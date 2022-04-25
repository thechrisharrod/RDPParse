
$Events = Get-EventLog -LogName Security -EntryType FailureAudit 

$Events.count

$arrEvents = @()

foreach($Event in $Events){
    if($Event.EventID -eq 4625){
        $Message = $Event.Message
        $Account = $Message.split("`n")[12].split("`t")[3].trim()
        $Machine = $Message.split("`n")[25].split("`t")[2].trim()
        if(($Machine).Trim() -like "*-*"){
            $Machine = $Null
        }

        $IP = $Message.split("`n")[26].split(": ")[3].replace("`t","").trim()

        $Item = [PSCustomObject]@{
            Account = $Account
            IP = $IP
            Machine    = $Machine
        }

        $arrEvents += $Item
    }
}

#$arrEvents | Group-Object Account | Sort-Object Count

#$arrEvents | Group-Object IP | Sort-Object Count

#$arrEvents | Group-Object Machine | Sort-Object Count

#$arrEvents | Where-Object IP -eq "" 

#$arrEvents | Where-Object Account -eq "realaccountname" 

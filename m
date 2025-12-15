Return-Path: <netdev+bounces-244704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C15CCBD5D5
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 11:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A7C01300D022
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 10:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917A0329384;
	Mon, 15 Dec 2025 10:27:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F7A31AF25
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 10:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765794430; cv=none; b=LcGMeKzuC41tSp0e9nL+neTEDl1IZDJU7EwnzYJpMRWM1IaqNn7EMe9t72uS6n2uNrwxoEDa8q0xc5URr/7wRyRBuqCoHO45IRG8NosXn6L4J9q19y45SKAl/A0k6ZmbS3+/XscPxS+hSJy/Y+2oVtCCG9ipHszvDd9MWgPcqUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765794430; c=relaxed/simple;
	bh=XkzgWCV1z6KAGTIBt7YKzssf0oXhR5s1z9G5ZoRUG0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=juqLvPxZCPn1s/jctupcEqm0/4hE65H4MjDtLZACBTezRnXnPHP/EyMNs5rtOQ8Ti+AdBD8IYjZaMMlX0bjTf89jHX6PvlJiFqsatUfSDTQGH36ESUdy74BQ4AGmIFJpV2qM7tlWAP0Qkm0vBzGvR3qEIPmlHzWHpou6VEbXEH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 30D4449459;
	Mon, 15 Dec 2025 11:19:51 +0100 (CET)
Message-ID: <cd44c0d2-17ed-460d-9f89-759987d423dc@proxmox.com>
Date: Mon, 15 Dec 2025 11:19:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 7/8] tcp: stronger sk_rcvbuf checks
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20250711114006.480026-1-edumazet@google.com>
 <20250711114006.480026-8-edumazet@google.com>
Content-Language: en-US, de-DE
From: Christian Ebner <c.ebner@proxmox.com>
In-Reply-To: <20250711114006.480026-8-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1765793983261

Hi,

some of our users (Proxmox Backup Server) are seeing issues with slow
and stale backups on kernel versions 6.17 and 6.18, especially in
combination with MTU 9000. The issue persists also with the mainline
kernel v6.18. Backups are running over a single TCP connection using
HTTP/2 based protocol, the stall affects only the single TCP connection
while the rest of the network is unaffected. Also, other network
traffic does not reproduce the issue so far.

When reverting to older kernel versions the issue disappears [0].
Unfortunately the stale connections are not easily reproduced.

In an effort to identify the issue, bisection lead us and independently
an affected user [1] to this commit:

"1d2fbaad: tcp: stronger sk_rcvbuf checks"

Taking note that there were several patches with bugfixes and
additional adaptions, we are reaching out in order to ask for guidance
on how to best debug this issue further, given that it persists also
with the latest stable kernel.

What outputs could we provide to narrow down the possible root cause
of the stale TCP connections?

Output from `ss` and `nstat` gathered during 2 stale connections as
provided by an affected user [2]:
```
State                                           Recv-Q 
                          Send-Q 
                                                      Local Address:Port 
  
                        Peer Address:Port 
  
  
  

ESTAB                                           0 
                          0 
                                               [::ffff:10.x.y.a]:8007 
  
             [::ffff:10.x.y.c]:48288
          cubic wscale:7,10 rto:207 rtt:6.582/11.374 ato:40 mss:8948 
pmtu:9000 rcvmss:3072 advmss:8948 cwnd:10 ssthresh:16 bytes_sent:1084107 
bytes_retrans:123 bytes_acked:1083984 bytes_received:3703857790 
segs_out:317478 segs_in:315112 data_segs_out:2343 data_segs_in:314619 
send 109Mbps lastsnd:423225 lastrcv:76 lastack:76 pacing_rate 131Mbps 
delivery_rate 3.33Gbps delivered:2344 app_limited busy:3592ms 
retrans:0/1 dsack_dups:1 rcv_rtt:207.33 rcv_space:146392 
rcv_ssthresh:592739 minrtt:0.044 rcv_ooopack:890 snd_wnd:1065728 
rcv_wnd:3072
ESTAB                                           0 
                          0 
                                               [::ffff:10.x.y.a]:8007 
  
             [::ffff:10.x.y.b]:46712
          cubic wscale:10,10 rto:201 rtt:0.333/0.496 ato:40 mss:8948 
pmtu:9000 rcvmss:4096 advmss:8948 cwnd:10 bytes_sent:861063 
bytes_acked:861063 bytes_received:181206715 segs_out:17834 segs_in:17552 
data_segs_out:382 data_segs_in:17280 send 2.15Gbps lastsnd:53439 
lastrcv:191 lastack:191 pacing_rate 4.29Gbps delivery_rate 2.95Gbps 
delivered:383 app_limited busy:405ms rcv_rtt:207.33 rcv_space:95745 
rcv_ssthresh:246825 minrtt:0.04 rcv_ooopack:75 snd_wnd:193536 rcv_wnd:4096
```

```
#kernel
IpInReceives                    18674              0.0
IpInDelivers                    18672              0.0
IpOutRequests                   21147              0.0
IpOutTransmits                  21147              0.0
TcpActiveOpens                  806                0.0
TcpPassiveOpens                 1052               0.0
TcpAttemptFails                 280                0.0
TcpInSegs                       18607              0.0
TcpOutSegs                      22190              0.0
TcpRetransSegs                  40                 0.0
TcpOutRsts                      280                0.0
UdpInDatagrams                  10                 0.0
UdpOutDatagrams                 31                 0.0
UdpIgnoredMulti                 17                 0.0
Ip6InReceives                   37                 0.0
Ip6InDiscards                   37                 0.0
Ip6InOctets                     2664               0.0
TcpExtTW                        526                0.0
TcpExtTWRecycled                2                  0.0
TcpExtDelayedACKs               19                 0.0
TcpExtDelayedACKLost            1                  0.0
TcpExtTCPHPHits                 1065               0.0
TcpExtTCPPureAcks               2901               0.0
TcpExtTCPHPAcks                 2010               0.0
TcpExtTCPSackRecovery           6                  0.0
TcpExtTCPSACKReorder            2                  0.0
TcpExtTCPLostRetransmit         2                  0.0
TcpExtTCPFastRetrans            40                 0.0
TcpExtTCPBacklogCoalesce        4                  0.0
TcpExtTCPDSACKOldSent           1                  0.0
TcpExtTCPSackShifted            5                  0.0
TcpExtTCPSackMerged             16                 0.0
TcpExtTCPSackShiftFallback      13                 0.0
TcpExtTCPRcvCoalesce            65                 0.0
TcpExtTCPAutoCorking            77                 0.0
TcpExtTCPFromZeroWindowAdv      2946               0.0
TcpExtTCPToZeroWindowAdv        248                0.0
TcpExtTCPOrigDataSent           8414               0.0
TcpExtTCPDelivered              7886               0.0
IpExtInMcastPkts                38                 0.0
IpExtInBcastPkts                17                 0.0
IpExtInOctets                   22147530           0.0
IpExtOutOctets                  16300295           0.0
IpExtInMcastOctets              1216               0.0
IpExtInBcastOctets              2755               0.0
IpExtInNoECTPkts                18663              0.0
IpExtInECT0Pkts                 11                 0.0
```

[0] https://forum.proxmox.com/threads/176444/
[1] https://forum.proxmox.com/threads/176444/post-824615
[2] https://forum.proxmox.com/threads/176444/post-824407

Best regards,
Christian Ebner



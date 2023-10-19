Return-Path: <netdev+bounces-42797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1397D02B3
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 21:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D9C12822B0
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 19:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F493C695;
	Thu, 19 Oct 2023 19:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhbZsJHR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72B739853
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 19:45:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC037C433C9;
	Thu, 19 Oct 2023 19:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697744743;
	bh=s836uDkgduLI1XFDZViMmnBYgxkNlTSThLRqbszfg0o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NhbZsJHR+GlOLLoiXgBOT6PWm1pimRYeHfwD/z/eAGysYnQ7gCP6PW9qwHqhbGqtm
	 /v8y+/R/0pqhfWfTc2iKeVZowvl9pc1wMuyZF0U6y4K1kVC21BptJhY5RsWZ6PU5nD
	 jEk3VhDsTKWj6YEP1xv4NnnvdwGQVmwbAUwhVFpGPDPPHNa3kPrQTK+QXVE2zHjomd
	 wpR8eevdQrzStOq+gIObOX00ICHlKXuto+QHeAS0vvdGBhJaXUHOjtvrUagFvYS/XE
	 6fo2PfnrAuNeNpLb4BRPWmJhKfgHQqPG0ywmvC9TMgW9fbfAt6pnkBbod4miIMVAvW
	 twlBxHkW1qP9g==
Message-ID: <44651dfe-3176-e295-adbd-351c149aad88@kernel.org>
Date: Thu, 19 Oct 2023 13:45:42 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next V3] net: fix IPSTATS_MIB_OUTPKGS increment in
 OutForwDatagrams.
Content-Language: en-US
To: Heng Guo <heng.guo@windriver.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, filip.pudak@windriver.com, kun.song@windriver.com
References: <20231017062838.4897-1-heng.guo@windriver.com>
 <20231019012053.19049-1-heng.guo@windriver.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231019012053.19049-1-heng.guo@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/18/23 7:20 PM, Heng Guo wrote:
> Reproduce environment:
> network with 3 VM linuxs is connected as below:
> VM1<---->VM2(latest kernel 6.5.0-rc7)<---->VM3
> VM1: eth0 ip: 192.168.122.207 MTU 1500
> VM2: eth0 ip: 192.168.122.208, eth1 ip: 192.168.123.224 MTU 1500
> VM3: eth0 ip: 192.168.123.240 MTU 1500
> 
> Reproduce:
> VM1 send 1400 bytes UDP data to VM3 using tools scapy with flags=0.
> scapy command:
> send(IP(dst="192.168.123.240",flags=0)/UDP()/str('0'*1400),count=1,
> inter=1.000000)
> 
> Result:
> Before IP data is sent.
> ----------------------------------------------------------------------
> root@qemux86-64:~# cat /proc/net/snmp
> Ip: Forwarding DefaultTTL InReceives InHdrErrors InAddrErrors
>   ForwDatagrams InUnknownProtos InDiscards InDelivers OutRequests
>   OutDiscards OutNoRoutes ReasmTimeout ReasmReqds ReasmOKs ReasmFails
>   FragOKs FragFails FragCreates
> Ip: 1 64 11 0 3 4 0 0 4 7 0 0 0 0 0 0 0 0 0
> ......
> ----------------------------------------------------------------------
> After IP data is sent.
> ----------------------------------------------------------------------
> root@qemux86-64:~# cat /proc/net/snmp
> Ip: Forwarding DefaultTTL InReceives InHdrErrors InAddrErrors
>   ForwDatagrams InUnknownProtos InDiscards InDelivers OutRequests
>   OutDiscards OutNoRoutes ReasmTimeout ReasmReqds ReasmOKs ReasmFails
>   FragOKs FragFails FragCreates
> Ip: 1 64 12 0 3 5 0 0 4 8 0 0 0 0 0 0 0 0 0
> ......
> ----------------------------------------------------------------------
> "ForwDatagrams" increase from 4 to 5 and "OutRequests" also increase
> from 7 to 8.
> 
> Issue description and patch:
> IPSTATS_MIB_OUTPKTS("OutRequests") is counted with IPSTATS_MIB_OUTOCTETS
> ("OutOctets") in ip_finish_output2().
> According to RFC 4293, it is "OutOctets" counted with "OutTransmits" but
> not "OutRequests". "OutRequests" does not include any datagrams counted
> in "ForwDatagrams".
> ipSystemStatsOutOctets OBJECT-TYPE
>     DESCRIPTION
>            "The total number of octets in IP datagrams delivered to the
>             lower layers for transmission.  Octets from datagrams
>             counted in ipIfStatsOutTransmits MUST be counted here.
> ipSystemStatsOutRequests OBJECT-TYPE
>     DESCRIPTION
>            "The total number of IP datagrams that local IP user-
>             protocols (including ICMP) supplied to IP in requests for
>             transmission.  Note that this counter does not include any
>             datagrams counted in ipSystemStatsOutForwDatagrams.
> So do patch to define IPSTATS_MIB_OUTPKTS to "OutTransmits" and add
> IPSTATS_MIB_OUTREQUESTS for "OutRequests".
> Add IPSTATS_MIB_OUTREQUESTS counter in __ip_local_out() for ipv4 and add
> IPSTATS_MIB_OUT counter in ip6_finish_output2() for ipv6.
> 
> Test result with patch:
> Before IP data is sent.
> ----------------------------------------------------------------------
> root@qemux86-64:~# cat /proc/net/snmp
> Ip: Forwarding DefaultTTL InReceives InHdrErrors InAddrErrors
>   ForwDatagrams InUnknownProtos InDiscards InDelivers OutRequests
>   OutDiscards OutNoRoutes ReasmTimeout ReasmReqds ReasmOKs ReasmFails
>   FragOKs FragFails FragCreates OutTransmits
> Ip: 1 64 9 0 5 1 0 0 3 3 0 0 0 0 0 0 0 0 0 4
> ......
> root@qemux86-64:~# cat /proc/net/netstat
> ......
> IpExt: InNoRoutes InTruncatedPkts InMcastPkts OutMcastPkts InBcastPkts
>   OutBcastPkts InOctets OutOctets InMcastOctets OutMcastOctets
>   InBcastOctets OutBcastOctets InCsumErrors InNoECTPkts InECT1Pkts
>   InECT0Pkts InCEPkts ReasmOverlaps
> IpExt: 0 0 0 0 0 0 2976 1896 0 0 0 0 0 9 0 0 0 0
> ----------------------------------------------------------------------
> After IP data is sent.
> ----------------------------------------------------------------------
> root@qemux86-64:~# cat /proc/net/snmp
> Ip: Forwarding DefaultTTL InReceives InHdrErrors InAddrErrors
>   ForwDatagrams InUnknownProtos InDiscards InDelivers OutRequests
>   OutDiscards OutNoRoutes ReasmTimeout ReasmReqds ReasmOKs ReasmFails
>   FragOKs FragFails FragCreates OutTransmits
> Ip: 1 64 10 0 5 2 0 0 3 3 0 0 0 0 0 0 0 0 0 5
> ......
> root@qemux86-64:~# cat /proc/net/netstat
> ......
> IpExt: InNoRoutes InTruncatedPkts InMcastPkts OutMcastPkts InBcastPkts
>   OutBcastPkts InOctets OutOctets InMcastOctets OutMcastOctets
>   InBcastOctets OutBcastOctets InCsumErrors InNoECTPkts InECT1Pkts
>   InECT0Pkts InCEPkts ReasmOverlaps
> IpExt: 0 0 0 0 0 0 4404 3324 0 0 0 0 0 10 0 0 0 0
> ----------------------------------------------------------------------
> "ForwDatagrams" increase from 1 to 2 and "OutRequests" is keeping 3.
> "OutTransmits" increase from 4 to 5 and "OutOctets" increase 1428.
> 
> Signed-off-by: Heng Guo <heng.guo@windriver.com>
> Reviewed-by: Kun Song <Kun.Song@windriver.com>
> Reviewed-by: Filip Pudak <filip.pudak@windriver.com>
> ---
> V2: fix the missing space after a comma.
> V3: keep original counter in mpls_stats_inc_outucastpkts(), because
> both forward and local outputs are in it.
> 
>  include/uapi/linux/snmp.h | 3 ++-
>  net/ipv4/ip_output.c      | 2 ++
>  net/ipv4/proc.c           | 3 ++-
>  net/ipv6/ip6_output.c     | 6 ++++--
>  net/ipv6/mcast.c          | 5 ++---
>  net/ipv6/ndisc.c          | 2 +-
>  net/ipv6/proc.c           | 3 ++-
>  net/ipv6/raw.c            | 2 +-
>  8 files changed, 16 insertions(+), 10 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



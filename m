Return-Path: <netdev+bounces-218284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61940B3BC5C
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 15:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D02C21CC2929
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 13:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CD72EB869;
	Fri, 29 Aug 2025 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bBk4taRy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59C82F39AD
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 13:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473521; cv=none; b=oVgjoyXT4+pau//MmxWCLLByPIItAvq5QJT87ndDwsN+ZXv2DvF12FIDCduBjUVeDhVVNyHU33RcI5al13OEz7BC7h0TZPzjyGQBue5FLsc6SqUsbds2lPDEqUOhp07lYgVw+m0dHvgV23zjtF7OhVMVv4x7ycGr0t8/dx0barg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473521; c=relaxed/simple;
	bh=GR5gzhRmkua7tEyXC3I0hLqe6gKeacqwb2bz0Im+URA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=refYb7levnY7sZjigl+DlCmiQRiHzSvAaP11YLvo+YViEuzq59K/ExrVak2oE8J+UQTvDA0Y9d4P69yDBwNA7bEL8CcJzMmOyZgTBLBOdkPfpnVzZUUIIcUpktCx+Kj3NhthZ5zkoiZK7wY05zr1me/ui72u+hviXhU75d6fm1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bBk4taRy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756473516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=55FItBz3KGukhNz10UyzLbk/60O0SxwHukE1Wy/C6+E=;
	b=bBk4taRyOh4wrX12YduYd78zGKk8023bbh1ic/0v+lUfqnjo6NQzF6gvlPn/fLLfhjXJSE
	Bn7tmH8Wr9RpiEFJPpwufQk8vp5MGF5EFodHeFiF65DYv2cc4zK6zpRtOfDH4wuvzg2HUA
	/7k0M2gXwk65q0mC3RhvOUKlfaskUMs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-6xENpmhfOq2LtorPvosNvA-1; Fri,
 29 Aug 2025 09:18:33 -0400
X-MC-Unique: 6xENpmhfOq2LtorPvosNvA-1
X-Mimecast-MFC-AGG-ID: 6xENpmhfOq2LtorPvosNvA_1756473512
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1548719560B4;
	Fri, 29 Aug 2025 13:18:32 +0000 (UTC)
Received: from jramaseu-thinkpadt14gen5.tpbc.csb (unknown [10.43.3.226])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 212951956095;
	Fri, 29 Aug 2025 13:18:29 +0000 (UTC)
From: Jakub Ramaseuski <jramaseu@redhat.com>
To: willemdebruijn.kernel@gmail.com
Cc: horms@kernel.org,
	jramaseu@redhat.com,
	netdev@vger.kernel.org,
	tizhao@redhat.com
Subject: Re: [PATCH net] net: mask NETIF_F_IPV6_CSUM flag on irregular packet header size
Date: Fri, 29 Aug 2025 15:18:13 +0200
Message-ID: <20250829131813.3425001-1-jramaseu@redhat.com>
In-Reply-To: <68935cb3b108_1576e429466@willemb.c.googlers.com.notmuch>
References: <68935cb3b108_1576e429466@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

For whom it may concern, 
same problem currently appears when GREoIPv6 encapsulates IPv4 traffic, 
i.e. iperf3 -c IPV4_GRE_TUNNEL_ADDRESS, even with current 6.17.0-rc3.

Willem de Bruijn wrote:
>       if (features & NETIF_F_IPV6_CSUM &&
>           (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
>            (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
>	     vlan_get_protocol(skb) == htons(ETH_P_IPV6))) &&
>            skb_transport_header_was_set(skb) &&
>            skb_network_header_len(skb) != sizeof(struct ipv6hdr) &&
>            !ipv6_has_hopopt_jumbo(skb))
>                features &= ~(NETIF_F_IPV6_CSUM | NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4);
This part has been accepted as 
864e3396976e ("net: gso: Forbid IPv6 TSO with extensions on devices with only IPV6_CSUM")

I am currently looking for suggestions on how to loosen the suggested
solution, I added check for SKB_GSO_TCPV4, which worked fine (though with
SW checksum calculation), but I believe there could be more elegant solution.

I should also ask on next steps which should support IPv6 checksum offload
with devices capable of it, but not capable of NETIF_F_HW_CSUM,
and throughput seen prior to 04c20a9356f283da, whether it is possible.
Thank you in advance!

Here is the kernel log, note the gso_type in shinfo has flags set 
for SKB_GSO_TCPV4 and SKB_GSO_GRE, but also the skb content: 

gre: GRE over IPv4 demultiplexer driver 
ip6_gre: GRE over IPv6 tunneling driver 
ip6_tunnel: gre1 xmit: Local address not yet configured! 
skb len=7098 headroom=202 headlen=118 tailroom=0 
mac=(202,14) mac_len=0 net=(216,48) trans=264 
shinfo(txflags=0 nr_frags=1 gso(size=1396 type=65 segs=5)) 
csum(0x100120 start=288 offset=16 ip_summed=3 complete_sw=0 valid=0 level=0) 
hash(0x4dab788f sw=0 l4=1) proto=0x86dd pkttype=0 iif=0 
priority=0x0 mark=0x0 alloc_cpu=20 vlan_all=0x0 
encapsulation=1 inner(proto=0x0008, mac=268, net=268, trans=288) 
dev name=enp65s0f0np0 feat=0x001081e21fd54bb3 
sk family=2 type=1 proto=6 
skb linear:   00000000: b4 96 91 db db e8 b4 96 91 db dc b0 86 dd 60 0d 
skb linear:   00000010: 8f 78 1b 84 3c 40 20 11 00 00 00 00 00 00 00 00 
skb linear:   00000020: 00 00 00 00 00 11 20 11 00 00 00 00 00 00 00 00 
skb linear:   00000030: 00 00 00 00 00 12 2f 00 04 01 04 01 01 00 00 00 
skb linear:   00000040: 08 00 45 00 1b 78 34 84 40 00 40 06 15 94 c0 a8 
skb linear:   00000050: 2a 0b c0 a8 2a 0c 88 e2 14 51 0d 2e f4 85 98 ca 
skb linear:   00000060: 81 5e 80 18 00 40 f0 d2 00 00 01 01 08 0a f8 ea 
skb linear:   00000070: b5 98 43 9a 51 5d 
... 
ice: caps=(0x001081e21fd54bb3, 0x0000000e401d4869) 
WARNING: CPU: 20 PID: 5341 at net/core/dev.c:3532 skb_warn_bad_offload+0x81/0x140 
...
Call Trace: 
 <TASK> 
 skb_checksum_help+0x12a/0x1f0 
 ? mod_memcg_lruvec_state+0xc5/0x1f0 
 validate_xmit_skb+0x1a3/0x2d0 
 validate_xmit_skb_list+0x4f/0x80 
 sch_direct_xmit+0x1a2/0x380 
 __dev_xmit_skb+0x242/0x670 
 __dev_queue_xmit+0x3fc/0x7f0 
 ? srso_alias_return_thunk+0x5/0xfbef5 
 ? ip6_rt_copy_init+0xed/0x2a0 
 ? srso_alias_return_thunk+0x5/0xfbef5 
 ? selinux_ip_postroute+0x1c5/0x420 
 ? srso_alias_return_thunk+0x5/0xfbef5 
 ip6_finish_output2+0x25e/0x5d0 
 ? srso_alias_return_thunk+0x5/0xfbef5 
 ? nf_hook_slow+0x47/0xf0 
 ip6_finish_output+0x1fc/0x410 
 ip6_tnl_xmit+0x60a/0xc10 [ip6_tunnel] 
 ? srso_alias_return_thunk+0x5/0xfbef5 
 ip6gre_xmit_ipv4+0xa8/0x120 [ip6_gre] 
 ip6gre_tunnel_xmit+0x2d5/0x390 [ip6_gre] 
 ? srso_alias_return_thunk+0x5/0xfbef5 
 ? chacha_block_generic+0x72/0xd0 
 ? srso_alias_return_thunk+0x5/0xfbef5 
 dev_hard_start_xmit+0x63/0x1c0 
 __dev_queue_xmit+0x6d0/0x7f0 
 ? srso_alias_return_thunk+0x5/0xfbef5 
 ? selinux_ip_postroute+0x1c5/0x420 
 ip_finish_output2+0x1a9/0x520 
 ? __ip_finish_output+0xba/0x180 
 ip_output+0x63/0x110 
 ? __pfx_ip_finish_output+0x10/0x10 
 __ip_queue_xmit+0x369/0x4f0 
 __tcp_transmit_skb+0x8cc/0xa80 
 tcp_write_xmit+0x32a/0xea0 
 ? srso_alias_return_thunk+0x5/0xfbef5 
 ? skb_do_copy_data_nocache+0xc9/0x150 
 tcp_sendmsg_locked+0x434/0x10e0 
 ? srso_alias_return_thunk+0x5/0xfbef5 
 tcp_sendmsg+0x2f/0x50 
 ...

And aformentioned iperf3: 
ip a output, iperf3 server side (truncated), with enp65s0f0np0 using ice driver:
8: enp65s0f0np0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether b4:96:91:db:db:e8 brd ff:ff:ff:ff:ff:ff
    altname enxb49691dbdbe8
    inet 192.168.44.12/24 scope global enp65s0f0np0
       valid_lft forever preferred_lft forever
    inet6 2011::12/64 scope global 
       valid_lft forever preferred_lft forever
19: gre1@enp65s0f0np0: <POINTOPOINT,NOARP,UP,LOWER_UP> mtu 1448 qdisc noqueue state UNKNOWN group default qlen 1000
    link/gre6 2011::12 peer 2011::11 permaddr 429b:2cf8:de35::
    inet 192.168.42.12/24 scope global gre1
       valid_lft forever preferred_lft forever
    inet6 2023::12/64 scope global 
       valid_lft forever preferred_lft forever
    inet6 fe80::12/64 scope link 
       valid_lft forever preferred_lft forever

iperf3 output (server side)
-----------------------------------------------------------
Server listening on 5201 (test #3)
-----------------------------------------------------------
Accepted connection from 2023::11, port 44632
[  5] local 2023::12 port 5201 connected to 2023::11 port 44642
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec   822 MBytes  6.88 Gbits/sec                  
[  5]   1.00-2.00   sec   864 MBytes  7.25 Gbits/sec                  
[  5]   2.00-3.00   sec   850 MBytes  7.13 Gbits/sec                  
[  5]   3.00-4.00   sec   860 MBytes  7.22 Gbits/sec                  
[  5]   4.00-5.00   sec   868 MBytes  7.28 Gbits/sec                  
[  5]   5.00-6.00   sec   866 MBytes  7.26 Gbits/sec                  
[  5]   6.00-7.00   sec   868 MBytes  7.28 Gbits/sec                  
[  5]   7.00-8.00   sec   854 MBytes  7.17 Gbits/sec                  
[  5]   8.00-9.00   sec   858 MBytes  7.20 Gbits/sec                  
[  5]   9.00-10.00  sec   871 MBytes  7.30 Gbits/sec                  
[  5]  10.00-10.00  sec   384 KBytes  9.17 Gbits/sec                  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-10.00  sec  8.38 GBytes  7.20 Gbits/sec                  receiver
-----------------------------------------------------------
Server listening on 5201 (test #4)
-----------------------------------------------------------
Accepted connection from 192.168.42.11, port 44614
[  5] local 192.168.42.12 port 5201 connected to 192.168.42.11 port 44616
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  0.00 Bytes  0.00 bits/sec                  
[  5]   1.00-2.00   sec  0.00 Bytes  0.00 bits/sec                  
[  5]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec                  
[  5]   3.00-4.00   sec  0.00 Bytes  0.00 bits/sec                  
[  5]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec                  
[  5]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec                  
[  5]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec                  
[  5]   7.00-8.00   sec  0.00 Bytes  0.00 bits/sec                  
[  5]   8.00-9.00   sec  0.00 Bytes  0.00 bits/sec                  
[  5]   9.00-10.00  sec  91.3 KBytes   748 Kbits/sec                  
[  5]  10.00-10.53  sec  0.00 Bytes  0.00 bits/sec                  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-10.53  sec  91.3 KBytes  71.1 Kbits/sec                  receiver



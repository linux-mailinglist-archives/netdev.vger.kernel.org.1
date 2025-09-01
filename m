Return-Path: <netdev+bounces-218825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DA0B3EABF
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 17:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171E63BF403
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 15:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF37202997;
	Mon,  1 Sep 2025 15:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khUcJXoK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1A432F77C
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 15:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756739752; cv=none; b=W9dmCmLlO+RCHUIhL9nbR4sW4n0Wuf2DYaYQt9cowKAyvpqPTxKLwUHmyGkUbARku61J/wMQJOb4vi+lqPYvILdrPd/ZwC436tlPtw5FUvVXaODh9uLPSCaisN4trg/KGLWyG2va4lm5S8Po1heN3Tp7lAiQq9vhsAAS38sTGHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756739752; c=relaxed/simple;
	bh=jFgligNAzW+lpXyQDj8S1XhQUJV9CXNRAjrJztXVndM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=aSErIArWSr/OjvN/rRQ9luZdzFc3D5xmOFx4lEPG6R000FJwlxh+ROO+P1WV5HLBUysn41+6rYz2Y1JojHSyKsOPAuzYZwms/5TtCl8DfRk3W4Qt0lgNJuh7KAuefJKp0RUJYzRKufUhfz+b3KTwuWtYnykQ4sXbcPwP28ZkdW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khUcJXoK; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-544b17b85d0so410998e0c.0
        for <netdev@vger.kernel.org>; Mon, 01 Sep 2025 08:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756739749; x=1757344549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQEaR8wFyNuBHKrqYTInSUg64ahArfnxFirM6Dg6IVA=;
        b=khUcJXoKV55E3hSKu+qg8aGUiiCvlSnFk+31W0ptbhsClbQqfWSofXtzYzXOE0APXr
         IiRzrKDc+OvbZ+NJNcmE/vl0EUGbdnLkeeoUxJLK5aDeKQnX/2moGDxchrFA8TUamWWJ
         7IMb2MDc50vHqFqY+ivnt7FXRtnFcUqOKOP7sQviSJidUg6oAfd7Y4X2a1YZFZzlqxtK
         SFf4he7rRCSfQILDC7nrsZonBA8bAsZ7K0yjnGXjWLgY8yAC241Hyz/1NNayWA+bb1nV
         SpUEw6+sovJO/fAWBVEzpyOwy67iLWBZaFyspPUZ+INBz5mkAeb6rTsjk80wBHHDQXjh
         ONKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756739749; x=1757344549;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vQEaR8wFyNuBHKrqYTInSUg64ahArfnxFirM6Dg6IVA=;
        b=w39RmxzCyLnlzgPbBTUQXaBOZk1K/k4yfWXD5xH405ky9JDhpm95WuTDXnRpgDOhBY
         4Jr+WiTFIO9tABZK/tWWS+VSiN/0szgx9TPranSejDL4LJtUo5vNKvzrFc2JJ6sq6dFi
         myk4w25ShMeqMrbJc9Yj7fyUOKi36ZbI5K/9t3U3+nM6KJYor2YjadJGwwkaMCEr5w+5
         xFS+4Cpd06DR4H+dHkUuRt5SiZvsaBHayQlF4/MBImgnbfRK6Zncv0ZTPy5Y4xjwIa2d
         2WvDqRsJjdQ5b/NLfp3xUZL4P9J7BBfF+yLOwrTrIb/fIESB2J/QsPNZdxV4PvNYTmfR
         xJWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAN3ISnxvf17v07NMZVtz0GRCgF7yI0RqF0pqYwrJu8Cq/jk0HGY2bZno3aL+ii7RZA/ppK8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Njr3mcc50iq5S7l+1ixsu7OgNfFkoCB3zREK6dCO5LCKwbIl
	CCwHHWP9q5VKOzRZ4KcCTt07V016GmE7XvedpGlUppnWkxEO8lyBNzcE
X-Gm-Gg: ASbGncv2LGLB8zXkBSZymF+TmcBltLW5sTT3A246fswSJCh9pl6p+6IfIqcUhVDL/OY
	OKdJqAJH/Ne6bf/oePE8tTTWeMqvbw3M2K7Ro2kp6XTLX7nXnFFgVtQagcbMl3iZd9Vmegww2CZ
	ymQvj9CMFaGhR4UMF8uG1xPU8iVwM6ntuK7Jmk7LWNXeyTV5TuQOP9+vfZqyoSW1c8u0+A2N/bF
	j7CY5/AT/z/paDnMpucpNtK+HFg/ulSYMJ93e1Rdw+123011RnZl0ApLaMEmc3UhICXlBssqcYS
	sYB15ZDaV5GkwD1Y7LnPG09TDrqYcuhz9AdbEjYvq5vTy12/NuNnchqeJ6xde12v07WlrDDcm88
	ToYZjkwVTKP2Wt2yQeiuJ7fDxuW0oAO9mVkRtnkzbgUc9mSka82rGIzcxJX7W/fknqoBT42fhnE
	W068F5ObiK7hhz
X-Google-Smtp-Source: AGHT+IEgGcmob5m3b6RuzfrW8DKgbYqnz9g7jQfvuo56LBTVdyAXYfBKVkcThVBS0V7XC06lRCJllw==
X-Received: by 2002:a05:6122:2a41:b0:544:87b0:d1d1 with SMTP id 71dfb90a1353d-544a01c8f48mr2105597e0c.6.1756739746737;
        Mon, 01 Sep 2025 08:15:46 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 71dfb90a1353d-544912c7cbcsm4538453e0c.2.2025.09.01.08.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 08:15:45 -0700 (PDT)
Date: Mon, 01 Sep 2025 11:15:45 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Ramaseuski <jramaseu@redhat.com>, 
 willemdebruijn.kernel@gmail.com
Cc: horms@kernel.org, 
 jramaseu@redhat.com, 
 netdev@vger.kernel.org, 
 tizhao@redhat.com
Message-ID: <willemdebruijn.kernel.1d9f686fa89f4@gmail.com>
In-Reply-To: <20250829131813.3425001-1-jramaseu@redhat.com>
References: <68935cb3b108_1576e429466@willemb.c.googlers.com.notmuch>
 <20250829131813.3425001-1-jramaseu@redhat.com>
Subject: Re: [PATCH net] net: mask NETIF_F_IPV6_CSUM flag on irregular packet
 header size
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Ramaseuski wrote:
> For whom it may concern, 
> same problem currently appears when GREoIPv6 encapsulates IPv4 traffic, 
> i.e. iperf3 -c IPV4_GRE_TUNNEL_ADDRESS, even with current 6.17.0-rc3.
> 
> Willem de Bruijn wrote:
> >       if (features & NETIF_F_IPV6_CSUM &&
> >           (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
> >            (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
> >	     vlan_get_protocol(skb) == htons(ETH_P_IPV6))) &&
> >            skb_transport_header_was_set(skb) &&
> >            skb_network_header_len(skb) != sizeof(struct ipv6hdr) &&
> >            !ipv6_has_hopopt_jumbo(skb))
> >                features &= ~(NETIF_F_IPV6_CSUM | NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4);
> This part has been accepted as 
> 864e3396976e ("net: gso: Forbid IPv6 TSO with extensions on devices with only IPV6_CSUM")
> 
> I am currently looking for suggestions on how to loosen the suggested
> solution, I added check for SKB_GSO_TCPV4, which worked fine (though with
> SW checksum calculation), but I believe there could be more elegant solution.

Per the skb_dump (thanks), gso_type is SKB_GSO_GRE | SKB_GSO_TCPV4.
The gso_type does not capture explicitly that the outer network type
is IPv6.

But nor should it care? NETIF_F_IPV6_CSUM affects the (inner)
transport layer checksum, which only depends on the inner network
layer header for input to the pseudo-header.

> I should also ask on next steps which should support IPv6 checksum offload
> with devices capable of it, but not capable of NETIF_F_HW_CSUM,
> and throughput seen prior to 04c20a9356f283da, whether it is possible.
> Thank you in advance!

Do you mean that we lack a way for devices to communicate that they
only support IPv4/IPv6 checksums, but do support this IPv6 checksums
with extension headers? Something like NETIF_F_IPV6_EXTHDR_CSUM?

Or perhaps these can just advertise NETIF_F_HW_CSUM and in their
ndo_features_check drop the capability for all packets not IPv4/IPv6.
 
> Here is the kernel log, note the gso_type in shinfo has flags set 
> for SKB_GSO_TCPV4 and SKB_GSO_GRE, but also the skb content: 
> 
> gre: GRE over IPv4 demultiplexer driver 
> ip6_gre: GRE over IPv6 tunneling driver 
> ip6_tunnel: gre1 xmit: Local address not yet configured! 
> skb len=7098 headroom=202 headlen=118 tailroom=0 
> mac=(202,14) mac_len=0 net=(216,48) trans=264 
> shinfo(txflags=0 nr_frags=1 gso(size=1396 type=65 segs=5)) 
> csum(0x100120 start=288 offset=16 ip_summed=3 complete_sw=0 valid=0 level=0) 
> hash(0x4dab788f sw=0 l4=1) proto=0x86dd pkttype=0 iif=0 
> priority=0x0 mark=0x0 alloc_cpu=20 vlan_all=0x0 
> encapsulation=1 inner(proto=0x0008, mac=268, net=268, trans=288) 
> dev name=enp65s0f0np0 feat=0x001081e21fd54bb3 
> sk family=2 type=1 proto=6 
> skb linear:   00000000: b4 96 91 db db e8 b4 96 91 db dc b0 86 dd 60 0d 
> skb linear:   00000010: 8f 78 1b 84 3c 40 20 11 00 00 00 00 00 00 00 00 
> skb linear:   00000020: 00 00 00 00 00 11 20 11 00 00 00 00 00 00 00 00 
> skb linear:   00000030: 00 00 00 00 00 12 2f 00 04 01 04 01 01 00 00 00 
> skb linear:   00000040: 08 00 45 00 1b 78 34 84 40 00 40 06 15 94 c0 a8 
> skb linear:   00000050: 2a 0b c0 a8 2a 0c 88 e2 14 51 0d 2e f4 85 98 ca 
> skb linear:   00000060: 81 5e 80 18 00 40 f0 d2 00 00 01 01 08 0a f8 ea 
> skb linear:   00000070: b5 98 43 9a 51 5d 
> ... 
> ice: caps=(0x001081e21fd54bb3, 0x0000000e401d4869) 
> WARNING: CPU: 20 PID: 5341 at net/core/dev.c:3532 skb_warn_bad_offload+0x81/0x140 
> ...
> Call Trace: 
>  <TASK> 
>  skb_checksum_help+0x12a/0x1f0 
>  ? mod_memcg_lruvec_state+0xc5/0x1f0 
>  validate_xmit_skb+0x1a3/0x2d0 
>  validate_xmit_skb_list+0x4f/0x80 
>  sch_direct_xmit+0x1a2/0x380 
>  __dev_xmit_skb+0x242/0x670 
>  __dev_queue_xmit+0x3fc/0x7f0 
>  ? srso_alias_return_thunk+0x5/0xfbef5 
>  ? ip6_rt_copy_init+0xed/0x2a0 
>  ? srso_alias_return_thunk+0x5/0xfbef5 
>  ? selinux_ip_postroute+0x1c5/0x420 
>  ? srso_alias_return_thunk+0x5/0xfbef5 
>  ip6_finish_output2+0x25e/0x5d0 
>  ? srso_alias_return_thunk+0x5/0xfbef5 
>  ? nf_hook_slow+0x47/0xf0 
>  ip6_finish_output+0x1fc/0x410 
>  ip6_tnl_xmit+0x60a/0xc10 [ip6_tunnel] 
>  ? srso_alias_return_thunk+0x5/0xfbef5 
>  ip6gre_xmit_ipv4+0xa8/0x120 [ip6_gre] 
>  ip6gre_tunnel_xmit+0x2d5/0x390 [ip6_gre] 
>  ? srso_alias_return_thunk+0x5/0xfbef5 
>  ? chacha_block_generic+0x72/0xd0 
>  ? srso_alias_return_thunk+0x5/0xfbef5 
>  dev_hard_start_xmit+0x63/0x1c0 
>  __dev_queue_xmit+0x6d0/0x7f0 
>  ? srso_alias_return_thunk+0x5/0xfbef5 
>  ? selinux_ip_postroute+0x1c5/0x420 
>  ip_finish_output2+0x1a9/0x520 
>  ? __ip_finish_output+0xba/0x180 
>  ip_output+0x63/0x110 
>  ? __pfx_ip_finish_output+0x10/0x10 
>  __ip_queue_xmit+0x369/0x4f0 
>  __tcp_transmit_skb+0x8cc/0xa80 
>  tcp_write_xmit+0x32a/0xea0 
>  ? srso_alias_return_thunk+0x5/0xfbef5 
>  ? skb_do_copy_data_nocache+0xc9/0x150 
>  tcp_sendmsg_locked+0x434/0x10e0 
>  ? srso_alias_return_thunk+0x5/0xfbef5 
>  tcp_sendmsg+0x2f/0x50 
>  ...
> 
> And aformentioned iperf3: 
> ip a output, iperf3 server side (truncated), with enp65s0f0np0 using ice driver:
> 8: enp65s0f0np0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
>     link/ether b4:96:91:db:db:e8 brd ff:ff:ff:ff:ff:ff
>     altname enxb49691dbdbe8
>     inet 192.168.44.12/24 scope global enp65s0f0np0
>        valid_lft forever preferred_lft forever
>     inet6 2011::12/64 scope global 
>        valid_lft forever preferred_lft forever
> 19: gre1@enp65s0f0np0: <POINTOPOINT,NOARP,UP,LOWER_UP> mtu 1448 qdisc noqueue state UNKNOWN group default qlen 1000
>     link/gre6 2011::12 peer 2011::11 permaddr 429b:2cf8:de35::
>     inet 192.168.42.12/24 scope global gre1
>        valid_lft forever preferred_lft forever
>     inet6 2023::12/64 scope global 
>        valid_lft forever preferred_lft forever
>     inet6 fe80::12/64 scope link 
>        valid_lft forever preferred_lft forever
> 
> iperf3 output (server side)
> -----------------------------------------------------------
> Server listening on 5201 (test #3)
> -----------------------------------------------------------
> Accepted connection from 2023::11, port 44632
> [  5] local 2023::12 port 5201 connected to 2023::11 port 44642
> [ ID] Interval           Transfer     Bitrate
> [  5]   0.00-1.00   sec   822 MBytes  6.88 Gbits/sec                  
> [  5]   1.00-2.00   sec   864 MBytes  7.25 Gbits/sec                  
> [  5]   2.00-3.00   sec   850 MBytes  7.13 Gbits/sec                  
> [  5]   3.00-4.00   sec   860 MBytes  7.22 Gbits/sec                  
> [  5]   4.00-5.00   sec   868 MBytes  7.28 Gbits/sec                  
> [  5]   5.00-6.00   sec   866 MBytes  7.26 Gbits/sec                  
> [  5]   6.00-7.00   sec   868 MBytes  7.28 Gbits/sec                  
> [  5]   7.00-8.00   sec   854 MBytes  7.17 Gbits/sec                  
> [  5]   8.00-9.00   sec   858 MBytes  7.20 Gbits/sec                  
> [  5]   9.00-10.00  sec   871 MBytes  7.30 Gbits/sec                  
> [  5]  10.00-10.00  sec   384 KBytes  9.17 Gbits/sec                  
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate
> [  5]   0.00-10.00  sec  8.38 GBytes  7.20 Gbits/sec                  receiver
> -----------------------------------------------------------
> Server listening on 5201 (test #4)
> -----------------------------------------------------------
> Accepted connection from 192.168.42.11, port 44614
> [  5] local 192.168.42.12 port 5201 connected to 192.168.42.11 port 44616
> [ ID] Interval           Transfer     Bitrate
> [  5]   0.00-1.00   sec  0.00 Bytes  0.00 bits/sec                  
> [  5]   1.00-2.00   sec  0.00 Bytes  0.00 bits/sec                  
> [  5]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec                  
> [  5]   3.00-4.00   sec  0.00 Bytes  0.00 bits/sec                  
> [  5]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec                  
> [  5]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec                  
> [  5]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec                  
> [  5]   7.00-8.00   sec  0.00 Bytes  0.00 bits/sec                  
> [  5]   8.00-9.00   sec  0.00 Bytes  0.00 bits/sec                  
> [  5]   9.00-10.00  sec  91.3 KBytes   748 Kbits/sec                  
> [  5]  10.00-10.53  sec  0.00 Bytes  0.00 bits/sec                  
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate
> [  5]   0.00-10.53  sec  91.3 KBytes  71.1 Kbits/sec                  receiver
> 




Return-Path: <netdev+bounces-272148-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8A96OpxixWkJ+AQAu9opvQ
	(envelope-from <netdev+bounces-272148-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:45:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B268F338A4F
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E9B730D1AB1
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2FF411620;
	Thu, 26 Mar 2026 16:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Li9nxoSJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AEE41160C
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 16:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542784; cv=none; b=D0Mi6SHEHAuwrdv2JgKMsbua+rEH+v95saZixE4HVjaYo8wn+1CV7x9cx3ULRkG/I84Cg19v3XL9WUHk/6U+/74/l/EafGjfLZZODKNL1lcMShKSH/OElRsasPrslI8AOT80b/BwLE47zrmE+NZc4xG3aMhkivYocfUsPlZ01WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542784; c=relaxed/simple;
	bh=mXc8HhXjqNJCvEd/LGg/yieYTes/g78CIZi1NYJ6p0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nerNfc1mFLK2Lo/05tRG5pCfNzFhmNiiOHtJJRYDQeS8IMvQEdcMAgcLWc4q4dbNkb9ww4wM3OsFAqHcv1yJuFZjzm+ExBcpTIneCtG6AKIxEQIpGDhTzORIWXtcSBiHuX/WSqM9PVdjQ2mN4FYreP0szgghYUGgtL16C4PskWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Li9nxoSJ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6634197cd98so157543a12.0
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 09:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1774542781; x=1775147581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3Uz6X41/9QvtVD+0d1JY1sxw6aOqQLEJwgRVp5WANGc=;
        b=Li9nxoSJNKiJccyGD9yHbplqiHrTxZtxaczwGIMLi7rr9O6y29ZGBOpdAAXuUW8cfJ
         OoZIEnmvMMetvXbU5SpuB7ijmk2XNCva4fNQ/+JdEbBJ92940MgAZb6p1UFD2Fq2xTdR
         tcr9xcTZ/OgJG4bCKvrhEIqTcdmJ4TlCK1paJ3YG/ePD48gW4wqDYNS9tWyHrgABODR4
         9YvZAq6neO1xXjzoCgqVTe0hdNleOSiE6d6y/Yja3hMFB365xHTdEEZzHkaLBdcKr1O2
         u77ZpY/Xx2bzmZalj/QzrfQFP4pLy/X3KOK7U8F/z69wVAAF0+He+yWkpQquh1BMaRT+
         O4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774542781; x=1775147581;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Uz6X41/9QvtVD+0d1JY1sxw6aOqQLEJwgRVp5WANGc=;
        b=sm4ayDehkCJZEJB2hEwcyZt0RkFCv1U2MkbXGT9TAGt2nP0+fKrOdZ+UAny0kLF9Ie
         L0MQlg73P6zgJRClAMOjyqRsH2Dn6RtjyypiskB9/DsU3bkdpkxtirotNrgxxPRxxebo
         WLsDZUbotd8BBsDOu1p1uzSNvaoXl5Qojay63g+H1nsJClpfUe8o2Hk1wmuKOtTAgB4G
         CspGodRD3niYDtnbz35xGuwCsYilN0DYs/FI+RTV2AFgB0Ac/H0vbBPXkyij1R1IapdJ
         rK9h6p+kY/ekJMzrcZMGrmpFuIwxPq1CH9jm8XWQDWzYAe7V4iOXsdp12FyioSKdZdog
         4Amw==
X-Forwarded-Encrypted: i=1; AJvYcCWLV8V/eGfLUrSeJS6eLhaLuZTRrgnZxQ2ZZVI3k7/IDT0AKDJ6tToaERoIsoVJ9bdNtyQ+LpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqRTksQ2yIt1mhSILwrO/tz/cahLjOzRSWbqfOs152MJdHYQ1G
	WVgTcw9UwJyXvR6ZhVR62n4shXNP0UZCGU0yQva3jR4A5F5DXrPMNoHOYi85TujZERg=
X-Gm-Gg: ATEYQzycQ2vx5JNxTzTewbd3NJMPrZxHO1G5WM/sI1u4UOD2BWYjZYmpG0WggF8MuWx
	GTJlMYAmI9q7VtbHX1Mo2EUhIk4L7Zk9tgY7wsZ0rf9DjNSOTWER+RkANMgIcO7bmke43O7m/ht
	kpm6qlT5nh5OctDX6kR7xLFKI6MxEcU269at50j8v5OG0O45r+42LqnJjOCY8l6ATdHaYE9wSVj
	Aw/BJxDXP/4fD3SOGeX8u5QAFvC+THLqpIfccX6AV9jqX0E0JA5xkv0J6757mNcG6R0EoF0bZcs
	KrSh3plJN5V1G+weD2/UIuxZe8yFYK9/gV82olUoH/3QaYe8uWFwJ7VUbanpo7tsoq3j91tZRU0
	I1c4xP8S7F2AuasrTsSS0KQNyFemD4+SA32Xe2gbj450S5Y5noNT6lWAugko6/EBsKqCOx4jVZB
	JfRHRuw6M2neMlpum3bL0R00j1dRnAcajYNQn1RHcCSNlhPqkG4VY+PEHVnNSlg8WHqklTCfy4E
	XirxIQMGKuknDc=
X-Received: by 2002:a05:6402:210f:b0:66a:55eb:1cef with SMTP id 4fb4d7f45d1cf-66a826fa22dmr2939717a12.8.1774542780713;
        Thu, 26 Mar 2026 09:33:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66ad6a5f283sm1242324a12.27.2026.03.26.09.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 09:33:00 -0700 (PDT)
Message-ID: <2bb55d10-38a9-4595-baef-678d59bf4059@6wind.com>
Date: Thu, 26 Mar 2026 17:32:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [RFC PATCH net-next 0/3] seg6: SRv6 L2 VPN with End.DT2U and srl2
 device
To: Andrea Mayer <andrea.mayer@uniroma2.it>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Stefano Salsano <stefano.salsano@uniroma2.it>,
 Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
 Ahmed Abdelsalam <ahabdels@cisco.com>,
 Justin Iurman <justin.iurman@6wind.com>, linux-kernel@vger.kernel.org
References: <20260322000557.12559-1-andrea.mayer@uniroma2.it>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260322000557.12559-1-andrea.mayer@uniroma2.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-272148-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[nicolas.dichtel@6wind.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B268F338A4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le 22/03/2026 à 01:05, Andrea Mayer a écrit :
> Hi all,
Hi,

first, thank you for posting this RFC.

> 
> this RFC series adds support for the SRv6 End.DT2U behavior and
> introduces the srl2 Ethernet pseudowire device, together with
> corresponding selftests.
> 
> Motivation
> ==========
> 
> The main goal is to enable L2 service delivery through an internal
> SRv6 L2 endpoint, in a way similar to how VXLAN provides L2 services
> through a VXLAN netdevice.
> 
> Today, Linux supports SRv6 L2 decapsulation only through an
> End.DX2-style model, where the exposed Ethernet frame is forwarded
> to a configured egress interface. The current implementation does
> not provide a native netdevice representing the SRv6 L2 service
> endpoint. This is a significant limitation compared to VXLAN, where
> the tunnel endpoint is represented by a netdevice that can be
> attached to a bridge and integrated naturally into the local L2
> data plane.
> 
> On the encapsulation side, the existing H.L2.Encaps mode is
> implemented as a route-based lwtunnel, which only intercepts packets
> entering the IP routing path. Non-IP protocols such as ARP are
> never routed and therefore cannot be encapsulated, making it
> unsuitable for full L2 service delivery.
> 
> Design
> ======
> 
> This series addresses that limitation by introducing srl2, a native
> SRv6 L2 endpoint interface. The intent is to make SRv6 L2 delivery
> usable in the same deployment model already familiar from VXLAN: an
> internal interface that represents the L2 service endpoint and can
> participate naturally in local L2 forwarding.
The current design, with vxlan, uses two interfaces: one bridge and one vxlan.
I presume this design was chosen because the vxlan protocol is implemented in
the vxlan driver.
I wonder if using the same design for SRv6 is the best choice. Why not use only
a bridge interface? Instead of pointing to a port, the FDB entries could point
to a nexthop id. This enables to associate a srv6 encap directly to a MAC
address. Something like:

$ ip nexthop list id 1234
id 1234 encap seg6 mode encap segs ...
$ bridge fdb show dev br0
02:03:04:05:06:07 dev br0 nhid 1234 ...

What is the gain of having two interfaces?
In term of scalability, it is interesting to have only one interface.

Regards,
Nicolas

> 
> On top of that, the series adds support for End.DT2U so that Ethernet
> payloads carried over SRv6 can be decapsulated and delivered into an
> L2 domain through either a bridge port or an srl2 interface.
> 
> Relation to RFC 8986
> ====================
> 
> RFC 8986 describes End.DT2U in terms of an abstract L2 table
> associated with the SID. That abstraction specifies the externally
> observable forwarding behavior of the node, but it does not mandate a
> specific internal implementation. What matters is functional
> equivalence.
> 
> This series enforces that property by restricting valid End.DT2U
> decapsulation targets to endpoints that provide the required L2
> forwarding semantics by construction.
> 
> When the target device is a bridge port, the Linux bridge provides
> the expected behavior directly: source MAC learning, destination MAC
> lookup, and unknown-unicast flooding within the corresponding L2
> domain.
> 
> When the target device is an srl2 interface, the same model is
> realized in a degenerate but valid form, corresponding to a minimal
> two-port L2 domain in which one endpoint is srl2. In that case,
> forwarding is trivial: frames are delivered to srl2 only when
> addressed to its MAC address, or when they are broadcast or multicast.
> No general FDB is required in this case because there are no
> additional L2 destinations to learn.
> 
> Any other type of decapsulation target is rejected at configuration
> time, since it would not guarantee the forwarding behavior required by
> End.DT2U.
> 
> The srl2 device is the minimal baseline implementation providing
> point-to-point L2 encapsulation with a single segment list.
> Additional features can be added incrementally based on community
> feedback and use cases.
> 
> Usage
> =====
> 
>   ip link add srl2-0 type srl2 segs fc00::a,fc00::b
>   ip link set srl2-0 master br0
> 
>   ip -6 route add fc00::100/128 encap seg6local action End.DT2U \
>       l2dev srl2-0 dev dum0
> 
>   # encapsulating traffic from veth-hs into srl2-0
>   ip link set veth-hs master br0
> 
> Selftest topology
> =================
> 
>             cafe::1                                cafe::2
>            10.0.0.1                               10.0.0.2
>           +--------+                             +--------+
>           |  hs-1  |                             |  hs-2  |
>           +---+----+                             +----+---+
>               |                                       |
>         +-----+------+                         +------+-----+
>         |   veth-hs  |                         |  veth-hs   |
>         |      |     |   fcf0:0:1:2::/64       |     |      |
>         |    br0     +-------------------------+   br0      |
>         |      |     |                         |     |      |
>         |   srl2-0   |                         |  srl2-0    |
>         |    rt-1    |                         |   rt-2     |
>         +------------+                         +------------+
> 
> The test verifies IPv4/IPv6 host-to-host and host-to-gateway
> connectivity over the SRv6 L2 VPN, including ARP resolution
> through the tunnel.
> 
> A companion iproute2 series provides userspace support:
> 
>   [RFC PATCH iproute2-next 0/4] seg6: add SRv6 End.DT2U and srl2 support
> 
> 
> This is an RFC posting to collect feedback on both the overall design
> and the userspace API before moving forward with a formal submission.
> 
> Comments are very welcome, especially on:
> - the introduction of srl2 as an internal SRv6 L2 endpoint
> - the choice of constraining End.DT2U targets to bridge ports
>   and srl2 devices
> - the netlink/uAPI exposure
> - the selftest coverage and topology
> 
> Thanks,
> Andrea and Stefano
> 
> 
> Andrea Mayer (3):
>   seg6: add support for the SRv6 End.DT2U behavior
>   seg6: add SRv6 L2 tunnel device (srl2)
>   selftests: seg6: add SRv6 srl2 + End.DT2U L2 VPN test
> 
>  include/linux/srl2.h                          |   7 +
>  include/uapi/linux/seg6_local.h               |   3 +
>  include/uapi/linux/srl2.h                     |  20 +
>  net/ipv6/Kconfig                              |  16 +
>  net/ipv6/Makefile                             |   1 +
>  net/ipv6/seg6.c                               |   1 +
>  net/ipv6/seg6_local.c                         | 160 ++++-
>  net/ipv6/srl2.c                               | 269 ++++++++
>  tools/testing/selftests/net/Makefile          |   1 +
>  tools/testing/selftests/net/config            |   1 +
>  .../selftests/net/srv6_srl2_l2vpn_test.sh     | 621 ++++++++++++++++++
>  11 files changed, 1094 insertions(+), 6 deletions(-)
>  create mode 100644 include/linux/srl2.h
>  create mode 100644 include/uapi/linux/srl2.h
>  create mode 100644 net/ipv6/srl2.c
>  create mode 100755 tools/testing/selftests/net/srv6_srl2_l2vpn_test.sh
> 



Return-Path: <netdev+bounces-146538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D439D40EB
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 18:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 036F9283352
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 17:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FB5149C42;
	Wed, 20 Nov 2024 17:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="E45/7b3G";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="rmuzs7RU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.6.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F25139579
	for <netdev@vger.kernel.org>; Wed, 20 Nov 2024 17:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.6.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732122951; cv=none; b=hnOMUetvEpjfp0aFupP0BRy5Absv+voJe9xJR29U8bp6zpnGl+F0wUBKaQyUXXadXyBb6MEAxf4iFd6y4zMW45byWX/bq+KlvHViZsbZHORqibR/TZMj4luL0kXlqHwA8zszS9xsNRfgO31c4SWtRNAWz582JIi//kIQ1EVzCa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732122951; c=relaxed/simple;
	bh=yZmajvVoGH5zwCGm4YZ6XAV01yy4JmKp6DyvnrAXFBA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JrSshldv4Vuxb2jOAG52ZXxr6qqPoCJHV9vW+hsO6lk8jeZNt79g6mGadz2inEIMujFW4kjNBasxzxxrpmucd5kDxd0XD1ZyhHFiWsYRqEDGlrGh/rb1phPyeaOW1JIP5RJRSY42ekLlU/Y21bMFyHSWyMzxwY/ZZJ3Cct8k5pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=E45/7b3G; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=rmuzs7RU; arc=none smtp.client-ip=160.80.6.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 4AKHC6mf000983;
	Wed, 20 Nov 2024 18:12:11 +0100
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 741CC122906;
	Wed, 20 Nov 2024 18:12:01 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1732122721; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b5UOuJKBFKk0e+3hkD+Oo77UjqhQbOdXpavmc+Pl5cQ=;
	b=E45/7b3GRV0uJnNCG0d5cLlYfs5AqduImQ7W9AvyM5e2SHLCAUq4D9RVf2MGrKnk7y+zdT
	azqs8qJBFtNKDIAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1732122721; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b5UOuJKBFKk0e+3hkD+Oo77UjqhQbOdXpavmc+Pl5cQ=;
	b=rmuzs7RUsb10zJIpQzVWFgO3TNpxaYZhRHMkqYpx7Zl9iQUc8AMb5/569O2VVpGovjWuRM
	hibAR+hKm3Po+MzO6pPDcmroqUeWZitHLPiN/JHDU1xOflTGut+Quv0NL+Up7bWjCXEhml
	7roYiXyBlati0z5fFcxu5XbjlzX2Z80OeSnKhnJWyzatRa3yfyKZqB34YN2t7jxd6U39Ae
	NvOdSc9yPjWV/xdUFJt65KxINK2Jn9dLGvFwYE3ztFJrVrPHpG8or4dXhC3CgtSkVuF2qT
	siZ7Jug8G4NPWbKqNx+iMZaidR8YPyhmT0mVrdE9NC4lxf1zoGqWNEYnlPZmnQ==
Date: Wed, 20 Nov 2024 18:12:01 +0100
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: "Mortensen, Christian" <cworm@akamai.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
        Stefano Salsano
 <stefano.salsano@uniroma2.it>,
        Paolo Lungaroni
 <paolo.lungaroni@uniroma2.it>,
        Ahmed Abdelsalam <ahabdels.dev@gmail.com>,
        Andrea Mayer <andrea.mayer@uniroma2.it>,
        "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: Stackoverflow when using seg6 routes
Message-Id: <20241120181201.594aab6da28ec54d263c9177@uniroma2.it>
In-Reply-To: <2bc9e2079e864a9290561894d2a602d6@akamai.com>
References: <2bc9e2079e864a9290561894d2a602d6@akamai.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

Hi Christian,
please see below.

On Fri, 1 Nov 2024 16:28:54 +0000
"Mortensen, Christian" <cworm@akamai.com> wrote:

> Hi!
>=20
> I can consistently reproduce a stack-overflow=A0in the kernel when using =
seg6 routes. I was hit by the bug in a stock 5.15.0-119 Ubuntu kernel. I re=
produced it in QEMU using a custom 6.11.3 kernel. I have not tried other ke=
rnels.
>=20
> Here is output from the 6.11.3 kernel:
>=20
> BUG: IRQ stack guard page was hit at (____ptrval____) (stack is (____ptrv=
al____)..(____ptrval____))
> Oops: stack guard page: 0000 [#1] PREEMPT SMP PTI
> CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.11.3 #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian=
-1.16.2-1 04/01/2014
> RIP: 0010:fib_table_lookup+0x25/0x640
> Code: 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 41 57 49 89 f8 49 89 f1 4=
1 56 41 55 41 54 55 53 48 83 ec 58 48 8b 6f 28 44 8b 76 2c <89> 0c 24 48 8b=
 5d 08 48 85 db 0f 84 82 00 00 00 49 89 d2 45 31 e4
> RSP: 0018:ffffa81e000f4fe0 EFLAGS: 00010282
> RAX: ffff940dc2d9b600 RBX: ffff940dc1d7d9c0 RCX: 0000000000000001
> RDX: ffffa81e000f5128 RSI: ffffa81e000f5158 RDI: ffff940dc2d9b600
> RBP: ffff940dc2d9b630 R08: ffff940dc2d9b600 R09: ffffa81e000f5158
> R10: ffff940dc6882200 R11: ffff940dc3360000 R12: 00000000fffffff5
> R13: ffffa81e000f5158 R14: 000000000101a8c0 R15: ffff940dc793b080
> FS:  0000000000000000(0000) GS:ffff940e79c80000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffa81e000f4fd8 CR3: 000000000ce2c000 CR4: 00000000000006f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <#DF>
>  ? die+0x37/0x90
>  ? handle_stack_overflow+0x4d/0x60
>  ? exc_double_fault+0xe3/0x150
>  ? asm_exc_double_fault+0x23/0x30
>  ? fib_table_lookup+0x25/0x640
>  </#DF>
>  <IRQ>
>  ? fib_table_lookup+0x223/0x640
>  fib4_rule_action+0x7c/0xa0
>  fib_rules_lookup+0x1db/0x260
>  __fib_lookup+0x5f/0x90
>  __fib_validate_source+0x2e0/0x410
>  ? fib4_rule_action+0x84/0xa0
>  ? fib_rules_lookup+0x106/0x260
>  fib_validate_source+0x55/0x110
>  ip_route_input_slow+0x69b/0xb60
>  ip_route_input_noref+0x79/0x80
>  input_action_end_dt4+0x8c/0x180
>  seg6_local_input_core+0x34/0x70
>  lwtunnel_input+0x62/0xb0
>  lwtunnel_input+0x62/0xb0
>  seg6_local_input_core+0x34/0x70
>  lwtunnel_input+0x62/0xb0
>  lwtunnel_input+0x62/0xb0
>  seg6_local_input_core+0x34/0x70
>  lwtunnel_input+0x62/0xb0
>  lwtunnel_input+0x62/0xb0
>  seg6_local_input_core+0x34/0x70
>  lwtunnel_input+0x62/0xb0
>  lwtunnel_input+0x62/0xb0
>=20
> (MANY SIMILAR LINES OMITTED)
>=20
>  seg6_local_input_core+0x34/0x70
>  lwtunnel_input+0x62/0xb0
>  lwtunnel_input+0x62/0xb0
>  seg6_local_input_core+0x34/0x70
>  lwtunnel_input+0x62/0xb0
>  lwtunnel_input+0x62/0xb0
>  seg6_local_input_core+0x34/0x70
>  lwtunnel_input+0x62/0xb0
>  lwtunnel_input+0x62/0xb0
>  __netif_receive_skb_one_core+0x6b/0x80
>  process_backlog+0x8a/0x130
>  __napi_poll+0x2c/0x1b0
>  net_rx_action+0x2e6/0x350
>  ? sched_balance_domains+0xe9/0x350
>  handle_softirqs+0xc4/0x290
>  irq_exit_rcu+0x67/0x90
>  sysvec_apic_timer_interrupt+0x75/0x90
>  </IRQ>
>  <TASK>
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20
> RIP: 0010:default_idle+0xf/0x20
> Code: 4c 01 c7 4c 29 c2 e9 72 ff ff ff 90 90 90 90 90 90 90 90 90 90 90 9=
0 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d c3 26 26 00 fb f4 <fa> c3 cc cc cc=
 cc 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
> RSP: 0018:ffffa81e000b3ef0 EFLAGS: 00000202
> RAX: ffff940e79c80000 RBX: 0000000000000001 RCX: 0000000000000000
> RDX: 0000000000000001 RSI: ffffffffb5a2e8a9 RDI: 0000000000d4f884
> RBP: ffff940dc0384000 R08: 0000000000d4f884 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  default_idle_call+0x30/0xf0
>  do_idle+0x1b1/0x1c0
>  cpu_startup_entry+0x29/0x30
>  start_secondary+0xf5/0x100
>  common_startup_64+0x13e/0x148
>  </TASK>
> Modules linked in: veth vrf
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:fib_table_lookup+0x25/0x640
> Code: 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 41 57 49 89 f8 49 89 f1 4=
1 56 41 55 41 54 55 53 48 83 ec 58 48 8b 6f 28 44 8b 76 2c <89> 0c 24 48 8b=
 5d 08 48 85 db 0f 84 82 00 00 00 49 89 d2 45 31 e4
> RSP: 0018:ffffa81e000f4fe0 EFLAGS: 00010282
> RAX: ffff940dc2d9b600 RBX: ffff940dc1d7d9c0 RCX: 0000000000000001
> RDX: ffffa81e000f5128 RSI: ffffa81e000f5158 RDI: ffff940dc2d9b600
> RBP: ffff940dc2d9b630 R08: ffff940dc2d9b600 R09: ffffa81e000f5158
> R10: ffff940dc6882200 R11: ffff940dc3360000 R12: 00000000fffffff5
> R13: ffffa81e000f5158 R14: 000000000101a8c0 R15: ffff940dc793b080
> FS:  0000000000000000(0000) GS:ffff940e79c80000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffa81e000f4fd8 CR3: 000000000ce2c000 CR4: 00000000000006f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Kernel panic - not syncing: Fatal exception in interrupt
> Kernel Offset: 0x33000000 from 0xffffffff81000000 (relocation range: 0xff=
ffffff80000000-0xffffffffbfffffff)
>=20
> The following script consistently reproduces the problem for me. It is pr=
obably not minimal:
>=20

Thank you for providing the commands and configuration to reproduce the
behavior.

> #!/bin/bash
>=20
> # Make a network namespace
> ip netns delete network
> ip netns add network
> ip netns exec network ip link add br0 type bridge
> ip netns exec network ip link set br0 up
>=20
> # Setup host1:
> ip netns delete host1
> ip netns add host1
> ip netns exec network ip link add host1 type veth peer frr0 netns host1
> ip netns exec host1 ip addr add dev frr0 fe80::1
> ip netns exec host1 ip link set dev frr0 address 00:00:01:00:00:01
> ip netns exec host1 ip link set frr0 up
> ip netns exec network ip link set host1 master br0
> ip netns exec network ip link set host1 up
> ip netns exec host1 ip l set dev lo up
> ip netns exec host1 sysctl net.ipv4.ip_forward=3D1
> ip netns exec host1 sysctl net.ipv4.conf.all.rp_filter=3D0
> ip netns exec host1 sysctl net.ipv6.conf.all.forwarding=3D1
> ip netns exec host1 sysctl net.ipv4.conf.default.log_martians=3D1
> ip netns exec host1 sysctl net.vrf.strict_mode=3D1
> ip netns exec host1 ip addr add dev lo fc00::1:6:0:0:1
> ip netns exec host1 ip link add vrf9 type vrf table 1009
> ip netns exec host1 ip link set vrf9 up

Now, consider the following instruction for decapsulating a tunnel based on=
 the
SRv6 End.DT4 decap SID

> ip netns exec host1 ip r add fc00:0:0:1:7:: encap seg6local action End.DT=
4 vrftable 1009 dev vrf9 proto bgp metric 20 pref medium

This proposed configuration is pathological because the same End.DT4 decap =
SID,
fc00:0:0:1:7:: is used to identify a function residing in host1 and host2 (=
see
the equivalent decap instruction in host 2).

You must choose two different SIDs to distinguish the two instances of decap
behavior, for example you could assign fc00:0:0:1:7::d4 for the End.DT4
deployed on host1 and and fc00:0:0:2:7::d4 for the End.DT4 host2 respective=
ly.

In particular according to the SRv6 architecture, a SID should provide both=
 the
topological information (where to route the packet) and the service informa=
tion
(what to do with the packet when you have reached the destination).
Breaking this model is highly likely to generate troubles.

Therefore, the specific SID for (destination + End.DT4) should be used in t=
he
segment list of the following encapsulation instruction:

> ip netns exec host1 ip r add 192.168.2.1 encap seg6 mode encap segs fc00:=
0:0:1:7:: via inet6 fe80::2 dev frr0 vrf vrf9
>=20

Following the above instruction, the host 1 will encapsulate all packets wi=
th
IPv4 destination 192.168.2.1 into SRv6 packets with destination address
fc00:0:0:1:7::. Note that the "via" and "dev" parameters provided in this
instruction are simply ignored.

The host 1 will use the destination address (fc00:0:0:1:7::) to route the p=
acket
after the encapsulation operation. This is why it is fundamental that the S=
ID
includes the topological information to reach the destination.

On the other hand, in the provided configuration, the same destination addr=
ess
(fc00:0:0:1:7::) is associated with the decap (End.DT4) operation. Therefor=
e, the
packet immediately after having been encapsulated by host 1, will be
decapsulated by host 1 itself, and the original IPv4 packet will be again
routed by host 1. Clearly, the IPv4 destination will match the destination
associated with the encapsulation instruction and the packet will be again
encapsulated.

You can see that a loop is created and the packet will continue to be
encapsulated and then decapsulated until the stack-overflow in the kernel w=
ill
happen.

Perhaps the Linux kernel should be able to detect and protect itself from t=
his
kind of misconfiguration, but this will require a re-design of some kernel
components.

Ciao,
Andrea

> # Setup pseduo-vm on host1
> ip netns delete host1_1
> ip netns add host1_1
> ip netns exec host1 ip link add vm1 type veth peer eth0 netns host1_1
> ip netns exec host1 ip link set vm1 master vrf9
> ip netns exec host1 ip link set vm1 up
> ip netns exec host1_1 ip link set eth0 up
> ip netns exec host1 sysctl net.ipv4.conf.vm1.proxy_arp=3D1
> ip netns exec host1_1 ip addr add dev eth0 192.168.1.1/16
> ip netns exec host1 ip route add 192.168.1.1/32 dev vm1 vrf vrf9
>=20
> # Setup host2
> ip netns delete host2
> ip netns add host2
> ip netns exec network ip link add host2 type veth peer frr0 netns host2
> ip netns exec host2 ip addr add dev frr0 fe80::2
> ip netns exec host2 ip link set dev frr0 address 00:00:01:00:00:02
> ip netns exec host2 ip link set frr0 up
> ip netns exec network ip link set host2 master br0
> ip netns exec network ip link set host2 up
> ip netns exec host2 ip l set dev lo up
> ip netns exec host2 sysctl net.ipv4.ip_forward=3D1
> ip netns exec host2 sysctl net.ipv4.conf.all.rp_filter=3D0
> ip netns exec host2 sysctl net.ipv6.conf.all.forwarding=3D1
> ip netns exec host2 sysctl net.ipv4.conf.default.log_martians=3D1
> ip netns exec host2 sysctl net.vrf.strict_mode=3D1
> ip netns exec host2 ip addr add dev lo fc00::2:6:0:0:1
> ip netns exec host2 ip link add vrf9 type vrf table 1009
> ip netns exec host2 ip link set vrf9 up
> ip netns exec host2 ip r add fc00:0:0:1:7:: encap seg6local action End.DT=
4 vrftable 1009 dev vrf9 proto bgp metric 20 pref medium
> ip netns exec host2 ip r add 192.168.1.1 encap seg6 mode encap segs fc00:=
0:0:1:7:: via inet6 fe80::1 dev frr0 vrf vrf9
>=20
> # Setup pseduo-vm on host2:
> ip netns delete host2_1
> ip netns add host2_1
> ip netns exec host2 ip link add vm1 type veth peer eth0 netns host2_1
> ip netns exec host2 ip link set vm1 master vrf9
> ip netns exec host2 ip link set vm1 up
> ip netns exec host2_1 ip link set eth0 up
> ip netns exec host2 sysctl net.ipv4.conf.vm1.proxy_arp=3D1
> ip netns exec host2_1 ip addr add dev eth0 192.168.2.1/16
> ip netns exec host2 ip route add 192.168.2.1/32 dev vm1 vrf vrf9
> ip netns exec host1_1 ip a add 192.168.254.254 dev eth0
>=20
> # Setup routes between host1 and host2:
> ip netns exec host1 ip -6 route add fc00:0:0:2::/64 dev frr0 nexthop via =
fe80::2
> ip netns exec host1 ip neigh add fe80::2 lladdr 00:00:01:00:00:02 dev frr0
> ip netns exec host2 ip -6 route add fc00:0:0:1::/64 dev frr0 nexthop via =
fe80::1
> ip netns exec host2 ip neigh add fe80::1 lladdr 00:00:01:00:00:01 dev frr0
>=20
> # And ping
> ip netns exec host1_1 ping 192.168.2.1
>=20
>=20
> Best
>=20
> Christian
>=20
>


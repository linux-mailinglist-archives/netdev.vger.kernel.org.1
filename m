Return-Path: <netdev+bounces-141065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0793A9B9579
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 17:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B98792828A6
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 16:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC97B145FE0;
	Fri,  1 Nov 2024 16:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="WAqvyQ5E"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FF214884F
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 16:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730478806; cv=none; b=j6/Xhv6CtM/O6OgyAcWHsyAFm9YsWrQoRRRt9RwTFnSx1KzTSxQv+d3NFiiift4/NOf6dDu92+sJGWd50r9VCk2WUAc4207W9q7AdMdn+ltM94+izb+rmXrkhZo5f67JvgpcYHstZ3fq2XpL/cjAPBHYOtatVzN2z2LAfqsZoSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730478806; c=relaxed/simple;
	bh=On8LByMUMPJ/v8jOG5Xx12HT3MaHDgMujA0M548NRpw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QY3FzGHz99eVSWPHsJ0KP1DupRpEHXTH41bbS16DMqHZdTrKrKw2lwvjc9UZOUvRsDvdC1KIxCn3N1Nq15sPsMGNA6/Osdajv1h4aK0k7i5pyfpzI0PjLE4MlFGFpYO+Y3rKby1myC5KiIkxp9CKEpzwAo1qX/axjIXJtlDupMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=WAqvyQ5E; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0050096.ppops.net [127.0.0.1])
	by m0050096.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id 4A18j0t4013192;
	Fri, 1 Nov 2024 16:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=jan2016.eng; bh=Oejh6t/b8MYUhmRSIHS+
	P9trmrqhfm0+Kt3RkzQyEFY=; b=WAqvyQ5EjwkcSyo1DRP5f7C2aT2Icobf0SR6
	HFBpt5vuk0+2WKbYqQLnO86SKm0+vrB6+Ss02rUZh/b11AZXnp24CZ32LtfqCPWK
	NawajE+45oX3WE+dFIq5nOH+qBunO2GNOihaJHMd+E9YLQK1nn+nGpJIF6h4GFTB
	gnWZ0ainxMz4qduAU8xpqa7PhjokbIaiCFhKlfRoMKIk0ZAMUF9CewD7VFKYwvZo
	/G20GVn3I580kAswEOtauIsrWuFHkJWXIST2xQCDwhRatdLYcKREZmTO9mSJJp4V
	TuGGWTMWfI8kS2rElKx2R7/jq6c7M35C+mUk4/hIr7woWdW0JQ==
Received: from prod-mail-ppoint8 (a72-247-45-34.deploy.static.akamaitechnologies.com [72.247.45.34] (may be forged))
	by m0050096.ppops.net-00190b01. (PPS) with ESMTPS id 42jtj09m72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 16:28:56 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint8.akamai.com [127.0.0.1])
	by prod-mail-ppoint8.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1GESaF020437;
	Fri, 1 Nov 2024 12:28:55 -0400
Received: from email.msg.corp.akamai.com ([172.27.50.207])
	by prod-mail-ppoint8.akamai.com (PPS) with ESMTPS id 42gurwr0hx-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 12:28:55 -0400
Received: from ustx2ex-dag4mb2.msg.corp.akamai.com (172.27.50.201) by
 ustx2ex-dag4mb8.msg.corp.akamai.com (172.27.50.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 1 Nov 2024 09:28:54 -0700
Received: from ustx2ex-dag4mb2.msg.corp.akamai.com ([172.27.50.201]) by
 ustx2ex-dag4mb2.msg.corp.akamai.com ([172.27.50.201]) with mapi id
 15.02.1544.011; Fri, 1 Nov 2024 09:28:54 -0700
From: "Mortensen, Christian" <cworm@akamai.com>
To: "davem@davemloft.net" <davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Stackoverflow when using seg6 routes
Thread-Topic: Stackoverflow when using seg6 routes
Thread-Index: AQHbLHgGBbzTarS88E2nQjLK/Exe5A==
Date: Fri, 1 Nov 2024 16:28:54 +0000
Message-ID: <2bc9e2079e864a9290561894d2a602d6@akamai.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-01_10,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=503
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411010118
X-Proofpoint-GUID: VD-26SE2sahrZJ51t5k-pb3IzMBX8mrH
X-Proofpoint-ORIG-GUID: VD-26SE2sahrZJ51t5k-pb3IzMBX8mrH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0 mlxlogscore=328
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411010120

Hi!

I can consistently reproduce a stack-overflow=A0in the kernel when using se=
g6 routes. I was hit by the bug in a stock 5.15.0-119 Ubuntu kernel. I repr=
oduced it in QEMU using a custom 6.11.3 kernel. I have not tried other kern=
els.

Here is output from the 6.11.3 kernel:

BUG: IRQ stack guard page was hit at (____ptrval____) (stack is (____ptrval=
____)..(____ptrval____))
Oops: stack guard page: 0000 [#1] PREEMPT SMP PTI
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.11.3 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1=
.16.2-1 04/01/2014
RIP: 0010:fib_table_lookup+0x25/0x640
Code: 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 41 57 49 89 f8 49 89 f1 41 =
56 41 55 41 54 55 53 48 83 ec 58 48 8b 6f 28 44 8b 76 2c <89> 0c 24 48 8b 5=
d 08 48 85 db 0f 84 82 00 00 00 49 89 d2 45 31 e4
RSP: 0018:ffffa81e000f4fe0 EFLAGS: 00010282
RAX: ffff940dc2d9b600 RBX: ffff940dc1d7d9c0 RCX: 0000000000000001
RDX: ffffa81e000f5128 RSI: ffffa81e000f5158 RDI: ffff940dc2d9b600
RBP: ffff940dc2d9b630 R08: ffff940dc2d9b600 R09: ffffa81e000f5158
R10: ffff940dc6882200 R11: ffff940dc3360000 R12: 00000000fffffff5
R13: ffffa81e000f5158 R14: 000000000101a8c0 R15: ffff940dc793b080
FS:  0000000000000000(0000) GS:ffff940e79c80000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffa81e000f4fd8 CR3: 000000000ce2c000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <#DF>
 ? die+0x37/0x90
 ? handle_stack_overflow+0x4d/0x60
 ? exc_double_fault+0xe3/0x150
 ? asm_exc_double_fault+0x23/0x30
 ? fib_table_lookup+0x25/0x640
 </#DF>
 <IRQ>
 ? fib_table_lookup+0x223/0x640
 fib4_rule_action+0x7c/0xa0
 fib_rules_lookup+0x1db/0x260
 __fib_lookup+0x5f/0x90
 __fib_validate_source+0x2e0/0x410
 ? fib4_rule_action+0x84/0xa0
 ? fib_rules_lookup+0x106/0x260
 fib_validate_source+0x55/0x110
 ip_route_input_slow+0x69b/0xb60
 ip_route_input_noref+0x79/0x80
 input_action_end_dt4+0x8c/0x180
 seg6_local_input_core+0x34/0x70
 lwtunnel_input+0x62/0xb0
 lwtunnel_input+0x62/0xb0
 seg6_local_input_core+0x34/0x70
 lwtunnel_input+0x62/0xb0
 lwtunnel_input+0x62/0xb0
 seg6_local_input_core+0x34/0x70
 lwtunnel_input+0x62/0xb0
 lwtunnel_input+0x62/0xb0
 seg6_local_input_core+0x34/0x70
 lwtunnel_input+0x62/0xb0
 lwtunnel_input+0x62/0xb0

(MANY SIMILAR LINES OMITTED)

 seg6_local_input_core+0x34/0x70
 lwtunnel_input+0x62/0xb0
 lwtunnel_input+0x62/0xb0
 seg6_local_input_core+0x34/0x70
 lwtunnel_input+0x62/0xb0
 lwtunnel_input+0x62/0xb0
 seg6_local_input_core+0x34/0x70
 lwtunnel_input+0x62/0xb0
 lwtunnel_input+0x62/0xb0
 __netif_receive_skb_one_core+0x6b/0x80
 process_backlog+0x8a/0x130
 __napi_poll+0x2c/0x1b0
 net_rx_action+0x2e6/0x350
 ? sched_balance_domains+0xe9/0x350
 handle_softirqs+0xc4/0x290
 irq_exit_rcu+0x67/0x90
 sysvec_apic_timer_interrupt+0x75/0x90
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20
RIP: 0010:default_idle+0xf/0x20
Code: 4c 01 c7 4c 29 c2 e9 72 ff ff ff 90 90 90 90 90 90 90 90 90 90 90 90 =
90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d c3 26 26 00 fb f4 <fa> c3 cc cc cc c=
c 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
RSP: 0018:ffffa81e000b3ef0 EFLAGS: 00000202
RAX: ffff940e79c80000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffffb5a2e8a9 RDI: 0000000000d4f884
RBP: ffff940dc0384000 R08: 0000000000d4f884 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 default_idle_call+0x30/0xf0
 do_idle+0x1b1/0x1c0
 cpu_startup_entry+0x29/0x30
 start_secondary+0xf5/0x100
 common_startup_64+0x13e/0x148
 </TASK>
Modules linked in: veth vrf
---[ end trace 0000000000000000 ]---
RIP: 0010:fib_table_lookup+0x25/0x640
Code: 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 41 57 49 89 f8 49 89 f1 41 =
56 41 55 41 54 55 53 48 83 ec 58 48 8b 6f 28 44 8b 76 2c <89> 0c 24 48 8b 5=
d 08 48 85 db 0f 84 82 00 00 00 49 89 d2 45 31 e4
RSP: 0018:ffffa81e000f4fe0 EFLAGS: 00010282
RAX: ffff940dc2d9b600 RBX: ffff940dc1d7d9c0 RCX: 0000000000000001
RDX: ffffa81e000f5128 RSI: ffffa81e000f5158 RDI: ffff940dc2d9b600
RBP: ffff940dc2d9b630 R08: ffff940dc2d9b600 R09: ffffa81e000f5158
R10: ffff940dc6882200 R11: ffff940dc3360000 R12: 00000000fffffff5
R13: ffffa81e000f5158 R14: 000000000101a8c0 R15: ffff940dc793b080
FS:  0000000000000000(0000) GS:ffff940e79c80000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffa81e000f4fd8 CR3: 000000000ce2c000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Kernel panic - not syncing: Fatal exception in interrupt
Kernel Offset: 0x33000000 from 0xffffffff81000000 (relocation range: 0xffff=
ffff80000000-0xffffffffbfffffff)

The following script consistently reproduces the problem for me. It is prob=
ably not minimal:

#!/bin/bash

# Make a network namespace
ip netns delete network
ip netns add network
ip netns exec network ip link add br0 type bridge
ip netns exec network ip link set br0 up

# Setup host1:
ip netns delete host1
ip netns add host1
ip netns exec network ip link add host1 type veth peer frr0 netns host1
ip netns exec host1 ip addr add dev frr0 fe80::1
ip netns exec host1 ip link set dev frr0 address 00:00:01:00:00:01
ip netns exec host1 ip link set frr0 up
ip netns exec network ip link set host1 master br0
ip netns exec network ip link set host1 up
ip netns exec host1 ip l set dev lo up
ip netns exec host1 sysctl net.ipv4.ip_forward=3D1
ip netns exec host1 sysctl net.ipv4.conf.all.rp_filter=3D0
ip netns exec host1 sysctl net.ipv6.conf.all.forwarding=3D1
ip netns exec host1 sysctl net.ipv4.conf.default.log_martians=3D1
ip netns exec host1 sysctl net.vrf.strict_mode=3D1
ip netns exec host1 ip addr add dev lo fc00::1:6:0:0:1
ip netns exec host1 ip link add vrf9 type vrf table 1009
ip netns exec host1 ip link set vrf9 up
ip netns exec host1 ip r add fc00:0:0:1:7:: encap seg6local action End.DT4 =
vrftable 1009 dev vrf9 proto bgp metric 20 pref medium
ip netns exec host1 ip r add 192.168.2.1 encap seg6 mode encap segs fc00:0:=
0:1:7:: via inet6 fe80::2 dev frr0 vrf vrf9

# Setup pseduo-vm on host1
ip netns delete host1_1
ip netns add host1_1
ip netns exec host1 ip link add vm1 type veth peer eth0 netns host1_1
ip netns exec host1 ip link set vm1 master vrf9
ip netns exec host1 ip link set vm1 up
ip netns exec host1_1 ip link set eth0 up
ip netns exec host1 sysctl net.ipv4.conf.vm1.proxy_arp=3D1
ip netns exec host1_1 ip addr add dev eth0 192.168.1.1/16
ip netns exec host1 ip route add 192.168.1.1/32 dev vm1 vrf vrf9

# Setup host2
ip netns delete host2
ip netns add host2
ip netns exec network ip link add host2 type veth peer frr0 netns host2
ip netns exec host2 ip addr add dev frr0 fe80::2
ip netns exec host2 ip link set dev frr0 address 00:00:01:00:00:02
ip netns exec host2 ip link set frr0 up
ip netns exec network ip link set host2 master br0
ip netns exec network ip link set host2 up
ip netns exec host2 ip l set dev lo up
ip netns exec host2 sysctl net.ipv4.ip_forward=3D1
ip netns exec host2 sysctl net.ipv4.conf.all.rp_filter=3D0
ip netns exec host2 sysctl net.ipv6.conf.all.forwarding=3D1
ip netns exec host2 sysctl net.ipv4.conf.default.log_martians=3D1
ip netns exec host2 sysctl net.vrf.strict_mode=3D1
ip netns exec host2 ip addr add dev lo fc00::2:6:0:0:1
ip netns exec host2 ip link add vrf9 type vrf table 1009
ip netns exec host2 ip link set vrf9 up
ip netns exec host2 ip r add fc00:0:0:1:7:: encap seg6local action End.DT4 =
vrftable 1009 dev vrf9 proto bgp metric 20 pref medium
ip netns exec host2 ip r add 192.168.1.1 encap seg6 mode encap segs fc00:0:=
0:1:7:: via inet6 fe80::1 dev frr0 vrf vrf9

# Setup pseduo-vm on host2:
ip netns delete host2_1
ip netns add host2_1
ip netns exec host2 ip link add vm1 type veth peer eth0 netns host2_1
ip netns exec host2 ip link set vm1 master vrf9
ip netns exec host2 ip link set vm1 up
ip netns exec host2_1 ip link set eth0 up
ip netns exec host2 sysctl net.ipv4.conf.vm1.proxy_arp=3D1
ip netns exec host2_1 ip addr add dev eth0 192.168.2.1/16
ip netns exec host2 ip route add 192.168.2.1/32 dev vm1 vrf vrf9
ip netns exec host1_1 ip a add 192.168.254.254 dev eth0

# Setup routes between host1 and host2:
ip netns exec host1 ip -6 route add fc00:0:0:2::/64 dev frr0 nexthop via fe=
80::2
ip netns exec host1 ip neigh add fe80::2 lladdr 00:00:01:00:00:02 dev frr0
ip netns exec host2 ip -6 route add fc00:0:0:1::/64 dev frr0 nexthop via fe=
80::1
ip netns exec host2 ip neigh add fe80::1 lladdr 00:00:01:00:00:01 dev frr0

# And ping
ip netns exec host1_1 ping 192.168.2.1


Best

Christian




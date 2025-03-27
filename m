Return-Path: <netdev+bounces-177900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F35A72AA6
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 08:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B40CC176D2C
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 07:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59161FF613;
	Thu, 27 Mar 2025 07:40:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E85C4A1A;
	Thu, 27 Mar 2025 07:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743061213; cv=none; b=T6+oM0ZEERCpT1uLBS343Zq18OiCk+epozLjgrr7/CMNSzhPqyP3q0pO6PGOtnSIYSGl1QckP1nVhFO7g8O04/t+FxutRLKLdiQo2JCPTscy2yLyWZNzTkeBrF+OzqhGWCIv6DWsiqkeEJrLBmr4h+yycosotsqBG/RZDJ9tQzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743061213; c=relaxed/simple;
	bh=xIzDxi++J3dCaLpdaxTc+W8/qa00RPqhhzN6FtJfE20=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pY/FyQ7Tl2MYERCibOJiAb9OFv7KcKkl1Mq4fvx7HSaI2kLdXPMkseFKFpTKo7Hy0AkC5MmuEmc0VCMHjIKOFivjC7ERKVui3+1l7KQ6esNJQwWrOqJfz8itpWowgl+KJsaJlYTfOACIlF12U8AMjBZ5AZDbxK6wwqzVN7uj9Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZNb6R2k9Gz2TS0C;
	Thu, 27 Mar 2025 15:35:27 +0800 (CST)
Received: from kwepemg200005.china.huawei.com (unknown [7.202.181.32])
	by mail.maildlp.com (Postfix) with ESMTPS id DEFF71A016C;
	Thu, 27 Mar 2025 15:40:07 +0800 (CST)
Received: from [10.174.176.70] (10.174.176.70) by
 kwepemg200005.china.huawei.com (7.202.181.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 27 Mar 2025 15:40:06 +0800
Message-ID: <7b0e4957-623b-45ce-85e4-e4c08cbdb8b3@huawei.com>
Date: Thu, 27 Mar 2025 15:40:06 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: sit: fix skb_under_panic with overflowed
 needed_headroom
To: Eric Dumazet <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <kuniyu@amazon.com>,
	<yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250327015827.2729554-1-wangliang74@huawei.com>
 <CANn89iJn5gARyEPHeYxZxERpERdNKMngMcP1BbKrW9ebxB-tRw@mail.gmail.com>
 <df2d0ac0-c80e-4511-9303-3ee773c73a22@huawei.com>
 <CANn89iJdThGoaVc3LbucK_QGe1akNzmd5YOhMqmshwh_RfOn+A@mail.gmail.com>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <CANn89iJdThGoaVc3LbucK_QGe1akNzmd5YOhMqmshwh_RfOn+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg200005.china.huawei.com (7.202.181.32)


在 2025/3/27 14:39, Eric Dumazet 写道:
> On Thu, Mar 27, 2025 at 7:33 AM Wang Liang <wangliang74@huawei.com> wrote:
>>
>>
>> You can get the report in
>> https://syzkaller.appspot.com/text?tag=CrashReport&x=106b6b34880000
> Well, please provide the most accurate stack trace with symbols in
> your patch then ?
>
> If you spent time reproducing the issue and providing your stack
> trace, please add the symbols.


Thank you for the reminder of decode_stacktrace.sh.

I just reproduce the issue, and first use decode_stacktrace.sh to get the
stack trace below[1], please check it. I will update the stack trace in my
patch later.

Thanks.


[1]

[  895.885034][T23587] ------------[ cut here ]------------
[  895.885951][T23587] kernel BUG at net/core/skbuff.c:209!
[  895.886889][T23587] Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
[  895.888037][T23587] CPU: 0 UID: 0 PID: 23587 Comm: test Tainted: 
G        W          6.14.0-00624-g2f2d52945852-dirty #15
[  895.889837][T23587] Tainted: [W]=WARN
[  895.890469][T23587] Hardware name: QEMU Standard PC (i440FX + PIIX, 
1996), BIOS 1.15.0-1 04/01/2014
[895.891962][T23587] RIP: 0010:skb_panic (net/core/skbuff.c:209 
(discriminator 4))
[ 895.892786][T23587] Code: 0f b6 04 01 84 c0 74 04 3c 03 7e 20 8b 4b 70 
41 56 45 89 e8 48 c7 c7 c0 0c 7e 8b 41 57 56 48 89 ee 52 4c 89 e2 e8 6a 
40 6e f9 <0f> 0b 4c 89 4c 24 10 48 89 54 24 08 48 89 34 24 e8 b5 68 ec f9 4c
[  895.895918][T23587] RSP: 0018:ffffc900000e6a18 EFLAGS: 00010282
[  895.897396][T23587] RAX: 0000000000000088 RBX: ffff88809a0cd000 RCX: 
ffffffff819352e9
[  895.898695][T23587] RDX: 0000000000000000 RSI: ffffffff8193bd1d RDI: 
0000000000000005
[  895.899992][T23587] RBP: ffffffff8b7e2020 R08: 0000000000000000 R09: 
fffffbfff1989a84
[  895.901274][T23587] R10: 0000000000000200 R11: 000000000023df70 R12: 
ffffffff88d9b291
[  895.902561][T23587] R13: 0000000000000008 R14: ffff88805013e120 R15: 
0000000000000180
[  895.903863][T23587] FS:  00000000162863c0(0000) 
GS:ffff8880b9400000(0000) knlGS:0000000000000000
[  895.905307][T23587] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  895.906378][T23587] CR2: ffffffffff600400 CR3: 0000000094fcc000 CR4: 
00000000000006f0
[  895.907669][T23587] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[  895.908960][T23587] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[  895.910252][T23587] Call Trace:
[  895.910798][T23587]  <TASK>
[895.923567][T23587] skb_push (net/core/skbuff.c:2544)
[895.924232][T23587] fou_build_udp (./include/linux/skbuff.h:3026 
net/ipv4/fou_core.c:1041)
[895.925001][T23587] gue_build_header (net/ipv4/fou_core.c:1085)
[895.927586][T23587] ip_tunnel_xmit (./include/net/ip_tunnels.h:541 
./include/net/ip_tunnels.h:525 net/ipv4/ip_tunnel.c:780)
[895.931769][T23587] sit_tunnel_xmit__.isra.0 (net/ipv6/sit.c:1065)
[895.932682][T23587] sit_tunnel_xmit (net/ipv6/sit.c:1076)
[895.937147][T23587] dev_hard_start_xmit 
(./include/linux/netdevice.h:5161 net/core/dev.c:3800 net/core/dev.c:3816)
[895.937996][T23587] __dev_queue_xmit (net/core/dev.h:320 
net/core/dev.c:4653)
[895.945680][T23587] neigh_connected_output 
(./include/linux/netdevice.h:3313 net/core/neighbour.c:1543)
[895.946570][T23587] ip_finish_output2 (./include/net/neighbour.h:539 
net/ipv4/ip_output.c:236)
[895.948304][T23587] __ip_finish_output (net/ipv4/ip_output.c:314 
net/ipv4/ip_output.c:296)
[895.949152][T23587] ip_finish_output (net/ipv4/ip_output.c:324)
[895.949945][T23587] ip_mc_output (./include/linux/netfilter.h:303 
net/ipv4/ip_output.c:421)
[895.951538][T23587] ip_send_skb (./include/net/dst.h:459 
./include/net/dst.h:457 net/ipv4/ip_output.c:130 net/ipv4/ip_output.c:1502)
[895.952279][T23587] udp_send_skb (net/ipv4/udp.c:1197)
[895.953048][T23587] udp_sendmsg (net/ipv4/udp.c:1484)
[895.962452][T23587] udpv6_sendmsg (net/ipv6/udp.c:1545 (discriminator 1))
[895.976909][T23587] inet6_sendmsg (net/ipv6/af_inet6.c:659 
(discriminator 4))
[895.978530][T23587] ____sys_sendmsg (net/socket.c:718 net/socket.c:733 
net/socket.c:2573)
[895.982832][T23587] ___sys_sendmsg (net/socket.c:2629)
[895.988814][T23587] __sys_sendmmsg (net/socket.c:2719)
[895.994530][T23587] __x64_sys_sendmmsg (net/socket.c:2740)
[895.996217][T23587] do_syscall_64 (arch/x86/entry/common.c:52 
arch/x86/entry/common.c:83)
[895.996965][T23587] entry_SYSCALL_64_after_hwframe 
(arch/x86/entry/entry_64.S:130)
[  895.997937][T23587] RIP: 0033:0x44a19d
[ 895.998581][T23587] Code: c3 e8 37 1f 00 00 0f 1f 80 00 00 00 00 f3 0f 
1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
[  896.001683][T23587] RSP: 002b:00007fffc1b01a88 EFLAGS: 00000216 
ORIG_RAX: 0000000000000133
[  896.003032][T23587] RAX: ffffffffffffffda RBX: 0000000020000014 RCX: 
000000000044a19d
[  896.004311][T23587] RDX: 0000000000000001 RSI: 00000000200017c0 RDI: 
0000000000000003
[  896.005595][T23587] RBP: 00007fffc1b01ab0 R08: 0000000000000000 R09: 
0000000000000000
[  896.006891][T23587] R10: 0000000000000000 R11: 0000000000000216 R12: 
0000000000000001
[  896.008164][T23587] R13: 00007fffc1b01cf8 R14: 00000000004c4710 R15: 
0000000000000001
[  896.009454][T23587]  </TASK>
[  896.009969][T23587] Modules linked in:
[  896.010664][T23587] ---[ end trace 0000000000000000 ]---



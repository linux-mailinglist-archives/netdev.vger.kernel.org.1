Return-Path: <netdev+bounces-128121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C24978175
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 15:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8E41B213E6
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 13:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD58B1DC041;
	Fri, 13 Sep 2024 13:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="NbE6FoEO"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CCB1DB944;
	Fri, 13 Sep 2024 13:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235233; cv=none; b=O1KBvnPhWzr8J4DfSPtZKLBVrOh+d3F8UdG8NHnLAnNYUfYe2YAuHZ6X53Bvy6IxrlJOeleRPrIyyIFr//+G/kJe/lEfR8rumtZocF7EgLf/C53h/UMShQypG+2HrGpxYoNHipr+NJ8z0c18m6fZXX3kZSGGOXBtwuf340/46w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235233; c=relaxed/simple;
	bh=gSKF73ELRYiPVfunTe9d06F2jJrVWK3PzdtJcZYhfkc=;
	h=Message-ID:Date:MIME-Version:To:References:From:Subject:
	 In-Reply-To:Content-Type; b=Gr7RftJXgxgbNTuLvKebviCnkMfPSmcj6uh/Mapw9B9b7OuT/pu4U7v49Bmqx0l5o2aJ0lWp+MqawsBDaY2+7lg2MqRSp+RYcwRbcHyhWoRCl3oKiZ8Gmu9EtzK0xIYvr6QsKt2VT3Rr5wynDIN+NsKFYzc/Qgb0cTU9FdlSHPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=NbE6FoEO; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from [IPV6:2a02:8010:6359:2:fd3b:359b:7b1f:f7be] (unknown [IPv6:2a02:8010:6359:2:fd3b:359b:7b1f:f7be])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id D133C7D0D4;
	Fri, 13 Sep 2024 14:39:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1726234742; bh=gSKF73ELRYiPVfunTe9d06F2jJrVWK3PzdtJcZYhfkc=;
	h=Message-ID:Date:MIME-Version:To:References:From:Subject:
	 In-Reply-To:From;
	z=Message-ID:=20<237e9f5f-4605-8873-2260-c7e5ddac9795@katalix.com>|
	 Date:=20Fri,=2013=20Sep=202024=2014:39:01=20+0100|MIME-Version:=20
	 1.0|To:=20syzbot=20<syzbot+332fe1e67018625f63c9@syzkaller.appspotm
	 ail.com>,=0D=0A=20davem@davemloft.net,=20edumazet@google.com,=20ku
	 ba@kernel.org,=0D=0A=20linux-kernel@vger.kernel.org,=20netdev@vger
	 .kernel.org,=20pabeni@redhat.com,=0D=0A=20syzkaller-bugs@googlegro
	 ups.com|References:=20<0000000000005423e30621f745ff@google.com>|Fr
	 om:=20James=20Chapman=20<jchapman@katalix.com>|Subject:=20Re:=20[s
	 yzbot]=20[net?]=20WARNING=20in=20l2tp_exit_net|In-Reply-To:=20<000
	 0000000005423e30621f745ff@google.com>;
	b=NbE6FoEOhDTedLLrdww0gCtBB1iYleifysjr0BpqyO8xqOyO7EgMsBNJYDjhgJW+k
	 jH7b5Wp4LhZNQ1pEyEijwaR7E/49d5EW3p4SDqx4YJpNC70/ydouuprPXIfhepaHVE
	 rueSLmmMHP0dBWqoGGFTMToLIDDNnre/9j2Sxi8nNwUqX6m9Xn3Pfj9U/yD/fL0tug
	 gJwKAlTTiQ2KNaKGNwV/wNr70W2AY/I/5CHyzhwwIxOORUhBE24yHzFRNb4f0sI2gS
	 J8MLSafSyeM0i1QhDA/inR3wYbKW+Bw4gpKbXfQ1Dav7ZPIlunKiKzMGZbmlEO/+UN
	 lRDh181ACPmMw==
Message-ID: <237e9f5f-4605-8873-2260-c7e5ddac9795@katalix.com>
Date: Fri, 13 Sep 2024 14:39:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: syzbot <syzbot+332fe1e67018625f63c9@syzkaller.appspotmail.com>,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com
References: <0000000000005423e30621f745ff@google.com>
From: James Chapman <jchapman@katalix.com>
Organization: Katalix Systems Ltd
Subject: Re: [syzbot] [net?] WARNING in l2tp_exit_net
In-Reply-To: <0000000000005423e30621f745ff@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/09/2024 03:49, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f3b6129b7d25 Merge branch '100GbE' of git://git.kernel.org..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=144ba477980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=37742f4fda0d1b09
> dashboard link: https://syzkaller.appspot.com/bug?extid=332fe1e67018625f63c9
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/a742e7b2e0d2/disk-f3b6129b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/6982186745fb/vmlinux-f3b6129b.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/5fd38b217bb5/bzImage-f3b6129b.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+332fe1e67018625f63c9@syzkaller.appspotmail.com
> 
> bond0 (unregistering): (slave dummy0): Releasing backup interface
> bond0 (unregistering): Released all slaves
> tipc: Disabling bearer <eth:batadv0>
> tipc: Disabling bearer <udp:syz0>
> tipc: Left network mode
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 17026 at net/l2tp/l2tp_core.c:1881 l2tp_exit_net+0x165/0x170 net/l2tp/l2tp_core.c:1881
> Modules linked in:
> CPU: 0 UID: 0 PID: 17026 Comm: kworker/u8:36 Not tainted 6.11.0-rc6-syzkaller-01324-gf3b6129b7d25 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
> Workqueue: netns cleanup_net
> RIP: 0010:l2tp_exit_net+0x165/0x170 net/l2tp/l2tp_core.c:1881
> Code: 0f 0b 90 e9 3b ff ff ff e8 48 a4 b0 f6 eb 05 e8 41 a4 b0 f6 90 0f 0b 90 e9 7a ff ff ff e8 33 a4 b0 f6 eb 05 e8 2c a4 b0 f6 90 <0f> 0b 90 eb b5 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90
> RSP: 0018:ffffc9000ae07a98 EFLAGS: 00010293
> RAX: ffffffff8ae2e87d RBX: ffff8880797c0888 RCX: ffff88806dbbda00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
> RBP: ffffc9000ae07bb0 R08: ffffffff8bb2ce16 R09: 1ffffffff2031025
> R10: dffffc0000000000 R11: fffffbfff2031026 R12: dffffc0000000000
> R13: 1ffffffff1fd274c R14: ffff8880797c0930 R15: ffff8880797c0840
> FS:  0000000000000000(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000110c3831d6 CR3: 000000000e734000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   ops_exit_list net/core/net_namespace.c:173 [inline]
>   cleanup_net+0x802/0xcc0 net/core/net_namespace.c:626
>   process_one_work kernel/workqueue.c:3231 [inline]
>   process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
>   worker_thread+0x86d/0xd10 kernel/workqueue.c:3389
>   kthread+0x2f0/0x390 kernel/kthread.c:389
>   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>   </TASK>

This warning is l2tp checking that there are no l2tp tunnels left when 
l2tp_exit_net is called and finding one or more tunnels still in its IDR 
list. These should be removed by l2tp_pre_exit_net.

I'll review l2tp code and watch this one.

> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 



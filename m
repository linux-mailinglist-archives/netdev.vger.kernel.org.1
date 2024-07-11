Return-Path: <netdev+bounces-110943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3115F92F117
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 23:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A435C1F243BA
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 21:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357D819FA76;
	Thu, 11 Jul 2024 21:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="T2jsrTox";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dum0/7Vy"
X-Original-To: netdev@vger.kernel.org
Received: from flow5-smtp.messagingengine.com (flow5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A5719FA75;
	Thu, 11 Jul 2024 21:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720733107; cv=none; b=I0YpYtqLzevAq3vjVrZp7rbY345e65jjz4ShNjJ84LX6FXKaJIonPT9yd/FOQ3zXTRptl9gTbI9rpnwrrPQqS1Wo0XcJQB7VuOiwMddAE20HqkcxpMz1pFGz0RS5ec4g8wTDv1yCB4UTQuzGKaCkIRvIcIVOmLx8qoVyKf+333U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720733107; c=relaxed/simple;
	bh=q4DMDtgxnaMKya2B5COrAXU4vhMI8Y9ctICHpEBql/U=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=T6kETtZLVr8pUTQgL2H42Jz0eJjYJbTTh8ODnblTvUfM5jSTpXFqGL/fsfWEVywe2SOUBfIoJZWGFihu1i0OWQ+x2ew+hGHMURmK7nBGPYhRnyzwPm4lp0kZid8yAlyh7LSzT1vj3+5cJOiiUvRVzk5P1KNMckBYweaAMGB/9YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=T2jsrTox; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dum0/7Vy; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailflow.nyi.internal (Postfix) with ESMTP id D389B2005A1;
	Thu, 11 Jul 2024 17:25:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 11 Jul 2024 17:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1720733103; x=1720736703; bh=hdzJ8Pkwo3tJQEsQyK14g
	YhBNw6itvSs5iBgAbRbu9I=; b=T2jsrToxk2pzCQyWAC8PeqKCoLm5Lbe4qWdl3
	hxGcWP+DkVcJPVBgEaqYMYA8guMkjfu/CztMjTjUMfccc+aMuZYEi5/m5eiBQt0c
	5l+O8yfB6uIkHdT+9ux6lA+vxvx/kjps8tqeYG46NOeBCfDMhLXavVdV0BMWntp+
	XBETuB/p8sdbet3J9JyCpfA2JB3G2Bvee0HLmopzRWekFd9u+IpEMwc53hjcXKia
	nO1ssTyjO3GfUdsDA5WLBGevomqVTw2meaws3bqoFVEdvK9V+fj3N9sMGp2gC10u
	xwfg6yR7PeuBtyjnetwiTo4XQsXE07F1RXKTV1L13gR2pAkVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720733103; x=1720736703; bh=hdzJ8Pkwo3tJQEsQyK14gYhBNw6i
	tvSs5iBgAbRbu9I=; b=dum0/7VyEDZ+L19v+92g6iggv0XePfLMGuqybFDxN8kd
	NNHttAlw543PafDO56KjsO09c+h5gx9OkbH+mpWwcKZvQScZlBXZQoDLowqOsXjk
	mW2BM3V/blZ6atWvwJoL9ThaW4I2zGgl+p0Gh54ArDSPYh3q3Q4t4A686o7tWIqU
	J5f8+HP62BdGlt6VAcvBEKy/eF42mO/LjEMhonpFyy6VVUq1n8ZqhWT9ZMM6fq78
	Z5RvsjwWGJO8yrqJT8+oi65m/V5ES931fSE+n5At+Pkr13y/jmjNBJ4WKwk1OFjr
	/0GlnxugDYqwqrrJdWzqSK5ulVIk2KA44d46l4TfJQ==
X-ME-Sender: <xms:rk2QZtGJYCeBaFag3yuI_ykPMpgYsfbCCC3gVNYS4jRwCPy7BstRDQ>
    <xme:rk2QZiWQjhKFV-dLLnjvwOBEisOdLJ4pR8NrIOGODqWWSJrbMRqPfUPTTpZKgJvd-
    PV8FFSD-k9exUeJ76s>
X-ME-Received: <xmr:rk2QZvL1sOuU_jgK_KCa5XmRuC3eX739oddxpNNLU_Z9ntcNpHqTd-eN6qUNt7eATefyiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeeggdduieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoufhushhpvggtthffohhmrghinhculdegledmne
    cujfgurhephffvvefujghfofggtgfgfffksehtqhertdertddvnecuhfhrohhmpeflrgih
    ucggohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrth
    htvghrnhepkeetfeduhfehhfegteeukedtjeeiheeijedugefhvddufffggfejffevtdfh
    gfelnecuffhomhgrihhnpehshiiikhgrlhhlvghrrdgrphhpshhpohhtrdgtohhmpdhgoh
    hoghhlvggrphhishdrtghomhdpghhoohdrghhlnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepjhhvsehjvhhoshgsuhhrghhhrdhnvght
X-ME-Proxy: <xmx:rk2QZjGQSzMx2y5B85-ndiXpjHAQL2g02biqGJLVnl-cTmkgnpzVgA>
    <xmx:rk2QZjUvKGIXqP65s4ubxqonQhR7ZVnxR7QmR4gBV_qLifJYjRZCQw>
    <xmx:rk2QZuNTSOFlfMj82pjtdb9DMIej_hIsnobQK9ruWVHzaeU-S3_P4g>
    <xmx:rk2QZi07C4lMzjSf_iET0AaR49gMw3aA2Ex9rLAdQLZImmBOtNH42g>
    <xmx:r02QZgVtHw2m3cwxWYH_JbdgYY7qaYdzG3_cUgKhcrsxBsUQIx6VIRfd>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jul 2024 17:25:02 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 0F4449FC9C; Thu, 11 Jul 2024 14:25:01 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 0C4429FC99;
	Thu, 11 Jul 2024 14:25:01 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: syzbot <syzbot+9b277e2c2076e2661f61@syzkaller.appspotmail.com>
cc: davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com,
    jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org,
    netdev@vger.kernel.org, pabeni@redhat.com,
    syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Subject: Re: [syzbot] [net?] BUG: sleeping function called from invalid
 context in synchronize_net
In-reply-to: <000000000000eb54bf061cfd666a@google.com>
References: <000000000000eb54bf061cfd666a@google.com>
Comments: In-reply-to syzbot
 <syzbot+9b277e2c2076e2661f61@syzkaller.appspotmail.com>
   message dated "Thu, 11 Jul 2024 12:02:19 -0700."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2144727.1720733101.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jul 2024 14:25:01 -0700
Message-ID: <2144728.1720733101@famine>

syzbot <syzbot+9b277e2c2076e2661f61@syzkaller.appspotmail.com> wrote:

>Hello,
>
>syzbot found the following issue on:
>
>HEAD commit:    523b23f0bee3 Add linux-next specific files for 20240710
>git tree:       linux-next
>console output: https://syzkaller.appspot.com/x/log.txt?x=3D10d88fb998000=
0
>kernel config:  https://syzkaller.appspot.com/x/.config?x=3D98dd8c4bab5cd=
ce
>dashboard link: https://syzkaller.appspot.com/bug?extid=3D9b277e2c2076e26=
61f61
>compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
>Unfortunately, I don't have any reproducer for this issue yet.

	Looking at the code, I'm pretty sure this can happen when:

	a) the bond is configured with use_carrier =3D 0; this causes
bonding to query ethtool to get carrier state.

	b) bond_mii_monitor runs while dev->link_watch_list is
non-empty, in this case with a pending link down transition.  In this
case, linkwatch_sync_dev (called by ethtool_op_get_link) will in turn
call linkwatch_do_dev -> dev_deactivate -> dev_deactivate_many ->
synchronize_net -> might_sleep.

	The use_carrier option was added 20-ish years ago for device
drivers that didn't do netif_carrier_on / _off at the time.

	I was about to say that I'd expect all drivers today to do
netif_carrier, but 1386c36b3038 ("bonding: allow carrier and link status
to determine link state") suggests that something needed it as recently
as 2018.

	-J

>Downloadable assets:
>disk image: https://storage.googleapis.com/syzbot-assets/345bcd25ed2f/dis=
k-523b23f0.raw.xz
>vmlinux: https://storage.googleapis.com/syzbot-assets/a4508962d345/vmlinu=
x-523b23f0.xz
>kernel image: https://storage.googleapis.com/syzbot-assets/4ba5eb555639/b=
zImage-523b23f0.xz
>
>IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
>Reported-by: syzbot+9b277e2c2076e2661f61@syzkaller.appspotmail.com
>
>BUG: sleeping function called from invalid context at net/core/dev.c:1123=
9
>in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 12, name: kworker/=
u8:1
>preempt_count: 0, expected: 0
>RCU nest depth: 1, expected: 0
>INFO: lockdep is turned off.
>CPU: 1 UID: 0 PID: 12 Comm: kworker/u8:1 Not tainted 6.10.0-rc7-next-2024=
0710-syzkaller #0
>Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 06/07/2024
>Workqueue: bond0 bond_mii_monitor
>Call Trace:
> <TASK>
> __dump_stack lib/dump_stack.c:94 [inline]
> dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
> __might_resched+0x5d4/0x780 kernel/sched/core.c:8526
> synchronize_net+0x1b/0x50 net/core/dev.c:11239
> dev_deactivate_many+0x4a7/0xb10 net/sched/sch_generic.c:1371
> dev_deactivate+0x184/0x280 net/sched/sch_generic.c:1397
> linkwatch_do_dev+0x10a/0x170 net/core/link_watch.c:175
> ethtool_op_get_link+0x15/0x60 net/ethtool/ioctl.c:62
> bond_check_dev_link+0x1f1/0x3f0 drivers/net/bonding/bond_main.c:757
> bond_miimon_inspect drivers/net/bonding/bond_main.c:2604 [inline]
> bond_mii_monitor+0x49a/0x3170 drivers/net/bonding/bond_main.c:2826
> process_one_work kernel/workqueue.c:3228 [inline]
> process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3309
> worker_thread+0x86d/0xd40 kernel/workqueue.c:3387
> kthread+0x2f0/0x390 kernel/kthread.c:389
> ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> </TASK>
>------------[ cut here ]------------
>Voluntary context switch within RCU read-side critical section!
>WARNING: CPU: 1 PID: 12 at kernel/rcu/tree_plugin.h:330 rcu_note_context_=
switch+0xcf4/0xff0 kernel/rcu/tree_plugin.h:330
>Modules linked in:
>CPU: 1 UID: 0 PID: 12 Comm: kworker/u8:1 Tainted: G        W          6.1=
0.0-rc7-next-20240710-syzkaller #0
>Tainted: [W]=3DWARN
>Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 06/07/2024
>Workqueue: bond0 bond_mii_monitor
>RIP: 0010:rcu_note_context_switch+0xcf4/0xff0 kernel/rcu/tree_plugin.h:33=
0
>Code: 00 ba 02 00 00 00 e8 bb 02 fe ff 4c 8b b4 24 80 00 00 00 eb 91 c6 0=
5 a4 4f 1f 0e 01 90 48 c7 c7 e0 2d cc 8b e8 ad c5 da ff 90 <0f> 0b 90 90 e=
9 3b f4 ff ff 90 0f 0b 90 45 84 ed 0f 84 00 f4 ff ff
>RSP: 0018:ffffc90000116f00 EFLAGS: 00010046
>RAX: b02efd3a29e78a00 RBX: ffff8880172cde44 RCX: ffff8880172cda00
>RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>RBP: ffffc90000117050 R08: ffffffff815583f2 R09: fffffbfff1c39f8c
>R10: dffffc0000000000 R11: fffffbfff1c39f8c R12: ffff8880172cda00
>R13: 0000000000000000 R14: 1ffff92000022df8 R15: dffffc0000000000
>FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000=
000
>CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>CR2: 000000110c444d58 CR3: 000000006ca0e000 CR4: 00000000003506f0
>DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>Call Trace:
> <TASK>
> __schedule+0x348/0x4a60 kernel/sched/core.c:6491
> __schedule_loop kernel/sched/core.c:6680 [inline]
> schedule+0x14b/0x320 kernel/sched/core.c:6695
> schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6752
> __mutex_lock_common kernel/locking/mutex.c:684 [inline]
> __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
> exp_funnel_lock kernel/rcu/tree_exp.h:329 [inline]
> synchronize_rcu_expedited+0x451/0x830 kernel/rcu/tree_exp.h:967
> synchronize_rcu+0x11b/0x360 kernel/rcu/tree.c:4020
> dev_deactivate_many+0x4a7/0xb10 net/sched/sch_generic.c:1371
> dev_deactivate+0x184/0x280 net/sched/sch_generic.c:1397
> linkwatch_do_dev+0x10a/0x170 net/core/link_watch.c:175
> ethtool_op_get_link+0x15/0x60 net/ethtool/ioctl.c:62
> bond_check_dev_link+0x1f1/0x3f0 drivers/net/bonding/bond_main.c:757
> bond_miimon_inspect drivers/net/bonding/bond_main.c:2604 [inline]
> bond_mii_monitor+0x49a/0x3170 drivers/net/bonding/bond_main.c:2826
> process_one_work kernel/workqueue.c:3228 [inline]
> process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3309
> worker_thread+0x86d/0xd40 kernel/workqueue.c:3387
> kthread+0x2f0/0x390 kernel/kthread.c:389
> ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> </TASK>
>
>
>---
>This report is generated by a bot. It may contain errors.
>See https://goo.gl/tpsmEJ for more information about syzbot.
>syzbot engineers can be reached at syzkaller@googlegroups.com.
>
>syzbot will keep track of this issue. See:
>https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
>If the report is already addressed, let syzbot know by replying with:
>#syz fix: exact-commit-title
>
>If you want to overwrite report's subsystems, reply with:
>#syz set subsystems: new-subsystem
>(See the list of subsystem names on the web dashboard)
>
>If the report is a duplicate of another one, reply with:
>#syz dup: exact-subject-of-another-report
>
>If you want to undo deduplication, reply with:
>#syz undup
>

---
	-Jay Vosburgh, jv@jvosburgh.net


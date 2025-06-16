Return-Path: <netdev+bounces-198143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CE6ADB629
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 18:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76D8A3A7073
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 16:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F63216E26;
	Mon, 16 Jun 2025 16:07:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AB22853E5
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 16:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750090025; cv=none; b=EXWIdu5dfi5KZBbiYnRiZenLQtus3CPddaX6MR5CtHVjyCawIc7IlxfKqZJvoLOJefy/RLnciVZXXchxNBSCW//kUA3420mq0hhLN+0HkpBm2n1riE9Qi1fWKj5MGKsWrv7NIL7Iw/erLQ6AYHqzWe4i9O8ZJn4MaLldFYrAlIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750090025; c=relaxed/simple;
	bh=ods/arTWG7zZ2uno2X+VmD8n9DuNm4lm7lNPDCPVQEM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sX70ny/bf19ZWs6t+0OmcHsybEPpReyUF6xmvNlVoxMyDFwWPe2B6M/QwQPCJ2doyQEZgoCW7vggrrZBZjLm3SF7UWW4/mTjemPdElxfTSIvx1NRUNrGRGCAuHLNSDYu1Np2IrqAHta+xxoIfltBP317sBEQeoTyEddLglVe7VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8730ca8143eso539535639f.0
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 09:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750090022; x=1750694822;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oyrMjgYCMoTHaFVZEjrnp+WPauvIoz+a+6ANv4xt5JQ=;
        b=Rc5Oo5wWbxvXkbUSg+yLeroQgzft2TmfnfEEnXOhYWCtK1pUiCAJK7pxG+itP9HRvv
         9sI/rpR1LIJZpQhJaXG0BZ9Dlyh/jvzqZRp9GEP0dYFCGE7PnWhXRbKwJorMdJEyKNCj
         BSHezyQzizFdR0sNU7MYwTX+5uj/ZyPzeyd9vGt1O9sDSimtw5WzQuq91dUNtD9NLt5E
         m+je8+aSMaQbBKPGe+nJfeQQrt1ehtjpuNSpRoFdewrXp5uY7p4FAqvIfAzuyEBbs2vS
         dzEzOYTUDPNkgssGNcCMSV7UsxwQU57/8UyplwU6xF2IbBCe2o7lmUsfdGhWp4N4IK7u
         GmDA==
X-Forwarded-Encrypted: i=1; AJvYcCWOW+5WtyVgq4dSM8hv3VJtXz9JQ2b2Ff0sXR7VtCVUMaGaqkR1wsn251D3klaZjKDvT84IAZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyAMpdJh/WQe6mdqLC3yaHCRdGaWLNPyZJuBjgKn2Akic+1m2V
	0JZRBF36kFibZ/sOQBFoRaYlFcfgckEubyOL1DbcgngB0V35W2ocjtH9v5dc876aEp4wrOrrYTj
	DSouhd5Vo05HT962VuzrtQp/wDBjfEGeN+L3uOVOzmw/f/PVJ55y0+sRxKuE=
X-Google-Smtp-Source: AGHT+IGmzmhbQ10jKNMeBAYJc+boB0tO/bcvbxwh5R9+sXakm1D6YTGCMbDL0izvDKBz7Z1D9WlTUL0k4yqTud7rdk241oGDatiK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2787:b0:3dc:7b3d:6a45 with SMTP id
 e9e14a558f8ab-3de07a9c6a0mr103005305ab.0.1750090022305; Mon, 16 Jun 2025
 09:07:02 -0700 (PDT)
Date: Mon, 16 Jun 2025 09:07:02 -0700
In-Reply-To: <aFA-NpGpVF77Fyer@mini-arch>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68504126.a70a0220.395abc.01e4.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in __linkwatch_sync_dev (2)
From: syzbot <syzbot+b8c48ea38ca27d150063@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, stfomichev@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: suspicious RCU usage in bond_mii_monitor

=============================
WARNING: suspicious RCU usage
6.16.0-rc2-syzkaller-ge04c78d86a96-dirty #0 Not tainted
-----------------------------
drivers/net/bonding/bond_main.c:2736 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
3 locks held by kworker/u32:0/12:
 #0: ffff888044cc7948 ((wq_completion)bond0#2){+.+.}-{0:0}, at: process_one_work+0x12a2/0x1b70 kernel/workqueue.c:3213
 #1: ffffc900000f7d10 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_one_work+0x929/0x1b70 kernel/workqueue.c:3214
 #2: ffffffff9034d128 (rtnl_mutex){+.+.}-{4:4}, at: bond_mii_monitor+0x122/0x2a20 drivers/net/bonding/bond_main.c:2966

stack backtrace:
CPU: 2 UID: 0 PID: 12 Comm: kworker/u32:0 Not tainted 6.16.0-rc2-syzkaller-ge04c78d86a96-dirty #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: bond0 bond_mii_monitor
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x166/0x260 kernel/locking/lockdep.c:6871
 bond_miimon_inspect drivers/net/bonding/bond_main.c:2736 [inline]
 bond_mii_monitor+0xab6/0x2a20 drivers/net/bonding/bond_main.c:2973
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x5d7/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: now running without any active interface!
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): link status definitely up, 10000 Mbps full duplex
bond0: (slave bond_slave_1): link status definitely up, 10000 Mbps full duplex
bond0: active interface up!
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): link status definitely up, 10000 Mbps full duplex
bond0: (slave bond_slave_1): link status definitely up, 10000 Mbps full duplex
bond0: active interface up!
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): link status definitely up, 10000 Mbps full duplex
bond0: (slave bond_slave_1): link status definitely up, 10000 Mbps full duplex
bond0: active interface up!
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: now running without any active interface!
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: now running without any active interface!
bond0: (slave bond_slave_0): link status definitely up, 10000 Mbps full duplex
bond0: (slave bond_slave_1): link status definitely up, 10000 Mbps full duplex
bond0: active interface up!
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: now running without any active interface!
bond0: (slave bond_slave_0): link status definitely up, 10000 Mbps full duplex
bond0: (slave bond_slave_1): link status definitely up, 10000 Mbps full duplex
bond0: active interface up!
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: now running without any active interface!
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down
bond0: (slave bond_slave_0): link status definitely up, 10000 Mbps full duplex
bond0: (slave bond_slave_1): link status definitely up, 10000 Mbps full duplex
bond0: active interface up!
bond0: (slave bond_slave_0): interface is now down
bond0: (slave bond_slave_1): interface is now down


Tested on:

commit:         e04c78d8 Linux 6.16-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1321e90c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4130f4d8a06c3e71
dashboard link: https://syzkaller.appspot.com/bug?extid=b8c48ea38ca27d150063
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1423490c580000



Return-Path: <netdev+bounces-198140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB74ADB5F4
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 17:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88B277A4D29
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 15:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39ADA283121;
	Mon, 16 Jun 2025 15:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRw0JrJ0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB98278E79;
	Mon, 16 Jun 2025 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750089274; cv=none; b=WcYDc4l7oTQuu49qk7caVWpfeSvagy3h0ZSrjx+dBVWv4ey0ztIr+Al/gUy5wXG4Z3ZrhFZ1Khb6egzbXl7ii9PKtMScjHSQ3260QT8IzJjOOBaplxTWEwVlBtMEAePgRkfZ4S44dvFYRsGlNK8i3EIZFCZDXzFvwYpFOcZW464=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750089274; c=relaxed/simple;
	bh=q3ERfAh5Wy+Y9yDxFKPCc6BxDJQn6ZQJ6Ti16SPnhbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqbRpayHuWPpwdMP4msHPnUcVfPogepjqS5XHsBPBfJPnc7SLVoepNimgO3FjUIdOLyh0xQfB5/Ry6gayxVOgwkSAi6YALZ6yiiIWFZF5jmimSwRYZIANaUqHTiug+SDh+KqJsqLbUKrTTZ/gPQ+MtLB1tSS/zFlkLr2YwnnMjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRw0JrJ0; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-747abb3cd0bso4241096b3a.1;
        Mon, 16 Jun 2025 08:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750089272; x=1750694072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DsotLJ0Tq8v8Qep/9/uIKbgNsK/CVWAdf4TKiG2Z1Fk=;
        b=KRw0JrJ0/VObyXEPKszSsBwQ4E61OOAsrC5AadQ7oLl+nvELFJRjGjxoWcEgixCJ6w
         eG459Rrb6NUY5YkoPhzXYCvX7bKvBNWLq3aT1PVJfjibSv98Bj6/Nt/Plrb2GW2J+6DP
         mi1UrO701BfF/ym2BOv0i+L1M14qwLoMDwnnEU21L1r/+eipvMWyA4E3NKDYKvFjYeLN
         NWU4mXRTbb8WsmoFJi1rW/ID6S/PNny/scP/J/PInMimOhToDkEfVSe7On4ajC81mDF7
         xObeLRa9YJpZO9vklPMQlIi/PT0QpnYlONRsX+y2x8L7NP4Y2Z2/GIRExNLJjhz6GPL7
         bZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750089272; x=1750694072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DsotLJ0Tq8v8Qep/9/uIKbgNsK/CVWAdf4TKiG2Z1Fk=;
        b=kwzNEqlRvnh9HrPmnCEM1nRbtQxTZBtUXMtXsDM/oliYHfWJxCTc2Av7wkZ8ZcKwbq
         /oKz5ciRgPUiGAj2zJZSOv4HZeZiP0j+u3GgcLNjNv0pbGywh8CUR9iBdIqxmQDs7gft
         8nMzPSD0Yc8HysXlPSbKow7azZIh/zigDMIPsgjvB1Wjev/jYZJhK7sOkWlb8eHXUnQ6
         JKZUxv4+NwebFLdiKKtnkyWqAU/ifQYjzj2xyvgpKef7e/ux8AVsDWcY50N9FtK8AXv2
         UtbgCg9AxeltlAb0WmmzfZBXAkPQUGol4NDOZUuZnBp9e/KjpebZfN3Px2lneVJRCJAL
         3w3g==
X-Forwarded-Encrypted: i=1; AJvYcCVL1qFM0dpA83SdzoviLib4mU/RvvZmF8mYyPTCQb2KojmHPloKmjqtGuwKLDfHPFuAcowVrUsf@vger.kernel.org, AJvYcCW3MjX0OTszdMADrndbDB6uYyz5r3gyrtlSksYt2EVq8LjYl8mK4h2o7xX4wV4FzsdYB7Q9/Z49mn0w6ig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb4kyJ845W8rFke7rZAPojBOhzQYr/9wIBYRt0pKkYx17H9Ftq
	4q4vhglSUkNs215iyxHK0hKLsfewB4Hu1jg0ZQpbmAStAE1HqI80OFU=
X-Gm-Gg: ASbGncvOgel79kQjWNYRftoo3Lqqvb2Nbumg3vJMhDhIsTaIehkTddGm8Sbf0J0hs+e
	c1qZIVHx3N5jo5S72O9KzXXsJelXQ+UcZ9g9gAwm452HWMF7GeluxtypeeM96c5Zibyd+15s6X2
	r7WzREvqPOsVtz59xcAPS7P3ddBccal8Gs7MJeogGEtr67eyXK6dTh5vRGthyO6v2KEwfKZse2K
	E80Ep+fvfezDgn3er7GS2AmA3yD3B2CAm7aqsNfcaIm1qwN9b0Y6y3a84MRbW43Cyb3yGtaFmoE
	X/nutkVsnBExsMz5Ygn1CQwonkbf3Sv55xa8inyRqvQM720UTsdnLy1XIqiOfxP3IFR7oZ78DVP
	LZzB5roQ637o/YcMPaLrst2k=
X-Google-Smtp-Source: AGHT+IGBbQO47U97OyA/s1rEzau9jZN7eao3Sz5Kjh41qnoM5N6war6gzRMxoRY7syzuVYnffzWGyA==
X-Received: by 2002:a05:6a00:4b01:b0:736:9f2e:1357 with SMTP id d2e1a72fcca58-7489c483195mr14293260b3a.12.1750089271703;
        Mon, 16 Jun 2025 08:54:31 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-748900d736bsm7234336b3a.176.2025.06.16.08.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 08:54:31 -0700 (PDT)
Date: Mon, 16 Jun 2025 08:54:30 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: syzbot <syzbot+b8c48ea38ca27d150063@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in __linkwatch_sync_dev (2)
Message-ID: <aFA-NpGpVF77Fyer@mini-arch>
References: <684a39aa.a00a0220.1eb5f5.00fa.GAE@google.com>
 <684c8a60.050a0220.be214.02a6.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <684c8a60.050a0220.be214.02a6.GAE@google.com>

On 06/13, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    27605c8c0f69 Merge tag 'net-6.16-rc2' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17bb9d70580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8e5a54165d499a9
> dashboard link: https://syzkaller.appspot.com/bug?extid=b8c48ea38ca27d150063
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a7b9d4580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1421310c580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-27605c8c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/ab939a8a93b4/vmlinux-27605c8c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e90d45016aac/bzImage-27605c8c.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b8c48ea38ca27d150063@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> RTNL: assertion failed at ./include/net/netdev_lock.h (72)
> WARNING: CPU: 2 PID: 60 at ./include/net/netdev_lock.h:72 netdev_ops_assert_locked include/net/netdev_lock.h:72 [inline]
> WARNING: CPU: 2 PID: 60 at ./include/net/netdev_lock.h:72 __linkwatch_sync_dev+0x1ed/0x230 net/core/link_watch.c:279
> Modules linked in:
> CPU: 2 UID: 0 PID: 60 Comm: kworker/u32:3 Not tainted 6.16.0-rc1-syzkaller-00101-g27605c8c0f69 #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Workqueue: bond0 bond_mii_monitor
> RIP: 0010:netdev_ops_assert_locked include/net/netdev_lock.h:72 [inline]
> RIP: 0010:__linkwatch_sync_dev+0x1ed/0x230 net/core/link_watch.c:279
> Code: 05 ff ff ff e8 94 b6 59 f8 c6 05 e9 0f 2e 07 01 90 ba 48 00 00 00 48 c7 c6 c0 8c e3 8c 48 c7 c7 60 8c e3 8c e8 94 7b 18 f8 90 <0f> 0b 90 90 e9 d6 fe ff ff 48 c7 c7 44 3b a8 90 e8 ae 86 c0 f8 e9
> RSP: 0018:ffffc90000ce79f0 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: ffff8880363a2000 RCX: ffffffff817ae368
> RDX: ffff888022148000 RSI: ffffffff817ae375 RDI: 0000000000000001
> RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000001 R12: 1ffff9200019cf48
> R13: ffff8880363a2cc5 R14: ffffffff8c5909c0 R15: ffffffff899ba310
> FS:  0000000000000000(0000) GS:ffff8880d6954000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffd4122af9c CR3: 000000000e382000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  ethtool_op_get_link+0x1d/0x70 net/ethtool/ioctl.c:63
>  bond_check_dev_link+0x3f9/0x710 drivers/net/bonding/bond_main.c:863
>  bond_miimon_inspect drivers/net/bonding/bond_main.c:2745 [inline]
>  bond_mii_monitor+0x3c0/0x2dc0 drivers/net/bonding/bond_main.c:2967
>  process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
>  process_scheduled_works kernel/workqueue.c:3321 [inline]
>  worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
>  kthread+0x3c5/0x780 kernel/kthread.c:464
>  ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> 
> 
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

#syz test

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index c4d53e8e7c15..e2c4bcdb8b1a 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2739,7 +2739,7 @@ static int bond_miimon_inspect(struct bonding *bond)
 			ignore_updelay = true;
 	}
 
-	bond_for_each_slave_rcu(bond, slave, iter) {
+	bond_for_each_slave(bond, slave, iter) {
 		bond_propose_link_state(slave, BOND_LINK_NOCHANGE);
 
 		link_state = bond_check_dev_link(bond, slave->dev, 0);
@@ -2962,35 +2962,28 @@ static void bond_mii_monitor(struct work_struct *work)
 	if (!bond_has_slaves(bond))
 		goto re_arm;
 
-	rcu_read_lock();
+	/* Race avoidance with bond_close cancel of workqueue */
+	if (!rtnl_trylock()) {
+		delay = 1;
+		should_notify_peers = false;
+		goto re_arm;
+	}
+
 	should_notify_peers = bond_should_notify_peers(bond);
 	commit = !!bond_miimon_inspect(bond);
 	if (bond->send_peer_notif) {
-		rcu_read_unlock();
-		if (rtnl_trylock()) {
-			bond->send_peer_notif--;
-			rtnl_unlock();
-		}
-	} else {
-		rcu_read_unlock();
+		bond->send_peer_notif--;
 	}
 
 	if (commit) {
-		/* Race avoidance with bond_close cancel of workqueue */
-		if (!rtnl_trylock()) {
-			delay = 1;
-			should_notify_peers = false;
-			goto re_arm;
-		}
-
 		bond_for_each_slave(bond, slave, iter) {
 			bond_commit_link_state(slave, BOND_SLAVE_NOTIFY_LATER);
 		}
 		bond_miimon_commit(bond);
-
-		rtnl_unlock();	/* might sleep, hold no other locks */
 	}
 
+	rtnl_unlock();	/* might sleep, hold no other locks */
+
 re_arm:
 	if (bond->params.miimon)
 		queue_delayed_work(bond->wq, &bond->mii_work, delay);



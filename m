Return-Path: <netdev+bounces-197280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38168AD7FF9
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 03:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE26717D964
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 01:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199E21C84CF;
	Fri, 13 Jun 2025 01:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJXz4Zlc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F03B1B85F8;
	Fri, 13 Jun 2025 01:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749776946; cv=none; b=eASym4DzDfq7AMSM/WsCZf9gOV9Q5d6n+tpEJPMaeqPE5O/hsGi8oXml/A90540nSVvDvx6IBupFUdAXhTus9Gc4x7QpPXSRwdnJnufGMzTZ989le3E3V1eB26B/4hSKYgNkZY0g2gz+CGKE/HwmXH25REn/wjUowtXGAhXly+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749776946; c=relaxed/simple;
	bh=CL39Y09tldOkduTJUv/yrhpBrW/GAFEW2x6aGEDtDeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3ZC4fjgusoWbW2dOmZVdUceyloSwwPjQ8OzXBXIOyq3jRncW1zV86Hg+CCQ44wkiyn1G0xbahHHJu1BsjBPA0nUuFf6UWYwpZzHVZiOdwalLY/lBP2aCdWebblm8q7Itbk1dpp4MNCvKg45vPpYDeIOv6V9C8vdl7zVS2nM+i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJXz4Zlc; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23636167afeso16037285ad.3;
        Thu, 12 Jun 2025 18:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749776944; x=1750381744; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7mnOu8GOPvWlaCL2dD/0DCQC4xT6FxohHBJt4LsaZV4=;
        b=DJXz4ZlcAGFapd/Oo9mi09s6UJosYYe+cQ4uP7mhcQKPzD3uvHb1JO3bxkA6znGcEN
         3kznvbkHM0ULXia4OJldpeO6dACqQs0AAjEDlA6jZywucS7P+sqPVhx9zsAghNgJE91k
         CzNmpUB/0IMnZ2451WzzxYQglohNWpD9ksuisClEhD7UFCJHjn3r9TNHJ5hyAp0WlDzw
         T6Uzl2NYWEKdVchy+JK+6i/+7RL2Nwe8X6I/A0YrdxAwcWN5TVF0DD/idePKkWuPPTJ1
         U+bkXjjvktU/+cQyXmQe+SxjkQv/vGA471FBYzWYqnJ+wW5o4TiOh5vSYHHdGqhrsax1
         c7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749776944; x=1750381744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7mnOu8GOPvWlaCL2dD/0DCQC4xT6FxohHBJt4LsaZV4=;
        b=mqTrvaOF02YVusC3qpDrjGFLYNl92r/H/F5iL+fkGPR17LdS3lAdngR4jB+yc+DVxG
         YbqjEGu5qhF6eo6FJtek0spTKKvFRucMaVBdyA5gczCYfF+jwu6ZeMe+YVphVQmHjE2F
         m3omBEI36sWk363aGQV/2zORh1CmGoh/YCTDjrKFr5fWXpfDjd2QujaHoO+XF3rWtBbK
         HxtVqwEsmWaOKHB5ORAKXpfV7Ma7J1KtdyROZNRqNMfTLUFzV/uMBuBMddB6JEazn7wr
         8pX7OWOsa6vpFz8rUOxOeK3sNr2pc7Rrrs7t+7fUZm4j7MF3+nyQRozgkxl6bkChGn7E
         3CLw==
X-Forwarded-Encrypted: i=1; AJvYcCVxUCNN5MTC1lbTf80CtCZCxOzNyb0IgyyhF3PvAQEnde3DgbOC/1wcXuvAV1Y4nzjau3RjR64rRuW/mtA=@vger.kernel.org, AJvYcCXi5xzc3LtFmAkPeapN/IsSOs46CX6xfk2LPfvZSkxCYMJAgQcu+yma3NdkHrulMZTnGChxB6mL@vger.kernel.org
X-Gm-Message-State: AOJu0YzgTCpNfO/VqbVzy9prjZEWSAj8Kp4umyt1vO+/Sns1oDndDpAd
	YEUzv/d/+VxTYLebt6WJqBLmqHxSi0g7sBjgrfUavCOZcWk8lh0BuX8=
X-Gm-Gg: ASbGncsS806Et5HEeDbbYqmBDlAXD/Lra4w+5Zr1wG98OqvzeXpfKBLzinojzkyP6/9
	jhfO6qAy7VEQinpHbg7EUI7XksVyGBTjICXrmw68JkGL0V9UPI/DRqDPPiCJLe3KQxBpAznB7HM
	4mBHmtLnzd6aNQAOhgVl64vLbZH/xbUiloF5a0PzEVpVV1UQDu+/gI55VYb9S0Symgmwr4S2okg
	DTIpsfuzli2oNE+g0dKLCLnd0Xo0p7Z2pQckndMjl1P4D2ntZnjNumA85qjaBSwG9LkMd6y8sC4
	uCSCQPiUI1gfmv+juY9kDsnHmyVujpnMQzxtmQ14Y+YM7LezNksoFyv3yaX9+vMCTIBLipW36DA
	CYYCSL3oSV1SAYLoMxFqMpxo=
X-Google-Smtp-Source: AGHT+IHfhYjnG1JC92HNzmOJaW/pwPNnCKvtr4rnnyIjEcYl38+QzCs6yW8OO/W9kWRl/yi3CQHbtg==
X-Received: by 2002:a17:903:19c5:b0:235:be0:db6b with SMTP id d9443c01a7336-2365dd3f57emr15916205ad.45.1749776943504;
        Thu, 12 Jun 2025 18:09:03 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b2fe1691be9sm434862a12.68.2025.06.12.18.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 18:09:03 -0700 (PDT)
Date: Thu, 12 Jun 2025 18:09:02 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: syzbot <syzbot+b8c48ea38ca27d150063@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in __linkwatch_sync_dev (2)
Message-ID: <aEt6LvBMwUMxmUyx@mini-arch>
References: <684a39aa.a00a0220.1eb5f5.00fa.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <684a39aa.a00a0220.1eb5f5.00fa.GAE@google.com>

On 06/11, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f09079bd04a9 Merge tag 'powerpc-6.16-2' of git://git.kerne..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16e9260c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e24211089078d6c6
> dashboard link: https://syzkaller.appspot.com/bug?extid=b8c48ea38ca27d150063
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-f09079bd.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/ef68cb3d29a3/vmlinux-f09079bd.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/1cc9431b9a15/bzImage-f09079bd.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b8c48ea38ca27d150063@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> RTNL: assertion failed at ./include/net/netdev_lock.h (72)
> WARNING: CPU: -1 PID: 1141 at ./include/net/netdev_lock.h:72 netdev_ops_assert_locked include/net/netdev_lock.h:72 [inline]
> WARNING: CPU: 0 PID: 1141 at ./include/net/netdev_lock.h:72 __linkwatch_sync_dev+0x1ed/0x230 net/core/link_watch.c:279
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

netdev_ops_assert_locked is called for non-ops-locked netdev and we
trigger ASSERT_RTNL case. Which is a bit misleading, but I noticed that
bond_miimon_inspect is running under rcu lock, which is not
gonna work for ops-locked devices :-/ (we want to grab instance
lock for the CHANGE notifiers).

I'm contemplating dropping rcu and doing try_lock rtnl. Looking at
commit f0c76d61779b ("bonding: refactor mii monitor"), it doesn't look
like there were issues with rtnl performance, so hopefully should be ok.

Because from my resent patches I remember this trace:

    [ 3456.656261]  ? ipv6_add_dev+0x370/0x620
    [ 3456.660039]  ipv6_find_idev+0x96/0xe0
    [ 3456.660445]  addrconf_add_dev+0x1e/0xa0
    [ 3456.660861]  addrconf_init_auto_addrs+0xb0/0x720
    [ 3456.661803]  addrconf_notify+0x35f/0x8d0
    [ 3456.662236]  notifier_call_chain+0x38/0xf0
    [ 3456.662676]  netdev_state_change+0x65/0x90
    [ 3456.663112]  linkwatch_do_dev+0x5a/0x70

Where linkwatch_do_dev (potentially called from ethtool_op_get_link and
bond_check_dev_link) might trigger ipv6 address assignment so I'm not
sure how this all supposed to work under rcu and without rtnl lock.

Tentatively (untested uncompiled):

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


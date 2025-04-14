Return-Path: <netdev+bounces-182020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE534A875DB
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 04:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 448891891296
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 02:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13D21F941;
	Mon, 14 Apr 2025 02:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="B5djlLy9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C1E2F4A;
	Mon, 14 Apr 2025 02:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744597870; cv=none; b=Mbk2kkjgIev0ECNOo92qX3Ycg5p0SfPQAVTEQ88zn0eCsg3547f4X3g+FOMI00wm6wVCd61gr2CClrUO0xa7NQZGgchw8kAJQEGzl/3f/dQOSqQqytAlBMU0Pmj23HyCfj/vwp89TWkLGhCtTR+AysIjKbspx3J1ZG7aaOu35/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744597870; c=relaxed/simple;
	bh=hrkt79QgwXIsiasCmcytf6NbadKuKHha5ialFnb48Ys=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZlXeH0Mx5rH06DzpSOBjDVzK69EBsCsDtxUKeUCvrsA+kvKrTuuVT6uX25lQpYwt87lYbSFg9ffxY2b2q8YtsgD272PNWws7U9f48juo8r+hzGdssIBqkdWCx6TZCOQfhDHnTlejsHaDuZ+pUIwEn73hAh0rsLBzRLRUyYTY7NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=B5djlLy9; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744597868; x=1776133868;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mXp++OhBZeDrR/eRrZugOW96Mk+uHmRbPf2RwqEupgk=;
  b=B5djlLy9Ghhukpx6iPxTu+KqElHFbgCiiVuP3NRt2KPusfhyd3DGwKr4
   iknGfqckzsP6rF2gOFh3nqpL6sFcr9MaDohReig/ckru8QMzgRG8r0IqB
   3Kv0GSY/CMmPtO05Q94KwEwQwEY9BYdPS5esgFFFhbA0oPWLeICS3Etwz
   Q=;
X-IronPort-AV: E=Sophos;i="6.15,211,1739836800"; 
   d="scan'208";a="187058078"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 02:31:07 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:39673]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.63:2525] with esmtp (Farcaster)
 id 90f9a2c6-7278-4f22-8cb8-4f854b41179f; Mon, 14 Apr 2025 02:31:06 +0000 (UTC)
X-Farcaster-Flow-ID: 90f9a2c6-7278-4f22-8cb8-4f854b41179f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 02:31:05 +0000
Received: from 6c7e67bfbae3.amazon.com (10.88.185.97) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 02:31:03 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <syzbot+de1c7d68a10e3f123bdd@syzkaller.appspotmail.com>
CC: <cratiu@nvidia.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <sdf@fomichev.me>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [net?] general protection fault in rtnl_create_link
Date: Sun, 13 Apr 2025 19:30:46 -0700
Message-ID: <20250414023048.44721-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <67fc6f85.050a0220.2970f9.039e.GAE@google.com>
References: <67fc6f85.050a0220.2970f9.039e.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC001.ant.amazon.com (10.13.139.218) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: syzbot <syzbot+de1c7d68a10e3f123bdd@syzkaller.appspotmail.com>
Date: Sun, 13 Apr 2025 19:14:29 -0700
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    eaa517b77e63 ethtool: cmis_cdb: Fix incorrect read / write..
> git tree:       net
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1541f23f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f2054704dd53fb80
> dashboard link: https://syzkaller.appspot.com/bug?extid=de1c7d68a10e3f123bdd
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1429874c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1353f74c580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/8ff6a34dbd2f/disk-eaa517b7.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/80dc0689a89b/vmlinux-eaa517b7.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/093b749f228d/bzImage-eaa517b7.xz
> 
> The issue was bisected to:
> 
> commit 04efcee6ef8d0f01eef495db047e7216d6e6e38f
> Author: Stanislav Fomichev <sdf@fomichev.me>
> Date:   Fri Apr 4 16:11:22 2025 +0000
> 
>     net: hold instance lock during NETDEV_CHANGE
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=151db7e4580000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=171db7e4580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=131db7e4580000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+de1c7d68a10e3f123bdd@syzkaller.appspotmail.com
> Fixes: 04efcee6ef8d ("net: hold instance lock during NETDEV_CHANGE")
> 
> netlink: 4 bytes leftover after parsing attributes in process `syz-executor402'.
> netlink: 'syz-executor402': attribute type 15 has an invalid length.
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000055: 0000 [#1] SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x00000000000002a8-0x00000000000002af]
> CPU: 0 UID: 0 PID: 5841 Comm: syz-executor402 Not tainted 6.14.0-syzkaller-13348-geaa517b77e63 #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
> RIP: 0010:netdev_need_ops_lock include/net/netdev_lock.h:33 [inline]
> RIP: 0010:netdev_lock_ops include/net/netdev_lock.h:41 [inline]
> RIP: 0010:rtnl_create_link+0x6af/0xea0 net/core/rtnetlink.c:3680

#syz test

diff --git a/include/net/netdev_lock.h b/include/net/netdev_lock.h
index 5706835a660c..270e157a4a79 100644
--- a/include/net/netdev_lock.h
+++ b/include/net/netdev_lock.h
@@ -30,7 +30,8 @@ static inline bool netdev_need_ops_lock(const struct net_device *dev)
 	bool ret = dev->request_ops_lock || !!dev->queue_mgmt_ops;
 
 #if IS_ENABLED(CONFIG_NET_SHAPER)
-	ret |= !!dev->netdev_ops->net_shaper_ops;
+	if (dev->netdev_ops)
+		ret |= !!dev->netdev_ops->net_shaper_ops;
 #endif
 
 	return ret;



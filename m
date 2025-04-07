Return-Path: <netdev+bounces-179757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA55A7E730
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 127C83A9367
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6DC20E6FB;
	Mon,  7 Apr 2025 16:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Aww/hTv/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FF120F062
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 16:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744044171; cv=none; b=c+fE6yMhSQpupDToggBTlLyung5J2sJk1+hCUevExFqSA89+AVGChX//am5ML0r7nUUAYVJcCPgDUAtz6XYFiVjOxoVrvJMTY3QSHSNiwQipdFZJlyDkGpMnNIP4a04n4JLe/5zw0eSG6XizIobjPMXksAUPkN5ixOxdCbNCE3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744044171; c=relaxed/simple;
	bh=qu6kCiy18wes7/stWoYPmQrMB3vdpy7swV09KOSp8iE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LM+U2LtqYeFgZdWGJsGwpFBGOkadJETyCVluEw5YXpy9gFTisjZbpWFTC94NA052gD7zt5Y7N2LtQyhkT+kaWd/YVJi0mee9ETvlXWG0n7nYLDG5H0Cy+/+UnGWwKdjdaHIyu8M4ELAEzImQaBQ8Ns5O+2h+jR4hG80VJM3e6Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Aww/hTv/; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744044170; x=1775580170;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5zG/o96f2N+G2RDK8ePFKFA1zjKN6pbQpRb3bVxemJg=;
  b=Aww/hTv/0SxbkzgDuvgvX/TEpFitZz0ZTsQpwXS0Q4EnCC/+F1dvqTxK
   tWedblKl0mz/TSdvFIavl2PBj503HyBp6JIj4eXO4TUsEG6vofNDSDeVn
   /IXkrp1jfqq9sBKVJzHKwUF4rEvfqQWj4ryUc3l4bsywvPtjBRQYMWpqv
   U=;
X-IronPort-AV: E=Sophos;i="6.15,194,1739836800"; 
   d="scan'208";a="814055935"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 16:42:43 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:46389]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.147:2525] with esmtp (Farcaster)
 id f2b01fff-20c5-49f5-af69-30dfa4b99aae; Mon, 7 Apr 2025 16:42:41 +0000 (UTC)
X-Farcaster-Flow-ID: f2b01fff-20c5-49f5-af69-30dfa4b99aae
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Apr 2025 16:42:41 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.45) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Apr 2025 16:42:38 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>,
	<syzbot+45016fe295243a7882d3@syzkaller.appspotmail.com>
Subject: [PATCH v1 net] rtnetlink: Fix bad unlock balance in do_setlink().
Date: Mon, 7 Apr 2025 09:42:22 -0700
Message-ID: <20250407164229.24414-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB001.ant.amazon.com (10.13.139.160) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

When validate_linkmsg() fails in do_setlink(), we jump to the errout
label and calls netdev_unlock_ops() even though we have not called
netdev_lock_ops() as reported by syzbot.  [0]

Let's return an error directly in such a case.

[0]
WARNING: bad unlock balance detected!
6.14.0-syzkaller-12504-g8bc251e5d874 #0 Not tainted

syz-executor814/5834 is trying to release lock (&dev_instance_lock_key) at:
[<ffffffff89f41f56>] netdev_unlock include/linux/netdevice.h:2756 [inline]
[<ffffffff89f41f56>] netdev_unlock_ops include/net/netdev_lock.h:48 [inline]
[<ffffffff89f41f56>] do_setlink+0xc26/0x43a0 net/core/rtnetlink.c:3406
but there are no more locks to release!

other info that might help us debug this:
1 lock held by syz-executor814/5834:
 #0: ffffffff900fc408 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #0: ffffffff900fc408 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
 #0: ffffffff900fc408 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0xd68/0x1fe0 net/core/rtnetlink.c:4064

stack backtrace:
CPU: 0 UID: 0 PID: 5834 Comm: syz-executor814 Not tainted 6.14.0-syzkaller-12504-g8bc251e5d874 #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_unlock_imbalance_bug+0x185/0x1a0 kernel/locking/lockdep.c:5296
 __lock_release kernel/locking/lockdep.c:5535 [inline]
 lock_release+0x1ed/0x3e0 kernel/locking/lockdep.c:5887
 __mutex_unlock_slowpath+0xee/0x800 kernel/locking/mutex.c:907
 netdev_unlock include/linux/netdevice.h:2756 [inline]
 netdev_unlock_ops include/net/netdev_lock.h:48 [inline]
 do_setlink+0xc26/0x43a0 net/core/rtnetlink.c:3406
 rtnl_group_changelink net/core/rtnetlink.c:3783 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3937 [inline]
 rtnl_newlink+0x1619/0x1fe0 net/core/rtnetlink.c:4065
 rtnetlink_rcv_msg+0x80f/0xd70 net/core/rtnetlink.c:6955
 netlink_rcv_skb+0x208/0x480 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x7f8/0x9a0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8c3/0xcd0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:727
 ____sys_sendmsg+0x523/0x860 net/socket.c:2566
 ___sys_sendmsg net/socket.c:2620 [inline]
 __sys_sendmsg+0x271/0x360 net/socket.c:2652
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8427b614a9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff9b59f3a8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fff9b59f578 RCX: 00007f8427b614a9
RDX: 0000000000000000 RSI: 0000200000000300 RDI: 0000000000000004
RBP: 00007f8427bd4610 R08: 000000000000000c R09: 00007fff9b59f578
R10: 000000000000001b R11: 0000000000000246 R12: 0000000000000001
R13:

Fixes: 4c975fd70002 ("net: hold instance lock during NETDEV_REGISTER/UP")
Reported-by: syzbot+45016fe295243a7882d3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=45016fe295243a7882d3
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/rtnetlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index c23852835050..925d634f724e 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3027,7 +3027,7 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 
 	err = validate_linkmsg(dev, tb, extack);
 	if (err < 0)
-		goto errout;
+		return err;
 
 	if (tb[IFLA_IFNAME])
 		nla_strscpy(ifname, tb[IFLA_IFNAME], IFNAMSIZ);
-- 
2.48.1



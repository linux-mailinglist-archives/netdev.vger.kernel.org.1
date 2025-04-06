Return-Path: <netdev+bounces-179454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B02A7CCAA
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 05:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC414176AA5
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 03:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9BF192D8E;
	Sun,  6 Apr 2025 03:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="pA58EEAH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66751922F5
	for <netdev@vger.kernel.org>; Sun,  6 Apr 2025 03:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743911894; cv=none; b=k1JQfSeYtijt8QawLl+JjnLuDuG5dUSHP6EmTuY/684UJlVsPz/b+uU6Ixa3ST3XHXYVx/2OyL/Qavf7zQR/ZS41Vb6YVOI+D4CSO4ULd7LOhQZmWwDcPi6JFJkHpeFhoRBxScQ+YRFoRYwXtt+8LAnbxqlX/ndVoBkexXQ80Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743911894; c=relaxed/simple;
	bh=0gTVhFw4H8jt3nTwTF5WNABxXa8VRg/iGAbrHj4kT7k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tqG9w3RhGzZl2JlDe4fdq6t6rR4i0WuDHQlz79LTobTUD5qDofNmSr9UFs3oBz6IbhnJ7idkqIreMoTFgi6RlQYPf6f1iLJA5xOe+bwb+25tHvb2Hl2JeSghOfPB04UtJhCeN0s9PCz50a1W58+PoqRENKVWidH80fAVPxaX8c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=pA58EEAH; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743911893; x=1775447893;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=726E6U2OC4OYQHOTfjNWN7nRrBC7B1dTy5pEKLTJdrc=;
  b=pA58EEAH3yahyAKBkTpCh3e93aGKZzwjW8DnzYURqpfXkMpyp4ub3Ova
   8OtBts9OEtHfTtDtw4bgSrJdtAlymsipsfspcUngNIgXv//uB19MgJNAr
   7C55iqcaRr5KIElOu90CtXEB0lWMFTNjP8Y6/jTLbOxNS+a2dWwIJ9wXv
   g=;
X-IronPort-AV: E=Sophos;i="6.15,192,1739836800"; 
   d="scan'208";a="480712619"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2025 03:58:09 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:47754]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.132:2525] with esmtp (Farcaster)
 id 3fabfdf2-5ddf-4b39-8424-239d7b16b490; Sun, 6 Apr 2025 03:58:08 +0000 (UTC)
X-Farcaster-Flow-ID: 3fabfdf2-5ddf-4b39-8424-239d7b16b490
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sun, 6 Apr 2025 03:58:07 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.50) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sun, 6 Apr 2025 03:58:04 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, syzkaller
	<syzkaller@googlegroups.com>, Hui Guo <guohui.study@gmail.com>
Subject: [PATCH v1 net] ipv6: Fix null-ptr-deref in addrconf_add_ifaddr().
Date: Sat, 5 Apr 2025 20:57:51 -0700
Message-ID: <20250406035755.69238-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The cited commit placed netdev_lock_ops() just after __dev_get_by_index()
in addrconf_add_ifaddr(), where dev could be NULL as reported. [0]

Let's call netdev_lock_ops() only when dev is not NULL.

[0]:
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000198: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000cc0-0x0000000000000cc7]
CPU: 3 UID: 0 PID: 12032 Comm: syz.0.15 Not tainted 6.14.0-13408-g9f867ba24d36 #1 PREEMPT(full)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:addrconf_add_ifaddr (./include/net/netdev_lock.h:30 ./include/net/netdev_lock.h:41 net/ipv6/addrconf.c:3157)
Code: 8b b4 24 94 00 00 00 4c 89 ef e8 7e 4c 2f ff 4c 8d b0 c5 0c 00 00 48 89 c3 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 <0f> b6 04 02 4c 89 f2 83 e2 07 38 d0 7f 08 80
RSP: 0018:ffffc90015b0faa0 EFLAGS: 00010213
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000198 RSI: ffffffff893162f2 RDI: ffff888078cb0338
RBP: ffffc90015b0fbb0 R08: 0000000000000000 R09: fffffbfff20cbbe2
R10: ffffc90015b0faa0 R11: 0000000000000000 R12: 1ffff92002b61f54
R13: ffff888078cb0000 R14: 0000000000000cc5 R15: ffff888078cb0000
FS: 00007f92559ed640(0000) GS:ffff8882a8659000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f92559ecfc8 CR3: 000000001c39e000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 inet6_ioctl (net/ipv6/af_inet6.c:580)
 sock_do_ioctl (net/socket.c:1196)
 sock_ioctl (net/socket.c:1314)
 __x64_sys_ioctl (fs/ioctl.c:52 fs/ioctl.c:906 fs/ioctl.c:892 fs/ioctl.c:892)
 do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130
RIP: 0033:0x7f9254b9c62d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff f8
RSP: 002b:00007f92559ecf98 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f9254d65f80 RCX: 00007f9254b9c62d
RDX: 0000000020000040 RSI: 0000000000008916 RDI: 0000000000000003
RBP: 00007f9254c264d3 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f9254d65f80 R15: 00007f92559cd000
 </TASK>
Modules linked in:

Fixes: 8965c160b8f7 ("net: use netif_disable_lro in ipv6_add_dev")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Reported-by: Hui Guo <guohui.study@gmail.com>
Closes: https://lore.kernel.org/netdev/CAHOo4gK+tdU1B14Kh6tg-tNPqnQ1qGLfinONFVC43vmgEPnXXw@mail.gmail.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/addrconf.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index c3b908fccbc1..9c52ed23ff23 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3154,12 +3154,13 @@ int addrconf_add_ifaddr(struct net *net, void __user *arg)
 
 	rtnl_net_lock(net);
 	dev = __dev_get_by_index(net, ireq.ifr6_ifindex);
-	netdev_lock_ops(dev);
-	if (dev)
+	if (dev) {
+		netdev_lock_ops(dev);
 		err = inet6_addr_add(net, dev, &cfg, 0, 0, NULL);
-	else
+		netdev_unlock_ops(dev);
+	} else {
 		err = -ENODEV;
-	netdev_unlock_ops(dev);
+	}
 	rtnl_net_unlock(net);
 	return err;
 }
-- 
2.48.1



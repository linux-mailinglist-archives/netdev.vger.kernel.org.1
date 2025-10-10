Return-Path: <netdev+bounces-228530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A34FBCD5B3
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 15:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4FE6D4F024B
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 13:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ED42F3C08;
	Fri, 10 Oct 2025 13:54:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A621C5D44;
	Fri, 10 Oct 2025 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760104468; cv=none; b=lBCOM6zLy2C+AjXyzGbEDksV1RvzlZpft5duX79pcDdgfGOi5/41UauT7XNZgncKLn1a4qbJwTat4XhDaLxJmbtalXGIyoOs+K37jRhoNApT/4XjGZQer+eY8u3uTDaedh9fZA0v277Dv6d7xEGy3w8tYX6/qnQplkyH9gAeIuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760104468; c=relaxed/simple;
	bh=gqLAGOI0QfcdMMy5i6qQfg6/kX9HGC8qZPu6N6EoQXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pb2sStKwFT2h4R+qJM22Pemj15jRtUk/wlPFqJM8mzDfO6NGjbIIVwGx0ek7Rsaz6A57GXjeL9r3JDtd7aOVl/7VN0fHfiI7wEMLesSTddTUjkIlNH9RyyTSWGn5TeBff77fUddu3RajbviOQAAj4ug/pxroA9ovSVjlyxAltpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id EFB7461775; Fri, 10 Oct 2025 15:54:24 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>,
	sdf@fomichev.me
Subject: [PATCH net 2/2] net: core: split unregister_netdevice list into smaller chunks
Date: Fri, 10 Oct 2025 15:54:12 +0200
Message-ID: <20251010135412.22602-3-fw@strlen.de>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251010135412.22602-1-fw@strlen.de>
References: <20251010135412.22602-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since blamed commit, unregister_netdevice_many_notify() takes the netdev
mutex if the device needs it.

This isn't a problem in itself, the problem is that the list can be
very long, so it may lock a LOT of mutexes, but lockdep engine can only
deal with MAX_LOCK_DEPTH held locks:

unshare -n bash -c 'for i in $(seq 1 100);do  ip link add foo$i type dummy;done'
BUG: MAX_LOCK_DEPTH too low!
turning off the locking correctness validator.
depth: 48  max: 48!
48 locks held by kworker/u16:1/69:
 #0: ffff8880010b7148 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x7ed/0x1350
 #1: ffffc900004a7d40 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0xcf3/0x1350
 #2: ffffffff8bc6fbd0 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0xab/0x7f0
 #3: ffffffff8bc8daa8 (rtnl_mutex){+.+.}-{4:4}, at: default_device_exit_batch+0x7e/0x2e0
 #4: ffff88800b5e9cb0 (&dev_instance_lock_key#3){+.+.}-{4:4}, at: unregister_netdevice_many_notify+0x1056/0x1b00
[..]

Work around this limitation by chopping the list into smaller chunks
and process them individually for LOCKDEP enabled kernels.

Fixes: 7e4d784f5810 ("net: hold netdev instance lock during rtnetlink operations")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/core/dev.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 9a09b48c9371..7e35aa4ebc74 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12208,6 +12208,38 @@ static void unregister_netdevice_close_many(struct list_head *head)
 	}
 }
 
+static void unregister_netdevice_close_many_lockdep(struct list_head *head)
+{
+#ifdef CONFIG_LOCKDEP
+	unsigned int lock_depth = lockdep_depth(current);
+	unsigned int lock_count = lock_depth;
+	struct net_device *dev, *tmp;
+	LIST_HEAD(done_head);
+
+	list_for_each_entry_safe(dev, tmp, head, unreg_list) {
+		if (netdev_need_ops_lock(dev))
+			lock_count++;
+
+		/* we'll run out of lockdep keys, reduce size. */
+		if (lock_count >= MAX_LOCK_DEPTH - 1) {
+			LIST_HEAD(tmp_head);
+
+			list_cut_before(&tmp_head, head, &dev->unreg_list);
+			unregister_netdevice_close_many(&tmp_head);
+			lock_count = lock_depth;
+			list_splice_tail(&tmp_head, &done_head);
+		}
+	}
+
+	unregister_netdevice_close_many(head);
+
+	list_for_each_entry_safe_reverse(dev, tmp, &done_head, unreg_list)
+		list_move(&dev->unreg_list, head);
+#else
+	unregister_netdevice_close_many(head);
+#endif
+}
+
 void unregister_netdevice_many_notify(struct list_head *head,
 				      u32 portid, const struct nlmsghdr *nlh)
 {
@@ -12237,7 +12269,7 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		BUG_ON(dev->reg_state != NETREG_REGISTERED);
 	}
 
-	unregister_netdevice_close_many(head);
+	unregister_netdevice_close_many_lockdep(head);
 
 	flush_all_backlogs();
 
-- 
2.49.1



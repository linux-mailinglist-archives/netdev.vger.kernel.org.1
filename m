Return-Path: <netdev+bounces-183111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF1CA8AE57
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 05:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 051AB7ACE21
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 03:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E372139B1;
	Wed, 16 Apr 2025 03:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Icbm8MOp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E194814B08E
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 03:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744772695; cv=none; b=kjOMnMXmq1S6K9f6BgDIaSIWhwGKy69PKET/K7PkcwWcLXjm0VVYXTNBu2/fOnwaVFQtBgah7jyvVJrrbIWcjbj6Q6afhrGqBy5xhrSw83RKyxWEnnjVN/DXtujFdeWtO7YDoV3EONC7njS+1OKg6KiP2c7pSbv6WIRzemXC8no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744772695; c=relaxed/simple;
	bh=6NnVRgiam3xgqR6/ja0WUP6xIEnAyrVW0ySHJMf8wbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tNnX7gfrF93VomGmfVQ8IwTxgRxyhV3npUaxPoFWalxbACUp/LvCZ6u+nEy8kldgx/xqmoGJdBrYBHeDkBmI/mPfmJP9H/zS5MAP5ogvvhsbM+pUIkz8TqLcOrdYEeTU86JZKXNRfwTEKtWpG2aASBMCnQ0os6Zz/S1qjP9NNqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Icbm8MOp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0134C4CEE7;
	Wed, 16 Apr 2025 03:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744772694;
	bh=6NnVRgiam3xgqR6/ja0WUP6xIEnAyrVW0ySHJMf8wbA=;
	h=From:To:Cc:Subject:Date:From;
	b=Icbm8MOp7gkozZLCItXYkEVd19vAtSSHK6lOykejb/lsETGZHAmTtfBQbeFMB0Bp7
	 cX8RXDp9wbcV9glZ+pWb25+uQuIY8hgvvkODzDjTUR0C6vZFUVfdEsQGXGQiMCEHZk
	 qLfpw1J8Dyz5f61CzKfrL9ItGvJmGXmy/+GuMDFnWiYtzTDhud7TzRZo13YR706nDX
	 Nq0gCZsRoUS+vxgGB4X7v38DOOY6C4ZR4Iqnb75PaAbBDIi+hdj3yLxJLWeHbQT2mO
	 NRN+lrcuS8zH5v7v/ILUTkR4OKi3VPhznVjgQ5tQ5p8aUmXfb4ObK8leSdZ2lIj1vB
	 YoHgSweP/ABPA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	syzkaller <syzkaller@googlegroups.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	sdf@fomichev.me,
	jdamato@fastly.com,
	almasrymina@google.com
Subject: [PATCH net-next v3] netdev: fix the locking for netdev notifications
Date: Tue, 15 Apr 2025 20:04:47 -0700
Message-ID: <20250416030447.1077551-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kuniyuki reports that the assert for netdev lock fires when
there are netdev event listeners (otherwise we skip the netlink
event generation).

Correct the locking when coming from the notifier.

The NETDEV_XDP_FEAT_CHANGE notifier is already fully locked,
it's the documentation that's incorrect.

Fixes: 99e44f39a8f7 ("netdev: depend on netdev->lock for xdp features")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Reported-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://lore.kernel.org/20250410171019.62128-1-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - add else branch in the helpers with a lockdep assert
v2: https://lore.kernel.org/20250414195903.574489-1-kuba@kernel.org
 - rebase vs net merge which brought in
   commit 04efcee6ef8d ("net: hold instance lock during NETDEV_CHANGE")
v1: https://lore.kernel.org/20250411204629.128669-1-kuba@kernel.org

CC: kuniyu@amazon.com
CC: sdf@fomichev.me
CC: jdamato@fastly.com
CC: almasrymina@google.com
---
 Documentation/networking/netdevices.rst |  4 +++-
 include/linux/netdevice.h               |  2 +-
 include/net/netdev_lock.h               | 16 ++++++++++++++++
 net/core/lock_debug.c                   |  4 +++-
 net/core/netdev-genl.c                  |  4 ++++
 5 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index f87bb55b4afe..a73a39b206e3 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -387,12 +387,14 @@ For device drivers that implement shaping or queue management APIs,
 some of the notifiers (``enum netdev_cmd``) are running under the netdev
 instance lock.
 
+The following netdev notifiers are always run under the instance lock:
+* ``NETDEV_XDP_FEAT_CHANGE``
+
 For devices with locked ops, currently only the following notifiers are
 running under the lock:
 * ``NETDEV_CHANGE``
 * ``NETDEV_REGISTER``
 * ``NETDEV_UP``
-* ``NETDEV_XDP_FEAT_CHANGE``
 
 The following notifiers are running without the lock:
 * ``NETDEV_UNREGISTER``
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e6036b82ef4c..0321fd952f70 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2520,7 +2520,7 @@ struct net_device {
 	 *	@net_shaper_hierarchy, @reg_state, @threaded
 	 *
 	 * Double protects:
-	 *	@up, @moving_ns, @nd_net, @xdp_flags
+	 *	@up, @moving_ns, @nd_net, @xdp_features
 	 *
 	 * Double ops protects:
 	 *	@real_num_rx_queues, @real_num_tx_queues
diff --git a/include/net/netdev_lock.h b/include/net/netdev_lock.h
index 5706835a660c..2a753813f849 100644
--- a/include/net/netdev_lock.h
+++ b/include/net/netdev_lock.h
@@ -48,6 +48,22 @@ static inline void netdev_unlock_ops(struct net_device *dev)
 		netdev_unlock(dev);
 }
 
+static inline void netdev_lock_ops_to_full(struct net_device *dev)
+{
+	if (netdev_need_ops_lock(dev))
+		netdev_assert_locked(dev);
+	else
+		netdev_lock(dev);
+}
+
+static inline void netdev_unlock_full_to_ops(struct net_device *dev)
+{
+	if (netdev_need_ops_lock(dev))
+		netdev_assert_locked(dev);
+	else
+		netdev_unlock(dev);
+}
+
 static inline void netdev_ops_assert_locked(const struct net_device *dev)
 {
 	if (netdev_need_ops_lock(dev))
diff --git a/net/core/lock_debug.c b/net/core/lock_debug.c
index 6fade574bc2a..9e9fb25314b9 100644
--- a/net/core/lock_debug.c
+++ b/net/core/lock_debug.c
@@ -18,10 +18,12 @@ int netdev_debug_event(struct notifier_block *nb, unsigned long event,
 
 	/* Keep enum and don't add default to trigger -Werror=switch */
 	switch (cmd) {
+	case NETDEV_XDP_FEAT_CHANGE:
+		netdev_assert_locked(dev);
+		fallthrough;
 	case NETDEV_CHANGE:
 	case NETDEV_REGISTER:
 	case NETDEV_UP:
-	case NETDEV_XDP_FEAT_CHANGE:
 		netdev_ops_assert_locked(dev);
 		fallthrough;
 	case NETDEV_DOWN:
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index b64c614a00c4..2c104947d224 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -963,10 +963,14 @@ static int netdev_genl_netdevice_event(struct notifier_block *nb,
 
 	switch (event) {
 	case NETDEV_REGISTER:
+		netdev_lock_ops_to_full(netdev);
 		netdev_genl_dev_notify(netdev, NETDEV_CMD_DEV_ADD_NTF);
+		netdev_unlock_full_to_ops(netdev);
 		break;
 	case NETDEV_UNREGISTER:
+		netdev_lock(netdev);
 		netdev_genl_dev_notify(netdev, NETDEV_CMD_DEV_DEL_NTF);
+		netdev_unlock(netdev);
 		break;
 	case NETDEV_XDP_FEAT_CHANGE:
 		netdev_genl_dev_notify(netdev, NETDEV_CMD_DEV_CHANGE_NTF);
-- 
2.49.0



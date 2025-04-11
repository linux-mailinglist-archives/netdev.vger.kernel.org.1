Return-Path: <netdev+bounces-181787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A094A8678D
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 22:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5FD9A28B4
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC10827D769;
	Fri, 11 Apr 2025 20:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePXBkuXW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8399AD24
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 20:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744404391; cv=none; b=MdT/9bxw8z2SnjOEJJMLHVWhH9qhufnP1FE5v0xxMFEyXjWf+ea0g/P98kuw5qc2tQCbBGjjnMf+Rl1paX1k8jB+rs0q050VkwwmOMkQLWbj6x7zMZsZIyqfNZic3u/Ff0aYbGfCAp8IkMcGWUeSTm/zwGqn9b+s9sLSk8y1GUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744404391; c=relaxed/simple;
	bh=LpwWmr0vowZPRajK38ZJdFpxFDCNIri9W8G9dcd3Fz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rz3oTL/Ggpa0a3Z5v3KlcL5zyYc17H/o69a2+Jto9F9/IIfo2VALZMlCVZ4aTGjw/YyH9hOEt5tD6NMBYbdKzKQh39SLERTdWaX6122JsRqQJAdKYNQqkPeFKILCvzaiRibOefXloQRtJNrChd7L1XWAFjUDw8HfgrOE5J6HFaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePXBkuXW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8289C4CEE2;
	Fri, 11 Apr 2025 20:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744404391;
	bh=LpwWmr0vowZPRajK38ZJdFpxFDCNIri9W8G9dcd3Fz0=;
	h=From:To:Cc:Subject:Date:From;
	b=ePXBkuXWHXal0I+q7x0vTN7xB/TErW1a+H5AWB/xqo/BcNiDIHHauX6tlq8WJcBWb
	 EBu/g8mvhUx3zfZLFJgzEaeiLAkeQzCNVAhfVNt3ZcF6Qid3V7n+Ycog3+tRPQWLBu
	 M4xwu6v9dSoE18xI8664Detq67qUfnbtdcJN+d/acm5+VpmsjI2C9IqefgLieCzkvr
	 7KLksXG6mqPFFqFBGf6QDQDihs86OA1p1H4kYouPScwWoIHbFx56pbWMjyw2EqKuij
	 8waN/KVKjIo5BdLe0SBhjNd27ooArSd3F/O/aHQezkBk7EnuTYTUZZq8vgDWwEdGDe
	 uHmimqzziPd9Q==
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
Subject: [PATCH net-next] netdev: fix the locking for netdev notifications
Date: Fri, 11 Apr 2025 13:46:29 -0700
Message-ID: <20250411204629.128669-1-kuba@kernel.org>
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
CC: kuniyu@amazon.com
CC: sdf@fomichev.me
CC: jdamato@fastly.com
CC: almasrymina@google.com
---
 Documentation/networking/netdevices.rst |  4 +++-
 include/linux/netdevice.h               |  2 +-
 include/net/netdev_lock.h               | 12 ++++++++++++
 net/core/lock_debug.c                   |  4 +++-
 net/core/netdev-genl.c                  |  4 ++++
 5 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index 0ccc7dcf4390..feadefe61849 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -386,11 +386,13 @@ For device drivers that implement shaping or queue management APIs,
 some of the notifiers (``enum netdev_cmd``) are running under the netdev
 instance lock.
 
+The following netdev notifiers are always run under the instance lock:
+* ``NETDEV_XDP_FEAT_CHANGE``
+
 For devices with locked ops, currently only the following notifiers are
 running under the lock:
 * ``NETDEV_REGISTER``
 * ``NETDEV_UP``
-* ``NETDEV_XDP_FEAT_CHANGE``
 
 The following notifiers are running without the lock:
 * ``NETDEV_UNREGISTER``
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index a28a08046615..0976c85932e5 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2526,7 +2526,7 @@ struct net_device {
 	 *	@net_shaper_hierarchy, @reg_state, @threaded
 	 *
 	 * Double protects:
-	 *	@up, @moving_ns, @nd_net, @xdp_flags
+	 *	@up, @moving_ns, @nd_net, @xdp_features
 	 *
 	 * Double ops protects:
 	 *	@real_num_rx_queues, @real_num_tx_queues
diff --git a/include/net/netdev_lock.h b/include/net/netdev_lock.h
index 5706835a660c..c63448b17f9e 100644
--- a/include/net/netdev_lock.h
+++ b/include/net/netdev_lock.h
@@ -48,6 +48,18 @@ static inline void netdev_unlock_ops(struct net_device *dev)
 		netdev_unlock(dev);
 }
 
+static inline void netdev_lock_ops_to_full(struct net_device *dev)
+{
+	if (!netdev_need_ops_lock(dev))
+		netdev_lock(dev);
+}
+
+static inline void netdev_unlock_full_to_ops(struct net_device *dev)
+{
+	if (!netdev_need_ops_lock(dev))
+		netdev_unlock(dev);
+}
+
 static inline void netdev_ops_assert_locked(const struct net_device *dev)
 {
 	if (netdev_need_ops_lock(dev))
diff --git a/net/core/lock_debug.c b/net/core/lock_debug.c
index 598c443ef2f3..72d3f5dd610c 100644
--- a/net/core/lock_debug.c
+++ b/net/core/lock_debug.c
@@ -18,9 +18,11 @@ int netdev_debug_event(struct notifier_block *nb, unsigned long event,
 
 	/* Keep enum and don't add default to trigger -Werror=switch */
 	switch (cmd) {
+	case NETDEV_XDP_FEAT_CHANGE:
+		netdev_assert_locked(dev);
+		fallthrough;
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



Return-Path: <netdev+bounces-182448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 323B0A88C8B
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 21:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38D9B1899F33
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 19:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58F01CACF3;
	Mon, 14 Apr 2025 19:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPLMNPAM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15AA1C9B9B
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 19:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744660746; cv=none; b=aqcocC6vTe9l0sEmXV40iXakvFf/oIw9GVfBaZy8p1TWNtjHL5kN8tF/Ex8qdSsQB2tF7PTMhqRoel4+6DTVRFD0EOgfnrfcKr4AevOC4cqADJxfuw/REcfLk7/GFuRY0NWYlANajiaDtCaLWs5Mp55WaCFqRvQdBHSxxduSYyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744660746; c=relaxed/simple;
	bh=x8CqKD86w1HLWsRTI7tkXXVi8TA4dwN4sSMKnYRrrLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ox4fRcfGTWXX3SBGatGdvJz4+SjXuMa32Ja0B+xknTyjs1eaxT5FiBpPXv36zoH7mxft3u/+OcwT6Hq8jTXyfNyfM4ZrXMUyH+qGOgfjXv768wsmk1bdvpOS5gZpG4GkFzHClf6IER2GARO67c5J9GDZ4lQ4H3X8J2hh8KFYbY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPLMNPAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9965C4CEE2;
	Mon, 14 Apr 2025 19:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744660746;
	bh=x8CqKD86w1HLWsRTI7tkXXVi8TA4dwN4sSMKnYRrrLU=;
	h=From:To:Cc:Subject:Date:From;
	b=BPLMNPAM0XraWKli4t3Er+nqMpQQZ112/HcIjJ/V0pSDUvcHdcw5ZVlbiE2WCl0Bj
	 efXPWtKtDM/geoAqQFvmyXCYgnE42pnMN+GlB54e+EQFuQDY2xFYGpJL0AbpAFZ8xu
	 EhYNtNhJHE8zgCGi8+e9zAjRCQXYLF3Yq/Rtacj1PldqbFngiwe94hQYaHk+wICVzx
	 YpvEvHwY8agfmCE0t9RzPgqGzXNd666JVX/tDCFV/vX/zpam1vV2xUqcZCGcxDyYWf
	 wOBfqxPlfe4rWtb2jyEYai9v63Ny1lR4MCsDc+KSoEgK+q0OqP8FkPtz+5GsSIb0m2
	 YE78cR6oxZnbQ==
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
Subject: [PATCH net-next v2] netdev: fix the locking for netdev notifications
Date: Mon, 14 Apr 2025 12:59:03 -0700
Message-ID: <20250414195903.574489-1-kuba@kernel.org>
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
v2:
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
 include/net/netdev_lock.h               | 12 ++++++++++++
 net/core/lock_debug.c                   |  4 +++-
 net/core/netdev-genl.c                  |  4 ++++
 5 files changed, 23 insertions(+), 3 deletions(-)

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



Return-Path: <netdev+bounces-93022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 355578B9ADE
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 14:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4DC91F23770
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 12:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA8C8002F;
	Thu,  2 May 2024 12:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IN5hyfCy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C6F80028
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 12:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714652969; cv=none; b=VPk1wpON59Vytyqk/EATFtImxR+Fw/lJCw9/8rcQq3yEg8M4QFb30zUqJoz0oNPbdd2YiCj3lkzQp/6Qcg3Ia+75zkJdyyN9UQCe76rWhWXJWcqt/ngBrYuEYl8xXiJa5YfLaUn/VS0bLVdz3OPaQSIYKHCQIOC4Vr2Xdl4NR/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714652969; c=relaxed/simple;
	bh=uSpwPlMaWkCNTNLi9NPx1KH8LbWug9nQARrsTq8Rzm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HK62F36dbI7Gt8VDuiFKBimcCcQWdp3nLZz4TwKYBiV2G0Dm4AdDvZcvsdymt23bzSKfvDmPQ9ejfiU5YLKhp7BL9r14itVXzcQV8gGXqXOJLqYK1nXjXmrhWY+HD57atzMrQuZ9HFbvFgUpBnGlGH14FOGepXmtSegcQETchsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IN5hyfCy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74140C4AF48;
	Thu,  2 May 2024 12:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714652969;
	bh=uSpwPlMaWkCNTNLi9NPx1KH8LbWug9nQARrsTq8Rzm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IN5hyfCy2NPwWsx5VVTUu5AP4Y8PDO92zGyNfGCtOl70Oj9+JMmnUuo4bHv7hxv+o
	 OHXUuxe9oh9BFUcv0Z3YeL4qrVmXM3B5U9dMmQPsLkAWfA6UltkWPtt/Z+ISWZ8QXx
	 9vXKnslioJKX8Y1pW5bYXIcYDPYyPDLkHmGT0pbfDP9uQKuaImGnohEPJTqTtRqJvX
	 hPb4Lzyv0f6CGGm5UAWiDhRKRHCJZeBKlNxBr1muykAnQvjvyoN8jbi9l1LhHQ7Nyw
	 KBImcB+y04att91SfGowqdgyd4T76hLrAArOYwnBxH5cUgm/PhqoXQlLF/WcdQHv9/
	 5CbMzb043009g==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net-next v2 2/2] net: dsa: update the unicast MAC address when changing conduit
Date: Thu,  2 May 2024 14:29:22 +0200
Message-ID: <20240502122922.28139-3-kabel@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240502122922.28139-1-kabel@kernel.org>
References: <20240502122922.28139-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When changing DSA user interface conduit while the user interface is up,
DSA exhibits different behavior in comparison to when the interface is
down. This different behavior concers the primary unicast MAC address
stored in the port standalone FDB and in the conduit device UC database.

If we put a switch port down while changing the conduit with
  ip link set sw0p0 down
  ip link set sw0p0 type dsa conduit conduit1
  ip link set sw0p0 up
we delete the address in dsa_user_close() and install the (possibly
different) address in dsa_user_open().

But when changing the conduit on the fly, the old address is not
deleted and the new one is not installed.

Since we explicitly want to support live-changing the conduit, uninstall
the old address before calling dsa_port_assign_conduit() and install the
(possibly different) new address after the call.

Because conduit change might also trigger address change (the user
interface is supposed to inherit the conudit interface MAC address if no
address is defined in hardware (dp->mac is a zero address)), move the
eth_hw_addr_inherit() call from dsa_user_change_conduit() to
dsa_port_change_conduit(), just before installing the new address.

Fixes: 95f510d0b792 ("net: dsa: allow the DSA master to be seen and changed through rtnetlink")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 net/dsa/port.c | 40 ++++++++++++++++++++++++++++++++++++++++
 net/dsa/user.c | 10 ++--------
 net/dsa/user.h |  2 ++
 3 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/net/dsa/port.c b/net/dsa/port.c
index 9a249d4ac3a5..961b2dc84512 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -1467,10 +1467,34 @@ int dsa_port_change_conduit(struct dsa_port *dp, struct net_device *conduit,
 	 */
 	dsa_user_unsync_ha(dev);
 
+	/* If live-changing, we also need to uninstall the user device address
+	 * from the port FDB and the conduit interface.
+	 */
+	if (dev->flags & IFF_UP)
+		dsa_user_host_uc_uninstall(dev);
+
 	err = dsa_port_assign_conduit(dp, conduit, extack, true);
 	if (err)
 		goto rewind_old_addrs;
 
+	/* If the port doesn't have its own MAC address and relies on the DSA
+	 * conduit's one, inherit it again from the new DSA conduit.
+	 */
+	if (is_zero_ether_addr(dp->mac))
+		eth_hw_addr_inherit(dev, conduit);
+
+	/* If live-changing, we need to install the user device address to the
+	 * port FDB and the conduit interface.
+	 */
+	if (dev->flags & IFF_UP) {
+		err = dsa_user_host_uc_install(dev, dev->dev_addr);
+		if (err) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Failed to install host UC address");
+			goto rewind_addr_inherit;
+		}
+	}
+
 	dsa_user_sync_ha(dev);
 
 	if (vlan_filtering) {
@@ -1500,10 +1524,26 @@ int dsa_port_change_conduit(struct dsa_port *dp, struct net_device *conduit,
 rewind_new_addrs:
 	dsa_user_unsync_ha(dev);
 
+	if (dev->flags & IFF_UP)
+		dsa_user_host_uc_uninstall(dev);
+
+rewind_addr_inherit:
+	if (is_zero_ether_addr(dp->mac))
+		eth_hw_addr_inherit(dev, old_conduit);
+
 	dsa_port_assign_conduit(dp, old_conduit, NULL, false);
 
 /* Restore the objects on the old CPU port */
 rewind_old_addrs:
+	if (dev->flags & IFF_UP) {
+		tmp = dsa_user_host_uc_install(dev, dev->dev_addr);
+		if (tmp) {
+			dev_err(ds->dev,
+				"port %d failed to restore host UC address: %pe\n",
+				dp->index, ERR_PTR(tmp));
+		}
+	}
+
 	dsa_user_sync_ha(dev);
 
 	if (vlan_filtering) {
diff --git a/net/dsa/user.c b/net/dsa/user.c
index b1d8d1827f91..b599f0e9459c 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -355,7 +355,7 @@ static int dsa_user_get_iflink(const struct net_device *dev)
 	return READ_ONCE(dsa_user_to_conduit(dev)->ifindex);
 }
 
-static int dsa_user_host_uc_install(struct net_device *dev, const u8 *addr)
+int dsa_user_host_uc_install(struct net_device *dev, const u8 *addr)
 {
 	struct net_device *conduit = dsa_user_to_conduit(dev);
 	struct dsa_port *dp = dsa_user_to_port(dev);
@@ -383,7 +383,7 @@ static int dsa_user_host_uc_install(struct net_device *dev, const u8 *addr)
 	return err;
 }
 
-static void dsa_user_host_uc_uninstall(struct net_device *dev)
+void dsa_user_host_uc_uninstall(struct net_device *dev)
 {
 	struct net_device *conduit = dsa_user_to_conduit(dev);
 	struct dsa_port *dp = dsa_user_to_port(dev);
@@ -2779,12 +2779,6 @@ int dsa_user_change_conduit(struct net_device *dev, struct net_device *conduit,
 			    ERR_PTR(err));
 	}
 
-	/* If the port doesn't have its own MAC address and relies on the DSA
-	 * conduit's one, inherit it again from the new DSA conduit.
-	 */
-	if (is_zero_ether_addr(dp->mac))
-		eth_hw_addr_inherit(dev, conduit);
-
 	return 0;
 
 out_revert_conduit_link:
diff --git a/net/dsa/user.h b/net/dsa/user.h
index 996069130bea..016884bead3c 100644
--- a/net/dsa/user.h
+++ b/net/dsa/user.h
@@ -42,6 +42,8 @@ int dsa_user_suspend(struct net_device *user_dev);
 int dsa_user_resume(struct net_device *user_dev);
 int dsa_user_register_notifier(void);
 void dsa_user_unregister_notifier(void);
+int dsa_user_host_uc_install(struct net_device *dev, const u8 *addr);
+void dsa_user_host_uc_uninstall(struct net_device *dev);
 void dsa_user_sync_ha(struct net_device *dev);
 void dsa_user_unsync_ha(struct net_device *dev);
 void dsa_user_setup_tagger(struct net_device *user);
-- 
2.43.2



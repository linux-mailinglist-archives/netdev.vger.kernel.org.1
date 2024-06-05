Return-Path: <netdev+bounces-101015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 832E58FCFCA
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 15:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C3711C24615
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E01819414B;
	Wed,  5 Jun 2024 13:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkAjT25A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192A9194144
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 13:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717594417; cv=none; b=FhV1c24TJCskuGR9jXEevqpESAQkuzFgVc7XXIbfFHUByzmo/i/36w/AwfORImJ9MZncmF7k4x4FZXrxyFzHqZ7tQoW6SiNNiD2DuZBAAhA7VEF/7wHp4gcgKjG9z7pOD2gl+pMCf87FdNGPDlF706ljDBLEJItBoBjvnDlMtn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717594417; c=relaxed/simple;
	bh=PC5VZ09WYJULpMalCKGmCW+ATLIPSSfMsstX5e9DIkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VdbxFYPR/DoVccmKkdpJQ3ngKOQrcx7V1Mw2gDKqQB2eMbHkyeFfR2OrBw76ZOdz4OCkijkTdIZ8MafgGVu0o3B2wcbGt1wFiB3cvCu2+iH+tVtsf3rabewj4dJfqjRD9WHd0CqaO6snXByEZt0IKmRIIZrXKXKvDk1W2eLplJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkAjT25A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75365C4AF07;
	Wed,  5 Jun 2024 13:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717594416;
	bh=PC5VZ09WYJULpMalCKGmCW+ATLIPSSfMsstX5e9DIkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FkAjT25AxVHOWfd6MmxcPLioYLey69qTHNFZMOvib614XwClPlxT1v/pAU76t5pry
	 F3QHzR1z7ozp1KRpdvABf/wt8JEt7H2CApMsktJAGclbNdBWNdzCpc6s+JdZmzBqEW
	 HBtK2PtDwUA62LwUwFq+eg/VIMhmxtKzra23HHQvvxIP7/JxMPusEWq2/XvUWllAqz
	 ZX1rHT7RB28Njf204sT/PmriWK2A7znswy9jCU4ZAp2Lhw87Nv7lyfUztKRVV7+WK9
	 16Dp8n6DieHN9KzA37ADS6gNuig0t25MGJwW7SjJ4RQKOiT+cP9/T3qpfNT/7MNwP1
	 UAPOLwjYvC0hw==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net-next v3 2/2] net: dsa: update the unicast MAC address when changing conduit
Date: Wed,  5 Jun 2024 15:33:29 +0200
Message-ID: <20240605133329.6304-3-kabel@kernel.org>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240605133329.6304-1-kabel@kernel.org>
References: <20240605133329.6304-1-kabel@kernel.org>
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
down. This different behavior concerns the primary unicast MAC address
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
interface is supposed to inherit the conduit interface MAC address if no
address is defined in hardware (dp->mac is a zero address)), move the
eth_hw_addr_inherit() call from dsa_user_change_conduit() to
dsa_port_change_conduit(), just before installing the new address.

Although this is in theory a flaw in DSA core, it needs not be
backported, since there is currently no DSA driver that can be affected
by this. The only DSA driver that supports changing conduit is felix,
and, as explained by Vladimir Oltean [1]:

  There are 2 reasons why with felix the bug does not manifest itself.

  First is because both the 'ocelot' and the alternate 'ocelot-8021q'
  tagging protocols have the 'promisc_on_conduit = true' flag. So the
  unicast address doesn't have to be in the conduit's RX filter -
  neither the old or the new conduit.

  Second, dsa_user_host_uc_install() theoretically leaves behind host
  FDB entries installed towards the wrong (old) CPU port. But in
  felix_fdb_add(), we treat any FDB entry requested towards any CPU port
  as if it was a multicast FDB entry programmed towards _all_ CPU ports.
  For that reason, it is installed towards the port mask of the PGID_CPU
  port group ID:

	if (dsa_port_is_cpu(dp))
		port = PGID_CPU;

Therefore no Fixes tag for this change.

[1] https://lore.kernel.org/netdev/20240507201827.47suw4fwcjrbungy@skbuf/
Signed-off-by: Marek Behún <kabel@kernel.org>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Tested-by: Vladimir Oltean <olteanv@gmail.com>
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
index efbb34c711cb..e8f56a40b614 100644
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
@@ -2882,12 +2882,6 @@ int dsa_user_change_conduit(struct net_device *dev, struct net_device *conduit,
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



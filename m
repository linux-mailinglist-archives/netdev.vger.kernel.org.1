Return-Path: <netdev+bounces-99671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0DB8D5CA2
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 10:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04474B20FBB
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 08:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E294D131;
	Fri, 31 May 2024 08:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CGXmzr5o"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E2033993
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 08:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717143698; cv=none; b=NQo66aE3939Da40P0JmYqWW1o6ard4NFpCi3Le4FTO3rCD7oBF0FXgPXyIj2PSH8aOEhmPjKN444sh+dvilRGV6ccXRtx05vFrFRq4pa5i5bTcjv3yguxDippOTRayxcwJU1lTDJnI+qSKe0dmx5sRyyb5Be+ghZpKlBU88xf2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717143698; c=relaxed/simple;
	bh=6/b83v/rOfUknOcFiXrAGX3xT1BPG7kwSgc0tx14DfQ=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=H2wvfln45vzhTdnLPhSkr+qKe29HmyCkXlyPG7jox0HkE+t3yMTCHpU3Tvf9IrVX+LpBn+PykDeCTAbQupvuWG6y3ThUNY0csR95WpSjzSKeGQBvWlmrZzUYQLzFKz73y+n10LWR/Si2OFeOLbJSLKeZJmy1gKCKRjgNWizUOH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=CGXmzr5o; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HvkgMLItmDJrzjXZoEnRq0S5j7b6SCsLgZ+719ygOJw=; b=CGXmzr5oawkeKWKysSRvCDp9It
	r12xZnxDETEFmVxkIT03FqcPdzQ+eRKkaJHncEfBL1aYDEpacl8oPF2IOW4qkHuuJ3mKCvChYKjKz
	v0AvUyFaZbWbvGRZBzeoPFWla5/Sl9nmPgrF/kYuuFqy2a33UNAH+U0GJ5Yo5nZB8gCCwRctvJv+9
	9kVRX3BObtDnN3dkDc7fNm9v/pTevXpLetqLAnXPQTAna/fP/LnbQMrkdHgQzdB+6Jo12dfUjfugW
	S1UcZI/GDYWz4cmUILcpxkfo0T0iULSRB9pIi+mtW7XjILyx744XtAoca3W8yaqfpUvKsI+onCeYE
	zgkHgJHg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:47860 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sCxVu-0008G6-2B;
	Fri, 31 May 2024 09:21:26 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sCxVx-00EwVY-E2; Fri, 31 May 2024 09:21:29 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: dsa: remove obsolete phylink dsa_switch
 operations
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sCxVx-00EwVY-E2@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 31 May 2024 09:21:29 +0100

No driver now uses the DSA switch phylink members, so we can now remove
the shim functions and method pointers. Arrange to print an error
message and fail registration if a DSA driver does not provide the
phylink MAC operations structure.

Signed-off-by: Russell King (oracle) <rmk+kernel@armlinux.org.uk>
---
 include/net/dsa.h | 15 ----------
 net/dsa/dsa.c     |  9 ++----
 net/dsa/port.c    | 74 +----------------------------------------------
 3 files changed, 4 insertions(+), 94 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index f9ae3ca66b6f..d64bbd1f9f29 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -879,21 +879,6 @@ struct dsa_switch_ops {
 	 */
 	void	(*phylink_get_caps)(struct dsa_switch *ds, int port,
 				    struct phylink_config *config);
-	struct phylink_pcs *(*phylink_mac_select_pcs)(struct dsa_switch *ds,
-						      int port,
-						      phy_interface_t iface);
-	void	(*phylink_mac_config)(struct dsa_switch *ds, int port,
-				      unsigned int mode,
-				      const struct phylink_link_state *state);
-	void	(*phylink_mac_link_down)(struct dsa_switch *ds, int port,
-					 unsigned int mode,
-					 phy_interface_t interface);
-	void	(*phylink_mac_link_up)(struct dsa_switch *ds, int port,
-				       unsigned int mode,
-				       phy_interface_t interface,
-				       struct phy_device *phydev,
-				       int speed, int duplex,
-				       bool tx_pause, bool rx_pause);
 	void	(*phylink_fixed_state)(struct dsa_switch *ds, int port,
 				       struct phylink_link_state *state);
 	/*
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 668c729946ea..ceeadb52d1cc 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -1505,12 +1505,9 @@ static int dsa_switch_probe(struct dsa_switch *ds)
 	if (!ds->num_ports)
 		return -EINVAL;
 
-	if (ds->phylink_mac_ops) {
-		if (ds->ops->phylink_mac_select_pcs ||
-		    ds->ops->phylink_mac_config ||
-		    ds->ops->phylink_mac_link_down ||
-		    ds->ops->phylink_mac_link_up)
-			return -EINVAL;
+	if (!ds->phylink_mac_ops) {
+		dev_err(ds->dev, "DSA switch driver does not provide phylink MAC operations");
+		return -EINVAL;
 	}
 
 	if (np) {
diff --git a/net/dsa/port.c b/net/dsa/port.c
index e23db9507546..a31a5517a12f 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -1535,73 +1535,8 @@ void dsa_port_set_tag_protocol(struct dsa_port *cpu_dp,
 	cpu_dp->tag_ops = tag_ops;
 }
 
-static struct phylink_pcs *
-dsa_port_phylink_mac_select_pcs(struct phylink_config *config,
-				phy_interface_t interface)
-{
-	struct dsa_port *dp = dsa_phylink_to_port(config);
-	struct phylink_pcs *pcs = ERR_PTR(-EOPNOTSUPP);
-	struct dsa_switch *ds = dp->ds;
-
-	if (ds->ops->phylink_mac_select_pcs)
-		pcs = ds->ops->phylink_mac_select_pcs(ds, dp->index, interface);
-
-	return pcs;
-}
-
-static void dsa_port_phylink_mac_config(struct phylink_config *config,
-					unsigned int mode,
-					const struct phylink_link_state *state)
-{
-	struct dsa_port *dp = dsa_phylink_to_port(config);
-	struct dsa_switch *ds = dp->ds;
-
-	if (!ds->ops->phylink_mac_config)
-		return;
-
-	ds->ops->phylink_mac_config(ds, dp->index, mode, state);
-}
-
-static void dsa_port_phylink_mac_link_down(struct phylink_config *config,
-					   unsigned int mode,
-					   phy_interface_t interface)
-{
-	struct dsa_port *dp = dsa_phylink_to_port(config);
-	struct dsa_switch *ds = dp->ds;
-
-	if (!ds->ops->phylink_mac_link_down)
-		return;
-
-	ds->ops->phylink_mac_link_down(ds, dp->index, mode, interface);
-}
-
-static void dsa_port_phylink_mac_link_up(struct phylink_config *config,
-					 struct phy_device *phydev,
-					 unsigned int mode,
-					 phy_interface_t interface,
-					 int speed, int duplex,
-					 bool tx_pause, bool rx_pause)
-{
-	struct dsa_port *dp = dsa_phylink_to_port(config);
-	struct dsa_switch *ds = dp->ds;
-
-	if (!ds->ops->phylink_mac_link_up)
-		return;
-
-	ds->ops->phylink_mac_link_up(ds, dp->index, mode, interface, phydev,
-				     speed, duplex, tx_pause, rx_pause);
-}
-
-static const struct phylink_mac_ops dsa_port_phylink_mac_ops = {
-	.mac_select_pcs = dsa_port_phylink_mac_select_pcs,
-	.mac_config = dsa_port_phylink_mac_config,
-	.mac_link_down = dsa_port_phylink_mac_link_down,
-	.mac_link_up = dsa_port_phylink_mac_link_up,
-};
-
 int dsa_port_phylink_create(struct dsa_port *dp)
 {
-	const struct phylink_mac_ops *mac_ops;
 	struct dsa_switch *ds = dp->ds;
 	phy_interface_t mode;
 	struct phylink *pl;
@@ -1625,12 +1560,8 @@ int dsa_port_phylink_create(struct dsa_port *dp)
 		}
 	}
 
-	mac_ops = &dsa_port_phylink_mac_ops;
-	if (ds->phylink_mac_ops)
-		mac_ops = ds->phylink_mac_ops;
-
 	pl = phylink_create(&dp->pl_config, of_fwnode_handle(dp->dn), mode,
-			    mac_ops);
+			    ds->phylink_mac_ops);
 	if (IS_ERR(pl)) {
 		pr_err("error creating PHYLINK: %ld\n", PTR_ERR(pl));
 		return PTR_ERR(pl);
@@ -1831,9 +1762,6 @@ static void dsa_shared_port_link_down(struct dsa_port *dp)
 	if (ds->phylink_mac_ops && ds->phylink_mac_ops->mac_link_down)
 		ds->phylink_mac_ops->mac_link_down(&dp->pl_config, MLO_AN_FIXED,
 						   PHY_INTERFACE_MODE_NA);
-	else if (ds->ops->phylink_mac_link_down)
-		ds->ops->phylink_mac_link_down(ds, dp->index, MLO_AN_FIXED,
-					       PHY_INTERFACE_MODE_NA);
 }
 
 int dsa_shared_port_link_register_of(struct dsa_port *dp)
-- 
2.30.2



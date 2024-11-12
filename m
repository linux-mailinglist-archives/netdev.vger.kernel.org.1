Return-Path: <netdev+bounces-144154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960289C5D06
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 17:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FD76281631
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 16:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00C920409D;
	Tue, 12 Nov 2024 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="h2wtBcJq"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133CB202649
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731428415; cv=none; b=tJqZfSYYKgshKr7ljbmgO65+QOI1sxJkuyZOim0As7Shjn7+VvORk39HEm+fp+3qOu3a1arW6wAzSr7OxD1OsriO6MDOg8xfhRP8ms8rlw4OGBsw0C7YVlP9Y/y7qk59VgulAwYtBO4wKw6EQW+xxL5JjuaajixLcx3tf1Iqjkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731428415; c=relaxed/simple;
	bh=+MiBfqBwvfi3xIVUfkNkGmIspQzYF5GGdknEVwEboyw=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=e+N9JlIGtoLdweBQ0gWbOkQbLFR9Ov17Nv0sOJJfk64XbIZGrx8Y0cnYIDRUAx8uc/Dq+7jh+GY7w4MZR+Cei6qs8WN43zbpCzZOPrcfE865RD2hkKDVeM+H7yqWMwVjmrqQofbD+6MgpQ9VWSfPcwYYhwnC9HMDEN5O55MKdHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=h2wtBcJq; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PnsUv742ZhBELrN37gwbdxczzexyZwfVpy5fbI2ADkE=; b=h2wtBcJq8VGSwybR2tDWnKb83Q
	2O1yGH6KffQnG9xwnjQv21vvhHWuJjXnv4RPNPXymq2awz40vNvn9OnrksTAWNGuVuS9EA0O2UbB+
	i8C+nkWCJc4prCwrdq90K9bxiP2NgtWHnztATdAFIGCsibm59iSjmn3wr3qgtNKeW1oZslljB8ajL
	79t7bJEU98WFq8v8xC7qjweDLJHW0SEEXh4Pg4E7jwDmlDSotO6vAiNEz+1NgWkMuGGYSwffMx5n4
	EKu4Q6C+3rIegKfPxunrfw391uMO5kXHKQnpEQfqbqqbJCOPgFzmw6ef5Prf28sO/7dooxuml90W8
	POO42rhg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38952 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tAtcW-0004YP-0B;
	Tue, 12 Nov 2024 16:20:00 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tAtcW-002RBS-LB; Tue, 12 Nov 2024 16:20:00 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org
Subject: [PATCH net] net: phylink: ensure PHY momentary link-fails are handled
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tAtcW-002RBS-LB@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 12 Nov 2024 16:20:00 +0000

Normally, phylib won't notify changes in quick succession. However, as
a result of commit 3e43b903da04 ("net: phy: Immediately call
adjust_link if only tx_lpi_enabled changes") this is no longer true -
it is now possible that phy_link_down() and phy_link_up() will both
complete before phylink's resolver has run, which means it'll miss that
pl->phy_state.link momentarily became false.

Rename "mac_link_dropped" to be more generic "link_failed" since it will
cover more than the MAC/PCS end of the link failing, and arrange to set
this in phylink_phy_change() if we notice that the PHY reports that the
link is down.

This will ensure that we capture an EEE reconfiguration event.

Fixes: 3e43b903da04 ("net: phy: Immediately call adjust_link if only tx_lpi_enabled changes")
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 4309317de3d1..3e9957b6aa14 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -78,7 +78,7 @@ struct phylink {
 	unsigned int pcs_neg_mode;
 	unsigned int pcs_state;
 
-	bool mac_link_dropped;
+	bool link_failed;
 	bool using_mac_select_pcs;
 
 	struct sfp_bus *sfp_bus;
@@ -1475,9 +1475,9 @@ static void phylink_resolve(struct work_struct *w)
 		cur_link_state = pl->old_link_state;
 
 	if (pl->phylink_disable_state) {
-		pl->mac_link_dropped = false;
+		pl->link_failed = false;
 		link_state.link = false;
-	} else if (pl->mac_link_dropped) {
+	} else if (pl->link_failed) {
 		link_state.link = false;
 		retrigger = true;
 	} else {
@@ -1572,7 +1572,7 @@ static void phylink_resolve(struct work_struct *w)
 			phylink_link_up(pl, link_state);
 	}
 	if (!link_state.link && retrigger) {
-		pl->mac_link_dropped = false;
+		pl->link_failed = false;
 		queue_work(system_power_efficient_wq, &pl->resolve);
 	}
 	mutex_unlock(&pl->state_mutex);
@@ -1835,6 +1835,8 @@ static void phylink_phy_change(struct phy_device *phydev, bool up)
 		pl->phy_state.pause |= MLO_PAUSE_RX;
 	pl->phy_state.interface = phydev->interface;
 	pl->phy_state.link = up;
+	if (!up)
+		pl->link_failed = true;
 	mutex_unlock(&pl->state_mutex);
 
 	phylink_run_resolve(pl);
@@ -2158,7 +2160,7 @@ EXPORT_SYMBOL_GPL(phylink_disconnect_phy);
 static void phylink_link_changed(struct phylink *pl, bool up, const char *what)
 {
 	if (!up)
-		pl->mac_link_dropped = true;
+		pl->link_failed = true;
 	phylink_run_resolve(pl);
 	phylink_dbg(pl, "%s link %s\n", what, up ? "up" : "down");
 }
@@ -2792,7 +2794,7 @@ int phylink_ethtool_set_pauseparam(struct phylink *pl,
 	 * link will cycle.
 	 */
 	if (manual_changed) {
-		pl->mac_link_dropped = true;
+		pl->link_failed = true;
 		phylink_run_resolve(pl);
 	}
 
-- 
2.30.2



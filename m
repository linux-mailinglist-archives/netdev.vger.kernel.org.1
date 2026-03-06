Return-Path: <netdev+bounces-264639-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNhKAC5HqmlkOgEAu9opvQ
	(envelope-from <netdev+bounces-264639-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 04:17:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 034DB21AF79
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 04:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8E7D30254DE
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 03:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2769D36A000;
	Fri,  6 Mar 2026 03:16:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974CC2FF66A;
	Fri,  6 Mar 2026 03:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772767016; cv=none; b=hk8GErZd5kjRv3d2AdRtOd49qRjIiYZ6uRlFQAnSh4n5rm8rgOjxh7bvjfRlS7n/fIbwJYbOoMxeN9igCK3AXi4kuQel4pPMb7cqA6wMAjLcJdqkEJYsULdX+rP9f9LcOP5csqQTj8C0aoXZoDW+m+rlywkRRK4m4Jl8uTxuMGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772767016; c=relaxed/simple;
	bh=nRwAHeCnAx4TMPRjfJHmfOOWaJeikaxj05X7Xlnd6TA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fZr/A68fH/uNqPF+RUsv9Uvh8m2CA8ZtFC+hzooEjve9skK80Wq0brsTdO22foNCRYt4O2uyA/WAoMkpRQp3RxunuvxMmdzTKEYyT32FxEfwsAjFki9muTj71cf9H2n35S7Px2YlpV6tBHOXdbzlLtfjhlerjXbQ+EPny+A+uKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vyLg5-000000005tL-0lEa;
	Fri, 06 Mar 2026 03:16:37 +0000
Date: Fri, 6 Mar 2026 03:16:32 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: dsa: skip user_mii_bus fallback if phy-handle is set
Message-ID: <b25e764be31bcbb130d057c0f6bf25261ce605c0.1772766796.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 034DB21AF79
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264639-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	DMARC_NA(0.00)[makrotopia.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.095];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

When phylink_of_phy_connect() returns -ENODEV, dsa_user_phy_setup()
falls back to connecting the port to the PHY at dp->index on the
switch's internal MDIO bus. This fallback was introduced to handle
switches where no explicit phy-handle is given in DT. However, if a
phy-handle property is present but the referenced PHY device is not
yet available at registration time, phylink_of_phy_connect() also
returns -ENODEV, causing the fallback to potentially attach the wrong
PHY device instead of propagating the error.

This becomes a very weird bug on switches on which the PHY address
isn't equal to the corresponding DSA port's index, as failure to
attach the PHY with -ENOENT then just attaches another PHY, typically
rendering two ports unusable instead of just one (and until you read
and understand the code it looks like an alarming memory corruption
rather than just PHY not being ready on time).

Fix this by calling fwnode_get_phy_node() before falling back:
If a phy-handle fwnode exists, skip the internal bus fallback and let
the -ENODEV propagate to the caller. The fallback is only taken when
no phy-handle is present in DT, which was the original intent.

Fixes: aab9c4067d238 ("net: dsa: Plug in PHYLINK support")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 net/dsa/user.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index c4bd6fe90b455..90e540f490bb3 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -2656,6 +2656,7 @@ static int dsa_user_phy_setup(struct net_device *user_dev)
 {
 	struct dsa_port *dp = dsa_user_to_port(user_dev);
 	struct device_node *port_dn = dp->dn;
+	struct fwnode_handle *phy_fwnode;
 	struct dsa_switch *ds = dp->ds;
 	u32 phy_flags = 0;
 	int ret;
@@ -2682,9 +2683,18 @@ static int dsa_user_phy_setup(struct net_device *user_dev)
 	ret = phylink_of_phy_connect(dp->pl, port_dn, phy_flags);
 	if (ret == -ENODEV && ds->user_mii_bus) {
 		/* We could not connect to a designated PHY or SFP, so try to
-		 * use the switch internal MDIO bus instead
+		 * use the switch internal MDIO bus instead. Only fall back if
+		 * no phy-handle was specified in DT. If a phy-handle exists
+		 * but the PHY device is missing (e.g. not yet ready at
+		 * registration time), connecting to a PHY at dp->index would
+		 * attach the wrong PHY device.
 		 */
-		ret = dsa_user_phy_connect(user_dev, dp->index, phy_flags);
+		phy_fwnode = fwnode_get_phy_node(of_fwnode_handle(port_dn));
+		if (IS_ERR(phy_fwnode))
+			ret = dsa_user_phy_connect(user_dev, dp->index,
+						   phy_flags);
+		else
+			fwnode_handle_put(phy_fwnode);
 	}
 	if (ret) {
 		netdev_err(user_dev, "failed to connect to PHY: %pe\n",
-- 
2.53.0


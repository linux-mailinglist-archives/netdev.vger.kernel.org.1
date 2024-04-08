Return-Path: <netdev+bounces-85710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FAB89BE01
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 13:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5AE1F211E2
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 11:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02B8651B2;
	Mon,  8 Apr 2024 11:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="SeoQEHA2"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AEC651B3
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 11:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712575171; cv=none; b=FVajmXUb446OW5Ln16wR/hAUlCwuGmUiQp9VypmY1QyGfsREAxgg7JnRojBGmRAEcBsrTDqqL52OlSC90cs/cyM6FO4PBnqnpGUe13Kiozp3P3r5LRe/RSy+GgHm1xfP2kwIeljBRsMKppWkEvdDhmQZEHr8765UetJP0/Rie3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712575171; c=relaxed/simple;
	bh=6CZm+YaODftH3xxUY5qs/gMTNapUCJBrTT7zXmKFCrI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=dcQTY0lz/xIrk3wzBni6nfG9rZYgLjjcrutwEXfG2sF9bJAGh2W93wgfsaIIBDa1XDy2DTj2d7jZMOPjeCQHI1shHFzJmoQ/46ektIFzG6rt6B5C/61bqW2blK0PUqUzG19IOe8Czcmj/gKrEJAVAblfJNXYuWspjC2fXmB+WeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=SeoQEHA2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pliDRFiFJlkRTov+U5sCxFcoGMtMc8TcViaYwFKxGj0=; b=SeoQEHA2prrPPH+b6lUZ/1A2v/
	ZPCUCPX3kitrNK7kTWt29YdqzOiftJg7IicuatLI9e9v87b8REIlgDYc2bfJLAGnUXcKF41QwEPMv
	1puT4a+iT9HblxoQEObO9HFixyXXeWFTqF+v0L4A7ZZUtI3voJqBiPktkncBP7Txgi3Y7bcXKIMKC
	O0Voy8YYvcnDZnaXt9pgvgyjxS1W5D22Cl0r4PCsO6bOhHfMSNkk61u+93yiRIZNKxg4xhNsmzLKn
	BakrIojpsU9PuLhWUBoo05B9x2GnA2LL011kaRXhW9TRG3mV0Un9YN3EHGK8Fpzio4VCgM+Mr9k+h
	gGfqcmWg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:59274 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rtn24-00056s-0x;
	Mon, 08 Apr 2024 12:19:24 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rtn25-0065p0-2C; Mon, 08 Apr 2024 12:19:25 +0100
In-Reply-To: <ZhPSpvJfvLqWi0Hu@shell.armlinux.org.uk>
References: <ZhPSpvJfvLqWi0Hu@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	 Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	 netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 2/3] net: dsa: allow DSA switch drivers to provide
 their own phylink mac ops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rtn25-0065p0-2C@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 08 Apr 2024 12:19:25 +0100

Rather than having a shim for each and every phylink MAC operation,
allow DSA switch drivers to provide their own ops structure.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 include/net/dsa.h |  5 +++++
 net/dsa/port.c    | 29 ++++++++++++++++++++++++-----
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index f228b479a5fd..7edfd8de8882 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -457,6 +457,11 @@ struct dsa_switch {
 	 */
 	const struct dsa_switch_ops	*ops;
 
+	/*
+	 * Allow a DSA switch driver to override the phylink MAC ops
+	 */
+	const struct phylink_mac_ops	*phylink_mac_ops;
+
 	/*
 	 * User mii_bus and devices for the individual ports.
 	 */
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 02bf1c306bdc..bfacf41344df 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -1662,6 +1662,7 @@ static const struct phylink_mac_ops dsa_port_phylink_mac_ops = {
 
 int dsa_port_phylink_create(struct dsa_port *dp)
 {
+	const struct phylink_mac_ops *mac_ops;
 	struct dsa_switch *ds = dp->ds;
 	phy_interface_t mode;
 	struct phylink *pl;
@@ -1685,8 +1686,12 @@ int dsa_port_phylink_create(struct dsa_port *dp)
 		}
 	}
 
-	pl = phylink_create(&dp->pl_config, of_fwnode_handle(dp->dn),
-			    mode, &dsa_port_phylink_mac_ops);
+	mac_ops = &dsa_port_phylink_mac_ops;
+	if (ds->phylink_mac_ops)
+		mac_ops = ds->phylink_mac_ops;
+
+	pl = phylink_create(&dp->pl_config, of_fwnode_handle(dp->dn), mode,
+			    mac_ops);
 	if (IS_ERR(pl)) {
 		pr_err("error creating PHYLINK: %ld\n", PTR_ERR(pl));
 		return PTR_ERR(pl);
@@ -1952,6 +1957,22 @@ static void dsa_shared_port_validate_of(struct dsa_port *dp,
 		dn, dsa_port_is_cpu(dp) ? "CPU" : "DSA", dp->index);
 }
 
+static void dsa_shared_port_link_down(struct dsa_port *dp)
+{
+	struct dsa_switch *ds = dp->ds;
+
+	if (ds->phylink_mac_ops) {
+		if (ds->phylink_mac_ops->mac_link_down)
+			ds->phylink_mac_ops->mac_link_down(&dp->pl_config,
+							   MLO_AN_FIXED,
+							   PHY_INTERFACE_MODE_NA);
+	} else {
+		if (ds->ops->phylink_mac_link_down)
+			ds->ops->phylink_mac_link_down(ds, dp->index,
+				MLO_AN_FIXED, PHY_INTERFACE_MODE_NA);
+	}
+}
+
 int dsa_shared_port_link_register_of(struct dsa_port *dp)
 {
 	struct dsa_switch *ds = dp->ds;
@@ -1973,9 +1994,7 @@ int dsa_shared_port_link_register_of(struct dsa_port *dp)
 				 "Skipping phylink registration for %s port %d\n",
 				 dsa_port_is_cpu(dp) ? "CPU" : "DSA", dp->index);
 		} else {
-			if (ds->ops->phylink_mac_link_down)
-				ds->ops->phylink_mac_link_down(ds, port,
-					MLO_AN_FIXED, PHY_INTERFACE_MODE_NA);
+			dsa_shared_port_link_down(dp);
 
 			return dsa_shared_port_phylink_register(dp);
 		}
-- 
2.30.2



Return-Path: <netdev+bounces-244054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DF5CAE9F8
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 02:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6BB60300917B
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 01:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECAA238150;
	Tue,  9 Dec 2025 01:28:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49F11E8332;
	Tue,  9 Dec 2025 01:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765243710; cv=none; b=TmUl8U0ms97ZBqNZ0xWqFhpbszEtjNjoE7W6CcTIFkvUTUVo0mmmYVYWwUwowIgChmJvs7DqC0UWOhO1zo7IXaWFY9irNsbPAyGKAflzZs2UxFNBlFlfiQhS40c9rHNhYGe/V31a4djZ2wxcf1GyImZA0BciGXvwIFDM2NiMDHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765243710; c=relaxed/simple;
	bh=9g5o6PYCBvzzbUj8OZ+f1nNRVQVNOuF4NRAY15YHUHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0boJ/xiQ+E89OiGxuDCUG360pvux9ip47sCn5gvuWtt4eR3VvHLyA/q5nJ/NzqzX2vDU0kdHt7kMzXnpghQzMdiUq9B+XZVj/Mzuonqi3UEd46h6+yDchHiq2P2+yp+/p+fBebh+ODdP/SkHM85CBtEFPBjhIcnVOdMhvhaDhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vSmWd-000000005A9-15dG;
	Tue, 09 Dec 2025 01:28:23 +0000
Date: Tue, 9 Dec 2025 01:28:20 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Rasmus Villemoes <ravi@prevas.dk>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net v4 1/4] net: dsa: lantiq_gswip: fix order in .remove
 operation
Message-ID: <4ebd72a29edc1e4059b9666a26a0bb5d906a829a.1765241054.git.daniel@makrotopia.org>
References: <cover.1765241054.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1765241054.git.daniel@makrotopia.org>

Russell King pointed out that disabling the switch by clearing
GSWIP_MDIO_GLOB_ENABLE before calling dsa_unregister_switch() is
problematic, as it violates a Golden Rule of driver development to
always first unpublish userspace interfaces and then disable the
hardware.

Fix this, and also simplify the probe() function, by introducing a
dsa_switch_ops teardown() operation which takes care of clearing the
GSWIP_MDIO_GLOB_ENABLE bit.

Fixes: 14fceff4771e5 ("net: dsa: Add Lantiq / Intel DSA driver for vrx200")
Suggested-by: "Russell King (Oracle)" <linux@armlinux.org.uk>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v4: initial submission, not present in previous versions

 drivers/net/dsa/lantiq/lantiq_gswip.c        |  3 ---
 drivers/net/dsa/lantiq/lantiq_gswip_common.c | 13 ++++++++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
index 57dd063c07403..b094001a7c805 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
@@ -444,9 +444,6 @@ static void gswip_remove(struct platform_device *pdev)
 	if (!priv)
 		return;
 
-	/* disable the switch */
-	gswip_disable_switch(priv);
-
 	dsa_unregister_switch(priv->ds);
 
 	for (i = 0; i < priv->num_gphy_fw; i++)
diff --git a/drivers/net/dsa/lantiq/lantiq_gswip_common.c b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
index 9da39edf8f574..6b171d58e1862 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip_common.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
@@ -752,6 +752,13 @@ static int gswip_setup(struct dsa_switch *ds)
 	return 0;
 }
 
+static void gswip_teardown(struct dsa_switch *ds)
+{
+	struct gswip_priv *priv = ds->priv;
+
+	regmap_clear_bits(priv->mdio, GSWIP_MDIO_GLOB, GSWIP_MDIO_GLOB_ENABLE);
+}
+
 static enum dsa_tag_protocol gswip_get_tag_protocol(struct dsa_switch *ds,
 						    int port,
 						    enum dsa_tag_protocol mp)
@@ -1629,6 +1636,7 @@ static const struct phylink_mac_ops gswip_phylink_mac_ops = {
 static const struct dsa_switch_ops gswip_switch_ops = {
 	.get_tag_protocol	= gswip_get_tag_protocol,
 	.setup			= gswip_setup,
+	.teardown		= gswip_teardown,
 	.port_setup		= gswip_port_setup,
 	.port_enable		= gswip_port_enable,
 	.port_disable		= gswip_port_disable,
@@ -1718,15 +1726,14 @@ int gswip_probe_common(struct gswip_priv *priv, u32 version)
 
 	err = gswip_validate_cpu_port(priv->ds);
 	if (err)
-		goto disable_switch;
+		goto unregister_switch;
 
 	dev_info(priv->dev, "probed GSWIP version %lx mod %lx\n",
 		 GSWIP_VERSION_REV(version), GSWIP_VERSION_MOD(version));
 
 	return 0;
 
-disable_switch:
-	gswip_disable_switch(priv);
+unregister_switch:
 	dsa_unregister_switch(priv->ds);
 
 	return err;
-- 
2.52.0


Return-Path: <netdev+bounces-214330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EECB29054
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 21:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC5931C8875A
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 19:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9F821ABB0;
	Sat, 16 Aug 2025 19:52:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5696D21A459;
	Sat, 16 Aug 2025 19:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755373927; cv=none; b=MfWJUUSebaIszJKNq0ZMOEBp0g63OpeeIz+of/XNPhv2Et1Rxu/dgj8xk2QaSh4Gc1ecP85+6c2CkFZEM7FHNusMmd/uqhVlqF+46H5Y1h760OnlRvBM2VUAtW0FQnMWVotIxLU9z6BuDp5xuvRh2+jeti7NfUZYwA5vB5m89ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755373927; c=relaxed/simple;
	bh=YIZO24dd1xIadpm3qFi0jJ7lS3SOsW8WUHlpJpsvSTA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RlOAKa16CJ33k3OIO9QiJqQiA2y8h9idy1sGdugwq976uOgE3k4DSLMKFfN+2J8VWJgv01csudgFPA0I7ombh3+J+WGzGyctGXX7DLBlVYWExpv31c7V8vZQybFOjeVB1rfGRmu8m30/rLTJqBAfFI43ebBN8trbNMms5am628s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1unMwb-000000006y8-1BN8;
	Sat, 16 Aug 2025 19:52:01 +0000
Date: Sat, 16 Aug 2025 20:51:57 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hauke Mehrtens <hauke@hauke-m.de>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Arkadi Sharshevsky <arkadis@mellanox.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH RFC net-next 05/23] net: dsa: lantiq_gswip: introduce bitmaps
 for port types
Message-ID: <aKDhXWIjk3VYYTQh@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Instead of relying on hard-coded numbers for MII ports, introduce
bitmaps for ports with either built-in PHYs, MII or SGMII.
This is done in order to prepare for supporting MaxLinear GSW1xx ICs
which got a different layout of ports, and also support SGMII.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq_gswip.c | 15 ++++++++++++---
 drivers/net/dsa/lantiq_gswip.h |  3 +++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index 5a8fb358fb59..86e02ac0c221 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -185,14 +185,19 @@ static void gswip_mii_mask(struct gswip_priv *priv, u32 clear, u32 set,
 static void gswip_mii_mask_cfg(struct gswip_priv *priv, u32 clear, u32 set,
 			       int port)
 {
-	/* There's no MII_CFG register for the CPU port */
-	if (!dsa_is_cpu_port(priv->ds, port))
-		gswip_mii_mask(priv, clear, set, GSWIP_MII_CFGp(port));
+	if (!(priv->hw_info->mii_ports & BIT(port)))
+		return;
+
+	/* MII_CFG register only exists for MII ports */
+	gswip_mii_mask(priv, clear, set, GSWIP_MII_CFGp(port));
 }
 
 static void gswip_mii_mask_pcdu(struct gswip_priv *priv, u32 clear, u32 set,
 				int port)
 {
+	if (!(priv->hw_info->mii_ports & BIT(port)))
+		return;
+
 	switch (port) {
 	case 0:
 		gswip_mii_mask(priv, clear, set, GSWIP_MII_PCDU0);
@@ -2003,12 +2008,16 @@ static void gswip_shutdown(struct platform_device *pdev)
 static const struct gswip_hw_info gswip_xrx200 = {
 	.max_ports = 7,
 	.allowed_cpu_ports = BIT(6),
+	.phy_ports = BIT(2) | BIT(3) | BIT(4) | BIT(5),
+	.mii_ports = BIT(0) | BIT(5),
 	.phylink_get_caps = gswip_xrx200_phylink_get_caps,
 };
 
 static const struct gswip_hw_info gswip_xrx300 = {
 	.max_ports = 7,
 	.allowed_cpu_ports = BIT(6),
+	.phy_ports = BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5),
+	.mii_ports = BIT(0) | BIT(1) | BIT(5),
 	.phylink_get_caps = gswip_xrx300_phylink_get_caps,
 };
 
diff --git a/drivers/net/dsa/lantiq_gswip.h b/drivers/net/dsa/lantiq_gswip.h
index c90ddf89d0d7..3b19963f2073 100644
--- a/drivers/net/dsa/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq_gswip.h
@@ -217,6 +217,9 @@
 struct gswip_hw_info {
 	int max_ports;
 	unsigned int allowed_cpu_ports;
+	unsigned int phy_ports;
+	unsigned int mii_ports;
+	unsigned int sgmii_ports;
 	void (*phylink_get_caps)(struct dsa_switch *ds, int port,
 				 struct phylink_config *config);
 };
-- 
2.50.1


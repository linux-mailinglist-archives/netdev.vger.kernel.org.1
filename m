Return-Path: <netdev+bounces-215098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 319C1B2D1A9
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 03:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ECA21C4356E
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 01:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B9E2777E1;
	Wed, 20 Aug 2025 01:55:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92112773E8;
	Wed, 20 Aug 2025 01:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755654911; cv=none; b=PQCTE+zoMOwjzYDold8HQ3SLIiUJNINzK6tt3/QibaGG6R4qdxTPtleK9uQtAnJCXxlGSEzzQ2eOWUUcKq3bAEBn48jNwgD770UlLTUeRqXj49/mW/XausdXqGDMYpGnxU/lPogYbxqSs87SrMyt0DBqJjJ1RD+s3qf+6KztzKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755654911; c=relaxed/simple;
	bh=j4/i4eI14D5cvbJU5rU5kKzyGnX3uHlyntrNSEiv7Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U10auqTBTsLj8T3sh2Ax6sKCVHf7fvtMsu6xhn1OjfBWtAAITjVnj8ikpF6xvYsSusVFzegJ016vY96q7zZK+6vaMST1JkzLDurHlfqlGmDsVYPsecveGbLVYwxhymh4vsfoqXpTJE0EOmW/Csx90AJHLDQDb9Mx8d8flXabyX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uoY2b-000000006D4-0HbT;
	Wed, 20 Aug 2025 01:55:05 +0000
Date: Wed, 20 Aug 2025 02:55:00 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
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
Subject: [PATCH net-next v3 4/8] net: dsa: lantiq_gswip: introduce bitmap for
 MII ports
Message-ID: <4d3c8d746f7e199e2c8f8c863671f43e48e074fb.1755654392.git.daniel@makrotopia.org>
References: <cover.1755654392.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1755654392.git.daniel@makrotopia.org>

Instead of relying on hard-coded numbers for MII ports, introduce
a bitmap for MII ports.
This is done in order to prepare for supporting MaxLinear GSW1xx ICs
which got a different layout of ports.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
v3: no changes
v2:
 - move comment before 'if' statement
 - don't add unused sgmii_ports and phy_ports
 - correct bitmask for XRX200 and XRX300 (they were swapped in v1/RFC)

 drivers/net/dsa/lantiq_gswip.c | 14 +++++++++++---
 drivers/net/dsa/lantiq_gswip.h |  1 +
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index b1b250fc4f61..d988839dce2f 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -183,14 +183,20 @@ static void gswip_mii_mask(struct gswip_priv *priv, u32 clear, u32 set,
 static void gswip_mii_mask_cfg(struct gswip_priv *priv, u32 clear, u32 set,
 			       int port)
 {
-	/* There's no MII_CFG register for the CPU port */
-	if (!dsa_is_cpu_port(priv->ds, port))
-		gswip_mii_mask(priv, clear, set, GSWIP_MII_CFGp(port));
+	/* MII_CFG register only exists for MII ports */
+	if (!(priv->hw_info->mii_ports & BIT(port)))
+		return;
+
+	gswip_mii_mask(priv, clear, set, GSWIP_MII_CFGp(port));
 }
 
 static void gswip_mii_mask_pcdu(struct gswip_priv *priv, u32 clear, u32 set,
 				int port)
 {
+	/* MII_PCDU register only exists for MII ports */
+	if (!(priv->hw_info->mii_ports & BIT(port)))
+		return;
+
 	switch (port) {
 	case 0:
 		gswip_mii_mask(priv, clear, set, GSWIP_MII_PCDU0);
@@ -1993,12 +1999,14 @@ static void gswip_shutdown(struct platform_device *pdev)
 static const struct gswip_hw_info gswip_xrx200 = {
 	.max_ports = 7,
 	.allowed_cpu_ports = BIT(6),
+	.mii_ports = BIT(0) | BIT(1) | BIT(5),
 	.phylink_get_caps = gswip_xrx200_phylink_get_caps,
 };
 
 static const struct gswip_hw_info gswip_xrx300 = {
 	.max_ports = 7,
 	.allowed_cpu_ports = BIT(6),
+	.mii_ports = BIT(0) | BIT(5),
 	.phylink_get_caps = gswip_xrx300_phylink_get_caps,
 };
 
diff --git a/drivers/net/dsa/lantiq_gswip.h b/drivers/net/dsa/lantiq_gswip.h
index 8703c947028a..1bd05348f1e1 100644
--- a/drivers/net/dsa/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq_gswip.h
@@ -216,6 +216,7 @@
 struct gswip_hw_info {
 	int max_ports;
 	unsigned int allowed_cpu_ports;
+	unsigned int mii_ports;
 	void (*phylink_get_caps)(struct dsa_switch *ds, int port,
 				 struct phylink_config *config);
 };
-- 
2.50.1


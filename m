Return-Path: <netdev+bounces-230905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 08093BF1678
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 15:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF9224F6642
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 13:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED103191C5;
	Mon, 20 Oct 2025 12:58:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CA83191B0;
	Mon, 20 Oct 2025 12:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965120; cv=none; b=Y+vR3NtYYfNScobSfLqMLYmjHJeUuA1ro5ddZMnP2f0/n+ouP2HJCjV1oPjnYf+jAAA6DuDLNq+ko6ksgNyHYECmPI981AzsbXtRWRDPb2X8RlU3ZNfmZGQ312WrbuPnLFEnNL8IVsCdAmFD7GLOXf4HwAOl5WDEaF13fg3JV/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965120; c=relaxed/simple;
	bh=CESiDmUhJfxBaBUPyQBnVN9iNF0v9uAMHinPmNEEN74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=codaSzCG/iBuM83QqWBG/xTrgXfkWKiMnriKWD9MWYB81n7nu4gMBJv3F23jbv/g6ecMLldMnRJfs5tjzxEOE+NgpLWeuFPbe3n9J1twJU7oCvTdjgDIfah+TjbPVfbvo9ulWNtXUp8ABr/DI5zMXV8YVtYVH0IGNXG+LaDSc5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vApT8-000000003tE-2MT3;
	Mon, 20 Oct 2025 12:58:34 +0000
Date: Mon, 20 Oct 2025 13:58:31 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
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
Subject: [PATCH net-next v4 7/7] net: dsa: lantiq_gswip: harmonize
 gswip_mii_mask_*() parameters
Message-ID: <3665feba80d284f1bf716387644bfd48322aaf53.1760964550.git.daniel@makrotopia.org>
References: <cover.1760964550.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1760964550.git.daniel@makrotopia.org>

The 'clear' parameter of gswip_mii_mask_cfg() and gswip_mii_mask_pcdu()
is inconsistent with the semantics of regmap_write_bits() which also
applies the mask to the value to be written.
Change the semantic mask/set of the functions gswip_mii_mask_cfg() and
gswip_mii_mask_pcdu() to follow the regmap_write_bits() pattern.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq/lantiq_gswip.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
index 4a843d24ee69..b368d2fe7a61 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
@@ -120,7 +120,7 @@ static u32 gswip_switch_r_timeout(struct gswip_priv *priv, u32 offset,
 					!(val & cleared), 20, 50000);
 }
 
-static void gswip_mii_mask_cfg(struct gswip_priv *priv, u32 clear, u32 set,
+static void gswip_mii_mask_cfg(struct gswip_priv *priv, u32 mask, u32 set,
 			       int port)
 {
 	int reg_port;
@@ -131,11 +131,11 @@ static void gswip_mii_mask_cfg(struct gswip_priv *priv, u32 clear, u32 set,
 
 	reg_port = port + priv->hw_info->mii_port_reg_offset;
 
-	regmap_write_bits(priv->mii, GSWIP_MII_CFGp(reg_port), clear | set,
+	regmap_write_bits(priv->mii, GSWIP_MII_CFGp(reg_port), mask,
 			  set);
 }
 
-static void gswip_mii_mask_pcdu(struct gswip_priv *priv, u32 clear, u32 set,
+static void gswip_mii_mask_pcdu(struct gswip_priv *priv, u32 mask, u32 set,
 				int port)
 {
 	int reg_port;
@@ -148,16 +148,13 @@ static void gswip_mii_mask_pcdu(struct gswip_priv *priv, u32 clear, u32 set,
 
 	switch (reg_port) {
 	case 0:
-		regmap_write_bits(priv->mii, GSWIP_MII_PCDU0, clear | set,
-				  set);
+		regmap_write_bits(priv->mii, GSWIP_MII_PCDU0, mask, set);
 		break;
 	case 1:
-		regmap_write_bits(priv->mii, GSWIP_MII_PCDU1, clear | set,
-				  set);
+		regmap_write_bits(priv->mii, GSWIP_MII_PCDU1, mask, set);
 		break;
 	case 5:
-		regmap_write_bits(priv->mii, GSWIP_MII_PCDU5, clear | set,
-				  set);
+		regmap_write_bits(priv->mii, GSWIP_MII_PCDU5, mask, set);
 		break;
 	}
 }
@@ -1501,7 +1498,7 @@ static void gswip_phylink_mac_link_up(struct phylink_config *config,
 		gswip_port_set_pause(priv, port, tx_pause, rx_pause);
 	}
 
-	gswip_mii_mask_cfg(priv, 0, GSWIP_MII_CFG_EN, port);
+	gswip_mii_mask_cfg(priv, GSWIP_MII_CFG_EN, GSWIP_MII_CFG_EN, port);
 }
 
 static void gswip_get_strings(struct dsa_switch *ds, int port, u32 stringset,
-- 
2.51.1.dirty


Return-Path: <netdev+bounces-219372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D877AB410D6
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 01:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8687B5E35E3
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E1E27FB1E;
	Tue,  2 Sep 2025 23:36:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B45126C05;
	Tue,  2 Sep 2025 23:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756856182; cv=none; b=Pvh2A4+NmNnBz0u3BSklsb+nAI0Zyy+SjsKDhHIDOL9ecjMYEqI8MnOHZu4BAtuyZxPuTC2zH/yO8vx+YSlBYA+EJWwHjYql3bpXmaReWrfRSmDgoOPJqvZsMyVQpu+YBkEl4K1WsgFE4YxRczrc8OjEQUed1X3pgMaP53GexMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756856182; c=relaxed/simple;
	bh=2pIxf0HoF6Z6UiQch8+8jOIMygT02+QakPHOWqDwM94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fv9F0bcbLAVjPfVYbfhqGeiUjvJm8XSaMZKbCKa2hK+qIXQK7jNMxP3WzrO8ZOEZBDc7xWKbGgDoSFuj1P0onTFcpZGv3rKUetf8zYZy1AGhQOMW73f92utV0Z7/2BWTAVabME8MlcN4gCDLYIkDj4yCQKg2RRRmv1w11xaHgb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1utaXw-000000001IK-2JIC;
	Tue, 02 Sep 2025 23:36:16 +0000
Date: Wed, 3 Sep 2025 00:36:13 +0100
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
Subject: [RFC PATCH net-next 3/6] net: dsa: lantiq_gswip: manually convert
 remaining uses of read accessors
Message-ID: <08a08504d030b8b9f4587097ef81e014acc98846.1756855069.git.daniel@makrotopia.org>
References: <cover.1756855069.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756855069.git.daniel@makrotopia.org>

Manually convert the remaining uses of the read accessor functions and
remove them now that they are unused.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq/lantiq_gswip.c | 77 ++++++++++++---------------
 1 file changed, 34 insertions(+), 43 deletions(-)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
index 4c46b8f0ab3d..7ba562f02b57 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
@@ -111,21 +111,6 @@ static const struct gswip_rmon_cnt_desc gswip_rmon_cnt[] = {
 	MIB_DESC(2, 0x0E, "TxGoodBytes"),
 };
 
-static u32 gswip_switch_r(struct gswip_priv *priv, u32 offset)
-{
-	unsigned int val;
-	int ret;
-
-	ret = regmap_read(priv->gswip, offset, &val);
-	if (ret) {
-		WARN_ON_ONCE(1);
-		dev_err(priv->dev, "failed to read switch register\n");
-		return 0;
-	}
-
-	return val;
-}
-
 static void gswip_switch_mask(struct gswip_priv *priv, u32 clear, u32 set,
 			      u32 offset)
 {
@@ -147,21 +132,6 @@ static u32 gswip_switch_r_timeout(struct gswip_priv *priv, u32 offset,
 					!(val & cleared), 20, 50000);
 }
 
-static u32 gswip_mdio_r(struct gswip_priv *priv, u32 offset)
-{
-	u32 val;
-	int ret;
-
-	ret = regmap_read(priv->mdio, offset, &val);
-	if (ret) {
-		WARN_ON_ONCE(1);
-		dev_err(priv->dev, "failed to read mdio register\n");
-		return 0;
-	}
-
-	return val;
-}
-
 static void gswip_mdio_mask(struct gswip_priv *priv, u32 clear, u32 set,
 			    u32 offset)
 {
@@ -255,6 +225,7 @@ static int gswip_mdio_wr(struct mii_bus *bus, int addr, int reg, u16 val)
 static int gswip_mdio_rd(struct mii_bus *bus, int addr, int reg)
 {
 	struct gswip_priv *priv = bus->priv;
+	u32 val;
 	int err;
 
 	err = gswip_mdio_poll(priv);
@@ -274,7 +245,11 @@ static int gswip_mdio_rd(struct mii_bus *bus, int addr, int reg)
 		return err;
 	}
 
-	return gswip_mdio_r(priv, GSWIP_MDIO_READ);
+	err = regmap_read(priv->mdio, GSWIP_MDIO_READ, &val);
+	if (err)
+		return err;
+
+	return val;
 }
 
 static int gswip_mdio(struct gswip_priv *priv)
@@ -318,6 +293,7 @@ static int gswip_pce_table_entry_read(struct gswip_priv *priv,
 	int i;
 	int err;
 	u16 crtl;
+	u32 tmp;
 	u16 addr_mode = tbl->key_mode ? GSWIP_PCE_TBL_CTRL_OPMOD_KSRD :
 					GSWIP_PCE_TBL_CTRL_OPMOD_ADRD;
 
@@ -343,16 +319,29 @@ static int gswip_pce_table_entry_read(struct gswip_priv *priv,
 		return err;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(tbl->key); i++)
-		tbl->key[i] = gswip_switch_r(priv, GSWIP_PCE_TBL_KEY(i));
-
-	for (i = 0; i < ARRAY_SIZE(tbl->val); i++)
-		tbl->val[i] = gswip_switch_r(priv, GSWIP_PCE_TBL_VAL(i));
+	for (i = 0; i < ARRAY_SIZE(tbl->key); i++) {
+		err = regmap_read(priv->gswip, GSWIP_PCE_TBL_KEY(i), &tmp);
+		if (err)
+			return err;
+		tbl->key[i] = tmp;
+	}
+	for (i = 0; i < ARRAY_SIZE(tbl->val); i++) {
+		err = regmap_read(priv->gswip, GSWIP_PCE_TBL_VAL(i), &tmp);
+		if (err)
+			return err;
+		tbl->val[i] = tmp;
+	}
 
-	tbl->mask = gswip_switch_r(priv, GSWIP_PCE_TBL_MASK);
+	err = regmap_read(priv->gswip, GSWIP_PCE_TBL_MASK, &tmp);
+	if (err)
+		return err;
 
-	crtl = gswip_switch_r(priv, GSWIP_PCE_TBL_CTRL);
+	tbl->mask = tmp;
+	err = regmap_read(priv->gswip, GSWIP_PCE_TBL_CTRL, &tmp);
+	if (err)
+		return err;
 
+	crtl = tmp;
 	tbl->type = !!(crtl & GSWIP_PCE_TBL_CTRL_TYPE);
 	tbl->valid = !!(crtl & GSWIP_PCE_TBL_CTRL_VLD);
 	tbl->gmap = (crtl & GSWIP_PCE_TBL_CTRL_GMAP_MASK) >> 7;
@@ -368,6 +357,7 @@ static int gswip_pce_table_entry_write(struct gswip_priv *priv,
 	int i;
 	int err;
 	u16 crtl;
+	u32 tmp;
 	u16 addr_mode = tbl->key_mode ? GSWIP_PCE_TBL_CTRL_OPMOD_KSWR :
 					GSWIP_PCE_TBL_CTRL_OPMOD_ADWR;
 
@@ -399,9 +389,9 @@ static int gswip_pce_table_entry_write(struct gswip_priv *priv,
 
 	regmap_write(priv->gswip, GSWIP_PCE_TBL_MASK, tbl->mask);
 
-	crtl = gswip_switch_r(priv, GSWIP_PCE_TBL_CTRL);
-	crtl &= ~(GSWIP_PCE_TBL_CTRL_TYPE | GSWIP_PCE_TBL_CTRL_VLD |
-		  GSWIP_PCE_TBL_CTRL_GMAP_MASK);
+	regmap_read(priv->gswip, GSWIP_PCE_TBL_CTRL, &tmp);
+	crtl = tmp & ~(GSWIP_PCE_TBL_CTRL_TYPE | GSWIP_PCE_TBL_CTRL_VLD |
+		       GSWIP_PCE_TBL_CTRL_GMAP_MASK);
 	if (tbl->type)
 		crtl |= GSWIP_PCE_TBL_CTRL_TYPE;
 	if (tbl->valid)
@@ -1563,7 +1553,7 @@ static void gswip_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 static u32 gswip_bcm_ram_entry_read(struct gswip_priv *priv, u32 table,
 				    u32 index)
 {
-	u32 result;
+	u32 result, val;
 	int err;
 
 	regmap_write(priv->gswip, GSWIP_BM_RAM_ADDR, index);
@@ -1581,7 +1571,8 @@ static u32 gswip_bcm_ram_entry_read(struct gswip_priv *priv, u32 table,
 	}
 
 	regmap_read(priv->gswip, GSWIP_BM_RAM_VAL(0), &result);
-	result |= gswip_switch_r(priv, GSWIP_BM_RAM_VAL(1)) << 16;
+	regmap_read(priv->gswip, GSWIP_BM_RAM_VAL(1), &val);
+	result |= val << 16;
 
 	return result;
 }
-- 
2.51.0


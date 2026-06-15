Return-Path: <netdev+bounces-299325-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zVBDD8iML2rQCAUAu9opvQ
	(envelope-from <netdev+bounces-299325-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 07:25:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A38D4683721
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 07:25:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299325-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299325-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A277300A137
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 05:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F05630BB9B;
	Mon, 15 Jun 2026 05:22:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6845A3093B8;
	Mon, 15 Jun 2026 05:22:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781500925; cv=none; b=r877awZrCwqpF6jfmsb4FWRyo+1PHga/WqdImjdFyW5WjngbAYGdg4LjvnvTgywkc2s8wUlfPudl5tMVEsq++nBGtEJ20p5pc3D8cW3qczdEY/x/E7/V199KQ9EqTbMfg5nHhh4rJeijcSlmzRsnA5mTECuqvj193TKjDHbfgNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781500925; c=relaxed/simple;
	bh=7D6bBK7t5TfbcDi2A8hwguK/J/Wi668cd1S8/CoHUyc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCOZdG7S8P0XMjOSjmbwuleFVQN9RbYMKgnzAvO18MSXdoXbHaQLtijkZBAhZMntbVzyrbBYWhUD5g7OiSETjERlk4MFW5E6th7w++RHpCwPwurtRxDAyLpLUBun1kZ4bNwIeYs7mvC+2HyZTYgjmOzyTLthejYrizBOW14PPdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wYzll-000000000yO-1y6J;
	Mon, 15 Jun 2026 05:21:57 +0000
Date: Mon, 15 Jun 2026 06:21:54 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v3 6/8] net: dsa: mt7530: convert to use field
 accessor macros
Message-ID: <7855d55348cc1b8ae7d3e52df398ac94c2993386.1781500517.git.daniel@makrotopia.org>
References: <cover.1781500517.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781500517.git.daniel@makrotopia.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299325-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:chester.a.unal@arinc9.com,m:daniel@makrotopia.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[arinc9.com,makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,armlinux.org.uk,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[makrotopia.org:email,makrotopia.org:mid,makrotopia.org:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A38D4683721

Use FIELD_GET and FIELD_PREP instead of open-coding register fields.
Replace 0x1f constant with (PHY_MAX_ADDR - 1).

Some field macros (ATC_HASH and VTCR_VID) were previously defined as
object-like macros referencing an undeclared 'x' and were therefore
unusable; convert them into proper FIELD_PREP() accessors. The masks are
equivalent to the open-coded values they replace, so there is no
functional change.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>

---
v3:
 * name the age timer field AGE_TIMER_MASK instead of AGE_TIMER_RD_MASK
 * note the corrected ATC_HASH/VTCR_VID macros in the commit message

v2: no changes

 drivers/net/dsa/mt7530.c |  64 ++++++------
 drivers/net/dsa/mt7530.h | 208 ++++++++++++++++++++++-----------------
 2 files changed, 148 insertions(+), 124 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index bd4892918f01..397f5c5e17e5 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -208,16 +208,16 @@ mt7530_fdb_read(struct mt7530_priv *priv, struct mt7530_fdb *fdb)
 			__func__, __LINE__, i, reg[i]);
 	}
 
-	fdb->vid = (reg[1] >> CVID) & CVID_MASK;
-	fdb->aging = (reg[2] >> AGE_TIMER) & AGE_TIMER_MASK;
-	fdb->port_mask = (reg[2] >> PORT_MAP) & PORT_MAP_MASK;
-	fdb->mac[0] = (reg[0] >> MAC_BYTE_0) & MAC_BYTE_MASK;
-	fdb->mac[1] = (reg[0] >> MAC_BYTE_1) & MAC_BYTE_MASK;
-	fdb->mac[2] = (reg[0] >> MAC_BYTE_2) & MAC_BYTE_MASK;
-	fdb->mac[3] = (reg[0] >> MAC_BYTE_3) & MAC_BYTE_MASK;
-	fdb->mac[4] = (reg[1] >> MAC_BYTE_4) & MAC_BYTE_MASK;
-	fdb->mac[5] = (reg[1] >> MAC_BYTE_5) & MAC_BYTE_MASK;
-	fdb->noarp = ((reg[2] >> ENT_STATUS) & ENT_STATUS_MASK) == STATIC_ENT;
+	fdb->vid = FIELD_GET(CVID_MASK, reg[1]);
+	fdb->aging = FIELD_GET(AGE_TIMER_MASK, reg[2]);
+	fdb->port_mask = FIELD_GET(PORT_MAP_MASK, reg[2]);
+	fdb->mac[0] = FIELD_GET(MAC_BYTE_0_MASK, reg[0]);
+	fdb->mac[1] = FIELD_GET(MAC_BYTE_1_MASK, reg[0]);
+	fdb->mac[2] = FIELD_GET(MAC_BYTE_2_MASK, reg[0]);
+	fdb->mac[3] = FIELD_GET(MAC_BYTE_3_MASK, reg[0]);
+	fdb->mac[4] = FIELD_GET(MAC_BYTE_4_MASK, reg[1]);
+	fdb->mac[5] = FIELD_GET(MAC_BYTE_5_MASK, reg[1]);
+	fdb->noarp = FIELD_GET(ENT_STATUS_MASK, reg[2]) == STATIC_ENT;
 }
 
 static void
@@ -228,22 +228,22 @@ mt7530_fdb_write(struct mt7530_priv *priv, u16 vid,
 	u32 reg[3] = { 0 };
 	int i;
 
-	reg[1] |= vid & CVID_MASK;
+	reg[1] |= FIELD_PREP(CVID_MASK, vid);
 	reg[1] |= ATA2_IVL;
 	reg[1] |= ATA2_FID(FID_BRIDGED);
-	reg[2] |= (aging & AGE_TIMER_MASK) << AGE_TIMER;
-	reg[2] |= (port_mask & PORT_MAP_MASK) << PORT_MAP;
+	reg[2] |= FIELD_PREP(AGE_TIMER_MASK, aging);
+	reg[2] |= FIELD_PREP(PORT_MAP_MASK, port_mask);
 	/* STATIC_ENT indicate that entry is static wouldn't
 	 * be aged out and STATIC_EMP specified as erasing an
 	 * entry
 	 */
-	reg[2] |= (type & ENT_STATUS_MASK) << ENT_STATUS;
-	reg[1] |= mac[5] << MAC_BYTE_5;
-	reg[1] |= mac[4] << MAC_BYTE_4;
-	reg[0] |= mac[3] << MAC_BYTE_3;
-	reg[0] |= mac[2] << MAC_BYTE_2;
-	reg[0] |= mac[1] << MAC_BYTE_1;
-	reg[0] |= mac[0] << MAC_BYTE_0;
+	reg[2] |= FIELD_PREP(ENT_STATUS_MASK, type);
+	reg[1] |= FIELD_PREP(MAC_BYTE_5_MASK, mac[5]);
+	reg[1] |= FIELD_PREP(MAC_BYTE_4_MASK, mac[4]);
+	reg[0] |= FIELD_PREP(MAC_BYTE_3_MASK, mac[3]);
+	reg[0] |= FIELD_PREP(MAC_BYTE_2_MASK, mac[2]);
+	reg[0] |= FIELD_PREP(MAC_BYTE_1_MASK, mac[1]);
+	reg[0] |= FIELD_PREP(MAC_BYTE_0_MASK, mac[0]);
 
 	/* Write array into the ARL table */
 	for (i = 0; i < 3; i++)
@@ -385,22 +385,22 @@ mt7531_pll_setup(struct mt7530_priv *priv)
 
 	/* Step 4: program COREPLL output frequency to 500MHz */
 	regmap_read(priv->regmap, MT7531_PLLGP_CR0, &val);
-	val &= ~RG_COREPLL_POSDIV_M;
-	val |= 2 << RG_COREPLL_POSDIV_S;
+	val &= ~RG_COREPLL_POSDIV_MASK;
+	val |= RG_COREPLL_POSDIV(2);
 	regmap_write(priv->regmap, MT7531_PLLGP_CR0, val);
 	usleep_range(25, 35);
 
 	switch (xtal) {
 	case MT7531_XTAL_FSEL_25MHZ:
 		regmap_read(priv->regmap, MT7531_PLLGP_CR0, &val);
-		val &= ~RG_COREPLL_SDM_PCW_M;
-		val |= 0x140000 << RG_COREPLL_SDM_PCW_S;
+		val &= ~RG_COREPLL_SDM_PCW_MASK;
+		val |= RG_COREPLL_SDM_PCW(0x140000);
 		regmap_write(priv->regmap, MT7531_PLLGP_CR0, val);
 		break;
 	case MT7531_XTAL_FSEL_40MHZ:
 		regmap_read(priv->regmap, MT7531_PLLGP_CR0, &val);
-		val &= ~RG_COREPLL_SDM_PCW_M;
-		val |= 0x190000 << RG_COREPLL_SDM_PCW_S;
+		val &= ~RG_COREPLL_SDM_PCW_MASK;
+		val |= RG_COREPLL_SDM_PCW(0x190000);
 		regmap_write(priv->regmap, MT7531_PLLGP_CR0, val);
 		break;
 	}
@@ -1555,7 +1555,7 @@ mt7530_vlan_cmd(struct mt7530_priv *priv, enum mt7530_vlan_cmd cmd, u16 vid)
 	u32 val;
 	int ret;
 
-	val = VTCR_BUSY | VTCR_FUNC(cmd) | vid;
+	val = VTCR_BUSY | VTCR_FUNC(cmd) | VTCR_VID(vid);
 	regmap_write(priv->regmap, MT7530_VTCR, val);
 
 	INIT_MT7530_DUMMY_POLL(&p, priv, MT7530_VTCR);
@@ -1786,7 +1786,7 @@ mt7530_port_mdb_add(struct dsa_switch *ds, int port,
 	mt7530_fdb_write(priv, vid, 0, addr, 0, STATIC_EMP);
 	if (!mt7530_fdb_cmd(priv, MT7530_FDB_READ, NULL)) {
 		regmap_read(priv->regmap, MT7530_ATRD, &val);
-		port_mask = (val >> PORT_MAP) & PORT_MAP_MASK;
+		port_mask = FIELD_GET(PORT_MAP_MASK, val);
 	}
 
 	port_mask |= BIT(port);
@@ -1815,7 +1815,7 @@ mt7530_port_mdb_del(struct dsa_switch *ds, int port,
 	mt7530_fdb_write(priv, vid, 0, addr, 0, STATIC_EMP);
 	if (!mt7530_fdb_cmd(priv, MT7530_FDB_READ, NULL)) {
 		regmap_read(priv->regmap, MT7530_ATRD, &val);
-		port_mask = (val >> PORT_MAP) & PORT_MAP_MASK;
+		port_mask = FIELD_GET(PORT_MAP_MASK, val);
 	}
 
 	port_mask &= ~BIT(port);
@@ -1923,7 +1923,7 @@ mt7530_hw_vlan_update(struct mt7530_priv *priv, u16 vid,
 
 	regmap_read(priv->regmap, MT7530_VAWD1, &val);
 
-	entry->old_members = (val >> PORT_MEM_SHFT) & PORT_MEM_MASK;
+	entry->old_members = FIELD_GET(PORT_MEM_MASK, val);
 
 	/* Manipulate entry */
 	vlan_op(priv, entry);
@@ -2436,7 +2436,7 @@ mt7530_setup(struct dsa_switch *ds)
 	}
 
 	regmap_read(priv->regmap, MT7530_CREV, &id);
-	id >>= CHIP_NAME_SHIFT;
+	id = FIELD_GET(CHIP_NAME_MASK, id);
 	if (id != MT7530_ID) {
 		dev_err(priv->dev, "chip %x can't be supported\n", id);
 		return -ENODEV;
@@ -2679,7 +2679,7 @@ mt7531_setup(struct dsa_switch *ds)
 	}
 
 	regmap_read(priv->regmap, MT7531_CREV, &id);
-	id >>= CHIP_NAME_SHIFT;
+	id = FIELD_GET(CHIP_NAME_MASK, id);
 
 	if (id != MT7531_ID) {
 		dev_err(priv->dev, "chip %x can't be supported\n", id);
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index dd33b0df3419..804c2e0991a0 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -6,6 +6,8 @@
 #ifndef __MT7530_H
 #define __MT7530_H
 
+#include <linux/bitfield.h>
+
 #define MT7530_NUM_PORTS		7
 #define MT7530_NUM_PHYS			5
 #define MT7530_NUM_FDB_RECORDS		2048
@@ -146,19 +148,22 @@ enum mt753x_to_cpu_fw {
 #define  STATIC_ENT			3
 #define MT7530_ATA2			0x78
 #define  ATA2_IVL			BIT(15)
-#define  ATA2_FID(x)			(((x) & 0x7) << 12)
+#define  ATA2_FID_MASK			GENMASK(14, 12)
+#define  ATA2_FID(x)			FIELD_PREP(ATA2_FID_MASK, x)
 
 /* Register for address table write data */
 #define MT7530_ATWD			0x7c
 
 /* Register for address table control */
 #define MT7530_ATC			0x80
-#define  ATC_HASH			(((x) & 0xfff) << 16)
+#define  ATC_HASH_MASK			GENMASK(27, 16)
+#define  ATC_HASH(x)			FIELD_PREP(ATC_HASH_MASK, x)
 #define  ATC_BUSY			BIT(15)
 #define  ATC_SRCH_END			BIT(14)
 #define  ATC_SRCH_HIT			BIT(13)
 #define  ATC_INVALID			BIT(12)
-#define  ATC_MAT(x)			(((x) & 0xf) << 8)
+#define  ATC_MAT_MASK			GENMASK(11, 8)
+#define  ATC_MAT(x)			FIELD_PREP(ATC_MAT_MASK, x)
 #define  ATC_MAT_MACTAB			ATC_MAT(0)
 
 enum mt7530_fdb_cmd {
@@ -171,32 +176,29 @@ enum mt7530_fdb_cmd {
 
 /* Registers for table search read address */
 #define MT7530_TSRA1			0x84
-#define  MAC_BYTE_0			24
-#define  MAC_BYTE_1			16
-#define  MAC_BYTE_2			8
-#define  MAC_BYTE_3			0
-#define  MAC_BYTE_MASK			0xff
+#define  MAC_BYTE_0_MASK		GENMASK(31, 24)
+#define  MAC_BYTE_1_MASK		GENMASK(23, 16)
+#define  MAC_BYTE_2_MASK		GENMASK(15, 8)
+#define  MAC_BYTE_3_MASK		GENMASK(7, 0)
 
 #define MT7530_TSRA2			0x88
-#define  MAC_BYTE_4			24
-#define  MAC_BYTE_5			16
-#define  CVID				0
-#define  CVID_MASK			0xfff
+#define  MAC_BYTE_4_MASK		GENMASK(31, 24)
+#define  MAC_BYTE_5_MASK		GENMASK(23, 16)
+#define  CVID_MASK			GENMASK(11, 0)
 
 #define MT7530_ATRD			0x8C
-#define	 AGE_TIMER			24
-#define  AGE_TIMER_MASK			0xff
-#define  PORT_MAP			4
-#define  PORT_MAP_MASK			0xff
-#define  ENT_STATUS			2
-#define  ENT_STATUS_MASK		0x3
+#define  AGE_TIMER_MASK			GENMASK(31, 24)
+#define  PORT_MAP_MASK			GENMASK(11, 4)
+#define  ENT_STATUS_MASK		GENMASK(3, 2)
 
 /* Register for vlan table control */
 #define MT7530_VTCR			0x90
 #define  VTCR_BUSY			BIT(31)
 #define  VTCR_INVALID			BIT(16)
-#define  VTCR_FUNC(x)			(((x) & 0xf) << 12)
-#define  VTCR_VID			((x) & 0xfff)
+#define  VTCR_FUNC_MASK			GENMASK(15, 12)
+#define  VTCR_FUNC(x)			FIELD_PREP(VTCR_FUNC_MASK, x)
+#define  VTCR_VID_MASK			GENMASK(11, 0)
+#define  VTCR_VID(x)			FIELD_PREP(VTCR_VID_MASK, x)
 
 enum mt7530_vlan_cmd {
 	/* Read/Write the specified VID entry from VAWD register based
@@ -216,13 +218,13 @@ enum mt7530_vlan_cmd {
 /* Per VLAN Egress Tag Control */
 #define  VTAG_EN			BIT(28)
 /* VLAN Member Control */
-#define  PORT_MEM(x)			(((x) & 0xff) << 16)
+#define  PORT_MEM_MASK			GENMASK(23, 16)
+#define  PORT_MEM(x)			FIELD_PREP(PORT_MEM_MASK, x)
 /* Filter ID */
-#define  FID(x)				(((x) & 0x7) << 1)
+#define  FID_MASK			GENMASK(3, 1)
+#define  FID(x)				FIELD_PREP(FID_MASK, x)
 /* VLAN Entry Valid */
 #define  VLAN_VALID			BIT(0)
-#define  PORT_MEM_SHFT			16
-#define  PORT_MEM_MASK			0xff
 
 enum mt7530_fid {
 	FID_STANDALONE = 0,
@@ -247,11 +249,11 @@ enum mt7530_vlan_egress_attr {
 /* Age count */
 #define  AGE_CNT_MASK			GENMASK(19, 12)
 #define  AGE_CNT_MAX			0xff
-#define  AGE_CNT(x)			(AGE_CNT_MASK & ((x) << 12))
+#define  AGE_CNT(x)			FIELD_PREP(AGE_CNT_MASK, x)
 /* Age unit */
 #define  AGE_UNIT_MASK			GENMASK(11, 0)
 #define  AGE_UNIT_MAX			0xfff
-#define  AGE_UNIT(x)			(AGE_UNIT_MASK & (x))
+#define  AGE_UNIT(x)			FIELD_PREP(AGE_UNIT_MASK, x)
 
 #define MT753X_ERLCR_P(x)		(0x1040 + ((x) * 0x100))
 #define  ERLCR_CIR_MASK			GENMASK(31, 16)
@@ -282,30 +284,31 @@ enum mt7530_stp_state {
 #define MT7530_PCR_P(x)			(0x2004 + ((x) * 0x100))
 #define  PORT_TX_MIR			BIT(9)
 #define  PORT_RX_MIR			BIT(8)
-#define  PORT_VLAN(x)			((x) & 0x3)
+#define  PCR_PORT_VLAN_MASK		GENMASK(1, 0)
 
 enum mt7530_port_mode {
 	/* Port Matrix Mode: Frames are forwarded by the PCR_MATRIX members. */
-	MT7530_PORT_MATRIX_MODE = PORT_VLAN(0),
+	MT7530_PORT_MATRIX_MODE = 0,
 
 	/* Fallback Mode: Forward received frames with ingress ports that do
 	 * not belong to the VLAN member. Frames whose VID is not listed on
 	 * the VLAN table are forwarded by the PCR_MATRIX members.
 	 */
-	MT7530_PORT_FALLBACK_MODE = PORT_VLAN(1),
+	MT7530_PORT_FALLBACK_MODE = 1,
 
 	/* Security Mode: Discard any frame due to ingress membership
 	 * violation or VID missed on the VLAN table.
 	 */
-	MT7530_PORT_SECURITY_MODE = PORT_VLAN(3),
+	MT7530_PORT_SECURITY_MODE = 3,
 };
 
-#define  PCR_MATRIX(x)			(((x) & 0xff) << 16)
-#define  PORT_PRI(x)			(((x) & 0x7) << 24)
-#define  EG_TAG(x)			(((x) & 0x3) << 28)
-#define  PCR_MATRIX_MASK		PCR_MATRIX(0xff)
+#define  PCR_MATRIX_MASK		GENMASK(23, 16)
+#define  PCR_MATRIX(x)			FIELD_PREP(PCR_MATRIX_MASK, x)
+#define  PORT_PRI_MASK			GENMASK(26, 24)
+#define  PORT_PRI(x)			FIELD_PREP(PORT_PRI_MASK, x)
+#define  EG_TAG_MASK			GENMASK(29, 28)
+#define  EG_TAG(x)			FIELD_PREP(EG_TAG_MASK, x)
 #define  PCR_MATRIX_CLR			PCR_MATRIX(0)
-#define  PCR_PORT_VLAN_MASK		PORT_VLAN(3)
 
 /* Register for port security control */
 #define MT7530_PSC_P(x)			(0x200c + ((x) * 0x100))
@@ -314,10 +317,10 @@ enum mt7530_port_mode {
 /* Register for port vlan control */
 #define MT7530_PVC_P(x)			(0x2010 + ((x) * 0x100))
 #define  PORT_SPEC_TAG			BIT(5)
-#define  PVC_EG_TAG(x)			(((x) & 0x7) << 8)
-#define  PVC_EG_TAG_MASK		PVC_EG_TAG(7)
-#define  VLAN_ATTR(x)			(((x) & 0x3) << 6)
-#define  VLAN_ATTR_MASK			VLAN_ATTR(3)
+#define  PVC_EG_TAG_MASK		GENMASK(10, 8)
+#define  PVC_EG_TAG(x)			FIELD_PREP(PVC_EG_TAG_MASK, x)
+#define  VLAN_ATTR_MASK			GENMASK(7, 6)
+#define  VLAN_ATTR(x)			FIELD_PREP(VLAN_ATTR_MASK, x)
 #define  ACC_FRM_MASK			GENMASK(1, 0)
 
 enum mt7530_vlan_port_eg_tag {
@@ -337,12 +340,13 @@ enum mt7530_vlan_port_acc_frm {
 	MT7530_VLAN_ACC_UNTAGGED = 2,
 };
 
-#define  STAG_VPID			(((x) & 0xffff) << 16)
+#define  STAG_VPID_MASK			GENMASK(31, 16)
+#define  STAG_VPID(x)			FIELD_PREP(STAG_VPID_MASK, x)
 
 /* Register for port port-and-protocol based vlan 1 control */
 #define MT7530_PPBV1_P(x)		(0x2014 + ((x) * 0x100))
-#define  G0_PORT_VID(x)			(((x) & 0xfff) << 0)
-#define  G0_PORT_VID_MASK		G0_PORT_VID(0xfff)
+#define  G0_PORT_VID_MASK		GENMASK(11, 0)
+#define  G0_PORT_VID(x)			FIELD_PREP(G0_PORT_VID_MASK, x)
 #define  G0_PORT_VID_DEF		G0_PORT_VID(0)
 
 /* Register for port MAC control register */
@@ -418,8 +422,8 @@ enum mt7530_vlan_port_acc_frm {
 #define  MT7531_DIS_CLR			BIT(31)
 
 #define MT7530_GMACCR			0x30e0
-#define  MAX_RX_JUMBO(x)		((x) << 2)
 #define  MAX_RX_JUMBO_MASK		GENMASK(5, 2)
+#define  MAX_RX_JUMBO(x)		FIELD_PREP(MAX_RX_JUMBO_MASK, x)
 #define  MAX_RX_PKT_LEN_MASK		GENMASK(1, 0)
 #define  MAX_RX_PKT_LEN_1522		0x0
 #define  MAX_RX_PKT_LEN_1536		0x1
@@ -505,16 +509,16 @@ enum mt7530_vlan_port_acc_frm {
 /* Register for PHY Indirect Access Control */
 #define MT7531_PHY_IAC			0x701C
 #define  MT7531_PHY_ACS_ST		BIT(31)
-#define  MT7531_MDIO_REG_ADDR_MASK	(0x1f << 25)
-#define  MT7531_MDIO_PHY_ADDR_MASK	(0x1f << 20)
-#define  MT7531_MDIO_CMD_MASK		(0x3 << 18)
-#define  MT7531_MDIO_ST_MASK		(0x3 << 16)
-#define  MT7531_MDIO_RW_DATA_MASK	(0xffff)
-#define  MT7531_MDIO_REG_ADDR(x)	(((x) & 0x1f) << 25)
-#define  MT7531_MDIO_DEV_ADDR(x)	(((x) & 0x1f) << 25)
-#define  MT7531_MDIO_PHY_ADDR(x)	(((x) & 0x1f) << 20)
-#define  MT7531_MDIO_CMD(x)		(((x) & 0x3) << 18)
-#define  MT7531_MDIO_ST(x)		(((x) & 0x3) << 16)
+#define  MT7531_MDIO_REG_ADDR_MASK	GENMASK(29, 25)
+#define  MT7531_MDIO_PHY_ADDR_MASK	GENMASK(24, 20)
+#define  MT7531_MDIO_CMD_MASK		GENMASK(19, 18)
+#define  MT7531_MDIO_ST_MASK		GENMASK(17, 16)
+#define  MT7531_MDIO_RW_DATA_MASK	GENMASK(15, 0)
+#define  MT7531_MDIO_REG_ADDR(x)	FIELD_PREP(MT7531_MDIO_REG_ADDR_MASK, x)
+#define  MT7531_MDIO_DEV_ADDR(x)	FIELD_PREP(MT7531_MDIO_REG_ADDR_MASK, x)
+#define  MT7531_MDIO_PHY_ADDR(x)	FIELD_PREP(MT7531_MDIO_PHY_ADDR_MASK, x)
+#define  MT7531_MDIO_CMD(x)		FIELD_PREP(MT7531_MDIO_CMD_MASK, x)
+#define  MT7531_MDIO_ST(x)		FIELD_PREP(MT7531_MDIO_ST_MASK, x)
 
 enum mt7531_phy_iac_cmd {
 	MT7531_MDIO_ADDR = 0,
@@ -542,14 +546,14 @@ enum mt7531_mdio_st {
 
 /* Register for RGMII clock phase */
 #define MT7531_CLKGEN_CTRL		0x7500
-#define  CLK_SKEW_OUT(x)		(((x) & 0x3) << 8)
 #define  CLK_SKEW_OUT_MASK		GENMASK(9, 8)
-#define  CLK_SKEW_IN(x)			(((x) & 0x3) << 6)
+#define  CLK_SKEW_OUT(x)		FIELD_PREP(CLK_SKEW_OUT_MASK, x)
 #define  CLK_SKEW_IN_MASK		GENMASK(7, 6)
+#define  CLK_SKEW_IN(x)			FIELD_PREP(CLK_SKEW_IN_MASK, x)
 #define  RXCLK_NO_DELAY			BIT(5)
 #define  TXCLK_NO_REVERSE		BIT(4)
-#define  GP_MODE(x)			(((x) & 0x3) << 1)
 #define  GP_MODE_MASK			GENMASK(2, 1)
+#define  GP_MODE(x)			FIELD_PREP(GP_MODE_MASK, x)
 #define  GP_CLK_EN			BIT(0)
 
 enum mt7531_gp_mode {
@@ -599,8 +603,10 @@ enum mt7531_xtal_fsel {
 #define  PAD_MCM_SMI_EN			BIT(0)
 
 #define MT7530_IO_DRV_CR		0x7810
-#define  P5_IO_CLK_DRV(x)		((x) & 0x3)
-#define  P5_IO_DATA_DRV(x)		(((x) & 0x3) << 4)
+#define  P5_IO_CLK_DRV_MASK		GENMASK(1, 0)
+#define  P5_IO_CLK_DRV(x)		FIELD_PREP(P5_IO_CLK_DRV_MASK, x)
+#define  P5_IO_DATA_DRV_MASK		GENMASK(5, 4)
+#define  P5_IO_DATA_DRV(x)		FIELD_PREP(P5_IO_DATA_DRV_MASK, x)
 
 #define MT7531_CHIP_REV			0x781C
 
@@ -610,15 +616,15 @@ enum mt7531_xtal_fsel {
 #define  SW_PLLGP			BIT(0)
 
 #define MT7530_P6ECR			0x7830
-#define  P6_INTF_MODE_MASK		0x3
-#define  P6_INTF_MODE(x)		((x) & 0x3)
+#define  P6_INTF_MODE_MASK		GENMASK(1, 0)
+#define  P6_INTF_MODE(x)		FIELD_PREP(P6_INTF_MODE_MASK, x)
 
 #define MT7531_PLLGP_CR0		0x78a8
 #define  RG_COREPLL_EN			BIT(22)
-#define  RG_COREPLL_POSDIV_S		23
-#define  RG_COREPLL_POSDIV_M		0x3800000
-#define  RG_COREPLL_SDM_PCW_S		1
-#define  RG_COREPLL_SDM_PCW_M		0x3ffffe
+#define  RG_COREPLL_POSDIV_MASK		GENMASK(25, 23)
+#define  RG_COREPLL_POSDIV(x)		FIELD_PREP(RG_COREPLL_POSDIV_MASK, x)
+#define  RG_COREPLL_SDM_PCW_MASK	GENMASK(21, 1)
+#define  RG_COREPLL_SDM_PCW(x)		FIELD_PREP(RG_COREPLL_SDM_PCW_MASK, x)
 #define  RG_COREPLL_SDM_PCW_CHG		BIT(0)
 
 /* Registers for RGMII and SGMII PLL clock */
@@ -629,10 +635,10 @@ enum mt7531_xtal_fsel {
 #define MT7530_TRGMII_RCK_CTRL		0x7a00
 #define  RX_RST				BIT(31)
 #define  RXC_DQSISEL			BIT(30)
-#define  DQSI1_TAP_MASK			(0x7f << 8)
-#define  DQSI0_TAP_MASK			0x7f
-#define  DQSI1_TAP(x)			(((x) & 0x7f) << 8)
-#define  DQSI0_TAP(x)			((x) & 0x7f)
+#define  DQSI1_TAP_MASK			GENMASK(14, 8)
+#define  DQSI0_TAP_MASK			GENMASK(6, 0)
+#define  DQSI1_TAP(x)			FIELD_PREP(DQSI1_TAP_MASK, x)
+#define  DQSI0_TAP(x)			FIELD_PREP(DQSI0_TAP_MASK, x)
 
 #define MT7530_TRGMII_RCK_RTT		0x7a04
 #define  DQS1_GATE			BIT(31)
@@ -641,8 +647,8 @@ enum mt7531_xtal_fsel {
 #define MT7530_TRGMII_RD(x)		(0x7a10 + (x) * 8)
 #define  BSLIP_EN			BIT(31)
 #define  EDGE_CHK			BIT(30)
-#define  RD_TAP_MASK			0x7f
-#define  RD_TAP(x)			((x) & 0x7f)
+#define  RD_TAP_MASK			GENMASK(6, 0)
+#define  RD_TAP(x)			FIELD_PREP(RD_TAP_MASK, x)
 
 #define MT7530_TRGMII_TXCTRL		0x7a40
 #define  TRAIN_TXEN			BIT(31)
@@ -650,18 +656,23 @@ enum mt7531_xtal_fsel {
 #define  TX_RST				BIT(28)
 
 #define MT7530_TRGMII_TD_ODT(i)		(0x7a54 + 8 * (i))
-#define  TD_DM_DRVP(x)			((x) & 0xf)
-#define  TD_DM_DRVN(x)			(((x) & 0xf) << 4)
+#define  TD_DM_DRVP_MASK		GENMASK(3, 0)
+#define  TD_DM_DRVP(x)			FIELD_PREP(TD_DM_DRVP_MASK, x)
+#define  TD_DM_DRVN_MASK		GENMASK(7, 4)
+#define  TD_DM_DRVN(x)			FIELD_PREP(TD_DM_DRVN_MASK, x)
 
 #define MT7530_TRGMII_TCK_CTRL		0x7a78
-#define  TCK_TAP(x)			(((x) & 0xf) << 8)
+#define  TCK_TAP_MASK			GENMASK(11, 8)
+#define  TCK_TAP(x)			FIELD_PREP(TCK_TAP_MASK, x)
 
 #define MT7530_P5RGMIIRXCR		0x7b00
 #define  CSR_RGMII_EDGE_ALIGN		BIT(8)
-#define  CSR_RGMII_RXC_0DEG_CFG(x)	((x) & 0xf)
+#define  CSR_RGMII_RXC_0DEG_CFG_MASK	GENMASK(3, 0)
+#define  CSR_RGMII_RXC_0DEG_CFG(x)	FIELD_PREP(CSR_RGMII_RXC_0DEG_CFG_MASK, x)
 
 #define MT7530_P5RGMIITXCR		0x7b04
-#define  CSR_RGMII_TXC_CFG(x)		((x) & 0x1f)
+#define  CSR_RGMII_TXC_CFG_MASK		GENMASK(4, 0)
+#define  CSR_RGMII_TXC_CFG(x)		FIELD_PREP(CSR_RGMII_TXC_CFG_MASK, x)
 
 /* Registers for GPIO mode */
 #define MT7531_GPIO_MODE0		0x7c0c
@@ -670,9 +681,9 @@ enum mt7531_xtal_fsel {
 
 #define MT7531_GPIO_MODE1		0x7c10
 #define  MT7531_GPIO11_RG_RXD2_MASK	GENMASK(15, 12)
-#define  MT7531_EXT_P_MDC_11		(2 << 12)
+#define  MT7531_EXT_P_MDC_11		FIELD_PREP(MT7531_GPIO11_RG_RXD2_MASK, 2)
 #define  MT7531_GPIO12_RG_RXD3_MASK	GENMASK(19, 16)
-#define  MT7531_EXT_P_MDIO_12		(2 << 16)
+#define  MT7531_EXT_P_MDIO_12		FIELD_PREP(MT7531_GPIO12_RG_RXD3_MASK, 2)
 
 #define MT753X_CPORT_SPTAG_CFG		0x7c10
 #define  CPORT_SW2FE_STAG_EN		BIT(1)
@@ -704,7 +715,7 @@ enum mt7531_xtal_fsel {
 #define MT7530_LED_GPIO_DATA		0x7d18
 
 #define MT7530_CREV			0x7ffc
-#define  CHIP_NAME_SHIFT		16
+#define  CHIP_NAME_MASK			GENMASK(31, 16)
 #define  MT7530_ID			0x7530
 
 #define MT7531_CREV			0x781C
@@ -716,10 +727,13 @@ enum mt7531_xtal_fsel {
 #define  RG_SYSPLL_EN_NORMAL		BIT(15)
 #define  RG_SYSPLL_VODEN		BIT(14)
 #define  RG_SYSPLL_LF			BIT(13)
-#define  RG_SYSPLL_RST_DLY(x)		(((x) & 0x3) << 12)
+#define  RG_SYSPLL_RST_DLY_MASK		GENMASK(13, 12)
+#define  RG_SYSPLL_RST_DLY(x)		FIELD_PREP(RG_SYSPLL_RST_DLY_MASK, x)
 #define  RG_SYSPLL_LVROD_EN		BIT(10)
-#define  RG_SYSPLL_PREDIV(x)		(((x) & 0x3) << 8)
-#define  RG_SYSPLL_POSDIV(x)		(((x) & 0x3) << 5)
+#define  RG_SYSPLL_PREDIV_MASK		GENMASK(9, 8)
+#define  RG_SYSPLL_PREDIV(x)		FIELD_PREP(RG_SYSPLL_PREDIV_MASK, x)
+#define  RG_SYSPLL_POSDIV_MASK		GENMASK(6, 5)
+#define  RG_SYSPLL_POSDIV(x)		FIELD_PREP(RG_SYSPLL_POSDIV_MASK, x)
 #define  RG_SYSPLL_FBKSEL		BIT(4)
 #define  RT_SYSPLL_EN_AFE_OLT		BIT(0)
 
@@ -731,38 +745,48 @@ enum mt7531_xtal_fsel {
 #define  MT7531_PHY_PLL_OFF		BIT(5)
 #define  MT7531_PHY_PLL_BYPASS_MODE	BIT(4)
 
-#define MT753X_CTRL_PHY_ADDR(addr)	((addr + 1) & 0x1f)
+#define MT753X_CTRL_PHY_ADDR(addr)	(((addr) + 1) & (PHY_MAX_ADDR - 1))
 
 #define CORE_PLL_GROUP5			0x404
-#define  RG_LCDDS_PCW_NCPO1(x)		((x) & 0xffff)
+#define  RG_LCDDS_PCW_NCPO1_MASK	GENMASK(15, 0)
+#define  RG_LCDDS_PCW_NCPO1(x)		FIELD_PREP(RG_LCDDS_PCW_NCPO1_MASK, x)
 
 #define CORE_PLL_GROUP6			0x405
-#define  RG_LCDDS_PCW_NCPO0(x)		((x) & 0xffff)
+#define  RG_LCDDS_PCW_NCPO0_MASK	GENMASK(15, 0)
+#define  RG_LCDDS_PCW_NCPO0(x)		FIELD_PREP(RG_LCDDS_PCW_NCPO0_MASK, x)
 
 #define CORE_PLL_GROUP7			0x406
 #define  RG_LCDDS_PWDB			BIT(15)
 #define  RG_LCDDS_ISO_EN		BIT(13)
-#define  RG_LCCDS_C(x)			(((x) & 0x7) << 4)
+#define  RG_LCCDS_C_MASK		GENMASK(6, 4)
+#define  RG_LCCDS_C(x)			FIELD_PREP(RG_LCCDS_C_MASK, x)
 #define  RG_LCDDS_PCW_NCPO_CHG		BIT(3)
 
 #define CORE_PLL_GROUP10		0x409
-#define  RG_LCDDS_SSC_DELTA(x)		((x) & 0xfff)
+#define  RG_LCDDS_SSC_DELTA_MASK	GENMASK(11, 0)
+#define  RG_LCDDS_SSC_DELTA(x)		FIELD_PREP(RG_LCDDS_SSC_DELTA_MASK, x)
 
 #define CORE_PLL_GROUP11		0x40a
-#define  RG_LCDDS_SSC_DELTA1(x)		((x) & 0xfff)
+#define  RG_LCDDS_SSC_DELTA1_MASK	GENMASK(11, 0)
+#define  RG_LCDDS_SSC_DELTA1(x)		FIELD_PREP(RG_LCDDS_SSC_DELTA1_MASK, x)
 
 #define CORE_GSWPLL_GRP1		0x40d
-#define  RG_GSWPLL_PREDIV(x)		(((x) & 0x3) << 14)
-#define  RG_GSWPLL_POSDIV_200M(x)	(((x) & 0x3) << 12)
+#define  RG_GSWPLL_PREDIV_MASK		GENMASK(15, 14)
+#define  RG_GSWPLL_PREDIV(x)		FIELD_PREP(RG_GSWPLL_PREDIV_MASK, x)
+#define  RG_GSWPLL_POSDIV_200M_MASK	GENMASK(13, 12)
+#define  RG_GSWPLL_POSDIV_200M(x)	FIELD_PREP(RG_GSWPLL_POSDIV_200M_MASK, x)
 #define  RG_GSWPLL_EN_PRE		BIT(11)
 #define  RG_GSWPLL_FBKSEL		BIT(10)
 #define  RG_GSWPLL_BP			BIT(9)
 #define  RG_GSWPLL_BR			BIT(8)
-#define  RG_GSWPLL_FBKDIV_200M(x)	((x) & 0xff)
+#define  RG_GSWPLL_FBKDIV_200M_MASK	GENMASK(7, 0)
+#define  RG_GSWPLL_FBKDIV_200M(x)	FIELD_PREP(RG_GSWPLL_FBKDIV_200M_MASK, x)
 
 #define CORE_GSWPLL_GRP2		0x40e
-#define  RG_GSWPLL_POSDIV_500M(x)	(((x) & 0x3) << 8)
-#define  RG_GSWPLL_FBKDIV_500M(x)	((x) & 0xff)
+#define  RG_GSWPLL_POSDIV_500M_MASK	GENMASK(9, 8)
+#define  RG_GSWPLL_POSDIV_500M(x)	FIELD_PREP(RG_GSWPLL_POSDIV_500M_MASK, x)
+#define  RG_GSWPLL_FBKDIV_500M_MASK	GENMASK(7, 0)
+#define  RG_GSWPLL_FBKDIV_500M(x)	FIELD_PREP(RG_GSWPLL_FBKDIV_500M_MASK, x)
 
 #define CORE_TRGMII_GSW_CLK_CG		0x410
 #define  REG_GSWCK_EN			BIT(0)
-- 
2.54.0


Return-Path: <netdev+bounces-299324-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JjFRGJ+ML2rNCAUAu9opvQ
	(envelope-from <netdev+bounces-299324-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 07:24:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDB9683713
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 07:24:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299324-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299324-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96F4D302A6C9
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 05:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6AB30B51F;
	Mon, 15 Jun 2026 05:21:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B99F308F3B;
	Mon, 15 Jun 2026 05:21:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781500917; cv=none; b=QuOMpaTJv4aW4LH3WUFN118erzxTFDTsZlYYlcyjyjsFg3RvjOajq9foq7k/OJC22yU6X1FoYJWL93hOyDuaxu+u6lUot/4s3JVWSWxPd6iJx3AskqVaPZCc4hqdbj399jBlQ4WVnnSgw+dycQ/hl5fOCXbGidNj+V4BCDAeeUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781500917; c=relaxed/simple;
	bh=9jC+o8TIHOd7ZahqOMWRZEI/ZFsK5BxXdZa+6kWbNyg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZgRhMO61RVJLLxYc29Muu3OpAEXeKWcm/NnA8mogU8lpoxEYxZPjQh5w1Ht4CYZ3CI8vqMTfIRQR++1/t5m9Nesv0PNOxftBvePIBeFx60JLoPM2cFi6AXMXdn8IO44l5Z9xumf1DdrC74SD3LXDPe6WILFTgl3saU0MEoUxbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wYzle-000000000xz-0DM7;
	Mon, 15 Jun 2026 05:21:50 +0000
Date: Mon, 15 Jun 2026 06:21:47 +0100
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
Subject: [PATCH net-next v3 5/8] net: dsa: mt7530: replace mt7530_read with
 regmap_read
Message-ID: <48b638ddd2f04ac1947dc5053afd24b25def6079.1781500517.git.daniel@makrotopia.org>
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
	TAGGED_FROM(0.00)[bounces-299324-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: AEDB9683713

Replace all mt7530_read() calls with direct regmap_read() calls and
remove the wrapper function. The WARN_ON_ONCE error logging is dropped
as regmap provides its own error handling.

Most callsites follow the val = mt7530_read(priv, reg) pattern and are
converted mechanically using the following semantic patch:

@@
expression priv, reg;
identifier val;
@@
-val = mt7530_read(priv, reg);
+regmap_read(priv->regmap, reg, &val);

Remaining inline uses are converted by hand.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>

---
v3:
 * init read-back variables to 0 to preserve the old read-failure
   behaviour
 * use u32 for val in mt7530_setup_port5

v2:
 * drop fix for stray 'static void' leftover now correctly squashed
   into 4/8

 drivers/net/dsa/mt7530.c | 129 +++++++++++++++++++--------------------
 1 file changed, 64 insertions(+), 65 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index fe7e4ab5ae9c..bd4892918f01 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -152,28 +152,15 @@ core_clear(struct mt7530_priv *priv, u32 reg, u32 val)
 
 
 static u32
-mt7530_read(struct mt7530_priv *priv, u32 reg)
+mt7530_mii_poll(struct mt7530_dummy_poll *p)
 {
-	int ret;
-	u32 val;
+	u32 val = 0;
 
-	ret = regmap_read(priv->regmap, reg, &val);
-	if (ret) {
-		WARN_ON_ONCE(1);
-		dev_err(priv->dev,
-			"failed to read mt7530 register\n");
-		return 0;
-	}
+	regmap_read(p->priv->regmap, p->reg, &val);
 
 	return val;
 }
 
-static u32
-mt7530_mii_poll(struct mt7530_dummy_poll *p)
-{
-	return mt7530_read(p->priv, p->reg);
-}
-
 static int
 mt7530_fdb_cmd(struct mt7530_priv *priv, enum mt7530_fdb_cmd cmd, u32 *rsp)
 {
@@ -196,7 +183,7 @@ mt7530_fdb_cmd(struct mt7530_priv *priv, enum mt7530_fdb_cmd cmd, u32 *rsp)
 	/* Additional sanity for read command if the specified
 	 * entry is invalid
 	 */
-	val = mt7530_read(priv, MT7530_ATC);
+	regmap_read(priv->regmap, MT7530_ATC, &val);
 	if ((cmd == MT7530_FDB_READ) && (val & ATC_INVALID))
 		return -EINVAL;
 
@@ -214,7 +201,8 @@ mt7530_fdb_read(struct mt7530_priv *priv, struct mt7530_fdb *fdb)
 
 	/* Read from ARL table into an array */
 	for (i = 0; i < 3; i++) {
-		reg[i] = mt7530_read(priv, MT7530_TSRA1 + (i * 4));
+		regmap_read(priv->regmap, MT7530_TSRA1 + (i * 4),
+			    &reg[i]);
 
 		dev_dbg(priv->dev, "%s(%d) reg[%d]=0x%x\n",
 			__func__, __LINE__, i, reg[i]);
@@ -321,7 +309,8 @@ mt7530_setup_port6(struct dsa_switch *ds, phy_interface_t interface)
 	regmap_update_bits(priv->regmap, MT7530_P6ECR, P6_INTF_MODE_MASK,
 			   P6_INTF_MODE(1));
 
-	xtal = mt7530_read(priv, MT753X_MTRAP) & MT7530_XTAL_MASK;
+	regmap_read(priv->regmap, MT753X_MTRAP, &xtal);
+	xtal &= MT7530_XTAL_MASK;
 
 	if (xtal == MT7530_XTAL_25MHZ)
 		ssc_delta = 0x57;
@@ -361,13 +350,13 @@ static void
 mt7531_pll_setup(struct mt7530_priv *priv)
 {
 	enum mt7531_xtal_fsel xtal;
-	u32 top_sig;
-	u32 hwstrap;
-	u32 val;
+	u32 top_sig = 0;
+	u32 hwstrap = 0;
+	u32 val = 0;
 
-	val = mt7530_read(priv, MT7531_CREV);
-	top_sig = mt7530_read(priv, MT7531_TOP_SIG_SR);
-	hwstrap = mt7530_read(priv, MT753X_TRAP);
+	regmap_read(priv->regmap, MT7531_CREV, &val);
+	regmap_read(priv->regmap, MT7531_TOP_SIG_SR, &top_sig);
+	regmap_read(priv->regmap, MT753X_TRAP, &hwstrap);
 	if ((val & CHIP_REV_M) > 0)
 		xtal = (top_sig & PAD_MCM_SMI_EN) ? MT7531_XTAL_FSEL_40MHZ :
 						    MT7531_XTAL_FSEL_25MHZ;
@@ -376,26 +365,26 @@ mt7531_pll_setup(struct mt7530_priv *priv)
 						   MT7531_XTAL_FSEL_40MHZ;
 
 	/* Step 1 : Disable MT7531 COREPLL */
-	val = mt7530_read(priv, MT7531_PLLGP_EN);
+	regmap_read(priv->regmap, MT7531_PLLGP_EN, &val);
 	val &= ~EN_COREPLL;
 	regmap_write(priv->regmap, MT7531_PLLGP_EN, val);
 
 	/* Step 2: switch to XTAL output */
-	val = mt7530_read(priv, MT7531_PLLGP_EN);
+	regmap_read(priv->regmap, MT7531_PLLGP_EN, &val);
 	val |= SW_CLKSW;
 	regmap_write(priv->regmap, MT7531_PLLGP_EN, val);
 
-	val = mt7530_read(priv, MT7531_PLLGP_CR0);
+	regmap_read(priv->regmap, MT7531_PLLGP_CR0, &val);
 	val &= ~RG_COREPLL_EN;
 	regmap_write(priv->regmap, MT7531_PLLGP_CR0, val);
 
 	/* Step 3: disable PLLGP and enable program PLLGP */
-	val = mt7530_read(priv, MT7531_PLLGP_EN);
+	regmap_read(priv->regmap, MT7531_PLLGP_EN, &val);
 	val |= SW_PLLGP;
 	regmap_write(priv->regmap, MT7531_PLLGP_EN, val);
 
 	/* Step 4: program COREPLL output frequency to 500MHz */
-	val = mt7530_read(priv, MT7531_PLLGP_CR0);
+	regmap_read(priv->regmap, MT7531_PLLGP_CR0, &val);
 	val &= ~RG_COREPLL_POSDIV_M;
 	val |= 2 << RG_COREPLL_POSDIV_S;
 	regmap_write(priv->regmap, MT7531_PLLGP_CR0, val);
@@ -403,13 +392,13 @@ mt7531_pll_setup(struct mt7530_priv *priv)
 
 	switch (xtal) {
 	case MT7531_XTAL_FSEL_25MHZ:
-		val = mt7530_read(priv, MT7531_PLLGP_CR0);
+		regmap_read(priv->regmap, MT7531_PLLGP_CR0, &val);
 		val &= ~RG_COREPLL_SDM_PCW_M;
 		val |= 0x140000 << RG_COREPLL_SDM_PCW_S;
 		regmap_write(priv->regmap, MT7531_PLLGP_CR0, val);
 		break;
 	case MT7531_XTAL_FSEL_40MHZ:
-		val = mt7530_read(priv, MT7531_PLLGP_CR0);
+		regmap_read(priv->regmap, MT7531_PLLGP_CR0, &val);
 		val &= ~RG_COREPLL_SDM_PCW_M;
 		val |= 0x190000 << RG_COREPLL_SDM_PCW_S;
 		regmap_write(priv->regmap, MT7531_PLLGP_CR0, val);
@@ -417,14 +406,14 @@ mt7531_pll_setup(struct mt7530_priv *priv)
 	}
 
 	/* Set feedback divide ratio update signal to high */
-	val = mt7530_read(priv, MT7531_PLLGP_CR0);
+	regmap_read(priv->regmap, MT7531_PLLGP_CR0, &val);
 	val |= RG_COREPLL_SDM_PCW_CHG;
 	regmap_write(priv->regmap, MT7531_PLLGP_CR0, val);
 	/* Wait for at least 16 XTAL clocks */
 	usleep_range(10, 20);
 
 	/* Step 5: set feedback divide ratio update signal to low */
-	val = mt7530_read(priv, MT7531_PLLGP_CR0);
+	regmap_read(priv->regmap, MT7531_PLLGP_CR0, &val);
 	val &= ~RG_COREPLL_SDM_PCW_CHG;
 	regmap_write(priv->regmap, MT7531_PLLGP_CR0, val);
 
@@ -435,11 +424,11 @@ mt7531_pll_setup(struct mt7530_priv *priv)
 	regmap_write(priv->regmap, MT7531_ANA_PLLGP_CR2, 0x4f40000);
 
 	/* Step 6: Enable MT7531 PLL */
-	val = mt7530_read(priv, MT7531_PLLGP_CR0);
+	regmap_read(priv->regmap, MT7531_PLLGP_CR0, &val);
 	val |= RG_COREPLL_EN;
 	regmap_write(priv->regmap, MT7531_PLLGP_CR0, val);
 
-	val = mt7530_read(priv, MT7531_PLLGP_EN);
+	regmap_read(priv->regmap, MT7531_PLLGP_EN, &val);
 	val |= EN_COREPLL;
 	regmap_write(priv->regmap, MT7531_PLLGP_EN, val);
 	usleep_range(25, 35);
@@ -696,13 +685,13 @@ static void
 mt7530_read_port_stats(struct mt7530_priv *priv, int port,
 		       u32 offset, u8 size, uint64_t *data)
 {
-	u32 val, reg = MT7530_PORT_MIB_COUNTER(port) + offset;
+	u32 val = 0, reg = MT7530_PORT_MIB_COUNTER(port) + offset;
 
-	val = mt7530_read(priv, reg);
+	regmap_read(priv->regmap, reg, &val);
 	*data = val;
 
 	if (size == 2) {
-		val = mt7530_read(priv, reg + 4);
+		regmap_read(priv->regmap, reg + 4, &val);
 		*data |= (u64)val << 32;
 	}
 }
@@ -1006,11 +995,11 @@ static void mt7530_setup_port5(struct dsa_switch *ds, phy_interface_t interface)
 {
 	struct mt7530_priv *priv = ds->priv;
 	u8 tx_delay = 0;
-	int val;
+	u32 val;
 
 	mutex_lock(&priv->reg_mutex);
 
-	val = mt7530_read(priv, MT753X_MTRAP);
+	regmap_read(priv->regmap, MT753X_MTRAP, &val);
 
 	val &= ~MT7530_P5_PHY0_SEL & ~MT7530_P5_MAC_SEL & ~MT7530_P5_RGMII_MODE;
 
@@ -1368,8 +1357,8 @@ static int
 mt7530_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 {
 	struct mt7530_priv *priv = ds->priv;
+	u32 val = 0;
 	int length;
-	u32 val;
 
 	/* When a new MTU is set, DSA always set the CPU port's MTU to the
 	 * largest MTU of the user ports. Because the switch only has a global
@@ -1378,7 +1367,7 @@ mt7530_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 	if (!dsa_is_cpu_port(ds, port))
 		return 0;
 
-	val = mt7530_read(priv, MT7530_GMACCR);
+	regmap_read(priv->regmap, MT7530_GMACCR, &val);
 	val &= ~MAX_RX_PKT_LEN_MASK;
 
 	/* RX length also includes Ethernet header, MTK tag, and FCS length */
@@ -1577,7 +1566,7 @@ mt7530_vlan_cmd(struct mt7530_priv *priv, enum mt7530_vlan_cmd cmd, u16 vid)
 		return ret;
 	}
 
-	val = mt7530_read(priv, MT7530_VTCR);
+	regmap_read(priv->regmap, MT7530_VTCR, &val);
 	if (val & VTCR_INVALID) {
 		dev_err(priv->dev, "read VTCR invalid\n");
 		return -EINVAL;
@@ -1789,14 +1778,16 @@ mt7530_port_mdb_add(struct dsa_switch *ds, int port,
 	const u8 *addr = mdb->addr;
 	u16 vid = mdb->vid;
 	u8 port_mask = 0;
+	u32 val;
 	int ret;
 
 	mutex_lock(&priv->reg_mutex);
 
 	mt7530_fdb_write(priv, vid, 0, addr, 0, STATIC_EMP);
-	if (!mt7530_fdb_cmd(priv, MT7530_FDB_READ, NULL))
-		port_mask = (mt7530_read(priv, MT7530_ATRD) >> PORT_MAP)
-			    & PORT_MAP_MASK;
+	if (!mt7530_fdb_cmd(priv, MT7530_FDB_READ, NULL)) {
+		regmap_read(priv->regmap, MT7530_ATRD, &val);
+		port_mask = (val >> PORT_MAP) & PORT_MAP_MASK;
+	}
 
 	port_mask |= BIT(port);
 	mt7530_fdb_write(priv, vid, port_mask, addr, -1, STATIC_ENT);
@@ -1816,14 +1807,16 @@ mt7530_port_mdb_del(struct dsa_switch *ds, int port,
 	const u8 *addr = mdb->addr;
 	u16 vid = mdb->vid;
 	u8 port_mask = 0;
+	u32 val;
 	int ret;
 
 	mutex_lock(&priv->reg_mutex);
 
 	mt7530_fdb_write(priv, vid, 0, addr, 0, STATIC_EMP);
-	if (!mt7530_fdb_cmd(priv, MT7530_FDB_READ, NULL))
-		port_mask = (mt7530_read(priv, MT7530_ATRD) >> PORT_MAP)
-			    & PORT_MAP_MASK;
+	if (!mt7530_fdb_cmd(priv, MT7530_FDB_READ, NULL)) {
+		regmap_read(priv->regmap, MT7530_ATRD, &val);
+		port_mask = (val >> PORT_MAP) & PORT_MAP_MASK;
+	}
 
 	port_mask &= ~BIT(port);
 	mt7530_fdb_write(priv, vid, port_mask, addr, -1,
@@ -1901,7 +1894,7 @@ mt7530_hw_vlan_del(struct mt7530_priv *priv,
 
 	new_members = entry->old_members & ~BIT(entry->port);
 
-	val = mt7530_read(priv, MT7530_VAWD1);
+	regmap_read(priv->regmap, MT7530_VAWD1, &val);
 	if (!(val & VLAN_VALID)) {
 		dev_err(priv->dev,
 			"Cannot be deleted due to invalid entry\n");
@@ -1928,7 +1921,7 @@ mt7530_hw_vlan_update(struct mt7530_priv *priv, u16 vid,
 	/* Fetch entry */
 	mt7530_vlan_cmd(priv, MT7530_VTCR_RD_VID, vid);
 
-	val = mt7530_read(priv, MT7530_VAWD1);
+	regmap_read(priv->regmap, MT7530_VAWD1, &val);
 
 	entry->old_members = (val >> PORT_MEM_SHFT) & PORT_MEM_MASK;
 
@@ -2046,7 +2039,7 @@ static int mt753x_port_mirror_add(struct dsa_switch *ds, int port,
 	if ((ingress ? priv->mirror_rx : priv->mirror_tx) & BIT(port))
 		return -EEXIST;
 
-	val = mt7530_read(priv, MT753X_MIRROR_REG(priv->id));
+	regmap_read(priv->regmap, MT753X_MIRROR_REG(priv->id), &val);
 
 	/* MT7530 only supports one monitor port */
 	monitor_port = MT753X_MIRROR_PORT_GET(priv->id, val);
@@ -2059,7 +2052,7 @@ static int mt753x_port_mirror_add(struct dsa_switch *ds, int port,
 	val |= MT753X_MIRROR_PORT_SET(priv->id, mirror->to_local_port);
 	regmap_write(priv->regmap, MT753X_MIRROR_REG(priv->id), val);
 
-	val = mt7530_read(priv, MT7530_PCR_P(port));
+	regmap_read(priv->regmap, MT7530_PCR_P(port), &val);
 	if (ingress) {
 		val |= PORT_RX_MIR;
 		priv->mirror_rx |= BIT(port);
@@ -2076,9 +2069,9 @@ static void mt753x_port_mirror_del(struct dsa_switch *ds, int port,
 				   struct dsa_mall_mirror_tc_entry *mirror)
 {
 	struct mt7530_priv *priv = ds->priv;
-	u32 val;
+	u32 val = 0;
 
-	val = mt7530_read(priv, MT7530_PCR_P(port));
+	regmap_read(priv->regmap, MT7530_PCR_P(port), &val);
 	if (mirror->ingress) {
 		val &= ~PORT_RX_MIR;
 		priv->mirror_rx &= ~BIT(port);
@@ -2089,7 +2082,7 @@ static void mt753x_port_mirror_del(struct dsa_switch *ds, int port,
 	regmap_write(priv->regmap, MT7530_PCR_P(port), val);
 
 	if (!priv->mirror_rx && !priv->mirror_tx) {
-		val = mt7530_read(priv, MT753X_MIRROR_REG(priv->id));
+		regmap_read(priv->regmap, MT753X_MIRROR_REG(priv->id), &val);
 		val &= ~MT753X_MIRROR_EN(priv->id);
 		regmap_write(priv->regmap, MT753X_MIRROR_REG(priv->id), val);
 	}
@@ -2121,8 +2114,11 @@ mt7530_gpio_get(struct gpio_chip *gc, unsigned int offset)
 {
 	struct mt7530_priv *priv = gpiochip_get_data(gc);
 	u32 bit = mt7530_gpio_to_bit(offset);
+	u32 val = 0;
+
+	regmap_read(priv->regmap, MT7530_LED_GPIO_DATA, &val);
 
-	return !!(mt7530_read(priv, MT7530_LED_GPIO_DATA) & bit);
+	return !!(val & bit);
 }
 
 static int
@@ -2144,8 +2140,11 @@ mt7530_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
 {
 	struct mt7530_priv *priv = gpiochip_get_data(gc);
 	u32 bit = mt7530_gpio_to_bit(offset);
+	u32 val;
+
+	regmap_read(priv->regmap, MT7530_LED_GPIO_DIR, &val);
 
-	return (mt7530_read(priv, MT7530_LED_GPIO_DIR) & bit) ?
+	return (val & bit) ?
 		GPIO_LINE_DIRECTION_OUT : GPIO_LINE_DIRECTION_IN;
 }
 
@@ -2436,7 +2435,7 @@ mt7530_setup(struct dsa_switch *ds)
 		return ret;
 	}
 
-	id = mt7530_read(priv, MT7530_CREV);
+	regmap_read(priv->regmap, MT7530_CREV, &id);
 	id >>= CHIP_NAME_SHIFT;
 	if (id != MT7530_ID) {
 		dev_err(priv->dev, "chip %x can't be supported\n", id);
@@ -2679,7 +2678,7 @@ mt7531_setup(struct dsa_switch *ds)
 		return ret;
 	}
 
-	id = mt7530_read(priv, MT7531_CREV);
+	regmap_read(priv->regmap, MT7531_CREV, &id);
 	id >>= CHIP_NAME_SHIFT;
 
 	if (id != MT7531_ID) {
@@ -2690,7 +2689,7 @@ mt7531_setup(struct dsa_switch *ds)
 	/* MT7531AE has got two SGMII units. One for port 5, one for port 6.
 	 * MT7531BE has got only one SGMII unit which is for port 6.
 	 */
-	val = mt7530_read(priv, MT7531_TOP_SIG_SR);
+	regmap_read(priv->regmap, MT7531_TOP_SIG_SR, &val);
 	priv->p5_sgmii = !!(val & PAD_DUAL_SGMII_EN);
 
 	/* Force link down on all ports before internal reset */
@@ -2880,7 +2879,7 @@ static void mt7531_rgmii_setup(struct mt7530_priv *priv,
 {
 	u32 val;
 
-	val = mt7530_read(priv, MT7531_CLKGEN_CTRL);
+	regmap_read(priv->regmap, MT7531_CLKGEN_CTRL, &val);
 	val |= GP_CLK_EN;
 	val &= ~GP_MODE_MASK;
 	val |= GP_MODE(MT7531_GP_MODE_RGMII);
@@ -3059,7 +3058,7 @@ static void mt753x_phylink_get_caps(struct dsa_switch *ds, int port,
 
 	config->lpi_capabilities = MAC_100FD | MAC_1000FD | MAC_2500FD;
 
-	eeecr = mt7530_read(priv, MT753X_PMEEECR_P(port));
+	regmap_read(priv->regmap, MT753X_PMEEECR_P(port), &eeecr);
 	/* tx_lpi_timer should be in microseconds. The time units for
 	 * LPI threshold are unspecified.
 	 */
@@ -3087,7 +3086,7 @@ static void mt7530_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
 	int port = pcs_to_mt753x_pcs(pcs)->port;
 	u32 pmsr;
 
-	pmsr = mt7530_read(priv, MT7530_PMSR_P(port));
+	regmap_read(priv->regmap, MT7530_PMSR_P(port), &pmsr);
 
 	state->link = (pmsr & PMSR_LINK);
 	state->an_complete = state->link;
-- 
2.54.0


Return-Path: <netdev+bounces-267922-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMrlMCjOtmkPJAEAu9opvQ
	(envelope-from <netdev+bounces-267922-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 16:20:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 492A62912C2
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 16:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AFCA030087C9
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 15:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05B036F42A;
	Sun, 15 Mar 2026 15:20:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CFA3B2A0;
	Sun, 15 Mar 2026 15:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773588004; cv=none; b=Jne8pWvikFmvLX1Lpw30rEAlPxZMbS1Fd1yaJbcJVNWLJwjDIn/7/oZx9mxJOKeRz5V9q3aoHbo5afmqKGsQUDB+nvbhaTsBkEV16vB1wM+wVdXHgHINPuhbkh19NEUClBd8wL1xpSFiuCK36cfmN6qY8/h+DAwmJNHuTSyr0nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773588004; c=relaxed/simple;
	bh=m1seJc8oqN9Jir8dhipS2Ife7Xs7bNz3x5k7GGWv8cw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=W2qM5t/uL7+Ds0ty18KpB6uWUW/HWZ+5K2lmIElJDSwCynFb9kYfH9yM+M38FRyhO7l0i9+KJo4GwMB/aw1NYcvBGcVtSBS4j0xw9giQ9rIHTR0RRfgazvCdwI+0RqVbLpYl/YsrDOfEqFLOJHH1EXFXGknql/vfAW1T1mjuaHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w1nFv-000000005qn-0qHU;
	Sun, 15 Mar 2026 15:19:51 +0000
Date: Sun, 15 Mar 2026 15:19:44 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Xu Liang <lxu@maxlinear.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: phy: mxl-gpy: add PHY-level statistics via
 ethtool
Message-ID: <0029a2fb29bfdcc26abff828d2e18400067b5c58.1773587924.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267922-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[maxlinear.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 492A62912C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Report PCS receive error counts for all supported GPY115x, GPY2xx and
MxL862xx PHYs.

Accumulate the vendor-specific PHY_ERRCNT read-clear counter
(SEL=RXERR) in .update_stats() and expose it as both IEEE 802.3
SymbolErrorDuringCarrier and generic rx_errors via
.get_phy_stats().

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: rebase on top of current net-next

 drivers/net/phy/mxl-gpy.c | 66 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
index 5f99766fb64c3..0da2d4e9d8548 100644
--- a/drivers/net/phy/mxl-gpy.c
+++ b/drivers/net/phy/mxl-gpy.c
@@ -38,12 +38,17 @@
 #define PHY_CTL1_MDICD		BIT(3)
 #define PHY_CTL1_MDIAB		BIT(2)
 #define PHY_CTL1_AMDIX		BIT(0)
+#define PHY_ERRCNT		0x15	/* Error counter */
 #define PHY_MIISTAT		0x18	/* MII state */
 #define PHY_IMASK		0x19	/* interrupt mask */
 #define PHY_ISTAT		0x1A	/* interrupt status */
 #define PHY_LED			0x1B	/* LEDs */
 #define PHY_FWV			0x1E	/* firmware version */
 
+#define PHY_ERRCNT_SEL		GENMASK(11, 8)
+#define PHY_ERRCNT_COUNT	GENMASK(7, 0)
+#define PHY_ERRCNT_SEL_RXERR	0
+
 #define PHY_MIISTAT_SPD_MASK	GENMASK(2, 0)
 #define PHY_MIISTAT_DPX		BIT(3)
 #define PHY_MIISTAT_LS		BIT(10)
@@ -134,6 +139,7 @@ struct gpy_priv {
 	u8 fw_major;
 	u8 fw_minor;
 	u32 wolopts;
+	u64 rx_errors;
 
 	/* It takes 3 seconds to fully switch out of loopback mode before
 	 * it can safely re-enter loopback mode. Record the time when
@@ -331,8 +337,9 @@ static int gpy_mbox_read(struct phy_device *phydev, u32 addr)
 
 static int gpy_config_init(struct phy_device *phydev)
 {
-	/* Nothing to configure. Configuration Requirement Placeholder */
-	return 0;
+	/* Count MDI RX errors (SymbolErrorDuringCarrier) */
+	return phy_write(phydev, PHY_ERRCNT,
+			 FIELD_PREP(PHY_ERRCNT_SEL, PHY_ERRCNT_SEL_RXERR));
 }
 
 static int gpy21x_config_init(struct phy_device *phydev)
@@ -1067,6 +1074,31 @@ static int gpy_config_inband(struct phy_device *phydev, unsigned int modes)
 			      VSPEC1_SGMII_ANEN_ANRS);
 }
 
+static int gpy_update_stats(struct phy_device *phydev)
+{
+	struct gpy_priv *priv = phydev->priv;
+	int ret;
+
+	/* PHY_ERRCNT: 8-bit read-clear counter, SEL set to RXERR */
+	ret = phy_read(phydev, PHY_ERRCNT);
+	if (ret < 0)
+		return ret;
+
+	priv->rx_errors += FIELD_GET(PHY_ERRCNT_COUNT, ret);
+
+	return 0;
+}
+
+static void gpy_get_phy_stats(struct phy_device *phydev,
+			      struct ethtool_eth_phy_stats *eth_stats,
+			      struct ethtool_phy_stats *stats)
+{
+	struct gpy_priv *priv = phydev->priv;
+
+	eth_stats->SymbolErrorDuringCarrier = priv->rx_errors;
+	stats->rx_errors = priv->rx_errors;
+}
+
 static struct phy_driver gpy_drivers[] = {
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_GPY2xx),
@@ -1091,6 +1123,8 @@ static struct phy_driver gpy_drivers[] = {
 		.led_hw_control_get = gpy_led_hw_control_get,
 		.led_hw_control_set = gpy_led_hw_control_set,
 		.led_polarity_set = gpy_led_polarity_set,
+		.update_stats	= gpy_update_stats,
+		.get_phy_stats	= gpy_get_phy_stats,
 	},
 	{
 		.phy_id		= PHY_ID_GPY115B,
@@ -1116,6 +1150,8 @@ static struct phy_driver gpy_drivers[] = {
 		.led_hw_control_get = gpy_led_hw_control_get,
 		.led_hw_control_set = gpy_led_hw_control_set,
 		.led_polarity_set = gpy_led_polarity_set,
+		.update_stats	= gpy_update_stats,
+		.get_phy_stats	= gpy_get_phy_stats,
 	},
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_GPY115C),
@@ -1140,6 +1176,8 @@ static struct phy_driver gpy_drivers[] = {
 		.led_hw_control_get = gpy_led_hw_control_get,
 		.led_hw_control_set = gpy_led_hw_control_set,
 		.led_polarity_set = gpy_led_polarity_set,
+		.update_stats	= gpy_update_stats,
+		.get_phy_stats	= gpy_get_phy_stats,
 	},
 	{
 		.phy_id		= PHY_ID_GPY211B,
@@ -1165,6 +1203,8 @@ static struct phy_driver gpy_drivers[] = {
 		.led_hw_control_get = gpy_led_hw_control_get,
 		.led_hw_control_set = gpy_led_hw_control_set,
 		.led_polarity_set = gpy_led_polarity_set,
+		.update_stats	= gpy_update_stats,
+		.get_phy_stats	= gpy_get_phy_stats,
 	},
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_GPY211C),
@@ -1189,6 +1229,8 @@ static struct phy_driver gpy_drivers[] = {
 		.led_hw_control_get = gpy_led_hw_control_get,
 		.led_hw_control_set = gpy_led_hw_control_set,
 		.led_polarity_set = gpy_led_polarity_set,
+		.update_stats	= gpy_update_stats,
+		.get_phy_stats	= gpy_get_phy_stats,
 	},
 	{
 		.phy_id		= PHY_ID_GPY212B,
@@ -1214,6 +1256,8 @@ static struct phy_driver gpy_drivers[] = {
 		.led_hw_control_get = gpy_led_hw_control_get,
 		.led_hw_control_set = gpy_led_hw_control_set,
 		.led_polarity_set = gpy_led_polarity_set,
+		.update_stats	= gpy_update_stats,
+		.get_phy_stats	= gpy_get_phy_stats,
 	},
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_GPY212C),
@@ -1238,6 +1282,8 @@ static struct phy_driver gpy_drivers[] = {
 		.led_hw_control_get = gpy_led_hw_control_get,
 		.led_hw_control_set = gpy_led_hw_control_set,
 		.led_polarity_set = gpy_led_polarity_set,
+		.update_stats	= gpy_update_stats,
+		.get_phy_stats	= gpy_get_phy_stats,
 	},
 	{
 		.phy_id		= PHY_ID_GPY215B,
@@ -1263,6 +1309,8 @@ static struct phy_driver gpy_drivers[] = {
 		.led_hw_control_get = gpy_led_hw_control_get,
 		.led_hw_control_set = gpy_led_hw_control_set,
 		.led_polarity_set = gpy_led_polarity_set,
+		.update_stats	= gpy_update_stats,
+		.get_phy_stats	= gpy_get_phy_stats,
 	},
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_GPY215C),
@@ -1287,6 +1335,8 @@ static struct phy_driver gpy_drivers[] = {
 		.led_hw_control_get = gpy_led_hw_control_get,
 		.led_hw_control_set = gpy_led_hw_control_set,
 		.led_polarity_set = gpy_led_polarity_set,
+		.update_stats	= gpy_update_stats,
+		.get_phy_stats	= gpy_get_phy_stats,
 	},
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_GPY241B),
@@ -1306,6 +1356,8 @@ static struct phy_driver gpy_drivers[] = {
 		.set_wol	= gpy_set_wol,
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy_loopback,
+		.update_stats	= gpy_update_stats,
+		.get_phy_stats	= gpy_get_phy_stats,
 	},
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_GPY241BM),
@@ -1325,6 +1377,8 @@ static struct phy_driver gpy_drivers[] = {
 		.set_wol	= gpy_set_wol,
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy_loopback,
+		.update_stats	= gpy_update_stats,
+		.get_phy_stats	= gpy_get_phy_stats,
 	},
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_GPY245B),
@@ -1344,6 +1398,8 @@ static struct phy_driver gpy_drivers[] = {
 		.set_wol	= gpy_set_wol,
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy_loopback,
+		.update_stats	= gpy_update_stats,
+		.get_phy_stats	= gpy_get_phy_stats,
 	},
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_MXL86211C),
@@ -1368,6 +1424,8 @@ static struct phy_driver gpy_drivers[] = {
 		.led_hw_control_get = gpy_led_hw_control_get,
 		.led_hw_control_set = gpy_led_hw_control_set,
 		.led_polarity_set = gpy_led_polarity_set,
+		.update_stats	= gpy_update_stats,
+		.get_phy_stats	= gpy_get_phy_stats,
 	},
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_MXL86252),
@@ -1385,6 +1443,8 @@ static struct phy_driver gpy_drivers[] = {
 		.set_wol	= gpy_set_wol,
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy_loopback,
+		.update_stats	= gpy_update_stats,
+		.get_phy_stats	= gpy_get_phy_stats,
 		.led_brightness_set = gpy_led_brightness_set,
 		.led_hw_is_supported = gpy_led_hw_is_supported,
 		.led_hw_control_get = gpy_led_hw_control_get,
@@ -1407,6 +1467,8 @@ static struct phy_driver gpy_drivers[] = {
 		.set_wol	= gpy_set_wol,
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy_loopback,
+		.update_stats	= gpy_update_stats,
+		.get_phy_stats	= gpy_get_phy_stats,
 		.led_brightness_set = gpy_led_brightness_set,
 		.led_hw_is_supported = gpy_led_hw_is_supported,
 		.led_hw_control_get = gpy_led_hw_control_get,
-- 
2.53.0


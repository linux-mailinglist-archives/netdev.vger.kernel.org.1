Return-Path: <netdev+bounces-267256-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDzEFUJms2mVVwAAu9opvQ
	(envelope-from <netdev+bounces-267256-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:20:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5F927C3A9
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 067B53110792
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 01:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901BA31715D;
	Fri, 13 Mar 2026 01:19:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3713313520;
	Fri, 13 Mar 2026 01:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773364759; cv=none; b=th+9ivnE9AvWPiN8fENevHWLa3A0rAImKVnP3n59VMBuxxWYwY8uqbfYouEYTzqlQ/oZHhGF3M2ESyiFcWK1kVKWq6E+KnjkDMSJhnMDkJz8JclMsa6vh108QLG4DDdbx6cTL7wjPFInOicnz2wTUPKFmAnz9qa9I64HmGtQ/Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773364759; c=relaxed/simple;
	bh=gDqiVugEuiXarhUc6bCX0SDyQf/f6Tx1CbT617o9rvY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZwRnQjnrXyhJVhnUc1DCIM3Iaau953/5USSl0Y89xwmOTDZfundFgFkFHoqAdjyYtP6lGOBqSjFJXhAjL1YRdQsf8sbm+SSTg1++LmV4KKNJE6xpErA3+AaZ7xulgWj1veSpEYhzKXD6JKvRN9X7jetB1iyDqsEc2VZkDoV3hJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w0rBG-00000000365-02Wm;
	Fri, 13 Mar 2026 01:19:10 +0000
Date: Fri, 13 Mar 2026 01:19:07 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Liang Xu <lxu@maxlinear.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: phy: mxl-gpy: add PHY-level statistics via
 ethtool
Message-ID: <bd75b95a4b78a0f60f2f550cc6cdf7807904e879.1773364582.git.daniel@makrotopia.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267256-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AD5F927C3A9
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
 drivers/net/phy/mxl-gpy.c | 66 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
index 65a77b8431514..8248bb37f0cae 100644
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
@@ -332,8 +338,9 @@ static int gpy_mbox_read(struct phy_device *phydev, u32 addr)
 
 static int gpy_config_init(struct phy_device *phydev)
 {
-	/* Nothing to configure. Configuration Requirement Placeholder */
-	return 0;
+	/* Count MDI RX errors (SymbolErrorDuringCarrier) */
+	return phy_write(phydev, PHY_ERRCNT,
+			 FIELD_PREP(PHY_ERRCNT_SEL, PHY_ERRCNT_SEL_RXERR));
 }
 
 static int gpy21x_config_init(struct phy_device *phydev)
@@ -1099,6 +1106,31 @@ static int gpy_config_inband(struct phy_device *phydev, unsigned int modes)
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
@@ -1124,6 +1156,8 @@ static struct phy_driver gpy_drivers[] = {
 		.led_hw_control_set = gpy_led_hw_control_set,
 		.led_polarity_set = gpy_led_polarity_set,
 		.link_change_notify = gpy_link_change_notify,
+		.update_stats	= gpy_update_stats,
+		.get_phy_stats	= gpy_get_phy_stats,
 	},
 	{
 		.phy_id		= PHY_ID_GPY115B,
@@ -1150,6 +1184,8 @@ static struct phy_driver gpy_drivers[] = {
 		.led_hw_control_set = gpy_led_hw_control_set,
 		.led_polarity_set = gpy_led_polarity_set,
 		.link_change_notify = gpy_link_change_notify,
+		.update_stats	= gpy_update_stats,
+		.get_phy_stats	= gpy_get_phy_stats,
 	},
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_GPY115C),
@@ -1175,6 +1211,8 @@ static struct phy_driver gpy_drivers[] = {
 		.led_hw_control_set = gpy_led_hw_control_set,
 		.led_polarity_set = gpy_led_polarity_set,
 		.link_change_notify = gpy_link_change_notify,
+		.update_stats	= gpy_update_stats,
+		.get_phy_stats	= gpy_get_phy_stats,
 	},
 	{
 		.phy_id		= PHY_ID_GPY211B,
@@ -1201,6 +1239,8 @@ static struct phy_driver gpy_drivers[] = {
 		.led_hw_control_set = gpy_led_hw_control_set,
 		.led_polarity_set = gpy_led_polarity_set,
 		.link_change_notify = gpy_link_change_notify,
+		.update_stats	= gpy_update_stats,
+		.get_phy_stats	= gpy_get_phy_stats,
 	},
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_GPY211C),
@@ -1226,6 +1266,8 @@ static struct phy_driver gpy_drivers[] = {
 		.led_hw_control_set = gpy_led_hw_control_set,
 		.led_polarity_set = gpy_led_polarity_set,
 		.link_change_notify = gpy_link_change_notify,
+		.update_stats	= gpy_update_stats,
+		.get_phy_stats	= gpy_get_phy_stats,
 	},
 	{
 		.phy_id		= PHY_ID_GPY212B,
@@ -1252,6 +1294,8 @@ static struct phy_driver gpy_drivers[] = {
 		.led_hw_control_set = gpy_led_hw_control_set,
 		.led_polarity_set = gpy_led_polarity_set,
 		.link_change_notify = gpy_link_change_notify,
+		.update_stats	= gpy_update_stats,
+		.get_phy_stats	= gpy_get_phy_stats,
 	},
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_GPY212C),
@@ -1277,6 +1321,8 @@ static struct phy_driver gpy_drivers[] = {
 		.led_hw_control_set = gpy_led_hw_control_set,
 		.led_polarity_set = gpy_led_polarity_set,
 		.link_change_notify = gpy_link_change_notify,
+		.update_stats	= gpy_update_stats,
+		.get_phy_stats	= gpy_get_phy_stats,
 	},
 	{
 		.phy_id		= PHY_ID_GPY215B,
@@ -1303,6 +1349,8 @@ static struct phy_driver gpy_drivers[] = {
 		.led_hw_control_set = gpy_led_hw_control_set,
 		.led_polarity_set = gpy_led_polarity_set,
 		.link_change_notify = gpy_link_change_notify,
+		.update_stats	= gpy_update_stats,
+		.get_phy_stats	= gpy_get_phy_stats,
 	},
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_GPY215C),
@@ -1328,6 +1376,8 @@ static struct phy_driver gpy_drivers[] = {
 		.led_hw_control_set = gpy_led_hw_control_set,
 		.led_polarity_set = gpy_led_polarity_set,
 		.link_change_notify = gpy_link_change_notify,
+		.update_stats	= gpy_update_stats,
+		.get_phy_stats	= gpy_get_phy_stats,
 	},
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_GPY241B),
@@ -1348,6 +1398,8 @@ static struct phy_driver gpy_drivers[] = {
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy_loopback,
 		.link_change_notify	= gpy_link_change_notify,
+		.update_stats	= gpy_update_stats,
+		.get_phy_stats	= gpy_get_phy_stats,
 	},
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_GPY241BM),
@@ -1368,6 +1420,8 @@ static struct phy_driver gpy_drivers[] = {
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy_loopback,
 		.link_change_notify	= gpy_link_change_notify,
+		.update_stats	= gpy_update_stats,
+		.get_phy_stats	= gpy_get_phy_stats,
 	},
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_GPY245B),
@@ -1388,6 +1442,8 @@ static struct phy_driver gpy_drivers[] = {
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy_loopback,
 		.link_change_notify	= gpy_link_change_notify,
+		.update_stats	= gpy_update_stats,
+		.get_phy_stats	= gpy_get_phy_stats,
 	},
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_MXL86211C),
@@ -1412,6 +1468,8 @@ static struct phy_driver gpy_drivers[] = {
 		.led_hw_control_get = gpy_led_hw_control_get,
 		.led_hw_control_set = gpy_led_hw_control_set,
 		.led_polarity_set = gpy_led_polarity_set,
+		.update_stats	= gpy_update_stats,
+		.get_phy_stats	= gpy_get_phy_stats,
 	},
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_MXL86252),
@@ -1429,6 +1487,8 @@ static struct phy_driver gpy_drivers[] = {
 		.set_wol	= gpy_set_wol,
 		.get_wol	= gpy_get_wol,
 		.set_loopback	= gpy_loopback,
+		.update_stats	= gpy_update_stats,
+		.get_phy_stats	= gpy_get_phy_stats,
 		.led_brightness_set = gpy_led_brightness_set,
 		.led_hw_is_supported = gpy_led_hw_is_supported,
 		.led_hw_control_get = gpy_led_hw_control_get,
@@ -1451,6 +1511,8 @@ static struct phy_driver gpy_drivers[] = {
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


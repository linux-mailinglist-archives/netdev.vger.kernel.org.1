Return-Path: <netdev+bounces-252829-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDV+MqBjc2mivQAAu9opvQ
	(envelope-from <netdev+bounces-252829-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 13:03:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E13C7586D
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 13:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C06EC30747A8
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC9A33D6EE;
	Fri, 23 Jan 2026 12:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfhG+Py1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668B8340290
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 12:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769169695; cv=none; b=QqJ2XZ5AMM+o9wwvaP1uSOI1UrEbTZomMHBcUpGLy/l20sjhbuv12+I4G/gIEAgivUrsT3xBYRb31/2SKWSjLs3zGhDeUap/wKsTi101wNa3oK2hqjgvSMsZQWf50e3CpFl5Dk3i8lNK3QMJPzKeZXvIKQ1DTNygnwfKU5Ifl4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769169695; c=relaxed/simple;
	bh=argX+ekhVkmNswgZoOntqGB4oLHzgeu85h5GOyhgHik=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9adwW/DgeDRpk3bNnS4sDDZgRjz+LQvTEmVA2gZpsfoSlrne8B9+rUPf/1TO/1/1NCBRdQoU5zFBxCAP+DIDlLupRMQ49DDUdaOeze6uqm/Up6hIUkAMzNOAqTJ7gaPEy2MBuLRM9TjJcGLog/efxw4zBtp2c1KNwPJV2XzcmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfhG+Py1; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47ee2715254so11654515e9.3
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 04:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769169692; x=1769774492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JSvgyOqp8b8U8Jk0c4U57aOF95Ym7PtbxT8UnBm+Rrs=;
        b=kfhG+Py1p10h8wyA0M6YHYWuzIiTcGVJNG2pu8nHJnwaNm0ID7pahvEFuBrlyEVpZl
         W6CPYIu0nxkpR1fqK/oPft0yY/e1LBW8IsSVD5F4JVulWW50wsivESHD+c4t657/qsgM
         +W5T9F2JBNOYfje4IP5xG3xhIQj2UlD77Vh0R802P096QOwLlvqaQFNoflyYNhxgNU7T
         C7yW459e1oSJr/6FpOH7tq13Sq0Dihoh6v32g1uhIAGsB6zf8U7ml4OoQlUrpBunvbAq
         4iWF8aiy4nojQdmDslM6IuG67JppiljkcdKrxqxyfxR3zHJsWU/MVEpTxgGbVvkdF7Ut
         vaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769169692; x=1769774492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JSvgyOqp8b8U8Jk0c4U57aOF95Ym7PtbxT8UnBm+Rrs=;
        b=w5U9chXB2mhhb4g3LMw98YfOMFcq/0uc5ctVggnLdoirP8qeTkqQ34LtJOod2+bGLM
         uh52vKMdwdUybFP/qRzCouSDb9jYH7p4h61dAcBnufumIVzxYNj/rOwum4Yhx4bD8TxN
         jNlpnl4p/rzw4wgsECxltLfLYh6O+IWolQz8GN4YOOi4nAAc/XtkbK2tX0NaazYnCEus
         LY22A+GcU9lcvT7p/pK9CQ6OmZTyCFjPfOLpN5Fun4uH/fwoFrI5QRod0Rvx7ilwbgo0
         W/TlzOEM3M6GlbdC5JCaNNxd5hSq6YmsJY898fAcA2+jeyyYwZq8fJbp12g5x8QxnaHs
         yW6g==
X-Forwarded-Encrypted: i=1; AJvYcCUye75INK2lh76Il24NPRICFl5Oso5zdgu3/EvFzFsn3vgGH+k6eW3Ytsx8ia30A5rta8i6/4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9gNAF/h1ThGVcDv2bHZYPQogLV57pQhUidgdrfHqyW2iu0lAD
	sFV1thx8Jr7Zqn+XiY+GqT02EhreswOLPJmjUiGT1SVQT8pHdEBWHOTg
X-Gm-Gg: AZuq6aJQtF3UGxqigVgOwotg9rxeTVnCIlHpeWeI/NFLErdk1GnNZ/yHy2dNIOrqfIc
	hDFrrQ2CqLMcb//p3LaKiwJhINIMLmnXtXY2FHaUw7Lhyx7uzAGgAkh0x9swIYIDC6g8O6o+FJN
	9DG0ZPTuHS+FqVFnsxJS+ur9A+lvKy/D8K6Qb++uIbmU3VfhBjakiHddtRbo8tAmwFD7BpSSN6k
	UHrw0MbNLrqP5UpusSh4HkqdgIWnU5rJX/HTfCCv5M6q7908EQedBgmKVxP1zLNZ/kBAi1HmZvg
	k3X8UMlDdcNCkzcyWSFAdaz2tjw3984TW8TwYgg1ED6kGkQb5UyxURZvaw04bef8X1FPLjHbI6S
	41rCuTFeOYMGpW5++MonBrOM55C2aAxOKSy7iIUpuJfKh9XJkQh8YPKYs3OH6d1+NjAk2iVUA24
	0ORkKIql3/R5EJSlpySt0iUz3oDugsfHijKdPe/0bO
X-Received: by 2002:a05:600c:a00d:b0:477:a246:8398 with SMTP id 5b1f17b1804b1-4804c947d28mr48477335e9.2.1769169690230;
        Fri, 23 Jan 2026 04:01:30 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-88-81.ip49.fastwebnet.it. [93.34.88.81])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4804d603ac9sm21575135e9.4.2026.01.23.04.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 04:01:29 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v2 3/3] net: phy: as21xxx: fill in inband caps and better handle inband
Date: Fri, 23 Jan 2026 13:00:31 +0100
Message-ID: <20260123120117.10883-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123120117.10883-1-ansuelsmth@gmail.com>
References: <20260123120117.10883-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252829-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6E13C7586D
X-Rspamd-Action: no action

The as21xxx control In-Band support with the DPC RateAdapation
configuration.

Tested on a Banana Pi R4 PRO (MT7988a) and on Airoha AN7581/AN7583 where
In Band is controlled by disabling Autoneg on the PCS, where the PHY
correctly transfer packet with In Band disabled on the PCS and DPC RA
disabled on the PHY. It was also confirmed that with In Band enabled on
the PCS and DPC RA enabled on the PHY also packets gets transmitted
correctly.

With this new information, fill in the .inband_caps() OP and set the
.config_inband() to enable DPC RA when inband is enabled.

Support for this feature is enabled only on PHY firmware >= 1.9 as on
previous version the DPC RA could only be enabled and a PHY reset (and
Firmware reloaded) was needed to change this at runtime.

To keep compatibility with some HW configuration, we enable DPC RA by
default for older firmware. This is needed as on Banana Pi R4 PRO, one
of the 2 as21xxx PHY is attached to a Switch that requires the PHY in In
Band mode with Rate Adaption.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/as21xxx.c | 111 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 110 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/as21xxx.c b/drivers/net/phy/as21xxx.c
index 2098fa6a2f63..60ec7af6e386 100644
--- a/drivers/net/phy/as21xxx.c
+++ b/drivers/net/phy/as21xxx.c
@@ -125,6 +125,10 @@
 #define IPC_DATA_DBG_SEC		GENMASK(15, 8)
 #define IPC_DATA_DBG_CMD		GENMASK(7, 0)
 
+/* DBG_DPC sub command */
+#define IPC_DPC_RA_SET_CFG		0x2
+#define IPC_DPC_RA_GET_CFG		0x7
+
 #define AS21XXX_MDIO_AN_C22		0xffe0
 
 #define PHY_ID_AS21XXX			0x75009410
@@ -724,6 +728,52 @@ static int aeon_ipc_dbg_write_buf(struct phy_device *phydev, u8 *data,
 	return ret;
 }
 
+static int aeon_ipc_dpc_ra_set(struct phy_device *phydev, bool enable)
+{
+	u8 data[1];
+	int ret;
+
+	ret = aeon_ipc_dbg_cmd(phydev, IPC_DBG_DPC,
+			       IPC_DPC_RA_SET_CFG,
+			       sizeof(data));
+	if (ret)
+		return ret;
+
+	data[0] = enable;
+
+	ret = aeon_ipc_dbg_write_buf(phydev, data, sizeof(data));
+	if (ret)
+		return ret;
+
+	ret = aeon_ipc_poll(phydev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int aeon_ipc_dpc_ra_get(struct phy_device *phydev, bool *enabled)
+{
+	u16 ret_data[AEON_IPC_DATA_NUM_REGISTERS];
+	int ret;
+
+	ret = aeon_ipc_dbg_cmd(phydev, IPC_DBG_DPC,
+			       IPC_DPC_RA_GET_CFG, 0);
+	if (ret)
+		return ret;
+
+	ret = aeon_ipc_poll(phydev);
+	if (ret)
+		return ret;
+
+	ret = aeon_ipc_dbg_read_buf(phydev, ret_data);
+	if (ret < 0)
+		return ret;
+
+	*enabled = !!ret_data[0];
+	return 0;
+}
+
 static int aeon_dpc_ra_enable(struct phy_device *phydev)
 {
 	u16 data[2];
@@ -765,7 +815,11 @@ static int as21xxx_probe(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	return aeon_dpc_ra_enable(phydev);
+	/* Enable DPC Rate Adaption by default on older firmware */
+	if (priv->fw_major_ver == 1 && priv->fw_minor_ver < 9)
+		return aeon_dpc_ra_enable(phydev);
+
+	return 0;
 }
 
 static int as21xxx_read_link(struct phy_device *phydev, int *bmcr)
@@ -1078,6 +1132,41 @@ static int as21xxx_match_phy_device(struct phy_device *phydev,
 	return ret;
 }
 
+static unsigned int as21xxx_inband_caps(struct phy_device *phydev,
+					phy_interface_t interface)
+{
+	struct as21xxx_priv *priv = phydev->priv;
+
+	/* Configuring DPC Rate Adaption (to permit In Band support)
+	 * is supported only from firmware version 1.9+
+	 */
+	if (priv->fw_major_ver > 1 || priv->fw_minor_ver >= 9)
+		return LINK_INBAND_ENABLE | LINK_INBAND_DISABLE;
+
+	/* On older firmware we enforce In Band by default
+	 * for compatibility reason.
+	 */
+	return LINK_INBAND_ENABLE;
+}
+
+static int as21xxx_config_inband(struct phy_device *phydev,
+				 unsigned int modes)
+{
+	bool enabled;
+	int ret;
+
+	ret = aeon_ipc_dpc_ra_get(phydev, &enabled);
+	if (ret)
+		return ret;
+
+	/* Ignore if already in the desired mode */
+	if ((modes == LINK_INBAND_ENABLE && enabled) ||
+	    (modes == LINK_INBAND_DISABLE && !enabled))
+		return 0;
+
+	return aeon_ipc_dpc_ra_set(phydev, modes == LINK_INBAND_ENABLE);
+}
+
 static struct phy_driver as21xxx_drivers[] = {
 	{
 		/* PHY expose in C45 as 0x7500 0x9410
@@ -1093,6 +1182,8 @@ static struct phy_driver as21xxx_drivers[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_AS21011JB1),
 		.name		= "Aeonsemi AS21011JB1",
 		.probe		= as21xxx_probe,
+		.inband_caps	= as21xxx_inband_caps,
+		.config_inband	= as21xxx_config_inband,
 		.match_phy_device = as21xxx_match_phy_device,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
@@ -1105,6 +1196,8 @@ static struct phy_driver as21xxx_drivers[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_AS21011PB1),
 		.name		= "Aeonsemi AS21011PB1",
 		.probe		= as21xxx_probe,
+		.inband_caps	= as21xxx_inband_caps,
+		.config_inband	= as21xxx_config_inband,
 		.match_phy_device = as21xxx_match_phy_device,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
@@ -1117,6 +1210,8 @@ static struct phy_driver as21xxx_drivers[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_AS21010PB1),
 		.name		= "Aeonsemi AS21010PB1",
 		.probe		= as21xxx_probe,
+		.inband_caps	= as21xxx_inband_caps,
+		.config_inband	= as21xxx_config_inband,
 		.match_phy_device = as21xxx_match_phy_device,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
@@ -1129,6 +1224,8 @@ static struct phy_driver as21xxx_drivers[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_AS21010JB1),
 		.name		= "Aeonsemi AS21010JB1",
 		.probe		= as21xxx_probe,
+		.inband_caps	= as21xxx_inband_caps,
+		.config_inband	= as21xxx_config_inband,
 		.match_phy_device = as21xxx_match_phy_device,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
@@ -1141,6 +1238,8 @@ static struct phy_driver as21xxx_drivers[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_AS21210PB1),
 		.name		= "Aeonsemi AS21210PB1",
 		.probe		= as21xxx_probe,
+		.inband_caps	= as21xxx_inband_caps,
+		.config_inband	= as21xxx_config_inband,
 		.match_phy_device = as21xxx_match_phy_device,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
@@ -1153,6 +1252,8 @@ static struct phy_driver as21xxx_drivers[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_AS21510JB1),
 		.name		= "Aeonsemi AS21510JB1",
 		.probe		= as21xxx_probe,
+		.inband_caps	= as21xxx_inband_caps,
+		.config_inband	= as21xxx_config_inband,
 		.match_phy_device = as21xxx_match_phy_device,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
@@ -1165,6 +1266,8 @@ static struct phy_driver as21xxx_drivers[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_AS21510PB1),
 		.name		= "Aeonsemi AS21510PB1",
 		.probe		= as21xxx_probe,
+		.inband_caps	= as21xxx_inband_caps,
+		.config_inband	= as21xxx_config_inband,
 		.match_phy_device = as21xxx_match_phy_device,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
@@ -1177,6 +1280,8 @@ static struct phy_driver as21xxx_drivers[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_AS21511JB1),
 		.name		= "Aeonsemi AS21511JB1",
 		.probe		= as21xxx_probe,
+		.inband_caps	= as21xxx_inband_caps,
+		.config_inband	= as21xxx_config_inband,
 		.match_phy_device = as21xxx_match_phy_device,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
@@ -1189,6 +1294,8 @@ static struct phy_driver as21xxx_drivers[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_AS21210JB1),
 		.name		= "Aeonsemi AS21210JB1",
 		.probe		= as21xxx_probe,
+		.inband_caps	= as21xxx_inband_caps,
+		.config_inband	= as21xxx_config_inband,
 		.match_phy_device = as21xxx_match_phy_device,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
@@ -1201,6 +1308,8 @@ static struct phy_driver as21xxx_drivers[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_AS21511PB1),
 		.name		= "Aeonsemi AS21511PB1",
 		.probe		= as21xxx_probe,
+		.inband_caps	= as21xxx_inband_caps,
+		.config_inband	= as21xxx_config_inband,
 		.match_phy_device = as21xxx_match_phy_device,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
-- 
2.51.0



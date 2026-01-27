Return-Path: <netdev+bounces-253867-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJIjEaa7eGm0sgEAu9opvQ
	(envelope-from <netdev+bounces-253867-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:20:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC57C94CF0
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AADB304A9C6
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E383563FF;
	Tue, 27 Jan 2026 13:19:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978E9284690;
	Tue, 27 Jan 2026 13:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769519941; cv=none; b=Mnbb4d2hrt0tjL9cBQnLITs/NxrR3bTRk66s1a0Qc7UdCCQcbDCK/if5mo99mOCZvCidRVyFkEeUhswi9dSNImsU3wPfO4PrgzoaBAafuuNejEyjslUtmJvJfK8QBuQeUmewV0Husb2fynmgO0zpIDbUEXQdbOreq1ojYKUOtlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769519941; c=relaxed/simple;
	bh=1gtUumC4TmfZHWPDt1Gl1OUd8p+6pJQW372zQwMXqu0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpZyr2XEaiCCmqrHx1q4oDmpa5mWSgAmODc6FvqVviLHeBsp3xba3fcSXwbPJ+A8WrXuel5X8YogvQzXfjsiEWG9eV1BmVJYLhvV2C86o4KTLU4J4itHHvehaWpIYqE0wOR4aRfrbal0dSpTPYG3lkIh2f8/gV2/YiqxK3jpMqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vkiy8-000000000Sz-0EkY;
	Tue, 27 Jan 2026 13:18:56 +0000
Date: Tue, 27 Jan 2026 13:18:53 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/3] net: dsa: mxl-gsw1xx: validate chip ID
Message-ID: <ce85ecfe2792a34ba7e0498b7027ecdd73fc621f.1769519758.git.daniel@makrotopia.org>
References: <cover.1769519758.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1769519758.git.daniel@makrotopia.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253867-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[makrotopia.org];
	FREEMAIL_TO(0.00)[hauke-m.de,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,makrotopia.org:mid,makrotopia.org:email]
X-Rspamd-Queue-Id: AC57C94CF0
X-Rspamd-Action: no action

No check for actually present hardware is being performed in the probe
function of the mxl-gsw1xx switch driver. So even if the switch isn't
present at the configured MDIO bus address the driver wrongly tells the
user that a "GSWIP version 0 mod 0" was found, outputting errors about
PHY capabilities not matching.

Read and validate the chip MANU_ID and PNUM_ID registers and output
information while probing, but return an error and abort probing in case
the hardware is not actually present.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq/mxl-gsw1xx.c | 27 ++++++++++++++++++++++++++-
 drivers/net/dsa/lantiq/mxl-gsw1xx.h |  9 +++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
index 6284b9afdbbb..68034ce25e5a 100644
--- a/drivers/net/dsa/lantiq/mxl-gsw1xx.c
+++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
@@ -689,7 +689,9 @@ static int gsw1xx_probe(struct mdio_device *mdiodev)
 {
 	struct device *dev = &mdiodev->dev;
 	struct gsw1xx_priv *priv;
-	u32 version;
+	u32 version, val;
+	u8 shellver;
+	u16 pnum;
 	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -737,6 +739,27 @@ static int gsw1xx_probe(struct mdio_device *mdiodev)
 	if (IS_ERR(priv->shell))
 		return PTR_ERR(priv->shell);
 
+	ret = regmap_read(priv->shell, GSW1XX_SHELL_MANU_ID, &val);
+	if (ret < 0)
+		return ret;
+
+	/* validate chip ID */
+	if (FIELD_GET(GSW1XX_SHELL_MANU_ID_FIX1, val) != 1)
+		return -ENODEV;
+
+	if (FIELD_GET(GSW1XX_SHELL_MANU_ID_MANID, val) !=
+	    GSW1XX_SHELL_MANU_ID_MANID_VAL)
+		return -ENODEV;
+
+	pnum = FIELD_GET(GSW1XX_SHELL_MANU_ID_PNUML, val);
+
+	ret = regmap_read(priv->shell, GSW1XX_SHELL_PNUM_ID, &val);
+	if (ret < 0)
+		return ret;
+
+	pnum |= FIELD_GET(GSW1XX_SHELL_PNUM_ID_PNUMM, val) << 4;
+	shellver = FIELD_GET(GSW1XX_SHELL_PNUM_ID_VER, val);
+
 	ret = gsw1xx_serdes_pcs_init(priv);
 	if (ret < 0)
 		return ret;
@@ -757,6 +780,8 @@ static int gsw1xx_probe(struct mdio_device *mdiodev)
 	if (ret)
 		return ret;
 
+	dev_info(dev, "standalone switch part number 0x%x v1.%u\n", pnum, shellver);
+
 	dev_set_drvdata(dev, &priv->gswip);
 
 	return 0;
diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.h b/drivers/net/dsa/lantiq/mxl-gsw1xx.h
index d1fded56e967..caa8f1008587 100644
--- a/drivers/net/dsa/lantiq/mxl-gsw1xx.h
+++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.h
@@ -110,6 +110,15 @@
 #define GSW1XX_SHELL_BASE			0xfa00
 #define  GSW1XX_SHELL_RST_REQ			0x01
 #define   GSW1XX_RST_REQ_SGMII_SHELL		BIT(5)
+#define  GSW1XX_SHELL_MANU_ID			0x10
+#define   GSW1XX_SHELL_MANU_ID_PNUML		GENMASK(15, 12)
+#define   GSW1XX_SHELL_MANU_ID_MANID		GENMASK(11, 1)
+#define    GSW1XX_SHELL_MANU_ID_MANID_VAL	0x389
+#define   GSW1XX_SHELL_MANU_ID_FIX1		BIT(0)
+#define  GSW1XX_SHELL_PNUM_ID			0x11
+#define   GSW1XX_SHELL_PNUM_ID_VER		GENMASK(15, 12)
+#define   GSW1XX_SHELL_PNUM_ID_PNUMM		GENMASK(11, 0)
+
 /* RGMII PAD Slew Control Register */
 #define  GSW1XX_SHELL_RGMII_SLEW_CFG		0x78
 #define   RGMII_SLEW_CFG_DRV_TXC		BIT(2)
-- 
2.52.0


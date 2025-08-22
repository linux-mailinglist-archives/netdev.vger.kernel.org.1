Return-Path: <netdev+bounces-216097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 828C5B3206A
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 18:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0DD9E1C47
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 16:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0469D2820D1;
	Fri, 22 Aug 2025 16:12:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BB1281525;
	Fri, 22 Aug 2025 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755879151; cv=none; b=iImEaDsrgmNK9P/4a7lgOPRLUoFjlLveUO1oxUGjSWkcQTivUbuYPZ3IEdV9oe/Rsw0iLmfV+Zy10pQB+r1NFQKkNT6M6OgFi6Ff3Z0HoO10dzo3Jyg0lXkg95UCVWiD96QAib2GEbVNEvJrLwChcSuGrQGcoA0HpzwGbccJmAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755879151; c=relaxed/simple;
	bh=v43CVOfdATmGLdEU2YvxTHCWbyWikT9BQFV6cJxMbUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atqW0KF9RUhD3R7jObE04L46geLPGoNlbdTPH962Ho9LiSubZrAYAXcuvXubdLvPNk8OggguF3Br1j22YKrWY0W6NC7a2Nl8R9F2KrTz6nlK95aOmwPeb+UtGskWYhSJ7e1hf5Idn4Y/keiq067cktU0GE4uvi1dIdV4aVOEM48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1upUNN-000000006pC-16Fr;
	Fri, 22 Aug 2025 16:12:25 +0000
Date: Fri, 22 Aug 2025 17:12:21 +0100
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
Subject: [PATCH net-next v4 7/7] net: dsa: lantiq_gswip: store switch API
 version in priv
Message-ID: <eddb51ae8d0b2046ca91906e93daad7be5af56d7.1755878232.git.daniel@makrotopia.org>
References: <cover.1755878232.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1755878232.git.daniel@makrotopia.org>

Store the switch API version in struct gswip_priv. As the hardware has
the 'major/minor' version bytes in the wrong order preventing numerical
comparisons the version to be stored in gswip_priv is constructed in
such a way that the REV field is the most significant byte and the MOD
field the least significant byte. Also provide a conveniance macro to
allow comparing the stored version of the hardware against the already
defined GSWIP_VERSION_* macros.

This is done in order to prepare supporting newer features such as 4096
VLANs and per-port configurable learning which are only available
starting from specific hardware versions.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v4: use FIELD_GET accessor macro to construct version to be stored,
    add comments and postpone adding the for now unused
    GSWIP_VERSION_2_3 macro
v3: use __force for version field endian exception (__le16 __force) to
    fix sparse warning.
v2: no changes

 drivers/net/dsa/lantiq_gswip.c | 13 +++++++++++--
 drivers/net/dsa/lantiq_gswip.h | 13 +++++++++++--
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index f8a43c351649..638f9a42f218 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -1908,6 +1908,16 @@ static int gswip_probe(struct platform_device *pdev)
 	mutex_init(&priv->pce_table_lock);
 	version = gswip_switch_r(priv, GSWIP_VERSION);
 
+	/* The hardware has the 'major/minor' version bytes in the wrong order
+	 * preventing numerical comparisons. Construct a 16-bit unsigned integer
+	 * having the REV field as most significant byte and the MOD field as
+	 * least significant byte. This is effectively swapping the two bytes of
+	 * the version variable, but other than using swab16 it doesn't affect
+	 * the source variable.
+	 */
+	priv->version = GSWIP_VERSION_REV(version) << 8 |
+			GSWIP_VERSION_MOD(version);
+
 	np = dev->of_node;
 	switch (version) {
 	case GSWIP_VERSION_2_0:
@@ -1956,8 +1966,7 @@ static int gswip_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, priv);
 
 	dev_info(dev, "probed GSWIP version %lx mod %lx\n",
-		 (version & GSWIP_VERSION_REV_MASK) >> GSWIP_VERSION_REV_SHIFT,
-		 (version & GSWIP_VERSION_MOD_MASK) >> GSWIP_VERSION_MOD_SHIFT);
+		 GSWIP_VERSION_REV(version), GSWIP_VERSION_MOD(version));
 	return 0;
 
 disable_switch:
diff --git a/drivers/net/dsa/lantiq_gswip.h b/drivers/net/dsa/lantiq_gswip.h
index 0b7b6db4eab9..620c2d560cbe 100644
--- a/drivers/net/dsa/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq_gswip.h
@@ -7,6 +7,7 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
+#include <linux/swab.h>
 #include <net/dsa.h>
 
 /* GSWIP MDIO Registers */
@@ -85,14 +86,21 @@
 #define  GSWIP_SWRES_R1			BIT(1)	/* GSWIP Software reset */
 #define  GSWIP_SWRES_R0			BIT(0)	/* GSWIP Hardware reset */
 #define GSWIP_VERSION			0x013
-#define  GSWIP_VERSION_REV_SHIFT	0
 #define  GSWIP_VERSION_REV_MASK		GENMASK(7, 0)
-#define  GSWIP_VERSION_MOD_SHIFT	8
 #define  GSWIP_VERSION_MOD_MASK		GENMASK(15, 8)
+#define  GSWIP_VERSION_REV(v)		FIELD_GET(GSWIP_VERSION_REV_MASK, v)
+#define  GSWIP_VERSION_MOD(v)		FIELD_GET(GSWIP_VERSION_MOD_MASK, v)
 #define   GSWIP_VERSION_2_0		0x100
 #define   GSWIP_VERSION_2_1		0x021
 #define   GSWIP_VERSION_2_2		0x122
 #define   GSWIP_VERSION_2_2_ETC		0x022
+/* The hardware has the 'major/minor' version bytes in the wrong order
+ * preventing numerical comparisons. Swap the bytes of the 16-bit value
+ * to end up with REV being the most significant byte and MOD being the
+ * least significant byte, which then allows comparing it with the
+ * value stored in struct gswip_priv.
+ */
+#define GSWIP_VERSION_GE(priv, ver)	((priv)->version >= swab16(ver))
 
 #define GSWIP_BM_RAM_VAL(x)		(0x043 - (x))
 #define GSWIP_BM_RAM_ADDR		0x044
@@ -258,6 +266,7 @@ struct gswip_priv {
 	struct gswip_gphy_fw *gphy_fw;
 	u32 port_vlan_filter;
 	struct mutex pce_table_lock;
+	u16 version;
 };
 
 #endif /* __LANTIQ_GSWIP_H */
-- 
2.50.1


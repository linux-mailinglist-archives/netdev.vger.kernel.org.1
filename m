Return-Path: <netdev+bounces-56445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D893F80EE75
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 15:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BB771F21236
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 14:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300667316E;
	Tue, 12 Dec 2023 14:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khkQlVtJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD359FF;
	Tue, 12 Dec 2023 06:12:02 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-336356d9092so263881f8f.2;
        Tue, 12 Dec 2023 06:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702390321; x=1702995121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pwano9guwZgppKOMB5aK4J4782C3dg8VANWXqW1Jv/c=;
        b=khkQlVtJs8MSXYRAN5wSrbK8t/Ky9YjqhQgy8B5S6Iw1YsxPhKJmWeocvnNxND9P4y
         geTm6pbrOfexcYtiWx2M+5see8KhTyL5gjt8TPXn/bbh3XtUTszoZTpjcX5FU+ON9Qzv
         CA+/fAYf5JVvQIw4vWBdqwd55DQhnsYnB1YJrduPepJV2a/ckNHOzNcBOuT8dnrTmfsT
         WAEy2XuGniKhqoaxUihBYOVIHw2diTD/77aNeMX9ZfzNY2ONPK+TogcoiKQTOLi8HFaF
         TF/3xz/GETRgop8ZZCZ6CFF99jx/9ZvZXLe5p3Dz26vRWcxFaDxoMcB45yJ924DT/YN3
         cIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702390321; x=1702995121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pwano9guwZgppKOMB5aK4J4782C3dg8VANWXqW1Jv/c=;
        b=vC96whIY0BXCSjQ/8WdtytROVNNnVIou8DWFterfsf0GyWGoTeUK0ys5avlxRNteL0
         QhgmyQudusMpPGwFUmlMrBpktwlMC7LbRHvDfwLHq3zBUVh1bQkY3j/BKZjm9QQPbAtr
         EFmcXXmlY6XCwAJRu1yvY4fjGghbMbMOKUSZSxrffZELx6LLCTtKpQakMljgkD9SlRnF
         1yHYOF2XKsho/3busYsxMKCAXLTq6Fs7jkOTBpaffYTLt21XgcDSHKxN36BmmKqfPd1Q
         vSECA7BZhRE6t7qOgnk/IzS6TZheClCMbY5s0TMJCYBKvokhZCNWTUb09BxOQMh9VfcF
         LiEw==
X-Gm-Message-State: AOJu0YwffVN/XmbJCTzbwFx5Dav2Ywfsb5YH0T9ilgoHhzjjDazW70mN
	fgMEdvaLstuwXl957MPOPxs=
X-Google-Smtp-Source: AGHT+IHU7VRTf2bVnL21KJoSeULrZCVIcNlyZpBJvxAksi4Ci/dj7EQpfx/j7ClSjfOl9OX7jnsOAA==
X-Received: by 2002:adf:ee47:0:b0:333:2fd2:8170 with SMTP id w7-20020adfee47000000b003332fd28170mr3211089wro.141.1702390321048;
        Tue, 12 Dec 2023 06:12:01 -0800 (PST)
Received: from eichest-laptop.. ([178.197.202.123])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d48d0000000b0033616ea5a0fsm7906913wrs.45.2023.12.12.06.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 06:12:00 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: maxime.chevallier@bootlin.com,
	mw@semihalf.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: mvpp2: add support for mii
Date: Tue, 12 Dec 2023 15:12:00 +0100
Message-Id: <20231212141200.62579-1-eichest@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, mvpp2 only supports RGMII. This commit adds support for MII.
The description in Marvell's functional specification seems to be wrong.
To enable MII, we need to set GENCONF_CTRL0_PORT3_RGMII, while for RGMII
we need to clear it. This is also how U-Boot handles it.

Signed-off-by: Stefan Eichenberger <eichest@gmail.com>
---
v2:
- Remove PHY_INTERFACE_MODE_100BASEX from supported_interfaces (Maxime)
---
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 21 ++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 93137606869e..c5f72a1ef928 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -1513,10 +1513,21 @@ static void mvpp22_gop_init_rgmii(struct mvpp2_port *port)
 	regmap_write(priv->sysctrl_base, GENCONF_PORT_CTRL0, val);
 
 	regmap_read(priv->sysctrl_base, GENCONF_CTRL0, &val);
-	if (port->gop_id == 2)
+	if (port->gop_id == 2) {
 		val |= GENCONF_CTRL0_PORT2_RGMII;
-	else if (port->gop_id == 3)
+	} else if (port->gop_id == 3) {
 		val |= GENCONF_CTRL0_PORT3_RGMII_MII;
+
+		/* According to the specification, GENCONF_CTRL0_PORT3_RGMII
+		 * should be set to 1 for RGMII and 0 for MII. However, tests
+		 * show that it is the other way around. This is also what
+		 * U-Boot does for mvpp2, so it is assumed to be correct.
+		 */
+		if (port->phy_interface == PHY_INTERFACE_MODE_MII)
+			val |= GENCONF_CTRL0_PORT3_RGMII;
+		else
+			val &= ~GENCONF_CTRL0_PORT3_RGMII;
+	}
 	regmap_write(priv->sysctrl_base, GENCONF_CTRL0, val);
 }
 
@@ -1615,6 +1626,7 @@ static int mvpp22_gop_init(struct mvpp2_port *port, phy_interface_t interface)
 		return 0;
 
 	switch (interface) {
+	case PHY_INTERFACE_MODE_MII:
 	case PHY_INTERFACE_MODE_RGMII:
 	case PHY_INTERFACE_MODE_RGMII_ID:
 	case PHY_INTERFACE_MODE_RGMII_RXID:
@@ -6948,8 +6960,11 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 					MAC_10000FD;
 		}
 
-		if (mvpp2_port_supports_rgmii(port))
+		if (mvpp2_port_supports_rgmii(port)) {
 			phy_interface_set_rgmii(port->phylink_config.supported_interfaces);
+			__set_bit(PHY_INTERFACE_MODE_MII,
+				  port->phylink_config.supported_interfaces);
+		}
 
 		if (comphy) {
 			/* If a COMPHY is present, we can support any of the
-- 
2.40.1



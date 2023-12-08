Return-Path: <netdev+bounces-55324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB51680A638
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 15:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7765328111C
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 14:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE0720B10;
	Fri,  8 Dec 2023 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6VZUtd+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4808419A1;
	Fri,  8 Dec 2023 06:52:15 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c09f4bea8so23343965e9.1;
        Fri, 08 Dec 2023 06:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702047133; x=1702651933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xPT5eitsPLMWqf9JvP+rrRy2e2KvhKrvYQ5CxZDAVg=;
        b=k6VZUtd+i34aIFvxN1LZ2iwjt9OiyogBuCb1Pb8ApKbvskaenCfqhVgqhdni9tq1x7
         PiblA+ZwQjp9HktUxlzCM9eoiYP0m9fFVrLwohq5s4u04vb4PMabsdwQBJorNkbHqY7x
         8v+EfLg5ist3XDdmoZOQpNuE63RRhp9baOS3lyow6V+9SHddJ3uDpVqfCxrgZSoQJgwK
         9K/ph74veol19tCfyc+XZnxGx7nSqr6+ufEXfOSP1uU087Wk8YPsvVn3W251leVN1T9z
         WUNb1v5FCRV5suFQkYmfePy+RhCKUPEsujVOmBWJiQBWxeJKjcl6HBJdRH/81Slp/mEO
         qSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702047133; x=1702651933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xPT5eitsPLMWqf9JvP+rrRy2e2KvhKrvYQ5CxZDAVg=;
        b=ABQipJLm5pUd6/llphZ5UO1pJuELtRYj2c/cgr8/Jw92mC5vpfn8tbwG9NrAhu1okR
         9Her9aDtSTsBPwTXq9dTT87qS7a6jsN67WI5mzKzmjX9tdk24P6y34h4Vr0LeiDxWzUh
         TNhgzIrfPeAI+TfkK5Mn57YDk++Wz9szfBpQeyAfUXs/2AEbGSmJHqfLADjWLDALLBjW
         S/Hmt9dgAotiBJjpkav2v2ZgGql3EYEezY4K2rDYyhxXztp7AJmwwAYAIfBo2xhXuhji
         +i35o7D0s1Z3d8al5W3z9sZHdxeQPbF4tzieMOIaSAkhh2r576eF0r4D7AcPXobervFk
         d+kw==
X-Gm-Message-State: AOJu0Yznbc0Ii2Q+2lWCCGXpeqkVIz9uixj470fyrxi9GlAmNryNu/5I
	tGlI8sBH6QYEiM8FglYjD4Y=
X-Google-Smtp-Source: AGHT+IGzOVMestV1zQHtSsFECYZkabM6IvIokypmmsUerQb4p914/KLF2mT4Kn9HmIba1n5stNqhww==
X-Received: by 2002:a05:600c:4709:b0:40b:3dae:1ff6 with SMTP id v9-20020a05600c470900b0040b3dae1ff6mr60904wmo.14.1702047133519;
        Fri, 08 Dec 2023 06:52:13 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id r9-20020a05600c458900b0040b3e79bad3sm3088264wmo.40.2023.12.08.06.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 06:52:13 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v4 06/13] net: phy: at803x: move specific at8031 probe mode check to dedicated probe
Date: Fri,  8 Dec 2023 15:51:53 +0100
Message-Id: <20231208145200.25162-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231208145200.25162-1-ansuelsmth@gmail.com>
References: <20231208145200.25162-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move specific at8031 probe mode check to dedicated probe to make
at803x_probe more generic and keep code tidy.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/at803x.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 5694c2667b4d..6cb41af31818 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -844,26 +844,6 @@ static int at803x_probe(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	if (phydev->drv->phy_id == ATH8031_PHY_ID) {
-		int ccr = phy_read(phydev, AT803X_REG_CHIP_CONFIG);
-		int mode_cfg;
-
-		if (ccr < 0)
-			return ccr;
-		mode_cfg = ccr & AT803X_MODE_CFG_MASK;
-
-		switch (mode_cfg) {
-		case AT803X_MODE_CFG_BX1000_RGMII_50OHM:
-		case AT803X_MODE_CFG_BX1000_RGMII_75OHM:
-			priv->is_1000basex = true;
-			fallthrough;
-		case AT803X_MODE_CFG_FX100_RGMII_50OHM:
-		case AT803X_MODE_CFG_FX100_RGMII_75OHM:
-			priv->is_fiber = true;
-			break;
-		}
-	}
-
 	return 0;
 }
 
@@ -1584,6 +1564,9 @@ static int at8031_parse_dt(struct phy_device *phydev)
 
 static int at8031_probe(struct phy_device *phydev)
 {
+	struct at803x_priv *priv = phydev->priv;
+	int mode_cfg;
+	int ccr;
 	int ret;
 
 	ret = at803x_probe(phydev);
@@ -1597,6 +1580,22 @@ static int at8031_probe(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	ccr = phy_read(phydev, AT803X_REG_CHIP_CONFIG);
+	if (ccr < 0)
+		return ccr;
+	mode_cfg = ccr & AT803X_MODE_CFG_MASK;
+
+	switch (mode_cfg) {
+	case AT803X_MODE_CFG_BX1000_RGMII_50OHM:
+	case AT803X_MODE_CFG_BX1000_RGMII_75OHM:
+		priv->is_1000basex = true;
+		fallthrough;
+	case AT803X_MODE_CFG_FX100_RGMII_50OHM:
+	case AT803X_MODE_CFG_FX100_RGMII_75OHM:
+		priv->is_fiber = true;
+		break;
+	}
+
 	/* Disable WoL in 1588 register which is enabled
 	 * by default
 	 */
-- 
2.40.1



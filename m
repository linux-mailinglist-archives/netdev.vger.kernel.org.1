Return-Path: <netdev+bounces-55325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F09B480A639
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 15:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A59DA1F21373
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 14:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792DE200B6;
	Fri,  8 Dec 2023 14:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSan3pD/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B786386F;
	Fri,  8 Dec 2023 06:52:20 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40c256ffdbcso22578955e9.2;
        Fri, 08 Dec 2023 06:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702047138; x=1702651938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/LkCIkEWQjEgEt2tt9hxl04Qa/tBAKJsHnx5bVDjm0=;
        b=QSan3pD/hLnk9N111xORmrs2/4lCjvmbEvF+NYk87r5FeV4Y1G9Z23+scCPLEZ8AZG
         BN/iDpS02MmF0QfYnvzIMomea8ny6F3OYFRwvS7VTRfLGgkdMYUa9c3/HczoSSrwqec+
         1acM9FlauXk3y0LQb4SXouffuOqi7MTuJEOduHPqt/RzWRTE9YHAhMy+gHlSgKsRYJJP
         FOcE05gL6Zp0w1e8TezMY/DcwkzeV+EUYtGqSi0eHdYClfjEwsvb6j/pgE4QLKoqi4AC
         MyyiLWDei7d461icI0QiIL8MGgB9K4NzCnRsW2eSeGbFpZdVnRZDhxkFdGKLr5XxVtpc
         WKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702047138; x=1702651938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l/LkCIkEWQjEgEt2tt9hxl04Qa/tBAKJsHnx5bVDjm0=;
        b=Z1e5h31I6OIhU4IDnDMhcHAprV6qupIwfYaqxWlq2wuPFjQEr82CTYlrP6uspuljUY
         diMKxZChlfeJPMDbvHuIJQp6O48tFSfHMs9XwGrIO+A9qqcIrwA6KmiYj8RZictHvf1I
         yXbYrq90ZNkIZnkImP94LreDokCkQASUGZRZJxh/hzqOQoFPvBaC58WK8zBZAeipDDIO
         Wlgrx6qLIlAM+7e3Y3f2gj9xlZjsyeIyDC24HKJiu27bmQQacmbLBXoIel7dhlI10Eev
         KIAhTD+KmKoIOL4gFWyPPjmQ6u16WetbRL9Jy6WWMFcM/HS4EOlGfYMZdCzK2td5blLw
         cc9w==
X-Gm-Message-State: AOJu0YwEiVTX7cwB3r7HscKrTyg/3wjDTSfEA/qUDAi6ievH4J9MxyMQ
	GinrPAx99kDG2Tg5cL8aq4g=
X-Google-Smtp-Source: AGHT+IFj7dF/TB9yUsm0f4KRaidOuh26cbvdaL9a+KV72dPfZQWHlZGgIqNx4q2NMoWrJNnhAJwfUw==
X-Received: by 2002:a05:600c:492f:b0:40b:5e1e:cf6 with SMTP id f47-20020a05600c492f00b0040b5e1e0cf6mr53165wmp.49.1702047138266;
        Fri, 08 Dec 2023 06:52:18 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id r9-20020a05600c458900b0040b3e79bad3sm3088264wmo.40.2023.12.08.06.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 06:52:17 -0800 (PST)
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
Subject: [net-next PATCH v4 10/13] net: phy: at803x: make at8031 related DT functions name more specific
Date: Fri,  8 Dec 2023 15:51:57 +0100
Message-Id: <20231208145200.25162-11-ansuelsmth@gmail.com>
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

Rename at8031 related DT function name to a more specific name
referencing they are only related to at8031 and not to the generic
at803x PHY family.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/at803x.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 83428305281b..7443bc8fe17c 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -583,7 +583,7 @@ static int at803x_resume(struct phy_device *phydev)
 	return phy_modify(phydev, MII_BMCR, BMCR_PDOWN | BMCR_ISOLATE, 0);
 }
 
-static int at803x_rgmii_reg_set_voltage_sel(struct regulator_dev *rdev,
+static int at8031_rgmii_reg_set_voltage_sel(struct regulator_dev *rdev,
 					    unsigned int selector)
 {
 	struct phy_device *phydev = rdev_get_drvdata(rdev);
@@ -596,7 +596,7 @@ static int at803x_rgmii_reg_set_voltage_sel(struct regulator_dev *rdev,
 					     AT803X_DEBUG_RGMII_1V8, 0);
 }
 
-static int at803x_rgmii_reg_get_voltage_sel(struct regulator_dev *rdev)
+static int at8031_rgmii_reg_get_voltage_sel(struct regulator_dev *rdev)
 {
 	struct phy_device *phydev = rdev_get_drvdata(rdev);
 	int val;
@@ -610,8 +610,8 @@ static int at803x_rgmii_reg_get_voltage_sel(struct regulator_dev *rdev)
 
 static const struct regulator_ops vddio_regulator_ops = {
 	.list_voltage = regulator_list_voltage_table,
-	.set_voltage_sel = at803x_rgmii_reg_set_voltage_sel,
-	.get_voltage_sel = at803x_rgmii_reg_get_voltage_sel,
+	.set_voltage_sel = at8031_rgmii_reg_set_voltage_sel,
+	.get_voltage_sel = at8031_rgmii_reg_get_voltage_sel,
 };
 
 static const unsigned int vddio_voltage_table[] = {
@@ -666,7 +666,7 @@ static int at8031_register_regulators(struct phy_device *phydev)
 	return 0;
 }
 
-static int at803x_sfp_insert(void *upstream, const struct sfp_eeprom_id *id)
+static int at8031_sfp_insert(void *upstream, const struct sfp_eeprom_id *id)
 {
 	struct phy_device *phydev = upstream;
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(phy_support);
@@ -710,10 +710,10 @@ static int at803x_sfp_insert(void *upstream, const struct sfp_eeprom_id *id)
 	return 0;
 }
 
-static const struct sfp_upstream_ops at803x_sfp_ops = {
+static const struct sfp_upstream_ops at8031_sfp_ops = {
 	.attach = phy_sfp_attach,
 	.detach = phy_sfp_detach,
-	.module_insert = at803x_sfp_insert,
+	.module_insert = at8031_sfp_insert,
 };
 
 static int at803x_parse_dt(struct phy_device *phydev)
@@ -1519,7 +1519,7 @@ static int at8031_parse_dt(struct phy_device *phydev)
 	}
 
 	/* Only AR8031/8033 support 1000Base-X for SFP modules */
-	return phy_sfp_probe(phydev, &at803x_sfp_ops);
+	return phy_sfp_probe(phydev, &at8031_sfp_ops);
 }
 
 static int at8031_probe(struct phy_device *phydev)
-- 
2.40.1



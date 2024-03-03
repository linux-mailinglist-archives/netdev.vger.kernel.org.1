Return-Path: <netdev+bounces-76887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2373C86F463
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 11:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834B01F2160C
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 10:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB819BE48;
	Sun,  3 Mar 2024 10:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neHdgbtg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196A2B66C
	for <netdev@vger.kernel.org>; Sun,  3 Mar 2024 10:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709461739; cv=none; b=PqkCv0p9eDT4kElf1njoTjf9EwpQ0+xuMG27u2u1g5sf6OeLmth1R13CgA7Jbc0wO9etCiPltBJwEJj7/msXKsl8/xkSH7S47jiH5aeJaK0oIhz0HKFaM+hvAelg7lsgRKfRrnpxLB6L92ZG0KRh1xMny4HilzyyDYtOodvhKi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709461739; c=relaxed/simple;
	bh=LIyHiAiVE2ZRftipgvkLI5r2cMqN7AsKKJxK53s9G7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eDJwz29EErLzhWJXvTJVWrEvo0CZN1Pvpy4rz4jPa1p3nQSNJJTJFEhx9ZWpeCZqbsVdvB6tgVGJ3KNNy0F1BfeNdrjVHanEbZ6DA8/CeTK0sOVG4c0NGhaKMIAY3/qrVWDSGueSbpc8xAGD28AYh6FupTigjK4VKA7iarMeyo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=neHdgbtg; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a445587b796so354746366b.1
        for <netdev@vger.kernel.org>; Sun, 03 Mar 2024 02:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709461736; x=1710066536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+ub2j93bWVCOYfTvPlxZokH1A9Y30q8BP/f+XgJEPc=;
        b=neHdgbtgSA/p/U4wWvEZOvgYZ0hJSXXBLLSLlN2aIk4IgtrZemxd3J9MCP2TSsEHDr
         2o8S3MlzwJO9an872ntAQbBb3FYF388kgkz+27ap1s4myRTWxIZjjVzmFlatL+bOg4HD
         tpz2PbLb1ud0hSgnyTME324JGg8SPdQAR/TB022S4EcpzQglk4F9Gcg7mlFLqtpTR2yc
         6xDg+ku49dkaKuNyvj38OVoabShY/tFTWcQdzaJ0GeaLFUK1i+3tVdDZHO0iISGbGA4X
         V7nbZfZwN8Tax4YT5OfvBMBAV1QVz6qk5oTkJVG9RGCXtiQg/e46e3d+/2UkZ7QTq9cb
         Q4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709461736; x=1710066536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+ub2j93bWVCOYfTvPlxZokH1A9Y30q8BP/f+XgJEPc=;
        b=Fo9WUFCvXOqa6XYRQynMfRp8O7pcOKX5hcgQ2KBIITg7lxuX+ew6KxCVbHGWGKrkuM
         YSNHRbUA0i1TpuP3Xmn/qi2joIEO8sdU3EzgNGFolnsMHSpot9IVmakGOpw2pnzirgDo
         OY2EO8Pbi/goufed4MFMs/8nsiHN8wX+YeNme17LbeLfbq94g0+OclnXV+/K8l2gBHJV
         L1IiCDZ0Q5RH0zWEaW+Qrqy3ot9YsjIRNt6wRgn3azhTlOGFOBvvXvMV3ZrDkP30hQJr
         rmpioOgWuttFSfiBEUxL6+z0HuKYMgNdH4bl2ETQ25poEOfYMHJxOQBjg82hozFJxjkZ
         6vkQ==
X-Gm-Message-State: AOJu0Yy+znqKiB2JHeE1YwBwrdfM9EdkUnr39TOci8CvSpia8XGgWM8G
	Ut9bfdO6nsspGBkNPN/UNpLpU8lX0xFxWxjQHpJVYa760LLqwFPA
X-Google-Smtp-Source: AGHT+IFSZMr4A9VAM4coN8A9nPRzro7k6BfEnMLZHoXKoJ8+ec4bcGSgoQY8L1YG8kon20K/fXAOcg==
X-Received: by 2002:a17:906:6b94:b0:a45:26fd:f5aa with SMTP id l20-20020a1709066b9400b00a4526fdf5aamr553521ejr.17.1709461736489;
        Sun, 03 Mar 2024 02:28:56 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id um9-20020a170906cf8900b00a44d01aff81sm1530759ejb.97.2024.03.03.02.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 02:28:56 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	"Frank Wunderlich" <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v2 net-next 2/7] net: phy: realtek: add get_rate_matching() for rtl822x/8251b PHYs
Date: Sun,  3 Mar 2024 11:28:43 +0100
Message-ID: <20240303102848.164108-3-ericwouds@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240303102848.164108-1-ericwouds@gmail.com>
References: <20240303102848.164108-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Uses vendor register to determine if SerDes is setup in rate-matching mode.

Rate-matching only supported when SerDes is set to 2500base-x.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 drivers/net/phy/realtek.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 8a876e003774..d7a47edd529e 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -723,6 +723,28 @@ static int rtl822x_config_init(struct phy_device *phydev)
 	return phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x6f11, 0x8020);
 }
 
+static int rtl822x_get_rate_matching(struct phy_device *phydev,
+				     phy_interface_t iface)
+{
+	int val;
+
+	/* Only rate matching at 2500base-x */
+	if (iface != PHY_INTERFACE_MODE_2500BASEX)
+		return RATE_MATCH_NONE;
+
+	val = phy_read_mmd(phydev, MDIO_MMD_VEND1, RTL822X_VND1_SERDES_OPTION);
+	if (val < 0)
+		return val;
+
+	switch (val & RTL822X_VND1_SERDES_OPTION_MODE_MASK) {
+	case RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX:
+		return RATE_MATCH_PAUSE;
+	/* case RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX_SGMII: */
+	default:
+		return RATE_MATCH_NONE;
+	}
+}
+
 static int rtl822x_get_features(struct phy_device *phydev)
 {
 	int val;
@@ -1065,6 +1087,7 @@ static struct phy_driver realtek_drvs[] = {
 		.get_features	= rtl822x_get_features,
 		.config_aneg	= rtl822x_config_aneg,
 		.config_init    = rtl822x_config_init,
+		.get_rate_matching = rtl822x_get_rate_matching,
 		.read_status	= rtl822x_read_status,
 		.suspend	= genphy_suspend,
 		.resume		= rtlgen_resume,
@@ -1078,6 +1101,7 @@ static struct phy_driver realtek_drvs[] = {
 		.get_features	= rtl822x_get_features,
 		.config_aneg	= rtl822x_config_aneg,
 		.config_init    = rtl822x_config_init,
+		.get_rate_matching = rtl822x_get_rate_matching,
 		.read_status	= rtl822x_read_status,
 		.suspend	= genphy_suspend,
 		.resume		= rtlgen_resume,
@@ -1091,6 +1115,7 @@ static struct phy_driver realtek_drvs[] = {
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.config_init    = rtl822x_config_init,
+		.get_rate_matching = rtl822x_get_rate_matching,
 		.read_status    = rtl822x_read_status,
 		.suspend        = genphy_suspend,
 		.resume         = rtlgen_resume,
@@ -1102,6 +1127,7 @@ static struct phy_driver realtek_drvs[] = {
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.config_init    = rtl822x_config_init,
+		.get_rate_matching = rtl822x_get_rate_matching,
 		.read_status    = rtl822x_read_status,
 		.suspend        = genphy_suspend,
 		.resume         = rtlgen_resume,
@@ -1112,6 +1138,7 @@ static struct phy_driver realtek_drvs[] = {
 		.name           = "RTL8221B-VB-CG 2.5Gbps PHY",
 		.get_features   = rtl822x_get_features,
 		.config_init    = rtl822x_config_init,
+		.get_rate_matching = rtl822x_get_rate_matching,
 		.config_aneg    = rtl822x_config_aneg,
 		.read_status    = rtl822x_read_status,
 		.suspend        = genphy_suspend,
@@ -1124,6 +1151,7 @@ static struct phy_driver realtek_drvs[] = {
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.config_init    = rtl822x_config_init,
+		.get_rate_matching = rtl822x_get_rate_matching,
 		.read_status    = rtl822x_read_status,
 		.suspend        = genphy_suspend,
 		.resume         = rtlgen_resume,
@@ -1135,6 +1163,7 @@ static struct phy_driver realtek_drvs[] = {
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.config_init    = rtl822x_config_init,
+		.get_rate_matching = rtl822x_get_rate_matching,
 		.read_status    = rtl822x_read_status,
 		.suspend        = genphy_suspend,
 		.resume         = rtlgen_resume,
-- 
2.42.1



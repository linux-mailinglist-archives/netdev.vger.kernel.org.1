Return-Path: <netdev+bounces-75208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56607868A36
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 08:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D142B1F22213
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 07:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7BF56449;
	Tue, 27 Feb 2024 07:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuMj8elG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8206455E64
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 07:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709020337; cv=none; b=pKEpZSrd5zEgiUsESb+GB9Ri/SJ7szUkXSFFFjZaHU6dxzAoimZWA6OUY5jMtqPHGEI0yKObE7L/Vxv6KXrELlqx6e8JOyHIfYzXAnJGv81Xc0eVTrwCpAd3ReEzEzQ2iO2yOKrESP3ppWX/zftytj1lhp4Cex7C8Zlui61oZyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709020337; c=relaxed/simple;
	bh=WXBN17EZgGUH6eWcK8F7nRi3ldI0G96Q5Mq+ECjAY6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cbvYcGz/9R6CN4XwYPLBn5WJo1HH8+SPn2XgeA2Mrz6g9CoCm2AdHB+Z7yXmgyMdl5hLp2CIwfwWfxbA63K/mwJoBRVWjzhSbBQpvyCSCcBEWVsJOvExitagPsNhK840/KxiUoex0iXISMf87OrMPm3x/Wc5nmc12rDBt6M8nA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuMj8elG; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d1094b5568so44036871fa.1
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 23:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709020333; x=1709625133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lV0JEslqQX7lSZDJO/0feKiEgQjMhrNlSGIZWQa9fZ4=;
        b=UuMj8elGNxUsQsVaNK0qel2FzApQYJUVaBDLOW34vatCZCnPTmuA+z/oqd1gE0dgx7
         yn5JBdXoFApyXsX5FzXhEHQ2kJt8pWI5y1gMFdvvpq8MPL9O43xHkOB8wfzjL0n/8SAH
         HO3b8v11o2athbHTtNdzprOzTXmZBeQzst9RTVFAm+5KcfgjYyfl5kSP9X1Dj9kKSUn4
         eFMe7Odc91m3+mopMbUDSV8ogHxsELFQrzIka/wvN8/+jcvwZ4cT9/IqI428FjWaZ4aV
         CRojfqlT82sOBJ5N5mxggBzbEKhQePTy16Wpxf6IBcesK2lN9x4Ih+thR6RyFn+HLkZb
         NU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709020333; x=1709625133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lV0JEslqQX7lSZDJO/0feKiEgQjMhrNlSGIZWQa9fZ4=;
        b=ScOaphzBjuvIaUqY8Nd9DPEa/8fjKUN5r9ZDYD4tc1eXxnAvyltcs75Q8EFGUYCBPA
         EFogu99fBkgYwNIx2FV2/5XwwCHWfEUqbhAHJk3UiScPe/nu4hrVh+ESPLn16NUCFwRo
         4rX0eH6nWAlQLuvUuDrRqKmYX+SY9g7FQDPOWnOwVYn8Frb0E347seCy4XxvpwDbibLN
         lEfMTdy8bBJ89Svc1thMr4vJA2F5+8cTYwnzce7HvfV004c0u5DbTjZvhl2/ILdJkJUi
         JddttZIEiyK4MfjQNmGwaSOwYOs3BOoaB/5sqtJyi7wtp0mTicnQgUDLX/HxaVGBMn0J
         I7tA==
X-Gm-Message-State: AOJu0Yzhti7otdTCqQTvZg+r2fsCZrwubeV3eNoHZSdca/rgpOiOgGGd
	bZJ9UrG0sQrZtcIuIcWBA4md/hO9NGTBXGMksDZQIECeB+EVO+6b
X-Google-Smtp-Source: AGHT+IGBssLLT1LntYrPHQTqNHja27lsZLZtzwkitpKXRXEpqu4qgDnePiH5s556DLr9PCTdB2tPVg==
X-Received: by 2002:a05:6512:3c97:b0:513:ece:8f7d with SMTP id h23-20020a0565123c9700b005130ece8f7dmr554295lfv.9.1709020333380;
        Mon, 26 Feb 2024 23:52:13 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id un6-20020a170907cb8600b00a3f0dbdf106sm496460ejc.105.2024.02.26.23.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 23:52:13 -0800 (PST)
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
Subject: [PATCH RFC net-next 2/6] net: phy: realtek: add get_rate_matching() for rtl822x/8251b PHYs
Date: Tue, 27 Feb 2024 08:51:47 +0100
Message-ID: <20240227075151.793496-3-ericwouds@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240227075151.793496-1-ericwouds@gmail.com>
References: <20240227075151.793496-1-ericwouds@gmail.com>
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
index 67cffe9b7d5d..75c4f3e14371 100644
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
@@ -1062,6 +1084,7 @@ static struct phy_driver realtek_drvs[] = {
 		.get_features	= rtl822x_get_features,
 		.config_aneg	= rtl822x_config_aneg,
 		.config_init    = rtl822x_config_init,
+		.get_rate_matching = rtl822x_get_rate_matching,
 		.read_status	= rtl822x_read_status,
 		.suspend	= genphy_suspend,
 		.resume		= rtlgen_resume,
@@ -1075,6 +1098,7 @@ static struct phy_driver realtek_drvs[] = {
 		.get_features	= rtl822x_get_features,
 		.config_aneg	= rtl822x_config_aneg,
 		.config_init    = rtl822x_config_init,
+		.get_rate_matching = rtl822x_get_rate_matching,
 		.read_status	= rtl822x_read_status,
 		.suspend	= genphy_suspend,
 		.resume		= rtlgen_resume,
@@ -1088,6 +1112,7 @@ static struct phy_driver realtek_drvs[] = {
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.config_init    = rtl822x_config_init,
+		.get_rate_matching = rtl822x_get_rate_matching,
 		.read_status    = rtl822x_read_status,
 		.suspend        = genphy_suspend,
 		.resume         = rtlgen_resume,
@@ -1099,6 +1124,7 @@ static struct phy_driver realtek_drvs[] = {
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.config_init    = rtl822x_config_init,
+		.get_rate_matching = rtl822x_get_rate_matching,
 		.read_status    = rtl822x_read_status,
 		.suspend        = genphy_suspend,
 		.resume         = rtlgen_resume,
@@ -1109,6 +1135,7 @@ static struct phy_driver realtek_drvs[] = {
 		.name           = "RTL8221B-VB-CG 2.5Gbps PHY",
 		.get_features   = rtl822x_get_features,
 		.config_init    = rtl822x_config_init,
+		.get_rate_matching = rtl822x_get_rate_matching,
 		.config_aneg    = rtl822x_config_aneg,
 		.read_status    = rtl822x_read_status,
 		.suspend        = genphy_suspend,
@@ -1121,6 +1148,7 @@ static struct phy_driver realtek_drvs[] = {
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.config_init    = rtl822x_config_init,
+		.get_rate_matching = rtl822x_get_rate_matching,
 		.read_status    = rtl822x_read_status,
 		.suspend        = genphy_suspend,
 		.resume         = rtlgen_resume,
@@ -1132,6 +1160,7 @@ static struct phy_driver realtek_drvs[] = {
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.config_init    = rtl822x_config_init,
+		.get_rate_matching = rtl822x_get_rate_matching,
 		.read_status    = rtl822x_read_status,
 		.suspend        = genphy_suspend,
 		.resume         = rtlgen_resume,
-- 
2.42.1



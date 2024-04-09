Return-Path: <netdev+bounces-85982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C886E89D30A
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 09:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3939B1F2390E
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 07:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DF57D3E6;
	Tue,  9 Apr 2024 07:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UruCRz/L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A6E7C6E9
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 07:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712647829; cv=none; b=cdosrffLffSBVYtrvWHLa3iVJefRRHVQOk76cAZAaxEM/OAYSW8ZxgmdaTijMjS7fl5k0jkUnEy+ilMis1+RQqKKgwvT9DfzmEhQ1nSj2SaLqXNF0TJJFfg6qghCehTvmwy8xvBvPupq38qerkOsx8FMNNuI7aT0BxFV9YNKUTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712647829; c=relaxed/simple;
	bh=vtB6yGJgo+xJBjwo2aPEj6An2i/IcemQoK6ItWCNfAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KNYcgtJRXQ9zIOnCK4qNUiasdBoteG8yoQJuC6K7wEQydJf4hh8FD++50qvl1XpY1VRZzKRX3iBJ7g2SdOvkPf5IETuHuS5e6bUaKPEqTlcsThn7QSohhslFEhYbxgYkYCmsml1f7wZNVs11dNItBSs4D6cAsR3MIpaeLMqwIDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UruCRz/L; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e136cbcecso7240557a12.3
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 00:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712647825; x=1713252625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOUmkKoltFZufK17eGVufFHxAOB0ZBowfgVM7R4VLZw=;
        b=UruCRz/LU9DH/gGnn9O699FQS97HlN86QDFAjAcAvvp7OcS49qvC7JtiV2YFiRCN4H
         DXS6Et3d+CV4yh2BvLG5PgyNNS/dFYWJpqVDa5o89Gg71QfOgO9u2WdDW3k7J1aNarM3
         aOktiieFXqb+duM94O40jrrR0Tp9t+QlDT63fjmur0C5LZHb6QbTuOm68kvb/hAduj2a
         M1u+oQSyAjpFDBuwzqBPjt40Mu0Q0qeB6MdP1XNWYbdP3vpr5n6CV1N54NKgPYobL2E6
         UDgPcxm6OIfcF7/rgiDVxbuJfM6pGwy65VAToQap7iQZO8JBPg8qk6IeoI9AviAVh57w
         6Y3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712647825; x=1713252625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IOUmkKoltFZufK17eGVufFHxAOB0ZBowfgVM7R4VLZw=;
        b=GSly67Gg/X/0RgSs1azzxJiO48bhYrvU4VdsmoUlwWMV5Lqv2WeCuDBTJIHFqaJmPK
         HvdaCdJ599xiDtRwXSRQy3Fiz8z7LNQRgG6vzaZgnnbB5x/haXvOaDNqbP0XMg5MDgM5
         zeHtihlAkLFBsZaSIhAYcPHBSUfWWBxioKG/+Y1mG2ZqK3aBkGuX6tsUwWt8d6IGbwQE
         TNr/Z3V2tfA5Ppt9FLq/jnfnul5cCH3B3MPnQ8cAcLA3oxvJ5PTVtojE7EnzA38SwkPO
         K9kaJtnQ5vuNISfpsrybAXVZtu4///rrH8pVIQoqoLGC6n0yI6oVSPUPXOEwctpXM50m
         GGEQ==
X-Gm-Message-State: AOJu0YxZC7XB9m5M3iK4DDMXXuPTftQniP7KF721CV9bjfgTLq+HcLvR
	ORDhpYQcP1RF7kQ5lShreikHjsYmJry09wR2bV6oMc7VxBiD8JIy
X-Google-Smtp-Source: AGHT+IHNw+jgejSPzRZP3uqZRAbj02QJWTtMdh75921+/0Y8l6zSrXqQWFaTP1jG6EbsdaRwjhC9Sw==
X-Received: by 2002:a17:907:6d06:b0:a50:7cdd:348f with SMTP id sa6-20020a1709076d0600b00a507cdd348fmr10651826ejc.46.1712647825365;
        Tue, 09 Apr 2024 00:30:25 -0700 (PDT)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id j25-20020a1709066dd900b00a473362062fsm5315694ejt.220.2024.04.09.00.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 00:30:24 -0700 (PDT)
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
Subject: [PATCH v4 net-next 2/6] net: phy: realtek: add get_rate_matching() for rtl822xb PHYs
Date: Tue,  9 Apr 2024 09:30:12 +0200
Message-ID: <20240409073016.367771-3-ericwouds@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240409073016.367771-1-ericwouds@gmail.com>
References: <20240409073016.367771-1-ericwouds@gmail.com>
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
 drivers/net/phy/realtek.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 70cd1834a832..08d338271bd0 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -726,6 +726,27 @@ static int rtl822xb_config_init(struct phy_device *phydev)
 	return phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x6f11, 0x8020);
 }
 
+static int rtl822xb_get_rate_matching(struct phy_device *phydev,
+				      phy_interface_t iface)
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
+	if ((val & RTL822X_VND1_SERDES_OPTION_MODE_MASK) ==
+	    RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX)
+		return RATE_MATCH_PAUSE;
+
+	/* RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX_SGMII */
+	return RATE_MATCH_NONE;
+}
+
 static int rtl822x_get_features(struct phy_device *phydev)
 {
 	int val;
@@ -1091,6 +1112,7 @@ static struct phy_driver realtek_drvs[] = {
 		.get_features	= rtl822x_get_features,
 		.config_aneg	= rtl822x_config_aneg,
 		.config_init    = rtl822xb_config_init,
+		.get_rate_matching = rtl822xb_get_rate_matching,
 		.read_status	= rtl822xb_read_status,
 		.suspend	= genphy_suspend,
 		.resume		= rtlgen_resume,
@@ -1114,6 +1136,7 @@ static struct phy_driver realtek_drvs[] = {
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.config_init    = rtl822xb_config_init,
+		.get_rate_matching = rtl822xb_get_rate_matching,
 		.read_status    = rtl822xb_read_status,
 		.suspend        = genphy_suspend,
 		.resume         = rtlgen_resume,
@@ -1125,6 +1148,7 @@ static struct phy_driver realtek_drvs[] = {
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.config_init    = rtl822xb_config_init,
+		.get_rate_matching = rtl822xb_get_rate_matching,
 		.read_status    = rtl822xb_read_status,
 		.suspend        = genphy_suspend,
 		.resume         = rtlgen_resume,
@@ -1136,6 +1160,7 @@ static struct phy_driver realtek_drvs[] = {
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.config_init    = rtl822xb_config_init,
+		.get_rate_matching = rtl822xb_get_rate_matching,
 		.read_status    = rtl822xb_read_status,
 		.suspend        = genphy_suspend,
 		.resume         = rtlgen_resume,
-- 
2.42.1



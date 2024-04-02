Return-Path: <netdev+bounces-83891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5F9894AFF
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 07:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEDBF1C220C7
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 05:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A3F18E29;
	Tue,  2 Apr 2024 05:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrqM2aBs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F4E182BD
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 05:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712037542; cv=none; b=E1yRCx5UzJaqVVpMk1KwLyruObW7ei1hNyDt6OxRUXuJkvWLofpACdu9t0IstL5dVU+Z6ABgTX4tG1UIHYzY1kzuWr4zfoZFFld6vf2lHVcOHEFhx/c6u+V939qHZ1X9QhyQr6aerxihWxIctEWsChS+DJBdWlEmV7vR23jqtfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712037542; c=relaxed/simple;
	bh=bakkUEd+sfh8hCc1uTZ1eQ7Ul4771yVG6DUhGDryZOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fM4m90W7oCRGNs5Nkl3/xITowvaeBI00Iv6D49TdIQ0khQogpU/Z2K/puvX0ic5Pp6KrKtJFgLtW8xF6PcyapDW7ZcXZSqjRy20QCmC5jIn1Bl2OMmLTv4S4dK1tyG8SzFrF1zaAInj8XLUh6i1S4iAuR61KOY6KFTXLNMOU0x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrqM2aBs; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a4e83bf72f5so55354566b.2
        for <netdev@vger.kernel.org>; Mon, 01 Apr 2024 22:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712037539; x=1712642339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EL1uEd3eRQvQawYg+l+RPdo3Mmhw2fuADfl058DWnRw=;
        b=lrqM2aBsu1wi3aW1Bd0zKXubTOk/UF4UQcSujT7kNV9gbfJuAIHkrIaXzNY7c+lzYF
         GSpIC5GG3xUXg6eLJtXfaaOz2Ho10lgNO32eGLbY4kQiNYmecPxsIav1hvnyrYXIxaln
         qvVR8nbyNsyvopxsoLitRuGwxo8B/CPDylQ2yBM5ai/JEXMtIyYd3qKVCULD90l0nezw
         /H8e1rpeWCfX7Lo5JXWCgLoyk2TKKr9cm1pIioix7Ic8LLklpjM90IYcngRKRqODREVd
         4COJB8pqtmGT8FRDqKD3EwRRWun7t+qSzARthqEAkuDYOjspvcgzJhMfqv/ONy848LLj
         KhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712037539; x=1712642339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EL1uEd3eRQvQawYg+l+RPdo3Mmhw2fuADfl058DWnRw=;
        b=pbdxi6HYn1XRseIzTTIcCjf7IOZh2+orMJI7X58EIGXljHi7nl/Rul3ekFOABuPdsO
         1hkLXKfzyQL0n540YR/UW1VKH2FyFDJoykx62CUlIoXlqEGafZ2QZiA4OwzKjgGIOLul
         GBNmNjpICD0ODAx2dPImS/4KbWU389CkSlhTyUZNAzaa4ZKV8ymvup7W7v+HuXXKyMcv
         0MILtlqFlzVCwmvoSwlN3QfGGEdDvPKqjwGp4UN8mjKqr8q5XPb/5+U6FD4YRUhUtXgn
         rggdyMVEdSrfF6GCPrnCYwpSVt8e0c6SMjFHpcctPZgsUV1J1WT+k5H4dfToIKSygx9P
         35Eg==
X-Gm-Message-State: AOJu0YxaD7SleYrDrrKawHdB/82AIKK39v0f/D9n9YpMsSQefOV247tX
	OZyBOLDmSqtElUJ5LtdTaSILgj41Ou1uQe8wyG2SgBVvhUpCxZ95
X-Google-Smtp-Source: AGHT+IHcnXgHCh/88IMrBDCpojdyLEiP7DVutJ0YLcIPEebpyK5hquhk4qeYckOgI6Cp0ZjEX5eRiw==
X-Received: by 2002:a17:906:eb59:b0:a47:4fe1:cf99 with SMTP id mc25-20020a170906eb5900b00a474fe1cf99mr7489484ejb.21.1712037538566;
        Mon, 01 Apr 2024 22:58:58 -0700 (PDT)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id cd1-20020a170906b34100b00a4a396ba54asm6136636ejb.93.2024.04.01.22.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 22:58:58 -0700 (PDT)
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
Subject: [PATCH v3 net-next 2/6] net: phy: realtek: add get_rate_matching() for rtl822xb PHYs
Date: Tue,  2 Apr 2024 07:58:44 +0200
Message-ID: <20240402055848.177580-3-ericwouds@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240402055848.177580-1-ericwouds@gmail.com>
References: <20240402055848.177580-1-ericwouds@gmail.com>
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
 drivers/net/phy/realtek.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 70cd1834a832..ca1d61fa44f5 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -726,6 +726,28 @@ static int rtl822xb_config_init(struct phy_device *phydev)
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
@@ -1091,6 +1113,7 @@ static struct phy_driver realtek_drvs[] = {
 		.get_features	= rtl822x_get_features,
 		.config_aneg	= rtl822x_config_aneg,
 		.config_init    = rtl822xb_config_init,
+		.get_rate_matching = rtl822xb_get_rate_matching,
 		.read_status	= rtl822xb_read_status,
 		.suspend	= genphy_suspend,
 		.resume		= rtlgen_resume,
@@ -1114,6 +1137,7 @@ static struct phy_driver realtek_drvs[] = {
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.config_init    = rtl822xb_config_init,
+		.get_rate_matching = rtl822xb_get_rate_matching,
 		.read_status    = rtl822xb_read_status,
 		.suspend        = genphy_suspend,
 		.resume         = rtlgen_resume,
@@ -1125,6 +1149,7 @@ static struct phy_driver realtek_drvs[] = {
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.config_init    = rtl822xb_config_init,
+		.get_rate_matching = rtl822xb_get_rate_matching,
 		.read_status    = rtl822xb_read_status,
 		.suspend        = genphy_suspend,
 		.resume         = rtlgen_resume,
@@ -1136,6 +1161,7 @@ static struct phy_driver realtek_drvs[] = {
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.config_init    = rtl822xb_config_init,
+		.get_rate_matching = rtl822xb_get_rate_matching,
 		.read_status    = rtl822xb_read_status,
 		.suspend        = genphy_suspend,
 		.resume         = rtlgen_resume,
-- 
2.42.1



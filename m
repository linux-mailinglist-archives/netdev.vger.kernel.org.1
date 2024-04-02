Return-Path: <netdev+bounces-83893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8413E894B01
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 07:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F28A61F2376E
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 05:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7321D526;
	Tue,  2 Apr 2024 05:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyutLmJz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427EB19477
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 05:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712037543; cv=none; b=glhBRYtdgif+cVACGSAfEsOtjZKnqt8kWdSptameCOOkxdVV6uAIOO+iDvPMEvn8Chmako9uk3yhz2oE5ZYABTujcyGrR9BJdfbcYxlvYNTxJrdhc6BMxAOm1OW/DFNjVgE3wlWWCbmdj0WTgygv8mYNR5+u6XGa/mtupIAS/1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712037543; c=relaxed/simple;
	bh=qI4EkGt1lRVXThePQvIizEVoKNfdwX3+gMHUx9GulF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BcJA3FY593KHLYeapA8qrIicp7mf/cKOmIJAq3+kz0f/UWolicrIGmJbMegxNhxLBTNPrODe3RmW8ILtpo2uYaQ7xZqbtzNHrRo/ZziiPuF90S3ovKIWfz70ty9rhBhpzJCctZtalgVVcilRh9s3eAaFyQVTl2BWv78E8U/aFvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyutLmJz; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5688eaf1165so6505089a12.1
        for <netdev@vger.kernel.org>; Mon, 01 Apr 2024 22:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712037540; x=1712642340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/ybX8G8LSGKMTLWp+71FV+9Atmqurbwgxi8KnNdjoQ=;
        b=GyutLmJz2/OZrCKdFE3Z7ljlejoAIH0mWDluCuMmf76WnDpddoWA5splwo76ms9W0j
         q8U/NsYNNKCofhUM3RLuHvomyIA8IoabLV3zNRGV6BqGzStb4tdUu9o5rkV29Augp50P
         UaxYz9v7GiJ+e3O89igw+gB/sIJY4w6KIAHW+tRRPsdvHwMYb5w2rtArkzQRYSHBxNK+
         ozg6B7bYBXAr2b7aB3u9Y/gpnbAbMTkG5KooUxzcC/1Gyw9SjQKnZSNUNGrvvDyuX/s3
         71WtIQOZytyY7zJQ6ZjY3REkOhsIghXn/gpoqp4hUEGaF234kqiSVoG+I+Jp/R4DkUhf
         IfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712037540; x=1712642340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/ybX8G8LSGKMTLWp+71FV+9Atmqurbwgxi8KnNdjoQ=;
        b=TUGHdZjYoEnGE7zr+lDSe93ExnRWwVxckk06wk4770q1JYCgzwwl3hP2d1tEQDB7SZ
         mMtquFcnyy2KoBkS8zymS3imguJ6UUsYsvq+Lwo4Y+0qpFkyOaqjdHzadHlSpBMiI9PC
         npItO+IyAXb/Bpq5Sdk6Hwq5MYqiNGLWeAanWQQRpxp3EutztgItTr3omQeX9s89K0Aw
         MF7XCbIFwE4dZIIEmjDGkBx1wJsEqmvMRuh9zHge1gFkWDqObW3ITy0081QZV7jy0vpt
         I3OGgnDoIdZB1a18baO7q80HN6R5J3gMxJ5KAGOLeccWRQg8+T6Wgfok8VqLU8m5H9Fl
         DNAw==
X-Gm-Message-State: AOJu0YzcoW1ELj136/YEtY8ZMYjBey06f6RgWPw3uxxI5eztJZ0Ydy7I
	IbZ0zQ974l6NDU52Vjg+pOlAmHAcPy+vZDqscObrt3BVVKLTJIl3
X-Google-Smtp-Source: AGHT+IF8DzA+EderdBEm8/ZbyTZ5BDpjyIQxX6iby7dBG0Z5sFRY6GnOGqiLMrlp+sUCLgKnVyATpw==
X-Received: by 2002:a17:907:77cb:b0:a46:8c9f:f783 with SMTP id kz11-20020a17090777cb00b00a468c9ff783mr8062157ejc.67.1712037540619;
        Mon, 01 Apr 2024 22:59:00 -0700 (PDT)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id cd1-20020a170906b34100b00a4a396ba54asm6136636ejb.93.2024.04.01.22.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 22:59:00 -0700 (PDT)
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
Subject: [PATCH v3 net-next 4/6] net: phy: realtek: Change rtlgen_get_speed() to rtlgen_decode_speed()
Date: Tue,  2 Apr 2024 07:58:46 +0200
Message-ID: <20240402055848.177580-5-ericwouds@gmail.com>
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

The value of the register to determine the speed, is retrieved
differently when using Clause 45 only. To use the rtlgen_get_speed()
function in this case, pass the value of the register as argument to
rtlgen_get_speed(). The function would then always return 0, so change it
to void. A better name for this function now is rtlgen_decode_speed().

Replace a call to genphy_read_status() followed by rtlgen_get_speed()
with a call to rtlgen_read_status() in rtl822x_read_status().

Add reading speed to rtl822x_c45_read_status().

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 drivers/net/phy/realtek.c | 46 +++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 2215a31d5aab..af5e77fd6576 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -71,6 +71,8 @@
 
 #define RTL822X_VND2_GANLPAR				0xa414
 
+#define RTL822X_VND2_PHYSR				0xa434
+
 #define RTL8366RB_POWER_SAVE			0x15
 #define RTL8366RB_POWER_SAVE_ON			BIT(12)
 
@@ -551,17 +553,8 @@ static int rtl8366rb_config_init(struct phy_device *phydev)
 }
 
 /* get actual speed to cover the downshift case */
-static int rtlgen_get_speed(struct phy_device *phydev)
+static void rtlgen_decode_speed(struct phy_device *phydev, int val)
 {
-	int val;
-
-	if (!phydev->link)
-		return 0;
-
-	val = phy_read_paged(phydev, 0xa43, 0x12);
-	if (val < 0)
-		return val;
-
 	switch (val & RTLGEN_SPEED_MASK) {
 	case 0x0000:
 		phydev->speed = SPEED_10;
@@ -584,19 +577,26 @@ static int rtlgen_get_speed(struct phy_device *phydev)
 	default:
 		break;
 	}
-
-	return 0;
 }
 
 static int rtlgen_read_status(struct phy_device *phydev)
 {
-	int ret;
+	int ret, val;
 
 	ret = genphy_read_status(phydev);
 	if (ret < 0)
 		return ret;
 
-	return rtlgen_get_speed(phydev);
+	if (!phydev->link)
+		return 0;
+
+	val = phy_read_paged(phydev, 0xa43, 0x12);
+	if (val < 0)
+		return val;
+
+	rtlgen_decode_speed(phydev, val);
+
+	return 0;
 }
 
 static int rtlgen_read_mmd(struct phy_device *phydev, int devnum, u16 regnum)
@@ -818,8 +818,6 @@ static void rtl822xb_update_interface(struct phy_device *phydev)
 
 static int rtl822x_read_status(struct phy_device *phydev)
 {
-	int ret;
-
 	if (phydev->autoneg == AUTONEG_ENABLE) {
 		int lpadv = phy_read_paged(phydev, 0xa5d, 0x13);
 
@@ -830,11 +828,7 @@ static int rtl822x_read_status(struct phy_device *phydev)
 						  lpadv);
 	}
 
-	ret = genphy_read_status(phydev);
-	if (ret < 0)
-		return ret;
-
-	return rtlgen_get_speed(phydev);
+	return rtlgen_read_status(phydev);
 }
 
 static int rtl822xb_read_status(struct phy_device *phydev)
@@ -895,6 +889,16 @@ static int rtl822x_c45_read_status(struct phy_device *phydev)
 		mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising, val);
 	}
 
+	if (!phydev->link)
+		return 0;
+
+	/* Read actual speed from vendor register. */
+	val = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL822X_VND2_PHYSR);
+	if (val < 0)
+		return val;
+
+	rtlgen_decode_speed(phydev, val);
+
 	return 0;
 }
 
-- 
2.42.1



Return-Path: <netdev+bounces-85984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 312E089D30C
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 09:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2A441F23823
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 07:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF7A7E0FF;
	Tue,  9 Apr 2024 07:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoEtnWlh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A48A7D3EC
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 07:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712647831; cv=none; b=tbsiwrbCBtfkxDVzhBe3z8NeNcvzg4ahsPJdwHRATJal4ZFQ4JZ0i6XJjHRb3Pry1ltHGhR+Ore+0Vh6oRqEVkXG3nLncqgPk+7DQJPJw76wq5aEYdjjby2JTsYsVobA3OJ/mvPoU9ss8jqh1YJYdwdwm4wahNNDwSGeXvd0vwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712647831; c=relaxed/simple;
	bh=OtGHJbGUgHc9dZuM2JQHrf1CGB+d6FDODUqjTGCDDk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QK84AInYA3vyPCLfNFf2le4wGpvrejEWQzYHbwj+pDJKQ7K6lB3SThDbop1V3B826WHs7Ekc0RAHmTc/ShvKOcgSmSBZy2jeUm1s+YrW/SvSLFYJykiOQOwjZV5SVgAO8zutMaZOzouy27NY85rVqidnudSw6Ez76VfTZLDTIzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hoEtnWlh; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56bdf81706aso6959311a12.2
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 00:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712647827; x=1713252627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ArUcu/OIuu70X1GylkMgA2lcpO4SjCntOxNcsByY5E=;
        b=hoEtnWlhfeD8/2mYjWKqqfYxX0V3oS3BDTmegZRLlF1/0SU2U9Ohj/+I6S1wm1LZPP
         R1r5TF7YTvH4bKu/O38IF83p3F5tCPEXuo1VSogAD0MUIEqtZcqZIB0ztJl311G40ljq
         ejFoqrsfWMl6Rts+W24UiHB7utXpXBsGXtygi4RbdME4YiuXN74Ubvl5iNXIJfApydRb
         wfBYh7ApaIo0KsmqLe3zbNia7cPBZSUDitF/vT+UJvXW/dzby0wF3nBs+S+q3sRa7zQ6
         HxskFj1lE1aXP1ZwcrhZ28xssawirkvt7SIx+ozUzHr4ygENXS8s2NNEkOIoRMeCok9I
         tamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712647827; x=1713252627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ArUcu/OIuu70X1GylkMgA2lcpO4SjCntOxNcsByY5E=;
        b=lii+RL2H7V9/e3c93LYPPOJrZhLKQGrLhURpb4Z3cH1RI7KSBz3gN4BKll6P8rvvv+
         DZCX++875wAyl8v76vSey2XvHQ95YCPWQXuRwvK1bTyVO7f2N4q6W1Idz1H3qszR6GL2
         ImCFBqR4w6GVjmyuX9FFabfnuC7kPudLYN+ouqNzYW9FF2XN5Ph9YkDa81hFxrTI5H48
         ck1GUUhfADSpq3vN7ocyoVWEUnyaDd28X943eKxnfRXQIybkB/wAtgU5cqZvpQPbJRB2
         MravSjYWWmdA5ujK3CRfN0JfGCzKTjMEZQMJOnd6k2tYLgZdME0y9BQJfava7dQByLXM
         K4jQ==
X-Gm-Message-State: AOJu0YzU/cgH/Q64RCTVyypxhTwL5tHymkNVD+9lah+s5d2yeWgCbeMd
	qOLUkznEVVhxmcp+ZjXwTrMGpjxousrYlvA+u3z2znRH52/rtniS
X-Google-Smtp-Source: AGHT+IHwabGo99NumrWX4B7jidWK1Z8oLngpHs15OB5YK85qoU/reUXwrBMyXs9/XXrWAPJLrZuZlw==
X-Received: by 2002:a17:906:d8f:b0:a51:89f1:2841 with SMTP id m15-20020a1709060d8f00b00a5189f12841mr6183997eji.50.1712647827447;
        Tue, 09 Apr 2024 00:30:27 -0700 (PDT)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id j25-20020a1709066dd900b00a473362062fsm5315694ejt.220.2024.04.09.00.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 00:30:27 -0700 (PDT)
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
	Eric Woudstra <ericwouds@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH v4 net-next 4/6] net: phy: realtek: Change rtlgen_get_speed() to rtlgen_decode_speed()
Date: Tue,  9 Apr 2024 09:30:14 +0200
Message-ID: <20240409073016.367771-5-ericwouds@gmail.com>
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

The value of the register to determine the speed, is retrieved
differently when using Clause 45 only. To use the rtlgen_get_speed()
function in this case, pass the value of the register as argument to
rtlgen_get_speed(). The function would then always return 0, so change it
to void. A better name for this function now is rtlgen_decode_speed().

Replace a call to genphy_read_status() followed by rtlgen_get_speed()
with a call to rtlgen_read_status() in rtl822x_read_status().

Add reading speed to rtl822x_c45_read_status().

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/realtek.c | 46 +++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index f4a6f073a1f7..901c6f7b04c2 100644
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
@@ -817,8 +817,6 @@ static void rtl822xb_update_interface(struct phy_device *phydev)
 
 static int rtl822x_read_status(struct phy_device *phydev)
 {
-	int ret;
-
 	if (phydev->autoneg == AUTONEG_ENABLE) {
 		int lpadv = phy_read_paged(phydev, 0xa5d, 0x13);
 
@@ -829,11 +827,7 @@ static int rtl822x_read_status(struct phy_device *phydev)
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
@@ -894,6 +888,16 @@ static int rtl822x_c45_read_status(struct phy_device *phydev)
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



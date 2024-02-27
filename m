Return-Path: <netdev+bounces-75209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069C6868A38
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 08:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3658A1C21A8F
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 07:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DEC56459;
	Tue, 27 Feb 2024 07:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/yhQV7f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF6E54F94
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 07:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709020337; cv=none; b=P0/GlOpCHpdFHdW8Wq2rQe0nUTBIKvQljuHepna7RHBU0qh0MCiOQGPCEbJ5aWEGBssUnEJnn4mTpC2FaeffQEPTQCO1Otc/SBuoDeMEJQTrscJMUqvWntg7bmKPjDSI+M5j9DGVRljuU7uUws3209R2ACo0Aw/QSM03Kzmyi68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709020337; c=relaxed/simple;
	bh=IbBUCH9a8BhHyPlprzScPjuJgo74gSBae89ejOzHT9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=POuM/PollaOYDSMQTq32oraCiHMpBH1lqGIF5e5oBK6h76xXVlAJZ4gIQ99RVQfMuUbQBb+i+M1EYwJm++C/ta7PR/oRfgmtzxgzYruYx9luJh9MGz4qABzWCHNkakyLlkw5YL/7ZJFNvEoiP3Xw5n5GKrLzrtdVamv9hu94ArU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/yhQV7f; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3e5d82ad86so547106566b.2
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 23:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709020334; x=1709625134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gHVelXeXSgnMtA/zAd3Bprx2pS/mZvAhKsCp7WWu54=;
        b=j/yhQV7f1dve81++gxMeBKaVjxfqpksW6KuU4IDb3Vgc3rGvNsH4QmRjZcOESwpj4R
         V5bcyF/Aad+M4JsE6exnOKuKqEgoanOlw9yUUPHPNddmcFSEXeJVjfyDwfD29FTpsi5A
         TfsGvv2a03yFuJa5lpsyrHu7daAuVbalI3V5LiRewXMndnL8d5Vrirjmd2Mz1MHZQGGI
         JoWTCtNmP6DmcJUHjp1vB3zYETLZ/lILXduJdh9JHhuABAzDos8e4TQOuY9LBHBfXUN7
         m4MhFo5wv5I4T3Fffjdi/BVqIGBcM3Woq2OlHYGdyuMqmmk8yigrFWaJDSoU7otX7nn4
         Ig7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709020334; x=1709625134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gHVelXeXSgnMtA/zAd3Bprx2pS/mZvAhKsCp7WWu54=;
        b=duW3Kc70HGdsxUPlQtxOOxwYCCGbPP6ES1TBKmoSQ7307hKbO+bj42OdbBzGFJaXFD
         GI2row/NJUyykZ3exQQS949VSRuIInBXOv9Om9cXFWVIEmcroCVuyJLDozmYLfjOpdxj
         C/6HZV6E6lp4bzrOyKv0p9HbY4mdIeRXsGBY7C0nwkKhxYMkVJDNReEHdx77jkJFBNrg
         KA6eVvIWfRdkHicG5tYRN0OiA6Xq0IXAM2tvJhaEqH080rtwR3Fxoeos4Jp0LOpQ9awy
         cnbYGr6u7Um+DWq6yrO8TTwI/VuzU+3QVqp3StjwDr/QIAaPNfoZbZygHT+esG6AghYM
         OWng==
X-Gm-Message-State: AOJu0YyRcQwKZMf/pLJ30vfOt39gqdEBJrizhYKHOapJu7dXUVtFTdFh
	tniGbLSTV3961CNGC/HpdTi4emFgxL1aURHn5Vkd+aXDb1447kzg
X-Google-Smtp-Source: AGHT+IHyJolNG79mN40aL7R9k9Wt+E1cnJqmdaFk0zQNRdGM9cGqWbisOiZaFtcu8eqtYB9Zpai1Cw==
X-Received: by 2002:a17:906:a992:b0:a3e:eebe:7a2f with SMTP id jr18-20020a170906a99200b00a3eeebe7a2fmr6195640ejb.35.1709020334427;
        Mon, 26 Feb 2024 23:52:14 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id un6-20020a170907cb8600b00a3f0dbdf106sm496460ejc.105.2024.02.26.23.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 23:52:14 -0800 (PST)
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
Subject: [PATCH RFC net-next 3/6] net: phy: realtek: rtlgen_get_speed(): Pass register value as argument
Date: Tue, 27 Feb 2024 08:51:48 +0100
Message-ID: <20240227075151.793496-4-ericwouds@gmail.com>
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

The value of the register to determine the speed, is retrieved
differently when using Clause 45 only.

To use the rtlgen_get_speed() function in this case, pass the value of the
register as argument to rtlgen_get_speed().

The function would then always return 0, so change it to void.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 drivers/net/phy/realtek.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 75c4f3e14371..e7c42ec18971 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -541,16 +541,10 @@ static int rtl8366rb_config_init(struct phy_device *phydev)
 }
 
 /* get actual speed to cover the downshift case */
-static int rtlgen_get_speed(struct phy_device *phydev)
+static void rtlgen_get_speed(struct phy_device *phydev, int val)
 {
-	int val;
-
 	if (!phydev->link)
-		return 0;
-
-	val = phy_read_paged(phydev, 0xa43, 0x12);
-	if (val < 0)
-		return val;
+		return;
 
 	switch (val & RTLGEN_SPEED_MASK) {
 	case 0x0000:
@@ -574,19 +568,23 @@ static int rtlgen_get_speed(struct phy_device *phydev)
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
+	val = phy_read_paged(phydev, 0xa43, 0x12);
+	if (val < 0)
+		return val;
+
+	rtlgen_get_speed(phydev, val);
+
+	return 0;
 }
 
 static int rtlgen_read_mmd(struct phy_device *phydev, int devnum, u16 regnum)
-- 
2.42.1



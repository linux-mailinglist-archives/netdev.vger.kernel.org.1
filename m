Return-Path: <netdev+bounces-76889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CEB86F465
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 11:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB9FA1C20AA2
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 10:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8978C2E9;
	Sun,  3 Mar 2024 10:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1d1Ax6Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10030BE4E
	for <netdev@vger.kernel.org>; Sun,  3 Mar 2024 10:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709461741; cv=none; b=uNJ73uf+RbqAkhbMs/LwfCuEIFXsVc+mwXmX78ck6HAYQcfzVQMwnQEmuYlLdkp/jBkKzIR8WJTxwRIOGT8kOuEZMQHN7buwKIzhrh4Gxt/SPPz1vSei9YBrbSvfFVU48mXLwfn02/um6SrZOUZO/aAXSq9A69OLLrlR+4qdFeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709461741; c=relaxed/simple;
	bh=sjk4DKjY5W38ceRxgY6XyLXOGdCqCSFhOHLPHgO37ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gYvVEpRoKKBbQK5GJVm4yEKb/nnMmFaT5SY9OWCPEPIsZsG7J2MsLdDwOAYp/hh9AczLPpTz9feyLHQnl15KLvab9PMSC2vUzjj22Yp3bxb84grVA1UJoN0saquuYWBL/FdRzP90QJVlPHDN/4WrgQVdgLr3D9e+95hZoR7+x0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1d1Ax6Y; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a293f2280c7so646308866b.1
        for <netdev@vger.kernel.org>; Sun, 03 Mar 2024 02:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709461738; x=1710066538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFkUG4OmYVtGVYs30111P+RH4LV2Gj0+GJlUJMZ+yBI=;
        b=R1d1Ax6Y8DPK1DCrRKui0Bnym6P8JbP8aMLQJzmROnSmblTrUiTO3K00IfYgqDcK2j
         KKrNe2B6FZCxvcHWhDzCHcgOrB/imxbtwtm5bMJLVTJ9glE4iFgLDPIWaCEVyAp5bs63
         43z0g4pVqQYANsHXMZ3YuxYz4CeoS0UDasBBq+cIF9iW+RlCMe3ctCgjnYQ/MqzzAk0N
         bph5zN98jrLdcqbgE+mzhC7a7Yb7l33/OB9gjgAwc581yVzFaZm0mdXVEyGURK7GGC41
         4IEUMl5s/BQhYhsLXT92JipxbjQv1ryTomyqJjYe0KxtCsdrPi0If/veBrY4XE8jGq2K
         Nwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709461738; x=1710066538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFkUG4OmYVtGVYs30111P+RH4LV2Gj0+GJlUJMZ+yBI=;
        b=qf2FiSIVuBNbk52n0SuX3VLpnNurunRIz0oamMtS0pSymhJhdnaHSmvJUU0hX9gXPQ
         BLX4UxN+oF2sbacZTxqmVdS5ndrEHd2egJLzSL+V90SzOVJACLyB5gNzAr9cg1OjB85n
         jUQQg6IM4q+WfBPzjyXTGens4siWHLts2jTP0mfmrHt4Tn+u81xcOUEINHTcE//eM5Kd
         W9Rf8KAOAEwUDo6nOY1iKtXRQ7zgWfs/6rtvvt8LujBx4S24L+bZLwBvA3FDEu4qI9Sm
         E9MZ8B8H1Idg0gH3ZeLh8QKmk2YxGhHu9JNjCreLQFcyYUY5nq/je8OIwHXuUGH1/v7n
         wU9A==
X-Gm-Message-State: AOJu0YxhyC3VNYbLB/OHLD7oYdWQtPZ42lamscpbsX6eNi+SYGcVn8iW
	Bsz7+mFeGCShERL0idnd2VwJloRc7q+b6ZByzaPbDa78GhnGx2ma
X-Google-Smtp-Source: AGHT+IG+BTZ3+oBVRzO7SXSUw6sTJDF56mvHu/4PTn34qTL+a2KgZ3TcJuT6KO9kJmG/3ll4Y7kf3g==
X-Received: by 2002:a17:906:f8d6:b0:a45:2e21:c9c3 with SMTP id lh22-20020a170906f8d600b00a452e21c9c3mr366817ejb.3.1709461738345;
        Sun, 03 Mar 2024 02:28:58 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id um9-20020a170906cf8900b00a44d01aff81sm1530759ejb.97.2024.03.03.02.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 02:28:58 -0800 (PST)
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
Subject: [PATCH v2 net-next 4/7] net: phy: realtek: Change rtlgen_get_speed() to rtlgen_decode_speed()
Date: Sun,  3 Mar 2024 11:28:45 +0100
Message-ID: <20240303102848.164108-5-ericwouds@gmail.com>
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

The value of the register to determine the speed, is retrieved
differently when using Clause 45 only. To use the rtlgen_get_speed()
function in this case, pass the value of the register as argument to
rtlgen_get_speed(). The function would then always return 0, so change it
to void. A better name for this function now is rtlgen_decode_speed().

Add reading speed to rtl822x_c45_read_status().

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 drivers/net/phy/realtek.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index f9a67761878e..6449d8e0842c 100644
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
@@ -881,6 +881,16 @@ static int rtl822x_c45_read_status(struct phy_device *phydev)
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
 	rtl822x_update_interface(phydev);
 
 	return 0;
-- 
2.42.1



Return-Path: <netdev+bounces-175169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B35E9A63D8E
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 04:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2F2E188EB9A
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 03:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B4D1519A3;
	Mon, 17 Mar 2025 03:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0WqavR9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4920FEEA9;
	Mon, 17 Mar 2025 03:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742183478; cv=none; b=tXDbzthLBsxBwVHF6Sb8BOmBahDgu2G0vfTwFc97ymW0T8z87vL/MHtfEnzIvTS+1MDN1uYecUexk5ktkj4u+96ED2sr9wWlHI4/pHCv4iiP3rYbmStgE+gGTqWIQvpARnsF3asAh5R75dhPV54IaXNPL3ifkxS9sDwX0h88Thk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742183478; c=relaxed/simple;
	bh=qhdRLVgZypKW9sXgOcBFCl4fPWfUP61UyiBa0eLhEW0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z1j/xxB8AfIo4gwmMxgBD+n49uzrddbU2z6MzGBkt05GxvAAjSjgmqdNo5Ekt8s3+CIOn0uQ6A+cvb0n0bjwpj7uL5E/7jEzWtk1cWqgksQcS9eauaQFDS3MxmuasjpPPuBujUJbpFq2LMZrIeiIqyLL99INcIyF9deKI+a76Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0WqavR9; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2243803b776so23182435ad.0;
        Sun, 16 Mar 2025 20:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742183474; x=1742788274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bybvDh4gza3CtHXY8H6ofdczJetAOoZ7ud9S8QA+kxk=;
        b=L0WqavR9xO0ErztoGL+Nx1mUGR/8f7TTHn8aBLUqUsl8C/91FS8LOBqBd1LKDx8HX0
         wQO7WO3SIoRJ7637LtEPRvzAExwFbmwkg2LAoieId6xSFPsIjd8vfDCWM6hMBb2XzJ5C
         1xB7ELMu6GekLM8KJcFzu7xfFcjLdXWEYoGa4h0Kwmdra4fH1lB3K/lpNFsdrG0G6LGe
         i5OQctEjuTYYI4tnioLwEmPWBnVrGHx6rqxYr0EtbayjdMpdBxiiGy2yx9stXQHzz23E
         tOGo2FwEdgTDWr8KWAcoujECpSPG0qo7cIueXK4y9ChQI5Krog5VfPuGMqWESea/h9E/
         BqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742183474; x=1742788274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bybvDh4gza3CtHXY8H6ofdczJetAOoZ7ud9S8QA+kxk=;
        b=B3E0Fi8D5QvsJeWyJoqD5XzMlC76/GIKx9Q0IK20T/mGwHMYDNu5a9i3U6SL+WKa7t
         wzbuzK5CHYSMKQaQqAG5+lCwyOqWAcYjaR+Xn3fyiunPEYGf4gBSuB+91FJa2JZzo8Rx
         IkU/4UKLwVVPRMx22Ph+H2TeeoyFH9/UgWvVtNXCYImxZ7W5+vWtI/tT99BR736bSE1k
         LLP6s2HgTyvpRQ3dMfl+j6JiYR2g9uQ+vBtM7pkGR/nHrgIU6dZyC+jOCaxiAQNipqrS
         2CAbqOZLQgXV2213MKzmbtgarkZ3tZn5sVQzXc4wZkzbxuoBy5ISGlggJWh6YyCrTfgS
         zzVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/ZdWnnRCf1yjkOBSojqvVcZGOpRCaPiD7+QOEXDN4ZIWsumiNekYt7wwA/jx3m3X7g4NDdxDcY/jE7VQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPmiOjlmC6LY691IhlcJ65YVYL2HqVJEAtGXJGpa1Z7XGvZlSH
	iwpM0aOkDDws+Drm+kUhns8q7/syg1N2afpIhkXDGufhRwu5Osc+J8QXua5U
X-Gm-Gg: ASbGncvcXqh3uVUNej9AJivy08m2imtW3C8qKpdW8OhtRoHKHqRd/2LFaWhw0I9EwfZ
	sT1lySOgtKhAEWXeFpH5t/d62yqTHnaP3k9wAJPJi2t2hBl02MCyQcZ0ZCRO71twBEcQ8kiWsQZ
	ksCpAQzo2vB5c3+sSt76q20uyA6sCkSN3E+z4Kf87eldAWHBmrXFY2+m/eKXinobtCEdzDYrAm2
	eV4wPfC1EOhs1T5WigFsGT3Osey6Sm1jPJsNn7wCubpLdJaRpgiJxl+kPrHB+VntPCH5dVMmYs0
	Led6748Cia2Yd/d3CdAcsV8LRoSmNREzgRw4Kit24grs2jAYpkDkCxAz
X-Google-Smtp-Source: AGHT+IGAXa0nBao8DDNaoRRLowqasPCIZ2c/NdsEIrDJbFpDJNYIwxCYYvnaMUe1AaQVefIA6EuQ4Q==
X-Received: by 2002:a17:902:cecd:b0:223:5ca8:5ecb with SMTP id d9443c01a7336-225e0aff4e1mr136031785ad.42.1742183474433;
        Sun, 16 Mar 2025 20:51:14 -0700 (PDT)
Received: from cs20-buildserver.lan ([2403:c300:df04:8817:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba6f64sm65049985ad.127.2025.03.16.20.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 20:51:14 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com,
	jim.t90615@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	kuba@kernel.org,
	linux@armlinux.org.uk,
	edumazet@google.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] net: phy: broadcom: Correct BCM5221 PHY model detection failure
Date: Mon, 17 Mar 2025 11:50:05 +0800
Message-Id: <20250317035005.3064083-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use "BRCM_PHY_MODEL" can be applied to the entire 5221 family of PHYs.

Fixes: 3abbd0699b67 (net: phy: broadcom: add support for BCM5221 phy)
Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 drivers/net/phy/broadcom.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 22edb7e4c1a1..3529289e9d13 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -859,7 +859,7 @@ static int brcm_fet_config_init(struct phy_device *phydev)
 		return reg;
 
 	/* Unmask events we are interested in and mask interrupts globally. */
-	if (phydev->phy_id == PHY_ID_BCM5221)
+	if (BRCM_PHY_MODEL(phydev) == PHY_ID_BCM5221)
 		reg = MII_BRCM_FET_IR_ENABLE |
 		      MII_BRCM_FET_IR_MASK;
 	else
@@ -888,7 +888,7 @@ static int brcm_fet_config_init(struct phy_device *phydev)
 		return err;
 	}
 
-	if (phydev->phy_id != PHY_ID_BCM5221) {
+	if (BRCM_PHY_MODEL(phydev) != PHY_ID_BCM5221) {
 		/* Set the LED mode */
 		reg = __phy_read(phydev, MII_BRCM_FET_SHDW_AUXMODE4);
 		if (reg < 0) {
@@ -1009,7 +1009,7 @@ static int brcm_fet_suspend(struct phy_device *phydev)
 		return err;
 	}
 
-	if (phydev->phy_id == PHY_ID_BCM5221)
+	if (BRCM_PHY_MODEL(phydev) == PHY_ID_BCM5221)
 		/* Force Low Power Mode with clock enabled */
 		reg = BCM5221_SHDW_AM4_EN_CLK_LPM | BCM5221_SHDW_AM4_FORCE_LPM;
 	else
-- 
2.34.1



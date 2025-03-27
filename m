Return-Path: <netdev+bounces-177895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5A6A72A2E
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 07:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82DC1894A1C
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 06:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E9D1ACEA6;
	Thu, 27 Mar 2025 06:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfqKW3zq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACED01A9B4F;
	Thu, 27 Mar 2025 06:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743056996; cv=none; b=CQDDQLR/FCXontKLhB4m/MZwz96DJjhJwRnev/zuWcsxuWhPOIbMSIv7xD00TaESNqEs94kivR8NOgUiO0jjiYwXIE3AnEhu0UfA2SPMEj/Hmxv0mj25ORNZ5HRlB8vXkDSj3koAexB7ui7Wls0G4+z8h6Fn0WQ9cuhHrTcPugI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743056996; c=relaxed/simple;
	bh=Z0RB6A3CD4C8yz/TJDY72WXKjZQn6hvHEC9n2ur0JZM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HuKV56xtZGCVzE3X9kU9J3r3iqkGd84OJJmNc7fImmQgDYEV8wwTYPcnOPhNv67q+zZXt+MAk0/yLMDs9+1jPcDRkHTMVVdL8pQS7Lqgetwr6t83+w2t5uRbK2aar0KrXUEmTSfw4XVwEJghGv6IbO6q+isr9rwHo4pnRq7UNZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfqKW3zq; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2254e0b4b79so17117425ad.2;
        Wed, 26 Mar 2025 23:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743056993; x=1743661793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IFA2jCWAdpbd9dVGdMaNE6+715WLXOpux3yDjYcoVkE=;
        b=FfqKW3zqcG8MlhYAKg+cERT1HRkZDXk/AtMP5G8tuhXoZSz2EEdVEI8+42Plo8PmJZ
         wz0KWrPG4pa0zUOIvdsQcxjyM96ZXcF2D/0dUI29T5IyrRN9atYrHDul+ior4mXd3nH2
         cASKVnCbjGmr2g9WvXpNu36piC/ghX/C++SatmCOlZcDejUF/apBkEsV73a6zGWWym7Y
         n2OdePVqomBMNd6w7y3BW0bEbAWWgRPl8tHpm8Dpz+SIRpAuvKtFbwcGWaavDcZqzwf0
         UvTX1g06lGL4QdSsc3N2ru7dbHrT5HKJskXTnH40NcMKtzn77JA7xILbrd2gBlgb/ZCK
         Uo2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743056993; x=1743661793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IFA2jCWAdpbd9dVGdMaNE6+715WLXOpux3yDjYcoVkE=;
        b=QtK2xw5bzk/c2w7Mn3wPMFS+armFsQDP7brL50UlEuaTCcUMxjPnA8njbsfnc1bSW6
         Z5kfn4jpAIgwBTfTOZluBkWO37g5Gshao+3VBXPNkb1wKMHzB/HHz/m9eY78I46Lw4dk
         6nB7/+gpuLho9B1Jquz2aEzH016Dm6RrDjIQWawUI61jQPRaa3PaamCTclWVJ8L9hD5W
         aSgQ1J/J0OVIvhZBBg0n0aTodajr46fJIVQN6HREonMs9kDOMs42jNwqxePL8XUML68l
         8wKEWgcV+ldnYQ/JMebTcbY6rzGrKYbC1Yzya9NXprKu+TGj2js65c5CUrZhZryoOPl3
         P3Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUQV9LrpAvSmHdApbErb4PIeKFWdpjAzbkC8eUCZ8163eOELFjgkhcJAmVqTMMWSd9iHtAFbqtQ4fhFsM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUBN4niiTnUYEgmZC8v1OMeOwJAaZb5lF6pbdXwVCXl9LXKTIa
	FKXE6voefiT0q6kpI4rVIUFO/TuHiGm/G7Aumt7otZsd4O6mQPXX
X-Gm-Gg: ASbGncvlm8ZEPTMBWenhjQuObMRSVTpHdi3ea9wPib+DHPofJdH5AKVgaBFGjDCrEBS
	LA1E4+A0pP7YSDmBzJQFUcLFEqs8gdCfoQu9U/Obie/bJVT0NTa94ZYe8dsRFS/f+wUWUybTcG5
	sFdz/KIhQI66z3BGGV8avEsOkJ9rRWR9W6wi9Aina2GlFJjdaA+pYpjg34odxh/YvZCeE2Jzuqo
	ZvSf8IHQdx5X+J7cgxsXFlfVsW1cl/X/FQ497/Nx1CceKQ7WWBRfuWz4fKi0+DGFgPIKUx+MXmT
	l3cg1lclrB9yUHQCVfSTCQbLTd7qwb/qbUuMcmxmhcXFDORSPgi6R+Aa
X-Google-Smtp-Source: AGHT+IFDczJNV2PlaZ92MRR56CU/S3I6DgU8RLCdFDNq302mF2apkTEgLwc6m1fxtCWO3WHjje5qCQ==
X-Received: by 2002:a17:903:184:b0:224:fa0:36da with SMTP id d9443c01a7336-22804845131mr34156595ad.18.1743056992728;
        Wed, 26 Mar 2025 23:29:52 -0700 (PDT)
Received: from cs20-buildserver.lan ([2403:c300:5c0c:4075:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227eb193816sm36353915ad.44.2025.03.26.23.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 23:29:52 -0700 (PDT)
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
	giulio.benetti+tekvox@benettiengineering.com,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [v4,net] net: phy: broadcom: Correct BCM5221 PHY model detection
Date: Thu, 27 Mar 2025 14:29:42 +0800
Message-Id: <20250327062942.3597402-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct detect condition is applied to the entire 5221 family of PHYs.

Fixes: 3abbd0699b67 ("net: phy: broadcom: add support for BCM5221 phy")
Signed-off-by: Jim Liu <jim.t90615@gmail.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
v4:
   modify detect condition
---
 drivers/net/phy/broadcom.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 13e43fee1906..9b1de54fd483 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -859,7 +859,7 @@ static int brcm_fet_config_init(struct phy_device *phydev)
 		return reg;
 
 	/* Unmask events we are interested in and mask interrupts globally. */
-	if (phydev->phy_id == PHY_ID_BCM5221)
+	if (phydev->drv->phy_id == PHY_ID_BCM5221)
 		reg = MII_BRCM_FET_IR_ENABLE |
 		      MII_BRCM_FET_IR_MASK;
 	else
@@ -888,7 +888,7 @@ static int brcm_fet_config_init(struct phy_device *phydev)
 		return err;
 	}
 
-	if (phydev->phy_id != PHY_ID_BCM5221) {
+	if (phydev->drv->phy_id != PHY_ID_BCM5221) {
 		/* Set the LED mode */
 		reg = __phy_read(phydev, MII_BRCM_FET_SHDW_AUXMODE4);
 		if (reg < 0) {
@@ -1009,7 +1009,7 @@ static int brcm_fet_suspend(struct phy_device *phydev)
 		return err;
 	}
 
-	if (phydev->phy_id == PHY_ID_BCM5221)
+	if (phydev->drv->phy_id == PHY_ID_BCM5221)
 		/* Force Low Power Mode with clock enabled */
 		reg = BCM5221_SHDW_AM4_EN_CLK_LPM | BCM5221_SHDW_AM4_FORCE_LPM;
 	else
-- 
2.34.1



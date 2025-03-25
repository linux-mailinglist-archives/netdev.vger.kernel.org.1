Return-Path: <netdev+bounces-177297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67221A6EC50
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 10:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 681B6169D40
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 09:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4761E9B06;
	Tue, 25 Mar 2025 09:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCoTDpX6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF292F5B;
	Tue, 25 Mar 2025 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742893889; cv=none; b=Nc0PPLbH9qk7ow23DdXKTbvR46nXCZZ6iORhc1WUk0rLVyNy0FR9a8RyyFr0i6i9RduXB/I+37KO5Y5yjqgrUpnwm9AcjJH5fQrNsYSWBvP06bR8JWO96Vb6bDEtxPpXOTrzYqovc8j3N32t80eyOBye/qb8kfaNsRpT4JxVA7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742893889; c=relaxed/simple;
	bh=8ZqXnrU0AKG02HNlyB5u3VfqeMfIfP0PQXI4TwJmruo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uaYIz9x3VjuGjIXoKiOp8TwB50WNFXb/B1+ixSLdQNKcbcG1yNVOtr9bKN0HqHVWkuyV/J68FL6rz5I+gBgZC2qjg4GON6F7JAW7YRYPfl6YSb2oytwvkyKQ5IeYQ9GSe0ToN+3L28O7S/2fnSqm8uItBSqPmr61M/Y+B+lnQA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCoTDpX6; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ff85fec403so13022021a91.1;
        Tue, 25 Mar 2025 02:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742893887; x=1743498687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6S3q00Ly2YEgnihClS5EXWQIAkjqOLphkLp6Zwb5Cuw=;
        b=kCoTDpX6EhA6p6FikQbr127X8JTKskmP1/t/PC8H+7QnPIfNt6ZfzQrs5bxLZeu2fY
         VkfOSrNDwkJ6XS03ZHArCn+JIV2lQaQmiB7yFvntBYRvX+v/ozCfWFCZuHqc1AnotzaH
         KmUjyP0DuQrlcvf5F2M5xRbrmbf/BdbQfMI26917laC/+o+zTy0R8Fa6iznAS1VW27O5
         3RuYI/jCuQ20WK2vUbYKYCC/qe+lnbsdmZGEVJE52G7iIXIqra9JEsTMdiJLG8MFu758
         +5mu/1fy4p2GtsxJ84zN+gdnI9ALg+3EdafSz2vJj1okg/Vdg8X0Y7fU5s5mqj7Q5j8n
         AnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742893887; x=1743498687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6S3q00Ly2YEgnihClS5EXWQIAkjqOLphkLp6Zwb5Cuw=;
        b=o/dYB8hUjuC0juUbqiE3I2ZgToBMJQ3BZJD+slZY4SChjQVffa2cn/5pDiWVrdwsuw
         9jL6+YCLZ3tVQ6g7LfIRT5GQ9iQA+jgNgV3bHQZMGWo/1xc1EGSPZJ2z5poFe8Ur/ytI
         ZI5Y++ELo1kDVpB1mywX3+AEBQF6gnqzeLhN2sUHa3TnNsjse9dM2EIpgCUYAGxm0yc+
         O1BEV8U53kuyF35RILIcj7sReFdFP19YWem1LVDj3Yk81XjZvS+9Igs2UqDJ8cJ2o25i
         Xa+QVVn/VVYgGa5zLFSgGLcRIL/grHCNiMdhrJeVkvN4ItQAZpiRZHsLoNbmnZ4ie00/
         4jdA==
X-Forwarded-Encrypted: i=1; AJvYcCUYLruyRCYHYFgjzUD4jocMeFiHQVpZnRn19FDtAScT26BHOcrMg8yz67kLPseeRpfcY3KIukoV1U6g2FA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6u272XPmNZu8z2Uz/+JIVaTNX8sgjqZmLRRZPSL1Rky1f79jK
	UG7t5PPFza26iFDvo1uMf5kxajo3RkYdcBMd5Tr380QXsLtIL3Tt
X-Gm-Gg: ASbGncvT9kUVT6WDJGkOL8Geejm07+sEkpZvq1lOHsWN9z5DrVMP0nDhSjeHGLDSiNp
	5nzDB7ZbBH5N39ylbCgcBx4XI1g5J9QUtw2lW2yhMH4pGWyXMkQXm6Woode2dKIH1BTW53wplxK
	bZG3vTe61yN+0nzpD/951AdE31jMEEBJkSEyJoqPLoNscEimdCoHx1znaVAHVUxkr7kphLfeHu9
	262FZ4mmLYHOLcjfSYbRfRoVF41kaKN1om561D3GOHrKUOZIN5+P8zDFhm2F7XqLUV958Do+2gW
	Kok2LInE8hUcl8J0s68Wm42ZDhwII5WZkESrchPwqBZHJpWHfDoMd/PT58rSqQKMeRE=
X-Google-Smtp-Source: AGHT+IGAgeeRx8c4qx0gwdM6u3mkeO/xzEJBfDsv8Qo3SDJ35nrMrCfdjOnwKQpjGh0bDrU0lgqtIA==
X-Received: by 2002:a17:90b:5408:b0:2ee:5c9b:35c0 with SMTP id 98e67ed59e1d1-3030f200ebdmr20681087a91.9.1742893886955;
        Tue, 25 Mar 2025 02:11:26 -0700 (PDT)
Received: from cs20-buildserver.lan ([2403:c300:dc02:2d2e:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf576be5sm13717402a91.6.2025.03.25.02.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 02:11:26 -0700 (PDT)
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
Subject: [v3,net] net: phy: broadcom: Correct BCM5221 PHY model detection failure
Date: Tue, 25 Mar 2025 17:10:29 +0800
Message-Id: <20250325091029.3511303-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use "BRCM_PHY_MODEL" can be applied to the entire 5221 family of PHYs.

Fixes: 3abbd0699b67 ("net: phy: broadcom: add support for BCM5221 phy")
Signed-off-by: Jim Liu <jim.t90615@gmail.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
v3:
   modify BRCM_PHY_MODEL define
---
 drivers/net/phy/broadcom.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 22edb7e4c1a1..4327d946d524 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -23,8 +23,7 @@
 #include <linux/irq.h>
 #include <linux/gpio/consumer.h>
 
-#define BRCM_PHY_MODEL(phydev) \
-	((phydev)->drv->phy_id & (phydev)->drv->phy_id_mask)
+#define BRCM_PHY_MODEL(phydev) ((phydev)->drv->phy_id)
 
 #define BRCM_PHY_REV(phydev) \
 	((phydev)->drv->phy_id & ~((phydev)->drv->phy_id_mask))
@@ -859,7 +858,7 @@ static int brcm_fet_config_init(struct phy_device *phydev)
 		return reg;
 
 	/* Unmask events we are interested in and mask interrupts globally. */
-	if (phydev->phy_id == PHY_ID_BCM5221)
+	if (BRCM_PHY_MODEL(phydev) == PHY_ID_BCM5221)
 		reg = MII_BRCM_FET_IR_ENABLE |
 		      MII_BRCM_FET_IR_MASK;
 	else
@@ -888,7 +887,7 @@ static int brcm_fet_config_init(struct phy_device *phydev)
 		return err;
 	}
 
-	if (phydev->phy_id != PHY_ID_BCM5221) {
+	if (BRCM_PHY_MODEL(phydev) != PHY_ID_BCM5221) {
 		/* Set the LED mode */
 		reg = __phy_read(phydev, MII_BRCM_FET_SHDW_AUXMODE4);
 		if (reg < 0) {
@@ -1009,7 +1008,7 @@ static int brcm_fet_suspend(struct phy_device *phydev)
 		return err;
 	}
 
-	if (phydev->phy_id == PHY_ID_BCM5221)
+	if (BRCM_PHY_MODEL(phydev) == PHY_ID_BCM5221)
 		/* Force Low Power Mode with clock enabled */
 		reg = BCM5221_SHDW_AM4_EN_CLK_LPM | BCM5221_SHDW_AM4_FORCE_LPM;
 	else
-- 
2.34.1



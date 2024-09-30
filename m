Return-Path: <netdev+bounces-130260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A21A398995D
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 05:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D4A1F21277
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 03:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A82311CA9;
	Mon, 30 Sep 2024 03:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNOK9fzF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5312F29
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 03:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727666202; cv=none; b=VNz/Pmz6kDb+nen9AHWEfR8yGmztn87tJ/+86SKGZjmjq64VHnmSx6vAHP7L1CKHZDdSB3OfRqbuHvP1ihTXK1/EuT+4kLRNWdsuno1baVJ30KyRsH3C2vPyEgQbn7KLTjXQkV8PADODvJK0WoiyY3bVNebJb15atAaF3mYitO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727666202; c=relaxed/simple;
	bh=gxqCXXuRRIwHPjsRBeWQxW2ZwyoOsC42aYH44CRIEW4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jWd12CkGIMZ8Cc3H924Ba69ZuTv04Rj2f0DqbhO4LzsXJ9Z6H7Z/tCulIYhhN9h+i5lt7T9pMI3uzaMc7uTWe1C7OhU4ZB/wjJ2XJEl1HuV/mfeExiJ4ooYVhdTfwQhBvQBiUkYYPAO37aRON/7weH1d3C8e8Z/zo4JCdDzGCdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNOK9fzF; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20792913262so45873665ad.3
        for <netdev@vger.kernel.org>; Sun, 29 Sep 2024 20:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727666200; x=1728271000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ucD2XJQWu4yYNPDGQD/Z5MzEr03Cm1SCrLKcaC8nSKQ=;
        b=LNOK9fzFZQsyZBb6eYy/3xpXsMd06aLcmrMvP4C0G2KwZ8waRAjbq733vbBLTDVetD
         63Bj2/9VWtTnyt/Ro23K5C/wbljJyopDe9eOvUv6WKFrRDiDUtRm2yodLbg324Trjge/
         q0q0vQtOBceRZctfSinZmvsph4ft/wsXOM3eJ5ExXFY5JQEXVPVOsekEuAYjgFcC0pFR
         PeEfscUdP0YMItGoOji7PJYJrHcqPmuoObbFPWGJPn5ffBlhY7xjgcSYRN0R4dQKnuFt
         dmWqpdA2qT96dg2TIK7haPtTlKIDXdudEWlkglRDYtEdZV5OnFuTwBrKiqvrqbtPMxfN
         YGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727666200; x=1728271000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ucD2XJQWu4yYNPDGQD/Z5MzEr03Cm1SCrLKcaC8nSKQ=;
        b=eS3stPvqoSJ33YPobTTCy3yJWrdNClco81c/0xtMc6H+T3C/jsJ7Ce1SMm1NbnrqKJ
         lMtbVySWl5ZOAWBgZ0V9zH7Hl7XpW6HvQJuPs86IaDs9Kg5jCOQk0pKnjb8ESQIPxuXa
         2NXac9NldGg+odHhm1Eyd22+A8Ql3k0QjhjaZZ79dDWlkOC+IjuEbGIPci/c95JyFbBO
         BuE1M8A2N55Lc97dNt/HyfXwh2raOI9Sk0JEhVsVo5R84mlItY7JPSDWj5OnK2KmCIU4
         1F7t71RV+9OxW66gW5NH7cZKw3kO4eQkfGVSzgeVqsmT88DjWEpcDPVkKKJlltSzNoHo
         vrVg==
X-Gm-Message-State: AOJu0Yy2Imx8AI9dxlXxjIYdqa1Kav2jDs69Rjf6me1jHqsBrdjZqcmz
	waP525S/JWSbn95VFk9G8474vJr302kNnex62LVcZlZWRo9VBatCCvtx3CbB
X-Google-Smtp-Source: AGHT+IFY/j1+pmbrhjQJ+rVokz3hyAtdg0T8qtcMxVrjc6gVnltW0QOJKB1T14p2O3XdAmPYhDYnew==
X-Received: by 2002:a17:903:228d:b0:207:6e9:2da1 with SMTP id d9443c01a7336-20b376750a8mr169203605ad.17.1727666199594;
        Sun, 29 Sep 2024 20:16:39 -0700 (PDT)
Received: from localhost ([101.12.29.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e0fd99sm45794935ad.173.2024.09.29.20.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 20:16:39 -0700 (PDT)
From: wojackbb@gmail.com
To: netdev@vger.kernel.org
Cc: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com,
	ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	angelogioacchino.delregno@collabora.com,
	linux-mediatek@lists.infradead.org,
	matthias.bgg@gmail.com,
	Jack Wu <wojackbb@gmail.com>
Subject: [PATCH] [net,v2] net: wwan: t7xx: add PM_AUTOSUSPEND_MS_BY_DW5933E for Dell DW5933e
Date: Mon, 30 Sep 2024 11:16:24 +0800
Message-Id: <20240930031624.2116592-1-wojackbb@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jack Wu <wojackbb@gmail.com>

Because optimizing the power consumption of Dell DW5933e,
Add a new auto suspend time for Dell DW5933e.

Signed-off-by: Jack Wu <wojackbb@gmail.com>
---
 drivers/net/wwan/t7xx/t7xx_pci.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index e556e5bd49ab..ec567153ea6e 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -49,6 +49,7 @@
 #define PM_SLEEP_DIS_TIMEOUT_MS		20
 #define PM_ACK_TIMEOUT_MS		1500
 #define PM_AUTOSUSPEND_MS		20000
+#define PM_AUTOSUSPEND_MS_BY_DW5933E 5000
 #define PM_RESOURCE_POLL_TIMEOUT_US	10000
 #define PM_RESOURCE_POLL_STEP_US	100
 
@@ -174,7 +175,7 @@ static int t7xx_wait_pm_config(struct t7xx_pci_dev *t7xx_dev)
 	return ret;
 }
 
-static int t7xx_pci_pm_init(struct t7xx_pci_dev *t7xx_dev)
+static int t7xx_pci_pm_init(struct t7xx_pci_dev *t7xx_dev, int pm_autosuspend_ms)
 {
 	struct pci_dev *pdev = t7xx_dev->pdev;
 
@@ -191,7 +192,7 @@ static int t7xx_pci_pm_init(struct t7xx_pci_dev *t7xx_dev)
 				DPM_FLAG_NO_DIRECT_COMPLETE);
 
 	iowrite32(T7XX_L1_BIT(0), IREG_BASE(t7xx_dev) + DISABLE_ASPM_LOWPWR);
-	pm_runtime_set_autosuspend_delay(&pdev->dev, PM_AUTOSUSPEND_MS);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, pm_autosuspend_ms);
 	pm_runtime_use_autosuspend(&pdev->dev);
 
 	return 0;
@@ -824,7 +825,13 @@ static int t7xx_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	IREG_BASE(t7xx_dev) = pcim_iomap_table(pdev)[T7XX_PCI_IREG_BASE];
 	t7xx_dev->base_addr.pcie_ext_reg_base = pcim_iomap_table(pdev)[T7XX_PCI_EREG_BASE];
 
-	ret = t7xx_pci_pm_init(t7xx_dev);
+	if (id->vendor == 0x14c0 && id->device == 0x4d75) {
+		/* Dell DW5933e */
+		ret = t7xx_pci_pm_init(t7xx_dev, PM_AUTOSUSPEND_MS_BY_DW5933E);
+	} else {
+		/* Other devices */
+		ret = t7xx_pci_pm_init(t7xx_dev, PM_AUTOSUSPEND_MS);
+	}
 	if (ret)
 		return ret;
 
-- 
2.34.1



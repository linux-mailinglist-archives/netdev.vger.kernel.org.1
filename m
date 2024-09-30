Return-Path: <netdev+bounces-130258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF45989957
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 05:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2001F218C4
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 03:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C15E224DC;
	Mon, 30 Sep 2024 03:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHvpNCTU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D85079EA
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 03:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727665556; cv=none; b=WYanAwkKTT0cpDiywnGjXmWdIC/HSSts/9EEg6tzlktc+6g4N/g+t4LFYrE1m+/8sKIySHaiuAEgtNIYs7A+kthzhC9b4zcO+lo6cl2DyQytysi4/uvkNR9LpAifskqmzalJgLy/EGZGlziJjnZEqtcjNNZXtDD7qTZ+khSqzAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727665556; c=relaxed/simple;
	bh=zXhjHuoV5OoobFyq6inEY82nEZLep5g7CFZ5ujxra9g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t1cJgLsZo6DGC+Rx+EebHf6FjNCUGUGrb/ZKzBy2xnIFMw003/qf5bapbxbrumlDKDe+e5dBRUnbzaKMFmrHoYdDjK6dDVDexQXrE/wGh2uyJplPzKkOelCKElqJsgfJoYfmX6aKOC8ptEATAv6pA8SFU21cODaUpyxfPOBUndg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHvpNCTU; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71b8d10e9b3so1838190b3a.3
        for <netdev@vger.kernel.org>; Sun, 29 Sep 2024 20:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727665554; x=1728270354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=liH+2HX4gU0bkSiJPPJupVzmEbjmJ5tsUvyE/1aKSfE=;
        b=PHvpNCTUMuLSYjB95I0DKCrxOkMmqUGiji3RFHLHRTDTGSEsiVL6Q7n7F6EpFDxVIb
         XU8yp0e+pHh4t/YlhRp83erIRGmYmwSJlLhpL6wpqWWnTpBnRJffM3UPZrbXMFkA1amV
         wLPBCDOVelJXg236CbEMueHw2iPjntT/ZV4oOq+Zqb1hiYCaiY63ekGPx+JOdmMuH/LF
         8cJ591pR0DLWpAeTvy84P5ur8GV/MfdniB2xrDZCcMt3gpwEYmhQEjfMuRBgzbqiQTTZ
         wsnI/WmblYTeXQYZ6N1L+4YJP6xpvt0JDZ5lFNFvSISAL0xjiXLQtQisQRIL13rVJM8B
         IfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727665554; x=1728270354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=liH+2HX4gU0bkSiJPPJupVzmEbjmJ5tsUvyE/1aKSfE=;
        b=YdWz0GXx4IiZotL/mb6LMAENOKBWhd07j9/VJb23aBOrnqRW0vnu5ssWgAtcw/msxN
         UigfYNs08HtWYrZ/s5w9wRzOtxoJV5GBzpsff3JfbXpPSlohzb+3QMdqMYAKd61X4kOx
         2PDpQR51HYxN+WKCNUGA8J8YH5FhZvARlsLhILReHIZcaZu8J8an9zRb8K5Kb98FEtw/
         iAwurmBoWhaYFxtr5Z2yi4UZtyqAJ8bAGPQ1ump72rXNdGfzIfM1XGn/wGHCcCw9JwhJ
         G8iXhirHYVkIG/f9LI+giEF/QJI6qKIvb8biTYPQSJSy93k2MTbqPOUvJcvSa76Nmmlu
         B7hA==
X-Gm-Message-State: AOJu0Yw7KSVVsEDNgNQCXPz8itIwFu/DlkqoeyXAd3N9tbmNxl7HCAyR
	yBmeL5Yxn4IhTy+GuM/KGu/PT0YFCATZ9capvzCo7LuTabidxRHFNh5zU0Z7
X-Google-Smtp-Source: AGHT+IH4GpRORCnq9LI2QFzModkh2qMGn6SjusdmX+tpIFnHxAv4i58A2+Se9YymegaBfG7F23ci6g==
X-Received: by 2002:a05:6a00:21d5:b0:717:925a:299a with SMTP id d2e1a72fcca58-71b260478efmr16421559b3a.19.1727665554046;
        Sun, 29 Sep 2024 20:05:54 -0700 (PDT)
Received: from localhost ([101.12.29.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26498b26sm5219466b3a.9.2024.09.29.20.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 20:05:53 -0700 (PDT)
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
Subject: [PATCH] Add PM_AUTOSUSPEND_MS_BY_DW5933E for Dell DW5933e
Date: Mon, 30 Sep 2024 11:05:49 +0800
Message-Id: <20240930030549.2116070-1-wojackbb@gmail.com>
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
index e556e5bd49ab..2dcb0967f9e9 100644
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
+		ret = t7xx_pci_pm_init(t7xx_dev,PM_AUTOSUSPEND_MS_BY_DW5933E);
+	} else {
+		/* Other devices */
+		ret = t7xx_pci_pm_init(t7xx_dev,PM_AUTOSUSPEND_MS);
+	}
 	if (ret)
 		return ret;
 
-- 
2.34.1



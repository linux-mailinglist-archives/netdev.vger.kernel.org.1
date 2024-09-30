Return-Path: <netdev+bounces-130259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3B2989958
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 05:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4F791F218A1
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 03:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EAB27466;
	Mon, 30 Sep 2024 03:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6xZVuFO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEEF1D545
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 03:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727665764; cv=none; b=dzKZWPDzd/dLf4N7L/6qMSYIDvDe5XXJJ3w0dleHJ1oBWVJ5oMBAbm5hPZ1IIVkIRQthm2rCdSJeoJv9T0Pg/y61FeaSxtYCxPQ9NxLgYC/2zqlBojeVInqOKhlcQjuM9QmerxwZ3aqTPVAvVipXcr7vBAE7e8Ywkfs/F/fRktI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727665764; c=relaxed/simple;
	bh=zXhjHuoV5OoobFyq6inEY82nEZLep5g7CFZ5ujxra9g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RIzM4Iw5RXdHBazSIxg7kvZu2NHZeIYMzQcITuH24TPt3B5aIlXrf31ybGoI4z5CWk6H8yaqnVYvhpb55ZU7/q3oHkNPSjHsY65UBk7k0pehGK8j+JtWrreVCLzT1r6Gimd6wFe6RllR39JESJAaotdhcJF4fzGD7jT7Yrch2VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6xZVuFO; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-6bce380eb96so2277238a12.0
        for <netdev@vger.kernel.org>; Sun, 29 Sep 2024 20:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727665762; x=1728270562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=liH+2HX4gU0bkSiJPPJupVzmEbjmJ5tsUvyE/1aKSfE=;
        b=P6xZVuFO9yR2kxZ6Bel/CbDsAQnDe+dN/lOalQRfR8lLQovi0dI6814GK6DrGOL848
         /fIQpF6kXfJzKQUUBCL7Rm7o4cpSvO2n2g3N/f6IsTSFESraDNquSOkT1iL1rdHb+hGD
         aqcsmY9wHzv4bGdEfXYNS1yKKvGHkYt2qIR2clEgM6H/jkv8GQX5apXYQJtvAfqtBmej
         SUHz2E4vxoXnrFdjX37RTJHl8SQCzVZNdzflwviblokWRozN2gS+kZNyYdbZME1ajXQZ
         ZA2MYWg59kTxjq+oH2Ae6MG9TupQ1LMJTLuOZdcJMVuGsF4ipno2DjEUWxUSaPbtRacm
         34pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727665762; x=1728270562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=liH+2HX4gU0bkSiJPPJupVzmEbjmJ5tsUvyE/1aKSfE=;
        b=wDDArP9MiCg168Mr7Cd9o14IAWjpSvP9gY8c6ZKkEZI6rQrO8KrSvCZsiidu/VnSCI
         YhUGspi/NMsJ/4ggsXEJCzjj+qySi+1G+qYcd+6Xkk4WSdjI93lzvxveTyCVcI9qXOv8
         gU0dNUu8lg4Y6/1NW6fabJ9ZAfDNJJObwMH6ZzTPyAu7ToFke/WaIwmTvcPZ0Em98ftv
         haUtoKVcmh8kW/LhR1yJ0QI7KIBKn5kEVLyEoduL+qzyk9AwirgTNuFfmSRiLTWs8iND
         QARRmRxiKhr4DklOnC/KcKCU4C1z63bWljslZ2kCHfmLQnnZu0gjHw/5bUbR3DNgnVDu
         q1kw==
X-Gm-Message-State: AOJu0YzWGlvG0sGXdr7cyLS9Jd+QDZ3NmKg5XgrNcEBms7jHKu42ZIyN
	+WrQGC77/lO1xxo3TzYzW1gPqHphcVMaVKBevKIfDK19slF9GopVvOEVQ/OA
X-Google-Smtp-Source: AGHT+IFdwqW2x+LGQ7yYzogOpNGWw7LvWSFFkUOqczekRhOYAg1KYqWZJSV3YBPjsXWkv2LJgeUzjA==
X-Received: by 2002:a05:6300:4041:b0:1cf:3a0a:ae45 with SMTP id adf61e73a8af0-1d4fa7ae36emr18049593637.35.1727665761650;
        Sun, 29 Sep 2024 20:09:21 -0700 (PDT)
Received: from localhost ([101.12.29.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26538a3esm5235967b3a.208.2024.09.29.20.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 20:09:21 -0700 (PDT)
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
Subject: [PATCH] [net] net: wwan: t7xx: add PM_AUTOSUSPEND_MS_BY_DW5933E for Dell DW5933e
Date: Mon, 30 Sep 2024 11:09:07 +0800
Message-Id: <20240930030907.2116224-1-wojackbb@gmail.com>
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



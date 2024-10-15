Return-Path: <netdev+bounces-135418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D8599DCBB
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 05:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FF101C20F33
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 03:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D7F16EC0E;
	Tue, 15 Oct 2024 03:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EseVOeF3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C1C154456
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 03:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728962920; cv=none; b=AtjHQWn3dGVhlTafFlijIJSE7QHDtyradpB8diextvNBBU2LvQfT8jD4A34DYXuwZu5Lev1eeTEzlECJFf2CgoK4ukBamQEf7R2KsOg7DAxqNrpGhJ2hzspo7OqBpUYW/50HyALYat92t5WR+KAe2f8ZkBDzCl0cRcUnLPi3G7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728962920; c=relaxed/simple;
	bh=9qfn9VbbRjKgR++iThcquREsFkOqgP2o/GwT1+A9F50=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U0AxZQ5ZmnHCngJ8AU1eZ4gGswnPIbmcv8sISDmW08deTcupd/YknVoRuApxX6olgrumm37L+iQcgG/EY10J69gz9nOIT+LTQXp44FmQAM+bAE5njOWfxF/QolUCndSXbdB8xGiYFpYq0+mRi98P63eZPrk67bYZcToHf8CgNRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EseVOeF3; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20ceb8bd22fso12566795ad.3
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 20:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728962917; x=1729567717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5toA+i342QCyHiEYfQpngKk7r+1pZDBgH0RjgANa6XY=;
        b=EseVOeF3N97H4kBci1T04wxBoZeiX6WtJixuFLDhsWIZI1SURJHss1HrSSQ/VD/6n3
         qdiuCdJOwSqjrm3fLtHeH+AwSXkdc7fVQ66DZJVM12KH2SfdIKi2ApdyW/1gg5vXqtvJ
         Na78k8bOO8KDaP8pmvdNJAvKYYEKhTA5gZDM+XxRoNUSqvf3s1ZyLFfBx9Bh/qjXzFVp
         q20kpio0NyklwYsxgCGec3k4nRh9w1Regmc27NNFVO0RM5naGLT0hyrE8DsrI217UDGG
         NJrUgNmhd70DxL0xN1VT1TTI4jvYK8WL7G48jivX7nGSVeOxTM7A5lPhfKr5V+QkfwXk
         5j9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728962917; x=1729567717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5toA+i342QCyHiEYfQpngKk7r+1pZDBgH0RjgANa6XY=;
        b=SJn4HvYPt5LdxnAf+pKVbSGGqECCW34Ffa/Ooc4Kwvio5evYZjHBoBQ/xbZnVloSVt
         cXBAyE5wPI6CYEu5XgJz0+h6nE5u9vvQF2H+vxKb9uZsm496w3xk6s+bTmWeuL+Xsijf
         /1ZlCCXRxatqjeeFB0TFEiQWDdFfukflHj2EVCKrpBo7vLHemOuO8bJlM8cx2kPfRGKF
         ZFKzXFDIy9eQF8UWleiprZIuVd5/r8ZvXCgV+cQZDW71vLCX2hnMKuEfV7nvWo9mabsN
         tvByBZ2kWSgygrQ0/YQBsZ4njoAA5VL06YtXjct2xSVyXND++Q8vpXJeHCgKuVQ2mN7/
         hmDA==
X-Gm-Message-State: AOJu0Yz6Y2vNVQ8ChhqJOHmFANfzDHI27nLIeoSGVj1yGf8+p27euVJC
	yJhdcQaTLWnyGAlSUudMus9Ofxx/DGQrlIBJtOyDkduYwxtSVOEIVTRqjAq5
X-Google-Smtp-Source: AGHT+IFkkeRsQOCFrl7ubPyos8WBLRbx8OL51e45EkMfFWUlxyhzoH1mi6W60ixNwcxDkTLxUBbvTw==
X-Received: by 2002:a17:902:f550:b0:20c:a175:1942 with SMTP id d9443c01a7336-20cbb1aa3a5mr131065495ad.24.1728962917283;
        Mon, 14 Oct 2024 20:28:37 -0700 (PDT)
Received: from localhost ([2402:7500:477:e9fa:5129:403f:9618:b589])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1804eb2bsm2722625ad.188.2024.10.14.20.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 20:28:36 -0700 (PDT)
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
Subject: [PATCH] [net,v3] net: wwan: t7xx: add PM_AUTOSUSPEND_MS_BY_DW5933E for Dell DW5933e
Date: Tue, 15 Oct 2024 11:28:20 +0800
Message-Id: <20241015032820.2265382-1-wojackbb@gmail.com>
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

The Tests uses a small script to loop through the power_state
of Dell DW5933e.
(for example: /sys/bus/pci/devices/0000\:72\:00.0/power_state)

* If Auto suspend is 20 seconds,
  test script show power_state have 5% of the time was in D3 state
  when host don't have data packet transmission.

* Changed auto suspend time to 5 seconds,
  test script show power_state have 50% of the time was in D3 state
  when host don't have data packet transmission.

Signed-off-by: Jack Wu <wojackbb@gmail.com>
---
V3:
 * supplementary commit information
V2:
 * Fix code style error
---
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



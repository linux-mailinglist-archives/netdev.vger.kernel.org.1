Return-Path: <netdev+bounces-146354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5549D3053
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 23:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96AD283B31
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 22:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3948D1D6191;
	Tue, 19 Nov 2024 22:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="No8YYIBE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499901D2F64;
	Tue, 19 Nov 2024 22:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732054442; cv=none; b=HaP3FiIiHiJ0FLDRFpxiR+mGnORX5VlxXJQbocVofV+EsDcl0h0bR4bwTquzVcuUQxF+9RW7RzxkXHL0U2HeDBz5gQRIFYny59VNE4Ss5YHY5x+uugzMyHCgC8TmAFdni2A+igf7kYq3fSAbw7UeOkvw+/u+wI0k+BJWs4EL+0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732054442; c=relaxed/simple;
	bh=20DSJPorGLDBUaY58IT/e03JwEmC8787005QWBAWWMk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MFrAtk9hT+KPaWMk0uvWDkD0URJb0X7B1AB+OpYnD8oIdie/ER0l5zlhOb3JSCjOb9bObRxuiBeGvgWQ3ldk5cNSHYlOJNO8WLRP3uyp1qG4zFXaDWzfU+HScF4+6ZNwrH5AyytVUyjve9L/dEQA2Q+fM8zX1dopuZ6H1iJdt4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=No8YYIBE; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb388e64b0so58979381fa.0;
        Tue, 19 Nov 2024 14:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732054438; x=1732659238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yF+XhgMq2qb2Fhx8mba/c1UDE5pPRHsVLVN7iX8+ig4=;
        b=No8YYIBEUZtbOa3DDNczpSIHwYVSEqkVl6/BfLplHtKjHhYStCV5u9rHNrvLDWyyoh
         p5XbmMfMKEWT7ZaVohKseNs3XOmMejLOswWUnDdKTeFLUvxhGP2+cEmufsI1x8RN2CZK
         p5lkz+0+xZ6df6WrHZH8BVrTwbQGYTGZjRhyngk9mN0tdHfgc3UgOUHtXtaRQ5pR/H+B
         kQHPuvE6ADP/NAqHmmAYmtbxFUwNptEykvjWRw/sPIQgOWWL16pJg99s4fnOgnteAqdd
         a74Let7Y7xxVCWE26gNJlAw3AkXjZU8nNssPqE8prqzMQy76PXxOmBLLHE9ZXB2Izc+J
         lvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732054438; x=1732659238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yF+XhgMq2qb2Fhx8mba/c1UDE5pPRHsVLVN7iX8+ig4=;
        b=l5c7wsrRUrL7AClGVgOIou4FxbWOycsR0M+u2nBowPgQc2xHgFjGNNw3xTLvmWO0BN
         Bi3xC7Is+qTCBuIB+kjaPdD1xWf87vER26VM/IjESgTy43bnDl8e6rdORiQNuMfPgbpW
         8bZEPb8nx9PaSBMWdpcIqk8LEb/hcN0Gzzatsz7AxTWnfe+QRw9fcq2tmixqxUVRh+cH
         n/jziyR4ooezojW4vq2E2JcylRhvS0ZgGg2Hyybm5CasraIL7PRmF6ovC4f7NV0H7Caj
         G8bLlfL6nMOGhO8+BSwKsVSUcIKbdpWgf/v8OnWl03ZvJKbkpY0I0OaKMmK/ZH/r5SeL
         DUrA==
X-Forwarded-Encrypted: i=1; AJvYcCUk4P9utex/l3dVSUHBa3DpsC86vi2W8QgeqjoralEm6ntd86uh9+FLZRjbbg59DIrOcJeYOhNK@vger.kernel.org, AJvYcCWw2Q/1pnIgqTOVER8/kl+Kxo/r79qRaPXWSHBdLt/3NZL75cdc47EuNoyNKURfMQB0RNnYHTtT7KE+QtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwoCrhYmof2gCnh+4BSpVIFPaUWdCw+4A7XQZ6sx7apE6Izo+q
	eXEegQ1r4Qsj0wx9xeoa/r09YAD0HET7nf3jjaMUZ9Yhy1DNFThf
X-Google-Smtp-Source: AGHT+IGwviVTzfFewQBiJN59FgjgGN1Q2YqXT6ceUhaJ8bzaBn5hts1h0p/jcAXeMOQpddMmOWph1A==
X-Received: by 2002:a05:651c:b14:b0:2fb:51e0:93f with SMTP id 38308e7fff4ca-2ff8dcf7836mr3185801fa.35.1732054438248;
        Tue, 19 Nov 2024 14:13:58 -0800 (PST)
Received: from rex.hwlab.vusec.net (lab-4.lab.cs.vu.nl. [192.33.36.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cff45504fcsm133484a12.89.2024.11.19.14.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 14:13:57 -0800 (PST)
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
To: Ronak Doshi <ronak.doshi@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
	Raphael Isemann <teemperor@gmail.com>,
	Cristiano Giuffrida <giuffrida@cs.vu.nl>,
	Herbert Bos <h.j.bos@vu.nl>
Subject: [RFC v2 2/2] vmxnet3: Remove adapter from DMA region
Date: Tue, 19 Nov 2024 23:13:52 +0100
Message-Id: <20241119221353.3912257-2-bjohannesmeyer@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119221353.3912257-1-bjohannesmeyer@gmail.com>
References: <20241119221353.3912257-1-bjohannesmeyer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Revert parts of [0] that map `adapter` into a streaming DMA region. Also
revert any other DMA-related uses of `adapter`. Doing so mitigates all
inconsistent accesses to it.

[0] commit b0eb57cb97e7837ebb746404c2c58c6f536f23fa ("VMXNET3: Add support
for virtual IOMMU")

Co-developed-by: Raphael Isemann <teemperor@gmail.com>
Signed-off-by: Raphael Isemann <teemperor@gmail.com>
Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 17 ++---------------
 drivers/net/vmxnet3/vmxnet3_int.h |  1 -
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 7fa74b8b2100..5219992f6a63 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -2605,7 +2605,7 @@ vmxnet3_setup_driver_shared(struct vmxnet3_adapter *adapter)
 	devRead->misc.driverInfo.vmxnet3RevSpt = cpu_to_le32(1);
 	devRead->misc.driverInfo.uptVerSpt = cpu_to_le32(1);
 
-	devRead->misc.ddPA = cpu_to_le64(adapter->adapter_pa);
+	devRead->misc.ddPA = cpu_to_le64(virt_to_phys(adapter));
 	devRead->misc.ddLen = cpu_to_le32(sizeof(struct vmxnet3_adapter));
 
 	/* set up feature flags */
@@ -3662,14 +3662,6 @@ vmxnet3_probe_device(struct pci_dev *pdev,
 	}
 
 	spin_lock_init(&adapter->cmd_lock);
-	adapter->adapter_pa = dma_map_single(&adapter->pdev->dev, adapter,
-					     sizeof(struct vmxnet3_adapter),
-					     DMA_TO_DEVICE);
-	if (dma_mapping_error(&adapter->pdev->dev, adapter->adapter_pa)) {
-		dev_err(&pdev->dev, "Failed to map dma\n");
-		err = -EFAULT;
-		goto err_set_mask;
-	}
 	adapter->shared = dma_alloc_coherent(
 				&adapter->pdev->dev,
 				sizeof(struct Vmxnet3_DriverShared),
@@ -3677,7 +3669,7 @@ vmxnet3_probe_device(struct pci_dev *pdev,
 	if (!adapter->shared) {
 		dev_err(&pdev->dev, "Failed to allocate memory\n");
 		err = -ENOMEM;
-		goto err_alloc_shared;
+		goto err_set_mask;
 	}
 
 	err = vmxnet3_alloc_pci_resources(adapter);
@@ -3954,9 +3946,6 @@ vmxnet3_probe_device(struct pci_dev *pdev,
 	dma_free_coherent(&adapter->pdev->dev,
 			  sizeof(struct Vmxnet3_DriverShared),
 			  adapter->shared, adapter->shared_pa);
-err_alloc_shared:
-	dma_unmap_single(&adapter->pdev->dev, adapter->adapter_pa,
-			 sizeof(struct vmxnet3_adapter), DMA_TO_DEVICE);
 err_set_mask:
 	free_netdev(netdev);
 	return err;
@@ -4023,8 +4012,6 @@ vmxnet3_remove_device(struct pci_dev *pdev)
 	dma_free_coherent(&adapter->pdev->dev,
 			  sizeof(struct Vmxnet3_DriverShared),
 			  adapter->shared, adapter->shared_pa);
-	dma_unmap_single(&adapter->pdev->dev, adapter->adapter_pa,
-			 sizeof(struct vmxnet3_adapter), DMA_TO_DEVICE);
 	free_netdev(netdev);
 }
 
diff --git a/drivers/net/vmxnet3/vmxnet3_int.h b/drivers/net/vmxnet3/vmxnet3_int.h
index 3367db23aa13..b45ed1045ca3 100644
--- a/drivers/net/vmxnet3/vmxnet3_int.h
+++ b/drivers/net/vmxnet3/vmxnet3_int.h
@@ -404,7 +404,6 @@ struct vmxnet3_adapter {
 	struct Vmxnet3_CoalesceScheme *coal_conf;
 	bool   default_coal_mode;
 
-	dma_addr_t adapter_pa;
 	dma_addr_t pm_conf_pa;
 	dma_addr_t rss_conf_pa;
 	bool   queuesExtEnabled;
-- 
2.34.1



Return-Path: <netdev+bounces-144563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD159C7C8A
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 21:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D001B29BCF
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 20:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31209208230;
	Wed, 13 Nov 2024 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUHJD+Iq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5721A2071EF;
	Wed, 13 Nov 2024 20:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731528030; cv=none; b=pZlG0d+u2720Z+SHnTVOXWiCGdLDBCaZeaL4jeiQetS2mS/qM3H5pWuTpT8swhZb3HYPqyh+g7LWn0EEluSw1iNS25PBbzq2hXJn1wlIgijqpiUguM7JlxS7d0mvjpPKlYkB7cpTEU/WCOUH321ckua4vel1J6BQkfnUP6Bc7SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731528030; c=relaxed/simple;
	bh=bxvXj0rYTEUIuTo+oE6Fsv17g+bx+ZviM+T2flCinDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SF6lnOW9NluuB1VbtZSkoxgtjvwlwos1zz78lTSIyhOUBwPayXnxv8Jv1gc4rMWV3u/EN1b7/kom41r16fF3mtJ1DxSZz9cjeJnmNQd3wMP/0QXOiVnw/kAiDK0gr1/ggmYkHGnQabTJiTWmaWzVbMCiomC1wr099u1lyDNDMjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUHJD+Iq; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso101683161fa.2;
        Wed, 13 Nov 2024 12:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731528026; x=1732132826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNoagPAPa8LF4vkYrXReGe3nCeerUu69H6SQLVJho/s=;
        b=QUHJD+IqjSd2ReFj7y1VdgZujw1PvtGmB7bEn+M6Na75tTFDzyAj/uA+NZgqfkPlle
         htF9QKfNoaWvD2tL7zNr+X7DNpSENQkeraDjo1x2PFPNvRdPtFFN3Sd7wnzQ41JPsBIw
         iEhFzKVUfa0uDQmXM1O0c1kzQgbHrFTndP0DCC2WUhjd5a02aobuOX/F+UH5pfkGRmEg
         BQaHOMeaFoC4voZlMR9U5jTrJkVaKP/T169fhI/6drjmnCxTo+rilLiwwTXILzgPJZM6
         Hxj0IeSLPHx2F8JuuF/dBYwkZgsLwtqlqCbEAcRwgXTn1veYkQbSeWzOX1SSQMwM7zAP
         tWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731528026; x=1732132826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNoagPAPa8LF4vkYrXReGe3nCeerUu69H6SQLVJho/s=;
        b=gVu2SPtEhraIn8vAb4ar1bG+bW6dOIEVN1SfSnM3JHBP82DuB/125GZN7LSv0aQYVo
         yZ8HmjRku0Axz3LWSXO94odk9oE/kp6UBk8qTy/JkNus6KPHVTeIFyhn7AC4ZRIkasFI
         cBedFJQncQI/38NIwt3tQ4GQ7iwya5UML+96Z1up5gRkFix36MmBixdufeQs0yboVLHJ
         AA68a9cJS9mnhcvsA6BZJFYaHdj8ZVOQMqu+mLNF8BCnqHMZ1v5zU0+Sy7Aeqx6Yg5so
         wjKivKL6GbmcrTYi1YIOXLOarhRPQbfy7pWBYXAs2EfwZ7cpujHaZBsT2tXJOdzuLsAx
         SdWA==
X-Forwarded-Encrypted: i=1; AJvYcCW3YYl/VWkcZwXcJJ758FrACkLZfrw6kFeF6933aUkYeZZTlCNzU0TzLl4FbV4MH4yWg5M7Big5vk4oOsM=@vger.kernel.org, AJvYcCW5iYil2C1Txa485SrujCfs+OedfVJcTjmpz6H3YZLLZupgRa8d/cmHCtHZPYisdLr9plkFHGbJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy35qjuPt1/8LKVLLxC5/tD6XXLTrKKPeK1WNOaXm2dYxcJkp8O
	u1vG6SzL7ItIYrxYvkTabhe/Ktx/McCIce7hX1AdCx4iOOQYBtUC
X-Google-Smtp-Source: AGHT+IHZ2iTOwACBsmAVacJwB6oQq4aacfYJnaFDukytp6B0W/wrdrWtkSP4TAASrmzLdcFTHZgr4g==
X-Received: by 2002:a2e:a9a4:0:b0:2fb:63b5:c0bc with SMTP id 38308e7fff4ca-2ff20162837mr146723531fa.3.1731528026079;
        Wed, 13 Nov 2024 12:00:26 -0800 (PST)
Received: from rex.hwlab.vusec.net (lab-4.lab.cs.vu.nl. [192.33.36.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9efd2fe9fdsm675016066b.132.2024.11.13.12.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 12:00:25 -0800 (PST)
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
To: Ronak Doshi <ronak.doshi@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy King <acking@vmware.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
	Raphael Isemann <teemperor@gmail.com>
Subject: [PATCH 2/2] vmxnet3: Remove adapter from DMA region
Date: Wed, 13 Nov 2024 21:00:01 +0100
Message-Id: <20241113200001.3567479-3-bjohannesmeyer@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113200001.3567479-1-bjohannesmeyer@gmail.com>
References: <20241113200001.3567479-1-bjohannesmeyer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 drivers/net/vmxnet3/vmxnet3_drv.c | 26 ++------------------------
 drivers/net/vmxnet3/vmxnet3_int.h |  1 -
 2 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index cc76134c7db4..5219992f6a63 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -2605,7 +2605,7 @@ vmxnet3_setup_driver_shared(struct vmxnet3_adapter *adapter)
 	devRead->misc.driverInfo.vmxnet3RevSpt = cpu_to_le32(1);
 	devRead->misc.driverInfo.uptVerSpt = cpu_to_le32(1);
 
-	devRead->misc.ddPA = cpu_to_le64(adapter->adapter_pa);
+	devRead->misc.ddPA = cpu_to_le64(virt_to_phys(adapter));
 	devRead->misc.ddLen = cpu_to_le32(sizeof(struct vmxnet3_adapter));
 
 	/* set up feature flags */
@@ -3623,8 +3623,6 @@ vmxnet3_probe_device(struct pci_dev *pdev,
 	int num_rx_queues;
 	int queues;
 	unsigned long flags;
-	struct device *dev;
-	dma_addr_t adapter_pa;
 
 	if (!pci_msi_enabled())
 		enable_mq = 0;
@@ -3664,19 +3662,6 @@ vmxnet3_probe_device(struct pci_dev *pdev,
 	}
 
 	spin_lock_init(&adapter->cmd_lock);
-	dev = &adapter->pdev->dev;
-	adapter_pa = dma_map_single(dev, adapter,
-					     sizeof(struct vmxnet3_adapter),
-					     DMA_TO_DEVICE);
-	if (dma_mapping_error(dev, adapter_pa)) {
-		dev_err(&pdev->dev, "Failed to map dma\n");
-		err = -EFAULT;
-		goto err_set_mask;
-	}
-	dma_sync_single_for_cpu(dev, adapter_pa,
-				sizeof(struct vmxnet3_adapter), DMA_TO_DEVICE);
-	adapter->adapter_pa = adapter_pa;
-
 	adapter->shared = dma_alloc_coherent(
 				&adapter->pdev->dev,
 				sizeof(struct Vmxnet3_DriverShared),
@@ -3684,7 +3669,7 @@ vmxnet3_probe_device(struct pci_dev *pdev,
 	if (!adapter->shared) {
 		dev_err(&pdev->dev, "Failed to allocate memory\n");
 		err = -ENOMEM;
-		goto err_alloc_shared;
+		goto err_set_mask;
 	}
 
 	err = vmxnet3_alloc_pci_resources(adapter);
@@ -3935,8 +3920,6 @@ vmxnet3_probe_device(struct pci_dev *pdev,
 	}
 
 	vmxnet3_check_link(adapter, false);
-	dma_sync_single_for_device(dev, adapter_pa,
-				sizeof(struct vmxnet3_adapter), DMA_TO_DEVICE);
 	return 0;
 
 err_register:
@@ -3963,9 +3946,6 @@ vmxnet3_probe_device(struct pci_dev *pdev,
 	dma_free_coherent(&adapter->pdev->dev,
 			  sizeof(struct Vmxnet3_DriverShared),
 			  adapter->shared, adapter->shared_pa);
-err_alloc_shared:
-	dma_unmap_single(&adapter->pdev->dev, adapter->adapter_pa,
-			 sizeof(struct vmxnet3_adapter), DMA_TO_DEVICE);
 err_set_mask:
 	free_netdev(netdev);
 	return err;
@@ -4032,8 +4012,6 @@ vmxnet3_remove_device(struct pci_dev *pdev)
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



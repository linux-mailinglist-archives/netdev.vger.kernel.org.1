Return-Path: <netdev+bounces-146355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CDF9D3055
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 23:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5023C1F24591
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 22:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCCB1D4150;
	Tue, 19 Nov 2024 22:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNxHbz+G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D0B1D5CDB;
	Tue, 19 Nov 2024 22:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732054443; cv=none; b=dTmhn0gaqzEt6Uw69sImGukQr21V4/U3CV7UuebT6GC/v56j+aijFP67dNPgl/bpk28ZoCdyejS14d5mFuJE2+zZd8biu6Kc65QgdcJGU8TQM6nLFaMoasizY+WHrr/SpKm8oeCCqni/WnImhqRFpWoXBNuR2/f2THl6YOuVV58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732054443; c=relaxed/simple;
	bh=lzP7Gvkcx/FmhvwQSpENog9t68uKeMkJZy5qk0I1338=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oKgL2QjJA58FLcsTW/n5e/plVKBr/jv43yjD0D6i8JnX4sGC2a1wq/evHYX/vpaRsMO/Isoxye8vgOVJDz7REXQywvNUwSmiMxn2S31uVRumP2OsnpA+Nq2N77R8IB6i1Oiw1PtdYRsStx/t1QP+1QgRw6Qr5IC0uhsbWuNACII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNxHbz+G; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c9c28c1ecbso2085105a12.0;
        Tue, 19 Nov 2024 14:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732054440; x=1732659240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLg3Zgz+FEDEY+dTOsaG0ncu4gz3SWEdaD0wc9B4rSY=;
        b=eNxHbz+Gq/W1hz5k+I/CsiJCAZXmQkeRp9OtcZAK3hW2pM2WXICWsfbE9eMOmOy4U3
         qWKTmcOYyZDK25p2EzUM0IZykgwmcbgKz6Qfm69lfuJ6BbK2zIzrHy+DpfPeILGBNuIY
         bTCi0NNiO/GcwswP460LYFrD8bbTxDrEH3JdLv7fMxqBRKiYzkxzSfx1dEh7c73rB9OQ
         5UnmeZv+oV4HpIi0JfSFwSSvZ0F0ynmi8MP2UZUHbxPXJh6i3k/Gp3dSeUCh/eHa9ocW
         YXfMyAQE809VGsLKCE/qZxuj+V+D1xT5C2fQdNQFD8hsE1xkJs6V++KVzyzxIs3QbPzO
         h2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732054440; x=1732659240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jLg3Zgz+FEDEY+dTOsaG0ncu4gz3SWEdaD0wc9B4rSY=;
        b=GOcInnjg49R0RMaAXbM+H6gPcwLyZQBvT3BxzE5UZFJtk1pZS/UGypGxyypvfQMada
         EH17lvx4YB2muTVdmzd5shE72L7qEKrjqaHOwbGVKJbD2/8sqg5xDacBEEPHyO3/xGhM
         5N5C11A6EuYkd3amHp+EmB/dUvbcAi9Dj2L+YhN8pwcS6tre8wRrep42HlFYFzFslSMn
         m04+hOXuhabIPUmbpA+dvza2WsMpd2O24If+wqdFII13ta2R0JYcsuLjxRayqT3Op1Kq
         XqflkJ0/PgAtfjkEEptxi4Z3GQNU1LKfOaY+pUdz7Zi+2J310YhtS7t6PyodpvM1+xSN
         gSIw==
X-Forwarded-Encrypted: i=1; AJvYcCUoXt2kfm63qVdQEAWoy3J/7ZjdmH27/1K7QPExlXhOdl/JaK36Zpb81DBBiMz6liuoYfcN7J5zcPDPsrg=@vger.kernel.org, AJvYcCWlz/6fJeqi8BzNV3sFk3ou4uUhUN2EKAggDSJtipvynl6XaQBgE4SsUZEC+iLzP/4N1TcfxmWG@vger.kernel.org
X-Gm-Message-State: AOJu0YzmFqG6MDKPLO67zri9VD5LLQdFVo6TGJPLBcKfVJ8DsxVYAHWb
	bBO1+KtLv8blFbYMBwNLaRAJJCNz3hkCEq/wke2TbPn7dq8COAQZ
X-Google-Smtp-Source: AGHT+IF/SBX+B2+021nCX1tdeI9ozu3Mfn3ca5/E2iXbH7GqBvRnxzsFafGMnb4PILGaYjVb+4BGLw==
X-Received: by 2002:a05:6402:524a:b0:5cf:e218:a4ae with SMTP id 4fb4d7f45d1cf-5cff4cdd75dmr163238a12.31.1732054439744;
        Tue, 19 Nov 2024 14:13:59 -0800 (PST)
Received: from rex.hwlab.vusec.net (lab-4.lab.cs.vu.nl. [192.33.36.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cff45504fcsm133484a12.89.2024.11.19.14.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 14:13:59 -0800 (PST)
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
Subject: [RFC v2 1/2] vmxnet3: Fix inconsistent DMA accesses in vmxnet3_probe_device()
Date: Tue, 19 Nov 2024 23:13:53 +0100
Message-Id: <20241119221353.3912257-3-bjohannesmeyer@gmail.com>
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

After mapping `adapter` to streaming DMA, but before accessing it,
synchronize it to the CPU. Then, before returning, synchronize it back to
the device. This mitigates any inconsistent accesses to it from
vmxnet3_probe_device().

Co-developed-by: Raphael Isemann <teemperor@gmail.com>
Signed-off-by: Raphael Isemann <teemperor@gmail.com>
Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 7fa74b8b2100..032d3cd34be1 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -3623,6 +3623,8 @@ vmxnet3_probe_device(struct pci_dev *pdev,
 	int num_rx_queues;
 	int queues;
 	unsigned long flags;
+	struct device *dev;
+	dma_addr_t adapter_pa;
 
 	if (!pci_msi_enabled())
 		enable_mq = 0;
@@ -3662,14 +3664,19 @@ vmxnet3_probe_device(struct pci_dev *pdev,
 	}
 
 	spin_lock_init(&adapter->cmd_lock);
-	adapter->adapter_pa = dma_map_single(&adapter->pdev->dev, adapter,
-					     sizeof(struct vmxnet3_adapter),
-					     DMA_TO_DEVICE);
-	if (dma_mapping_error(&adapter->pdev->dev, adapter->adapter_pa)) {
+	dev = &adapter->pdev->dev;
+	adapter_pa = dma_map_single(dev, adapter,
+				    sizeof(struct vmxnet3_adapter),
+				    DMA_TO_DEVICE);
+	if (dma_mapping_error(dev, adapter_pa)) {
 		dev_err(&pdev->dev, "Failed to map dma\n");
 		err = -EFAULT;
 		goto err_set_mask;
 	}
+	dma_sync_single_for_cpu(dev, adapter_pa,
+				sizeof(struct vmxnet3_adapter), DMA_TO_DEVICE);
+	adapter->adapter_pa = adapter_pa;
+
 	adapter->shared = dma_alloc_coherent(
 				&adapter->pdev->dev,
 				sizeof(struct Vmxnet3_DriverShared),
@@ -3928,6 +3935,9 @@ vmxnet3_probe_device(struct pci_dev *pdev,
 	}
 
 	vmxnet3_check_link(adapter, false);
+	dma_sync_single_for_device(dev, adapter_pa,
+				   sizeof(struct vmxnet3_adapter),
+				   DMA_TO_DEVICE);
 	return 0;
 
 err_register:
-- 
2.34.1



Return-Path: <netdev+bounces-144562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E92859C7C89
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 21:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAA0B2862E5
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 20:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F54A2076A3;
	Wed, 13 Nov 2024 20:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJ8OKL9r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5AA206E63;
	Wed, 13 Nov 2024 20:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731528029; cv=none; b=RLC8eq8J+SQUIebmJPfqDtu8wh9k2RPWsRYJ9j0Pv+dLPrlXLx+RAeguR09rvEjPcWZq94TqMFye+xAD//B4FnaZYj6gNHcSFDHCOS9ZOmitA2itZZWWVzk8MY3dXGCnv6mP9cETl+YHINglGanguErsbBOnZZwMzlYP63sKg6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731528029; c=relaxed/simple;
	bh=d5viJel+82ljzhWK9mCPXgCaDSTDjH/J2BX+NnimVOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n8RHYLObh6kCVMKcapttUI8I546tgACI+SEBmBKzgejq7vL9LhnhmXxn6AkSQHShWCqAZfjjBEFF61jcZDhUKTs3+bszp4tZLbFNcufzRDjOm6dQ6fBFC51hFEQmuiEeN9TtKPMQ6f2efPrbuwrDEY1fA3tJQGZTLX7Pm0q5O8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJ8OKL9r; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso669941966b.1;
        Wed, 13 Nov 2024 12:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731528024; x=1732132824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVlI2r8n+S0FhsHSJ6kkX4Tar+jyuTTpMFKnYbDwCvM=;
        b=BJ8OKL9rf2lmTgaRqkaXNhkO/kbHHn5kE34RzI20ggIEa/SxwPEBGCeUKb21cIuVSP
         OiM1YkE4jkhI5N9wd3EAhqqTeO3W7PhMUYWTQ1hOUdaLZL0I0tcimNEAQa4/0OdpwJ/J
         +ZaShcz7/FhZFxb6xOFC1848Vs9PCid9U4FtJr9kj2mtET1VXA1bYu057a8SSdAm05zh
         LfVv6ajwAJMyvJnlYTug2yrnPr/jzp66cJO/VTlfUMI/phmLbSykat9ji+UpfDbZg4vD
         XbJH8YIELzjKpk3znd7JTjHnvBz+MnZmNhQqT9ySqUA/og9TBQ1KXlatLLa9bjeBqCgF
         bNvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731528024; x=1732132824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVlI2r8n+S0FhsHSJ6kkX4Tar+jyuTTpMFKnYbDwCvM=;
        b=wwit3aTh2hv6ImrlplkkmGCl1DjE2LNfWHXmxGDf7N6w//sVuJXG9pJYq+krnuqlMn
         rhwM9Kn3wU9QRwDGSqvl5wOmmuE8aG7bvOPmyraWKOMJ4E1V4er+wD8jtHzREa3ytnJq
         iMKbPiwz5zBpUytie/LLZptKIsYIZubW5AodPouBLk+YdWk7oHGEm5G4SVMbKtjrxtzI
         +5XdMtJ6osd4EXhgyW7WklmvbSkflqqEMi3Z5MZA3p8tWbFhSD9rlfOZyYotDimeFdz3
         LvZIgNtO/8/E0YuBaLe+Wldd/q2WfuUL3EC4telGyC+MWw7SgcHjKKRw7PKVJrDEi0+G
         8MPA==
X-Forwarded-Encrypted: i=1; AJvYcCUyBCeJpt1VK9AhDYSXat5TZLRSupZCqX8ZZS+YARQi/KlwKtszLnWL8UEqCOPqJTESIRgvt6FA@vger.kernel.org, AJvYcCWAsdZjGHX/7aDHtkas1gBVYKugj7Td5hmHhiid5wtYIfODKrpL18b/OajdT35ZC4CwkJwTqHG9s0TE1Ks=@vger.kernel.org
X-Gm-Message-State: AOJu0YygJMXzl671t4ycNPbyVt8u7ZlH9soQl3vaYB0X97Maf5gDNiLx
	dxuuqnCqnMYkXQauD2iIk3WdA0eMVMhqEpeP+7sueIuHPPiMarOo
X-Google-Smtp-Source: AGHT+IGyAcftxKD33p1adczISEa+8uVQe/SrQh3kWlJBDNwqWiuUASq8P7YyCPSja4Og4uiuI9na2g==
X-Received: by 2002:a17:907:5ca:b0:a9e:c947:d5e5 with SMTP id a640c23a62f3a-aa1f807701bmr351520466b.28.1731528024357;
        Wed, 13 Nov 2024 12:00:24 -0800 (PST)
Received: from rex.hwlab.vusec.net (lab-4.lab.cs.vu.nl. [192.33.36.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9efd2fe9fdsm675016066b.132.2024.11.13.12.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 12:00:24 -0800 (PST)
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
Subject: [PATCH 1/2] vmxnet3: Fix inconsistent DMA accesses in vmxnet3_probe_device()
Date: Wed, 13 Nov 2024 21:00:00 +0100
Message-Id: <20241113200001.3567479-2-bjohannesmeyer@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113200001.3567479-1-bjohannesmeyer@gmail.com>
References: <20241113200001.3567479-1-bjohannesmeyer@gmail.com>
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
 drivers/net/vmxnet3/vmxnet3_drv.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 7fa74b8b2100..cc76134c7db4 100644
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
+	dev = &adapter->pdev->dev;
+	adapter_pa = dma_map_single(dev, adapter,
 					     sizeof(struct vmxnet3_adapter),
 					     DMA_TO_DEVICE);
-	if (dma_mapping_error(&adapter->pdev->dev, adapter->adapter_pa)) {
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
@@ -3928,6 +3935,8 @@ vmxnet3_probe_device(struct pci_dev *pdev,
 	}
 
 	vmxnet3_check_link(adapter, false);
+	dma_sync_single_for_device(dev, adapter_pa,
+				sizeof(struct vmxnet3_adapter), DMA_TO_DEVICE);
 	return 0;
 
 err_register:
-- 
2.34.1



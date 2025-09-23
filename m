Return-Path: <netdev+bounces-225551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CF4B95523
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 11:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 101A22E2697
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 09:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3780320A20;
	Tue, 23 Sep 2025 09:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IqPICzxq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A463191B4
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 09:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758621007; cv=none; b=Oq1FVMTcuBtubqZyl2SkT7swxNfhBQu8bzlkuSHZrOFQFHwwiEReYNAdf/L5GHdMTPwU8E32C4dgZB28+g50OSuKnB8gEJwS5HWa7PTNP+JmOI08wMSUq7pPyolY+3xAT8XxJWirC4p/sknPoeZ8lHXG3MCPyKOnI/NPa5PRndg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758621007; c=relaxed/simple;
	bh=P+xbXXENIRr59C9H8dmSx7rvC10vfBao+7CkpfUO3bM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a2lEj5p0cfXqG/HPk1VvFMuReX+yRHHlQG3XOpsVWkfPI6Ga5+yViFud0r6mIorjCPBM5ar026mI6tfdFY/7wO6XndgyeBz0fYb8x6IAZJe2UPKjjcoRSkn4lYuz/WLN3GjeyETHwlYhbu0FMJVzIDoQvucnDkOZgRv//uh9B9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IqPICzxq; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-77f41086c11so1693965b3a.0
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 02:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758621005; x=1759225805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sTZFfTvToc3eSrZtaGP9vkY5xr5lWepCbD04a99pHno=;
        b=Go9SBIIIoWS3dSMEuwQuNq8RkzSc7mQWl8rxkXVs9Ly5xgGh6XzVs6Sc53i2UiuBxG
         phIah4M5Pi5ZP/+ZbMgrxWphAirMR4xfGP/sogaRZYUFzWpdTtrU4A9k47pVWuFcZ7ZM
         0MYSFgaUiWKdOdraODdcEnOS5As+Ac1AeLcEAalwrAKwayUwskkmD4uR7rvVJnN4sdtp
         nMSdXVhVcsefop5KON98YegnNnsVjHUBEdhhgCW2kAjLI7xUpe9BqV9XzEUmraxYAMYo
         cXg2VScseWFFJ2JAzJg9G+qwYt5r8VCFOBzRPGj3QNGHN2GXGNVQpAtqsT94wqmHBJPr
         y/Bg==
X-Forwarded-Encrypted: i=1; AJvYcCXwggQWAVRv8GAAuxJBwjGu9FJ7/CpmxBqZrnxrH0oDnFGjSx/TNrTmvpae4z9McLPbPuGhdYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP6LUYCcunerZxrLMXg1/FYOjb/3iv7A1jsJF4FFbqBQBUch7m
	CCfvf6b5JATKqx7hqw73qqBkwUlvlDo90yCeAcc/rbUAKlHafRwKwDoMDuxgI338P0jpRq/trlH
	B9EkV4EG83cVbwt9DwTKGgPWBGjqJnq9xfcFqwDss44Nu/GcquEzRLSWLmYwOYTcfM+0P2qO61A
	wM/vsMKu7ZxLdLNyacWLQX1Rkawqxb8OZ/UDbes6DeqMCXJAnuvXVl/yIXVdoT1kTA7RRLPovr5
	x4N1vN+2LI=
X-Gm-Gg: ASbGncswOyzYe4f0hs7PiQOjYAj4q8/3nS7NermkAySbsCk6LAzHiiCJwbfHFme+WN5
	f36WVlnoDRQo8Ir2X0uL6Tqrmv7KWH0MxyP8cnI9GoqR5XJk9XGc0SqFwbfLIkP795wALoksYGF
	lSWSwIkm7+jdUviaiO/pVHAOcfaM+gZSSMpKWPyLbxp1GfXVGjBZUpdTlLtkJbw8fayZKn2RZ57
	WqEmemG+yWyzdFIKnF2DYwlkfDeWZXyZvTHXNxVhvPpg2i7nAihOfaGdrz04wTMXYzfyrI8T+4r
	3R1Z9560tIo5IWUeGpU8NyWmt1g23WXger7DMh/qK2hOaJwdM7s9J+WnTNE89SHq9vdqmRcsN3n
	zwoECNV5a+6Gyw7Ym/EpoMgLsrkAbFWQGa+1IpzLZQHyDVPE7+KBdP4+N1uEVxq3VZWObUpuuNB
	Q=
X-Google-Smtp-Source: AGHT+IEfq5/O9rLbKAlmRmoUFcrF8N+uWXwxQzX3pK8bI2L938BS+BDTUhey6P89v7t5ZykEigx5mJFzuYiC
X-Received: by 2002:a05:6a00:1a8c:b0:77f:5048:8a8c with SMTP id d2e1a72fcca58-77f53b65aa7mr2255109b3a.28.1758621005357;
        Tue, 23 Sep 2025 02:50:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-77cfec3f5a5sm949746b3a.12.2025.09.23.02.50.04
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Sep 2025 02:50:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2699ed6d43dso52547525ad.1
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 02:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758621003; x=1759225803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTZFfTvToc3eSrZtaGP9vkY5xr5lWepCbD04a99pHno=;
        b=IqPICzxqldgP0Xqk8zaTu2tEj82YP4yanL+IiwtIACSCEXF6U6FGRXgmCWL5nSl9MC
         2ktcB31zB/tqwpXT8ckIFI+AsGcU1Zl1SH1cg9/9KXpUXBpkhtZ2pdKDaFLRSjSO1/Rz
         GgRCX7cVA4wWxLroheVdQHiLudvpkzZ90vr1A=
X-Forwarded-Encrypted: i=1; AJvYcCWdr3kU1490fhr9RnJQyy7kZMUFRPRNPUUPA6lZe/xV1savu34PdTIb686FcT9xO3VcbrbSqz8=@vger.kernel.org
X-Received: by 2002:a17:903:986:b0:271:479d:3ddc with SMTP id d9443c01a7336-27cc1e1ace8mr24394255ad.15.1758621003370;
        Tue, 23 Sep 2025 02:50:03 -0700 (PDT)
X-Received: by 2002:a17:903:986:b0:271:479d:3ddc with SMTP id d9443c01a7336-27cc1e1ace8mr24394035ad.15.1758621002933;
        Tue, 23 Sep 2025 02:50:02 -0700 (PDT)
Received: from PC-MID-R740.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269a75d63eesm139105945ad.100.2025.09.23.02.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 02:50:02 -0700 (PDT)
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
To: jgg@ziepe.ca,
	michael.chan@broadcom.com
Cc: dave.jiang@intel.com,
	saeedm@nvidia.com,
	Jonathan.Cameron@huawei.com,
	davem@davemloft.net,
	corbet@lwn.net,
	edumazet@google.com,
	gospo@broadcom.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	selvin.xavier@broadcom.com,
	leon@kernel.org,
	kalesh-anakkur.purayil@broadcom.com,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH net-next v2 4/6] bnxt_en: Create an aux device for fwctl
Date: Tue, 23 Sep 2025 02:58:23 -0700
Message-Id: <20250923095825.901529-5-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250923095825.901529-1-pavan.chebbi@broadcom.com>
References: <20250923095825.901529-1-pavan.chebbi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Create an additional auxiliary device to support fwctl.
The next patch will create bnxt_fwctl and bind to this
device.

Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  5 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 79 +++++++++++++++++--
 include/linux/bnxt/ulp.h                      |  1 +
 4 files changed, 82 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index feb11b9ea4dd..58a7c0af89a7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -16189,11 +16189,13 @@ static void bnxt_remove_one(struct pci_dev *pdev)
 		__bnxt_sriov_disable(bp);
 
 	bnxt_aux_device_del(bp, BNXT_AUXDEV_RDMA);
+	bnxt_aux_device_del(bp, BNXT_AUXDEV_FWCTL);
 
 	unregister_netdev(dev);
 	bnxt_ptp_clear(bp);
 
 	bnxt_aux_device_uninit(bp, BNXT_AUXDEV_RDMA);
+	bnxt_aux_device_uninit(bp, BNXT_AUXDEV_FWCTL);
 
 	bnxt_free_l2_filters(bp, true);
 	bnxt_free_ntp_fltrs(bp, true);
@@ -16780,6 +16782,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	bnxt_init_ring_params(bp);
 	bnxt_set_ring_params(bp);
 	bnxt_aux_device_init(bp, BNXT_AUXDEV_RDMA);
+	bnxt_aux_device_init(bp, BNXT_AUXDEV_FWCTL);
 	rc = bnxt_set_dflt_rings(bp, true);
 	if (rc) {
 		if (BNXT_VF(bp) && rc == -ENODEV) {
@@ -16844,6 +16847,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	bnxt_dl_fw_reporters_create(bp);
 
 	bnxt_aux_device_add(bp, BNXT_AUXDEV_RDMA);
+	bnxt_aux_device_add(bp, BNXT_AUXDEV_FWCTL);
 
 	bnxt_print_device_info(bp);
 
@@ -16852,6 +16856,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return 0;
 init_err_cleanup:
 	bnxt_aux_device_uninit(bp, BNXT_AUXDEV_RDMA);
+	bnxt_aux_device_uninit(bp, BNXT_AUXDEV_FWCTL);
 	bnxt_dl_unregister(bp);
 init_err_dl:
 	bnxt_shutdown_tc(bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index b2f139eddfec..1eeea0884e09 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2340,6 +2340,8 @@ struct bnxt {
 
 	struct bnxt_napi	**bnapi;
 
+	struct bnxt_en_dev	*edev_fwctl;
+	struct bnxt_aux_priv	*aux_priv_fwctl;
 	struct bnxt_rx_ring_info	*rx_ring;
 	struct bnxt_tx_ring_info	*tx_ring;
 	u16			*tx_ring_map;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index ecad1947ccb5..c06a9503b551 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -28,6 +28,7 @@
 #include "bnxt_hwrm.h"
 
 static DEFINE_IDA(bnxt_rdma_aux_dev_ids);
+static DEFINE_IDA(bnxt_fwctl_aux_dev_ids);
 
 struct bnxt_aux_device {
 	const char *name;
@@ -43,6 +44,7 @@ struct bnxt_aux_device {
 };
 
 static void bnxt_rdma_aux_dev_release(struct device *dev);
+static void bnxt_fwctl_aux_dev_release(struct device *dev);
 
 static void bnxt_rdma_aux_dev_set_priv(struct bnxt *bp,
 				       struct bnxt_aux_priv *priv)
@@ -81,6 +83,43 @@ static void bnxt_rdma_aux_dev_free_ida(struct bnxt_aux_priv *aux_priv)
 	ida_free(&bnxt_rdma_aux_dev_ids, aux_priv->id);
 }
 
+static void bnxt_fwctl_aux_dev_set_priv(struct bnxt *bp,
+					struct bnxt_aux_priv *priv)
+{
+	bp->aux_priv_fwctl = priv;
+}
+
+static struct bnxt_aux_priv *bnxt_fwctl_aux_dev_get_priv(struct bnxt *bp)
+{
+	return bp->aux_priv_fwctl;
+}
+
+static struct auxiliary_device *bnxt_fwctl_aux_dev_get_auxdev(struct bnxt *bp)
+{
+	return &bp->aux_priv_fwctl->aux_dev;
+}
+
+static void bnxt_fwctl_aux_dev_set_edev(struct bnxt *bp,
+					struct bnxt_en_dev *edev)
+{
+	bp->edev_fwctl = edev;
+}
+
+static struct bnxt_en_dev *bnxt_fwctl_aux_dev_get_edev(struct bnxt *bp)
+{
+	return bp->edev_fwctl;
+}
+
+static u32 bnxt_fwctl_aux_dev_alloc_ida(void)
+{
+	return ida_alloc(&bnxt_fwctl_aux_dev_ids, GFP_KERNEL);
+}
+
+static void bnxt_fwctl_aux_dev_free_ida(struct bnxt_aux_priv *aux_priv)
+{
+	ida_free(&bnxt_fwctl_aux_dev_ids, aux_priv->id);
+}
+
 static struct bnxt_aux_device bnxt_aux_devices[__BNXT_AUXDEV_MAX] = {{
 	.name		= "rdma",
 	.alloc_ida	= bnxt_rdma_aux_dev_alloc_ida,
@@ -91,6 +130,16 @@ static struct bnxt_aux_device bnxt_aux_devices[__BNXT_AUXDEV_MAX] = {{
 	.set_edev       = bnxt_rdma_aux_dev_set_edev,
 	.get_edev	= bnxt_rdma_aux_dev_get_edev,
 	.get_auxdev	= bnxt_rdma_aux_dev_get_auxdev,
+}, {
+	.name		= "fwctl",
+	.alloc_ida	= bnxt_fwctl_aux_dev_alloc_ida,
+	.free_ida	= bnxt_fwctl_aux_dev_free_ida,
+	.release	= bnxt_fwctl_aux_dev_release,
+	.set_priv       = bnxt_fwctl_aux_dev_set_priv,
+	.get_priv	= bnxt_fwctl_aux_dev_get_priv,
+	.set_edev       = bnxt_fwctl_aux_dev_set_edev,
+	.get_edev	= bnxt_fwctl_aux_dev_get_edev,
+	.get_auxdev	= bnxt_fwctl_aux_dev_get_auxdev,
 }};
 
 static void bnxt_fill_msix_vecs(struct bnxt *bp, struct bnxt_msix_entry *ent)
@@ -314,6 +363,8 @@ void bnxt_ulp_stop(struct bnxt *bp)
 		}
 	}
 ulp_stop_exit:
+	if (bp->edev_fwctl)
+		bp->edev_fwctl->flags |= BNXT_EN_FLAG_ULP_STOPPED;
 	mutex_unlock(&edev->en_dev_lock);
 }
 
@@ -347,6 +398,8 @@ void bnxt_ulp_start(struct bnxt *bp, int err)
 	}
 ulp_start_exit:
 	edev->flags &= ~BNXT_EN_FLAG_ULP_STOPPED;
+	if (bp->edev_fwctl)
+		bp->edev_fwctl->flags &= ~BNXT_EN_FLAG_ULP_STOPPED;
 	mutex_unlock(&edev->en_dev_lock);
 }
 
@@ -536,12 +589,27 @@ void bnxt_aux_device_add(struct bnxt *bp, enum bnxt_ulp_auxdev_type auxdev_type)
 	aux_dev = bnxt_aux_devices[auxdev_type].get_auxdev(bp);
 	rc = auxiliary_device_add(aux_dev);
 	if (rc) {
-		netdev_warn(bp->dev, "Failed to add auxiliary device for ROCE\n");
+		netdev_warn(bp->dev, "Failed to add auxiliary device for auxdev type %d\n",
+			    auxdev_type);
 		auxiliary_device_uninit(aux_dev);
-		bp->flags &= ~BNXT_FLAG_ROCE_CAP;
+		if (auxdev_type == BNXT_AUXDEV_RDMA)
+			bp->flags &= ~BNXT_FLAG_ROCE_CAP;
 	}
 }
 
+static void bnxt_fwctl_aux_dev_release(struct device *dev)
+{
+	struct bnxt_aux_priv *aux_priv =
+		container_of(dev, struct bnxt_aux_priv, aux_dev.dev);
+	struct bnxt *bp = netdev_priv(aux_priv->edev->net);
+
+	ida_free(&bnxt_fwctl_aux_dev_ids, aux_priv->id);
+	kfree(aux_priv->edev);
+	bp->edev_fwctl = NULL;
+	kfree(bp->aux_priv_fwctl);
+	bp->aux_priv_fwctl = NULL;
+}
+
 void bnxt_aux_device_init(struct bnxt *bp,
 			  enum bnxt_ulp_auxdev_type auxdev_type)
 {
@@ -566,8 +634,8 @@ void bnxt_aux_device_init(struct bnxt *bp,
 
 	aux_priv->id = bnxt_aux_devices[auxdev_type].alloc_ida();
 	if (aux_priv->id < 0) {
-		netdev_warn(bp->dev,
-			    "ida alloc failed for ROCE auxiliary device\n");
+		netdev_warn(bp->dev, "ida alloc failed for %d auxiliary device\n",
+			    auxdev_type);
 		kfree(aux_priv);
 		goto exit;
 	}
@@ -611,5 +679,6 @@ void bnxt_aux_device_init(struct bnxt *bp,
 aux_dev_uninit:
 	auxiliary_device_uninit(aux_dev);
 exit:
-	bp->flags &= ~BNXT_FLAG_ROCE_CAP;
+	if (auxdev_type == BNXT_AUXDEV_RDMA)
+		bp->flags &= ~BNXT_FLAG_ROCE_CAP;
 }
diff --git a/include/linux/bnxt/ulp.h b/include/linux/bnxt/ulp.h
index baac0dd44078..5a580bc37a06 100644
--- a/include/linux/bnxt/ulp.h
+++ b/include/linux/bnxt/ulp.h
@@ -22,6 +22,7 @@ struct bnxt;
 
 enum bnxt_ulp_auxdev_type {
 	BNXT_AUXDEV_RDMA = 0,
+	BNXT_AUXDEV_FWCTL,
 	__BNXT_AUXDEV_MAX,
 };
 
-- 
2.39.1



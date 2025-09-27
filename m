Return-Path: <netdev+bounces-226879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0342ABA5C74
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 11:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37111B21866
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 09:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EE62D6608;
	Sat, 27 Sep 2025 09:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WZIHMNgb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f99.google.com (mail-oa1-f99.google.com [209.85.160.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E2D2D5A01
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 09:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758965591; cv=none; b=dNyRf88PsNSCmVQH4HElH8i9B1JI+WQ1iQxwoTTQA0xP89KNShZOZpCn/Vdvf2kQEVJtYt65tnWNAHGTU0pIMKENoe2Mreh77lYghwWdcqp98csHPjqrSFmXrRb+P8hYFlQP2Yk7sJdKLMuLdCvkshrSQpLEaoqY5+9/UDK2ugU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758965591; c=relaxed/simple;
	bh=UPtriqeSrnlDWa7RdZaBVb05Pgec/SzvKli+6KieM7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k5ez0bpi/qEJgeCvbJ/Z2Ei07eSH+cMjs6SHmPW6q0ubYJ6Ac0eN/f/ww/OKRwNzKRffEJXsRj2zi2SIrX9Oxbo3vR+7ExHDImO3i2HhNmWVU1xAWn6jyMk9g6tr2GTHBADVlqqNSMpcaJrav+kQ8QWtJgW+CrHluX+wDqsnID4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WZIHMNgb; arc=none smtp.client-ip=209.85.160.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f99.google.com with SMTP id 586e51a60fabf-3799fc8ada6so72388fac.1
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 02:33:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758965589; x=1759570389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w6U9OAp6smC97RyM0KZjVaXlM0osQ9F79WEK/8vAOxE=;
        b=NFlEwWZpOV35bU2pwzCQpsNHynPjhsyYsgA1vFrJDm9MCiS/YMlp40UHBQBKXszgTZ
         dcfq4KDpoQjzizr0XSJYHdtJo0eXYLWJTMLhzUmWgX51x7dCRzWsYZhHff5aSH8PV73m
         2Psdc1Mvo4aGG1yDsWleZSti+sn5j6YnmK93sIgXe8zzX9lmXsVmKRevqtOaUi2UC7ZW
         Z0TYHiAg8O788IR9NNdw4ZbNMG2BnRuYCL+VHH6JYGI+9UH5Xrhf+gqXTQZm1NCi8Wo3
         SDV252+8BxIltlUPWw1ih/uBTVTB9Wh9wwaBGRt7ecT1pKyemNxxaASsGAukocSfz0i6
         WIlg==
X-Forwarded-Encrypted: i=1; AJvYcCUZE5QuyFWaCM+zvydg816k0VxbMclD7tEaDo3if6WS+U5h1t0FJItj9zgDKfExVNkJOY5Mwtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKeHMr2JZkDi9/FpFs75V2tg2PNeOBwR5usiXj9NM2j3Z0RdRO
	+oWZ+MyIycbm3beXlvmLd72cClzsG4DdwEygwYLUb08vWlGFjRxSzf5c8GdSstLbUnKp2d0SluM
	/1PGUj3fkOCAgUVzJNkoNq8NqcKIFvEyeymOF6DW+J6b2E05CzytQX2U9u3MZyCw6YPIjkAd6wh
	gh+ZgSf2wBMX0b0iLeAZy3yTNaAeuI1Iy+MC5F16mp89UfzPa/cQk7cVx3Q3tJHpmB+utkU/VWB
	zkaphhBeNu90A==
X-Gm-Gg: ASbGncvjRSPn9OmC3roV7Zs/zUcl0Ba54KttSVeE8fhoCJL76tTzNWPSS74yuX1/LSL
	qkSkuXQYhdGvawwKFe3tntYU1ZOte7UljoBISbQiGPt646/vURyQZys3Y3RyneiCP2y0IdPsr5r
	9sKZzXbarbydsuQFUPrPzYsppe0FNNQfAUVqJHmNtZmpCrXnqo1XQPmgDkvKrVA3r8MhKkK6xwy
	OPlI4besFCfTIuUI6wgt3Ia4sbE7OuWADYHECk1QhEYrrElwTcUrRtf9f5MVyZtQZqVYsL45lab
	MRIeUtBjtxTI1xaUr4hQYRF1oMkgm/nZ1hiEKs1kUEvw3DBWoOMJSqPNHD3c0FAbgAYSLRIp3wY
	cdu98OwI46xYV6asbNEFJNH94Cv3rRWwFvLfhU4eaFsERWOhd0PljNqvtkzkzurHDNryQ2ActDX
	o=
X-Google-Smtp-Source: AGHT+IE67iPAbkiIkkv3y1epeVBPU8j3tYGyerVEjx2AAip/hUEta+Lsd5IBxy7LrAH1HEWCZCOhWVoEC06a
X-Received: by 2002:a05:6820:16a8:b0:639:4656:f9a3 with SMTP id 006d021491bc7-63a361be79dmr4814479eaf.4.1758965589114;
        Sat, 27 Sep 2025 02:33:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-63b1f673382sm260043eaf.6.2025.09.27.02.33.08
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Sep 2025 02:33:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4c72281674so1901693a12.3
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 02:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758965587; x=1759570387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6U9OAp6smC97RyM0KZjVaXlM0osQ9F79WEK/8vAOxE=;
        b=WZIHMNgbCErni+sUmjmLHhn1hQxgGlxIc3Up4fZC3mdi5MDd+jm9sailE91V1B1OPy
         /0pw95QRapeWR+jYQI0/NUX/y6sQZVWjTfo6AGaCmj1EJYFE/FKVT+RTpayqbbPnw/r6
         OWQ+ZxdAwgie+T5Ebb8UPexP2umkLZVQZPXeQ=
X-Forwarded-Encrypted: i=1; AJvYcCWNWNbABXvF8yX3LxhiZmnzjXuMiOzRKvRRvZiAuGXgZ+DeiSpwKgy5mjbeMVpI48eYd57ZRz8=@vger.kernel.org
X-Received: by 2002:a17:90b:3d4b:b0:32d:d4fa:4c3 with SMTP id 98e67ed59e1d1-3342a2ef04fmr8611266a91.31.1758965587378;
        Sat, 27 Sep 2025 02:33:07 -0700 (PDT)
X-Received: by 2002:a17:90b:3d4b:b0:32d:d4fa:4c3 with SMTP id 98e67ed59e1d1-3342a2ef04fmr8611243a91.31.1758965586929;
        Sat, 27 Sep 2025 02:33:06 -0700 (PDT)
Received: from PC-MID-R740.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78105a81540sm6109940b3a.14.2025.09.27.02.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 02:33:06 -0700 (PDT)
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
Subject: [PATCH net-next v4 3/5] bnxt_en: Create an aux device for fwctl
Date: Sat, 27 Sep 2025 02:39:28 -0700
Message-Id: <20250927093930.552191-4-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250927093930.552191-1-pavan.chebbi@broadcom.com>
References: <20250927093930.552191-1-pavan.chebbi@broadcom.com>
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
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 63 ++++++++++++++++++-
 include/linux/bnxt/ulp.h                      |  1 +
 4 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index bd567f776fe8..82301fc4f53b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -16185,11 +16185,13 @@ static void bnxt_remove_one(struct pci_dev *pdev)
 		__bnxt_sriov_disable(bp);
 
 	bnxt_aux_device_del(bp, BNXT_AUXDEV_RDMA);
+	bnxt_aux_device_del(bp, BNXT_AUXDEV_FWCTL);
 
 	unregister_netdev(dev);
 	bnxt_ptp_clear(bp);
 
 	bnxt_aux_device_uninit(bp, BNXT_AUXDEV_RDMA);
+	bnxt_aux_device_uninit(bp, BNXT_AUXDEV_FWCTL);
 
 	bnxt_free_l2_filters(bp, true);
 	bnxt_free_ntp_fltrs(bp, true);
@@ -16776,6 +16778,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	bnxt_init_ring_params(bp);
 	bnxt_set_ring_params(bp);
 	bnxt_aux_device_init(bp, BNXT_AUXDEV_RDMA);
+	bnxt_aux_device_init(bp, BNXT_AUXDEV_FWCTL);
 	rc = bnxt_set_dflt_rings(bp, true);
 	if (rc) {
 		if (BNXT_VF(bp) && rc == -ENODEV) {
@@ -16840,6 +16843,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	bnxt_dl_fw_reporters_create(bp);
 
 	bnxt_aux_device_add(bp, BNXT_AUXDEV_RDMA);
+	bnxt_aux_device_add(bp, BNXT_AUXDEV_FWCTL);
 
 	bnxt_print_device_info(bp);
 
@@ -16848,6 +16852,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return 0;
 init_err_cleanup:
 	bnxt_aux_device_uninit(bp, BNXT_AUXDEV_RDMA);
+	bnxt_aux_device_uninit(bp, BNXT_AUXDEV_FWCTL);
 	bnxt_dl_unregister(bp);
 init_err_dl:
 	bnxt_shutdown_tc(bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index b3cba97bb9ea..ea1d10c50da6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2345,6 +2345,8 @@ struct bnxt {
 
 	struct bnxt_napi	**bnapi;
 
+	struct bnxt_en_dev	*edev_fwctl;
+	struct bnxt_aux_priv	*aux_priv_fwctl;
 	struct bnxt_rx_ring_info	*rx_ring;
 	struct bnxt_tx_ring_info	*tx_ring;
 	u16			*tx_ring_map;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index 8009964da698..7fe8848ac9fc 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -28,6 +28,7 @@
 #include "bnxt_hwrm.h"
 
 static DEFINE_IDA(bnxt_rdma_aux_dev_ids);
+static DEFINE_IDA(bnxt_fwctl_aux_dev_ids);
 
 struct bnxt_aux_device {
 	const char *name;
@@ -42,6 +43,7 @@ struct bnxt_aux_device {
 };
 
 static void bnxt_rdma_aux_dev_release(struct device *dev);
+static void bnxt_fwctl_aux_dev_release(struct device *dev);
 
 static void bnxt_rdma_aux_dev_set_priv(struct bnxt *bp,
 				       struct bnxt_aux_priv *priv)
@@ -70,6 +72,33 @@ static struct bnxt_en_dev *bnxt_rdma_aux_dev_get_edev(struct bnxt *bp)
 	return bp->edev_rdma;
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
 static struct bnxt_aux_device bnxt_aux_devices[__BNXT_AUXDEV_MAX] = {{
 	.name		= "rdma",
 	.type		= BNXT_AUXDEV_RDMA,
@@ -80,6 +109,16 @@ static struct bnxt_aux_device bnxt_aux_devices[__BNXT_AUXDEV_MAX] = {{
 	.set_edev       = bnxt_rdma_aux_dev_set_edev,
 	.get_edev	= bnxt_rdma_aux_dev_get_edev,
 	.get_auxdev	= bnxt_rdma_aux_dev_get_auxdev,
+}, {
+	.name		= "fwctl",
+	.type		= BNXT_AUXDEV_FWCTL,
+	.ida		= &bnxt_fwctl_aux_dev_ids,
+	.release	= bnxt_fwctl_aux_dev_release,
+	.set_priv       = bnxt_fwctl_aux_dev_set_priv,
+	.get_priv	= bnxt_fwctl_aux_dev_get_priv,
+	.set_edev       = bnxt_fwctl_aux_dev_set_edev,
+	.get_edev	= bnxt_fwctl_aux_dev_get_edev,
+	.get_auxdev	= bnxt_fwctl_aux_dev_get_auxdev,
 }};
 
 static void bnxt_fill_msix_vecs(struct bnxt *bp, struct bnxt_msix_entry *ent)
@@ -303,6 +342,8 @@ void bnxt_ulp_stop(struct bnxt *bp)
 		}
 	}
 ulp_stop_exit:
+	if (bp->edev_fwctl)
+		bp->edev_fwctl->flags |= BNXT_EN_FLAG_ULP_STOPPED;
 	mutex_unlock(&edev->en_dev_lock);
 }
 
@@ -336,6 +377,8 @@ void bnxt_ulp_start(struct bnxt *bp, int err)
 	}
 ulp_start_exit:
 	edev->flags &= ~BNXT_EN_FLAG_ULP_STOPPED;
+	if (bp->edev_fwctl)
+		bp->edev_fwctl->flags &= ~BNXT_EN_FLAG_ULP_STOPPED;
 	mutex_unlock(&edev->en_dev_lock);
 }
 
@@ -525,13 +568,27 @@ void bnxt_aux_device_add(struct bnxt *bp, enum bnxt_ulp_auxdev_type auxdev_type)
 	aux_dev = bnxt_aux_devices[auxdev_type].get_auxdev(bp);
 	rc = auxiliary_device_add(aux_dev);
 	if (rc) {
-		netdev_warn(bp->dev, "Failed to add auxiliary device for ROCE\n");
+		netdev_warn(bp->dev, "Failed to add auxiliary device for auxdev type %d\n",
+			    auxdev_type);
 		auxiliary_device_uninit(aux_dev);
 		if (bnxt_aux_devices[auxdev_type].type == BNXT_AUXDEV_RDMA)
 			bp->flags &= ~BNXT_FLAG_ROCE_CAP;
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
@@ -556,8 +613,8 @@ void bnxt_aux_device_init(struct bnxt *bp,
 
 	aux_priv->id = ida_alloc(bnxt_aux_devices[auxdev_type].ida, GFP_KERNEL);
 	if (aux_priv->id < 0) {
-		netdev_warn(bp->dev,
-			    "ida alloc failed for ROCE auxiliary device\n");
+		netdev_warn(bp->dev, "ida alloc failed for %d auxiliary device\n",
+			    auxdev_type);
 		kfree(aux_priv);
 		goto exit;
 	}
diff --git a/include/linux/bnxt/ulp.h b/include/linux/bnxt/ulp.h
index 01b7100dcf4d..b1ec40cf00fa 100644
--- a/include/linux/bnxt/ulp.h
+++ b/include/linux/bnxt/ulp.h
@@ -22,6 +22,7 @@ struct bnxt;
 
 enum bnxt_ulp_auxdev_type {
 	BNXT_AUXDEV_RDMA = 0,
+	BNXT_AUXDEV_FWCTL,
 	__BNXT_AUXDEV_MAX
 };
 
-- 
2.39.1



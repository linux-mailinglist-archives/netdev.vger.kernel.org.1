Return-Path: <netdev+bounces-225175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E774B8FB30
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 11:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F6291883CE8
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 09:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD00E283FE4;
	Mon, 22 Sep 2025 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cWTyIjn5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB99F277C9A
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 09:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758532159; cv=none; b=kG+igEx6J/XjbCwzi4xPdWyn74SGqKFjnSFhl7uvs+JdVgDw8NXL0eGgbN+wQ114hPrHjdao+JGd2cCX9Wynej7E2wFTh85kIQZ/Cc6Dtb+frgqzedTCXYG9SHaG/9c5tMyIRyAHIX8p/hbTq6cPiQwnhxhbXhMjaS+cH2BpR88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758532159; c=relaxed/simple;
	bh=P+xbXXENIRr59C9H8dmSx7rvC10vfBao+7CkpfUO3bM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cyLfosQG5Owh4H+Ej14z5Hu7Fzy2A6H91P7OzoXhSq5dcz/JXeuzVZ8HvrfvLRDtgoNv6K30W1XUfRAR/Fj/77IIA4e5z4pPNdYwNFy09iRJFGe1SwqTZVDZQM9U5SVvzadgWWQA5ucEEPf5/fz9Cyn9o9x/Mc5uiVNFUtONlFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cWTyIjn5; arc=none smtp.client-ip=209.85.222.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-84a7e1650fdso100483585a.2
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 02:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758532157; x=1759136957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sTZFfTvToc3eSrZtaGP9vkY5xr5lWepCbD04a99pHno=;
        b=c4N+abZmL95Nge1bccvVjGg06vJEL0TnpjuQ/0GNuX8+GZvjAX9osvsP9FIBHNCUgZ
         7HcRsLvfloIdXvfvq+4sfuDHpmT36ydK+8fnBKsAd32F1UvFYBrxhWyQ+Y22wu6yusO1
         9E0y8tIDLBWjy9+F8gAs/7gfBAOM08zV1igWYoH6JYkNZlJQTKM5APPTN45pc7effIH0
         T9Y7aCSH55hqLzuE/AqMd3relv8FnXnqJRVdYYpqoeJHcrb3oRMBTDslsQ4OTqDLlGWY
         nZ6N7iJptt+Wx8jwoFjJK0tDej9qexghjKDbllYrJZ2bqVmIWXglSay3Rz5oqrSSuX81
         8Mpg==
X-Forwarded-Encrypted: i=1; AJvYcCWAd2W1QSTMbztVFWIk85sVmdMb7T2JunIpEzoPn3KSgwCCGZEzsXy8/Jg8xbrNl++dfumEEDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxpW7K5/pJrjLTuU/2W7UEbhMDdQues31NwqZ+pPnig60Iy9cp
	tuDdNjgauTSm0jFfNJM0qAO1l8CFQNKjMNzn3TtyvnFhkYSyUybScOYi+DhxwJQCyfn4XrCaGwS
	SHJGWM1mkBX+oBI7kUmZENwA33F5Ryzm2KKFhAs1pcFZhxMIsHmtHwHNPkReE+H6ALOQguQP40E
	8M6PQLcTb70BhkVwmohe+k6wazVHV0cFh9IkMK89IxWO9glB1S8v+Y/ePfKWyXuzMBptDDlw4am
	JqS2YR8Sf8=
X-Gm-Gg: ASbGncvkNiRDlwsVOozmqixQWiKPPV5n0Dndt7T/Rc/mJk1QSNyJnsa6dicEbdIDctO
	QQxYNgySW7EsGSDe9xvN2fZIbAaIi+nr+4AVmODe/HXlqUY16faehebiyJBNnKgJ+3m60Kpin5r
	rEF75fFVDThPiAVCMf+oB8hGkspokQvoyLynMMCn30gfUhuYd/4JAtzKbG3o8OSUrIfQI1Eh0TG
	CT84vuPO6dhHUsB2eaXzdMha+uM6gxARJEyrS7/J2cfyJ9bU9FE+Wy8fl7B8J0uVdnfypF0KjS6
	ELCmRmUDaXSO+PcyzPAsTFP9Dfi4Kev00lOq9vcXkVWpvQVl3cRBEqzlM1NyQNg/Y56Ck12iKt4
	NPB4w/UHn9P0qxEfBf09kEJPinUO1fFaohQp1n5u+UKwPZ90eB/Jla9+yTisFtuX9znAUZqcXCU
	Xz5A==
X-Google-Smtp-Source: AGHT+IHSCrOalwDC1+Kmsa0vOHX5Q+aWhDqJcoT5li0RB2jKffsxojzwowIwbYO/pB5KnE3zLShsk/vNH9L8
X-Received: by 2002:a17:903:1b0b:b0:267:a942:788c with SMTP id d9443c01a7336-269ba3fa0afmr180378595ad.1.1758531681045;
        Mon, 22 Sep 2025 02:01:21 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2775258bec1sm1384295ad.65.2025.09.22.02.01.20
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Sep 2025 02:01:21 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24458345f5dso60403915ad.3
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 02:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758531679; x=1759136479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTZFfTvToc3eSrZtaGP9vkY5xr5lWepCbD04a99pHno=;
        b=cWTyIjn57qiY8V8OwOs5lsrHzKzbk6EvDuk62WG4bhipMqMqWjoMaTbSW+EdVZZKxN
         JLVOtgYPsheUdd8Hb5FyS6xDnhC5hk6UYoZaYdGnCPDviKUbbXmqI7qIxIFiREkE0axk
         h1faAx9dB3hudPJnF/MapwNBlAlVxozcuje+M=
X-Forwarded-Encrypted: i=1; AJvYcCXyg06BS4U9FvSkCpFzvs/Mdr63j8r8oj0jzEDInuc3P9VyNF2yAZLV9Qwc7ezH65tkGP0+tPk=@vger.kernel.org
X-Received: by 2002:a17:903:110c:b0:240:9dd8:219b with SMTP id d9443c01a7336-269ba53e4bfmr168216275ad.49.1758531678976;
        Mon, 22 Sep 2025 02:01:18 -0700 (PDT)
X-Received: by 2002:a17:903:110c:b0:240:9dd8:219b with SMTP id d9443c01a7336-269ba53e4bfmr168215405ad.49.1758531678205;
        Mon, 22 Sep 2025 02:01:18 -0700 (PDT)
Received: from PC-MID-R740.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269803416a2sm123309615ad.134.2025.09.22.02.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:01:17 -0700 (PDT)
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
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH net-next 4/6] bnxt_en: Create an aux device for fwctl
Date: Mon, 22 Sep 2025 02:08:49 -0700
Message-Id: <20250922090851.719913-5-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250922090851.719913-1-pavan.chebbi@broadcom.com>
References: <20250922090851.719913-1-pavan.chebbi@broadcom.com>
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



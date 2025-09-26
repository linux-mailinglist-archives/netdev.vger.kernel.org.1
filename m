Return-Path: <netdev+bounces-226617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12753BA304D
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 10:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E66917D633
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 08:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3F129B233;
	Fri, 26 Sep 2025 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="e8iXMM06"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD7829B200
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 08:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758876700; cv=none; b=eKELBvEn2JYzvVBm1belqpveeUkhpYXXCF+JLlScMwfZFGiv6zFqcSHX70EqQGkrREAdLOxqfv7wXNuEipnY7CVhJ4JXtmSVE82fXaC3anOzGpu0qiOnW6jJsjmjxYsoxa9JwDg+b+BiqpJ3zOT7NJBaV1oYrFLFfwNzjqmvJa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758876700; c=relaxed/simple;
	bh=UPtriqeSrnlDWa7RdZaBVb05Pgec/SzvKli+6KieM7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BPgHZNhqQIk2wau5LsU7xQ1zpWga5lsq4jH+MbgK+W4pEOVjqjKsW7MxyCpOQG65grGiYojBIqKrFSuozgRDXKNwgiD6mdgNHrodnxa0IGEXpQT+2J4b1XcYbWTPdPwTzA+DlQleb9xFaAdTsgG/joPvmUr0ufHHNQWGQjMGTEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=e8iXMM06; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-27d69771e3eso16600925ad.3
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 01:51:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758876698; x=1759481498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w6U9OAp6smC97RyM0KZjVaXlM0osQ9F79WEK/8vAOxE=;
        b=fZkfWG4ID/Cj4JiHnYAnXlAXeSKkL1LYJYR16Ca2LoaREN3aKYv3aMJUKpaEhIo1jL
         E9EH74KWOrDsgkltmpIHlwrecVQBPg7+6tCjLr6GSF4IntT1+HDrARvKLI5eymeIPViQ
         iWoFd7+orh1US7hRictccbIsxDIV4H69Z5fO+6EF3ab8CNfbDj2+FI/IuA0fri5zitvq
         cZHhofPZdK3GlD61zKmpj0YqynATjIER5Ame4cG1LTRrdCnNQW61vqzJV/KpAtGThuqm
         Oiq6H7GGK+V3MXe22XVEQyK8Y5ZgWCPZ7CjWUgcf61cL6QMepWt2WTQmKFe5pmmbAujT
         ntrA==
X-Forwarded-Encrypted: i=1; AJvYcCXpOEhwL1zhVYqUOpP92Cs++M8yVOg39UJ9AT6k4lH6P/qsVAwWSRLTgjNPPkAl1lXjCHWYQJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9lyQgTPj2+CEBdgxMN793kN/xSzI6BS5GcaVpsRnoAWeyoFXL
	NBNNh+ImOvgsEUAJRkNuXuw7Q903Hqpj9dPkt+Jd+LN2HgDvKLypIV4ENI5VD9/SSp+qv0QoYcu
	J7/UY/lEfPSkroO57Xv+DYApnBtSVuRqYdjNNlEsjtpENiO+cMm9uPa39GeDAjZTrxSm+SIpcbJ
	tGuyfI2CYvPXAK2mIJTG5+a1TmXXWydVrnC4kyyZxAGjOPED36ZugXKqbPGZaP8lASVDCtr0mQr
	fFwUzQvA0E=
X-Gm-Gg: ASbGncszNAs1zY4ldMEX63W3P8aUjY+KzDZOttlDwo8HIDpEZuGhUaMHrvJLXrVG9dl
	mng0WdCUqc63WEL2CaHKPwv8e3o4e7IMGIKoIUAfXHjoOoQ1QjxytB9UkuO7ofaLzrU2xSAkm9r
	twsGy27uvF4pW5zQ/+CUgvLOiJ6eSnMqQltMWcFtNzmkJ98dNlN1eINhacbUm5TJ2GHwIFeFf6F
	lOeW+6miFuijqEZKn0RGS1gRHSoRGu/M55g7sZun2ycCClEHQYi5rVfONwCMup/hOb0JIYUsPpo
	z84Rkjl+8tMUAaPMkcaT/2M1HfmehpoS+rBPvbDLYfD9IxeZsW5r2tTOeSfJukmvYD9bke/qqsG
	HPcdzRbq0X5BSD2LVtz4vrXWrqVlLW+uNdhlCn5UwZZSC2uQJYOEYdjB3ZV/tttU8/Lit8M1u5C
	PKQQ==
X-Google-Smtp-Source: AGHT+IHBsMVIxucyrMIBnmxygNBlVfd34U7HNf2hjeFuYpRpZ2jOpH0qcIApgcLL2qKOdam5LvFryUPrFzEZ
X-Received: by 2002:a17:903:2281:b0:266:ddd:772f with SMTP id d9443c01a7336-27ed4a06cd8mr69360805ad.9.1758876697803;
        Fri, 26 Sep 2025 01:51:37 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-27ed6816ee5sm3205205ad.61.2025.09.26.01.51.37
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Sep 2025 01:51:37 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-78104c8c8ddso1489335b3a.2
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 01:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758876696; x=1759481496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6U9OAp6smC97RyM0KZjVaXlM0osQ9F79WEK/8vAOxE=;
        b=e8iXMM06QsL67XXNJBpaZUGJ8waD5mXp2Jdowk075qeeUgiFGFpv9KiMZJIvrCJoOL
         ZHQn8FEomOJy955J+Xn3tQ2HiB34roeFa3a6heIeiHsl4hrTU7pRN5Q2sxCIV1Hnoq/t
         LbU0J4DmhE25Gd1KRpvwBIlEKAIoKEBrkAnkU=
X-Forwarded-Encrypted: i=1; AJvYcCX/eqhYkBSi61nkBvsw0a+7q8vRBWar5+ql9Nwszsw38QdTGoEHHP3+b7TmGIvhB8m7/B30IhA=@vger.kernel.org
X-Received: by 2002:a05:6a00:8c3:b0:77d:13e3:ccfa with SMTP id d2e1a72fcca58-780fcdc7ea8mr7246950b3a.4.1758876695964;
        Fri, 26 Sep 2025 01:51:35 -0700 (PDT)
X-Received: by 2002:a05:6a00:8c3:b0:77d:13e3:ccfa with SMTP id d2e1a72fcca58-780fcdc7ea8mr7246910b3a.4.1758876695319;
        Fri, 26 Sep 2025 01:51:35 -0700 (PDT)
Received: from PC-MID-R740.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c1203fsm3959896b3a.92.2025.09.26.01.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 01:51:34 -0700 (PDT)
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
Subject: [PATCH net-next v3 3/5] bnxt_en: Create an aux device for fwctl
Date: Fri, 26 Sep 2025 01:59:09 -0700
Message-Id: <20250926085911.354947-4-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250926085911.354947-1-pavan.chebbi@broadcom.com>
References: <20250926085911.354947-1-pavan.chebbi@broadcom.com>
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



Return-Path: <netdev+bounces-225164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3D1B8FAC4
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 11:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAB6718A16C0
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 09:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08427284892;
	Mon, 22 Sep 2025 09:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EawjIkHy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f100.google.com (mail-oa1-f100.google.com [209.85.160.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAF12848BC
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 09:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758531675; cv=none; b=JG/WnxSWEH6JDSuf2yZ5XHBTNKljVlEuU0MDiWQjKZlrbLw0nmY9Nn6BL1T+016lL6CCWdkp2nlkCpWp9PXQtwwZyXjrJNowapRgQ9FDyh5E08LX46D/1m0xxRpaMwYeANExDyEOuwfddtJ/1kv6PxTs2PX22Aa3i8AQCIAbTxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758531675; c=relaxed/simple;
	bh=IpYR51ndOFvlv/bMFEmfUG27BspXq8PKAr1aGXcT0U4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WQYFQa3X8bojqM3taulxD5oD32MzQuBrVy5CiE3eyHy+90moZARGJynPhrYEiWCXRu20nJt7VVsMSxbbrWIZPJqfWdRLHmWYE8/REltsAaJ8sC4W9EunhqLa86kSlGOK3iDY3HjzZ2+Fb+URZLMdHWNl/t2zYvTUixIgX63NSSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EawjIkHy; arc=none smtp.client-ip=209.85.160.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f100.google.com with SMTP id 586e51a60fabf-3316cc5ba2fso2469011fac.1
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 02:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758531672; x=1759136472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aUpTZgFhasJBvfgda9efPsDK2iofgo2kIh+Fv09uyaw=;
        b=f1iqgOvpkw9LX/Vui6gOtlYr+e+I1L/iMx3eLtaSQQ2Uj7GTC2cD+w4iRjKLEqSX8u
         sXcUq/dGTeND/YwzytXq/ftmeWTNvmqkrtbLEaDGmLDOtD76BF9QPe6qJrsVZdrRQiw3
         TpBPUnI5OOFTvQ5I5WCUsPvCXdcdfVxyzzEefKJEpqhphAeizLBc2b2ejEhNXBoj1ZvY
         D3wnmjjvaHnVKPDYmF+HPfJq/Z9JTbxzNZIb8olW13FkgbWZS8IgXXwLq114KOScexTq
         17HkFYE46QJENWWGO2tW4wGNRW8AnxX+LZWcRBebteJvBt0dAKa1aV4E9OVMOC051VxM
         GW1g==
X-Forwarded-Encrypted: i=1; AJvYcCWyLaY8c+PoLnGHEva3HJm7AdokhIwGMRor8GrtWnQR00JC46qWXLJ780A56nkZ/RJe9hG/6rk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjj6phDOKjvODWnPaTp55UKwnUagf8wdPJF+LjjSE4EbBGHrBd
	yTfFOHPIz94Jjz/wLGHA5PzaNb3aC3CVCGxbEP88QnyS9lObL5rL5MjfZDGszUqhVUyMJWneW58
	/VpvylL9ypbQDbFEyx/g1us57wbtCQg7wvJ6RCtAt4TdarcRk645Hk68iUKTIMI8ZjlyQUz+VpL
	sbnzuZoTPkWpqfdwPCDJ44xy0mEI4jVJ4BVur1SSdISJwu8irmi6RowvESRzv8hMbkQ51J7EGxx
	cD1laN+EAw=
X-Gm-Gg: ASbGncswDIsLqujSYjFFSIjLyebLAe8H2XPf+mr5XjTCdUAogGIaGMTndfIAjAZ8wHL
	7HE+nmhcEdQHcocqW/KxX7el7+HZ0DXeRJoKum1xnupTpQVJByqTp1WF5lQB9JoALNVi3OIBA7G
	xiVXm2ScXqAm2oXhOhHiM1kJdrL5T17iY4eGrrIOOie//EraTqvwOVuRdjxZY0TnEUNd/QLu8eI
	a04aQ5TginW5LdKXFkMTcbI5gTnv/hJw8WVGCwaOshTuP8lMf4FgPtx6dt7JatPkdqjGLNPSVBW
	WTfrId1LJf44ywslU3VKI58SC7966R21NO/NwRTn8jw+ZglPsg4/u+wygtj9ZfRD7BHbBnmBXNl
	pUm8XOmliwqXjxlYO8SUsepfXK97jf6QrRB5SQfyKBydQtLCUPNz+gFM+uFvGeZsDwS/Fg1Vrrr
	dgZw==
X-Google-Smtp-Source: AGHT+IFS4unFWSYc3bhfhcax5L8LHnEamOmRH/rpZKxqAA8Z2vaE2PSIb7TlMuirC9CP6k9ue8Rc4d9SAZLG
X-Received: by 2002:a05:6870:8191:b0:331:7220:f4e7 with SMTP id 586e51a60fabf-33bb62a5944mr6167027fac.33.1758531672221;
        Mon, 22 Sep 2025 02:01:12 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-336e6487e5bsm1012793fac.14.2025.09.22.02.01.11
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Sep 2025 02:01:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2698b5fbe5bso52065585ad.0
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 02:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758531671; x=1759136471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUpTZgFhasJBvfgda9efPsDK2iofgo2kIh+Fv09uyaw=;
        b=EawjIkHyxVvgDhUsxZBsEhEgm+PQSKN0L4vacFSNXvnYYE3ypQDo499pkHVOxRatFf
         /96cO8BmzWlJc1fJtdkjwldocg6jw/G/BmILS0srQ1c4qtHrAtlWNDQ4xLjDnUBJIVeU
         zShpluSBsAsnqCz8I0bYfuLsYm0+LemsPH+ag=
X-Forwarded-Encrypted: i=1; AJvYcCX2a3BooZIwXq6Xb24YIt1X7YZGffr3n/7lIXZbn7bCv1bj5Jj24L0lKBra1s/wj4LMmrhQnww=@vger.kernel.org
X-Received: by 2002:a17:903:1a0d:b0:268:db2:b78e with SMTP id d9443c01a7336-269ba593019mr141959835ad.60.1758531670487;
        Mon, 22 Sep 2025 02:01:10 -0700 (PDT)
X-Received: by 2002:a17:903:1a0d:b0:268:db2:b78e with SMTP id d9443c01a7336-269ba593019mr141959395ad.60.1758531669975;
        Mon, 22 Sep 2025 02:01:09 -0700 (PDT)
Received: from PC-MID-R740.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269803416a2sm123309615ad.134.2025.09.22.02.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:01:09 -0700 (PDT)
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
Subject: [PATCH net-next 3/6] bnxt_en: Make a lookup table for supported aux bus devices
Date: Mon, 22 Sep 2025 02:08:48 -0700
Message-Id: <20250922090851.719913-4-pavan.chebbi@broadcom.com>
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

We could maintain a look up table of aux bus devices supported
by bnxt. This way, the aux bus init/add/uninit/del could have
generic code to work on any of bnxt's aux devices.

Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 105 ++++++++++++++++--
 1 file changed, 93 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index 665850753f90..ecad1947ccb5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -29,6 +29,70 @@
 
 static DEFINE_IDA(bnxt_rdma_aux_dev_ids);
 
+struct bnxt_aux_device {
+	const char *name;
+	const u32 id;
+	u32 (*alloc_ida)(void);
+	void (*free_ida)(struct bnxt_aux_priv *priv);
+	void (*release)(struct device *dev);
+	void (*set_priv)(struct bnxt *bp, struct bnxt_aux_priv *priv);
+	struct bnxt_aux_priv *(*get_priv)(struct bnxt *bp);
+	void (*set_edev)(struct bnxt *bp, struct bnxt_en_dev *edev);
+	struct bnxt_en_dev *(*get_edev)(struct bnxt *bp);
+	struct auxiliary_device *(*get_auxdev)(struct bnxt *bp);
+};
+
+static void bnxt_rdma_aux_dev_release(struct device *dev);
+
+static void bnxt_rdma_aux_dev_set_priv(struct bnxt *bp,
+				       struct bnxt_aux_priv *priv)
+{
+	bp->aux_priv_rdma = priv;
+}
+
+static struct bnxt_aux_priv *bnxt_rdma_aux_dev_get_priv(struct bnxt *bp)
+{
+	return bp->aux_priv_rdma;
+}
+
+static struct auxiliary_device *bnxt_rdma_aux_dev_get_auxdev(struct bnxt *bp)
+{
+	return &bp->aux_priv_rdma->aux_dev;
+}
+
+static void bnxt_rdma_aux_dev_set_edev(struct bnxt *bp,
+				       struct bnxt_en_dev *edev)
+{
+	bp->edev_rdma = edev;
+}
+
+static struct bnxt_en_dev *bnxt_rdma_aux_dev_get_edev(struct bnxt *bp)
+{
+	return bp->edev_rdma;
+}
+
+static u32 bnxt_rdma_aux_dev_alloc_ida(void)
+{
+	return ida_alloc(&bnxt_rdma_aux_dev_ids, GFP_KERNEL);
+}
+
+static void bnxt_rdma_aux_dev_free_ida(struct bnxt_aux_priv *aux_priv)
+{
+	ida_free(&bnxt_rdma_aux_dev_ids, aux_priv->id);
+}
+
+static struct bnxt_aux_device bnxt_aux_devices[__BNXT_AUXDEV_MAX] = {{
+	.name		= "rdma",
+	.alloc_ida	= bnxt_rdma_aux_dev_alloc_ida,
+	.free_ida	= bnxt_rdma_aux_dev_free_ida,
+	.release	= bnxt_rdma_aux_dev_release,
+	.set_priv       = bnxt_rdma_aux_dev_set_priv,
+	.get_priv	= bnxt_rdma_aux_dev_get_priv,
+	.set_edev       = bnxt_rdma_aux_dev_set_edev,
+	.get_edev	= bnxt_rdma_aux_dev_get_edev,
+	.get_auxdev	= bnxt_rdma_aux_dev_get_auxdev,
+}};
+
 static void bnxt_fill_msix_vecs(struct bnxt *bp, struct bnxt_msix_entry *ent)
 {
 	struct bnxt_en_dev *edev = bp->edev_rdma;
@@ -391,11 +455,15 @@ void bnxt_aux_device_uninit(struct bnxt *bp,
 	struct bnxt_aux_priv *aux_priv;
 	struct auxiliary_device *adev;
 
+	if (auxdev_type >= __BNXT_AUXDEV_MAX) {
+		netdev_warn(bp->dev, "Failed to uninit: unrecognized auxiliary device\n");
+		return;
+	}
 	/* Skip if no auxiliary device init was done. */
-	if (!bp->aux_priv_rdma)
+	if (!bnxt_aux_devices[auxdev_type].get_priv(bp))
 		return;
 
-	aux_priv = bp->aux_priv_rdma;
+	aux_priv = bnxt_aux_devices[auxdev_type].get_priv(bp);
 	adev = &aux_priv->aux_dev;
 	auxiliary_device_uninit(adev);
 }
@@ -416,10 +484,14 @@ static void bnxt_rdma_aux_dev_release(struct device *dev)
 
 void bnxt_aux_device_del(struct bnxt *bp, enum bnxt_ulp_auxdev_type auxdev_type)
 {
-	if (!bp->edev_rdma)
+	if (auxdev_type >= __BNXT_AUXDEV_MAX) {
+		netdev_warn(bp->dev, "Failed to del: unrecognized auxiliary device\n");
+		return;
+	}
+	if (!bnxt_aux_devices[auxdev_type].get_edev(bp))
 		return;
 
-	auxiliary_device_delete(&bp->aux_priv_rdma->aux_dev);
+	auxiliary_device_delete(bnxt_aux_devices[auxdev_type].get_auxdev(bp));
 }
 
 static void bnxt_set_edev_info(struct bnxt_en_dev *edev, struct bnxt *bp)
@@ -454,10 +526,14 @@ void bnxt_aux_device_add(struct bnxt *bp, enum bnxt_ulp_auxdev_type auxdev_type)
 	struct auxiliary_device *aux_dev;
 	int rc;
 
-	if (!bp->edev_rdma)
+	if (auxdev_type >= __BNXT_AUXDEV_MAX) {
+		netdev_warn(bp->dev, "Failed to add: unrecognized auxiliary device\n");
+		return;
+	}
+	if (!bnxt_aux_devices[auxdev_type].get_edev(bp))
 		return;
 
-	aux_dev = &bp->aux_priv_rdma->aux_dev;
+	aux_dev = bnxt_aux_devices[auxdev_type].get_auxdev(bp);
 	rc = auxiliary_device_add(aux_dev);
 	if (rc) {
 		netdev_warn(bp->dev, "Failed to add auxiliary device for ROCE\n");
@@ -475,6 +551,11 @@ void bnxt_aux_device_init(struct bnxt *bp,
 	struct bnxt_ulp *ulp;
 	int rc;
 
+	if (auxdev_type >= __BNXT_AUXDEV_MAX) {
+		netdev_warn(bp->dev, "Failed to init: unrecognized auxiliary device\n");
+		return;
+	}
+
 	if (auxdev_type == BNXT_AUXDEV_RDMA &&
 	    !(bp->flags & BNXT_FLAG_ROCE_CAP))
 		return;
@@ -483,7 +564,7 @@ void bnxt_aux_device_init(struct bnxt *bp,
 	if (!aux_priv)
 		goto exit;
 
-	aux_priv->id = ida_alloc(&bnxt_rdma_aux_dev_ids, GFP_KERNEL);
+	aux_priv->id = bnxt_aux_devices[auxdev_type].alloc_ida();
 	if (aux_priv->id < 0) {
 		netdev_warn(bp->dev,
 			    "ida alloc failed for ROCE auxiliary device\n");
@@ -493,17 +574,17 @@ void bnxt_aux_device_init(struct bnxt *bp,
 
 	aux_dev = &aux_priv->aux_dev;
 	aux_dev->id = aux_priv->id;
-	aux_dev->name = "rdma";
+	aux_dev->name = bnxt_aux_devices[auxdev_type].name;
 	aux_dev->dev.parent = &bp->pdev->dev;
-	aux_dev->dev.release = bnxt_rdma_aux_dev_release;
+	aux_dev->dev.release = bnxt_aux_devices[auxdev_type].release;
 
 	rc = auxiliary_device_init(aux_dev);
 	if (rc) {
-		ida_free(&bnxt_rdma_aux_dev_ids, aux_priv->id);
+		bnxt_aux_devices[auxdev_type].free_ida(aux_priv);
 		kfree(aux_priv);
 		goto exit;
 	}
-	bp->aux_priv_rdma = aux_priv;
+	bnxt_aux_devices[auxdev_type].set_priv(bp, aux_priv);
 
 	/* From this point, all cleanup will happen via the .release callback &
 	 * any error unwinding will need to include a call to
@@ -520,7 +601,7 @@ void bnxt_aux_device_init(struct bnxt *bp,
 		goto aux_dev_uninit;
 
 	edev->ulp_tbl = ulp;
-	bp->edev_rdma = edev;
+	bnxt_aux_devices[auxdev_type].set_edev(bp, edev);
 	bnxt_set_edev_info(edev, bp);
 	if (auxdev_type == BNXT_AUXDEV_RDMA)
 		bp->ulp_num_msix_want = bnxt_set_dflt_ulp_msix(bp);
-- 
2.39.1



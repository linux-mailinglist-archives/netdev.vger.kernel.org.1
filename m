Return-Path: <netdev+bounces-225550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDEDB95520
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 11:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D70E52E1F59
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 09:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D315C3203AA;
	Tue, 23 Sep 2025 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="X7e/6tHj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f226.google.com (mail-il1-f226.google.com [209.85.166.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A64F3191B4
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 09:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758621003; cv=none; b=n6KwQDgWOIGqSKpVi9icojcQfR/TtnogSJR+kvXLuzu5ID85mG8VSHCHbR2YI2v2j1nnvjNV3GzePnPoFgrsph6cLa5rX4+7zPhj2xJmUzJhReK42dBNp9Y2oRquyEjtcUrTytlLqSKt2qLKUih0Hd5yc71YCdhqcDz1Y9c1Cqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758621003; c=relaxed/simple;
	bh=IpYR51ndOFvlv/bMFEmfUG27BspXq8PKAr1aGXcT0U4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aSEDvKYqDjCMDf0/VEs9cHfe2z6quhiW6Ig3TUIkfqk6nlx9OyGvTzo0QqgHrFbpGPOL2FJBcIHgSHm1YQj99fJKwQocV+jmvq70FD74IKQ76hjuT+FPzoUXKH078vI5gVDFN8jmeQ81m1YQAPx7UjNKQGRplRezjNq562p/2pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=X7e/6tHj; arc=none smtp.client-ip=209.85.166.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f226.google.com with SMTP id e9e14a558f8ab-42480cb42e9so22403545ab.0
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 02:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758621000; x=1759225800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aUpTZgFhasJBvfgda9efPsDK2iofgo2kIh+Fv09uyaw=;
        b=Jc+AhqFBXJg/PN6kMDAA00KX2EYEwmmWe9KoyspdqzQiaatKufB9bh4HsYqrlcAh1k
         Lufu4WCQ4iFk+A/hVsV/S2BY160X7RdAoFQHUr7w855aLpQltBJ5P+xo7fLTjJjU5W2h
         OEAXWzr28xLql8Lxo+d3FxviJX0cxbNacktuwE5kdWit0rzXI3r4RRMd4mPdmxEJVWqu
         gUxsb7SJwGh4sZABTd7mdptFYrDPtwCI9XbCVeCq7MWoT1I+iJXsfbhEj4IjgJ7Xq09y
         HjXYl7eAOS2lc515rY9avxTdE1dsghhCZRkPYnc+FqxHOmMTwPCUA7gqouVydokyAkmT
         zi+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8az/XpUR4AOhGGJepY5ZEbFL2oV1c/fKlPDNmcXJE4pf/tD5Y4spcskpQoQueRFwHvo9aZYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBc2HaWvTcQV3BPZGk3qRnuz/hP69a5TU+mNVJ0IocF18++Dbb
	6/d7KYo4Y6ZTjoZWsZTIRBRx0kuK5hE4TwlrNhB4kYSvAqKPrcfp+boMXuAGORyecdocbU80N5Z
	cbMZyimhpoWJ/kjgxFNlGh09E/WUmzAlQJJmgEJkglLQe04FXcC637vAzTmRu595ZbUbJ8KfxuV
	EGhipCk4XTAHBx8mpxlLb0bCjCoX+C7Fs2r+cpqNodhrdNuY1jrFaPayYZ8jBWfsWkFy4bxSECH
	C+yxq5aSz8=
X-Gm-Gg: ASbGncv1fOQwj+FGfPi4WBxVL96yKZbIrMYqfLz6Qkyn5aZvNKFNesnM1JX/pfLQdgn
	uJSyKndNqLbwzolNcb0On/kk5rrz+X0GHVyq/QhgojwNHRPFPZatnOZt18A1YzQ/Fc3UlCMtqmT
	v5SDS6Bd76J/kaoySOsVf8sJHm/PCgtDacqZ8EEa/vzJrWXun3gQRykDQ7qPdss0aaZteVVRGms
	WulDrQqmc30gqyP8e3WYXkS8B0YPINnuiYiMxKFJN3T5yADwjJcJSBo7H4VaAhIQYz1Dq4tZVF2
	xNDHDc1eEOU0G98paJHd/zLg1I7q5KCmO5rZo30jLAdSp+uTPiCeisWtif6iKcwkgCvA6RljFbO
	47IR+Nmw1p5zNHT2QJhJND2Hvlt0bBEFz/vvr6FLIki3NEQJZpJBwv9HZOHXqWE0tmOHB4FxZpp
	A=
X-Google-Smtp-Source: AGHT+IE+G8+ex6APxiPXE55nIiatFBh6l4nbplvFvujZ6CTNyZONpg1pqu+Pu/c7Ns9H9cvB+kxJX8AwIg99
X-Received: by 2002:a05:6e02:380d:b0:424:8d44:a267 with SMTP id e9e14a558f8ab-42581eac095mr32893805ab.29.1758621000168;
        Tue, 23 Sep 2025 02:50:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-4244a369a9dsm9568175ab.8.2025.09.23.02.49.59
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Sep 2025 02:50:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4f87c691a7so9045022a12.3
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 02:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758620999; x=1759225799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUpTZgFhasJBvfgda9efPsDK2iofgo2kIh+Fv09uyaw=;
        b=X7e/6tHjUQFvo/JCYfWagj9t1a/VqWjtUnJGUtuORo4CnpcCHpV7vIsY8PtJflshEv
         EmFQQeC9Uhuu0y4D4dRcQjx3rdfZPrnV6ihgVelsyubs4YzkjJja6NUxFAFzWQY0laHz
         z2I+TgK5WKc0itzI1kq4M/FYheGgmyPF+ha1E=
X-Forwarded-Encrypted: i=1; AJvYcCWFB0rA/BzBFS4E5iPAe0yQqHiHeyygUUABfhpIt6oURgMtgBZNLXQjeA6E4CQZ+H90sY8vudM=@vger.kernel.org
X-Received: by 2002:a17:903:32d0:b0:26b:da03:60db with SMTP id d9443c01a7336-27cc185330cmr31261465ad.13.1758620998610;
        Tue, 23 Sep 2025 02:49:58 -0700 (PDT)
X-Received: by 2002:a17:903:32d0:b0:26b:da03:60db with SMTP id d9443c01a7336-27cc185330cmr31261205ad.13.1758620998179;
        Tue, 23 Sep 2025 02:49:58 -0700 (PDT)
Received: from PC-MID-R740.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269a75d63eesm139105945ad.100.2025.09.23.02.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 02:49:57 -0700 (PDT)
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
Subject: [PATCH net-next v2 3/6] bnxt_en: Make a lookup table for supported aux bus devices
Date: Tue, 23 Sep 2025 02:58:22 -0700
Message-Id: <20250923095825.901529-4-pavan.chebbi@broadcom.com>
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



Return-Path: <netdev+bounces-229089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81139BD817A
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 10:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE76919229DD
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 08:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F8A30F811;
	Tue, 14 Oct 2025 08:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GoKU8EZ3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB66330F7E2
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 08:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760429065; cv=none; b=G36OhOUWQLEisrCnCCSMdmQSboLttui4bK9MWwEkPXv8HXMEaW2E1bZ18i2zNnNkQTGMHZU2iv+UeKaqinjJ1Q9xcKzoWcuABOusaXM6bHqt1mPsIoTCpEOIOBvL9Qy2krUd2Q5lbAVH0m9zJySCAkWlUKcugZiPL4rvbgTB9Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760429065; c=relaxed/simple;
	bh=4kqotZA/5XHTwCo9LejUeDdFpqQekmIrNmmduaRBvpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TrnfjKwaNVuMo+oFt0UAFnxpQHQ23XVP/HW1ueAYbffE54Tx+opwWMBRz0HJYQ0zpWlzChVMb94opgonNwM+jJocFxaaP5DQhiDBcX53PT94xrpk7KBrF+6NCnL8TeGn5Wdoby1+ZUK6bKL8xsyakHbfi3YjcMQmuu2jHq9EC8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GoKU8EZ3; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-879b99b7ca8so75709596d6.0
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 01:04:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760429062; x=1761033862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hS9hleGg82SHts/IRwNKh15o89yTVU/34opgBNd3XI8=;
        b=pOwgGRdPNKJvfztjOabZDv7GyFpScqPtmBqEH9vt3RUCMJEMqiIdKULqTgC02t5tD2
         rgpFKWly4O4qDG6jXW7KwpE7R9ZaCM2sanQ+PVz64X5FBY4al15Qrt1hEt79WA24pj8u
         6yDk+vlZ8VX182zqrN2XiZitmq2lhd1rMdTihUlHgZyfAMnlW/yk+2VOMt9MnltekWmF
         bJ/S++Ac+ZCScFcAZYVrJuYNvkLc/8Eqz9dUTNZbGUucyRBGt82JDtYY87uwk7s5/mMH
         KUnULmtaQs+yapBETT+ljkp9ByltxMWTIBCuHeO/BC2SxK31KHez3NoIKEQMj7W4F4Rk
         lXzQ==
X-Forwarded-Encrypted: i=1; AJvYcCViGKa+8aJkLdlkwJjgWyPnvLneL6VdkChOtd1KaJnbgN9vOD4zvP+p0e93d5/kmO3VqwnSKWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSibmzeVwQ/3dzklWHcMjRxnUqHuVHo9A6141FmM+QSnqKKDzs
	JCx7J/u/u7EORnnsGa151STUmy9J/pkoEWZLK/r683DxL8ZtH8YBXQZHfM7M2znULqyBX5sK3au
	nI9+ygFCJgtJ+6x9oxgsp6GTDL6w883U63JBqH6reFLLGaQDZST0vybL/sY3K+0ggq618CjmxP/
	/BYrspLFW7KMGdJ4j/FYQjFjxwZc9E/9ReKSPqeonEpBvH8e7BVw37J5UnZkoESndsRTUcoft8k
	lXkj8Uhimnsog==
X-Gm-Gg: ASbGncueJcnT03L5aNe/MUNg6iECLD8r82aIcpQo2Bzy6irmnayX8WNycpNo13I931v
	HksHKFO4FB4AFhjy+PTgZhe94qg4mne1KhU7ErBuXJDEqVslfff7UhIimI0WgxSRrHyCK19ZwF6
	kP8znIN6H1jnNnKFsY4Dp+E0lu81wMYbZKKc1EDcLq0f7rcmS4A1N/TiNGkuzdgCfL9jyUoIYcn
	zefTXLuCOMbypGbj091nNzEHGDmNM4aFH2ooewbo8aZXjv22iiGKGFi3N+cgdh+DoK0G1CDE2U/
	o3/geO7TSsTvs7WywVdwHEjwmXHSnqQfz4+QkHhqlGKTSdZ+554miXtvzdfasbK8319SPwzzv4n
	P7QNrjiL1guQwwzMnqLSc853IrAqxe5KodiVZeRWvSGKrIw/YMmNLysvI3cVBVgguFJt1GX1/El
	JV0w==
X-Google-Smtp-Source: AGHT+IHm553sAhSC3t+MREstwmAQ3OM69kaBY9jgMOBcsGq0uprdZeszHoF4BO6nK1kqafmWm3IA8Bf5JMC5
X-Received: by 2002:a05:6214:da2:b0:767:cad6:42a6 with SMTP id 6a1803df08f44-87b2103c706mr278479046d6.6.1760429062221;
        Tue, 14 Oct 2025 01:04:22 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-87bc3513e60sm9966446d6.21.2025.10.14.01.04.21
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Oct 2025 01:04:22 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-781269a9049so14678512b3a.2
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 01:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760429061; x=1761033861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hS9hleGg82SHts/IRwNKh15o89yTVU/34opgBNd3XI8=;
        b=GoKU8EZ3kS6WR1ktRHqvUbZUlgvFessWnmGfOIAL1cxNcOUvKIIcnurdtb7icALsUj
         fdVDiv2gckIM23Z6qu0Gmzbp+k97jwjRAbdwbMnV8FVgRrTv7znb/zVRqgFM1lRP5EuQ
         eA2VuIH485j6gHto0t98BrIsng8NeJMQE7Y8s=
X-Forwarded-Encrypted: i=1; AJvYcCXCXcmHnl3xaaqpfAMt/tBRcYGj4PFHpJwrQO0piJziD+19LB+NLzh1kokJaGaFr2ThUVomOxE=@vger.kernel.org
X-Received: by 2002:a05:6a00:3be7:b0:79a:8a6d:c082 with SMTP id d2e1a72fcca58-79a8a6dc29dmr9064818b3a.23.1760429060607;
        Tue, 14 Oct 2025 01:04:20 -0700 (PDT)
X-Received: by 2002:a05:6a00:3be7:b0:79a:8a6d:c082 with SMTP id d2e1a72fcca58-79a8a6dc29dmr9064795b3a.23.1760429060218;
        Tue, 14 Oct 2025 01:04:20 -0700 (PDT)
Received: from PC-MID-R740.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-799283c1a14sm14329716b3a.0.2025.10.14.01.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 01:04:19 -0700 (PDT)
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
Subject: [PATCH net-next v5 3/5] bnxt_en: Create an aux device for fwctl
Date: Tue, 14 Oct 2025 01:10:31 -0700
Message-Id: <20251014081033.1175053-4-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20251014081033.1175053-1-pavan.chebbi@broadcom.com>
References: <20251014081033.1175053-1-pavan.chebbi@broadcom.com>
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
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  8 +++++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 12 ++++++++++--
 include/linux/bnxt/ulp.h                      |  1 +
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index dcbb321cee3a..5244deb15ecc 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -16188,11 +16188,13 @@ static void bnxt_remove_one(struct pci_dev *pdev)
 		__bnxt_sriov_disable(bp);
 
 	bnxt_aux_device_del(bp, BNXT_AUXDEV_RDMA);
+	bnxt_aux_device_del(bp, BNXT_AUXDEV_FWCTL);
 
 	unregister_netdev(dev);
 	bnxt_ptp_clear(bp);
 
 	bnxt_aux_device_uninit(bp, BNXT_AUXDEV_RDMA);
+	bnxt_aux_device_uninit(bp, BNXT_AUXDEV_FWCTL);
 	bnxt_auxdev_id_free(bp, bp->auxdev_id);
 
 	bnxt_free_l2_filters(bp, true);
@@ -16779,8 +16781,10 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	bnxt_set_tpa_flags(bp);
 	bnxt_init_ring_params(bp);
 	bnxt_set_ring_params(bp);
-	if (!bnxt_auxdev_id_alloc(bp))
+	if (!bnxt_auxdev_id_alloc(bp)) {
 		bnxt_aux_device_init(bp, BNXT_AUXDEV_RDMA);
+		bnxt_aux_device_init(bp, BNXT_AUXDEV_FWCTL);
+	}
 	rc = bnxt_set_dflt_rings(bp, true);
 	if (rc) {
 		if (BNXT_VF(bp) && rc == -ENODEV) {
@@ -16845,6 +16849,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	bnxt_dl_fw_reporters_create(bp);
 
 	bnxt_aux_device_add(bp, BNXT_AUXDEV_RDMA);
+	bnxt_aux_device_add(bp, BNXT_AUXDEV_FWCTL);
 
 	bnxt_print_device_info(bp);
 
@@ -16853,6 +16858,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return 0;
 init_err_cleanup:
 	bnxt_aux_device_uninit(bp, BNXT_AUXDEV_RDMA);
+	bnxt_aux_device_uninit(bp, BNXT_AUXDEV_FWCTL);
 	bnxt_auxdev_id_free(bp, bp->auxdev_id);
 	bnxt_dl_unregister(bp);
 init_err_dl:
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index e15cf4774e9b..2e06cf5e3604 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -35,6 +35,8 @@ struct bnxt_aux_device {
 
 static struct bnxt_aux_device bnxt_aux_devices[__BNXT_AUXDEV_MAX] = {{
 	.name		= "rdma",
+}, {
+	.name		= "fwctl",
 }};
 
 static void bnxt_fill_msix_vecs(struct bnxt *bp, struct bnxt_msix_entry *ent)
@@ -262,6 +264,11 @@ void bnxt_ulp_stop(struct bnxt *bp)
 			continue;
 
 		mutex_lock(&edev->en_dev_lock);
+		if (i == BNXT_AUXDEV_FWCTL) {
+			edev->flags |= BNXT_EN_FLAG_ULP_STOPPED;
+			mutex_unlock(&edev->en_dev_lock);
+			continue;
+		}
 		if (!bnxt_ulp_registered(edev) ||
 		    (edev->flags & BNXT_EN_FLAG_ULP_STOPPED)) {
 			mutex_unlock(&edev->en_dev_lock);
@@ -298,7 +305,7 @@ void bnxt_ulp_start(struct bnxt *bp, int err)
 			return;
 
 		mutex_lock(&edev->en_dev_lock);
-		if (!bnxt_ulp_registered(edev) ||
+		if (i == BNXT_AUXDEV_FWCTL || !bnxt_ulp_registered(edev) ||
 		    !(edev->flags & BNXT_EN_FLAG_ULP_STOPPED)) {
 			goto clear_flag_continue;
 		}
@@ -496,7 +503,8 @@ void bnxt_aux_device_add(struct bnxt *bp, enum bnxt_auxdev_type idx)
 	aux_dev = &bp->aux_priv[idx]->aux_dev;
 	rc = auxiliary_device_add(aux_dev);
 	if (rc) {
-		netdev_warn(bp->dev, "Failed to add auxiliary device for ROCE\n");
+		netdev_warn(bp->dev, "Failed to add auxiliary device for auxdev type %d\n",
+			    idx);
 		auxiliary_device_uninit(aux_dev);
 		if (idx == BNXT_AUXDEV_RDMA)
 			bp->flags &= ~BNXT_FLAG_ROCE_CAP;
diff --git a/include/linux/bnxt/ulp.h b/include/linux/bnxt/ulp.h
index 99cd872f6605..3cd9d128e5d1 100644
--- a/include/linux/bnxt/ulp.h
+++ b/include/linux/bnxt/ulp.h
@@ -24,6 +24,7 @@ struct bnxt;
 
 enum bnxt_auxdev_type {
 	BNXT_AUXDEV_RDMA = 0,
+	BNXT_AUXDEV_FWCTL,
 	__BNXT_AUXDEV_MAX
 };
 
-- 
2.39.1



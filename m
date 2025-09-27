Return-Path: <netdev+bounces-226878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6274BA5C71
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 11:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 543E0323520
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 09:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33382D59E8;
	Sat, 27 Sep 2025 09:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PgKmKQ6I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F19A2D46CE
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 09:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758965586; cv=none; b=tUUdZxFoLwZwk4TA9F8zLu5koy/0q+vNRh5CVuVQXODQkX741lCJkqz0TAxzbLSiNKjzgUafwgZa2cguKdvaPrW7dTLdK5gGPzFCOMdpVI2Tz1i1krU4ey9BY0ZswzfAxYgWr57oeNowcfM+px+cnk9X2N8vn0Dv8ATdtHmIkBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758965586; c=relaxed/simple;
	bh=O8dXVJkFsCt/u3Hj6qzoq8KrnkROLg38eyVjin1X2T4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RUksVTHv+T5eacmx0bXdLOxMux7ZYpQjZGC5J0feAeIQi1BNUoIyGpfkcXOm4qFdX+RRAMYtS7K6aQFaUDfS6FqYfo3aImHnMasibpZWil6FK8EFHmPbu8x81jUj23UdJ43EbSMzJfaFOxGkdVMxGI8RPbci660x2Th1CsoPSwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PgKmKQ6I; arc=none smtp.client-ip=209.85.215.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-b54a74f9150so2686267a12.0
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 02:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758965584; x=1759570384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wuYpLycitYADVAx0izS9/YZkIIfoL79uVHFrEhI6IGo=;
        b=wItM0scjiGJookPLZqwsYMxzzzWW4sBaLQLCZ5axsEOYhC88vZeYqUVbjXGk6iW1OH
         H0NkY9RDUZTziEp9L2FEG15PAjL0EDoVBSUU9+xDBdl240B8DrlrAjwTtrIewOfHPvSF
         /I4dbmuHR4hyjSAjhiGGNxyzW7VIuy7Gi9TPsGtTeQgMPclqFoK3qYpl/7Fh5P16qQEx
         QfSd46/CDq6IgtrRlFIz895S8hV7CJYb+j8nuNQPkdLqIfa4MreVrsl/AVeHCA0vZ0/J
         fiPMPvbRZbqSZHlHYHb2XBp7LT3yhFvH81YrZugkXDkTAp5N/Ppw4Ke7dyt0pitQK+I/
         K6tg==
X-Forwarded-Encrypted: i=1; AJvYcCV0G2SOccM4Aeuz9FoSIssxnhkghhiYeBrXPy3o/Btmjlfkk/BqZPfmUFlOfRWMDUreF+3wjc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuKJzEIe3Bg8cndv0FJa9/qkxK+X+ZdCnNtM4u/uyKkRiJ8IY1
	7hn6OV1813uX65rgJCv/YCuS/EPI8/HMpmFb77zOPsIDS4OqPwEFMtkeIIDwGwZlxquohbJFECW
	6fauG8V9GGX4zWhxP0r1U/wcDpL/3+xpMFYmqH8OdJPc0art+uzXUfZkxp/zGnvM3zw5i3wz0/8
	CSJ5fvm1IoUJ3dyWxADp/CGQQGe31HZ9UqohTopgytcKQXVZju/tawPoTn2omdtnHedoOsUFbQN
	dVTe5FoPmJbnQ==
X-Gm-Gg: ASbGncu7dHr4rQt+puIgouW6LBgJtgY8uv8FOQmSNouP2v9wEsVJQJ+ginLUc0GCGNe
	svujGlLqhw6ClJtyXPmeTgcxA9sa2al0h8vi5oTEEGMvP0kHL9KS7GGeY1BJ9p59m56JqaPM46a
	pAX9FEfKno+29Oa3U8fyTWcS9r9JgzZVu3aLe3eR/YK0Y9U9t/tn7Vw+7wvVCVjudhwhy3m7cas
	l+u8xekhfntowXKyZKKQRlBHj74EfmlBvOljW82o3o6EbLgY9otkLsXD8kTSEixCO2xY1RaoAAz
	+koMz4+HZ+jik8ZyEl+Tb4tzRhlJ9vBHbozar8HcriLiyCHtcNCTDJPWUSzglv4ayfS+dSWQUWb
	IeRkHuxqAcJMfOc3VUOU7oURIg83it8GyGOwKo9vNPnY99A6K9Y+bRIZ9s09wMyRmLT54DW7eem
	aRZQ==
X-Google-Smtp-Source: AGHT+IHpyXcQ7Zw9iL25XCAbeFmBx5Tz1QTnnApMQ7ygP5Wf4fh0Jz+NDPN4kmkXqmFRSC9eBV6fkw1+v4+4
X-Received: by 2002:a17:902:cccf:b0:27e:ef96:c153 with SMTP id d9443c01a7336-27eef96c3acmr58322785ad.19.1758965583639;
        Sat, 27 Sep 2025 02:33:03 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-27ed67e6795sm5376545ad.36.2025.09.27.02.33.03
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Sep 2025 02:33:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-78105c10afdso2641943b3a.1
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 02:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758965582; x=1759570382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuYpLycitYADVAx0izS9/YZkIIfoL79uVHFrEhI6IGo=;
        b=PgKmKQ6Iy0JKMsi6XlB/0AZYY6L2BLz3E/yRSzTGR0S5SufTqvn8JOJdDKL0kihiQS
         1mU55Qk816DJNe9FoJxuSkCnKKk0kPw4msUD/EqlpY6vJPtq0ajJo8ijj3ORJexHX6Sx
         FnHs13cR+ma8ybEsa81iVNf0KWRVprTuY/iBY=
X-Forwarded-Encrypted: i=1; AJvYcCVfwR+Fn01G6QMqTXsk+z2jDMLfkVcPkrzdue+zqfqZSwHmXQCjDiFHc4Zo8+F8n3BsGcqvQng=@vger.kernel.org
X-Received: by 2002:a05:6a00:10c5:b0:781:1cc0:d0ce with SMTP id d2e1a72fcca58-7811cc0d324mr3739839b3a.16.1758965581522;
        Sat, 27 Sep 2025 02:33:01 -0700 (PDT)
X-Received: by 2002:a05:6a00:10c5:b0:781:1cc0:d0ce with SMTP id d2e1a72fcca58-7811cc0d324mr3739819b3a.16.1758965581072;
        Sat, 27 Sep 2025 02:33:01 -0700 (PDT)
Received: from PC-MID-R740.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78105a81540sm6109940b3a.14.2025.09.27.02.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 02:33:00 -0700 (PDT)
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
Subject: [PATCH net-next v4 2/5] bnxt_en: Refactor aux bus functions to be more generic
Date: Sat, 27 Sep 2025 02:39:27 -0700
Message-Id: <20250927093930.552191-3-pavan.chebbi@broadcom.com>
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

Up until now there was only one auxiliary device that bnxt
created and that was for RoCE driver. bnxt fwctl is also
going to use an aux bus device that bnxt should create.
This requires some nomenclature changes and refactoring of
the existing bnxt aux dev functions.

We could maintain a look up table of supported aux bus devices
so that we can fetch the aux device info by calling the table's
functions. This way, the aux bus init/add/uninit/del could have
generic code to work on any of bnxt's aux devices.

Make aux bus init/uninit/add/del functions more generic which
will accept aux device type as a parameter. Change the existing
'aux_dev_ids' to 'aux_dev_rdma_ids' to mean it is for RoCE driver.

Also rename the 'aux_priv' and 'edev' members of struct bp to
'aux_priv_rdma' and 'edev_rdma' respectively, to mean they belong
to rdma.
Rename bnxt_aux_device_release() as bnxt_rdma_aux_device_release()

Future patches will reuse these functions to add an aux bus device
for fwctl.

Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  23 +--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   4 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 180 +++++++++++++-----
 include/linux/bnxt/ulp.h                      |  13 +-
 5 files changed, 152 insertions(+), 70 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 785a6146b968..bd567f776fe8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6848,7 +6848,8 @@ int bnxt_hwrm_vnic_cfg(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 #endif
 	if ((bp->flags & BNXT_FLAG_STRIP_VLAN) || def_vlan)
 		req->flags |= cpu_to_le32(VNIC_CFG_REQ_FLAGS_VLAN_STRIP_MODE);
-	if (vnic->vnic_id == BNXT_VNIC_DEFAULT && bnxt_ulp_registered(bp->edev))
+	if (vnic->vnic_id == BNXT_VNIC_DEFAULT &&
+	    bnxt_ulp_registered(bp->edev_rdma))
 		req->flags |= cpu_to_le32(bnxt_get_roce_vnic_mode(bp));
 
 	return hwrm_req_send(bp, req);
@@ -7973,7 +7974,7 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 	if (!bnxt_need_reserve_rings(bp))
 		return 0;
 
-	if (BNXT_NEW_RM(bp) && !bnxt_ulp_registered(bp->edev)) {
+	if (BNXT_NEW_RM(bp) && !bnxt_ulp_registered(bp->edev_rdma)) {
 		ulp_msix = bnxt_get_avail_msix(bp, bp->ulp_num_msix_want);
 		if (!ulp_msix)
 			bnxt_set_ulp_stat_ctxs(bp, 0);
@@ -8024,7 +8025,7 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 	}
 	rx_rings = min_t(int, rx_rings, hwr.grp);
 	hwr.cp = min_t(int, hwr.cp, bp->cp_nr_rings);
-	if (bnxt_ulp_registered(bp->edev) &&
+	if (bnxt_ulp_registered(bp->edev_rdma) &&
 	    hwr.stat > bnxt_get_ulp_stat_ctxs(bp))
 		hwr.stat -= bnxt_get_ulp_stat_ctxs(bp);
 	hwr.cp = min_t(int, hwr.cp, hwr.stat);
@@ -8064,7 +8065,7 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 	    !netif_is_rxfh_configured(bp->dev))
 		bnxt_set_dflt_rss_indir_tbl(bp, NULL);
 
-	if (!bnxt_ulp_registered(bp->edev) && BNXT_NEW_RM(bp)) {
+	if (!bnxt_ulp_registered(bp->edev_rdma) && BNXT_NEW_RM(bp)) {
 		int resv_msix, resv_ctx, ulp_ctxs;
 		struct bnxt_hw_resc *hw_resc;
 
@@ -11419,7 +11420,7 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
 	if (!bnxt_need_reserve_rings(bp))
 		return 0;
 
-	if (BNXT_NEW_RM(bp) && !bnxt_ulp_registered(bp->edev)) {
+	if (BNXT_NEW_RM(bp) && !bnxt_ulp_registered(bp->edev_rdma)) {
 		int ulp_msix = bnxt_get_avail_msix(bp, bp->ulp_num_msix_want);
 
 		if (ulp_msix > bp->ulp_num_msix_want)
@@ -14651,7 +14652,7 @@ int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
 		hwr.cp_p5 = hwr.tx + rx;
 	rc = bnxt_hwrm_check_rings(bp, &hwr);
 	if (!rc && pci_msix_can_alloc_dyn(bp->pdev)) {
-		if (!bnxt_ulp_registered(bp->edev)) {
+		if (!bnxt_ulp_registered(bp->edev_rdma)) {
 			hwr.cp += bnxt_get_ulp_msix_num(bp);
 			hwr.cp = min_t(int, hwr.cp, bnxt_get_max_func_irqs(bp));
 		}
@@ -16183,12 +16184,12 @@ static void bnxt_remove_one(struct pci_dev *pdev)
 	if (BNXT_PF(bp))
 		__bnxt_sriov_disable(bp);
 
-	bnxt_rdma_aux_device_del(bp);
+	bnxt_aux_device_del(bp, BNXT_AUXDEV_RDMA);
 
 	unregister_netdev(dev);
 	bnxt_ptp_clear(bp);
 
-	bnxt_rdma_aux_device_uninit(bp);
+	bnxt_aux_device_uninit(bp, BNXT_AUXDEV_RDMA);
 
 	bnxt_free_l2_filters(bp, true);
 	bnxt_free_ntp_fltrs(bp, true);
@@ -16774,7 +16775,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	bnxt_set_tpa_flags(bp);
 	bnxt_init_ring_params(bp);
 	bnxt_set_ring_params(bp);
-	bnxt_rdma_aux_device_init(bp);
+	bnxt_aux_device_init(bp, BNXT_AUXDEV_RDMA);
 	rc = bnxt_set_dflt_rings(bp, true);
 	if (rc) {
 		if (BNXT_VF(bp) && rc == -ENODEV) {
@@ -16838,7 +16839,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	bnxt_dl_fw_reporters_create(bp);
 
-	bnxt_rdma_aux_device_add(bp);
+	bnxt_aux_device_add(bp, BNXT_AUXDEV_RDMA);
 
 	bnxt_print_device_info(bp);
 
@@ -16846,7 +16847,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	return 0;
 init_err_cleanup:
-	bnxt_rdma_aux_device_uninit(bp);
+	bnxt_aux_device_uninit(bp, BNXT_AUXDEV_RDMA);
 	bnxt_dl_unregister(bp);
 init_err_dl:
 	bnxt_shutdown_tc(bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 06a4c2afdf8a..b3cba97bb9ea 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2340,8 +2340,8 @@ struct bnxt {
 #define BNXT_CHIP_P5_AND_MINUS(bp)		\
 	(BNXT_CHIP_P3(bp) || BNXT_CHIP_P4(bp) || BNXT_CHIP_P5(bp))
 
-	struct bnxt_aux_priv	*aux_priv;
-	struct bnxt_en_dev	*edev;
+	struct bnxt_aux_priv	*aux_priv_rdma;
+	struct bnxt_en_dev	*edev_rdma;
 
 	struct bnxt_napi	**bnapi;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 818bd0fa0a7d..0c1f7450ea55 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -5086,7 +5086,7 @@ static void bnxt_self_test(struct net_device *dev, struct ethtool_test *etest,
 
 	memset(buf, 0, sizeof(u64) * bp->num_tests);
 	if (etest->flags & ETH_TEST_FL_OFFLINE &&
-	    bnxt_ulp_registered(bp->edev)) {
+	    bnxt_ulp_registered(bp->edev_rdma)) {
 		etest->flags |= ETH_TEST_FL_FAILED;
 		netdev_warn(dev, "Offline tests cannot be run with RoCE driver loaded\n");
 		return;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index 992eec874345..8009964da698 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -27,11 +27,64 @@
 #include "bnxt.h"
 #include "bnxt_hwrm.h"
 
-static DEFINE_IDA(bnxt_aux_dev_ids);
+static DEFINE_IDA(bnxt_rdma_aux_dev_ids);
+
+struct bnxt_aux_device {
+	const char *name;
+	const u32 type;
+	struct ida *ida;
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
+static struct bnxt_aux_device bnxt_aux_devices[__BNXT_AUXDEV_MAX] = {{
+	.name		= "rdma",
+	.type		= BNXT_AUXDEV_RDMA,
+	.ida		= &bnxt_rdma_aux_dev_ids,
+	.release	= bnxt_rdma_aux_dev_release,
+	.set_priv       = bnxt_rdma_aux_dev_set_priv,
+	.get_priv	= bnxt_rdma_aux_dev_get_priv,
+	.set_edev       = bnxt_rdma_aux_dev_set_edev,
+	.get_edev	= bnxt_rdma_aux_dev_get_edev,
+	.get_auxdev	= bnxt_rdma_aux_dev_get_auxdev,
+}};
 
 static void bnxt_fill_msix_vecs(struct bnxt *bp, struct bnxt_msix_entry *ent)
 {
-	struct bnxt_en_dev *edev = bp->edev;
+	struct bnxt_en_dev *edev = bp->edev_rdma;
 	int num_msix, i;
 
 	if (!edev->ulp_tbl->msix_requested) {
@@ -51,55 +104,55 @@ static void bnxt_fill_msix_vecs(struct bnxt *bp, struct bnxt_msix_entry *ent)
 
 int bnxt_get_ulp_msix_num(struct bnxt *bp)
 {
-	if (bp->edev)
-		return bp->edev->ulp_num_msix_vec;
+	if (bp->edev_rdma)
+		return bp->edev_rdma->ulp_num_msix_vec;
 	return 0;
 }
 
 void bnxt_set_ulp_msix_num(struct bnxt *bp, int num)
 {
-	if (bp->edev)
-		bp->edev->ulp_num_msix_vec = num;
+	if (bp->edev_rdma)
+		bp->edev_rdma->ulp_num_msix_vec = num;
 }
 
 int bnxt_get_ulp_msix_num_in_use(struct bnxt *bp)
 {
-	if (bnxt_ulp_registered(bp->edev))
-		return bp->edev->ulp_num_msix_vec;
+	if (bnxt_ulp_registered(bp->edev_rdma))
+		return bp->edev_rdma->ulp_num_msix_vec;
 	return 0;
 }
 
 int bnxt_get_ulp_stat_ctxs(struct bnxt *bp)
 {
-	if (bp->edev)
-		return bp->edev->ulp_num_ctxs;
+	if (bp->edev_rdma)
+		return bp->edev_rdma->ulp_num_ctxs;
 	return 0;
 }
 
 void bnxt_set_ulp_stat_ctxs(struct bnxt *bp, int num_ulp_ctx)
 {
-	if (bp->edev)
-		bp->edev->ulp_num_ctxs = num_ulp_ctx;
+	if (bp->edev_rdma)
+		bp->edev_rdma->ulp_num_ctxs = num_ulp_ctx;
 }
 
 int bnxt_get_ulp_stat_ctxs_in_use(struct bnxt *bp)
 {
-	if (bnxt_ulp_registered(bp->edev))
-		return bp->edev->ulp_num_ctxs;
+	if (bnxt_ulp_registered(bp->edev_rdma))
+		return bp->edev_rdma->ulp_num_ctxs;
 	return 0;
 }
 
 void bnxt_set_dflt_ulp_stat_ctxs(struct bnxt *bp)
 {
-	if (bp->edev) {
-		bp->edev->ulp_num_ctxs = BNXT_MIN_ROCE_STAT_CTXS;
+	if (bp->edev_rdma) {
+		bp->edev_rdma->ulp_num_ctxs = BNXT_MIN_ROCE_STAT_CTXS;
 		/* Reserve one additional stat_ctx for PF0 (except
 		 * on 1-port NICs) as it also creates one stat_ctx
 		 * for PF1 in case of RoCE bonding.
 		 */
 		if (BNXT_PF(bp) && !bp->pf.port_id &&
 		    bp->port_count > 1)
-			bp->edev->ulp_num_ctxs++;
+			bp->edev_rdma->ulp_num_ctxs++;
 	}
 }
 
@@ -135,7 +188,7 @@ int bnxt_register_dev(struct bnxt_en_dev *edev,
 
 	edev->ulp_tbl->msix_requested = bnxt_get_ulp_msix_num(bp);
 
-	bnxt_fill_msix_vecs(bp, bp->edev->msix_entries);
+	bnxt_fill_msix_vecs(bp, bp->edev_rdma->msix_entries);
 	edev->flags |= BNXT_EN_FLAG_MSIX_REQUESTED;
 exit:
 	mutex_unlock(&edev->en_dev_lock);
@@ -224,8 +277,8 @@ EXPORT_SYMBOL(bnxt_send_msg);
 
 void bnxt_ulp_stop(struct bnxt *bp)
 {
-	struct bnxt_aux_priv *aux_priv = bp->aux_priv;
-	struct bnxt_en_dev *edev = bp->edev;
+	struct bnxt_aux_priv *aux_priv = bp->aux_priv_rdma;
+	struct bnxt_en_dev *edev = bp->edev_rdma;
 
 	if (!edev)
 		return;
@@ -255,8 +308,8 @@ void bnxt_ulp_stop(struct bnxt *bp)
 
 void bnxt_ulp_start(struct bnxt *bp, int err)
 {
-	struct bnxt_aux_priv *aux_priv = bp->aux_priv;
-	struct bnxt_en_dev *edev = bp->edev;
+	struct bnxt_aux_priv *aux_priv = bp->aux_priv_rdma;
+	struct bnxt_en_dev *edev = bp->edev_rdma;
 
 	if (!edev || err)
 		return;
@@ -288,14 +341,14 @@ void bnxt_ulp_start(struct bnxt *bp, int err)
 
 void bnxt_ulp_irq_stop(struct bnxt *bp)
 {
-	struct bnxt_en_dev *edev = bp->edev;
+	struct bnxt_en_dev *edev = bp->edev_rdma;
 	struct bnxt_ulp_ops *ops;
 	bool reset = false;
 
 	if (!edev || !(edev->flags & BNXT_EN_FLAG_MSIX_REQUESTED))
 		return;
 
-	if (bnxt_ulp_registered(bp->edev)) {
+	if (bnxt_ulp_registered(bp->edev_rdma)) {
 		struct bnxt_ulp *ulp = edev->ulp_tbl;
 
 		if (!ulp->msix_requested)
@@ -312,13 +365,13 @@ void bnxt_ulp_irq_stop(struct bnxt *bp)
 
 void bnxt_ulp_irq_restart(struct bnxt *bp, int err)
 {
-	struct bnxt_en_dev *edev = bp->edev;
+	struct bnxt_en_dev *edev = bp->edev_rdma;
 	struct bnxt_ulp_ops *ops;
 
 	if (!edev || !(edev->flags & BNXT_EN_FLAG_MSIX_REQUESTED))
 		return;
 
-	if (bnxt_ulp_registered(bp->edev)) {
+	if (bnxt_ulp_registered(bp->edev_rdma)) {
 		struct bnxt_ulp *ulp = edev->ulp_tbl;
 		struct bnxt_msix_entry *ent = NULL;
 
@@ -344,7 +397,7 @@ void bnxt_ulp_irq_restart(struct bnxt *bp, int err)
 void bnxt_ulp_async_events(struct bnxt *bp, struct hwrm_async_event_cmpl *cmpl)
 {
 	u16 event_id = le16_to_cpu(cmpl->event_id);
-	struct bnxt_en_dev *edev = bp->edev;
+	struct bnxt_en_dev *edev = bp->edev_rdma;
 	struct bnxt_ulp_ops *ops;
 	struct bnxt_ulp *ulp;
 
@@ -385,40 +438,49 @@ void bnxt_register_async_events(struct bnxt_en_dev *edev,
 }
 EXPORT_SYMBOL(bnxt_register_async_events);
 
-void bnxt_rdma_aux_device_uninit(struct bnxt *bp)
+void bnxt_aux_device_uninit(struct bnxt *bp,
+			    enum bnxt_ulp_auxdev_type auxdev_type)
 {
 	struct bnxt_aux_priv *aux_priv;
 	struct auxiliary_device *adev;
 
+	if (auxdev_type >= __BNXT_AUXDEV_MAX) {
+		netdev_warn(bp->dev, "Failed to uninit: unrecognized auxiliary device\n");
+		return;
+	}
 	/* Skip if no auxiliary device init was done. */
-	if (!bp->aux_priv)
+	if (!bnxt_aux_devices[auxdev_type].get_priv(bp))
 		return;
 
-	aux_priv = bp->aux_priv;
+	aux_priv = bnxt_aux_devices[auxdev_type].get_priv(bp);
 	adev = &aux_priv->aux_dev;
 	auxiliary_device_uninit(adev);
 }
 
-static void bnxt_aux_dev_release(struct device *dev)
+static void bnxt_rdma_aux_dev_release(struct device *dev)
 {
 	struct bnxt_aux_priv *aux_priv =
 		container_of(dev, struct bnxt_aux_priv, aux_dev.dev);
 	struct bnxt *bp = netdev_priv(aux_priv->edev->net);
 
-	ida_free(&bnxt_aux_dev_ids, aux_priv->id);
+	ida_free(&bnxt_rdma_aux_dev_ids, aux_priv->id);
 	kfree(aux_priv->edev->ulp_tbl);
-	bp->edev = NULL;
+	bp->edev_rdma = NULL;
 	kfree(aux_priv->edev);
 	kfree(aux_priv);
-	bp->aux_priv = NULL;
+	bp->aux_priv_rdma = NULL;
 }
 
-void bnxt_rdma_aux_device_del(struct bnxt *bp)
+void bnxt_aux_device_del(struct bnxt *bp, enum bnxt_ulp_auxdev_type auxdev_type)
 {
-	if (!bp->edev)
+	if (auxdev_type >= __BNXT_AUXDEV_MAX) {
+		netdev_warn(bp->dev, "Failed to del: unrecognized auxiliary device\n");
+		return;
+	}
+	if (!bnxt_aux_devices[auxdev_type].get_edev(bp))
 		return;
 
-	auxiliary_device_delete(&bp->aux_priv->aux_dev);
+	auxiliary_device_delete(bnxt_aux_devices[auxdev_type].get_auxdev(bp));
 }
 
 static void bnxt_set_edev_info(struct bnxt_en_dev *edev, struct bnxt *bp)
@@ -448,24 +510,30 @@ static void bnxt_set_edev_info(struct bnxt_en_dev *edev, struct bnxt *bp)
 	edev->bar0 = bp->bar0;
 }
 
-void bnxt_rdma_aux_device_add(struct bnxt *bp)
+void bnxt_aux_device_add(struct bnxt *bp, enum bnxt_ulp_auxdev_type auxdev_type)
 {
 	struct auxiliary_device *aux_dev;
 	int rc;
 
-	if (!bp->edev)
+	if (auxdev_type >= __BNXT_AUXDEV_MAX) {
+		netdev_warn(bp->dev, "Failed to add: unrecognized auxiliary device\n");
+		return;
+	}
+	if (!bnxt_aux_devices[auxdev_type].get_edev(bp))
 		return;
 
-	aux_dev = &bp->aux_priv->aux_dev;
+	aux_dev = bnxt_aux_devices[auxdev_type].get_auxdev(bp);
 	rc = auxiliary_device_add(aux_dev);
 	if (rc) {
 		netdev_warn(bp->dev, "Failed to add auxiliary device for ROCE\n");
 		auxiliary_device_uninit(aux_dev);
-		bp->flags &= ~BNXT_FLAG_ROCE_CAP;
+		if (bnxt_aux_devices[auxdev_type].type == BNXT_AUXDEV_RDMA)
+			bp->flags &= ~BNXT_FLAG_ROCE_CAP;
 	}
 }
 
-void bnxt_rdma_aux_device_init(struct bnxt *bp)
+void bnxt_aux_device_init(struct bnxt *bp,
+			  enum bnxt_ulp_auxdev_type auxdev_type)
 {
 	struct auxiliary_device *aux_dev;
 	struct bnxt_aux_priv *aux_priv;
@@ -473,14 +541,20 @@ void bnxt_rdma_aux_device_init(struct bnxt *bp)
 	struct bnxt_ulp *ulp;
 	int rc;
 
-	if (!(bp->flags & BNXT_FLAG_ROCE_CAP))
+	if (auxdev_type >= __BNXT_AUXDEV_MAX) {
+		netdev_warn(bp->dev, "Failed to init: unrecognized auxiliary device\n");
+		return;
+	}
+
+	if (bnxt_aux_devices[auxdev_type].type == BNXT_AUXDEV_RDMA &&
+	    !(bp->flags & BNXT_FLAG_ROCE_CAP))
 		return;
 
-	aux_priv = kzalloc(sizeof(*bp->aux_priv), GFP_KERNEL);
+	aux_priv = kzalloc(sizeof(*bp->aux_priv_rdma), GFP_KERNEL);
 	if (!aux_priv)
 		goto exit;
 
-	aux_priv->id = ida_alloc(&bnxt_aux_dev_ids, GFP_KERNEL);
+	aux_priv->id = ida_alloc(bnxt_aux_devices[auxdev_type].ida, GFP_KERNEL);
 	if (aux_priv->id < 0) {
 		netdev_warn(bp->dev,
 			    "ida alloc failed for ROCE auxiliary device\n");
@@ -490,17 +564,17 @@ void bnxt_rdma_aux_device_init(struct bnxt *bp)
 
 	aux_dev = &aux_priv->aux_dev;
 	aux_dev->id = aux_priv->id;
-	aux_dev->name = "rdma";
+	aux_dev->name = bnxt_aux_devices[auxdev_type].name;
 	aux_dev->dev.parent = &bp->pdev->dev;
-	aux_dev->dev.release = bnxt_aux_dev_release;
+	aux_dev->dev.release = bnxt_aux_devices[auxdev_type].release;
 
 	rc = auxiliary_device_init(aux_dev);
 	if (rc) {
-		ida_free(&bnxt_aux_dev_ids, aux_priv->id);
+		ida_free(bnxt_aux_devices[auxdev_type].ida, aux_priv->id);
 		kfree(aux_priv);
 		goto exit;
 	}
-	bp->aux_priv = aux_priv;
+	bnxt_aux_devices[auxdev_type].set_priv(bp, aux_priv);
 
 	/* From this point, all cleanup will happen via the .release callback &
 	 * any error unwinding will need to include a call to
@@ -517,14 +591,16 @@ void bnxt_rdma_aux_device_init(struct bnxt *bp)
 		goto aux_dev_uninit;
 
 	edev->ulp_tbl = ulp;
-	bp->edev = edev;
+	bnxt_aux_devices[auxdev_type].set_edev(bp, edev);
 	bnxt_set_edev_info(edev, bp);
-	bp->ulp_num_msix_want = bnxt_set_dflt_ulp_msix(bp);
+	if (bnxt_aux_devices[auxdev_type].type == BNXT_AUXDEV_RDMA)
+		bp->ulp_num_msix_want = bnxt_set_dflt_ulp_msix(bp);
 
 	return;
 
 aux_dev_uninit:
 	auxiliary_device_uninit(aux_dev);
 exit:
-	bp->flags &= ~BNXT_FLAG_ROCE_CAP;
+	if (bnxt_aux_devices[auxdev_type].type == BNXT_AUXDEV_RDMA)
+		bp->flags &= ~BNXT_FLAG_ROCE_CAP;
 }
diff --git a/include/linux/bnxt/ulp.h b/include/linux/bnxt/ulp.h
index 7b9dd8ebe4bc..01b7100dcf4d 100644
--- a/include/linux/bnxt/ulp.h
+++ b/include/linux/bnxt/ulp.h
@@ -20,6 +20,11 @@
 struct hwrm_async_event_cmpl;
 struct bnxt;
 
+enum bnxt_ulp_auxdev_type {
+	BNXT_AUXDEV_RDMA = 0,
+	__BNXT_AUXDEV_MAX
+};
+
 struct bnxt_msix_entry {
 	u32	vector;
 	u32	ring_idx;
@@ -116,10 +121,10 @@ void bnxt_ulp_sriov_cfg(struct bnxt *bp, int num_vfs);
 void bnxt_ulp_irq_stop(struct bnxt *bp);
 void bnxt_ulp_irq_restart(struct bnxt *bp, int err);
 void bnxt_ulp_async_events(struct bnxt *bp, struct hwrm_async_event_cmpl *cmpl);
-void bnxt_rdma_aux_device_uninit(struct bnxt *bp);
-void bnxt_rdma_aux_device_del(struct bnxt *bp);
-void bnxt_rdma_aux_device_add(struct bnxt *bp);
-void bnxt_rdma_aux_device_init(struct bnxt *bp);
+void bnxt_aux_device_uninit(struct bnxt *bp, enum bnxt_ulp_auxdev_type type);
+void bnxt_aux_device_init(struct bnxt *bp, enum bnxt_ulp_auxdev_type type);
+void bnxt_aux_device_add(struct bnxt *bp, enum bnxt_ulp_auxdev_type type);
+void bnxt_aux_device_del(struct bnxt *bp, enum bnxt_ulp_auxdev_type type);
 int bnxt_register_dev(struct bnxt_en_dev *edev, struct bnxt_ulp_ops *ulp_ops,
 		      void *handle);
 void bnxt_unregister_dev(struct bnxt_en_dev *edev);
-- 
2.39.1



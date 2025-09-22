Return-Path: <netdev+bounces-225163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EB8B8FABE
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 11:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ED3C3A4330
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 09:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0116C271443;
	Mon, 22 Sep 2025 09:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="W9oiblZa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f227.google.com (mail-yb1-f227.google.com [209.85.219.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5134241139
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 09:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758531667; cv=none; b=MtUnXDLc1ABnxLPy4Nk2nHtWzEeqD/qHN9so4/HmzdxKrSwj0X0EiG6Z2xiOARtp0/MlaQBGgWvJJHwqUL8kNrtAaTiQHvCTL7nH5W4Brc3J7REFTrtqWs4UutgV6XNvHHe4fstTwl4HzF+D9bw5NAav92g601z2Y+gIM6tD+hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758531667; c=relaxed/simple;
	bh=IK8sHN59r6LO2zzlKdOv00lHKALVIOHCulModE0Tf9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qa97qQJZlU4GMyJmdSk1Jm/uMoEqAVJB8kayAXwk4XujPgfdUdPE+OsWpntSF6gg/6Uv0VoUYr3xpm2E8351Gw1HvKclXWZNHwqGqPS7x2LwLxTpoEsaZd97G6wz1WpQv/fe9CWqngmEEnFIpkAc3kwtraGK5kV3ryWE4RaArqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=W9oiblZa; arc=none smtp.client-ip=209.85.219.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f227.google.com with SMTP id 3f1490d57ef6-ea3c51e4cffso3349063276.3
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 02:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758531665; x=1759136465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Blvmoz4g8MClBjvdehYbMGGRznbF2L4EM56eGtANSvw=;
        b=AwtfwVwU2BkzOscABldN8ICzZmNlb7ci0iTRdpRk02eYqXp+Gplh//Net1s6o/HEZz
         L2C7lXSNK56Rls3Tr9Yj6PQ6l/1zSow+sUk2rwI0Et9vfCT1BZIvil3heLc7tLfswU4Y
         Fs1m4LKXmbfvhSr5uxZEHtRav1qrEeqXYgF7748e2sbjJCMqvxQKXC7S582JjB2o23up
         AvG1TdwWACyMvX14+rDlGzszvxNg09FO30xUcy/hHRwHDA3dNpaKDhJxrGfCgHls3n0u
         YlNTkmn6xpNNs0PzGVzSc8eHosWuaP8EgRfDeW6SFuTrtkiSHdx+jV0Bs8/W6JRQk5Fq
         KZQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOYHRSwI3r1DyMDZ14V47L6TE5w2HwLgQLJXXQntBHXfd3eEyRpE0BpnMhIWrDfnIE6xphozI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8GQ2JQms7YAunF8Lm0SEflzWnAqWA8bmKikvezisvwsLTUHiZ
	SMPWaJ+4n0ptKIEuQY4kHCy7z55niv4iH2VhoElRmXYTWRFqSQzZRXM/2ht40mWD2fjCSmzNPxh
	s0eSNU6ikiTJuH8O348mypD8hR59aN1AKRf1Xphlx6O/lBnwO9un2MS6FwulcopHfY35di1ApVL
	GnEjD1dxSLwOV02QYNs3nNZejjj8MfLYe/nh4jcMTVB3HuVoKX+U44m+pP1X9JV9vDOOLuFpnjU
	9HmP4XFjDI=
X-Gm-Gg: ASbGncv6WBnp0lubElXpThhi/fSnpVDYwuK0Kb2LgGLqePopKyXSYyj4EL3G3ERU5Ms
	OddRtjMMzUFBPAftQIcLzmLowoqdnOanH4f1xGq4Pg+hCm5fhoVoq25K9Qgz7DlLTfVLC8Jocyq
	9aur4nMaivPVIEk4ZfTrDcdYfKf7wn5w0GZqD0tdH725jD/q2qVp3h8axxGgIMyRwrDBVUQgAad
	NULlpjGZGJsc/iMw1WMeSzCr0sn2IOeNS9FVxXvzwuEH9Ipg59XJQipkfJP+5t6+886z8HzSiAZ
	ASIrqHYov865JIG0GLJXZ+RKCqL21Qb1ydQzwNPzXhThBgbxNFi4V7tBmmifcmQB+rF3FAyOtDR
	BO+/1NhkfXhcIWm8a12jQJHMotJy0I6chWgzHPBiP0p8ETOyfnp9W1+nRIpXHJbySTDe5Y3nhPu
	SVxg==
X-Google-Smtp-Source: AGHT+IGk1hEGausXBvKS9QG6sSOYOIUc8tL5Xo+kUy9nDwc75682P65kP04Giy4k/0cM6eCLO2/ky+Wqwktk
X-Received: by 2002:a05:690c:4b04:b0:751:25b1:2b2f with SMTP id 00721157ae682-75125b12cb9mr13984877b3.43.1758531664500;
        Mon, 22 Sep 2025 02:01:04 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-73971998651sm5241437b3.44.2025.09.22.02.01.04
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Sep 2025 02:01:04 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-269880a7bd9so46316905ad.3
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 02:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758531663; x=1759136463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Blvmoz4g8MClBjvdehYbMGGRznbF2L4EM56eGtANSvw=;
        b=W9oiblZaVlEjsNOzP+JS+n7nHGoe+1geaMupcjukpEEmfJlxBhdTUnQqgU+eXlZRBA
         fV+chDAabEsMQ47E07847koKL5iZcea13WVni/Oc+a05Hj3vwOMM2TgPtP/VKJBTdxlr
         CAM2L/45lmTmjsCbnuN5l8QWQimeUxDp00uUU=
X-Forwarded-Encrypted: i=1; AJvYcCWtqLP37IYGZWqxA52VxwQwlftos0h9H19Dc1Jr4xvW0c4TtdukVGjJ08kxIzqXGsNDpbAKfRY=@vger.kernel.org
X-Received: by 2002:a17:903:2a8e:b0:267:e09c:7ea3 with SMTP id d9443c01a7336-269ba467aaamr174110205ad.13.1758531662861;
        Mon, 22 Sep 2025 02:01:02 -0700 (PDT)
X-Received: by 2002:a17:903:2a8e:b0:267:e09c:7ea3 with SMTP id d9443c01a7336-269ba467aaamr174109655ad.13.1758531662273;
        Mon, 22 Sep 2025 02:01:02 -0700 (PDT)
Received: from PC-MID-R740.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269803416a2sm123309615ad.134.2025.09.22.02.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:01:01 -0700 (PDT)
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
Subject: [PATCH net-next 2/6] bnxt_en: Refactor aux bus functions to be generic
Date: Mon, 22 Sep 2025 02:08:47 -0700
Message-Id: <20250922090851.719913-3-pavan.chebbi@broadcom.com>
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

Up until now there was only one auxiliary device that bnxt
created and that was for RoCE driver. bnxt fwctl is also
going to use an aux bus device that bnxt should create.
This requires some nomenclature changes and refactoring of
the existing bnxt aux dev functions.

Make aux bus init/uninit/add/del functions generic which will
accept aux device type as a parameter. Change aux_dev_ids to
aux_dev_rdma_ids to mean it is for RoCE driver.

Also rename the 'aux_priv' and 'edev' members of struct bp to
'aux_priv_rdma' and 'edev_rdma' respectively, to mean they belong
to rdma.
Rename bnxt_aux_device_release() as bnxt_rdma_aux_device_release()

Future patches will reuse these functions to add an aux bus device
for fwctl.

Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  23 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   4 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 102 +++++++++---------
 include/linux/bnxt/ulp.h                      |  13 ++-
 5 files changed, 77 insertions(+), 67 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 917a39f8865c..feb11b9ea4dd 100644
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
@@ -14657,7 +14658,7 @@ int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
 		hwr.cp_p5 = hwr.tx + rx;
 	rc = bnxt_hwrm_check_rings(bp, &hwr);
 	if (!rc && pci_msix_can_alloc_dyn(bp->pdev)) {
-		if (!bnxt_ulp_registered(bp->edev)) {
+		if (!bnxt_ulp_registered(bp->edev_rdma)) {
 			hwr.cp += bnxt_get_ulp_msix_num(bp);
 			hwr.cp = min_t(int, hwr.cp, bnxt_get_max_func_irqs(bp));
 		}
@@ -16187,12 +16188,12 @@ static void bnxt_remove_one(struct pci_dev *pdev)
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
@@ -16778,7 +16779,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	bnxt_set_tpa_flags(bp);
 	bnxt_init_ring_params(bp);
 	bnxt_set_ring_params(bp);
-	bnxt_rdma_aux_device_init(bp);
+	bnxt_aux_device_init(bp, BNXT_AUXDEV_RDMA);
 	rc = bnxt_set_dflt_rings(bp, true);
 	if (rc) {
 		if (BNXT_VF(bp) && rc == -ENODEV) {
@@ -16842,7 +16843,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	bnxt_dl_fw_reporters_create(bp);
 
-	bnxt_rdma_aux_device_add(bp);
+	bnxt_aux_device_add(bp, BNXT_AUXDEV_RDMA);
 
 	bnxt_print_device_info(bp);
 
@@ -16850,7 +16851,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	return 0;
 init_err_cleanup:
-	bnxt_rdma_aux_device_uninit(bp);
+	bnxt_aux_device_uninit(bp, BNXT_AUXDEV_RDMA);
 	bnxt_dl_unregister(bp);
 init_err_dl:
 	bnxt_shutdown_tc(bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 2578bac16f6c..b2f139eddfec 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2335,8 +2335,8 @@ struct bnxt {
 #define BNXT_CHIP_P5_AND_MINUS(bp)		\
 	(BNXT_CHIP_P3(bp) || BNXT_CHIP_P4(bp) || BNXT_CHIP_P5(bp))
 
-	struct bnxt_aux_priv	*aux_priv;
-	struct bnxt_en_dev	*edev;
+	struct bnxt_aux_priv	*aux_priv_rdma;
+	struct bnxt_en_dev	*edev_rdma;
 
 	struct bnxt_napi	**bnapi;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 3231d3c022dc..6a175fd082c1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -5085,7 +5085,7 @@ static void bnxt_self_test(struct net_device *dev, struct ethtool_test *etest,
 
 	memset(buf, 0, sizeof(u64) * bp->num_tests);
 	if (etest->flags & ETH_TEST_FL_OFFLINE &&
-	    bnxt_ulp_registered(bp->edev)) {
+	    bnxt_ulp_registered(bp->edev_rdma)) {
 		etest->flags |= ETH_TEST_FL_FAILED;
 		netdev_warn(dev, "Offline tests cannot be run with RoCE driver loaded\n");
 		return;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index 992eec874345..665850753f90 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -27,11 +27,11 @@
 #include "bnxt.h"
 #include "bnxt_hwrm.h"
 
-static DEFINE_IDA(bnxt_aux_dev_ids);
+static DEFINE_IDA(bnxt_rdma_aux_dev_ids);
 
 static void bnxt_fill_msix_vecs(struct bnxt *bp, struct bnxt_msix_entry *ent)
 {
-	struct bnxt_en_dev *edev = bp->edev;
+	struct bnxt_en_dev *edev = bp->edev_rdma;
 	int num_msix, i;
 
 	if (!edev->ulp_tbl->msix_requested) {
@@ -51,55 +51,55 @@ static void bnxt_fill_msix_vecs(struct bnxt *bp, struct bnxt_msix_entry *ent)
 
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
 
@@ -135,7 +135,7 @@ int bnxt_register_dev(struct bnxt_en_dev *edev,
 
 	edev->ulp_tbl->msix_requested = bnxt_get_ulp_msix_num(bp);
 
-	bnxt_fill_msix_vecs(bp, bp->edev->msix_entries);
+	bnxt_fill_msix_vecs(bp, bp->edev_rdma->msix_entries);
 	edev->flags |= BNXT_EN_FLAG_MSIX_REQUESTED;
 exit:
 	mutex_unlock(&edev->en_dev_lock);
@@ -224,8 +224,8 @@ EXPORT_SYMBOL(bnxt_send_msg);
 
 void bnxt_ulp_stop(struct bnxt *bp)
 {
-	struct bnxt_aux_priv *aux_priv = bp->aux_priv;
-	struct bnxt_en_dev *edev = bp->edev;
+	struct bnxt_aux_priv *aux_priv = bp->aux_priv_rdma;
+	struct bnxt_en_dev *edev = bp->edev_rdma;
 
 	if (!edev)
 		return;
@@ -255,8 +255,8 @@ void bnxt_ulp_stop(struct bnxt *bp)
 
 void bnxt_ulp_start(struct bnxt *bp, int err)
 {
-	struct bnxt_aux_priv *aux_priv = bp->aux_priv;
-	struct bnxt_en_dev *edev = bp->edev;
+	struct bnxt_aux_priv *aux_priv = bp->aux_priv_rdma;
+	struct bnxt_en_dev *edev = bp->edev_rdma;
 
 	if (!edev || err)
 		return;
@@ -288,14 +288,14 @@ void bnxt_ulp_start(struct bnxt *bp, int err)
 
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
@@ -312,13 +312,13 @@ void bnxt_ulp_irq_stop(struct bnxt *bp)
 
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
 
@@ -344,7 +344,7 @@ void bnxt_ulp_irq_restart(struct bnxt *bp, int err)
 void bnxt_ulp_async_events(struct bnxt *bp, struct hwrm_async_event_cmpl *cmpl)
 {
 	u16 event_id = le16_to_cpu(cmpl->event_id);
-	struct bnxt_en_dev *edev = bp->edev;
+	struct bnxt_en_dev *edev = bp->edev_rdma;
 	struct bnxt_ulp_ops *ops;
 	struct bnxt_ulp *ulp;
 
@@ -385,40 +385,41 @@ void bnxt_register_async_events(struct bnxt_en_dev *edev,
 }
 EXPORT_SYMBOL(bnxt_register_async_events);
 
-void bnxt_rdma_aux_device_uninit(struct bnxt *bp)
+void bnxt_aux_device_uninit(struct bnxt *bp,
+			    enum bnxt_ulp_auxdev_type auxdev_type)
 {
 	struct bnxt_aux_priv *aux_priv;
 	struct auxiliary_device *adev;
 
 	/* Skip if no auxiliary device init was done. */
-	if (!bp->aux_priv)
+	if (!bp->aux_priv_rdma)
 		return;
 
-	aux_priv = bp->aux_priv;
+	aux_priv = bp->aux_priv_rdma;
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
+	if (!bp->edev_rdma)
 		return;
 
-	auxiliary_device_delete(&bp->aux_priv->aux_dev);
+	auxiliary_device_delete(&bp->aux_priv_rdma->aux_dev);
 }
 
 static void bnxt_set_edev_info(struct bnxt_en_dev *edev, struct bnxt *bp)
@@ -448,15 +449,15 @@ static void bnxt_set_edev_info(struct bnxt_en_dev *edev, struct bnxt *bp)
 	edev->bar0 = bp->bar0;
 }
 
-void bnxt_rdma_aux_device_add(struct bnxt *bp)
+void bnxt_aux_device_add(struct bnxt *bp, enum bnxt_ulp_auxdev_type auxdev_type)
 {
 	struct auxiliary_device *aux_dev;
 	int rc;
 
-	if (!bp->edev)
+	if (!bp->edev_rdma)
 		return;
 
-	aux_dev = &bp->aux_priv->aux_dev;
+	aux_dev = &bp->aux_priv_rdma->aux_dev;
 	rc = auxiliary_device_add(aux_dev);
 	if (rc) {
 		netdev_warn(bp->dev, "Failed to add auxiliary device for ROCE\n");
@@ -465,7 +466,8 @@ void bnxt_rdma_aux_device_add(struct bnxt *bp)
 	}
 }
 
-void bnxt_rdma_aux_device_init(struct bnxt *bp)
+void bnxt_aux_device_init(struct bnxt *bp,
+			  enum bnxt_ulp_auxdev_type auxdev_type)
 {
 	struct auxiliary_device *aux_dev;
 	struct bnxt_aux_priv *aux_priv;
@@ -473,14 +475,15 @@ void bnxt_rdma_aux_device_init(struct bnxt *bp)
 	struct bnxt_ulp *ulp;
 	int rc;
 
-	if (!(bp->flags & BNXT_FLAG_ROCE_CAP))
+	if (auxdev_type == BNXT_AUXDEV_RDMA &&
+	    !(bp->flags & BNXT_FLAG_ROCE_CAP))
 		return;
 
-	aux_priv = kzalloc(sizeof(*bp->aux_priv), GFP_KERNEL);
+	aux_priv = kzalloc(sizeof(*bp->aux_priv_rdma), GFP_KERNEL);
 	if (!aux_priv)
 		goto exit;
 
-	aux_priv->id = ida_alloc(&bnxt_aux_dev_ids, GFP_KERNEL);
+	aux_priv->id = ida_alloc(&bnxt_rdma_aux_dev_ids, GFP_KERNEL);
 	if (aux_priv->id < 0) {
 		netdev_warn(bp->dev,
 			    "ida alloc failed for ROCE auxiliary device\n");
@@ -492,15 +495,15 @@ void bnxt_rdma_aux_device_init(struct bnxt *bp)
 	aux_dev->id = aux_priv->id;
 	aux_dev->name = "rdma";
 	aux_dev->dev.parent = &bp->pdev->dev;
-	aux_dev->dev.release = bnxt_aux_dev_release;
+	aux_dev->dev.release = bnxt_rdma_aux_dev_release;
 
 	rc = auxiliary_device_init(aux_dev);
 	if (rc) {
-		ida_free(&bnxt_aux_dev_ids, aux_priv->id);
+		ida_free(&bnxt_rdma_aux_dev_ids, aux_priv->id);
 		kfree(aux_priv);
 		goto exit;
 	}
-	bp->aux_priv = aux_priv;
+	bp->aux_priv_rdma = aux_priv;
 
 	/* From this point, all cleanup will happen via the .release callback &
 	 * any error unwinding will need to include a call to
@@ -517,9 +520,10 @@ void bnxt_rdma_aux_device_init(struct bnxt *bp)
 		goto aux_dev_uninit;
 
 	edev->ulp_tbl = ulp;
-	bp->edev = edev;
+	bp->edev_rdma = edev;
 	bnxt_set_edev_info(edev, bp);
-	bp->ulp_num_msix_want = bnxt_set_dflt_ulp_msix(bp);
+	if (auxdev_type == BNXT_AUXDEV_RDMA)
+		bp->ulp_num_msix_want = bnxt_set_dflt_ulp_msix(bp);
 
 	return;
 
diff --git a/include/linux/bnxt/ulp.h b/include/linux/bnxt/ulp.h
index 7b9dd8ebe4bc..baac0dd44078 100644
--- a/include/linux/bnxt/ulp.h
+++ b/include/linux/bnxt/ulp.h
@@ -20,6 +20,11 @@
 struct hwrm_async_event_cmpl;
 struct bnxt;
 
+enum bnxt_ulp_auxdev_type {
+	BNXT_AUXDEV_RDMA = 0,
+	__BNXT_AUXDEV_MAX,
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



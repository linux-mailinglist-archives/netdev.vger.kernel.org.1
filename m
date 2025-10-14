Return-Path: <netdev+bounces-229088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5EFBD8141
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 10:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F93F3E193B
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 08:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907D530F7FD;
	Tue, 14 Oct 2025 08:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LHrXW1xw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com [209.85.221.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8E130F7E2
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 08:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760429061; cv=none; b=BQ+MaKeFL3ShOwCsqW6Ot5MvNEOkndPqnl8ujmkLT9hWIDoN93AzaFSCHV0081s9loc1MUiqLmvlZwi7JXj56GDzqQ1LD/ZcvjzBSxNN1dhVlzfdtvTx5GCEm29zhpPy7kcMXMbp7u+Uw/4gd+rYS5balASYyrkuQc1ZTqEka6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760429061; c=relaxed/simple;
	bh=rPT5sl3ki4JlRaTPyKLtswvGFrvI3YX9wrJbrBY7YTg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dnmntJZC9hJWChqmBkEMdCqPxGzDZ1B6jOHu1QX+Y/b+xTSCI4vzSFTDTTWPy+OEeV09ReQOZ1xnUnhf+XT1nr3iMY1Z2VtJopPfU3hV4O9AMIj4Ozq1vH1KIRON+cqhVmCgxEf/HwdHn71usW+EUAAKjXQYQUsCJjzy96TyYsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LHrXW1xw; arc=none smtp.client-ip=209.85.221.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f226.google.com with SMTP id 71dfb90a1353d-54a880e2858so2438124e0c.2
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 01:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760429058; x=1761033858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMOZjbgTb0hnvvo086fp0yc1b7ZcEylgQpPYzumnFy8=;
        b=uJxPr3xKS9WKBowsf9Gd2PrzMaj8NOAAwlftqGMOZggEFOTmzBAarYQkJQWKg6i8xm
         T+CSLZtYaBLP4Q4k54BSf0tBQYl+gNwMLmLvlJCpzRIk7xNO9UMuOcEW5asedId+7vgq
         YKkTzgW1T2TbKuCE71ylwCuv86meRm2lzYyCNKpUbW9jzO4eqC4JPFfIlY/xZ2h11knG
         y3WDDMMAbbiuKIMzlGnkEZ/XwM21TW0arWy1kQs71UA/0PbV2qsGxcfgEWVERIKdwiX2
         u2lbPEu/FZT1JEb4UGfZny9AxCBvInBhgHFpXkQ+jOBi1M7+evXaEFlXs4/kVLjP8LzP
         LWaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVicCBnL5mt26eGHvpV4GeMwcd75WnzTOOWo5gRyz/o39Eo2JPiboAxhMVXqzz9/K3iqfioCrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNsnFvJtivThFuv90qswInmqkhLb2dTiOJwiPrS3IWeMBPny0v
	BpiA/gq+yf1oOxzBccEBcc1a+r/C9bbs+XOM+6nCPAoWvbljwTnLlSUJasnAMksq+rK/4uEk0CF
	PeLAggIjlH8pfdLfsi1S972+0PordbSqTFfC3IZWcy6di9tQyZpkCKLqXdKak28EImZ0RQ9hj/5
	n5lVrHuqSHr1pqb64oZ2iZmPTo9+TqSpgXI0084FryGeFhkBDI5xy7unYUTN1plsz4GK7NKtT+T
	zdwyab62kb82g==
X-Gm-Gg: ASbGncvKruGOP8BL9LZ4zdhvmWDxtCZCCvDL/juEKEDYBTtu7txLHigClIbLhR3jYlk
	MNGWSz9VCQlwlKZ2S/3/dFUjScSfpdVC83vYAs8sem+BdacXFKLDzoVFw7Zpp1WVWaHtbXLZMlC
	w+oVjSds3o3n+p5cjIJBMPUBmd4VgI8Y+acsADuQ96TLqWfFsJmdig5pn/L6r8CUfL7pDWc3XBL
	0K8r5epQqb2P/g9ZH6L1Teb1J4KJ1TsjsDHCCaUxo/y/A+7k10D50zluIjl0cBzgyQjsSTxobzd
	KHvj0q0QStJJOauUM0NAogDrzaTYw6N90ke6zpWkk8j1kCddkEoSBli9smxWG/pJ9pfetrUIXdz
	Vq4b0FU+arH+5H6W7C2tpeDa0G2qSrwHlVw0gcRHtSb54psjeTNfQMqkJ+xBKTJQ6f5GVdKeGX7
	4PxQ==
X-Google-Smtp-Source: AGHT+IFwZsVu0HG6lpUVk+lqYmv0jpNzbCxwIeII7Nn4l7HUS07GypvVTHb24IMIaBaYO6CHgRn7AoqU6MVe
X-Received: by 2002:a05:6122:1e16:b0:542:59a2:731a with SMTP id 71dfb90a1353d-554b8c3112cmr9232800e0c.16.1760429057855;
        Tue, 14 Oct 2025 01:04:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-554d8036d3bsm1429945e0c.7.2025.10.14.01.04.17
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Oct 2025 01:04:17 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7811e063dceso8205821b3a.2
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 01:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760429056; x=1761033856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMOZjbgTb0hnvvo086fp0yc1b7ZcEylgQpPYzumnFy8=;
        b=LHrXW1xw49UCiRXqaTy/bN3Q0LnOlr7Nkj1CflfTn7dK36k1Rtp7g29r0MeqOhwj+b
         UTD0z4LOdCMhGjh+xuqNkbNQaufEsOPD0r3QVPz7g/IRhTvBkbUhlCFW86rQ6zKQpe/M
         Imlfoq7rFrD2mr+yMyCUhyp3/cvvOHofnkkO0=
X-Forwarded-Encrypted: i=1; AJvYcCX6pWVA7a0R5+gtChG1unOufm6upMQX1jAe5X9RqKRZpLBu6AKuO4OQIRZnikxXEN1ipkA01H4=@vger.kernel.org
X-Received: by 2002:a05:6a00:92a5:b0:77f:1ef8:8ac4 with SMTP id d2e1a72fcca58-79387636849mr21776232b3a.23.1760429055931;
        Tue, 14 Oct 2025 01:04:15 -0700 (PDT)
X-Received: by 2002:a05:6a00:92a5:b0:77f:1ef8:8ac4 with SMTP id d2e1a72fcca58-79387636849mr21776191b3a.23.1760429055339;
        Tue, 14 Oct 2025 01:04:15 -0700 (PDT)
Received: from PC-MID-R740.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-799283c1a14sm14329716b3a.0.2025.10.14.01.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 01:04:14 -0700 (PDT)
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
Subject: [PATCH net-next v5 2/5] bnxt_en: Refactor aux bus functions to be more generic
Date: Tue, 14 Oct 2025 01:10:30 -0700
Message-Id: <20251014081033.1175053-3-pavan.chebbi@broadcom.com>
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

Up until now there was only one auxiliary device that bnxt
created and that was for RoCE driver. bnxt fwctl is also
going to use an aux bus device that bnxt should create.
This requires some nomenclature changes and refactoring of
the existing bnxt aux dev functions.

Convert 'aux_priv' and 'edev' members of struct bnxt into
arrays where each element contains supported auxbus device's
data. Move struct bnxt_aux_priv from bnxt.h to ulp.h because
that is where it belongs. Make aux bus init/uninit/add/del
functions more generic which will accept aux device type as
a parameter. Make bnxt_ulp_start/stop functions (the only
other common functions applicable to any aux device) loop
through the aux devices to update their config and states.

Also, as an improvement in code, bnxt_register_dev() can skip
unnecessary dereferencing of edev from bp, instead use the
edev pointer from the function parameter.

Future patches will reuse these functions to add an aux bus
device for fwctl.

Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  29 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  13 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 238 ++++++++++--------
 include/linux/bnxt/ulp.h                      |  23 +-
 5 files changed, 181 insertions(+), 124 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 34fef6b15ce1..dcbb321cee3a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6848,7 +6848,8 @@ int bnxt_hwrm_vnic_cfg(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 #endif
 	if ((bp->flags & BNXT_FLAG_STRIP_VLAN) || def_vlan)
 		req->flags |= cpu_to_le32(VNIC_CFG_REQ_FLAGS_VLAN_STRIP_MODE);
-	if (vnic->vnic_id == BNXT_VNIC_DEFAULT && bnxt_ulp_registered(bp->edev))
+	if (vnic->vnic_id == BNXT_VNIC_DEFAULT &&
+	    bnxt_ulp_registered(bp->edev[BNXT_AUXDEV_RDMA]))
 		req->flags |= cpu_to_le32(bnxt_get_roce_vnic_mode(bp));
 
 	return hwrm_req_send(bp, req);
@@ -7963,6 +7964,7 @@ static int bnxt_get_avail_msix(struct bnxt *bp, int num);
 
 static int __bnxt_reserve_rings(struct bnxt *bp)
 {
+	struct bnxt_en_dev *edev = bp->edev[BNXT_AUXDEV_RDMA];
 	struct bnxt_hw_rings hwr = {0};
 	int rx_rings, old_rx_rings, rc;
 	int cp = bp->cp_nr_rings;
@@ -7973,7 +7975,7 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 	if (!bnxt_need_reserve_rings(bp))
 		return 0;
 
-	if (BNXT_NEW_RM(bp) && !bnxt_ulp_registered(bp->edev)) {
+	if (BNXT_NEW_RM(bp) && !bnxt_ulp_registered(edev)) {
 		ulp_msix = bnxt_get_avail_msix(bp, bp->ulp_num_msix_want);
 		if (!ulp_msix)
 			bnxt_set_ulp_stat_ctxs(bp, 0);
@@ -8024,8 +8026,7 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 	}
 	rx_rings = min_t(int, rx_rings, hwr.grp);
 	hwr.cp = min_t(int, hwr.cp, bp->cp_nr_rings);
-	if (bnxt_ulp_registered(bp->edev) &&
-	    hwr.stat > bnxt_get_ulp_stat_ctxs(bp))
+	if (bnxt_ulp_registered(edev) && hwr.stat > bnxt_get_ulp_stat_ctxs(bp))
 		hwr.stat -= bnxt_get_ulp_stat_ctxs(bp);
 	hwr.cp = min_t(int, hwr.cp, hwr.stat);
 	rc = bnxt_trim_rings(bp, &rx_rings, &hwr.tx, hwr.cp, sh);
@@ -8064,7 +8065,7 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 	    !netif_is_rxfh_configured(bp->dev))
 		bnxt_set_dflt_rss_indir_tbl(bp, NULL);
 
-	if (!bnxt_ulp_registered(bp->edev) && BNXT_NEW_RM(bp)) {
+	if (!bnxt_ulp_registered(edev) && BNXT_NEW_RM(bp)) {
 		int resv_msix, resv_ctx, ulp_ctxs;
 		struct bnxt_hw_resc *hw_resc;
 
@@ -11412,6 +11413,7 @@ static void bnxt_clear_int_mode(struct bnxt *bp)
 
 int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
 {
+	struct bnxt_en_dev *edev = bp->edev[BNXT_AUXDEV_RDMA];
 	bool irq_cleared = false;
 	bool irq_change = false;
 	int tcs = bp->num_tc;
@@ -11421,7 +11423,7 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
 	if (!bnxt_need_reserve_rings(bp))
 		return 0;
 
-	if (BNXT_NEW_RM(bp) && !bnxt_ulp_registered(bp->edev)) {
+	if (BNXT_NEW_RM(bp) && !bnxt_ulp_registered(edev)) {
 		int ulp_msix = bnxt_get_avail_msix(bp, bp->ulp_num_msix_want);
 
 		if (ulp_msix > bp->ulp_num_msix_want)
@@ -14653,7 +14655,7 @@ int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
 		hwr.cp_p5 = hwr.tx + rx;
 	rc = bnxt_hwrm_check_rings(bp, &hwr);
 	if (!rc && pci_msix_can_alloc_dyn(bp->pdev)) {
-		if (!bnxt_ulp_registered(bp->edev)) {
+		if (!bnxt_ulp_registered(bp->edev[BNXT_AUXDEV_RDMA])) {
 			hwr.cp += bnxt_get_ulp_msix_num(bp);
 			hwr.cp = min_t(int, hwr.cp, bnxt_get_max_func_irqs(bp));
 		}
@@ -16185,12 +16187,13 @@ static void bnxt_remove_one(struct pci_dev *pdev)
 	if (BNXT_PF(bp))
 		__bnxt_sriov_disable(bp);
 
-	bnxt_rdma_aux_device_del(bp);
+	bnxt_aux_device_del(bp, BNXT_AUXDEV_RDMA);
 
 	unregister_netdev(dev);
 	bnxt_ptp_clear(bp);
 
-	bnxt_rdma_aux_device_uninit(bp);
+	bnxt_aux_device_uninit(bp, BNXT_AUXDEV_RDMA);
+	bnxt_auxdev_id_free(bp, bp->auxdev_id);
 
 	bnxt_free_l2_filters(bp, true);
 	bnxt_free_ntp_fltrs(bp, true);
@@ -16776,7 +16779,8 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	bnxt_set_tpa_flags(bp);
 	bnxt_init_ring_params(bp);
 	bnxt_set_ring_params(bp);
-	bnxt_rdma_aux_device_init(bp);
+	if (!bnxt_auxdev_id_alloc(bp))
+		bnxt_aux_device_init(bp, BNXT_AUXDEV_RDMA);
 	rc = bnxt_set_dflt_rings(bp, true);
 	if (rc) {
 		if (BNXT_VF(bp) && rc == -ENODEV) {
@@ -16840,7 +16844,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	bnxt_dl_fw_reporters_create(bp);
 
-	bnxt_rdma_aux_device_add(bp);
+	bnxt_aux_device_add(bp, BNXT_AUXDEV_RDMA);
 
 	bnxt_print_device_info(bp);
 
@@ -16848,7 +16852,8 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	return 0;
 init_err_cleanup:
-	bnxt_rdma_aux_device_uninit(bp);
+	bnxt_aux_device_uninit(bp, BNXT_AUXDEV_RDMA);
+	bnxt_auxdev_id_free(bp, bp->auxdev_id);
 	bnxt_dl_unregister(bp);
 init_err_dl:
 	bnxt_shutdown_tc(bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 741b2d854789..e0c3ad6a76bf 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -24,12 +24,12 @@
 #include <linux/interrupt.h>
 #include <linux/rhashtable.h>
 #include <linux/crash_dump.h>
-#include <linux/auxiliary_bus.h>
 #include <net/devlink.h>
 #include <net/dst_metadata.h>
 #include <net/xdp.h>
 #include <linux/dim.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/bnxt/ulp.h>
 #ifdef CONFIG_TEE_BNXT_FW
 #include <linux/firmware/broadcom/tee_bnxt_fw.h>
 #endif
@@ -2075,12 +2075,6 @@ struct bnxt_fw_health {
 #define BNXT_FW_IF_RETRY		10
 #define BNXT_FW_SLOT_RESET_RETRY	4
 
-struct bnxt_aux_priv {
-	struct auxiliary_device aux_dev;
-	struct bnxt_en_dev *edev;
-	int id;
-};
-
 enum board_idx {
 	BCM57301,
 	BCM57302,
@@ -2340,8 +2334,8 @@ struct bnxt {
 #define BNXT_CHIP_P5_AND_MINUS(bp)		\
 	(BNXT_CHIP_P3(bp) || BNXT_CHIP_P4(bp) || BNXT_CHIP_P5(bp))
 
-	struct bnxt_aux_priv	*aux_priv;
-	struct bnxt_en_dev	*edev;
+	struct bnxt_aux_priv	*aux_priv[__BNXT_AUXDEV_MAX];
+	struct bnxt_en_dev	*edev[__BNXT_AUXDEV_MAX];
 
 	struct bnxt_napi	**bnapi;
 
@@ -2748,6 +2742,7 @@ struct bnxt {
 	struct bnxt_ctx_pg_info	*fw_crash_mem;
 	u32			fw_crash_len;
 	struct bnxt_bs_trace_info bs_trace[BNXT_TRACE_MAX];
+	int			auxdev_id;
 };
 
 #define BNXT_NUM_RX_RING_STATS			8
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 818bd0fa0a7d..57f7303e3465 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -5086,7 +5086,7 @@ static void bnxt_self_test(struct net_device *dev, struct ethtool_test *etest,
 
 	memset(buf, 0, sizeof(u64) * bp->num_tests);
 	if (etest->flags & ETH_TEST_FL_OFFLINE &&
-	    bnxt_ulp_registered(bp->edev)) {
+	    bnxt_ulp_registered(bp->edev[BNXT_AUXDEV_RDMA])) {
 		etest->flags |= ETH_TEST_FL_FAILED;
 		netdev_warn(dev, "Offline tests cannot be run with RoCE driver loaded\n");
 		return;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index 56a35c65d193..e15cf4774e9b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -29,9 +29,17 @@
 
 static DEFINE_IDA(bnxt_aux_dev_ids);
 
+struct bnxt_aux_device {
+	const char *name;
+};
+
+static struct bnxt_aux_device bnxt_aux_devices[__BNXT_AUXDEV_MAX] = {{
+	.name		= "rdma",
+}};
+
 static void bnxt_fill_msix_vecs(struct bnxt *bp, struct bnxt_msix_entry *ent)
 {
-	struct bnxt_en_dev *edev = bp->edev;
+	struct bnxt_en_dev *edev = bp->edev[BNXT_AUXDEV_RDMA];
 	int num_msix, i;
 
 	if (!edev->ulp_tbl->msix_requested) {
@@ -51,61 +59,75 @@ static void bnxt_fill_msix_vecs(struct bnxt *bp, struct bnxt_msix_entry *ent)
 
 int bnxt_get_ulp_msix_num(struct bnxt *bp)
 {
-	if (bp->edev)
-		return bp->edev->ulp_num_msix_vec;
+	struct bnxt_en_dev *edev = bp->edev[BNXT_AUXDEV_RDMA];
+
+	if (edev)
+		return edev->ulp_num_msix_vec;
 	return 0;
 }
 
 void bnxt_set_ulp_msix_num(struct bnxt *bp, int num)
 {
-	if (bp->edev)
-		bp->edev->ulp_num_msix_vec = num;
+	struct bnxt_en_dev *edev = bp->edev[BNXT_AUXDEV_RDMA];
+
+	if (edev)
+		edev->ulp_num_msix_vec = num;
 }
 
 int bnxt_get_ulp_msix_num_in_use(struct bnxt *bp)
 {
-	if (bnxt_ulp_registered(bp->edev))
-		return bp->edev->ulp_num_msix_vec;
+	struct bnxt_en_dev *edev = bp->edev[BNXT_AUXDEV_RDMA];
+
+	if (bnxt_ulp_registered(edev))
+		return edev->ulp_num_msix_vec;
 	return 0;
 }
 
 int bnxt_get_ulp_stat_ctxs(struct bnxt *bp)
 {
-	if (bp->edev)
-		return bp->edev->ulp_num_ctxs;
+	struct bnxt_en_dev *edev = bp->edev[BNXT_AUXDEV_RDMA];
+
+	if (edev)
+		return edev->ulp_num_ctxs;
 	return 0;
 }
 
 void bnxt_set_ulp_stat_ctxs(struct bnxt *bp, int num_ulp_ctx)
 {
-	if (bp->edev)
-		bp->edev->ulp_num_ctxs = num_ulp_ctx;
+	struct bnxt_en_dev *edev = bp->edev[BNXT_AUXDEV_RDMA];
+
+	if (edev)
+		edev->ulp_num_ctxs = num_ulp_ctx;
 }
 
 int bnxt_get_ulp_stat_ctxs_in_use(struct bnxt *bp)
 {
-	if (bnxt_ulp_registered(bp->edev))
-		return bp->edev->ulp_num_ctxs;
+	struct bnxt_en_dev *edev = bp->edev[BNXT_AUXDEV_RDMA];
+
+	if (bnxt_ulp_registered(edev))
+		return edev->ulp_num_ctxs;
 	return 0;
 }
 
 void bnxt_set_dflt_ulp_stat_ctxs(struct bnxt *bp)
 {
-	if (bp->edev) {
-		bp->edev->ulp_num_ctxs = BNXT_MIN_ROCE_STAT_CTXS;
+	struct bnxt_en_dev *edev = bp->edev[BNXT_AUXDEV_RDMA];
+
+	if (edev) {
+		edev->ulp_num_ctxs = BNXT_MIN_ROCE_STAT_CTXS;
 		/* Reserve one additional stat_ctx for PF0 (except
 		 * on 1-port NICs) as it also creates one stat_ctx
 		 * for PF1 in case of RoCE bonding.
 		 */
 		if (BNXT_PF(bp) && !bp->pf.port_id &&
 		    bp->port_count > 1)
-			bp->edev->ulp_num_ctxs++;
+			edev->ulp_num_ctxs++;
 
 		/* Reserve one additional stat_ctx when the device is capable
 		 * of supporting port mirroring on RDMA device.
 		 */
 		if (BNXT_MIRROR_ON_ROCE_CAP(bp))
-			bp->edev->ulp_num_ctxs++;
+			edev->ulp_num_ctxs++;
 	}
 }
 
@@ -141,7 +163,7 @@ int bnxt_register_dev(struct bnxt_en_dev *edev,
 
 	edev->ulp_tbl->msix_requested = bnxt_get_ulp_msix_num(bp);
 
-	bnxt_fill_msix_vecs(bp, bp->edev->msix_entries);
+	bnxt_fill_msix_vecs(bp, edev->msix_entries);
 	edev->flags |= BNXT_EN_FLAG_MSIX_REQUESTED;
 exit:
 	mutex_unlock(&edev->en_dev_lock);
@@ -230,78 +252,88 @@ EXPORT_SYMBOL(bnxt_send_msg);
 
 void bnxt_ulp_stop(struct bnxt *bp)
 {
-	struct bnxt_aux_priv *aux_priv = bp->aux_priv;
-	struct bnxt_en_dev *edev = bp->edev;
+	int i;
 
-	if (!edev)
-		return;
+	for (i = 0; i < __BNXT_AUXDEV_MAX; i++) {
+		struct bnxt_aux_priv *aux_priv = bp->aux_priv[i];
+		struct bnxt_en_dev *edev = bp->edev[i];
 
-	mutex_lock(&edev->en_dev_lock);
-	if (!bnxt_ulp_registered(edev) ||
-	    (edev->flags & BNXT_EN_FLAG_ULP_STOPPED))
-		goto ulp_stop_exit;
-
-	edev->flags |= BNXT_EN_FLAG_ULP_STOPPED;
-	if (aux_priv) {
-		struct auxiliary_device *adev;
-
-		adev = &aux_priv->aux_dev;
-		if (adev->dev.driver) {
-			const struct auxiliary_driver *adrv;
-			pm_message_t pm = {};
-
-			adrv = to_auxiliary_drv(adev->dev.driver);
-			edev->en_state = bp->state;
-			adrv->suspend(adev, pm);
+		if (!edev)
+			continue;
+
+		mutex_lock(&edev->en_dev_lock);
+		if (!bnxt_ulp_registered(edev) ||
+		    (edev->flags & BNXT_EN_FLAG_ULP_STOPPED)) {
+			mutex_unlock(&edev->en_dev_lock);
+			continue;
 		}
+
+		edev->flags |= BNXT_EN_FLAG_ULP_STOPPED;
+		if (aux_priv) {
+			struct auxiliary_device *adev;
+
+			adev = &aux_priv->aux_dev;
+			if (adev->dev.driver) {
+				const struct auxiliary_driver *adrv;
+				pm_message_t pm = {};
+
+				adrv = to_auxiliary_drv(adev->dev.driver);
+				edev->en_state = bp->state;
+				adrv->suspend(adev, pm);
+			}
+		}
+		mutex_unlock(&edev->en_dev_lock);
 	}
-ulp_stop_exit:
-	mutex_unlock(&edev->en_dev_lock);
 }
 
 void bnxt_ulp_start(struct bnxt *bp, int err)
 {
-	struct bnxt_aux_priv *aux_priv = bp->aux_priv;
-	struct bnxt_en_dev *edev = bp->edev;
+	int i;
 
-	if (!edev || err)
-		return;
+	for (i = 0; i < __BNXT_AUXDEV_MAX; i++) {
+		struct bnxt_aux_priv *aux_priv = bp->aux_priv[i];
+		struct bnxt_en_dev *edev = bp->edev[i];
 
-	mutex_lock(&edev->en_dev_lock);
-	if (!bnxt_ulp_registered(edev) ||
-	    !(edev->flags & BNXT_EN_FLAG_ULP_STOPPED))
-		goto ulp_start_exit;
+		if (!edev || err)
+			return;
 
-	if (edev->ulp_tbl->msix_requested)
-		bnxt_fill_msix_vecs(bp, edev->msix_entries);
+		mutex_lock(&edev->en_dev_lock);
+		if (!bnxt_ulp_registered(edev) ||
+		    !(edev->flags & BNXT_EN_FLAG_ULP_STOPPED)) {
+			goto clear_flag_continue;
+		}
 
-	if (aux_priv) {
-		struct auxiliary_device *adev;
+		if (edev->ulp_tbl->msix_requested)
+			bnxt_fill_msix_vecs(bp, edev->msix_entries);
 
-		adev = &aux_priv->aux_dev;
-		if (adev->dev.driver) {
-			const struct auxiliary_driver *adrv;
+		if (aux_priv) {
+			struct auxiliary_device *adev;
 
-			adrv = to_auxiliary_drv(adev->dev.driver);
-			edev->en_state = bp->state;
-			adrv->resume(adev);
+			adev = &aux_priv->aux_dev;
+			if (adev->dev.driver) {
+				const struct auxiliary_driver *adrv;
+
+				adrv = to_auxiliary_drv(adev->dev.driver);
+				edev->en_state = bp->state;
+				adrv->resume(adev);
+			}
 		}
+clear_flag_continue:
+		edev->flags &= ~BNXT_EN_FLAG_ULP_STOPPED;
+		mutex_unlock(&edev->en_dev_lock);
 	}
-ulp_start_exit:
-	edev->flags &= ~BNXT_EN_FLAG_ULP_STOPPED;
-	mutex_unlock(&edev->en_dev_lock);
 }
 
 void bnxt_ulp_irq_stop(struct bnxt *bp)
 {
-	struct bnxt_en_dev *edev = bp->edev;
+	struct bnxt_en_dev *edev = bp->edev[BNXT_AUXDEV_RDMA];
 	struct bnxt_ulp_ops *ops;
 	bool reset = false;
 
 	if (!edev || !(edev->flags & BNXT_EN_FLAG_MSIX_REQUESTED))
 		return;
 
-	if (bnxt_ulp_registered(bp->edev)) {
+	if (bnxt_ulp_registered(edev)) {
 		struct bnxt_ulp *ulp = edev->ulp_tbl;
 
 		if (!ulp->msix_requested)
@@ -318,13 +350,13 @@ void bnxt_ulp_irq_stop(struct bnxt *bp)
 
 void bnxt_ulp_irq_restart(struct bnxt *bp, int err)
 {
-	struct bnxt_en_dev *edev = bp->edev;
+	struct bnxt_en_dev *edev = bp->edev[BNXT_AUXDEV_RDMA];
 	struct bnxt_ulp_ops *ops;
 
 	if (!edev || !(edev->flags & BNXT_EN_FLAG_MSIX_REQUESTED))
 		return;
 
-	if (bnxt_ulp_registered(bp->edev)) {
+	if (bnxt_ulp_registered(edev)) {
 		struct bnxt_ulp *ulp = edev->ulp_tbl;
 		struct bnxt_msix_entry *ent = NULL;
 
@@ -350,7 +382,7 @@ void bnxt_ulp_irq_restart(struct bnxt *bp, int err)
 void bnxt_ulp_async_events(struct bnxt *bp, struct hwrm_async_event_cmpl *cmpl)
 {
 	u16 event_id = le16_to_cpu(cmpl->event_id);
-	struct bnxt_en_dev *edev = bp->edev;
+	struct bnxt_en_dev *edev = bp->edev[BNXT_AUXDEV_RDMA];
 	struct bnxt_ulp_ops *ops;
 	struct bnxt_ulp *ulp;
 
@@ -391,16 +423,16 @@ void bnxt_register_async_events(struct bnxt_en_dev *edev,
 }
 EXPORT_SYMBOL(bnxt_register_async_events);
 
-void bnxt_rdma_aux_device_uninit(struct bnxt *bp)
+void bnxt_aux_device_uninit(struct bnxt *bp, enum bnxt_auxdev_type idx)
 {
 	struct bnxt_aux_priv *aux_priv;
 	struct auxiliary_device *adev;
 
 	/* Skip if no auxiliary device init was done. */
-	if (!bp->aux_priv)
+	if (!bp->aux_priv[idx])
 		return;
 
-	aux_priv = bp->aux_priv;
+	aux_priv = bp->aux_priv[idx];
 	adev = &aux_priv->aux_dev;
 	auxiliary_device_uninit(adev);
 }
@@ -411,20 +443,19 @@ static void bnxt_aux_dev_release(struct device *dev)
 		container_of(dev, struct bnxt_aux_priv, aux_dev.dev);
 	struct bnxt *bp = netdev_priv(aux_priv->edev->net);
 
-	ida_free(&bnxt_aux_dev_ids, aux_priv->id);
 	kfree(aux_priv->edev->ulp_tbl);
-	bp->edev = NULL;
+	bp->edev[aux_priv->id] = NULL;
 	kfree(aux_priv->edev);
 	kfree(aux_priv);
-	bp->aux_priv = NULL;
+	bp->aux_priv[aux_priv->id] = NULL;
 }
 
-void bnxt_rdma_aux_device_del(struct bnxt *bp)
+void bnxt_aux_device_del(struct bnxt *bp, enum bnxt_auxdev_type idx)
 {
-	if (!bp->edev)
+	if (!bp->edev[idx])
 		return;
 
-	auxiliary_device_delete(&bp->aux_priv->aux_dev);
+	auxiliary_device_delete(&bp->aux_priv[idx]->aux_dev);
 }
 
 static void bnxt_set_edev_info(struct bnxt_en_dev *edev, struct bnxt *bp)
@@ -454,59 +485,52 @@ static void bnxt_set_edev_info(struct bnxt_en_dev *edev, struct bnxt *bp)
 	edev->bar0 = bp->bar0;
 }
 
-void bnxt_rdma_aux_device_add(struct bnxt *bp)
+void bnxt_aux_device_add(struct bnxt *bp, enum bnxt_auxdev_type idx)
 {
 	struct auxiliary_device *aux_dev;
 	int rc;
 
-	if (!bp->edev)
+	if (!bp->edev[idx])
 		return;
 
-	aux_dev = &bp->aux_priv->aux_dev;
+	aux_dev = &bp->aux_priv[idx]->aux_dev;
 	rc = auxiliary_device_add(aux_dev);
 	if (rc) {
 		netdev_warn(bp->dev, "Failed to add auxiliary device for ROCE\n");
 		auxiliary_device_uninit(aux_dev);
-		bp->flags &= ~BNXT_FLAG_ROCE_CAP;
+		if (idx == BNXT_AUXDEV_RDMA)
+			bp->flags &= ~BNXT_FLAG_ROCE_CAP;
 	}
 }
 
-void bnxt_rdma_aux_device_init(struct bnxt *bp)
+void bnxt_aux_device_init(struct bnxt *bp, enum bnxt_auxdev_type idx)
 {
+	const char *name = bnxt_aux_devices[idx].name;
 	struct auxiliary_device *aux_dev;
 	struct bnxt_aux_priv *aux_priv;
 	struct bnxt_en_dev *edev;
 	struct bnxt_ulp *ulp;
 	int rc;
 
-	if (!(bp->flags & BNXT_FLAG_ROCE_CAP))
+	if (idx == BNXT_AUXDEV_RDMA && !(bp->flags & BNXT_FLAG_ROCE_CAP))
 		return;
 
-	aux_priv = kzalloc(sizeof(*bp->aux_priv), GFP_KERNEL);
+	aux_priv = kzalloc(sizeof(**bp->aux_priv), GFP_KERNEL);
 	if (!aux_priv)
 		goto exit;
 
-	aux_priv->id = ida_alloc(&bnxt_aux_dev_ids, GFP_KERNEL);
-	if (aux_priv->id < 0) {
-		netdev_warn(bp->dev,
-			    "ida alloc failed for ROCE auxiliary device\n");
-		kfree(aux_priv);
-		goto exit;
-	}
-
 	aux_dev = &aux_priv->aux_dev;
-	aux_dev->id = aux_priv->id;
-	aux_dev->name = "rdma";
+	aux_dev->id = bp->auxdev_id;
+	aux_dev->name = name;
 	aux_dev->dev.parent = &bp->pdev->dev;
 	aux_dev->dev.release = bnxt_aux_dev_release;
 
 	rc = auxiliary_device_init(aux_dev);
 	if (rc) {
-		ida_free(&bnxt_aux_dev_ids, aux_priv->id);
 		kfree(aux_priv);
 		goto exit;
 	}
-	bp->aux_priv = aux_priv;
+	bp->aux_priv[idx] = aux_priv;
 
 	/* From this point, all cleanup will happen via the .release callback &
 	 * any error unwinding will need to include a call to
@@ -523,14 +547,32 @@ void bnxt_rdma_aux_device_init(struct bnxt *bp)
 		goto aux_dev_uninit;
 
 	edev->ulp_tbl = ulp;
-	bp->edev = edev;
+	bp->edev[idx] = edev;
 	bnxt_set_edev_info(edev, bp);
-	bp->ulp_num_msix_want = bnxt_set_dflt_ulp_msix(bp);
+	if (idx == BNXT_AUXDEV_RDMA)
+		bp->ulp_num_msix_want = bnxt_set_dflt_ulp_msix(bp);
+	aux_priv->id = idx;
 
 	return;
 
 aux_dev_uninit:
 	auxiliary_device_uninit(aux_dev);
 exit:
-	bp->flags &= ~BNXT_FLAG_ROCE_CAP;
+	if (idx == BNXT_AUXDEV_RDMA)
+		bp->flags &= ~BNXT_FLAG_ROCE_CAP;
+}
+
+int bnxt_auxdev_id_alloc(struct bnxt *bp)
+{
+	bp->auxdev_id = ida_alloc(&bnxt_aux_dev_ids, GFP_KERNEL);
+	if (bp->auxdev_id < 0)
+		return bp->auxdev_id;
+
+	return 0;
+}
+
+void bnxt_auxdev_id_free(struct bnxt *bp, int id)
+{
+	if (bp->auxdev_id >= 0)
+		ida_free(&bnxt_aux_dev_ids, id);
 }
diff --git a/include/linux/bnxt/ulp.h b/include/linux/bnxt/ulp.h
index 7b9dd8ebe4bc..99cd872f6605 100644
--- a/include/linux/bnxt/ulp.h
+++ b/include/linux/bnxt/ulp.h
@@ -10,6 +10,8 @@
 #ifndef BNXT_ULP_H
 #define BNXT_ULP_H
 
+#include <linux/auxiliary_bus.h>
+
 #define BNXT_MIN_ROCE_CP_RINGS	2
 #define BNXT_MIN_ROCE_STAT_CTXS	1
 
@@ -20,6 +22,17 @@
 struct hwrm_async_event_cmpl;
 struct bnxt;
 
+enum bnxt_auxdev_type {
+	BNXT_AUXDEV_RDMA = 0,
+	__BNXT_AUXDEV_MAX
+};
+
+struct bnxt_aux_priv {
+	struct auxiliary_device aux_dev;
+	struct bnxt_en_dev *edev;
+	int id;
+};
+
 struct bnxt_msix_entry {
 	u32	vector;
 	u32	ring_idx;
@@ -116,14 +129,16 @@ void bnxt_ulp_sriov_cfg(struct bnxt *bp, int num_vfs);
 void bnxt_ulp_irq_stop(struct bnxt *bp);
 void bnxt_ulp_irq_restart(struct bnxt *bp, int err);
 void bnxt_ulp_async_events(struct bnxt *bp, struct hwrm_async_event_cmpl *cmpl);
-void bnxt_rdma_aux_device_uninit(struct bnxt *bp);
-void bnxt_rdma_aux_device_del(struct bnxt *bp);
-void bnxt_rdma_aux_device_add(struct bnxt *bp);
-void bnxt_rdma_aux_device_init(struct bnxt *bp);
+void bnxt_aux_device_uninit(struct bnxt *bp, enum bnxt_auxdev_type idx);
+void bnxt_aux_device_del(struct bnxt *bp, enum bnxt_auxdev_type idx);
+void bnxt_aux_device_add(struct bnxt *bp, enum bnxt_auxdev_type idx);
+void bnxt_aux_device_init(struct bnxt *bp, enum bnxt_auxdev_type idx);
 int bnxt_register_dev(struct bnxt_en_dev *edev, struct bnxt_ulp_ops *ulp_ops,
 		      void *handle);
 void bnxt_unregister_dev(struct bnxt_en_dev *edev);
 int bnxt_send_msg(struct bnxt_en_dev *edev, struct bnxt_fw_msg *fw_msg);
 void bnxt_register_async_events(struct bnxt_en_dev *edev,
 				unsigned long *events_bmap, u16 max_id);
+int bnxt_auxdev_id_alloc(struct bnxt *bp);
+void bnxt_auxdev_id_free(struct bnxt *bp, int id);
 #endif
-- 
2.39.1



Return-Path: <netdev+bounces-81837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9F188B422
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 23:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDAFB1C319C0
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 22:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E932684D11;
	Mon, 25 Mar 2024 22:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hkgsN2rC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F277C84D06
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 22:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711405788; cv=none; b=PF2KILDH24/YMDDmMEecy85UqmIfOj8BoWVnwsxhmbZuKMvOAp+9D3WxVobuGtCIBuL1pa6Hb4PxBf+H72nEiiJlEcxY2o0dcMjnnlvoABzoQ4Be4kO1Nnsn+2TfzmGch0gGK2koq+Bf3AU0kBoOcxyT70n/D3gxXt2DGaeGkOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711405788; c=relaxed/simple;
	bh=df8ybIuvcKnjRr/lLpeRUVsRU5mDmZt9SgRDnvSX1Ow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W+5FUiQC2Uxv8m/uWo7N8jpB7KCDsSo58S/vS6FYwpM7dw1qWejG1q7/dC54Oz+XN8aK8Zef62PBa0T1dPkZ/fjxokEkmmcBszhAC9b7GQH/RafFiQUuQOUmS8okstKKhP/v26Ar+JW57MSjOvnwp3YYp/ehCSps8PSkeYryt24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hkgsN2rC; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-222c0572eedso2630553fac.3
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 15:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1711405786; x=1712010586; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7SrR+y/h6fwYdN5MpSHpJC+aO7tm21vLnnot9ExWza8=;
        b=hkgsN2rCUDtXwVRUquryYamIIldd2r+Ve9FpolWLTH4fCC3Cc7yxIapZQW7OF2K9LZ
         X0KfNec0cTtekmmdIZN/SarvOlaDlbnhIX8Oev8OfwwNohIGN7H9FeEkG0zZwjq1sXab
         fL+03J7vFxlndke64IFyuilGR5r7yGPThdk/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711405786; x=1712010586;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7SrR+y/h6fwYdN5MpSHpJC+aO7tm21vLnnot9ExWza8=;
        b=bQTfnwkk6OJ68BHMUIK5HEcRYanZwjaToCjhWIDn1vEvF9fOuVJShQ4aKGv3p1fCol
         fxle7mn0jLxM0ksEUygSGBpSP1AvLdJ92554lZLe8/GeNP6BLBdZbUHxQNASMHS+YVzU
         xfoYv/Y3mjaOz0v7Rjq0YrUMYSIpWW6lL2dlIRGzhdzVQXvbbD268ZG9UHTU6eVXDjGz
         MrqPWNDz72h+93uaiq2IcZBpv63pQu/DBjzfClXV/1bRZykKfYQ+kTpF7anFwsYdqVlH
         TncTl4GgC1FYOZmsCBfWFy6/z3zHTpslU8ZbL8KPNh3+19HGaNclff4nvrnGTSvGL3on
         oNig==
X-Gm-Message-State: AOJu0YyMsRLyj9esaNMJLga6iA4G+BrV6sJWm/zVlsIQPvyI5YtQZQ0A
	KmjoklqcQhduT9yfXDETLEG3ALL5YnQaxLfsmyPYN99xGYipEHMIC0GZk8D4sw==
X-Google-Smtp-Source: AGHT+IGYA1oYF+poY6d//OT7+zd6fYtx/2UMRzt+NjouyqAT06LeXD0SZgvgD0XNkppe9o+WnaqpRg==
X-Received: by 2002:a05:6870:938b:b0:229:f9fa:df52 with SMTP id b11-20020a056870938b00b00229f9fadf52mr10314939oal.12.1711405785780;
        Mon, 25 Mar 2024 15:29:45 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id t10-20020a63dd0a000000b005e438fe702dsm6301610pgg.65.2024.03.25.15.29.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2024 15:29:44 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next 10/12] bnxt_en: Support RSS contexts in ethtool .{get|set}_rxfh()
Date: Mon, 25 Mar 2024 15:29:00 -0700
Message-Id: <20240325222902.220712-11-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240325222902.220712-1-michael.chan@broadcom.com>
References: <20240325222902.220712-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f86c7c061483b571"

--000000000000f86c7c061483b571
Content-Transfer-Encoding: 8bit

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

Support up to 32 RSS contexts per device if supported by the device.

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  49 +++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   7 +
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 148 +++++++++++++++++-
 3 files changed, 196 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c5f3b97d258d..8aa3db2ceece 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -5939,8 +5939,8 @@ static void bnxt_hwrm_vnic_update_tunl_tpa(struct bnxt *bp,
 	req->tnl_tpa_en_bitmap = cpu_to_le32(tunl_tpa_bmap);
 }
 
-static int bnxt_hwrm_vnic_set_tpa(struct bnxt *bp, struct bnxt_vnic_info *vnic,
-				  u32 tpa_flags)
+int bnxt_hwrm_vnic_set_tpa(struct bnxt *bp, struct bnxt_vnic_info *vnic,
+			   u32 tpa_flags)
 {
 	u16 max_aggs = VNIC_TPA_CFG_REQ_MAX_AGGS_MAX;
 	struct hwrm_vnic_tpa_cfg_input *req;
@@ -6129,6 +6129,8 @@ static void bnxt_fill_hw_rss_tbl_p5(struct bnxt *bp,
 
 		if (vnic->flags & BNXT_VNIC_NTUPLE_FLAG)
 			j = ethtool_rxfh_indir_default(i, bp->rx_nr_rings);
+		else if (vnic->flags & BNXT_VNIC_RSSCTX_FLAG)
+			j = vnic->rss_ctx->rss_indir_tbl[i];
 		else
 			j = bp->rss_indir_tbl[i];
 		rxr = &bp->rx_ring[j];
@@ -6423,9 +6425,9 @@ static void bnxt_hwrm_vnic_free(struct bnxt *bp)
 		bnxt_hwrm_vnic_free_one(bp, &bp->vnic_info[i]);
 }
 
-static int bnxt_hwrm_vnic_alloc(struct bnxt *bp, struct bnxt_vnic_info *vnic,
-				unsigned int start_rx_ring_idx,
-				unsigned int nr_rings)
+int bnxt_hwrm_vnic_alloc(struct bnxt *bp, struct bnxt_vnic_info *vnic,
+			 unsigned int start_rx_ring_idx,
+			 unsigned int nr_rings)
 {
 	unsigned int i, j, grp_idx, end_idx = start_rx_ring_idx + nr_rings;
 	struct hwrm_vnic_alloc_output *resp;
@@ -9852,7 +9854,7 @@ int bnxt_hwrm_vnic_rss_cfg_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 	return rc;
 }
 
-static int __bnxt_setup_vnic_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic)
+int __bnxt_setup_vnic_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 {
 	int rc, i, nr_ctxs;
 
@@ -9939,15 +9941,46 @@ static int bnxt_alloc_rfs_vnics(struct bnxt *bp)
 void bnxt_del_one_rss_ctx(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
 			  bool all)
 {
+	struct bnxt_vnic_info *vnic = &rss_ctx->vnic;
+	int i;
+
+	bnxt_hwrm_vnic_free_one(bp, &rss_ctx->vnic);
+	for (i = 0; i < BNXT_MAX_CTX_PER_VNIC; i++) {
+		if (vnic->fw_rss_cos_lb_ctx[i] != INVALID_HW_RING_ID)
+			bnxt_hwrm_vnic_ctx_free_one(bp, vnic, i);
+	}
 	if (!all)
 		return;
 
+	if (vnic->rss_table)
+		dma_free_coherent(&bp->pdev->dev, vnic->rss_table_size,
+				  vnic->rss_table,
+				  vnic->rss_table_dma_addr);
+	kfree(rss_ctx->rss_indir_tbl);
 	list_del(&rss_ctx->list);
 	bp->num_rss_ctx--;
 	clear_bit(rss_ctx->index, bp->rss_ctx_bmap);
 	kfree(rss_ctx);
 }
 
+static void bnxt_hwrm_realloc_rss_ctx_vnic(struct bnxt *bp)
+{
+	bool set_tpa = !!(bp->flags & BNXT_FLAG_TPA);
+	struct bnxt_rss_ctx *rss_ctx, *tmp;
+
+	list_for_each_entry_safe(rss_ctx, tmp, &bp->rss_ctx_list, list) {
+		struct bnxt_vnic_info *vnic = &rss_ctx->vnic;
+
+		if (bnxt_hwrm_vnic_alloc(bp, vnic, 0, bp->rx_nr_rings) ||
+		    bnxt_hwrm_vnic_set_tpa(bp, vnic, set_tpa) ||
+		    __bnxt_setup_vnic_p5(bp, vnic)) {
+			netdev_err(bp->dev, "Failed to restore RSS ctx %d\n",
+				   rss_ctx->index);
+			bnxt_del_one_rss_ctx(bp, rss_ctx, true);
+		}
+	}
+}
+
 struct bnxt_rss_ctx *bnxt_alloc_rss_ctx(struct bnxt *bp)
 {
 	struct bnxt_rss_ctx *rss_ctx = NULL;
@@ -11829,6 +11862,8 @@ static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 		bnxt_vf_reps_open(bp);
 	bnxt_ptp_init_rtc(bp, true);
 	bnxt_ptp_cfg_tstamp_filters(bp);
+	if (BNXT_SUPPORTS_MULTI_RSS_CTX(bp))
+		bnxt_hwrm_realloc_rss_ctx_vnic(bp);
 	bnxt_cfg_usr_fltrs(bp);
 	return 0;
 
@@ -11977,6 +12012,8 @@ static void __bnxt_close_nic(struct bnxt *bp, bool irq_re_init,
 	while (bnxt_drv_busy(bp))
 		msleep(20);
 
+	if (BNXT_SUPPORTS_MULTI_RSS_CTX(bp))
+		bnxt_clear_rss_ctxs(bp, false);
 	/* Flush rings and disable interrupts */
 	bnxt_shutdown_nic(bp, irq_re_init);
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index d5fbb63a0e0c..37a850959315 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1270,6 +1270,7 @@ struct bnxt_rss_ctx {
 
 #define BNXT_MAX_ETH_RSS_CTX	32
 #define BNXT_RSS_CTX_BMAP_LEN	(BNXT_MAX_ETH_RSS_CTX + 1)
+#define BNXT_VNIC_ID_INVALID	0xffffffff
 
 struct bnxt_hw_rings {
 	int tx;
@@ -2714,11 +2715,16 @@ int bnxt_hwrm_cfa_ntuple_filter_free(struct bnxt *bp,
 				     struct bnxt_ntuple_filter *fltr);
 int bnxt_hwrm_cfa_ntuple_filter_alloc(struct bnxt *bp,
 				      struct bnxt_ntuple_filter *fltr);
+int bnxt_hwrm_vnic_set_tpa(struct bnxt *bp, struct bnxt_vnic_info *vnic,
+			   u32 tpa_flags);
 void bnxt_fill_ipv6_mask(__be32 mask[4]);
 int bnxt_alloc_rss_indir_tbl(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx);
 void bnxt_set_dflt_rss_indir_tbl(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx);
 int bnxt_get_nr_rss_ctxs(struct bnxt *bp, int rx_rings);
 int bnxt_hwrm_vnic_cfg(struct bnxt *bp, struct bnxt_vnic_info *vnic);
+int bnxt_hwrm_vnic_alloc(struct bnxt *bp, struct bnxt_vnic_info *vnic,
+			 unsigned int start_rx_ring_idx,
+			 unsigned int nr_rings);
 int __bnxt_hwrm_get_tx_rings(struct bnxt *bp, u16 fid, int *tx_rings);
 int bnxt_nq_rings_in_use(struct bnxt *bp);
 int bnxt_hwrm_set_coal(struct bnxt *);
@@ -2745,6 +2751,7 @@ int bnxt_hwrm_func_resc_qcaps(struct bnxt *bp, bool all);
 int bnxt_hwrm_func_qcaps(struct bnxt *bp);
 int bnxt_hwrm_fw_set_time(struct bnxt *);
 int bnxt_hwrm_vnic_rss_cfg_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic);
+int __bnxt_setup_vnic_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic);
 void bnxt_del_one_rss_ctx(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
 			  bool all);
 struct bnxt_rss_ctx *bnxt_alloc_rss_ctx(struct bnxt *bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 7f57198f5834..4dbe80b11dda 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1207,6 +1207,36 @@ static int bnxt_grxclsrule(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 	return rc;
 }
 
+static struct bnxt_rss_ctx *bnxt_get_rss_ctx_from_index(struct bnxt *bp,
+							u32 index)
+{
+	struct bnxt_rss_ctx *rss_ctx, *tmp;
+
+	list_for_each_entry_safe(rss_ctx, tmp, &bp->rss_ctx_list, list)
+		if (rss_ctx->index == index)
+			return rss_ctx;
+	return NULL;
+}
+
+static int bnxt_alloc_rss_ctx_rss_table(struct bnxt *bp,
+					struct bnxt_rss_ctx *rss_ctx)
+{
+	int size = L1_CACHE_ALIGN(BNXT_MAX_RSS_TABLE_SIZE_P5);
+	struct bnxt_vnic_info *vnic = &rss_ctx->vnic;
+
+	vnic->rss_table_size = size + HW_HASH_KEY_SIZE;
+	vnic->rss_table = dma_alloc_coherent(&bp->pdev->dev,
+					     vnic->rss_table_size,
+					     &vnic->rss_table_dma_addr,
+					     GFP_KERNEL);
+	if (!vnic->rss_table)
+		return -ENOMEM;
+
+	vnic->rss_hash_key = ((void *)vnic->rss_table) + size;
+	vnic->rss_hash_key_dma_addr = vnic->rss_table_dma_addr + size;
+	return 0;
+}
+
 static int bnxt_add_l2_cls_rule(struct bnxt *bp,
 				struct ethtool_rx_flow_spec *fs)
 {
@@ -1756,7 +1786,10 @@ static u32 bnxt_get_rxfh_key_size(struct net_device *dev)
 static int bnxt_get_rxfh(struct net_device *dev,
 			 struct ethtool_rxfh_param *rxfh)
 {
+	u32 rss_context = rxfh->rss_context;
+	struct bnxt_rss_ctx *rss_ctx = NULL;
 	struct bnxt *bp = netdev_priv(dev);
+	u16 *indir_tbl = bp->rss_indir_tbl;
 	struct bnxt_vnic_info *vnic;
 	u32 i, tbl_size;
 
@@ -1766,10 +1799,18 @@ static int bnxt_get_rxfh(struct net_device *dev,
 		return 0;
 
 	vnic = &bp->vnic_info[BNXT_VNIC_DEFAULT];
-	if (rxfh->indir && bp->rss_indir_tbl) {
+	if (rxfh->rss_context) {
+		rss_ctx = bnxt_get_rss_ctx_from_index(bp, rss_context);
+		if (!rss_ctx)
+			return -EINVAL;
+		indir_tbl = rss_ctx->rss_indir_tbl;
+		vnic = &rss_ctx->vnic;
+	}
+
+	if (rxfh->indir && indir_tbl) {
 		tbl_size = bnxt_get_rxfh_indir_size(dev);
 		for (i = 0; i < tbl_size; i++)
-			rxfh->indir[i] = bp->rss_indir_tbl[i];
+			rxfh->indir[i] = indir_tbl[i];
 	}
 
 	if (rxfh->key && vnic->rss_hash_key)
@@ -1804,6 +1845,105 @@ static void bnxt_modify_rss(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
 	}
 }
 
+static int bnxt_set_rxfh_context(struct bnxt *bp,
+				 struct ethtool_rxfh_param *rxfh,
+				 struct netlink_ext_ack *extack)
+{
+	u32 *rss_context = &rxfh->rss_context;
+	struct bnxt_rss_ctx *rss_ctx;
+	struct bnxt_vnic_info *vnic;
+	bool modify = false;
+	int bit_id;
+	int rc;
+
+	if (!BNXT_SUPPORTS_MULTI_RSS_CTX(bp)) {
+		NL_SET_ERR_MSG_MOD(extack, "RSS contexts not supported");
+		return -EOPNOTSUPP;
+	}
+
+	if (*rss_context != ETH_RXFH_CONTEXT_ALLOC) {
+		rss_ctx = bnxt_get_rss_ctx_from_index(bp, *rss_context);
+		if (!rss_ctx) {
+			NL_SET_ERR_MSG_FMT_MOD(extack, "RSS context %u not found",
+					       *rss_context);
+			return -EINVAL;
+		}
+		if (*rss_context && rxfh->rss_delete) {
+			bnxt_del_one_rss_ctx(bp, rss_ctx, true);
+			return 0;
+		}
+		modify = true;
+		vnic = &rss_ctx->vnic;
+		goto modify_context;
+	}
+
+	if (bp->num_rss_ctx >= BNXT_MAX_ETH_RSS_CTX) {
+		NL_SET_ERR_MSG_FMT_MOD(extack, "Out of RSS contexts, maximum %u",
+				       BNXT_MAX_ETH_RSS_CTX);
+		return -EINVAL;
+	}
+
+	if (!bnxt_rfs_capable(bp, true)) {
+		NL_SET_ERR_MSG_MOD(extack, "Out hardware resources");
+		return -ENOMEM;
+	}
+
+	rss_ctx = bnxt_alloc_rss_ctx(bp);
+	if (!rss_ctx)
+		return -ENOMEM;
+
+	vnic = &rss_ctx->vnic;
+	vnic->flags |= BNXT_VNIC_RSSCTX_FLAG;
+	vnic->vnic_id = BNXT_VNIC_ID_INVALID;
+	rc = bnxt_alloc_rss_ctx_rss_table(bp, rss_ctx);
+	if (rc)
+		goto out;
+
+	rc = bnxt_alloc_rss_indir_tbl(bp, rss_ctx);
+	if (rc)
+		goto out;
+
+	bnxt_set_dflt_rss_indir_tbl(bp, rss_ctx);
+	memcpy(vnic->rss_hash_key, bp->rss_hash_key, HW_HASH_KEY_SIZE);
+
+	rc = bnxt_hwrm_vnic_alloc(bp, vnic, 0, bp->rx_nr_rings);
+	if (rc) {
+		NL_SET_ERR_MSG_MOD(extack, "Unable to allocate VNIC");
+		goto out;
+	}
+
+	rc = bnxt_hwrm_vnic_set_tpa(bp, vnic, bp->flags & BNXT_FLAG_TPA);
+	if (rc) {
+		NL_SET_ERR_MSG_MOD(extack, "Unable to setup TPA");
+		goto out;
+	}
+modify_context:
+	bnxt_modify_rss(bp, rss_ctx, rxfh);
+
+	if (modify)
+		return bnxt_hwrm_vnic_rss_cfg_p5(bp, vnic);
+
+	rc = __bnxt_setup_vnic_p5(bp, vnic);
+	if (rc) {
+		NL_SET_ERR_MSG_MOD(extack, "Unable to setup TPA");
+		goto out;
+	}
+
+	bit_id = bitmap_find_free_region(bp->rss_ctx_bmap,
+					 BNXT_RSS_CTX_BMAP_LEN, 0);
+	if (bit_id < 0) {
+		rc = -ENOMEM;
+		goto out;
+	}
+	rss_ctx->index = (u16)bit_id;
+	*rss_context = rss_ctx->index;
+
+	return 0;
+out:
+	bnxt_del_one_rss_ctx(bp, rss_ctx, true);
+	return rc;
+}
+
 static int bnxt_set_rxfh(struct net_device *dev,
 			 struct ethtool_rxfh_param *rxfh,
 			 struct netlink_ext_ack *extack)
@@ -1814,6 +1954,9 @@ static int bnxt_set_rxfh(struct net_device *dev,
 	if (rxfh->hfunc && rxfh->hfunc != ETH_RSS_HASH_TOP)
 		return -EOPNOTSUPP;
 
+	if (rxfh->rss_context)
+		return bnxt_set_rxfh_context(bp, rxfh, extack);
+
 	bnxt_modify_rss(bp, NULL, rxfh);
 
 	bnxt_clear_usr_fltrs(bp, false);
@@ -5087,6 +5230,7 @@ void bnxt_ethtool_free(struct bnxt *bp)
 
 const struct ethtool_ops bnxt_ethtool_ops = {
 	.cap_link_lanes_supported	= 1,
+	.cap_rss_ctx_supported		= 1,
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES |
 				     ETHTOOL_COALESCE_USECS_IRQ |
-- 
2.30.1


--000000000000f86c7c061483b571
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIB7ygPkDkk4Oty6tx6VusX7d2f3Y229t
B9c/Y15B3PoLMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDMy
NTIyMjk0NlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAsiZATNYh9EXtchnIhx4VrLy1nX+c6fzoq7yfApz7y7CHdoPCw
H6/xeHzhecRJvortsQZK/D1ha4pFdc+NNhHBzLg/uclm793aXyIEWV9fnnBZ7u4POm2OiYv2a0rX
NUSU8i3XP2l6ny8ic5BNH5MMq/Rqv5KlJQOU7AXzoVmhTNWrks2EDSPtEFT+TGKkk9k+6Azvi7wn
/NHy8xmeCYqJ7fck0oLoApUQ8zNSVZunRKnSLe1w7lWskpdbP6brAL9km/+1JPo5oO6z4smTddhy
RAV8eGmFHwSeKqDkLaRezqmdTjSHH2nOwAheSYtd3qBNyaC+P8ZzNJhO8EQkSN3l
--000000000000f86c7c061483b571--


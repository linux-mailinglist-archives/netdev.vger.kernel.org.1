Return-Path: <netdev+bounces-216888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C42D6B35B3C
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CB6918873C4
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 11:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0623431E9;
	Tue, 26 Aug 2025 11:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IgkiIM2c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB45434166C
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 11:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207086; cv=none; b=Xsous7q8jPnAC4NjS2DRBVLzimR/ERnfV1v8BsAjCKikvCOQcBZpUGbiCk3WmttTJbt3/1Q0fZV66KRtFT4Q8lEqBuwAIqw2raGclNUYpFzavl6sHr7TaRJ06YuMzWAs+AVEwNWv+mx5uK4kuZd4GP/BD7xl7D9yy0N753FXWJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207086; c=relaxed/simple;
	bh=yuCQW35VCn5Mfjnf5UY/8rS5iZApftj+Cj8ez528CIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3ySsjFqzrI5vWYTAc5gemAryW3Q8zlpMNp1cmGKDt9Hi/fgQEgXKnGwmmP8c7DQ57Kg2z8cfG4RYF4eocD/FP84nBGd4Wwjw/lngTWd1dgmR2t1osx7nXup6a7h4ITEQwJ6DQn4IXTP9ZE7FLECEc48srSc6exS7wR/V+F7XIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IgkiIM2c; arc=none smtp.client-ip=209.85.128.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-71d6051aeafso44760807b3.2
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 04:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756207083; x=1756811883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1EjIQuaPFKIuGLbugDdugNJOHSl9PeJMisU1sGa+1ZQ=;
        b=BCwh6Ok5r4BoLsg2wvmJ6sJmE5RhvdcL/K0JT1sg5JASnrkOB+twQ+ObpDglKyGqt9
         z08i/K7WQ+gYTNBxfgCQQs1ebIdONN60hQeRseMqgJBlUuSXiLoCCObUmThlucbR/8lc
         CkpSOywGxcw3tMVKxiq0LP5RWa/qnIMKB+D5lZqh/7AJMZ1aGEWAHAMiixSyIKRrMrQJ
         Buvj6kqpd0GwAENlZoRvoMpKtMA+RU1CLiBZYg/Pc0LMOMunH0Vob40QYfsA4tVnx+Cg
         VQl6dfNUTY6Z1XrjTMm+vIsfSdTDP8sjg8a2kCG7GtQhIos1OlY+w1q7Gqo26/bYjbEH
         K2Cw==
X-Gm-Message-State: AOJu0YyWCiHKmNiKvjtEFT+XbfsHmFj7xzNuubcTe73Eyj+gOekFia5v
	l/9WingdKtnYgct3S20lpWvV4M8IW5ExuNwDFlU2wnH5FeJ4XL9XoaDhSabQ1iEyRT8aCj8aBYC
	hXfLkUOhyKim5MEEU5EqJwcfSAeJr6NSfVnoLeRKO6zRLoJSHhPqYq2TGzNQ2GDmLAUNaBfrK+e
	yynxNAGW5ndVaRRkSI6YAdsoaHOBv7b0v5EHBV3pEyAO76ZQORJT6vinPMHLkRUsWrZpz3hdBDC
	EBTOsdHD0+m1ld7SXGZ
X-Gm-Gg: ASbGncsecHli8CrdMDK40lr6w/ZMWtqaWuwIQEdAmp/L/VAFiiSe8Qogob1PsbBOVDR
	q4AJ9WfRzSieGsXbGFHkWvoQm1Rivhes5gGCukShY4xQXPfTa9YfB0W+HxCl3ukSdXd689bUtpQ
	I/sc2x9bdWvEGcrCuGEiYy/SwXpmPipyzgSeeKalbabv2QrVgKtZxW42mkf7+uVJCkKVRSiMqBZ
	U4S8ZZy87QVVCoezkYhgKO/+TCK+Tj7vzcRjb0nBTaa0llj3IMLH6rGAPArirnYWT6WyxZKNmrP
	IRtlDhEC/M1SSFcNYr4uobRdlJHvxFrHGr79X1+jRzeqp6uLSuVIivoZPKZHht2i2Ez3xmU8wZm
	HsTgFh/wlGJ3eUiz7fKg91wvCfbNzBQ==
X-Google-Smtp-Source: AGHT+IE2zBSmnqG9pYIs758Vb/s9BwLngDigIwUwdOr+p7bEu5PWYE+JVFbvUfDRRvdlef09MgMQ4uaDsuZk
X-Received: by 2002:a05:690c:968f:b0:71f:b944:1027 with SMTP id 00721157ae682-71fdc530cccmr178122277b3.48.1756207082781;
        Tue, 26 Aug 2025 04:18:02 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-71ff182893esm5402367b3.23.2025.08.26.04.18.02
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Aug 2025 04:18:02 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77057266d0bso3962598b3a.1
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 04:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756207081; x=1756811881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EjIQuaPFKIuGLbugDdugNJOHSl9PeJMisU1sGa+1ZQ=;
        b=IgkiIM2ch18BIVeQFu2pQ4qJSLT1pM53xG/t7UQAFnrMg0KIrjmwFymx6qWzu5+Cyy
         fDE4FGHFyo6PHbdd06XsooU9U6fMz8FwC0sPcJ+LNi0HXhzMuzCv83xwdA7azUPgN4lp
         BVplOjLLYSU0mG1UmRQL29ZnRSecnU2/pVHaU=
X-Received: by 2002:a05:6a00:1a94:b0:771:e8be:8390 with SMTP id d2e1a72fcca58-771e8be87b2mr7649111b3a.14.1756207081315;
        Tue, 26 Aug 2025 04:18:01 -0700 (PDT)
X-Received: by 2002:a05:6a00:1a94:b0:771:e8be:8390 with SMTP id d2e1a72fcca58-771e8be87b2mr7649062b3a.14.1756207080770;
        Tue, 26 Aug 2025 04:18:00 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77054bb0c46sm7280339b3a.41.2025.08.26.04.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 04:18:00 -0700 (PDT)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [v4, net-next 8/9] bng_en: Register default VNIC
Date: Tue, 26 Aug 2025 16:44:11 +0000
Message-ID: <20250826164412.220565-9-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250826164412.220565-1-bhargava.marreddy@broadcom.com>
References: <20250826164412.220565-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Allocate the default VNIC with the firmware and configure its RSS,
HDS, and Jumbo parameters. Add related functions to support VNIC
configuration for these parameters.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge.h     |   1 +
 .../net/ethernet/broadcom/bnge/bnge_core.c    |  12 +
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    | 207 ++++++++++++++++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |  19 ++
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 134 ++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |   4 +
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |   2 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.h    |   1 +
 8 files changed, 379 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index 642e16f511d5..d4c05688fc2e 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -164,6 +164,7 @@ struct bnge_dev {
 	u16			rss_indir_tbl_entries;
 
 	u32			rss_cap;
+	u32			rss_hash_cfg;
 
 	u16			rx_nr_rings;
 	u16			tx_nr_rings;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_core.c b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
index 56a3dd2a23ee..b3524db56115 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_core.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
@@ -102,6 +102,16 @@ static void bnge_fw_unregister_dev(struct bnge_dev *bd)
 	bnge_free_ctx_mem(bd);
 }
 
+static void bnge_set_dflt_rss_hash_type(struct bnge_dev *bd)
+{
+	bd->rss_hash_cfg = VNIC_RSS_CFG_REQ_HASH_TYPE_IPV4 |
+			   VNIC_RSS_CFG_REQ_HASH_TYPE_TCP_IPV4 |
+			   VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6 |
+			   VNIC_RSS_CFG_REQ_HASH_TYPE_TCP_IPV6 |
+			   VNIC_RSS_CFG_REQ_HASH_TYPE_UDP_IPV4 |
+			   VNIC_RSS_CFG_REQ_HASH_TYPE_UDP_IPV6;
+}
+
 static int bnge_fw_register_dev(struct bnge_dev *bd)
 {
 	int rc;
@@ -143,6 +153,8 @@ static int bnge_fw_register_dev(struct bnge_dev *bd)
 		goto err_func_unrgtr;
 	}
 
+	bnge_set_dflt_rss_hash_type(bd);
+
 	return 0;
 
 err_func_unrgtr:
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index a7c18a57fbca..fd54c72b0ad0 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
@@ -6,6 +6,8 @@
 #include <linux/mm.h>
 #include <linux/pci.h>
 #include <linux/bnxt/hsi.h>
+#include <linux/if_vlan.h>
+#include <net/netdev_queues.h>
 
 #include "bnge.h"
 #include "bnge_hwrm.h"
@@ -702,6 +704,211 @@ int bnge_hwrm_queue_qportcfg(struct bnge_dev *bd)
 	return rc;
 }
 
+int bnge_hwrm_vnic_set_hds(struct bnge_net *bn, struct bnge_vnic_info *vnic)
+{
+	u16 hds_thresh = (u16)bn->netdev->cfg_pending->hds_thresh;
+	struct hwrm_vnic_plcmodes_cfg_input *req;
+	struct bnge_dev *bd = bn->bd;
+	int rc;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_VNIC_PLCMODES_CFG);
+	if (rc)
+		return rc;
+
+	req->flags = cpu_to_le32(VNIC_PLCMODES_CFG_REQ_FLAGS_JUMBO_PLACEMENT);
+	req->enables = cpu_to_le32(BNGE_PLC_EN_JUMBO_THRES_VALID);
+	req->jumbo_thresh = cpu_to_le16(bn->rx_buf_use_size);
+
+	if (bnge_is_agg_reqd(bd)) {
+		req->flags |= cpu_to_le32(VNIC_PLCMODES_CFG_REQ_FLAGS_HDS_IPV4 |
+					  VNIC_PLCMODES_CFG_REQ_FLAGS_HDS_IPV6);
+		req->enables |=
+			cpu_to_le32(BNGE_PLC_EN_HDS_THRES_VALID);
+		req->hds_threshold = cpu_to_le16(hds_thresh);
+	}
+	req->vnic_id = cpu_to_le32(vnic->fw_vnic_id);
+	return bnge_hwrm_req_send(bd, req);
+}
+
+int bnge_hwrm_vnic_ctx_alloc(struct bnge_dev *bd,
+			     struct bnge_vnic_info *vnic, u16 ctx_idx)
+{
+	struct hwrm_vnic_rss_cos_lb_ctx_alloc_output *resp;
+	struct hwrm_vnic_rss_cos_lb_ctx_alloc_input *req;
+	int rc;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_VNIC_RSS_COS_LB_CTX_ALLOC);
+	if (rc)
+		return rc;
+
+	resp = bnge_hwrm_req_hold(bd, req);
+	rc = bnge_hwrm_req_send(bd, req);
+	if (!rc)
+		vnic->fw_rss_cos_lb_ctx[ctx_idx] =
+			le16_to_cpu(resp->rss_cos_lb_ctx_id);
+	bnge_hwrm_req_drop(bd, req);
+
+	return rc;
+}
+
+static void
+__bnge_hwrm_vnic_set_rss(struct bnge_net *bn,
+			 struct hwrm_vnic_rss_cfg_input *req,
+			 struct bnge_vnic_info *vnic)
+{
+	struct bnge_dev *bd = bn->bd;
+
+	bnge_fill_hw_rss_tbl(bn, vnic);
+	req->flags |= VNIC_RSS_CFG_REQ_FLAGS_IPSEC_HASH_TYPE_CFG_SUPPORT;
+
+	req->hash_type = cpu_to_le32(bd->rss_hash_cfg);
+	req->hash_mode_flags = VNIC_RSS_CFG_REQ_HASH_MODE_FLAGS_DEFAULT;
+	req->ring_grp_tbl_addr = cpu_to_le64(vnic->rss_table_dma_addr);
+	req->hash_key_tbl_addr = cpu_to_le64(vnic->rss_hash_key_dma_addr);
+}
+
+int bnge_hwrm_vnic_set_rss(struct bnge_net *bn,
+			   struct bnge_vnic_info *vnic, bool set_rss)
+{
+	struct hwrm_vnic_rss_cfg_input *req;
+	struct bnge_dev *bd = bn->bd;
+	dma_addr_t ring_tbl_map;
+	u32 i, nr_ctxs;
+	int rc;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_VNIC_RSS_CFG);
+	if (rc)
+		return rc;
+
+	req->vnic_id = cpu_to_le16(vnic->fw_vnic_id);
+	if (!set_rss)
+		return bnge_hwrm_req_send(bd, req);
+
+	__bnge_hwrm_vnic_set_rss(bn, req, vnic);
+	ring_tbl_map = vnic->rss_table_dma_addr;
+	nr_ctxs = bnge_get_nr_rss_ctxs(bd->rx_nr_rings);
+
+	bnge_hwrm_req_hold(bd, req);
+	for (i = 0; i < nr_ctxs; ring_tbl_map += BNGE_RSS_TABLE_SIZE, i++) {
+		req->ring_grp_tbl_addr = cpu_to_le64(ring_tbl_map);
+		req->ring_table_pair_index = i;
+		req->rss_ctx_idx = cpu_to_le16(vnic->fw_rss_cos_lb_ctx[i]);
+		rc = bnge_hwrm_req_send(bd, req);
+		if (rc)
+			goto exit;
+	}
+
+exit:
+	bnge_hwrm_req_drop(bd, req);
+	return rc;
+}
+
+int bnge_hwrm_vnic_cfg(struct bnge_net *bn, struct bnge_vnic_info *vnic)
+{
+	struct bnge_rx_ring_info *rxr = &bn->rx_ring[0];
+	struct hwrm_vnic_cfg_input *req;
+	struct bnge_dev *bd = bn->bd;
+	int rc;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_VNIC_CFG);
+	if (rc)
+		return rc;
+
+	req->default_rx_ring_id =
+		cpu_to_le16(rxr->rx_ring_struct.fw_ring_id);
+	req->default_cmpl_ring_id =
+		cpu_to_le16(bnge_cp_ring_for_rx(rxr));
+	req->enables =
+		cpu_to_le32(VNIC_CFG_REQ_ENABLES_DEFAULT_RX_RING_ID |
+			    VNIC_CFG_REQ_ENABLES_DEFAULT_CMPL_RING_ID);
+	vnic->mru = bd->netdev->mtu + ETH_HLEN + VLAN_HLEN;
+	req->mru = cpu_to_le16(vnic->mru);
+
+	req->vnic_id = cpu_to_le16(vnic->fw_vnic_id);
+
+	if (bd->flags & BNGE_EN_STRIP_VLAN)
+		req->flags |= cpu_to_le32(VNIC_CFG_REQ_FLAGS_VLAN_STRIP_MODE);
+	if (vnic->vnic_id == BNGE_VNIC_DEFAULT && bnge_aux_registered(bd))
+		req->flags |= cpu_to_le32(BNGE_VNIC_CFG_ROCE_DUAL_MODE);
+
+	return bnge_hwrm_req_send(bd, req);
+}
+
+void bnge_hwrm_update_rss_hash_cfg(struct bnge_net *bn)
+{
+	struct bnge_vnic_info *vnic = &bn->vnic_info[BNGE_VNIC_DEFAULT];
+	struct hwrm_vnic_rss_qcfg_output *resp;
+	struct hwrm_vnic_rss_qcfg_input *req;
+	struct bnge_dev *bd = bn->bd;
+
+	if (bnge_hwrm_req_init(bd, req, HWRM_VNIC_RSS_QCFG))
+		return;
+
+	req->vnic_id = cpu_to_le16(vnic->fw_vnic_id);
+	/* all contexts configured to same hash_type, zero always exists */
+	req->rss_ctx_idx = cpu_to_le16(vnic->fw_rss_cos_lb_ctx[0]);
+	resp = bnge_hwrm_req_hold(bd, req);
+	if (!bnge_hwrm_req_send(bd, req))
+		bd->rss_hash_cfg =
+			le32_to_cpu(resp->hash_type) ?: bd->rss_hash_cfg;
+	bnge_hwrm_req_drop(bd, req);
+}
+
+int bnge_hwrm_vnic_alloc(struct bnge_dev *bd, struct bnge_vnic_info *vnic,
+			 unsigned int nr_rings)
+{
+	struct hwrm_vnic_alloc_output *resp;
+	struct hwrm_vnic_alloc_input *req;
+	unsigned int i;
+	int rc;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_VNIC_ALLOC);
+	if (rc)
+		return rc;
+
+	for (i = 0; i < BNGE_MAX_CTX_PER_VNIC; i++)
+		vnic->fw_rss_cos_lb_ctx[i] = INVALID_HW_RING_ID;
+	if (vnic->vnic_id == BNGE_VNIC_DEFAULT)
+		req->flags = cpu_to_le32(VNIC_ALLOC_REQ_FLAGS_DEFAULT);
+
+	resp = bnge_hwrm_req_hold(bd, req);
+	rc = bnge_hwrm_req_send(bd, req);
+	if (!rc)
+		vnic->fw_vnic_id = le32_to_cpu(resp->vnic_id);
+	bnge_hwrm_req_drop(bd, req);
+	return rc;
+}
+
+void bnge_hwrm_vnic_free_one(struct bnge_dev *bd, struct bnge_vnic_info *vnic)
+{
+	if (vnic->fw_vnic_id != INVALID_HW_RING_ID) {
+		struct hwrm_vnic_free_input *req;
+
+		if (bnge_hwrm_req_init(bd, req, HWRM_VNIC_FREE))
+			return;
+
+		req->vnic_id = cpu_to_le32(vnic->fw_vnic_id);
+
+		bnge_hwrm_req_send(bd, req);
+		vnic->fw_vnic_id = INVALID_HW_RING_ID;
+	}
+}
+
+void bnge_hwrm_vnic_ctx_free_one(struct bnge_dev *bd,
+				 struct bnge_vnic_info *vnic, u16 ctx_idx)
+{
+	struct hwrm_vnic_rss_cos_lb_ctx_free_input *req;
+
+	if (bnge_hwrm_req_init(bd, req, HWRM_VNIC_RSS_COS_LB_CTX_FREE))
+		return;
+
+	req->rss_cos_lb_ctx_id =
+		cpu_to_le16(vnic->fw_rss_cos_lb_ctx[ctx_idx]);
+
+	bnge_hwrm_req_send(bd, req);
+	vnic->fw_rss_cos_lb_ctx[ctx_idx] = INVALID_HW_RING_ID;
+}
+
 void bnge_hwrm_stat_ctx_free(struct bnge_net *bn)
 {
 	struct hwrm_stat_ctx_free_input *req;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
index b2e2ec47be2e..09517ffb1a21 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
@@ -4,6 +4,13 @@
 #ifndef _BNGE_HWRM_LIB_H_
 #define _BNGE_HWRM_LIB_H_
 
+#define BNGE_PLC_EN_JUMBO_THRES_VALID		\
+	VNIC_PLCMODES_CFG_REQ_ENABLES_JUMBO_THRESH_VALID
+#define BNGE_PLC_EN_HDS_THRES_VALID		\
+	VNIC_PLCMODES_CFG_REQ_ENABLES_HDS_THRESHOLD_VALID
+#define BNGE_VNIC_CFG_ROCE_DUAL_MODE		\
+	VNIC_CFG_REQ_FLAGS_ROCE_DUAL_VNIC_MODE
+
 int bnge_hwrm_ver_get(struct bnge_dev *bd);
 int bnge_hwrm_func_reset(struct bnge_dev *bd);
 int bnge_hwrm_fw_set_time(struct bnge_dev *bd);
@@ -24,6 +31,18 @@ int bnge_hwrm_func_qcfg(struct bnge_dev *bd);
 int bnge_hwrm_func_resc_qcaps(struct bnge_dev *bd);
 int bnge_hwrm_queue_qportcfg(struct bnge_dev *bd);
 
+int bnge_hwrm_vnic_set_hds(struct bnge_net *bn, struct bnge_vnic_info *vnic);
+int bnge_hwrm_vnic_ctx_alloc(struct bnge_dev *bd,
+			     struct bnge_vnic_info *vnic, u16 ctx_idx);
+int bnge_hwrm_vnic_set_rss(struct bnge_net *bn,
+			   struct bnge_vnic_info *vnic, bool set_rss);
+int bnge_hwrm_vnic_cfg(struct bnge_net *bn, struct bnge_vnic_info *vnic);
+void bnge_hwrm_update_rss_hash_cfg(struct bnge_net *bn);
+int bnge_hwrm_vnic_alloc(struct bnge_dev *bd, struct bnge_vnic_info *vnic,
+			 unsigned int nr_rings);
+void bnge_hwrm_vnic_free_one(struct bnge_dev *bd, struct bnge_vnic_info *vnic);
+void bnge_hwrm_vnic_ctx_free_one(struct bnge_dev *bd,
+				 struct bnge_vnic_info *vnic, u16 ctx_idx);
 void bnge_hwrm_stat_ctx_free(struct bnge_net *bn);
 int bnge_hwrm_stat_ctx_alloc(struct bnge_net *bn);
 int hwrm_ring_free_send_msg(struct bnge_net *bn, struct bnge_ring_struct *ring,
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 5b56a1d0e8d5..30381d9a0734 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -1433,6 +1433,117 @@ static int bnge_hwrm_ring_alloc(struct bnge_net *bn)
 	return rc;
 }
 
+int bnge_get_nr_rss_ctxs(int rx_rings)
+{
+	if (!rx_rings)
+		return 0;
+	return bnge_adjust_pow_two(rx_rings - 1, BNGE_RSS_TABLE_ENTRIES);
+}
+
+void bnge_fill_hw_rss_tbl(struct bnge_net *bn, struct bnge_vnic_info *vnic)
+{
+	__le16 *ring_tbl = vnic->rss_table;
+	struct bnge_rx_ring_info *rxr;
+	struct bnge_dev *bd = bn->bd;
+	u16 tbl_size, i;
+
+	tbl_size = bnge_get_rxfh_indir_size(bd);
+
+	for (i = 0; i < tbl_size; i++) {
+		u16 ring_id, j;
+
+		j = bd->rss_indir_tbl[i];
+		rxr = &bn->rx_ring[j];
+
+		ring_id = rxr->rx_ring_struct.fw_ring_id;
+		*ring_tbl++ = cpu_to_le16(ring_id);
+		ring_id = bnge_cp_ring_for_rx(rxr);
+		*ring_tbl++ = cpu_to_le16(ring_id);
+	}
+}
+
+static int bnge_hwrm_vnic_rss_cfg(struct bnge_net *bn,
+				  struct bnge_vnic_info *vnic)
+{
+	int rc;
+
+	rc = bnge_hwrm_vnic_set_rss(bn, vnic, true);
+	if (rc) {
+		netdev_err(bn->netdev, "hwrm vnic %d set rss failure rc: %d\n",
+			   vnic->vnic_id, rc);
+		return rc;
+	}
+	rc = bnge_hwrm_vnic_cfg(bn, vnic);
+	if (rc)
+		netdev_err(bn->netdev, "hwrm vnic %d cfg failure rc: %d\n",
+			   vnic->vnic_id, rc);
+	return rc;
+}
+
+static int bnge_setup_vnic(struct bnge_net *bn, struct bnge_vnic_info *vnic)
+{
+	struct bnge_dev *bd = bn->bd;
+	int rc, i, nr_ctxs;
+
+	nr_ctxs = bnge_get_nr_rss_ctxs(bd->rx_nr_rings);
+	for (i = 0; i < nr_ctxs; i++) {
+		rc = bnge_hwrm_vnic_ctx_alloc(bd, vnic, i);
+		if (rc) {
+			netdev_err(bn->netdev, "hwrm vnic %d ctx %d alloc failure rc: %d\n",
+				   vnic->vnic_id, i, rc);
+			break;
+		}
+		bn->rsscos_nr_ctxs++;
+	}
+	if (i < nr_ctxs)
+		return -ENOMEM;
+
+	rc = bnge_hwrm_vnic_rss_cfg(bn, vnic);
+	if (rc)
+		return rc;
+
+	if (bnge_is_agg_reqd(bd)) {
+		rc = bnge_hwrm_vnic_set_hds(bn, vnic);
+		if (rc) {
+			netdev_err(bn->netdev, "hwrm vnic %d set hds failure rc: %d\n",
+				   vnic->vnic_id, rc);
+		}
+	}
+	return rc;
+}
+
+static void bnge_hwrm_vnic_free(struct bnge_net *bn)
+{
+	int i;
+
+	for (i = 0; i < bn->nr_vnics; i++)
+		bnge_hwrm_vnic_free_one(bn->bd, &bn->vnic_info[i]);
+}
+
+static void bnge_hwrm_vnic_ctx_free(struct bnge_net *bn)
+{
+	int i, j;
+
+	for (i = 0; i < bn->nr_vnics; i++) {
+		struct bnge_vnic_info *vnic = &bn->vnic_info[i];
+
+		for (j = 0; j < BNGE_MAX_CTX_PER_VNIC; j++) {
+			if (vnic->fw_rss_cos_lb_ctx[j] != INVALID_HW_RING_ID)
+				bnge_hwrm_vnic_ctx_free_one(bn->bd, vnic, j);
+		}
+	}
+	bn->rsscos_nr_ctxs = 0;
+}
+
+static void bnge_clear_vnic(struct bnge_net *bn)
+{
+	if (!bn->vnic_info)
+		return;
+
+	bnge_hwrm_vnic_free(bn);
+	bnge_hwrm_vnic_ctx_free(bn);
+}
+
 static void bnge_hwrm_rx_ring_free(struct bnge_net *bn,
 				   struct bnge_rx_ring_info *rxr,
 				   bool close_path)
@@ -1593,6 +1704,7 @@ static int bnge_setup_interrupts(struct bnge_net *bn)
 
 static void bnge_hwrm_resource_free(struct bnge_net *bn, bool close_path)
 {
+	bnge_clear_vnic(bn);
 	bnge_hwrm_ring_free(bn, close_path);
 	bnge_hwrm_stat_ctx_free(bn);
 }
@@ -1640,6 +1752,8 @@ static int bnge_request_irq(struct bnge_net *bn)
 
 static int bnge_init_chip(struct bnge_net *bn)
 {
+	struct bnge_vnic_info *vnic = &bn->vnic_info[BNGE_VNIC_DEFAULT];
+	struct bnge_dev *bd = bn->bd;
 	int rc = 0;
 
 #define BNGE_DEF_STATS_COAL_TICKS	 1000000
@@ -1658,6 +1772,18 @@ static int bnge_init_chip(struct bnge_net *bn)
 		goto err_out;
 	}
 
+	rc = bnge_hwrm_vnic_alloc(bd, vnic, bd->rx_nr_rings);
+	if (rc) {
+		netdev_err(bn->netdev, "hwrm vnic alloc failure rc: %d\n", rc);
+		goto err_out;
+	}
+
+	rc = bnge_setup_vnic(bn, vnic);
+	if (rc)
+		goto err_out;
+	if (bd->rss_cap & BNGE_RSS_CAP_RSS_HASH_TYPE_DELTA)
+		bnge_hwrm_update_rss_hash_cfg(bn);
+
 	return 0;
 err_out:
 	bnge_hwrm_resource_free(bn, 0);
@@ -1811,11 +1937,19 @@ static int bnge_open(struct net_device *dev)
 	return rc;
 }
 
+static int bnge_shutdown_nic(struct bnge_net *bn)
+{
+	/* TODO: close_path = 0 until we make NAPI functional */
+	bnge_hwrm_resource_free(bn, 0);
+	return 0;
+}
+
 static void bnge_close_core(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
 
 	clear_bit(BNGE_STATE_OPEN, &bd->state);
+	bnge_shutdown_nic(bn);
 	bnge_free_pkts_mem(bn);
 	bnge_free_irq(bn);
 	bnge_del_napi(bn);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index ba0dd2202fb6..f5b1a6360f50 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -228,6 +228,7 @@ struct bnge_net {
 	u8			rss_hash_key[HW_HASH_KEY_SIZE];
 	u8			rss_hash_key_valid:1;
 	u8			rss_hash_key_updated:1;
+	int			rsscos_nr_ctxs;
 	u32			stats_coal_ticks;
 };
 
@@ -381,6 +382,7 @@ struct bnge_vnic_info {
 	u16		fw_vnic_id;
 #define BNGE_MAX_CTX_PER_VNIC	8
 	u16		fw_rss_cos_lb_ctx[BNGE_MAX_CTX_PER_VNIC];
+	u16		mru;
 	u8		*uc_list;
 	dma_addr_t	rss_table_dma_addr;
 	__le16		*rss_table;
@@ -408,4 +410,6 @@ struct bnge_vnic_info {
 
 u16 bnge_cp_ring_for_rx(struct bnge_rx_ring_info *rxr);
 u16 bnge_cp_ring_for_tx(struct bnge_tx_ring_info *txr);
+int bnge_get_nr_rss_ctxs(int rx_rings);
+void bnge_fill_hw_rss_tbl(struct bnge_net *bn, struct bnge_vnic_info *vnic);
 #endif /* _BNGE_NETDEV_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
index 5597af1b3b7c..e05560975938 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
@@ -184,7 +184,7 @@ static u16 bnge_get_total_vnics(struct bnge_dev *bd, u16 rx_rings)
 	return 1;
 }
 
-static u32 bnge_get_rxfh_indir_size(struct bnge_dev *bd)
+u32 bnge_get_rxfh_indir_size(struct bnge_dev *bd)
 {
 	return bnge_cal_nr_rss_ctxs(bd->rx_nr_rings) *
 	       BNGE_RSS_TABLE_ENTRIES;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.h b/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
index 54ef1c7d8822..ad429fe65744 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
@@ -72,6 +72,7 @@ void bnge_free_irqs(struct bnge_dev *bd);
 int bnge_net_init_dflt_config(struct bnge_dev *bd);
 void bnge_net_uninit_dflt_config(struct bnge_dev *bd);
 void bnge_aux_init_dflt_config(struct bnge_dev *bd);
+u32 bnge_get_rxfh_indir_size(struct bnge_dev *bd);
 
 static inline u32
 bnge_adjust_pow_two(u32 total_ent, u16 ent_per_blk)
-- 
2.47.3



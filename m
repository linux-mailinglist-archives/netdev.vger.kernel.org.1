Return-Path: <netdev+bounces-222270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73790B53C68
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 21:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5C35C028A
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 19:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D821F36CE19;
	Thu, 11 Sep 2025 19:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RGMWf5/5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EBB36CE05
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 19:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757619366; cv=none; b=ITWE8nRopl91HmZXkKcWsivZWtR8lggNiWCcwmlEhCPqV3LpWgo5N6UQK85Wmt/UTMxXkshNWnSOnA+gciBEcZ26EoV04XVXLkrHxhJaKZS+b7ggAKZZRJKhMdbpCjiYKjaFqQzt3iElybCS0eaUmcPYmiYCKwxC1lrduSurVNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757619366; c=relaxed/simple;
	bh=gtAvfagUraw6GYKs1QCmE3yB+M/2xuo0BI43AUsYnzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cpP1sKuUDAYjo7y+AD8zg36qa/87U7uJA7bQfubp8uPZaIGBcyo5+lH8IT5HupDFsiTpFpZ8cpZFiheQnX2I25xgKnIo45uO5Yi8iiiK1dq2WOQ2EIDHOdo7flzjd0arz1Sl7Hw5iHJVkPr0uKCVY6OlaJPXco8HDBKK94zS8mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RGMWf5/5; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-25c5e597cfcso9701005ad.1
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 12:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757619364; x=1758224164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0sRSyaGd2EmUmnOioo6afYQh8jks3lhEqpFinhuuh/A=;
        b=e24BGSiVYpab7GP+OWAylg7znlWMlOlaR35OqAiqtLhZWgeO6CZILHRZzurMvaYJVE
         HTJrWpYOqSPhWVjRchcZJq6+nPGwdNeprt1V3YjvM0xOIXb+Dr4EOAcZmgOGl16a3Zzx
         xPria7zB+rhTwB58u5W3tFtrB0y6XV2cjufX1Ski3JnS8GQ01KhRMv5lLSppGyzwusWl
         j65tzYkNyY8v+bCCXkyQDPfMF6X/pHCK2g7uxFdREfoVNhlbcPCd9tel1R/vOGD5iP85
         XQJiBnXy1VU3QnoRHjlxX/HkvnkZ+I3U6lZEKnr76S7qPCj6BaXe5hCjSfgwJBTc+Ofc
         p24Q==
X-Gm-Message-State: AOJu0YyVheOv3hL7dyWT8bkLg5ib2wr4smIwCrWs5V9UpwQnlYvffFYV
	z+J8bHgIO4ORqSJqf6ozGejhplN4Ha2tUOR/XvtsBsKmx8ZJffVKXp/kq5gM2X1kAGgKwHyXceO
	IUg9+mfg7mYQaeHU97OhCN4bVD/8YSdgJQvAJS6woYAMpcTTkfBBqgfahnB9gN4QBDqTvuETARM
	VAzATuP8iivXCDl9ZzSGrEFToLqTJyhMHq482tIzZbx94yndA5+MYW09PH0gMvitqK10mwl/Fs3
	tr0c+yPum7yNgFXP5rJ
X-Gm-Gg: ASbGncv7HeoaKyyZtvuHuGTbEBxK1pxb6OSAqoxHjJ46q+bTtPeE8vIK2bZwR7quFh3
	vUOX8p921OP6yExdd9BnseUNphEPiGjmVjqPDilRW2kPrC9rV04RoiATaf4dMKfDSY+S7EETJlT
	1o1y4BIgQSCB61xlTUNG3p2gI5RV+UTd5v97PtX5J6C2VeLl3u1P2ryIO6RfAcSQdOgVLFZP3rc
	QMjB1szpTpfEu7t11P5KyRDVBJ/91YC+5gZNurXog1sIODQe/MrIAZjSlx71DIIXmpex1SNhF9U
	dsnbClltkX0d54kjXmGnzI3tew6hV+z7Txi9T38VAbK1/4JZ0fMtIv5jZ5b+v4MZBRMxZyPZ6YV
	STbOPU9S13/xQKlHXohZmhrI00mwTRvFJ7neU9AXPHF6SmtW6zMuOAe2pZa2tli4KgebVDV+1lX
	cFm8jmltJL
X-Google-Smtp-Source: AGHT+IHjnxDko+f+c/hnoiMBtnnGTz/8y4TMPIUnzvcggu30M6LPwWlkUJOB2+t9xLRVplQYtPSn02ySJDie
X-Received: by 2002:a17:903:1ab0:b0:24c:d08e:309b with SMTP id d9443c01a7336-25d24cac50fmr5852795ad.15.1757619363960;
        Thu, 11 Sep 2025 12:36:03 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-25c393c1a85sm2045725ad.37.2025.09.11.12.36.03
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Sep 2025 12:36:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24c99bd543aso18669245ad.3
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 12:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757619362; x=1758224162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sRSyaGd2EmUmnOioo6afYQh8jks3lhEqpFinhuuh/A=;
        b=RGMWf5/5P7EcqJCq3P5wxUYjeVgpiWupVlXRoBx9ioRhY69N6nWYq9MFn9/EuELLJd
         TjTgqhdxQ7pBwZXru5MDCtDp5cDZ38CEkAAHwrGRZpSBBv0EJNu6hjgD1G869oXkJdH0
         26MjIUhfy9Jd/cEUkDg2k8j7WqLOljo5Tselo=
X-Received: by 2002:a17:903:41cd:b0:246:464d:1194 with SMTP id d9443c01a7336-25d245dd704mr6918645ad.2.1757619361918;
        Thu, 11 Sep 2025 12:36:01 -0700 (PDT)
X-Received: by 2002:a17:903:41cd:b0:246:464d:1194 with SMTP id d9443c01a7336-25d245dd704mr6918335ad.2.1757619361360;
        Thu, 11 Sep 2025 12:36:01 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3ad3404csm25839285ad.113.2025.09.11.12.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 12:36:00 -0700 (PDT)
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
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [v7, net-next 09/10] bng_en: Register default VNIC
Date: Fri, 12 Sep 2025 01:05:04 +0530
Message-ID: <20250911193505.24068-10-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250911193505.24068-1-bhargava.marreddy@broadcom.com>
References: <20250911193505.24068-1-bhargava.marreddy@broadcom.com>
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
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 122 +++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |   3 +
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |   4 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.h    |   2 +
 8 files changed, 368 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index aee65a6c980..7aed5f81cd5 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -160,6 +160,7 @@ struct bnge_dev {
 	u16			rss_indir_tbl_entries;
 
 	u32			rss_cap;
+	u32			rss_hash_cfg;
 
 	u16			rx_nr_rings;
 	u16			tx_nr_rings;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_core.c b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
index 304b1e4d5a0..2c72dd34d50 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_core.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
@@ -96,6 +96,16 @@ static void bnge_fw_unregister_dev(struct bnge_dev *bd)
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
@@ -137,6 +147,8 @@ static int bnge_fw_register_dev(struct bnge_dev *bd)
 		goto err_func_unrgtr;
 	}
 
+	bnge_set_dflt_rss_hash_type(bd);
+
 	return 0;
 
 err_func_unrgtr:
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index b44e0f4ed7c..ae780939828 100644
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
+	nr_ctxs = bnge_cal_nr_rss_ctxs(bd->rx_nr_rings);
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
index b2e2ec47be2..09517ffb1a2 100644
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
index dbfb4516933..793b84c2bec 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -1411,6 +1411,104 @@ static int bnge_hwrm_ring_alloc(struct bnge_net *bn)
 	return rc;
 }
 
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
+	nr_ctxs = bnge_cal_nr_rss_ctxs(bd->rx_nr_rings);
+	for (i = 0; i < nr_ctxs; i++) {
+		rc = bnge_hwrm_vnic_ctx_alloc(bd, vnic, i);
+		if (rc) {
+			netdev_err(bn->netdev, "hwrm vnic %d ctx %d alloc failure rc: %d\n",
+				   vnic->vnic_id, i, rc);
+			return -ENOMEM;
+		}
+		bn->rsscos_nr_ctxs++;
+	}
+
+	rc = bnge_hwrm_vnic_rss_cfg(bn, vnic);
+	if (rc)
+		return rc;
+
+	if (bnge_is_agg_reqd(bd)) {
+		rc = bnge_hwrm_vnic_set_hds(bn, vnic);
+		if (rc)
+			netdev_err(bn->netdev, "hwrm vnic %d set hds failure rc: %d\n",
+				   vnic->vnic_id, rc);
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
+	bnge_hwrm_vnic_free(bn);
+	bnge_hwrm_vnic_ctx_free(bn);
+}
+
 static void bnge_hwrm_rx_ring_free(struct bnge_net *bn,
 				   struct bnge_rx_ring_info *rxr,
 				   bool close_path)
@@ -1554,6 +1652,7 @@ static int bnge_setup_interrupts(struct bnge_net *bn)
 
 static void bnge_hwrm_resource_free(struct bnge_net *bn, bool close_path)
 {
+	bnge_clear_vnic(bn);
 	bnge_hwrm_ring_free(bn, close_path);
 	bnge_hwrm_stat_ctx_free(bn);
 }
@@ -1627,6 +1726,8 @@ static int bnge_request_irq(struct bnge_net *bn)
 
 static int bnge_init_chip(struct bnge_net *bn)
 {
+	struct bnge_vnic_info *vnic = &bn->vnic_info[BNGE_VNIC_DEFAULT];
+	struct bnge_dev *bd = bn->bd;
 	int rc;
 
 #define BNGE_DEF_STATS_COAL_TICKS	 1000000
@@ -1643,6 +1744,19 @@ static int bnge_init_chip(struct bnge_net *bn)
 		netdev_err(bn->netdev, "hwrm ring alloc failure rc: %d\n", rc);
 		goto err_out;
 	}
+
+	rc = bnge_hwrm_vnic_alloc(bd, vnic, bd->rx_nr_rings);
+	if (rc) {
+		netdev_err(bn->netdev, "hwrm vnic alloc failure rc: %d\n", rc);
+		goto err_out;
+	}
+
+	rc = bnge_setup_vnic(bn, vnic);
+	if (rc)
+		goto err_out;
+
+	if (bd->rss_cap & BNGE_RSS_CAP_RSS_HASH_TYPE_DELTA)
+		bnge_hwrm_update_rss_hash_cfg(bn);
 	return 0;
 
 err_out:
@@ -1776,11 +1890,19 @@ static int bnge_open(struct net_device *dev)
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
index ba0dd2202fb..1b580761262 100644
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
@@ -408,4 +410,5 @@ struct bnge_vnic_info {
 
 u16 bnge_cp_ring_for_rx(struct bnge_rx_ring_info *rxr);
 u16 bnge_cp_ring_for_tx(struct bnge_tx_ring_info *txr);
+void bnge_fill_hw_rss_tbl(struct bnge_net *bn, struct bnge_vnic_info *vnic);
 #endif /* _BNGE_NETDEV_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
index 5597af1b3b7..62ebe03a0dc 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
@@ -164,7 +164,7 @@ static int bnge_adjust_rings(struct bnge_dev *bd, u16 *rx,
 	return bnge_fix_rings_count(rx, tx, max_nq, sh);
 }
 
-static int bnge_cal_nr_rss_ctxs(u16 rx_rings)
+int bnge_cal_nr_rss_ctxs(u16 rx_rings)
 {
 	if (!rx_rings)
 		return 0;
@@ -184,7 +184,7 @@ static u16 bnge_get_total_vnics(struct bnge_dev *bd, u16 rx_rings)
 	return 1;
 }
 
-static u32 bnge_get_rxfh_indir_size(struct bnge_dev *bd)
+u32 bnge_get_rxfh_indir_size(struct bnge_dev *bd)
 {
 	return bnge_cal_nr_rss_ctxs(bd->rx_nr_rings) *
 	       BNGE_RSS_TABLE_ENTRIES;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.h b/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
index 54ef1c7d882..0d6213b2758 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
@@ -72,6 +72,8 @@ void bnge_free_irqs(struct bnge_dev *bd);
 int bnge_net_init_dflt_config(struct bnge_dev *bd);
 void bnge_net_uninit_dflt_config(struct bnge_dev *bd);
 void bnge_aux_init_dflt_config(struct bnge_dev *bd);
+u32 bnge_get_rxfh_indir_size(struct bnge_dev *bd);
+int bnge_cal_nr_rss_ctxs(u16 rx_rings);
 
 static inline u32
 bnge_adjust_pow_two(u32 total_ent, u16 ent_per_blk)
-- 
2.47.3



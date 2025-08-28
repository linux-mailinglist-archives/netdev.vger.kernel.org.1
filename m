Return-Path: <netdev+bounces-217822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9997BB39EA3
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 15:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9649F984583
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 13:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDC7314B76;
	Thu, 28 Aug 2025 13:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hB7X3jqp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f100.google.com (mail-io1-f100.google.com [209.85.166.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707953128C9
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 13:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756387175; cv=none; b=DPPq6JmAeOxWwR5PyI4C/JljTTn1EwNba98uUdCK6Pz3qY1kXKcFYOQqfCi9mdMzzjg3bAXmel7VxLDxb5aWW4OnsFS4U9J3gwqb70zmQuMbI27yY5XJGo1ourT7c+R+2ZCQCKPhe49ApeU2/O8x7f/Z+7/EmIcBkFNaNWTEGIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756387175; c=relaxed/simple;
	bh=E09FRASXFN18x/+6O7101d41CuiViuGqROHAARceE7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ezbB8FqEkdawS23JOnRErIrKgtZicjF+KGF0KrGiTpsyClic88URTHStCfUetcfxaZA/ShBiVkKsE4pFQa+zCs9AL9MPcn4ol7Vw9nc5a5Io5Q0gdv6LbDlUUAlZItcVKS39jp9YuzegflGBnRi4Ib3zW5CO3OOYNOkzMAxYZ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hB7X3jqp; arc=none smtp.client-ip=209.85.166.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f100.google.com with SMTP id ca18e2360f4ac-88432ccd787so66707139f.0
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 06:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756387172; x=1756991972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QjzGiesoPeELHTG9hKv/eX1cbMY/2J6zIwLy7FSAnDI=;
        b=Xb7l4w/y2wDcQqwjKr8SZqLp4vcyFrO9/f0dfLbGHV9EvENfz3KkFtcHstz2ybI9J/
         P9jSKlWo0sno+YCbDgIw/iSARgowq1dO7qXa0LkGq71ScpZyymGQ0/Ye3XWgvoByIhYO
         ts+GVO0ghdzChn6bcIHIcHKi5OBBxvN3YiJt7lcSezNAREWwqaoyj9qbGlvhl658BFSq
         zFtHaF1UFearg9tJ/tvOfXf6uChDRkfZccwOmqHC6tlWzi4If9CIYrdMmcYqKAMi8v1w
         ivh3lzWmmcEkPb6GZ2QW9NBDyTwxGUUwwgy4lUD36wV/fE7ckkKWHW7+j97Jxo7kcFVz
         M9Pw==
X-Gm-Message-State: AOJu0YyWjTcbF7ELJziXyh7SuexzvowhTH7BkwIDt+4ao+Ulwx6RssVa
	L2Urw7HvodW3ZevTxkh6lzRC0tMqbebEk27gFX8zAa0t3l0gKnb2475LbdAm8cwLlHFXB1T+EOk
	/maNt43WiAGATp50urDxd2o14DnDMMIidZ2S5FM7ic5CizVRYPy2UL6xtmOF3Jx9ErrGCG5z0G1
	oF7JxpguI/1xrObi7kaxNI2/N++VHOyiwC92no/3RsnFM3I0S/1kADT5vRmZjhj5welB6Vrdafn
	ESNxnht2KndDFIxpawV
X-Gm-Gg: ASbGncuLml9nAR29Mk1FbSWtoXaVO5v6/R/Ei6Yx17ylAYGwMFRiXpZZ/9YsouK8rXq
	8BOMBViNt1pFuIT/nXFBtMd0NLhm8vOfHPsN5Aw5HnVFUIKCrg+Wx7XsMRQt5Opm52sXoTG7MdV
	/h7IRbW5DSnKiphYPA+xtuXTN8fogfhZb+VeEMOoF6dwDD92bCdxLMdwKXqwFDNqIPu9GKg4O9h
	d5esSYLPdLXFjf/+gI0UhR1wlzNuNihTtx2SpicJAChjmqepYcy0pDxPnFO6xd1pfbz2mHvyja/
	caX1UrUEW5ZgOp0t1UR+yMEkGiiEzebB+XpelGIFC6ghMS+rC0FG0ndtGyajVi+JVS0FInGz5up
	Ep/B0oW4Lyyh2PuMmT1XMOEFHbstGFh0R89UGEdVJCpVxFeKQw4gRxceA+61pb/BB10MkDbLmMe
	GwJ8W0R1ox
X-Google-Smtp-Source: AGHT+IHij7Xpomw23DMj8KYNFImFauybx9HOn7DiNZ0O0qqQgfqUgFSmvczgRZjvswRJrXzhPgPBpKO/4FRz
X-Received: by 2002:a05:6602:486:b0:881:7e0c:7a79 with SMTP id ca18e2360f4ac-886bd10de0emr2983158939f.2.1756387172435;
        Thu, 28 Aug 2025 06:19:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-122.dlp.protect.broadcom.com. [144.49.247.122])
        by smtp-relay.gmail.com with ESMTPS id ca18e2360f4ac-886c8f020b0sm89584239f.7.2025.08.28.06.19.31
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Aug 2025 06:19:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-246266f9ae1so9281615ad.2
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 06:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756387171; x=1756991971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjzGiesoPeELHTG9hKv/eX1cbMY/2J6zIwLy7FSAnDI=;
        b=hB7X3jqpIjDxaj3DKR+ePW30hK0OTOxMBUTbwtvhbv4MtfzzkW7Wvy9FtWMM866iw5
         NvEjr4WmshEulxxnOuqkdfym8zKozBPZeJUtm3ZApn5wByo9Mcbs2R8Zg8vPLEbxtl5g
         NnvevbHgYEUroZXSi/kwGTIzoKZ+dc88aRTdg=
X-Received: by 2002:a17:902:e888:b0:240:a54e:21a0 with SMTP id d9443c01a7336-2462ee13154mr318314765ad.19.1756387170400;
        Thu, 28 Aug 2025 06:19:30 -0700 (PDT)
X-Received: by 2002:a17:902:e888:b0:240:a54e:21a0 with SMTP id d9443c01a7336-2462ee13154mr318314295ad.19.1756387169831;
        Thu, 28 Aug 2025 06:19:29 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-248b6a16ae3sm36468705ad.137.2025.08.28.06.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 06:19:29 -0700 (PDT)
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
Subject: [v5, net-next 8/9] bng_en: Register default VNIC
Date: Thu, 28 Aug 2025 18:45:46 +0000
Message-ID: <20250828184547.242496-9-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250828184547.242496-1-bhargava.marreddy@broadcom.com>
References: <20250828184547.242496-1-bhargava.marreddy@broadcom.com>
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
index 58e4f42830b0..04635ade94ea 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -1432,6 +1432,117 @@ static int bnge_hwrm_ring_alloc(struct bnge_net *bn)
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
@@ -1592,6 +1703,7 @@ static int bnge_setup_interrupts(struct bnge_net *bn)
 
 static void bnge_hwrm_resource_free(struct bnge_net *bn, bool close_path)
 {
+	bnge_clear_vnic(bn);
 	bnge_hwrm_ring_free(bn, close_path);
 	bnge_hwrm_stat_ctx_free(bn);
 }
@@ -1639,6 +1751,8 @@ static int bnge_request_irq(struct bnge_net *bn)
 
 static int bnge_init_chip(struct bnge_net *bn)
 {
+	struct bnge_vnic_info *vnic = &bn->vnic_info[BNGE_VNIC_DEFAULT];
+	struct bnge_dev *bd = bn->bd;
 	int rc = 0;
 
 #define BNGE_DEF_STATS_COAL_TICKS	 1000000
@@ -1657,6 +1771,18 @@ static int bnge_init_chip(struct bnge_net *bn)
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
@@ -1810,11 +1936,19 @@ static int bnge_open(struct net_device *dev)
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



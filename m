Return-Path: <netdev+bounces-217821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE41B39EA1
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 15:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CC6F160F00
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 13:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F996314A9E;
	Thu, 28 Aug 2025 13:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Twt+3Z95"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f228.google.com (mail-yb1-f228.google.com [209.85.219.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395A1314B61
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 13:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756387171; cv=none; b=qvOMmiS2aYxjXZdAERKeNrN0HTfV3WwF6yE8dM+4jz1H6fWNc0/qNgx2gugy9G+89mujYGJ21k8L3ol8lIV3uYxo9Tr18ceauw7lpw1o8EuXs2n8SDtfrNbmf340aYd3v5Knm4v6Iudmkqaz9R4UnwdFxeWem5WYjrb0kx32lEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756387171; c=relaxed/simple;
	bh=a7pz/Gx5/kVIQdxa6NrGZowvAENZ4vMn/FPCDpfELrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GxEbUbI25jNigaO/zofaOpmi7s6eD3FwWzVba5rrW0LYJ0dgtIXo4U3DZpAanl+HlvxjhkoU3VkdL307Uy3DRSrHWU7BkUDJgT1bATWDgkPrkaaCELgQtMJrfD+hDaQlnDig47nesDKZ4zKUjLxtsCD2hMXfsJa3p0LshR0fKVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Twt+3Z95; arc=none smtp.client-ip=209.85.219.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f228.google.com with SMTP id 3f1490d57ef6-e96dc26dfa2so712001276.1
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 06:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756387168; x=1756991968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xIFB/AlHZEsJK8LDJrBsJMdfECpeU+VhE2ENPC0h48s=;
        b=norWiEzZqww+dU6EBwpAaT42Uvwm6sOn8IKKFrZuAq026H9EtKGjWwiY785xFvUxIx
         AkkFWCMrAJ4AEFHRJPf1ZNUDS2nZIgfWlDDSkP+Sp349ShxBuX9nJUstc4mq124oiaBw
         SeltUzseeO+QlMDTNY3BOxeArMm9KbkiKPniovdwUuoHhGDsuV+kBWGsnKtb6xl5iykb
         RfdOjMjMfhbJre9XRMtom62/1qIL3ggVhcWOwhDqVn7kGidmfn/lXcSNPywokniMotiw
         tue9eNcocRX2e65Ds0FDISboxprv1GkLHjRe8QuF7wsSEk99HFMc74iaPD5XIZ+lz9p5
         z15Q==
X-Gm-Message-State: AOJu0YzMtGNZ2JzeUFgCKGgXEMuvgw/BriAEYLu7AwQb/JP/KBe3nXbH
	eTxp0t2FmczX0FafiyecB9Z7R6mQxP9O0OB6DDGClJpc7BkYsp19glu570uzHnxTyvpFcfUFTkG
	vNFadiTgB44jDaRkIsd/jsenBntuDHr1WeerBoylEyLDzZyAmyItv1n1/qeAdp0nm7EG5cDy9FE
	L7GFwLKYH6Bql6zFI4BygWG0o0NXVipE/GMBmnx0I86AYKpfeNG1ddnCJgTPQnyQPR0IdH7/PQw
	Jw80m1N0Wdu1DapkA==
X-Gm-Gg: ASbGnct/QZxHeOL1ULoK9v+5GjTUW0WjJ7E7kMxxglkbwqerneXBvZllKBsR9B8Z2Qu
	xJwMRHrpGlvJjDAxoLWsWKwIYBQpyLHhThLSgKsEzDVrr04CNRN5pqm5DXzChEdwfi+gDT8LoPM
	ZmrA3G6dl8s/st7iPX+W7D5OcCe63NgKso5FewWapHcxJQv8XH0WJ8blW0TJqCBsS0BdjnWpNii
	2Q6fOf1Ud9CG8WxPacxQlARBFp9N0z9AB9q+mhWlQBLMSTlhY+CpNq8K2cZhQhtxsgOBJ4ZldxD
	2XLqFX/qeV0P+SoKSdbCRaSiyrUlc4jof9RqLmUo9pHV7n72JhqynSl8JuQ25IwRzBsDRN8iNEG
	4smqhD0KXjHIUTwLIAtvxysr2ip6PbRtlwZGe8/luCEqjA3n/Ft9MSQFNZkcP9V+IXG0M4l/eRg
	+RTiQFQw==
X-Google-Smtp-Source: AGHT+IHNUEcI4dGui9wCqNj8HkGkF21OISnjXu+BlSkdJwIjIH51zcIZYvojSW5z2HdqpBmo1/y0MgOmPSp6
X-Received: by 2002:a05:6902:33c5:b0:e93:4b5c:d50d with SMTP id 3f1490d57ef6-e951c2a6db5mr25142878276.25.1756387167884;
        Thu, 28 Aug 2025 06:19:27 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 3f1490d57ef6-e9700d00255sm162121276.7.2025.08.28.06.19.27
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Aug 2025 06:19:27 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b49da0156bdso1380107a12.1
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 06:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756387166; x=1756991966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIFB/AlHZEsJK8LDJrBsJMdfECpeU+VhE2ENPC0h48s=;
        b=Twt+3Z95gBF4hEq8yTil3idU4dWwsF0mtoVKKLBnICYkFqUxFcsvx3WhwDPRh5HiCL
         TvzYdNbF1maVIG0/P+I26cusqxZ+c66VFWkDsEAC3YppPKOho73IE7IL2kCqcTTEfGDY
         Pu71NVVW8c6sXjjjDbagqv0VkGRyMIxJgU+AU=
X-Received: by 2002:a17:902:c406:b0:248:79d4:93a9 with SMTP id d9443c01a7336-24879d4975cmr121033405ad.55.1756387166199;
        Thu, 28 Aug 2025 06:19:26 -0700 (PDT)
X-Received: by 2002:a17:902:c406:b0:248:79d4:93a9 with SMTP id d9443c01a7336-24879d4975cmr121032705ad.55.1756387165227;
        Thu, 28 Aug 2025 06:19:25 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-248b6a16ae3sm36468705ad.137.2025.08.28.06.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 06:19:24 -0700 (PDT)
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
Subject: [v5, net-next 7/9] bng_en: Register rings with the firmware
Date: Thu, 28 Aug 2025 18:45:45 +0000
Message-ID: <20250828184547.242496-8-bhargava.marreddy@broadcom.com>
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

Enable ring functionality by registering RX, AGG, TX, CMPL, and
NQ rings with the firmware. Initialise the doorbells associated
with the rings.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge.h     |  24 ++
 .../net/ethernet/broadcom/bnge/bnge_core.c    |   4 +
 drivers/net/ethernet/broadcom/bnge/bnge_db.h  |  34 ++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    | 147 ++++++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |   6 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 349 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  16 +
 .../net/ethernet/broadcom/bnge/bnge_rmem.h    |   1 +
 8 files changed, 581 insertions(+)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_db.h

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index 07df86f0061f..642e16f511d5 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -106,6 +106,10 @@ struct bnge_dev {
 	u16		chip_num;
 	u8		chip_rev;
 
+#if BITS_PER_LONG == 32
+	/* ensure atomic 64-bit doorbell writes on 32-bit systems. */
+	spinlock_t	db_lock;
+#endif
 	int		db_offset; /* db_offset within db_size */
 	int		db_size;
 
@@ -218,6 +222,26 @@ static inline bool bnge_is_agg_reqd(struct bnge_dev *bd)
 	return true;
 }
 
+static inline void bnge_writeq(struct bnge_dev *bd, u64 val,
+			       void __iomem *addr)
+{
+#if BITS_PER_LONG == 32
+	spin_lock(&bd->db_lock);
+	lo_hi_writeq(val, addr);
+	spin_unlock(&bd->db_lock);
+#else
+	writeq(val, addr);
+#endif
+}
+
+/* For TX and RX ring doorbells */
+static inline void bnge_db_write(struct bnge_dev *bd, struct bnge_db_info *db,
+				 u32 idx)
+{
+	bnge_writeq(bd, db->db_key64 | DB_RING_IDX(db, idx),
+		    db->doorbell);
+}
+
 bool bnge_aux_registered(struct bnge_dev *bd);
 u16 bnge_aux_get_msix(struct bnge_dev *bd);
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_core.c b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
index 51e93b7f9899..56a3dd2a23ee 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_core.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
@@ -302,6 +302,10 @@ static int bnge_probe_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_config_uninit;
 	}
 
+#if BITS_PER_LONG == 32
+	spin_lock_init(&bd->db_lock);
+#endif
+
 	rc = bnge_alloc_irqs(bd);
 	if (rc) {
 		dev_err(&pdev->dev, "Error IRQ allocation rc = %d\n", rc);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_db.h b/drivers/net/ethernet/broadcom/bnge/bnge_db.h
new file mode 100644
index 000000000000..950ed582f1d8
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_db.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2025 Broadcom */
+
+#ifndef _BNGE_DB_H_
+#define _BNGE_DB_H_
+
+/* 64-bit doorbell */
+#define DBR_EPOCH_SFT					24
+#define DBR_TOGGLE_SFT					25
+#define DBR_XID_SFT					32
+#define DBR_PATH_L2					(0x1ULL << 56)
+#define DBR_VALID					(0x1ULL << 58)
+#define DBR_TYPE_SQ					(0x0ULL << 60)
+#define DBR_TYPE_SRQ					(0x2ULL << 60)
+#define DBR_TYPE_CQ					(0x4ULL << 60)
+#define DBR_TYPE_CQ_ARMALL				(0x6ULL << 60)
+#define DBR_TYPE_NQ					(0xaULL << 60)
+#define DBR_TYPE_NQ_ARM					(0xbULL << 60)
+#define DBR_TYPE_NQ_MASK				(0xeULL << 60)
+
+struct bnge_db_info {
+	void __iomem		*doorbell;
+	u64			db_key64;
+	u32			db_ring_mask;
+	u32			db_epoch_mask;
+	u8			db_epoch_shift;
+};
+
+#define DB_EPOCH(db, idx)	(((idx) & (db)->db_epoch_mask) <<	\
+				 ((db)->db_epoch_shift))
+#define DB_RING_IDX(db, idx)	(((idx) & (db)->db_ring_mask) |		\
+				 DB_EPOCH(db, idx))
+
+#endif /* _BNGE_DB_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index d77ea5536e7c..a7c18a57fbca 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
@@ -760,3 +760,150 @@ int bnge_hwrm_stat_ctx_alloc(struct bnge_net *bn)
 	bnge_hwrm_req_drop(bd, req);
 	return rc;
 }
+
+int hwrm_ring_free_send_msg(struct bnge_net *bn,
+			    struct bnge_ring_struct *ring,
+			    u32 ring_type, int cmpl_ring_id)
+{
+	struct hwrm_ring_free_input *req;
+	struct bnge_dev *bd = bn->bd;
+	int rc;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_RING_FREE);
+	if (rc)
+		goto exit;
+
+	req->cmpl_ring = cpu_to_le16(cmpl_ring_id);
+	req->ring_type = ring_type;
+	req->ring_id = cpu_to_le16(ring->fw_ring_id);
+
+	bnge_hwrm_req_hold(bd, req);
+	rc = bnge_hwrm_req_send(bd, req);
+	bnge_hwrm_req_drop(bd, req);
+exit:
+	if (rc) {
+		netdev_err(bd->netdev, "hwrm_ring_free type %d failed. rc:%d\n", ring_type, rc);
+		return -EIO;
+	}
+	return 0;
+}
+
+int hwrm_ring_alloc_send_msg(struct bnge_net *bn,
+			     struct bnge_ring_struct *ring,
+			     u32 ring_type, u32 map_index)
+{
+	struct bnge_ring_mem_info *rmem = &ring->ring_mem;
+	struct bnge_ring_grp_info *grp_info;
+	struct hwrm_ring_alloc_output *resp;
+	struct hwrm_ring_alloc_input *req;
+	struct bnge_dev *bd = bn->bd;
+	u16 ring_id, flags = 0;
+	int rc;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_RING_ALLOC);
+	if (rc)
+		goto exit;
+
+	req->enables = 0;
+	if (rmem->nr_pages > 1) {
+		req->page_tbl_addr = cpu_to_le64(rmem->dma_pg_tbl);
+		/* Page size is in log2 units */
+		req->page_size = BNGE_PAGE_SHIFT;
+		req->page_tbl_depth = 1;
+	} else {
+		req->page_tbl_addr =  cpu_to_le64(rmem->dma_arr[0]);
+	}
+	req->fbo = 0;
+	/* Association of ring index with doorbell index and MSIX number */
+	req->logical_id = cpu_to_le16(map_index);
+
+	switch (ring_type) {
+	case HWRM_RING_ALLOC_TX: {
+		struct bnge_tx_ring_info *txr;
+
+		txr = container_of(ring, struct bnge_tx_ring_info,
+				   tx_ring_struct);
+		req->ring_type = RING_ALLOC_REQ_RING_TYPE_TX;
+		/* Association of transmit ring with completion ring */
+		grp_info = &bn->grp_info[ring->grp_idx];
+		req->cmpl_ring_id = cpu_to_le16(bnge_cp_ring_for_tx(txr));
+		req->length = cpu_to_le32(bn->tx_ring_mask + 1);
+		req->stat_ctx_id = cpu_to_le32(grp_info->fw_stats_ctx);
+		req->queue_id = cpu_to_le16(ring->queue_id);
+		req->flags = cpu_to_le16(flags);
+		break;
+	}
+	case HWRM_RING_ALLOC_RX:
+		req->ring_type = RING_ALLOC_REQ_RING_TYPE_RX;
+		req->length = cpu_to_le32(bn->rx_ring_mask + 1);
+
+		/* Association of rx ring with stats context */
+		grp_info = &bn->grp_info[ring->grp_idx];
+		req->rx_buf_size = cpu_to_le16(bn->rx_buf_use_size);
+		req->stat_ctx_id = cpu_to_le32(grp_info->fw_stats_ctx);
+		req->enables |=
+			cpu_to_le32(RING_ALLOC_REQ_ENABLES_RX_BUF_SIZE_VALID);
+		if (NET_IP_ALIGN == 2)
+			flags = RING_ALLOC_REQ_FLAGS_RX_SOP_PAD;
+		req->flags = cpu_to_le16(flags);
+		break;
+	case HWRM_RING_ALLOC_AGG:
+		req->ring_type = RING_ALLOC_REQ_RING_TYPE_RX_AGG;
+		/* Association of agg ring with rx ring */
+		grp_info = &bn->grp_info[ring->grp_idx];
+		req->rx_ring_id = cpu_to_le16(grp_info->rx_fw_ring_id);
+		req->rx_buf_size = cpu_to_le16(BNGE_RX_PAGE_SIZE);
+		req->stat_ctx_id = cpu_to_le32(grp_info->fw_stats_ctx);
+		req->enables |=
+			cpu_to_le32(RING_ALLOC_REQ_ENABLES_RX_RING_ID_VALID |
+				    RING_ALLOC_REQ_ENABLES_RX_BUF_SIZE_VALID);
+		req->length = cpu_to_le32(bn->rx_agg_ring_mask + 1);
+		break;
+	case HWRM_RING_ALLOC_CMPL:
+		req->ring_type = RING_ALLOC_REQ_RING_TYPE_L2_CMPL;
+		req->length = cpu_to_le32(bn->cp_ring_mask + 1);
+		/* Association of cp ring with nq */
+		grp_info = &bn->grp_info[map_index];
+		req->nq_ring_id = cpu_to_le16(grp_info->nq_fw_ring_id);
+		req->cq_handle = cpu_to_le64(ring->handle);
+		req->enables |=
+			cpu_to_le32(RING_ALLOC_REQ_ENABLES_NQ_RING_ID_VALID);
+		break;
+	case HWRM_RING_ALLOC_NQ:
+		req->ring_type = RING_ALLOC_REQ_RING_TYPE_NQ;
+		req->length = cpu_to_le32(bn->cp_ring_mask + 1);
+		req->int_mode = RING_ALLOC_REQ_INT_MODE_MSIX;
+		break;
+	default:
+		netdev_err(bn->netdev, "hwrm alloc invalid ring type %d\n", ring_type);
+		return -EINVAL;
+	}
+
+	resp = bnge_hwrm_req_hold(bd, req);
+	rc = bnge_hwrm_req_send(bd, req);
+	ring_id = le16_to_cpu(resp->ring_id);
+	bnge_hwrm_req_drop(bd, req);
+
+exit:
+	if (rc) {
+		netdev_err(bd->netdev, "hwrm_ring_alloc type %d failed. rc:%d\n", ring_type, rc);
+		return -EIO;
+	}
+	ring->fw_ring_id = ring_id;
+	return rc;
+}
+
+int bnge_hwrm_set_async_event_cr(struct bnge_dev *bd, int idx)
+{
+	struct hwrm_func_cfg_input *req;
+	int rc;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_FUNC_CFG);
+	if (rc)
+		return rc;
+
+	req->fid = cpu_to_le16(0xffff);
+	req->enables = cpu_to_le32(FUNC_CFG_REQ_ENABLES_ASYNC_EVENT_CR);
+	req->async_event_cr = cpu_to_le16(idx);
+	return bnge_hwrm_req_send(bd, req);
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
index 1c3fd02d7e0a..b2e2ec47be2e 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
@@ -26,4 +26,10 @@ int bnge_hwrm_queue_qportcfg(struct bnge_dev *bd);
 
 void bnge_hwrm_stat_ctx_free(struct bnge_net *bn);
 int bnge_hwrm_stat_ctx_alloc(struct bnge_net *bn);
+int hwrm_ring_free_send_msg(struct bnge_net *bn, struct bnge_ring_struct *ring,
+			    u32 ring_type, int cmpl_ring_id);
+int hwrm_ring_alloc_send_msg(struct bnge_net *bn,
+			     struct bnge_ring_struct *ring,
+			     u32 ring_type, u32 map_index);
+int bnge_hwrm_set_async_event_cr(struct bnge_dev *bd, int idx);
 #endif /* _BNGE_HWRM_LIB_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 501d8b832492..58e4f42830b0 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -829,6 +829,28 @@ static int bnge_alloc_core(struct bnge_net *bn)
 	return rc;
 }
 
+u16 bnge_cp_ring_for_rx(struct bnge_rx_ring_info *rxr)
+{
+	return rxr->rx_cpr->ring_struct.fw_ring_id;
+}
+
+u16 bnge_cp_ring_for_tx(struct bnge_tx_ring_info *txr)
+{
+	return txr->tx_cpr->ring_struct.fw_ring_id;
+}
+
+static void bnge_db_nq(struct bnge_net *bn, struct bnge_db_info *db, u32 idx)
+{
+	bnge_writeq(bn->bd, db->db_key64 | DBR_TYPE_NQ_MASK |
+		    DB_RING_IDX(db, idx), db->doorbell);
+}
+
+static void bnge_db_cq(struct bnge_net *bn, struct bnge_db_info *db, u32 idx)
+{
+	bnge_writeq(bn->bd, db->db_key64 | DBR_TYPE_CQ_ARMALL |
+		    DB_RING_IDX(db, idx), db->doorbell);
+}
+
 static int bnge_cp_num_to_irq_num(struct bnge_net *bn, int n)
 {
 	struct bnge_napi *bnapi = bn->bnapi[n];
@@ -1197,6 +1219,326 @@ static void bnge_init_vnics(struct bnge_net *bn)
 	}
 }
 
+static void bnge_set_db_mask(struct bnge_net *bn, struct bnge_db_info *db,
+			     u32 ring_type)
+{
+	switch (ring_type) {
+	case HWRM_RING_ALLOC_TX:
+		db->db_ring_mask = bn->tx_ring_mask;
+		break;
+	case HWRM_RING_ALLOC_RX:
+		db->db_ring_mask = bn->rx_ring_mask;
+		break;
+	case HWRM_RING_ALLOC_AGG:
+		db->db_ring_mask = bn->rx_agg_ring_mask;
+		break;
+	case HWRM_RING_ALLOC_CMPL:
+	case HWRM_RING_ALLOC_NQ:
+		db->db_ring_mask = bn->cp_ring_mask;
+		break;
+	}
+	db->db_epoch_mask = db->db_ring_mask + 1;
+	db->db_epoch_shift = DBR_EPOCH_SFT - ilog2(db->db_epoch_mask);
+}
+
+static void bnge_set_db(struct bnge_net *bn, struct bnge_db_info *db,
+			u32 ring_type, u32 map_idx, u32 xid)
+{
+	struct bnge_dev *bd = bn->bd;
+
+	switch (ring_type) {
+	case HWRM_RING_ALLOC_TX:
+		db->db_key64 = DBR_PATH_L2 | DBR_TYPE_SQ;
+		break;
+	case HWRM_RING_ALLOC_RX:
+	case HWRM_RING_ALLOC_AGG:
+		db->db_key64 = DBR_PATH_L2 | DBR_TYPE_SRQ;
+		break;
+	case HWRM_RING_ALLOC_CMPL:
+		db->db_key64 = DBR_PATH_L2;
+		break;
+	case HWRM_RING_ALLOC_NQ:
+		db->db_key64 = DBR_PATH_L2;
+		break;
+	}
+	db->db_key64 |= ((u64)xid << DBR_XID_SFT) | DBR_VALID;
+
+	db->doorbell = bd->bar1 + bd->db_offset;
+	bnge_set_db_mask(bn, db, ring_type);
+}
+
+static int bnge_hwrm_cp_ring_alloc(struct bnge_net *bn,
+				   struct bnge_cp_ring_info *cpr)
+{
+	const u32 type = HWRM_RING_ALLOC_CMPL;
+	struct bnge_napi *bnapi = cpr->bnapi;
+	struct bnge_ring_struct *ring;
+	u32 map_idx = bnapi->index;
+	int rc;
+
+	ring = &cpr->ring_struct;
+	ring->handle = BNGE_SET_NQ_HDL(cpr);
+	rc = hwrm_ring_alloc_send_msg(bn, ring, type, map_idx);
+	if (rc)
+		return rc;
+
+	bnge_set_db(bn, &cpr->cp_db, type, map_idx, ring->fw_ring_id);
+	bnge_db_cq(bn, &cpr->cp_db, cpr->cp_raw_cons);
+
+	return 0;
+}
+
+static int bnge_hwrm_tx_ring_alloc(struct bnge_net *bn,
+				   struct bnge_tx_ring_info *txr, u32 tx_idx)
+{
+	struct bnge_ring_struct *ring = &txr->tx_ring_struct;
+	const u32 type = HWRM_RING_ALLOC_TX;
+	int rc;
+
+	rc = hwrm_ring_alloc_send_msg(bn, ring, type, tx_idx);
+	if (rc)
+		return rc;
+
+	bnge_set_db(bn, &txr->tx_db, type, tx_idx, ring->fw_ring_id);
+
+	return 0;
+}
+
+static int bnge_hwrm_rx_agg_ring_alloc(struct bnge_net *bn,
+				       struct bnge_rx_ring_info *rxr)
+{
+	struct bnge_ring_struct *ring = &rxr->rx_agg_ring_struct;
+	u32 type = HWRM_RING_ALLOC_AGG;
+	struct bnge_dev *bd = bn->bd;
+	u32 grp_idx = ring->grp_idx;
+	u32 map_idx;
+	int rc;
+
+	map_idx = grp_idx + bd->rx_nr_rings;
+	rc = hwrm_ring_alloc_send_msg(bn, ring, type, map_idx);
+	if (rc)
+		return rc;
+
+	bnge_set_db(bn, &rxr->rx_agg_db, type, map_idx,
+		    ring->fw_ring_id);
+	bnge_db_write(bn->bd, &rxr->rx_agg_db, rxr->rx_agg_prod);
+	bnge_db_write(bn->bd, &rxr->rx_db, rxr->rx_prod);
+	bn->grp_info[grp_idx].agg_fw_ring_id = ring->fw_ring_id;
+
+	return 0;
+}
+
+static int bnge_hwrm_rx_ring_alloc(struct bnge_net *bn,
+				   struct bnge_rx_ring_info *rxr)
+{
+	struct bnge_ring_struct *ring = &rxr->rx_ring_struct;
+	struct bnge_napi *bnapi = rxr->bnapi;
+	u32 type = HWRM_RING_ALLOC_RX;
+	u32 map_idx = bnapi->index;
+	int rc;
+
+	rc = hwrm_ring_alloc_send_msg(bn, ring, type, map_idx);
+	if (rc)
+		return rc;
+
+	bnge_set_db(bn, &rxr->rx_db, type, map_idx, ring->fw_ring_id);
+	bn->grp_info[map_idx].rx_fw_ring_id = ring->fw_ring_id;
+
+	return 0;
+}
+
+static int bnge_hwrm_ring_alloc(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	bool agg_rings;
+	int i, rc = 0;
+
+	agg_rings = !!(bnge_is_agg_reqd(bd));
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+		struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;
+		struct bnge_ring_struct *ring = &nqr->ring_struct;
+		u32 type = HWRM_RING_ALLOC_NQ;
+		u32 map_idx = ring->map_idx;
+		unsigned int vector;
+
+		vector = bd->irq_tbl[map_idx].vector;
+		disable_irq_nosync(vector);
+		rc = hwrm_ring_alloc_send_msg(bn, ring, type, map_idx);
+		if (rc) {
+			enable_irq(vector);
+			goto err_out;
+		}
+		bnge_set_db(bn, &nqr->nq_db, type, map_idx, ring->fw_ring_id);
+		bnge_db_nq(bn, &nqr->nq_db, nqr->nq_raw_cons);
+		enable_irq(vector);
+		bn->grp_info[i].nq_fw_ring_id = ring->fw_ring_id;
+
+		if (!i) {
+			rc = bnge_hwrm_set_async_event_cr(bd, ring->fw_ring_id);
+			if (rc)
+				netdev_warn(bn->netdev, "Failed to set async event completion ring.\n");
+		}
+	}
+
+	for (i = 0; i < bd->tx_nr_rings; i++) {
+		struct bnge_tx_ring_info *txr = &bn->tx_ring[i];
+
+		rc = bnge_hwrm_cp_ring_alloc(bn, txr->tx_cpr);
+		if (rc)
+			goto err_out;
+		rc = bnge_hwrm_tx_ring_alloc(bn, txr, i);
+		if (rc)
+			goto err_out;
+	}
+
+	for (i = 0; i < bd->rx_nr_rings; i++) {
+		struct bnge_rx_ring_info *rxr = &bn->rx_ring[i];
+		struct bnge_cp_ring_info *cpr;
+		struct bnge_ring_struct *ring;
+		struct bnge_napi *bnapi;
+		u32 map_idx, type;
+
+		rc = bnge_hwrm_rx_ring_alloc(bn, rxr);
+		if (rc)
+			goto err_out;
+		/* If we have agg rings, post agg buffers first. */
+		if (!agg_rings)
+			bnge_db_write(bn->bd, &rxr->rx_db, rxr->rx_prod);
+
+		cpr = rxr->rx_cpr;
+		bnapi = rxr->bnapi;
+		type = HWRM_RING_ALLOC_CMPL;
+		map_idx = bnapi->index;
+
+		ring = &cpr->ring_struct;
+		ring->handle = BNGE_SET_NQ_HDL(cpr);
+		rc = hwrm_ring_alloc_send_msg(bn, ring, type, map_idx);
+		if (rc)
+			goto err_out;
+		bnge_set_db(bn, &cpr->cp_db, type, map_idx,
+			    ring->fw_ring_id);
+		bnge_db_cq(bn, &cpr->cp_db, cpr->cp_raw_cons);
+	}
+
+	if (agg_rings) {
+		for (i = 0; i < bd->rx_nr_rings; i++) {
+			rc = bnge_hwrm_rx_agg_ring_alloc(bn, &bn->rx_ring[i]);
+			if (rc)
+				goto err_out;
+		}
+	}
+err_out:
+	return rc;
+}
+
+static void bnge_hwrm_rx_ring_free(struct bnge_net *bn,
+				   struct bnge_rx_ring_info *rxr,
+				   bool close_path)
+{
+	struct bnge_ring_struct *ring = &rxr->rx_ring_struct;
+	u32 grp_idx = rxr->bnapi->index;
+	u32 cmpl_ring_id;
+
+	if (ring->fw_ring_id == INVALID_HW_RING_ID)
+		return;
+
+	cmpl_ring_id = bnge_cp_ring_for_rx(rxr);
+	hwrm_ring_free_send_msg(bn, ring,
+				RING_FREE_REQ_RING_TYPE_RX,
+				close_path ? cmpl_ring_id :
+				INVALID_HW_RING_ID);
+	ring->fw_ring_id = INVALID_HW_RING_ID;
+	bn->grp_info[grp_idx].rx_fw_ring_id = INVALID_HW_RING_ID;
+}
+
+static void bnge_hwrm_rx_agg_ring_free(struct bnge_net *bn,
+				       struct bnge_rx_ring_info *rxr,
+				       bool close_path)
+{
+	struct bnge_ring_struct *ring = &rxr->rx_agg_ring_struct;
+	u32 grp_idx = rxr->bnapi->index;
+	u32 cmpl_ring_id;
+
+	if (ring->fw_ring_id == INVALID_HW_RING_ID)
+		return;
+
+	cmpl_ring_id = bnge_cp_ring_for_rx(rxr);
+	hwrm_ring_free_send_msg(bn, ring, RING_FREE_REQ_RING_TYPE_RX_AGG,
+				close_path ? cmpl_ring_id :
+				INVALID_HW_RING_ID);
+	ring->fw_ring_id = INVALID_HW_RING_ID;
+	bn->grp_info[grp_idx].agg_fw_ring_id = INVALID_HW_RING_ID;
+}
+
+static void bnge_hwrm_tx_ring_free(struct bnge_net *bn,
+				   struct bnge_tx_ring_info *txr,
+				   bool close_path)
+{
+	struct bnge_ring_struct *ring = &txr->tx_ring_struct;
+	u32 cmpl_ring_id;
+
+	if (ring->fw_ring_id == INVALID_HW_RING_ID)
+		return;
+
+	cmpl_ring_id = close_path ? bnge_cp_ring_for_tx(txr) :
+		       INVALID_HW_RING_ID;
+	hwrm_ring_free_send_msg(bn, ring, RING_FREE_REQ_RING_TYPE_TX,
+				cmpl_ring_id);
+	ring->fw_ring_id = INVALID_HW_RING_ID;
+}
+
+static void bnge_hwrm_cp_ring_free(struct bnge_net *bn,
+				   struct bnge_cp_ring_info *cpr)
+{
+	struct bnge_ring_struct *ring;
+
+	ring = &cpr->ring_struct;
+	if (ring->fw_ring_id == INVALID_HW_RING_ID)
+		return;
+
+	hwrm_ring_free_send_msg(bn, ring, RING_FREE_REQ_RING_TYPE_L2_CMPL,
+				INVALID_HW_RING_ID);
+	ring->fw_ring_id = INVALID_HW_RING_ID;
+}
+
+static void bnge_hwrm_ring_free(struct bnge_net *bn, bool close_path)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i;
+
+	if (!bn->bnapi)
+		return;
+
+	for (i = 0; i < bd->tx_nr_rings; i++)
+		bnge_hwrm_tx_ring_free(bn, &bn->tx_ring[i], close_path);
+
+	for (i = 0; i < bd->rx_nr_rings; i++) {
+		bnge_hwrm_rx_ring_free(bn, &bn->rx_ring[i], close_path);
+		bnge_hwrm_rx_agg_ring_free(bn, &bn->rx_ring[i], close_path);
+	}
+
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+		struct bnge_nq_ring_info *nqr;
+		struct bnge_ring_struct *ring;
+		int j;
+
+		nqr = &bnapi->nq_ring;
+		for (j = 0; j < nqr->cp_ring_count && nqr->cp_ring_arr; j++)
+			bnge_hwrm_cp_ring_free(bn, &nqr->cp_ring_arr[j]);
+
+		ring = &nqr->ring_struct;
+		if (ring->fw_ring_id != INVALID_HW_RING_ID) {
+			hwrm_ring_free_send_msg(bn, ring,
+						RING_FREE_REQ_RING_TYPE_NQ,
+						INVALID_HW_RING_ID);
+			ring->fw_ring_id = INVALID_HW_RING_ID;
+			bn->grp_info[i].nq_fw_ring_id = INVALID_HW_RING_ID;
+		}
+	}
+}
+
 static void bnge_setup_msix(struct bnge_net *bn)
 {
 	struct net_device *dev = bn->netdev;
@@ -1250,6 +1592,7 @@ static int bnge_setup_interrupts(struct bnge_net *bn)
 
 static void bnge_hwrm_resource_free(struct bnge_net *bn, bool close_path)
 {
+	bnge_hwrm_ring_free(bn, close_path);
 	bnge_hwrm_stat_ctx_free(bn);
 }
 
@@ -1308,6 +1651,12 @@ static int bnge_init_chip(struct bnge_net *bn)
 		goto err_out;
 	}
 
+	rc = bnge_hwrm_ring_alloc(bn);
+	if (rc) {
+		netdev_err(bn->netdev, "hwrm ring alloc failure rc: %d\n", rc);
+		goto err_out;
+	}
+
 	return 0;
 err_out:
 	bnge_hwrm_resource_free(bn, 0);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 56df0765bf0a..ba0dd2202fb6 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -5,6 +5,8 @@
 #define _BNGE_NETDEV_H_
 
 #include <linux/bnxt/hsi.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include "bnge_db.h"
 
 struct tx_bd {
 	__le32 tx_bd_len_flags_type;
@@ -169,6 +171,7 @@ enum {
 #define RING_RX_AGG(bn, idx)	((idx) & (bn)->rx_agg_ring_mask)
 #define NEXT_RX_AGG(idx)	((idx) + 1)
 
+#define BNGE_NQ_HDL_TYPE_SHIFT	24
 #define BNGE_NQ_HDL_TYPE_RX	0x00
 #define BNGE_NQ_HDL_TYPE_TX	0x01
 
@@ -272,6 +275,9 @@ void bnge_set_ring_params(struct bnge_dev *bd);
 	     txr = (iter < BNGE_MAX_TXR_PER_NAPI - 1) ?	\
 	     (bnapi)->tx_ring[++iter] : NULL)
 
+#define BNGE_SET_NQ_HDL(cpr)						\
+	(((cpr)->cp_ring_type << BNGE_NQ_HDL_TYPE_SHIFT) | (cpr)->cp_idx)
+
 struct bnge_stats_mem {
 	u64		*sw_stats;
 	u64		*hw_masks;
@@ -287,6 +293,8 @@ struct bnge_cp_ring_info {
 	struct bnge_ring_struct	ring_struct;
 	u8			cp_ring_type;
 	u8			cp_idx;
+	u32			cp_raw_cons;
+	struct bnge_db_info	cp_db;
 };
 
 struct bnge_nq_ring_info {
@@ -294,6 +302,8 @@ struct bnge_nq_ring_info {
 	dma_addr_t		*desc_mapping;
 	struct nqe_cn		**desc_ring;
 	struct bnge_ring_struct	ring_struct;
+	u32			nq_raw_cons;
+	struct bnge_db_info	nq_db;
 
 	struct bnge_stats_mem	stats;
 	u32			hw_stats_ctx_id;
@@ -309,6 +319,8 @@ struct bnge_rx_ring_info {
 	u16			rx_agg_prod;
 	u16			rx_sw_agg_prod;
 	u16			rx_next_cons;
+	struct bnge_db_info	rx_db;
+	struct bnge_db_info	rx_agg_db;
 
 	struct rx_bd		*rx_desc_ring[MAX_RX_PAGES];
 	struct bnge_sw_rx_bd	*rx_buf_ring;
@@ -338,6 +350,7 @@ struct bnge_tx_ring_info {
 	u16			txq_index;
 	u8			tx_napi_idx;
 	u8			kick_pending;
+	struct bnge_db_info	tx_db;
 
 	struct tx_bd		*tx_desc_ring[MAX_TX_PAGES];
 	struct bnge_sw_tx_bd	*tx_buf_ring;
@@ -392,4 +405,7 @@ struct bnge_vnic_info {
 #define BNGE_VNIC_UCAST_FLAG	8
 	u32		vnic_id;
 };
+
+u16 bnge_cp_ring_for_rx(struct bnge_rx_ring_info *rxr);
+u16 bnge_cp_ring_for_tx(struct bnge_tx_ring_info *txr);
 #endif /* _BNGE_NETDEV_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h
index 0e7684e20714..341c7f81ed09 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h
@@ -189,6 +189,7 @@ struct bnge_ring_struct {
 		u16		grp_idx;
 		u16		map_idx; /* Used by NQs */
 	};
+	u32			handle;
 	u8			queue_id;
 };
 
-- 
2.47.3



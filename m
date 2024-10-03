Return-Path: <netdev+bounces-131674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5593C98F390
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 18:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1067528280F
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 16:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1527B1A4F3B;
	Thu,  3 Oct 2024 16:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R41VqN47"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B44F1A4F30;
	Thu,  3 Oct 2024 16:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727971613; cv=none; b=dQLQ6hXfuttgCGochVNanIwEzzrxBzA64t7eLtLH5U1yD1nozg6aegQh1W7ad/Jic0Me/x7SnglyN2icE7KRBDsA4fWoD5DWe+AiMk2umUth3uWBBGKARKZqjiFQyQ5tcdYexbXlwArPQ6clTzQapEDA2NyV1z8T84IJXrJ2oqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727971613; c=relaxed/simple;
	bh=jNSUloLXTW7XNo6ZIiysdZCvwrXEXTkS6KjsJozFq6g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YVIPpFxbrAqYJT6vCBaJaku3Og2WCIAx8LVJ+6adpPdqrm43rriSXENXikW3voHHLflG9HA8Gveo7eYmmEAELhugm+zhWjb9dKzFIdiktvf2bbz3YeRQlkZ84F5XYCFsD3its9P1SQL7n1nv8Mp3J1bURz3vR75Ir1R0GBuxEvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R41VqN47; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20b6458ee37so12282735ad.1;
        Thu, 03 Oct 2024 09:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727971611; x=1728576411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrdRZ6PxOosogiFJCfq5RDtTFnNKOZUdm2yfBEXM0OI=;
        b=R41VqN47CGXs8mlADR6fNG9GF9Q0wO5NwbdcCVIiprw10tKg/dDq0emFizMKH4Rxaf
         bzzUEwXsrYp96YJniY5jftTLDzEfxxXVFg2/OKlVXR437xmBz7qh6e51xd2zr94UCz/Q
         SfKAxJRG6h+D4nCbCZ54xH5E8iMp+NV+YwiUKQHBexwbSgqMauGXbpkcW30sdTFgIkgn
         ZUQvmTiIzPpJkP215eGjpEcLq1CFS32EfXfjBrXzhS5jDQI3/8zPLeAQyU/Sn8l7t0/I
         wMJMi92XyuQ5+juq5TAWqFvGYEghf4NQiUOAu+IZYC5SFrVDNRDYyQAVAk9elxoMwjRS
         jgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727971611; x=1728576411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CrdRZ6PxOosogiFJCfq5RDtTFnNKOZUdm2yfBEXM0OI=;
        b=GVwbk7bj2/IgA3RIB+ec3JoDQmgMhGrpIWX2t6/Fy94okirEEEpjV2fyFFoGZmSsU0
         7Y1MCyFW9+aEJMV3hWI7wUrZaf0w/M4W+0qajKSTFXxqoZripC3omQcsyt6amr2ulvHY
         dU4fVYVZLlpP1JcCsRH4Phk8TeFrOJkZqJMT/ku5qQTq7R0Mn9Qb9zJVXLytxMI+ivd3
         UwBiw1EcmqzMWWGaglRC/+05tQsHTqcdMHMPuV0N2K48xOaXKwp7iStsYxefxmnd1fQM
         biGmo/VBADRGAnER8zdiwA+PO1Oi1UK8DcFkVewkMzjyL4FeRjFs/p4wg6Roqo+H44sO
         vxyA==
X-Forwarded-Encrypted: i=1; AJvYcCU/KML/4dgY1nh1ONHSvSbouaGnEg3zSZfUoIPIL5cJQFiUC//q+ruQMNgPRv+TcttNrt5jgjti@vger.kernel.org, AJvYcCW6rErzaln+pkurHjm/BiBIG6eyHs+mkSwy3r7tt/qq8Wj17Ak8a8vuXVdw9gsmidw5CxdoxL3/gnc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe2UoX80oCk0knH/YzDncNchNMHW3+TBctPNAjJLbVIeSZziec
	vQqZFV/dkhI055Dh9RQekpk2fSjH2zT64+cwDQCP49BZIL0kn8XO
X-Google-Smtp-Source: AGHT+IGK8beT/Um9fHuskDtoU6uwH7Ywmp1rWC395Q/iU2v8bBZutSYeZe5TEQ1WyeHgB/tJLdoRNQ==
X-Received: by 2002:a17:903:22d2:b0:20b:751f:c9ca with SMTP id d9443c01a7336-20bc59ae37emr105030175ad.5.1727971610624;
        Thu, 03 Oct 2024 09:06:50 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20bef7071f1sm10425435ad.292.2024.10.03.09.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 09:06:49 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	almasrymina@google.com,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	michael.chan@broadcom.com
Cc: kory.maincent@bootlin.com,
	andrew@lunn.ch,
	maxime.chevallier@bootlin.com,
	danieller@nvidia.com,
	hengqi@linux.alibaba.com,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	hkallweit1@gmail.com,
	ahmed.zaki@intel.com,
	paul.greenwalt@intel.com,
	rrameshbabu@nvidia.com,
	idosch@nvidia.com,
	asml.silence@gmail.com,
	kaiyuanz@google.com,
	willemb@google.com,
	aleksander.lobakin@intel.com,
	dw@davidwei.uk,
	sridhar.samudrala@intel.com,
	bcreeley@amd.com,
	ap420073@gmail.com
Subject: [PATCH net-next v3 2/7] bnxt_en: add support for tcp-data-split ethtool command
Date: Thu,  3 Oct 2024 16:06:15 +0000
Message-Id: <20241003160620.1521626-3-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241003160620.1521626-1-ap420073@gmail.com>
References: <20241003160620.1521626-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NICs that uses bnxt_en driver supports tcp-data-split feature by the
name of HDS(header-data-split).
But there is no implementation for the HDS to enable or disable by
ethtool.
Only getting the current HDS status is implemented and The HDS is just
automatically enabled only when either LRO, HW-GRO, or JUMBO is enabled.
The hds_threshold follows rx-copybreak value. and it was unchangeable.

This implements `ethtool -G <interface name> tcp-data-split <value>`
command option.
The value can be <on>, <off>, and <auto> but the <auto> will be
automatically changed to <on>.

HDS feature relies on the aggregation ring.
So, if HDS is enabled, the bnxt_en driver initializes the aggregation
ring.
This is the reason why BNXT_FLAG_AGG_RINGS contains HDS condition.

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v3:
 - No changes.

v2:
 - Do not set hds_threshold to 0.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  9 +++----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  5 ++--
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 25 +++++++++++++++++--
 3 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 8da211e083a4..f046478dfd2a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4454,6 +4454,7 @@ void bnxt_set_tpa_flags(struct bnxt *bp)
 static void bnxt_init_ring_params(struct bnxt *bp)
 {
 	bp->rx_copybreak = BNXT_DEFAULT_RX_COPYBREAK;
+	bp->flags |= BNXT_FLAG_HDS;
 }
 
 /* bp->rx_ring_size, bp->tx_ring_size, dev->mtu, BNXT_FLAG_{G|L}RO flags must
@@ -4474,7 +4475,7 @@ void bnxt_set_ring_params(struct bnxt *bp)
 	bp->rx_agg_ring_size = 0;
 	bp->rx_agg_nr_pages = 0;
 
-	if (bp->flags & BNXT_FLAG_TPA)
+	if (bp->flags & BNXT_FLAG_TPA || bp->flags & BNXT_FLAG_HDS)
 		agg_factor = min_t(u32, 4, 65536 / BNXT_RX_PAGE_SIZE);
 
 	bp->flags &= ~BNXT_FLAG_JUMBO;
@@ -6421,15 +6422,13 @@ static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 
 	req->flags = cpu_to_le32(VNIC_PLCMODES_CFG_REQ_FLAGS_JUMBO_PLACEMENT);
 	req->enables = cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_JUMBO_THRESH_VALID);
+	req->jumbo_thresh = cpu_to_le16(bp->rx_buf_use_size);
 
-	if (BNXT_RX_PAGE_MODE(bp)) {
-		req->jumbo_thresh = cpu_to_le16(bp->rx_buf_use_size);
-	} else {
+	if (bp->flags & BNXT_FLAG_HDS) {
 		req->flags |= cpu_to_le32(VNIC_PLCMODES_CFG_REQ_FLAGS_HDS_IPV4 |
 					  VNIC_PLCMODES_CFG_REQ_FLAGS_HDS_IPV6);
 		req->enables |=
 			cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_HDS_THRESHOLD_VALID);
-		req->jumbo_thresh = cpu_to_le16(bp->rx_copybreak);
 		req->hds_threshold = cpu_to_le16(bp->rx_copybreak);
 	}
 	req->vnic_id = cpu_to_le32(vnic->fw_vnic_id);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index cff031993223..35601c71dfe9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2202,8 +2202,6 @@ struct bnxt {
 	#define BNXT_FLAG_TPA		(BNXT_FLAG_LRO | BNXT_FLAG_GRO)
 	#define BNXT_FLAG_JUMBO		0x10
 	#define BNXT_FLAG_STRIP_VLAN	0x20
-	#define BNXT_FLAG_AGG_RINGS	(BNXT_FLAG_JUMBO | BNXT_FLAG_GRO | \
-					 BNXT_FLAG_LRO)
 	#define BNXT_FLAG_RFS		0x100
 	#define BNXT_FLAG_SHARED_RINGS	0x200
 	#define BNXT_FLAG_PORT_STATS	0x400
@@ -2224,6 +2222,9 @@ struct bnxt {
 	#define BNXT_FLAG_ROCE_MIRROR_CAP	0x4000000
 	#define BNXT_FLAG_TX_COAL_CMPL	0x8000000
 	#define BNXT_FLAG_PORT_STATS_EXT	0x10000000
+	#define BNXT_FLAG_HDS		0x20000000
+	#define BNXT_FLAG_AGG_RINGS	(BNXT_FLAG_JUMBO | BNXT_FLAG_GRO | \
+					 BNXT_FLAG_LRO | BNXT_FLAG_HDS)
 
 	#define BNXT_FLAG_ALL_CONFIG_FEATS (BNXT_FLAG_TPA |		\
 					    BNXT_FLAG_RFS |		\
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index fdecdf8894b3..e9ef65dd2e7b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -829,12 +829,16 @@ static void bnxt_get_ringparam(struct net_device *dev,
 	if (bp->flags & BNXT_FLAG_AGG_RINGS) {
 		ering->rx_max_pending = BNXT_MAX_RX_DESC_CNT_JUM_ENA;
 		ering->rx_jumbo_max_pending = BNXT_MAX_RX_JUM_DESC_CNT;
-		kernel_ering->tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_ENABLED;
 	} else {
 		ering->rx_max_pending = BNXT_MAX_RX_DESC_CNT;
 		ering->rx_jumbo_max_pending = 0;
-		kernel_ering->tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_DISABLED;
 	}
+
+	if (bp->flags & BNXT_FLAG_HDS)
+		kernel_ering->tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_ENABLED;
+	else
+		kernel_ering->tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_DISABLED;
+
 	ering->tx_max_pending = BNXT_MAX_TX_DESC_CNT;
 
 	ering->rx_pending = bp->rx_ring_size;
@@ -854,9 +858,25 @@ static int bnxt_set_ringparam(struct net_device *dev,
 	    (ering->tx_pending < BNXT_MIN_TX_DESC_CNT))
 		return -EINVAL;
 
+	if (kernel_ering->tcp_data_split != ETHTOOL_TCP_DATA_SPLIT_DISABLED &&
+	    BNXT_RX_PAGE_MODE(bp)) {
+		NL_SET_ERR_MSG_MOD(extack, "tcp-data-split can not be enabled with XDP");
+		return -EINVAL;
+	}
+
 	if (netif_running(dev))
 		bnxt_close_nic(bp, false, false);
 
+	switch (kernel_ering->tcp_data_split) {
+	case ETHTOOL_TCP_DATA_SPLIT_UNKNOWN:
+	case ETHTOOL_TCP_DATA_SPLIT_ENABLED:
+		bp->flags |= BNXT_FLAG_HDS;
+		break;
+	case ETHTOOL_TCP_DATA_SPLIT_DISABLED:
+		bp->flags &= ~BNXT_FLAG_HDS;
+		break;
+	}
+
 	bp->rx_ring_size = ering->rx_pending;
 	bp->tx_ring_size = ering->tx_pending;
 	bnxt_set_ring_params(bp);
@@ -5346,6 +5366,7 @@ const struct ethtool_ops bnxt_ethtool_ops = {
 				     ETHTOOL_COALESCE_STATS_BLOCK_USECS |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
 				     ETHTOOL_COALESCE_USE_CQE,
+	.supported_ring_params	= ETHTOOL_RING_USE_TCP_DATA_SPLIT,
 	.get_link_ksettings	= bnxt_get_link_ksettings,
 	.set_link_ksettings	= bnxt_set_link_ksettings,
 	.get_fec_stats		= bnxt_get_fec_stats,
-- 
2.34.1



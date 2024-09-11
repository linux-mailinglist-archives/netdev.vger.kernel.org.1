Return-Path: <netdev+bounces-127434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D62975628
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 16:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 683831F27843
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 14:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37951A2C21;
	Wed, 11 Sep 2024 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghx53zQf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3708A192B88;
	Wed, 11 Sep 2024 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726066588; cv=none; b=UQaPTGmVje2LZzZ7wyrymZwJBZ308GnTY7IsFMSyUjeE9mANTsgr7rLXH0K919+D47XDAebFRdtUjTWbtM8PhT4VfCbLIgRRwYdSWHSuNNWeU24yHDmY/aqnNIfsVlinJVot1QPh5XalDk4LywGEKvlor0NmDpg1Rw0lhGYYvWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726066588; c=relaxed/simple;
	bh=VlH9qghJ+ivGLa1Az3jXw3Wf8/BhZo7NkJYT/LbBYSM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Baw94MGCJPfEAgw729eYlrucTScb0OK80knv0SKVoADFbXuMHmU5KdgmpopGj+C+oyEhcIHHkQprt4iBHi0ykjTddkYx5pakYCiGqBco6242swIEXzOOSAlHMPuMj5DrTQ8O+b7p82+BUlzf11NLiznxL/h7k/KqzI1SfdKtJw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghx53zQf; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7d50b3a924bso2133309a12.0;
        Wed, 11 Sep 2024 07:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726066585; x=1726671385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TNx/nS63X+zv8pX/HRoQHqrSw4kohqQiIE/CxdrDUU=;
        b=ghx53zQfcMkrdwlR/Yta2N35BO8I8s2NunnoMK0ZfCWobXoxtIKMSPJk94QEe2/Kp3
         0fwRnd/ai/Pe4i/2eNVVeYcAmCalTCLIdA8FOlThWzjqGe6u82+1JUCHq/RGhqjOinEP
         KPt4+fzm+3sFWElOTSu2TVnXQ9EyBTbwrn6w+UhaOVQtJ2xVFmTRAOq+k0WoVHth2Eyw
         5SVk0iNIY1/VyCMWGhryoa8yU5uMw1MRVvvGIm8yTtGcGVWj/EasamQAmASt18N6l8f6
         qxPjthz5KS887IzPn5P43G+tZlTupUrSMmgI1vyzT+Xu1eMQQ2khoFiK16ywfVrz4ynx
         0cUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726066585; x=1726671385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3TNx/nS63X+zv8pX/HRoQHqrSw4kohqQiIE/CxdrDUU=;
        b=iPDvJ/WiiABQ/33TLZR7gqBFPzs5bUTfEv6J5IfDxjNl8YRIQfk4LL3C2qdFrENKsD
         9TkTAs1fzJRpS7/PF286VRMUIAziQRXSPlyuBEHNzI2BwU0kK97aVKtjY01+GH5pnRqQ
         P+o0+vCD/591Dj6gjXyCQfjoeXmd7/TPliMowTI1qec3lpU5tcOSP8b3CC17rdnM9RMM
         BHJ32Oh+vnskpvInXoG634rZSgzYOsl69vzzomCVFoSMp7MxnEpxf4U7Fvy0BuHLn/y5
         Su7DCBzgx8AXRYsRasC7wq/6zBug1mDTldwd9nd6nYUSjiS4IurA3ZPIf8Drtrn/dh8H
         mc0w==
X-Forwarded-Encrypted: i=1; AJvYcCUfxMKADH+v7EnylL+agj6wt1nh/QbMkPPaKWwmEk3SrdIe60zeFGDv82lE5radhd4mXERBOM0q@vger.kernel.org, AJvYcCVtTGcfvlDd8BuVwF1gOthyDGwO6q8jOy1Mo+g6YrJpa09A4RNSa2pKukk5DTDk+xZ8EhjTygP66ZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvjTKZaEANQkkd+oHBZ4w4j8Y/YSltjJ/CKwqpT7/e8LxABXdr
	H42KYfapEWIFl8u4Tz2sWvt29z8qnRrTzFvEWkpu/fsYn2FX/ZIN
X-Google-Smtp-Source: AGHT+IGXBtI5qGItAG7ecCkJspCcWLlfdNiOgWezv9eulwnfJ2v+OFrjVd2dJtsMK9Zc989t8arvEA==
X-Received: by 2002:a05:6a21:9201:b0:1cf:4da0:d95c with SMTP id adf61e73a8af0-1cf5e0aa0c7mr6793983637.23.1726066585393;
        Wed, 11 Sep 2024 07:56:25 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076af278aasm664995ad.28.2024.09.11.07.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 07:56:24 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	corbet@lwn.net,
	michael.chan@broadcom.com,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	kory.maincent@bootlin.com,
	ahmed.zaki@intel.com,
	paul.greenwalt@intel.com,
	rrameshbabu@nvidia.com,
	idosch@nvidia.com,
	maxime.chevallier@bootlin.com,
	danieller@nvidia.com,
	aleksander.lobakin@intel.com,
	ap420073@gmail.com
Subject: [PATCH net-next v2 2/4] bnxt_en: add support for tcp-data-split ethtool command
Date: Wed, 11 Sep 2024 14:55:53 +0000
Message-Id: <20240911145555.318605-3-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911145555.318605-1-ap420073@gmail.com>
References: <20240911145555.318605-1-ap420073@gmail.com>
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
index 201c3fcba04e..ab64d7f94796 100644
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
@@ -5344,6 +5364,7 @@ const struct ethtool_ops bnxt_ethtool_ops = {
 				     ETHTOOL_COALESCE_STATS_BLOCK_USECS |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
 				     ETHTOOL_COALESCE_USE_CQE,
+	.supported_ring_params	= ETHTOOL_RING_USE_TCP_DATA_SPLIT,
 	.get_link_ksettings	= bnxt_get_link_ksettings,
 	.set_link_ksettings	= bnxt_set_link_ksettings,
 	.get_fec_stats		= bnxt_get_fec_stats,
-- 
2.34.1



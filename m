Return-Path: <netdev+bounces-125830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF7796ED30
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 10:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28529284BD7
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 08:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7725315622E;
	Fri,  6 Sep 2024 08:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNO6fcc7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8BF158523
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 08:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725610086; cv=none; b=u9XGLT65uLERNRImWxDLH8OqxQL5qYOCQGoCrhBVhp5Lepievtgfl3PychXWt/GD6CHOT9U+sxWRRuwJMtUDkOm6iXSPvPYEIlcu+kNg7Yk8+B6zuqJfatSOzYX4sUGqSrXGhUr2EAKfHBcMGSlq1QJt30KMpAnlIig1RO3kgvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725610086; c=relaxed/simple;
	bh=eUmx0jFX3aP82jer+EaPWxqSqSUelCRoRuYfhcG6VZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=czoLD8vQdEZk1qFJ/vjnSiJpt9ZrbCkVyMG9Ea1FZZjmI1kn2vvggCkypEUUasjKksQ96WmECdDVh2aad0KN1x4559iWYK5+E/j3NTqM3EP+7wo1V9nF9q2JDoLQ/jYiSEyU38H+LyFt7lLx1JNNxr8ovR21PhXzHGxfDE7+icE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNO6fcc7; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20543fdb7acso13848225ad.1
        for <netdev@vger.kernel.org>; Fri, 06 Sep 2024 01:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725610084; x=1726214884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Co3JskdQXia9t4hL3yZS7izHK+YTE9h+4PZRfBdKArQ=;
        b=hNO6fcc7AzJH+Mh9rqjYP1DU/gDSDS3aqoDXShD7e5hcF3Sh8UmbmbXAJ67ryOu7q9
         smaTKHb/i+Eh7KJcVIPdOWEWefBsWT2wiTYSCnPB4QO/cuGT7IxGLt6scotAsxznn1Hb
         qOw3iFWcp8PUjyLLawcoMAwbh2Fq9ikzzhSI20tq+l04+yXNVerLZoWI6mc4ZvobiCnE
         9uvhPAsLEPSbn7VXlGknx9KFe47TNyE+/1Kkq+jQHTLIj1lWgvxq7bdw9+5QxtXiW2WK
         PrxIOA4mR5K+Jei7iDmmpJy/L3Bj0aGb3CMaTaRElFl9JhO1YmI72k1prKXPYapPA4TQ
         NoPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725610084; x=1726214884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Co3JskdQXia9t4hL3yZS7izHK+YTE9h+4PZRfBdKArQ=;
        b=WtSXrxXfU4/3DMRtLwQsXbl5vPMPLlx69SsmnzpRVfrZ4rQF5Yl5KN0BZgw9qZwkcC
         h2fCDyA6CncMNNpE0ZwZC9Lbsjx/VSRzJLXHo4cTtdzsMMuHTA8MCE/6i5YDgrsRyUxe
         BZUn4qulCDjZMeAW2zsVT1jNHIC60dHVvTCQ5xt3zH1cKQLo/Hin0vNF5vqGJSHnkmmQ
         6B/b2CApLxU+GqDG4zOAGCUsorpi+RihTbpYbS/5l8FCyi5VhvBU4/RULmogyoUrtcb7
         SfPZyBtLkojO2BLsB+ZjvEC/ebok6K+Pp+kja8wWHuuV/uxMenGKhPo0zp7Y5YFUTO56
         Sq8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUxURm05gUOKy8w5nR/9+v6i+W1KFKXSvtNRE8/UexcIHoThBMj85XW6rLAghNzuK4XSRxYV80=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKYwXRkcz6f1hnRZwpJP9BulvKGeIUbnN4re4sXFFDAeQ0vImg
	fdIeHbvoMJqTWkpl7Gy/i55gKMJbdq1OelTF4kCOnU6RMysuSc16
X-Google-Smtp-Source: AGHT+IGe3xs5OgVTCKUWRXdo5QLrM2/3puI382Bpdy738WmQzf+TwclHQilCJRKt34+OzHviPY1PtQ==
X-Received: by 2002:a17:902:e543:b0:1fb:90e1:c8c5 with SMTP id d9443c01a7336-206f0535d23mr24151845ad.33.1725610084140;
        Fri, 06 Sep 2024 01:08:04 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae912facsm38965205ad.45.2024.09.06.01.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 01:08:03 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	michael.chan@broadcom.com,
	netdev@vger.kernel.org
Cc: ap420073@gmail.com
Subject: [PATCH net-next 2/2] bnxt_en: add support for tcp-data-split ethtool command
Date: Fri,  6 Sep 2024 08:07:50 +0000
Message-Id: <20240906080750.1068983-3-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240906080750.1068983-1-ap420073@gmail.com>
References: <20240906080750.1068983-1-ap420073@gmail.com>
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

By this change, hds_threshold will always be 0 if tcp-data-split is
enabled until we provide some option to set/get tcp-data-split-threshold
option someday And hds_threshold doesn't follow rx-copybreak value
anymore.

HDS feature relies on the aggregation ring.
So, if HDS is enabled, the bnxt_en driver initializes the aggregation
ring.
This is the reason why BNXT_FLAG_AGG_RINGS contains HDS condition.

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 11 ++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  5 ++--
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 25 +++++++++++++++++--
 3 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index e1a4beece582..d3641616e313 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4453,6 +4453,7 @@ void bnxt_set_tpa_flags(struct bnxt *bp)
 static void bnxt_init_ring_params(struct bnxt *bp)
 {
 	bp->rx_copybreak = BNXT_DEFAULT_RX_COPYBREAK;
+	bp->flags |= BNXT_FLAG_HDS;
 }
 
 /* bp->rx_ring_size, bp->tx_ring_size, dev->mtu, BNXT_FLAG_{G|L}RO flags must
@@ -4473,7 +4474,7 @@ void bnxt_set_ring_params(struct bnxt *bp)
 	bp->rx_agg_ring_size = 0;
 	bp->rx_agg_nr_pages = 0;
 
-	if (bp->flags & BNXT_FLAG_TPA)
+	if (bp->flags & BNXT_FLAG_TPA || bp->flags & BNXT_FLAG_HDS)
 		agg_factor = min_t(u32, 4, 65536 / BNXT_RX_PAGE_SIZE);
 
 	bp->flags &= ~BNXT_FLAG_JUMBO;
@@ -6420,16 +6421,14 @@ static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 
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
-		req->hds_threshold = cpu_to_le16(bp->rx_copybreak);
+		req->hds_threshold = 0;
 	}
 	req->vnic_id = cpu_to_le32(vnic->fw_vnic_id);
 	return hwrm_req_send(bp, req);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index ad95d0ede5d8..382a87a80bb4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2198,8 +2198,6 @@ struct bnxt {
 	#define BNXT_FLAG_TPA		(BNXT_FLAG_LRO | BNXT_FLAG_GRO)
 	#define BNXT_FLAG_JUMBO		0x10
 	#define BNXT_FLAG_STRIP_VLAN	0x20
-	#define BNXT_FLAG_AGG_RINGS	(BNXT_FLAG_JUMBO | BNXT_FLAG_GRO | \
-					 BNXT_FLAG_LRO)
 	#define BNXT_FLAG_RFS		0x100
 	#define BNXT_FLAG_SHARED_RINGS	0x200
 	#define BNXT_FLAG_PORT_STATS	0x400
@@ -2220,6 +2218,9 @@ struct bnxt {
 	#define BNXT_FLAG_ROCE_MIRROR_CAP	0x4000000
 	#define BNXT_FLAG_TX_COAL_CMPL	0x8000000
 	#define BNXT_FLAG_PORT_STATS_EXT	0x10000000
+	#define BNXT_FLAG_HDS		0x20000000
+	#define BNXT_FLAG_AGG_RINGS	(BNXT_FLAG_JUMBO | BNXT_FLAG_GRO | \
+					 BNXT_FLAG_LRO | BNXT_FLAG_HDS)
 
 	#define BNXT_FLAG_ALL_CONFIG_FEATS (BNXT_FLAG_TPA |		\
 					    BNXT_FLAG_RFS |		\
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 052b53937757..f619a0bc3a6a 100644
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



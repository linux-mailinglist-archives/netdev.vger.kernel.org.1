Return-Path: <netdev+bounces-155024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A08A00B17
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 16:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF7857A18FD
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 15:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27F81FAC52;
	Fri,  3 Jan 2025 15:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GX1rV+oj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358AC1F9428;
	Fri,  3 Jan 2025 15:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735916684; cv=none; b=S327iTZ12EwawrIjOHoqC6RkZH2N4XqrXGtON4JBqYxSb6kaAny6sXThlyO9ObJBK1xwDXinR88I6ys+CPPI9xqpd/C8x2bWQfrXV9aZs6ScEIvdrPfB6KOkqHDeZMbEpAI0BJ2KbO+M8OVLtmgcbHrghUXEODB+idrcMVFo92M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735916684; c=relaxed/simple;
	bh=TawOs3j1JwsW5rW9dQlifILRHDeeK6Ec67G4qVy6ebs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A7v4Zq2a5Q7KBblIcVLTWj4BR+v+xTc69j5BrxgLrDRzzTWAmRKzs9IAc3YKposLTxQD1GWxV6s/GnlSTb8SsV95GLwTb9E+27v392jNVd2R7Mzfcw4QcvGvb0Iee2iPAptTCV76Ukot+6HKa/ggpwGd1Brt1EaSpvov+QGa/dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GX1rV+oj; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-216395e151bso125282955ad.0;
        Fri, 03 Jan 2025 07:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735916681; x=1736521481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9M7wNcVX1T/1Xwu71Cw/kXYIswzxZw/fxJpL2uVZ/g=;
        b=GX1rV+ojdlPB0+KP6t2LfQeLqV5zunXt2Acp1JjSquQ4/Cuv9rFivx1HVUZDveZzoA
         tso4Y+gfV3qRc2qozfZt6cdg7Y/i00YyxT32T9Sc4DnCPsEnaQsieBxCb1hPID/jVoeM
         WpqYZkmgm4Clwz2H5bUjpszkEZuUw1xpuujghqX/w4kzSz3nEu3b+H8bbGczMr4hQbUs
         Ogpub4DUWh9p9R05OyAi8A3CjHPcYAZaSIqtm7MYYXKX7DfC7roRbWSZOsWB1n1OtlrL
         +3q6etYF6Myj0blcD1W4BBhIyXI7kMeY06aGzlD3sXh58yJ8a7XUxW3DRcDv57LCjfID
         I6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735916681; x=1736521481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n9M7wNcVX1T/1Xwu71Cw/kXYIswzxZw/fxJpL2uVZ/g=;
        b=A0QeNbgmcMY9+wFjACrqdaWFXLklfdK5GDHgDyI5Q/MZDLkIMcW6FxZU/UWAbJDmPN
         QVV0bQwlnKUrbPlO99OMwdC9U63JR7tz9HRiQjSQI4ATofgk+zIuvkQUnmLYgonr38dh
         VbpDCrKRN3tkKpp6zVFMvh3Uz05djqPOwiV87E1UUgajGZlY2o3mLBBtIrjjOB8+Cn3K
         wH4mWU11T0rFxJGtLiNxiZ12BrjQoNRDqvQoFwiJjx7c9+cO5pApU+73PQl9CmzBA9g7
         RNZfkC9JRnkxu6T7zUVwDQEGDA608ZakL3pzvsWrk3Uq80MJfgtpnb/8x1ZpWLwhJYL8
         VCqQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3QDZ3sbgY0lgVb+UEpdwmikDSdADvShVIKNkZzZOxudm0m1I5unZTDOpZdX+yh+t/XZwoRDVj@vger.kernel.org, AJvYcCWhIPP7buO34JqUPSq5XG5y1uH+IGKrYkuIdDejTtsh5z8ged6RVAdthwl4ZrXilHwiydPaHMlqB0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0sAFhQ7w6ADtrh5aMFsWBQCqQiZ0QdfA9ZuoG97FQsfiAIiYG
	lDVge/rS+VSzytRFGRoG/GH6y1FTaM1NTe220gPj6e6/VUL6WhFb
X-Gm-Gg: ASbGncuRVc521yNmyfmR8NSvL4Ns5bdEUWtcRSqtfAORL9NzjUt/QGYy74jTwUtyHEO
	fkMb+v6N8VcJjNCxpyXHdn0onfWaWQENVnswc941StCeEFT3QXfEynR+3zsD7EvtMcvlmfyro9/
	FEoPVVT1h4r2uZ24YKjS4ftQPQXxI/MImgNX4demb0La2DcyhHAsGE7LL652qlgbHD5v1UeqRsd
	sjukfOVOtKBQm0BsLX01PxQKdHP/VCJU0/U5MWtjVRUDA==
X-Google-Smtp-Source: AGHT+IEU4Gc4os4+UvJJ2F1EahOtG2L5hh4X6mrWlIhXOL/HYp5QNc6R6dP8eV6QhhyYruhCtKZWXw==
X-Received: by 2002:a17:902:e850:b0:215:7e49:8202 with SMTP id d9443c01a7336-219e6cf8cdcmr755335065ad.13.1735916681198;
        Fri, 03 Jan 2025 07:04:41 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9629d0sm247047255ad.41.2025.01.03.07.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 07:04:40 -0800 (PST)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	almasrymina@google.com,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	michael.chan@broadcom.com,
	andrew+netdev@lunn.ch,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	dw@davidwei.uk,
	sdf@fomichev.me,
	asml.silence@gmail.com,
	brett.creeley@amd.com,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org
Cc: kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	danieller@nvidia.com,
	hengqi@linux.alibaba.com,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	hkallweit1@gmail.com,
	ahmed.zaki@intel.com,
	rrameshbabu@nvidia.com,
	idosch@nvidia.com,
	jiri@resnulli.us,
	bigeasy@linutronix.de,
	lorenzo@kernel.org,
	jdamato@fastly.com,
	aleksander.lobakin@intel.com,
	kaiyuanz@google.com,
	willemb@google.com,
	daniel.zahka@gmail.com,
	ap420073@gmail.com,
	Andy Gospodarek <gospo@broadcom.com>
Subject: [PATCH net-next v7 07/10] bnxt_en: add support for tcp-data-split ethtool command
Date: Fri,  3 Jan 2025 15:03:22 +0000
Message-Id: <20250103150325.926031-8-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250103150325.926031-1-ap420073@gmail.com>
References: <20250103150325.926031-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NICs that uses bnxt_en driver supports tcp-data-split feature by the
name of HDS(header-data-split).
But there is no implementation for the HDS to enable by ethtool.
Only getting the current HDS status is implemented and The HDS is just
automatically enabled only when either LRO, HW-GRO, or JUMBO is enabled.
The hds_threshold follows rx-copybreak value. and it was unchangeable.

This implements `ethtool -G <interface name> tcp-data-split <value>`
command option.
The value can be <on> and <auto>.
The value is <auto> and one of LRO/GRO/JUMBO is enabled, HDS is
automatically enabled and all LRO/GRO/JUMBO are disabled, HDS is
automatically disabled.

HDS feature relies on the aggregation ring.
So, if HDS is enabled, the bnxt_en driver initializes the aggregation ring.
This is the reason why BNXT_FLAG_AGG_RINGS contains HDS condition.

Tested-by: Stanislav Fomichev <sdf@fomichev.me>
Tested-by: Andy Gospodarek <gospo@broadcom.com>
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v7:
 - Remove hds unrelated changes.
 - Return -EINVAL instead of -EOPNOTSUPP;

v6:
 - Disallow to attach XDP when HDS is in use.
 - Add Test tag from Andy.

v5:
 - Do not set HDS if XDP is attached.
 - Enable tcp-data-split only when tcp_data_split_mod is true.

v4:
 - Do not support disable tcp-data-split.
 - Add Test tag from Stanislav.

v3:
 - No changes.

v2:
 - Do not set hds_threshold to 0.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  5 +++--
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 20 +++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  4 ++++
 4 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 9b5ca1e3d99a..7198d05cd27b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4623,7 +4623,7 @@ void bnxt_set_ring_params(struct bnxt *bp)
 	bp->rx_agg_ring_size = 0;
 	bp->rx_agg_nr_pages = 0;
 
-	if (bp->flags & BNXT_FLAG_TPA)
+	if (bp->flags & BNXT_FLAG_TPA || bp->flags & BNXT_FLAG_HDS)
 		agg_factor = min_t(u32, 4, 65536 / BNXT_RX_PAGE_SIZE);
 
 	bp->flags &= ~BNXT_FLAG_JUMBO;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 7edb92ce5976..7dc06e07bae2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2244,8 +2244,6 @@ struct bnxt {
 	#define BNXT_FLAG_TPA		(BNXT_FLAG_LRO | BNXT_FLAG_GRO)
 	#define BNXT_FLAG_JUMBO		0x10
 	#define BNXT_FLAG_STRIP_VLAN	0x20
-	#define BNXT_FLAG_AGG_RINGS	(BNXT_FLAG_JUMBO | BNXT_FLAG_GRO | \
-					 BNXT_FLAG_LRO)
 	#define BNXT_FLAG_RFS		0x100
 	#define BNXT_FLAG_SHARED_RINGS	0x200
 	#define BNXT_FLAG_PORT_STATS	0x400
@@ -2266,6 +2264,9 @@ struct bnxt {
 	#define BNXT_FLAG_ROCE_MIRROR_CAP	0x4000000
 	#define BNXT_FLAG_TX_COAL_CMPL	0x8000000
 	#define BNXT_FLAG_PORT_STATS_EXT	0x10000000
+	#define BNXT_FLAG_HDS		0x20000000
+	#define BNXT_FLAG_AGG_RINGS	(BNXT_FLAG_JUMBO | BNXT_FLAG_GRO | \
+					 BNXT_FLAG_LRO | BNXT_FLAG_HDS)
 
 	#define BNXT_FLAG_ALL_CONFIG_FEATS (BNXT_FLAG_TPA |		\
 					    BNXT_FLAG_RFS |		\
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index e9e63d95df17..413007190f50 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -840,16 +840,35 @@ static int bnxt_set_ringparam(struct net_device *dev,
 			      struct kernel_ethtool_ringparam *kernel_ering,
 			      struct netlink_ext_ack *extack)
 {
+	u8 tcp_data_split = kernel_ering->tcp_data_split;
 	struct bnxt *bp = netdev_priv(dev);
+	u8 hds_config_mod;
 
 	if ((ering->rx_pending > BNXT_MAX_RX_DESC_CNT) ||
 	    (ering->tx_pending > BNXT_MAX_TX_DESC_CNT) ||
 	    (ering->tx_pending < BNXT_MIN_TX_DESC_CNT))
 		return -EINVAL;
 
+	hds_config_mod = tcp_data_split != dev->ethtool->hds_config;
+	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_DISABLED && hds_config_mod)
+		return -EINVAL;
+
+	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
+	    hds_config_mod && BNXT_RX_PAGE_MODE(bp)) {
+		NL_SET_ERR_MSG_MOD(extack, "tcp-data-split is disallowed when XDP is attached");
+		return -EINVAL;
+	}
+
 	if (netif_running(dev))
 		bnxt_close_nic(bp, false, false);
 
+	if (hds_config_mod) {
+		if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED)
+			bp->flags |= BNXT_FLAG_HDS;
+		else if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_UNKNOWN)
+			bp->flags &= ~BNXT_FLAG_HDS;
+	}
+
 	bp->rx_ring_size = ering->rx_pending;
 	bp->tx_ring_size = ering->tx_pending;
 	bnxt_set_ring_params(bp);
@@ -5371,6 +5390,7 @@ const struct ethtool_ops bnxt_ethtool_ops = {
 				     ETHTOOL_COALESCE_STATS_BLOCK_USECS |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
 				     ETHTOOL_COALESCE_USE_CQE,
+	.supported_ring_params	= ETHTOOL_RING_USE_TCP_DATA_SPLIT,
 	.get_link_ksettings	= bnxt_get_link_ksettings,
 	.set_link_ksettings	= bnxt_set_link_ksettings,
 	.get_fec_stats		= bnxt_get_fec_stats,
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index f88b641533fc..1bfff7f29310 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -395,6 +395,10 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
 			    bp->dev->mtu, BNXT_MAX_PAGE_MODE_MTU);
 		return -EOPNOTSUPP;
 	}
+	if (prog && bp->flags & BNXT_FLAG_HDS) {
+		netdev_warn(dev, "XDP is disallowed when HDS is enabled.\n");
+		return -EOPNOTSUPP;
+	}
 	if (!(bp->flags & BNXT_FLAG_SHARED_RINGS)) {
 		netdev_warn(dev, "ethtool rx/tx channels must be combined to support XDP.\n");
 		return -EOPNOTSUPP;
-- 
2.34.1



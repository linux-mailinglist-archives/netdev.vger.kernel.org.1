Return-Path: <netdev+bounces-157423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C507A0A43F
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 15:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EBBF169F44
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 14:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5557E1AE01C;
	Sat, 11 Jan 2025 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ih9IVJPJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFACD1ACEB3;
	Sat, 11 Jan 2025 14:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736606813; cv=none; b=jZ7bytc/7vRXbGhyiyvtqxs80hUS4DP9/urFTYViu7obG1eMbJGqfrSmLINYj1//soAtL1p3bHpMFT1tNmsa+2BKfvBVRBmlyFhUhESFKjggvDFO78EqsFUg6EpHraWtcnudC4hIzIFtAHmoPqFSEIG/7tMG5e2sLq9vWyXvIjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736606813; c=relaxed/simple;
	bh=6x92Hs8vfjM72TCvNKjyk8LU0sI5S215gCWTET3u5kQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qqSE0+aAu66mLDLv3QdgK1Mxar+Tkjj1u1Y5A6sJ8t4n9Jq7jilibpesM0FiSWNUrHwJ6r8FHfZH+OASVHh1mjwgvad4GsbRkITJRXn62lKSwnihdbM9OcaHW90/x8LwwAX9gH6uE2gX5aHHPlVAszpExyk9wiIwUz/IGN6pfl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ih9IVJPJ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-216426b0865so49989645ad.0;
        Sat, 11 Jan 2025 06:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736606811; x=1737211611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8kQoSzV+zNhAQr+y1fUtNkfpPO/otuNPk/v4/KvXzU=;
        b=ih9IVJPJBWyp7Jp2oeUQsfEFdZW5eHi9kFDQvhiLdnN1wf9d/J/pd5MSllLo3wXLp5
         jfI8wU3u5YvrtJSzkEdJmLBzYjdnrRnuxqU7GNqP0y58aTwEhR8cd2WvUg6v8hIPQQHT
         acoz4rPZxJgLtg+0RgPpyblucmwHfDJf/em2vngEFDrQFFBwBZtdQaF9+FdPj1/9WHyh
         rmJfHHTH+X65yNWQqOKud8mpuA9nYP7nDd7xRDfTyJ92CfE0iR9AUIaXwNnujvNBGzUu
         ObeIDr59B8/Dlso01sS5PWu+RBDzf1CEbLZluGcOmiVUTMNWwiUCOMdfQ0vjSD2Dr7Tj
         69+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736606811; x=1737211611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8kQoSzV+zNhAQr+y1fUtNkfpPO/otuNPk/v4/KvXzU=;
        b=YcrunyB4PmwTjNzKWYSQWFEO2/XNix5um7ObKLNiczCWBbfOLiTeQWia2zmnMebp89
         q74jRZhdv4UVuEbDV7JTeemSKy+sbmd2p71blneHJC3zxx2PS/FJCdTKc8SXltwNJWt9
         5UJMOe00OCbC3vGSY/2S8E9ADb+OfRZvbWvIBjPTLn4goRyrpkn4J4mg1H/DZlLFtJCR
         vnQGZPnu+Sq9hJrWdu0F3OKWe8TNwRgXUJalPfx7kYOz/oKHaMITaAxN8G4QPaQWUaxX
         InciBqenEmARnRjAvdQHD7MNiXG+NaVsgk1XrNlwAtvgnkLaW1o6g22c8e3OxUPTxU1p
         fdhw==
X-Forwarded-Encrypted: i=1; AJvYcCV6SQhJxwb3pQQYg/RKxDYIFRGxSMGm303F+NF5JdRUFn+KrkronBX9oHMa1xmcpq7QhpHAMtEK7m4=@vger.kernel.org, AJvYcCVvSbSjCUQuNK/JtJB0cZuPyy0c1oHDIeOBRzf0KgUuPgD0zYATllXoKRcVr29b3aAwD9gmMWx5@vger.kernel.org
X-Gm-Message-State: AOJu0YwF6+krvetnseqrNA/kRePY8BYRvoxAYywnCTo71Qc6hvUiitWZ
	Q9qe1j2Qufjt0v004h9GRVzExA535FK41DCKTcEgUmjPYxuzVqaI
X-Gm-Gg: ASbGncvdUCgkPTC+KWYyalT8U86IorONKg1zl1q9q54aqqouVV6yISgF66mXb8PKGCc
	ym3gqS0HfNkg1uYHANdVbfzHvOuaAf17mBTR6XznRm307AdbfXny3V4KGpiUFiTHr6SRPE0EajO
	JrwgT5uVHn8bB3aKDJ6Zf070Sn5q7AMIMytoDuuYVHqB35BLMOdj9FbHZO/LsBbNHuZzSyfIN9f
	zut4Tp4LxvjKHhgajuT94eR9roiGAmJvyHUxj7E8Yuq+w==
X-Google-Smtp-Source: AGHT+IHJbLE458aCv8YGRYUjklRl7Wf9fdGG52gue6GKeD4k2nBje6dcidbbD55END0WytispeDubA==
X-Received: by 2002:a05:6a00:9285:b0:725:e499:5b8a with SMTP id d2e1a72fcca58-72d21f55d89mr17557393b3a.15.1736606811002;
        Sat, 11 Jan 2025 06:46:51 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40594a06sm3097466b3a.80.2025.01.11.06.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 06:46:50 -0800 (PST)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org,
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
	linux-doc@vger.kernel.org
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
Subject: [PATCH net-next v8 07/10] bnxt_en: add support for tcp-data-split ethtool command
Date: Sat, 11 Jan 2025 14:45:10 +0000
Message-Id: <20250111144513.1289403-8-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250111144513.1289403-1-ap420073@gmail.com>
References: <20250111144513.1289403-1-ap420073@gmail.com>
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

Acked-by: Jakub Kicinski <kuba@kernel.org>
Tested-by: Stanislav Fomichev <sdf@fomichev.me>
Tested-by: Andy Gospodarek <gospo@broadcom.com>
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v8:
 - No changes.

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



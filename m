Return-Path: <netdev+bounces-158146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F06A10955
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 15:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 550A21887432
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FFD147C71;
	Tue, 14 Jan 2025 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdbFEl6C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8C614600F;
	Tue, 14 Jan 2025 14:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736865030; cv=none; b=OmQtzxyF7/ygr9KswhjP4Isa4f5qj3di6ClWb7QzY4ZQIqLhPD/ylsQs2vGDvPPz6/YMCI4MZjsj4Ou62VaK5cUVdxqV/kvReac60m+ZNWZ5R7Ch6qdXFFC2c0wDtQHeT+l6QkhUVWbXdeKVpW0JQW0syquKZUNNF4/c0tlFQXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736865030; c=relaxed/simple;
	bh=jV6ughD5Wjr4GVyxtlx75gHgzjzGXsG0Tx8bI179sk0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UDiQwpo1kBA7/mXU/SLXLKuzecKkmp+mg73TxcmtJRkXJQxekZg9D8eUXgDuK+uw+r7x2YVrcO2nYq/UXSQ1hEgH+9jbsyUh2ukTI5VJH/jp4xoQSdhcRh3JrhUxMVfteyAFisQPm8EGyIRxp9vge3xlcmbas2SrdC8GYBKEhq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdbFEl6C; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2162c0f6a39so117661745ad.0;
        Tue, 14 Jan 2025 06:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736865028; x=1737469828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0PF2bMPqKZKaH/FqfzRI83Rsy0dE0M4NyqDnd9kKJs=;
        b=cdbFEl6C9PjhfS7A+bsk/YiMA3Xeie76pUzSUU2jC2KwHWwuzDBMqOuWAR2bMuNkar
         Vg4CZB4rsvbwzHnLoBFHU/fnxDyDGGqZaPH4cJkBsyFD2ZoBfjuGZ6/VXAbSE6XVms1E
         RCN3zmfVU4jkCSuO+vo+sCGD9lcAej6dHBAgIKXx70jk8OZm2fyLL5fxF7hTZinzo5wI
         VL2MntKPK1i/ygG4QWkRGDE1aIyrEi2RBE10wWZNuc0zxpSqxCfEQ8M6zH2DG16vxPgA
         h6tPziRCqY3/7YF1yzVsBnl/jP6eX1xJ1SJTfXFBnANApK4X4BFr8iLR2OWMp0rcNu3G
         OdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736865028; x=1737469828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0PF2bMPqKZKaH/FqfzRI83Rsy0dE0M4NyqDnd9kKJs=;
        b=P+/M7EL2upVDn0411Dw9rsi8/0eq2EghscUrLoEtMWNjIyMwp5iY+700ZDH0hUwpYI
         JfBb2vssT2M7zN6Hd3tSgvaDQYL/D6EAkDuC6PPqA33VLWgwl/eMHGdWtx+J2WHDl4dh
         AcCfXrStga2nJUgrtHeTpEApYhtEwDL8fggdzl9B8QxQgSvVdfTeScnwE62NbDnDSWC5
         bGEm0QVnXwC4LHAVO+AH5l4wHWBSigBnC3jtNr1xrA7n7oETs6zPhsr9rSUsem/P8Hyq
         dBzRCebf05NJIJ2WsNOGqguw+m2FrGDwXuUCNoJMQo4R3Rgp5MBX4y+TnG4dvXiD4iSW
         tBmw==
X-Forwarded-Encrypted: i=1; AJvYcCUhV7zbjEN4JEScbNDBJFAyzd7+2j2N9+fsfLsB3xuWmU9FJHYg4CJa161sg2XaOO/3vE6wDkzJwfE=@vger.kernel.org, AJvYcCX1kqKTNrbEpV+JgRSjhIZBItAI+e4xHQvOeqM1zuO9O9y8SRDiDzazEvRquzugnLaRb/bhGAOr@vger.kernel.org
X-Gm-Message-State: AOJu0YwRhdic88fP6Jjwz7HONnw19oR8uMI3kbtkTUnefOstHU77MNMm
	iKyzxxJtS6iE0qgYZ925niU3AOnJycLSRlsZYd1v2c/heC+8luft
X-Gm-Gg: ASbGncuKUWcDwEtvvPBaKfSBg3kSitVKwSbY/AP2TK0QqpY2LGWnRLNgYLOVL1pm+D8
	V+2cGWiLeiUWr5OR+AInUuTO3q/ceM3noByma/6hUfs84Ewg56if8rwQ4/xVMKoRpNtB/32ZiOK
	qyqkwHtfBZzpGrabIynQirJQW2hGOiewzzIrTnM2oVZXkYa/CRxbL30sqPVGQo/lVJuGNtqJ9cS
	UXswypiVJhfefGmQL5GFGx8WNS8KU9dyJykfc8etIRGwQ==
X-Google-Smtp-Source: AGHT+IEuKyXifrQa9t+s3G5OCIi22aGU5IINUIaNF71STjbL+HOZkXbEFbB3f3BadfPqqzGzTtYx3A==
X-Received: by 2002:a05:6a00:39a8:b0:728:f21b:ce4c with SMTP id d2e1a72fcca58-72d324bf1c1mr33037244b3a.5.1736865028244;
        Tue, 14 Jan 2025 06:30:28 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d406a4dfesm7474582b3a.156.2025.01.14.06.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 06:30:27 -0800 (PST)
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
Subject: [PATCH net-next v9 07/10] bnxt_en: add support for tcp-data-split ethtool command
Date: Tue, 14 Jan 2025 14:28:49 +0000
Message-Id: <20250114142852.3364986-8-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250114142852.3364986-1-ap420073@gmail.com>
References: <20250114142852.3364986-1-ap420073@gmail.com>
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

v9:
 - No changes.

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
index d19c4fb588e5..f029559a581e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4630,7 +4630,7 @@ void bnxt_set_ring_params(struct bnxt *bp)
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



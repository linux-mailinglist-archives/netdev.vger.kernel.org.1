Return-Path: <netdev+bounces-166283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96325A3556A
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 04:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AF6616DD67
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 03:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A7E14EC77;
	Fri, 14 Feb 2025 03:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiIFi22B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF0914B088
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 03:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739505058; cv=none; b=oou9ehDi2IzIOpVf4V3T7F0TAHzl/nG3XyWsez2/ms9cBYvWXAUOl/nHwZXP7o/1yjbv0wgDJo6fYoB/DJPv+9V1cLmwZVNGY6Xz95+tcbGLW3ygckKeIj/CzYjKBCTFAjYhgP5A+I8EOP4qQR34aX2dgMatvjh85MeYDGoR54o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739505058; c=relaxed/simple;
	bh=ETI5iVzJdZ+sW92+V7IDBAKcozuSKrnx0jgbGX/wpxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vd89CK4PY0CdTtVtjEeU6fektzWua0aUYw1bFBIUHV1NoB6a+EeWi4sEWQ84puEqS3fEGqKXAnwEcqYMf+NmluhRY37RBotciQfZrOv4o7pzrhJEXAOzsFuNzoRQOWy+XnIpnXrFEfap/LEYtAQzzVMJvMxCsoHnhjW96wpOraY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiIFi22B; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5deb1b8e1bcso2997518a12.0
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 19:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739505055; x=1740109855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ON0AI5LIKRY01veX2Y8fur1qAsOo/9rhbvdVRBGvOTA=;
        b=eiIFi22BxuzcdW5PjWsag+Wl6FoTlhUp0RYB4D+sCTbm1liKhJXekPAVVSygFBxrMI
         sM6YQ7ldRULunLkbFRAIvWOPRYVdW4k5GFWXZshoyFXolmggM4NpF97vcbRzxYpF2PoJ
         KkOJ7UhaaYJgTNSr1KgOYypYQ4scmHNOpRNQKuwir23Dlf38Ifuy/VvGz0UYLdzTSYMe
         txi9V2Uwu4ORiflZXrbdvDcRAMGT0tERoWMBoeBNI/krw0BDGFrvugABsw6wuJn5zWxu
         pPmPHTAXx3JtDAFlNFfMX3mGTm84IyopR50fo7jvZttxpOUhmm4yrjZdMNAfQUQq1asd
         scog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739505055; x=1740109855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ON0AI5LIKRY01veX2Y8fur1qAsOo/9rhbvdVRBGvOTA=;
        b=Ez8yrsaJ9ZJ44GBL3zuqlgo7oPLpdkqYzRg7Y3e6OMlDuLLlZ6iKd1fztKdoaF3t37
         SEjMdcKeC44UU7p9UFDABxSrQEy5ZYf8O4Tf7tzD+ueVdwxIWmBZyhciiz0uQZzZDngb
         mSj8vzsK0eeXFCXdm08MaQPi0IvVmpH+AjK+p2gdScNkmgYOKMTgsjyfOnpQLG+pk7o9
         MM8mo76hcp2sxHPMpohdoSL5kFdExzBcrO/wnXhcfLnbNY97yvXnMTz7nNQfYTKse2ty
         YS+QyEPNz7UjMI34+kGAlnpV6IVLxIBbmSsGxSdkeKBdeVcdEQQS8kWA1elStVnFO+ws
         IqVQ==
X-Gm-Message-State: AOJu0Yye1ID3L1F5fIv3qMVyeUuG6hf68ysD0OiT1Kb2uu5QBhr1SiCn
	lSg2BMbiWV0BgmFqKp7QmXNMxB2HN5bbwK9obtn5arVSRyhp3c1/7QtYT7py
X-Gm-Gg: ASbGncsazBre17sVyWif+4ixxN5/+UHpM8ESHk8GRB+5tDeCSdb36NQKLjCWMaoziC/
	KvRh9TWSifIRcWEseksiwPoY/z/pRHo88nfR6vgkVIFh+ZjuQHEL9MQwG/i19JGteV5J4B37zJI
	7/Sohvse1iMff9SAk7cD++AOOnzS2JVWfsJbQ8kmF4i776joF22XzQMxz8BtXu4GsYaXx8t0tM5
	TgLlsx2p5QXCHUa43iujJP11U3y7qkzcdjtqe9a0uqYNQ8nBvXcUVG0JUeDYmxpTFm2t/9vX8T6
	bH9tdzwS9wMo
X-Google-Smtp-Source: AGHT+IGowXKNjHXox/mqh6oenJ5mH7U1pf9gjzmF1TmQ0yGuhICYYf1taDYHGHc9mRqZGqYcElZOLQ==
X-Received: by 2002:a17:906:730f:b0:aae:fd36:f511 with SMTP id a640c23a62f3a-aba501a9d85mr569938066b.47.1739505054459;
        Thu, 13 Feb 2025 19:50:54 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:1::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba533bdcf9sm249923166b.163.2025.02.13.19.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 19:50:52 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	sanman.p211993@gmail.com,
	vadim.fedorenko@linux.dev,
	suhui@nfschina.com,
	horms@kernel.org,
	sdf@fomichev.me,
	jdamato@fastly.com,
	brett.creeley@amd.com,
	przemyslaw.kitszel@intel.com,
	colin.i.king@gmail.com,
	kernel-team@meta.com,
	mohsin.bashr@gmail.com
Subject: [PATCH net-next V2] eth: fbnic: Add ethtool support for IRQ coalescing
Date: Thu, 13 Feb 2025 19:50:37 -0800
Message-ID: <20250214035037.650291-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ethtool support to configure the IRQ coalescing behavior. Support
separate timers for Rx and Tx for time based coalescing. For frame based
configuration, currently we only support the Rx side.

The hardware allows configuration of descriptor count instead of frame
count requiring conversion between the two. We assume 2 descriptors
per frame, one for the metadata and one for the data segment.

When rx-frames are not configured, we set the RX descriptor count to
half the ring size as a fail safe.

Default configuration:
ethtool -c eth0 | grep -E "rx-usecs:|tx-usecs:|rx-frames:"
rx-usecs:       30
rx-frames:      0
tx-usecs:       35

IRQ rate test:
With single iperf flow we monitor IRQ rate while changing the tx-usesc and
rx-usecs to high and low values.

ethtool -C eth0 rx-frames 8192 rx-usecs 150 tx-usecs 150
irq/sec   13k
irq/sec   14k
irq/sec   14k

ethtool -C eth0 rx-frames 8192 rx-usecs 10 tx-usecs 10
irq/sec  27k
irq/sec  28k
irq/sec  28k

Validating the use of extack:
ethtool -C eth0 rx-frames 16384
netlink error: fbnic: rx_frames is above device max
netlink error: Invalid argument

Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
V2:
- Update fbnic_set_coalesce() to use extack to highlight incorrect config
- Simplify fbnic_config_rx_frames()
V1: https://lore.kernel.org/netdev/20250212234946.2536116-1-mohsin.bashr@gmail.com
---
 drivers/net/ethernet/meta/fbnic/fbnic.h       |  3 +
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 59 +++++++++++++++++++
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  4 ++
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  6 ++
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 53 ++++++++++++++---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  3 +
 6 files changed, 120 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index 14751f16e125..548e882381ce 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -180,6 +180,9 @@ void fbnic_dbg_exit(void);
 void fbnic_csr_get_regs(struct fbnic_dev *fbd, u32 *data, u32 *regs_version);
 int fbnic_csr_regs_len(struct fbnic_dev *fbd);
 
+void fbnic_config_txrx_usecs(struct fbnic_napi_vector *nv, u32 arm);
+void fbnic_config_rx_frames(struct fbnic_napi_vector *nv);
+
 enum fbnic_boards {
 	fbnic_board_asic
 };
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 20cd9f5f89e2..54c216148d12 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -135,6 +135,61 @@ static void fbnic_clone_free(struct fbnic_net *clone)
 	kfree(clone);
 }
 
+static int fbnic_get_coalesce(struct net_device *netdev,
+			      struct ethtool_coalesce *ec,
+			      struct kernel_ethtool_coalesce *kernel_coal,
+			      struct netlink_ext_ack *extack)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+
+	ec->tx_coalesce_usecs = fbn->tx_usecs;
+	ec->rx_coalesce_usecs = fbn->rx_usecs;
+	ec->rx_max_coalesced_frames = fbn->rx_max_frames;
+
+	return 0;
+}
+
+static int fbnic_set_coalesce(struct net_device *netdev,
+			      struct ethtool_coalesce *ec,
+			      struct kernel_ethtool_coalesce *kernel_coal,
+			      struct netlink_ext_ack *extack)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+
+	/* Verify against hardware limits */
+	if (ec->rx_coalesce_usecs > FIELD_MAX(FBNIC_INTR_CQ_REARM_RCQ_TIMEOUT)) {
+		NL_SET_ERR_MSG_MOD(extack, "rx_usecs is above device max");
+		return -EINVAL;
+	}
+	if (ec->tx_coalesce_usecs > FIELD_MAX(FBNIC_INTR_CQ_REARM_TCQ_TIMEOUT)) {
+		NL_SET_ERR_MSG_MOD(extack, "tx_usecs is above device max");
+		return -EINVAL;
+	}
+	if (ec->rx_max_coalesced_frames >
+	    FIELD_MAX(FBNIC_QUEUE_RIM_THRESHOLD_RCD_MASK) /
+	    FBNIC_MIN_RXD_PER_FRAME) {
+		NL_SET_ERR_MSG_MOD(extack, "rx_frames is above device max");
+		return -EINVAL;
+	}
+
+	fbn->tx_usecs = ec->tx_coalesce_usecs;
+	fbn->rx_usecs = ec->rx_coalesce_usecs;
+	fbn->rx_max_frames = ec->rx_max_coalesced_frames;
+
+	if (netif_running(netdev)) {
+		int i;
+
+		for (i = 0; i < fbn->num_napi; i++) {
+			struct fbnic_napi_vector *nv = fbn->napi[i];
+
+			fbnic_config_txrx_usecs(nv, 0);
+			fbnic_config_rx_frames(nv);
+		}
+	}
+
+	return 0;
+}
+
 static void fbnic_get_strings(struct net_device *dev, u32 sset, u8 *data)
 {
 	int i;
@@ -586,9 +641,13 @@ fbnic_get_eth_mac_stats(struct net_device *netdev,
 }
 
 static const struct ethtool_ops fbnic_ethtool_ops = {
+	.supported_coalesce_params	= ETHTOOL_COALESCE_USECS |
+					  ETHTOOL_COALESCE_RX_MAX_FRAMES,
 	.get_drvinfo		= fbnic_get_drvinfo,
 	.get_regs_len		= fbnic_get_regs_len,
 	.get_regs		= fbnic_get_regs,
+	.get_coalesce		= fbnic_get_coalesce,
+	.set_coalesce		= fbnic_set_coalesce,
 	.get_strings		= fbnic_get_strings,
 	.get_ethtool_stats	= fbnic_get_ethtool_stats,
 	.get_sset_count		= fbnic_get_sset_count,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 1db57c42333e..8b6be6b60945 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -618,6 +618,10 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 	fbn->ppq_size = FBNIC_PPQ_SIZE_DEFAULT;
 	fbn->rcq_size = FBNIC_RCQ_SIZE_DEFAULT;
 
+	fbn->tx_usecs = FBNIC_TX_USECS_DEFAULT;
+	fbn->rx_usecs = FBNIC_RX_USECS_DEFAULT;
+	fbn->rx_max_frames = FBNIC_RX_FRAMES_DEFAULT;
+
 	default_queues = netif_get_num_default_rss_queues();
 	if (default_queues > fbd->max_num_queues)
 		default_queues = fbd->max_num_queues;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index a392ac1cc4f2..46af92a8f781 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -12,6 +12,7 @@
 #include "fbnic_txrx.h"
 
 #define FBNIC_MAX_NAPI_VECTORS		128u
+#define FBNIC_MIN_RXD_PER_FRAME		2
 
 struct fbnic_net {
 	struct fbnic_ring *tx[FBNIC_MAX_TXQS];
@@ -27,6 +28,11 @@ struct fbnic_net {
 	u32 ppq_size;
 	u32 rcq_size;
 
+	u16 rx_usecs;
+	u16 tx_usecs;
+
+	u32 rx_max_frames;
+
 	u16 num_napi;
 
 	struct phylink *phylink;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index d4d7027df9a0..7e0bd11f05d2 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -2010,9 +2010,51 @@ static void fbnic_config_drop_mode_rcq(struct fbnic_napi_vector *nv,
 	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RDE_CTL0, rcq_ctl);
 }
 
+static void fbnic_config_rim_threshold(struct fbnic_ring *rcq, u16 nv_idx, u32 rx_desc)
+{
+	u32 threshold;
+
+	/* Set the threhsold to half the ring size if rx_frames
+	 * is not configured
+	 */
+	threshold = rx_desc ? : rcq->size_mask / 2;
+
+	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RIM_CTL, nv_idx);
+	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RIM_THRESHOLD, threshold);
+}
+
+void fbnic_config_txrx_usecs(struct fbnic_napi_vector *nv, u32 arm)
+{
+	struct fbnic_net *fbn = netdev_priv(nv->napi.dev);
+	struct fbnic_dev *fbd = nv->fbd;
+	u32 val = arm;
+
+	val |= FIELD_PREP(FBNIC_INTR_CQ_REARM_RCQ_TIMEOUT, fbn->rx_usecs) |
+	       FBNIC_INTR_CQ_REARM_RCQ_TIMEOUT_UPD_EN;
+	val |= FIELD_PREP(FBNIC_INTR_CQ_REARM_TCQ_TIMEOUT, fbn->tx_usecs) |
+	       FBNIC_INTR_CQ_REARM_TCQ_TIMEOUT_UPD_EN;
+
+	fbnic_wr32(fbd, FBNIC_INTR_CQ_REARM(nv->v_idx), val);
+}
+
+void fbnic_config_rx_frames(struct fbnic_napi_vector *nv)
+{
+	struct fbnic_net *fbn = netdev_priv(nv->napi.dev);
+	int i;
+
+	for (i = nv->txt_count; i < nv->rxt_count + nv->txt_count; i++) {
+		struct fbnic_q_triad *qt = &nv->qt[i];
+
+		fbnic_config_rim_threshold(&qt->cmpl, nv->v_idx,
+					   fbn->rx_max_frames *
+					   FBNIC_MIN_RXD_PER_FRAME);
+	}
+}
+
 static void fbnic_enable_rcq(struct fbnic_napi_vector *nv,
 			     struct fbnic_ring *rcq)
 {
+	struct fbnic_net *fbn = netdev_priv(nv->napi.dev);
 	u32 log_size = fls(rcq->size_mask);
 	u32 rcq_ctl;
 
@@ -2040,8 +2082,8 @@ static void fbnic_enable_rcq(struct fbnic_napi_vector *nv,
 	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RCQ_SIZE, log_size & 0xf);
 
 	/* Store interrupt information for the completion queue */
-	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RIM_CTL, nv->v_idx);
-	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RIM_THRESHOLD, rcq->size_mask / 2);
+	fbnic_config_rim_threshold(rcq, nv->v_idx, fbn->rx_max_frames *
+						   FBNIC_MIN_RXD_PER_FRAME);
 	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RIM_MASK, 0);
 
 	/* Enable queue */
@@ -2080,12 +2122,7 @@ void fbnic_enable(struct fbnic_net *fbn)
 
 static void fbnic_nv_irq_enable(struct fbnic_napi_vector *nv)
 {
-	struct fbnic_dev *fbd = nv->fbd;
-	u32 val;
-
-	val = FBNIC_INTR_CQ_REARM_INTR_UNMASK;
-
-	fbnic_wr32(fbd, FBNIC_INTR_CQ_REARM(nv->v_idx), val);
+	fbnic_config_txrx_usecs(nv, FBNIC_INTR_CQ_REARM_INTR_UNMASK);
 }
 
 void fbnic_napi_enable(struct fbnic_net *fbn)
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index c2a94f31f71b..483e11e8bf39 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -31,6 +31,9 @@ struct fbnic_net;
 #define FBNIC_HPQ_SIZE_DEFAULT		256
 #define FBNIC_PPQ_SIZE_DEFAULT		256
 #define FBNIC_RCQ_SIZE_DEFAULT		1024
+#define FBNIC_TX_USECS_DEFAULT		35
+#define FBNIC_RX_USECS_DEFAULT		30
+#define FBNIC_RX_FRAMES_DEFAULT		0
 
 #define FBNIC_RX_TROOM \
 	SKB_DATA_ALIGN(sizeof(struct skb_shared_info))
-- 
2.43.5



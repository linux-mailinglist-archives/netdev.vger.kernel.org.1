Return-Path: <netdev+bounces-166645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBBAA36BDD
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 04:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57887188C093
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 03:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0081624C8;
	Sat, 15 Feb 2025 03:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6x2b2nj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541BA144D21
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 03:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739591619; cv=none; b=lWrYVfsgCrgrvoM5i/Ln+ysc9p1ataN1KovIefxzB82g46eF7He6e2yRjPbAum2+4hEfxSnularTEwFI7UggxtCi4a2G04stNk1a1hUkhsNuCs9LL80dy00RLoJHLl8BM3tg5bUopgUvmnjycsdZK4FiRVJT33UE7HRgE1zVuDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739591619; c=relaxed/simple;
	bh=elnbY55KTPmPPcWZJkArwGotajz4kB6WJOUaKKcBrlw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R8bYfne3zD81UNQJ7pFgPOu5/k23TNrYLnT+9dZYrxWytID/53XYjPlF45l2VfWky2Yi0GyJ2BuHDntzgsq+UCrIvat3XrEiTSjAntDok/lZD+5R9otZ0nXN9tvw/UM70if4skzhs0KRDQiKsUTkYnpf84B7UCp6iziq6JAIJlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6x2b2nj; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaec61d0f65so587453366b.1
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 19:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739591615; x=1740196415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JgaPEhQfkpuJhjXIR4zBufXKRv1nqCjiOg3yuvqYJUs=;
        b=V6x2b2njz74UUESwtt6Ru7QLPzdpLHrdzfcCRxoFAQVCJYe5lQWjGIbGhVakkqcKR+
         xxH2WCVv5YGqU43jY11Ewn/X6TJkcsw5VpPxEPchwEL78C+4TckrRJmF3J8W4FmRnLeA
         o+eHgoMxNZ5wgUvbbCy4kv+cSLEegn0HdQKyUwUNn9E35vOTpXIzbAARam+bpAOYHyJt
         sLIU9jciXNESj4JPgY5DCcbdiIF9hcVzAf1up7kEPEITvS+zwxez0iuZbCLCFTKHOQUy
         lfvYEcgQ1AvhDC5O7FqvHChK64z06Lm1fb7gDxG+i2vqXOibb/Y5EnhOXFA1ZN6jGZRU
         iitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739591615; x=1740196415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JgaPEhQfkpuJhjXIR4zBufXKRv1nqCjiOg3yuvqYJUs=;
        b=N/4pW+riNZ/69jwVxakWT1Ae1CvjLhg5HPLY3b0OLzBwQSdjsqTFGoUJDGYb1uk9H/
         JMvvSYmr6TyDNhi4OCHR8Yz1x2/5BIScfv+b/8PxRCw8KpqOnRiVVzetwavw0dPIradx
         +OaY7YiSDaTP6gFJnuew+CFXYhehI57OBon+JeL+xQpi1NPRvct4W5u+prXw3Sp+vBGr
         g9mhCRQEmYpDtyzhxSsQNNuDb2Jio99uWBFeT0ROOZmjqLRwFg8qeMcqH7ILvnwb7f34
         GX6yOgcY2+wEt7jkn2g0yW1GOr1RsDf4cO58+LWZEzBSxaYqgEIfRjUYbHngZZ18aNwz
         Z6pg==
X-Gm-Message-State: AOJu0YzylxrXTzHTkQA3RKo/IqFZXHslI8SGYg6wUydBCMypmf1Bz2Ya
	sXP3RH0kCKSBrZhZ5TBrnlsrCohTo2Vz86b6zTTSwFhK2nErYl1uQy6ACBtf
X-Gm-Gg: ASbGncucJUgzlGBjgTke/9HCdwwKirIbhhVgUQ5Ae+rIlg41Y0b5dylN8myteanaSZ0
	Vb/GokcP6GKGYt8nHFUsC9jfZ7m8IeRFDEWCE4YrMFSa4NGpWbW+QtGoXX5dwkRQPNe3rXxB8Y0
	hc4cDohAK5U1Yhi15Bl9rbC/A2ZDMPLcWzzbxKWjqRCf2OXLrcWQLeFUf+MGDfp7niAHxOfCF52
	UFbfU1hnssRZDpGpVli2pqeqpoEPDCgBAsNC/JpmTTRdMUBtp87nQxjKR8wv4us1sdeXun9GrWw
	xjWpcLUtBfa7Pg==
X-Google-Smtp-Source: AGHT+IFXpbRy4LxemBSM/m5Gisrloa7GUzLzqQ8942IaRytHvYB/NGbZI0GM57rQsZANRRydm4aGBA==
X-Received: by 2002:a17:907:1ca1:b0:ab7:63fa:e49c with SMTP id a640c23a62f3a-abb711600a7mr150653466b.36.1739591614652;
        Fri, 14 Feb 2025 19:53:34 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5339dc6bsm458228466b.145.2025.02.14.19.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 19:53:32 -0800 (PST)
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
	aleksander.lobakin@intel.com,
	kernel-team@meta.com,
	mohsin.bashr@gmail.com
Subject: [PATCH net-next V3] eth: fbnic: Add ethtool support for IRQ coalescing
Date: Fri, 14 Feb 2025 19:53:25 -0800
Message-ID: <20250215035325.752824-1-mohsin.bashr@gmail.com>
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
V3:
- Rebased on the net-next

V2: https://lore.kernel.org/netdev/20250214035037.650291-1-mohsin.bashr@gmail.com
- Update fbnic_set_coalesce() to use extack to highlight incorrect config
- Simplify fbnic_config_rx_frames()

V1: https://lore.kernel.org/netdev/20250212234946.2536116-1-mohsin.bashr@gmail.com
---
 drivers/net/ethernet/meta/fbnic/fbnic.h       |  3 +
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 60 +++++++++++++++++++
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  4 ++
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  6 ++
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 53 +++++++++++++---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  3 +
 6 files changed, 121 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index 37f81db1fc30..4ca7b99ef131 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -186,6 +186,9 @@ void fbnic_dbg_exit(void);
 void fbnic_csr_get_regs(struct fbnic_dev *fbd, u32 *data, u32 *regs_version);
 int fbnic_csr_regs_len(struct fbnic_dev *fbd);
 
+void fbnic_config_txrx_usecs(struct fbnic_napi_vector *nv, u32 arm);
+void fbnic_config_rx_frames(struct fbnic_napi_vector *nv);
+
 enum fbnic_boards {
 	fbnic_board_asic
 };
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index fb7139a1da46..c1477aad98a0 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -136,6 +136,61 @@ static void fbnic_clone_free(struct fbnic_net *clone)
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
@@ -1287,10 +1342,15 @@ fbnic_get_eth_mac_stats(struct net_device *netdev,
 }
 
 static const struct ethtool_ops fbnic_ethtool_ops = {
+	.supported_coalesce_params	=
+				  ETHTOOL_COALESCE_USECS |
+				  ETHTOOL_COALESCE_RX_MAX_FRAMES,
 	.rxfh_max_num_contexts	= FBNIC_RPC_RSS_TBL_COUNT,
 	.get_drvinfo		= fbnic_get_drvinfo,
 	.get_regs_len		= fbnic_get_regs_len,
 	.get_regs		= fbnic_get_regs,
+	.get_coalesce		= fbnic_get_coalesce,
+	.set_coalesce		= fbnic_set_coalesce,
 	.get_strings		= fbnic_get_strings,
 	.get_ethtool_stats	= fbnic_get_ethtool_stats,
 	.get_sset_count		= fbnic_get_sset_count,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index b12672d1607e..34300241f7e1 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -638,6 +638,10 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
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
index 24d2b528b66c..8c4d494b0637 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -2054,9 +2054,51 @@ static void fbnic_config_drop_mode_rcq(struct fbnic_napi_vector *nv,
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
 
@@ -2084,8 +2126,8 @@ static void fbnic_enable_rcq(struct fbnic_napi_vector *nv,
 	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RCQ_SIZE, log_size & 0xf);
 
 	/* Store interrupt information for the completion queue */
-	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RIM_CTL, nv->v_idx);
-	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RIM_THRESHOLD, rcq->size_mask / 2);
+	fbnic_config_rim_threshold(rcq, nv->v_idx, fbn->rx_max_frames *
+						   FBNIC_MIN_RXD_PER_FRAME);
 	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RIM_MASK, 0);
 
 	/* Enable queue */
@@ -2124,12 +2166,7 @@ void fbnic_enable(struct fbnic_net *fbn)
 
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
index b53a7d28ecd3..1ed78b744635 100644
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



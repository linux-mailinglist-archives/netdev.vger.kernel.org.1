Return-Path: <netdev+bounces-167190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1702A390DF
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 03:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBA293AFFF4
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 02:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A84D29D05;
	Tue, 18 Feb 2025 02:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ta14DIk1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473C14C9F
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 02:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739846163; cv=none; b=PavAkvbg4q2YJjM+31D58hSTJz5cFvyMrDRQXuaOO4jlzBKQcdtmAtBbp9jORiNFjEFS595+yCpWq2HW0Q3wgcyzenS34EWWuBJ+rOzPU20Jx0nL6KO/wAeGFWR5mP9pcnWS1fXZM7D/0Uner1V+NqZx0iIbjRHhVOyS2f0+X1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739846163; c=relaxed/simple;
	bh=y88EbolgpKIBYReUhHKh9d1+JK3Ca8gqNdo1YcutapM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=prfF5PP2lGuZuCU/vwtgqcDyYfPdZ1cf+6rJ91mbErfA7Pq2wekMOInt3xF3QZRvLR+1Fwcg41RVj2szjC36sHFv6cz2W5tgLRbz3c4pgqnK4pnP6KTrg4fpolfJGxKHFXHGwsasoVYkO//eRipZXLFvqoxyhkj3JsZ0ms9cGD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ta14DIk1; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abb999658fbso192415066b.3
        for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 18:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739846159; x=1740450959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dmJHSSonnT5liIl40L0gPNkrE8JfUVZiK2KhxjA8V4A=;
        b=Ta14DIk10MSrZvGNq3ZuF8xnt550l291jxYdCM/t/SwckAewQe7S3r96VOGhRJ1YfA
         M060uzjlZlnwi1vaP9wLIES9lyKQpXGPc0tl+96Ss715iih3Ym+3Trbt9WIy5HXhIYC5
         zFVJzohW1Tg8uqKfq/uhTCIwG/I1ZZLIu6SSyEHa6Pj7KUYpXNsJDLZs3rwfZcex2RLM
         T6TvMGKM6EEZQ2x4AV5dzfbZzS6TlaupfuSKOjgi8xTsW4yDLYBFxbhemi64NXsMYbIF
         6KsKgzdqiTEpjH1XKowhUEu20QW+SabDPBAKu55gGhcfExPNajkIlbxH3OzKerB01BVI
         Wi3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739846159; x=1740450959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dmJHSSonnT5liIl40L0gPNkrE8JfUVZiK2KhxjA8V4A=;
        b=pivgBPkTNNMExgbo97JHW1bsxw1JpDSFolzo6POuiQRTwg7DEu6A8hR+PQg4RIYuz/
         sFDVRnLY+aAm3j82/LtplDvi3Nb2wliEB6CPUQLC76V7nH8M2tqMySQXhH8f/Uy7R/6a
         6YH2o9yGKsaalUuhAu8pU3dlSi0B+IKsBeDggQMSauw8pP3PMdoNoLnMV3Asd7Dn6vNq
         gYjWH0eP0J9oWT+ufzzOxXbFCP3K5jxV7sld+z6UbXYRomegttMAZGci6trvdtOWkAzJ
         tvodzg289XgvjTQoS44p1DOOZcu4Px7tHWHyP5u/9KLP4viOttFHpaqLvZpFp+//+xEZ
         wVyA==
X-Gm-Message-State: AOJu0YwGge8YL8+oWIFfY7aiGAv/84rzIi9bMvgcZptt1W+Tg0WlryiE
	Z1wzyGN+Eex8KjAkS0fKcrPM1OfCBsT5eokq5YpO1WYzThRkRlo3sDJIwQ==
X-Gm-Gg: ASbGnctpsW7FW28KN0PJk9MsBLzVymSpw5Cd0tcbBLCymKWRS/U21m35sSfbAxPQW1r
	aMlMq2R1XjOPzCFka2gVVb3yUCby8Dt1DSbWKTusEdjo80Dv5nKIfkGO2HV+P+tVF2Bnsz306KX
	SI6NhHAjS3vL+x5Npm2tuI9bl0XuyOXKwkvwRso3OWJRhc883RVnUXK5bNF14VvBM1bzsRN4Xec
	TpqLuslbPjEE2nyJXf9W/6L4XguXfNZp4NgH02ZIAkThz3yPwALILJ3MOq7uSnVTaUdxbxSSwTN
	gD4zs6webs4y
X-Google-Smtp-Source: AGHT+IGfAxzZiMyHLYQE/HN9cyITVVJVWw0eWWfOtNgL57WQB2EeE0bUxK5cuAZY0+YEQnlvc1S5ng==
X-Received: by 2002:a05:6402:4609:b0:5e0:2ea2:e583 with SMTP id 4fb4d7f45d1cf-5e03605b96fmr28859279a12.14.1739846158661;
        Mon, 17 Feb 2025 18:35:58 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8190d15esm501597766b.16.2025.02.17.18.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 18:35:57 -0800 (PST)
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
	sdf@fomichev.me,
	jdamato@fastly.com,
	brett.creeley@amd.com,
	aleksander.lobakin@intel.com,
	kernel-team@meta.com,
	mohsin.bashr@gmail.com,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next V4] eth: fbnic: Add ethtool support for IRQ coalescing
Date: Mon, 17 Feb 2025 18:35:20 -0800
Message-ID: <20250218023520.2038010-1-mohsin.bashr@gmail.com>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
V4: Add missing 'Reviewed-by' tags

V3: https://lore.kernel.org/netdev/20250215035325.752824-1-mohsin.bashr@gmail.com
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
index c59f1ce8de32..cf8feb90b617 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -641,6 +641,10 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
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
index b84b447a8d8a..561837e80ec8 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -12,6 +12,7 @@
 #include "fbnic_txrx.h"
 
 #define FBNIC_MAX_NAPI_VECTORS		128u
+#define FBNIC_MIN_RXD_PER_FRAME		2
 
 /* Natively supported tunnel GSO features (not thru GSO_PARTIAL) */
 #define FBNIC_TUN_GSO_FEATURES		NETIF_F_GSO_IPXIP6
@@ -30,6 +31,11 @@ struct fbnic_net {
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
index b2e544a66de3..aba4c65974ee 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -2184,9 +2184,51 @@ static void fbnic_config_drop_mode_rcq(struct fbnic_napi_vector *nv,
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
 
@@ -2214,8 +2256,8 @@ static void fbnic_enable_rcq(struct fbnic_napi_vector *nv,
 	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RCQ_SIZE, log_size & 0xf);
 
 	/* Store interrupt information for the completion queue */
-	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RIM_CTL, nv->v_idx);
-	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RIM_THRESHOLD, rcq->size_mask / 2);
+	fbnic_config_rim_threshold(rcq, nv->v_idx, fbn->rx_max_frames *
+						   FBNIC_MIN_RXD_PER_FRAME);
 	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RIM_MASK, 0);
 
 	/* Enable queue */
@@ -2254,12 +2296,7 @@ void fbnic_enable(struct fbnic_net *fbn)
 
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
index 89a5c394f846..54368dc22328 100644
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



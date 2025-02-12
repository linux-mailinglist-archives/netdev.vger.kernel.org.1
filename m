Return-Path: <netdev+bounces-165717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A77CEA333A9
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 00:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 346663A8782
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 23:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC1D25E44F;
	Wed, 12 Feb 2025 23:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2U/9fy9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FC8126C05
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 23:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739404195; cv=none; b=faTZzTLS2QSrREJMDWYVVh3DgsOQ6HmyDtHKQqanp6yhso62gDnfa2YFYw1GvNxwBIaPxAp49MbSa+WfZupEuaezmdvQjheONhmitmljQSrotqFbpgTkL3F0EltbxIeRwt4tRk4rJ6e/NYxqCipurRE3BJcEmlZgFXu+bFcNMCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739404195; c=relaxed/simple;
	bh=MvzuDcqFL2E46hJuBtLO4o+VDjyedwztw1ffiMlvyvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L4o2bGCeNDIX/DibIFYU0sp3AsFpjQ9YW2MWcGcJnq0R/n7Xfi76UxOLcHvLTJq5+bOCEYI4jNljU7Gh3sLPkCGSphjXziOy6SLa4l8o/jmA9rfww3dPebNgiBSChjboBqA+OkjSJDfqdVwkmAXyJ3nju0GQxb6vvJGIejqU99w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2U/9fy9; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab7f838b92eso37747466b.2
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 15:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739404191; x=1740008991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WgK6MNY5TFQ4tOQtCUw/d91xnOOFZBfJ6yYfTFFgdmk=;
        b=i2U/9fy946pf1jAOSvSFwlRD+Fqao6dwtxVKWHW9gQuwuSExgiwK9mDWJWDeXKyZ9O
         dWOHXdWKa19kHyzVg2TncGTNT4O6CgK8NE+960q7Bmy3arKJNxwQTRfPNMN2wcxvEXCv
         FzNQ5EHhVPz1CVUa+M0aSaJE0+GQcGGYLyTXJ22oVYDVnyXTHI2vcPoKFSRYfFw3TYnH
         7cef3VYfokIbivkk8MjuuQYJiX9QyPH+2tpfW7/lUshMq0V4nro9roamoQz6Ol3t7rjp
         AyXhzpWFQEhPV4Jw1FwoaXnN2XD/6uAhKuZ/jQQnlR8ZVJZpH/tTdO0v5o6BridrVdEB
         HRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739404191; x=1740008991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WgK6MNY5TFQ4tOQtCUw/d91xnOOFZBfJ6yYfTFFgdmk=;
        b=CLjAmGxtAwVP/Kad+LQHVlyLj+JngGUV8I35MNV/CHpeKsWxUatHdjpo70haKlCcDg
         icldmPTcYAnbBdmb+BiaObsi2MPT4h4ePNTKnrbigK+L73+H+y0sZRmQR3eE3hK0cf44
         G8861bt1uF6HgP6b9MxeKFjSP3munExSERWZH7f5pBoaNRod+9YsmvsPT7MirAId3oyo
         xggmrALrSfYbnzLhyW1MdIRER+4U1JhWwdf4wDZiNkNdD6TzN2oynXC9Q1K8tou3X3hj
         eXEW+dlV3WQPeMH9QdlKubTofC0HP4phQL0eST2yGi0TxSFyojYpL/c2U7J2J858NFwU
         nSpA==
X-Gm-Message-State: AOJu0YwWfImrXWQJmZYRX66PqeKjeaEYgu3rTZrNGND3FynHQPsMGSch
	wiQ4TRvUAaHuaO43DD44S0uxXzdL4LOec+CRLAFZR1ETp9bU1iE/2hwBeA0D
X-Gm-Gg: ASbGnctjggap/hPmd1SZgub4NZQvR7o2QBaRzHRqK2xqP2vYZ+mtTXbaLYHygV3Yefk
	cQQhQwOljLRquWttE7p+eINxhZGI4lNaangBTaImQi0ed3wFFzQ9hl6jGor4JWghlgJBQjhAl8D
	CQ30m9RGV6HEPimWAxmaiXkAv+2Gfm4pD5vZgX6j/Zq38WZuyfPbkH3Kks8vJ+Hk/nLYtzrdHGX
	cUX6AG49jZTgzWBuAsAXsybcmu0/hhUTAw4CPznlqtG9QJuGldVdBkWYu8fcVjNNMrzfhUC7y0o
	OSn0i2LEKxSZpw==
X-Google-Smtp-Source: AGHT+IGCiYsFg3NLvnwCS24sfB/Dsj8geN1ON32AbpCmXnlXp4GyDrdJqu9mraF/KVmNlT/lnvTAuA==
X-Received: by 2002:a17:907:c02:b0:aa6:8d51:8fdb with SMTP id a640c23a62f3a-aba4ebbcdb9mr92650666b.19.1739404191138;
        Wed, 12 Feb 2025 15:49:51 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:1a::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5337697fsm14907366b.105.2025.02.12.15.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 15:49:49 -0800 (PST)
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
	kernel-team@meta.com,
	mohsin.bashr@gmail.com
Subject: [PATCH net-next] eth: fbnic: Add ethtool support for IRQ coalescing
Date: Wed, 12 Feb 2025 15:49:46 -0800
Message-ID: <20250212234946.2536116-1-mohsin.bashr@gmail.com>
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

Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic.h       |  3 +
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 52 ++++++++++++++++++
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  4 ++
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  6 ++
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 55 ++++++++++++++++---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  3 +
 6 files changed, 115 insertions(+), 8 deletions(-)

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
index 20cd9f5f89e2..7a149d73edb5 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -135,6 +135,54 @@ static void fbnic_clone_free(struct fbnic_net *clone)
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
+	if (ec->rx_coalesce_usecs >
+	    FIELD_MAX(FBNIC_INTR_CQ_REARM_RCQ_TIMEOUT) ||
+	    ec->tx_coalesce_usecs >
+	    FIELD_MAX(FBNIC_INTR_CQ_REARM_TCQ_TIMEOUT) ||
+	    ec->rx_max_coalesced_frames * FBNIC_MIN_RXD_PER_FRAME >
+	    FIELD_MAX(FBNIC_QUEUE_RIM_THRESHOLD_RCD_MASK))
+		return -EINVAL;
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
@@ -586,9 +634,13 @@ fbnic_get_eth_mac_stats(struct net_device *netdev,
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
index d4d7027df9a0..978dce1e4eaa 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -2010,9 +2010,53 @@ static void fbnic_config_drop_mode_rcq(struct fbnic_napi_vector *nv,
 	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RDE_CTL0, rcq_ctl);
 }
 
+static void fbnic_config_rim_threshold(struct fbnic_ring *rcq, u16 nv_idx, u32 rx_desc)
+{
+	u32 threshold;
+
+	/* Set the threshold to half the ring size if rx_frames
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
+	struct fbnic_q_triad *qt;
+	int i, t;
+
+	t = nv->txt_count;
+
+	for (i = 0; i < nv->rxt_count; i++, t++) {
+		qt = &nv->qt[t];
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
 
@@ -2040,8 +2084,8 @@ static void fbnic_enable_rcq(struct fbnic_napi_vector *nv,
 	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RCQ_SIZE, log_size & 0xf);
 
 	/* Store interrupt information for the completion queue */
-	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RIM_CTL, nv->v_idx);
-	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RIM_THRESHOLD, rcq->size_mask / 2);
+	fbnic_config_rim_threshold(rcq, nv->v_idx, fbn->rx_max_frames *
+						   FBNIC_MIN_RXD_PER_FRAME);
 	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RIM_MASK, 0);
 
 	/* Enable queue */
@@ -2080,12 +2124,7 @@ void fbnic_enable(struct fbnic_net *fbn)
 
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



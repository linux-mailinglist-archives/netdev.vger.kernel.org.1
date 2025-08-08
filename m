Return-Path: <netdev+bounces-212205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 144E4B1EAE0
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 16:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71D661C26BB0
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 14:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25FE286413;
	Fri,  8 Aug 2025 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFfpMGJb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ECB285C9B;
	Fri,  8 Aug 2025 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664833; cv=none; b=lqhwAAUx2F+mVciwuygv2l06e4lZKH+4bzjVUJBbpPtT0wMIyjN0xM2eV2scoCAbBPP8NUAgZK0ziqNC6lYZFcH9jlDnMQIVJCYjxPUxPEprZeXOUWKZmVIURyPjEtLxJzOSUx0IqFom6NVd+rXkVDYSvHVkD5GVlR6lGNSRtbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664833; c=relaxed/simple;
	bh=tHqgRFnG9VZNjWW4qCMSl9mRruPCJCMFAqhqIXuqLjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLv5CoFUkXQQJHC779Fhx+WrBVPkHvD7nxvQLXriAeeUj5x5Fvjfu5fXWd57WdC1Cq2A2+NRS0YUFA3r/8/1ZSIhA1m49GjqmQUm3meWT4+O2SU2yvLF0Xe8nvWgC1sEgCIZkg+oIq85E+usN4QRXoFV4VzU2aA+ANHlFv8o9Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFfpMGJb; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-459d62184c9so13752555e9.1;
        Fri, 08 Aug 2025 07:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754664830; x=1755269630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gb/oONA0Dehga0RDpnaZGL4vbthbdjxuVh7ggvbN3HY=;
        b=WFfpMGJb6iwYX9nOmlGceRCz8Zm5Vn5pkf+DAPCGFZcmJCYBrQve35islWHm8kly5a
         12Khqm4XT0z3ZH5/6mDX6GiwTEB/G2TShtYhaI6cPVHPAG0B10eFM7XIlPCiUr/W/bv/
         c+EWhJ7LXfRVmAt/j58ATGMNvRP/NrmuYTUPlebr6OP2tY+lnrKFKphoZGnCDCuuDH+4
         4MmR5eMmwW0aC+17zGPaBZlEtHFwBBBakeqatvwo/wgwuIxCFkBGwG5GWv3EzNCTU8bY
         jZsKkas/fnEt3MbICFXxQYHm408xq4SmpXA5Y4+X9uWDKREK/K3Tq4x6VWvZ1+/3uk1E
         Ay3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754664830; x=1755269630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gb/oONA0Dehga0RDpnaZGL4vbthbdjxuVh7ggvbN3HY=;
        b=s2EoP1YK8QJgiGLSnkX7Z8aSaYPK8FOjIbKWIRZpQtVZ/NEQ20rkzWJ56MQ1Hm0WAI
         0+woRcV1xKHlqlkWJh35c/6c8CTHPFraDNGpw2Ee6IR4xiiWokcNTnN0Tjc17FhA6J8C
         9UNtkJhMbwxggOho+sEHN0leHXxtLm8Nt1p1zuFDF0S2YRYQZ4ml/1wz0Wx4mpjSmd5H
         ofCrDmWcwCeWNEK+m3O9HPxT3qjSOyKUbpM0eCDNH0Qu4sMBC5bZATTcS5cUD9PlEjpJ
         3qIDkiHY2l2U1moJCz1c9BD+MOR6sgliCWwhKRPcBcAatrs1lTqsWlJozZjo2WBKPhPL
         soSA==
X-Forwarded-Encrypted: i=1; AJvYcCUAswdjcELo2RxN4kRXpVbAjyCIAkbXvymooRIzbIewba6c92Tes9nHW0BadgnS2q0pqi19MfFg@vger.kernel.org, AJvYcCWtkqSxWweHcTaTTNOHjGOFV19OyWhJTHtDnMYb/xfOEwZPP6bnlqD+SR4TJrs4UjseT+ZzLMPYwlHhtj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuakQirHCR6Mb8cYR91D/iaE1ino6AxKRQ+THIPvfr+cLzhiTY
	NTlUhgNSslLo40JlJytzhPwETcZfWMqXFEH+2+6NWCwCoRi9FmOkDqtl
X-Gm-Gg: ASbGncvXLpsFJmkiAh46zw8nfUTXyk3qtCnrJ9GIc/WA02agP1DIcfH/ocYpu2aBwLD
	36tI4FlwFaqpbLdrVBin+IUuZanmlcUUj0+z7vTvJktVm3bFsNgGjpR3tElr331J6MdR9MTze9Y
	SEZsttL7M95jGEE1ixx7KnQBKwq32p7pBuFVJrTb8x6E1dY1tX4Aofi341CWgOi0AKxm5tdMhN7
	7FRTpXuLXDxSa9DBFniGg3/YSRC90yTEXLWfRza6ba8ybM9iLIkuYWf/49OfsuzHO/BovCVYlq3
	dxxBpb9JssJSagBOB3CYeb9gm3GSuQREUoOPRuL4engm4TsFWBHlFUULhC6l5Qg08XK45+vEodJ
	Gdf4aEA==
X-Google-Smtp-Source: AGHT+IFoyrc4WFqqeLXYaZENTQI8sCv10hgM0FYRU0eZ+8bBzxO6igRsiUzMNGRL4jJkwem/YjUUTA==
X-Received: by 2002:a05:600c:3b9f:b0:456:1a69:94fd with SMTP id 5b1f17b1804b1-459fb789f26mr742985e9.0.1754664829427;
        Fri, 08 Aug 2025 07:53:49 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:a360])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58400f5sm135106725e9.2.2025.08.08.07.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 07:53:48 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: asml.silence@gmail.com,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	davem@davemloft.net,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	michael.chan@broadcom.com,
	dtatulea@nvidia.com,
	ap420073@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [RFC v2 12/24] net: allocate per-queue config structs and pass them thru the queue API
Date: Fri,  8 Aug 2025 15:54:35 +0100
Message-ID: <122bf9970a71ffecc77a68286e52e09d59a73cc5.1754657711.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1754657711.git.asml.silence@gmail.com>
References: <cover.1754657711.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Create an array of config structs to store per-queue config.
Pass these structs in the queue API. Drivers can also retrieve
the config for a single queue calling netdev_queue_config()
directly.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[pavel: patch up mlx callbacks with unused qcfg]
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  8 ++-
 drivers/net/ethernet/google/gve/gve_main.c    |  9 ++-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  9 +--
 drivers/net/netdevsim/netdev.c                |  6 +-
 include/net/netdev_queues.h                   | 19 ++++++
 net/core/dev.h                                |  3 +
 net/core/netdev_config.c                      | 58 +++++++++++++++++++
 net/core/netdev_rx_queue.c                    | 11 +++-
 8 files changed, 109 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 869c15d4dc34..96b6fa696247 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15812,7 +15812,9 @@ static const struct netdev_stat_ops bnxt_stat_ops = {
 	.get_base_stats		= bnxt_get_base_stats,
 };
 
-static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
+static int bnxt_queue_mem_alloc(struct net_device *dev,
+				struct netdev_queue_config *qcfg,
+				void *qmem, int idx)
 {
 	struct bnxt_rx_ring_info *rxr, *clone;
 	struct bnxt *bp = netdev_priv(dev);
@@ -15980,7 +15982,9 @@ static void bnxt_copy_rx_ring(struct bnxt *bp,
 	dst->rx_agg_bmap = src->rx_agg_bmap;
 }
 
-static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
+static int bnxt_queue_start(struct net_device *dev,
+			    struct netdev_queue_config *qcfg,
+			    void *qmem, int idx)
 {
 	struct bnxt *bp = netdev_priv(dev);
 	struct bnxt_rx_ring_info *rxr, *clone;
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 1f411d7c4373..f40edab616d8 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2580,8 +2580,9 @@ static void gve_rx_queue_mem_free(struct net_device *dev, void *per_q_mem)
 		gve_rx_free_ring_dqo(priv, gve_per_q_mem, &cfg);
 }
 
-static int gve_rx_queue_mem_alloc(struct net_device *dev, void *per_q_mem,
-				  int idx)
+static int gve_rx_queue_mem_alloc(struct net_device *dev,
+				  struct netdev_queue_config *qcfg,
+				  void *per_q_mem, int idx)
 {
 	struct gve_priv *priv = netdev_priv(dev);
 	struct gve_rx_alloc_rings_cfg cfg = {0};
@@ -2602,7 +2603,9 @@ static int gve_rx_queue_mem_alloc(struct net_device *dev, void *per_q_mem,
 	return err;
 }
 
-static int gve_rx_queue_start(struct net_device *dev, void *per_q_mem, int idx)
+static int gve_rx_queue_start(struct net_device *dev,
+			      struct netdev_queue_config *qcfg,
+			      void *per_q_mem, int idx)
 {
 	struct gve_priv *priv = netdev_priv(dev);
 	struct gve_rx_ring *gve_per_q_mem;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 21bb88c5d3dc..83264c17a4f7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5541,8 +5541,9 @@ struct mlx5_qmgmt_data {
 	struct mlx5e_channel_param cparam;
 };
 
-static int mlx5e_queue_mem_alloc(struct net_device *dev, void *newq,
-				 int queue_index)
+static int mlx5e_queue_mem_alloc(struct net_device *dev,
+				 struct netdev_queue_config *qcfg,
+				 void *newq, int queue_index)
 {
 	struct mlx5_qmgmt_data *new = (struct mlx5_qmgmt_data *)newq;
 	struct mlx5e_priv *priv = netdev_priv(dev);
@@ -5603,8 +5604,8 @@ static int mlx5e_queue_stop(struct net_device *dev, void *oldq, int queue_index)
 	return 0;
 }
 
-static int mlx5e_queue_start(struct net_device *dev, void *newq,
-			     int queue_index)
+static int mlx5e_queue_start(struct net_device *dev, struct netdev_queue_config *qcfg,
+			     void *newq, int queue_index)
 {
 	struct mlx5_qmgmt_data *new = (struct mlx5_qmgmt_data *)newq;
 	struct mlx5e_priv *priv = netdev_priv(dev);
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 39fe28af48b9..46cdf31f0354 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -729,7 +729,8 @@ struct nsim_queue_mem {
 };
 
 static int
-nsim_queue_mem_alloc(struct net_device *dev, void *per_queue_mem, int idx)
+nsim_queue_mem_alloc(struct net_device *dev, struct netdev_queue_config *qcfg,
+		     void *per_queue_mem, int idx)
 {
 	struct nsim_queue_mem *qmem = per_queue_mem;
 	struct netdevsim *ns = netdev_priv(dev);
@@ -778,7 +779,8 @@ static void nsim_queue_mem_free(struct net_device *dev, void *per_queue_mem)
 }
 
 static int
-nsim_queue_start(struct net_device *dev, void *per_queue_mem, int idx)
+nsim_queue_start(struct net_device *dev, struct netdev_queue_config *qcfg,
+		 void *per_queue_mem, int idx)
 {
 	struct nsim_queue_mem *qmem = per_queue_mem;
 	struct netdevsim *ns = netdev_priv(dev);
diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index d73f9023c96f..b850cff71d12 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -32,6 +32,13 @@ struct netdev_config {
 	/** @hds_config: HDS enabled (ETHTOOL_A_RINGS_TCP_DATA_SPLIT).
 	 */
 	u8	hds_config;
+
+	/** @qcfg: per-queue configuration */
+	struct netdev_queue_config *qcfg;
+};
+
+/* Same semantics as fields in struct netdev_config */
+struct netdev_queue_config {
 };
 
 /* See the netdev.yaml spec for definition of each statistic */
@@ -136,6 +143,10 @@ void netdev_stat_queue_sum(struct net_device *netdev,
  *
  * @ndo_queue_mem_size: Size of the struct that describes a queue's memory.
  *
+ * @ndo_queue_cfg_defaults: (Optional) Populate queue config struct with
+ *			defaults. Queue config structs are passed to this
+ *			helper before the user-requested settings are applied.
+ *
  * @ndo_queue_mem_alloc: Allocate memory for an RX queue at the specified index.
  *			 The new memory is written at the specified address.
  *
@@ -153,12 +164,17 @@ void netdev_stat_queue_sum(struct net_device *netdev,
  */
 struct netdev_queue_mgmt_ops {
 	size_t	ndo_queue_mem_size;
+	void	(*ndo_queue_cfg_defaults)(struct net_device *dev,
+					  int idx,
+					  struct netdev_queue_config *qcfg);
 	int	(*ndo_queue_mem_alloc)(struct net_device *dev,
+				       struct netdev_queue_config *qcfg,
 				       void *per_queue_mem,
 				       int idx);
 	void	(*ndo_queue_mem_free)(struct net_device *dev,
 				      void *per_queue_mem);
 	int	(*ndo_queue_start)(struct net_device *dev,
+				   struct netdev_queue_config *qcfg,
 				   void *per_queue_mem,
 				   int idx);
 	int	(*ndo_queue_stop)(struct net_device *dev,
@@ -166,6 +182,9 @@ struct netdev_queue_mgmt_ops {
 				  int idx);
 };
 
+void netdev_queue_config(struct net_device *dev, int rxq,
+			 struct netdev_queue_config *qcfg);
+
 /**
  * DOC: Lockless queue stopping / waking helpers.
  *
diff --git a/net/core/dev.h b/net/core/dev.h
index 5c9f43280eca..5fdcf97149f9 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -9,6 +9,7 @@
 #include <net/netdev_lock.h>
 
 struct net;
+struct netdev_queue_config;
 struct netlink_ext_ack;
 struct cpumask;
 
@@ -96,6 +97,8 @@ int netdev_alloc_config(struct net_device *dev);
 void __netdev_free_config(struct netdev_config *cfg);
 void netdev_free_config(struct net_device *dev);
 int netdev_reconfig_start(struct net_device *dev);
+void __netdev_queue_config(struct net_device *dev, int rxq,
+			   struct netdev_queue_config *qcfg, bool pending);
 
 /* netdev management, shared between various uAPI entry points */
 struct netdev_name_node {
diff --git a/net/core/netdev_config.c b/net/core/netdev_config.c
index 270b7f10a192..bad2d53522f0 100644
--- a/net/core/netdev_config.c
+++ b/net/core/netdev_config.c
@@ -8,18 +8,29 @@
 int netdev_alloc_config(struct net_device *dev)
 {
 	struct netdev_config *cfg;
+	unsigned int maxqs;
 
 	cfg = kzalloc(sizeof(*dev->cfg), GFP_KERNEL_ACCOUNT);
 	if (!cfg)
 		return -ENOMEM;
 
+	maxqs = max(dev->num_rx_queues, dev->num_tx_queues);
+	cfg->qcfg = kcalloc(maxqs, sizeof(*cfg->qcfg), GFP_KERNEL_ACCOUNT);
+	if (!cfg->qcfg)
+		goto err_free_cfg;
+
 	dev->cfg = cfg;
 	dev->cfg_pending = cfg;
 	return 0;
+
+err_free_cfg:
+	kfree(cfg);
+	return -ENOMEM;
 }
 
 void __netdev_free_config(struct netdev_config *cfg)
 {
+	kfree(cfg->qcfg);
 	kfree(cfg);
 }
 
@@ -32,12 +43,59 @@ void netdev_free_config(struct net_device *dev)
 int netdev_reconfig_start(struct net_device *dev)
 {
 	struct netdev_config *cfg;
+	unsigned int maxqs;
 
 	WARN_ON(dev->cfg != dev->cfg_pending);
 	cfg = kmemdup(dev->cfg, sizeof(*dev->cfg), GFP_KERNEL_ACCOUNT);
 	if (!cfg)
 		return -ENOMEM;
 
+	maxqs = max(dev->num_rx_queues, dev->num_tx_queues);
+	cfg->qcfg = kmemdup_array(dev->cfg->qcfg, maxqs, sizeof(*cfg->qcfg),
+				  GFP_KERNEL_ACCOUNT);
+	if (!cfg->qcfg)
+		goto err_free_cfg;
+
 	dev->cfg_pending = cfg;
 	return 0;
+
+err_free_cfg:
+	kfree(cfg);
+	return -ENOMEM;
+}
+
+void __netdev_queue_config(struct net_device *dev, int rxq,
+			   struct netdev_queue_config *qcfg, bool pending)
+{
+	memset(qcfg, 0, sizeof(*qcfg));
+
+	/* Get defaults from the driver, in case user config not set */
+	if (dev->queue_mgmt_ops->ndo_queue_cfg_defaults)
+		dev->queue_mgmt_ops->ndo_queue_cfg_defaults(dev, rxq, qcfg);
+}
+
+/**
+ * netdev_queue_config() - get configuration for a given queue
+ * @dev:  net_device instance
+ * @rxq:  index of the queue of interest
+ * @qcfg: queue configuration struct (output)
+ *
+ * Render the configuration for a given queue. This helper should be used
+ * by drivers which support queue configuration to retrieve config for
+ * a particular queue.
+ *
+ * @qcfg is an output parameter and is always fully initialized by this
+ * function. Some values may not be set by the user, drivers may either
+ * deal with the "unset" values in @qcfg, or provide the callback
+ * to populate defaults in queue_management_ops.
+ *
+ * Note that this helper returns pending config, as it is expected that
+ * "old" queues are retained until config is successful so they can
+ * be restored directly without asking for the config.
+ */
+void netdev_queue_config(struct net_device *dev, int rxq,
+			 struct netdev_queue_config *qcfg)
+{
+	__netdev_queue_config(dev, rxq, qcfg, true);
 }
+EXPORT_SYMBOL(netdev_queue_config);
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index 3bf1151d8061..fb87ce219a8a 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -7,12 +7,14 @@
 #include <net/netdev_rx_queue.h>
 #include <net/page_pool/memory_provider.h>
 
+#include "dev.h"
 #include "page_pool_priv.h"
 
 int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 {
 	struct netdev_rx_queue *rxq = __netif_get_rx_queue(dev, rxq_idx);
 	const struct netdev_queue_mgmt_ops *qops = dev->queue_mgmt_ops;
+	struct netdev_queue_config qcfg;
 	void *new_mem, *old_mem;
 	int err;
 
@@ -32,7 +34,9 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 		goto err_free_new_mem;
 	}
 
-	err = qops->ndo_queue_mem_alloc(dev, new_mem, rxq_idx);
+	netdev_queue_config(dev, rxq_idx, &qcfg);
+
+	err = qops->ndo_queue_mem_alloc(dev, &qcfg, new_mem, rxq_idx);
 	if (err)
 		goto err_free_old_mem;
 
@@ -45,7 +49,7 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 		if (err)
 			goto err_free_new_queue_mem;
 
-		err = qops->ndo_queue_start(dev, new_mem, rxq_idx);
+		err = qops->ndo_queue_start(dev, &qcfg, new_mem, rxq_idx);
 		if (err)
 			goto err_start_queue;
 	} else {
@@ -60,6 +64,7 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 	return 0;
 
 err_start_queue:
+	__netdev_queue_config(dev, rxq_idx, &qcfg, false);
 	/* Restarting the queue with old_mem should be successful as we haven't
 	 * changed any of the queue configuration, and there is not much we can
 	 * do to recover from a failure here.
@@ -67,7 +72,7 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 	 * WARN if we fail to recover the old rx queue, and at least free
 	 * old_mem so we don't also leak that.
 	 */
-	if (qops->ndo_queue_start(dev, old_mem, rxq_idx)) {
+	if (qops->ndo_queue_start(dev, &qcfg, old_mem, rxq_idx)) {
 		WARN(1,
 		     "Failed to restart old queue in error path. RX queue %d may be unhealthy.",
 		     rxq_idx);
-- 
2.49.0



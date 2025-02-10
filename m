Return-Path: <netdev+bounces-164877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F56A2F876
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 20:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D56CA3A40B1
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3908257423;
	Mon, 10 Feb 2025 19:20:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3012566C4
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 19:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739215250; cv=none; b=huTOcuUzWPfGk40kJmZcQrBA1Y/LN31KmHIVcieh8n2RFOkXQt5r3JlggdHA5e8wUNYnUg6X6qYL7cw1Fqf9CqYkAQqWH2ekugLMsI0llMp5gFhh66gnOTd10cWr6o04vI3br2tbfDADfI7peQVGDGmVtRcmQDFT8oTQFY2PCFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739215250; c=relaxed/simple;
	bh=sCxgg11rCGOkf8eOqE+lb6r8iDVFUZ/Q7FCY9aKHTew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3fQSaRTqxb7jVsGM8gz/ar3fKX4bJnOq79sGAtFi/dOWeLpvWZLkwlCWKxJhlIde7O6kNswNOwcBYMbBJvWsLyCGxY88tc9XDevjVtdEvSSdlfbQQgdQPlY62SKcmCuRHqEgFSZ8k56HsREgLdo2MXYGuUMlCe2Efln67BbzDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f6f18b474so32536455ad.1
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 11:20:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739215247; x=1739820047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pG8CtpwCO/vnnLm3KosnV8NalcLhd8tHthrp9+tXKHw=;
        b=C3qJqjXHFPDY/QQfUIV3bwLopaCr4SPTJWQcPyd02QID4YOELV4bDRUVkyPLciZgHr
         PfIdji5AQMnNXIdNwxQSN0OgIr7e3e46XDdaVgmkNuguByMs60fnC7ttrEE0mZgA21oM
         0HZSllgOXHIUGSl8NrNS7aj3cktsMd0J8WkrlUkNLsFqZpWlPZSk3w394xoTWq9h+QcN
         VzV4QjaTwslHTyjWQXFaFJMqil7eYDYDWbP1CYDrWU2wkGsMysoTAm04q/lfF+xb4I3Q
         gcpcr/9y5krhz/8LtEJOIHm2MoS+nbTa8NM079PfFaFynwMb4xbyRvBJEVzedCto8yJe
         QVSQ==
X-Gm-Message-State: AOJu0Yw2OBQu7iYW4a5iCDPJtEbSBbSdFwBTgwnBu7gnN0Q93aHyYvhC
	oZqP0XuErSqFvvRBLy5xuwV8GqJgr8eKvL8etN0OWWdnlI4F4EF7yzlt
X-Gm-Gg: ASbGncvfOp/8HTWoMDQkkP6cKi3a8j3hm6hVhtm5vZHtyfai8hwfvyezhzB5ecIC/VK
	susspbKL3Q6quW3R/+L3eAnTZpIh1zXCZ0K9A9TfYYjBZU+Wc66MhEWQ3ZrtiRyVSRGJVH5y13B
	Ocr0oZle8Je6Y30eDg4LP7tj2E/zDTw+Hj1fGuNk4aOK9bWM1e5GwTVTl65VnyfV8zoNsQn+UUB
	yE5RV6tDVumllPMjI5lDzS+sywYt0UIA6SWOgN7Xvl0A7lIsIS9a8ChDAlRh45n1tzsIQZb+FCH
	kns4V5MfsgU5cBA=
X-Google-Smtp-Source: AGHT+IFiLPkM2axIBPHKaMZHRRhXR8N9tnUUOIVEmiw9FvHpdHVq36dKZmVFqr7b8NBEfJ0eqqkXyA==
X-Received: by 2002:a05:6a21:348b:b0:1e1:af70:a30b with SMTP id adf61e73a8af0-1ee03b439a4mr30553547637.34.1739215247048;
        Mon, 10 Feb 2025 11:20:47 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-ad51aecd55esm8091966a12.29.2025.02.10.11.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 11:20:46 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next 02/11] net: hold netdev instance lock during ndo_setup_tc
Date: Mon, 10 Feb 2025 11:20:34 -0800
Message-ID: <20250210192043.439074-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210192043.439074-1-sdf@fomichev.me>
References: <20250210192043.439074-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce new dev_setup_tc that handles the details and call it from
all qdiscs/classifiers. The instance lock is still applied only to
the drivers that implement shaper API so only iavf is affected.

Cc: Saeed Mahameed <saeed@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c |  2 --
 include/linux/netdevice.h                   |  2 ++
 net/core/dev.c                              | 22 +++++++++++++++++++++
 net/dsa/user.c                              |  5 +----
 net/netfilter/nf_flow_table_offload.c       |  2 +-
 net/netfilter/nf_tables_offload.c           |  2 +-
 net/sched/cls_api.c                         |  2 +-
 net/sched/sch_api.c                         | 13 +++---------
 net/sched/sch_cbs.c                         |  9 ++-------
 net/sched/sch_etf.c                         |  9 ++-------
 net/sched/sch_ets.c                         | 10 ++--------
 net/sched/sch_fifo.c                        | 10 ++--------
 net/sched/sch_gred.c                        |  5 +----
 net/sched/sch_htb.c                         |  2 +-
 net/sched/sch_mq.c                          |  5 +----
 net/sched/sch_mqprio.c                      |  6 ++----
 net/sched/sch_prio.c                        |  5 +----
 net/sched/sch_red.c                         |  8 ++------
 net/sched/sch_taprio.c                      | 17 +++-------------
 net/sched/sch_tbf.c                         | 10 ++--------
 20 files changed, 52 insertions(+), 94 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 176f9bb871d0..4fe481433842 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3707,10 +3707,8 @@ static int __iavf_setup_tc(struct net_device *netdev, void *type_data)
 	if (test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section))
 		return 0;
 
-	netdev_lock(netdev);
 	netif_set_real_num_rx_queues(netdev, total_qps);
 	netif_set_real_num_tx_queues(netdev, total_qps);
-	netdev_unlock(netdev);
 
 	return ret;
 }
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 308c7fc888b3..06f24dc4f46e 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3316,6 +3316,8 @@ int dev_alloc_name(struct net_device *dev, const char *name);
 int dev_open(struct net_device *dev, struct netlink_ext_ack *extack);
 void dev_close(struct net_device *dev);
 void dev_close_many(struct list_head *head, bool unlink);
+int dev_setup_tc(struct net_device *dev, enum tc_setup_type type,
+		 void *type_data);
 void dev_disable_lro(struct net_device *dev);
 int dev_loopback_xmit(struct net *net, struct sock *sk, struct sk_buff *newskb);
 u16 dev_pick_tx_zero(struct net_device *dev, struct sk_buff *skb,
diff --git a/net/core/dev.c b/net/core/dev.c
index 23262f1d8839..a8df26f8ffe5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1755,6 +1755,28 @@ void dev_close(struct net_device *dev)
 }
 EXPORT_SYMBOL(dev_close);
 
+int dev_setup_tc(struct net_device *dev, enum tc_setup_type type,
+		 void *type_data)
+{
+	const struct net_device_ops *ops = dev->netdev_ops;
+
+	ASSERT_RTNL();
+
+	if (tc_can_offload(dev) && ops->ndo_setup_tc) {
+		int ret = -ENODEV;
+
+		if (netif_device_present(dev)) {
+			netdev_lock_ops(dev);
+			ret = ops->ndo_setup_tc(dev, type, type_data);
+			netdev_unlock_ops(dev);
+		}
+
+		return ret;
+	}
+
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(dev_setup_tc);
 
 /**
  *	dev_disable_lro - disable Large Receive Offload on a device
diff --git a/net/dsa/user.c b/net/dsa/user.c
index 291ab1b4acc4..f2ac7662e4cc 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1729,10 +1729,7 @@ static int dsa_user_setup_ft_block(struct dsa_switch *ds, int port,
 {
 	struct net_device *conduit = dsa_port_to_conduit(dsa_to_port(ds, port));
 
-	if (!conduit->netdev_ops->ndo_setup_tc)
-		return -EOPNOTSUPP;
-
-	return conduit->netdev_ops->ndo_setup_tc(conduit, TC_SETUP_FT, type_data);
+	return dev_setup_tc(conduit, TC_SETUP_FT, type_data);
 }
 
 static int dsa_user_setup_tc(struct net_device *dev, enum tc_setup_type type,
diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index e06bc36f49fe..0ec4abded10d 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -1175,7 +1175,7 @@ static int nf_flow_table_offload_cmd(struct flow_block_offload *bo,
 	nf_flow_table_block_offload_init(bo, dev_net(dev), cmd, flowtable,
 					 extack);
 	down_write(&flowtable->flow_block_lock);
-	err = dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_FT, bo);
+	err = dev_setup_tc(dev, TC_SETUP_FT, bo);
 	up_write(&flowtable->flow_block_lock);
 	if (err < 0)
 		return err;
diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
index 64675f1c7f29..b761899c143c 100644
--- a/net/netfilter/nf_tables_offload.c
+++ b/net/netfilter/nf_tables_offload.c
@@ -390,7 +390,7 @@ static int nft_block_offload_cmd(struct nft_base_chain *chain,
 
 	nft_flow_block_offload_init(&bo, dev_net(dev), cmd, chain, &extack);
 
-	err = dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_BLOCK, &bo);
+	err = dev_setup_tc(dev, TC_SETUP_BLOCK, &bo);
 	if (err < 0)
 		return err;
 
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 8e47e5355be6..082b355be8e6 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -835,7 +835,7 @@ static int tcf_block_offload_cmd(struct tcf_block *block,
 	if (dev->netdev_ops->ndo_setup_tc) {
 		int err;
 
-		err = dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_BLOCK, &bo);
+		err = dev_setup_tc(dev, TC_SETUP_BLOCK, &bo);
 		if (err < 0) {
 			if (err != -EOPNOTSUPP)
 				NL_SET_ERR_MSG(extack, "Driver ndo_setup_tc failed");
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index e3e91cf867eb..6d0728cfc19f 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -833,10 +833,8 @@ int qdisc_offload_dump_helper(struct Qdisc *sch, enum tc_setup_type type,
 	int err;
 
 	sch->flags &= ~TCQ_F_OFFLOADED;
-	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
-		return 0;
 
-	err = dev->netdev_ops->ndo_setup_tc(dev, type, type_data);
+	err = dev_setup_tc(dev, type, type_data);
 	if (err == -EOPNOTSUPP)
 		return 0;
 
@@ -855,10 +853,7 @@ void qdisc_offload_graft_helper(struct net_device *dev, struct Qdisc *sch,
 	bool any_qdisc_is_offloaded;
 	int err;
 
-	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
-		return;
-
-	err = dev->netdev_ops->ndo_setup_tc(dev, type, type_data);
+	err = dev_setup_tc(dev, type, type_data);
 
 	/* Don't report error if the graft is part of destroy operation. */
 	if (!err || !new || new == &noop_qdisc)
@@ -880,7 +875,6 @@ void qdisc_offload_query_caps(struct net_device *dev,
 			      enum tc_setup_type type,
 			      void *caps, size_t caps_len)
 {
-	const struct net_device_ops *ops = dev->netdev_ops;
 	struct tc_query_caps_base base = {
 		.type = type,
 		.caps = caps,
@@ -888,8 +882,7 @@ void qdisc_offload_query_caps(struct net_device *dev,
 
 	memset(caps, 0, caps_len);
 
-	if (ops->ndo_setup_tc)
-		ops->ndo_setup_tc(dev, TC_QUERY_CAPS, &base);
+	dev_setup_tc(dev, TC_QUERY_CAPS, &base);
 }
 EXPORT_SYMBOL(qdisc_offload_query_caps);
 
diff --git a/net/sched/sch_cbs.c b/net/sched/sch_cbs.c
index 8c9a0400c862..492a98fa209b 100644
--- a/net/sched/sch_cbs.c
+++ b/net/sched/sch_cbs.c
@@ -251,7 +251,6 @@ static void cbs_disable_offload(struct net_device *dev,
 				struct cbs_sched_data *q)
 {
 	struct tc_cbs_qopt_offload cbs = { };
-	const struct net_device_ops *ops;
 	int err;
 
 	if (!q->offload)
@@ -260,14 +259,10 @@ static void cbs_disable_offload(struct net_device *dev,
 	q->enqueue = cbs_enqueue_soft;
 	q->dequeue = cbs_dequeue_soft;
 
-	ops = dev->netdev_ops;
-	if (!ops->ndo_setup_tc)
-		return;
-
 	cbs.queue = q->queue;
 	cbs.enable = 0;
 
-	err = ops->ndo_setup_tc(dev, TC_SETUP_QDISC_CBS, &cbs);
+	err = dev_setup_tc(dev, TC_SETUP_QDISC_CBS, &cbs);
 	if (err < 0)
 		pr_warn("Couldn't disable CBS offload for queue %d\n",
 			cbs.queue);
@@ -294,7 +289,7 @@ static int cbs_enable_offload(struct net_device *dev, struct cbs_sched_data *q,
 	cbs.idleslope = opt->idleslope;
 	cbs.sendslope = opt->sendslope;
 
-	err = ops->ndo_setup_tc(dev, TC_SETUP_QDISC_CBS, &cbs);
+	err = dev_setup_tc(dev, TC_SETUP_QDISC_CBS, &cbs);
 	if (err < 0) {
 		NL_SET_ERR_MSG(extack, "Specified device failed to setup cbs hardware offload");
 		return err;
diff --git a/net/sched/sch_etf.c b/net/sched/sch_etf.c
index c74d778c32a1..f183c2e9a4e8 100644
--- a/net/sched/sch_etf.c
+++ b/net/sched/sch_etf.c
@@ -297,20 +297,15 @@ static void etf_disable_offload(struct net_device *dev,
 				struct etf_sched_data *q)
 {
 	struct tc_etf_qopt_offload etf = { };
-	const struct net_device_ops *ops;
 	int err;
 
 	if (!q->offload)
 		return;
 
-	ops = dev->netdev_ops;
-	if (!ops->ndo_setup_tc)
-		return;
-
 	etf.queue = q->queue;
 	etf.enable = 0;
 
-	err = ops->ndo_setup_tc(dev, TC_SETUP_QDISC_ETF, &etf);
+	err = dev_setup_tc(dev, TC_SETUP_QDISC_ETF, &etf);
 	if (err < 0)
 		pr_warn("Couldn't disable ETF offload for queue %d\n",
 			etf.queue);
@@ -331,7 +326,7 @@ static int etf_enable_offload(struct net_device *dev, struct etf_sched_data *q,
 	etf.queue = q->queue;
 	etf.enable = 1;
 
-	err = ops->ndo_setup_tc(dev, TC_SETUP_QDISC_ETF, &etf);
+	err = dev_setup_tc(dev, TC_SETUP_QDISC_ETF, &etf);
 	if (err < 0) {
 		NL_SET_ERR_MSG(extack, "Specified device failed to setup ETF hardware offload");
 		return err;
diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index 516038a44163..1757dd3b0552 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -117,9 +117,6 @@ static void ets_offload_change(struct Qdisc *sch)
 	unsigned int weight;
 	unsigned int i;
 
-	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
-		return;
-
 	qopt.command = TC_ETS_REPLACE;
 	qopt.handle = sch->handle;
 	qopt.parent = sch->parent;
@@ -142,7 +139,7 @@ static void ets_offload_change(struct Qdisc *sch)
 		qopt.replace_params.weights[i] = weight;
 	}
 
-	dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_ETS, &qopt);
+	dev_setup_tc(dev, TC_SETUP_QDISC_ETS, &qopt);
 }
 
 static void ets_offload_destroy(struct Qdisc *sch)
@@ -150,13 +147,10 @@ static void ets_offload_destroy(struct Qdisc *sch)
 	struct net_device *dev = qdisc_dev(sch);
 	struct tc_ets_qopt_offload qopt;
 
-	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
-		return;
-
 	qopt.command = TC_ETS_DESTROY;
 	qopt.handle = sch->handle;
 	qopt.parent = sch->parent;
-	dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_ETS, &qopt);
+	dev_setup_tc(dev, TC_SETUP_QDISC_ETS, &qopt);
 }
 
 static void ets_offload_graft(struct Qdisc *sch, struct Qdisc *new,
diff --git a/net/sched/sch_fifo.c b/net/sched/sch_fifo.c
index e6bfd39ff339..f5c31af3a749 100644
--- a/net/sched/sch_fifo.c
+++ b/net/sched/sch_fifo.c
@@ -61,13 +61,10 @@ static void fifo_offload_init(struct Qdisc *sch)
 	struct net_device *dev = qdisc_dev(sch);
 	struct tc_fifo_qopt_offload qopt;
 
-	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
-		return;
-
 	qopt.command = TC_FIFO_REPLACE;
 	qopt.handle = sch->handle;
 	qopt.parent = sch->parent;
-	dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_FIFO, &qopt);
+	dev_setup_tc(dev, TC_SETUP_QDISC_FIFO, &qopt);
 }
 
 static void fifo_offload_destroy(struct Qdisc *sch)
@@ -75,13 +72,10 @@ static void fifo_offload_destroy(struct Qdisc *sch)
 	struct net_device *dev = qdisc_dev(sch);
 	struct tc_fifo_qopt_offload qopt;
 
-	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
-		return;
-
 	qopt.command = TC_FIFO_DESTROY;
 	qopt.handle = sch->handle;
 	qopt.parent = sch->parent;
-	dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_FIFO, &qopt);
+	dev_setup_tc(dev, TC_SETUP_QDISC_FIFO, &qopt);
 }
 
 static int fifo_offload_dump(struct Qdisc *sch)
diff --git a/net/sched/sch_gred.c b/net/sched/sch_gred.c
index ab6234b4fcd5..d1a29842a2b4 100644
--- a/net/sched/sch_gred.c
+++ b/net/sched/sch_gred.c
@@ -314,9 +314,6 @@ static void gred_offload(struct Qdisc *sch, enum tc_gred_command command)
 	struct net_device *dev = qdisc_dev(sch);
 	struct tc_gred_qopt_offload *opt = table->opt;
 
-	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
-		return;
-
 	memset(opt, 0, sizeof(*opt));
 	opt->command = command;
 	opt->handle = sch->handle;
@@ -348,7 +345,7 @@ static void gred_offload(struct Qdisc *sch, enum tc_gred_command command)
 		opt->set.qstats = &sch->qstats;
 	}
 
-	dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_GRED, opt);
+	dev_setup_tc(dev, TC_SETUP_QDISC_GRED, opt);
 }
 
 static int gred_offload_dump_stats(struct Qdisc *sch)
diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index c31bc5489bdd..ed406b3ceb7b 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -1041,7 +1041,7 @@ static void htb_work_func(struct work_struct *work)
 
 static int htb_offload(struct net_device *dev, struct tc_htb_qopt_offload *opt)
 {
-	return dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_HTB, opt);
+	return dev_setup_tc(dev, TC_SETUP_QDISC_HTB, opt);
 }
 
 static int htb_init(struct Qdisc *sch, struct nlattr *opt,
diff --git a/net/sched/sch_mq.c b/net/sched/sch_mq.c
index c860119a8f09..a5ba59728d63 100644
--- a/net/sched/sch_mq.c
+++ b/net/sched/sch_mq.c
@@ -29,10 +29,7 @@ static int mq_offload(struct Qdisc *sch, enum tc_mq_command cmd)
 		.handle = sch->handle,
 	};
 
-	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
-		return -EOPNOTSUPP;
-
-	return dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_MQ, &opt);
+	return dev_setup_tc(dev, TC_SETUP_QDISC_MQ, &opt);
 }
 
 static int mq_offload_stats(struct Qdisc *sch)
diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
index 51d4013b6121..2c9a90b83c2b 100644
--- a/net/sched/sch_mqprio.c
+++ b/net/sched/sch_mqprio.c
@@ -67,8 +67,7 @@ static int mqprio_enable_offload(struct Qdisc *sch,
 
 	mqprio_fp_to_offload(priv->fp, &mqprio);
 
-	err = dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_MQPRIO,
-					    &mqprio);
+	err = dev_setup_tc(dev, TC_SETUP_QDISC_MQPRIO, &mqprio);
 	if (err)
 		return err;
 
@@ -86,8 +85,7 @@ static void mqprio_disable_offload(struct Qdisc *sch)
 	switch (priv->mode) {
 	case TC_MQPRIO_MODE_DCB:
 	case TC_MQPRIO_MODE_CHANNEL:
-		dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_MQPRIO,
-					      &mqprio);
+		dev_setup_tc(dev, TC_SETUP_QDISC_MQPRIO, &mqprio);
 		break;
 	}
 }
diff --git a/net/sched/sch_prio.c b/net/sched/sch_prio.c
index cc30f7a32f1a..276e290b4071 100644
--- a/net/sched/sch_prio.c
+++ b/net/sched/sch_prio.c
@@ -145,9 +145,6 @@ static int prio_offload(struct Qdisc *sch, struct tc_prio_qopt *qopt)
 		.parent = sch->parent,
 	};
 
-	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
-		return -EOPNOTSUPP;
-
 	if (qopt) {
 		opt.command = TC_PRIO_REPLACE;
 		opt.replace_params.bands = qopt->bands;
@@ -158,7 +155,7 @@ static int prio_offload(struct Qdisc *sch, struct tc_prio_qopt *qopt)
 		opt.command = TC_PRIO_DESTROY;
 	}
 
-	return dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_PRIO, &opt);
+	return dev_setup_tc(dev, TC_SETUP_QDISC_PRIO, &opt);
 }
 
 static void
diff --git a/net/sched/sch_red.c b/net/sched/sch_red.c
index ef8a2afed26b..235ec57b29b8 100644
--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -192,9 +192,6 @@ static int red_offload(struct Qdisc *sch, bool enable)
 		.parent = sch->parent,
 	};
 
-	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
-		return -EOPNOTSUPP;
-
 	if (enable) {
 		opt.command = TC_RED_REPLACE;
 		opt.set.min = q->parms.qth_min >> q->parms.Wlog;
@@ -209,7 +206,7 @@ static int red_offload(struct Qdisc *sch, bool enable)
 		opt.command = TC_RED_DESTROY;
 	}
 
-	return dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_RED, &opt);
+	return dev_setup_tc(dev, TC_SETUP_QDISC_RED, &opt);
 }
 
 static void red_destroy(struct Qdisc *sch)
@@ -460,8 +457,7 @@ static int red_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 				.xstats = &q->stats,
 			},
 		};
-		dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_RED,
-					      &hw_stats_request);
+		dev_setup_tc(dev, TC_SETUP_QDISC_RED, &hw_stats_request);
 	}
 	st.early = q->stats.prob_drop + q->stats.forced_drop;
 	st.pdrop = q->stats.pdrop;
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index a68e17891b0b..e35cf13eb4bc 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1539,7 +1539,7 @@ static int taprio_enable_offload(struct net_device *dev,
 	for (tc = 0; tc < TC_MAX_QUEUE; tc++)
 		offload->max_sdu[tc] = q->max_sdu[tc];
 
-	err = ops->ndo_setup_tc(dev, TC_SETUP_QDISC_TAPRIO, offload);
+	err = dev_setup_tc(dev, TC_SETUP_QDISC_TAPRIO, offload);
 	if (err < 0) {
 		NL_SET_ERR_MSG_WEAK(extack,
 				    "Device failed to setup taprio offload");
@@ -1564,7 +1564,6 @@ static int taprio_disable_offload(struct net_device *dev,
 				  struct taprio_sched *q,
 				  struct netlink_ext_ack *extack)
 {
-	const struct net_device_ops *ops = dev->netdev_ops;
 	struct tc_taprio_qopt_offload *offload;
 	int err;
 
@@ -1579,7 +1578,7 @@ static int taprio_disable_offload(struct net_device *dev,
 	}
 	offload->cmd = TAPRIO_CMD_DESTROY;
 
-	err = ops->ndo_setup_tc(dev, TC_SETUP_QDISC_TAPRIO, offload);
+	err = dev_setup_tc(dev, TC_SETUP_QDISC_TAPRIO, offload);
 	if (err < 0) {
 		NL_SET_ERR_MSG(extack,
 			       "Device failed to disable offload");
@@ -2314,24 +2313,14 @@ static int taprio_dump_xstats(struct Qdisc *sch, struct gnet_dump *d,
 			      struct tc_taprio_qopt_stats *stats)
 {
 	struct net_device *dev = qdisc_dev(sch);
-	const struct net_device_ops *ops;
 	struct sk_buff *skb = d->skb;
 	struct nlattr *xstats;
 	int err;
 
-	ops = qdisc_dev(sch)->netdev_ops;
-
-	/* FIXME I could use qdisc_offload_dump_helper(), but that messes
-	 * with sch->flags depending on whether the device reports taprio
-	 * stats, and I'm not sure whether that's a good idea, considering
-	 * that stats are optional to the offload itself
-	 */
-	if (!ops->ndo_setup_tc)
-		return 0;
 
 	memset(stats, 0xff, sizeof(*stats));
 
-	err = ops->ndo_setup_tc(dev, TC_SETUP_QDISC_TAPRIO, offload);
+	err = dev_setup_tc(dev, TC_SETUP_QDISC_TAPRIO, offload);
 	if (err == -EOPNOTSUPP)
 		return 0;
 	if (err)
diff --git a/net/sched/sch_tbf.c b/net/sched/sch_tbf.c
index dc26b22d53c7..5a2133716446 100644
--- a/net/sched/sch_tbf.c
+++ b/net/sched/sch_tbf.c
@@ -145,9 +145,6 @@ static void tbf_offload_change(struct Qdisc *sch)
 	struct net_device *dev = qdisc_dev(sch);
 	struct tc_tbf_qopt_offload qopt;
 
-	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
-		return;
-
 	qopt.command = TC_TBF_REPLACE;
 	qopt.handle = sch->handle;
 	qopt.parent = sch->parent;
@@ -155,7 +152,7 @@ static void tbf_offload_change(struct Qdisc *sch)
 	qopt.replace_params.max_size = q->max_size;
 	qopt.replace_params.qstats = &sch->qstats;
 
-	dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_TBF, &qopt);
+	dev_setup_tc(dev, TC_SETUP_QDISC_TBF, &qopt);
 }
 
 static void tbf_offload_destroy(struct Qdisc *sch)
@@ -163,13 +160,10 @@ static void tbf_offload_destroy(struct Qdisc *sch)
 	struct net_device *dev = qdisc_dev(sch);
 	struct tc_tbf_qopt_offload qopt;
 
-	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
-		return;
-
 	qopt.command = TC_TBF_DESTROY;
 	qopt.handle = sch->handle;
 	qopt.parent = sch->parent;
-	dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_TBF, &qopt);
+	dev_setup_tc(dev, TC_SETUP_QDISC_TBF, &qopt);
 }
 
 static int tbf_offload_dump(struct Qdisc *sch)
-- 
2.48.1



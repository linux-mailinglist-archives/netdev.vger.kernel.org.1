Return-Path: <netdev+bounces-162796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF76A27F29
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 00:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73FA1162018
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 23:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F4D21C9EE;
	Tue,  4 Feb 2025 23:01:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813D221C185
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 23:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738710064; cv=none; b=pQ/uXAuoTGuigpsIGAIWE6IDGU3ypIoswlBky23hZQvCz91Q7OgIDUzxnIpqy4lq7jWUp5DYbul3CWnDml6vKRhZiM978VuMD0KvJS8Ib6ht7Pu0w76K4mGQfn7mRECN5UMtu/8jlg+ytZezab4PnGVH83WvRLwZiOkbpIvFsDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738710064; c=relaxed/simple;
	bh=qPpc7VR+hEywtv1QnaIqa7vYsxQXbcdHIsG0J6R3r3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bECA6MsValMFxtYojnin0xB0dF1038z2knmgIVKak77BurKO9TFaCE32/Aks/YsBDfN7Eev54EipebEOJevhEIStNW02ETmZ0hjnfd7e/Am7IY0sRMlRBSvHKEuMdtrudW57GXmJ6nxfbaKyNYqHe0ttar64BVWdgNpiKmGlG0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-216426b0865so107726705ad.0
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 15:01:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738710061; x=1739314861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=86ytV2o0r7olPN40xHsUg9fRYAMG6anGPFiwgPfhGXY=;
        b=eBh+CJH738Ap8ZN6d5etpty6HBFXurxRTsmq+5bquKrk3Z/1ckMA2l54hJQwC60713
         rFJI6yDu+TpfahnVZV9EI2EIkxjU43yr7J2fIUvVBORph71u/dIDOKlclG6YgON9ykbo
         RGW2bAwAxAhQHeY4CLylkbgeInOzWMlZIki2JJu+wopWOyNlWr2XgNafvFldMYQH67ap
         GlDop6hoL8WtjMulkML8zmX18nQ3ipEeG5JVm87JlIsbfljOT6SefKiJDrVPN0r7ZFR8
         4dC9TSft7kSvGe/stsYkkGSk3/6TnMEskbKt0Z4CDShUCPblt3DtwnxdnDAw4pmpo+c0
         NutA==
X-Gm-Message-State: AOJu0YwzXAc9NsP/+1xtg1nJ4T9jj86yz/DO2snlgHXn5h1CCaAS+Oij
	b+GubqNZ0FnepVMWTdMpuSrXDtgIwAEKzKS1+sljsaatsJxPRwAYna2K
X-Gm-Gg: ASbGncuBMlCjFBRvE5lK9WsuNkXiSIFcRTfT0xQ/0Z6+mNaip+JqCLYTo6Ct+TrHviU
	Jcv4XUckpt/wLt87/zKkMazusCv+bFT8CIulLFqNKHOdF9W0R6suLEmreusPMSSEvzevjD7bneJ
	JAnQmfK81lPsllVW2XO1wOKbSmHzgByMftbgsES6hTyIvpl2gGUKSIjaElJr1q5tYQa+42DjP63
	pHnvsev9V6IHdggIwEW5fi6scKWt5t1UPxRy50FBy8kTR8DJILAW0owx6SHLmdyDWWFIWrdST8v
	m9RUBSZj7m8QBT0=
X-Google-Smtp-Source: AGHT+IE9yLB8IpGZdqlvY/A5sLyDm+GALV7t7M5bEEv7/AChC3pm2fGXfYVpc48FPLGjQjfV3ocdIA==
X-Received: by 2002:a05:6a21:6da4:b0:1ed:75f4:d289 with SMTP id adf61e73a8af0-1ede8845ecamr698985637.19.1738710061209;
        Tue, 04 Feb 2025 15:01:01 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72fe6424f5dsm11071807b3a.42.2025.02.04.15.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 15:01:00 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [RFC net-next 2/4] net: Hold netdev instance lock during ndo_setup_tc
Date: Tue,  4 Feb 2025 15:00:55 -0800
Message-ID: <20250204230057.1270362-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204230057.1270362-1-sdf@fomichev.me>
References: <20250204230057.1270362-1-sdf@fomichev.me>
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
 Documentation/networking/netdevices.rst     |  4 ++++
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
 net/sched/sch_taprio.c                      | 16 +++------------
 net/sched/sch_tbf.c                         | 10 ++--------
 21 files changed, 56 insertions(+), 93 deletions(-)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index 78213e476ce6..c6087d92d740 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -257,6 +257,10 @@ struct net_device synchronization rules
 	Synchronization: rtnl_lock() semaphore, or RCU.
 	Context: atomic (can't sleep under RCU)
 
+ndo_setup_tc:
+	Synchronization: rtnl_lock() semaphore. In addition, netdev instance
+	lock if the driver implements shaper API.
+
 ndo_start_xmit:
 	Synchronization: __netif_tx_lock spinlock.
 
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
index 962774cbce55..6f2eb129ef3e 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3315,6 +3315,8 @@ int dev_alloc_name(struct net_device *dev, const char *name);
 int dev_open(struct net_device *dev, struct netlink_ext_ack *extack);
 void dev_close(struct net_device *dev);
 void dev_close_many(struct list_head *head, bool unlink);
+int dev_setup_tc(struct net_device *dev, enum tc_setup_type type,
+		 void *type_data);
 void dev_disable_lro(struct net_device *dev);
 int dev_loopback_xmit(struct net *net, struct sock *sk, struct sk_buff *newskb);
 u16 dev_pick_tx_zero(struct net_device *dev, struct sk_buff *skb,
diff --git a/net/core/dev.c b/net/core/dev.c
index fda42b2415fc..e55da80d24e2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1754,6 +1754,28 @@ void dev_close(struct net_device *dev)
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
index b50b2c2cc09b..4729a090c876 100644
--- a/net/sched/sch_fifo.c
+++ b/net/sched/sch_fifo.c
@@ -58,13 +58,10 @@ static void fifo_offload_init(struct Qdisc *sch)
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
@@ -72,13 +69,10 @@ static void fifo_offload_destroy(struct Qdisc *sch)
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
index a68e17891b0b..18b7e59df786 100644
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
@@ -1579,7 +1579,7 @@ static int taprio_disable_offload(struct net_device *dev,
 	}
 	offload->cmd = TAPRIO_CMD_DESTROY;
 
-	err = ops->ndo_setup_tc(dev, TC_SETUP_QDISC_TAPRIO, offload);
+	err = dev_setup_tc(dev, TC_SETUP_QDISC_TAPRIO, offload);
 	if (err < 0) {
 		NL_SET_ERR_MSG(extack,
 			       "Device failed to disable offload");
@@ -2314,24 +2314,14 @@ static int taprio_dump_xstats(struct Qdisc *sch, struct gnet_dump *d,
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



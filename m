Return-Path: <netdev+bounces-166843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 554DBA378D2
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 00:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE9B418918CB
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 23:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC681A76BB;
	Sun, 16 Feb 2025 23:32:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502031A316C
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 23:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739748772; cv=none; b=UVgDr5qAXhTufdojZPxL2eCvzkxyQqX27sdsr8rJxCYAgEZpx5BPTi6IsOmYTGhLHn9IKmnMl3Ddl3VysDvPv2ma7F13Lmafx7HFA3Mk5rHsxHJt6RsjDUKuvRZ2WGj6r00FWjHngUmmDr4XRIOCsyvma2hnmRfnXUbby86kCic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739748772; c=relaxed/simple;
	bh=1uTmv46CqpNjrAHfQmuEavDEBHZ0e+jt+wZDQbLpfT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PyZbx4VNi+IAcox0mDBjGoW9ftv6/9pFmpY+zB1He2qwgvh+m5QiCesEI3Ego2X8iC36BD2TFAS2sx4EYZII3jjNU6RHQFcliwKUKpUz/LUBx5HZxuGEvb+G5HTxEEOeGK4m+uU1IPQH4aMr70bqXmoK0grEgFZzBDU4x7frMQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22128b7d587so7894305ad.3
        for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 15:32:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739748769; x=1740353569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3OpZegDreuncsH9Cz4wV80Fn0vPGNu5KSQTUIoh8as=;
        b=khOnsSsGNLt0f/H1cw+ykzTj/WhCbmARX3e6xlHi2S4U0MVrsQtGyIGff6Bn/S0+yv
         Gxs83wjIqaxkBN+HNiCEYWpfWKUFN2NK7kv3BsFbJ08L0VPs7MBuXB39uR/pIM8KtKkm
         86+/shpZbsAT/Vcb3wM21ZmJODCSiNuqZiNPBkmj9+83PvQKwutGSOUkq00rqrEP6kxQ
         lHtR3JCH48RLPzba1/jtR5J9Fnkeoaz6Cu7c2Itxok4sTOx+6VT0tdFV05x46Zlbrc8e
         RH3Bu5FfqJ6Lvkt6JOyTUwPFuQkX09K6PdbsGgWhXU/kbNqsMT54t239gCxHIK5dXtVK
         6CyQ==
X-Gm-Message-State: AOJu0YxqgeR4/cIRYoQJy5b9HZ3+xIio4giHVXPK03MpyZQawtfVRHS5
	mSqECTlkZANWqjJili9n+CoK+H4JvYDm4x1btADnRyd4H4s0u5KaMZuZ
X-Gm-Gg: ASbGncv3TRAzdYQhgvkkMF+4mww767cG9qb+xrXizifPJm8+4IAwDib1setbj9PM+Bv
	dtrPF8jGYzP/ICYG/7KJiNIM7et9kBZGeiFLordx1f5c3dPYnoywUghMZDokVCmOix+WU2ykAFl
	6eYyY7K2PNScskw7gqseT95hW0z71OlhfQnvLcytWQ9kstAMiGOjzMo9CCtoLJKHc2xsCzctb6s
	rlPW/sA9o1NlCeRRDhdHLV7JM8AXCgCb8r8HQbzyaVxqJui2x2UDfCXwRhqXEBvLyTHG6JgYtLn
	SNXPlJM3UOdG+u8=
X-Google-Smtp-Source: AGHT+IG9w7kFHlqL6yH6Vbesu8A77g4r9P1TF73WuTFrWUKdjjIWn44oculHVlyxSAq/htTry8g7Tg==
X-Received: by 2002:a17:903:230f:b0:220:c4e8:3b9d with SMTP id d9443c01a7336-221040ac0eemr112494855ad.37.1739748769042;
        Sun, 16 Feb 2025 15:32:49 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d53491ecsm60150165ad.9.2025.02.16.15.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 15:32:48 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v3 02/12] net: hold netdev instance lock during ndo_setup_tc
Date: Sun, 16 Feb 2025 15:32:35 -0800
Message-ID: <20250216233245.3122700-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250216233245.3122700-1-sdf@fomichev.me>
References: <20250216233245.3122700-1-sdf@fomichev.me>
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
 net/core/dev.c                              | 18 ++++++++++++++++++
 net/dsa/user.c                              |  5 +----
 net/netfilter/nf_flow_table_offload.c       |  2 +-
 net/netfilter/nf_tables_offload.c           |  2 +-
 net/sched/cls_api.c                         |  2 +-
 net/sched/sch_api.c                         |  8 +++-----
 net/sched/sch_cbs.c                         |  8 +++-----
 net/sched/sch_etf.c                         |  8 +++-----
 net/sched/sch_ets.c                         |  4 ++--
 net/sched/sch_fifo.c                        |  4 ++--
 net/sched/sch_gred.c                        |  2 +-
 net/sched/sch_htb.c                         |  2 +-
 net/sched/sch_mq.c                          |  2 +-
 net/sched/sch_mqprio.c                      |  6 ++----
 net/sched/sch_prio.c                        |  2 +-
 net/sched/sch_red.c                         |  5 ++---
 net/sched/sch_taprio.c                      | 12 ++++--------
 net/sched/sch_tbf.c                         |  4 ++--
 20 files changed, 51 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 2396932f073d..ad18c9324333 100644
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
index 759a035d2740..e64acf1992a9 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3322,6 +3322,8 @@ int dev_alloc_name(struct net_device *dev, const char *name);
 int dev_open(struct net_device *dev, struct netlink_ext_ack *extack);
 void dev_close(struct net_device *dev);
 void dev_close_many(struct list_head *head, bool unlink);
+int dev_setup_tc(struct net_device *dev, enum tc_setup_type type,
+		 void *type_data);
 void dev_disable_lro(struct net_device *dev);
 int dev_loopback_xmit(struct net *net, struct sock *sk, struct sk_buff *newskb);
 u16 dev_pick_tx_zero(struct net_device *dev, struct sk_buff *skb,
diff --git a/net/core/dev.c b/net/core/dev.c
index 23262f1d8839..ea607b629eca 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1755,6 +1755,24 @@ void dev_close(struct net_device *dev)
 }
 EXPORT_SYMBOL(dev_close);
 
+int dev_setup_tc(struct net_device *dev, enum tc_setup_type type,
+		 void *type_data)
+{
+	const struct net_device_ops *ops = dev->netdev_ops;
+	int ret;
+
+	ASSERT_RTNL();
+
+	if (!ops->ndo_setup_tc)
+		return -EOPNOTSUPP;
+
+	netdev_lock_ops(dev);
+	ret = ops->ndo_setup_tc(dev, type, type_data);
+	netdev_unlock_ops(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL(dev_setup_tc);
 
 /**
  *	dev_disable_lro - disable Large Receive Offload on a device
diff --git a/net/dsa/user.c b/net/dsa/user.c
index 2296a4ead020..a2c0ab24a746 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1738,10 +1738,7 @@ static int dsa_user_setup_ft_block(struct dsa_switch *ds, int port,
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
index e3e91cf867eb..118f0dceccd9 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -836,7 +836,7 @@ int qdisc_offload_dump_helper(struct Qdisc *sch, enum tc_setup_type type,
 	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
 		return 0;
 
-	err = dev->netdev_ops->ndo_setup_tc(dev, type, type_data);
+	err = dev_setup_tc(dev, type, type_data);
 	if (err == -EOPNOTSUPP)
 		return 0;
 
@@ -858,7 +858,7 @@ void qdisc_offload_graft_helper(struct net_device *dev, struct Qdisc *sch,
 	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
 		return;
 
-	err = dev->netdev_ops->ndo_setup_tc(dev, type, type_data);
+	err = dev_setup_tc(dev, type, type_data);
 
 	/* Don't report error if the graft is part of destroy operation. */
 	if (!err || !new || new == &noop_qdisc)
@@ -880,7 +880,6 @@ void qdisc_offload_query_caps(struct net_device *dev,
 			      enum tc_setup_type type,
 			      void *caps, size_t caps_len)
 {
-	const struct net_device_ops *ops = dev->netdev_ops;
 	struct tc_query_caps_base base = {
 		.type = type,
 		.caps = caps,
@@ -888,8 +887,7 @@ void qdisc_offload_query_caps(struct net_device *dev,
 
 	memset(caps, 0, caps_len);
 
-	if (ops->ndo_setup_tc)
-		ops->ndo_setup_tc(dev, TC_QUERY_CAPS, &base);
+	dev_setup_tc(dev, TC_QUERY_CAPS, &base);
 }
 EXPORT_SYMBOL(qdisc_offload_query_caps);
 
diff --git a/net/sched/sch_cbs.c b/net/sched/sch_cbs.c
index 8c9a0400c862..0c578f3edc32 100644
--- a/net/sched/sch_cbs.c
+++ b/net/sched/sch_cbs.c
@@ -251,7 +251,6 @@ static void cbs_disable_offload(struct net_device *dev,
 				struct cbs_sched_data *q)
 {
 	struct tc_cbs_qopt_offload cbs = { };
-	const struct net_device_ops *ops;
 	int err;
 
 	if (!q->offload)
@@ -260,14 +259,13 @@ static void cbs_disable_offload(struct net_device *dev,
 	q->enqueue = cbs_enqueue_soft;
 	q->dequeue = cbs_dequeue_soft;
 
-	ops = dev->netdev_ops;
-	if (!ops->ndo_setup_tc)
+	if (!dev->netdev_ops->ndo_setup_tc)
 		return;
 
 	cbs.queue = q->queue;
 	cbs.enable = 0;
 
-	err = ops->ndo_setup_tc(dev, TC_SETUP_QDISC_CBS, &cbs);
+	err = dev_setup_tc(dev, TC_SETUP_QDISC_CBS, &cbs);
 	if (err < 0)
 		pr_warn("Couldn't disable CBS offload for queue %d\n",
 			cbs.queue);
@@ -294,7 +292,7 @@ static int cbs_enable_offload(struct net_device *dev, struct cbs_sched_data *q,
 	cbs.idleslope = opt->idleslope;
 	cbs.sendslope = opt->sendslope;
 
-	err = ops->ndo_setup_tc(dev, TC_SETUP_QDISC_CBS, &cbs);
+	err = dev_setup_tc(dev, TC_SETUP_QDISC_CBS, &cbs);
 	if (err < 0) {
 		NL_SET_ERR_MSG(extack, "Specified device failed to setup cbs hardware offload");
 		return err;
diff --git a/net/sched/sch_etf.c b/net/sched/sch_etf.c
index c74d778c32a1..0273ec717f05 100644
--- a/net/sched/sch_etf.c
+++ b/net/sched/sch_etf.c
@@ -297,20 +297,18 @@ static void etf_disable_offload(struct net_device *dev,
 				struct etf_sched_data *q)
 {
 	struct tc_etf_qopt_offload etf = { };
-	const struct net_device_ops *ops;
 	int err;
 
 	if (!q->offload)
 		return;
 
-	ops = dev->netdev_ops;
-	if (!ops->ndo_setup_tc)
+	if (!dev->netdev_ops->ndo_setup_tc)
 		return;
 
 	etf.queue = q->queue;
 	etf.enable = 0;
 
-	err = ops->ndo_setup_tc(dev, TC_SETUP_QDISC_ETF, &etf);
+	err = dev_setup_tc(dev, TC_SETUP_QDISC_ETF, &etf);
 	if (err < 0)
 		pr_warn("Couldn't disable ETF offload for queue %d\n",
 			etf.queue);
@@ -331,7 +329,7 @@ static int etf_enable_offload(struct net_device *dev, struct etf_sched_data *q,
 	etf.queue = q->queue;
 	etf.enable = 1;
 
-	err = ops->ndo_setup_tc(dev, TC_SETUP_QDISC_ETF, &etf);
+	err = dev_setup_tc(dev, TC_SETUP_QDISC_ETF, &etf);
 	if (err < 0) {
 		NL_SET_ERR_MSG(extack, "Specified device failed to setup ETF hardware offload");
 		return err;
diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index 516038a44163..11164127c0ab 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -142,7 +142,7 @@ static void ets_offload_change(struct Qdisc *sch)
 		qopt.replace_params.weights[i] = weight;
 	}
 
-	dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_ETS, &qopt);
+	dev_setup_tc(dev, TC_SETUP_QDISC_ETS, &qopt);
 }
 
 static void ets_offload_destroy(struct Qdisc *sch)
@@ -156,7 +156,7 @@ static void ets_offload_destroy(struct Qdisc *sch)
 	qopt.command = TC_ETS_DESTROY;
 	qopt.handle = sch->handle;
 	qopt.parent = sch->parent;
-	dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_ETS, &qopt);
+	dev_setup_tc(dev, TC_SETUP_QDISC_ETS, &qopt);
 }
 
 static void ets_offload_graft(struct Qdisc *sch, struct Qdisc *new,
diff --git a/net/sched/sch_fifo.c b/net/sched/sch_fifo.c
index e6bfd39ff339..8a8205a6cff5 100644
--- a/net/sched/sch_fifo.c
+++ b/net/sched/sch_fifo.c
@@ -67,7 +67,7 @@ static void fifo_offload_init(struct Qdisc *sch)
 	qopt.command = TC_FIFO_REPLACE;
 	qopt.handle = sch->handle;
 	qopt.parent = sch->parent;
-	dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_FIFO, &qopt);
+	dev_setup_tc(dev, TC_SETUP_QDISC_FIFO, &qopt);
 }
 
 static void fifo_offload_destroy(struct Qdisc *sch)
@@ -81,7 +81,7 @@ static void fifo_offload_destroy(struct Qdisc *sch)
 	qopt.command = TC_FIFO_DESTROY;
 	qopt.handle = sch->handle;
 	qopt.parent = sch->parent;
-	dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_FIFO, &qopt);
+	dev_setup_tc(dev, TC_SETUP_QDISC_FIFO, &qopt);
 }
 
 static int fifo_offload_dump(struct Qdisc *sch)
diff --git a/net/sched/sch_gred.c b/net/sched/sch_gred.c
index ab6234b4fcd5..6c546d618f22 100644
--- a/net/sched/sch_gred.c
+++ b/net/sched/sch_gred.c
@@ -348,7 +348,7 @@ static void gred_offload(struct Qdisc *sch, enum tc_gred_command command)
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
index c860119a8f09..9be82a112ac9 100644
--- a/net/sched/sch_mq.c
+++ b/net/sched/sch_mq.c
@@ -32,7 +32,7 @@ static int mq_offload(struct Qdisc *sch, enum tc_mq_command cmd)
 	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
 		return -EOPNOTSUPP;
 
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
index cc30f7a32f1a..6d95ae61f9c9 100644
--- a/net/sched/sch_prio.c
+++ b/net/sched/sch_prio.c
@@ -158,7 +158,7 @@ static int prio_offload(struct Qdisc *sch, struct tc_prio_qopt *qopt)
 		opt.command = TC_PRIO_DESTROY;
 	}
 
-	return dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_PRIO, &opt);
+	return dev_setup_tc(dev, TC_SETUP_QDISC_PRIO, &opt);
 }
 
 static void
diff --git a/net/sched/sch_red.c b/net/sched/sch_red.c
index ef8a2afed26b..50dafd0b58f2 100644
--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -209,7 +209,7 @@ static int red_offload(struct Qdisc *sch, bool enable)
 		opt.command = TC_RED_DESTROY;
 	}
 
-	return dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_RED, &opt);
+	return dev_setup_tc(dev, TC_SETUP_QDISC_RED, &opt);
 }
 
 static void red_destroy(struct Qdisc *sch)
@@ -460,8 +460,7 @@ static int red_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
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
index a68e17891b0b..10548bb78da1 100644
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
@@ -2314,24 +2313,21 @@ static int taprio_dump_xstats(struct Qdisc *sch, struct gnet_dump *d,
 			      struct tc_taprio_qopt_stats *stats)
 {
 	struct net_device *dev = qdisc_dev(sch);
-	const struct net_device_ops *ops;
 	struct sk_buff *skb = d->skb;
 	struct nlattr *xstats;
 	int err;
 
-	ops = qdisc_dev(sch)->netdev_ops;
-
 	/* FIXME I could use qdisc_offload_dump_helper(), but that messes
 	 * with sch->flags depending on whether the device reports taprio
 	 * stats, and I'm not sure whether that's a good idea, considering
 	 * that stats are optional to the offload itself
 	 */
-	if (!ops->ndo_setup_tc)
+	if (!dev->netdev_ops->ndo_setup_tc)
 		return 0;
 
 	memset(stats, 0xff, sizeof(*stats));
 
-	err = ops->ndo_setup_tc(dev, TC_SETUP_QDISC_TAPRIO, offload);
+	err = dev_setup_tc(dev, TC_SETUP_QDISC_TAPRIO, offload);
 	if (err == -EOPNOTSUPP)
 		return 0;
 	if (err)
diff --git a/net/sched/sch_tbf.c b/net/sched/sch_tbf.c
index dc26b22d53c7..03090b074d0c 100644
--- a/net/sched/sch_tbf.c
+++ b/net/sched/sch_tbf.c
@@ -155,7 +155,7 @@ static void tbf_offload_change(struct Qdisc *sch)
 	qopt.replace_params.max_size = q->max_size;
 	qopt.replace_params.qstats = &sch->qstats;
 
-	dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_TBF, &qopt);
+	dev_setup_tc(dev, TC_SETUP_QDISC_TBF, &qopt);
 }
 
 static void tbf_offload_destroy(struct Qdisc *sch)
@@ -169,7 +169,7 @@ static void tbf_offload_destroy(struct Qdisc *sch)
 	qopt.command = TC_TBF_DESTROY;
 	qopt.handle = sch->handle;
 	qopt.parent = sch->parent;
-	dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_TBF, &qopt);
+	dev_setup_tc(dev, TC_SETUP_QDISC_TBF, &qopt);
 }
 
 static int tbf_offload_dump(struct Qdisc *sch)
-- 
2.48.1



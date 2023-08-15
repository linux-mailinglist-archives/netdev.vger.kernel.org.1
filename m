Return-Path: <netdev+bounces-27721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 005FB77D015
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 18:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD4D2814C7
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 16:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB540156E5;
	Tue, 15 Aug 2023 16:26:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5C6156E4
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 16:26:23 +0000 (UTC)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA028EE
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 09:26:21 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-76d1c58ace6so288218685a.1
        for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 09:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692116781; x=1692721581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uoRTLxA83owuqHIF5w85em2MfTM3rO2JzFdkcwhTzpo=;
        b=ogMciMFn2gZkrKs/gMwjvIs9QfrrkMlVMwuJDcxc48PZpADgWTQ09fy8225k8+iYy9
         u8amT8pVo2uFuZxWXS6CtpGbqP7WOamihiMSTgHlBTseDXwoNEkb4RKxwqxNRwXkrDAl
         nGlnvM6b9NMswRHPCJEWpTuHNxi3pDRO3A4+b9S2o9iJBf8iICMvwAw0kGcVWIEh8gAC
         ctLoF6ISOOgfTDDgSjStQ0FqmR0COcgBfqgFOz2jHjvZsGeGXIReWFLL0KdyHa4qJLPb
         HN/wkNodi6qBeG8HIbCzONnVgUHKmNKpm7DG00EOIoWNNKbmiRvVMqhw0viS5VHe9kZS
         Xc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692116781; x=1692721581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uoRTLxA83owuqHIF5w85em2MfTM3rO2JzFdkcwhTzpo=;
        b=dHIzTRBMwVuh9JFynz8ODssWSd6lcmsWvceGF+vpRLLB1yvETa8ourSKALtBuIaTzZ
         HYNherXZvsloJz4ko/wW6b20JAJEcysM4ogZOjVpxNmpCPZd7TNaoOQmhkTNndwRIMKP
         FJZGvzHew7eOuDtZ7aCFj+GJfRP0A8ZLmpn9WSVXNxxkuqGYHO/w74oxC7BDyT8/VL+M
         ju0ahhS76EISU12+LbyaKwAjlbaRaoW06pqj5fRu0Pf9bBuTlWxQZ8PoSWFrVnAEsRBp
         1i3WuzVJelavj/lH1WyjTgaCy0yfBl0Jh/AGqBbS7xjarMJyi3G0zMnLvy21DcUssRA+
         jVRQ==
X-Gm-Message-State: AOJu0YyPbCxQms44qkIdU0i6HdT6pKAIogI7e7KqCfReX+zfEvaAZbZN
	50mNx51TGLj8QUcA9WTr+2jFMw==
X-Google-Smtp-Source: AGHT+IEtgCEWhGhkeVfGVFrkVu+c6z5e8LVCiYCw+JpcuLHL0GICBcANeatvwPc6HpwQVBbCjQSZIg==
X-Received: by 2002:a05:620a:2982:b0:76c:e661:448b with SMTP id r2-20020a05620a298200b0076ce661448bmr3432368qkp.33.1692116781043;
        Tue, 15 Aug 2023 09:26:21 -0700 (PDT)
Received: from majuu.waya ([174.93.66.252])
        by smtp.gmail.com with ESMTPSA id q5-20020ac87345000000b003fde3d63d22sm3874640qtp.69.2023.08.15.09.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 09:26:20 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: jiri@resnulli.us
Cc: xiyou.wangcong@gmail.com,
	netdev@vger.kernel.org,
	vladbu@nvidia.com,
	mleitner@redhat.com,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH RFC net-next 1/3] Introduce tc block netdev tracking infra
Date: Tue, 15 Aug 2023 12:25:28 -0400
Message-Id: <20230815162530.150994-2-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815162530.150994-1-jhs@mojatatu.com>
References: <20230815162530.150994-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The tc block is a collection of netdevs/ports which allow qdiscs to share filter
block instances (as opposed to the traditional tc filter per port).
Example:
$ tc qdisc add dev ens7 ingress block 22
$ tc qdisc add dev ens8 ingress block 22

Now we can add a filter using the block index:
$ tc filter add block 22 protocol ip pref 25 \
  flower dst_ip 192.168.0.0/16 action drop

Upto this point, the block is unaware of its ports. This patch fixes that and
makes the tc block ports available to the datapath as well as control path on
offloading.

Suggested-by: Jiri Pirko <jiri@nvidia.com>
Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/sch_generic.h |  4 ++
 net/sched/cls_api.c       |  1 +
 net/sched/sch_api.c       | 82 +++++++++++++++++++++++++++++++++++++--
 net/sched/sch_generic.c   | 40 ++++++++++++++++++-
 4 files changed, 121 insertions(+), 6 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index f232512505f8..f002b0423efc 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -19,6 +19,7 @@
 #include <net/gen_stats.h>
 #include <net/rtnetlink.h>
 #include <net/flow_offload.h>
+#include <linux/xarray.h>
 
 struct Qdisc_ops;
 struct qdisc_walker;
@@ -126,6 +127,8 @@ struct Qdisc {
 
 	struct rcu_head		rcu;
 	netdevice_tracker	dev_tracker;
+	netdevice_tracker	in_block_tracker;
+	netdevice_tracker	eg_block_tracker;
 	/* private data */
 	long privdata[] ____cacheline_aligned;
 };
@@ -458,6 +461,7 @@ struct tcf_chain {
 };
 
 struct tcf_block {
+	struct xarray ports; /* datapath accessible */
 	/* Lock protects tcf_block and lifetime-management data of chains
 	 * attached to the block (refcnt, action_refcnt, explicitly_created).
 	 */
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index a193cc7b3241..a976792ef02f 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1003,6 +1003,7 @@ static struct tcf_block *tcf_block_create(struct net *net, struct Qdisc *q,
 	refcount_set(&block->refcnt, 1);
 	block->net = net;
 	block->index = block_index;
+	xa_init(&block->ports);
 
 	/* Don't store q pointer for blocks which are shared */
 	if (!tcf_block_shared(block))
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index aa6b1fe65151..744db6d50f77 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1180,6 +1180,73 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 	return 0;
 }
 
+//XXX: Does not seem necessary
+static void qdisc_block_undo_set(struct Qdisc *sch, struct nlattr **tca)
+{
+	if (tca[TCA_INGRESS_BLOCK])
+		sch->ops->ingress_block_set(sch, 0);
+
+	if (tca[TCA_EGRESS_BLOCK])
+		sch->ops->egress_block_set(sch, 0);
+}
+
+static int qdisc_block_add_dev(struct Qdisc *sch, struct net_device *dev,
+			       struct nlattr **tca,
+			       struct netlink_ext_ack *extack)
+{
+	const struct Qdisc_class_ops *cl_ops = sch->ops->cl_ops;
+	struct tcf_block *in_block = NULL;
+	struct tcf_block *eg_block = NULL;
+	unsigned long cl = 0;
+	int err;
+
+	if (tca[TCA_INGRESS_BLOCK]) {
+		/* works for both ingress and clsact */
+		cl = TC_H_MIN_INGRESS;
+		in_block = cl_ops->tcf_block(sch, cl, NULL);
+		if (!in_block) {
+			NL_SET_ERR_MSG(extack, "Shared ingress block missing");
+			return -EINVAL;
+		}
+
+		err = xa_insert(&in_block->ports, dev->ifindex, dev, GFP_KERNEL);
+		if (err) {
+			NL_SET_ERR_MSG(extack, "ingress block dev insert failed");
+			return err;
+		}
+
+		netdev_hold(dev, &sch->in_block_tracker, GFP_KERNEL);
+	}
+
+	if (tca[TCA_EGRESS_BLOCK]) {
+		cl = TC_H_MIN_EGRESS;
+		eg_block = cl_ops->tcf_block(sch, cl, NULL);
+		if (!eg_block) {
+			NL_SET_ERR_MSG(extack, "Shared egress block missing");
+			err = -EINVAL;
+			goto err_out;
+		}
+
+		err = xa_insert(&eg_block->ports, dev->ifindex, dev, GFP_KERNEL);
+		if (err) {
+			netdev_put(dev, &sch->eg_block_tracker);
+			NL_SET_ERR_MSG(extack, "Egress block dev insert failed");
+			goto err_out;
+		}
+		netdev_hold(dev, &sch->eg_block_tracker, GFP_KERNEL);
+	}
+
+	return 0;
+err_out:
+	if (in_block) {
+		xa_erase(&in_block->ports, dev->ifindex);
+		netdev_put(dev, &sch->in_block_tracker);
+		NL_SET_ERR_MSG(extack, "ingress block dev insert failed");
+	}
+	return err;
+}
+
+//XXX: Should we reset INGRES if EGRESS fails?
 static int qdisc_block_indexes_set(struct Qdisc *sch, struct nlattr **tca,
 				   struct netlink_ext_ack *extack)
 {
@@ -1270,7 +1337,7 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 	sch = qdisc_alloc(dev_queue, ops, extack);
 	if (IS_ERR(sch)) {
 		err = PTR_ERR(sch);
-		goto err_out2;
+		goto err_out1;
 	}
 
 	sch->parent = parent;
@@ -1289,7 +1356,7 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 			if (handle == 0) {
 				NL_SET_ERR_MSG(extack, "Maximum number of qdisc handles was exceeded");
 				err = -ENOSPC;
-				goto err_out3;
+				goto err_out2;
 			}
 		}
 		if (!netif_is_multiqueue(dev))
@@ -1311,7 +1378,7 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 
 	err = qdisc_block_indexes_set(sch, tca, extack);
 	if (err)
-		goto err_out3;
+		goto err_out2;
 
 	if (tca[TCA_STAB]) {
 		stab = qdisc_get_stab(tca[TCA_STAB], extack);
@@ -1350,6 +1417,10 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 	qdisc_hash_add(sch, false);
 	trace_qdisc_create(ops, dev, parent);
 
+	err = qdisc_block_add_dev(sch, dev, tca, extack);
+	if (err)
+		goto err_out4;
+
 	return sch;
 
 err_out4:
@@ -1360,9 +1431,12 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 		ops->destroy(sch);
 	qdisc_put_stab(rtnl_dereference(sch->stab));
 err_out3:
+	//XXX: not sure if we need to do this
+	qdisc_block_undo_set(sch, tca);
+err_out2:
 	netdev_put(dev, &sch->dev_tracker);
 	qdisc_free(sch);
-err_out2:
+err_out1:
 	module_put(ops->owner);
 err_out:
 	*errp = err;
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 5d7e23f4cc0e..c62583bba06f 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1048,7 +1048,12 @@ static void qdisc_free_cb(struct rcu_head *head)
 
 static void __qdisc_destroy(struct Qdisc *qdisc)
 {
-	const struct Qdisc_ops  *ops = qdisc->ops;
+	struct net_device *dev = qdisc_dev(qdisc);
+	const struct Qdisc_ops *ops = qdisc->ops;
+	const struct Qdisc_class_ops *cops;
+	struct tcf_block *block;
+	unsigned long cl;
+	u32 block_index;
 
 #ifdef CONFIG_NET_SCHED
 	qdisc_hash_del(qdisc);
@@ -1059,11 +1064,42 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
 
 	qdisc_reset(qdisc);
 
+	cops = ops->cl_ops;
+	if (ops->ingress_block_get) {
+		block_index = ops->ingress_block_get(qdisc);
+		if (block_index) {
+			/* XXX: will only work for clsact and ingress, we need
+			 *  a flag for qdiscs instead of depending on this hack
+			 */
+			cl = TC_H_MIN_INGRESS;
+			block = cops->tcf_block(qdisc, cl, NULL);
+			if (block) {
+				if (xa_erase(&block->ports, dev->ifindex))
+					netdev_put(dev, &qdisc->in_block_tracker);
+			}
+		}
+	}
+
+	if (ops->egress_block_get) {
+		block_index = ops->egress_block_get(qdisc);
+		if (block_index) {
+			/* XXX: will only work for clsact, we need a flag for
+			 * qdiscs instead of depending on this hack
+			 */
+			cl = TC_H_MIN_EGRESS;
+			block = cops->tcf_block(qdisc, cl, NULL);
+			if (block) {
+				if (xa_erase(&block->ports, dev->ifindex))
+					netdev_put(dev, &qdisc->eg_block_tracker);
+			}
+		}
+	}
+
 	if (ops->destroy)
 		ops->destroy(qdisc);
 
 	module_put(ops->owner);
-	netdev_put(qdisc_dev(qdisc), &qdisc->dev_tracker);
+	netdev_put(dev, &qdisc->dev_tracker);
 
 	trace_qdisc_destroy(qdisc);
 
-- 
2.34.1



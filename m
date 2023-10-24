Return-Path: <netdev+bounces-43815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BBF7D4E88
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 13:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 240141C20B05
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 11:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7020C26281;
	Tue, 24 Oct 2023 11:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1A17498
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 11:06:30 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BDEB3
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 04:06:29 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qvFEx-0007oa-Bt; Tue, 24 Oct 2023 13:06:27 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Florian Westphal <fw@strlen.de>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net-next v2] sched: act_ct: switch to per-action label counting
Date: Tue, 24 Oct 2023 13:05:51 +0200
Message-ID: <20231024110557.20688-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

net->ct.labels_used was meant to convey 'number of ip/nftables rules
that need the label extension allocated'.

act_ct enables this for each net namespace, which voids all attempts
to avoid ct->ext allocation when possible.

Move this increment to the control plane to request label extension
space allocation only when its needed.

Signed-off-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 v2: want reverse xmas

 include/net/tc_act/tc_ct.h |  1 +
 net/sched/act_ct.c         | 41 +++++++++++++++++---------------------
 2 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/include/net/tc_act/tc_ct.h b/include/net/tc_act/tc_ct.h
index b24ea2d9400b..8a6dbfb23336 100644
--- a/include/net/tc_act/tc_ct.h
+++ b/include/net/tc_act/tc_ct.h
@@ -22,6 +22,7 @@ struct tcf_ct_params {
 
 	struct nf_nat_range2 range;
 	bool ipv4_range;
+	bool put_labels;
 
 	u16 ct_action;
 
diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 7c652d14528b..43b06cb284ce 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -690,7 +690,6 @@ static struct tc_action_ops act_ct_ops;
 
 struct tc_ct_action_net {
 	struct tc_action_net tn; /* Must be first */
-	bool labels;
 };
 
 /* Determine whether skb->_nfct is equal to the result of conntrack lookup. */
@@ -829,8 +828,13 @@ static void tcf_ct_params_free(struct tcf_ct_params *params)
 	}
 	if (params->ct_ft)
 		tcf_ct_flow_table_put(params->ct_ft);
-	if (params->tmpl)
+	if (params->tmpl) {
+		if (params->put_labels)
+			nf_connlabels_put(nf_ct_net(params->tmpl));
+
 		nf_ct_put(params->tmpl);
+	}
+
 	kfree(params);
 }
 
@@ -1154,9 +1158,9 @@ static int tcf_ct_fill_params(struct net *net,
 			      struct nlattr **tb,
 			      struct netlink_ext_ack *extack)
 {
-	struct tc_ct_action_net *tn = net_generic(net, act_ct_ops.net_id);
 	struct nf_conntrack_zone zone;
 	int err, family, proto, len;
+	bool put_labels = false;
 	struct nf_conn *tmpl;
 	char *name;
 
@@ -1186,15 +1190,20 @@ static int tcf_ct_fill_params(struct net *net,
 	}
 
 	if (tb[TCA_CT_LABELS]) {
+		unsigned int n_bits = sizeof_field(struct tcf_ct_params, labels) * 8;
+
 		if (!IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS)) {
 			NL_SET_ERR_MSG_MOD(extack, "Conntrack labels isn't enabled.");
 			return -EOPNOTSUPP;
 		}
 
-		if (!tn->labels) {
+		if (nf_connlabels_get(net, n_bits - 1)) {
 			NL_SET_ERR_MSG_MOD(extack, "Failed to set connlabel length");
 			return -EOPNOTSUPP;
+		} else {
+			put_labels = true;
 		}
+
 		tcf_ct_set_key_val(tb,
 				   p->labels, TCA_CT_LABELS,
 				   p->labels_mask, TCA_CT_LABELS_MASK,
@@ -1238,10 +1247,15 @@ static int tcf_ct_fill_params(struct net *net,
 		}
 	}
 
+	p->put_labels = put_labels;
+
 	if (p->ct_action & TCA_CT_ACT_COMMIT)
 		__set_bit(IPS_CONFIRMED_BIT, &tmpl->status);
 	return 0;
 err:
+	if (put_labels)
+		nf_connlabels_put(net);
+
 	nf_ct_put(p->tmpl);
 	p->tmpl = NULL;
 	return err;
@@ -1542,32 +1556,13 @@ static struct tc_action_ops act_ct_ops = {
 
 static __net_init int ct_init_net(struct net *net)
 {
-	unsigned int n_bits = sizeof_field(struct tcf_ct_params, labels) * 8;
 	struct tc_ct_action_net *tn = net_generic(net, act_ct_ops.net_id);
 
-	if (nf_connlabels_get(net, n_bits - 1)) {
-		tn->labels = false;
-		pr_err("act_ct: Failed to set connlabels length");
-	} else {
-		tn->labels = true;
-	}
-
 	return tc_action_net_init(net, &tn->tn, &act_ct_ops);
 }
 
 static void __net_exit ct_exit_net(struct list_head *net_list)
 {
-	struct net *net;
-
-	rtnl_lock();
-	list_for_each_entry(net, net_list, exit_list) {
-		struct tc_ct_action_net *tn = net_generic(net, act_ct_ops.net_id);
-
-		if (tn->labels)
-			nf_connlabels_put(net);
-	}
-	rtnl_unlock();
-
 	tc_action_net_exit(net_list, act_ct_ops.net_id);
 }
 
-- 
2.41.0



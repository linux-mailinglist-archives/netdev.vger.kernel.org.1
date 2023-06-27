Return-Path: <netdev+bounces-14250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DC273FC18
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 14:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DD222810A9
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 12:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E01D18015;
	Tue, 27 Jun 2023 12:39:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1309117FE6
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 12:39:24 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C3D26A5
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 05:39:19 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qE7yY-0003uj-EG; Tue, 27 Jun 2023 14:39:18 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>,
	Simon Horman <simon.horman@corigine.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net v3 3/3] net/sched: act_ipt: zero skb->cb before calling target
Date: Tue, 27 Jun 2023 14:38:13 +0200
Message-Id: <20230627123813.3036-4-fw@strlen.de>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230627123813.3036-1-fw@strlen.de>
References: <20230627123813.3036-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

xtables relies on skb being owned by ip stack, i.e. with ipv4
check in place skb->cb is supposed to be IPCB.

I don't see an immediate problem (REJECT target cannot be used anymore
now that PRE/POSTROUTING hook validation has been fixed), but better be
safe than sorry.

A much better patch would be to either mark act_ipt as
"depends on BROKEN" or remove it altogether. I plan to do this
for -next in the near future.

This tc extension is broken in the sense that tc lacks an
equivalent of NF_STOLEN verdict.

With NF_STOLEN, target function takes complete ownership of skb, caller
cannot dereference it anymore.

ACT_STOLEN cannot be used for this: it has a different meaning, caller
is allowed to dereference the skb.

At this time NF_STOLEN won't be returned by any targets as far as I can
see, but this may change in the future.

It might be possible to work around this via list of allowed
target extensions known to only return DROP or ACCEPT verdicts, but this
is error prone/fragile.

Existing selftest only validates xt_LOG and act_ipt is restricted
to ipv4 so I don't think this action is used widely.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/act_ipt.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/sched/act_ipt.c b/net/sched/act_ipt.c
index a6b522b512dc..598d6e299152 100644
--- a/net/sched/act_ipt.c
+++ b/net/sched/act_ipt.c
@@ -21,6 +21,7 @@
 #include <linux/tc_act/tc_ipt.h>
 #include <net/tc_act/tc_ipt.h>
 #include <net/tc_wrapper.h>
+#include <net/ip.h>
 
 #include <linux/netfilter_ipv4/ip_tables.h>
 
@@ -254,6 +255,7 @@ TC_INDIRECT_SCOPE int tcf_ipt_act(struct sk_buff *skb,
 				  const struct tc_action *a,
 				  struct tcf_result *res)
 {
+	char saved_cb[sizeof_field(struct sk_buff, cb)];
 	int ret = 0, result = 0;
 	struct tcf_ipt *ipt = to_ipt(a);
 	struct xt_action_param par;
@@ -280,6 +282,8 @@ TC_INDIRECT_SCOPE int tcf_ipt_act(struct sk_buff *skb,
 		state.out = skb->dev;
 	}
 
+	memcpy(saved_cb, skb->cb, sizeof(saved_cb));
+
 	spin_lock(&ipt->tcf_lock);
 
 	tcf_lastuse_update(&ipt->tcf_tm);
@@ -292,6 +296,9 @@ TC_INDIRECT_SCOPE int tcf_ipt_act(struct sk_buff *skb,
 	par.state    = &state;
 	par.target   = ipt->tcfi_t->u.kernel.target;
 	par.targinfo = ipt->tcfi_t->data;
+
+	memset(IPCB(skb), 0, sizeof(struct inet_skb_parm));
+
 	ret = par.target->target(skb, &par);
 
 	switch (ret) {
@@ -312,6 +319,9 @@ TC_INDIRECT_SCOPE int tcf_ipt_act(struct sk_buff *skb,
 		break;
 	}
 	spin_unlock(&ipt->tcf_lock);
+
+	memcpy(skb->cb, saved_cb, sizeof(skb->cb));
+
 	return result;
 
 }
-- 
2.39.3



Return-Path: <netdev+bounces-81642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7ABE88A93B
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 17:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD4721C39F0D
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 16:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2600C15B0F4;
	Mon, 25 Mar 2024 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="RnPRk63H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316CC159573
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 14:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711376947; cv=none; b=REHU4mqFJCZU6TOgkxFJ07ptEYuByyvCalyTaZTH4b7rO17qqHKMRRnlRXam+ILCH/LlpLg3ozFq7uyj7NfXNOdoMwGKiaVhjeccD163wrN8EQsApGkVUnDt9dpaL5zV6m0iIwNM/FE7xWtrrxKLkzYnE3XCxiRICmAjB94Bk3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711376947; c=relaxed/simple;
	bh=zAMjAJLOHitINP2i/k384hV6g8ZSWneElUuBIKt+bvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PnoWrdMz510nesK2t3jWS8Z5AH6VAPccRkDsh9UVHwYNeZB8OuNpdkZg0iddtrqkujHm72MyuPUlm+zoXXs/51Qd4SpAgbKvVSa/bC2I+0RYAU7IZENzoFkURac8bnnoCKe3P41xmC9lU2ytJ8voMlVDw8HxfkOXGqyVlclEZew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=RnPRk63H; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-ddaad2aeab1so2598108276.3
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 07:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1711376943; x=1711981743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdsAxeubGzvlml+Lb/dooIzFGZYnkfmMNYZ54ee5W3I=;
        b=RnPRk63HV84G370EAI7NNhnQAC5rPWIPK0bwrO1i89liCaCWbavyovYrxGZyzwAcpC
         p7dFTbjtSEE9dp2LSQA44uzKQ4DTi8pPJgajRLJMYVzBydKBF5ejYlj3bgrgk4HRPOc8
         44CK3v80jft2TkDUaP2JSaMzoSCByijxmJRDcxRdj8PIrZlDkHSBlF4E7uT7gwfuaQ61
         X2KY6RsHP9DzvBHdXWXMoD+3/ftUnHRhWZToT+PO+VgZr7pqT3Yu5vV9YwZXYcPHetHK
         MEYxepOeSsZhC+h+SzDAqUlpxT6MIwfDne4O4Pmx3TnsOvbxhgCIw8th1uEFWscI5IEZ
         +uDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711376943; x=1711981743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdsAxeubGzvlml+Lb/dooIzFGZYnkfmMNYZ54ee5W3I=;
        b=lbtzcxC7/R38q4cc63Dmt1CEBt7CYXIWpR+abkK+2/Q5v22E192czi61forKpg/O/I
         TKfiN8JH/5I0l615FaGUXFVgYAE/8HUgKgdxHEGi2gYllwx+U/36KVasS4pvcGD9/Gyc
         WzW69cf4Sxag5iORHD9f8D+O+j+hEYorQpastVxSCZXbenv5mi7AN4AoNTd/Pv4U5md1
         1QyP0bzbLsLfxUAYk/sBW4qLr6ZTMnt3xKB6IBHKMy05sYQ5gbg09tNnEJ4sexTw86L1
         GNXSgBMSBPkE77BBDRl8lMLFzpDMcp6+zmqNCBmfKfIzURvHpKaifRGLx9ehqGL3VQnJ
         ohnA==
X-Gm-Message-State: AOJu0Yw0f0FNqgzCAgEwIGNIroIWMtiBpSqh8hS+MLIZhOzysxjY3xDi
	Uhh/+dLENpXARN8eGxxN2J2JKn8axIk4khIrKh/jXqv4RKOJ9mphxKPDGnWw/E8bMEJA5ZHOwgM
	=
X-Google-Smtp-Source: AGHT+IGydCWiob35bURtXHxZ+Pg7b7KknK1D0r/biU1yeZL5ZIi9kKRTZv6twMusl4prDHjzJjaBUw==
X-Received: by 2002:a25:b41a:0:b0:dc7:4639:55d1 with SMTP id n26-20020a25b41a000000b00dc7463955d1mr4930104ybj.18.1711376942250;
        Mon, 25 Mar 2024 07:29:02 -0700 (PDT)
Received: from majuu.waya ([174.94.28.98])
        by smtp.gmail.com with ESMTPSA id l4-20020ad44bc4000000b0069687cdaba3sm1729255qvw.36.2024.03.25.07.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 07:29:01 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com,
	anjali.singhai@intel.com,
	namrata.limaye@intel.com,
	tom@sipanda.io,
	mleitner@redhat.com,
	Mahesh.Shirshyad@amd.com,
	Vipin.Jain@amd.com,
	tomasz.osinski@intel.com,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladbu@nvidia.com,
	horms@kernel.org,
	khalidm@nvidia.com,
	toke@redhat.com,
	daniel@iogearbox.net,
	victor@mojatatu.com,
	pctammela@mojatatu.com,
	bpf@vger.kernel.org
Subject: [PATCH net-next v13  10/15] p4tc: add runtime action support
Date: Mon, 25 Mar 2024 10:28:29 -0400
Message-Id: <20240325142834.157411-11-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325142834.157411-1-jhs@mojatatu.com>
References: <20240325142834.157411-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit deals with the runtime part of P4 actions i.e instantiation and
binding of action kinds which are created via templates (see previous
patch).

For illustration we repeat the P4 code snippet from the action template
commit:

action send_nh(@tc_type("macaddr) bit<48> dstAddr, @tc_type("dev") bit<8> port)
{
    hdr.ethernet.dstAddr = dstMac;
    send_to_port(port);
}

table mytable {
        key = {
            hdr.ipv4.dstAddr @tc_type("ipv4"): lpm;
        }

        actions = {
            send_nh;
            drop;
            NoAction;
        }

        size = 1024;
}

One could create a table entry alongside an action instance as follows:

tc p4ctrl create aP4proggie/table/mycontrol/mytable \
   srcAddr 10.10.10.0/24 \
   action send_nh param dstAddr AA:BB:CC:DD:EE:FF param port eth0

As previously stated, we refer to the action by it's "full name"
(pipeline_name/action_name). In the above the pipeline_name is inherited from
the table patch ("aP4proggie"), so it doesn't need to be specified.
Above we are creating an instance of the send_nh action specifying as parameter
values AA:BB:CC:DD:EE:FF for dstAddr and eth0 for port.

We could also create the action instance outside of the table entry
which is then added to the pool of send_nh action kind's instances as follows:

tc actions add action aP4proggie/send_nh \
param dstAddr AA:BB:CC:DD:EE:FF param port eth0

Observe these are _exactly the same semantics_ as what tc today already
provides with a caveat that we have a keyword "param" to precede the
appropriate parameters.

Note: We can create as many instances for action templates as we wish, as
long as we do not exceed the maximum allowed actions - in this specific
case 1024 for table "mytable". Any creation of action instances above the max
allowed will be rejected by the kernel.

Action sharing still works the same way (as in classical tc). For example
if we know the action index of the previous instance is 100 then we can
bind it to a table entry, for example

tc p4ctrl create aP4proggie/table/mycontrol/mytable \
   srcAddr 11.11.0.0/16 action send_nh index 100

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
---
 include/net/p4tc.h           |  115 ++++
 include/net/tc_act/p4tc.h    |    1 +
 include/uapi/linux/p4tc.h    |   13 +
 net/sched/p4tc/p4tc_action.c | 1263 +++++++++++++++++++++++++++++++++-
 4 files changed, 1382 insertions(+), 10 deletions(-)

diff --git a/include/net/p4tc.h b/include/net/p4tc.h
index 89ba907ee..b3b1b783e 100644
--- a/include/net/p4tc.h
+++ b/include/net/p4tc.h
@@ -116,6 +116,56 @@ p4tc_pipeline_find_byany_unsealed(struct net *net, const char *p_name,
 				  const u32 pipeid,
 				  struct netlink_ext_ack *extack);
 
+struct p4tc_act *p4a_runt_find(struct net *net,
+			       const struct tc_action_ops *a_o,
+			       struct netlink_ext_ack *extack);
+void
+p4a_runt_prealloc_put(struct p4tc_act *act, struct tcf_p4act *p4_act);
+
+static inline int p4tc_action_destroy(struct tc_action *acts[])
+{
+	struct tc_action *acts_non_prealloc[TCA_ACT_MAX_PRIO] = {NULL};
+	struct tc_action *a;
+	int ret = 0;
+	int j = 0;
+	int i;
+
+	tcf_act_for_each_action(i, a, acts) {
+		if (acts[i]->tcfa_flags & TCA_ACT_FLAGS_PREALLOC) {
+			struct tcf_p4act *p4act;
+			struct p4tc_act *act;
+			struct net *net;
+
+			p4act = (struct tcf_p4act *)acts[i];
+			net = maybe_get_net(acts[i]->idrinfo->net);
+
+			if (net) {
+				const struct tc_action_ops *ops;
+
+				ops = acts[i]->ops;
+				act = p4a_runt_find(net, ops, NULL);
+				p4a_runt_prealloc_put(act, p4act);
+				put_net(net);
+			} else {
+				/* If net is coming down, template
+				 * action will be deleted, so no need to
+				 * remove from prealloc list, just decr
+				 * refcounts.
+				 */
+				acts_non_prealloc[j] = acts[i];
+				j++;
+			}
+		} else {
+			acts_non_prealloc[j] = acts[i];
+			j++;
+		}
+	}
+
+	ret = tcf_action_destroy(acts_non_prealloc, TCA_ACT_UNBIND);
+
+	return ret;
+}
+
 struct p4tc_act_param {
 	struct list_head head;
 	struct rcu_head	rcu;
@@ -164,10 +214,67 @@ struct p4tc_act {
 	 * pipeline it belongs to.
 	 */
 	refcount_t                  a_ref;
+	atomic_t                    num_insts;
 	bool                        active;
 	char                        fullname[ACTNAMSIZ];
 };
 
+static inline int p4tc_action_init(struct net *net, struct nlattr *nla,
+				   struct tc_action *acts[], u32 pipeid,
+				   u32 flags, struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[TCA_ACT_MAX_PRIO + 1] = {};
+	int init_res[TCA_ACT_MAX_PRIO];
+	struct tc_action *a;
+	size_t attrs_size;
+	size_t nacts = 0;
+	int ret;
+	int i;
+
+	ret = nla_parse_nested_deprecated(tb, TCA_ACT_MAX_PRIO, nla, NULL,
+					  extack);
+	if (ret < 0)
+		return ret;
+
+	for (i = 1; i < TCA_ACT_MAX_PRIO + 1; i++)
+		nacts += !!tb[i];
+
+	if (nacts > 1) {
+		NL_SET_ERR_MSG(extack, "Only one action is allowed");
+		return -E2BIG;
+	}
+
+	/* If action was already created, just bind to existing one */
+	flags |= TCA_ACT_FLAGS_BIND;
+	flags |= TCA_ACT_FLAGS_FROM_P4TC;
+	ret = tcf_action_init(net, NULL, nla, NULL, acts, init_res, &attrs_size,
+			      flags, 0, extack);
+
+	/* Check if we are trying to bind to dynamic action from different
+	 * pipeline.
+	 */
+	tcf_act_for_each_action(i, a, acts) {
+		struct tcf_p4act *p;
+
+		if (a->ops->id <= TCA_ID_MAX)
+			continue;
+
+		p = to_p4act(a);
+		if (p->p_id != pipeid) {
+			NL_SET_ERR_MSG(extack,
+				       "Unable to bind to dynact from different pipeline");
+			ret = -EPERM;
+			goto destroy_acts;
+		}
+	}
+
+	return ret;
+
+destroy_acts:
+	p4tc_action_destroy(acts);
+	return ret;
+}
+
 struct p4tc_act *p4a_tmpl_get(struct p4tc_pipeline *pipeline,
 			      const char *act_name, const u32 a_id,
 			      struct netlink_ext_ack *extack);
@@ -179,6 +286,14 @@ static inline bool p4tc_action_put_ref(struct p4tc_act *act)
 	return refcount_dec_not_one(&act->a_ref);
 }
 
+struct tcf_p4act *
+p4a_runt_prealloc_get_next(struct p4tc_act *act);
+void p4a_runt_prealloc_reference(struct p4tc_act *act, struct tcf_p4act *p4act);
+void p4a_runt_parm_destroy(struct p4tc_act_param *parm);
+struct p4tc_act_param *
+p4a_runt_parm_init(struct net *net, struct p4tc_act *act,
+		   struct nlattr *nla, struct netlink_ext_ack *extack);
+
 #define to_pipeline(t) ((struct p4tc_pipeline *)t)
 #define p4tc_to_act(t) ((struct p4tc_act *)t)
 
diff --git a/include/net/tc_act/p4tc.h b/include/net/tc_act/p4tc.h
index c5256d821..9b62dc76b 100644
--- a/include/net/tc_act/p4tc.h
+++ b/include/net/tc_act/p4tc.h
@@ -20,6 +20,7 @@ struct tcf_p4act {
 	u32 p_id;
 	u32 act_id;
 	struct list_head node;
+	u32 num_runt_params;
 };
 
 #define to_p4act(a) ((struct tcf_p4act *)a)
diff --git a/include/uapi/linux/p4tc.h b/include/uapi/linux/p4tc.h
index d07e331bc..bb4533689 100644
--- a/include/uapi/linux/p4tc.h
+++ b/include/uapi/linux/p4tc.h
@@ -115,6 +115,17 @@ enum {
 };
 
 #define P4TC_ACT_MAX (__P4TC_ACT_MAX - 1)
+
+/* Action params value attributes */
+
+enum {
+	P4TC_ACT_PARAMS_VALUE_UNSPEC,
+	P4TC_ACT_PARAMS_VALUE_RAW, /* binary */
+	__P4TC_ACT_PARAMS_VALUE_MAX
+};
+
+#define P4TC_ACT_VALUE_PARAMS_MAX (__P4TC_ACT_PARAMS_VALUE_MAX - 1)
+
 enum {
 	P4TC_ACT_PARAMS_TYPE_UNSPEC,
 	P4TC_ACT_PARAMS_TYPE_BITEND, /* u16 */
@@ -138,6 +149,8 @@ enum {
 	P4TC_ACT_PARAMS_ID, /* u32 */
 	P4TC_ACT_PARAMS_TYPE, /* nested type - mandatory for params create */
 	P4TC_ACT_PARAMS_FLAGS, /* u8 */
+	P4TC_ACT_PARAMS_VALUE, /* bytes - mandatory for runtime params create */
+	P4TC_ACT_PARAMS_MASK, /* bytes */
 	__P4TC_ACT_PARAMS_MAX
 };
 
diff --git a/net/sched/p4tc/p4tc_action.c b/net/sched/p4tc/p4tc_action.c
index db4add0c4..d0684036a 100644
--- a/net/sched/p4tc/p4tc_action.c
+++ b/net/sched/p4tc/p4tc_action.c
@@ -30,11 +30,533 @@
 #include <net/sock.h>
 #include <net/tc_act/p4tc.h>
 
+static LIST_HEAD(dynact_list);
+
+#define P4TC_ACT_CREATED 1
+#define P4TC_ACT_PREALLOC 2
+#define P4TC_ACT_PREALLOC_UNINIT 3
+
+static int __p4a_runt_init(struct net *net, struct nlattr *est,
+			   struct p4tc_act *act, struct tc_act_p4 *parm,
+			   struct tc_action **a, struct tcf_proto *tp,
+			   const struct tc_action_ops *a_o,
+			   struct tcf_chain **goto_ch, u32 flags,
+			   struct netlink_ext_ack *extack)
+{
+	bool unreferenced = flags & TCA_ACT_FLAGS_UNREFERENCED;
+	bool from_p4tc = flags & TCA_ACT_FLAGS_FROM_P4TC;
+	bool prealloc = flags & TCA_ACT_FLAGS_PREALLOC;
+	bool replace = flags & TCA_ACT_FLAGS_REPLACE;
+	bool bind = flags & TCA_ACT_FLAGS_BIND;
+	struct p4tc_pipeline *pipeline;
+	struct tcf_p4act *p4act;
+	u32 index = parm->index;
+	bool exists = false;
+	int ret = 0;
+	int err;
+
+	if ((from_p4tc && !prealloc && !replace && !index)) {
+		p4act = p4a_runt_prealloc_get_next(act);
+
+		if (p4act) {
+			p4a_runt_prealloc_reference(act, p4act);
+			*a = &p4act->common;
+			return P4TC_ACT_PREALLOC_UNINIT;
+		}
+	}
+
+	err = tcf_idr_check_alloc(act->tn, &index, a, bind);
+	if (err < 0)
+		return err;
+
+	exists = err;
+	if (!exists) {
+		struct tcf_p4act *p;
+
+		ret = tcf_idr_create(act->tn, index, est, a, a_o, bind, true,
+				     flags);
+		if (ret) {
+			tcf_idr_cleanup(act->tn, index);
+			return ret;
+		}
+
+		if (!(prealloc && unreferenced))
+			atomic_inc(&act->num_insts);
+
+		pipeline = act->pipeline;
+
+		p = to_p4act(*a);
+		p->p_id = pipeline->common.p_id;
+		p->act_id = act->a_id;
+
+		p->common.tcfa_flags |= TCA_ACT_FLAGS_PREALLOC;
+		if (!prealloc && !bind) {
+			spin_lock_bh(&act->list_lock);
+			list_add_tail(&p->node, &act->prealloc_list);
+			spin_unlock_bh(&act->list_lock);
+		}
+
+		ret = P4TC_ACT_CREATED;
+	} else {
+		const u32 tcfa_flags = (*a)->tcfa_flags;
+
+		if (bind) {
+			if ((tcfa_flags & TCA_ACT_FLAGS_PREALLOC)) {
+				if (tcfa_flags & TCA_ACT_FLAGS_UNREFERENCED) {
+					p4act = to_p4act(*a);
+					p4a_runt_prealloc_reference(act, p4act);
+					return P4TC_ACT_PREALLOC_UNINIT;
+				}
+
+				return P4TC_ACT_PREALLOC;
+			}
+
+			return 0;
+		}
+
+		if (replace) {
+			if ((tcfa_flags & TCA_ACT_FLAGS_PREALLOC)) {
+				if (tcfa_flags & TCA_ACT_FLAGS_UNREFERENCED) {
+					p4act = to_p4act(*a);
+					p4a_runt_prealloc_reference(act, p4act);
+					ret = P4TC_ACT_PREALLOC_UNINIT;
+				} else {
+					ret = P4TC_ACT_PREALLOC;
+				}
+			}
+		} else {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "Action %s with index %u was already created",
+					   (*a)->ops->kind, index);
+			tcf_idr_release(*a, bind);
+			return -EEXIST;
+		}
+	}
+
+	err = tcf_action_check_ctrlact(parm->action, tp, goto_ch, extack);
+	if (err < 0) {
+		tcf_idr_release(*a, bind);
+		return err;
+	}
+
+	return ret;
+}
+
+static void p4a_runt_parm_val_free(struct p4tc_act_param *param)
+{
+	kfree(param->value);
+	kfree(param->mask);
+}
+
+static const struct nla_policy
+p4a_parm_val_policy[P4TC_ACT_VALUE_PARAMS_MAX + 1] = {
+	[P4TC_ACT_PARAMS_VALUE_RAW] = { .type = NLA_BINARY },
+};
+
+static const struct nla_policy
+p4a_parm_type_policy[P4TC_ACT_PARAMS_TYPE_MAX + 1] = {
+	[P4TC_ACT_PARAMS_TYPE_BITEND] = { .type = NLA_U16 },
+	[P4TC_ACT_PARAMS_TYPE_CONTAINER_ID] = { .type = NLA_U32 },
+};
+
+static int p4a_runt_dev_parm_val_init(struct net *net,
+				      struct p4tc_act_param_ops *op,
+				      struct p4tc_act_param *nparam,
+				      struct nlattr **tb,
+				      struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb_value[P4TC_ACT_VALUE_PARAMS_MAX + 1];
+	u32 value_len;
+	u32 *ifindex;
+	int err;
+
+	if (!tb[P4TC_ACT_PARAMS_VALUE]) {
+		NL_SET_ERR_MSG(extack, "Must specify param value");
+		return -EINVAL;
+	}
+	err = nla_parse_nested(tb_value, P4TC_ACT_VALUE_PARAMS_MAX,
+			       tb[P4TC_ACT_PARAMS_VALUE],
+			       p4a_parm_val_policy, extack);
+	if (err < 0)
+		return err;
+
+	value_len = nla_len(tb_value[P4TC_ACT_PARAMS_VALUE_RAW]);
+	if (value_len != sizeof(u32)) {
+		NL_SET_ERR_MSG(extack, "Value length differs from template's");
+		return -EINVAL;
+	}
+
+	ifindex = nla_data(tb_value[P4TC_ACT_PARAMS_VALUE_RAW]);
+	rcu_read_lock();
+	if (!dev_get_by_index_rcu(net, *ifindex)) {
+		NL_SET_ERR_MSG(extack, "Invalid ifindex");
+		rcu_read_unlock();
+		return -EINVAL;
+	}
+	rcu_read_unlock();
+
+	nparam->value = kmemdup(ifindex, sizeof(*ifindex), GFP_KERNEL);
+	if (!nparam->value)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int p4a_runt_dev_parm_val_dump(struct sk_buff *skb,
+				      struct p4tc_act_param_ops *op,
+				      struct p4tc_act_param *param)
+{
+	const u32 *ifindex = param->value;
+	struct nlattr *nest;
+	int ret;
+
+	nest = nla_nest_start(skb, P4TC_ACT_PARAMS_VALUE);
+	if (nla_put_u32(skb, P4TC_ACT_PARAMS_VALUE_RAW, *ifindex)) {
+		ret = -EINVAL;
+		goto out_nla_cancel;
+	}
+	nla_nest_end(skb, nest);
+
+	return 0;
+
+out_nla_cancel:
+	nla_nest_cancel(skb, nest);
+	return ret;
+}
+
+static void p4a_runt_dev_parm_val_free(struct p4tc_act_param *param)
+{
+	kfree(param->value);
+}
+
+static const struct p4tc_act_param_ops param_ops[P4TC_T_MAX + 1] = {
+	[P4TC_T_DEV] = {
+		.init_value = p4a_runt_dev_parm_val_init,
+		.dump_value = p4a_runt_dev_parm_val_dump,
+		.free = p4a_runt_dev_parm_val_free,
+	},
+};
+
+void p4a_runt_parm_destroy(struct p4tc_act_param *parm)
+{
+	struct p4tc_act_param_ops *op;
+
+	op = (struct p4tc_act_param_ops *)&param_ops[parm->type->typeid];
+	if (op->free)
+		op->free(parm);
+	else
+		p4a_runt_parm_val_free(parm);
+	kfree(parm);
+}
+
+static void p4a_runt_parms_destroy(struct tcf_p4act_params *params)
+{
+	struct p4tc_act_param *parm;
+	unsigned long param_id, tmp;
+
+	idr_for_each_entry_ul(&params->params_idr, parm, tmp, param_id) {
+		idr_remove(&params->params_idr, param_id);
+		p4a_runt_parm_destroy(parm);
+	}
+
+	kfree(params->params_array);
+	idr_destroy(&params->params_idr);
+
+	kfree(params);
+}
+
+static void p4a_runt_parms_destroy_rcu(struct rcu_head *head)
+{
+	struct tcf_p4act_params *params;
+
+	params = container_of(head, struct tcf_p4act_params, rcu);
+	p4a_runt_parms_destroy(params);
+}
+
+static bool p4a_param_has_runt_flag(struct p4tc_act_param *param)
+{
+	return param->flags & BIT(P4TC_ACT_PARAMS_FLAGS_RUNT);
+}
+
+static void p4a_set_num_runtime(struct tcf_p4act *p4act)
+{
+	struct tcf_p4act_params *params;
+	struct p4tc_act_param *param;
+	unsigned long param_id, tmp;
+
+	p4act->num_runt_params = 0;
+	params = rcu_dereference_protected(p4act->params, 1);
+	idr_for_each_entry_ul(&params->params_idr, param, tmp, param_id) {
+		if (p4a_param_has_runt_flag(param))
+			p4act->num_runt_params++;
+	}
+}
+
+static int __p4a_runt_init_set(struct p4tc_act *act, struct tc_action **a,
+			       struct tcf_p4act_params *params,
+			       struct tcf_chain *goto_ch,
+			       struct tc_act_p4 *parm, bool exists,
+			       struct netlink_ext_ack *extack)
+{
+	struct tcf_p4act_params *params_old;
+	struct tcf_p4act *p;
+
+	p = to_p4act(*a);
+
+	/* sparse is fooled by lock under conditionals.
+	 * To avoid false positives, we are repeating these statements in
+	 * both branches of the if-statement
+	 */
+	if (exists) {
+		spin_lock_bh(&p->tcf_lock);
+		goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
+		params_old = rcu_replace_pointer(p->params, params, 1);
+		p4a_set_num_runtime(p);
+		spin_unlock_bh(&p->tcf_lock);
+	} else {
+		goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
+		params_old = rcu_replace_pointer(p->params, params, 1);
+		p4a_set_num_runtime(p);
+	}
+
+	if (goto_ch)
+		tcf_chain_put_by_act(goto_ch);
+
+	if (params_old)
+		call_rcu(&params_old->rcu, p4a_runt_parms_destroy_rcu);
+
+	return 0;
+}
+
+static int p4a_runt_init_from_tmpl(struct net *net, struct tc_action **a,
+				   struct p4tc_act *act,
+				   struct idr *params_idr,
+				   struct list_head *params_lst,
+				   struct tc_act_p4 *parm, u32 flags,
+				   struct netlink_ext_ack *extack);
+
+static struct tcf_p4act_params *p4a_runt_parms_alloc(struct p4tc_act *act)
+{
+	struct tcf_p4act_params *params;
+
+	params = kzalloc(sizeof(*params), GFP_KERNEL);
+	if (!params)
+		return ERR_PTR(-ENOMEM);
+
+	params->params_array = kcalloc(act->num_params,
+				       sizeof(struct p4tc_act_param *),
+				       GFP_KERNEL);
+	if (!params->params_array) {
+		kfree(params);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	idr_init(&params->params_idr);
+
+	return params;
+}
+
+static struct p4tc_act_param *
+p4a_runt_prealloc_init_param(struct p4tc_act *act, struct idr *params_idr,
+			     struct p4tc_act_param *param,
+			     unsigned long *param_id,
+			     struct netlink_ext_ack *extack)
+{
+	struct p4tc_act_param *nparam;
+	void *value;
+
+	nparam = kzalloc(sizeof(*nparam), GFP_KERNEL);
+	if (!nparam)
+		return ERR_PTR(-ENOMEM);
+
+	value = kzalloc(BITS_TO_BYTES(param->type->container_bitsz),
+			GFP_KERNEL);
+	if (!value) {
+		kfree(nparam);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	strscpy(nparam->name, param->name, P4TC_ACT_PARAM_NAMSIZ);
+	nparam->id = *param_id;
+	nparam->value = value;
+	nparam->type = param->type;
+
+	return nparam;
+}
+
 static void p4a_parm_put(struct p4tc_act_param *param)
 {
 	kfree(param);
 }
 
+static void p4a_runt_parm_put_val(struct p4tc_act_param *param)
+{
+	kfree(param->value);
+	p4a_parm_put(param);
+}
+
+static void p4a_runt_prealloc_list_free(struct list_head *params_list)
+{
+	struct p4tc_act_param *nparam, *p;
+
+	list_for_each_entry_safe(nparam, p, params_list, head) {
+		p4a_runt_parm_put_val(nparam);
+	}
+}
+
+static int p4a_runt_prealloc_params_init(struct p4tc_act *act,
+					 struct idr *params_idr,
+					 struct list_head *params_lst,
+					 struct netlink_ext_ack *extack)
+{
+	struct p4tc_act_param *param;
+	unsigned long param_id = 0;
+	unsigned long tmp;
+
+	idr_for_each_entry_ul(params_idr, param, tmp, param_id) {
+		struct p4tc_act_param *nparam;
+
+		nparam = p4a_runt_prealloc_init_param(act, params_idr,
+						      param, &param_id,
+						      extack);
+		if (IS_ERR(nparam))
+			return PTR_ERR(nparam);
+
+		list_add_tail(&nparam->head, params_lst);
+	}
+
+	return 0;
+}
+
+static void
+p4a_runt_prealloc_list_add(struct p4tc_act *act_tmpl,
+			   struct tc_action **acts,
+			   u32 num_prealloc_acts)
+{
+	int i;
+
+	for (i = 0; i < num_prealloc_acts; i++) {
+		struct tcf_p4act *p4act = to_p4act(acts[i]);
+
+		list_add_tail(&p4act->node, &act_tmpl->prealloc_list);
+	}
+
+	tcf_idr_insert_n(acts, num_prealloc_acts);
+}
+
+static int
+p4a_runt_prealloc_create(struct net *net, struct p4tc_act *act,
+			 struct idr *params_idr, struct tc_action **acts,
+			 const u32 num_prealloc_acts,
+			 struct netlink_ext_ack *extack)
+{
+	int err;
+	int i;
+
+	for (i = 0; i < num_prealloc_acts; i++) {
+		u32 flags = TCA_ACT_FLAGS_PREALLOC | TCA_ACT_FLAGS_UNREFERENCED;
+		struct tc_action *a = acts[i];
+		struct tc_act_p4 parm = {0};
+		struct list_head params_lst;
+
+		parm.index = i + 1;
+		parm.action = TC_ACT_PIPE;
+
+		INIT_LIST_HEAD(&params_lst);
+
+		err = p4a_runt_prealloc_params_init(act, params_idr,
+						    &params_lst, extack);
+		if (err < 0) {
+			p4a_runt_prealloc_list_free(&params_lst);
+			goto destroy_acts;
+		}
+
+		err = p4a_runt_init_from_tmpl(net, &a, act, params_idr,
+					      &params_lst, &parm, flags,
+					      extack);
+		p4a_runt_prealloc_list_free(&params_lst);
+		if (err < 0)
+			goto destroy_acts;
+
+		acts[i] = a;
+	}
+
+	return 0;
+
+destroy_acts:
+	tcf_action_destroy(acts, false);
+
+	return err;
+}
+
+struct tcf_p4act *
+p4a_runt_prealloc_get_next(struct p4tc_act *act)
+{
+	struct tcf_p4act *p4_act;
+
+	spin_lock_bh(&act->list_lock);
+	p4_act = list_first_entry_or_null(&act->prealloc_list, struct tcf_p4act,
+					  node);
+	if (p4_act) {
+		list_del_init(&p4_act->node);
+		refcount_set(&p4_act->common.tcfa_refcnt, 1);
+		atomic_set(&p4_act->common.tcfa_bindcnt, 1);
+	}
+	spin_unlock_bh(&act->list_lock);
+
+	return p4_act;
+}
+
+void p4a_runt_prealloc_reference(struct p4tc_act *act, struct tcf_p4act *p4act)
+{
+	struct tc_action *a;
+
+	a = (struct tc_action *)p4act;
+	a->tcfa_flags &= ~TCA_ACT_FLAGS_UNREFERENCED;
+	atomic_inc(&act->num_insts);
+}
+
+static void __p4a_runt_prealloc_put(struct p4tc_act *act,
+				    struct tcf_p4act *p4act)
+{
+	struct tcf_p4act_params *p4act_params;
+	struct p4tc_act_param *param;
+	unsigned long param_id, tmp;
+
+	spin_lock_bh(&p4act->tcf_lock);
+	p4act_params = rcu_dereference_protected(p4act->params, 1);
+	if (p4act_params) {
+		idr_for_each_entry_ul(&p4act_params->params_idr, param, tmp,
+				      param_id) {
+			if (!p4a_param_has_runt_flag(param)) {
+				const struct p4tc_type *type = param->type;
+				u32 type_bytesz =
+					BITS_TO_BYTES(type->container_bitsz);
+
+				memset(param->value, 0, type_bytesz);
+			}
+		}
+	}
+	p4act->common.tcfa_flags |= TCA_ACT_FLAGS_UNREFERENCED;
+	atomic_dec(&act->num_insts);
+	spin_unlock_bh(&p4act->tcf_lock);
+
+	spin_lock_bh(&act->list_lock);
+	list_add_tail(&p4act->node, &act->prealloc_list);
+	spin_unlock_bh(&act->list_lock);
+}
+
+void
+p4a_runt_prealloc_put(struct p4tc_act *act, struct tcf_p4act *p4act)
+{
+	if (refcount_read(&p4act->common.tcfa_refcnt) == 1) {
+		__p4a_runt_prealloc_put(act, p4act);
+	} else {
+		refcount_dec(&p4act->common.tcfa_refcnt);
+		atomic_dec(&p4act->common.tcfa_bindcnt);
+	}
+}
+
 static const struct nla_policy p4a_parm_policy[P4TC_ACT_PARAMS_MAX + 1] = {
 	[P4TC_ACT_PARAMS_NAME] = {
 		.type = NLA_STRING,
@@ -45,8 +567,100 @@ static const struct nla_policy p4a_parm_policy[P4TC_ACT_PARAMS_MAX + 1] = {
 	[P4TC_ACT_PARAMS_FLAGS] =
 		NLA_POLICY_RANGE(NLA_U8, 0,
 				 BIT(P4TC_ACT_PARAMS_FLAGS_MAX + 1) - 1),
+	[P4TC_ACT_PARAMS_VALUE] = { .type = NLA_NESTED },
+	[P4TC_ACT_PARAMS_MASK] = { .type = NLA_BINARY },
 };
 
+static int
+p4a_runt_parm_val_dump(struct sk_buff *skb, struct p4tc_type *type,
+		       struct p4tc_act_param *param)
+{
+	const u32 bytesz = BITS_TO_BYTES(type->container_bitsz);
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct nlattr *nla_value;
+
+	nla_value = nla_nest_start(skb, P4TC_ACT_PARAMS_VALUE);
+	if (nla_put(skb, P4TC_ACT_PARAMS_VALUE_RAW, bytesz,
+		    param->value))
+		goto out_nlmsg_trim;
+	nla_nest_end(skb, nla_value);
+
+	if (param->mask &&
+	    nla_put(skb, P4TC_ACT_PARAMS_MASK, bytesz, param->mask))
+		goto out_nlmsg_trim;
+
+	return 0;
+
+out_nlmsg_trim:
+	nlmsg_trim(skb, b);
+	return -1;
+}
+
+static int
+p4a_runt_parm_val_init(struct p4tc_act_param *nparam,
+		       struct p4tc_type *type, struct nlattr **tb,
+		       struct netlink_ext_ack *extack)
+{
+	const u32 alloc_len = BITS_TO_BYTES(type->container_bitsz);
+	struct nlattr *tb_value[P4TC_ACT_VALUE_PARAMS_MAX + 1];
+	const u32 len = BITS_TO_BYTES(type->bitsz);
+	void *value;
+	int err;
+
+	if (!tb[P4TC_ACT_PARAMS_VALUE]) {
+		NL_SET_ERR_MSG(extack, "Must specify param value");
+		return -EINVAL;
+	}
+
+	err = nla_parse_nested(tb_value, P4TC_ACT_VALUE_PARAMS_MAX,
+			       tb[P4TC_ACT_PARAMS_VALUE],
+			       p4a_parm_val_policy, extack);
+	if (err < 0)
+		return err;
+
+	value = nla_data(tb_value[P4TC_ACT_PARAMS_VALUE_RAW]);
+	if (type->ops->validate_p4t) {
+		err = type->ops->validate_p4t(type, value, 0, nparam->bitend,
+					      extack);
+		if (err < 0)
+			return err;
+	}
+
+	if (nla_len(tb_value[P4TC_ACT_PARAMS_VALUE_RAW]) != len)
+		return -EINVAL;
+
+	nparam->value = kzalloc(alloc_len, GFP_KERNEL);
+	if (!nparam->value)
+		return -ENOMEM;
+
+	memcpy(nparam->value, value, len);
+
+	if (tb[P4TC_ACT_PARAMS_MASK]) {
+		const void *mask = nla_data(tb[P4TC_ACT_PARAMS_MASK]);
+
+		if (nla_len(tb[P4TC_ACT_PARAMS_MASK]) != len) {
+			NL_SET_ERR_MSG(extack,
+				       "Mask length differs from template's");
+			err = -EINVAL;
+			goto free_value;
+		}
+
+		nparam->mask = kzalloc(alloc_len, GFP_KERNEL);
+		if (!nparam->mask) {
+			err = -ENOMEM;
+			goto free_value;
+		}
+
+		memcpy(nparam->mask, mask, len);
+	}
+
+	return 0;
+
+free_value:
+	kfree(nparam->value);
+	return err;
+}
+
 static struct p4tc_act_param *
 p4a_parm_find_byname(struct idr *params_idr, const char *param_name)
 {
@@ -119,11 +733,27 @@ p4a_parm_find_byanyattr(struct p4tc_act *act, struct nlattr *name_attr,
 	return p4a_parm_find_byany(act, param_name, param_id, extack);
 }
 
-static const struct nla_policy
-p4a_parm_type_policy[P4TC_ACT_PARAMS_TYPE_MAX + 1] = {
-	[P4TC_ACT_PARAMS_TYPE_BITEND] = { .type = NLA_U16 },
-	[P4TC_ACT_PARAMS_TYPE_CONTAINER_ID] = { .type = NLA_U32 },
-};
+static int p4a_runt_parms_check(struct p4tc_act *act,
+				struct idr *params_idr,
+				struct netlink_ext_ack *extack)
+{
+	struct p4tc_act_param *parm;
+	unsigned long param_id, tmp;
+
+	idr_for_each_entry_ul(&act->params_idr, parm, tmp, param_id) {
+		struct p4tc_act_param *parm_passed;
+
+		parm_passed = p4a_parm_find_byid(params_idr, param_id);
+		if (!parm_passed) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "Must specify param %s\n",
+					   parm->name);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
 
 static int
 __p4a_parm_init_type(struct p4tc_act_param *param, struct nlattr *nla,
@@ -169,6 +799,139 @@ __p4a_parm_init_type(struct p4tc_act_param *param, struct nlattr *nla,
 	return 0;
 }
 
+struct p4tc_act_param *
+p4a_runt_parm_init(struct net *net, struct p4tc_act *act,
+		   struct nlattr *nla, struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_ACT_PARAMS_MAX + 1];
+	struct p4tc_act_param *param, *nparam;
+	u32 param_id = 0;
+	int err;
+
+	err = nla_parse_nested(tb, P4TC_ACT_PARAMS_MAX, nla, p4a_parm_policy,
+			       extack);
+	if (err < 0)
+		goto out;
+
+	if (tb[P4TC_ACT_PARAMS_ID])
+		param_id = nla_get_u32(tb[P4TC_ACT_PARAMS_ID]);
+
+	param = p4a_parm_find_byanyattr(act, tb[P4TC_ACT_PARAMS_NAME],
+					param_id, extack);
+	if (IS_ERR(param))
+		return param;
+
+	nparam = kzalloc(sizeof(*nparam), GFP_KERNEL);
+	if (!nparam) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	if (tb[P4TC_ACT_PARAMS_FLAGS])
+		nparam->flags = nla_get_u8(tb[P4TC_ACT_PARAMS_FLAGS]);
+
+	strscpy(nparam->name, param->name, P4TC_ACT_PARAM_NAMSIZ);
+
+	if (p4a_param_has_runt_flag(nparam)) {
+		if (tb[P4TC_ACT_PARAMS_TYPE]) {
+			NL_SET_ERR_MSG(extack,
+				       "Unable to specify type and runtime flag simultaneously");
+			err = -EINVAL;
+			goto free;
+		}
+		if (tb[P4TC_ACT_PARAMS_VALUE]) {
+			NL_SET_ERR_MSG(extack,
+				       "Unable to specify value and runtime flag simultaneously");
+			err = -EINVAL;
+			goto free;
+		}
+
+		nparam->type = param->type;
+		nparam->bitend = param->bitend;
+	} else {
+		const struct p4tc_act_param_ops *op;
+
+		err = __p4a_parm_init_type(nparam, tb[P4TC_ACT_PARAMS_TYPE],
+					   extack);
+		if (err < 0)
+			goto free;
+
+		if (nparam->type != param->type) {
+			NL_SET_ERR_MSG(extack,
+				       "Param type differs from template");
+			err = -EINVAL;
+			goto free;
+		}
+
+		if (nparam->bitend != param->bitend) {
+			NL_SET_ERR_MSG(extack,
+				       "Param bitend differs from template");
+			err = -EINVAL;
+			goto free;
+		}
+
+		op = &param_ops[param->type->typeid];
+		if (op->init_value)
+			err = op->init_value(net,
+					     (struct p4tc_act_param_ops *)op,
+					     nparam, tb, extack);
+		else
+			err = p4a_runt_parm_val_init(nparam, nparam->type, tb,
+						     extack);
+		if (err < 0)
+			goto free;
+	}
+
+	nparam->id = param->id;
+	nparam->index = param->index;
+
+	return nparam;
+
+free:
+	kfree(nparam);
+out:
+	return ERR_PTR(err);
+}
+
+static int p4a_runt_parms_init(struct net *net, struct tcf_p4act_params *params,
+			       struct p4tc_act *act, struct nlattr *nla,
+			       struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_MSGBATCH_SIZE + 1];
+	int err;
+	int i;
+
+	err = nla_parse_nested(tb, P4TC_MSGBATCH_SIZE, nla, NULL, NULL);
+	if (err < 0)
+		return err;
+
+	for (i = 1; i < P4TC_MSGBATCH_SIZE + 1 && tb[i]; i++) {
+		const struct p4tc_act_param_ops *op;
+		struct p4tc_act_param *param;
+
+		param = p4a_runt_parm_init(net, act, tb[i], extack);
+		if (IS_ERR(param))
+			return PTR_ERR(param);
+
+		err = idr_alloc_u32(&params->params_idr, param, &param->id,
+				    param->id, GFP_KERNEL);
+		op = &param_ops[param->type->typeid];
+		if (err < 0) {
+			if (op->free)
+				op->free(param);
+			else
+				p4a_runt_parm_val_free(param);
+			kfree(param);
+			return err;
+		}
+
+		if (params->params_array)
+			params->params_array[param->index] = param;
+	}
+
+	return p4a_runt_parms_check(act, &params->params_idr, extack);
+}
+
 static struct p4tc_act *
 p4a_tmpl_find_byname(const char *fullname, struct p4tc_pipeline *pipeline,
 		     struct netlink_ext_ack *extack)
@@ -183,6 +946,145 @@ p4a_tmpl_find_byname(const char *fullname, struct p4tc_pipeline *pipeline,
 	return NULL;
 }
 
+struct p4tc_act *p4a_runt_find(struct net *net,
+			       const struct tc_action_ops *a_o,
+			       struct netlink_ext_ack *extack)
+{
+	char *pname, *aname, fullname[ACTNAMSIZ];
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_act *act;
+
+	strscpy(fullname, a_o->kind, ACTNAMSIZ);
+
+	aname = fullname;
+	pname = strsep(&aname, "/");
+	pipeline = p4tc_pipeline_find_byany(net, pname, 0, NULL);
+	if (IS_ERR(pipeline))
+		return ERR_PTR(-ENOENT);
+
+	act = p4a_tmpl_find_byname(a_o->kind, pipeline, extack);
+	if (!act)
+		return ERR_PTR(-ENOENT);
+
+	return act;
+}
+
+static int p4a_runt_init(struct net *net, struct nlattr *nla,
+			 struct nlattr *est, struct tc_action **a,
+			 struct tcf_proto *tp, const struct tc_action_ops *a_o,
+			 u32 flags, struct netlink_ext_ack *extack)
+{
+	bool bind = flags & TCA_ACT_FLAGS_BIND;
+	struct nlattr *tb[P4TC_ACT_MAX + 1];
+	struct tcf_chain *goto_ch = NULL;
+	struct tcf_p4act_params *params;
+	struct tcf_p4act *prealloc_act;
+	struct tc_act_p4 *parm;
+	struct p4tc_act *act;
+	bool exists = false;
+	int ret = 0;
+	int err;
+
+	if (flags & TCA_ACT_FLAGS_BIND &&
+	    !(flags & TCA_ACT_FLAGS_FROM_P4TC)) {
+		NL_SET_ERR_MSG(extack,
+			       "Can only bind to dynamic action from P4TC objects");
+		return -EPERM;
+	}
+
+	if (unlikely(!nla)) {
+		NL_SET_ERR_MSG(extack,
+			       "Must specify action netlink attributes");
+		return -EINVAL;
+	}
+
+	err = nla_parse_nested(tb, P4TC_ACT_MAX, nla, NULL, extack);
+	if (err < 0)
+		return err;
+
+	if (NL_REQ_ATTR_CHECK(extack, NULL, tb, P4TC_ACT_OPT)) {
+		NL_SET_ERR_MSG(extack,
+			       "Must specify option netlink attributes");
+		return -EINVAL;
+	}
+
+	act = p4a_runt_find(net, a_o, extack);
+	if (IS_ERR(act))
+		return PTR_ERR(act);
+
+	if (!act->active) {
+		NL_SET_ERR_MSG(extack,
+			       "Dynamic action must be active to create instance");
+		return -EINVAL;
+	}
+
+	parm = nla_data(tb[P4TC_ACT_OPT]);
+
+	ret = __p4a_runt_init(net, est, act, parm, a, tp, a_o, &goto_ch,
+			      flags, extack);
+	if (ret < 0)
+		return ret;
+	/* If trying to bind to unitialised preallocated action, must init
+	 * below
+	 */
+	if (bind && ret == P4TC_ACT_PREALLOC)
+		return 0;
+
+	err = tcf_action_check_ctrlact(parm->action, tp, &goto_ch, extack);
+	if (err < 0)
+		goto release_idr;
+
+	params = p4a_runt_parms_alloc(act);
+	if (IS_ERR(params)) {
+		err = PTR_ERR(params);
+		goto release_idr;
+	}
+
+	if (tb[P4TC_ACT_PARMS]) {
+		err = p4a_runt_parms_init(net, params, act, tb[P4TC_ACT_PARMS],
+					  extack);
+		if (err < 0)
+			goto release_params;
+	} else {
+		err = p4a_runt_parms_check(act, &params->params_idr, extack);
+		if (err < 0)
+			goto release_params;
+	}
+
+	exists = ret != P4TC_ACT_CREATED;
+	err = __p4a_runt_init_set(act, a, params, goto_ch, parm, exists,
+				  extack);
+	if (err < 0)
+		goto release_params;
+
+	return ret;
+
+release_params:
+	p4a_runt_parms_destroy(params);
+
+release_idr:
+	if (ret == P4TC_ACT_PREALLOC) {
+		prealloc_act = to_p4act(*a);
+		p4a_runt_prealloc_put(act, prealloc_act);
+		(*a)->tcfa_flags |= TCA_ACT_FLAGS_UNREFERENCED;
+	} else if (!bind && !exists &&
+		   ((*a)->tcfa_flags & TCA_ACT_FLAGS_PREALLOC)) {
+		prealloc_act = to_p4act(*a);
+		list_del_init(&prealloc_act->node);
+		tcf_idr_release(*a, bind);
+	} else {
+		tcf_idr_release(*a, bind);
+	}
+
+	return err;
+}
+
+static int p4a_runt_act(struct sk_buff *skb, const struct tc_action *a,
+			struct tcf_result *res)
+{
+	return 0;
+}
+
 static int p4a_parm_type_fill(struct sk_buff *skb, struct p4tc_act_param *param)
 {
 	unsigned char *b = nlmsg_get_pos(skb);
@@ -201,6 +1103,273 @@ static int p4a_parm_type_fill(struct sk_buff *skb, struct p4tc_act_param *param)
 	return -1;
 }
 
+static int p4a_runt_dump(struct sk_buff *skb, struct tc_action *a,
+			 int bind, int ref)
+{
+	struct tcf_p4act *dynact = to_p4act(a);
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct tc_act_p4 opt = {
+		.index = dynact->tcf_index,
+		.refcnt = refcount_read(&dynact->tcf_refcnt) - ref,
+		.bindcnt = atomic_read(&dynact->tcf_bindcnt) - bind,
+	};
+	struct tcf_p4act_params *params;
+	struct p4tc_act_param *parm;
+	struct nlattr *nest_parms;
+	struct p4tc_act *act;
+	struct net *net;
+	struct tcf_t t;
+	int i = 1;
+	int id;
+
+	spin_lock_bh(&dynact->tcf_lock);
+
+	net = a->idrinfo->net;
+	act = p4a_runt_find(net, a->ops, NULL);
+	if (!act)
+		goto nla_put_failure;
+
+	opt.action = dynact->tcf_action;
+	if (nla_put(skb, P4TC_ACT_OPT, sizeof(opt), &opt))
+		goto nla_put_failure;
+
+	if (nla_put_string(skb, P4TC_ACT_NAME, a->ops->kind))
+		goto nla_put_failure;
+
+	tcf_tm_dump(&t, &dynact->tcf_tm);
+	if (nla_put_64bit(skb, P4TC_ACT_TM, sizeof(t), &t, P4TC_ACT_PAD))
+		goto nla_put_failure;
+
+	nest_parms = nla_nest_start(skb, P4TC_ACT_PARMS);
+	if (!nest_parms)
+		goto nla_put_failure;
+
+	params = rcu_dereference_protected(dynact->params, 1);
+	if (params) {
+		idr_for_each_entry(&params->params_idr, parm, id) {
+			struct p4tc_act_param_ops *op;
+			struct nlattr *nest_count;
+			struct nlattr *nest_type;
+
+			nest_count = nla_nest_start(skb, i);
+			if (!nest_count)
+				goto nla_put_failure;
+
+			if (nla_put_string(skb, P4TC_ACT_PARAMS_NAME,
+					   parm->name))
+				goto nla_put_failure;
+
+			if (nla_put_u32(skb, P4TC_ACT_PARAMS_ID, parm->id))
+				goto nla_put_failure;
+
+			if (!p4a_param_has_runt_flag(parm)) {
+				op = (struct p4tc_act_param_ops *)
+					&param_ops[parm->type->typeid];
+				if (op->dump_value) {
+					if (op->dump_value(skb, op, parm) < 0)
+						goto nla_put_failure;
+				} else {
+					if (p4a_runt_parm_val_dump(skb,
+								   parm->type,
+								   parm))
+						goto nla_put_failure;
+				}
+			}
+
+			nest_type = nla_nest_start(skb, P4TC_ACT_PARAMS_TYPE);
+			if (!nest_type)
+				goto nla_put_failure;
+
+			p4a_parm_type_fill(skb, parm);
+			nla_nest_end(skb, nest_type);
+
+			if (nla_put_u8(skb, P4TC_ACT_PARAMS_FLAGS, parm->flags))
+				goto nla_put_failure;
+
+			nla_nest_end(skb, nest_count);
+			i++;
+		}
+	}
+	nla_nest_end(skb, nest_parms);
+
+	spin_unlock_bh(&dynact->tcf_lock);
+
+	return skb->len;
+
+nla_put_failure:
+	spin_unlock_bh(&dynact->tcf_lock);
+	nlmsg_trim(skb, b);
+	return -1;
+}
+
+static int p4a_runt_lookup(struct net *net,
+			   const struct tc_action_ops *ops,
+			   struct tc_action **a, u32 index)
+{
+	struct p4tc_act *act;
+	int err;
+
+	act = p4a_runt_find(net, ops, NULL);
+	if (IS_ERR(act))
+		return PTR_ERR(act);
+
+	err = tcf_idr_search(act->tn, a, index);
+	if (!err)
+		return err;
+
+	if ((*a)->tcfa_flags & TCA_ACT_FLAGS_UNREFERENCED)
+		return false;
+
+	return err;
+}
+
+static int p4a_runt_walker(struct net *net, struct sk_buff *skb,
+			   struct netlink_callback *cb, int type,
+			   const struct tc_action_ops *ops,
+			   struct netlink_ext_ack *extack)
+{
+	struct p4tc_act *act;
+
+	act = p4a_runt_find(net, ops, extack);
+	if (IS_ERR(act))
+		return PTR_ERR(act);
+
+	return tcf_generic_walker(act->tn, skb, cb, type, ops, extack);
+}
+
+static void p4a_runt_cleanup(struct tc_action *a)
+{
+	struct tc_action_ops *ops = (struct tc_action_ops *)a->ops;
+	struct tcf_p4act *m = to_p4act(a);
+	struct tcf_p4act_params *params;
+
+	params = rcu_dereference_protected(m->params, 1);
+
+	if (!(a->tcfa_flags & TCA_ACT_FLAGS_UNREFERENCED)) {
+		struct net *net = maybe_get_net(a->idrinfo->net);
+
+		/* If netns is going down, pipeline is being destroyed and all
+		 * objects beneath it (including actions) regardess of
+		 * num_insts's value, so there is no need to decrement it here.
+		 */
+		if (net) {
+			struct p4tc_act *act;
+
+			act = p4a_runt_find(a->idrinfo->net, ops, NULL);
+			atomic_dec(&act->num_insts);
+			put_net(net);
+		}
+	}
+
+	if (params)
+		call_rcu(&params->rcu, p4a_runt_parms_destroy_rcu);
+}
+
+static void p4a_runt_net_exit(struct tc_action_net *tn)
+{
+	tcf_idrinfo_destroy(tn->ops, tn->idrinfo);
+	kfree(tn->idrinfo);
+	kfree(tn);
+}
+
+static int p4a_runt_parm_list_init(struct p4tc_act *act,
+				   struct tcf_p4act_params *params,
+				   struct list_head *params_lst)
+{
+	struct p4tc_act_param *nparam, *tmp;
+	u32 tot_params_sz = 0;
+	int err;
+
+	list_for_each_entry_safe(nparam, tmp, params_lst, head) {
+		err = idr_alloc_u32(&params->params_idr, nparam, &nparam->id,
+				    nparam->id, GFP_KERNEL);
+		if (err < 0)
+			return err;
+		list_del(&nparam->head);
+		params->num_params++;
+		tot_params_sz += nparam->type->container_bitsz;
+	}
+	/* Sum act_id */
+	params->tot_params_sz = tot_params_sz + (sizeof(u32) << 3);
+
+	return 0;
+}
+
+/* This is the action instantiation that is invoked from the template code,
+ * specifically when initialising preallocated dynamic actions.
+ * This functions is analogous to p4a_runt_init.
+ */
+static int p4a_runt_init_from_tmpl(struct net *net, struct tc_action **a,
+				   struct p4tc_act *act,
+				   struct idr *params_idr,
+				   struct list_head *params_lst,
+				   struct tc_act_p4 *parm, u32 flags,
+				   struct netlink_ext_ack *extack)
+{
+	bool bind = flags & TCA_ACT_FLAGS_BIND;
+	struct tc_action_ops *a_o = &act->ops;
+	struct tcf_chain *goto_ch = NULL;
+	struct tcf_p4act_params *params;
+	struct tcf_p4act *prealloc_act;
+	bool exists = false;
+	int ret;
+	int err;
+
+	/* Don't need to check if action is active because we only call this
+	 * when we are on our way to activating the action.
+	 */
+	ret = __p4a_runt_init(net, NULL, act, parm, a, NULL, a_o, &goto_ch,
+			      flags, extack);
+	if (ret < 0)
+		return ret;
+
+	params = p4a_runt_parms_alloc(act);
+	if (IS_ERR(params)) {
+		err = PTR_ERR(params);
+		goto release_idr;
+	}
+
+	if (params_idr) {
+		err = p4a_runt_parm_list_init(act, params, params_lst);
+		if (err < 0)
+			goto release_params;
+	} else {
+		if (!idr_is_empty(&act->params_idr)) {
+			NL_SET_ERR_MSG(extack,
+				       "Must specify action parameters");
+			err = -EINVAL;
+			goto release_params;
+		}
+	}
+
+	exists = ret != P4TC_ACT_CREATED;
+	err = __p4a_runt_init_set(act, a, params, goto_ch, parm, exists,
+				  extack);
+	if (err < 0)
+		goto release_params;
+
+	return err;
+
+release_params:
+	p4a_runt_parms_destroy(params);
+
+release_idr:
+	if (ret == P4TC_ACT_PREALLOC) {
+		prealloc_act = to_p4act(*a);
+		p4a_runt_prealloc_put(act, prealloc_act);
+		(*a)->tcfa_flags |= TCA_ACT_FLAGS_UNREFERENCED;
+	} else if (!bind && !exists &&
+		   ((*a)->tcfa_flags & TCA_ACT_FLAGS_PREALLOC)) {
+		prealloc_act = to_p4act(*a);
+		list_del_init(&prealloc_act->node);
+		tcf_idr_release(*a, bind);
+	} else {
+		tcf_idr_release(*a, bind);
+	}
+
+	return err;
+}
+
 struct p4tc_act *p4a_tmpl_find_byid(struct p4tc_pipeline *pipeline,
 				    const u32 a_id)
 {
@@ -555,7 +1724,8 @@ static int __p4a_tmpl_put(struct net *net, struct p4tc_pipeline *pipeline,
 {
 	struct tcf_p4act *p4act, *tmp_act;
 
-	if (!teardown && refcount_read(&act->a_ref) > 1) {
+	if (!teardown && (atomic_read(&act->num_insts) > 0 ||
+			  refcount_read(&act->a_ref) > 1)) {
 		NL_SET_ERR_MSG(extack,
 			       "Unable to delete referenced action template");
 		return -EBUSY;
@@ -570,6 +1740,7 @@ static int __p4a_tmpl_put(struct net *net, struct p4tc_pipeline *pipeline,
 		if (p4act->common.tcfa_flags & TCA_ACT_FLAGS_UNREFERENCED)
 			tcf_idr_release(&p4act->common, true);
 	}
+	p4a_runt_net_exit(act->tn);
 
 	idr_remove(&pipeline->p_act_idr, act->a_id);
 
@@ -844,12 +2015,36 @@ p4a_tmpl_create(struct net *net, struct nlattr **tb,
 	if (!act)
 		return ERR_PTR(-ENOMEM);
 
+	strscpy(act->ops.kind, fullname, ACTNAMSIZ);
+	act->ops.owner = THIS_MODULE;
+	act->ops.act = p4a_runt_act;
+	act->ops.dump = p4a_runt_dump;
+	act->ops.cleanup = p4a_runt_cleanup;
+	act->ops.init_ops = p4a_runt_init;
+	act->ops.lookup = p4a_runt_lookup;
+	act->ops.walk = p4a_runt_walker;
+	act->ops.size = sizeof(struct tcf_p4act);
+	INIT_LIST_HEAD(&act->head);
+
+	act->tn = kzalloc(sizeof(*act->tn), GFP_KERNEL);
+	if (!act->tn) {
+		ret = -ENOMEM;
+		goto free_act_ops;
+	}
+
+	ret = tc_action_net_init(net, act->tn, &act->ops);
+	if (ret < 0) {
+		kfree(act->tn);
+		goto free_act_ops;
+	}
+	act->tn->ops = &act->ops;
+
 	if (a_id) {
 		ret = idr_alloc_u32(&pipeline->p_act_idr, act, &a_id, a_id,
 				    GFP_KERNEL);
 		if (ret < 0) {
 			NL_SET_ERR_MSG(extack, "Unable to alloc action id");
-			goto free_act;
+			goto free_action_net;
 		}
 
 		act->a_id = a_id;
@@ -860,7 +2055,7 @@ p4a_tmpl_create(struct net *net, struct nlattr **tb,
 				    UINT_MAX, GFP_KERNEL);
 		if (ret < 0) {
 			NL_SET_ERR_MSG(extack, "Unable to alloc action id");
-			goto free_act;
+			goto free_action_net;
 		}
 	}
 
@@ -872,10 +2067,18 @@ p4a_tmpl_create(struct net *net, struct nlattr **tb,
 	else
 		act->num_prealloc_acts = P4TC_DEFAULT_NUM_PREALLOC;
 
+	atomic_set(&act->num_insts, 0);
+	ret = tcf_register_p4_action(net, &act->ops);
+	if (ret < 0) {
+		NL_SET_ERR_MSG(extack,
+			       "Unable to register new action template");
+		goto idr_rm;
+	}
+
 	num_params = p4a_tmpl_init(act, tb[P4TC_ACT_PARMS], extack);
 	if (num_params < 0) {
 		ret = num_params;
-		goto idr_rm;
+		goto unregister;
 	}
 	act->num_params = num_params;
 
@@ -894,15 +2097,22 @@ p4a_tmpl_create(struct net *net, struct nlattr **tb,
 
 	refcount_set(&act->a_ref, 1);
 
+	list_add_tail(&act->head, &dynact_list);
 	INIT_LIST_HEAD(&act->prealloc_list);
 	spin_lock_init(&act->list_lock);
 
 	return act;
 
+unregister:
+	tcf_unregister_p4_action(net, &act->ops);
+
 idr_rm:
 	idr_remove(&pipeline->p_act_idr, act->a_id);
 
-free_act:
+free_action_net:
+	p4a_runt_net_exit(act->tn);
+
+free_act_ops:
 	kfree(act);
 
 	return ERR_PTR(ret);
@@ -914,6 +2124,7 @@ p4a_tmpl_update(struct net *net, struct nlattr **tb,
 		u32 flags, struct netlink_ext_ack *extack)
 {
 	const u32 a_id = ids[P4TC_AID_IDX];
+	struct tc_action **prealloc_acts;
 	bool updates_params = false;
 	struct idr params_idr;
 	u32 num_prealloc_acts;
@@ -932,6 +2143,11 @@ p4a_tmpl_update(struct net *net, struct nlattr **tb,
 
 	if (act->active) {
 		if (!active) {
+			if (atomic_read(&act->num_insts) > 0) {
+				NL_SET_ERR_MSG(extack,
+					       "Unable to inactivate action with instances");
+				return ERR_PTR(-EINVAL);
+			}
 			act->active = false;
 			return act;
 		}
@@ -960,6 +2176,30 @@ p4a_tmpl_update(struct net *net, struct nlattr **tb,
 
 	act->pipeline = pipeline;
 	if (active == 1) {
+		struct idr *chosen_idr = updates_params ?
+			&params_idr : &act->params_idr;
+
+		prealloc_acts = kcalloc(num_prealloc_acts,
+					sizeof(*prealloc_acts),
+					GFP_KERNEL);
+		if (!prealloc_acts) {
+			ret = -ENOMEM;
+			goto params_del;
+		}
+
+		ret = p4a_runt_prealloc_create(pipeline->net, act,
+					       chosen_idr,
+					       prealloc_acts,
+					       num_prealloc_acts,
+					       extack);
+		if (ret < 0)
+			goto free_prealloc_acts;
+
+		p4a_runt_prealloc_list_add(act, prealloc_acts,
+					   num_prealloc_acts);
+
+		kfree(prealloc_acts);
+
 		act->active = true;
 	} else if (!active) {
 		NL_SET_ERR_MSG(extack, "Action is already inactive");
@@ -976,6 +2216,9 @@ p4a_tmpl_update(struct net *net, struct nlattr **tb,
 
 	return act;
 
+free_prealloc_acts:
+	kfree(prealloc_acts);
+
 params_del:
 	p4a_tmpl_parms_put_many(&params_idr);
 
-- 
2.34.1



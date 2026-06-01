Return-Path: <netdev+bounces-293619-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4A3LKHNPHWoDYwkAu9opvQ
	(envelope-from <netdev+bounces-293619-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:22:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 543DF61C57A
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C6B53026077
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 08:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85262363C6A;
	Mon,  1 Jun 2026 08:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="1ojO7qI7"
X-Original-To: netdev@vger.kernel.org
Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534BB364053
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780303839; cv=none; b=Je6ADElYcpnNH1+/+pF8s5JTBgBxizOAAGwUwiHopOG2OXGvaYWM/x9xd6AwqOnr8gAnFbD5LRtpTEp/KWDKPHnmuHGad2EIwwJ4N7MhjSIVYix+FwU7UGkeq3JMsufZIio2IPnVbBdwHuNooAZ/lMbmjipJzGy7mr6GUsgFoDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780303839; c=relaxed/simple;
	bh=fZ3aP/MHWRIBfYLMIiK9ohcj4kHPDIambVX8WyEZ74o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KuqP6dNSKHs1V+TFPRdyp4hrAde/MB5S1d9fxZ/9UBGWJ0r/FI0Bfvztt4jfT9sx8hlIa1Lx7nB6sB5lNNO/2ztWMzr6ab5AeWEmcw9WBlfgHcL2LHHypYpx7/4pjcGMRfLCvUrYe45dE46eZGZiV6P+efJTQFww55Y29l7pOs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=1ojO7qI7; arc=none smtp.client-ip=120.232.169.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=1ojO7qI7TWohfvq2ra0BKJgn6K9u5aqEZb/HQk4kHXM1zgtOz1kjEP2za6MuWzUQVjm9c1sl2Q3HH
	 wIKr/MnSAPoPQGg4XNMhNxCF4BsG0Uptn5DVuYPLRneR6R6KZVFyeEnOjhsd4Pwb9qsyb952OAzN8G
	 Jlih5kD5PgZRz7tY=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[60.247.85.88])
	by rmsmtp-lg-appmail-06-12084 (RichMail) with SMTP id 2f346a1d47cb0b8-010cd;
	Mon, 01 Jun 2026 16:50:21 +0800 (CST)
X-RM-TRANSID:2f346a1d47cb0b8-010cd
From: Li hongliang <1468888505@139.com>
To: p@1g4.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	kuba@kernel.org,
	Po.Liu@nxp.com,
	netdev@vger.kernel.org,
	vladimir.oltean@nxp.com,
	victor@mojatatu.com
Subject: [PATCH 5.15.y] net/sched: act_gate: snapshot parameters with RCU on replace
Date: Mon,  1 Jun 2026 16:50:20 +0800
Message-Id: <20260601085020.769479-1-1468888505@139.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [7.34 / 15.00];
	SEM_URIBL(3.50)[139.com:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[139.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	TAGGED_FROM(0.00)[bounces-293619-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,kernel.org,nxp.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[139.com];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[1468888505@139.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_SPF_ALLOW(0.00)[+ip4:104.64.211.4:c];
	NEURAL_SPAM(0.00)[0.583];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,139.com:mid,139.com:email,msgid.link:url,mojatatu.com:email,1g4.org:email]
X-Rspamd-Queue-Id: 543DF61C57A
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

From: Paul Moses <p@1g4.org>

[ Upstream commit 62413a9c3cb183afb9bb6e94dd68caf4e4145f4c ]

The gate action can be replaced while the hrtimer callback or dump path is
walking the schedule list.

Convert the parameters to an RCU-protected snapshot and swap updates under
tcf_lock, freeing the previous snapshot via call_rcu(). When REPLACE omits
the entry list, preserve the existing schedule so the effective state is
unchanged.

Fixes: a51c328df310 ("net: qos: introduce a gate control flow action")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Moses <p@1g4.org>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Link: https://patch.msgid.link/20260223150512.2251594-2-p@1g4.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Li hongliang <1468888505@139.com>
---
 include/net/tc_act/tc_gate.h |  33 ++++-
 net/sched/act_gate.c         | 262 ++++++++++++++++++++++++-----------
 2 files changed, 210 insertions(+), 85 deletions(-)

diff --git a/include/net/tc_act/tc_gate.h b/include/net/tc_act/tc_gate.h
index 8bc6be81a7ad..d9f91ec43a96 100644
--- a/include/net/tc_act/tc_gate.h
+++ b/include/net/tc_act/tc_gate.h
@@ -32,6 +32,7 @@ struct tcf_gate_params {
 	s32			tcfg_clockid;
 	size_t			num_entries;
 	struct list_head	entries;
+	struct rcu_head		rcu;
 };
 
 #define GATE_ACT_GATE_OPEN	BIT(0)
@@ -39,7 +40,7 @@ struct tcf_gate_params {
 
 struct tcf_gate {
 	struct tc_action	common;
-	struct tcf_gate_params	param;
+	struct tcf_gate_params __rcu *param;
 	u8			current_gate_status;
 	ktime_t			current_close_time;
 	u32			current_entry_octets;
@@ -65,47 +66,65 @@ static inline u32 tcf_gate_index(const struct tc_action *a)
 	return a->tcfa_index;
 }
 
+static inline struct tcf_gate_params *tcf_gate_params_locked(const struct tc_action *a)
+{
+	struct tcf_gate *gact = to_gate(a);
+
+	return rcu_dereference_protected(gact->param,
+					 lockdep_is_held(&gact->tcf_lock));
+}
+
 static inline s32 tcf_gate_prio(const struct tc_action *a)
 {
+	struct tcf_gate_params *p;
 	s32 tcfg_prio;
 
-	tcfg_prio = to_gate(a)->param.tcfg_priority;
+	p = tcf_gate_params_locked(a);
+	tcfg_prio = p->tcfg_priority;
 
 	return tcfg_prio;
 }
 
 static inline u64 tcf_gate_basetime(const struct tc_action *a)
 {
+	struct tcf_gate_params *p;
 	u64 tcfg_basetime;
 
-	tcfg_basetime = to_gate(a)->param.tcfg_basetime;
+	p = tcf_gate_params_locked(a);
+	tcfg_basetime = p->tcfg_basetime;
 
 	return tcfg_basetime;
 }
 
 static inline u64 tcf_gate_cycletime(const struct tc_action *a)
 {
+	struct tcf_gate_params *p;
 	u64 tcfg_cycletime;
 
-	tcfg_cycletime = to_gate(a)->param.tcfg_cycletime;
+	p = tcf_gate_params_locked(a);
+	tcfg_cycletime = p->tcfg_cycletime;
 
 	return tcfg_cycletime;
 }
 
 static inline u64 tcf_gate_cycletimeext(const struct tc_action *a)
 {
+	struct tcf_gate_params *p;
 	u64 tcfg_cycletimeext;
 
-	tcfg_cycletimeext = to_gate(a)->param.tcfg_cycletime_ext;
+	p = tcf_gate_params_locked(a);
+	tcfg_cycletimeext = p->tcfg_cycletime_ext;
 
 	return tcfg_cycletimeext;
 }
 
 static inline u32 tcf_gate_num_entries(const struct tc_action *a)
 {
+	struct tcf_gate_params *p;
 	u32 num_entries;
 
-	num_entries = to_gate(a)->param.num_entries;
+	p = tcf_gate_params_locked(a);
+	num_entries = p->num_entries;
 
 	return num_entries;
 }
@@ -119,7 +138,7 @@ static inline struct action_gate_entry
 	u32 num_entries;
 	int i = 0;
 
-	p = &to_gate(a)->param;
+	p = tcf_gate_params_locked(a);
 	num_entries = p->num_entries;
 
 	list_for_each_entry(entry, &p->entries, list)
diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index 12b8fdbd9df1..4400e45b6bfe 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -31,9 +31,12 @@ static ktime_t gate_get_time(struct tcf_gate *gact)
 	return KTIME_MAX;
 }
 
-static void gate_get_start_time(struct tcf_gate *gact, ktime_t *start)
+static void tcf_gate_params_free_rcu(struct rcu_head *head);
+
+static void gate_get_start_time(struct tcf_gate *gact,
+				const struct tcf_gate_params *param,
+				ktime_t *start)
 {
-	struct tcf_gate_params *param = &gact->param;
 	ktime_t now, base, cycle;
 	u64 n;
 
@@ -68,12 +71,14 @@ static enum hrtimer_restart gate_timer_func(struct hrtimer *timer)
 {
 	struct tcf_gate *gact = container_of(timer, struct tcf_gate,
 					     hitimer);
-	struct tcf_gate_params *p = &gact->param;
 	struct tcfg_gate_entry *next;
+	struct tcf_gate_params *p;
 	ktime_t close_time, now;
 
 	spin_lock(&gact->tcf_lock);
 
+	p = rcu_dereference_protected(gact->param,
+				      lockdep_is_held(&gact->tcf_lock));
 	next = gact->next_entry;
 
 	/* cycle start, clear pending bit, clear total octets */
@@ -226,6 +231,35 @@ static void release_entry_list(struct list_head *entries)
 	}
 }
 
+static int tcf_gate_copy_entries(struct tcf_gate_params *dst,
+				 const struct tcf_gate_params *src,
+				 struct netlink_ext_ack *extack)
+{
+	struct tcfg_gate_entry *entry;
+	int i = 0;
+
+	list_for_each_entry(entry, &src->entries, list) {
+		struct tcfg_gate_entry *new;
+
+		new = kzalloc(sizeof(*new), GFP_ATOMIC);
+		if (!new) {
+			NL_SET_ERR_MSG(extack, "Not enough memory for entry");
+			return -ENOMEM;
+		}
+
+		new->index      = entry->index;
+		new->gate_state = entry->gate_state;
+		new->interval   = entry->interval;
+		new->ipv        = entry->ipv;
+		new->maxoctets  = entry->maxoctets;
+		list_add_tail(&new->list, &dst->entries);
+		i++;
+	}
+
+	dst->num_entries = i;
+	return 0;
+}
+
 static int parse_gate_list(struct nlattr *list_attr,
 			   struct tcf_gate_params *sched,
 			   struct netlink_ext_ack *extack)
@@ -271,23 +305,42 @@ static int parse_gate_list(struct nlattr *list_attr,
 	return err;
 }
 
-static void gate_setup_timer(struct tcf_gate *gact, u64 basetime,
-			     enum tk_offsets tko, s32 clockid,
-			     bool do_init)
+static bool gate_timer_needs_cancel(u64 basetime, u64 old_basetime,
+				    enum tk_offsets tko,
+				    enum tk_offsets old_tko,
+				    s32 clockid, s32 old_clockid)
 {
-	if (!do_init) {
-		if (basetime == gact->param.tcfg_basetime &&
-		    tko == gact->tk_offset &&
-		    clockid == gact->param.tcfg_clockid)
-			return;
+	return basetime != old_basetime ||
+	       clockid != old_clockid ||
+	       tko != old_tko;
+}
 
-		spin_unlock_bh(&gact->tcf_lock);
-		hrtimer_cancel(&gact->hitimer);
-		spin_lock_bh(&gact->tcf_lock);
+static int gate_clock_resolve(s32 clockid, enum tk_offsets *tko,
+			      struct netlink_ext_ack *extack)
+{
+	switch (clockid) {
+	case CLOCK_REALTIME:
+		*tko = TK_OFFS_REAL;
+		return 0;
+	case CLOCK_MONOTONIC:
+		*tko = TK_OFFS_MAX;
+		return 0;
+	case CLOCK_BOOTTIME:
+		*tko = TK_OFFS_BOOT;
+		return 0;
+	case CLOCK_TAI:
+		*tko = TK_OFFS_TAI;
+		return 0;
+	default:
+		NL_SET_ERR_MSG(extack, "Invalid 'clockid'");
+		return -EINVAL;
 	}
-	gact->param.tcfg_basetime = basetime;
-	gact->param.tcfg_clockid = clockid;
-	gact->tk_offset = tko;
+}
+
+static void gate_setup_timer(struct tcf_gate *gact, s32 clockid,
+			     enum tk_offsets tko)
+{
+	WRITE_ONCE(gact->tk_offset, tko);
 	hrtimer_init(&gact->hitimer, clockid, HRTIMER_MODE_ABS_SOFT);
 	gact->hitimer.function = gate_timer_func;
 }
@@ -298,15 +351,22 @@ static int tcf_gate_init(struct net *net, struct nlattr *nla,
 			 struct netlink_ext_ack *extack)
 {
 	struct tc_action_net *tn = net_generic(net, act_gate_ops.net_id);
-	enum tk_offsets tk_offset = TK_OFFS_TAI;
+	u64 cycletime = 0, basetime = 0, cycletime_ext = 0;
+	struct tcf_gate_params *p = NULL, *old_p = NULL;
+	enum tk_offsets old_tk_offset = TK_OFFS_TAI;
+	const struct tcf_gate_params *cur_p = NULL;
 	bool bind = flags & TCA_ACT_FLAGS_BIND;
 	struct nlattr *tb[TCA_GATE_MAX + 1];
+	enum tk_offsets tko = TK_OFFS_TAI;
 	struct tcf_chain *goto_ch = NULL;
-	u64 cycletime = 0, basetime = 0;
-	struct tcf_gate_params *p;
+	s32 timer_clockid = CLOCK_TAI;
+	bool use_old_entries = false;
+	s32 old_clockid = CLOCK_TAI;
+	bool need_cancel = false;
 	s32 clockid = CLOCK_TAI;
 	struct tcf_gate *gact;
 	struct tc_gate *parm;
+	u64 old_basetime = 0;
 	int ret = 0, err;
 	u32 gflags = 0;
 	s32 prio = -1;
@@ -323,26 +383,8 @@ static int tcf_gate_init(struct net *net, struct nlattr *nla,
 	if (!tb[TCA_GATE_PARMS])
 		return -EINVAL;
 
-	if (tb[TCA_GATE_CLOCKID]) {
+	if (tb[TCA_GATE_CLOCKID])
 		clockid = nla_get_s32(tb[TCA_GATE_CLOCKID]);
-		switch (clockid) {
-		case CLOCK_REALTIME:
-			tk_offset = TK_OFFS_REAL;
-			break;
-		case CLOCK_MONOTONIC:
-			tk_offset = TK_OFFS_MAX;
-			break;
-		case CLOCK_BOOTTIME:
-			tk_offset = TK_OFFS_BOOT;
-			break;
-		case CLOCK_TAI:
-			tk_offset = TK_OFFS_TAI;
-			break;
-		default:
-			NL_SET_ERR_MSG(extack, "Invalid 'clockid'");
-			return -EINVAL;
-		}
-	}
 
 	parm = nla_data(tb[TCA_GATE_PARMS]);
 	index = parm->index;
@@ -368,6 +410,60 @@ static int tcf_gate_init(struct net *net, struct nlattr *nla,
 		return -EEXIST;
 	}
 
+	gact = to_gate(*a);
+
+	err = tcf_action_check_ctrlact(parm->action, tp, &goto_ch, extack);
+	if (err < 0)
+		goto release_idr;
+
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	if (!p) {
+		err = -ENOMEM;
+		goto chain_put;
+	}
+	INIT_LIST_HEAD(&p->entries);
+
+	use_old_entries = !tb[TCA_GATE_ENTRY_LIST];
+	if (!use_old_entries) {
+		err = parse_gate_list(tb[TCA_GATE_ENTRY_LIST], p, extack);
+		if (err < 0)
+			goto err_free;
+		use_old_entries = !err;
+	}
+
+	if (ret == ACT_P_CREATED && use_old_entries) {
+		NL_SET_ERR_MSG(extack, "The entry list is empty");
+		err = -EINVAL;
+		goto err_free;
+	}
+
+	if (ret != ACT_P_CREATED) {
+		rcu_read_lock();
+		cur_p = rcu_dereference(gact->param);
+
+		old_basetime  = cur_p->tcfg_basetime;
+		old_clockid   = cur_p->tcfg_clockid;
+		old_tk_offset = READ_ONCE(gact->tk_offset);
+
+		basetime      = old_basetime;
+		cycletime_ext = cur_p->tcfg_cycletime_ext;
+		prio          = cur_p->tcfg_priority;
+		gflags        = cur_p->tcfg_flags;
+
+		if (!tb[TCA_GATE_CLOCKID])
+			clockid = old_clockid;
+
+		err = 0;
+		if (use_old_entries) {
+			err = tcf_gate_copy_entries(p, cur_p, extack);
+			if (!err && !tb[TCA_GATE_CYCLE_TIME])
+				cycletime = cur_p->tcfg_cycletime;
+		}
+		rcu_read_unlock();
+		if (err)
+			goto err_free;
+	}
+
 	if (tb[TCA_GATE_PRIORITY])
 		prio = nla_get_s32(tb[TCA_GATE_PRIORITY]);
 
@@ -377,25 +473,26 @@ static int tcf_gate_init(struct net *net, struct nlattr *nla,
 	if (tb[TCA_GATE_FLAGS])
 		gflags = nla_get_u32(tb[TCA_GATE_FLAGS]);
 
-	gact = to_gate(*a);
-	if (ret == ACT_P_CREATED)
-		INIT_LIST_HEAD(&gact->param.entries);
+	if (tb[TCA_GATE_CYCLE_TIME])
+		cycletime = nla_get_u64(tb[TCA_GATE_CYCLE_TIME]);
 
-	err = tcf_action_check_ctrlact(parm->action, tp, &goto_ch, extack);
-	if (err < 0)
-		goto release_idr;
+	if (tb[TCA_GATE_CYCLE_TIME_EXT])
+		cycletime_ext = nla_get_u64(tb[TCA_GATE_CYCLE_TIME_EXT]);
 
-	spin_lock_bh(&gact->tcf_lock);
-	p = &gact->param;
+	err = gate_clock_resolve(clockid, &tko, extack);
+	if (err)
+		goto err_free;
+	timer_clockid = clockid;
 
-	if (tb[TCA_GATE_CYCLE_TIME])
-		cycletime = nla_get_u64(tb[TCA_GATE_CYCLE_TIME]);
+	need_cancel = ret != ACT_P_CREATED &&
+		      gate_timer_needs_cancel(basetime, old_basetime,
+					      tko, old_tk_offset,
+					      timer_clockid, old_clockid);
 
-	if (tb[TCA_GATE_ENTRY_LIST]) {
-		err = parse_gate_list(tb[TCA_GATE_ENTRY_LIST], p, extack);
-		if (err < 0)
-			goto chain_put;
-	}
+	if (need_cancel)
+		hrtimer_cancel(&gact->hitimer);
+
+	spin_lock_bh(&gact->tcf_lock);
 
 	if (!cycletime) {
 		struct tcfg_gate_entry *entry;
@@ -404,22 +501,20 @@ static int tcf_gate_init(struct net *net, struct nlattr *nla,
 		list_for_each_entry(entry, &p->entries, list)
 			cycle = ktime_add_ns(cycle, entry->interval);
 		cycletime = cycle;
-		if (!cycletime) {
-			err = -EINVAL;
-			goto chain_put;
-		}
 	}
 	p->tcfg_cycletime = cycletime;
+	p->tcfg_cycletime_ext = cycletime_ext;
 
-	if (tb[TCA_GATE_CYCLE_TIME_EXT])
-		p->tcfg_cycletime_ext =
-			nla_get_u64(tb[TCA_GATE_CYCLE_TIME_EXT]);
-
-	gate_setup_timer(gact, basetime, tk_offset, clockid,
-			 ret == ACT_P_CREATED);
+	if (need_cancel || ret == ACT_P_CREATED)
+		gate_setup_timer(gact, timer_clockid, tko);
 	p->tcfg_priority = prio;
 	p->tcfg_flags = gflags;
-	gate_get_start_time(gact, &start);
+	p->tcfg_basetime = basetime;
+	p->tcfg_clockid = timer_clockid;
+	gate_get_start_time(gact, p, &start);
+
+	old_p = rcu_replace_pointer(gact->param, p,
+				    lockdep_is_held(&gact->tcf_lock));
 
 	gact->current_close_time = start;
 	gact->current_gate_status = GATE_ACT_GATE_OPEN | GATE_ACT_PENDING;
@@ -436,11 +531,15 @@ static int tcf_gate_init(struct net *net, struct nlattr *nla,
 	if (goto_ch)
 		tcf_chain_put_by_act(goto_ch);
 
+	if (old_p)
+		call_rcu(&old_p->rcu, tcf_gate_params_free_rcu);
+
 	return ret;
 
+err_free:
+	release_entry_list(&p->entries);
+	kfree(p);
 chain_put:
-	spin_unlock_bh(&gact->tcf_lock);
-
 	if (goto_ch)
 		tcf_chain_put_by_act(goto_ch);
 release_idr:
@@ -448,21 +547,29 @@ static int tcf_gate_init(struct net *net, struct nlattr *nla,
 	 * without taking tcf_lock.
 	 */
 	if (ret == ACT_P_CREATED)
-		gate_setup_timer(gact, gact->param.tcfg_basetime,
-				 gact->tk_offset, gact->param.tcfg_clockid,
-				 true);
+		gate_setup_timer(gact, timer_clockid, tko);
+
 	tcf_idr_release(*a, bind);
 	return err;
 }
 
+static void tcf_gate_params_free_rcu(struct rcu_head *head)
+{
+	struct tcf_gate_params *p = container_of(head, struct tcf_gate_params, rcu);
+
+	release_entry_list(&p->entries);
+	kfree(p);
+}
+
 static void tcf_gate_cleanup(struct tc_action *a)
 {
 	struct tcf_gate *gact = to_gate(a);
 	struct tcf_gate_params *p;
 
-	p = &gact->param;
 	hrtimer_cancel(&gact->hitimer);
-	release_entry_list(&p->entries);
+	p = rcu_dereference_protected(gact->param, 1);
+	if (p)
+		call_rcu(&p->rcu, tcf_gate_params_free_rcu);
 }
 
 static int dumping_entry(struct sk_buff *skb,
@@ -511,10 +618,9 @@ static int tcf_gate_dump(struct sk_buff *skb, struct tc_action *a,
 	struct nlattr *entry_list;
 	struct tcf_t t;
 
-	spin_lock_bh(&gact->tcf_lock);
-	opt.action = gact->tcf_action;
-
-	p = &gact->param;
+	rcu_read_lock();
+	opt.action = READ_ONCE(gact->tcf_action);
+	p = rcu_dereference(gact->param);
 
 	if (nla_put(skb, TCA_GATE_PARMS, sizeof(opt), &opt))
 		goto nla_put_failure;
@@ -554,12 +660,12 @@ static int tcf_gate_dump(struct sk_buff *skb, struct tc_action *a,
 	tcf_tm_dump(&t, &gact->tcf_tm);
 	if (nla_put_64bit(skb, TCA_GATE_TM, sizeof(t), &t, TCA_GATE_PAD))
 		goto nla_put_failure;
-	spin_unlock_bh(&gact->tcf_lock);
+	rcu_read_unlock();
 
 	return skb->len;
 
 nla_put_failure:
-	spin_unlock_bh(&gact->tcf_lock);
+	rcu_read_unlock();
 	nlmsg_trim(skb, b);
 	return -1;
 }
-- 
2.34.1




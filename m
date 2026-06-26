Return-Path: <netdev+bounces-302239-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hSomD02uPmqvKAkAu9opvQ
	(envelope-from <netdev+bounces-302239-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 18:52:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CF87E6CF45E
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 18:52:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=WI8d4PXK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302239-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302239-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A52563009092
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 16:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8971A3FD960;
	Fri, 26 Jun 2026 16:52:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A1D3FF1B8
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 16:52:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782492731; cv=none; b=LOa1qADBUeokaW+Q/VAqko0FdF87WhJSc9TAfGjcDQtZopew7pekx+F61CrFj5yfE7pmCzspiRykvi1eRkIVLhvxLGUrrButooUkI5Zm5YxdriizIsvm8jTmxKoCXUt1JF5o5/OP6sLMubR5hshbmfTKXPzWtNzUM+0SxmI1Z6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782492731; c=relaxed/simple;
	bh=I0iV0OGwdQqpZTsd2iMX3d2K3JGGyPqRJT8cKkMEFvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GojF5T3y/UxrwQLrjhWrLlYScuK8wZglB6+GrRyBIYC9DyqpKnxIa4LEhHIT00AttN1U3O8yXEj+sdbUxPuv/enoKQHTaCpehswlMnJEz7iCMVSo+I5z3j/WanEiUpN8N8KAls7f6a3IS8Ay8BlkU8jHLluGWuknjPe0Urmmmcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=WI8d4PXK; arc=none smtp.client-ip=209.85.222.174
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92213351918so151767685a.0
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 09:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782492728; x=1783097528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUkJL98wPtVRt0Al3u2IlJCXBNc/ZJ9Hpflou6qG0VE=;
        b=WI8d4PXK7PmLiXfyOa9NAGfO+Cpr/8NhHQOIpMxiFY4nHsp3B7wqDYiU4SB8+mbhz7
         u9nZWMUzFwHYn0Yx7AiX14ltXK7PXkZu8TpcObzsMdUH5VTqDc/ehJ+LBkQBvyZMdEL+
         YZb4CJ4QKA+hnsf9tic6c8E7dxI4eGly5bHVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782492728; x=1783097528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DUkJL98wPtVRt0Al3u2IlJCXBNc/ZJ9Hpflou6qG0VE=;
        b=kNODfpp9vKZgfCo7Ne5XZQFoFOK5EU5bwwuonxbx+2IptjBIglBgEmn6tDyiPxNgRe
         92TWah0p8u7QOBXM/8ux4NlTq/PiNGxpW7/nA7/14KZ2BELwl5l1OJwN6/x/6hqRqVTf
         d5q+4UDc+BUDRZcxu8/5gqg/SccRNHP/2+Yu0EoEAMJ+n5aNIYRwTE8ugXhksrhwnREB
         84hr3XQrGrqmcJrZhCCx2G9l1CnuMWRC2I4Pw/ibOio1AWi/FooneITmrR1Dw2D4A4WF
         TReVgG1Zpu5uMvCJ0sznsgWtusjdcupASoIkLCqVSEeV5WlmiynwfqRhlnK5sJCzio3F
         wvHg==
X-Gm-Message-State: AOJu0YwVi+UpsYjr87irNQYhHF3HtFQYLi0Gg0xNgASaTYSbXRHtEN1a
	mJ8/fC6iJBXtwfExYiCo9XsNwFRXV7NlMpM4tSiACTtQrfhaXnaEHXwILH/w/fxbm7A2KiyYgot
	ksDrADQ==
X-Gm-Gg: AfdE7cnVFrOBeCfJY9zf3L2GX//cz3aqYJIuXWNXD+Hhuc12ITfoQcbXbXrLJuEfOX9
	MWOxuoCIUo034W7GBELjXuk93IzrY4ghzrfTTadxiXCTZOskTT13Fjx5xe6MHGNUGeMfvrFSppw
	duLj+c0Rv50qBxr3DgtSUwSWkuNbQSNVJKKO2/wDNofyYHFKSeCIJmpq5SGo1gDpLI8VDDsm0NI
	9/YUowcyl7I1Gr8rf68Dz+3vZMx7purs+elHkj/q9rDJK+eZQUuFozp63jYFuBGmgozsmYjwNKT
	41C7jv5XGGUe2hNAuLy8JDRdjM7/t3OIBfKlTbUEKvsRaJWkeDzFrVMYMP8SFtYwli+3o8g3nR6
	1xTRpGbfnvzLROIWJwifyhvZd9xJ2RSwtxtaa2nCNtgUckmnbFThYKhZugjLPYf/GbMEmaGfqIp
	DneG5x7A==
X-Received: by 2002:a05:620a:44d4:b0:925:eb05:d194 with SMTP id af79cd13be357-9293d4b2daamr1161768385a.57.1782492727391;
        Fri, 26 Jun 2026 09:52:07 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926004abe29sm1216957385a.33.2026.06.26.09.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 09:52:06 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	toke@toke.dk,
	jiri@resnulli.us,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	kuniyu@google.com,
	sdf.kernel@gmail.com,
	skhawaja@google.com,
	liuhangbin@gmail.com,
	krikku@gmail.com,
	mkarsten@uwaterloo.ca,
	victor@mojatatu.com,
	ast@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	daniel@iogearbox.net,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net 2/3] net/sched: Handle TC_ACT_REDIRECT from qdisc filter chains
Date: Fri, 26 Jun 2026 12:51:55 -0400
Message-Id: <20260626165156.169012-3-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260626165156.169012-1-jhs@mojatatu.com>
References: <20260626165156.169012-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302239-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:toke@toke.dk,m:jiri@resnulli.us,m:bigeasy@linutronix.de,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:kuniyu@google.com,m:sdf.kernel@gmail.com,m:skhawaja@google.com,m:liuhangbin@gmail.com,m:krikku@gmail.com,m:mkarsten@uwaterloo.ca,m:victor@mojatatu.com,m:ast@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:daniel@iogearbox.net,m:jhs@mojatatu.com,m:sdfkernel@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[mojatatu.com];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,toke.dk,resnulli.us,linutronix.de,goodmis.org,gmail.com,uwaterloo.ca,mojatatu.com,iogearbox.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mojatatu.com:dkim,mojatatu.com:email,mojatatu.com:mid,mojatatu.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF87E6CF45E

When a TC filter attached to a qdisc filter chain returns
TC_ACT_REDIRECT (ex: via an eBPF program calling bpf_redirect() or an
act_bpf action), the redirect was silently lost i.e no qdisc classify
function handled TC_ACT_REDIRECT, so the packet fell through the
switch and was enqueued normally instead of being redirected.

This has been broken since bpf_redirect() was introduced for TC in
commit 27b29f63058d ("bpf: add bpf_redirect() helper"). We got lucky
for a long time because bpf_net_context was a per-CPU variable that
was always available.
commit 401cb7dae813 ("net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.")
turned bpf_net_context into a task_struct member that is only set up by
explicit callers. Without a caller setting it up, bpf_redirect() itself
crashes with a NULL pointer dereference in bpf_net_ctx_get_ri().

The NULL deref is fixed separately by extending the bpf_net_context
lifetime to cover qdisc enqueue. However, even with bpf_net_context
available, TC_ACT_REDIRECT from qdisc filter chains cannot be honored
without adding skb_do_redirect() calls to every qdisc classify
function, which would require changes across net/sched/.

Instead, add a tcf_classify_qdisc() inline helper in pkt_cls.h, as a
wrapper around tcf_classify() for use by qdisc classify functions and
tcf_qevent_handle(). When the classify verdict is TC_ACT_REDIRECT,
the wrapper converts it to TC_ACT_SHOT, dropping the packet rather
than letting it continue silently.  Dropping is preferred over
letting the packet through because the user immediately sees packet
loss and, with the help of the rate-limited warning in the log
("use eBPF with clsact or mirred redirect instead"), can quickly
identify and fix the misconfiguration. Silently passing the packet
through would hide the problem and leave the user wondering why their
redirect is not working.

The clsact fast path, tc_run() continues to call tcf_classify() directly
and is unaffected: TC_ACT_REDIRECT is returned as-is and handled by
sch_handle_egress/ingress() calling skb_do_redirect() as before.

Remove the TC_ACT_REDIRECT case from tcf_qevent_handle() since
tcf_classify_qdisc() now converts it to TC_ACT_SHOT, and the existing
SHOT case handles it.

Fixes: 27b29f63058d ("bpf: add bpf_redirect() helper")
Fixes: 401cb7dae813 ("net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.")
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/pkt_cls.h    | 13 +++++++++++++
 net/sched/cls_api.c      |  6 +-----
 net/sched/sch_cake.c     |  2 +-
 net/sched/sch_drr.c      |  2 +-
 net/sched/sch_dualpi2.c  |  2 +-
 net/sched/sch_ets.c      |  2 +-
 net/sched/sch_fq_codel.c |  2 +-
 net/sched/sch_fq_pie.c   |  2 +-
 net/sched/sch_hfsc.c     |  2 +-
 net/sched/sch_htb.c      |  2 +-
 net/sched/sch_multiq.c   |  2 +-
 net/sched/sch_prio.c     |  2 +-
 net/sched/sch_qfq.c      |  2 +-
 net/sched/sch_sfb.c      |  2 +-
 net/sched/sch_sfq.c      |  2 +-
 15 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index 3bd08d7f39c1..3a542a72e9a5 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -159,6 +159,19 @@ static inline int tcf_classify(struct sk_buff *skb,
 
 #endif
 
+static inline int tcf_classify_qdisc(struct sk_buff *skb,
+				     const struct tcf_proto *tp,
+				     struct tcf_result *res, bool compat_mode)
+{
+	int ret = tcf_classify(skb, NULL, tp, res, compat_mode);
+
+	if (unlikely(ret == TC_ACT_REDIRECT)) {
+		pr_warn_once("TC_ACT_REDIRECT from qdisc filter chains is not supported; use eBPF with clsact or mirred redirect instead\n");
+		ret = TC_ACT_SHOT;
+	}
+	return ret;
+}
+
 static inline unsigned long
 __cls_set_class(unsigned long *clp, unsigned long cl)
 {
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 3e67600a4a1a..3ca56d060e28 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -4033,7 +4033,7 @@ struct sk_buff *tcf_qevent_handle(struct tcf_qevent *qe, struct Qdisc *sch, stru
 
 	fl = rcu_dereference_bh(qe->filter_chain);
 
-	switch (tcf_classify(skb, NULL, fl, &cl_res, false)) {
+	switch (tcf_classify_qdisc(skb, fl, &cl_res, false)) {
 	case TC_ACT_SHOT:
 		qdisc_qstats_drop(sch);
 		__qdisc_drop(skb, to_free);
@@ -4045,10 +4045,6 @@ struct sk_buff *tcf_qevent_handle(struct tcf_qevent *qe, struct Qdisc *sch, stru
 		__qdisc_drop(skb, to_free);
 		*ret = __NET_XMIT_STOLEN;
 		return NULL;
-	case TC_ACT_REDIRECT:
-		skb_do_redirect(skb);
-		*ret = __NET_XMIT_STOLEN;
-		return NULL;
 	case TC_ACT_CONSUMED:
 		*ret = __NET_XMIT_STOLEN;
 		return NULL;
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index a3c185505afc..94eb47ac54ee 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1730,7 +1730,7 @@ static u32 cake_classify(struct Qdisc *sch, struct cake_tin_data **t,
 		goto hash;
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
-	result = tcf_classify(skb, NULL, filter, &res, false);
+	result = tcf_classify_qdisc(skb, filter, &res, false);
 
 	if (result >= 0) {
 #ifdef CONFIG_NET_CLS_ACT
diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index 020657f959b5..91b1ef824afa 100644
--- a/net/sched/sch_drr.c
+++ b/net/sched/sch_drr.c
@@ -312,7 +312,7 @@ static struct drr_class *drr_classify(struct sk_buff *skb, struct Qdisc *sch,
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	fl = rcu_dereference_bh(q->filter_list);
-	result = tcf_classify(skb, NULL, fl, &res, false);
+	result = tcf_classify_qdisc(skb, fl, &res, false);
 	if (result >= 0) {
 #ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index 5434df6ca8ef..98364f74211e 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -364,7 +364,7 @@ static int dualpi2_skb_classify(struct dualpi2_sched_data *q,
 		return NET_XMIT_SUCCESS;
 	}
 
-	result = tcf_classify(skb, NULL, fl, &res, false);
+	result = tcf_classify_qdisc(skb, fl, &res, false);
 	if (result >= 0) {
 #ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index cb8cf437ce87..25fcf4079fec 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -391,7 +391,7 @@ static struct ets_class *ets_classify(struct sk_buff *skb, struct Qdisc *sch,
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	if (TC_H_MAJ(skb->priority) != sch->handle) {
 		fl = rcu_dereference_bh(q->filter_list);
-		err = tcf_classify(skb, NULL, fl, &res, false);
+		err = tcf_classify_qdisc(skb, fl, &res, false);
 #ifdef CONFIG_NET_CLS_ACT
 		switch (err) {
 		case TC_ACT_STOLEN:
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index cafd1f943d99..6cce86ba383c 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -91,7 +91,7 @@ static unsigned int fq_codel_classify(struct sk_buff *skb, struct Qdisc *sch,
 		return fq_codel_hash(q, skb) + 1;
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
-	result = tcf_classify(skb, NULL, filter, &res, false);
+	result = tcf_classify_qdisc(skb, filter, &res, false);
 	if (result >= 0) {
 #ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index 72f48fa4010b..069e1facd413 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -96,7 +96,7 @@ static unsigned int fq_pie_classify(struct sk_buff *skb, struct Qdisc *sch,
 		return fq_pie_hash(q, skb) + 1;
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
-	result = tcf_classify(skb, NULL, filter, &res, false);
+	result = tcf_classify_qdisc(skb, filter, &res, false);
 	if (result >= 0) {
 #ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index 7e537295b8b6..e87f5021a199 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -1143,7 +1143,7 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	head = &q->root;
 	tcf = rcu_dereference_bh(q->root.filter_list);
-	while (tcf && (result = tcf_classify(skb, NULL, tcf, &res, false)) >= 0) {
+	while (tcf && (result = tcf_classify_qdisc(skb, tcf, &res, false)) >= 0) {
 #ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
 		case TC_ACT_QUEUED:
diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index 908b9ba9ba2e..fdac0dc8f35a 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -243,7 +243,7 @@ static struct htb_class *htb_classify(struct sk_buff *skb, struct Qdisc *sch,
 	}
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
-	while (tcf && (result = tcf_classify(skb, NULL, tcf, &res, false)) >= 0) {
+	while (tcf && (result = tcf_classify_qdisc(skb, tcf, &res, false)) >= 0) {
 #ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
 		case TC_ACT_QUEUED:
diff --git a/net/sched/sch_multiq.c b/net/sched/sch_multiq.c
index 4e465d11e3d7..004f0d275caf 100644
--- a/net/sched/sch_multiq.c
+++ b/net/sched/sch_multiq.c
@@ -36,7 +36,7 @@ multiq_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
 	int err;
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
-	err = tcf_classify(skb, NULL, fl, &res, false);
+	err = tcf_classify_qdisc(skb, fl, &res, false);
 #ifdef CONFIG_NET_CLS_ACT
 	switch (err) {
 	case TC_ACT_STOLEN:
diff --git a/net/sched/sch_prio.c b/net/sched/sch_prio.c
index e4dd56a89072..79437c587e7e 100644
--- a/net/sched/sch_prio.c
+++ b/net/sched/sch_prio.c
@@ -39,7 +39,7 @@ prio_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	if (TC_H_MAJ(skb->priority) != sch->handle) {
 		fl = rcu_dereference_bh(q->filter_list);
-		err = tcf_classify(skb, NULL, fl, &res, false);
+		err = tcf_classify_qdisc(skb, fl, &res, false);
 #ifdef CONFIG_NET_CLS_ACT
 		switch (err) {
 		case TC_ACT_STOLEN:
diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index cb56787e1d25..6f3b7273cb16 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -709,7 +709,7 @@ static struct qfq_class *qfq_classify(struct sk_buff *skb, struct Qdisc *sch,
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	fl = rcu_dereference_bh(q->filter_list);
-	result = tcf_classify(skb, NULL, fl, &res, false);
+	result = tcf_classify_qdisc(skb, fl, &res, false);
 	if (result >= 0) {
 #ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
diff --git a/net/sched/sch_sfb.c b/net/sched/sch_sfb.c
index b1d465094276..ed39869199c0 100644
--- a/net/sched/sch_sfb.c
+++ b/net/sched/sch_sfb.c
@@ -260,7 +260,7 @@ static bool sfb_classify(struct sk_buff *skb, struct tcf_proto *fl,
 	struct tcf_result res;
 	int result;
 
-	result = tcf_classify(skb, NULL, fl, &res, false);
+	result = tcf_classify_qdisc(skb, fl, &res, false);
 	if (result >= 0) {
 #ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 758b88f21865..77675f9a4c46 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -171,7 +171,7 @@ static unsigned int sfq_classify(struct sk_buff *skb, struct Qdisc *sch,
 		return sfq_hash(q, skb) + 1;
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
-	result = tcf_classify(skb, NULL, fl, &res, false);
+	result = tcf_classify_qdisc(skb, fl, &res, false);
 	if (result >= 0) {
 #ifdef CONFIG_NET_CLS_ACT
 		switch (result) {
-- 
2.54.0



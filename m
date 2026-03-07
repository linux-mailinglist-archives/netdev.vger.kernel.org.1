Return-Path: <netdev+bounces-265143-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMuPD8gprGmAmAEAu9opvQ
	(envelope-from <netdev+bounces-265143-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 14:36:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 961D522BFB7
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 14:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55C9F30209F9
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 13:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466B127E1D7;
	Sat,  7 Mar 2026 13:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FVCgQfFw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C72245019
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 13:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772890565; cv=none; b=LkxCBRWR6CNHgVEzDFuBz0cx4aF66m4WHuTjGZc+HFUym/GKjUW+s9odwh2c0egt22xvTHiJHwWD8gCyBB4MpIauz4VJW1rIVZ83xWsgQvVvja2mvy1tnq4sWpEzXSQO8FPO38w/S6OSm8MxsIBRObyoEzCAkrDwpLZVHTooFLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772890565; c=relaxed/simple;
	bh=Xw+xXyKgAFZ78KvTXhrohsf3SPAwNGO75yuQgjMMv7U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YRmw12i8hEc0lw+B+vOdnI4efF3Az7/aWKNqty99HxS/trSNEdSEQRp6R+D3U39zb+GtFPJOH06q5sZG+qGyL1XztDKaVijH2F7kX0PxtG6fHnIBMvJ2K469yaikHTFxK3WQxTM+JRdRaDfXjAggxek6eHZRh5y5W2a6h1EJLNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FVCgQfFw; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c70ab7f67fso2319471585a.3
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 05:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772890563; x=1773495363; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M72An+xa5ruRooSCs5kPGGDrEcRCHa2Swraz3QoYifA=;
        b=FVCgQfFwmTQin4kGYW/JOvoZp8d0qpN/2md5j0Qt2t4IDhjdoCPsVgdaLPefnpeW+G
         uX3YMjKANR8cJ9Z8T9yn3CIViVHQmRTHCa3+/0GTB0woP4LfIwNZKAiwUJpiy3z+VsJU
         DtbxtMWInSTCYSn7J2PnSVLTEn/5FJ7TaQqqO2cFd40uOKLLb2YF9luzDR/M3u/aovcZ
         MXKFLh0a37z2rOjxiyooSgBlE0KqYPE8s08wRehqjQ6mxfPdiE85pAmjmlSqJEQugzoZ
         Mnjqvx0Vr0h9Fp3EZYCwC1AtPGq4BHGtTukahKzBJbJ178PQd1uAsrSv7cq6wrvxlgHz
         R4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772890563; x=1773495363;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M72An+xa5ruRooSCs5kPGGDrEcRCHa2Swraz3QoYifA=;
        b=ljCC0ZwoDv0nt1nZhMYxBn5TMD0UI1rcpNfRLz5ZHa+qvu41yPwgDuHvHr5sRhsC1h
         6BTB66D5L+6dYDUOYlg5BhsYEZOfTw+1EpeFrzO/PgisPLT/L/cOfx5xulZAk+1iINVV
         yuaBL2wdZOiGwCcKQ46pxHFSBvenfxl1XiNIHFY0CW8JPrpPKFowU1XD8kyzogVyvqiU
         sipUqkJeJlo29suNuBGTLfSjhSBWcay1R6CYxz0NX7MxkLVXBTGVj0cX53n1qANJu/Ps
         TS5PgdZU940MEwPoLcDoS4Bg7dLIp/TNnBD6w6s+8Cio8C33rwPBC5rqVK7ndKH6+LF4
         LPgg==
X-Forwarded-Encrypted: i=1; AJvYcCWKTG2fdRrnCWN77/hNwZ7/5vvgzUWRn4UHp094zmo4663+fnMHzWYvcALUtC/3905m7OR2gmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVuRqrGNZLGyo38/V+cZRhhoki/eGu8z/Zeq2QnKlTSqAqIDlw
	HsM11Ozbo8yDOQkxgfS25lVKVQPWZLmVHw8QfE2vJyI47ILSMSE+Z+eXdPCmPwREgrtJ4dSmjyN
	ecHfXFZ+4Q/Fcsw==
X-Received: from qkbdt25.prod.google.com ([2002:a05:620a:4799:b0:8c5:23eb:82dc])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:269a:b0:8ca:fe7f:7324 with SMTP id af79cd13be357-8cd6d4cc3c4mr667593185a.53.1772890562667;
 Sat, 07 Mar 2026 05:36:02 -0800 (PST)
Date: Sat,  7 Mar 2026 13:36:01 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260307133601.3863071-1-edumazet@google.com>
Subject: [PATCH net-next] net/sched: refine indirect call mitigation in tc_wrapper.h
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Victor Noguiera <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.ai>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 961D522BFB7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com,mojatatu.ai];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265143-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mojatatu.com:email]
X-Rspamd-Action: no action

Some modern cpus disable X86_FEATURE_RETPOLINE feature,
even if a direct call can still be beneficial.

Even when IBRS is present, an indirect call is more expensive
than a direct one:

Direct Calls:
  Compilers can perform powerful optimizations like inlining,
  where the function body is directly inserted at the call site,
  eliminating call overhead entirely.

Indirect Calls:
  Inlining is much harder, if not impossible, because the compiler
  doesn't know the target function at compile time.
  Techniques like Indirect Call Promotion can help by using
  profile-guided optimization to turn frequently taken indirect calls
  into conditional direct calls, but they still add complexity
  and potential overhead compared to a truly direct call.

In this patch, I split tc_skip_wrapper in two different
static keys, one for tc_act() (tc_skip_wrapper_act)
and one for tc_classify() (tc_skip_wrapper_cls).

Then I enable the tc_skip_wrapper_cls only if the count
of builtin classifiers is above one.

I enable tc_skip_wrapper_act only it the count of builtin
actions is above one.

In our production kernels, we only have CONFIG_NET_CLS_BPF=y
and CONFIG_NET_ACT_BPF=y. Other are modules or are not compiled.

Tested on AMD Turin cpus, cls_bpf_classify() cost went
from 1% down to 0.18 %, and FDO will be able to inline
it in tcf_classify() for further gains.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
Cc: Victor Noguiera <victor@mojatatu.com>
Cc: Pedro Tammela <pctammela@mojatatu.ai>
---
 include/net/tc_wrapper.h | 47 +++++++++++++++++++++++++++++++++++-----
 net/sched/sch_api.c      |  3 ++-
 2 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/include/net/tc_wrapper.h b/include/net/tc_wrapper.h
index ffe58a02537c3ae7979e37ace09373a443d81cc9..4ebb053bb0dd6f5f1af572fe62404eacfd0885ed 100644
--- a/include/net/tc_wrapper.h
+++ b/include/net/tc_wrapper.h
@@ -12,7 +12,8 @@
 
 #define TC_INDIRECT_SCOPE
 
-extern struct static_key_false tc_skip_wrapper;
+extern struct static_key_false tc_skip_wrapper_act;
+extern struct static_key_false tc_skip_wrapper_cls;
 
 /* TC Actions */
 #ifdef CONFIG_NET_CLS_ACT
@@ -46,7 +47,7 @@ TC_INDIRECT_ACTION_DECLARE(tunnel_key_act);
 static inline int tc_act(struct sk_buff *skb, const struct tc_action *a,
 			   struct tcf_result *res)
 {
-	if (static_branch_likely(&tc_skip_wrapper))
+	if (static_branch_likely(&tc_skip_wrapper_act))
 		goto skip;
 
 #if IS_BUILTIN(CONFIG_NET_ACT_GACT)
@@ -153,7 +154,7 @@ TC_INDIRECT_FILTER_DECLARE(u32_classify);
 static inline int tc_classify(struct sk_buff *skb, const struct tcf_proto *tp,
 				struct tcf_result *res)
 {
-	if (static_branch_likely(&tc_skip_wrapper))
+	if (static_branch_likely(&tc_skip_wrapper_cls))
 		goto skip;
 
 #if IS_BUILTIN(CONFIG_NET_CLS_BPF)
@@ -202,8 +203,44 @@ static inline int tc_classify(struct sk_buff *skb, const struct tcf_proto *tp,
 static inline void tc_wrapper_init(void)
 {
 #ifdef CONFIG_X86
-	if (!cpu_feature_enabled(X86_FEATURE_RETPOLINE))
-		static_branch_enable(&tc_skip_wrapper);
+	int cnt_cls = IS_BUILTIN(CONFIG_NET_CLS_BPF) +
+		IS_BUILTIN(CONFIG_NET_CLS_U32)  +
+		IS_BUILTIN(CONFIG_NET_CLS_FLOWER) +
+		IS_BUILTIN(CONFIG_NET_CLS_FW) +
+		IS_BUILTIN(CONFIG_NET_CLS_MATCHALL) +
+		IS_BUILTIN(CONFIG_NET_CLS_BASIC) +
+		IS_BUILTIN(CONFIG_NET_CLS_CGROUP) +
+		IS_BUILTIN(CONFIG_NET_CLS_FLOW) +
+		IS_BUILTIN(CONFIG_NET_CLS_ROUTE4);
+
+	int cnt_act = IS_BUILTIN(CONFIG_NET_ACT_GACT) +
+		IS_BUILTIN(CONFIG_NET_ACT_MIRRED) +
+		IS_BUILTIN(CONFIG_NET_ACT_PEDIT) +
+		IS_BUILTIN(CONFIG_NET_ACT_SKBEDIT) +
+		IS_BUILTIN(CONFIG_NET_ACT_SKBMOD) +
+		IS_BUILTIN(CONFIG_NET_ACT_POLICE) +
+		IS_BUILTIN(CONFIG_NET_ACT_BPF) +
+		IS_BUILTIN(CONFIG_NET_ACT_CONNMARK) +
+		IS_BUILTIN(CONFIG_NET_ACT_CSUM) +
+		IS_BUILTIN(CONFIG_NET_ACT_CT) +
+		IS_BUILTIN(CONFIG_NET_ACT_CTINFO) +
+		IS_BUILTIN(CONFIG_NET_ACT_GATE) +
+		IS_BUILTIN(CONFIG_NET_ACT_MPLS) +
+		IS_BUILTIN(CONFIG_NET_ACT_NAT) +
+		IS_BUILTIN(CONFIG_NET_ACT_TUNNEL_KEY) +
+		IS_BUILTIN(CONFIG_NET_ACT_VLAN) +
+		IS_BUILTIN(CONFIG_NET_ACT_IFE) +
+		IS_BUILTIN(CONFIG_NET_ACT_SIMP) +
+		IS_BUILTIN(CONFIG_NET_ACT_SAMPLE);
+
+	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE))
+		return;
+
+	if (cnt_cls > 1)
+		static_branch_enable(&tc_skip_wrapper_cls);
+
+	if (cnt_act > 1)
+		static_branch_enable(&tc_skip_wrapper_act);
 #endif
 }
 
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index cc43e3f7574fae203989f5c28b4934f0720e64c2..61a9dc219a18fb34d10893fe45a0030d3c23f5d0 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -2479,7 +2479,8 @@ static struct pernet_operations psched_net_ops = {
 };
 
 #if IS_ENABLED(CONFIG_MITIGATION_RETPOLINE)
-DEFINE_STATIC_KEY_FALSE(tc_skip_wrapper);
+DEFINE_STATIC_KEY_FALSE(tc_skip_wrapper_act);
+DEFINE_STATIC_KEY_FALSE(tc_skip_wrapper_cls);
 #endif
 
 static const struct rtnl_msg_handler psched_rtnl_msg_handlers[] __initconst = {
-- 
2.53.0.473.g4a7958ca14-goog



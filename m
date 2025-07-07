Return-Path: <netdev+bounces-204577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3333CAFB3D8
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 15:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A13D3ACD34
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 13:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436FA29B77A;
	Mon,  7 Jul 2025 13:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XwhJPbaC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA1C29C32C
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 13:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751893288; cv=none; b=OYpSiFSwfrxX+C2+hHTJ3H9yuz7wxn0B+CcZb0vVCrnSbPUenp70szw6ScEuWTfxMM32+aPlS6Uqz36HTNKNFh55lB570qtPcWFSg9Q6WvHk5XSJMXpV25gFCRLBBY9vXFlOyepF7ufW0kiL/Mi9IOQvTCbWMNK33RritaTXL7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751893288; c=relaxed/simple;
	bh=+0Cuc468gfGYrCN+yrneTsEWx/5pFhh9unSPMcY95ls=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y30cJnrrFTlT6YE1zQjhdh97cd+C5M39Fm2ZZxuP2ZjZFiq11pzisB+iLvGG4kbrkZUrNm0eaC2yWIMP58B5gyvV8nlozwO2xGrifvxXEJbRiLmhPIwn7csJDxkKaT/l/JzfaR8XBsh5ku5MuTP10uxxa2HpZI7Aox2tqWR/y14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XwhJPbaC; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6fb3466271fso55552626d6.0
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 06:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751893285; x=1752498085; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xyJZq95SvxS0dcbGP7YwGHajFzDJNEGqUF1dcjwDiTU=;
        b=XwhJPbaC9OgmonD0emxSVO/+SXRlHHvNZp5k8CTogvq05vAgKZJdnj6fukkDBSprxM
         KltBpnhZ744158DGa+r9keFQldycFsvSXPWI/Qnd7VBNIVd/I697hnxAxnalupu6E0gj
         0X7VjHZCxj50HFCMfUeX+7kPAEInPCCfbIVYGL+EIkkLX6vF1wDNX9C07LopJmmQk0K2
         7turMtObk1jgYZyL6rno0WpQmE+LNGRiR3nAt3fMxe66EMk/PWsdkV4F/HPGLIDsBLZy
         df4z+ervGqUuu7BWxDaC2wrjJBSf3phX6u+LkzSJsoP4befHPtP66+P0coDbgfc0T4v/
         m3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751893285; x=1752498085;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xyJZq95SvxS0dcbGP7YwGHajFzDJNEGqUF1dcjwDiTU=;
        b=RqmgrtrwoR6AydJ3OmYHhtfW5o/FXc0wvcXO0WhmPHu7//It8JVoiWml5dJrgrW1WA
         5lfK02t4xjcsyuWSHEtlHlpymFLrLNhOk/MBuoHr1GdETtf/vjmbhjfx2HdZZ1dybDHJ
         u1yVl9tHOJiQLZCob9We7gBY/HLaDhc+/n+I/7KyW/rcZ9lUpdfEvrid6k9n5y18TEa/
         8thfVd+yGsgGf3lEi83zEo4DviEFML6N5MzABBV51382IesH959W0FIjzkrfangqpyXh
         UeP+dXuit6W1X/hlUZ24FZoU/qg1fDEOjMR9llnmkp8lEJuIsmhZKTjSLUTo7mEOHMDr
         T/Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVTECSz9IrLzTemAro3Bc0oYP3pNRMEjtTPIFZFcFVwLaxIJL92kB4E/wzAtEfaktatw62XjAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP1HWee/z4hcAua3U9cbXPWdScbS4O++SJYx0iDlx8yJsLrPGu
	QGMo+bePceu1CjbJYdinNkS4+4E858jPAkmRBSddEInvzL6TUCqlv2KV9UBqi/MNANM/DXA3fXy
	vl9qer8pPfmqIlw==
X-Google-Smtp-Source: AGHT+IGWugQCXRF8eHKwuUboehzHGep9plrgY/KKyJgHiwgWLcNQAvnwcAgZoVH9PXdml6s6O6M9NuRugXUdow==
X-Received: from qvbrd3.prod.google.com ([2002:a05:6214:4ec3:b0:702:aeeb:561c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:21e7:b0:702:c038:af78 with SMTP id 6a1803df08f44-702c5695e64mr221073446d6.5.1751893285490;
 Mon, 07 Jul 2025 06:01:25 -0700 (PDT)
Date: Mon,  7 Jul 2025 13:01:06 +0000
In-Reply-To: <20250707130110.619822-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250707130110.619822-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250707130110.619822-8-edumazet@google.com>
Subject: [PATCH net-next 07/11] net_sched: act_mpls: use RCU in tcf_mpls_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Also storing tcf_action into struct tcf_mpls_params
makes sure there is no discrepancy in tcf_mpls_act().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tc_act/tc_mpls.h |  1 +
 net/sched/act_mpls.c         | 21 ++++++++++-----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/net/tc_act/tc_mpls.h b/include/net/tc_act/tc_mpls.h
index d452e5e94fd0f6dfaf9510d8722f79b62c6d69bb..dd067bd4018d4bb70ca024f7997d22c7b993782a 100644
--- a/include/net/tc_act/tc_mpls.h
+++ b/include/net/tc_act/tc_mpls.h
@@ -10,6 +10,7 @@
 struct tcf_mpls_params {
 	int tcfm_action;
 	u32 tcfm_label;
+	int action; /* tcf_action */
 	u8 tcfm_tc;
 	u8 tcfm_ttl;
 	u8 tcfm_bos;
diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
index 9f86f4e666d3363b83cfc883136b2c4a231479a4..6654011dcd2ba30769b2f52078373a834e259f88 100644
--- a/net/sched/act_mpls.c
+++ b/net/sched/act_mpls.c
@@ -57,7 +57,7 @@ TC_INDIRECT_SCOPE int tcf_mpls_act(struct sk_buff *skb,
 	struct tcf_mpls *m = to_mpls(a);
 	struct tcf_mpls_params *p;
 	__be32 new_lse;
-	int ret, mac_len;
+	int mac_len;
 
 	tcf_lastuse_update(&m->tcf_tm);
 	bstats_update(this_cpu_ptr(m->common.cpu_bstats), skb);
@@ -72,8 +72,6 @@ TC_INDIRECT_SCOPE int tcf_mpls_act(struct sk_buff *skb,
 		mac_len = skb_network_offset(skb);
 	}
 
-	ret = READ_ONCE(m->tcf_action);
-
 	p = rcu_dereference_bh(m->mpls_p);
 
 	switch (p->tcfm_action) {
@@ -122,7 +120,7 @@ TC_INDIRECT_SCOPE int tcf_mpls_act(struct sk_buff *skb,
 	if (skb_at_tc_ingress(skb))
 		skb_pull_rcsum(skb, skb->mac_len);
 
-	return ret;
+	return p->action;
 
 drop:
 	qstats_drop_inc(this_cpu_ptr(m->common.cpu_qstats));
@@ -296,6 +294,7 @@ static int tcf_mpls_init(struct net *net, struct nlattr *nla,
 					 ACT_MPLS_BOS_NOT_SET);
 	p->tcfm_proto = nla_get_be16_default(tb[TCA_MPLS_PROTO],
 					     htons(ETH_P_MPLS_UC));
+	p->action = parm->action;
 
 	spin_lock_bh(&m->tcf_lock);
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
@@ -330,8 +329,8 @@ static int tcf_mpls_dump(struct sk_buff *skb, struct tc_action *a,
 			 int bind, int ref)
 {
 	unsigned char *b = skb_tail_pointer(skb);
-	struct tcf_mpls *m = to_mpls(a);
-	struct tcf_mpls_params *p;
+	const struct tcf_mpls *m = to_mpls(a);
+	const struct tcf_mpls_params *p;
 	struct tc_mpls opt = {
 		.index    = m->tcf_index,
 		.refcnt   = refcount_read(&m->tcf_refcnt) - ref,
@@ -339,10 +338,10 @@ static int tcf_mpls_dump(struct sk_buff *skb, struct tc_action *a,
 	};
 	struct tcf_t t;
 
-	spin_lock_bh(&m->tcf_lock);
-	opt.action = m->tcf_action;
-	p = rcu_dereference_protected(m->mpls_p, lockdep_is_held(&m->tcf_lock));
+	rcu_read_lock();
+	p = rcu_dereference(m->mpls_p);
 	opt.m_action = p->tcfm_action;
+	opt.action = p->action;
 
 	if (nla_put(skb, TCA_MPLS_PARMS, sizeof(opt), &opt))
 		goto nla_put_failure;
@@ -370,12 +369,12 @@ static int tcf_mpls_dump(struct sk_buff *skb, struct tc_action *a,
 	if (nla_put_64bit(skb, TCA_MPLS_TM, sizeof(t), &t, TCA_MPLS_PAD))
 		goto nla_put_failure;
 
-	spin_unlock_bh(&m->tcf_lock);
+	rcu_read_unlock();
 
 	return skb->len;
 
 nla_put_failure:
-	spin_unlock_bh(&m->tcf_lock);
+	rcu_read_unlock();
 	nlmsg_trim(skb, b);
 	return -EMSGSIZE;
 }
-- 
2.50.0.727.gbf7dc18ff4-goog



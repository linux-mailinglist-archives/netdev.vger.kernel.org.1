Return-Path: <netdev+bounces-205335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 875CAAFE374
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 11:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B9064E6CD5
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 09:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA78B283CBE;
	Wed,  9 Jul 2025 09:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bs/UIfrQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24066283CB5
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 09:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051740; cv=none; b=jf8WqEHzZ7sGV2I9z2tPmRD78HYffQ3PfkCb43rSyuAaGDPQrXjTNlsAl9DCpTGQuaeBdFzVInifiVXgX7Av0YE1Qblhlkgh/Wr1xe+MyzsjzHGo5fs11ozdEAb2nC9sVL6WFFmbaf2EZSc31CgJw3zHIagP/e1GJ6TbKLfjLgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051740; c=relaxed/simple;
	bh=+0Cuc468gfGYrCN+yrneTsEWx/5pFhh9unSPMcY95ls=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fNxrt3e3cbf2oPALlY/s4bT+KZ5ZdVjiseKS5GWL/bOGkF/bBRJ99sWJdnnVoDpQkwf2XhAi7qNNwtNopVFudduYBEMNYKyXSDomOvOZz1gupqKjBuZm+3ngtBPY7fOIBWpxqAYZM1U7bWhV1F2OJ7xBjzFas3SNvgTVFU64CQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bs/UIfrQ; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7d399065d55so660518385a.1
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 02:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752051738; x=1752656538; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xyJZq95SvxS0dcbGP7YwGHajFzDJNEGqUF1dcjwDiTU=;
        b=Bs/UIfrQoQ29FYfs3kN21SgJVUExavKkl3heQW5gGMXGmyZ9H5YvJoIML3kWUXeJsr
         7wI+R0iYmHkrxU/9Akoltf/CdpS1j6XxomUwVRNqQ0ZwEz1TLF6N8C3uZ+q1YIx8Pq6f
         LaPNTwJsunjqXEahozTm1KhKj3m4rUdUk9S34ELdz+fK+snJwSufDbp2qfP2YPrV499P
         FbMEbMZvHLH4EUFtlkzfeHjkTqKokPkcKysn//KBVBaVSN2S8lbXCaSZl5HQcj6o3xY2
         9ModQVL5fa+h6cFHSlPuofzoemrDBayfgRhpmpB9ydsDZNAyB616belCMtnm7HVWuafx
         Lhsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752051738; x=1752656538;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xyJZq95SvxS0dcbGP7YwGHajFzDJNEGqUF1dcjwDiTU=;
        b=Hk7JDIkKL6s5tCZmB1ODE30/iSO3XMjgrN0qVQArPrQBh/05YuxygfPxCbt8fjGmO7
         +/RL+n6wqISUqzAzFmAfnrTOFhp16+pN3DMjwwJazhr0usR/erQIIWTVfOFXXWQ2g1zu
         ojDfqkWDIM3qqCX8adtcEQlxnPsGXWx9jDrfU1VCrXSc7cr8mhp9sOzgdco34TMC2/uF
         07hboDVs78s3wTPEXjriT7DU3lJhfQ99iMyNFNY7AQtInd9OTtyCAiSSxzcS9Vm0v/38
         7Xrx9ZDgZ3HsKez2tk9efTHGeY38NSV+URvzBQ/CXWCGaNQnNRiajcYkySbaTQOFJV+E
         U8Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUHazKjIKcIonhrlPZ5lvIDjMPvNYkZ3SYMlUY2DJmkEnPul15glJfXhE8I4FXlJA8J3u/gvdc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+EWGBIbak5Ddv/58iU35O7A6XyGqTQ9rVj9YqysOCtqqgkE9R
	2Q8w+LBhEGKkFqypDiy/rN/q2OlbhQ5F1FZMrsrRb3hp40SSSrLGCjOJkFrIiY2J9eINolc7Iap
	QMhxBb4vnKyaaRQ==
X-Google-Smtp-Source: AGHT+IE06g3KHh7QgLw8K0utqJdg/P6xvWLWvzMbq8u9GRKd+84xpxevlrKzuwpd5/hRIV4KR+obO8/o6xBJWw==
X-Received: from qkaq28.prod.google.com ([2002:a05:620a:aa1c:b0:7d0:a085:2e0d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:170e:b0:7db:4d5f:83dc with SMTP id af79cd13be357-7db7db75d6fmr272319485a.55.1752051737119;
 Wed, 09 Jul 2025 02:02:17 -0700 (PDT)
Date: Wed,  9 Jul 2025 09:01:59 +0000
In-Reply-To: <20250709090204.797558-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709090204.797558-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709090204.797558-8-edumazet@google.com>
Subject: [PATCH v2 net-next 07/11] net_sched: act_mpls: use RCU in tcf_mpls_dump()
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



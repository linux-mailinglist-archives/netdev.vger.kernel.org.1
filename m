Return-Path: <netdev+bounces-204582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9495AFB3E1
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 15:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C837B3B5DE2
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 13:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558042BCF4B;
	Mon,  7 Jul 2025 13:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vEQzb1HN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45B929E10F
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751893301; cv=none; b=Sl5rDjirrWHZsKAal6yBlgmsUtiVcKPWhUFlPCUdElmbg1i7Vh5xAd5WzH+x3F4KW2+zSvGt5EAkGmezN52SvY40vuzfnloSvh4J28CoNo99VHvPS3BwXasOMXgYzGvYAFc4ZQWCigpvFshKXLgoF8807vjA6ECFVz13TWoLPgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751893301; c=relaxed/simple;
	bh=H6j6fraweO5OKoZOA6jOVgJuLNPX2/ptk0SlBuzJF8I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bHSs39senpT70xt8ft68QUnYH1w6K5RR3Y7+9+y81nqWvkGKxd6ZCvKxgq2XuRCJfmgAPGG6YYubBjBS3v6eypJbxOuojHrKplevudvrrjqfsSiAE3oTELcgGWHjeQiR3cIFGR1lprGbp7fjr1dHK0p9skSO4RDdZlwbjy/mumU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vEQzb1HN; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e81b9217352so3176374276.1
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 06:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751893298; x=1752498098; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RJNoe2JjTr+fPc7Xlv71b7dllYfIIf53YkSiJuaG9R0=;
        b=vEQzb1HNZRYZORxR8FxluwzGLKhCwEw2/JUstkNu0Rzykv5xGxxbFVCdVIGSaseJUG
         8MX5mDWidKtfOepPUV+MI3JET4hUuiHMyqRUJLFdtYHafM9BEpBLSeTOR541mMp+Lnhx
         7PejnNyd8ZSKa3YP5fH0h8ThZ03WC7tSXpxs+zYspQefm0PC3EfopK7e6JXoFnQ0tIeT
         G3MTDxe4kxUqp0FVzx9Qa+oziwS6fbDLzSDOVTcQ9AvBmh4zTpBBdbts1eHj9YH4ldSv
         zvyq2Z1UhjUcKvPXYlEo0kjtKbciK2ptBL4XbvG3+fdg7cpge8R6TqT1dNEjzRrZzgvm
         kH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751893298; x=1752498098;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJNoe2JjTr+fPc7Xlv71b7dllYfIIf53YkSiJuaG9R0=;
        b=R6FluiJLJme+cVb3UHRHmgvtok0WOz0HoN6pF+UxxdGuxcvYt4F92XMr2NjwalD3EQ
         kjBYZ+JUf0jOHqbp+XQ4FG/L+9yZ+y0y10l4cMGPs5NlsKbUAE6AWC5iTBuVVqZwVVGH
         dwUibEH/ylqynkzGEWznPzT3Bpv/2JAi7jDPcNiXLg9ecILSXB6uSQPEDxHoVxrZZCHl
         pSMWkSc0GJo/RZ9qgTTIUy/DhisZMRKrypLZJzkYINVLglEsgAWoretPneyIEQl2T3xx
         FO+GuQJkRppGusTxe2mnFbF0OASWWHfmERvOFq6ku/UHpAuvIbq5rN2M1XO81uKZ35pq
         K5Rg==
X-Forwarded-Encrypted: i=1; AJvYcCXvQqsDGrcE+qAO0flSZTSRc/raiPn20XhYehSMP2AlETxCOYOtYmIbE34BqtZxQ53G0AhG3iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQG5217XAGSdp3YP/0YlGHXYC6Rh3wcE/B9qjh0jOoarlCOu6t
	XxTmviszdQJkw6885YdATOSeG2i8WuTR+n71CpaaFWulXvgXgLksTpMPGGHySCqyXhkCBVdvdMJ
	qryOuOQFe8881Dg==
X-Google-Smtp-Source: AGHT+IHGoTKJ39BVqm3MC0tqubgAXgqZLccUuMKDXQXNGA0FQhofdLGRBzTgK5cUa3V2/vzeReXpRJE6qfEaaw==
X-Received: from qvbre17.prod.google.com ([2002:a05:6214:5e11:b0:6fb:4f55:79c6])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:5121:b0:4c3:6393:83f4 with SMTP id ada2fe7eead31-4f2f1e46a54mr7630332137.2.1751893279268;
 Mon, 07 Jul 2025 06:01:19 -0700 (PDT)
Date: Mon,  7 Jul 2025 13:01:02 +0000
In-Reply-To: <20250707130110.619822-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250707130110.619822-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250707130110.619822-4-edumazet@google.com>
Subject: [PATCH net-next 03/11] net_sched: act_csum: use RCU in tcf_csum_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Also storing tcf_action into struct tcf_csum_params
makes sure there is no discrepancy in tcf_csum_act().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tc_act/tc_csum.h |  1 +
 net/sched/act_csum.c         | 18 +++++++++---------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/net/tc_act/tc_csum.h b/include/net/tc_act/tc_csum.h
index 2515da0142a671be82f873183077a12b5c8600b2..8d0c7a9f934525cc5fa5fd2d5ea9808629b4a550 100644
--- a/include/net/tc_act/tc_csum.h
+++ b/include/net/tc_act/tc_csum.h
@@ -8,6 +8,7 @@
 
 struct tcf_csum_params {
 	u32 update_flags;
+	int action;
 	struct rcu_head rcu;
 };
 
diff --git a/net/sched/act_csum.c b/net/sched/act_csum.c
index 5cc8e407e7911c6c9f252d58b458728174913317..0939e6b2ba4d1947df0f3dcfc09bfaa339a6ace2 100644
--- a/net/sched/act_csum.c
+++ b/net/sched/act_csum.c
@@ -99,6 +99,7 @@ static int tcf_csum_init(struct net *net, struct nlattr *nla,
 		goto put_chain;
 	}
 	params_new->update_flags = parm->update_flags;
+	params_new->action = parm->action;
 
 	spin_lock_bh(&p->tcf_lock);
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
@@ -580,7 +581,7 @@ TC_INDIRECT_SCOPE int tcf_csum_act(struct sk_buff *skb,
 	tcf_lastuse_update(&p->tcf_tm);
 	tcf_action_update_bstats(&p->common, skb);
 
-	action = READ_ONCE(p->tcf_action);
+	action = params->action;
 	if (unlikely(action == TC_ACT_SHOT))
 		goto drop;
 
@@ -631,9 +632,9 @@ TC_INDIRECT_SCOPE int tcf_csum_act(struct sk_buff *skb,
 static int tcf_csum_dump(struct sk_buff *skb, struct tc_action *a, int bind,
 			 int ref)
 {
+	const struct tcf_csum *p = to_tcf_csum(a);
 	unsigned char *b = skb_tail_pointer(skb);
-	struct tcf_csum *p = to_tcf_csum(a);
-	struct tcf_csum_params *params;
+	const struct tcf_csum_params *params;
 	struct tc_csum opt = {
 		.index   = p->tcf_index,
 		.refcnt  = refcount_read(&p->tcf_refcnt) - ref,
@@ -641,10 +642,9 @@ static int tcf_csum_dump(struct sk_buff *skb, struct tc_action *a, int bind,
 	};
 	struct tcf_t t;
 
-	spin_lock_bh(&p->tcf_lock);
-	params = rcu_dereference_protected(p->params,
-					   lockdep_is_held(&p->tcf_lock));
-	opt.action = p->tcf_action;
+	rcu_read_lock();
+	params = rcu_dereference(p->params);
+	opt.action = params->action;
 	opt.update_flags = params->update_flags;
 
 	if (nla_put(skb, TCA_CSUM_PARMS, sizeof(opt), &opt))
@@ -653,12 +653,12 @@ static int tcf_csum_dump(struct sk_buff *skb, struct tc_action *a, int bind,
 	tcf_tm_dump(&t, &p->tcf_tm);
 	if (nla_put_64bit(skb, TCA_CSUM_TM, sizeof(t), &t, TCA_CSUM_PAD))
 		goto nla_put_failure;
-	spin_unlock_bh(&p->tcf_lock);
+	rcu_read_unlock();
 
 	return skb->len;
 
 nla_put_failure:
-	spin_unlock_bh(&p->tcf_lock);
+	rcu_read_unlock();
 	nlmsg_trim(skb, b);
 	return -1;
 }
-- 
2.50.0.727.gbf7dc18ff4-goog



Return-Path: <netdev+bounces-205331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C81D6AFE36F
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 11:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26BF31895099
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 09:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B691283FD9;
	Wed,  9 Jul 2025 09:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="erPuFWih"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DB02820BA
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 09:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051733; cv=none; b=BBGw81/r0V6PaoP+N6LSiuNiHjXMffhF37agm0kK6urdnnnd1nvByvFM4JXMyn+Zs/gR9NiTU8rx562/nnkWYaaNBXzBBNq+86oE/QZg2Gs8sw4Qsl13UJPpVwjj8tCGOb3/dbzp2egbkeo1viEGcwc6FiA2K4gP9vmgxQR7mcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051733; c=relaxed/simple;
	bh=H6j6fraweO5OKoZOA6jOVgJuLNPX2/ptk0SlBuzJF8I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ObIEFkBUG/lT6eBFvv0bZrDjCy4W8k+0HBsOWzvRmP9dcHbjS+bPn3UTbJdo5P12e4hEhQw9o8CE0UBv19GxZIBrkE9AQU1MgKx0me4Tjt4VCkNUe/DpaXNCgYWGrwgk0jWHmabBh+fxDk5A24BAAbbLucxGlUAiqGiKW0EpbDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=erPuFWih; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4a43ae0dcf7so106212831cf.1
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 02:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752051731; x=1752656531; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RJNoe2JjTr+fPc7Xlv71b7dllYfIIf53YkSiJuaG9R0=;
        b=erPuFWihHXta3iGClx1im0ACsNvpmT2FCpD2dvoclfDv+dbLaTgn1UOLsq8OAWAY0u
         EFbW0bMKr6iIxpaMGoayWmqpY6eYHbDua1Fz4cQVvtzxOYgjCxLFuEcMoyHEBmz1tpQh
         2Dnv0cWha+Db0OYzzgm3QJNTIvM0mIR9dVvnKs0irsugBKs5pEGqoQzhn0UeUsXWdrsN
         5kOr43SCH54Hm6gEbxdfRjKxtevr5wLgJ9fa8w9m0tyNXbzhkaC2lDzrHdqfEXe+xi7c
         zi7JQiCp/k/xfd04TuBNNGiEnKfLXwgbr9q9ytC1Sp2+wNt59+x51gV9yENRlC3amFsm
         A40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752051731; x=1752656531;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJNoe2JjTr+fPc7Xlv71b7dllYfIIf53YkSiJuaG9R0=;
        b=J+YJZpzptHKIRGN/buGrnYvrRe5WUs3DCSZ9KAJSVohTx9/xj2Cpk90tab+kmen1o8
         WNyuM/d5KniHunhFwBDmAcP1E0Cc5pDUDDRWTDpgGWD/icXIjL8aHNVrGNnIOOMC4Jrg
         Tg8M5RdU08NlnLjqo/NTvpoy2E5DFp6vUgBxZfGk0KRjh5Vl1r+gReDqYnPcv7lOjiTj
         W+M349nugtO/BCJ2Z2XTzsM4LYg0fKLM+9pA5nuZpFeuUHUCxd6D4/EO5DCftFoYuqm+
         xr+Ojl+8bIxYGtRUhif6FiycTJ7JvM/ZS3C/jzp3a90hi2AwyJ51hEcN4iLexwg1+vCw
         tycA==
X-Forwarded-Encrypted: i=1; AJvYcCVh1ft1tqiXiUUOCfsgjyCtCKPXCkfTafCkSiI+1oElq3cRfbTfFzK/Wz+zF6Jj2vTjl4HN7vQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYUxzSP4D4qA0+TXSpjgLN90BUOGFitbPLyCSTzWZ3Zz8TMc0V
	T9QC2t5xED6IGZkWuiYi+JEzd8X0eokWawNvwNa1fS+rOyLz4FpuV5rxVZQqvUzYYZIazECdAuk
	W5h+870mAJVLEWQ==
X-Google-Smtp-Source: AGHT+IE5RZt4cgyYBN0XMobLiiyJ29XiRN5pdDFxd+rV1aXOSAXhD9nMx4/Pqwj/QK9wMwNbeibIVxUoNBs5sw==
X-Received: from qtbbc4.prod.google.com ([2002:a05:622a:1cc4:b0:4a9:97f7:7b31])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:2443:b0:4a9:7725:b1be with SMTP id d75a77b69052e-4a9dec265fdmr17838121cf.8.1752051730776;
 Wed, 09 Jul 2025 02:02:10 -0700 (PDT)
Date: Wed,  9 Jul 2025 09:01:55 +0000
In-Reply-To: <20250709090204.797558-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709090204.797558-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709090204.797558-4-edumazet@google.com>
Subject: [PATCH v2 net-next 03/11] net_sched: act_csum: use RCU in tcf_csum_dump()
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



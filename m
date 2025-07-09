Return-Path: <netdev+bounces-205330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C164AFE36E
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 11:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FBF67A0121
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 09:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB400283FC8;
	Wed,  9 Jul 2025 09:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jN8Lj+QO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E790283CA3
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 09:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051731; cv=none; b=TdppMEEq6mBQ9zPMYAQTZUj+D8VJgH5lkh8bHrhnMoUlV4LSCZH0Dr28PaDaemdQOmreiWGvXuQpsdH7r9rGFHRWFwDrt27SVzH7XfCXbXPSI4Lzh/NO9mDvlvbzGJPY5I0R5bXRV1/iMk8Lmm3DS4bF9usm/s8IkxZuN28ahtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051731; c=relaxed/simple;
	bh=YRCVWNSTqk8nTHsuxVrMx7xFmhTDxLU/ff6LPy1oEr8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ioM/o8KdW8shp9Sa6q3iVm3ksPyzsXunLqa35v8Mj/LWYgfKWK78zWMT7j5oXrDuMhhC7iUxOk+AEhFnY4f+015qzp29hKcBJX8EllTqogzINYKeBFZZ/f9mHNyXTTWyelYN2B0XeMU5gIwBE5BGUIM+oVQzcmA2eLZD/QQictw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jN8Lj+QO; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6fabd295d12so97395616d6.1
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 02:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752051729; x=1752656529; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4EOklmCiEi2XRL3AgJubkAIQFnUMr2uDkKAWTyAPSUo=;
        b=jN8Lj+QO5thZb+dMo7gs1fYrEDsHkA/d4mNYdl/nBVhnQIX27enns87xGXpiwVVVcH
         0iV2ksgpx3mTY2oqd/UKnv3FO7omt/NtMojQgdQT2IPP4ibI2/05n/iNn1L+B31dF5G4
         P0JRq5R3CIL2ngzeaMxF31Bty8eyUAmDBN3Rl5t3sBhFqTRSgAAB23F0XdmVM/C4KM0/
         SmMoObKijl2Yq62qDG3w11ih6cj77QfRRC09+ItEZ4uhsP+AWPqyIKXF5Q62unDe/7dY
         vtthCfiwr7rAxa5UDj1aL9snJhWynDT2qyqoFtUb0Dwrz4pZpbiK/DF8SSAjfumPFuHm
         yVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752051729; x=1752656529;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4EOklmCiEi2XRL3AgJubkAIQFnUMr2uDkKAWTyAPSUo=;
        b=VTNYVvFl/xsN48jyR0cOr470ZUyVmMz1WX5uTHtkC2B2MLWKX9SvBROAXfPs6YGWDp
         Xhp2/l1Ax4cn7l5WLArAP5SNMD6gRUdzkuZyTsKKDDqGNLubeiu1cGeJVBxFWULzA65Z
         SsSiqXHECN1EZyEb5n7iJnKUv834dfjDWYroQKmkGZkN9iKgWsKHdlKxTVbGyc29wiIM
         I8aBtaJUGc7TXYE4lR7SrPKhjSLNkVEvNyxcuhflgWKV/3oqCEyLT5MaV3IWDR2s2hfX
         K6Li8bT9cqELU8nrJUGRV/Hu1DO3WGpBFP6dB0IL2HQPidwD1m8QT9UcddiTujCBpUpc
         M94A==
X-Forwarded-Encrypted: i=1; AJvYcCU7oSbBwweSWzzZw4PLijS0VfMcVPf2j1vvHQJOlUgxwQNB+1sanBj6bzx86YKIvzVkPki0lPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGLGChZVJ/WbgWF9waOLHB63i126E8H5XT5hHhcW68u5EcjZHv
	UHsh48SGz/ktOSBEA8dwSBfDnG85KyeOcYYnenbxQ89qhsm901czjH+axFHboddlSFZvfQ0p+Pd
	asmwhxLLpJR2h8A==
X-Google-Smtp-Source: AGHT+IFWXGSNsM2ToUW5l8OW9eS1oXgGVeKXR/pAd3sdGqy8KUd3quEqxmN2DgF5gjt9PawhdullC+7tn6N/lw==
X-Received: from qvbnz12.prod.google.com ([2002:a05:6214:3a8c:b0:6fb:5f7c:611])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:400b:b0:702:c140:b177 with SMTP id 6a1803df08f44-7048b8bed9cmr24615356d6.8.1752051729032;
 Wed, 09 Jul 2025 02:02:09 -0700 (PDT)
Date: Wed,  9 Jul 2025 09:01:54 +0000
In-Reply-To: <20250709090204.797558-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709090204.797558-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709090204.797558-3-edumazet@google.com>
Subject: [PATCH v2 net-next 02/11] net_sched: act_connmark: use RCU in tcf_connmark_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Also storing tcf_action into struct tcf_connmark_parms
makes sure there is no discrepancy in tcf_connmark_act().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tc_act/tc_connmark.h |  1 +
 net/sched/act_connmark.c         | 18 ++++++++++--------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/net/tc_act/tc_connmark.h b/include/net/tc_act/tc_connmark.h
index e8dd77a967480352f398f654f331016e2733a371..a5ce83f3eea4bfd5ab2b20071738c08f64d1cdf7 100644
--- a/include/net/tc_act/tc_connmark.h
+++ b/include/net/tc_act/tc_connmark.h
@@ -7,6 +7,7 @@
 struct tcf_connmark_parms {
 	struct net *net;
 	u16 zone;
+	int action;
 	struct rcu_head rcu;
 };
 
diff --git a/net/sched/act_connmark.c b/net/sched/act_connmark.c
index 0fce631e7c91113e5559d12ddc4d0ebeef1237e4..3e89927d711647d75f31c8d80a3ddd102e3d2e36 100644
--- a/net/sched/act_connmark.c
+++ b/net/sched/act_connmark.c
@@ -88,7 +88,7 @@ TC_INDIRECT_SCOPE int tcf_connmark_act(struct sk_buff *skb,
 	/* using overlimits stats to count how many packets marked */
 	tcf_action_inc_overlimit_qstats(&ca->common);
 out:
-	return READ_ONCE(ca->tcf_action);
+	return parms->action;
 }
 
 static const struct nla_policy connmark_policy[TCA_CONNMARK_MAX + 1] = {
@@ -167,6 +167,8 @@ static int tcf_connmark_init(struct net *net, struct nlattr *nla,
 	if (err < 0)
 		goto release_idr;
 
+	nparms->action = parm->action;
+
 	spin_lock_bh(&ci->tcf_lock);
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
 	oparms = rcu_replace_pointer(ci->parms, nparms, lockdep_is_held(&ci->tcf_lock));
@@ -190,20 +192,20 @@ static int tcf_connmark_init(struct net *net, struct nlattr *nla,
 static inline int tcf_connmark_dump(struct sk_buff *skb, struct tc_action *a,
 				    int bind, int ref)
 {
+	const struct tcf_connmark_info *ci = to_connmark(a);
 	unsigned char *b = skb_tail_pointer(skb);
-	struct tcf_connmark_info *ci = to_connmark(a);
+	const struct tcf_connmark_parms *parms;
 	struct tc_connmark opt = {
 		.index   = ci->tcf_index,
 		.refcnt  = refcount_read(&ci->tcf_refcnt) - ref,
 		.bindcnt = atomic_read(&ci->tcf_bindcnt) - bind,
 	};
-	struct tcf_connmark_parms *parms;
 	struct tcf_t t;
 
-	spin_lock_bh(&ci->tcf_lock);
-	parms = rcu_dereference_protected(ci->parms, lockdep_is_held(&ci->tcf_lock));
+	rcu_read_lock();
+	parms = rcu_dereference(ci->parms);
 
-	opt.action = ci->tcf_action;
+	opt.action = parms->action;
 	opt.zone = parms->zone;
 	if (nla_put(skb, TCA_CONNMARK_PARMS, sizeof(opt), &opt))
 		goto nla_put_failure;
@@ -212,12 +214,12 @@ static inline int tcf_connmark_dump(struct sk_buff *skb, struct tc_action *a,
 	if (nla_put_64bit(skb, TCA_CONNMARK_TM, sizeof(t), &t,
 			  TCA_CONNMARK_PAD))
 		goto nla_put_failure;
-	spin_unlock_bh(&ci->tcf_lock);
+	rcu_read_unlock();
 
 	return skb->len;
 
 nla_put_failure:
-	spin_unlock_bh(&ci->tcf_lock);
+	rcu_read_unlock();
 	nlmsg_trim(skb, b);
 	return -1;
 }
-- 
2.50.0.727.gbf7dc18ff4-goog



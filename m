Return-Path: <netdev+bounces-204575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63205AFB3D1
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 15:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A04DA3A54F1
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 13:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1206E29B8D9;
	Mon,  7 Jul 2025 13:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MuU7H2pa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f201.google.com (mail-vk1-f201.google.com [209.85.221.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A9829B79A
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 13:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751893283; cv=none; b=QjGVTH9urJFj1uUAVC/T5MGTxAhQQy2d3nK05t/vF+fiy92FXOhbZBB0CxnVIEfNe1k5kQxcqBK+U87WnTIoJ/0/9Koo9a96CJQvdHiKtyqY0n7mwCQuIrX6i2Koq+rPm6bKG44mSaqV0nZS2K4oeWqtLGVjk8IgKFRAxLsRKeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751893283; c=relaxed/simple;
	bh=xN7PH+gx7yrv+eb1TjOKM1rs027hPtxyxPqc8+VfrMk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MSRNF1Nn+V83As/VE5Ys0mcpngbGOaUdm8puf6r+FumvMD/9vUyBgSBpkovabcXSEhNFS1ZrRoNv8OFHon3vbHA9EOyouB3HH2DRajVOLuo4mHu9dupVT1vwHI/YlXpjKJlx4N/HafuGUPSl+bCG6x6l5RBr4G5RZqxfvlVwI7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MuU7H2pa; arc=none smtp.client-ip=209.85.221.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-vk1-f201.google.com with SMTP id 71dfb90a1353d-531566c838cso1024724e0c.2
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 06:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751893281; x=1752498081; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D0RThV8E210XsUdrwIWl/ua+d+LHkZYLUs+U3xCfFZI=;
        b=MuU7H2paAd046ldzd7coIZs87EnjbeDl4uvhIKkmAS+xFHj6EE1GSWlaaw3r6v8H48
         8DZcdAPE6oaAZ/mM3zBWOiGPrh3HQlw80kaLQKn0UBpbrjntoSF5aUF15OkiOC2lmswM
         WZgi2BAZ0m4Mp/zIcO1DVhAbB97p5fg1GBFx+ppiaOw5h1eTAK5h6yuoNdt4mz8umwwV
         zFV2gYFR8MkILvy2haRV3LCC0GJsrBaHilJgL+Uc9MikLDLBLd8meV52aZwx2WX6dtm1
         3i9pGAD5xuRyBEjAxZh/dQTaMAXyaoBBipMFxUch6MyN2MzU5rfBkbchI7/3glXERJWK
         uAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751893281; x=1752498081;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D0RThV8E210XsUdrwIWl/ua+d+LHkZYLUs+U3xCfFZI=;
        b=KdfY6mjiWSj6I0+0ry7I8+FnPHw8p6ZoMwAIZcutnYk4gRTIFVKFLslw9vqbILyTQY
         gGPZqTah8rhEIpWj2nyMbCp+Qf2U31KVQGJ8rY6KcPZK5ua0Y8misybq+zxPSXiYF+aA
         +qU6uA1CwpdwxsHE9VA+hf6qpFaAgKcLueXDmbX3wx5kGcGC5vTtI9X4pZDNPs3y+Bwm
         ikknyaaw/VP2/7jU1LzohuE09FXbdfRFiIv4cJWxu3/+2ZctURvkJURpcPjkLusDrBWs
         0le+/Mn2GBfuekzzH/v0J6gVaLWD8RoOEVZ6839lA44cNKyFKVz8mHvlM5T3CdbDImuT
         n4dQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtlh5ySm4tIhxQdG12cevuhPEvQxIFz16dJSn1rSFr+VzX8tVCswUR7QepXzkck6cZK2yE7eM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCC5GWExTbrob7eSg+KMEYV2ue21+DWC5eEZPTAbRn7R74ylks
	lIBbDsTN6UWbKMGIEn2NHfcuHtLb2SaPYlmvKzjgy6/OM90DE/QQ/XtLG/zAO8Y5ZmrPog+3kJg
	fZsQigMDPheNJIQ==
X-Google-Smtp-Source: AGHT+IF2Mei1uM8jy+j2EZ4W3JVWZiEzkixDvKr2AuyUCn/cwM3hlDb321dTGJ2NJIvh1t51bqXafFA7SBMD/Q==
X-Received: from vsbhz15.prod.google.com ([2002:a05:6102:4a8f:b0:4e7:bd44:2ecf])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:5813:b0:4e6:f8b0:2dfc with SMTP id ada2fe7eead31-4f305b4e39dmr4008074137.14.1751893281032;
 Mon, 07 Jul 2025 06:01:21 -0700 (PDT)
Date: Mon,  7 Jul 2025 13:01:03 +0000
In-Reply-To: <20250707130110.619822-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250707130110.619822-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250707130110.619822-5-edumazet@google.com>
Subject: [PATCH net-next 04/11] net_sched: act_ct: use RCU in tcf_ct_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Also storing tcf_action into struct tcf_ct_params
makes sure there is no discrepancy in tcf_ct_act().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tc_act/tc_ct.h |  2 +-
 net/sched/act_ct.c         | 30 +++++++++++++++---------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/net/tc_act/tc_ct.h b/include/net/tc_act/tc_ct.h
index e6b45cb27ebf43d6c937fd823767ac1cc9797524..8b90c86c0b0ddd63a3eab7d59328404deb148b10 100644
--- a/include/net/tc_act/tc_ct.h
+++ b/include/net/tc_act/tc_ct.h
@@ -13,7 +13,7 @@ struct tcf_ct_params {
 	struct nf_conntrack_helper *helper;
 	struct nf_conn *tmpl;
 	u16 zone;
-
+	int action;
 	u32 mark;
 	u32 mark_mask;
 
diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index c02f39efc6efead9e18908bdb307872445c6b8fd..6749a4a9a9cd0a43897fcd20d228721ce057cb88 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -977,7 +977,7 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 
 	p = rcu_dereference_bh(c->params);
 
-	retval = READ_ONCE(c->tcf_action);
+	retval = p->action;
 	commit = p->ct_action & TCA_CT_ACT_COMMIT;
 	clear = p->ct_action & TCA_CT_ACT_CLEAR;
 	tmpl = p->tmpl;
@@ -1409,6 +1409,7 @@ static int tcf_ct_init(struct net *net, struct nlattr *nla,
 	if (err)
 		goto cleanup;
 
+	params->action = parm->action;
 	spin_lock_bh(&c->tcf_lock);
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
 	params = rcu_replace_pointer(c->params, params,
@@ -1442,8 +1443,8 @@ static void tcf_ct_cleanup(struct tc_action *a)
 }
 
 static int tcf_ct_dump_key_val(struct sk_buff *skb,
-			       void *val, int val_type,
-			       void *mask, int mask_type,
+			       const void *val, int val_type,
+			       const void *mask, int mask_type,
 			       int len)
 {
 	int err;
@@ -1464,9 +1465,9 @@ static int tcf_ct_dump_key_val(struct sk_buff *skb,
 	return 0;
 }
 
-static int tcf_ct_dump_nat(struct sk_buff *skb, struct tcf_ct_params *p)
+static int tcf_ct_dump_nat(struct sk_buff *skb, const struct tcf_ct_params *p)
 {
-	struct nf_nat_range2 *range = &p->range;
+	const struct nf_nat_range2 *range = &p->range;
 
 	if (!(p->ct_action & TCA_CT_ACT_NAT))
 		return 0;
@@ -1504,7 +1505,8 @@ static int tcf_ct_dump_nat(struct sk_buff *skb, struct tcf_ct_params *p)
 	return 0;
 }
 
-static int tcf_ct_dump_helper(struct sk_buff *skb, struct nf_conntrack_helper *helper)
+static int tcf_ct_dump_helper(struct sk_buff *skb,
+			      const struct nf_conntrack_helper *helper)
 {
 	if (!helper)
 		return 0;
@@ -1521,9 +1523,8 @@ static inline int tcf_ct_dump(struct sk_buff *skb, struct tc_action *a,
 			      int bind, int ref)
 {
 	unsigned char *b = skb_tail_pointer(skb);
-	struct tcf_ct *c = to_ct(a);
-	struct tcf_ct_params *p;
-
+	const struct tcf_ct *c = to_ct(a);
+	const struct tcf_ct_params *p;
 	struct tc_ct opt = {
 		.index   = c->tcf_index,
 		.refcnt  = refcount_read(&c->tcf_refcnt) - ref,
@@ -1531,10 +1532,9 @@ static inline int tcf_ct_dump(struct sk_buff *skb, struct tc_action *a,
 	};
 	struct tcf_t t;
 
-	spin_lock_bh(&c->tcf_lock);
-	p = rcu_dereference_protected(c->params,
-				      lockdep_is_held(&c->tcf_lock));
-	opt.action = c->tcf_action;
+	rcu_read_lock();
+	p = rcu_dereference(c->params);
+	opt.action = p->action;
 
 	if (tcf_ct_dump_key_val(skb,
 				&p->ct_action, TCA_CT_ACTION,
@@ -1579,11 +1579,11 @@ static inline int tcf_ct_dump(struct sk_buff *skb, struct tc_action *a,
 	tcf_tm_dump(&t, &c->tcf_tm);
 	if (nla_put_64bit(skb, TCA_CT_TM, sizeof(t), &t, TCA_CT_PAD))
 		goto nla_put_failure;
-	spin_unlock_bh(&c->tcf_lock);
+	rcu_read_unlock();
 
 	return skb->len;
 nla_put_failure:
-	spin_unlock_bh(&c->tcf_lock);
+	rcu_read_unlock();
 	nlmsg_trim(skb, b);
 	return -1;
 }
-- 
2.50.0.727.gbf7dc18ff4-goog



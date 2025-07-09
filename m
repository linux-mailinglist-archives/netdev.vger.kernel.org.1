Return-Path: <netdev+bounces-205332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C44AFE371
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 11:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C60B748093C
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 09:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01005283FE8;
	Wed,  9 Jul 2025 09:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mwVKjv/M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5143C283FDA
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 09:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051734; cv=none; b=ICXQTH8U+e4RIRQwsUmI+fa8jtJbTAuZYW2GCRs/RLZ6iiYtzwjAGZs0Kpk710rxnDHB892sDiu9qora8huVPyDt9XE/dHoA4EAm182/2/ymx9e0WZ5+eWigI9S048xlhIPmWkM3o9+66J93k9w803NIUH1EpA1L9FA5PLcMWqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051734; c=relaxed/simple;
	bh=xN7PH+gx7yrv+eb1TjOKM1rs027hPtxyxPqc8+VfrMk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TBYOSx0E7K1nHjPct36X/k05WM280N2KicBgR9Snf3SUqycAXz9n4yOXMXiE2r3NobZWgNFRltO/gHrkCsDsE+n0YRQYA7N1cPyNSMfTz4mZJXrpdLgDulmDqsrhf8PBrmPUngtL5eVRmY/e8jwCYI0iy76/76Cojv8GImLOd6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mwVKjv/M; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7d22790afd2so727395985a.2
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 02:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752051732; x=1752656532; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D0RThV8E210XsUdrwIWl/ua+d+LHkZYLUs+U3xCfFZI=;
        b=mwVKjv/MdV9BoycXedIgdNPLFUL8GIH22r7gmLba/MUMWBXJ8A2dB6M3sJp2QhQ23u
         jHJ/ejgH58COfeojkTklWXad8GAjH7JBxg+XWpgm6ByLE+PO4zn45qkXaAct/Jen96yG
         jRvBiffK1QXivbmHL9MRz8dPr/VsrX/tVDMiZxMosU/v+w93psRgbfFeO1wYnvLml+3/
         //3dsm2vkuDccR7QRYYPmmandvP8GkIwZ26fis424TvQuW8DychIC2LcJ1K7fxu9+u6k
         zNse/RBtaSmn1/PVxC84FaeheGxoNHIsRVlKrWYvsOFR2hA0ViJ8amOm3r+e8NMFUaDq
         hs4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752051732; x=1752656532;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D0RThV8E210XsUdrwIWl/ua+d+LHkZYLUs+U3xCfFZI=;
        b=HCIVR+LBB2XRB+O0IR3opdOhdcidhEqiP3SUrvYfqf7qwG8hGvuDX5WhDW1p9RG/Vu
         3elNLp36AqRRqKtovEe4kp7npFL3V7/PG4B77Pg98QKbsMw9t8plad6P+Q4Is0OSgcC9
         YkRAe3HupYKlFLWivthX/bsZXL8kY1JbHsOH2MRyOYkU86WsSz9A/TW/7jCU/uC5DB+X
         /718vUD69F413B8h9VytDxkohS04oqMCrULcXW/kPtysO5wPh8uCMlWqcXdAYiSuGsoY
         4anLVIpB3b97xfUDKBXjepbdhiW8bu+sSiEwKOOcF38u0HknjPlsOEJ+upICCy2MSEJT
         ktOg==
X-Forwarded-Encrypted: i=1; AJvYcCXL/WScknegexm8LjnHj0ENIWUC+wQrDVVBh3rWS08B00vwTCalQyIQA34snsAYP0GV0xT129w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRoY7AAljuRVCDuX6Ca7zbdM3eeM122ayQ3qvX5Mudrv6WNT5N
	CsWJVGC+WCb0/43n/Z5vLBInZ58agEF0rMo53M56HCepJlpfuenpxHs0JwLZc44hPPecjYjZW8x
	X35gebtmtvsoceQ==
X-Google-Smtp-Source: AGHT+IG5ne8duZkEp6m8Q8Qk+/KycGomfgPs+b5sq0ohC9xj1v9m4qE+DG9Rmwi/7nR6iLSOhf3u4xl2yEZqpw==
X-Received: from qknqd16.prod.google.com ([2002:a05:620a:6590:b0:7d0:94e3:1ca1])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4116:b0:7d0:a1c9:65a7 with SMTP id af79cd13be357-7db7fad16damr266148885a.6.1752051732217;
 Wed, 09 Jul 2025 02:02:12 -0700 (PDT)
Date: Wed,  9 Jul 2025 09:01:56 +0000
In-Reply-To: <20250709090204.797558-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709090204.797558-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709090204.797558-5-edumazet@google.com>
Subject: [PATCH v2 net-next 04/11] net_sched: act_ct: use RCU in tcf_ct_dump()
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



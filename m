Return-Path: <netdev+bounces-205334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1A3AFE372
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 11:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E6D562878
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 09:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C03A284672;
	Wed,  9 Jul 2025 09:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IHaTkqw+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9297B283FFB
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 09:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051738; cv=none; b=SjWsURB1bQAtZLMGeWcanR4XrCR44o5c1+OzqW3IHB9uMfPCYJhueXe2tDaBBt13ZBfDLJdMdo7UKUs1lwlik7eqmzAyXdn/wGs4tsxH+yxnAULfRtI1FzHNd5mxv2RC0NqQRTlvjS28rYaKzwsDljSL87PV6Wta15d1u97SYUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051738; c=relaxed/simple;
	bh=/T0HwzI9j8g/SI9eut487Fk66S2bL19IBr5B2TYqgrI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lu2zEkt5Qnz6iK+sj8JorNzkLGR633YTkqAVEVs+Wah3tyy97k8oleTJ+HmbAiXcdfRiVeN7L7K6/hDvzAvAKKV+11zlJ1cWH+nZCaHSAgGtojSBdho98jB/ySzowpnJDpr/pTfSxuFxfEwDrOp5aQe4UqS1QG3QMM+niQpRwwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IHaTkqw+; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-7048088a6fdso25285026d6.1
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 02:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752051735; x=1752656535; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HyAy4rJwM+bYLxcCHmtu4h/+tGct2PyAHPVu6Zt5GA4=;
        b=IHaTkqw+DgjqgUDOzp3IKKoUroaBj6bDxZ4hAdLN4m8zPGcxSlNzQTlMCzFkxfms46
         +TmAnp8XgbK3IWwhqBiDeeW1zO/Ff8syDnkzK2feIeX2LXOJksh1A8vKzB6XapvlCY7W
         XKl5dE4wi6fnRR0Y3YFxlya8y40B1PhIrcQVJ6t4mHUz8MrBk2/JUjrKSHJjk+8x41ZS
         QS2MV3cic5MWmlsBaAs+LZKoEnvsdMqUZmln/04WrT5D76VurnD082rZqQoZMHM04Ngl
         9+jZqbAs/b+qcAqzFmoh4OiUxbwlJumOwybio3m2pm6nKqC4yzYa+Gvtwg1S+mQ5TfHx
         eC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752051735; x=1752656535;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HyAy4rJwM+bYLxcCHmtu4h/+tGct2PyAHPVu6Zt5GA4=;
        b=LY8RFhthXYR8xOACPItB7jfYfelGOs+/QGBCw+Zwxb7M76NOBVlZrHUB/vboDKBJQr
         +3TpmCWw5kaNb8t5IanRCcjeduvnkaoMjwhGU533MSNxs/pkxWDHMRbzaaTPYB6wGfsy
         j0+36BClDlgVNDvZVPWqAEJMY1EJyUNtxWfKABUTTtwIGp3aX7kdNHYGJJ74nakT/djW
         1oRlVag5TF35wbMYpxxmgfFzsFePNv/JThLsaURJhAILyHKPnImFtVADlVEbCEF8qrdY
         L/ysIgtNJPhy1JrxX8MfJ3Ex5ptTF9XLBdq8mAV6d3zL/gFP/CuivkI5xcr7f8HvAPSf
         EHCw==
X-Forwarded-Encrypted: i=1; AJvYcCWmRo19iOFO0p85kiIsbdNAlpWw5GCVVhTLA5Xp2sveaXCUvcQW3SScVPn0IzmvSuqDceWZZ4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1wjc7Rysbpu3U+JV0mx+erKvQqCIsHtzs/DJoaEQSOgdygjJt
	IQMFcoMx8QZJl3V4qSNSeDfUqmjJyJPNahUracHWn/UUmtImhQ3YwvoMrROu6uJ77vX+bbqBYa4
	pd3vE/b1Nopf97Q==
X-Google-Smtp-Source: AGHT+IGq0xs7lYj+zoCeQK5A2dbn2JYj6ygJ3NMO0WzlTalW61Nz0vcsdxWWuneuTbKH0Re8g0cnXlV7dK2Wyw==
X-Received: from qvlh11.prod.google.com ([2002:a0c:f40b:0:b0:702:b452:3d36])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:27e1:b0:6fd:24:b0e0 with SMTP id 6a1803df08f44-7048b940a14mr19566146d6.6.1752051735598;
 Wed, 09 Jul 2025 02:02:15 -0700 (PDT)
Date: Wed,  9 Jul 2025 09:01:58 +0000
In-Reply-To: <20250709090204.797558-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709090204.797558-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709090204.797558-7-edumazet@google.com>
Subject: [PATCH v2 net-next 06/11] net_sched: act_ctinfo: use RCU in tcf_ctinfo_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Also storing tcf_action into struct tcf_ctinfo_params
makes sure there is no discrepancy in tcf_ctinfo_act().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tc_act/tc_ctinfo.h |  1 +
 net/sched/act_ctinfo.c         | 23 +++++++++++------------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/net/tc_act/tc_ctinfo.h b/include/net/tc_act/tc_ctinfo.h
index a04bcac7adf4b61b73181d5dbd2ff9eee3cf5e97..7fe01ab236da4eaa0624db08d0a9599e36820bee 100644
--- a/include/net/tc_act/tc_ctinfo.h
+++ b/include/net/tc_act/tc_ctinfo.h
@@ -7,6 +7,7 @@
 struct tcf_ctinfo_params {
 	struct rcu_head rcu;
 	struct net *net;
+	int action;
 	u32 dscpmask;
 	u32 dscpstatemask;
 	u32 cpmarkmask;
diff --git a/net/sched/act_ctinfo.c b/net/sched/act_ctinfo.c
index 93ab3bcd6d3106a1561f043e078d0be5997ea277..71efe04d00b5c6195e43f1ea6dab1548f6f97293 100644
--- a/net/sched/act_ctinfo.c
+++ b/net/sched/act_ctinfo.c
@@ -88,13 +88,11 @@ TC_INDIRECT_SCOPE int tcf_ctinfo_act(struct sk_buff *skb,
 	struct tcf_ctinfo_params *cp;
 	struct nf_conn *ct;
 	int proto, wlen;
-	int action;
 
 	cp = rcu_dereference_bh(ca->params);
 
 	tcf_lastuse_update(&ca->tcf_tm);
 	tcf_action_update_bstats(&ca->common, skb);
-	action = READ_ONCE(ca->tcf_action);
 
 	wlen = skb_network_offset(skb);
 	switch (skb_protocol(skb, true)) {
@@ -141,7 +139,7 @@ TC_INDIRECT_SCOPE int tcf_ctinfo_act(struct sk_buff *skb,
 	if (thash)
 		nf_ct_put(ct);
 out:
-	return action;
+	return cp->action;
 }
 
 static const struct nla_policy ctinfo_policy[TCA_CTINFO_MAX + 1] = {
@@ -258,6 +256,8 @@ static int tcf_ctinfo_init(struct net *net, struct nlattr *nla,
 		cp_new->mode |= CTINFO_MODE_CPMARK;
 	}
 
+	cp_new->action = actparm->action;
+
 	spin_lock_bh(&ci->tcf_lock);
 	goto_ch = tcf_action_set_ctrlact(*a, actparm->action, goto_ch);
 	cp_new = rcu_replace_pointer(ci->params, cp_new,
@@ -282,25 +282,24 @@ static int tcf_ctinfo_init(struct net *net, struct nlattr *nla,
 static int tcf_ctinfo_dump(struct sk_buff *skb, struct tc_action *a,
 			   int bind, int ref)
 {
-	struct tcf_ctinfo *ci = to_ctinfo(a);
+	const struct tcf_ctinfo *ci = to_ctinfo(a);
+	unsigned char *b = skb_tail_pointer(skb);
+	const struct tcf_ctinfo_params *cp;
 	struct tc_ctinfo opt = {
 		.index   = ci->tcf_index,
 		.refcnt  = refcount_read(&ci->tcf_refcnt) - ref,
 		.bindcnt = atomic_read(&ci->tcf_bindcnt) - bind,
 	};
-	unsigned char *b = skb_tail_pointer(skb);
-	struct tcf_ctinfo_params *cp;
 	struct tcf_t t;
 
-	spin_lock_bh(&ci->tcf_lock);
-	cp = rcu_dereference_protected(ci->params,
-				       lockdep_is_held(&ci->tcf_lock));
+	rcu_read_lock();
+	cp = rcu_dereference(ci->params);
 
 	tcf_tm_dump(&t, &ci->tcf_tm);
 	if (nla_put_64bit(skb, TCA_CTINFO_TM, sizeof(t), &t, TCA_CTINFO_PAD))
 		goto nla_put_failure;
 
-	opt.action = ci->tcf_action;
+	opt.action = cp->action;
 	if (nla_put(skb, TCA_CTINFO_ACT, sizeof(opt), &opt))
 		goto nla_put_failure;
 
@@ -337,11 +336,11 @@ static int tcf_ctinfo_dump(struct sk_buff *skb, struct tc_action *a,
 			      TCA_CTINFO_PAD))
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



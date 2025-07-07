Return-Path: <netdev+bounces-204573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7558AFB3CF
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 15:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50E97423227
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 13:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F28129B766;
	Mon,  7 Jul 2025 13:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nv1Jt8dN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEE529ACDD
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 13:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751893280; cv=none; b=LT3GadvjFJQwz49xybKcI6YEBWmDMsP00Bi1aV+Cr37zEvtwvrH+/w++s5jnxiIQ4yAo2e9f2twND0yt9loacp0QvpPC50JcUnbzdu/HVI9NZEvugblj7b1itaWz4xfY7W1YlJYqToZK6gNNSglN1GG8ZNoqIrbd4h9RAch8mfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751893280; c=relaxed/simple;
	bh=YRCVWNSTqk8nTHsuxVrMx7xFmhTDxLU/ff6LPy1oEr8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kMlV0RA4WM2uTTkfdeh2PuiIAl6foQ7/DOQLv5gf8Dhuij3PVkI2LJMHsN9Ug+OheSFYqCLQivIuGFfg9K82aJoXkFYkujIcbvps9/H+lkKVaYNW78cHkJCMV5EwWvjULALUdk5K9rpMGf9crxq5CUfdm4Rkx4iujJIMSfa8RQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nv1Jt8dN; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4a7f6e08d92so38655131cf.3
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 06:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751893278; x=1752498078; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4EOklmCiEi2XRL3AgJubkAIQFnUMr2uDkKAWTyAPSUo=;
        b=Nv1Jt8dNZj9ZGNtNJVOGZp+kHT2Zj+OjtmHtBxe/D39VzxOxWBTdXB2OcbCuz4edLi
         YZPnPq+QYVKm7UuA4gmWa9DabIy4UfvuexyvWGdDiQk8vpIHhEhui73xIKhQtYXu7RH0
         zroycfhGPERQ/IWkH8ViAZKvHohO+3tdq1Cl20in0jO+44Kow4cKnhUdMoNXCPhjw5E+
         EA5hP1c6SZriVtxhXANu/2rBqk90pTe7nmOCdGUAwdiOlNWCoJY4cxvhcR5EV2l6Ur4E
         BTOdTtSiDGWdPl5bMlh2PTIGOCw0XRR3SG4lHR8DpCVbPN+BSu7O4Xkf/Xrk0A83f6Y0
         4J2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751893278; x=1752498078;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4EOklmCiEi2XRL3AgJubkAIQFnUMr2uDkKAWTyAPSUo=;
        b=GP9btR35vJN26MpORjpfJc6/s31/7EIAKxq18vdNE1OJJR5c1Fo3ooV7wW5sLBL0QW
         SXHFGcjrTBxqAJvUHs5z5B/NND3sBrfyos4r6d2/hLJum9fYzeXk8SmzplXZv9iJuDy0
         olkde6h5k1HFTenq+VVqWvwoDgtXmVWehsX13kQXNGy0AGn4SwrpQ+ga6ruEQ/rfFUDj
         Ugk81sJh4CfbiuwfHube1VqA+gDTL+8SUINiMiBVMla2YS2paIUMo7SuD9ZswWfFlRrG
         /AcOh/gM8LzxXkv2fbVJ45CbankX00YM1AVCun0nLm1DDh8stxU0PnKSlIehKnJ+bSz2
         D/cA==
X-Forwarded-Encrypted: i=1; AJvYcCWx68K2pNcRNPzrFpNm5rh2RVntUHEZrfXmTLHzK7e6KWrB2sHUO/uDHm0/2VbAfluE5THNKyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNaLgksBTSfix8rRxN/5hIXNieolnOkJFeJU5r1Z5yZI+s1AOq
	SheBgUhNmICS0HL5rvcR9XZg1TMpPIDCJ3Qzb6imB4lnOr+Z3fWL1Zz/jrQZ6OcGv7fcrrGzhIJ
	aB9hmr/gYasFSoQ==
X-Google-Smtp-Source: AGHT+IFzvGBMYipMhaLmFk6/wHy0f8PweQrYtUaMePAr4bDf/jgca4pPocq7AuZ7QIBewMen6tbNyCR9+hJ84Q==
X-Received: from qtbck14.prod.google.com ([2002:a05:622a:230e:b0:491:3113:bb68])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:2d0b:b0:4a9:ab9b:65da with SMTP id d75a77b69052e-4a9ab9b6a71mr93162231cf.13.1751893277723;
 Mon, 07 Jul 2025 06:01:17 -0700 (PDT)
Date: Mon,  7 Jul 2025 13:01:01 +0000
In-Reply-To: <20250707130110.619822-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250707130110.619822-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250707130110.619822-3-edumazet@google.com>
Subject: [PATCH net-next 02/11] net_sched: act_connmark: use RCU in tcf_connmark_dump()
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



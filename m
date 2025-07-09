Return-Path: <netdev+bounces-205339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EC3AFE378
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 11:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81122565E17
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 09:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A1F283FCF;
	Wed,  9 Jul 2025 09:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o5JsV314"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F394F2820BA
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 09:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051745; cv=none; b=aAin1waVIHDvaKi7QH324HQWdjIe0D8sV2/27rxjXNuDsTC70cniOjAxo3xrxVLXo4UANykvohSPcZFSJ2s1NmzHaKznIAojhjUrPUZAuL/aVecWL25ifxIO4m59FUTgUi8stKDAw65DfLwJvJkHaAlDANdg92Lyww61j4WnwLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051745; c=relaxed/simple;
	bh=CcejGQ8SHPlI1MV1L5CIzh1g4+lLG87YAF8mEG3K2Kg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BE5rE13n8UNs9GJgHGvkNTl0KvSBDVdQy8idUc27QeBgW2n7YAXAVWJXoXiTGuJF4V5/+8Y8+TvHxIlMpze8a65OijW1JkRpGCtcLlchUJEETmxJnKU5Itw737ahYA8+p6lRTyp+EY9+cMgQeTevvuxjkJ2IqpNJoY0ATedrirY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o5JsV314; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7d40185a630so909648785a.2
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 02:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752051743; x=1752656543; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pzOJVWd/gQVz8kTkQbl/2Rgc6oY4s5cublCArg1AdME=;
        b=o5JsV3140D094Of+EhiTT5F+4cEaxkEX/kQFgObe1CcpmNPgnNWJCZAS7KhgQSWctB
         tmGzJRb1phAraSuLTN7l6jTP7xrxEdu6JZzFbmjg2VDEajrxhtYxYzY9FoUw6gLTokjJ
         FcWw/nN/5r53YhB7OIhN5Fk3yzEc2kU5HUP2SoP2z5dB3dMzrYwIe1CoibS2nGpFboGy
         D7TvSYZ48OJHT34LNUFBGKzhTKWBtO9dfYUDy9+7VJq+SycB0aFB29A9McZmdCTGAjx6
         9+iqFc/s791tlHsvphW/tKQxfWpVIpVv9XGh2J4Ks55z6KvSyghZ61ercxasGftJxpf4
         m0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752051743; x=1752656543;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pzOJVWd/gQVz8kTkQbl/2Rgc6oY4s5cublCArg1AdME=;
        b=LLjwCCOT/hQjgGjpg38fw4ZpzEOx8DofzHhLFGTQ7cuB3a5Yt50DC0EDDqCpCVcub9
         keb5OM0U8Hx/o1QPtJ+AoKJqc5YU/aLzejxSBNQOnC0UXn8pwRIzcANKDE+RifCVCjA9
         GbTDquJ6InS2c8rj/7/5LpxrMJscKJN2SQEJYLECdwqsGJaV4d3XnFR03Qf/LHrjU0Ox
         zKZ7cb7Zncz4C5SN3Svla45AbnypKdG9DhhcCEfxOwL45RxUawppLcVHistxMJ1eVxBe
         tbzatXFhW9TfiC+D2/ynMJ4SRrdd5pAeFDyDT+fK12O5R+1HOhEOdmJQUV115Gg+Anvl
         2xgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUq38gb3MCeE+mUMhjpCLk/TGiPpuVkBmCz22rXKxQD0owfWZKm9imUrPXYbq/OXLB9igi2ie4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx/EaPjiPHoh7OAS30I1ZTXgD20W4hD/JKzHrad2EDUmiWV41E
	dvqez9yxLnzhV9wsYV0uc0xKqmbO0p+Kp0GxO1tejhHVEGyoGvsdQChkrfimIQOM0YNidURbCPd
	A5FVttNPbFhaR7w==
X-Google-Smtp-Source: AGHT+IGLSmxy7f805JQwOeQx5Y9Qqzyo/S/ugm5E7//Fv2BofeTdkE9d1DK3tRqQZ4YFWlOmN3aZg8/W3qY49Q==
X-Received: from qtbbx4.prod.google.com ([2002:a05:622a:904:b0:4a4:350c:ed45])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:192a:b0:7d3:ed55:c92b with SMTP id af79cd13be357-7db7d59d117mr197399385a.38.1752051742980;
 Wed, 09 Jul 2025 02:02:22 -0700 (PDT)
Date: Wed,  9 Jul 2025 09:02:02 +0000
In-Reply-To: <20250709090204.797558-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709090204.797558-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709090204.797558-11-edumazet@google.com>
Subject: [PATCH v2 net-next 10/11] net_sched: act_police: use RCU in tcf_police_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Also storing tcf_action into struct tcf_police_params
makes sure there is no discrepancy in tcf_police_act().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tc_act/tc_police.h |  3 ++-
 net/sched/act_police.c         | 18 +++++++++---------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/net/tc_act/tc_police.h b/include/net/tc_act/tc_police.h
index 490d88cb52338592f57e43fb79d1c6955a9684eb..a89fc8e68b1e4343bb3f6ecfc06737ebbc385f0c 100644
--- a/include/net/tc_act/tc_police.h
+++ b/include/net/tc_act/tc_police.h
@@ -5,10 +5,11 @@
 #include <net/act_api.h>
 
 struct tcf_police_params {
+	int			action;
 	int			tcfp_result;
 	u32			tcfp_ewma_rate;
-	s64			tcfp_burst;
 	u32			tcfp_mtu;
+	s64			tcfp_burst;
 	s64			tcfp_mtu_ptoks;
 	s64			tcfp_pkt_burst;
 	struct psched_ratecfg	rate;
diff --git a/net/sched/act_police.c b/net/sched/act_police.c
index a214ed68114206ed0770725ab91d867bab35aa09..0e1c611833790b4b1d941faf0a05ef1bde2adcb9 100644
--- a/net/sched/act_police.c
+++ b/net/sched/act_police.c
@@ -198,6 +198,7 @@ static int tcf_police_init(struct net *net, struct nlattr *nla,
 		psched_ppscfg_precompute(&new->ppsrate, pps);
 	}
 
+	new->action = parm->action;
 	spin_lock_bh(&police->tcf_lock);
 	spin_lock_bh(&police->tcfp_lock);
 	police->tcfp_t_c = ktime_get_ns();
@@ -254,8 +255,8 @@ TC_INDIRECT_SCOPE int tcf_police_act(struct sk_buff *skb,
 	tcf_lastuse_update(&police->tcf_tm);
 	bstats_update(this_cpu_ptr(police->common.cpu_bstats), skb);
 
-	ret = READ_ONCE(police->tcf_action);
 	p = rcu_dereference_bh(police->params);
+	ret = p->action;
 
 	if (p->tcfp_ewma_rate) {
 		struct gnet_stats_rate_est64 sample;
@@ -338,9 +339,9 @@ static void tcf_police_stats_update(struct tc_action *a,
 static int tcf_police_dump(struct sk_buff *skb, struct tc_action *a,
 			       int bind, int ref)
 {
+	const struct tcf_police *police = to_police(a);
 	unsigned char *b = skb_tail_pointer(skb);
-	struct tcf_police *police = to_police(a);
-	struct tcf_police_params *p;
+	const struct tcf_police_params *p;
 	struct tc_police opt = {
 		.index = police->tcf_index,
 		.refcnt = refcount_read(&police->tcf_refcnt) - ref,
@@ -348,10 +349,9 @@ static int tcf_police_dump(struct sk_buff *skb, struct tc_action *a,
 	};
 	struct tcf_t t;
 
-	spin_lock_bh(&police->tcf_lock);
-	opt.action = police->tcf_action;
-	p = rcu_dereference_protected(police->params,
-				      lockdep_is_held(&police->tcf_lock));
+	rcu_read_lock();
+	p = rcu_dereference(police->params);
+	opt.action = p->action;
 	opt.mtu = p->tcfp_mtu;
 	opt.burst = PSCHED_NS2TICKS(p->tcfp_burst);
 	if (p->rate_present) {
@@ -392,12 +392,12 @@ static int tcf_police_dump(struct sk_buff *skb, struct tc_action *a,
 	tcf_tm_dump(&t, &police->tcf_tm);
 	if (nla_put_64bit(skb, TCA_POLICE_TM, sizeof(t), &t, TCA_POLICE_PAD))
 		goto nla_put_failure;
-	spin_unlock_bh(&police->tcf_lock);
+	rcu_read_unlock();
 
 	return skb->len;
 
 nla_put_failure:
-	spin_unlock_bh(&police->tcf_lock);
+	rcu_read_unlock();
 	nlmsg_trim(skb, b);
 	return -1;
 }
-- 
2.50.0.727.gbf7dc18ff4-goog



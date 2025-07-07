Return-Path: <netdev+bounces-204583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25792AFB3E2
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 15:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCD0A3B8CA4
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 13:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A3129B228;
	Mon,  7 Jul 2025 13:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tosdu6BX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CA029E101
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 13:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751893303; cv=none; b=g0BnZSwH+dT/Q6ly9QQwq3yd/w+XsLhHeVn8lELsO8Gtx395OmRaUXz6s9MesoaPqGx2Ai6MyYU+cwML6VF99L/kXiSx+kOJTn8Q/uIKNi0r3U56Tl63cdEDKJAl24o1GNIiCUJHHsmkHeRckNVbKCLmo/GFbbWXKMt75Srdqk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751893303; c=relaxed/simple;
	bh=mTA1sRCfjgXbB8evkjF9LXlDVrLA79LhcVaKKHlvvk4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cvZp/dYE8LmLWTGsd5EfHzSSknMw2B2tNAgYUrWthHRIWF4LbVnO2cDTPyXyfAjaIesRhh98UO38zABqDsZkWqT3hWW7HwiLMvqe+hkx9wPxlp2QZO8WEUWzKZUdI0xA03n5WfGRS0OZntxqYWOBg92aMVKHeg86G5JmUBMlXI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tosdu6BX; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74928291bc3so2369906b3a.0
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 06:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751893301; x=1752498101; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DfSgLGjtmVvA8Svt0rzS+zJ1B1cOOsJFczkDrXW4SUo=;
        b=tosdu6BXCyBd1AfrHQGE7ts7C0W9p1nT6WABeSVvoZELFamsFGYHjJAFzi1Na4xSxq
         7bjv3N0zH2iYMphe6EDOtioTQELwIIZ2gS4e+SxAQg+9BaxM/b0sTemd1mEpscSE0gLo
         vXSoenMknImnNAPtYpiUQ2mwHg5Y/EaSuZPQ57gVUzM0wuPgJL59IEuvAqJA51yayCSD
         NCj8Z7u3w+1G9Jn3ety2K942UU/FXMJVl+78R7QQwd5FGGYbVrcUZcBJG50GQgfd2Y+w
         8i20FYjsYzTNDs1rzkE0Pv57B9qeqtMODAUAzoj/Ts2TcWCwM4Um/9988wRjjRh6K33H
         HyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751893301; x=1752498101;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DfSgLGjtmVvA8Svt0rzS+zJ1B1cOOsJFczkDrXW4SUo=;
        b=nqTUUoK0SwCO/t6LILe3M3CDGTX5azFL3vR2mZ56s/BLhWy7238LwRb3+uxBKm4DB/
         ZWH/B3eCN/0sIN+DOJM6O9zzHtR5/YSdpG7erGzw5hCLeVEhb8hIZmZpl5cIV76LhgIl
         lK0uz0maymaM8pdbCUJ5VcTIfhaTc3KdNIcSr87TF/MYe+l9MVXRZ9O40MRp/5bSf1UI
         c7N/E3igr7F3PETYvrMNcgA4HpMAyDgYzZlBc/Ocm8GfmDxNx1MyPQ8zMueu1ffoGckB
         k0P0/fhGeGAViLzoGwBCqJXg51wcH09Rzv9JRep4tsvOo5pgDwks+LQUwfJ4w9klNPMH
         T0CQ==
X-Forwarded-Encrypted: i=1; AJvYcCX565CP6dHTe8ohQXYLOVOof0bpCMwGDq2SbkXjjRwacu/E/4lmcv6F06LAGqZ7ZvkfHb7AbBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9I6QmH65B4z4HZpMqMxnMtD6LRSBt5ne8X8sWdkk2c+Cdvann
	Unk8y181X94jyZxUPUszU9b5L2i2ym33yLaiZRvV5uhm7/w0WrNZSlC/kYUQ2v/KxWslgT5FWtg
	gPuFOFIg3Hxkdag==
X-Google-Smtp-Source: AGHT+IHRrx8seyl4I0QB3AMb+fcshReUf9M4Kad+/5GSfS+OaAmeM/Jp9etbmRB6rD8amjMMpdS1RNMUAF7lcA==
X-Received: from vsbke23-n1.prod.google.com ([2002:a05:6102:8197:10b0:4f2:f997:244])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:3ec5:b0:4df:93e0:fb3 with SMTP id ada2fe7eead31-4f305b8b820mr4182353137.20.1751893289759;
 Mon, 07 Jul 2025 06:01:29 -0700 (PDT)
Date: Mon,  7 Jul 2025 13:01:08 +0000
In-Reply-To: <20250707130110.619822-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250707130110.619822-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250707130110.619822-10-edumazet@google.com>
Subject: [PATCH net-next 09/11] net_sched: act_pedit: use RCU in tcf_pedit_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Also storing tcf_action into struct tcf_pedit_params
makes sure there is no discrepancy in tcf_pedit_act().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tc_act/tc_pedit.h |  1 +
 net/sched/act_pedit.c         | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/net/tc_act/tc_pedit.h b/include/net/tc_act/tc_pedit.h
index 83fe3993178180a92d4493ad864b7bada16b1417..f58ee15cd858cf0291565c92a73e35c1f590431b 100644
--- a/include/net/tc_act/tc_pedit.h
+++ b/include/net/tc_act/tc_pedit.h
@@ -14,6 +14,7 @@ struct tcf_pedit_key_ex {
 struct tcf_pedit_parms {
 	struct tc_pedit_key	*tcfp_keys;
 	struct tcf_pedit_key_ex	*tcfp_keys_ex;
+	int action;
 	u32 tcfp_off_max_hint;
 	unsigned char tcfp_nkeys;
 	unsigned char tcfp_flags;
diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index fc0a35a7b62ac7a550f8f03d4a424f7b5ce5b51c..4b65901397a88864014f74c53d0fa00b40ac6613 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -279,7 +279,7 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 	}
 
 	p = to_pedit(*a);
-
+	nparms->action = parm->action;
 	spin_lock_bh(&p->tcf_lock);
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
 	oparms = rcu_replace_pointer(p->parms, nparms, 1);
@@ -483,7 +483,7 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
 bad:
 	tcf_action_inc_overlimit_qstats(&p->common);
 done:
-	return p->tcf_action;
+	return parms->action;
 }
 
 static void tcf_pedit_stats_update(struct tc_action *a, u64 bytes, u64 packets,
@@ -500,19 +500,19 @@ static int tcf_pedit_dump(struct sk_buff *skb, struct tc_action *a,
 			  int bind, int ref)
 {
 	unsigned char *b = skb_tail_pointer(skb);
-	struct tcf_pedit *p = to_pedit(a);
-	struct tcf_pedit_parms *parms;
+	const struct tcf_pedit *p = to_pedit(a);
+	const struct tcf_pedit_parms *parms;
 	struct tc_pedit *opt;
 	struct tcf_t t;
 	int s;
 
-	spin_lock_bh(&p->tcf_lock);
-	parms = rcu_dereference_protected(p->parms, 1);
+	rcu_read_lock();
+	parms = rcu_dereference(p->parms);
 	s = struct_size(opt, keys, parms->tcfp_nkeys);
 
 	opt = kzalloc(s, GFP_ATOMIC);
 	if (unlikely(!opt)) {
-		spin_unlock_bh(&p->tcf_lock);
+		rcu_read_unlock();
 		return -ENOBUFS;
 	}
 	opt->nkeys = parms->tcfp_nkeys;
@@ -521,7 +521,7 @@ static int tcf_pedit_dump(struct sk_buff *skb, struct tc_action *a,
 	       flex_array_size(opt, keys, parms->tcfp_nkeys));
 	opt->index = p->tcf_index;
 	opt->flags = parms->tcfp_flags;
-	opt->action = p->tcf_action;
+	opt->action = parms->action;
 	opt->refcnt = refcount_read(&p->tcf_refcnt) - ref;
 	opt->bindcnt = atomic_read(&p->tcf_bindcnt) - bind;
 
@@ -540,13 +540,13 @@ static int tcf_pedit_dump(struct sk_buff *skb, struct tc_action *a,
 	tcf_tm_dump(&t, &p->tcf_tm);
 	if (nla_put_64bit(skb, TCA_PEDIT_TM, sizeof(t), &t, TCA_PEDIT_PAD))
 		goto nla_put_failure;
-	spin_unlock_bh(&p->tcf_lock);
+	rcu_read_unlock();
 
 	kfree(opt);
 	return skb->len;
 
 nla_put_failure:
-	spin_unlock_bh(&p->tcf_lock);
+	rcu_read_unlock();
 	nlmsg_trim(skb, b);
 	kfree(opt);
 	return -1;
-- 
2.50.0.727.gbf7dc18ff4-goog



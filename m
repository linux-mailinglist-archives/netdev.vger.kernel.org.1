Return-Path: <netdev+bounces-205337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DA6AFE373
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 11:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ED2D7A87B1
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 09:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32556283FD5;
	Wed,  9 Jul 2025 09:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oAMWS7Sk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7591D283FCF
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 09:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051744; cv=none; b=tcyraBauzNOSFxmRAK7B05mBcrv1SF04tXgGujgPsPf3u+YDt3aUGZlCD7zQiKp7niRZnlFjNgjLQSTV0MlwGBerTnL1SIJ1T3+Nd1g93wSQibRT0XPEAaJMcc25NgVvYd59yRabhZCaD2NoZUvhfvnfHedhUuxPYnSVwLnKlqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051744; c=relaxed/simple;
	bh=mTA1sRCfjgXbB8evkjF9LXlDVrLA79LhcVaKKHlvvk4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ij0lOd3hukz+vqLV/rFAoLZqjUrYYCl6CHfmHJ+QdJmEHDeEn+7mfhgQNe+85V2qRXy+uosoTE0G8aPFZPGaJUTuOXxm4jCYvapnvnJesO6BU0yduwVkprY0K6WcX/esqTY2MGP9IYxYiVFBSN8WysvLJp8OZlcaHJukZSqshzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oAMWS7Sk; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7d399065d55so660527585a.1
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 02:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752051741; x=1752656541; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DfSgLGjtmVvA8Svt0rzS+zJ1B1cOOsJFczkDrXW4SUo=;
        b=oAMWS7SkDMvUV0T78FmoC8Ha8FcSrsRYgU9qXnadCuiJn0UijEqxrsq0ulb9QX5OAu
         4O4y8izg6qfc0pdhoEZdqYp7fZcVo0DKhUfcHdfckOCgOsfBahttDF9axmTAiUxG6OHi
         3I/c7sp2IvyfY+TT8jj5SaF31SZW8IdiWP2Ycs17qxibV9zBxUfBlrhAV5TViwKr9cYn
         JNPRhQAgdxufL0y5iLfqA2/VFB2yVRz43TZMIJiDOC2mtbzTS8m6oBOnUx4EFIcrYhm2
         tPyJPtOx+ZtXJ5kXTVMnrxlsVoN+duFscRWkupoRXlSUo+u6Pg7ZVcbFOLwWmEcnbwf0
         h9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752051741; x=1752656541;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DfSgLGjtmVvA8Svt0rzS+zJ1B1cOOsJFczkDrXW4SUo=;
        b=ufkm0t5NvnFChJL3T6Y9EmwyIc2+z2wVBezTON9tFLNCOwdErRK5XUiSjgZIZC58k1
         dzFVnFRJachM8fcqz0pF+6I5pD0N4Fa9/D9UGDOafYg4/9eUDamE7XUISPuJn0FdiQFm
         sAX4w9frqBOhujQbRkJGAfRqfeo2TBKHQNp4wSyRhbmmsQM94HfOn2EdaqwDlZgIuxcf
         My0naLPeAix35JnDqwdH63zWlI7gM0yC7FFjfiJwiQstGyTdAwaXSdQ71BMufk/hMCzw
         5hIPRwj4hyOXDQWv/3saAtqRfTB3zBZPzR+QbebH9bCo27AZOPMWNmwFf+k9g8kyCxji
         b29w==
X-Forwarded-Encrypted: i=1; AJvYcCUQqEvLlcupzMrSiXL9sF5iRDBQypZiy/I2REI97WhRSmHITLocnIsUl6VFa0utpti+iwylsqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEpKvgaP8+Jn6lK2XsLTN9pTj6aSfpp7x61URFyx446puo36wM
	pSAyL/R5l6OoygXRTKPEWO4ZydHLXlJQehyk9S3BHJtE62yZRYBcY90q1IPVr/xtbu70aQsh0WD
	RCHnJpLzGi4MCWg==
X-Google-Smtp-Source: AGHT+IECRagFnfzEu9WKm4HnVcLTlj9haX82Hg13iRwq/qLGhuYJBY9NH97Wr+Lb3v4kQPXX1JmboO3xp6I84g==
X-Received: from qkf16.prod.google.com ([2002:a05:620a:a210:b0:7d0:9d56:8a3e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:684a:b0:7ca:efbd:f4f4 with SMTP id af79cd13be357-7db7db759c3mr274898785a.56.1752051741284;
 Wed, 09 Jul 2025 02:02:21 -0700 (PDT)
Date: Wed,  9 Jul 2025 09:02:01 +0000
In-Reply-To: <20250709090204.797558-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709090204.797558-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709090204.797558-10-edumazet@google.com>
Subject: [PATCH v2 net-next 09/11] net_sched: act_pedit: use RCU in tcf_pedit_dump()
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



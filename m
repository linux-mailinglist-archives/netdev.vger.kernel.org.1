Return-Path: <netdev+bounces-204576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCA6AFB3D6
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 15:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22B823AB103
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 13:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069F629ACDD;
	Mon,  7 Jul 2025 13:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d+/U22BM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B4D299951
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 13:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751893285; cv=none; b=bTIYiSPZveOFsPZ959HklMoYbgdwpvI3GPJH2rM47E9Zj5vzux9+rVW9UZ8AvxROUu0vD8aK7oO3rZpR3JtWunEOcRjS/fBA6VnnRst6S+wpUnfKU2yIz+bmSJ05xgKCN4CeN9p0q8TYysx//KMu++n85oUkmiApXDRy6420h7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751893285; c=relaxed/simple;
	bh=arWgZaEfKbFcoGCkKFMyvqETdMlVAV9+nnDyQa4AQWE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AGRzDfeE+wGh8byBL/ay7JU96F62Pq2YaT3e3+Zy2QigiuTIJHk02zEZqHRHD3UMWCtKOhSTzRcL9w/Z47yiBHPTBoiwze1O64UnIVgXdQJgMyPKkacyZ2qIvwBH+pXC+3m655I7jXPQX4+dP2YW02UfEs7ln60XiTEI0L12Wmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d+/U22BM; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4a9764b4dc9so72855591cf.2
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 06:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751893283; x=1752498083; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xsEdde7gMFaWYqBWhr/9egnzYmnccqlwsELa0pu4i68=;
        b=d+/U22BMJb1KlQYBYUZzluSlnsCEajxDHs6q4uFPNioYmbU9cT9TpWiBq47NX6rEUf
         1VFVLmgpVO4qEmzjzZ9QGhwpDuTp3O4sUSsMf73At2kyURqfuuiwVo7SXroTSH3xfnE/
         IuvChUaB8Izj6f6xKLajz6Yhth6TaOBDKGptRkclkFtu20dYntLTYWYv7BNOh+ij+uQf
         zgaDKuhR7yyA7sbpoqWdWzA/Wuoc3rQ7HnkLv55rURqOi4yLiNWEC5HK6XchSJQA+FS/
         JLNjXwIVLk2nK6h4bgbNPhBB6BqqxPm/1bXt2DhkBzEvvskX/JO9D/7Pb8Bbhb9T9eXF
         niFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751893283; x=1752498083;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xsEdde7gMFaWYqBWhr/9egnzYmnccqlwsELa0pu4i68=;
        b=D9tmVYDeVQ9VKzwe1nCuFjv5Qhde9mIAfZq4f/Zctzg/1PotBSBcmPVvR+0A1H+8E6
         ua9e/7N8M1CAAFTHk6rDdylOuInYojN3aPFdV8ii4cBmnI4fxxMJ6toKS/6eJaxQbhX3
         6ezjG/VrSneyEH88+2ChrqrAJTc87VbKE2xh4ZVHncUyjf9tuALmIBGBK+ljZpzR5n9h
         80jCP28EXK4r6vYOby8DzG6Yj5i3PnxOVE4RSudGaTUb91NVVNYH/r/6y3wEh/dKHE+t
         nhLdqTGmRvtrXd2AN247bbfVoTBZ1srckF6xvLiRoXenPlAUQBEnxVQF/W4EyAJVz4m4
         kDMA==
X-Forwarded-Encrypted: i=1; AJvYcCWmuE9/XkCXa6YzGmqEOoBt2GcgFoSLE+GARlN+q5tbz2AP6dXO337lKIjqF/EzSA1qtborEkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBB8SBBmM6uRKfpQ6nOlBbb2J8JytRvwK/enYPs9QmR5hRXtyn
	6J9RV2MLdXi6+5Eqhfu3lmqTWrYbhi5T6gDsZKJ9gkE/MAyxvdnzagoQk86Nz7Am3XAkM8kSjWV
	IuXT2iwzNYWNGaQ==
X-Google-Smtp-Source: AGHT+IEyIbgXVgwUGQf+ghm6It2zcrh8Op5lLu4RCAN3KW2Cq7tY8wzksAP5WsCh4fCwFX561FYfZ3hwXmZmWA==
X-Received: from qtbbq16.prod.google.com ([2002:a05:622a:1c10:b0:4a9:8fd8:7c37])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:a915:b0:4a9:a90a:7233 with SMTP id d75a77b69052e-4a9a90a85c0mr107167801cf.12.1751893282710;
 Mon, 07 Jul 2025 06:01:22 -0700 (PDT)
Date: Mon,  7 Jul 2025 13:01:04 +0000
In-Reply-To: <20250707130110.619822-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250707130110.619822-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250707130110.619822-6-edumazet@google.com>
Subject: [PATCH net-next 05/11] net_sched: act_ctinfo: use atomic64_t for
 three counters
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"

Commit 21c167aa0ba9 ("net/sched: act_ctinfo: use percpu stats")
missed that stats_dscp_set, stats_dscp_error and stats_cpmark_set
might be written (and read) locklessly.

Use atomic64_t for these three fields, I doubt act_ctinfo is used
heavily on big SMP hosts anyway.

Fixes: 24ec483cec98 ("net: sched: Introduce act_ctinfo action")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Pedro Tammela <pctammela@mojatatu.com>
---
 include/net/tc_act/tc_ctinfo.h |  6 +++---
 net/sched/act_ctinfo.c         | 19 +++++++++++--------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/include/net/tc_act/tc_ctinfo.h b/include/net/tc_act/tc_ctinfo.h
index f071c1d70a25e14a7a68c6294563a08851fbc738..a04bcac7adf4b61b73181d5dbd2ff9eee3cf5e97 100644
--- a/include/net/tc_act/tc_ctinfo.h
+++ b/include/net/tc_act/tc_ctinfo.h
@@ -18,9 +18,9 @@ struct tcf_ctinfo_params {
 struct tcf_ctinfo {
 	struct tc_action common;
 	struct tcf_ctinfo_params __rcu *params;
-	u64 stats_dscp_set;
-	u64 stats_dscp_error;
-	u64 stats_cpmark_set;
+	atomic64_t stats_dscp_set;
+	atomic64_t stats_dscp_error;
+	atomic64_t stats_cpmark_set;
 };
 
 enum {
diff --git a/net/sched/act_ctinfo.c b/net/sched/act_ctinfo.c
index 5b1241ddc75851998d93cd533acd74d7688410ac..93ab3bcd6d3106a1561f043e078d0be5997ea277 100644
--- a/net/sched/act_ctinfo.c
+++ b/net/sched/act_ctinfo.c
@@ -44,9 +44,9 @@ static void tcf_ctinfo_dscp_set(struct nf_conn *ct, struct tcf_ctinfo *ca,
 				ipv4_change_dsfield(ip_hdr(skb),
 						    INET_ECN_MASK,
 						    newdscp);
-				ca->stats_dscp_set++;
+				atomic64_inc(&ca->stats_dscp_set);
 			} else {
-				ca->stats_dscp_error++;
+				atomic64_inc(&ca->stats_dscp_error);
 			}
 		}
 		break;
@@ -57,9 +57,9 @@ static void tcf_ctinfo_dscp_set(struct nf_conn *ct, struct tcf_ctinfo *ca,
 				ipv6_change_dsfield(ipv6_hdr(skb),
 						    INET_ECN_MASK,
 						    newdscp);
-				ca->stats_dscp_set++;
+				atomic64_inc(&ca->stats_dscp_set);
 			} else {
-				ca->stats_dscp_error++;
+				atomic64_inc(&ca->stats_dscp_error);
 			}
 		}
 		break;
@@ -72,7 +72,7 @@ static void tcf_ctinfo_cpmark_set(struct nf_conn *ct, struct tcf_ctinfo *ca,
 				  struct tcf_ctinfo_params *cp,
 				  struct sk_buff *skb)
 {
-	ca->stats_cpmark_set++;
+	atomic64_inc(&ca->stats_cpmark_set);
 	skb->mark = READ_ONCE(ct->mark) & cp->cpmarkmask;
 }
 
@@ -323,15 +323,18 @@ static int tcf_ctinfo_dump(struct sk_buff *skb, struct tc_action *a,
 	}
 
 	if (nla_put_u64_64bit(skb, TCA_CTINFO_STATS_DSCP_SET,
-			      ci->stats_dscp_set, TCA_CTINFO_PAD))
+			      atomic64_read(&ci->stats_dscp_set),
+			      TCA_CTINFO_PAD))
 		goto nla_put_failure;
 
 	if (nla_put_u64_64bit(skb, TCA_CTINFO_STATS_DSCP_ERROR,
-			      ci->stats_dscp_error, TCA_CTINFO_PAD))
+			      atomic64_read(&ci->stats_dscp_error),
+			      TCA_CTINFO_PAD))
 		goto nla_put_failure;
 
 	if (nla_put_u64_64bit(skb, TCA_CTINFO_STATS_CPMARK_SET,
-			      ci->stats_cpmark_set, TCA_CTINFO_PAD))
+			      atomic64_read(&ci->stats_cpmark_set),
+			      TCA_CTINFO_PAD))
 		goto nla_put_failure;
 
 	spin_unlock_bh(&ci->tcf_lock);
-- 
2.50.0.727.gbf7dc18ff4-goog



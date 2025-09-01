Return-Path: <netdev+bounces-218679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BFFB3DE9D
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 11:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6C19168570
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 09:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8BA1DE8BB;
	Mon,  1 Sep 2025 09:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jf6/0GAI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DA7248F66
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 09:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756719105; cv=none; b=lp2aPsB4NC1lDNrcDk/oMn5tbCyPGPP8CUDmqfjLf0IXtkkEdhvGcoAAn0J6USxdhIzoNnS1O7Amyud9gIj415t5HrT4cu/p8lcWekIv8TMuZ2Xorun50ODpwVXmMPgO2Bzr/tGn1CItf5eBeNKH3E5G7PprQ07RiuMd5vqNi+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756719105; c=relaxed/simple;
	bh=bxcbQCnQXh03o1/FieMCgPburpKueLLWlAPBELmu400=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hQPelMF2bCraDwxMxyHMKtvZcvYVrivJb+ec8wLjT+6XBjJAairgLQHICR5jJ7gimJaqAAaVTt6lrk51/Fjg2av/tC/5a3rMvS8MEvnSQcArLDjBS+7jxXxS0AdN5ALFUGDwJjNUOYuZHdK1q98/vljQNO8K5Mob57WUCc/deH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jf6/0GAI; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-80593bfe0a2so5973885a.3
        for <netdev@vger.kernel.org>; Mon, 01 Sep 2025 02:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756719102; x=1757323902; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZAamiYb10AnWbs9ZOo2nG5eTK7QhHxPH56kRc5DdxEw=;
        b=Jf6/0GAIgp1N07rONATv8mTn+Ii8lRmBBu4Dkp7q3JUpd7zcA/t9KS+M3/DZ2CRzFW
         AQEwqLs/w+/4TuHXBIME1Sidt98jWKgOqvtOwpzzhHhJKAm+NI74Cx7VZmDoJZQO5dXw
         zGuyp1tu6XZBt+t0/ADgtzrZLcSSzNeGBXznBwI5TflvXzVrsyzaAuSa/QDd4Sne1ziC
         En4C3teFh3oaglNW6gx7fU8r2t9X7hwmB5kUkTlgkRR8j6xhD1U4hxP+1C82urBYDbk2
         pEXFrDXUWpKNtuyvTE0KQGcFQDFOEwwxLnykacCGSZU3l6HgrO4cL4TNpyeoO8MbuS16
         U8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756719102; x=1757323902;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZAamiYb10AnWbs9ZOo2nG5eTK7QhHxPH56kRc5DdxEw=;
        b=WWTNNYRhz7mcl6mcNRycxguCjTEhtF3qKg/rSBKQX3pBLknErgmlaQHIeNW88pbmkP
         2TGTIbeSayC7WtSH1uYvzvMBUxe5lWaxBJA/HhDMPhnjOlxlzk2X8IW48kPWJm0cHDKq
         gKWi3DqXuXQG8xiqXqyj9SDNDuQ319WmOsca65DJmaWQ30gPq6TohmP5nC/FAVnyXqAc
         A4YXYZRz/6ZSAeRCPow9DlQVgPx1LrgTKWwRxtQUhp7Fw6g7lg4FHgCarqOIkfi2m6Ce
         zu1IwkL80ke/kgZVjVv2Fx6sVBDEUuUprJfJ6nDbcaI8OUgcPRtRdTVMxC1093epGIa/
         jypQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4IX8xuK9gXlPPe0WmPiD18KkwuLUl08bl610GtdtQfw2p50V40AAkapzsVBVWWgyeB7hXQpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnEm0RYhiPzeqcvcaIaxO9H2ofjWFyLvty5zItHF0/6XJ6juL2
	gAexTM7qv80Ci16aOt39eNdCh3eFqsSl8OPmuvYFQTINdpJGbg1h0i4v12LH8tOz47IwSzPEIdF
	nUdOW8pXCXKK+qA==
X-Google-Smtp-Source: AGHT+IGN0iWCSYrcFXOci1dWCHSlyo5xo5/GKZe++yoP2GT05lAw150Ai/h+g9J2hMKaOTqv1BfG2J0lvplJkQ==
X-Received: from qkbee20.prod.google.com ([2002:a05:620a:8014:b0:7f9:7d5a:c1e1])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:3906:b0:7e8:69bc:3446 with SMTP id af79cd13be357-7ff2b0d7812mr736962185a.43.1756719102622;
 Mon, 01 Sep 2025 02:31:42 -0700 (PDT)
Date: Mon,  1 Sep 2025 09:31:41 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250901093141.2093176-1-edumazet@google.com>
Subject: [PATCH net-next] net_sched: act: remove tcfa_qstats
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

tcfa_qstats is currently only used to hold drops and overlimits counters.

tcf_action_inc_drop_qstats() and tcf_action_inc_overlimit_qstats()
currently acquire a->tcfa_lock to increment these counters.

Switch to two atomic_t to get lock-free accounting.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/act_api.h | 14 ++++++--------
 net/sched/act_api.c   | 12 ++++++++----
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 2894cfff2da3..91a24b5e0b93 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -33,7 +33,10 @@ struct tc_action {
 	struct tcf_t			tcfa_tm;
 	struct gnet_stats_basic_sync	tcfa_bstats;
 	struct gnet_stats_basic_sync	tcfa_bstats_hw;
-	struct gnet_stats_queue		tcfa_qstats;
+
+	atomic_t			tcfa_drops;
+	atomic_t			tcfa_overlimits;
+
 	struct net_rate_estimator __rcu *tcfa_rate_est;
 	spinlock_t			tcfa_lock;
 	struct gnet_stats_basic_sync __percpu *cpu_bstats;
@@ -53,7 +56,6 @@ struct tc_action {
 #define tcf_action	common.tcfa_action
 #define tcf_tm		common.tcfa_tm
 #define tcf_bstats	common.tcfa_bstats
-#define tcf_qstats	common.tcfa_qstats
 #define tcf_rate_est	common.tcfa_rate_est
 #define tcf_lock	common.tcfa_lock
 
@@ -241,9 +243,7 @@ static inline void tcf_action_inc_drop_qstats(struct tc_action *a)
 		qstats_drop_inc(this_cpu_ptr(a->cpu_qstats));
 		return;
 	}
-	spin_lock(&a->tcfa_lock);
-	qstats_drop_inc(&a->tcfa_qstats);
-	spin_unlock(&a->tcfa_lock);
+	atomic_inc(&a->tcfa_drops);
 }
 
 static inline void tcf_action_inc_overlimit_qstats(struct tc_action *a)
@@ -252,9 +252,7 @@ static inline void tcf_action_inc_overlimit_qstats(struct tc_action *a)
 		qstats_overlimit_inc(this_cpu_ptr(a->cpu_qstats));
 		return;
 	}
-	spin_lock(&a->tcfa_lock);
-	qstats_overlimit_inc(&a->tcfa_qstats);
-	spin_unlock(&a->tcfa_lock);
+	atomic_inc(&a->tcfa_overlimits);
 }
 
 void tcf_action_update_stats(struct tc_action *a, u64 bytes, u64 packets,
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 9e468e463467..ff6be5cfe2b0 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1585,7 +1585,7 @@ void tcf_action_update_stats(struct tc_action *a, u64 bytes, u64 packets,
 	}
 
 	_bstats_update(&a->tcfa_bstats, bytes, packets);
-	a->tcfa_qstats.drops += drops;
+	atomic_add(drops, &a->tcfa_drops);
 	if (hw)
 		_bstats_update(&a->tcfa_bstats_hw, bytes, packets);
 }
@@ -1594,8 +1594,9 @@ EXPORT_SYMBOL(tcf_action_update_stats);
 int tcf_action_copy_stats(struct sk_buff *skb, struct tc_action *p,
 			  int compat_mode)
 {
-	int err = 0;
+	struct gnet_stats_queue qstats = {0};
 	struct gnet_dump d;
+	int err = 0;
 
 	if (p == NULL)
 		goto errout;
@@ -1619,14 +1620,17 @@ int tcf_action_copy_stats(struct sk_buff *skb, struct tc_action *p,
 	if (err < 0)
 		goto errout;
 
+	qstats.drops = atomic_read(&p->tcfa_drops);
+	qstats.overlimits = atomic_read(&p->tcfa_overlimits);
+
 	if (gnet_stats_copy_basic(&d, p->cpu_bstats,
 				  &p->tcfa_bstats, false) < 0 ||
 	    gnet_stats_copy_basic_hw(&d, p->cpu_bstats_hw,
 				     &p->tcfa_bstats_hw, false) < 0 ||
 	    gnet_stats_copy_rate_est(&d, &p->tcfa_rate_est) < 0 ||
 	    gnet_stats_copy_queue(&d, p->cpu_qstats,
-				  &p->tcfa_qstats,
-				  p->tcfa_qstats.qlen) < 0)
+				  &qstats,
+				  qstats.qlen) < 0)
 		goto errout;
 
 	if (gnet_stats_finish_copy(&d) < 0)
-- 
2.51.0.318.gd7df087d1a-goog



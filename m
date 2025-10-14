Return-Path: <netdev+bounces-229339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 900ADBDAC19
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 19:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 563AC4E74D3
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 17:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B639C304BC3;
	Tue, 14 Oct 2025 17:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q3VfOfJz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAFD30749E
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 17:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760462359; cv=none; b=KdO+IW0fEzisndwoq2eRBhCxrgAPAIITme2i+DJby+GgTMDBwHOineNlAko1qFHdInlylSwky/f+kkTif92039bb5nAqNKU3ktdIYam2ZFYusRPvgE+WybhN0Aly/3mQKI9rfQ+KRWYbv6Qs/2Eo9A+VQaeDonA9LDNywvYPssY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760462359; c=relaxed/simple;
	bh=7uFh6xbzdlqcou4lXrIX7uO5wGGXcv9bVoFvTKjiLQE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rbBIRw7zbF1SAs0ks6ENTuMaMvVngOSp+VzNH11f2oCR/oHblVFXFjD3s+D+Ji2nQ5AUjU8aSjgofYMEAWY95kRMUddzbHz9UbRn+d6MdN4t1G4rVP2PLz3SRH6X8fTHN7HpzpSl2cwtAQ0e5VQGM6FTfyDju4975epi+p8nWDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q3VfOfJz; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8574e8993cbso1182286585a.1
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 10:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760462357; x=1761067157; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ch9uQqLsXQAiGhU0iNfLBFD32J0M6cDjaqgfVFHZaoU=;
        b=Q3VfOfJz2e1PFV3rFawPKrgr71HkCoh623ksSyJQ5ifAu74DdcKd2keiEWf9sbz/jj
         rwhKb2eTMpJFfR6w/7izCvNTZNN6vbBCjNnCfN+JaLUUOl08Q+rlHrzk6D+h7E/JRfIR
         qCNN9acq0L2rBXgO7Ka4gA0e+W+eNk2ndJiutsnSK80+KR8OG6vZiDRkR0vhKtAvI4kv
         s/OwU1l0sqsRR5IppvMCgSz1udpxE8WLWrK/KmE+FARiTXDXioZ9sGWvMnh0C9eWxZR/
         Sh9Y/diYBDI4fFg8NTLdmajn9c4VTekxHxEr3mjwKByGWh9A03MzoYKQBqw8P55JsNkh
         nPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760462357; x=1761067157;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ch9uQqLsXQAiGhU0iNfLBFD32J0M6cDjaqgfVFHZaoU=;
        b=Zp//6IkEpglZud0vM24LLL4hoGYDbeJL8H+cy+vqNOw/0ncz/44OuHcoH18CQiWD5y
         0FywbhUWq95J/9QjLzj65Rh3NKGyMgWZJsYnJqZq17+W+iWYVJRkwXA6iIGr/6Gm0LMe
         DSehWqhKwbM/LGLrfzmjP5KnW4Z3Q0UC9VGrtnAwFfLYdvyVkYB0Iph9SLTN3WrKkuPH
         4ApIgzohX3MF1NrinlwiSKf0hJEKVgS7Th3kpf0uTf5qD66pgDXJuJnWDKeoN7jCL4oW
         JGDbCQqAxFNUYwzblQMzdgd2xRrktsK6sctS6Bcb8mTGQ70Ob4UO81Lx3QYwdlvAvHtu
         Zrxg==
X-Forwarded-Encrypted: i=1; AJvYcCVUZlF/d6v/PIsUVo6iidi4HQEArpXFVV8kJxe/MfdrpMo2eX5L9HcqSPz0hbY4EO5jJTHeQLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH7t5xyZnTR1jXgF7GiCOhZqxQUBzXvSzOXP47H72BEx9+ayNu
	CdPHeFAjN4kjxzH0LONISavIPQje+02Tz/qle/Ibze+lto89gIWBfDyFXd41bVVSqWTZDTWwjle
	xDDqYIQ9tbhifFw==
X-Google-Smtp-Source: AGHT+IFQgqDrUtth1bR20VjxulQjydhT0sTBkjtciw8nd/vefEcduWkU0L8TPXdmk6fyGA3DczKgE17tmXdHjg==
X-Received: from qvboj11.prod.google.com ([2002:a05:6214:440b:b0:827:2fbb:455b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:5915:b0:4d7:b3fa:efae with SMTP id d75a77b69052e-4e6eaccc277mr419696391cf.4.1760462357045;
 Tue, 14 Oct 2025 10:19:17 -0700 (PDT)
Date: Tue, 14 Oct 2025 17:19:06 +0000
In-Reply-To: <20251014171907.3554413-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251014171907.3554413-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251014171907.3554413-6-edumazet@google.com>
Subject: [PATCH v2 net-next 5/6] net: sched: claim one cache line in Qdisc
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Replace state2 field with a boolean.

Move it to a hole between qstats and state so that
we shrink Qdisc by a full cache line.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sch_generic.h | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 32e9961570b4..31561291bc92 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -41,13 +41,6 @@ enum qdisc_state_t {
 	__QDISC_STATE_DRAINING,
 };
 
-enum qdisc_state2_t {
-	/* Only for !TCQ_F_NOLOCK qdisc. Never access it directly.
-	 * Use qdisc_run_begin/end() or qdisc_is_running() instead.
-	 */
-	__QDISC_STATE2_RUNNING,
-};
-
 #define QDISC_STATE_MISSED	BIT(__QDISC_STATE_MISSED)
 #define QDISC_STATE_DRAINING	BIT(__QDISC_STATE_DRAINING)
 
@@ -117,8 +110,8 @@ struct Qdisc {
 	struct qdisc_skb_head	q;
 	struct gnet_stats_basic_sync bstats;
 	struct gnet_stats_queue	qstats;
+	bool			running; /* must be written under qdisc spinlock */
 	unsigned long		state;
-	unsigned long		state2; /* must be written under qdisc spinlock */
 	struct Qdisc            *next_sched;
 	struct sk_buff_head	skb_bad_txq;
 
@@ -167,7 +160,7 @@ static inline bool qdisc_is_running(struct Qdisc *qdisc)
 {
 	if (qdisc->flags & TCQ_F_NOLOCK)
 		return spin_is_locked(&qdisc->seqlock);
-	return test_bit(__QDISC_STATE2_RUNNING, &qdisc->state2);
+	return READ_ONCE(qdisc->running);
 }
 
 static inline bool nolock_qdisc_is_empty(const struct Qdisc *qdisc)
@@ -210,7 +203,10 @@ static inline bool qdisc_run_begin(struct Qdisc *qdisc)
 		 */
 		return spin_trylock(&qdisc->seqlock);
 	}
-	return !__test_and_set_bit(__QDISC_STATE2_RUNNING, &qdisc->state2);
+	if (READ_ONCE(qdisc->running))
+		return false;
+	WRITE_ONCE(qdisc->running, true);
+	return true;
 }
 
 static inline void qdisc_run_end(struct Qdisc *qdisc)
@@ -228,7 +224,7 @@ static inline void qdisc_run_end(struct Qdisc *qdisc)
 				      &qdisc->state)))
 			__netif_schedule(qdisc);
 	} else {
-		__clear_bit(__QDISC_STATE2_RUNNING, &qdisc->state2);
+		WRITE_ONCE(qdisc->running, false);
 	}
 }
 
-- 
2.51.0.788.g6d19910ace-goog



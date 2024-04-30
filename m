Return-Path: <netdev+bounces-92571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F148B7F5A
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 20:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899601F22BED
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 18:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A77018131F;
	Tue, 30 Apr 2024 18:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dk3HxTT0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79171802A0
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 18:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714500019; cv=none; b=i+eoxX1svLbYjOWYFsj9VPLlLAtkuE4179brVWWimja1+9gVhuSGa+EXZQ1z9sVnSKjuiB2foyEBNlr17jIwZVI33lq/oQrrfk0MBNhoXbT75lE+DO/j2XZ93N9sqmyy5dHznUgs8czUCZaIdW+nGsrP6iy48W0sS987Y+BfGX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714500019; c=relaxed/simple;
	bh=7pVLtZdUrvkn8+O5ZsyAet/scEzPUcxIG52l+pyU9l0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aLjEk7tSGdjgpIMT8ljb+M+G/9E3zAjg+7QRcEVY1lunI7q7fuVqVG0am/1o3un4cYpuuuQ3wx9oQArAjK+9zX2to3bwBXSc5oHcuCbnjfu/u2N7lQCqBrnb62aVTxW1EzUmM18Aty7PhTocurFYUo66wxb/SPf7S6OJMLgZ5xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dk3HxTT0; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de45c577ca9so112017276.0
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 11:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714500017; x=1715104817; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JVf34bpt8FapFzqQWdQTWyjytnSA/3+WfkgqAQJPXd8=;
        b=dk3HxTT0gr4u+PIfAwUyRRPDRdezSKXEkZ5aJRBGrObSarM7i2M3MPKil91ft8aHA/
         lMi+fPEty4Efx7EsNjVcCGfO7QhjAB4OOZmDE0Etiof7nBs8v+44tC0skwhXrZiFLcMT
         RqJw/ivfJLgWOzsUmyFqu1fx1lcqwps6YBny1oHsWkq0759DsVg//aTSfHjywtDS+gJg
         CjyqokCwaTmf2it4JIJeIfeeR9BWXCmlk8u4+gu7vdOfm919S8uf0FZmezElOtio3Blw
         g8hrsux1EY1jVTztkFx6bg0XicKhOW3WPV6Ejke3nZFlumAYyX+TC9cdjvNRe3uruiXb
         7+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714500017; x=1715104817;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JVf34bpt8FapFzqQWdQTWyjytnSA/3+WfkgqAQJPXd8=;
        b=uKqbpiaaqB1zn/hWAZ7Er0EG8sTmy1OcAIAT5zRgLyyqkvtD3gUuKNjCXPrlWOy5f/
         0musvQcSPn0w/c2V/A0ZihCzpMc4RPIoFEnOh1r6fZZYQlp5gn5pwJ1YH2F+DCootQda
         poCyagWiI6nhiuLhy7Gs4W0zyrKKbaQN1Pyj7w8NlExbP4sD9tionvu3J4fBfn67yFle
         diQWwLJHrEOcD625gh4QxXBNPjl4pl/boKk9IJ3VJrRawB2GtCjLgb1Cf0MGK8zKwSCt
         cgx58oL7obv+EqUPBjWVzmPAJrlBm9Z29/EkUxI1Eca4kQypDnmUei0fdddacgLWeejE
         tAhA==
X-Forwarded-Encrypted: i=1; AJvYcCV5/KHS+5RsLBB3IsvrmdB4mJYkfpI8AKi0wVuXI7qE1zH+60UwzhyjQP+R9YKh2Yv0OmpJmOhx4sXND4KJ1/NUiPPiZZYI
X-Gm-Message-State: AOJu0YyzdcGsKh6kfM1YFzJIAPuEZ9M4LetBBvh+8KRm5tE7JfjahZ3a
	9ExPbAOaavjgfZgVPXHs8CgraXrSugFLiUOOUcIOWUCO7us4c2urRccFGcJuu62RS7yYtxW7ror
	OJhGCdaZf+A==
X-Google-Smtp-Source: AGHT+IGkOj47kJITUTaQmcI61br9Sx0mNtRe6WH8NQTR7cJyI3hShehQexIzExLu3wAHH1ZOrLYJk42CE20DTQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2b0a:b0:dc6:e884:2342 with SMTP
 id fi10-20020a0569022b0a00b00dc6e8842342mr164644ybb.5.1714500016800; Tue, 30
 Apr 2024 11:00:16 -0700 (PDT)
Date: Tue, 30 Apr 2024 18:00:15 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240430180015.3111398-1-edumazet@google.com>
Subject: [PATCH net-next] net_sched: sch_sfq: annotate data-races around q->perturb_period
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Simon Horman <horms@kernel.org>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

sfq_perturbation() reads q->perturb_period locklessly.
Add annotations to fix potential issues.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_sfq.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index e66f4afb920d28b2fcca1e15634b61ca41ee1bcc..3b9245a3c767a6feed5e06f90459ae896b217c23 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -608,6 +608,7 @@ static void sfq_perturbation(struct timer_list *t)
 	struct Qdisc *sch = q->sch;
 	spinlock_t *root_lock;
 	siphash_key_t nkey;
+	int period;
 
 	get_random_bytes(&nkey, sizeof(nkey));
 	rcu_read_lock();
@@ -618,8 +619,12 @@ static void sfq_perturbation(struct timer_list *t)
 		sfq_rehash(sch);
 	spin_unlock(root_lock);
 
-	if (q->perturb_period)
-		mod_timer(&q->perturb_timer, jiffies + q->perturb_period);
+	/* q->perturb_period can change under us from
+	 * sfq_change() and sfq_destroy().
+	 */
+	period = READ_ONCE(q->perturb_period);
+	if (period)
+		mod_timer(&q->perturb_timer, jiffies + period);
 	rcu_read_unlock();
 }
 
@@ -662,7 +667,7 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt)
 		q->quantum = ctl->quantum;
 		q->scaled_quantum = SFQ_ALLOT_SIZE(q->quantum);
 	}
-	q->perturb_period = ctl->perturb_period * HZ;
+	WRITE_ONCE(q->perturb_period, ctl->perturb_period * HZ);
 	if (ctl->flows)
 		q->maxflows = min_t(u32, ctl->flows, SFQ_MAX_FLOWS);
 	if (ctl->divisor) {
@@ -724,7 +729,7 @@ static void sfq_destroy(struct Qdisc *sch)
 	struct sfq_sched_data *q = qdisc_priv(sch);
 
 	tcf_block_put(q->block);
-	q->perturb_period = 0;
+	WRITE_ONCE(q->perturb_period, 0);
 	del_timer_sync(&q->perturb_timer);
 	sfq_free(q->ht);
 	sfq_free(q->slots);
-- 
2.45.0.rc0.197.gbae5840b3b-goog



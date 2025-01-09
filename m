Return-Path: <netdev+bounces-156820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD33A07E98
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 18:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24E5F3A1156
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE8318B467;
	Thu,  9 Jan 2025 17:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PJN4rsfg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BE916FF4E
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 17:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736443134; cv=none; b=spzfETBc2c4pukF8FQ065G1ocrrs5Hzs41bUiX0LtTGVV0Tz7uKqx2TCs1OowCln8vS7B8cDUbTkOge4ENXkFUWOxGGKFX9LI9LN6+P3TfXPns2/YRINy/ZcaseWXVsBxoJ4R7aer6fkWIgumRJaBD09ZFL5fytJ2fPh145raXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736443134; c=relaxed/simple;
	bh=tk4Qpt07LJmYC9ra8ScQjkjsCcHT9nWuAsQ8rKxNtrM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kSMDyDuNIDgqC9Pu3sCLpZLIup0Jm8SWMqCPJzI0uPfB0a8R3nXWasN4MRjvsDE5awRbZIjob8Baa6ela43Hl5Bw3pYHSAtwG03o3PpzF9JF9D/Q1okF35u4Qt0505QUkdFqQv/rmD+1eM6JSB5Kv/rEjAeFadX1k8CJoJLcHlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PJN4rsfg; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4679becb47eso26178071cf.3
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 09:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736443132; x=1737047932; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5jwJUUjwcXssmk78ksfW5POnnZK3lsT2Fb/MSwHGu5U=;
        b=PJN4rsfgme1GlgnlQBi0/qT9XS8F6tLbA8XYFShO0ClU0TJ3X+7AfMlGqsDk6N+Q+0
         KjSpNghzpXVbPnyRxXhof8eWeXzgl6dRzlUY5zVmLA1fzrDklLgmu1HCvj/9U8Uf/ZHv
         3vqmpJUIETB+4+2PjgNkq1AlBfId9h/07Y8WdjRo3untWfMW+TLLYPD5zzcVcAm0yJ41
         XOvSObbAtzf2mTrrKiYNHSwuaabDa/2hok8TuYsu50tv1GOUORRQF9ox77UPS9l4qmC3
         OrRaiJYrWEhlSNwKcc6LWAPeoV0Tm1B3kXMyHQBe2BuqesNS525e7qQ+wyjbXKUkV8C2
         NG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736443132; x=1737047932;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5jwJUUjwcXssmk78ksfW5POnnZK3lsT2Fb/MSwHGu5U=;
        b=BIhIt50PkxRYOf1JIf4tTRXBvFoAR74dafGKjIJ6U3H1QVJ2rcBDjD7MFLbjSGLPmQ
         mFO/rsO8yJKylF2E1UALzf0Fachq1s7Nu1OTV0aqjOB61xIIWWwcpIIvoQMFgf+lCeZ/
         3Rk7L/yPHza88YmRhVDWjPckLpWAPf2EPqweqk7/AqsTXJcs6tgu2gN5wJKGlb9H/XU+
         e1Gfsn+ZDpdhTPACTNQZnzxwoDEGtcTe4P0Cxo34FzaTPfaQ46ZUw/DjrWU7yrKbozWA
         OL/D8wWmZXlbkJuUkJ+oYIeq2LVBUy9viuKwhf5q0TDvd+6u2qGLNBKMLT+8XfK0CMrO
         EtKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdpJY2MttidIfttRUvCU3J/vc7lwiWD8BR/9KHusg6yEKbGvUp1i1POZ2M+KixX30v8gxLzQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4h7sONqBXgW+h7Xr8kpDJg6/kG7OBFJTMABL2usrTn0eSFPPc
	mwIGnlxmx17s2ke/6XdqQSK6Ni48Jp7uDDs7bp9rSI9yIKkwq1vt1yni2Qyv1L1TU5JZu83ZOv9
	FJwwXMphfAA==
X-Google-Smtp-Source: AGHT+IGUA8TSzWQJYw4iGQr9MnaPXi+zLmqzoYm43PX3m8zC3V0oh2meXuUoCITORnvLb9LiiaJJQ1hjERJkyg==
X-Received: from qtcu6.prod.google.com ([2002:a05:622a:1986:b0:467:84a6:b744])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:58c4:0:b0:467:87f4:a29f with SMTP id d75a77b69052e-46c7108f7acmr124331491cf.45.1736443131865;
 Thu, 09 Jan 2025 09:18:51 -0800 (PST)
Date: Thu,  9 Jan 2025 17:18:50 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250109171850.2871194-1-edumazet@google.com>
Subject: [PATCH net-next] net: sched: calls synchronize_net() only when needed
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

dev_deactivate_many() role is to remove the qdiscs
of a network device.

When/if a qdisc is dismantled, an rcu grace period
is needed to make sure all outstanding qdisc enqueue
are done before we proceed with a qdisc reset.

Most virtual devices do not have a qdisc (if we exclude
noqueue ones).

We can call the expensive synchronize_net() only
if needed.

Note that dev_deactivate_many() does not have to deal
with qdisc-less dev_queue_xmit, as an old comment
was claiming.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_generic.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index bb7dd351bd651d4aa16945816ee26df3c4a48645..14ab2f4c190a1e201dd1788b413a06e799a829f2 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1277,15 +1277,17 @@ static void qdisc_deactivate(struct Qdisc *qdisc)
 
 static void dev_deactivate_queue(struct net_device *dev,
 				 struct netdev_queue *dev_queue,
-				 void *_qdisc_default)
+				 void *_sync_needed)
 {
-	struct Qdisc *qdisc_default = _qdisc_default;
+	bool *sync_needed = _sync_needed;
 	struct Qdisc *qdisc;
 
 	qdisc = rtnl_dereference(dev_queue->qdisc);
 	if (qdisc) {
+		if (qdisc->enqueue)
+			*sync_needed = true;
 		qdisc_deactivate(qdisc);
-		rcu_assign_pointer(dev_queue->qdisc, qdisc_default);
+		rcu_assign_pointer(dev_queue->qdisc, &noop_qdisc);
 	}
 }
 
@@ -1352,24 +1354,22 @@ static bool some_qdisc_is_busy(struct net_device *dev)
  */
 void dev_deactivate_many(struct list_head *head)
 {
+	bool sync_needed = false;
 	struct net_device *dev;
 
 	list_for_each_entry(dev, head, close_list) {
 		netdev_for_each_tx_queue(dev, dev_deactivate_queue,
-					 &noop_qdisc);
+					 &sync_needed);
 		if (dev_ingress_queue(dev))
 			dev_deactivate_queue(dev, dev_ingress_queue(dev),
-					     &noop_qdisc);
+					     &sync_needed);
 
 		netdev_watchdog_down(dev);
 	}
 
-	/* Wait for outstanding qdisc-less dev_queue_xmit calls or
-	 * outstanding qdisc enqueuing calls.
-	 * This is avoided if all devices are in dismantle phase :
-	 * Caller will call synchronize_net() for us
-	 */
-	synchronize_net();
+	/* Wait for outstanding qdisc enqueuing calls. */
+	if (sync_needed)
+		synchronize_net();
 
 	list_for_each_entry(dev, head, close_list) {
 		netdev_for_each_tx_queue(dev, dev_reset_queue, NULL);
-- 
2.47.1.613.gc27f4b7a9f-goog



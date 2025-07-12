Return-Path: <netdev+bounces-206373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7D2B02CE7
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 22:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D86DF4A464E
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 20:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41992225A31;
	Sat, 12 Jul 2025 20:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zCrFmlla"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2272225768
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 20:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752352539; cv=none; b=rZKelsKngC7uPaUwkt5iFYV7cs/xCqiK3vZjFHWU7jBcrBjVu+uEjKgmG8DsU9nXYJtkNwKv7QmUVdlPrFoXZYuGaoE5GO+WigT08qgz4Cf0ldxLm7DZcQC4UPo6c+yEZToTKmFUParmTATI3Jikx3C5H9wJLQmTCbfUwE5daO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752352539; c=relaxed/simple;
	bh=+6cT6LUs9XRny+9irtGaZCZNyXGfv3rNRHAkpEPrhlo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ACcjf1EfpyNEFs99b1+ko8OPi1diY9F3YS6FTgxaFecq+OhYhbTTlXJD4aOjHOCbMQOG3i9S52KK2eXMvktsloGwRUa508qmSz945uOtXM50TboxDJkOL8IKM3vLgZ79PP99c/NPdSvztE4YuJiLB8orNrZvJB9xus09uPwfjEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zCrFmlla; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-748f3613e6aso1493671b3a.0
        for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 13:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752352535; x=1752957335; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pbiNfsxACc2J9LM1Fo9i6oYdRJ/VWalxl1kEf25P/dY=;
        b=zCrFmllaHlzjACnj6pgI0wTD5uv7Dbryw5D4+hT0775ObfvE4t1RAqeZCXYsUvJQW/
         3Rep4elN74fX/v+UoZgULXWI8uVLzGAL3s8Pa8/E5sVK3dOEbftvvQhP94pb51FSxLNG
         mbO+27+eFjJ8/FvIj+xT0oke6zo3vzvvuQYiX2G1VMYbT+nhTssYT/v/7AayxBVpIABJ
         RkGVC0rWNqDkjrfb2hoQNp1EVsSMcCTyUapA1BNnOqotpdj0Od5bzcjyaTFmIX0laj2V
         M8ZuDq6QIc+kQn5c6Xh/bgW29QzoaRw9K7/Lsgo6sTQEZtomDXh3gUisU6EVvdHYz+5u
         urMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752352535; x=1752957335;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pbiNfsxACc2J9LM1Fo9i6oYdRJ/VWalxl1kEf25P/dY=;
        b=BHhENJV13rxyzYrSXDEjFycLBKK5rRwtlkKyPqnQG9dXq/bkRPzU1PZ4xxPdMrOH5x
         lfpUpyNP0047XrOWYRtu4x4EjothchnkhCdJ3Ja6RmAyDyEhSZY5X3M4jn/Wjw1V8bH1
         RMW7LvWuI+X14fVAv74QZQ7OvleExF4FzVzVpakhYNCB72TwyjR5UZpPhtjiKj2I1ahi
         IUSh11ilbZ2KP2OXEmzEdw+YOHvHzsTeVXDxesHbywqtgDuXkDg4hNHsVjVqxi40zo/w
         5kfp6KXhAbVkJI/SVX9JrP02OPx5WuTEeklyL9hw4EEb0SSHCLC8TTkg68QBeHuqRB7s
         m4iw==
X-Forwarded-Encrypted: i=1; AJvYcCUTWvQfX1cSZYwkJu5TK+w2XHl//ZBPZFtA2o2QiZmxBwDU724eFyVq6qviuvCdFIKKfqmzZOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIcC+Ol2kri9TSD9KuYgzkI3+45Ke4kA8N0AE6Y9URZM2mvL40
	pweKpO+bE2BWwBS/4kk7w1HOEj+fYKd/LTA8cGp+Hm8pgYldJjDmyC5VK7TU2mQwuT0E33kkqxy
	m6IYm1w==
X-Google-Smtp-Source: AGHT+IGbSL6iXmOwA1REZLuhaQq2Wy3lPamgAnAvBeEJZEsiAOVBDCiIzymMXM/3WQm+RCoX0tkprenffZM=
X-Received: from pgbfy15.prod.google.com ([2002:a05:6a02:2a8f:b0:b2c:4fcd:fe1b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d84:b0:22f:bba6:5dee
 with SMTP id adf61e73a8af0-23136f6eccemr14733842637.34.1752352534926; Sat, 12
 Jul 2025 13:35:34 -0700 (PDT)
Date: Sat, 12 Jul 2025 20:34:20 +0000
In-Reply-To: <20250712203515.4099110-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250712203515.4099110-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250712203515.4099110-12-kuniyu@google.com>
Subject: [PATCH v2 net-next 11/15] neighbour: Use rcu_dereference() in pneigh_get_{first,next}().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Now pneigh_entry is guaranteed to be alive during the
RCU critical section even without holding tbl->lock.

Let's use rcu_dereference() in pneigh_get_{first,next}().

Note that neigh_seq_start() still holds tbl->lock for the
normal neighbour entry.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/neighbour.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 0109bc712378d..324d61f86208f 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3315,10 +3315,10 @@ static struct pneigh_entry *pneigh_get_first(struct seq_file *seq)
 
 	state->flags |= NEIGH_SEQ_IS_PNEIGH;
 	for (bucket = 0; bucket <= PNEIGH_HASHMASK; bucket++) {
-		pn = rcu_dereference_protected(tbl->phash_buckets[bucket], 1);
+		pn = rcu_dereference(tbl->phash_buckets[bucket]);
 
 		while (pn && !net_eq(pneigh_net(pn), net))
-			pn = rcu_dereference_protected(pn->next, 1);
+			pn = rcu_dereference(pn->next);
 		if (pn)
 			break;
 	}
@@ -3336,17 +3336,17 @@ static struct pneigh_entry *pneigh_get_next(struct seq_file *seq,
 	struct neigh_table *tbl = state->tbl;
 
 	do {
-		pn = rcu_dereference_protected(pn->next, 1);
+		pn = rcu_dereference(pn->next);
 	} while (pn && !net_eq(pneigh_net(pn), net));
 
 	while (!pn) {
 		if (++state->bucket > PNEIGH_HASHMASK)
 			break;
 
-		pn = rcu_dereference_protected(tbl->phash_buckets[state->bucket], 1);
+		pn = rcu_dereference(tbl->phash_buckets[state->bucket]);
 
 		while (pn && !net_eq(pneigh_net(pn), net))
-			pn = rcu_dereference_protected(pn->next, 1);
+			pn = rcu_dereference(pn->next);
 		if (pn)
 			break;
 	}
-- 
2.50.0.727.gbf7dc18ff4-goog



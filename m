Return-Path: <netdev+bounces-206246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C025B02456
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 21:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FF557AD4E2
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 19:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3CA2F3C0D;
	Fri, 11 Jul 2025 19:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Un4doBeb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078912F3C26
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 19:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261028; cv=none; b=DLZu/vh7SM6WwWisNGrUmGV7Vbirqk+ycD6NEu5Wgxd0Sy/wLZuN2aATAXd7OjPscm/8+rVX4PorYYAigMrsE3rWlT9w7Q5abrB+XZAG0nBuO9bVusDipGj4NH/FIMIzgZgUh7h1a8UDFcBYNyMuS7JJ9gz8L0sgISSGjIgJ28Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261028; c=relaxed/simple;
	bh=GQNmKiJKGflQPJ8Eyc2kjfLGZUPYEsGrGNSIAhmN4kI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ie3cpX7qkMvX0b5JytHPOGa9QpayAotqF946voWE8zMRAg51dUVy+7uB5xL9+VC/tvfQu7HyKfXKizqgXlnp8Y/k16VKScb28j0lrKzXxDE9xqxxueHTwo1rqQAUPCJnoW4IG3NL7+ylA23E6N0KmtYnr0coGKETHcH5y5GoRq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Un4doBeb; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b115fb801bcso2481920a12.3
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 12:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752261026; x=1752865826; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f+OAma1lGjnBq7mIzS9D/j4h+VIEu5A1hClhMHQ/gOM=;
        b=Un4doBebN3+kWMACMGO9NpUV6DW3Xsnw6rx+/g8LE0xAOq2XN6nyoyqPvhw0nY/uH/
         8DGCUsnTsv2xGox+2UFjJMDRTQyOYvWhvAjFzf8fVO5JYOOSsjosgaMCUvbCFpG2E67j
         0Meq7egWCM+w2W+V3VTh2cQ6baJvWVC9lCImOQR2qIRncV6odULtIWgbGR0dKK+BeYYv
         SGjSDoVd2DIzksTlt8ypdDzGuhsG95vIpu+0nj7lA+Fjss58kD9Og3LBCFIn7S9NE2IG
         c6LCHgGK6S1F0ylw3/TeGEtUa708lqs2cSRprHgIDchcv/WJiT4Bd6fW4ORNs0DcHNTE
         St9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752261026; x=1752865826;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f+OAma1lGjnBq7mIzS9D/j4h+VIEu5A1hClhMHQ/gOM=;
        b=gJcZrA73uP/UlGT9/iZXxgyOjcx/Nf0wqvtcW4QjUh++r5Z1rxBViPm1DmshHr4vqF
         NHrml8uFLBVi+CxeMDw2BA5P96sM58NQ7z4bMRVhqyPQ3zmcJTswo/frFc9DnsfVwPzJ
         JVE0X7A6lmIcB38B4pF9EOiahYCghD9gNoyr53UUdhcDveD4znbwKNrJ2H5efMSQG1K/
         tKfFtkTzDlaXWZRxZ+wuIXgfOBUwkuGxt8ij0QbWQj0a7Wxby/zsiYUU7YsnWxUSTu2v
         k9tePIl4ILBDjafQdu2BT/FaW58qK/U51AvCF3t0Mkq5kjuyULWqMJ6VJcirv5rpgcbi
         CNyw==
X-Forwarded-Encrypted: i=1; AJvYcCXIKVIeATf326dEjhDG6B2A88ZZe5mnpgp+qPeyE38y4oYkWYrziAoS9SqO0+kDK0TAALj0770=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS6mvfpnc0W0BCRAqkCVr7PCR57LtLxsJ4sClQI9pQE4DP6vY2
	KYveW1d5lm3WOS17STQHMu4PIAq6RBhkFyjGqNOK3291pj6mLHnk2VXSwXiJky7Z81rQMofLAiI
	YhxIhlg==
X-Google-Smtp-Source: AGHT+IHzLma1cQBtdkqjtohQHIYPp2g9nXx+SlQZ0g7PtiXI+dP9rjHf3KqsdIefuZhh2saCQ3qIOA0gcK8=
X-Received: from pjl12.prod.google.com ([2002:a17:90b:2f8c:b0:31c:15e1:d04])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3142:b0:311:b5ac:6f63
 with SMTP id 98e67ed59e1d1-31c4ccea2abmr6431924a91.21.1752261026344; Fri, 11
 Jul 2025 12:10:26 -0700 (PDT)
Date: Fri, 11 Jul 2025 19:06:15 +0000
In-Reply-To: <20250711191007.3591938-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711191007.3591938-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250711191007.3591938-11-kuniyu@google.com>
Subject: [PATCH v1 net-next 10/14] neighbour: Use rcu_dereference() in pneigh_get_{first,next}().
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
index e8ca84e2ddf30..e762e88328255 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3309,9 +3309,9 @@ static struct pneigh_entry *pneigh_get_first(struct seq_file *seq)
 
 	state->flags |= NEIGH_SEQ_IS_PNEIGH;
 	for (bucket = 0; bucket <= PNEIGH_HASHMASK; bucket++) {
-		pn = tbl->phash_buckets[bucket];
+		pn = rcu_dereference(tbl->phash_buckets[bucket]);
 		while (pn && !net_eq(pneigh_net(pn), net))
-			pn = pn->next;
+			pn = rcu_dereference(pn->next);
 		if (pn)
 			break;
 	}
@@ -3329,15 +3329,15 @@ static struct pneigh_entry *pneigh_get_next(struct seq_file *seq,
 	struct neigh_table *tbl = state->tbl;
 
 	do {
-		pn = pn->next;
+		pn = rcu_dereference(pn->next);
 	} while (pn && !net_eq(pneigh_net(pn), net));
 
 	while (!pn) {
 		if (++state->bucket > PNEIGH_HASHMASK)
 			break;
-		pn = tbl->phash_buckets[state->bucket];
+		pn = rcu_dereference(tbl->phash_buckets[state->bucket]);
 		while (pn && !net_eq(pneigh_net(pn), net))
-			pn = pn->next;
+			pn = rcu_dereference(pn->next);
 		if (pn)
 			break;
 	}
-- 
2.50.0.727.gbf7dc18ff4-goog



Return-Path: <netdev+bounces-207628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2036BB08051
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 00:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B69A617A34C
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 22:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23102EF2B8;
	Wed, 16 Jul 2025 22:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WFWpN9cu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8362F2EF656
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 22:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752703961; cv=none; b=ZAEOOeA8aOzqXEbhj1f/KErAEL0kR/pZXV6B6mDTkNe7EzMCFc8AHjATkYkkmjZ4ABE58cafp1FLKqpW+3B6bCD/+feioEaaLmqNG4BGr339V/x4u1Gy+O+9TT/szQYlK949+wr0RVZT31n5wAN9RgBhaT8TqKK8nTUIk6SOy/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752703961; c=relaxed/simple;
	bh=NK1WN0l6I5rqYqZr0oJ70qiY6SjecXp1dy6S2MhflsU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SEkpyFXpcl79z2NVRafUarTVgPiDskDlsGT9b/qkXr9+cUJ23W3CExWeCnzR3iJJDLUOYSXaaKWjh14nSLYTJk2g+tmKRgSf8D83GasYIiWDD3jnnX6OLhALviRGihkM45mGpgfUqh/BvlKVH4a3B0qfEexhr1wxv0zcL8PPF1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WFWpN9cu; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-756a4884dfcso294011b3a.3
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 15:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752703960; x=1753308760; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xHLyR4tLxeFTsSMeh0/QtnlCGGcf+TcqafiqfSBBPic=;
        b=WFWpN9cuDNP/O/UDmSM7mdHIPBjgDePu+5uoOt3mjwS0ZNHLySjSV0J7WteEe8k1H/
         /SZIlAVAOqSsvR1GnQ2o5bvJ8LrKJGtH0zRubAUmOwTmKDCp69lw183Q1PmthbU4Cdvq
         ge4s5owqKLyj3JvAWKCw7+z9z+VVFtu95L1E7sRV5FoJl7fbnobw+KbcxD8npvsvH/Ok
         bqG+LTM90cUO0wSVcLnQcD2pi3L7HJQVEcMrvzgSsgTzyWZUMcx5Nko1fOZclZUFnnK8
         ZSGY0hOyPeMIhOSqq9d/JfwyLFzUPjH0+jP439jfSfDcyWa7VlAkfzCPpHljUy5Np/YZ
         lMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752703960; x=1753308760;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xHLyR4tLxeFTsSMeh0/QtnlCGGcf+TcqafiqfSBBPic=;
        b=pAVWEiS3yq0RcZMY0d4XyYQGai/8rZKXpSmtGhIzh07wGdGdw5qWsnik8agYf8cJ8+
         /jAj8BKTYFcXu9aWrZDgLB/p3+DuQUuO8MBFC2DyQzOJmUVheKISzsQwjq7tLToYj4Cv
         3SMTcABIKYfIuBMAS76FS8hQL8kDCUXBfdRBkBFN1m7mm6KAArsxo05u9kyGAB9XEkNR
         QHlTnEgy9JRfLbEGO/+gHnDW80s1/sxTRbul0A0C7jS4vkjI8XQ3ZHabsjTq0ty7YtfP
         1fF0DPigADaHGl8vJ1wmM/Kk0ubdm7nSPGQfEnLQpRdlgs/dPRSvjM2tmnUSZIHqIHlX
         OrRw==
X-Forwarded-Encrypted: i=1; AJvYcCX77EYdx/YWczGIwXLkxvCtbR248lBOQLJRVSErKCBdH0hKJF75qVn6l2XSmdh4z3NjWN1uTa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUzPC77GBGOchhK42oEFniTm1yVnkm8fIiC2isqJz7dVXdT//u
	MxKAolSjTNnMAPUdwRQATXeAN2nk7Dla0fxsyvb3Y9HhmwGjjyC9r5C7Vnp2sWr4qrvYUID6ymc
	Oe4+/1A==
X-Google-Smtp-Source: AGHT+IGrie2FbsCyOWn0alEJ4ZN/xIS6PIknCaoXLWiwbEWwEg6RTkY2IgzyK6i+S/S6ZmAzQw7pZff87s0=
X-Received: from pfgt20.prod.google.com ([2002:a05:6a00:1394:b0:746:223d:ebdc])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2da4:b0:748:ff4d:b585
 with SMTP id d2e1a72fcca58-75724c8c841mr5903860b3a.19.1752703959686; Wed, 16
 Jul 2025 15:12:39 -0700 (PDT)
Date: Wed, 16 Jul 2025 22:08:16 +0000
In-Reply-To: <20250716221221.442239-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716221221.442239-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716221221.442239-12-kuniyu@google.com>
Subject: [PATCH v3 net-next 11/15] neighbour: Use rcu_dereference() in pneigh_get_{first,next}().
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
index c7e0611219710..27650f52d659d 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3309,10 +3309,10 @@ static struct pneigh_entry *pneigh_get_first(struct seq_file *seq)
 
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
@@ -3330,17 +3330,17 @@ static struct pneigh_entry *pneigh_get_next(struct seq_file *seq,
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



Return-Path: <netdev+bounces-217983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7880DB3AB2C
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 21:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82B387B47E8
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 19:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3EB284B41;
	Thu, 28 Aug 2025 19:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jU8xkjS9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67769286D57
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 19:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756411125; cv=none; b=kDnwCMaLTZAfn+PkJWyZ1HqJAsLGnhmnB9RgMaoi+Ykthm2thp+pbX+kKyeImrYjgUdgxuDiX/qw89UeQpqcDSaVbgi/ZZWPnUxL2/VEjB+HFQn66O81DQDgD2SnUA1b8J6TsrfqgQJVdCm/BL2mb+tVyLuD3OScbdh9cymrXOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756411125; c=relaxed/simple;
	bh=NMeEUqI0pQczDKYu721lGH+O/eveRKEson7BI0BN930=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BfNps6mFagBN6oCUg9+t6Otsycf9KIQv0nhSXfFILLifIfNzLvho1yzdpWyitganqGkvGWYpNd64TB85agHLSTiJbUfneaz+QaAFTBKqkbkxW9cPKpxOR1tMsdcnJZF2vFxQIljbaom6k3RNozgNRsX0qrisRx8lxJ7trrVp/hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jU8xkjS9; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7f7706f53aaso313449885a.2
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 12:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756411123; x=1757015923; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dkNPWhNNxoA5IoCeL6Sn4cst9LatCdEAD1PHmlP2Lk4=;
        b=jU8xkjS9Tm+C5jQCD3n73U3E94a9PNBFL88DlEOt1ymBittBYsN9XGxTC4xZhBZzdm
         1x+tQyG3rVSh0LCN4Dvaq7ccsaIGvM3wS7wq1M9hNb14CRlVL7nO4vPi4VrhQRhqm5Av
         5WbT4mY+1U+HGZXPwn6ycX4H04T3y5XKRvr2ClP7QTuoemGck23NChhQGbkfKlP2zK+a
         nqGUoQnrhvt5xCbhSA9BsYBSBznNu6exWHRaKohQc7pHcvIMURjwgY8yuNYmUiJFOTFK
         Xbldg42z5VGI8UyvLougs/9xnMWJw3Y69CMtX8h5I67xRsR55MdR762Z4urUDo/OZ/dr
         gYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756411123; x=1757015923;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dkNPWhNNxoA5IoCeL6Sn4cst9LatCdEAD1PHmlP2Lk4=;
        b=rDDjMXzsFqGjQBBmkhwhh3o+Nfd+ORgJqlsvcVTbIygkayRIHdRP0rn3zh0WhT2LGg
         M/Q7DjXRVWQsZXnRW+txhdUgz+Dt6OruRMcu5esii9+FXdSmBfR+B3Fhj0wkojKctay7
         TWHaRk2NbYY4HRAGi1Hx4lO8q3aW1RqL8U3TQKPjBwhDRGEBptl+aRVUqFvMMNpLe6fh
         jA85rFHswpSyUiNsbNhtX4WIC2YQaEax00CGnn4o8omoRX9jv6JAM4HJ1IWJhMszEOEU
         5lpj2ZiL9BEbu94brP6RGyOwIaxtXdaLjpEQD9eGPSyGyh46S59OBjk/fMaf6N8S4QHU
         7x/A==
X-Forwarded-Encrypted: i=1; AJvYcCV5/KASJx1CMjRu5KIbGjy4ACar08wMqCzvZuPwbclko3HPnoJN6SQZhCbulkZVB0l69UvGDII=@vger.kernel.org
X-Gm-Message-State: AOJu0YykDPfbdJ7O+B4jXpPW138XnhoRrZARvbCc2NHIFxVOv0sSsVqY
	fjtjjlcBvP1vgx1s5P0qC1wbIv5J2JrylQaglvhgOKpYTYSW4y2Fq/Fnmw8QdHeAKnaKQKunZZS
	wGqC6ul8lk2eKQA==
X-Google-Smtp-Source: AGHT+IGQ5wrBNHZxBxsJ4l9ME7nVCWjabJzzn61kgXfiRf9vV9f6rO4otsNA9AZ1YCAIJsYnoYrCWNPffpiC9g==
X-Received: from qknqj6.prod.google.com ([2002:a05:620a:8806:b0:7e8:4977:2bed])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:7115:b0:7ee:4a7e:e556 with SMTP id af79cd13be357-7ee4a7ee77dmr2338003685a.41.1756411123378;
 Thu, 28 Aug 2025 12:58:43 -0700 (PDT)
Date: Thu, 28 Aug 2025 19:58:21 +0000
In-Reply-To: <20250828195823.3958522-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828195823.3958522-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250828195823.3958522-7-edumazet@google.com>
Subject: [PATCH net-next 6/8] tcp_metrics: use dst_dev_net_rcu()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Replace three dst_dev() with a lockdep enabled helper.

Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_metrics.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index 03c068ea27b6ad3283b8365f31706c11ecdd07f2..10e86f1008e9d9c340eee0ecdefd7f21bd84bd5b 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -170,7 +170,7 @@ static struct tcp_metrics_block *tcpm_new(struct dst_entry *dst,
 	struct net *net;
 
 	spin_lock_bh(&tcp_metrics_lock);
-	net = dev_net_rcu(dst_dev(dst));
+	net = dst_dev_net_rcu(dst);
 
 	/* While waiting for the spin-lock the cache might have been populated
 	 * with this entry and so we have to check again.
@@ -273,7 +273,7 @@ static struct tcp_metrics_block *__tcp_get_metrics_req(struct request_sock *req,
 		return NULL;
 	}
 
-	net = dev_net_rcu(dst_dev(dst));
+	net = dst_dev_net_rcu(dst);
 	hash ^= net_hash_mix(net);
 	hash = hash_32(hash, tcp_metrics_hash_log);
 
@@ -318,7 +318,7 @@ static struct tcp_metrics_block *tcp_get_metrics(struct sock *sk,
 	else
 		return NULL;
 
-	net = dev_net_rcu(dst_dev(dst));
+	net = dst_dev_net_rcu(dst);
 	hash ^= net_hash_mix(net);
 	hash = hash_32(hash, tcp_metrics_hash_log);
 
-- 
2.51.0.318.gd7df087d1a-goog



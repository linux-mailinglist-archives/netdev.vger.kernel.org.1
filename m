Return-Path: <netdev+bounces-160679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE793A1AD20
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 00:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9416E3AE383
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 23:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E6E1D5AB9;
	Thu, 23 Jan 2025 23:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RmGzEgfq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D8E1D54FE
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 23:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737673963; cv=none; b=lhyp1HpW50dyzK/+rY3wBA1SOlRQVm4loQsaESmBVF/5+FhE5Jo6NHPNK3wBrrYjOvMULvgVYSg1b0tUOGfBZDJMQaAiGMx6Y3H8RTnxNaNlkMvuCG8McMc+LKo7brR8Z5/37VzI12QOyvd8l8UbXVoB2qxEfHoOaSWKYQD+YsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737673963; c=relaxed/simple;
	bh=/TSdSsi2B1Xs//iGhQKSjID2cGhxTDaksQdeJMMIQoc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T38ChnZPzxhP8QIg2kRXf5J4i088X6G2sh0XfOG19ZeexVOHX2mYzi+psioXGmpV7bKeXODaJHmITxP9gVQvYkbv0xb6qAH7Wfm9oCmjlFXdQmhe9lzHGJNSBPH2VfYK+1F+LcR8zbWT2h6vMkDG3rUhVDNyY4F+24qzMCJrvc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RmGzEgfq; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2efa74481fdso3038218a91.1
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 15:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737673960; x=1738278760; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6cwA3MrIP+OTaNNbDIH6Ue9DgL0CpRgZj8Iu5e2x/FQ=;
        b=RmGzEgfqvlqv9fo0wgq8T2dTlNR3lAuAUC4J1cH40Afk9ks3cozxv0imQjOVA/HhEd
         6o1J80LKs5+NNo6KrJf0W2CHSX2264Aw15oiAurWMxWR5e2jN38IGelvgnDIRnr4XjJo
         a9ftYgpd7grr8Sx5KC4hJvHuAOhw4U2NAGWq/tWmWqZjAK8o/nXpeUp+zYlX1NMI8lMD
         wA/LuNltMOqfYFTtlksQscoMgBeBCu+klEqc/UUiBAHUt1zVSGoaoZUnquI/xKfLx5pS
         kti1qd1WCwYmopGWoW1dST9KK7thERTq2HhWD6yWkJvJc5WWt6UWeDz1RsqOLPkKmZEB
         E7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737673960; x=1738278760;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6cwA3MrIP+OTaNNbDIH6Ue9DgL0CpRgZj8Iu5e2x/FQ=;
        b=wRBXyF+jyxEL9bQNiqflLzZZaRdb1B1NOGbTh6i0rwy32M4q91peLNcmHObVaok/HB
         wdgYrzrMJZOK/hYekfZpQmlyGXfPG+6WOW79vxdawo5kcJb+doC2vyI12FWSCCnbs8ms
         LDe3Rj7W2wgbI4MvKgbeGHuXCNiye2uMeFeFkhBjIJZlqNYfVEglzqeg3etLOQ+i9ktM
         txeeut6TPcm5s1i/v+aUVDnG23B+Y3lWRKqzhMLSFZHyokZ5rA8mRK9F8xxjkohUL7YD
         g9iQeIGhsSLC50YVVLJMsfk86CtsG8OHr39dOU/It8xFgEcd/P+RSZ/9h5/Z1hbS+Vy/
         gO1g==
X-Gm-Message-State: AOJu0YytH+5jmU1N3jimA7hTfKdRm6xiKK85/O4HgTbBjj3f3IVs0Zn3
	OUY77TwUlwQrc0IZZOo+lI6dBn/Pui6OQSOyuQ68VHM8HviGujnRf97n1KApXJkp9Ck22MRrdoT
	M1f8JkMXXEw==
X-Google-Smtp-Source: AGHT+IFm3kWUgUekI0ubZJ5oGjx7UZidUw/AmU2JmROQnTE3BdT1PbtpMLHANmoBKZblGhHFsJ48t/V3+ty3nw==
X-Received: from pfbea18.prod.google.com ([2002:a05:6a00:4c12:b0:725:ceac:b47e])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:92a0:b0:729:9f1:69bc with SMTP id d2e1a72fcca58-72dafa410aemr40305152b3a.12.1737673960287;
 Thu, 23 Jan 2025 15:12:40 -0800 (PST)
Date: Thu, 23 Jan 2025 23:12:34 +0000
In-Reply-To: <20250123231236.2657321-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250123231236.2657321-1-skhawaja@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250123231236.2657321-3-skhawaja@google.com>
Subject: [PATCH net-next v2 2/4] net: Create separate gro_flush helper function
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com
Cc: netdev@vger.kernel.org, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

Move multiple copies of same code snippet doing `gro_flush` and
`gro_normal_list` into a separate helper function.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 net/core/dev.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 3885f3095873..484947ad5410 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6484,6 +6484,17 @@ static void skb_defer_free_flush(struct softnet_data *sd)
 	}
 }
 
+static void __napi_gro_flush_helper(struct napi_struct *napi)
+{
+	if (napi->gro_bitmask) {
+		/* flush too old packets
+		 * If HZ < 1000, flush all packets.
+		 */
+		napi_gro_flush(napi, HZ >= 1000);
+	}
+	gro_normal_list(napi);
+}
+
 #if defined(CONFIG_NET_RX_BUSY_POLL)
 
 static void __busy_poll_stop(struct napi_struct *napi, bool skip_schedule)
@@ -6494,14 +6505,8 @@ static void __busy_poll_stop(struct napi_struct *napi, bool skip_schedule)
 		return;
 	}
 
-	if (napi->gro_bitmask) {
-		/* flush too old packets
-		 * If HZ < 1000, flush all packets.
-		 */
-		napi_gro_flush(napi, HZ >= 1000);
-	}
+	__napi_gro_flush_helper(napi);
 
-	gro_normal_list(napi);
 	clear_bit(NAPI_STATE_SCHED, &napi->state);
 }
 
@@ -7170,14 +7175,7 @@ static int __napi_poll(struct napi_struct *n, bool *repoll)
 		return work;
 	}
 
-	if (n->gro_bitmask) {
-		/* flush too old packets
-		 * If HZ < 1000, flush all packets.
-		 */
-		napi_gro_flush(n, HZ >= 1000);
-	}
-
-	gro_normal_list(n);
+	__napi_gro_flush_helper(n);
 
 	/* Some drivers may have called napi_schedule
 	 * prior to exhausting their budget.
-- 
2.48.1.262.g85cc9f2d1e-goog



Return-Path: <netdev+bounces-224882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41963B8B3BA
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 22:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20ADA1CC31E6
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 20:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5B12C327E;
	Fri, 19 Sep 2025 20:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tlp/PM5Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C382729B78D
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 20:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758314946; cv=none; b=kaT6Z8P58bPOcLmKMmsJKB3QmDEbMYgMLy24GTfls8tBjLalj3uKdF75njvus72GgymrxFHVwPpFT3y429/cKItEmtg5951DkLGJJkBZoAlWMy9ok1rqA2QBOpSOCkoFzSzl9IiBdDr3+g8lx/MN7TXzwKWXLW8Pg6qsTelCKWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758314946; c=relaxed/simple;
	bh=t+X5CMxa/vOdIIztxMLETAG2QuE8iDANY6RyJJhgLnQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uKXjjf3BZeFgIkAsaQ+HWo5EePBhEggc5S8dw39Br6DTSy4CujT4JrpqmOpvBnAA53t9xtO8GzOsK9/GYIy5MgEuQIGMnzNWVIM8nKNDu+IoThFvzdWJdpgTNNMGotINS16tEAzpnBzQjqphNBD9/CKhvJJiDOFzajTGZDklfkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tlp/PM5Z; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8286b42f46bso506628785a.1
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 13:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758314944; x=1758919744; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EquBz1cdZVbHQrHM782lLsKRU2kCX36ApvHo83LUFGc=;
        b=Tlp/PM5Z2COdVLq4fwT6eteFYnguCEFawX3qR3zxtzU/QNFkytT9zNivtZ/r/YaZYA
         HsfeH0rN90qNnj6p0CQO6aSXdxN47kKJbYAvFvaEdQ1uxNF1hD+qbE78xIjy/+nVQmQJ
         fS7Lcb/4OUcdVzt1IXzA9XqwHkrQECM+jNF5iCNes/R7E2UbykzMAbXYTKcVk0b19sKd
         VXTU5LNaE8/q2FzcHZRQDFKUKPr5dGIglERAFubefSeEUdiucG+6FkWtedXgn4hluox3
         IP3Eu3TcW06O3rykCINiz/LrWtUSRlpfATeFiXD+dzSU/VGY7CyJzUGPXhlKRFmNuRDO
         uNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758314944; x=1758919744;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EquBz1cdZVbHQrHM782lLsKRU2kCX36ApvHo83LUFGc=;
        b=YVQmce3JeZSTePs13RT5+9kmZHMP5JVx9LfFf1U3DoMizXom/p9+Voo5/jHoJDN3ZH
         FqYtHUmP/ji0UN88G7NPIuSrwRJP8CjRfCyEI+x3fvElxYKGylYq9IomJACnZTKbJ4Fr
         XrPUp8JhrPUNZTIeNPkVtAOiaRWcfcvAOk/S7WpHBBMsfxg9WuZVH2s9/NoWqTCQBqL6
         od2zeeJmfKOe0xGUlfXpU4Ptr/FerxRdIQrtCVAyAczs4tBfP/4XJ2bbwJ7sg0usnC2I
         FqLqJ8Ve/SXFzFl5NrAzP7oxGQ4/esBXfqZT/le6JlKhCTtWQRYmgxxeSI873oocoXCG
         +GoQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9nkG47XAS3ofmsa/PHN38BvsRogqttt2aVIXmDsKa9PiNjqhXL6xVlDC44TqZqYb9+RVu7AE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyekdVOlWJWtTmd8X04E3lLJdBeGRZk7zk8GuKbSYpTpashFwdR
	A67ZdU3jGoVZcUvDE9z0CYjARe26uz7EjIA8pnlWz/nKqJIP+/5BXsf//s9NcJbtzuvIIvqE6Fi
	J5KkpjcSQqFNZjA==
X-Google-Smtp-Source: AGHT+IGGDQFxhCPTzADqPjK2XXdKoCXt6CJaVwNGfrazxEobQ93H56K5SdOWI+KdrzwGfIuN4/Q7NeEoR4jzLw==
X-Received: from qkpb17.prod.google.com ([2002:a05:620a:2711:b0:81d:accc:1ff0])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:100e:b0:813:116e:9fc8 with SMTP id af79cd13be357-83ba29b6ab1mr516181685a.17.1758314943643;
 Fri, 19 Sep 2025 13:49:03 -0700 (PDT)
Date: Fri, 19 Sep 2025 20:48:51 +0000
In-Reply-To: <20250919204856.2977245-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919204856.2977245-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919204856.2977245-4-edumazet@google.com>
Subject: [PATCH v2 net-next 3/8] tcp: remove CACHELINE_ASSERT_GROUP_SIZE() uses
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Maintaining the CACHELINE_ASSERT_GROUP_SIZE() uses
for struct tcp_sock has been painful.

This had little benefit, so remove them.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 9b327b6807fc694db249b4bf3521e154db84d11c..5932dba3bd717b59e730630d7390b65f329b03c2 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5101,7 +5101,6 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_tx, notsent_lowat);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_tx, gso_segs);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_tx, retransmit_skb_hint);
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_read_tx, 32);
 
 	/* TXRX read-mostly hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_txrx, tsoffset);
@@ -5112,7 +5111,6 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_txrx, lost_out);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_txrx, sacked_out);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_txrx, scaling_ratio);
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_read_txrx, 32);
 
 	/* RX read-mostly hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, copied_seq);
@@ -5129,9 +5127,6 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, snd_ssthresh);
 #if IS_ENABLED(CONFIG_TLS_DEVICE)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, tcp_clean_acked);
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_read_rx, 77);
-#else
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_read_rx, 69);
 #endif
 
 	/* TX read-write hotpath cache lines */
@@ -5151,7 +5146,6 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, tsorted_sent_queue);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, highest_sack);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, ecn_flags);
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_tx, 97);
 
 	/* TXRX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, pred_flags);
@@ -5172,11 +5166,6 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rx_opt);
 
-	/* 32bit arches with 8byte alignment on u64 fields might need padding
-	 * before tcp_clock_cache.
-	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 107 + 4);
-
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, segs_in);
@@ -5193,7 +5182,6 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_acked);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_est);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcvq_space);
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_rx, 112);
 }
 
 void __init tcp_init(void)
-- 
2.51.0.470.ga7dc726c21-goog



Return-Path: <netdev+bounces-215495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC465B2EE02
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 08:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB271725D6
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 06:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1B8261B82;
	Thu, 21 Aug 2025 06:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o1JmzJXl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4001C35971
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 06:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755756964; cv=none; b=nDTElTDTrtewUymg1gT7udv8+F/pvj5Ah3O6nQFABgd/0bI++3hdjBsVewH1ib+evlK3txye/2r1J6RCfDOfwSu4pvvqiYkrsWWm9ZTT1GbD0rIjmDE4oSapnog7QzkrYIUYZX4R8TpCn6ijJzwGMb91ORyTHAKPhzfd8Ie/PlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755756964; c=relaxed/simple;
	bh=8Qq+gIzConoqMsa75/6iSyrJeOg/gPNUXNIyYWk2Rd8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HYg/V12RqBdOHhTNyiW/CKeX6mfXZg0XkBLuWoUyfPiw2y6MeoDFQlySrr+KJKPuFDYn5TDvoqAjcvZBTV/qhM7pj7tskxB2qEZQQ6ZdK5W+2Tc2wusLWXqFwHdQ0xggvbD7xaky9sfZ1GwO2+c02c/y1QswhQi/i8ZSDLZDY2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o1JmzJXl; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3232677ad11so692161a91.1
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 23:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755756962; x=1756361762; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KOtXyIkvDrXeaTPTWhHuojgRCoBVdIX4dpR+xrdU4/A=;
        b=o1JmzJXlwFYXvjubdTtRVgb6SDYxVIXnqMGAnbm9yyVThGT0/MawJyQ8R2NlMRp52f
         QjDSJfLB445GtOQpyQ/gaZtgLbC1yrTmRVF61dGJPGw322+YdNzF22OghtGrjf+O9aYv
         3skjyUi/9NkeJWgaRr2UnEPBD2mnx9N6/4ARBi6Y3pl3nSX48EgsrqOp1dssnbvIFCdL
         tpB6R53qyRtebLsTrpLHwF0eyfQt+OUrdSOIRph0B9qfaa1A9Io9ncYepwG2XQZnKmD4
         GA0Z/WmbMctU0NAFPttC39S6GtEM6N00y31R6KslaF9dyIb2yOzXrD1wuux23S0dx/tv
         7ZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755756962; x=1756361762;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KOtXyIkvDrXeaTPTWhHuojgRCoBVdIX4dpR+xrdU4/A=;
        b=HLKoGpl03xEVu1mZgUSIkP1KwOKH22cKy5Y8S5SggqwXX+JQ3JH4uZjCUH8C7gju8N
         UrcjbR5OIDIB2rD2CbV3fXt7mB5GmhBlvfCUKLkIfGAls/Bqg2y1OH/XbYh4zkAI1kQD
         ypUzJleUQ3Ypbit9Zb3GbK4bkPqiA2BUkT546qiS26nWbv6mGy0gkyproATB6U2atuCJ
         Wv3EaLt8FwYf4BVYQmIyAsvlRfAaIrWF3Ru3v4e6pQV+SqqZSH8uQUitgVQzqA5fFRdt
         M1+6QY3WeW4Px2ff6RE3qs+XMOsBKXBNF0sqiBjDYV5GQYGtQAW/oAjiah+j6DBWTEMu
         2Uxw==
X-Forwarded-Encrypted: i=1; AJvYcCW4nDQR952DQArwdAal/sNa9tJnzzX1hJf0nAMGtVSsSY3p2VN2GUh6R61qZMR/ULMD7frT4eY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUKIkIRs8cuOs7vPZ5zIL1++KsUJKq0gBGYqjpu7NFfRpg9WV+
	hPMGGjYlzBMOwK/BpOTQ6skSfpPah0oTMc5wCCR5S+0A9Nk1ZT1YEdu7icgccnMPgqnlzHcdcJP
	WnNzr+g==
X-Google-Smtp-Source: AGHT+IEiB0Gx9T2peCI88U05qaHFshMqtj8EH1/DPg9utbSspBxePjIoGrQKBIlxhowQe+K02/KCfXuhkCI=
X-Received: from pjbee11.prod.google.com ([2002:a17:90a:fc4b:b0:312:187d:382d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:38c6:b0:31e:9cdb:32df
 with SMTP id 98e67ed59e1d1-324ed09777dmr2106993a91.10.1755756962520; Wed, 20
 Aug 2025 23:16:02 -0700 (PDT)
Date: Thu, 21 Aug 2025 06:15:13 +0000
In-Reply-To: <20250821061540.2876953-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821061540.2876953-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821061540.2876953-3-kuniyu@google.com>
Subject: [PATCH v1 net-next 2/7] tcp: Save __module_get() for TIME_WAIT sockets.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"

From: Kuniyuki Iwashima <kuniyu@amazon.com>

__module_get() in inet_twsk_alloc() was necessary to prevent
unloading tw->tw_prot, which is used in inet_twsk_free().

DCCP has gone, and TCP is built-in, so the pair is no longer needed.

ULPs also do not need it because

 * kTLS and XFRM_ESPINTCP restore sk_prot before close()
 * MPTCP is built-in
 * SMC uses TCP as is

, but using tw_prot without module_get() would be error prone to
future ULP addition.

Now we can use kfree() without the slab cache pointer thanks to SLUB.

Let's use kfree() in inet_twsk_free() and remove 2 atomic ops
for each connection.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/inet_timewait_sock.h | 1 -
 net/ipv4/inet_timewait_sock.c    | 7 +------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewait_sock.h
index 67a313575780..500a0478370f 100644
--- a/include/net/inet_timewait_sock.h
+++ b/include/net/inet_timewait_sock.h
@@ -48,7 +48,6 @@ struct inet_timewait_sock {
 #define tw_tx_queue_mapping	__tw_common.skc_tx_queue_mapping
 #define tw_rx_queue_mapping	__tw_common.skc_rx_queue_mapping
 #define tw_hash			__tw_common.skc_hash
-#define tw_prot			__tw_common.skc_prot
 #define tw_net			__tw_common.skc_net
 #define tw_daddr        	__tw_common.skc_daddr
 #define tw_v6_daddr		__tw_common.skc_v6_daddr
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 875ff923a8ed..024463a3e696 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -73,10 +73,8 @@ static void inet_twsk_kill(struct inet_timewait_sock *tw)
 
 void inet_twsk_free(struct inet_timewait_sock *tw)
 {
-	struct module *owner = tw->tw_prot->owner;
 	twsk_destructor((struct sock *)tw);
-	kmem_cache_free(tw->tw_prot->twsk_prot->twsk_slab, tw);
-	module_put(owner);
+	kfree(tw);
 }
 
 void inet_twsk_put(struct inet_timewait_sock *tw)
@@ -206,7 +204,6 @@ struct inet_timewait_sock *inet_twsk_alloc(const struct sock *sk,
 		tw->tw_hash	    = sk->sk_hash;
 		tw->tw_ipv6only	    = 0;
 		tw->tw_transparent  = inet_test_bit(TRANSPARENT, sk);
-		tw->tw_prot	    = sk->sk_prot_creator;
 		atomic64_set(&tw->tw_cookie, atomic64_read(&sk->sk_cookie));
 		twsk_net_set(tw, sock_net(sk));
 		timer_setup(&tw->tw_timer, tw_timer_handler, 0);
@@ -216,8 +213,6 @@ struct inet_timewait_sock *inet_twsk_alloc(const struct sock *sk,
 		 * timewait socket.
 		 */
 		refcount_set(&tw->tw_refcnt, 0);
-
-		__module_get(tw->tw_prot->owner);
 	}
 
 	return tw;
-- 
2.51.0.rc1.193.gad69d77794-goog



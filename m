Return-Path: <netdev+bounces-100848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 197228FC44F
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C08D1F26DA1
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 07:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C568C18F2E1;
	Wed,  5 Jun 2024 07:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3fkx972n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7C919148A
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 07:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717571764; cv=none; b=HjJ7vp64k9Icv55zwMlnRgNMHYEbx3V6j2kFdpUdv4MLMpJi+JiC0FfKkSQUM6YZ40xGMqziWc4klS/lxzu6LLzn32rnCe/BwdZ459qEzkbfJC5Lt3qWMhquPfY63+D0l1dy5+RlmSKSOqyslZE/vabaJI/arsIcuoRfHUNvSsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717571764; c=relaxed/simple;
	bh=WIAsTRlTcqwPIt+nbXduoXTeM8XuXQkgvEZz7rh7T8o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IrJULrVOCmDMyP8FryuAPLFqjSfmfbRhgA0owSH5hNz93bP6I9OkOwsg/WstaATI1dtZvQYCfW3NVIgwBCFTf7AIHtIa626qmVKN+iwyDip/ou24DTNTv0scsm44NZns1CZdDGsbMdbn8MXy7c7dzWTK64dx65Lf/vr8h2PF6LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3fkx972n; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-df7bdb0455bso3122857276.2
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 00:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717571762; x=1718176562; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XohALCxhIQuxmdqn4ziWm9Xd66SL12SuMLJAdzpuJIc=;
        b=3fkx972n64qTlK0H9WDZY/3j2ozF6pXNBBa/VFD9sYDHt7m+pXr5qi542hjLRypT38
         dY7T/7hGOMd6YBBVpO/o7mUrUKtv8U5jnPEt+wJXvTV4gL1QDToTmmiH/u/IL5FeM8Yd
         qkTpy3eqiHwsav2NezfTrgGNOqJB5y92dV1NL50odOhaszy+UQXQ+DHHKRqPXxzh48p9
         wJMrTfV0gbZoJfRKQdEoN+2GMkzFvC2EVBM8cvWyreiHgqHaf2UEaU/xQPOQsnqs1gwt
         ZkI5xcmDw71ZyuNkjMxHmWpeJLDYsUCem9yqFa7rLbrhCaHMDQO6hxdWs0SnZ6OpAuyk
         i84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717571762; x=1718176562;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XohALCxhIQuxmdqn4ziWm9Xd66SL12SuMLJAdzpuJIc=;
        b=bhActlvoJAh66O024cgpli0rq0/49w2eUNrnAIfVqUkR1nEwb1MMvwMllk1Qsk71+j
         uzcb92H5IJ9WW40bPzfyOvQ0A3X5aX+KXinIVnfF96ovo+m+b5tBFaJG35OFSbpllf4v
         50yd3TAFKzKJIKZ6vIBLRbFY1UE+f2BYoUnANaEZY07RGl8gbcuqSZwzztPR6lnDKQ7e
         e2qV9B3KEk/n15JRGwLygfv+WaKU9Z5o9knCYfnrgA9lgi+a/rdp9kitJSQjVgsSaZ7U
         Cz42PaRkjIfzVjB512uRSrSGSeuPMjbNyZv7grUGH1cWrnl8sKq/aK5jSK1KWkPaJRug
         Nc6g==
X-Gm-Message-State: AOJu0YymlAoErfdTo0ekyRP0agv4S0Z5hrgLG0rH6jyGsLML1VBMASma
	o8Aov5wAGsBImn98+MygFOP4yfUjP/ZIR/FDEcimMdyyM1obfG6JS7KQVwr2UZJWOmWjoAycWuK
	n31D7uKeARg==
X-Google-Smtp-Source: AGHT+IEuV2lMLWeb9M043lMbtWKUml0I0/5PYkFyoRmCZ1OV+cq8p/mbf8eMFwmBZKrlq7fbqNRoUAEsS0lEzw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1244:b0:dfa:cd81:4c6a with SMTP
 id 3f1490d57ef6-dfacd815034mr64722276.6.1717571762161; Wed, 05 Jun 2024
 00:16:02 -0700 (PDT)
Date: Wed,  5 Jun 2024 07:15:53 +0000
In-Reply-To: <20240605071553.1365557-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240605071553.1365557-1-edumazet@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240605071553.1365557-4-edumazet@google.com>
Subject: [PATCH net-next 3/3] tcp: move reqsk_alloc() to inet_connection_sock.c
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

reqsk_alloc() has a single caller, no need to expose it
in include/net/request_sock.h.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/request_sock.h      | 33 ---------------------------------
 net/ipv4/inet_connection_sock.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/include/net/request_sock.h b/include/net/request_sock.h
index a8f82216c628..b07b1cd14e9f 100644
--- a/include/net/request_sock.h
+++ b/include/net/request_sock.h
@@ -128,39 +128,6 @@ static inline struct sock *skb_steal_sock(struct sk_buff *skb,
 	return sk;
 }
 
-static inline struct request_sock *
-reqsk_alloc_noprof(const struct request_sock_ops *ops, struct sock *sk_listener,
-	    bool attach_listener)
-{
-	struct request_sock *req;
-
-	req = kmem_cache_alloc_noprof(ops->slab, GFP_ATOMIC | __GFP_NOWARN);
-	if (!req)
-		return NULL;
-	req->rsk_listener = NULL;
-	if (attach_listener) {
-		if (unlikely(!refcount_inc_not_zero(&sk_listener->sk_refcnt))) {
-			kmem_cache_free(ops->slab, req);
-			return NULL;
-		}
-		req->rsk_listener = sk_listener;
-	}
-	req->rsk_ops = ops;
-	req_to_sk(req)->sk_prot = sk_listener->sk_prot;
-	sk_node_init(&req_to_sk(req)->sk_node);
-	sk_tx_queue_clear(req_to_sk(req));
-	req->saved_syn = NULL;
-	req->syncookie = 0;
-	req->timeout = 0;
-	req->num_timeout = 0;
-	req->num_retrans = 0;
-	req->sk = NULL;
-	refcount_set(&req->rsk_refcnt, 0);
-
-	return req;
-}
-#define reqsk_alloc(...)	alloc_hooks(reqsk_alloc_noprof(__VA_ARGS__))
-
 static inline void __reqsk_free(struct request_sock *req)
 {
 	req->rsk_ops->destructor(req);
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index a9d2e6308910..7ced569778ab 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -911,6 +911,39 @@ int inet_rtx_syn_ack(const struct sock *parent, struct request_sock *req)
 }
 EXPORT_SYMBOL(inet_rtx_syn_ack);
 
+static struct request_sock *
+reqsk_alloc_noprof(const struct request_sock_ops *ops, struct sock *sk_listener,
+		   bool attach_listener)
+{
+	struct request_sock *req;
+
+	req = kmem_cache_alloc_noprof(ops->slab, GFP_ATOMIC | __GFP_NOWARN);
+	if (!req)
+		return NULL;
+	req->rsk_listener = NULL;
+	if (attach_listener) {
+		if (unlikely(!refcount_inc_not_zero(&sk_listener->sk_refcnt))) {
+			kmem_cache_free(ops->slab, req);
+			return NULL;
+		}
+		req->rsk_listener = sk_listener;
+	}
+	req->rsk_ops = ops;
+	req_to_sk(req)->sk_prot = sk_listener->sk_prot;
+	sk_node_init(&req_to_sk(req)->sk_node);
+	sk_tx_queue_clear(req_to_sk(req));
+	req->saved_syn = NULL;
+	req->syncookie = 0;
+	req->timeout = 0;
+	req->num_timeout = 0;
+	req->num_retrans = 0;
+	req->sk = NULL;
+	refcount_set(&req->rsk_refcnt, 0);
+
+	return req;
+}
+#define reqsk_alloc(...)	alloc_hooks(reqsk_alloc_noprof(__VA_ARGS__))
+
 struct request_sock *inet_reqsk_alloc(const struct request_sock_ops *ops,
 				      struct sock *sk_listener,
 				      bool attach_listener)
-- 
2.45.2.505.gda0bf45e8d-goog



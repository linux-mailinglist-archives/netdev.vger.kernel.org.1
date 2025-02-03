Return-Path: <netdev+bounces-162110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1F1A25CDA
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 15:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEE441885C6C
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 14:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F274020E307;
	Mon,  3 Feb 2025 14:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ORNt+o9z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532DB20E014
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 14:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593056; cv=none; b=PEtyrzmXtzwJzjzMitUEVuXr640FmDNAtTtZ4j9u9U5GfC1WOUD/7mKqKdUDEe/L5z3NGBSXsBwNnulgDITqCERL1RHYZRzrXfYMfS7QNyv68holCILlqafOZXScafLwN2lot4389gH2hC4p1d4rmoLrJyYLGErmzbJMZ8h7/Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593056; c=relaxed/simple;
	bh=H8JH/QPjFfGxbrJtRbDkCum9cREuE5YKVIPC//b1qCs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LFyK+VQoL26URaE5ADff6Nw7pdbjmMuRg3zRJjhP2J+M0RqAvC+1L9LYwRsgy8PZYoqbm59I0aoML4QEV/7s9LxDxMKnvb9Xfb47Vt3JXuTuKqia+o7PfrMbWIPE062LxavX5MKvXZjqFPaT+L26Y61F+tb7W1DG9Xj6YJAicgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ORNt+o9z; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-46dd301a429so95543511cf.1
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 06:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738593054; x=1739197854; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oummPnO89bchIzAktiowh3Jl3EZAt201EnCE7gdN6jc=;
        b=ORNt+o9zNiB5qjfH6HEHOfKX3/EDhOXZ2UGkfz0q8va5LSkzUKi8KTuPyf3ZsI6iIR
         ZkzJ2LOWzqFzSosOw/xrE6p64e81R6CGN2JpmMwE54J85m9oFqQMln7TgIi9He9T65ct
         dK/3lN4voLfqJV9ih0cCmt0qqjqJRy5uA1FA/maTuFXv5dTy26fb+awHld5kRxoDBV1u
         w07LRIxpR/+1QzwiG5vTQ6a603wUmFhezNAoZxPlV5krUK7WrDU0I+cYXv92AQMeViBs
         uuWAi/wMizhZQhm9D492hby3vId2NGEz0wsxooBtxlUw1n/tdh0QfTE2m/emQBiXiMWh
         bcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738593054; x=1739197854;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oummPnO89bchIzAktiowh3Jl3EZAt201EnCE7gdN6jc=;
        b=X3uFdBIJTZBZATnAPWbd2j9uvoj4BHhJ9e5og7yEHAtPKBKoTQafJzMC2n7meVtKzS
         ZxGQJUcQc90/3taEidw0qot8kmrjyw0Hn32V3az73mnzIKbgZcyKOoOMFMFwpncjNZXc
         lZXDXqS0CWPiRNSGJKNYzmPA++3CezqxjpEm4ot/gg6ymvJZEe+JpPLMsFBUc29xFWV0
         084YgjF+XDBK6VtFXBLUMu7C4g6LxJax7TLDR0riWpPp0ljMP/3Ultfr6RRm+G98Z1Jk
         qotk5mmw29NDxD1vJm/jlEQc2aLUS4ewJkIRI8GRkhyPKahtngYa1oKKYV19ZUpU7zb9
         1aVA==
X-Gm-Message-State: AOJu0Yyn5e9oOJp1njwH6d2PLvB6linPHcsoNW9aHSoZnnMXtX1TNWo+
	f4ZLyJZlEiCQUuuCNn0mh2B2kbbavtc8IQft1C0/OXUXI2HGoTRrS8OFq2tuegzB0CY8LT9oGer
	57UUFZmjAIA==
X-Google-Smtp-Source: AGHT+IFTe7ZfY4yWX2ICd+1ng3slGad8C5b2GR/bnJKwcPtGGj4cO3rk0SfNRTC0P2RjB2pPcKhR9q+H2bXOMw==
X-Received: from qtbay26.prod.google.com ([2002:a05:622a:229a:b0:467:84a6:b744])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5702:0:b0:46c:7188:e3c4 with SMTP id d75a77b69052e-46fd09e25aemr209240181cf.10.1738593054306;
 Mon, 03 Feb 2025 06:30:54 -0800 (PST)
Date: Mon,  3 Feb 2025 14:30:34 +0000
In-Reply-To: <20250203143046.3029343-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250203143046.3029343-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250203143046.3029343-5-edumazet@google.com>
Subject: [PATCH v2 net 04/16] ipv4: use RCU protection in ipv4_default_advmss()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ipv4_default_advmss() must use RCU protection to make
sure the net structure it reads does not disappear.

Fixes: 2e9589ff809e ("ipv4: Namespaceify min_adv_mss sysctl knob")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/route.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 577b88a43293aa801c3ee736d7e5cc4d97917717..74c074f45758be5ae78a87edb31837481cc40278 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1307,10 +1307,15 @@ static void set_class_tag(struct rtable *rt, u32 tag)
 
 static unsigned int ipv4_default_advmss(const struct dst_entry *dst)
 {
-	struct net *net = dev_net(dst->dev);
 	unsigned int header_size = sizeof(struct tcphdr) + sizeof(struct iphdr);
-	unsigned int advmss = max_t(unsigned int, ipv4_mtu(dst) - header_size,
-				    net->ipv4.ip_rt_min_advmss);
+	unsigned int advmss;
+	struct net *net;
+
+	rcu_read_lock();
+	net = dev_net_rcu(dst->dev);
+	advmss = max_t(unsigned int, ipv4_mtu(dst) - header_size,
+				   net->ipv4.ip_rt_min_advmss);
+	rcu_read_unlock();
 
 	return min(advmss, IPV4_MAX_PMTU - header_size);
 }
-- 
2.48.1.362.g079036d154-goog



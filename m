Return-Path: <netdev+bounces-257630-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBK/IFAmhmlSKAQAu9opvQ
	(envelope-from <netdev+bounces-257630-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 18:35:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C0710121C
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 18:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5FE0A3010788
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 17:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914903D6693;
	Fri,  6 Feb 2026 17:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fSVM9Z6c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4639041B34B
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 17:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770399286; cv=none; b=OKcxLiVm9GAO6+Y8nUzUmAPFFSde8izWbXXgQrIedgpIbaoLLQ8fxhcX9Agz5ReOShdlEEMgEg7FjC0gk0hi6tMW5+eyUyFZCICmj5TfZlTz3gbqgyTpqnqBxmHSclad5gTtQbd1WlhR/3Q4y37qBOjyLLs2RBnUSP+q0F+vN48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770399286; c=relaxed/simple;
	bh=O6zek/vcHbxcywmjQ1Y+LlmcWYQBoMlM2hvDx/ehVPM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ma4xY+oyeS9yb10mfnuMU6NvUjneaTA3mc5AYA4tQcuDvkQHFaavYnAf7G+8JWgrHrlRM6v6UM4dlKGByes0cpGmZgWw4hhrNazMJcW9CUKWyk9WIIb6jKwaWjSFtLx76L2rKI8E3WSBjHzbiLP3/CdEKRGs2xTkk76GtyC/xwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fSVM9Z6c; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-89493622b50so43526496d6.1
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 09:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770399285; x=1771004085; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xQNRGb5LrRBR2hLmX4+e0dFyqq/5wDyWfM0ofpjSq4g=;
        b=fSVM9Z6cap20FgTJjR2qSHtFu6lKU1n1016F7i+pIcSy0xjTg819hAkOvxUIzg6mki
         Vgu0GgPC5Qf4bdqLYxm5cSk/gI+fYBMa4GmtN84FR3my3dqsubbaUYKloswPftqvMQok
         dFu+Han4M4vxC+xoz8nbyxfIAr66zolMLAsac/3RrUC4t7tdiJ4UHNNfBS3iKXHedxKq
         EkJZaMQQwnCvB3A6ZW1eDMeTrj5Q8bSB/bg2RHHYrqLD1cZ929azRP27B2TugnPtH9aH
         fm0odSsnw1vaBqH0nnl3gFQqscLlw9DsMRZWwtkq9pu/SGH4AuHETjbCloIppKgCklrR
         8pFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770399285; x=1771004085;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xQNRGb5LrRBR2hLmX4+e0dFyqq/5wDyWfM0ofpjSq4g=;
        b=WE9DqRJbJsTDIZ4cAVG+DiPkjRh1JvPK/P21inNCc+yxDFkX5jBYMnTuRArWvt4ssu
         /oNwyXk34tHixZnd45wsNhNuaeQjK7pECKdOVkLX5Z3AueV5+ko/TgM1wk7cF+ncwxLV
         /B3HUIBFWKJVLTk7nS8SSBAgvRLKpsNX/JSbMYLmY8W9PUkNXya2BYbdtpc6XDVY65dQ
         xI2h69iqEjJvK/8Qk+8UKX8xAzQ1bNjjsPzQln99gNg0igongtQ4cOzCeaLQiK3+LhVY
         feLFTr3iVYv4SwZOAOyfNfdu0mLpV9TeQ1V9nEVQ94d3drHVCx//rDSowTeX6pKKSPoI
         sVCA==
X-Forwarded-Encrypted: i=1; AJvYcCW17I6G4ChbXrYhrQyrDM+Ks0+nzSgK33KiPgf6GYlBEmIvJYJT+RBRruPb7JWlXdgPDp6EC7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiM1Sb+eebxb9q1LPJa5GSprcSYuWJBYZUHCtrfEtfYHV2m4m5
	2NzIwmxJXqMaz1vcO1ltsLm3rjwviOnCNwShvRA19n4yTZN2js0Yj0v0bZJtCwUylyix9k0Q/02
	yIb1LDcXILAWB1g==
X-Received: from qvkj11.prod.google.com ([2002:a0c:e00b:0:b0:894:9756:bcb1])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:4ea1:0:b0:894:3d7d:b488 with SMTP id 6a1803df08f44-8953d0dee0emr47548536d6.66.1770399285011;
 Fri, 06 Feb 2026 09:34:45 -0800 (PST)
Date: Fri,  6 Feb 2026 17:34:21 +0000
In-Reply-To: <20260206173426.1638518-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260206173426.1638518-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260206173426.1638518-3-edumazet@google.com>
Subject: [PATCH net-next 2/7] ipv6: use np->final in inet6_sk_rebuild_header()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257630-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 48C0710121C
X-Rspamd-Action: no action

Instead of using an automatic variable, use np->final
to get rid of the stack canary in inet6_sk_rebuild_header().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/af_inet6.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 0476dbc8edb2b8273fd337b15c8196e9597753ef..31ba677d0442a861fc87e163b43a0aa1df88d8d4 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -825,7 +825,7 @@ int inet6_sk_rebuild_header(struct sock *sk)
 {
 	struct ipv6_pinfo *np = inet6_sk(sk);
 	struct inet_sock *inet = inet_sk(sk);
-	struct in6_addr *final_p, final;
+	struct in6_addr *final_p;
 	struct dst_entry *dst;
 	struct flowi6 *fl6;
 
@@ -847,7 +847,7 @@ int inet6_sk_rebuild_header(struct sock *sk)
 	security_sk_classify_flow(sk, flowi6_to_flowi_common(fl6));
 
 	rcu_read_lock();
-	final_p = fl6_update_dst(fl6, rcu_dereference(np->opt), &final);
+	final_p = fl6_update_dst(fl6, rcu_dereference(np->opt), &np->final);
 	rcu_read_unlock();
 
 	dst = ip6_dst_lookup_flow(sock_net(sk), sk, fl6, final_p);
-- 
2.53.0.rc2.204.g2597b5adb4-goog



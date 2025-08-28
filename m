Return-Path: <netdev+bounces-217929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF7BB3A6A6
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 18:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FF5DA01756
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 16:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F75326D67;
	Thu, 28 Aug 2025 16:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CUKrQksx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2500B22FDE8
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756399316; cv=none; b=haaU0tirgzYFB+PIstBNiYW0vRjvSr1G6yoVYwTCLhiPnfciykOSFoonPjTu+SbEmHkLmzor6/MlJ0yfcx611ZfgRU7dkrZkKfWoZ75dzqa+0xTkcQpJbKn8eldY74REpHKDayjhR5x03WrI0uspqOoMQG6oFAjCFmGIpq8l9Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756399316; c=relaxed/simple;
	bh=xe/H9TUaJiTwEUHDJ+/kiQS0JoDVhOHt9vu7I4X53qw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=largVG9ZZ6OIlkQ4U1BqLG22JB5xhWvMUgsG0Ry8tHpSffGlc8WrLT2gW8OnbaWWRbagMYifG5EffRQ0CfF7CaUQlLFgMxQU07JU1HZAUHN4w4hmc51PbPGLuMrHWCoOUWKpI+5tRw+FrXxCsBwmmJ8AfktTfZcJOwuIoYHhWD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CUKrQksx; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e970e624ba7so520282276.2
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 09:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756399314; x=1757004114; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hE5lLhFv0DiTJkRbcDlyyaL/U0g4hAG8/Cqcqv5+Btw=;
        b=CUKrQksxV34iQ2gfgu5STOZVJ1mYzd2glKPAZsqzEDY8NgaatJw4SocXv82TQZTRpZ
         ji2aWDWpiFL0yW93auhYYBN8aTULHD1uA0DYgFDwjxHlVSzYStKBV1kZA7iCUJjK2U83
         EGAP4fqSLGYsx649Ua+7AmsrxNp85wUiR2e/BJOmLm65Mqen26aLwGjdGN1QG3z0wTgu
         bUrgyxxDmGOzsnrG+NmiptL0Z3kyj7vve7LR7nMMwdkZRzORp6sbzpYFIlmxtqInIKIS
         c7mEx9PZd6hGhxJ6QWjLh1cx7sMEPVgBEcaniXUfGoI0sxqwC/S3u0GU7ylo9vi3adsr
         micw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756399314; x=1757004114;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hE5lLhFv0DiTJkRbcDlyyaL/U0g4hAG8/Cqcqv5+Btw=;
        b=SOwv2NtIe4HeTCRkd+WiR3ZY/msy3UERKgO5Ak/keN3AVTwfN1EBmawt+cnIh62Pba
         KlpyG+Z6JJPyQw9AK+ftHHrT1OlpNh/fGJBM6JuaRhk0ZGBA1IZXeyAP1OiJcvKhXHK/
         GrahUHCfddHRM3W/0zSESZClFfsZMe//GE+p1nqIun8XEGE65kPOAeGrttypZA4ad/8+
         lTqPCii9R+vpGuWNtdhDvqEoyGsJcXHgaV+EdYCRwBeHvN9z9rN/hyoLOZSqhDkb7DYh
         xsabjQN/Qh0VdREmw7Lik181WDMaqjN3R+fWvm8vKXyLYnJDihjYPuy74kC3l0bKrrEt
         TIhg==
X-Forwarded-Encrypted: i=1; AJvYcCVBApzxodjuUD8IV+EgFYUKhfjDR5rictBX70Tk7qRMkuxLkOlhr87Pysrv8oglMMDhNhhr7Oc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0u4LaXAyD8EApL4CdagiWX/fAAvCQJOlV0meLYwLvKqRAYLGW
	VZsGRU6RK1E/FGSAl5bRTHB8JJ+WVgZ5I3YE+ynFZsEHzplL+Vp3t4zmT2+LdZEKGKIQx2tEwaZ
	A0ZLV4OfDC6mOcQ==
X-Google-Smtp-Source: AGHT+IFXjgXxyzu14D8GCw78kgJHz3J05jAuqhbf1k5m4Hj01kuqm2sr+oGrXCnWYU8QvM3AcpPtthZrq+uwZA==
X-Received: from ybcv186.prod.google.com ([2002:a25:7ac3:0:b0:e96:dc7f:dbe3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6902:2b08:b0:e95:2e0a:e268 with SMTP id 3f1490d57ef6-e952e0ae6a8mr19952946276.3.1756399314033;
 Thu, 28 Aug 2025 09:41:54 -0700 (PDT)
Date: Thu, 28 Aug 2025 16:41:48 +0000
In-Reply-To: <20250828164149.3304323-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828164149.3304323-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828164149.3304323-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/3] inet: ping: remove ping_hash()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

There is no point in keeping ping_hash().

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 net/ipv4/ping.c | 10 ----------
 net/ipv6/ping.c |  1 -
 2 files changed, 11 deletions(-)

diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 74a0beddfcc41d8ba17792a11a9d027c9d590bac..75e1b0f5c697653e79166fde5f312f46b471344a 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -67,7 +67,6 @@ static inline u32 ping_hashfn(const struct net *net, u32 num, u32 mask)
 	pr_debug("hash(%u) = %u\n", num, res);
 	return res;
 }
-EXPORT_SYMBOL_GPL(ping_hash);
 
 static inline struct hlist_head *ping_hashslot(struct ping_table *table,
 					       struct net *net, unsigned int num)
@@ -144,14 +143,6 @@ int ping_get_port(struct sock *sk, unsigned short ident)
 }
 EXPORT_SYMBOL_GPL(ping_get_port);
 
-int ping_hash(struct sock *sk)
-{
-	pr_debug("ping_hash(sk->port=%u)\n", inet_sk(sk)->inet_num);
-	BUG(); /* "Please do not press this button again." */
-
-	return 0;
-}
-
 void ping_unhash(struct sock *sk)
 {
 	struct inet_sock *isk = inet_sk(sk);
@@ -1008,7 +999,6 @@ struct proto ping_prot = {
 	.bind =		ping_bind,
 	.backlog_rcv =	ping_queue_rcv_skb,
 	.release_cb =	ip4_datagram_release_cb,
-	.hash =		ping_hash,
 	.unhash =	ping_unhash,
 	.get_port =	ping_get_port,
 	.put_port =	ping_unhash,
diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
index 82b0492923d458213ac7a6f9316158af2191e30f..d7a2cdaa26312b44f1fe502d3d40f3e27f961fa8 100644
--- a/net/ipv6/ping.c
+++ b/net/ipv6/ping.c
@@ -208,7 +208,6 @@ struct proto pingv6_prot = {
 	.recvmsg =	ping_recvmsg,
 	.bind =		ping_bind,
 	.backlog_rcv =	ping_queue_rcv_skb,
-	.hash =		ping_hash,
 	.unhash =	ping_unhash,
 	.get_port =	ping_get_port,
 	.put_port =	ping_unhash,
-- 
2.51.0.268.g9569e192d0-goog



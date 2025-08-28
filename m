Return-Path: <netdev+bounces-217930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 510DFB3A6AA
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 18:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BFA0165463
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 16:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9861322752;
	Thu, 28 Aug 2025 16:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NIg1MUu9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39523277A2
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 16:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756399318; cv=none; b=ZCYjMvjX5ZIces5aps5EUjExBcBHckxPBGpDYkRq2fqGctsXYgL6tzZ5iON5sP640ekGqCEtVeVO7cL/MjyQY4IMEQyKkoiE8HJ+1Uv4i2Vo8W/NFnjlI15pv1khzHnjiQpQi4uVy6lOYT7YBPBDeyx636f6YFJolUV89o+uNIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756399318; c=relaxed/simple;
	bh=Jd32udxxvRhu/pIJTPdjtq4zhx0XIcXLqmY8fHlurIA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gX1oCcYTyXFeKPs9uBRvesiCzCLw5nUG7KX15QJos34TR715SMkGsqS+3bvFdWnLK9ObkWSfJK+I5hyMExp3F0+NrvbJ7m+Mj8D0Q/M+Z7S2jKz2mKNopavRbKjgL1pCQ9a8UQAqzYFAMp7TU0ibk/6esrlVbvbMPPekchr5iJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NIg1MUu9; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7eac60d6c18so199926285a.1
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 09:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756399316; x=1757004116; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nWjmdF9AC9+P2p4hwFYnn1FRpPJgJnOmYr+2Mdn8Okc=;
        b=NIg1MUu9jv4gyI9+OxT8B+orTVdvYWeCenag/+O89c674rf4CBDcLVrpZyTr5n+mAd
         QJiF+g6KGq/ohPq6RQ0Ejzj4FKJuMBlTq3Kyh7q023yO3uA8xAmQJ35iiJeLtXO0L8gG
         QGYGAx4hHyimw/gYzpKE0wQek6wisf/ihqOjFZw2ZaJhxeiLtSKqIMOuh/oNc9cgBOYS
         AiMirFnD29lNnVTLGTgLEABA5tEzJxhI6PWRXv3XRX6sMyA0s1NDvTKfpS0TWC2kZFNx
         Wey3G2jngjVc2aEPT3t9P03DkWPxjNgHJvQVmV+gGlINs2DgWiMmr22UgzUiznZoMVAF
         wPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756399316; x=1757004116;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWjmdF9AC9+P2p4hwFYnn1FRpPJgJnOmYr+2Mdn8Okc=;
        b=YrGaG/6urO3sHaoQyvahphZtpjkyA7gwo1eGtVbrPluiILpOhscFGcRzX4fiYJgivq
         D8esQM063/M0zg63FBR9sm7MWukSmQzF6xvkF33f2lXSxkzQuUg3yS9L4oht9lppzV69
         ZSPCTV4T33jkXxHmf7g7DIiFkEnqWf9rOWw6Hxg7dEYqvPA5bcE4CPa1+USv2AZ1xkWc
         +Q+OOEvtg+KZAz+CuFqiRe8xUCzbfAk54H+m8BSeCRAhdXY/Pd0ofWJOv6YRhMSlgQg1
         1GcvyrXFGJeSnFtpxRJF8x8bPPgIsETfwqLpyBiy4KUegpunCDmlnMfD+jL9ub9o9vY4
         srmw==
X-Forwarded-Encrypted: i=1; AJvYcCUCQBjMYEhXzXBnBBrZCKOK74OEglf+9fNXtcRkWlls1YB5/8j9ufu/aolvTiUzXU/2IcIot/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+wyN9l+GSl39VVc0KLhEqP0Un49yodgFIcOTce8zvMRgcs+i2
	NJatnsxI0R4k7nmrJSyCk9n4Hr06bRPFtBz3zpKh6lZ04vmTorYbGxq8U9xZk92h1hELu63PeVD
	QhJOWZ1SRdwCXMw==
X-Google-Smtp-Source: AGHT+IH5a1NaUlvYkdzPl2OkRXAci3UY7RJXSzGvUziEVq6rmEJuL7A52grC7E0m85XJOBUin1VgM5pPKruxTQ==
X-Received: from qkbea14.prod.google.com ([2002:a05:620a:488e:b0:7fb:8811:43f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:838f:b0:7e8:9f7:da5d with SMTP id af79cd13be357-7ea10fc7a93mr2334248185a.12.1756399315822;
 Thu, 28 Aug 2025 09:41:55 -0700 (PDT)
Date: Thu, 28 Aug 2025 16:41:49 +0000
In-Reply-To: <20250828164149.3304323-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828164149.3304323-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828164149.3304323-4-edumazet@google.com>
Subject: [PATCH v2 net-next 3/3] inet: ping: make ping_port_rover per netns
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Provide isolation between netns for ping idents.

Randomize initial ping_port_rover value at netns creation.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 include/net/netns/ipv4.h |  1 +
 net/ipv4/ping.c          | 10 +++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 6373e3f17da84ebc5c11058763932e595f0fd205..54a7d187f62a2e995076e85f1e6b2fd70f84b2c1 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -251,6 +251,7 @@ struct netns_ipv4 {
 	int sysctl_igmp_qrv;
 
 	struct ping_group_range ping_group_range;
+	u16			ping_port_rover;
 
 	atomic_t dev_addr_genid;
 
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 75e1b0f5c697653e79166fde5f312f46b471344a..98ccd4f9ed657d2bb9c013932d0c678f2b38a746 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -58,8 +58,6 @@ static struct ping_table ping_table;
 struct pingv6_ops pingv6_ops;
 EXPORT_SYMBOL_GPL(pingv6_ops);
 
-static u16 ping_port_rover;
-
 static inline u32 ping_hashfn(const struct net *net, u32 num, u32 mask)
 {
 	u32 res = (num + net_hash_mix(net)) & mask;
@@ -84,12 +82,12 @@ int ping_get_port(struct sock *sk, unsigned short ident)
 	isk = inet_sk(sk);
 	spin_lock(&ping_table.lock);
 	if (ident == 0) {
+		u16 result = net->ipv4.ping_port_rover + 1;
 		u32 i;
-		u16 result = ping_port_rover + 1;
 
 		for (i = 0; i < (1L << 16); i++, result++) {
 			if (!result)
-				result++; /* avoid zero */
+				continue; /* avoid zero */
 			hlist = ping_hashslot(&ping_table, net, result);
 			sk_for_each(sk2, hlist) {
 				if (!net_eq(sock_net(sk2), net))
@@ -101,7 +99,7 @@ int ping_get_port(struct sock *sk, unsigned short ident)
 			}
 
 			/* found */
-			ping_port_rover = ident = result;
+			net->ipv4.ping_port_rover = ident = result;
 			break;
 next_port:
 			;
@@ -1146,6 +1144,8 @@ static int __net_init ping_v4_proc_init_net(struct net *net)
 	if (!proc_create_net("icmp", 0444, net->proc_net, &ping_v4_seq_ops,
 			sizeof(struct ping_iter_state)))
 		return -ENOMEM;
+
+	net->ipv4.ping_port_rover = get_random_u16();
 	return 0;
 }
 
-- 
2.51.0.268.g9569e192d0-goog



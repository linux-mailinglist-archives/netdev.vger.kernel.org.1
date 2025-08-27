Return-Path: <netdev+bounces-217263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E87B381E8
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 14:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00DF1462673
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 12:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72C530148E;
	Wed, 27 Aug 2025 12:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OK4zxZhC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f74.google.com (mail-ua1-f74.google.com [209.85.222.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2C53009E8
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 12:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756296317; cv=none; b=qbKsma0EwA+RB1QKjvYlHPuOA093ttw16aVhurwTNVf5I5JAlaUqwFSAFWauClNFgxRd+4Rea5i4fvRmKcwPZrDDYy1Os0FhcJ20qc/U1/j3uQ/OBkejVj8r4FDYZ+sR8SWbmSRl3WaqReZj0qSMQd1XtB7JIbWf/+8QXzj4RNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756296317; c=relaxed/simple;
	bh=80LojI45L1Pp+IQNTBCMWhk6TUK5DO01KHuEsmPAyjQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uVe/TGzAxr8rzrZUnmeR9/3mcKxolAulmvhEepk/EHLiR2nCsxXzXoyv2rb9CuhNVMbc2Kzuv4VBfCC69aWC9mSm2sIqIQxprLByUHXIO/pvxOQIqx0dyAirPKbJTfFbU7D0trewuXnJTGR3La2lBTxsf11zjqaNFyXpUJD/oNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OK4zxZhC; arc=none smtp.client-ip=209.85.222.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-ua1-f74.google.com with SMTP id a1e0cc1a2514c-8921abd6c84so9633896241.3
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 05:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756296315; x=1756901115; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oVOEoAVmsRMWFejTmwKym0YsRcDeduRZ/VsWhlEJuQo=;
        b=OK4zxZhCGpxTNZhPnU1PwLmqHc7Sy5rPG0NHPLcuXcPdHFnS9f7G428g0j/mrBRw42
         jnRQOcpItvfTLy9rLteOIeDTPgi1rxHItQTbzvQN6gmucdoJmTKihlH+MB92k3bK79OJ
         ae+UZhZT8hBuEbKJXdnaZdQqWeE95DjTSiewkPkjZd1qmfgl+r903SS8fUhzlx2Nx6PR
         gJstB2sz/KkhNMsBWuj+vYyWu8Ml4p+AxPRJfQZR9zza0RNNlpJemzFCuN5QdAe0cVuQ
         88Yg/kmf60yx59A0q0VpO1ocbNCgdS7AoriE6uPPrrXR8SumMGE9s89rv7iY723+/nS4
         LIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756296315; x=1756901115;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oVOEoAVmsRMWFejTmwKym0YsRcDeduRZ/VsWhlEJuQo=;
        b=D5VwO9X6SrMd5o3E49aRpTLNR2LltXLpncnYowfFauXlWxnhZTq5SfFZ+0l9fGlTPh
         MbyCx8Binh0qFaEYb4nJSvj9X75/venScwdCzBZx1HW4ih/VE+0xfdd3zkgFCNcSYkGt
         TVlIZaHvRKgM5UQdfSbIOWJ21ECuAoeV98AiU1kp4vItC/UcgD05eb1hzkRuhImHEmk4
         bHOnb3NrWhkfe+0M4CDar28Jl8hF8KMtpbgj8NG8VFZfVbsVQEeyHzTJDDMRTn1IabMn
         mXXoYLb/sQnXlR8QqkcBsOlBCa4rCZc8KInvUvj34cmGH3uDQjGItTnQOpmsmsKyhH9L
         UOag==
X-Forwarded-Encrypted: i=1; AJvYcCVA9u5kry4Mi5NY5ApyPnsE83j0NqTB2JcXtYl2iCeePgNXHSJDAPfpAZOxEAcsMPGG4sjGQPs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/xpSLm9oMClAWTBP2hudgSWbUuS4syxqzgMBv9xiRVg9ees5B
	3YxRH3d0M9sXSP0H56qx7A5ufWebZMe0yn0s6S6P7WLYAwUOr6q6MYq7nSrJx9I7hsm9ZeTG0nK
	1igZoKqGaIft3Iw==
X-Google-Smtp-Source: AGHT+IHgwjxzPBCOIDmEgsxKB9vC+E3ETJbhw8lq5Z/Y+V94LJRonRnCEnfZpCA09YzwwZmOlVJNakSYClAlEw==
X-Received: from qkpf15.prod.google.com ([2002:a05:620a:280f:b0:7e9:e68c:c30])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:509f:b0:521:b9f2:a5dc with SMTP id ada2fe7eead31-521b9f2ab59mr4337085137.25.1756296314747;
 Wed, 27 Aug 2025 05:05:14 -0700 (PDT)
Date: Wed, 27 Aug 2025 12:05:03 +0000
In-Reply-To: <20250827120503.3299990-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827120503.3299990-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250827120503.3299990-4-edumazet@google.com>
Subject: [PATCH net-next 3/3] inet: ping: make ping_port_rover per netns
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Provide isolation between netns for ping idents.

Randomize initial ping_port_rover value at netns creation.

Signed-off-by: Eric Dumazet <edumazet@google.com>
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
index efceb2e17887f32d89c85161ccd818b12e38ff20..accfc249f6ceb29805e3bbec25d0721d2563cb4f 100644
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
@@ -1144,6 +1142,8 @@ static int __net_init ping_v4_proc_init_net(struct net *net)
 	if (!proc_create_net("icmp", 0444, net->proc_net, &ping_v4_seq_ops,
 			sizeof(struct ping_iter_state)))
 		return -ENOMEM;
+
+	net->ipv4.ping_port_rover = get_random_u16();
 	return 0;
 }
 
-- 
2.51.0.261.g7ce5a0a67e-goog



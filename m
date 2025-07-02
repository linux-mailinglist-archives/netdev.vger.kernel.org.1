Return-Path: <netdev+bounces-203565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC095AF65CD
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 01:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED3FD1C42457
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 23:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9069C2F6FA2;
	Wed,  2 Jul 2025 23:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdklyQHm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9562571BC
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 23:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497354; cv=none; b=QVyVTCp0RRRASticA3F/kcWZZWMQEVoLccs34qM2X7QYkVx/SMbVvg7ZbUE109uy8TjMAvMVqy5QjgJtStPbZiNzYOf1G56q/vFPQXgUen0LDmYa2xwmsGnuwKmRAtNxxM+4eX5/CZPShIfwUpsWRyXcRfCg8F+6sdgx8RPW6CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497354; c=relaxed/simple;
	bh=ny5Pq5ezvvaE2A3LlicqI7/1h9dEFz3PPt+QoVB11Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrnE6vJeH9+RsLnuukP4VyhthswL0MM3CO4dRHhO4jsRUAE8qj3FVZfhcfEkiXV37yiOdVXJ6mP3cLPeS81XB2BdAwuicpDyE4O5zIYxaMMKSqO/zQ1jJ1oW6TSFZNq2n7L3pxTEsOTZ063nT3fi6NgmWNBR83f5hjAr6RUYM7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdklyQHm; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-234b9dfb842so47167125ad.1
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 16:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751497352; x=1752102152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5eOCbyGe2adSCLJ9BUC/aayVCSJHNj/VF2yUa098rY=;
        b=UdklyQHmYe5ydjFI/XWMlpaNPHNvIz1xNHQzXrugGLMw6RPGIpGE1xXJ9cMfcNsvRz
         JfTakpjCd39rBPRI9u82yQq8YPcGsUapPiko6/B1ZRsjwctDYVpHN3KscH6GdF6wG5IX
         Ja2UNpet+RsQ+cXDhtsjWbFOrPQ0P+ZQyVp0l/smaDzHILSYHACuiYhAF16wJ+Tyz46Z
         Re8f5I8nEuiGMfhmUUtR2VW98H8nWqw4ttaQEpgcka+hhuwiEG2SKyL1pijf4V9ccRP4
         Pz1hokI9qFjNQGPRP4Yz+5U5ebwp1D4ie+wEnOSN/X1Zo3qYKOPGl1S3qqLHzjB+BRiV
         nwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497352; x=1752102152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G5eOCbyGe2adSCLJ9BUC/aayVCSJHNj/VF2yUa098rY=;
        b=f11wY7UMdLFQZNWSrtyfQiRDaviqoKuAuxint1NSmU7rJaGNoKa7wTuE/m6YkIJ5f9
         Xofjqvgce2he2RQtGdJHNu2znmBKNrrkWHUtgxZ5GpN42vZFUunzVlGMhIhfL+4+lvIp
         EI6XCHnOPkKoYVO7HgSb0ZcpjUlQhlCEoyeVD+tt2fB2U/uO8vpa2NeqoZt7NGKqYdwn
         Sfsw0uk5FjBhxhDoTuvttp6SFusX88yA1dXDIccVP8Svvc1MpShO6n8jNOOa9KHt4d2m
         0JodoAkLVzKrhza7qCw4cNRHXP5BprHPjdZEnYk+vjAuWHC/26wJMVAk7Qhaq2i3x9CF
         Zvzg==
X-Forwarded-Encrypted: i=1; AJvYcCW4dCH4bJWTZA4/usi/34ryGLFRw4429ukPyt1qzGzCH1wiAdspCcDXuKSSDjcB6VlEOLxi/kw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2rJu/qGxyT0BckDKSU36ye+rapfuZqedroaksOoZNok5JI2fS
	ORJ/3cZ5BO0a/3ctAeE/O/YHlEoq62HcP5aH4s60cY9/lkmFPvgDLAuG1MbpEy0rwX1z
X-Gm-Gg: ASbGncvci4BYziAN3chvZ23CURi1HYl1v0zfPyVCEsRIcIQxOFU0KLiFLHTokcrM9dG
	7kz9lMI+whfL8b+0GC+2iit2hBvOQaBt0UHr4QYIXcVemLgaFJQovZG7huKoEj2OOrtpyajQymV
	YqRvJI3qsx5HnLweMyWIwQ6QkpH8EgyFJ4jxKGhGkaMgzJO5CSmyS0nuHK1LWg/qm1WnaTRAkqC
	Jge8S69ebubmwajbYi8cFAk7WnQqtBXEJqNWeCk8di4yRyS8kBMst5AaK2h57m2tYCpNothKWgT
	XSyewrdC7EhLJdWKo/Ib+XgMXDG14MAVmPRAOIg=
X-Google-Smtp-Source: AGHT+IE8XeQ+TTRpFXrRKnz2IjZfCw4ovJfm5KffxY2EwH1XJOo3CQtx6rsGdRNwbdnQr4xg7/Qt3Q==
X-Received: by 2002:a17:90b:1d4e:b0:311:ba32:164f with SMTP id 98e67ed59e1d1-31a90b368bdmr6271932a91.8.1751497352381;
        Wed, 02 Jul 2025 16:02:32 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::a408])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9cc70a17sm727071a91.26.2025.07.02.16.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:02:31 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH v3 net-next 15/15] ipv6: Remove setsockopt_needs_rtnl().
Date: Wed,  2 Jul 2025 16:01:32 -0700
Message-ID: <20250702230210.3115355-16-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702230210.3115355-1-kuni1840@gmail.com>
References: <20250702230210.3115355-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

We no longer need to hold RTNL for IPv6 socket options.

Let's remove setsockopt_needs_rtnl().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ipv6_sockglue.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 702dc33e50ad..e66ec623972e 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -117,11 +117,6 @@ struct ipv6_txoptions *ipv6_update_options(struct sock *sk,
 	return opt;
 }
 
-static bool setsockopt_needs_rtnl(int optname)
-{
-	return false;
-}
-
 static int copy_group_source_from_sockptr(struct group_source_req *greqs,
 		sockptr_t optval, int optlen)
 {
@@ -380,9 +375,8 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 {
 	struct ipv6_pinfo *np = inet6_sk(sk);
 	struct net *net = sock_net(sk);
-	int val, valbool;
 	int retv = -ENOPROTOOPT;
-	bool needs_rtnl = setsockopt_needs_rtnl(optname);
+	int val, valbool;
 
 	if (sockptr_is_null(optval))
 		val = 0;
@@ -547,8 +541,7 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		return 0;
 	}
 	}
-	if (needs_rtnl)
-		rtnl_lock();
+
 	sockopt_lock_sock(sk);
 
 	/* Another thread has converted the socket into IPv4 with
@@ -954,8 +947,6 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 
 unlock:
 	sockopt_release_sock(sk);
-	if (needs_rtnl)
-		rtnl_unlock();
 
 	return retv;
 
-- 
2.49.0



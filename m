Return-Path: <netdev+bounces-73937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3FA85F617
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 11:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D321B287127
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 10:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CDE45BF9;
	Thu, 22 Feb 2024 10:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WZeh9EBn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2BC44C84
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 10:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599034; cv=none; b=svY3TTpzg69Hp4CV6VJWxstUXA6VgTsqjohCPxjeR7OnVzlWitf76Nn3aZEPXdpLYQQoXo0QgJv2ilqiYS/w2JlO2tmoLe0IvRsN8h5fOVnjDih1cmTp/pc5GF0M85Uw52tFy7sE7KZ2toboc/xsq6lJBlt+mSSUkH3UeTgsi9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599034; c=relaxed/simple;
	bh=Xy0+n9Pw6Ld7r3q9C5w6TjpnfVazfe7dZANFfUTESLo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hsRUCPRg4OuqwnvYDM/pVUxaYLNTmz7Uz4vpNWYVC6xj38OSHwC455paO6/Dkwz9eVLKa7OJbhXNZ3OLMOZhO9dvTPwx/5DgDWPmjNPtzrPPgEqeZ1COCAxvHelUFqljUl8latYKkjqxYK7ONJJvUg5EEFqqbL/tIIJyvOHQ/zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WZeh9EBn; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dccc49ef73eso9311258276.2
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 02:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708599032; x=1709203832; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pNsJx8P4mNBhoYU0JJHzFcUPUoA6dHzaqJZ3PEQd6/Q=;
        b=WZeh9EBnspZYCGAEcor62MZZl2Kvhp4g7H4pRMXAWAGhDp+8oWPCZrDkLJVuVnn00k
         xNIeMCG4o8fyRv9JJBQljHtBqsMQZYWG3ic0bFIkM+6e7GhDvGkMk0ezVv/XS7u9ZuP+
         ipBzXfTUKAK1M8zJEjGQ6lxhUR8qeyqAtfVzksH6BmiW5wJDsWhUYbybmIPtHCX9hgk6
         yqGugpSFoAuwH4wQVhgzeOYZacPIZO75tizui2AZoWKeeBqqCbuGpxEijvRaEW2Liw0Q
         nf1dGYlTyfjQ9DIqEShXkjTgWTxbKtn2vkRMVwx9v3TM9d1+vKuKc2tXHvgGHKS7bQDw
         Dd8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708599032; x=1709203832;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pNsJx8P4mNBhoYU0JJHzFcUPUoA6dHzaqJZ3PEQd6/Q=;
        b=o9eINQnmE1b+slu07vyhAYmRvTvPTJFcdocA6KgORjYI2q/ZUVE2dz0CLVtWfU+E24
         1ams8es+7/M++rkgyxyLBnS1Nhz2nAEKzMNGzB0GYQhQ6zPZFBKki6vI10++vwhIO6lc
         9csy7n8DYGk2lce01Bk1L6vqGj1udV0x/Bvr7n3UTPblkPlApsv+XMDJFfsoVk8K0i8F
         aRZdWc1ry8W3wOZSYCbg58xT5eJvXsA8CSyBJl8hBO/GxO4SICs6araPJP9/waF+EG+J
         MaMEfKyFECR2RY+M/RwwSN+emLf9hnnnL81my0Yx3LyJ6KxKUaVTXHxeNU5me4Gfnrt6
         BA0A==
X-Gm-Message-State: AOJu0YxRnnt0bNKCtfcHOytO+TuopUJ4ugpwyOA8DJwg8xXzFodviXVq
	3Xw8/K6L8AJXiDnGBZ1Ss0DFwcedQ24HWkRVe/lvZPu5OKXivvhUYe00oydJ0BPNd+dCW7beNY8
	AgJIG15vcnw==
X-Google-Smtp-Source: AGHT+IH67Bwomz6lNyUG4qF2T2v4SNFgJ1OuHILc0NTVnUocpcDTloDBdzjyw0qcB7rDIlBwlb/mkWtO7d0EFA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1081:b0:dc7:63e7:7a5c with SMTP
 id v1-20020a056902108100b00dc763e77a5cmr96923ybu.11.1708599032513; Thu, 22
 Feb 2024 02:50:32 -0800 (PST)
Date: Thu, 22 Feb 2024 10:50:13 +0000
In-Reply-To: <20240222105021.1943116-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240222105021.1943116-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240222105021.1943116-7-edumazet@google.com>
Subject: [PATCH v2 net-next 06/14] netlink: hold nlk->cb_mutex longer in __netlink_dump_start()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

__netlink_dump_start() releases nlk->cb_mutex right before
calling netlink_dump() which grabs it again.

This seems dangerous, even if KASAN did not bother yet.

Add a @lock_taken parameter to netlink_dump() to let it
grab the mutex if called from netlink_recvmsg() only.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/netlink/af_netlink.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 9c962347cf859f16fc76e4d8a2fd22cdb3d142d6..94f3860526bfaa5793e8b3917250ec0e751687b5 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -130,7 +130,7 @@ static const char *const nlk_cb_mutex_key_strings[MAX_LINKS + 1] = {
 	"nlk_cb_mutex-MAX_LINKS"
 };
 
-static int netlink_dump(struct sock *sk);
+static int netlink_dump(struct sock *sk, bool lock_taken);
 
 /* nl_table locking explained:
  * Lookup and traversal are protected with an RCU read-side lock. Insertion
@@ -1987,7 +1987,7 @@ static int netlink_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 
 	if (READ_ONCE(nlk->cb_running) &&
 	    atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf / 2) {
-		ret = netlink_dump(sk);
+		ret = netlink_dump(sk, false);
 		if (ret) {
 			WRITE_ONCE(sk->sk_err, -ret);
 			sk_error_report(sk);
@@ -2196,7 +2196,7 @@ static int netlink_dump_done(struct netlink_sock *nlk, struct sk_buff *skb,
 	return 0;
 }
 
-static int netlink_dump(struct sock *sk)
+static int netlink_dump(struct sock *sk, bool lock_taken)
 {
 	struct netlink_sock *nlk = nlk_sk(sk);
 	struct netlink_ext_ack extack = {};
@@ -2208,7 +2208,8 @@ static int netlink_dump(struct sock *sk)
 	int alloc_min_size;
 	int alloc_size;
 
-	mutex_lock(nlk->cb_mutex);
+	if (!lock_taken)
+		mutex_lock(nlk->cb_mutex);
 	if (!nlk->cb_running) {
 		err = -EINVAL;
 		goto errout_skb;
@@ -2365,9 +2366,7 @@ int __netlink_dump_start(struct sock *ssk, struct sk_buff *skb,
 	WRITE_ONCE(nlk->cb_running, true);
 	nlk->dump_done_errno = INT_MAX;
 
-	mutex_unlock(nlk->cb_mutex);
-
-	ret = netlink_dump(sk);
+	ret = netlink_dump(sk, true);
 
 	sock_put(sk);
 
-- 
2.44.0.rc1.240.g4c46232300-goog



Return-Path: <netdev+bounces-223745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7272B5A438
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6191617C736
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 21:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FEB31FEFB;
	Tue, 16 Sep 2025 21:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qM1aOaM6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E14831E0FD
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758059288; cv=none; b=IWiAV4pIemmjNVpONwLzIzdMzTtLEC0mnAoFkQ5L8iLoBqX7l0X0vHoVs6NQxQ/DUMtPODAT2P7ldLg56Cum5zeqeUSJbZVAbjzU+NI+579yRO+Da8zqGjZ/awiO/uEm4bN9lW7+Fm4FIW/OmpN2q82tjciJzzUSMyUkbER3lnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758059288; c=relaxed/simple;
	bh=lZPiFc8yTEqEJW6aFFy5vGnmLyAD3Rsa7rLnDDz4HSQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qRUetUQgR/kUcXvwhNqdpBy4TgAD2joqGM+sC8/gccXpUY7jvgDnFfxho4FfF9lepuazhdGiEbYrVepB186ji2Zz4BEKUeb6bbHwH9fbkj8MGz8FhHWiuBc+r0Xo7d53Oy1ZLntPyTAEw42JBCt7AiwozETXzhJr9tcfSGQ4E94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qM1aOaM6; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b549a25ade1so7601788a12.3
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 14:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758059286; x=1758664086; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ogSAK3tWP3sM/Qa2WLjpdEpB2sEni1RMX0e2BApVNtQ=;
        b=qM1aOaM6qz4kdfz9VGceu5q76XbG3GLg10y2GCVEXx815ABRD9RSao3XLJSTe+ZQuu
         6JZjlEeX0EKYJW6U/9gyjZbwJWSrbp399W5egMLuSI6SUoHceeHdNOdjKMg9Fp38/HsD
         tB0F78OqD5rUEYH5wrxEUwQ3pVd5DTlwm2KslHmJToyUDDELos8o+65kAqB8/cW1ITRG
         QKioBc3CqVnDMHDKDCrodbBC4iAUcd0+IWMjasHw+pnSG/hb2OyNZBUt6FHaFARzODZO
         YBN4CUACvW1zdjDtzwDJdkWdBCYa8+gZmVNb88ty4IG7fk7lXVbNNuGXZeFJS8xSuBNz
         nGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758059286; x=1758664086;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ogSAK3tWP3sM/Qa2WLjpdEpB2sEni1RMX0e2BApVNtQ=;
        b=mz5zWnJcgUr/mUcvloJHY4qTVtPW2UIhevPZec1q9AUdKuPVo0etj3SpjzGNJF72r/
         3H2d0pVjviIHzj4dGfAN8xVGNcW8f9QBvRndMTBwiku2rQq+VpcSiZPHq4leNKnZENiz
         Ib3IbJQR3CIEGtYSYh17f+X4gPu1OQBEvxIDdfS1lDXW1mpNCYZEeerIJ2D66VCsW2vc
         Qfd/kz8k+R1IWiakAtIqNM13jPSLd5DTTFU7/0rYPVnnmOWtYP/RMkG9ydE9gO5DNe67
         FHDsy1/sbqDKPOEE0njjSGRR8qgi8ME4oZNwlEOS3cho0i1ddsrGExAwR8QGmZfsqRFF
         ZYZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyhpt45U8X7Q7Pxm2VBkqBhagMYPkLzWvhi7/Q1ofBHrKvh5X+PpzlrjZefecoQ74lh4vsnZk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+4BYiw24GE1WK6AbU/Vi1ixMKsc9MPX/KNEEuNQMCgEgEu1Bu
	wbJ8mOXGr3lf4aG7mkfyHgTsP4MHtMxV/DMc7Lz+XR4WXzj8BiRhdPuDAHXFy8OwnR+lBVFPcDa
	Hhoj7kA==
X-Google-Smtp-Source: AGHT+IHYBpLQKuqMFtGZ9+lpVkaP3T9wMZqIcSDMTlO8mwaVfR3Rj+lJsk/SRvnrjAHbGJLgyEKepWB37uM=
X-Received: from pfbfi32.prod.google.com ([2002:a05:6a00:39a0:b0:779:8b43:c49e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7343:b0:243:aca2:e500
 with SMTP id adf61e73a8af0-2602c04a56fmr22999382637.29.1758059285673; Tue, 16
 Sep 2025 14:48:05 -0700 (PDT)
Date: Tue, 16 Sep 2025 21:47:20 +0000
In-Reply-To: <20250916214758.650211-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250916214758.650211-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250916214758.650211-3-kuniyu@google.com>
Subject: [PATCH v2 net-next 2/7] smc: Use __sk_dst_get() and dst_dev_rcu() in
 in smc_clc_prfx_set().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"

smc_clc_prfx_set() is called during connect() and not under RCU
nor RTNL.

Using sk_dst_get(sk)->dev could trigger UAF.

Let's use __sk_dst_get() and dev_dst_rcu() under rcu_read_lock()
after kernel_getsockname().

Note that the returned value of smc_clc_prfx_set() is not used
in the caller.

While at it, we change the 1st arg of smc_clc_prfx_set[46]_rcu()
not to touch dst there.

Fixes: a046d57da19f ("smc: CLC handshake (incl. preparation steps)")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
Cc: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: Dust Li <dust.li@linux.alibaba.com>
Cc: Sidraya Jayagond <sidraya@linux.ibm.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>
Cc: Tony Lu <tonylu@linux.alibaba.com>
Cc: Wen Gu <guwen@linux.alibaba.com>
Cc: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 net/smc/smc_clc.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 08be56dfb3f2..976b2102bdfc 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -509,10 +509,10 @@ static bool smc_clc_msg_hdr_valid(struct smc_clc_msg_hdr *clcm, bool check_trl)
 }
 
 /* find ipv4 addr on device and get the prefix len, fill CLC proposal msg */
-static int smc_clc_prfx_set4_rcu(struct dst_entry *dst, __be32 ipv4,
+static int smc_clc_prfx_set4_rcu(struct net_device *dev, __be32 ipv4,
 				 struct smc_clc_msg_proposal_prefix *prop)
 {
-	struct in_device *in_dev = __in_dev_get_rcu(dst->dev);
+	struct in_device *in_dev = __in_dev_get_rcu(dev);
 	const struct in_ifaddr *ifa;
 
 	if (!in_dev)
@@ -530,12 +530,12 @@ static int smc_clc_prfx_set4_rcu(struct dst_entry *dst, __be32 ipv4,
 }
 
 /* fill CLC proposal msg with ipv6 prefixes from device */
-static int smc_clc_prfx_set6_rcu(struct dst_entry *dst,
+static int smc_clc_prfx_set6_rcu(struct net_device *dev,
 				 struct smc_clc_msg_proposal_prefix *prop,
 				 struct smc_clc_ipv6_prefix *ipv6_prfx)
 {
 #if IS_ENABLED(CONFIG_IPV6)
-	struct inet6_dev *in6_dev = __in6_dev_get(dst->dev);
+	struct inet6_dev *in6_dev = __in6_dev_get(dev);
 	struct inet6_ifaddr *ifa;
 	int cnt = 0;
 
@@ -564,41 +564,44 @@ static int smc_clc_prfx_set(struct socket *clcsock,
 			    struct smc_clc_msg_proposal_prefix *prop,
 			    struct smc_clc_ipv6_prefix *ipv6_prfx)
 {
-	struct dst_entry *dst = sk_dst_get(clcsock->sk);
 	struct sockaddr_storage addrs;
 	struct sockaddr_in6 *addr6;
 	struct sockaddr_in *addr;
+	struct net_device *dev;
+	struct dst_entry *dst;
 	int rc = -ENOENT;
 
-	if (!dst) {
-		rc = -ENOTCONN;
-		goto out;
-	}
-	if (!dst->dev) {
-		rc = -ENODEV;
-		goto out_rel;
-	}
 	/* get address to which the internal TCP socket is bound */
 	if (kernel_getsockname(clcsock, (struct sockaddr *)&addrs) < 0)
-		goto out_rel;
+		goto out;
+
 	/* analyze IP specific data of net_device belonging to TCP socket */
 	addr6 = (struct sockaddr_in6 *)&addrs;
+
 	rcu_read_lock();
+
+	dst = __sk_dst_get(clcsock->sk);
+	dev = dst ? dst_dev_rcu(dst) : NULL;
+	if (!dev) {
+		rc = -ENODEV;
+		goto out_unlock;
+	}
+
 	if (addrs.ss_family == PF_INET) {
 		/* IPv4 */
 		addr = (struct sockaddr_in *)&addrs;
-		rc = smc_clc_prfx_set4_rcu(dst, addr->sin_addr.s_addr, prop);
+		rc = smc_clc_prfx_set4_rcu(dev, addr->sin_addr.s_addr, prop);
 	} else if (ipv6_addr_v4mapped(&addr6->sin6_addr)) {
 		/* mapped IPv4 address - peer is IPv4 only */
-		rc = smc_clc_prfx_set4_rcu(dst, addr6->sin6_addr.s6_addr32[3],
+		rc = smc_clc_prfx_set4_rcu(dev, addr6->sin6_addr.s6_addr32[3],
 					   prop);
 	} else {
 		/* IPv6 */
-		rc = smc_clc_prfx_set6_rcu(dst, prop, ipv6_prfx);
+		rc = smc_clc_prfx_set6_rcu(dev, prop, ipv6_prfx);
 	}
+
+out_unlock:
 	rcu_read_unlock();
-out_rel:
-	dst_release(dst);
 out:
 	return rc;
 }
-- 
2.51.0.384.g4c02a37b29-goog



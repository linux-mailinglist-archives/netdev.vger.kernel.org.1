Return-Path: <netdev+bounces-221962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFC6B526DA
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 05:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D97E01BC696A
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 03:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D2222ACF3;
	Thu, 11 Sep 2025 03:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B9NdYxGn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B2E1F4E59
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 03:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757559994; cv=none; b=bbCixjQZwA4NA8yXnHVEjXTy2sPE3HJBEDlJmRoeDBfczfDSv7d0KOmJpEO0Z7d1i+BIDeyZlubGfMaB9+aJOtcKeSNkAqZWaNMXl5wGUDNRlgBwsEvStC0at6VT/BQjL6dbaS66i/DpaUYD83TBORoz6cd8ra2JmrJ1vNvr+m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757559994; c=relaxed/simple;
	bh=SwZ1c7Ci++TkpHqBMBCmrgB6xWq9yQbActTVRfnrep0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iO2KLztIlRv2NS4hVQ6fjqlaYKnQqZqaqtU20NOxwEeTOMxrO2xtjDpCox10EdfWxxJdVI3V3iGitoEekYTbsU2JZGdmNgRY76ZdwH/u9H2Ep7VyakK0qNm4IGC/BzlYGMatCjINEizu+AtLUcdtHU3TvUxRYYZdw8qjIBIvB/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B9NdYxGn; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32972a6db98so328931a91.3
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 20:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757559992; x=1758164792; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DtwBjPVhSmGzcioWhCV8BzYurv3JJMPnUaNsURIifec=;
        b=B9NdYxGn6FWuWb7xH+6UTr8Y3yVdyQuhbQrWCtLEMq+dRgCIya+7eIi3gOkJ8/aFPF
         TzTSeV1dHwuUlSG/4G2VZRpNKmNErpNKSwfPqfJ/YoAVilRAn8/l/UabBBEGqrK3GkeH
         xt250lqDuG5k3ciF0ydXiS1X88JdZJHBJvQsyM0QJ+CWxwjiniJpZBZ1WC/QQra5M/lG
         9eIEW3pNEhR25tLUpmuP9yt0gQ05o6d8hq5Ppzcoa1KLt58OdtT/LdtCHR8Q7nyPngyy
         NKlyw6sFSVrQhX/9yTtxBokPmqw8IyVx8uwogkuyFJXsrYEwx/QewH5ujphk7n1E9GTc
         H5Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757559992; x=1758164792;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DtwBjPVhSmGzcioWhCV8BzYurv3JJMPnUaNsURIifec=;
        b=kGtFWLLmN9YpIK65hUun0pZEElkN/YLxgytLCdTSuBGWYZPuAlNXcQcC74pTQsxOzB
         REcFHCNAxuEKtc/xL6mWo8qgDelg0EosPY2y4FS1f8YRjRjpwFLAA0kz8Mbq1u6zK2yL
         Syhbhr8iUp9pILSJ2c/+u62GXwbG6jIuMMHvZMIqJIMj/lOGs9qZauHHgrHcVF+8tsJy
         TIkK3wR/Myp+TF+pU5bN2Sti1l3jvWbRLYcq3WmOQ4Q7MJ0fXn7VY0C7xpMgNOoZGUHb
         yrVLJrS0NE7cg3ZJUW5mUEGCcoRuDutyj89cP9Sr+kBrrTeY2AWM7mUyatebCuLkSfPV
         BvpQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3bQ29P/k7/pBXDwICL8yqWVTdGzKHZkcFO4M+oJG/jxwE+m5/M/VQWxU5Xc25Vd2Nci5gfWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/8tKj8Afnge6RGAp9OCXw6m1xJO/arbDmtrQgjEspEGaUM8Um
	sr1k0/rtjap5o/QmDp3iS/lQqDU8WZ2rb0GmofVNYwZPnHxbH4HWSQwGED+Vr117AD6GKLUsbjl
	qn/SIWQ==
X-Google-Smtp-Source: AGHT+IGVqvjEBoQEINp6CafbyV97p6UQp24p1SFDryUCPK+DFuTnZDcuEJ4eoxN6EWlENhfEWvUPCvdmy7s=
X-Received: from pjbsv13.prod.google.com ([2002:a17:90b:538d:b0:321:c441:a0a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5108:b0:32b:65e6:ec48
 with SMTP id 98e67ed59e1d1-32d43ef6e5amr22497087a91.8.1757559992479; Wed, 10
 Sep 2025 20:06:32 -0700 (PDT)
Date: Thu, 11 Sep 2025 03:05:31 +0000
In-Reply-To: <20250911030620.1284754-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250911030620.1284754-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250911030620.1284754-4-kuniyu@google.com>
Subject: [PATCH v1 net 3/8] smc: Use sk_dst_dev_rcu() in in smc_clc_prfx_set().
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

Let's use sk_dst_get_rcu() under rcu_read_lock() after
kernel_getsockname().

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
 net/smc/smc_clc.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 08be56dfb3f2..9aa1d75d3079 100644
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
 
@@ -564,41 +564,42 @@ static int smc_clc_prfx_set(struct socket *clcsock,
 			    struct smc_clc_msg_proposal_prefix *prop,
 			    struct smc_clc_ipv6_prefix *ipv6_prfx)
 {
-	struct dst_entry *dst = sk_dst_get(clcsock->sk);
 	struct sockaddr_storage addrs;
 	struct sockaddr_in6 *addr6;
 	struct sockaddr_in *addr;
+	struct net_device *dev;
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
+	dev = sk_dst_dev_rcu(clcsock->sk);
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



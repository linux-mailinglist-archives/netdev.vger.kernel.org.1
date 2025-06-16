Return-Path: <netdev+bounces-198338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD44EADBDBD
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 944871892FCA
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 23:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FD7238C36;
	Mon, 16 Jun 2025 23:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PW4jRbzZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F277239E88
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 23:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750116896; cv=none; b=Ln9c/FjRro0j9kdyI8y0HYr7nsjP0IQVZn20+mSs5C0fNC1H1rcyVrE6TsgIM/NPseDTgkV0ky054hguCa8gEm00RfQm/VyXPtku9AhIaX2eCIoyv8UgJGRPtkIrxA/ZIo+LlSNqzvjRAor8kZugiOMPYrpy3LFyl+IZN58pheY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750116896; c=relaxed/simple;
	bh=VTvxtR0f51a9CvJjYElwMaIvf5GKOHP+BX4QtSqR5EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUAcKztJMAYUTj6md1OJ7N7MkK+DS33j6e8T1iFaz2cF7NgZKBnBBYCst8ZEMmPocylSgi8mwCv02n3TkQrVVekf37vEiNX1y9WHKBHevxvGA2xL0EgUSmKS4gZsA816SpZJLwkUkJjWAXP1chukEqn69lRFZuF7ZsUzRqatW2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PW4jRbzZ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-311ef4fb43dso4016654a91.3
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 16:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750116894; x=1750721694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXbBA5GoQU2ZBqx8P6uWs8YzE92Ezh0aQl++jW7s7jw=;
        b=PW4jRbzZzaMuiYcy/WdFVbB0mBqWT6iS3zCvRsuOzg4KBo0svCVnP3JwohimKDsUzJ
         exyU/Vwes3uTErryIw5r1CULS1qaNNGmhxl7GGXPv7yLryloo8CWgVc32846uqUmRIO9
         wGhC0izhB/RqQvJUJc4C4AaHhLd6lT+eFOV3+lCmzFiY0NfvswpOW/CULbkvvXaKDFZi
         hQ9s3MO/5zIQI69954TPq2VhxBdsa7g8PQwWe5gyN8EsUi42xXdSvpWDfBJHG2TFIrIF
         LmTo6N5n+TBarwBc/WZOtK4wCwLHtmasx+EOximIdEvhhbzD/cxRpZQJH5dot4Lfhbv5
         e/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750116894; x=1750721694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gXbBA5GoQU2ZBqx8P6uWs8YzE92Ezh0aQl++jW7s7jw=;
        b=g77eyGx+qDxe8zjS10JA2D1PqeSMMwe2SM3eV80b7z/RAbY5gy1/pZ8GENVo4GYeBp
         j37hqgx5QpKBZ2PGPC0fkWXQeUISgWhE2ufCZ2BsSxMEpayC7pWoAKK1bE0tIbBMiy1X
         v+k40KI5Yi9qoY7RFdE9e4eMNUwHk08F+yfpdlsLMQbpxpEe/EmxkCsvtarvxa6D1S8j
         hmUUdYB2hsMZsWDtKs5RXUfXnFCTLYeaa1Q2m7Q5Nf5UKSFZZBrijp9YlQHx/ex6OmdZ
         wJR/xg8Vch6dxVdGVRfcFzxn9qsI97260zHPNKTJSF9/DZv8POD3VqAYyijdh6iN/onV
         +Ksw==
X-Forwarded-Encrypted: i=1; AJvYcCWb1SoCsyttoGfhbuX7K7lUF6IynyikEnqFe6B5ex0vl0bEZwGsZd8kjzkhErfqxxDJzSwIM3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmPiWhZdkgDQrVriQYD46hpIe7+iLl7WSn+irpLpHVLMF6J2dz
	6mWip0Nl+v6xcr/GDPRpH2NWZSF4ArpZQKZuFw//i2ojelpAeJjwNdA=
X-Gm-Gg: ASbGncvjY/xaaz9uegXbLJMtRZvHziuk+XUDyfnI06xwqqkMD6OI/5kHDWDI6OheuZm
	Xsvcr1WBA7DP23nWoH//rUvN9AZv/79VTJ/ef0AsbrTwR0qQBb1StQoOUBvCO4z3lKt2kHO99/V
	8H4cZaCfEQIfkXbjgBC80yO5SmBpEQgH41s5Yiwnl+VETrUeT/ir/BACwrMq7A8+UwNXYtF0mdk
	V4mxhHWg/rv3vWNsXp9vTp7ApSMpSXT4QZZRatl1caWguJj8gMJiTDC4+srDhHz5wdebsHXv1Or
	qGU95/EdDT0+h+9lITHyS0EKcjl66byWRiQInLU=
X-Google-Smtp-Source: AGHT+IFYDVuSK0k9r6yEh6R75yBe92YW8qdGZoiEq0aoX0sXHvJ9XjnY3uEoHXuLEVYryr3Ntgqnxg==
X-Received: by 2002:a17:90b:582d:b0:312:f0d0:bc4 with SMTP id 98e67ed59e1d1-313f1be5b9dmr15478264a91.5.1750116894072;
        Mon, 16 Jun 2025 16:34:54 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de89393sm67220485ad.114.2025.06.16.16.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 16:34:53 -0700 (PDT)
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
Subject: [PATCH v1 net-next 12/15] ipv6: anycast: Don't hold RTNL for IPV6_LEAVE_ANYCAST and IPV6_ADDRFORM.
Date: Mon, 16 Jun 2025 16:28:41 -0700
Message-ID: <20250616233417.1153427-13-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616233417.1153427-1-kuni1840@gmail.com>
References: <20250616233417.1153427-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

inet6_sk(sk)->ipv6_ac_list is protected by lock_sock().

In ipv6_sock_ac_drop() and ipv6_sock_ac_close(),
only __dev_get_by_index() and __in6_dev_get() requrie RTNL.

Let's replace them with dev_get_by_index() and in6_dev_get()
and drop RTNL from IPV6_LEAVE_ANYCAST and IPV6_ADDRFORM.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/anycast.c       | 36 ++++++++++++++++++++----------------
 net/ipv6/ipv6_sockglue.c |  2 --
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/net/ipv6/anycast.c b/net/ipv6/anycast.c
index f510df93b1e9..8440e7b27f6d 100644
--- a/net/ipv6/anycast.c
+++ b/net/ipv6/anycast.c
@@ -158,12 +158,10 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex, const struct in6_addr *addr)
  */
 int ipv6_sock_ac_drop(struct sock *sk, int ifindex, const struct in6_addr *addr)
 {
-	struct ipv6_pinfo *np = inet6_sk(sk);
-	struct net_device *dev;
 	struct ipv6_ac_socklist *pac, *prev_pac;
+	struct ipv6_pinfo *np = inet6_sk(sk);
 	struct net *net = sock_net(sk);
-
-	ASSERT_RTNL();
+	struct net_device *dev;
 
 	prev_pac = NULL;
 	for (pac = np->ipv6_ac_list; pac; pac = pac->acl_next) {
@@ -179,9 +177,11 @@ int ipv6_sock_ac_drop(struct sock *sk, int ifindex, const struct in6_addr *addr)
 	else
 		np->ipv6_ac_list = pac->acl_next;
 
-	dev = __dev_get_by_index(net, pac->acl_ifindex);
-	if (dev)
+	dev = dev_get_by_index(net, pac->acl_ifindex);
+	if (dev) {
 		ipv6_dev_ac_dec(dev, &pac->acl_addr);
+		dev_put(dev);
+	}
 
 	sock_kfree_s(sk, pac, sizeof(*pac));
 	return 0;
@@ -190,21 +190,20 @@ int ipv6_sock_ac_drop(struct sock *sk, int ifindex, const struct in6_addr *addr)
 void __ipv6_sock_ac_close(struct sock *sk)
 {
 	struct ipv6_pinfo *np = inet6_sk(sk);
+	struct net *net = sock_net(sk);
 	struct net_device *dev = NULL;
 	struct ipv6_ac_socklist *pac;
-	struct net *net = sock_net(sk);
-	int	prev_index;
+	int prev_index = 0;
 
-	ASSERT_RTNL();
 	pac = np->ipv6_ac_list;
 	np->ipv6_ac_list = NULL;
 
-	prev_index = 0;
 	while (pac) {
 		struct ipv6_ac_socklist *next = pac->acl_next;
 
 		if (pac->acl_ifindex != prev_index) {
-			dev = __dev_get_by_index(net, pac->acl_ifindex);
+			dev_put(dev);
+			dev = dev_get_by_index(net, pac->acl_ifindex);
 			prev_index = pac->acl_ifindex;
 		}
 		if (dev)
@@ -212,6 +211,8 @@ void __ipv6_sock_ac_close(struct sock *sk)
 		sock_kfree_s(sk, pac, sizeof(*pac));
 		pac = next;
 	}
+
+	dev_put(dev);
 }
 
 void ipv6_sock_ac_close(struct sock *sk)
@@ -220,9 +221,8 @@ void ipv6_sock_ac_close(struct sock *sk)
 
 	if (!np->ipv6_ac_list)
 		return;
-	rtnl_lock();
+
 	__ipv6_sock_ac_close(sk);
-	rtnl_unlock();
 }
 
 static void ipv6_add_acaddr_hash(struct net *net, struct ifacaddr6 *aca)
@@ -413,14 +413,18 @@ int __ipv6_dev_ac_dec(struct inet6_dev *idev, const struct in6_addr *addr)
 	return 0;
 }
 
-/* called with rtnl_lock() */
 static int ipv6_dev_ac_dec(struct net_device *dev, const struct in6_addr *addr)
 {
-	struct inet6_dev *idev = __in6_dev_get(dev);
+	struct inet6_dev *idev = in6_dev_get(dev);
+	int err;
 
 	if (!idev)
 		return -ENODEV;
-	return __ipv6_dev_ac_dec(idev, addr);
+
+	err = __ipv6_dev_ac_dec(idev, addr);
+	in6_dev_put(idev);
+
+	return err;
 }
 
 void ipv6_ac_destroy_dev(struct inet6_dev *idev)
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 0c870713b08c..3d891aa6e7f5 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -120,9 +120,7 @@ struct ipv6_txoptions *ipv6_update_options(struct sock *sk,
 static bool setsockopt_needs_rtnl(int optname)
 {
 	switch (optname) {
-	case IPV6_ADDRFORM:
 	case IPV6_JOIN_ANYCAST:
-	case IPV6_LEAVE_ANYCAST:
 		return true;
 	}
 	return false;
-- 
2.49.0



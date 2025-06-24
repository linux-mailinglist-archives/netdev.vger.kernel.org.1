Return-Path: <netdev+bounces-200829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B40AE70AF
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 22:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F8491BC5004
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 20:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EEA2EE96F;
	Tue, 24 Jun 2025 20:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGhcWxNl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E34B2EB5D8
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 20:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750796803; cv=none; b=VKTjVjx8U5EHXOj6sHxs14wxQ5WI4osSgSxeK/ykoureEzEb2mM9SW/I5XwVTnXOnAioJy0foF9x2oA2Azxvjp+imNbnVuqw78eu+Mp/VGBkIpEN+TvlQRWmlfX2fseEpSvl7rPqGydvDs+ulPRhZewRqudSD6Gcg9ZECzMd220=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750796803; c=relaxed/simple;
	bh=VTvxtR0f51a9CvJjYElwMaIvf5GKOHP+BX4QtSqR5EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pj1MZo5CUWKr6oyrSJKcbpFf8jXkQSttAXECx7a9SA2KBPV/KiBiFsmzUj4UIphpnQx5UsebG3Xkg9WIiXZlMMgWFfOwnD0+bcJlcchoObfK/+ppAvTTAlB69964JElr3hMxFdFyiiT/VLIY20yQqixnbIShN1fq9dZx9n1uy/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGhcWxNl; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-748f54dfa5fso460685b3a.2
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 13:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750796802; x=1751401602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXbBA5GoQU2ZBqx8P6uWs8YzE92Ezh0aQl++jW7s7jw=;
        b=DGhcWxNlNU9SEvlyibuW8slFs49bjOUAULJnwvoOx7Tysm4uIsSjEBblf0iSuYq9rW
         fxTQ/lXS+Kjt1p5SrpwOuUl2//9ESXIjFmTS8MSDHz3bCMaLNzmYWb7OxozVZeXaseg0
         bQNs7CfP7/rSXRVO1X/b/YgZN5CC+DfAq/VaYzUdMi+epOeD5odRQYRzoxIL3SmNNTBs
         Yl0PNDzC2zvGLoH+tzvoCLzxXLM1IDNV99Xy+bbBAsq5689VkLKn86HyXcgplOtCbeQY
         5UUHRxBAMlcqiXp+lc5vXzNkSDigA0Hhhy4yY2tULOc1MbLPL6lBklXi+hQ2XqAG/L1E
         eudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750796802; x=1751401602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gXbBA5GoQU2ZBqx8P6uWs8YzE92Ezh0aQl++jW7s7jw=;
        b=QcrCVDo/i5O1z4cO0ggbNlwuy3ubp5eIHxblzAq6vvd5ditla6uWMYFsn0Vif37G7M
         AZymn1yXqQv+cq1q0ssfVsxbltOPHL1muOLdWiAziXAUuFwkzp9MMX8TKCGZsxMjbCIi
         yqblXIlFBJZUtgQCHF6didSrJWIDH0W+kCfJ2g3Wa3MC//xCT3VkWDvGfziWcW0fsOwG
         l1Ph8rKJc52G4FVsjI7n/OvCSwQImh1rrn4ZEAn+jxNZ7obNBn6zg0UXwClqcGTeTGLh
         WlkRc2ErbwZfxL5zz/jeLYcTKQy9bl+3E39nXYrj8xDHw3d394Cj2zX+D9CPypHn+LpW
         x5Cw==
X-Forwarded-Encrypted: i=1; AJvYcCW8HqcnxGkIOvU20Asu5FVyhbgr1jBApFJYag47/Tetz7OaCkh9wvuSgq63R49T5UeTuf72oKs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+16BBGeT2hCf70eMYVzUgkNuZ08o1+GOABukSyCDLxAt+am27
	xWIqUckzD65rshMnkDj0qwJZw1Q8vP0HLnU5kZWysVZ3IokF4tp/lYA=
X-Gm-Gg: ASbGnctPiLNOAm1XOzazMIRameoHIIkZwMW0lcCMZ7WD02+tt7B5679OBO9XOJ7dqVT
	gjR8/IAyjia6aimMx1Sa1AJQTJdFRtLRh6PeCHGSRJ9XG3HV12IQXhZqWbX0hhNonaxYqIlOCna
	ZjL9aoDGw7Ws1rxQTduNU55vrlfXbP2VGuW58LAi4KQZJQ+fZY2g3DvQ3XVvOtnWHObPPTiWdG+
	3fI91lEtu14ETtdniTF+D3VcprPiTLC521I7I4uaPT3m6+lZsM1uDw+e3LfwbxljZJ4FoWL/wDs
	hHoYL8TqsMFzJ1XXEheY5g2EDxIG6X8IEko5tUo=
X-Google-Smtp-Source: AGHT+IFDejOTUapEBIITR5icI6NTcFO+d02ZmsdmSi6a1dzxAzlGQyFpIqYNXlUgYJVt3DHMEBywTA==
X-Received: by 2002:a05:6a20:3d85:b0:220:21bf:b112 with SMTP id adf61e73a8af0-2207f18e346mr556746637.13.1750796801658;
        Tue, 24 Jun 2025 13:26:41 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::a408])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74a9697817esm2252994b3a.124.2025.06.24.13.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 13:26:41 -0700 (PDT)
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
Subject: [PATCH v2 net-next 12/15] ipv6: anycast: Don't hold RTNL for IPV6_LEAVE_ANYCAST and IPV6_ADDRFORM.
Date: Tue, 24 Jun 2025 13:24:18 -0700
Message-ID: <20250624202616.526600-13-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624202616.526600-1-kuni1840@gmail.com>
References: <20250624202616.526600-1-kuni1840@gmail.com>
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



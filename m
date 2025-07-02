Return-Path: <netdev+bounces-203564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9C4AF65D4
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 01:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2885C7A1255
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 23:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EB62F6F9A;
	Wed,  2 Jul 2025 23:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8JwzFDG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108112F6F87
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 23:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497353; cv=none; b=a4mMkzfxJJSNMTUv5qGUxiul8TCHIT7xDejLBE3EzVzmFo1fZMprjBTSpuXnvtWno3vynCbvBWz6VM6riw9CuPaFwOD3fL/jKeN/jwvy/atiiekDjgj5JohYzfdGXUSRJyJLM85QsZl2s+11HYsBfhHwaHuT810pjVyH7AZBSy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497353; c=relaxed/simple;
	bh=IX8fHR5cXVe+zLufZl3v/+T6X3S6bsNUfXwQVK86tr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pofYfbkZSAT9RUBke9lGBfuYURMkmXUnZnecwOy4MR+8K01IT5GDmJyBnxJgCnoBCqkZWKite5VubOmfuWtzKZr9wN4pp728kNinbEvvkdyQ4BFnqwowIesWGVhZHn1PdvRlS9kClgKSse78Rs1Eb0jPkCbMf1dBG5n+NL5A1mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8JwzFDG; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-313a001d781so3763644a91.3
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 16:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751497351; x=1752102151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rx5V+kG75Whfk1XN03m47Nkcev58GGmSOhH1dlOtirI=;
        b=O8JwzFDGNZEz2oi2wq1NUJQgluYkf4NdUAb/7vtPfhzT4vExXLx8/2HZ7+oYU2pAC4
         1ygI5uteE2A45NhweUvIVtGLcwGtD/YLDpojULCDtxzdAf4y4RIaVPWBHpX0ID/N/aIC
         nyPtxql8jALHn5Q4S7fB3TBXbwSF+WI5mocIdbgxVsqKsmUkrmoDs8v1ra2jYYI6cyg0
         cleziAZgpZ1Qz1mbvU2zsbnBHw/ORjQ4ae9ifXG6aDe9M2c90Cv7IL4c78L+LTO2hwDJ
         8Y6zeVvwJnBCoOOt2bFq3OjJ8r5xbtr3hOPWDLCoNd+zyHRonVEZv13OCxoVPrCol0G6
         7qAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497351; x=1752102151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rx5V+kG75Whfk1XN03m47Nkcev58GGmSOhH1dlOtirI=;
        b=GZe2ZAR62UUKzcz65q6unp8n/Ef3k+acMxeqvUr0oN5iM/Nwsv5CF0x1pOsNXtCoc7
         PTmQ5pXilwh2wQTkS8kUkABOJhpaOAim5zRBhV+ONbxQFXhrL4e0ymJT51WDj3vLk947
         RTDzV/Vwvu9rpgIBQ7lNxSVykC+xj6k0Iwlktb6Do1VDObqknx3etPvM0KzcIlm6gFOE
         wKkKIu3sIEOTSOM1aigu+wrK4b1y4628Lk7HZvpuQsAAZnKNkHgHfqQwjHRwvS9XQbyk
         4AZexPBhbxze90zSKdRBIJU6dQZFS7qc/TJS9Os8aS3vc/nBm3EUjTUbVuDq2Fek66uJ
         OZ5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWr0oDxLQX5MSES0jD6xgtbSsnC0ZxpsqOhUEl6JUaBxf3IUeJkDVtEE6WVXcnmSmMabBSerBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyhK3s+Q3nrkVWOnt+0jKyQJY2mwxrzdNtaaIccSDpNSYv3eRR
	5CmCyHAKW3VX8IVpCtbWVIs/R7vpWr7LB7aYBJhYOzVvL8EAMg2NB3U=
X-Gm-Gg: ASbGncsnU4b65/EqFfgqTFCR3eiI62nxZDmcxr601C8RcvGvbPDToIFASHGo8woxEco
	hQ66xTJpRfT21J/OveBygs2rqlT59mvCu+OgGMEE1idGYaTsGVmsvMLPIj53n6ojd/vdZj3saml
	novVxrYKAd4Z08lUsMWJOX92zSzBSElNnwHTXMOdGM+YAgzz2uHhQJMk1a6/GW2ZH7VZtv4Uwm4
	e5v/8rwM3spsgttSX8khPxU/9OjjaBpedNn3PW0O+Aab2zv/H4vMjFjQjSx/sPeXKcJuRJ6Mfew
	Rri9VIp0YnahUVwtEhEchBR8ktR1eFZ6X1ePRCQ=
X-Google-Smtp-Source: AGHT+IEFCxq4NgKItpyC1uWKiGTN3OEO3R+7f59EaBKp0LaZJx5IwP3qpQijAd2bH4vHQ2xdr8OKiA==
X-Received: by 2002:a17:90b:3cc5:b0:311:c939:c851 with SMTP id 98e67ed59e1d1-31a9d52bcbcmr1379143a91.4.1751497351238;
        Wed, 02 Jul 2025 16:02:31 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::a408])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9cc70a17sm727071a91.26.2025.07.02.16.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:02:30 -0700 (PDT)
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
Subject: [PATCH v3 net-next 14/15] ipv6: anycast: Don't hold RTNL for IPV6_JOIN_ANYCAST.
Date: Wed,  2 Jul 2025 16:01:31 -0700
Message-ID: <20250702230210.3115355-15-kuni1840@gmail.com>
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

inet6_sk(sk)->ipv6_ac_list is protected by lock_sock().

In ipv6_sock_ac_join(), only __dev_get_by_index(), __dev_get_by_flags(),
and __in6_dev_get() require RTNL.

__dev_get_by_flags() is only used by ipv6_sock_ac_join() and can be
converted to RCU version.

Let's replace RCU version helper and drop RTNL from IPV6_JOIN_ANYCAST.

setsockopt_needs_rtnl() will be removed in the next patch.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
v3: Use dst_dev() for rt->dst.dev
v2: Hold rcu_read_lock() around rt6_lookup & dev_hold()
---
 include/linux/netdevice.h |  4 ++--
 net/core/dev.c            | 38 ++++++++++++++++++--------------------
 net/ipv6/anycast.c        | 22 ++++++++++++++--------
 net/ipv6/ipv6_sockglue.c  |  4 ----
 4 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 5847c20994d3..a80d21a14612 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3332,8 +3332,8 @@ int dev_get_iflink(const struct net_device *dev);
 int dev_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb);
 int dev_fill_forward_path(const struct net_device *dev, const u8 *daddr,
 			  struct net_device_path_stack *stack);
-struct net_device *__dev_get_by_flags(struct net *net, unsigned short flags,
-				      unsigned short mask);
+struct net_device *dev_get_by_flags_rcu(struct net *net, unsigned short flags,
+					unsigned short mask);
 struct net_device *dev_get_by_name(struct net *net, const char *name);
 struct net_device *dev_get_by_name_rcu(struct net *net, const char *name);
 struct net_device *__dev_get_by_name(struct net *net, const char *name);
diff --git a/net/core/dev.c b/net/core/dev.c
index 96d33dead604..6076826384f6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1267,33 +1267,31 @@ struct net_device *dev_getfirstbyhwtype(struct net *net, unsigned short type)
 EXPORT_SYMBOL(dev_getfirstbyhwtype);
 
 /**
- *	__dev_get_by_flags - find any device with given flags
- *	@net: the applicable net namespace
- *	@if_flags: IFF_* values
- *	@mask: bitmask of bits in if_flags to check
+ * dev_get_by_flags_rcu - find any device with given flags
+ * @net: the applicable net namespace
+ * @if_flags: IFF_* values
+ * @mask: bitmask of bits in if_flags to check
  *
- *	Search for any interface with the given flags. Returns NULL if a device
- *	is not found or a pointer to the device. Must be called inside
- *	rtnl_lock(), and result refcount is unchanged.
+ * Search for any interface with the given flags.
+ *
+ * Context: rcu_read_lock() must be held.
+ * Returns: NULL if a device is not found or a pointer to the device.
  */
-
-struct net_device *__dev_get_by_flags(struct net *net, unsigned short if_flags,
-				      unsigned short mask)
+struct net_device *dev_get_by_flags_rcu(struct net *net, unsigned short if_flags,
+					unsigned short mask)
 {
-	struct net_device *dev, *ret;
-
-	ASSERT_RTNL();
+	struct net_device *dev;
 
-	ret = NULL;
-	for_each_netdev(net, dev) {
-		if (((dev->flags ^ if_flags) & mask) == 0) {
-			ret = dev;
-			break;
+	for_each_netdev_rcu(net, dev) {
+		if (((READ_ONCE(dev->flags) ^ if_flags) & mask) == 0) {
+			dev_hold(dev);
+			return dev;
 		}
 	}
-	return ret;
+
+	return NULL;
 }
-EXPORT_SYMBOL(__dev_get_by_flags);
+EXPORT_IPV6_MOD(dev_get_by_flags_rcu);
 
 /**
  *	dev_valid_name - check if name is okay for network device
diff --git a/net/ipv6/anycast.c b/net/ipv6/anycast.c
index fd3d104c6c05..53cf68e0242b 100644
--- a/net/ipv6/anycast.c
+++ b/net/ipv6/anycast.c
@@ -73,15 +73,13 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex, const struct in6_addr *addr)
 	struct inet6_dev *idev;
 	int err = 0, ishost;
 
-	ASSERT_RTNL();
-
 	if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
 		return -EPERM;
 	if (ipv6_addr_is_multicast(addr))
 		return -EINVAL;
 
 	if (ifindex)
-		dev = __dev_get_by_index(net, ifindex);
+		dev = dev_get_by_index(net, ifindex);
 
 	if (ipv6_chk_addr_and_flags(net, addr, dev, true, 0, IFA_F_TENTATIVE)) {
 		err = -EINVAL;
@@ -102,18 +100,22 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex, const struct in6_addr *addr)
 	if (ifindex == 0) {
 		struct rt6_info *rt;
 
+		rcu_read_lock();
 		rt = rt6_lookup(net, addr, NULL, 0, NULL, 0);
 		if (rt) {
-			dev = rt->dst.dev;
+			dev = dst_dev(&rt->dst);
+			dev_hold(dev);
 			ip6_rt_put(rt);
 		} else if (ishost) {
+			rcu_read_unlock();
 			err = -EADDRNOTAVAIL;
 			goto error;
 		} else {
 			/* router, no matching interface: just pick one */
-			dev = __dev_get_by_flags(net, IFF_UP,
-						 IFF_UP | IFF_LOOPBACK);
+			dev = dev_get_by_flags_rcu(net, IFF_UP,
+						   IFF_UP | IFF_LOOPBACK);
 		}
+		rcu_read_unlock();
 	}
 
 	if (!dev) {
@@ -121,7 +123,7 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex, const struct in6_addr *addr)
 		goto error;
 	}
 
-	idev = __in6_dev_get(dev);
+	idev = in6_dev_get(dev);
 	if (!idev) {
 		if (ifindex)
 			err = -ENODEV;
@@ -144,7 +146,7 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex, const struct in6_addr *addr)
 		if (ishost)
 			err = -EADDRNOTAVAIL;
 		if (err)
-			goto error;
+			goto error_idev;
 	}
 
 	err = __ipv6_dev_ac_inc(idev, addr);
@@ -154,7 +156,11 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex, const struct in6_addr *addr)
 		pac = NULL;
 	}
 
+error_idev:
+	in6_dev_put(idev);
 error:
+	dev_put(dev);
+
 	if (pac)
 		sock_kfree_s(sk, pac, sizeof(*pac));
 	return err;
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 3d891aa6e7f5..702dc33e50ad 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -119,10 +119,6 @@ struct ipv6_txoptions *ipv6_update_options(struct sock *sk,
 
 static bool setsockopt_needs_rtnl(int optname)
 {
-	switch (optname) {
-	case IPV6_JOIN_ANYCAST:
-		return true;
-	}
 	return false;
 }
 
-- 
2.49.0



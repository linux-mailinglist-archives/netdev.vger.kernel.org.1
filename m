Return-Path: <netdev+bounces-198341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B28EADBDBE
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A565D1893BAB
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 23:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9071A23B617;
	Mon, 16 Jun 2025 23:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPCRvPY5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC75723B616
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 23:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750116900; cv=none; b=neVDlmjNJv5YxApnTcJC5FFQe9eFubvTsFqd1NclyACxpA7IKgMn+xT9hWI43/gsy3WScesAikYntPlH8unHLCakfFkEtDWr6SqyY7NhfhMwfoDvliY5Mb7xOFaXEhRIXXczK7W8r5QWA6w4sQpJr8uCrl5ZOpE8wh5/nlmxvbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750116900; c=relaxed/simple;
	bh=qxJHrbJ+qsx84fThekE8SFj0SCkr930vz1FDBEGuQDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbjdjEs3dQrXm4L46pUkSGoxxTG7i0WKDfo+OKymRyTHGjgr3+A80DS7lkwa9JWXxS45svATjV5evGCq+gbkzuQhFtOJuBI4P6/cN8a/L56JiCuAddoNj5jTmX2jTaod6Cv/CU7ZkMmi8MhP8lZsjAaBNmBG/zbsfWGO9jQTbXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPCRvPY5; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-235e1d4cba0so45046775ad.2
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 16:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750116897; x=1750721697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWae8gGOFV+pleBGFeaYVZu76URD2ucU37QEzcpCTrU=;
        b=iPCRvPY5AbZZnZ1L6EG553TxjZ/o+7g+j1/D1cpAtle/e73s+d8P1gYu511z8x3ff+
         p/ahwjoZGRM4Xa9W+sIyvdmv2hnmZqrRwipsW36tsMKJPL73n/JfBf+1U9oEhhZj5uKG
         8dsuXvlS5dnCK6DhX1dIGVRmDGfbGf9atL9qJ6A9LooOEphNTszsJ9+JRBscqds1+Y13
         gcASfQnZrJhgEhnzQ+N7bOwxBpfJo0O/G3qKaSblwo/75yCqenliCXHhJokqovIIgTV0
         cx2JAXc/vL3JZnLx/NctwegpU6ZuYtcrJI5Xi1e/uUTWoCWcE1OGhHQiD/Qh5z27bP3u
         DnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750116897; x=1750721697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWae8gGOFV+pleBGFeaYVZu76URD2ucU37QEzcpCTrU=;
        b=POodHsSGmeN+PsXMciTMYhAZoAfMgTD9LhFIxK/1gsy1knJEk3Wsn3b7n1Nq5+AL+9
         FPPjpJJoZuKmITD8/v7M4eSUvyQ5M4Xb9EciNk7ypY9/FCbuDp35V0RBRh4C5kd5DbFE
         ekALxx5oosaYAzHcRk0cj4VUcWZXuZEgxRb3jm/AQ00sKkXDcNDc68jUu4LNZ5N6cCQa
         NtEhIL7AvrTw0Gz2RsrIhsmlG2gOTK4RVgwPnUEsDDP5ZMJtjhOKF6CWWWB3BSx/aXQQ
         R+TfA1uZiQSoTmUX/flGEuzSBa/XhttuvlR9XECXckebUC8vX4quKbcTzTFen0xe9dro
         JeAg==
X-Forwarded-Encrypted: i=1; AJvYcCUBNNrs4ymXgKlsu9s+VEzMSwVJaz+7uDN1AcJ8uICsk8ebPyuRHYIJIqujSbkn5KNAwPG3Uc4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx08qTtCLSUFZ6rprTfsZvvOSGImsmrjWX1I97/lHWjw9WFWxPr
	1gtY8Tf2F7cgKqf5N6lZzedhDEt6INdKsOXMwyjYCfuZH8a6Zh/Lv7c=
X-Gm-Gg: ASbGnct8+uNJKpEvheXAxjaIKyHVqTce5JxZ2InBwsfKbBfDJaKNBkqVk4bluby9x9Q
	fbdoIOY05gniuhYsu6d1NNz6YjKm8/kLHC16dsnrt4cLyeafxcAX+/CjXcQtfe3+RTF0xamejNi
	F7MzxgXEMwrmNYHxFjp2BC7uKRTYOsdeI9UDkGNbQ9hvlrYrs9c2NQiC19WnDd2TloK2J3YkteZ
	2nh7CIDUndSLHLHJsW5mSC96BllKUK/tFLieUJIJVXykMXLMwF28ppZ9S/2QuVWFwakp1PDhVCE
	LHgFOPxBp5oBgSKQqa8YAWk9u+FB2qrTKGLqHSI=
X-Google-Smtp-Source: AGHT+IEqF0yP6B3Ycx8/4ieeli+kFtS/UWWPAVtd44LwIaS+l09aXIScP9qiwngZuq/TJ1l1aqEPmw==
X-Received: by 2002:a17:902:c94e:b0:234:ed31:fc98 with SMTP id d9443c01a7336-2366b14e566mr158168285ad.37.1750116896884;
        Mon, 16 Jun 2025 16:34:56 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de89393sm67220485ad.114.2025.06.16.16.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 16:34:56 -0700 (PDT)
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
Subject: [PATCH v1 net-next 14/15] ipv6: anycast: Don't hold RTNL for IPV6_JOIN_ANYCAST.
Date: Mon, 16 Jun 2025 16:28:43 -0700
Message-ID: <20250616233417.1153427-15-kuni1840@gmail.com>
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

In ipv6_sock_ac_join(), only __dev_get_by_index(), __dev_get_by_flags(),
and __in6_dev_get() require RTNL.

__dev_get_by_flags() is only used by ipv6_sock_ac_join() and can be
converted to RCU version.

Let's replace RCU version helper and drop RTNL from IPV6_JOIN_ANYCAST.

setsockopt_needs_rtnl() will be removed in the next patch.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/linux/netdevice.h |  4 ++--
 net/core/dev.c            | 30 +++++++++++++++---------------
 net/ipv6/anycast.c        | 17 ++++++++++-------
 net/ipv6/ipv6_sockglue.c  |  4 ----
 4 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9cbc4e54b7e4..ec410f434d39 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3329,8 +3329,8 @@ int dev_get_iflink(const struct net_device *dev);
 int dev_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb);
 int dev_fill_forward_path(const struct net_device *dev, const u8 *daddr,
 			  struct net_device_path_stack *stack);
-struct net_device *__dev_get_by_flags(struct net *net, unsigned short flags,
-				      unsigned short mask);
+struct net_device *dev_get_by_flags(struct net *net, unsigned short flags,
+				    unsigned short mask);
 struct net_device *dev_get_by_name(struct net *net, const char *name);
 struct net_device *dev_get_by_name_rcu(struct net *net, const char *name);
 struct net_device *__dev_get_by_name(struct net *net, const char *name);
diff --git a/net/core/dev.c b/net/core/dev.c
index 5baa4691074f..17b57f1990b3 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1267,33 +1267,33 @@ struct net_device *dev_getfirstbyhwtype(struct net *net, unsigned short type)
 EXPORT_SYMBOL(dev_getfirstbyhwtype);
 
 /**
- *	__dev_get_by_flags - find any device with given flags
- *	@net: the applicable net namespace
- *	@if_flags: IFF_* values
- *	@mask: bitmask of bits in if_flags to check
+ * dev_get_by_flags - find any device with given flags
+ * @net: the applicable net namespace
+ * @if_flags: IFF_* values
+ * @mask: bitmask of bits in if_flags to check
+ *
+ * Search for any interface with the given flags.
  *
- *	Search for any interface with the given flags. Returns NULL if a device
- *	is not found or a pointer to the device. Must be called inside
- *	rtnl_lock(), and result refcount is unchanged.
+ * Returns: NULL if a device is not found or a pointer to the device.
  */
-
-struct net_device *__dev_get_by_flags(struct net *net, unsigned short if_flags,
-				      unsigned short mask)
+struct net_device *dev_get_by_flags(struct net *net, unsigned short if_flags,
+				    unsigned short mask)
 {
-	struct net_device *dev, *ret;
-
-	ASSERT_RTNL();
+	struct net_device *dev, *ret = NULL;
 
-	ret = NULL;
+	rcu_read_lock();
 	for_each_netdev(net, dev) {
 		if (((dev->flags ^ if_flags) & mask) == 0) {
 			ret = dev;
+			dev_hold(ret);
 			break;
 		}
 	}
+	rcu_read_unlock();
+
 	return ret;
 }
-EXPORT_SYMBOL(__dev_get_by_flags);
+EXPORT_IPV6_MOD(dev_get_by_flags);
 
 /**
  *	dev_valid_name - check if name is okay for network device
diff --git a/net/ipv6/anycast.c b/net/ipv6/anycast.c
index e0a1f9d7622c..954c8cbb70f9 100644
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
@@ -105,14 +103,15 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex, const struct in6_addr *addr)
 		rt = rt6_lookup(net, addr, NULL, 0, NULL, 0);
 		if (rt) {
 			dev = rt->dst.dev;
+			dev_hold(dev);
 			ip6_rt_put(rt);
 		} else if (ishost) {
 			err = -EADDRNOTAVAIL;
 			goto error;
 		} else {
 			/* router, no matching interface: just pick one */
-			dev = __dev_get_by_flags(net, IFF_UP,
-						 IFF_UP | IFF_LOOPBACK);
+			dev = dev_get_by_flags(net, IFF_UP,
+					       IFF_UP | IFF_LOOPBACK);
 		}
 	}
 
@@ -121,7 +120,7 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex, const struct in6_addr *addr)
 		goto error;
 	}
 
-	idev = __in6_dev_get(dev);
+	idev = in6_dev_get(dev);
 	if (!idev) {
 		if (ifindex)
 			err = -ENODEV;
@@ -143,7 +142,7 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex, const struct in6_addr *addr)
 		if (ishost)
 			err = -EADDRNOTAVAIL;
 		if (err)
-			goto error;
+			goto error_idev;
 	}
 
 	err = __ipv6_dev_ac_inc(idev, addr);
@@ -153,7 +152,11 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex, const struct in6_addr *addr)
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



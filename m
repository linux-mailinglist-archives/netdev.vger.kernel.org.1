Return-Path: <netdev+bounces-200831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E26BAAE70B3
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 22:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB1955A5061
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 20:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B042EF9BB;
	Tue, 24 Jun 2025 20:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzXgCm+6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1C32EB5D8
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 20:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750796807; cv=none; b=XIXztAh75Ewi81Rl8Bee1/qt2Ufff7p8y/AibI+BU4GVJF6K9Z4wO9xJyZWUrY8nOeXe3p9XtLgfa0wO0cijqIjiUrst28jUB780fagcp8QGdKqdXOuDsZx/dgWLP8mC9w5o1NfEHbWPRz5GfJ6UrCgSWMZwLyr8D6yQEBEhFj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750796807; c=relaxed/simple;
	bh=8m02j+liHsCe2o+RawwfK3A1VNPef+ThYTT6AVphNeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VjX0JHUQRdTqYNS0KGlBV+b48kw25r1ZwBOnGRBpcv+Ef1E+/0XFG3ly+dGNjxXz+1P2KjiHX3pw7hom1ytYn/2wfsCP7ZE1rGhMIYKtZ6lET6A1ErH9GSoZRhqvprERc1XeflxW4gijks0SxQ3SNRhr7qTklyCJibKLNUzzJRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzXgCm+6; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-748fe69a7baso567994b3a.3
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 13:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750796805; x=1751401605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jITxkHqlVdmhbv2Vct5Iv1G4yz29mQsURIxYg2YGWmE=;
        b=OzXgCm+6i3GscyQRcF8iYgeevaQ39TpVQe5gI7bndEmUS5bnyt2p2uY7+XlV/gFEvF
         Q0B56RVS6wqdfA45PfkN4CNklKUDmq5gMzfk2vOIcS4i0q5/me/WrLlo4+1Tjzpj6sJ6
         Z3kB7Yl5BRT+HL0S9ynE0+7wpJvoCODj++m3t2Ld7KbfDVIo1TMqOolxLk8iCWxHSz0H
         7fEaEDj3rKQMPcTcJ4z0f4/xnNBcIouZU+s33SkZXQ7rRNPA1fz+QtIvZxAtTmzAJFOQ
         X48AX9tEZ4DeDynaiSZMPlaDjnoBiDCa8lEjR/c5L4IYx2JFKYGMDbtUeJfm/cSUNmxT
         Ot8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750796805; x=1751401605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jITxkHqlVdmhbv2Vct5Iv1G4yz29mQsURIxYg2YGWmE=;
        b=Iqv5vGc1mxK647dnGCKLIb80VQXgZZAZa/yqCR/uwofjsSxTV3/c1MziLC8Egv2Y2N
         hao31FvcGWn/UIbjQYh46mmW/ddqzfNzciQbIiPC+nbIU70rMS0Q8JVOv1MjKQr/a7Tm
         +gW/kubMoGLHVQO/ezOnDiAT3GPv1wota+LlYj1Gqs9UYEaVPZ7BauqlYfBmrX8+551R
         M9YeVBfZREjo0jG5s/8IvJpc/MSwSmcyQCo/tK7z+fLF9cJZ5scfZ1WAMzmXezq2etPo
         hNqePCHP7ZE/KL7t1tpNLR+/mlSraDWw3We9EANM7eZmoaNprWm3npfW/+pi2iuQz7m8
         zvFw==
X-Forwarded-Encrypted: i=1; AJvYcCUrJf6WUAk2mkyiGBRfSkpCpVM2pRh0gr8c5SKWE/0DlGHhKoiQ3sMT2mA+o5HNgRNtc/wT9n0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMIQs/sM4H6MoRQvO1eZffws/ChNjekbcN3EG+6FQ3a/IGopH2
	2BN5aCIgNJElyHW9RWFO4QSh/ide2wX50Lh+YgiHvRMudBeo9RXzBdM=
X-Gm-Gg: ASbGncvLfsgy1t9AYX6oBlBQuAm/UrrCpQ24Tepq7q2LMRHLF166UarSCwBLQF26V11
	4fBFy/ZnIQexsUmXmGsQY54WnYP+CFYUNOqshMEhD/T8TSzUqNXP9zDlIhHvXuF7+P2LO3o7FwO
	wodxl5f1pwdDBs0vVREREd8vqTbxK2p1HZXjs/L7JHvatCOANtrRwfSnUbhTiq4ZN/6aCOBQJcG
	w6RhwxkpgDi80KX7BvDBtLSULHvJT4F40za4QfQeDrNfdosYq5KTkUnp1f7l0q6WfiXrWWDdOb9
	nX1SEYrH9iG6/luINwHeMaRj2QdzlIp70ijrzP0=
X-Google-Smtp-Source: AGHT+IE+oWXsyqRzRnF++a6nmpiMDWaAp9ANwltYghhTGqdxUYz+jGo4m3A33rCvJmiO3bGN63k4oA==
X-Received: by 2002:a05:6a00:2d1b:b0:736:4644:86ee with SMTP id d2e1a72fcca58-74ad4564761mr710904b3a.14.1750796804632;
        Tue, 24 Jun 2025 13:26:44 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::a408])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74a9697817esm2252994b3a.124.2025.06.24.13.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 13:26:44 -0700 (PDT)
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
Subject: [PATCH v2 net-next 14/15] ipv6: anycast: Don't hold RTNL for IPV6_JOIN_ANYCAST.
Date: Tue, 24 Jun 2025 13:24:20 -0700
Message-ID: <20250624202616.526600-15-kuni1840@gmail.com>
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

In ipv6_sock_ac_join(), only __dev_get_by_index(), __dev_get_by_flags(),
and __in6_dev_get() require RTNL.

__dev_get_by_flags() is only used by ipv6_sock_ac_join() and can be
converted to RCU version.

Let's replace RCU version helper and drop RTNL from IPV6_JOIN_ANYCAST.

setsockopt_needs_rtnl() will be removed in the next patch.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Hold rcu_read_lock() around rt6_lookup & dev_hold()
---
 include/linux/netdevice.h |  4 ++--
 net/core/dev.c            | 38 ++++++++++++++++++--------------------
 net/ipv6/anycast.c        | 20 +++++++++++++-------
 net/ipv6/ipv6_sockglue.c  |  4 ----
 4 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 03c26bb0fbbe..68f874a58c92 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3339,8 +3339,8 @@ int dev_get_iflink(const struct net_device *dev);
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
index 7ee808eb068e..553c654e6f77 100644
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
index e0a1f9d7622c..427fa95018b7 100644
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
 			dev = rt->dst.dev;
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
@@ -143,7 +145,7 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex, const struct in6_addr *addr)
 		if (ishost)
 			err = -EADDRNOTAVAIL;
 		if (err)
-			goto error;
+			goto error_idev;
 	}
 
 	err = __ipv6_dev_ac_inc(idev, addr);
@@ -153,7 +155,11 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex, const struct in6_addr *addr)
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



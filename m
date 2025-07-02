Return-Path: <netdev+bounces-203562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDF8AF65CF
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 01:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45DB07B53C4
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 23:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720E72F6F83;
	Wed,  2 Jul 2025 23:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmFZ5qPj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAEB2F5C50
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 23:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497351; cv=none; b=II414OJvrSv4XvryEKvzQHDcaAUJ2P5GjujyElU9DqNdVRUr5LPsmfX942plI3n2TdDDezOnhm6k/z7Sn3nB1DBCbzRu2/k7AJ2gEmAP3l3pcfc8rncsd5lZBmYHXeQLq/czh+FMfPTzaiXw7bGjfkNu8W8zQrIwfu6cuT4LI9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497351; c=relaxed/simple;
	bh=2j666EZDsLZcDO+q/tvlW9T/a/n0ibXgS3kF5RLl2Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLMmXKGzJOUZFHk3bO0QNhFQ3e9pXr8SvabIwr6DnCU6QPvCyeOQ7uprnlhDq5MwjSXH58onIGvsWJQhxMeebrq/4OEsE5btLmxFA00FHnxpBcSzdoe70dlFrXPuZzkbb9EZv61zlsC9WfAyJdBWL+HSHl5+8oFg958ifK/+64Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmFZ5qPj; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2366e5e4dbaso2640315ad.1
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 16:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751497349; x=1752102149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=terYfdIo23ex3C6lhWgz5Ib7Nw4cucDbZxa/Zf+n5SI=;
        b=NmFZ5qPjM09LaO7TmmLXlekxP0EzO4IwtZJ9YdTyDXXtqeZYoQXVMDT6Z42rTxvcZV
         2txLcZ4uKwsGk+2e2jJJeFzH0z4VBz4OUwsAnx5vvUg5/QWU8kzDNAkeGBHiqipLduyh
         doH7dfAyuhmb/AMNFpgaWhV7XZoh13DKmYwjbba6Ksy9v+iKnyzuW7HUaVnpvM5rRpJU
         MOsJJJp6saHvMZGzZYcbr3nsIkfIgvwjuyI+eUQ/Ik+hneJhv74DzXD5rgAsUxdVr1gi
         RsF7FbMcKYA11S+fTWkw7j21MtwRVa/hx5iWaG7eNq8Jz1AYpASNjUMGeeYkvyU4VVQV
         hYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497349; x=1752102149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=terYfdIo23ex3C6lhWgz5Ib7Nw4cucDbZxa/Zf+n5SI=;
        b=MdYS6jE4FehJUCxHnohYsmFesP0neI6nKJS7Qi27BRHnf49sm44q+x5mu9jRtQTPZF
         N03QXR7nUWEXErRLy493uzr6GBTZsLJ0s9OmEa76ccol0FKyB7kD7uy+KSk/z93WlJs/
         FZQzpCjUqJVcYeMP/+Ne8wT8zFXmebEsnHh0sZK0qbgDPP/gHFDubjZK+I0PHkbUBiqp
         99nZ/0HpkJuOE43UYPKZgCeLuFvalh9SNGyfh2S1A0eGoUFuQ5XNKLOUYXJ31KZQwSUq
         jnJyaTrNf+9UjnWJeVH5hVkf/C80X6j07Fe9heqRVKrm/jLTSEQkmOSHEqQFC+JIZzph
         o8RQ==
X-Forwarded-Encrypted: i=1; AJvYcCXs8xHTicGTBIrfWxHHz7kpcf7dzFsTQWWAqmF4K2hllAqx6w8vh7jpw0hHQVcLLr5lFGr78+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxifpqYcxCQ0A8nyu1AdbdwsKZr7LAEjlP1fpaBNwBguiVByoR7
	HKxjIqkcxECEL1rVoaEDbm/nILIKoIes7NQ30vEiBu0C0+/xTk2OCio=
X-Gm-Gg: ASbGncsl29ASKxWLRUVLkTC1aLFfFMoXbJt8Zz8oIStWxwzK9X+Tmnha6XuOyd8I9+f
	2KFtyELlgqz9RxbSHqgzknyou2LeP2bvAFSUmmTTICakjL+nk44pVMEEccLzAMoY2wf2MHcDv9O
	kipTX+nQrotLFeo0LOpyxcDhFB5HoOgkJK7KleStAi8rsJejGia0eV5ItulsogWCTXWBNatSoYD
	sU4zSGW7V1Rwkv0RCSLyEUSPOPMaycHU/ZquiwnJVJLvKZlMCfttDKwjE6AqosrIH2peF6kmto8
	6qduQVGWG12Bl2LjDH1s1tD7WDNy06B2MUOyLu4=
X-Google-Smtp-Source: AGHT+IEU7Tk1uCI8NAVn3bnmIDQfBZNQ7VrPOTSv9jeL+r3Mmkqlx4/imQpkQ7P07VIhAO2gvcZjZA==
X-Received: by 2002:a17:90b:4f92:b0:315:aa6d:f20e with SMTP id 98e67ed59e1d1-31a9f4e0d64mr43907a91.4.1751497348991;
        Wed, 02 Jul 2025 16:02:28 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::a408])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9cc70a17sm727071a91.26.2025.07.02.16.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:02:28 -0700 (PDT)
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
Subject: [PATCH v3 net-next 12/15] ipv6: anycast: Don't hold RTNL for IPV6_LEAVE_ANYCAST and IPV6_ADDRFORM.
Date: Wed,  2 Jul 2025 16:01:29 -0700
Message-ID: <20250702230210.3115355-13-kuni1840@gmail.com>
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

In ipv6_sock_ac_drop() and ipv6_sock_ac_close(),
only __dev_get_by_index() and __in6_dev_get() requrie RTNL.

Let's replace them with dev_get_by_index() and in6_dev_get()
and drop RTNL from IPV6_LEAVE_ANYCAST and IPV6_ADDRFORM.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
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



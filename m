Return-Path: <netdev+bounces-77987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF289873B2F
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48200B22793
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 15:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC470135A5F;
	Wed,  6 Mar 2024 15:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wx8Zc5nK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433491353F2
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 15:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740315; cv=none; b=gweDdQw/bhIoMpMIfAJWuzwsTaNJa6105U0T2asfTOF0hRapPVJlU1Sm7E9VjgMP2mm6v+sLvDt+pXD7CVfYqF+7yX8q31Gr7GemiC+jiVwwRtOHqqfw9UH6PfVmEz1IKQBsevrcHTQQidD4ZDKyZit0upOuTgjDkl1q7ugoqoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740315; c=relaxed/simple;
	bh=cxKSgnoL35xm6pqOfKpuLcoFp3pjlT63iTrUrhoZzRY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G8GVHcVu2F2tbmxvTKeoWjJlry1nu0Pi34rg2OUzYjsUDLgPZTK86LWXGwXeyHus8Ofz3PUf6VQ6H/kDPi9e7l4sp2ThYZ2VC8qqng1fK2sR//Oc2iVwZ0Xp9pLS2aDgTsJhVL0REbsJylpqBq6QXbls/83Bpby+mZlh/zMKh78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wx8Zc5nK; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc74ac7d015so8520298276.0
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 07:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709740313; x=1710345113; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oNDzUBZKfUxoD5l3LUyv6FaIwoO+eA5F+4pgiz61cB0=;
        b=wx8Zc5nKr7mGcwUEpvL+PgTnyfuuTfptvVaYMrHMZEHiYrmod3l73OvuGspnmp5x2B
         o4rFcwi+jH0KDFoKTQmOrkc55P4ySdO7TWRSUtBJaqvv7jWeeiWrmKhRgrZd265wyNs8
         t8g34ViBa976QeMPRlp7iKkXSr7Fe91VsLqCDVjSe/WQU7ZTsEB3wxvXGof5V+fLCPNK
         9BjZ1hv4qbYIiREY7F2/pcXxCFQKSyhC9RzwhMiUDyPgZCjuTmpzounV2y7o0IdzWagO
         Wsgpc53Q+eWXZchArnVXwWuC67ec4++vDzcTk6faB5Qav+Fiwh/PVbg53IQkD7q5TgQF
         xFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709740313; x=1710345113;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oNDzUBZKfUxoD5l3LUyv6FaIwoO+eA5F+4pgiz61cB0=;
        b=SM5LbZecqj4tvuPrsVabzrU3qGI+gkF9ey2TBSyx4zinDIUgBWJqkkkl+V3yYA4R0o
         mNEgPmY9IsOM8RObIHdhj15e6ieHJdi173s50+ARk4DAM+mihbBHdz4XrRn59DUbOcsR
         B8k8JHxErt3oOajqVyU/Pt2n7LYIk+Nz0QyCP0ncxG5R/A41Iotupm0zy57idJPHmgKZ
         MaA846tXGCA2v/3QDkZ1grtiFff7iXaJJ+50T4vlvXhf8leiW0h2IIf+Md+ZX47GPhni
         LyVHh8HczFpUGkShL9EugRCAiZXZrmKVd5QD5FpEFieXKVPpFVSo9yM3oGsmpPsJn6E8
         5M2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPxCCarv3o4PnjtFOFGnC57i0fTc5nHgNZ/avoic2n+2Rqskzn/sP3k/4WKzSeP5THAvTFQvM+UMclAMnjUjRpCkWZaB8J
X-Gm-Message-State: AOJu0YyeuU5we0UfoRahGbmHx0dZDIqYa/IGoop2SHsU5O2MjYDxhxOp
	HD5lRMMnY11mHzpw4SkcPANBbEPXWgHEQL7xhqTaMU88AkQTXyperpz0ss4upRISxWhGTksPuF9
	e+TCw0+pD6A==
X-Google-Smtp-Source: AGHT+IH9ga0bt2H74hMBnJZDfFzl+mTfcmVHwuOEQNom6u29FrgQSEShwjgNLtaL2NN14dzJaS6G+kyqObwabA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1082:b0:dce:30f5:6bc5 with SMTP
 id v2-20020a056902108200b00dce30f56bc5mr652377ybu.4.1709740313558; Wed, 06
 Mar 2024 07:51:53 -0800 (PST)
Date: Wed,  6 Mar 2024 15:51:43 +0000
In-Reply-To: <20240306155144.870421-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306155144.870421-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306155144.870421-4-edumazet@google.com>
Subject: [PATCH net-next 3/4] ipv6: use xa_array iterator to implement inet6_dump_addr()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

inet6_dump_addr() can use the new xa_array iterator
for better scalability.

Make it ready for RCU-only protection.
RTNL use is removed in the following patch.

Also properly return 0 at the end of a dump to avoid
and extra recvmsg() to get NLMSG_DONE.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/addrconf.c | 79 +++++++++++++++++----------------------------
 1 file changed, 30 insertions(+), 49 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index f063a718893d989bc3362416a6b49ed14bb4c4ea..82ba44a23bd7434e93e8a847f38cc72d8ce228a8 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -717,7 +717,7 @@ static int inet6_netconf_get_devconf(struct sk_buff *in_skb,
 static u32 inet6_base_seq(const struct net *net)
 {
 	u32 res = atomic_read(&net->ipv6.dev_addr_genid) +
-		  net->dev_base_seq;
+		  READ_ONCE(net->dev_base_seq);
 
 	/* Must not return 0 (see nl_dump_check_consistent()).
 	 * Chose a value far away from 0.
@@ -5274,13 +5274,13 @@ static int inet6_fill_ifacaddr(struct sk_buff *skb,
 
 /* called with rcu_read_lock() */
 static int in6_dump_addrs(const struct inet6_dev *idev, struct sk_buff *skb,
-			  struct netlink_callback *cb, int s_ip_idx,
+			  struct netlink_callback *cb, int *s_ip_idx,
 			  struct inet6_fill_args *fillargs)
 {
 	const struct ifmcaddr6 *ifmca;
 	const struct ifacaddr6 *ifaca;
 	int ip_idx = 0;
-	int err = 1;
+	int err = 0;
 
 	switch (fillargs->type) {
 	case UNICAST_ADDR: {
@@ -5289,7 +5289,7 @@ static int in6_dump_addrs(const struct inet6_dev *idev, struct sk_buff *skb,
 
 		/* unicast address incl. temp addr */
 		list_for_each_entry_rcu(ifa, &idev->addr_list, if_list) {
-			if (ip_idx < s_ip_idx)
+			if (ip_idx < *s_ip_idx)
 				goto next;
 			err = inet6_fill_ifaddr(skb, ifa, fillargs);
 			if (err < 0)
@@ -5307,7 +5307,7 @@ static int in6_dump_addrs(const struct inet6_dev *idev, struct sk_buff *skb,
 		for (ifmca = rcu_dereference(idev->mc_list);
 		     ifmca;
 		     ifmca = rcu_dereference(ifmca->next), ip_idx++) {
-			if (ip_idx < s_ip_idx)
+			if (ip_idx < *s_ip_idx)
 				continue;
 			err = inet6_fill_ifmcaddr(skb, ifmca, fillargs);
 			if (err < 0)
@@ -5319,7 +5319,7 @@ static int in6_dump_addrs(const struct inet6_dev *idev, struct sk_buff *skb,
 		/* anycast address */
 		for (ifaca = rcu_dereference(idev->ac_list); ifaca;
 		     ifaca = rcu_dereference(ifaca->aca_next), ip_idx++) {
-			if (ip_idx < s_ip_idx)
+			if (ip_idx < *s_ip_idx)
 				continue;
 			err = inet6_fill_ifacaddr(skb, ifaca, fillargs);
 			if (err < 0)
@@ -5329,7 +5329,7 @@ static int in6_dump_addrs(const struct inet6_dev *idev, struct sk_buff *skb,
 	default:
 		break;
 	}
-	cb->args[2] = ip_idx;
+	*s_ip_idx = err ? ip_idx : 0;
 	return err;
 }
 
@@ -5392,6 +5392,7 @@ static int inet6_valid_dump_ifaddr_req(const struct nlmsghdr *nlh,
 static int inet6_dump_addr(struct sk_buff *skb, struct netlink_callback *cb,
 			   enum addr_type_t type)
 {
+	struct net *tgt_net = sock_net(skb->sk);
 	const struct nlmsghdr *nlh = cb->nlh;
 	struct inet6_fill_args fillargs = {
 		.portid = NETLINK_CB(cb->skb).portid,
@@ -5400,72 +5401,52 @@ static int inet6_dump_addr(struct sk_buff *skb, struct netlink_callback *cb,
 		.netnsid = -1,
 		.type = type,
 	};
-	struct net *tgt_net = sock_net(skb->sk);
-	int idx, s_idx, s_ip_idx;
-	int h, s_h;
+	struct {
+		unsigned long ifindex;
+		int ip_idx;
+	} *ctx = (void *)cb->ctx;
 	struct net_device *dev;
 	struct inet6_dev *idev;
-	struct hlist_head *head;
 	int err = 0;
 
-	s_h = cb->args[0];
-	s_idx = idx = cb->args[1];
-	s_ip_idx = cb->args[2];
-
 	rcu_read_lock();
 	if (cb->strict_check) {
 		err = inet6_valid_dump_ifaddr_req(nlh, &fillargs, &tgt_net,
 						  skb->sk, cb);
 		if (err < 0)
-			goto put_tgt_net;
+			goto done;
 
 		err = 0;
 		if (fillargs.ifindex) {
-			dev = __dev_get_by_index(tgt_net, fillargs.ifindex);
-			if (!dev) {
-				err = -ENODEV;
-				goto put_tgt_net;
-			}
+			err = -ENODEV;
+			dev = dev_get_by_index_rcu(tgt_net, fillargs.ifindex);
+			if (!dev)
+				goto done;
 			idev = __in6_dev_get(dev);
-			if (idev) {
-				err = in6_dump_addrs(idev, skb, cb, s_ip_idx,
+			if (idev)
+				err = in6_dump_addrs(idev, skb, cb,
+						     &ctx->ip_idx,
 						     &fillargs);
-				if (err > 0)
-					err = 0;
-			}
-			goto put_tgt_net;
+			goto done;
 		}
 	}
 
 	cb->seq = inet6_base_seq(tgt_net);
-	for (h = s_h; h < NETDEV_HASHENTRIES; h++, s_idx = 0) {
-		idx = 0;
-		head = &tgt_net->dev_index_head[h];
-		hlist_for_each_entry_rcu(dev, head, index_hlist) {
-			if (idx < s_idx)
-				goto cont;
-			if (h > s_h || idx > s_idx)
-				s_ip_idx = 0;
-			idev = __in6_dev_get(dev);
-			if (!idev)
-				goto cont;
-
-			if (in6_dump_addrs(idev, skb, cb, s_ip_idx,
-					   &fillargs) < 0)
-				goto done;
-cont:
-			idx++;
-		}
+	for_each_netdev_dump(tgt_net, dev, ctx->ifindex) {
+		idev = __in6_dev_get(dev);
+		if (!idev)
+			continue;
+		err = in6_dump_addrs(idev, skb, cb, &ctx->ip_idx,
+				     &fillargs);
+		if (err < 0)
+			goto done;
 	}
 done:
-	cb->args[0] = h;
-	cb->args[1] = idx;
-put_tgt_net:
 	rcu_read_unlock();
 	if (fillargs.netnsid >= 0)
 		put_net(tgt_net);
 
-	return skb->len ? : err;
+	return err;
 }
 
 static int inet6_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
-- 
2.44.0.278.ge034bb2e1d-goog



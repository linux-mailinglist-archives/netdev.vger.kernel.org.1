Return-Path: <netdev+bounces-233415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E48C12C94
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 04:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BBBD3BA5C3
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 03:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182122857CA;
	Tue, 28 Oct 2025 03:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d3YfNIqN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505EF27F4E7
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 03:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761622727; cv=none; b=hHFbrIN/vWOaIb/Ytjv5TXypHLJURWKu1AASc1O73kYlZEY1I2VxuuBDc1ySbyPRv0v+vatZvnNEntSycVLA7UwYFa4KZoPsYE2B18gQLn/rigy/nLmw4yyJjkUbXUyPgxOE0RLBoZfXD2napiFlooXgVi8aQwCUPSrPGKRFf88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761622727; c=relaxed/simple;
	bh=cYtgIm43m0M+3PGbEF4xUgWqKDpC21SwHiM6Lja6Q7w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gk4TQh41H7I2kLTdPUDZKTcxo/wCgy6FhngjV2RPaEj2wm4QRjFqOeo54CVfkt050+Cjqt0pU5bmyZ/1ymLGFgikr3FSj4WtGJ+Kien248rWWx/jy/jDOKwow3AYsdfAyOEYbTcS9WRioQVDNc2keb52zYUAWCRcDN63Tcpp5ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d3YfNIqN; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-340299fd99dso452008a91.0
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 20:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761622724; x=1762227524; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6bwBVi6LjNvwy6CLTyIFThrB1Alx6m6QfzpIzmkYZeA=;
        b=d3YfNIqN2XglJnNWOEjSLfCAfXfUApXcWtKN+OCNSWYXxpjWhF5b8K/pPECzm408xr
         v5VWSl5DVdVYtJUPtdS/rHx9J3fOX9XCiWruvWyp+Rso4eUxlDHfRNcFWnaaWXmtwIXC
         ehnitN7nCPRQk1M7jbgrueJWDP/U1Cd4sO/1kZ2Nu1sCwlS8K5rsCjPXQUDiyShGQj/W
         i+q1zoyN+wTQn5m3CkpsSZE3koaHuqQ3MKNpOz9FSc+dP10hEWqP5riPjmbAXEa8n5bN
         e+vqSZvSkri5juhFoW7AXV31VCdLKY+ZC/g2caMu6bmrmEGyN0d1RZxnh4h9MPbEXguV
         RTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761622724; x=1762227524;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6bwBVi6LjNvwy6CLTyIFThrB1Alx6m6QfzpIzmkYZeA=;
        b=SgbHfwK4MMeq40EyssFTLyU8Jx+I8hykaNn7ox/ef4GNmFUynUlTVlngN+wu7oVRNd
         dHItL5oWfj8jQzTF1ScMyAZmyTYyNcLff9vOZ1xTmQVLr4WE6SdQ8tJ21RKj1YPad3+T
         luiDefjBzGwEBWXN3DzXHg3Z7LK9l5SWYOjU4YYYW8xgGJIEQ3pilyyMBp1SpsyTaasn
         UzmdnY9Mv1m5N0aQ+jxouERvSVOZBt4zF0WhqvHNnUuovbKro3hAf47KJd/eQ24xM8If
         DpSWyodyKr2vwO/PTJ5lp3K9EWYXixWRRkqZFKdPv4xXGv+99+Q3JiF7fSEqwQJWGPpq
         qotg==
X-Forwarded-Encrypted: i=1; AJvYcCXOcBs43FIcabklxtJx21ChywRpvH/43o4UDBWCOSvkTkLQsGplwt1yG/MxQ6sEkqKX7f0JieE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAc9Rh2xVjmpg8sj767OaBg1UMZ+9LdHckRQc+830qSNdTCueX
	SWwYXyb8AHV1Mpr4MWg0bW6yJ5zssmUI75iyBc5ikpxG/INatI7mjCDIov62f3Puz4Kxbl4NGiq
	DBZ8F+g==
X-Google-Smtp-Source: AGHT+IHRInTJogDZTU8t+uLen8x5HZ1h3uffZovB931YFoEzMEFM8SqQnurQxFfcoQpNQ1k2BB7Gvh8DZ84=
X-Received: from plte1.prod.google.com ([2002:a17:902:7441:b0:24c:7829:4af6])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1c9:b0:28e:acf2:a782
 with SMTP id d9443c01a7336-294cb52e3d8mr26891535ad.37.1761622724681; Mon, 27
 Oct 2025 20:38:44 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:37:07 +0000
In-Reply-To: <20251028033812.2043964-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028033812.2043964-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.838.g19442a804e-goog
Message-ID: <20251028033812.2043964-13-kuniyu@google.com>
Subject: [PATCH v1 net-next 12/13] mpls: Protect net->mpls.platform_label with
 a per-netns mutex.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

MPLS (re)uses RTNL to protect net->mpls.platform_label,
but the lock does not need to be RTNL at all.

Let's protect net->mpls.platform_label with a dedicated
per-netns mutex.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/netns/mpls.h |  1 +
 net/mpls/af_mpls.c       | 55 ++++++++++++++++++++++++++--------------
 net/mpls/internal.h      |  7 ++++-
 3 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/include/net/netns/mpls.h b/include/net/netns/mpls.h
index 19ad2574b267..6682e51513ef 100644
--- a/include/net/netns/mpls.h
+++ b/include/net/netns/mpls.h
@@ -16,6 +16,7 @@ struct netns_mpls {
 	int default_ttl;
 	size_t platform_labels;
 	struct mpls_route __rcu * __rcu *platform_label;
+	struct mutex platform_mutex;
 
 	struct ctl_table_header *ctl;
 };
diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index ffd8bc96be55..afe5b0b70b23 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -79,8 +79,8 @@ static struct mpls_route *mpls_route_input(struct net *net, unsigned int index)
 {
 	struct mpls_route __rcu **platform_label;
 
-	platform_label = rtnl_dereference(net->mpls.platform_label);
-	return rtnl_dereference(platform_label[index]);
+	platform_label = mpls_dereference(net, net->mpls.platform_label);
+	return mpls_dereference(net, platform_label[index]);
 }
 
 static struct mpls_route *mpls_route_input_rcu(struct net *net, unsigned int index)
@@ -578,10 +578,8 @@ static void mpls_route_update(struct net *net, unsigned index,
 	struct mpls_route __rcu **platform_label;
 	struct mpls_route *rt;
 
-	ASSERT_RTNL();
-
-	platform_label = rtnl_dereference(net->mpls.platform_label);
-	rt = rtnl_dereference(platform_label[index]);
+	platform_label = mpls_dereference(net, net->mpls.platform_label);
+	rt = mpls_dereference(net, platform_label[index]);
 	rcu_assign_pointer(platform_label[index], new);
 
 	mpls_notify_route(net, index, rt, new, info);
@@ -1472,8 +1470,6 @@ static struct mpls_dev *mpls_add_dev(struct net_device *dev)
 	int err = -ENOMEM;
 	int i;
 
-	ASSERT_RTNL();
-
 	mdev = kzalloc(sizeof(*mdev), GFP_KERNEL);
 	if (!mdev)
 		return ERR_PTR(err);
@@ -1633,6 +1629,8 @@ static int mpls_dev_notify(struct notifier_block *this, unsigned long event,
 	unsigned int flags;
 	int err;
 
+	mutex_lock(&net->mpls.platform_mutex);
+
 	if (event == NETDEV_REGISTER) {
 		mdev = mpls_add_dev(dev);
 		if (IS_ERR(mdev)) {
@@ -1695,9 +1693,11 @@ static int mpls_dev_notify(struct notifier_block *this, unsigned long event,
 	}
 
 out:
+	mutex_unlock(&net->mpls.platform_mutex);
 	return NOTIFY_OK;
 
 err:
+	mutex_unlock(&net->mpls.platform_mutex);
 	return notifier_from_errno(err);
 }
 
@@ -1973,6 +1973,7 @@ static int rtm_to_route_config(struct sk_buff *skb,
 static int mpls_rtm_delroute(struct sk_buff *skb, struct nlmsghdr *nlh,
 			     struct netlink_ext_ack *extack)
 {
+	struct net *net = sock_net(skb->sk);
 	struct mpls_route_config *cfg;
 	int err;
 
@@ -1984,7 +1985,9 @@ static int mpls_rtm_delroute(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		goto out;
 
+	mutex_lock(&net->mpls.platform_mutex);
 	err = mpls_route_del(cfg, extack);
+	mutex_unlock(&net->mpls.platform_mutex);
 out:
 	kfree(cfg);
 
@@ -1995,6 +1998,7 @@ static int mpls_rtm_delroute(struct sk_buff *skb, struct nlmsghdr *nlh,
 static int mpls_rtm_newroute(struct sk_buff *skb, struct nlmsghdr *nlh,
 			     struct netlink_ext_ack *extack)
 {
+	struct net *net = sock_net(skb->sk);
 	struct mpls_route_config *cfg;
 	int err;
 
@@ -2006,7 +2010,9 @@ static int mpls_rtm_newroute(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		goto out;
 
+	mutex_lock(&net->mpls.platform_mutex);
 	err = mpls_route_add(cfg, extack);
+	mutex_unlock(&net->mpls.platform_mutex);
 out:
 	kfree(cfg);
 
@@ -2407,6 +2413,8 @@ static int mpls_getroute(struct sk_buff *in_skb, struct nlmsghdr *in_nlh,
 	u8 n_labels;
 	int err;
 
+	mutex_lock(&net->mpls.platform_mutex);
+
 	err = mpls_valid_getroute_req(in_skb, in_nlh, tb, extack);
 	if (err < 0)
 		goto errout;
@@ -2450,7 +2458,8 @@ static int mpls_getroute(struct sk_buff *in_skb, struct nlmsghdr *in_nlh,
 			goto errout_free;
 		}
 
-		return rtnl_unicast(skb, net, portid);
+		err = rtnl_unicast(skb, net, portid);
+		goto errout;
 	}
 
 	if (tb[RTA_NEWDST]) {
@@ -2542,12 +2551,14 @@ static int mpls_getroute(struct sk_buff *in_skb, struct nlmsghdr *in_nlh,
 
 	err = rtnl_unicast(skb, net, portid);
 errout:
+	mutex_unlock(&net->mpls.platform_mutex);
 	return err;
 
 nla_put_failure:
 	nlmsg_cancel(skb, nlh);
 	err = -EMSGSIZE;
 errout_free:
+	mutex_unlock(&net->mpls.platform_mutex);
 	kfree_skb(skb);
 	return err;
 }
@@ -2603,9 +2614,10 @@ static int resize_platform_label_table(struct net *net, size_t limit)
 		       lo->addr_len);
 	}
 
-	rtnl_lock();
+	mutex_lock(&net->mpls.platform_mutex);
+
 	/* Remember the original table */
-	old = rtnl_dereference(net->mpls.platform_label);
+	old = mpls_dereference(net, net->mpls.platform_label);
 	old_limit = net->mpls.platform_labels;
 
 	/* Free any labels beyond the new table */
@@ -2636,7 +2648,7 @@ static int resize_platform_label_table(struct net *net, size_t limit)
 	net->mpls.platform_labels = limit;
 	rcu_assign_pointer(net->mpls.platform_label, labels);
 
-	rtnl_unlock();
+	mutex_unlock(&net->mpls.platform_mutex);
 
 	mpls_rt_free(rt2);
 	mpls_rt_free(rt0);
@@ -2709,12 +2721,13 @@ static const struct ctl_table mpls_table[] = {
 	},
 };
 
-static int mpls_net_init(struct net *net)
+static __net_init int mpls_net_init(struct net *net)
 {
 	size_t table_size = ARRAY_SIZE(mpls_table);
 	struct ctl_table *table;
 	int i;
 
+	mutex_init(&net->mpls.platform_mutex);
 	net->mpls.platform_labels = 0;
 	net->mpls.platform_label = NULL;
 	net->mpls.ip_ttl_propagate = 1;
@@ -2740,7 +2753,7 @@ static int mpls_net_init(struct net *net)
 	return 0;
 }
 
-static void mpls_net_exit(struct net *net)
+static __net_exit void mpls_net_exit(struct net *net)
 {
 	struct mpls_route __rcu **platform_label;
 	size_t platform_labels;
@@ -2760,16 +2773,20 @@ static void mpls_net_exit(struct net *net)
 	 * As such no additional rcu synchronization is necessary when
 	 * freeing the platform_label table.
 	 */
-	rtnl_lock();
-	platform_label = rtnl_dereference(net->mpls.platform_label);
+	mutex_lock(&net->mpls.platform_mutex);
+
+	platform_label = mpls_dereference(net, net->mpls.platform_label);
 	platform_labels = net->mpls.platform_labels;
+
 	for (index = 0; index < platform_labels; index++) {
-		struct mpls_route *rt = rtnl_dereference(platform_label[index]);
-		RCU_INIT_POINTER(platform_label[index], NULL);
+		struct mpls_route *rt;
+
+		rt = mpls_dereference(net, platform_label[index]);
 		mpls_notify_route(net, index, rt, NULL, NULL);
 		mpls_rt_free(rt);
 	}
-	rtnl_unlock();
+
+	mutex_unlock(&net->mpls.platform_mutex);
 
 	kvfree(platform_label);
 }
diff --git a/net/mpls/internal.h b/net/mpls/internal.h
index 0df01a5395ee..80cb5bbcd946 100644
--- a/net/mpls/internal.h
+++ b/net/mpls/internal.h
@@ -185,6 +185,11 @@ static inline struct mpls_entry_decoded mpls_entry_decode(struct mpls_shim_hdr *
 	return result;
 }
 
+#define mpls_dereference(net, p)					\
+	rcu_dereference_protected(					\
+		(p),							\
+		lockdep_is_held(&(net)->mpls.platform_mutex))
+
 static inline struct mpls_dev *mpls_dev_rcu(const struct net_device *dev)
 {
 	return rcu_dereference(dev->mpls_ptr);
@@ -193,7 +198,7 @@ static inline struct mpls_dev *mpls_dev_rcu(const struct net_device *dev)
 static inline struct mpls_dev *mpls_dev_get(const struct net *net,
 					    const struct net_device *dev)
 {
-	return rcu_dereference_rtnl(dev->mpls_ptr);
+	return mpls_dereference(net, dev->mpls_ptr);
 }
 
 int nla_put_labels(struct sk_buff *skb, int attrtype,  u8 labels,
-- 
2.51.1.838.g19442a804e-goog



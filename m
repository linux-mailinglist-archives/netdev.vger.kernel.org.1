Return-Path: <netdev+bounces-117323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA26094D950
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 01:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70733281CF1
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 23:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FA816D4F5;
	Fri,  9 Aug 2024 23:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SdKACvfA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C1F16B381
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 23:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723247717; cv=none; b=QbHTCYQlw5JYmd+vA5yq59b9j+UfbxP+qMYPk4OcAnQ3cWqHgQE5P5OLKrXMRxPi5Q3ZUhiRJnaJKwFs4qqnylU5SWMCZeKAqsi5A6Cv2WGpXh3TX4wTtU8ra4Q5QqPFw6DBOCV6JxNUOueB5AC0NKJlsdLtF1a1J+a6CMGYZFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723247717; c=relaxed/simple;
	bh=4WxrjEtS5M17FaHlUOffKS61iuFISQOS8tHgSS+WuUs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JFXaAa/oZJkpgkqZKjQpb+ev57K0xAdev95O3edk0J+eus7at0rkO3EmmPT5ijAIBmOhFHUYFRYMmnJwGsXpHv12WUobPqy8q3ry/H0l/SzqK7GVBTaSA5IamsVLPKoy6GsIGQFv11hTAiP5PcXAdkLymD7U4wWf0lDbaK4qjbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=SdKACvfA; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723247716; x=1754783716;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=muRA0cpvmACoWH5h3uvtNqAyeuOU0fj72tm7FCfhBKg=;
  b=SdKACvfAZGzsLPR6k+rghH3FT/d2t22Yl3MnkEx0OGBRn+RXAVyMr2jq
   l7g15oCxAaTd+PWzNMzYBV71LA3z9JHZp1/TO20C7W0NTo/2seHJWQgQf
   6Hd0k4GemIJtUY4D+6qA7cqPn7cvCZZ6Rrkfovk/qMsY5R97DJMrK+GgB
   0=;
X-IronPort-AV: E=Sophos;i="6.09,277,1716249600"; 
   d="scan'208";a="442677894"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 23:55:09 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:62969]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.236:2525] with esmtp (Farcaster)
 id 46ed676f-7e83-46e1-aff3-e5ee6562b433; Fri, 9 Aug 2024 23:55:09 +0000 (UTC)
X-Farcaster-Flow-ID: 46ed676f-7e83-46e1-aff3-e5ee6562b433
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 9 Aug 2024 23:55:08 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.20) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 9 Aug 2024 23:55:06 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 2/5] ipv4: Set ifa->ifa_dev in inet_alloc_ifa().
Date: Fri, 9 Aug 2024 16:54:03 -0700
Message-ID: <20240809235406.50187-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240809235406.50187-1-kuniyu@amazon.com>
References: <20240809235406.50187-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA004.ant.amazon.com (10.13.139.56) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

When a new IPv4 address is assigned via ioctl(SIOCSIFADDR),
inet_set_ifa() sets ifa->ifa_dev if it's different from in_dev
passed as an argument.

In this case, ifa is always a newly allocated object, and
ifa->ifa_dev is NULL.

inet_set_ifa() can be called for an existing reused ifa, then,
this check is always false.

Let's set ifa_dev in inet_alloc_ifa() and remove the check
in inet_set_ifa().

Now, inet_alloc_ifa() is symmetric with inet_rcu_free_ifa().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/devinet.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index ddab15116454..9f4add07e67d 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -216,9 +216,18 @@ static void devinet_sysctl_unregister(struct in_device *idev)
 
 /* Locks all the inet devices. */
 
-static struct in_ifaddr *inet_alloc_ifa(void)
+static struct in_ifaddr *inet_alloc_ifa(struct in_device *in_dev)
 {
-	return kzalloc(sizeof(struct in_ifaddr), GFP_KERNEL_ACCOUNT);
+	struct in_ifaddr *ifa;
+
+	ifa = kzalloc(sizeof(*ifa), GFP_KERNEL_ACCOUNT);
+	if (!ifa)
+		return NULL;
+
+	in_dev_hold(in_dev);
+	ifa->ifa_dev = in_dev;
+
+	return ifa;
 }
 
 static void inet_rcu_free_ifa(struct rcu_head *head)
@@ -576,11 +585,7 @@ static int inet_set_ifa(struct net_device *dev, struct in_ifaddr *ifa)
 
 	ipv4_devconf_setall(in_dev);
 	neigh_parms_data_state_setall(in_dev->arp_parms);
-	if (ifa->ifa_dev != in_dev) {
-		WARN_ON(ifa->ifa_dev);
-		in_dev_hold(in_dev);
-		ifa->ifa_dev = in_dev;
-	}
+
 	if (ipv4_is_loopback(ifa->ifa_local))
 		ifa->ifa_scope = RT_SCOPE_HOST;
 	return inet_insert_ifa(ifa);
@@ -871,7 +876,7 @@ static struct in_ifaddr *rtm_to_ifaddr(struct net *net, struct nlmsghdr *nlh,
 	if (!in_dev)
 		goto errout;
 
-	ifa = inet_alloc_ifa();
+	ifa = inet_alloc_ifa(in_dev);
 	if (!ifa)
 		/*
 		 * A potential indev allocation can be left alive, it stays
@@ -881,7 +886,6 @@ static struct in_ifaddr *rtm_to_ifaddr(struct net *net, struct nlmsghdr *nlh,
 
 	ipv4_devconf_setall(in_dev);
 	neigh_parms_data_state_setall(in_dev->arp_parms);
-	in_dev_hold(in_dev);
 
 	if (!tb[IFA_ADDRESS])
 		tb[IFA_ADDRESS] = tb[IFA_LOCAL];
@@ -892,8 +896,6 @@ static struct in_ifaddr *rtm_to_ifaddr(struct net *net, struct nlmsghdr *nlh,
 	ifa->ifa_flags = tb[IFA_FLAGS] ? nla_get_u32(tb[IFA_FLAGS]) :
 					 ifm->ifa_flags;
 	ifa->ifa_scope = ifm->ifa_scope;
-	ifa->ifa_dev = in_dev;
-
 	ifa->ifa_local = nla_get_in_addr(tb[IFA_LOCAL]);
 	ifa->ifa_address = nla_get_in_addr(tb[IFA_ADDRESS]);
 
@@ -1182,7 +1184,7 @@ int devinet_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr)
 			ret = -ENOBUFS;
 			if (!in_dev)
 				break;
-			ifa = inet_alloc_ifa();
+			ifa = inet_alloc_ifa(in_dev);
 			if (!ifa)
 				break;
 			INIT_HLIST_NODE(&ifa->hash);
@@ -1584,7 +1586,7 @@ static int inetdev_event(struct notifier_block *this, unsigned long event,
 		if (!inetdev_valid_mtu(dev->mtu))
 			break;
 		if (dev->flags & IFF_LOOPBACK) {
-			struct in_ifaddr *ifa = inet_alloc_ifa();
+			struct in_ifaddr *ifa = inet_alloc_ifa(in_dev);
 
 			if (ifa) {
 				INIT_HLIST_NODE(&ifa->hash);
@@ -1592,8 +1594,6 @@ static int inetdev_event(struct notifier_block *this, unsigned long event,
 				  ifa->ifa_address = htonl(INADDR_LOOPBACK);
 				ifa->ifa_prefixlen = 8;
 				ifa->ifa_mask = inet_make_mask(8);
-				in_dev_hold(in_dev);
-				ifa->ifa_dev = in_dev;
 				ifa->ifa_scope = RT_SCOPE_HOST;
 				memcpy(ifa->ifa_label, dev->name, IFNAMSIZ);
 				set_ifa_lifetime(ifa, INFINITY_LIFE_TIME,
-- 
2.30.2



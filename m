Return-Path: <netdev+bounces-136788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B319A3205
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 03:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B22E1C21503
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 01:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9745A757F3;
	Fri, 18 Oct 2024 01:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lOVV4co1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E018A5478E
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 01:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729214656; cv=none; b=mgoTtaIzSJ7sFXXf2p/bD7rYbKEXUl0cJbAMxTMXqE+zTtEG0eAknnvl/w938KDsG7cUjkFdIEaeR6hyh4AA8QREs3Nt/cvlBOAWNXM7qsy4CjeesPt7B8USJtmOZvWeS9WZbWlVmMXoAlHv9LGFXaVm+5KgFaUmuuASFkvL1LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729214656; c=relaxed/simple;
	bh=Ka9dllwOH6q6C8edv590jcwubEcvEZo7QGvcxX5DWCg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fSAEiJBDI0AR3/+9pdfCSj7V8InkCXbCSXHRLtHhzsMuJ/yeLqJ60B6UBI2ZdmcX0IwEh0uUiSyyJ+kEwRWraCxYkrTBh+O6EudYDBX10PpujRsxaTQmQp33SbSMkvMxHPOLCSadsYR9KMz9XHtcBZmWo4bqS9f/B7vUbEsImqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=lOVV4co1; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729214655; x=1760750655;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NdCOBhIWq5wbuCmHXKx/C4Mcmqpqs6U3opoALnQMy/Y=;
  b=lOVV4co1Aqp0yD9J3FckXgTUf5L/Cm5H0RfykC+Os24P5n1KQ3fwpR/N
   rwthFJRJE2FxnFov7l43RS6mqXoV3u19P6eMFSliwmz/6cYKOX5JDIjsp
   M3cf9Lsah+k7mn+FMZ4HdZQLfJIqXQcfG194aeMAqoyoKJizHMVdVXIM+
   w=;
X-IronPort-AV: E=Sophos;i="6.11,212,1725321600"; 
   d="scan'208";a="667117524"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 01:24:12 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:54874]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.107:2525] with esmtp (Farcaster)
 id c34830ae-03ec-477b-93a3-749cea178784; Fri, 18 Oct 2024 01:24:11 +0000 (UTC)
X-Farcaster-Flow-ID: c34830ae-03ec-477b-93a3-749cea178784
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 18 Oct 2024 01:24:10 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.171.30) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 18 Oct 2024 01:24:08 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 05/11] ipv4: Use per-netns RTNL helpers in inet_rtm_newaddr().
Date: Thu, 17 Oct 2024 18:22:19 -0700
Message-ID: <20241018012225.90409-6-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241018012225.90409-1-kuniyu@amazon.com>
References: <20241018012225.90409-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

inet_rtm_to_ifa() and find_matching_ifa() are called
under rtnl_net_lock().

__in_dev_get_rtnl() and in_dev_for_each_ifa_rtnl() there
can use per-netns RTNL helpers.

Let's define and use __in_dev_get_rtnl_net() and
in_dev_for_each_ifa_rtnl_net().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/linux/inetdevice.h | 9 +++++++++
 net/ipv4/devinet.c         | 8 ++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/linux/inetdevice.h b/include/linux/inetdevice.h
index d9c690c8c80b..5730ba6b1cfa 100644
--- a/include/linux/inetdevice.h
+++ b/include/linux/inetdevice.h
@@ -226,6 +226,10 @@ static __inline__ bool bad_mask(__be32 mask, __be32 addr)
 	for (ifa = rtnl_dereference((in_dev)->ifa_list); ifa;	\
 	     ifa = rtnl_dereference(ifa->ifa_next))
 
+#define in_dev_for_each_ifa_rtnl_net(net, ifa, in_dev)			\
+	for (ifa = rtnl_net_dereference(net, (in_dev)->ifa_list); ifa;	\
+	     ifa = rtnl_net_dereference(net, ifa->ifa_next))
+
 #define in_dev_for_each_ifa_rcu(ifa, in_dev)			\
 	for (ifa = rcu_dereference((in_dev)->ifa_list); ifa;	\
 	     ifa = rcu_dereference(ifa->ifa_next))
@@ -252,6 +256,11 @@ static inline struct in_device *__in_dev_get_rtnl(const struct net_device *dev)
 	return rtnl_dereference(dev->ip_ptr);
 }
 
+static inline struct in_device *__in_dev_get_rtnl_net(const struct net_device *dev)
+{
+	return rtnl_net_dereference(dev_net(dev), dev->ip_ptr);
+}
+
 /* called with rcu_read_lock or rtnl held */
 static inline bool ip_ignore_linkdown(const struct net_device *dev)
 {
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 6abafdd20b3c..4f94fc8f552d 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -886,7 +886,7 @@ static struct in_ifaddr *inet_rtm_to_ifa(struct net *net, struct nlmsghdr *nlh,
 		goto errout;
 	}
 
-	in_dev = __in_dev_get_rtnl(dev);
+	in_dev = __in_dev_get_rtnl_net(dev);
 	err = -ENOBUFS;
 	if (!in_dev)
 		goto errout;
@@ -933,12 +933,12 @@ static struct in_ifaddr *inet_rtm_to_ifa(struct net *net, struct nlmsghdr *nlh,
 	return ERR_PTR(err);
 }
 
-static struct in_ifaddr *find_matching_ifa(struct in_ifaddr *ifa)
+static struct in_ifaddr *find_matching_ifa(struct net *net, struct in_ifaddr *ifa)
 {
 	struct in_device *in_dev = ifa->ifa_dev;
 	struct in_ifaddr *ifa1;
 
-	in_dev_for_each_ifa_rtnl(ifa1, in_dev) {
+	in_dev_for_each_ifa_rtnl_net(net, ifa1, in_dev) {
 		if (ifa1->ifa_mask == ifa->ifa_mask &&
 		    inet_ifa_match(ifa1->ifa_address, ifa) &&
 		    ifa1->ifa_local == ifa->ifa_local)
@@ -974,7 +974,7 @@ static int inet_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto unlock;
 	}
 
-	ifa_existing = find_matching_ifa(ifa);
+	ifa_existing = find_matching_ifa(net, ifa);
 	if (!ifa_existing) {
 		/* It would be best to check for !NLM_F_CREATE here but
 		 * userspace already relies on not having to provide this.
-- 
2.39.5 (Apple Git-154)



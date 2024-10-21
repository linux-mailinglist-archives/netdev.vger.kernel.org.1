Return-Path: <netdev+bounces-137616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EEF9A727B
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 20:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D85E1F25703
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 18:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913F81F9AB1;
	Mon, 21 Oct 2024 18:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="icn8dXpV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A1C1EF941
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 18:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729535798; cv=none; b=I3a82EiiuaMHsKAZsSSCP3LtF8AzWuaKjkBPGXjktqsByloFkgCWaf0YHM5rQ7TpiDaI0zHSt3cWxzzoEhf6ICAG9D2BXihcSE3/KipZDWWZb+FybcKrnPtFpow2EII84f41DG61/qPZYA/SVF6gB66RmMeMdO37DVovM9OANIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729535798; c=relaxed/simple;
	bh=rwQxBSkn5YYkBbTiQQA3cSqGJIpMyBkzXbZoQ8rcG4Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KAAwC99EiH+RO0hC+3Nsgt86UDCMmaNLPJRBqfPj2AWqgASaHzmTQ6pBf8EZryezOfVN/aHYXn34WvL4bx+Me7KrUzmRiNrtt3TBR0ZpVWyAr6/KAduAz6AjLqomr3sFNtE/ABZEExo088kD5rej6D4mSbwUv7io7LKaTREbCW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=icn8dXpV; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729535797; x=1761071797;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pi+scJ5vrTpoXQZuPQ8uhQyq7tlmBlA5tVsclFV4/XU=;
  b=icn8dXpVjUnPOaure4CMbAFmssq3sjZaZcMZxk8pJlKtJ2/yKxWXCDFI
   jHRZoU8WpqJuKNzTyH92bcPBiKWB64Y69lDocBM4kfxakb2BVZkq6qebj
   JmZ1hcV58emueOQ0wFyeMuj1jQ+D1QHF8iEXSOiWmbYlQJp8ZqD28m6yI
   Y=;
X-IronPort-AV: E=Sophos;i="6.11,221,1725321600"; 
   d="scan'208";a="668014920"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 18:36:35 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:52886]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.29:2525] with esmtp (Farcaster)
 id d553af51-2baf-4e02-9ac7-a44624758470; Mon, 21 Oct 2024 18:36:34 +0000 (UTC)
X-Farcaster-Flow-ID: d553af51-2baf-4e02-9ac7-a44624758470
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 21 Oct 2024 18:36:33 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.222.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 21 Oct 2024 18:36:31 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 12/12] ipv4: Convert devinet_ioctl to per-netns RTNL.
Date: Mon, 21 Oct 2024 11:32:39 -0700
Message-ID: <20241021183239.79741-13-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241021183239.79741-1-kuniyu@amazon.com>
References: <20241021183239.79741-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA001.ant.amazon.com (10.13.139.22) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

ioctl(SIOCGIFCONF) calls dev_ifconf() that operates on the current netns.

Let's use per-netns RTNL helpers in dev_ifconf() and inet_gifconf().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev_ioctl.c | 6 +++---
 net/ipv4/devinet.c   | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 473c437b6b53..46d43b950471 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -64,7 +64,7 @@ int dev_ifconf(struct net *net, struct ifconf __user *uifc)
 	}
 
 	/* Loop over the interfaces, and write an info block for each. */
-	rtnl_lock();
+	rtnl_net_lock(net);
 	for_each_netdev(net, dev) {
 		if (!pos)
 			done = inet_gifconf(dev, NULL, 0, size);
@@ -72,12 +72,12 @@ int dev_ifconf(struct net *net, struct ifconf __user *uifc)
 			done = inet_gifconf(dev, pos + total,
 					    len - total, size);
 		if (done < 0) {
-			rtnl_unlock();
+			rtnl_net_unlock(net);
 			return -EFAULT;
 		}
 		total += done;
 	}
-	rtnl_unlock();
+	rtnl_net_unlock(net);
 
 	return put_user(total, &uifc->ifc_len);
 }
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index fb6320f144c5..75549ce631ee 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -1314,7 +1314,7 @@ int devinet_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr)
 
 int inet_gifconf(struct net_device *dev, char __user *buf, int len, int size)
 {
-	struct in_device *in_dev = __in_dev_get_rtnl(dev);
+	struct in_device *in_dev = __in_dev_get_rtnl_net(dev);
 	const struct in_ifaddr *ifa;
 	struct ifreq ifr;
 	int done = 0;
@@ -1325,7 +1325,7 @@ int inet_gifconf(struct net_device *dev, char __user *buf, int len, int size)
 	if (!in_dev)
 		goto out;
 
-	in_dev_for_each_ifa_rtnl(ifa, in_dev) {
+	in_dev_for_each_ifa_rtnl_net(dev_net(dev), ifa, in_dev) {
 		if (!buf) {
 			done += size;
 			continue;
-- 
2.39.5 (Apple Git-154)



Return-Path: <netdev+bounces-136794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 258E49A320E
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 03:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFBF31F23DA1
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 01:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6067D56742;
	Fri, 18 Oct 2024 01:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ctk4octt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF0C3A1CD
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 01:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729214769; cv=none; b=CkvEBzprp9SKKuW0SB4G6wIMUtEw9Jltx1/C4qSuHzO06J7uvgloQ+dAmsw8l0lOdpg0zEv5vlwIYan6axb+d4rixtXwknvwc2X0igxIA977Vf3Ud0xwkv7FD5bmNXq/eUCF1zZwRrYjbzyUlTUWDFjkhYv6DyA6SllcYJs7GZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729214769; c=relaxed/simple;
	bh=HMJTkltv2UwLf0V9YV8sMNSWOJgBQlatcilxiBYcPis=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l87DVzlERmrTqhnDfl7Fj3w38kVSe9OkXNUk2wkiPFgPL73luzQhtg4CrKYF5fhhhdk0Exo+yDs4Xg9r83o44lYkdcNv6WJC9ZH7GaVZGmk6nJ5yFqQ7UqAXtvmegGcB8g/rTQouec35XELduBA79eKO2zwOu4LbjwdO+wy7U2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ctk4octt; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729214768; x=1760750768;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TJL29utz64qzJ9xtZk76SMLkqq2Z5VJtGd2PG9x+OZU=;
  b=ctk4octt/dZ/xVUWSaiFCjP9P2MjmNLNltKe/wYU1AQxB/oQzx5TyC2A
   TRj+eSzJzL1SQ5chO9n/uI7HE6dCxub07jTOxgwLgDrlmkxnylA0mXz1V
   XgjBExx3e1dNTN1EsjB4ZR6Ajl6OcKE1UParGfzcMHHZ98zywAdXxK0Fi
   w=;
X-IronPort-AV: E=Sophos;i="6.11,212,1725321600"; 
   d="scan'208";a="344036693"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 01:26:06 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:7633]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.250:2525] with esmtp (Farcaster)
 id 10ca9530-6db6-4750-95c9-be53796b6679; Fri, 18 Oct 2024 01:26:05 +0000 (UTC)
X-Farcaster-Flow-ID: 10ca9530-6db6-4750-95c9-be53796b6679
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 18 Oct 2024 01:26:05 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.171.30) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 18 Oct 2024 01:26:03 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 11/11] ipv4: Convert devinet_ioctl to per-netns RTNL.
Date: Thu, 17 Oct 2024 18:22:25 -0700
Message-ID: <20241018012225.90409-12-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D041UWB002.ant.amazon.com (10.13.139.179) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

ioctl(SIOCGIFCONF) calls dev_ifconf() that operates on the current netns.

Let's use per-netns RTNL helpers in dev_ifconf() and inet_gifconf().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
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
index f4790859ea69..6089d9255d31 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -1299,7 +1299,7 @@ int devinet_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr)
 
 int inet_gifconf(struct net_device *dev, char __user *buf, int len, int size)
 {
-	struct in_device *in_dev = __in_dev_get_rtnl(dev);
+	struct in_device *in_dev = __in_dev_get_rtnl_net(dev);
 	const struct in_ifaddr *ifa;
 	struct ifreq ifr;
 	int done = 0;
@@ -1310,7 +1310,7 @@ int inet_gifconf(struct net_device *dev, char __user *buf, int len, int size)
 	if (!in_dev)
 		goto out;
 
-	in_dev_for_each_ifa_rtnl(ifa, in_dev) {
+	in_dev_for_each_ifa_rtnl_net(dev_net(dev), ifa, in_dev) {
 		if (!buf) {
 			done += size;
 			continue;
-- 
2.39.5 (Apple Git-154)



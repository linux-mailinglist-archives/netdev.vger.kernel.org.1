Return-Path: <netdev+bounces-92295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D50468B67BF
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 03:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90FD82824C6
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 01:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F736AD7;
	Tue, 30 Apr 2024 01:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mqJuS7Xz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BDC8BE0
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 01:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714442357; cv=none; b=Hb8vMgwLuqRuBU7qj+zWqLCKjvxjI+GBu0zd/TkQkB99o4jXtp9VnClHLmwk/4nfLuANpKnu41jvkmEMb/0nOQ4UJWQJilM6QJSFah6IPI9OPmKRvsbzINuvJ12Q2E9/2RfH3sKhGdVAXalB/e6GRMsv/ZWDVPQJ2BTK09HnM+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714442357; c=relaxed/simple;
	bh=8nLfXofPYxLC/qRA6lX/xKdJmDzQNvmSO6A50KVMCgo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HvJYbK/X4xNf0HvqC5TKJjeE2I6+lW8FQ7gGjsOXkUKJGqWJZoqW9IoD2Z3y2gu5PsQHcEPKzLy3gvLVW7ZJDwsfI6lX/R6hmANacxxZ+JbWqz+Nkmh0sGL+0d/YebzTxTayhvgGzPYA0FwzlL8qoFPEVqrJyWgAHDmbQ1Srvps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=mqJuS7Xz; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714442356; x=1745978356;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XNxwJUTQlpDDvyH0259WoW+9/hOr/wutWBc0IDS76W0=;
  b=mqJuS7XzqHR/GyYvImELLTxjp+poPMDDK+WriWdZsOepaVI5KvBRzvoK
   nsK3FlNTbgq/pTwxHfAqopfmLDl1NcIS5m++kN1IUwSOzGJvtplVKgYiS
   /Lh3XHd9RMkqTp+0GVZzlDvD3kupGKIFwmRuQb/N7LxU/DUW1Ooo0WuE2
   Y=;
X-IronPort-AV: E=Sophos;i="6.07,241,1708387200"; 
   d="scan'208";a="415573328"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 01:59:16 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:40769]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.127:2525] with esmtp (Farcaster)
 id 049a46b8-7eaa-4d37-b5c6-c23de6d54804; Tue, 30 Apr 2024 01:59:15 +0000 (UTC)
X-Farcaster-Flow-ID: 049a46b8-7eaa-4d37-b5c6-c23de6d54804
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 30 Apr 2024 01:59:15 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 30 Apr 2024 01:59:12 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 2/7] arp: Validate netmask earlier for SIOCDARP and SIOCSARP in arp_ioctl().
Date: Mon, 29 Apr 2024 18:58:08 -0700
Message-ID: <20240430015813.71143-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240430015813.71143-1-kuniyu@amazon.com>
References: <20240430015813.71143-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA004.ant.amazon.com (10.13.139.7) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

When ioctl(SIOCDARP/SIOCSARP) is issued with ATF_PUBL, r.arp_netmask
must be 0.0.0.0 or 255.255.255.255.

Currently, the netmask is validated in arp_req_delete_public() or
arp_req_set_public() under rtnl_lock().

We have ATF_NETMASK test in arp_ioctl() before holding rtnl_lock(),
so let's move the netmask validation there.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/arp.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 3093374165fa..b20a5771d069 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1023,11 +1023,8 @@ static int arp_req_set_proxy(struct net *net, struct net_device *dev, int on)
 static int arp_req_set_public(struct net *net, struct arpreq *r,
 		struct net_device *dev)
 {
-	__be32 ip = ((struct sockaddr_in *)&r->arp_pa)->sin_addr.s_addr;
 	__be32 mask = ((struct sockaddr_in *)&r->arp_netmask)->sin_addr.s_addr;
 
-	if (mask && mask != htonl(0xFFFFFFFF))
-		return -EINVAL;
 	if (!dev && (r->arp_flags & ATF_COM)) {
 		dev = dev_getbyhwaddr_rcu(net, r->arp_ha.sa_family,
 				      r->arp_ha.sa_data);
@@ -1035,6 +1032,8 @@ static int arp_req_set_public(struct net *net, struct arpreq *r,
 			return -ENODEV;
 	}
 	if (mask) {
+		__be32 ip = ((struct sockaddr_in *)&r->arp_pa)->sin_addr.s_addr;
+
 		if (!pneigh_lookup(&arp_tbl, net, &ip, dev, 1))
 			return -ENOBUFS;
 		return 0;
@@ -1171,14 +1170,13 @@ int arp_invalidate(struct net_device *dev, __be32 ip, bool force)
 static int arp_req_delete_public(struct net *net, struct arpreq *r,
 		struct net_device *dev)
 {
-	__be32 ip = ((struct sockaddr_in *) &r->arp_pa)->sin_addr.s_addr;
 	__be32 mask = ((struct sockaddr_in *)&r->arp_netmask)->sin_addr.s_addr;
 
-	if (mask == htonl(0xFFFFFFFF))
-		return pneigh_delete(&arp_tbl, net, &ip, dev);
+	if (mask) {
+		__be32 ip = ((struct sockaddr_in *)&r->arp_pa)->sin_addr.s_addr;
 
-	if (mask)
-		return -EINVAL;
+		return pneigh_delete(&arp_tbl, net, &ip, dev);
+	}
 
 	return arp_req_set_proxy(net, dev, 0);
 }
@@ -1211,9 +1209,10 @@ static int arp_req_delete(struct net *net, struct arpreq *r,
 
 int arp_ioctl(struct net *net, unsigned int cmd, void __user *arg)
 {
-	int err;
-	struct arpreq r;
 	struct net_device *dev = NULL;
+	struct arpreq r;
+	__be32 *netmask;
+	int err;
 
 	switch (cmd) {
 	case SIOCDARP:
@@ -1236,9 +1235,13 @@ int arp_ioctl(struct net *net, unsigned int cmd, void __user *arg)
 	if (!(r.arp_flags & ATF_PUBL) &&
 	    (r.arp_flags & (ATF_NETMASK | ATF_DONTPUB)))
 		return -EINVAL;
+
+	netmask = &((struct sockaddr_in *)&r.arp_netmask)->sin_addr.s_addr;
 	if (!(r.arp_flags & ATF_NETMASK))
-		((struct sockaddr_in *)&r.arp_netmask)->sin_addr.s_addr =
-							   htonl(0xFFFFFFFFUL);
+		*netmask = htonl(0xFFFFFFFFUL);
+	else if (*netmask && *netmask != htonl(0xFFFFFFFFUL))
+		return -EINVAL;
+
 	rtnl_lock();
 	if (r.arp_dev[0]) {
 		err = -ENODEV;
-- 
2.30.2



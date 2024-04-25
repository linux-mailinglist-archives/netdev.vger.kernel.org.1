Return-Path: <netdev+bounces-91397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C49718B2711
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 19:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7958B1F22AEA
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 17:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF6F14D44E;
	Thu, 25 Apr 2024 17:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UmHi3XTF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217C33A1CC
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 17:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714064477; cv=none; b=JQLQLvxYkbTCny1g+vwsS5bCvEBee+L+iCQPNiM4oE+riRMyCPh1H9gnQaNvxIQICj2NjKluYj6EBEHMducukgckTDmResAhf3Klbr62tMcjTr/Njxldjf7xaopAihcHTRWaZHazg+yKxZATBDNMLn6gXBBIxzQJc+IXkSmOkFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714064477; c=relaxed/simple;
	bh=8nLfXofPYxLC/qRA6lX/xKdJmDzQNvmSO6A50KVMCgo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=klMpbx4djKFfH38TfBnsMqG8R4AQRsvXoK6vwS20gLPxFxKOlgCdgnpVpRbLvjRVx2yiwSFXEQ7e3prp2XdzNySiyIS8ecSJ+HYLpqBojqLpV54sLF0rQu4Ps0dXDfq6syo1PjXxwEAJYsTgDgcBQGNGmB+x14YA3gw8jXmKeHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=UmHi3XTF; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714064476; x=1745600476;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XNxwJUTQlpDDvyH0259WoW+9/hOr/wutWBc0IDS76W0=;
  b=UmHi3XTFhBJAh/lYe2IoxW8yAsXogOWHomtlqtnhW6kmjD4ZJa1CPcWQ
   g013eMQ37C1u37cg9+fFvAXgKASlPi1WStFl1zZqrmqPVV76KENGVhrHD
   0ntQTCQqPNH5ioPtdnb/WOTtmw2TjfwOy/QUog2gtu25Uw3vWmxa6YbRs
   I=;
X-IronPort-AV: E=Sophos;i="6.07,230,1708387200"; 
   d="scan'208";a="341068591"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 17:01:09 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:15821]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.180:2525] with esmtp (Farcaster)
 id 6c851476-306f-45fc-aeb4-4cdfaea9cf91; Thu, 25 Apr 2024 17:01:08 +0000 (UTC)
X-Farcaster-Flow-ID: 6c851476-306f-45fc-aeb4-4cdfaea9cf91
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 25 Apr 2024 17:01:08 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 25 Apr 2024 17:01:05 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 2/6] arp: Validate netmask earlier for SIOCDARP and SIOCSARP in arp_ioctl().
Date: Thu, 25 Apr 2024 09:59:58 -0700
Message-ID: <20240425170002.68160-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240425170002.68160-1-kuniyu@amazon.com>
References: <20240425170002.68160-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC002.ant.amazon.com (10.13.139.238) To
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



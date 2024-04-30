Return-Path: <netdev+bounces-92300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D19328B67C6
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 04:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4859D1F23237
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 02:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1649679EF;
	Tue, 30 Apr 2024 02:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hUZDaedX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526068F5C
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 02:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714442460; cv=none; b=Zcqw3FbWQ/SwXZoW8i80QTwBS2XYN3gG77dy6IvGu8yQThda2BNVzofJRJVX8nnPJ4aCJ8n717wgKGIwRph+3ATITwFEsVGbck+rZYxkxrxvRpFg6fwiXw31nw2MLDshczDup95TQxHhHpSunqVLIoiWSNXlGCbsVJ3oWer7g7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714442460; c=relaxed/simple;
	bh=YWFpKlJ3FX46l8hPi9h1Q04ATMF1KW1iMGCX+emQmzw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=beDJSWH5h9O6EaSrxiqZGLN+CEp9MN2DTqTLhA2CVd0vcIDwNH2bP/3zRzOJYsvqpg5u5wJOp8ZVWBPCdZZgYuKMoRle295GbPM7Vs9dZKnhmASJeEY/XK+T6QjFvN2ICTrGMhAkx9xa4dZz43yYe//TrJiZ7oVCg70064uMVqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=hUZDaedX; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714442458; x=1745978458;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zpbvsmHh9Su6EIbT7z/q6kDVT44f2D/j6HqdNf9PV0k=;
  b=hUZDaedXg7vyZZwjLKF6XNo+/jUqzEPVpKAwBIawEAlhmELNJ+ATlFsO
   qJzSGP1nbOx22I/bN9GmP6ATRCw1+FRX6blGNJMB/vSe0zZxrJLnY8Sbw
   pJJUJ9Sklwiud7INgnJQ7t5ZyNghVLpNRutAe8eNz2RfZB1eK2GNmBDFB
   8=;
X-IronPort-AV: E=Sophos;i="6.07,241,1708387200"; 
   d="scan'208";a="201976481"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 02:00:56 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:60973]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.38:2525] with esmtp (Farcaster)
 id 9c37f0be-3e14-4038-b280-0d27e6ffa33a; Tue, 30 Apr 2024 02:00:55 +0000 (UTC)
X-Farcaster-Flow-ID: 9c37f0be-3e14-4038-b280-0d27e6ffa33a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 30 Apr 2024 02:00:54 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 30 Apr 2024 02:00:52 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 6/7] net: Protect dev->name by seqlock.
Date: Mon, 29 Apr 2024 18:58:12 -0700
Message-ID: <20240430015813.71143-7-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D043UWC002.ant.amazon.com (10.13.139.222) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will convert ioctl(SIOCGARP) to RCU, and then we need to copy
dev->name which is currently protected by rtnl_lock().

This patch does the following:

  1) Add seqlock netdev_rename_lock to protect dev->name

  2) Add netdev_copy_name() that copies dev->name to buffer
     under netdev_rename_lock

  3) Use netdev_copy_name() in netdev_get_name() and drop
     devnet_rename_sem

Suggested-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/netdev/CANn89iJEWs7AYSJqGCUABeVqOCTkErponfZdT5kV-iD=-SajnQ@mail.gmail.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/linux/netdevice.h |  1 +
 net/core/dev.c            | 27 +++++++++++++++++++++++----
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index f849e7d110ed..41853424b41d 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3136,6 +3136,7 @@ struct net_device *netdev_get_by_name(struct net *net, const char *name,
 				      netdevice_tracker *tracker, gfp_t gfp);
 struct net_device *dev_get_by_index_rcu(struct net *net, int ifindex);
 struct net_device *dev_get_by_napi_id(unsigned int napi_id);
+void netdev_copy_name(struct net_device *dev, char *name);
 
 static inline int dev_hard_header(struct sk_buff *skb, struct net_device *dev,
 				  unsigned short type,
diff --git a/net/core/dev.c b/net/core/dev.c
index c9e59eff8ec8..01a9d6e451e2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -940,6 +940,18 @@ struct net_device *dev_get_by_napi_id(unsigned int napi_id)
 }
 EXPORT_SYMBOL(dev_get_by_napi_id);
 
+static DEFINE_SEQLOCK(netdev_rename_lock);
+
+void netdev_copy_name(struct net_device *dev, char *name)
+{
+	unsigned int seq;
+
+	do {
+		seq = read_seqbegin(&netdev_rename_lock);
+		strscpy(name, dev->name, IFNAMSIZ);
+	} while (read_seqretry(&netdev_rename_lock, seq));
+}
+
 /**
  *	netdev_get_name - get a netdevice name, knowing its ifindex.
  *	@net: network namespace
@@ -951,7 +963,6 @@ int netdev_get_name(struct net *net, char *name, int ifindex)
 	struct net_device *dev;
 	int ret;
 
-	down_read(&devnet_rename_sem);
 	rcu_read_lock();
 
 	dev = dev_get_by_index_rcu(net, ifindex);
@@ -960,12 +971,11 @@ int netdev_get_name(struct net *net, char *name, int ifindex)
 		goto out;
 	}
 
-	strcpy(name, dev->name);
+	netdev_copy_name(dev, name);
 
 	ret = 0;
 out:
 	rcu_read_unlock();
-	up_read(&devnet_rename_sem);
 	return ret;
 }
 
@@ -1217,7 +1227,10 @@ int dev_change_name(struct net_device *dev, const char *newname)
 
 	memcpy(oldname, dev->name, IFNAMSIZ);
 
+	write_seqlock(&netdev_rename_lock);
 	err = dev_get_valid_name(net, dev, newname);
+	write_sequnlock(&netdev_rename_lock);
+
 	if (err < 0) {
 		up_write(&devnet_rename_sem);
 		return err;
@@ -1257,7 +1270,9 @@ int dev_change_name(struct net_device *dev, const char *newname)
 		if (err >= 0) {
 			err = ret;
 			down_write(&devnet_rename_sem);
+			write_seqlock(&netdev_rename_lock);
 			memcpy(dev->name, oldname, IFNAMSIZ);
+			write_sequnlock(&netdev_rename_lock);
 			memcpy(oldname, newname, IFNAMSIZ);
 			WRITE_ONCE(dev->name_assign_type, old_assign_type);
 			old_assign_type = NET_NAME_RENAMED;
@@ -11404,8 +11419,12 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 	dev_net_set(dev, net);
 	dev->ifindex = new_ifindex;
 
-	if (new_name[0]) /* Rename the netdev to prepared name */
+	if (new_name[0]) {
+		/* Rename the netdev to prepared name */
+		write_seqlock(&netdev_rename_lock);
 		strscpy(dev->name, new_name, IFNAMSIZ);
+		write_sequnlock(&netdev_rename_lock);
+	}
 
 	/* Fixup kobjects */
 	dev_set_uevent_suppress(&dev->dev, 1);
-- 
2.30.2



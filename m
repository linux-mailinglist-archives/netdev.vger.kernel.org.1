Return-Path: <netdev+bounces-185186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6554A98ECC
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 16:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27703447681
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 14:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDF6280A5F;
	Wed, 23 Apr 2025 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mY46HS5w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A416A19DF4C
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420276; cv=none; b=OOLP825pNbVzMy814w/yCeDGL/Tzn40P1vKjMX61IrYbkx4RESX9arNrdEkwjc+KuQVz+X/5bB0sQ8lBXlbZOHiA3jQvXaErI9bAolJzTV/e95RTNjl4rGg9LHzYEwvCNmQHnJArOn+IjmuZF8IEZouPa5zfko+RQ0nAgfoas/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420276; c=relaxed/simple;
	bh=ry3OXvm8MNRk+35hfjC8SLmfLbP+2zJngT3Y9Q1kPhE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fcaJn7i3NCptX0ipHcZLUHCfjWm+xZeXew80kiN9fEqY+FHfumGGY9NEq3QzEAFp+4kGJ1urFH0QrHDk44v2UtH9ADM6IY360aQqk9U86aYeo7rRdwbQfR1pwPXH7zTIh4sefCXkVZ/r2A1vXb5Qdu13W/IcRL/pRIz2WZv+ZA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=mY46HS5w; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1745420274; x=1776956274;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CJBKbhvv7r7Qvsp/mJhqVYAJDHVE7tJ01jHxTylhxpA=;
  b=mY46HS5wZh2G1kC88EQuMRu0n45MGnTu+XNku8mAnUpB7D9SEkqCdmbl
   +fYBysqeoq1LniacHnZ9sjP9UIEkpJZWkcVz3mzQIndOeUXFdQlzF5ym4
   nhCNzDO6FH20LQ5ynB65sUEejZnU+hQKcSaqBkDpcCa+wulPOf/LEDOzo
   g=;
X-IronPort-AV: E=Sophos;i="6.15,233,1739836800"; 
   d="scan'208";a="485590208"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 14:57:50 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:21643]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.20:2525] with esmtp (Farcaster)
 id c11a44be-4fa3-46ab-9d9f-60ef549ea072; Wed, 23 Apr 2025 14:57:49 +0000 (UTC)
X-Farcaster-Flow-ID: c11a44be-4fa3-46ab-9d9f-60ef549ea072
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 23 Apr 2025 14:57:48 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 23 Apr 2025 14:57:45 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v2 net-next 2/3] pfcp: Convert pfcp_net_exit() to ->exit_rtnl().
Date: Wed, 23 Apr 2025 07:12:55 -0700
Message-ID: <20250423145736.95775-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423064026.636c822f@kernel.org>
References: <20250423064026.636c822f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC004.ant.amazon.com (10.13.139.206) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 23 Apr 2025 06:40:26 -0700
> On Thu, 17 Apr 2025 17:32:33 -0700 Kuniyuki Iwashima wrote:
> > -static void __net_exit pfcp_net_exit(struct net *net)
> > +static void __net_exit pfcp_net_exit_rtnl(struct net *net,
> > +					  struct list_head *dev_to_kill)
> >  {
> >  	struct pfcp_net *pn = net_generic(net, pfcp_net_id);
> >  	struct pfcp_dev *pfcp, *pfcp_next;
> > -	struct net_device *dev;
> > -	LIST_HEAD(list);
> > -
> > -	rtnl_lock();
> > -	for_each_netdev(net, dev)
> > -		if (dev->rtnl_link_ops == &pfcp_link_ops)
> > -			pfcp_dellink(dev, &list);
> >  
> >  	list_for_each_entry_safe(pfcp, pfcp_next, &pn->pfcp_dev_list, list)
> > -		pfcp_dellink(pfcp->dev, &list);
> > -
> > -	unregister_netdevice_many(&list);
> > -	rtnl_unlock();
> > +		pfcp_dellink(pfcp->dev, dev_to_kill);
> 
> Kuniyuki, I got distracted by the fact the driver is broken but I think
> this isn't right.

I guess it was broken recently ?  at least I didn't see null-deref
while testing ffc90e9ca61b ("pfcp: Destroy device along with udp
socket's netns dismantle.").


> The devices do not migrate to the local pcfp_dev_list
> when their netns is changed. They always stay on the list of original
> netns. Which I guess may make some sense as that's where their socket
> is? So we need to scan both the pcfp_dev_list _and_ the local netdevs
> that are pfcp. Am I misunderstanding something?

If the netns is queued up for cleanup_net(), the local netdevs
are handled later by default_device_exit_batch().

If the module is unloaded, we call pfcp_net_exit_rtnl() for
all netns including all local netdevs.

I remember bareudp did like that and I changed geneve and gtp
as well.

I applied the quivalent diff below on ffc90e9ca61b, and during
netns dismantle, 2 local netdevs were removed properly (one
was originally created there, another was moved to the netns).

---8<---
[root@localhost ~]# ip netns add ns1
[root@localhost ~]# ip netns add ns2
[root@localhost ~]# ip -n ns1 link add netns ns2 name pfcp0 type pfcp
[   74.564522] newlink: dev: pfcp0 at ff11000103ca9000
[root@localhost ~]# ip -n ns2 link add netns ns2 name pfcp1 type pfcp
[   79.510334] newlink: dev: pfcp1 at ff11000103caa000
[root@localhost ~]# ip netns del ns2
[   83.953871] dellink: dev: pfcp1 at ff11000103caa000 from cleanup_net+0x20e/0x3b0
[   83.980520] dellink: dev: pfcp0 at ff11000103ca9000 from default_device_exit_batch+0x244/0x300
---8<---

---8<---
diff --git a/drivers/net/pfcp.c b/drivers/net/pfcp.c
index 68d0d9e92a22..f7f254d7d031 100644
--- a/drivers/net/pfcp.c
+++ b/drivers/net/pfcp.c
@@ -206,6 +206,7 @@ static int pfcp_newlink(struct net *net, struct net_device *dev,
 		goto exit_del_pfcp_sock;
 	}
 
+	printk(KERN_ERR "newlink: dev: %s at %px\n", dev->name, dev);
 	pn = net_generic(net, pfcp_net_id);
 	list_add(&pfcp->list, &pn->pfcp_dev_list);
 
@@ -224,6 +225,7 @@ static void pfcp_dellink(struct net_device *dev, struct list_head *head)
 {
 	struct pfcp_dev *pfcp = netdev_priv(dev);
 
+	printk(KERN_ERR "dellink: dev: %s at %px from %pS\n", dev->name, dev, __builtin_return_address(0));
 	list_del(&pfcp->list);
 	unregister_netdevice_queue(dev, head);
 }
@@ -244,28 +246,26 @@ static int __net_init pfcp_net_init(struct net *net)
 	return 0;
 }
 
-static void __net_exit pfcp_net_exit(struct net *net)
+static void __net_exit pfcp_net_exit(struct net *net, struct list_head *list)
 {
 	struct pfcp_net *pn = net_generic(net, pfcp_net_id);
 	struct pfcp_dev *pfcp, *pfcp_next;
-	struct net_device *dev;
-	LIST_HEAD(list);
-
-	rtnl_lock();
-	for_each_netdev(net, dev)
-		if (dev->rtnl_link_ops == &pfcp_link_ops)
-			pfcp_dellink(dev, &list);
 
 	list_for_each_entry_safe(pfcp, pfcp_next, &pn->pfcp_dev_list, list)
-		pfcp_dellink(pfcp->dev, &list);
+		pfcp_dellink(pfcp->dev, list);
+}
+
+static void __net_exit pfcp_net_exit_batch_rtnl(struct list_head *net_list, struct list_head *head)
+{
+	struct net *net;
 
-	unregister_netdevice_many(&list);
-	rtnl_unlock();
+	list_for_each_entry(net, net_list, exit_list)
+		pfcp_net_exit(net, head);
 }
 
 static struct pernet_operations pfcp_net_ops = {
 	.init	= pfcp_net_init,
-	.exit	= pfcp_net_exit,
+	.exit_batch_rtnl	= pfcp_net_exit_batch_rtnl,
 	.id	= &pfcp_net_id,
 	.size	= sizeof(struct pfcp_net),
 };
---8<---


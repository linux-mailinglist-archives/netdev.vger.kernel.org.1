Return-Path: <netdev+bounces-303849-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e9x+DyCKRWrTBgsAu9opvQ
	(envelope-from <netdev+bounces-303849-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:44:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 232026F1E9A
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:44:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=VxeKqIxa;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303849-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303849-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A7AD7303192F
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 21:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0483BED7B;
	Wed,  1 Jul 2026 21:43:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6513B71B0
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 21:43:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782942233; cv=none; b=c5kQWTH+cRUi7rMAwNMdu4kxEkl1NfvfpbgPWjOgEoNcIRazuSn4Mafx11zGP6XHliXryPdGy9zO5sh/MoXn1qID7x1c4FmXImK3pJOH1S+BsyzevljfF4RWhzCGihQDer6z9XAVxlvhGxBF+EttHF4PlPbwhzSwmLpppo774Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782942233; c=relaxed/simple;
	bh=oK8xxkQnpnHq0m/s/zrNetzfWm7EIpU5z186OjqOneg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qE+vr+obUPU9+XcoycWHamcYrMEeyOG1hGP3OxmYo7DGyAapmqz713f6QoU0Fx7RvT4SsSOnxhPEWrqrg7ZSvXsmO6Ihw04v3ddbsFCV7kqFVmRhbpXUiD33Eu0UzkYhfmkLK5x4wKOhL+aD+9sxp7nh9qBDqUeymf0PSG8p4mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VxeKqIxa; arc=none smtp.client-ip=209.85.214.201
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c9a700dc0eso9838095ad.1
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 14:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782942229; x=1783547029; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qv+hwxHDJ92PQDTj0TRrJSI+bQcW2pH3TZcVqKUE80s=;
        b=VxeKqIxa0ObW5y8/1J6Tjd6tIWeGnASmTyfcDM33Ed/Z+gbV0N6ZbssutNQUfrMxK+
         dQMh9v4NaK9K9GPIZ0XhsNjbh7PrN3gTHxmWI68f5f2KYLaczUM8rZhdQUUKH/YOm9eV
         eq0FJ3Oa6g0PxcAKuKXF/ldcUxtpRmrtNQ2eVDh9nG0n/ekOr2LGbd8/aU2hheDkyGC/
         80kphUlSRIOsPyNPP8YwK+xht2XC3XSG0Q6UvDBpxTTtA2khXirRRbTCRmpYEq2kkYRF
         /E5fyP3IM8uN7r0UnvlXPJzlTxe27aYMvWgRwGjJ0vfilrIcr4VR7s2kp3cHmkxTlPK9
         KMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782942229; x=1783547029;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qv+hwxHDJ92PQDTj0TRrJSI+bQcW2pH3TZcVqKUE80s=;
        b=c7ydx5YUgq3Cxo6WER6ZgZe3pj7Mw9uwbztxX7ScTS40mjFCJ0os5Bxm1VA3rR8WVV
         Zm5ZDVxqZ77ROZtHQsxZmtQ7A0MllRsTyNB/UwMyXXJEQh4KabfdKnmu9Glm/0Nrhb3C
         Jnj2/AThfgUBk/0xCjEgytpS/HfOUuISmNwYuh7hJIk5QT+Hj7Iva8jlW67At7XY1f+9
         SbQ49UxVNoP7o//PrjrBAJBrf1Fl66bth+rZmYFUCh4R6pZUtkzGqlxVkTechwPdWAtv
         8XAHNMdB2FDeqevpP6tMqC7GsIGkE+ilemfyrxSlTH1BmqzDIon/v0sWt2aQA6MFJpTw
         dQNQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr2M1jPsxd5MqD1M9I36aMz6/duyuSeFHmB2jGnda5wNhFQi4iwLX0HSMgo+/sKgh43NXBKugs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRRzSAgY5eQhnTsxycTYaz4hJpzpWkxxEzgtdE2W++MIiUHdut
	qS1lF8c0pc4C+cYsUDVy6Mm9nVqhpKTQNCIAs5hAT95Gy737NDgYec9UF2QstiI/1IcDio3J4dq
	eoTsVkA==
X-Received: from plqu8.prod.google.com ([2002:a17:902:a608:b0:2ca:6d6d:5267])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3883:b0:2c9:97a7:b1ec
 with SMTP id d9443c01a7336-2ca7e9348f2mr37136415ad.43.1782942228683; Wed, 01
 Jul 2026 14:43:48 -0700 (PDT)
Date: Wed,  1 Jul 2026 21:41:45 +0000
In-Reply-To: <20260701214334.266991-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701214334.266991-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701214334.266991-8-kuniyu@google.com>
Subject: [PATCH v1 net-next 07/14] net: Call unregister_netdevice_many() per netns.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-303849-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 232026F1E9A

For per-netns device unregistration, the list passed to
unregister_netdevice_many() must contain devices from a single
netns only (once all callers are converted).

Let's move collected devices in the following functions to
net->dev_unreg_head and let __rtnl_net_unlock() pass them to
unregister_netdevice_many().

  * default_device_exit_batch()
  * ops_exit_rtnl_list()
  * __rtnl_kill_links()

This allows incremental conversion of each driver to support
per-netns device unregistration without affecting the normal
kernel where CONFIG_DEBUG_NET_SMALL_RTNL is disabled.

Note that this change unbatches synchronize_rcu() etc in
unregister_netdevice_many(), but we can later split it into
multiple stages to batch them again.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/linux/netdevice.h |  6 ++++++
 net/core/dev.c            | 27 +++++++++++++++++++++++++++
 net/core/net_namespace.c  |  1 +
 net/core/rtnetlink.c      |  6 +++++-
 4 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 53454db3611a..0cd26fb59806 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3479,6 +3479,7 @@ static inline void unregister_netdevice(struct net_device *dev)
 void unregister_netdevice_queue_net(struct net *net, struct net_device *dev,
 				    struct list_head *head);
 void unregister_netdevice_many_net(struct net *net);
+void unregister_netdevice_queue_many_net(struct net *net, struct list_head *head);
 #else
 static inline void unregister_netdevice_queue_net(struct net *net,
 						  struct net_device *dev,
@@ -3486,6 +3487,11 @@ static inline void unregister_netdevice_queue_net(struct net *net,
 {
 	unregister_netdevice_queue(dev, head);
 }
+
+static inline void unregister_netdevice_queue_many_net(struct net *net,
+						       struct list_head *head)
+{
+}
 #endif
 
 int netdev_refcnt_read(const struct net_device *dev);
diff --git a/net/core/dev.c b/net/core/dev.c
index 0f0bf65f5bf9..57fb4741d0ac 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12546,6 +12546,28 @@ void unregister_netdevice_queue_net(struct net *net, struct net_device *dev,
 }
 EXPORT_SYMBOL(unregister_netdevice_queue_net);
 
+void unregister_netdevice_queue_many_net(struct net *net, struct list_head *head)
+{
+	struct net_device *dev, *tmp;
+
+	spin_lock(&net->dev_unreg_lock);
+	list_for_each_entry_safe(dev, tmp, head, unreg_list) {
+		/* Once all cross-netns unregister_netdevice_queue() is
+		 * converted to _net() (or for debugging), remove this check.
+		 */
+		if (!net_eq(dev_net(dev), net))
+			continue;
+
+		DEBUG_NET_WARN_ONCE(!net_eq(dev_net(dev), net),
+				    "%s was unregistered from a different netns.\n",
+				    dev->name);
+
+		list_del_init(&dev->unreg_list);
+		list_move_tail(&dev->unreg_list_net, &net->dev_unreg_head);
+	}
+	spin_unlock(&net->dev_unreg_lock);
+}
+
 static void unregister_netdevice_move_net(struct net *net_old,
 					  struct net *net,
 					  struct net_device *dev)
@@ -13179,12 +13201,17 @@ static void __net_exit default_device_exit_batch(struct list_head *net_list)
 	__rtnl_net_unlock(&init_net);
 
 	list_for_each_entry(net, net_list, exit_list) {
+		__rtnl_net_lock(net);
+
 		for_each_netdev_reverse(net, dev) {
 			if (dev->rtnl_link_ops && dev->rtnl_link_ops->dellink)
 				dev->rtnl_link_ops->dellink(dev, &dev_kill_list);
 			else
 				unregister_netdevice_queue(dev, &dev_kill_list);
 		}
+
+		unregister_netdevice_queue_many_net(net, &dev_kill_list);
+		__rtnl_net_unlock(net);
 	}
 	unregister_netdevice_many(&dev_kill_list);
 	rtnl_unlock();
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 578b48cf5318..a91d2b58aadd 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -181,6 +181,7 @@ static void ops_exit_rtnl_list(const struct list_head *ops_list,
 				ops->exit_rtnl(net, &dev_kill_list);
 		}
 
+		unregister_netdevice_queue_many_net(net, &dev_kill_list);
 		__rtnl_net_unlock(net);
 	}
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 544498d3c325..b129f793d851 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -714,8 +714,12 @@ void rtnl_link_unregister(struct rtnl_link_ops *ops)
 	down_write(&pernet_ops_rwsem);
 	rtnl_lock_unregistering_all();
 
-	for_each_net(net)
+	for_each_net(net) {
+		__rtnl_net_lock(net);
 		__rtnl_kill_links(net, ops, &dev_kill_list);
+		unregister_netdevice_queue_many_net(net, &dev_kill_list);
+		__rtnl_net_unlock(net);
+	}
 
 	unregister_netdevice_many(&dev_kill_list);
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog



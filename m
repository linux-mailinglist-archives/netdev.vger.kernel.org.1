Return-Path: <netdev+bounces-69851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BD784CCB9
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 15:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A36E1C254E8
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 14:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851C97F7DF;
	Wed,  7 Feb 2024 14:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r5XsBkV7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D227CF24
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 14:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316018; cv=none; b=F1XjZRFGqu3X7N11w0dLNXLbU6D+cs5M6SgTmI7J2gmgIBglMKdxjRTXFCA4DlPbyTzNlZHG+d7X8m0lsN8q/pFGD4f/e1flhTHGIlHdj7ERumjZOL6rsHRNZ1g++2420aZ3/2ObYanLjUiNNh6bnRKe7W6n/7vYlrOryEBABQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316018; c=relaxed/simple;
	bh=/Uj0KGJ6nMHwCQ3DLA7HpnKs6FEVHAM5Ebw5a04dUyI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qkAicqiM3qjw8p61ZOqKTkQUB/F9wwAhD53cu7os3iPoQ6KGu+bW4rBA2cya17h6+b771OgZPgRSBR0Ql6TajGSKiXD42zVePVyneg6dqUqYXIgQKDBH6yJ+4RCeYibAQFiaAoll9QhR8Ky7nTGl+gFfmkzidyo+A5kjH2RrN9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r5XsBkV7; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ffee6fcdc1so10057387b3.2
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 06:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707316016; x=1707920816; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OeftRcez9trs9DLzR1P/DCUo3NZr+owV7onJgX1ygxY=;
        b=r5XsBkV7Dd5iVfNhlHRJ5YXcHtQUT7rXn9I4RhAMW/aeNu5pv0SHoQPgilYs0PYClk
         MQdTVccG+o2DvjTndWc/gfIX2G2JAaJpq2ltGpOZFFjwp8XfKlmWzxJu7Tj/1m/8bwLV
         lEZf73+rQ2VX0N/3sD/CkB7R8tjmED3w5ujbZ5OT3PHzbrZ4H3wMG+hMN+MeOIBNI9qG
         iB/pR6UGsQdAwujrhwUn3J/wTz1l/9E83m0Y68Df7jdtju1fQ/hCzhd11MK9dtELwTaW
         ZcsdI+zAweaXbV8kCff0hneo8rWc0jWC3kNwaZ3dKFyinyVsmycvInD/ASw5DcX72A9D
         HCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707316016; x=1707920816;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OeftRcez9trs9DLzR1P/DCUo3NZr+owV7onJgX1ygxY=;
        b=lslSPZDjnfjAb/LgXeALvm0NLenPhv7pFRA59ibccevtODlv+ZbnQgryfX3/gJVn0S
         JG9D7pWNbo6O8lJStYpTA/42OiNdt1ieGgi+P3NzwJZ03ZhP9VwDdeP+jX/ovynHAOBh
         PwbtnN6lFBBgg6r9+jW3774oEmReooY5lVflT+/Oamt6owuew9T5NW8kif2iTu25P1xq
         eBr3xP3Mf8hYzk4KrVMzyueYRvltdbs4O/hJXqZsyVWclGRPRIfLimyYh2zu8PRA3wus
         RfA9XUZH0tHgukGng/9Tyg9AgeYQVdOfJMcpgW6tJV9ujPNIH3jejwBbZ0KQiuJVOIKM
         /Kmg==
X-Gm-Message-State: AOJu0YxyKwadPCUkpa/Ph9H0rEfcnl6AjZhliKBxlgNTHTtiNoahWkrq
	DU2g7hVGlk6sD3z9TQoy1lZpMrxDTFETjN3ZgLmm5NH1qz+tH2BuehQbMJK2PplDbkenhq+jJ9b
	JRX2FB4SCzQ==
X-Google-Smtp-Source: AGHT+IFwtSkUXoIRAw6V0rWh7km+N/M7s8YnozAerzMzij8C1YGRuR9MOdbxUZe6cgmFxRtD0cjrQd0NxeGNGg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1b13:b0:dc2:5130:198f with SMTP
 id eh19-20020a0569021b1300b00dc25130198fmr191874ybb.5.1707316015834; Wed, 07
 Feb 2024 06:26:55 -0800 (PST)
Date: Wed,  7 Feb 2024 14:26:29 +0000
In-Reply-To: <20240207142629.3456570-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207142629.3456570-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240207142629.3456570-14-edumazet@google.com>
Subject: [PATCH net-next 13/13] net: remove dev_base_lock
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

dev_base_lock is not needed anymore, all remaining users also hold RTNL.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/netdevice.h |  2 --
 net/core/dev.c            | 39 ++++-----------------------------------
 2 files changed, 4 insertions(+), 37 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index b9140499630fa84108a1f22a2987c0c1934e8f8d..5aead4555f9aa342d832e238e895a1de0e791fb9 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3077,8 +3077,6 @@ int call_netdevice_notifiers(unsigned long val, struct net_device *dev);
 int call_netdevice_notifiers_info(unsigned long val,
 				  struct netdev_notifier_info *info);
 
-extern rwlock_t				dev_base_lock;		/* Device list lock */
-
 #define for_each_netdev(net, d)		\
 		list_for_each_entry(d, &(net)->dev_base_head, dev_list)
 #define for_each_netdev_reverse(net, d)	\
diff --git a/net/core/dev.c b/net/core/dev.c
index 9b6b530d94d01bcb6e8f70c6942fb39eccb52904..522b083b39b36840771644a506c5da3f5e011f30 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -166,28 +166,6 @@ static int call_netdevice_notifiers_extack(unsigned long val,
 					   struct net_device *dev,
 					   struct netlink_ext_ack *extack);
 
-/*
- * The @dev_base_head list is protected by @dev_base_lock and the rtnl
- * semaphore.
- *
- * Pure readers hold dev_base_lock for reading, or rcu_read_lock()
- *
- * Writers must hold the rtnl semaphore while they loop through the
- * dev_base_head list, and hold dev_base_lock for writing when they do the
- * actual updates.  This allows pure readers to access the list even
- * while a writer is preparing to update it.
- *
- * To put it another way, dev_base_lock is held for writing only to
- * protect against pure readers; the rtnl semaphore provides the
- * protection against other writers.
- *
- * See, for example usages, register_netdevice() and
- * unregister_netdevice(), which must be called with the rtnl
- * semaphore held.
- */
-DEFINE_RWLOCK(dev_base_lock);
-EXPORT_SYMBOL(dev_base_lock);
-
 static DEFINE_MUTEX(ifalias_mutex);
 
 /* protects napi_hash addition/deletion and napi_gen_id */
@@ -393,12 +371,10 @@ static void list_netdevice(struct net_device *dev)
 
 	ASSERT_RTNL();
 
-	write_lock(&dev_base_lock);
 	list_add_tail_rcu(&dev->dev_list, &net->dev_base_head);
 	netdev_name_node_add(net, dev->name_node);
 	hlist_add_head_rcu(&dev->index_hlist,
 			   dev_index_hash(net, dev->ifindex));
-	write_unlock(&dev_base_lock);
 
 	netdev_for_each_altname(dev, name_node)
 		netdev_name_node_add(net, name_node);
@@ -425,11 +401,9 @@ static void unlist_netdevice(struct net_device *dev)
 		netdev_name_node_del(name_node);
 
 	/* Unlink dev from the device chain */
-	write_lock(&dev_base_lock);
 	list_del_rcu(&dev->dev_list);
 	netdev_name_node_del(dev->name_node);
 	hlist_del_rcu(&dev->index_hlist);
-	write_unlock(&dev_base_lock);
 
 	dev_base_seq_inc(dev_net(dev));
 }
@@ -744,9 +718,9 @@ EXPORT_SYMBOL_GPL(dev_fill_forward_path);
  *	@net: the applicable net namespace
  *	@name: name to find
  *
- *	Find an interface by name. Must be called under RTNL semaphore
- *	or @dev_base_lock. If the name is found a pointer to the device
- *	is returned. If the name is not found then %NULL is returned. The
+ *	Find an interface by name. Must be called under RTNL semaphore.
+ *	If the name is found a pointer to the device is returned.
+ *	If the name is not found then %NULL is returned. The
  *	reference counters are not incremented so the caller must be
  *	careful with locks.
  */
@@ -827,8 +801,7 @@ EXPORT_SYMBOL(netdev_get_by_name);
  *	Search for an interface by index. Returns %NULL if the device
  *	is not found or a pointer to the device. The device has not
  *	had its reference counter increased so the caller must be careful
- *	about locking. The caller must hold either the RTNL semaphore
- *	or @dev_base_lock.
+ *	about locking. The caller must hold the RTNL semaphore.
  */
 
 struct net_device *__dev_get_by_index(struct net *net, int ifindex)
@@ -1233,15 +1206,11 @@ int dev_change_name(struct net_device *dev, const char *newname)
 
 	netdev_adjacent_rename_links(dev, oldname);
 
-	write_lock(&dev_base_lock);
 	netdev_name_node_del(dev->name_node);
-	write_unlock(&dev_base_lock);
 
 	synchronize_rcu();
 
-	write_lock(&dev_base_lock);
 	netdev_name_node_add(net, dev->name_node);
-	write_unlock(&dev_base_lock);
 
 	ret = call_netdevice_notifiers(NETDEV_CHANGENAME, dev);
 	ret = notifier_to_errno(ret);
-- 
2.43.0.594.gd9cf4e227d-goog



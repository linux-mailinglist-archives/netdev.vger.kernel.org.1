Return-Path: <netdev+bounces-70644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0560F84FDB6
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 21:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A31E7B29C9C
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 20:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C097C8F78;
	Fri,  9 Feb 2024 20:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JbtA3WKJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196AF1B942
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 20:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707510919; cv=none; b=u7Gj7Ro/hfJX0YLJhHd47diaFYY0hMJEwf4xrhp/IQl9DcETDIBH7J/Ht7gDoDzkRJoiOJh+pl3jQ+YzOnYTVwlnne95UlSqkkXDVRZOFXJJ/XRhRynR2J0JjtKYIjt+iHgQ/QS9bF54dXLVKHhv/oDCtc2LxtkUx+m3UWnT3QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707510919; c=relaxed/simple;
	bh=ahlla+16QokJ6wTt1qv7+vcqV9J+6TQp3ClJg5iP3I8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kJ2iSf24p7sihn8jlIQ3Nx58ZjRBVW+40X6N1SVXB05dQ71EfGYOi23pL1JdUvedzfqMCYGnJRJmfCbJdMcJjPnPROk7hki/rgh1izODYZgMl/3+11PZb8Tv5nc9MJr2rWS3lzVNmS8RQ4XnfQ4PCTtGa3AI4dMmve53AVGfEao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JbtA3WKJ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-604ad18981eso31354677b3.2
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 12:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707510917; x=1708115717; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eV11mstpzFnLJWh87jy8imRVnXBJeW3yOv2qvp05f7I=;
        b=JbtA3WKJ5hBwkDHorxIy+FBAdpNzB5N10x6lqThT8RP0/O6MtQAKTxiH8Cw/oPeRBo
         ve+G+rwtn09PU1npviPmVQBLZfAjtCOeDaPWSzchMUQlGlcPGUgYIDa0PfuKRQ1M/JDF
         3QFIJVcudUJVfV5dwUWXmkKe7qgI2C8kl54ThkcsAa7XRkyqmuhMWz7GnbuT7Mx1e6t0
         4r72KzMCCvlcmNNSv9J872mL34Ec9TKCohWXQd7FRN3qVA5yE95rb3lJTMcPF94cT0HP
         FstbMAU4ek6XH6uInwL5zStfALqI6qAYy/5f2vO3N4Lt4GzaGiFmAd+mULpggGT7teiz
         UgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707510917; x=1708115717;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eV11mstpzFnLJWh87jy8imRVnXBJeW3yOv2qvp05f7I=;
        b=ZRs8VKLURAEEhq/x0VBILriCLbdolmShPdLTKOVGFICjys+K2bOZserhCwWeeo3PIM
         X59b2cCbz39JDb7KBQPDQSzDY6u0fGzW0qzzHaMpwRs/9X7AQ6MacHQjWIzL5m5vQ/RK
         0ZT7eTLGdQoxdOYsiCaT4qShTi7978wX1NEsnVYEf1wYP6m/s7AmYyyFPA2mrl1i148I
         v4I/8fAQUpFHfWW5fuWj0ppy0ff4nxlX5YV7Kh7LYFDdf9iRadLWuiYTTUQSUibySbgm
         IOjq8LyphXTqdLf/n5BY/Vr2YgR4xOpyyP79FNBqfV7mqjxQYa7o77eu6gfSHEBbenPG
         76SA==
X-Gm-Message-State: AOJu0YyXleTu0uu8EI4A4QTL2aAOfcjDoMTTvZjKp4L1SXHqawQelNDZ
	tgu60VO+5VFGfcn1DxTQjQwcOUS0sQSvjIVzfzPNs7kGqFNM8c4f9fH1OO7G6WT9589+OmO4tnq
	yGOeJhekcjw==
X-Google-Smtp-Source: AGHT+IEFzoEUfpisLDtW+NzUOz/R/zrKE+NRXMIxwz/r73BASDe8z4V7OzhGvLp8qEaLuo3NHCvWUw91OH6Ddw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:102d:b0:dc6:c7ed:e72d with SMTP
 id x13-20020a056902102d00b00dc6c7ede72dmr65511ybt.4.1707510916976; Fri, 09
 Feb 2024 12:35:16 -0800 (PST)
Date: Fri,  9 Feb 2024 20:34:28 +0000
In-Reply-To: <20240209203428.307351-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209203428.307351-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209203428.307351-14-edumazet@google.com>
Subject: [PATCH v3 net-next 13/13] net: remove dev_base_lock
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
index d4d1e438ab8f1d2bd6426837b504ad6891fe83b7..94968baa7da172b69cc8ac148d39315018893420 100644
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
index a1cb7d3cab2c521fc28bd5f522c147bffca8d15e..456877e4b5d165878b3886db56d934c9e8c9cedc 100644
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
2.43.0.687.g38aa6559b0-goog



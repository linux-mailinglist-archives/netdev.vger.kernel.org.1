Return-Path: <netdev+bounces-70263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 536A184E2E5
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 15:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 781291C27065
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 14:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C9D79928;
	Thu,  8 Feb 2024 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="APmOIA9j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9F27B3FF
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 14:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707401556; cv=none; b=ob2wsUwLopirO8bKTb8K5oQXoGtBhmjwS22n3g1wRjiZ8m0k8HjhAVHuGrHexvW+EaqW5E+tv8f8M9N+CNQypnR3c1flEx0E8FVZVRFrwiKIbx4AInMAwIq14rKx9WzWd+W/zFaljDjz2FMP6Z0UZSe2ARDs1YrjuhlngWKgWKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707401556; c=relaxed/simple;
	bh=w2Ie9+bdPUx67CZqRE+quRI+wvl7Gn7OrPB9rRmrf8g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d3uQvY6XN7Qs8pN1KVIcW/QNj0vCHy8ldYf81rnEyemvKSAGEf7LmEmponp/jwm5XcBncSO6mCluNNalHfr9qgxhJtfJPT9HrpZ+2JdDVqDwsQAFmBn9ls6STJ7rY3Cl8fdU/kpXee9FP5M6zcN+z6HfAsm31iMQyA3aEaRLEeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=APmOIA9j; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7859d428fdfso208902085a.3
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 06:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707401553; x=1708006353; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=irhLyWxRXaUv1DlK+A4rXy6maAaO4CWIx5DziglKFXg=;
        b=APmOIA9j5WUUQ6Vhxg5yXyCGFlm112qR3wShhRsBrXU7zMVc2my5CBiJ+Rl0XwiS2q
         sU3BHWidXOGs+0plxTI66HOMphtAkGN37nE8tz9qAesrAMe53kvElTe03yaRqBCD+uFt
         HurKGRxeu4Cmk77L8gPQKHlNexnOyR+tlMi/T19Fc5HYbtmijy4bYEIaCOw1OA5kLtyg
         w+zfaB8CFmWlH0FTpUHJLrnwpLx9pgBgqri7rUsAXfGakJtsbWpWoTHqscFjhwR1y0pL
         z5bAkrcrDQPyUccx4+njyYuO81Zij6Fjclsaak469CavVhIzxb+y43+LVgPgk5fY6TLX
         6tcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707401553; x=1708006353;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=irhLyWxRXaUv1DlK+A4rXy6maAaO4CWIx5DziglKFXg=;
        b=ij1y0Go4iJBgH2uT96G9NBA+75TS95yBOCNsYt9O+pbvjaqIysgcDx2FnTB8+ss0sz
         DPDX3rVShQ2iio7gr9HA3P4pHcn/flL6A9r7NZxrk4XsbD5s2m/ggcp4Ev7+VxONKS8i
         6Fwg/6mtaUC8AdPGVWCxQ+fu82W+0boGEgox20EvJMkYyLLhgo4AP0CKTi3zMyav2IYV
         CfzMdqoo+DiMOInEUKYc3S/opw6DTcWMr4I2YmDIMig+RNgnvLlW2BfgkgTZGpKdhXaB
         IuX41wTOKmIZO9IYoRzy/MlFs2UVuV66ZKGZSBNCQQ7BOBMYUHf2x50t2rk1LZpGlLzk
         1e3g==
X-Gm-Message-State: AOJu0Yzkja+o4tcOsIOAYbjzZ5PkrvFA1QhW4RgnOKdbjm3j7TAoXPSi
	wF+rL3RbsWfwBmWZ2/9AaBM9mt+0pa/dL/H+gW7Ab2FNa+iOeC41HYfYULCqGyjSnDVS/A0QSK5
	g5Yg0hWvr4Q==
X-Google-Smtp-Source: AGHT+IH4YwHXsnC8Iy9np7IsIX1ZuMlHYWbgArktYb2OttZsicgBMkDE5SN8X3wCIeaDx0gojNSzjCbX6L6Y2A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:620a:8c04:b0:785:53d9:38f1 with SMTP
 id qz4-20020a05620a8c0400b0078553d938f1mr56775qkn.15.1707401553591; Thu, 08
 Feb 2024 06:12:33 -0800 (PST)
Date: Thu,  8 Feb 2024 14:11:54 +0000
In-Reply-To: <20240208141154.1131622-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208141154.1131622-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240208141154.1131622-14-edumazet@google.com>
Subject: [PATCH v2 net-next 13/13] net: remove dev_base_lock
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
index 636bea0a3587bd1d73389f2fe7f12b726bf56824..379220c28c423747cb7993596aafee168f85e6d7 100644
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
index 4adf1b93eefe8052dfd907727fe6f1996b3477fd..c8a51fb39c9f5474bbf0c6c98a7e16b2a759aaf0 100644
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



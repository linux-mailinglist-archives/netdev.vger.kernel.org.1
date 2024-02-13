Return-Path: <netdev+bounces-71188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D320485290C
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 07:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DB242844DA
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 06:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F86318044;
	Tue, 13 Feb 2024 06:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MSN7FMBs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7812C182D2
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 06:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707805992; cv=none; b=flwbU/Ih5UURDB/FThplb9GtxodW+F8UzNoPWSMfJi1OUeZVd0HEYsgl5dkfu6GiSSMZve2R50inrimdZShAmTNrkiOMlzDL5/1tS6cT5Wf2vWVO1qaB9dnM4BBpqqpscbUMFBc3tZO/eNu6T/+A3MzAviHZLQq2u0gRwXvtfEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707805992; c=relaxed/simple;
	bh=1ArgeFTJlG/zX5Twau0XgM2A1DGbdkSp16+77sr1wGE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sotiJ1gjzFHzKgQDETwIgQ1aUolGlFYt1VD9hB/szceMSGimzufEjh5Mr8lvp2mnxoATyJcL3A9KBVTsh8TmXKeoIZpgf8JpblPrJ+oFeYJ61i7JgstHvCwspIlikLs4IuYRzQ4MQt6VvGyQDXSYOxcSGAH62hsXghUnv4qNFzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MSN7FMBs; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6047fed0132so61569237b3.1
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 22:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707805989; x=1708410789; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YMQZrSYfbwKbeoCPqR+zmB0N7KcSmbdJ55FqHlpxrVQ=;
        b=MSN7FMBsgdXUsw8sSEUSoLBNPK/QMDpJvxxJTVbGvKczlDD/3deaNs9nk3k8S/ZHW7
         7LAR4QkQXW292tYheEsDlP97P5pGplckrV/2F6wpqfHzagxTvGXQpj2P1lBCVhNUI5bV
         nyG85asq/lmEEQIem1/8+FwyoTmdkK9bvpdt/OHw0Cn32SibGU+Cpu7pQ7P0iRKLBa9S
         bLxXrV+uFP/3AeGOtBYDZxkhs+iiToADYC1ENUDRL1RTVziACkwsqKo/WICmkn+V0g3s
         bMdHVeMdr4xMJY9aJASrZ9d0DDJg3pp/FofBM95caysqc+AbGTMAsyjvyMYqBSFAdAcH
         DBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707805989; x=1708410789;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YMQZrSYfbwKbeoCPqR+zmB0N7KcSmbdJ55FqHlpxrVQ=;
        b=Js4c8Rq1rVTEp/tUd2KpP1GN6ouN98qDv2NHonwlCOGofjWDDZ7njRdzbPhJ6Qp999
         /Vfo+UjPlX6q1ZWNGjYrA1SH18e24IfShwPbibWCNZEcKrpcdlwbXKQPn9dYSPhSiwmA
         KcpEvcH04QQfxlVKP2MN6AyyEw/hwIlxfUpwGHUP95VtiU2IU8U7UAjNd9H2esEOxjqk
         GrQpwqHFBzNLP0ZA+2HDeqOdzolEOnXMmIpdqplIFghKWoGKQeXXbAmrhkArZwRhvnKi
         EqDFjosFQcopkyDubhpgj8LiCva+FNPMDSr6WNCaCC1A9AxU9JhtwLj9zPhUe2gfqIcf
         zwdA==
X-Gm-Message-State: AOJu0YzAzBG5V5JOI4uBDx0AUbIUIMu71MRE82OOWWG3i0y1YmVzN4Gf
	sJwdFXz9jy50uE+gWd7a3XhgohoUt9G94/FF8/Yg778bOsh39YEr85tMvCbvHENBTDO/kMRDbcQ
	zKhwzvW1jug==
X-Google-Smtp-Source: AGHT+IFQm6ITrpkCQduxNdZERusycXaPsLqchj2lWxn55/x/PtXhtm6aOyv2eZD8v3APtkKdc3joYyxpDK73Rw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1005:b0:dcb:c2c0:b319 with SMTP
 id w5-20020a056902100500b00dcbc2c0b319mr111806ybt.9.1707805989547; Mon, 12
 Feb 2024 22:33:09 -0800 (PST)
Date: Tue, 13 Feb 2024 06:32:45 +0000
In-Reply-To: <20240213063245.3605305-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213063245.3605305-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213063245.3605305-14-edumazet@google.com>
Subject: [PATCH v4 net-next 13/13] net: remove dev_base_lock
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
index 0168d6e457bd3595eb6fc70938a83c0ece521a71..1d2edb05f85c6b643a46a6bd9cf3df0b6d2a67ae 100644
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
index a6b5c5aecb6f12a3cb280408bbdd5d9c0b9a9365..4177c57d227b31db12b1d700318ed39eea256d21 100644
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
 
 	synchronize_net();
 
-	write_lock(&dev_base_lock);
 	netdev_name_node_add(net, dev->name_node);
-	write_unlock(&dev_base_lock);
 
 	ret = call_netdevice_notifiers(NETDEV_CHANGENAME, dev);
 	ret = notifier_to_errno(ret);
-- 
2.43.0.687.g38aa6559b0-goog



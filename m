Return-Path: <netdev+bounces-178659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D48C6A7808E
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 18:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B8DE7A3EB9
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 16:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC43920DD47;
	Tue,  1 Apr 2025 16:35:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3936320D51F
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 16:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743525310; cv=none; b=uqGXWuaF2TKjy6jSotXG285EGds5HGMlaAI7bVSPOOW7zq0MWXpG90BCDGEcM9/DizveTBY+GVmtzotFgsopI6heiQlShO/GbYBxzDUh1q1LSiJZSGTiUfUHd78v+HxWpyXz8sY54T9nm7D+XPavtRkTxHTnXPtxWkul0LwmM18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743525310; c=relaxed/simple;
	bh=jtIpRcdfbZGr8j8HnOORbFj33P6heMMjUX2ftdMNEdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QDlfGQ+QOifgD7KjG20YkiQnkut5RlnAfYIfRNQnHn6uYuC2iHYOs49IMCV168FtVOEb9giR4Sp+cj/qfhlWnLKIgokcx5OLVIl6CBISVBMEX0gjiEcFQjhDQsW6X/1ime08GpT99UBXGmPxhUH1eqJMUz48IeaKe14AvD0TM2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-227b650504fso116541595ad.0
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 09:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743525308; x=1744130108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7aDtDjy3ey4QTIdSAIPP/aWvltr5sAHTnuDp8R+rVI=;
        b=fcvHJramCk5SW1O/kjB9Gc8Z77fzNQZI7HOfMRRdhrxehqEZ1kFO4kxwUcfjl7VNk4
         +HYExusEMr1FshNKIqi24HRt9Exc7mu/ocEvCZt+boBXR2sYBbuy3Nesn2deurvrfFgU
         ONQ2b23cc1I/mRQ7RA/fr+ybQ3dhWmYn17JOwPU/57qApVzHtQRIsFxKHAezotjQ4hsH
         6OCUqlHsxTd9mqQ8YwTgsRUTyRGVYjcCj0gmn/fUgagvhZ26uYqhTAftypAOGQ5ZO5d6
         lu0guxlAKVb6JC0lhmvprvcVuK5fGzomcSvdHAN8xc9C1WQrCN16N/4Y8i7pcnrPiyn+
         Ms/g==
X-Gm-Message-State: AOJu0YyRwkAL5TtroqgE/M0T9Aum7c3r2hT4Z5SDvBGjMowrx678uTR+
	K3YtuZK+pcRLQdW3w5DfcdNhr+0uOp91cdRrPEHObDkW1h2AJukGUJ6AxPZo/Q==
X-Gm-Gg: ASbGncuk3+oyjMlJFSKoTJQI5lLkZjlk7AhpwxprwyIX3B/c9kQ0KZ9uUVqt70tqVvu
	39QEXqwxNEFekrNO+2+fpcm9KppYLblbG4YWUQUKgNX3gOjdbA/RG612fA++o1PBg68cs2Xp6Bu
	EigVeJVhxveILdOyqnuw8+oA0S1CBEOf7M0uhkLYGZ8KdM7Nen11zJ3gpkXurHI+jVREtkhWz54
	6bE8bMZN2Sh71NFT7djISvB9L+0/cD3t5w6+ARQDmqB2QQ83lcPcIRJhUtHfXNgAANeC8X354x+
	w+l24OyLeBHl+Ruj4pOOiBiGLj3Vk/lAe20OKk5DGvXu
X-Google-Smtp-Source: AGHT+IHlvRCiCm8u1+6Cks1GmVtmsBIZ3y5TKSKXxi/FwbarPEI34ziVQxGe/IpUyIdrcaHNKrGX+w==
X-Received: by 2002:a17:903:2408:b0:224:1157:6d26 with SMTP id d9443c01a7336-2292f942a8fmr226841365ad.4.1743525308241;
        Tue, 01 Apr 2025 09:35:08 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2291eeca0e2sm90953075ad.34.2025.04.01.09.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 09:35:07 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v5 10/11] netdev: add "ops compat locking" helpers
Date: Tue,  1 Apr 2025 09:34:51 -0700
Message-ID: <20250401163452.622454-11-sdf@fomichev.me>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250401163452.622454-1-sdf@fomichev.me>
References: <20250401163452.622454-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Add helpers to "lock a netdev in a backward-compatible way",
which for ops-locked netdevs will mean take the instance lock.
For drivers which haven't opted into the ops locking we'll take
rtnl_lock.

The scoped foreach is dropping and re-taking the lock for each
device, even if prev and next are both under rtnl_lock.
I hope that's fine since we expect that netdev nl to be mostly
supported by modern drivers, and modern drivers should also
opt into the instance locking.

Note that these helpers are mostly needed for queue related state,
because drivers modify queue config in their ops in a non-atomic
way. Or differently put, queue changes don't have a clear-cut API
like NAPI configuration. Any state that can should just use the
instance lock directly, not the "compat" hacks.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/net/netdev_lock.h | 16 +++++++++++++
 net/core/dev.c            | 49 +++++++++++++++++++++++++++++++++++++++
 net/core/dev.h            | 15 ++++++++++++
 3 files changed, 80 insertions(+)

diff --git a/include/net/netdev_lock.h b/include/net/netdev_lock.h
index c316b551df8d..5706835a660c 100644
--- a/include/net/netdev_lock.h
+++ b/include/net/netdev_lock.h
@@ -64,6 +64,22 @@ netdev_ops_assert_locked_or_invisible(const struct net_device *dev)
 		netdev_ops_assert_locked(dev);
 }
 
+static inline void netdev_lock_ops_compat(struct net_device *dev)
+{
+	if (netdev_need_ops_lock(dev))
+		netdev_lock(dev);
+	else
+		rtnl_lock();
+}
+
+static inline void netdev_unlock_ops_compat(struct net_device *dev)
+{
+	if (netdev_need_ops_lock(dev))
+		netdev_unlock(dev);
+	else
+		rtnl_unlock();
+}
+
 static inline int netdev_lock_cmp_fn(const struct lockdep_map *a,
 				     const struct lockdep_map *b)
 {
diff --git a/net/core/dev.c b/net/core/dev.c
index e59eb173900d..87cba93fa59f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1051,6 +1051,18 @@ struct net_device *__netdev_put_lock(struct net_device *dev)
 	return dev;
 }
 
+static struct net_device *__netdev_put_lock_ops_compat(struct net_device *dev)
+{
+	netdev_lock_ops_compat(dev);
+	if (dev->reg_state > NETREG_REGISTERED) {
+		netdev_unlock_ops_compat(dev);
+		dev_put(dev);
+		return NULL;
+	}
+	dev_put(dev);
+	return dev;
+}
+
 /**
  *	netdev_get_by_index_lock() - find a device by its ifindex
  *	@net: the applicable net namespace
@@ -1073,6 +1085,18 @@ struct net_device *netdev_get_by_index_lock(struct net *net, int ifindex)
 	return __netdev_put_lock(dev);
 }
 
+struct net_device *
+netdev_get_by_index_lock_ops_compat(struct net *net, int ifindex)
+{
+	struct net_device *dev;
+
+	dev = dev_get_by_index(net, ifindex);
+	if (!dev)
+		return NULL;
+
+	return __netdev_put_lock_ops_compat(dev);
+}
+
 struct net_device *
 netdev_xa_find_lock(struct net *net, struct net_device *dev,
 		    unsigned long *index)
@@ -1098,6 +1122,31 @@ netdev_xa_find_lock(struct net *net, struct net_device *dev,
 	} while (true);
 }
 
+struct net_device *
+netdev_xa_find_lock_ops_compat(struct net *net, struct net_device *dev,
+			       unsigned long *index)
+{
+	if (dev)
+		netdev_unlock_ops_compat(dev);
+
+	do {
+		rcu_read_lock();
+		dev = xa_find(&net->dev_by_index, index, ULONG_MAX, XA_PRESENT);
+		if (!dev) {
+			rcu_read_unlock();
+			return NULL;
+		}
+		dev_hold(dev);
+		rcu_read_unlock();
+
+		dev = __netdev_put_lock_ops_compat(dev);
+		if (dev)
+			return dev;
+
+		(*index)++;
+	} while (true);
+}
+
 static DEFINE_SEQLOCK(netdev_rename_lock);
 
 void netdev_copy_name(struct net_device *dev, char *name)
diff --git a/net/core/dev.h b/net/core/dev.h
index 7ee203395d8e..c4b645120d72 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -41,6 +41,21 @@ DEFINE_FREE(netdev_unlock, struct net_device *, if (_T) netdev_unlock(_T));
 	     (var_name = netdev_xa_find_lock(net, var_name, &ifindex)); \
 	     ifindex++)
 
+struct net_device *
+netdev_get_by_index_lock_ops_compat(struct net *net, int ifindex);
+struct net_device *
+netdev_xa_find_lock_ops_compat(struct net *net, struct net_device *dev,
+			       unsigned long *index);
+
+DEFINE_FREE(netdev_unlock_ops_compat, struct net_device *,
+	    if (_T) netdev_unlock_ops_compat(_T));
+
+#define for_each_netdev_lock_ops_compat_scoped(net, var_name, ifindex)	\
+	for (struct net_device *var_name __free(netdev_unlock_ops_compat) = NULL; \
+	     (var_name = netdev_xa_find_lock_ops_compat(net, var_name,	\
+							&ifindex));	\
+	     ifindex++)
+
 #ifdef CONFIG_PROC_FS
 int __init dev_proc_init(void);
 #else
-- 
2.49.0



Return-Path: <netdev+bounces-178346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE47CA76ACD
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 17:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD59D188DCA8
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 15:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1AC21D004;
	Mon, 31 Mar 2025 15:06:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBBA21CC71
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 15:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743433582; cv=none; b=KrYrGNF8m10fTJyvlebQsnb12kYIOuVoOXnls7I5Ew2TFjrYiiSquk1d+zVV0b4TC3S8xPgn/+W0xgi/GfhVc20cZni7HvE2bEAjs4g5E0RnlLjxBySsDyJOlEaRkOWHYuWrP7usTN3drA/KymKwgwe9i6DgqkELj2ZdvANjLxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743433582; c=relaxed/simple;
	bh=hl35ujfOZVg64UpZwk7qsbl7ZjcbQrQhhAeOrMhC5RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BICZk+IOQ/fxQUD5hnG0nBmgnEUFYuPo3s8dKA8bXCJ6Usgrx+o7YUtJQKwy/teSRV1EWxdh/kkl1GGAb2a6e4MDcuymnxd9bnLTFhCdzPiExmX1CHtx+ftnmPyd88NuNiG+FwVwJD1Ye4et2h/6nY1DWqWR/9AaO138YTt0loM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-223f4c06e9fso82917075ad.1
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 08:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743433579; x=1744038379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwTWfgqefJmGJ+Qc6zGlY2axibd++Vub9iWTsP1YT2g=;
        b=OPQLkdrpJbnaedU2tho/2LiPXMsOMJpMbJ03DAsmmhKCm8uT8srp7wgWH6JSIM3g99
         BAXwwImeQh1ejoQLA6GBoMXbdaZhp6o+qBKDmcRgeW8zencqeyMFtfCbfkKx59+w7Kuy
         8CPFLXFjtkWynZBlTMqC1Of2SqblbATmATM/djjaP+DP/r6DSeVAQpoalx9/qxi/SegA
         oyTdoa22l+Hm/L/thCvem2i8e13WHkyLVQfUgrEpI9jAo5axQLbeZAuG0jhm3zB0aQKP
         CMzFgC0iZOA2odHNBSeKltV8dTjJFenlJilkrfOaxKPFVE4Nu2dYMAUBJubSk5jxS0o3
         t1Ng==
X-Gm-Message-State: AOJu0YwAaqbREIWCZF4Qr8kkhscAJ7vjOBBxfYtmqYk/If1WIAR2m5v9
	WyjwzJgKnSprpNaFHM3C51625kZ4ZK9JO0WWWS+ZWCc3WXREiJOfH1sG
X-Gm-Gg: ASbGncs7Dm/IrAD6D9Ikh2Tb1V7h/Kb85lk+enNHSI5spd+oC7Pj68FKqGuY3G+ES5r
	XDNS8ppGuIzjjcCwv0IUHNabfbOyNwqs72Xe/ZrOws3YqlyeTjeK5lMqaCqdx2VXtwv5HwX2nvx
	RvL47XL34Wj19oWtboqT0kdnMyQdx3Ig5ZW2Qy9oQnlCYEn9vr6jGRquaZr1I6hhZF6m/gfRrwR
	R0gIz8Y2LBhxFIbrXP6fVAsyXQhcoAdphVTj4Ae1Dn9WWtlDMmXBFmaXctSHNQEk+lBKEb/aNf8
	7Uh3z/Q1Ie1lULJF23rOfuYDAQWuQODICnYhyZQmbyiVikFQkl/IFWc=
X-Google-Smtp-Source: AGHT+IHRISq9ZPUrkcVHgRhHvsrxYbi8p3jbMfvNpnrSxDHzX2Op14zVO56PHZPOzhrSCLZk8p/X8g==
X-Received: by 2002:a17:90b:1f81:b0:2ee:8cbb:de28 with SMTP id 98e67ed59e1d1-3053189a552mr16400708a91.8.1743433579522;
        Mon, 31 Mar 2025 08:06:19 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2291f1f84fcsm70200925ad.228.2025.03.31.08.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 08:06:19 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v4 10/11] netdev: add "ops compat locking" helpers
Date: Mon, 31 Mar 2025 08:06:02 -0700
Message-ID: <20250331150603.1906635-11-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250331150603.1906635-1-sdf@fomichev.me>
References: <20250331150603.1906635-1-sdf@fomichev.me>
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
index 5f712de5bf8a..8ab108a4e2cf 100644
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
2.48.1



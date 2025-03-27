Return-Path: <netdev+bounces-177964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7942CA733BC
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 14:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CA0A3BCF03
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 13:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF2B217F56;
	Thu, 27 Mar 2025 13:57:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC56421422C
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 13:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743083837; cv=none; b=MC6iRHv5ck9zHey2PcR885x8XNHOdiW9Mae+giIS5iuBl7uSHolt2iCv8FmiTEa5RXPvAJIOvW4aoY40QQk0lh0AO83sP4Xs0nnBgsQZUa638GrmOaH6oPbGxOCC9kC7rRzVWAC02HGc6rEMhq4/UA8V81GpsamjGm8Ua7INo0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743083837; c=relaxed/simple;
	bh=of2BHr0ODb2uStHV41mgqAmOSbSLGSoE+Pr7pCR6LSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ApQCqpNHN1wS6s6zSiag1/FM6VEFuiexP/+hoB2Y04wRIYi+iFjGXBrHgKKRDJBwfDPlS3brNSop7mDWydFMZRz8XYEYNLcFT8Ol7wL3Ezw2bOdQ5wSQjZ4DvSvW0zBxiuMaAFdg0GzXumn6xdtOU2ar4Mj0yLSvkD9IPB/kATM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-224191d92e4so19777575ad.3
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 06:57:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743083835; x=1743688635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=41eutsHNNUgp/YLlU9qv9rjhqH3AWJ6Bj/6el16QKro=;
        b=h+s3Ib36M0uxhAoQQ1Jswy7zT1rvaBzn48NVyCOifK0we1URlGYt1whZDM+d2Z4gAc
         Yp0x1sK/0lfD+RiKupJ1fcfc93FWoE3WfVB4/2/4xsCoYs/OfnT6NXXYKVtcW59nx+Rc
         TtLP4JOT9lTlZO/2HmWeXPDmBpZHRwwAnhSrLj9vuiuTa4vZB3oeXu/+55tJYPJ8kKU0
         fI39/fysLCrgLinvT62efYao4LwMGQHrGdweXri579L/klKP8lr/bBgMHHE1mFEcJljB
         GyXZt4Z4ww6xvm/vx+jwQBMT1XYBmQomUcNJ3Oas8upejivne76HzIKOJINbf4zeVRSt
         lt6Q==
X-Gm-Message-State: AOJu0Yz8zFaAPUfWqGthaSiqwWRC3rTLCnxtnlFljq7R+AJYR/motVXa
	SCRMHLxl8z+3CR+zugpKbSK3eFqLFGUqI7tqlxfY351vqY2UeRSEif6s9cfQZQ==
X-Gm-Gg: ASbGncvfw7TVEEUjGZd5MDAZd7w6GV8ncPkDKqiYsCRb9vMLOgNoB9dqU9RB/C/Fvpb
	JTshh/eVD6f9zut6mzG/4SwPWLFCqwzTBRct9+51mll9o6trjS31rR57Z3mIk+UxR+eoFBl4uDD
	xvgE5UsFLXRAHylSDEIXmUzra4JcgY0wgvPQFQbFEFVWjpUikboWfq+C4G7RXsd0C/f79DzsgUh
	ZfJkwX1cic5RLeIvjTy/uIpsnJQKvOo5iGR/HVHCd+BQZcObXMW3159YYBTb+aOlfxu16LCeloX
	CVIsxCrlNoI4KsGRWJeItZhmvFWGe2njSxYMkjqBEWtC
X-Google-Smtp-Source: AGHT+IHESlvLw+d/BF9Ru55e4YB+Dzgp51+JEFes9+XLZ340jqxTIQaoNlewillDkf+fea7VnSsqmg==
X-Received: by 2002:a17:902:f644:b0:216:6901:d588 with SMTP id d9443c01a7336-228048ac56amr51471015ad.15.1743083834669;
        Thu, 27 Mar 2025 06:57:14 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-227811e3132sm129034435ad.200.2025.03.27.06.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 06:57:14 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v2 10/11] netdev: add "ops compat locking" helpers
Date: Thu, 27 Mar 2025 06:56:58 -0700
Message-ID: <20250327135659.2057487-11-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250327135659.2057487-1-sdf@fomichev.me>
References: <20250327135659.2057487-1-sdf@fomichev.me>
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
index 1c0c9a94cc22..76cbf5a449b6 100644
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
index bb4a135b1569..20ae7cb79163 100644
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
@@ -1074,6 +1086,18 @@ struct net_device *netdev_get_by_index_lock(struct net *net, int ifindex)
 }
 EXPORT_SYMBOL(netdev_get_by_index_lock);
 
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
@@ -1099,6 +1123,31 @@ netdev_xa_find_lock(struct net *net, struct net_device *dev,
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
index 8d35860f2e89..e7446b25bcde 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -40,6 +40,21 @@ DEFINE_FREE(netdev_unlock, struct net_device *, if (_T) netdev_unlock(_T));
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



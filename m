Return-Path: <netdev+bounces-178207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5AFA7578E
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 19:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 186ED3AE9D8
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 18:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7D81DFE0B;
	Sat, 29 Mar 2025 18:57:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6508B1DF985
	for <netdev@vger.kernel.org>; Sat, 29 Mar 2025 18:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743274643; cv=none; b=WUWETRVgRh5vY6Q8ERPfRdpMZZxYq9gRq3731jDQwcYrL0Eevq8H/IAdmqKTOGID+3c+YJ9ltpy7w9YIogS6TWaOoxto4xqutWykoYFGBDadC733966cv/yd2C4rRWHgmx9efZXRM8gSiO3v5RftH2rr+42K/iCfNVPSQ+Y/cvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743274643; c=relaxed/simple;
	bh=hl35ujfOZVg64UpZwk7qsbl7ZjcbQrQhhAeOrMhC5RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqcWvbYtXgfK/3mtsNZWrduGL/jGnZNbwRHwqHDJq0TXC9r+gDlKzpbRFV2v9C6/wDZ3M1h8UoId+kzy+YiWzYi4H2phbtpqhmgxOyAUivg86sNJbiwv16S7tnp+6IR3rvH/SzSQ7pdQNdVJ/uW6mA9aOoMY+su3l0r5+Uc14tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2279915e06eso69948725ad.1
        for <netdev@vger.kernel.org>; Sat, 29 Mar 2025 11:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743274641; x=1743879441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwTWfgqefJmGJ+Qc6zGlY2axibd++Vub9iWTsP1YT2g=;
        b=pQKZ9kQKL0jp8h8jtjVpbXKX+PELzuLZBfBmv4pXm5wpjB1nKJBcvuxz3qfG79tOBA
         6UzKoap/wL0Axvw1OJFDvJkv2L/jRh3kcvX5QC5tciNWSGL4M+FZO5p+aNZv7jNwyu2y
         By3pRGovXHbiiOEy8njd/uR7D/H4EXD4mMC7YH3CI4f0nt8O66fFOGOVIs34FzPbaf/p
         deYJEG0tlHZEQtipFCdsog2HuO8rqL+xsESmpO+cqe1C/8qTNLTFNlTtA8Q0ZgLmqU+s
         EfQ3yZ/JrOMScc11e8yibSyzo7dCQidHh/eYZ30nmGEVQdrIQTBZ295YaizUAMr8v8oU
         mYIw==
X-Gm-Message-State: AOJu0YyCsGspEJldJ8R1ke94KCniIudsTrkZn738s+FmsaRkuhs9EEpY
	am54mLLxeWjiY3WVRVcCbG6ykB/hMhQCbLS08z5emnvEfF4ORdP5jGOroEo=
X-Gm-Gg: ASbGncs+GfL1niAJaX3eL7GAdtapJd3zlO4Xpd0ucDnTWPu5FQ1Pf0+/csSAXaxkzTS
	oLd2xucaG+zvFzf0di/dyvlr1Nq3Zdbbeq7QR2Rse00ilOda40k+aHP+9kraSuDVGA8EClnL+Wr
	PEF9HPcKR/0FJ5/wWNVnYHKFqEAECwnrl+m0G2KaOu/HejYeuXeSmXe6eIGXCnx/6DEmTLof2Jm
	qREfsGom7Jh52FFOO2/VNvasnl/oze6UeLFaCxqov0N7gEnlngBO3RH+ACE4tLhencMEU/2zZ89
	AadVpAoTyvkFypankwad6JuScIGHEPHZneB0OSUtpHYr
X-Google-Smtp-Source: AGHT+IEoyJqptpSkbfMcWWnHAwCER0cdlnTjbX6uLQbrCIuT0b86G2OoUT0JQkAjQCldFkRM18WHLg==
X-Received: by 2002:a05:6a00:983:b0:732:2484:e0ce with SMTP id d2e1a72fcca58-739804397a1mr4282488b3a.17.1743274640890;
        Sat, 29 Mar 2025 11:57:20 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73970deeea2sm3922931b3a.21.2025.03.29.11.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 11:57:20 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v3 10/11] netdev: add "ops compat locking" helpers
Date: Sat, 29 Mar 2025 11:57:03 -0700
Message-ID: <20250329185704.676589-11-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250329185704.676589-1-sdf@fomichev.me>
References: <20250329185704.676589-1-sdf@fomichev.me>
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



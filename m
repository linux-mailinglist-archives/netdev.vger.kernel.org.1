Return-Path: <netdev+bounces-56345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B25D80E8EB
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 11:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20E47281873
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 10:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF565C089;
	Tue, 12 Dec 2023 10:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="pRcIP+sp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EE295
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 02:17:47 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5510479806dso3111987a12.0
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 02:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702376266; x=1702981066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvQLavHZhgBYjO34rYxoIaKhu/qHgcB5JUua6zhju5Q=;
        b=pRcIP+spTiuAckMce2w9M7mwtfuMA+UmoTGRsOufGLDhZ9mQEaTAvGHHdjRi5nR9w+
         Y+jgog/zU8Rf95EX70MrXuAXBKwOqeHt086IDsYlDKQ5TNJ+dV1ATAib+RUl8rbXkk/o
         r/Hitn7QugHbP4qWB1CGFDopBDMtB+zqnEryZt+l/S+g0SMt2NxY9tQxeGCukz46svjm
         j7J1QVryDUNH9RenulYIYo/Hsjn+VekNO35qA5rrfstg0HW+bdxWHA9KMIkPnBm3q2eC
         hb0aiz6Cx818YQNy/WDmRFsKsKgpIGHiYUys2q0kmRaIkUCgFVLmOV8L+wjnfdZDs9im
         yVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702376266; x=1702981066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GvQLavHZhgBYjO34rYxoIaKhu/qHgcB5JUua6zhju5Q=;
        b=pcVbZ5cNgirmDtfBqNcTuwEU8cuHQbohmOjCfTNuaQfBXyDzj3R8euGYb2QW1u7hO8
         EiXr0ar1aTvztiusc/eU4IxxrQvjVf+6BGMbKeyaS1z5zUC46hdL2Qn0Hpzofz+Y22wJ
         LYcJS/I6zerjyo94VliWXMBRA6zl6WPrsrW4MFowEfI6TqfjMfa/jbdVhqc0Rv8Jlhxj
         4i0d4fArSWSqks3AjP9Tl5TUaZgimUFGhLDn+exq08AI+UIAj2Lg539rmcGlYFlYUrSX
         ocqMTW1DIEe17Raqid13O1pLn4SsT8Ukvp8ronGQc+tRMkVEgYajJ5fJ2CiIrXPvemUK
         xNCw==
X-Gm-Message-State: AOJu0YyrwdOXXA8Dz++wOkQ50NpjcOQJhbnedxCOQ+iG7Q2pl0cWTtvF
	fPbeb7KuR6wm3HPpMtTQuNuIvh5tUOpzV6fmZZE=
X-Google-Smtp-Source: AGHT+IGXTgnoJsXvzyCsuH0tVVl0HeuKZLCWtiOQsIsHGqxq1ZR/rRIwx0T4G/5UZaXZh8Pv6d3UFQ==
X-Received: by 2002:a50:ab53:0:b0:551:bcc5:225 with SMTP id t19-20020a50ab53000000b00551bcc50225mr91888edc.96.1702376266379;
        Tue, 12 Dec 2023 02:17:46 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id c63-20020a509fc5000000b0054c738b6c31sm4789617edf.55.2023.12.12.02.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 02:17:45 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	jhs@mojatatu.com,
	johannes@sipsolutions.net,
	andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com,
	sdf@google.com,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com
Subject: [patch net-next v6 5/9] genetlink: introduce per-sock family private storage
Date: Tue, 12 Dec 2023 11:17:32 +0100
Message-ID: <20231212101736.1112671-6-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231212101736.1112671-1-jiri@resnulli.us>
References: <20231212101736.1112671-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Introduce a wrapper sock struct for Generic netlink and store
a pointer to family privs xarray. This per socket xarray contains
family->id indexed priv storage.

Note I used xarray instead of suggested linked list as it is more
convenient.

Introduce genl_sk_priv_get() to get the family priv pointer and
initialize it in case it does not exist.
Introduce __genl_sk_priv_get() to obtain family the priv pointer
under RCU read lock.

Allow family to specify the priv size, init() and destroy() callbacks.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v5->v6:
- moved sock_priv* fields out of private section of struct genl_family
- introduced NETLINK_SOCK_PROTO_SIZE define and use that in
  NETLINK_SOCK_SIZE computation
- moved struct genl_sock into genetlink.c, added BUILD_BUG_ON check for
  its size
- added missing priv free when xa_cmpxchg() fails
- added per-family sock privs tracking in a list, init the list with
  lock on family register, free all related privs on family unregister
- moved code up in above family register/unregister code
- added documentation comment part for sock_priv* family struct fields
- added WARN_ON_ONCE priv size check in genl_sk_priv_alloc()
v4->v5:
- s/Returns/Return/ in function comments
- introduced wrapper genl sock struct and store xarray there
- changed family helpers to genl_sk_priv_get() and __genl_sk_priv_get()
- introduced sock_priv_size for family and use this to allocate the priv
  in generic netlink code
- introduced init/destroy callbacks for family privs
- moved genl_unlock() call a bit up in the unlikely case section
- remove "again" label and return directly
v3->v4:
- new patch
---
 include/net/genetlink.h  |  16 +++
 net/netlink/af_netlink.c |   2 +-
 net/netlink/af_netlink.h |   7 ++
 net/netlink/genetlink.c  | 207 ++++++++++++++++++++++++++++++++++++++-
 4 files changed, 230 insertions(+), 2 deletions(-)

diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index c53244f20437..7df3ca11070a 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -20,6 +20,11 @@ struct genl_multicast_group {
 	u8			cap_sys_admin:1;
 };
 
+struct genl_sk_priv_list {
+	struct list_head list;
+	spinlock_t lock; /* protects list */
+};
+
 struct genl_split_ops;
 struct genl_info;
 
@@ -51,6 +56,9 @@ struct genl_info;
  * @split_ops: the split do/dump form of operation definition
  * @n_split_ops: number of entries in @split_ops, not that with split do/dump
  *	ops the number of entries is not the same as number of commands
+ * @sock_priv_size: the size of per-socket private memory
+ * @sock_priv_init: the per-socket private memory initializer
+ * @sock_priv_destroy: the per-socket private memory destructor
  *
  * Attribute policies (the combination of @policy and @maxattr fields)
  * can be attached at the family level or at the operation level.
@@ -84,11 +92,17 @@ struct genl_family {
 	const struct genl_multicast_group *mcgrps;
 	struct module		*module;
 
+	size_t			sock_priv_size;
+	void			(*sock_priv_init)(void *priv);
+	void			(*sock_priv_destroy)(void *priv);
+
 /* private: internal use only */
 	/* protocol family identifier */
 	int			id;
 	/* starting number of multicast group IDs in this family */
 	unsigned int		mcgrp_offset;
+	/* list of per-socket privs */
+	struct genl_sk_priv_list *sock_priv_list;
 };
 
 /**
@@ -298,6 +312,8 @@ static inline bool genl_info_is_ntf(const struct genl_info *info)
 	return !info->nlhdr;
 }
 
+void *__genl_sk_priv_get(struct sock *sk, struct genl_family *family);
+void *genl_sk_priv_get(struct sock *sk, struct genl_family *family);
 int genl_register_family(struct genl_family *family);
 int genl_unregister_family(const struct genl_family *family);
 void genl_notify(const struct genl_family *family, struct sk_buff *skb,
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 177126fb0484..5683b0ca23b1 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -632,7 +632,7 @@ static void netlink_remove(struct sock *sk)
 static struct proto netlink_proto = {
 	.name	  = "NETLINK",
 	.owner	  = THIS_MODULE,
-	.obj_size = sizeof(struct netlink_sock),
+	.obj_size = NETLINK_SOCK_SIZE,
 };
 
 static int __netlink_create(struct net *net, struct socket *sock,
diff --git a/net/netlink/af_netlink.h b/net/netlink/af_netlink.h
index 2145979b9986..c9d31e34269a 100644
--- a/net/netlink/af_netlink.h
+++ b/net/netlink/af_netlink.h
@@ -53,6 +53,13 @@ struct netlink_sock {
 	struct work_struct	work;
 };
 
+/* Size of netlink sock is size of the biggest user with priv,
+ * which is currently just Generic Netlink.
+ */
+#define NETLINK_SOCK_PROTO_SIZE 8
+#define NETLINK_SOCK_SIZE	\
+	(sizeof(struct netlink_sock) + NETLINK_SOCK_PROTO_SIZE)
+
 static inline struct netlink_sock *nlk_sk(struct sock *sk)
 {
 	return container_of(sk, struct netlink_sock, sk);
diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 9c7ffd10df2a..676dac168568 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -22,6 +22,8 @@
 #include <net/sock.h>
 #include <net/genetlink.h>
 
+#include "af_netlink.h"
+
 static DEFINE_MUTEX(genl_mutex); /* serialization of message processing */
 static DECLARE_RWSEM(cb_lock);
 
@@ -631,6 +633,199 @@ static int genl_validate_ops(const struct genl_family *family)
 	return 0;
 }
 
+struct genl_sock {
+	struct netlink_sock nlk_sk;
+	struct xarray *family_privs;
+};
+
+static inline struct genl_sock *genl_sk(struct sock *sk)
+{
+	BUILD_BUG_ON(sizeof(struct genl_sock) > NETLINK_SOCK_SIZE);
+	return container_of(nlk_sk(sk), struct genl_sock, nlk_sk);
+}
+
+struct genl_sk_priv {
+	struct list_head list;
+	struct genl_family *family;
+	void (*destructor)(void *priv);
+	long priv[];
+};
+
+static struct genl_sk_priv *genl_sk_priv_alloc(struct genl_family *family)
+{
+	struct genl_sk_priv *priv;
+
+	if (WARN_ON_ONCE(!family->sock_priv_size))
+		return ERR_PTR(-EINVAL);
+
+	priv = kzalloc(size_add(sizeof(*priv), family->sock_priv_size),
+		       GFP_KERNEL);
+	if (!priv)
+		return ERR_PTR(-ENOMEM);
+	priv->family = family;
+	priv->destructor = family->sock_priv_destroy;
+	if (family->sock_priv_init)
+		family->sock_priv_init(priv->priv);
+	spin_lock(&family->sock_priv_list->lock);
+	list_add(&priv->list, &family->sock_priv_list->list);
+	spin_unlock(&family->sock_priv_list->lock);
+	return priv;
+}
+
+static void genl_sk_priv_free(struct genl_sk_priv *priv)
+{
+	spin_lock(&priv->family->sock_priv_list->lock);
+	list_del(&priv->list);
+	spin_unlock(&priv->family->sock_priv_list->lock);
+	if (priv->destructor)
+		priv->destructor(priv->priv);
+	kfree(priv);
+}
+
+static int genl_sk_priv_list_alloc(struct genl_family *family)
+{
+	if (!family->sock_priv_size)
+		return 0;
+
+	family->sock_priv_list = kzalloc(sizeof(*family->sock_priv_list),
+					 GFP_KERNEL);
+	if (!family->sock_priv_list)
+		return -ENOMEM;
+	INIT_LIST_HEAD(&family->sock_priv_list->list);
+	spin_lock_init(&family->sock_priv_list->lock);
+	return 0;
+}
+
+static void genl_sk_priv_list_free(const struct genl_family *family)
+{
+	struct genl_sk_priv *priv, *tmp;
+
+	if (!family->sock_priv_size)
+		return;
+
+	list_for_each_entry_safe(priv, tmp, &family->sock_priv_list->list, list)
+		genl_sk_priv_free(priv);
+	kfree(family->sock_priv_list);
+}
+
+static void genl_release(struct sock *sk, unsigned long *groups)
+{
+	struct genl_sock *gsk = genl_sk(sk);
+	struct genl_sk_priv *priv;
+	unsigned long family_id;
+
+	if (!gsk->family_privs)
+		return;
+	xa_for_each(gsk->family_privs, family_id, priv) {
+		xa_erase(gsk->family_privs, family_id);
+		genl_sk_priv_free(priv);
+	}
+	xa_destroy(gsk->family_privs);
+	kfree(gsk->family_privs);
+}
+
+static struct xarray *genl_family_privs_get(struct genl_sock *gsk)
+{
+	struct xarray *family_privs;
+
+	family_privs = READ_ONCE(gsk->family_privs);
+	if (family_privs)
+		return family_privs;
+
+	family_privs = kzalloc(sizeof(*family_privs), GFP_KERNEL);
+	if (!family_privs)
+		return ERR_PTR(-ENOMEM);
+	xa_init_flags(family_privs, XA_FLAGS_ALLOC);
+
+	/* Use genl lock to protect family_privs to be
+	 * initialized in parallel by different CPU.
+	 */
+	genl_lock();
+	if (unlikely(gsk->family_privs)) {
+		genl_unlock();
+		xa_destroy(family_privs);
+		kfree(family_privs);
+		return READ_ONCE(gsk->family_privs);
+	}
+	WRITE_ONCE(gsk->family_privs, family_privs);
+	genl_unlock();
+	return family_privs;
+}
+
+/**
+ * __genl_sk_priv_get - Get per-socket private pointer for family
+ *
+ * @sk: socket
+ * @family: family
+ *
+ * Lookup a private pointer stored per-socket by a specified
+ * Generic netlink family.
+ *
+ * Caller should make sure this is called in RCU read locked section.
+ *
+ * Return: valid pointer on success, otherwise NULL.
+ */
+void *__genl_sk_priv_get(struct sock *sk, struct genl_family *family)
+{
+	struct genl_sock *gsk = genl_sk(sk);
+	struct genl_sk_priv *priv;
+	struct xarray *family_privs;
+
+	family_privs = READ_ONCE(gsk->family_privs);
+	if (!family_privs)
+		return NULL;
+	priv = xa_load(family_privs, family->id);
+	return priv ? priv->priv : NULL;
+}
+
+/**
+ * genl_sk_priv_get - Get per-socket private pointer for family
+ *
+ * @sk: socket
+ * @family: family
+ *
+ * Store a private pointer per-socket for a specified
+ * Generic netlink family.
+ *
+ * Caller has to make sure this is not called in parallel multiple times
+ * for the same sock and also in parallel to genl_release() for the same sock.
+ *
+ * Return: previously stored private pointer for the family (could be NULL)
+ * on success, otherwise negative error value encoded by ERR_PTR().
+ */
+void *genl_sk_priv_get(struct sock *sk, struct genl_family *family)
+{
+	struct genl_sk_priv *priv, *old_priv;
+	struct genl_sock *gsk = genl_sk(sk);
+	struct xarray *family_privs;
+
+	family_privs = genl_family_privs_get(gsk);
+	if (IS_ERR(family_privs))
+		return ERR_CAST(family_privs);
+
+	priv = xa_load(family_privs, family->id);
+	if (priv)
+		return priv->priv;
+
+	/* priv for the family does not exist so far, create it. */
+
+	priv = genl_sk_priv_alloc(family);
+	if (IS_ERR(priv))
+		return ERR_CAST(priv);
+
+	old_priv = xa_cmpxchg(family_privs, family->id, NULL, priv, GFP_KERNEL);
+	if (xa_is_err(old_priv)) {
+		genl_sk_priv_free(priv);
+		return ERR_PTR(xa_err(old_priv));
+	} else if (!old_priv) {
+		return priv->priv;
+	}
+
+	/* Race happened, priv was already inserted. */
+	genl_sk_priv_free(priv);
+	return old_priv->priv;
+}
+
 /**
  * genl_register_family - register a generic netlink family
  * @family: generic netlink family
@@ -659,6 +854,10 @@ int genl_register_family(struct genl_family *family)
 		goto errout_locked;
 	}
 
+	err = genl_sk_priv_list_alloc(family);
+	if (err)
+		goto errout_locked;
+
 	/*
 	 * Sadly, a few cases need to be special-cased
 	 * due to them having previously abused the API
@@ -679,7 +878,7 @@ int genl_register_family(struct genl_family *family)
 				      start, end + 1, GFP_KERNEL);
 	if (family->id < 0) {
 		err = family->id;
-		goto errout_locked;
+		goto errout_priv_list_free;
 	}
 
 	err = genl_validate_assign_mc_groups(family);
@@ -698,6 +897,8 @@ int genl_register_family(struct genl_family *family)
 
 errout_remove:
 	idr_remove(&genl_fam_idr, family->id);
+errout_priv_list_free:
+	genl_sk_priv_list_free(family);
 errout_locked:
 	genl_unlock_all();
 	return err;
@@ -728,6 +929,9 @@ int genl_unregister_family(const struct genl_family *family)
 	up_write(&cb_lock);
 	wait_event(genl_sk_destructing_waitq,
 		   atomic_read(&genl_sk_destructing_cnt) == 0);
+
+	genl_sk_priv_list_free(family);
+
 	genl_unlock();
 
 	genl_ctrl_event(CTRL_CMD_DELFAMILY, family, NULL, 0);
@@ -1708,6 +1912,7 @@ static int __net_init genl_pernet_init(struct net *net)
 		.input		= genl_rcv,
 		.flags		= NL_CFG_F_NONROOT_RECV,
 		.bind		= genl_bind,
+		.release	= genl_release,
 	};
 
 	/* we'll bump the group number right afterwards */
-- 
2.43.0



Return-Path: <netdev+bounces-57609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6C98139B8
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 19:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF6941F2214D
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 18:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF0B68B85;
	Thu, 14 Dec 2023 18:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="KbZQ/LM2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B4810F
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 10:16:02 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9fa2714e828so1095449766b.1
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 10:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702577761; x=1703182561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPlG74YF0WwZrmaFmliART5LqHjuLJowmw2/xWVe6hY=;
        b=KbZQ/LM2fqz75Adn/9hzevLoqHMasV5cdpqV/EmqUZSE35oQyxY3dSc5GAHVagNyXG
         RVVjpCWvSrPRhoEr+9fMgTfLYhubj2A6O3YWR1Lq2Jx6xajHVU/ForoJ5SA5BFtyprxP
         hsg+EJBCFLmv8E7SMmqBxE7W5e8EFER0JIyQoyoh0Lv0vxprNDBeMbuH4DdlxrV3j0xf
         nXLfWaa97peWysPPYyBj+zNlFmFOtmGOm76gj0pFBe21H5LC0DH/DW6Jw6ftJWhSD1Mk
         ShqO5s1bh7g+BquaqsFK2Ck1trBgKslbTdXxWenj9J4rFQDfB9NdrU79rx1OXyMQLxKn
         5MAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702577761; x=1703182561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPlG74YF0WwZrmaFmliART5LqHjuLJowmw2/xWVe6hY=;
        b=ToSOh/xMaGd2ujFTxJd57T2+uWjHYNPkTjstnebbb/ujX/Xj3v+bOuk8HW05qalRYH
         QpY4/M7yKNJUIPlDBtWGaRQARIcDit8DVtlSq6nBOVDzz/AVJ3S3ihWyKkHQy7Gr22a7
         2i6gkcz2OJCvibxH3Z5yVW6nVf0kptCz34j3nSS80r64wb+xPq3Z/okiIkT82Ge53wY9
         7rXiMEPL5LBT3eHZUvH0+tAQUiJNbaG+tsQR7MWgnc/mMaHs4kIEZkT2WkvZdEH6AGF3
         Q9kariZx/an/Xowzjw25D54jhWkeN+yBNpOgkQuaGQHwAUvqyqGjwm/A863EaJTU1V98
         oK4g==
X-Gm-Message-State: AOJu0YyBPfPrv1PGirzJ7NYSEwLxpVKzQiNpOuvu3enEwmmmZ//4EODi
	WWu/9Gm0RmHPwRHrcwl4BesbN5Z94ErSx2xRsks=
X-Google-Smtp-Source: AGHT+IFgHw29kKIyg3WnydwQNk46v5Cl1rsCihrv7ww4+En9482GuNozyasDwJFQCf7OdHKU3PSGUA==
X-Received: by 2002:a17:906:1083:b0:a19:a19b:5608 with SMTP id u3-20020a170906108300b00a19a19b5608mr5496365eju.152.1702577760849;
        Thu, 14 Dec 2023 10:16:00 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id tf13-20020a1709078d8d00b00a1b8829597fsm9673548ejc.114.2023.12.14.10.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 10:15:59 -0800 (PST)
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
Subject: [patch net-next v7 5/9] genetlink: introduce per-sock family private storage
Date: Thu, 14 Dec 2023 19:15:45 +0100
Message-ID: <20231214181549.1270696-6-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214181549.1270696-1-jiri@resnulli.us>
References: <20231214181549.1270696-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Introduce an xarray for Generic netlink family to store per-socket
private. Initialize this xarray only if family uses per-socket privs.

Introduce genl_sk_priv_get() to get the socket priv pointer for a family
and initialize it in case it does not exist.
Introduce __genl_sk_priv_get() to obtain socket priv pointer for a
family under RCU read lock.

Allow family to specify the priv size, init() and destroy() callbacks.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v6->v7:
- converted family->sock_priv_list to family->sock_privs xarray
  and use it to store the per-socket privs, use sock pointer as
  an xarrar index. This made the code much simpler
- removed no longer needed struct genl_sock and related code as the priv
  is stored in family xarray only
- removed sk_priv wrapper struct as destroy() is available through
  family pointer during priv_free() call, store void *priv directly into
  xarray
- change the genl_release() to iterate over families to free privs
- changed xa_cmpxchg() error flow in genl_sk_priv_get()
- updated __genl_sk_priv_get() and genl_sk_priv_get() function comments
  accordingly
- swapped __genl_sk_priv_get() and genl_sk_priv_get() args to better fit
  the changed lookup scheme
- updated patch description
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
 include/net/genetlink.h |  11 ++++
 net/netlink/genetlink.c | 143 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 153 insertions(+), 1 deletion(-)

diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index c53244f20437..6bc37f392a9a 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -51,6 +51,9 @@ struct genl_info;
  * @split_ops: the split do/dump form of operation definition
  * @n_split_ops: number of entries in @split_ops, not that with split do/dump
  *	ops the number of entries is not the same as number of commands
+ * @sock_priv_size: the size of per-socket private memory
+ * @sock_priv_init: the per-socket private memory initializer
+ * @sock_priv_destroy: the per-socket private memory destructor
  *
  * Attribute policies (the combination of @policy and @maxattr fields)
  * can be attached at the family level or at the operation level.
@@ -84,11 +87,17 @@ struct genl_family {
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
+	struct xarray		*sock_privs;
 };
 
 /**
@@ -298,6 +307,8 @@ static inline bool genl_info_is_ntf(const struct genl_info *info)
 	return !info->nlhdr;
 }
 
+void *__genl_sk_priv_get(struct genl_family *family, struct sock *sk);
+void *genl_sk_priv_get(struct genl_family *family, struct sock *sk);
 int genl_register_family(struct genl_family *family);
 int genl_unregister_family(const struct genl_family *family);
 void genl_notify(const struct genl_family *family, struct sk_buff *skb,
diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 9c7ffd10df2a..2747a5a47d26 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -631,6 +631,137 @@ static int genl_validate_ops(const struct genl_family *family)
 	return 0;
 }
 
+static void *genl_sk_priv_alloc(struct genl_family *family)
+{
+	void *priv;
+
+	priv = kzalloc(family->sock_priv_size, GFP_KERNEL);
+	if (!priv)
+		return ERR_PTR(-ENOMEM);
+
+	if (family->sock_priv_init)
+		family->sock_priv_init(priv);
+
+	return priv;
+}
+
+static void genl_sk_priv_free(const struct genl_family *family, void *priv)
+{
+	if (family->sock_priv_destroy)
+		family->sock_priv_destroy(priv);
+	kfree(priv);
+}
+
+static int genl_sk_privs_alloc(struct genl_family *family)
+{
+	if (!family->sock_priv_size)
+		return 0;
+
+	family->sock_privs = kzalloc(sizeof(*family->sock_privs), GFP_KERNEL);
+	if (!family->sock_privs)
+		return -ENOMEM;
+	xa_init(family->sock_privs);
+	return 0;
+}
+
+static void genl_sk_privs_free(const struct genl_family *family)
+{
+	unsigned long id;
+	void *priv;
+
+	if (!family->sock_priv_size)
+		return;
+
+	xa_for_each(family->sock_privs, id, priv)
+		genl_sk_priv_free(family, priv);
+
+	xa_destroy(family->sock_privs);
+	kfree(family->sock_privs);
+}
+
+static void genl_sk_priv_free_by_sock(struct genl_family *family,
+				      struct sock *sk)
+{
+	void *priv;
+
+	if (!family->sock_priv_size)
+		return;
+	priv = xa_erase(family->sock_privs, (unsigned long) sk);
+	if (!priv)
+		return;
+	genl_sk_priv_free(family, priv);
+}
+
+static void genl_release(struct sock *sk, unsigned long *groups)
+{
+	struct genl_family *family;
+	unsigned int id;
+
+	down_read(&cb_lock);
+
+	idr_for_each_entry(&genl_fam_idr, family, id)
+		genl_sk_priv_free_by_sock(family, sk);
+
+	up_read(&cb_lock);
+}
+
+/**
+ * __genl_sk_priv_get - Get family private pointer for socket, if exists
+ *
+ * @family: family
+ * @sk: socket
+ *
+ * Lookup a private memory for a Generic netlink family and specified socket.
+ *
+ * Caller should make sure this is called in RCU read locked section.
+ *
+ * Return: valid pointer on success, otherwise NULL.
+ */
+void *__genl_sk_priv_get(struct genl_family *family, struct sock *sk)
+{
+	if (WARN_ON_ONCE(!family->sock_privs))
+		return NULL;
+	return xa_load(family->sock_privs, (unsigned long) sk);
+}
+
+/**
+ * genl_sk_priv_get - Get family private pointer for socket
+ *
+ * @family: family
+ * @sk: socket
+ *
+ * Lookup a private memory for a Generic netlink family and specified socket.
+ * Allocate the private memory in case it was not already done.
+ *
+ * Return: valid pointer on success, otherwise negative error value
+ * encoded by ERR_PTR().
+ */
+void *genl_sk_priv_get(struct genl_family *family, struct sock *sk)
+{
+	void *priv, *old_priv;
+
+	priv = __genl_sk_priv_get(family, sk);
+	if (priv)
+		return priv;
+
+	/* priv for the family does not exist so far, create it. */
+
+	priv = genl_sk_priv_alloc(family);
+	if (IS_ERR(priv))
+		return ERR_CAST(priv);
+
+	old_priv = xa_cmpxchg(family->sock_privs, (unsigned long) sk, NULL,
+			      priv, GFP_KERNEL);
+	if (old_priv) {
+		genl_sk_priv_free(family, priv);
+		if (xa_is_err(old_priv))
+			return ERR_PTR(xa_err(old_priv));
+		/* Race happened, priv for the socket was already inserted. */
+		return old_priv;
+	}
+	return priv;
+}
+
 /**
  * genl_register_family - register a generic netlink family
  * @family: generic netlink family
@@ -659,6 +790,10 @@ int genl_register_family(struct genl_family *family)
 		goto errout_locked;
 	}
 
+	err = genl_sk_privs_alloc(family);
+	if (err)
+		goto errout_locked;
+
 	/*
 	 * Sadly, a few cases need to be special-cased
 	 * due to them having previously abused the API
@@ -679,7 +814,7 @@ int genl_register_family(struct genl_family *family)
 				      start, end + 1, GFP_KERNEL);
 	if (family->id < 0) {
 		err = family->id;
-		goto errout_locked;
+		goto errout_sk_privs_free;
 	}
 
 	err = genl_validate_assign_mc_groups(family);
@@ -698,6 +833,8 @@ int genl_register_family(struct genl_family *family)
 
 errout_remove:
 	idr_remove(&genl_fam_idr, family->id);
+errout_sk_privs_free:
+	genl_sk_privs_free(family);
 errout_locked:
 	genl_unlock_all();
 	return err;
@@ -728,6 +865,9 @@ int genl_unregister_family(const struct genl_family *family)
 	up_write(&cb_lock);
 	wait_event(genl_sk_destructing_waitq,
 		   atomic_read(&genl_sk_destructing_cnt) == 0);
+
+	genl_sk_privs_free(family);
+
 	genl_unlock();
 
 	genl_ctrl_event(CTRL_CMD_DELFAMILY, family, NULL, 0);
@@ -1708,6 +1848,7 @@ static int __net_init genl_pernet_init(struct net *net)
 		.input		= genl_rcv,
 		.flags		= NL_CFG_F_NONROOT_RECV,
 		.bind		= genl_bind,
+		.release	= genl_release,
 	};
 
 	/* we'll bump the group number right afterwards */
-- 
2.43.0



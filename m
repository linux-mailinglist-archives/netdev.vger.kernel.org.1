Return-Path: <netdev+bounces-58223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B3C8158FF
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 13:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C88B1C21745
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 12:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9D91D6A6;
	Sat, 16 Dec 2023 12:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="btmQQ4/u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869BD13B148
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-54c5d041c23so1630839a12.2
        for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 04:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702729812; x=1703334612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEaGRBLDuy8PazYC/YEpwSnUTDzBI+1qMZR7UgDTFjE=;
        b=btmQQ4/ukM/k7bCVYiQwWfhlwMgQF8pCGKEX+UcKoAL1TtEyFkQKtzPv8K16VaKtX1
         BCsw4KyFDJllH44+AmRdIQ8jrLT7IWnFmxETYPG0tF0zDPvpXo56Swtrd/H7llwgP3Pd
         c9wt5zEhEmkSmC+HCZaQooDRptjivMM6FSL52Z0MBCDXBuBvFjhEfSGd9BQJ9Xjflnct
         P5pFT8PhOA1b+cWGPu72rtEla8JAon/PAyrOmcodfLQ16676ElVySNzzQfFwe/fdEwhU
         O1vdQPzcXNEjS3dGJicXAwcahlK7RiJYBz4vVEjDZV661dyplxT1VMxGr8VNZoOlFDQj
         lwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702729812; x=1703334612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MEaGRBLDuy8PazYC/YEpwSnUTDzBI+1qMZR7UgDTFjE=;
        b=tfTjX1Fijgug6EFrrktzECQT4TViHoT7w+jEF9Bo8Fr79IPMhw3bFEpkBD0KdxX8pj
         /LEEKznoBdwSeNCn97yzK+2tcjCRIAoVtY7wz2zeIjxSxpu5q2KER4iHQR26PqY7R3NB
         oq6Duprcj4k8mysfcOTwHF37xDLEmOvnPzed6uVMuYP0T5tNcH10Kb/f45qunxmkXNo7
         Mxetjr25qXNOojZ0qtQA8WQVlIreWTIOWkJ1+9WHeYPzqCI6X1ksWgD7WCggGs831JGv
         1TZG0Y1QwqIJ4ykg+DTP6hGyM4nCt/flJ8QqGstyzJq9asXho41jkS91M/RZ3HXgDZjF
         tqwQ==
X-Gm-Message-State: AOJu0YyqWZPqmnpBurCo2Pfr/fsncYlfp8N05uQgIGOftpoaXa97pMTS
	tu2HNnbedJIeFvZLqjQQSb9POvlniIfe9awQ3YA=
X-Google-Smtp-Source: AGHT+IEE2guXWrtaz3/TFwP0U5x5LgSannjZI/KSvxyA6b41EF5Vd/kcgkWUx9b4XsmEHM8JCtPz8w==
X-Received: by 2002:a50:cc0b:0:b0:550:4c6f:7ba9 with SMTP id m11-20020a50cc0b000000b005504c6f7ba9mr3343982edi.102.1702729811663;
        Sat, 16 Dec 2023 04:30:11 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id cu3-20020a170906ba8300b00a1d818ebcadsm12007427ejd.19.2023.12.16.04.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 04:30:11 -0800 (PST)
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
Subject: [patch net-next v8 5/9] genetlink: introduce per-sock family private storage
Date: Sat, 16 Dec 2023 13:29:57 +0100
Message-ID: <20231216123001.1293639-6-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231216123001.1293639-1-jiri@resnulli.us>
References: <20231216123001.1293639-1-jiri@resnulli.us>
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
v7->v8:
- changed __genl_sk_priv_get() to return ERR_PTR() encoded pointer
  in case of a family bug
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
 include/net/genetlink.h |  11 +++
 net/netlink/genetlink.c | 144 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 154 insertions(+), 1 deletion(-)

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
index 9c7ffd10df2a..c0d15470a10b 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -631,6 +631,138 @@ static int genl_validate_ops(const struct genl_family *family)
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
+ * Return: valid pointer on success, otherwise negative error value
+ * encoded by ERR_PTR(), NULL in case priv does not exist.
+ */
+void *__genl_sk_priv_get(struct genl_family *family, struct sock *sk)
+{
+	if (WARN_ON_ONCE(!family->sock_privs))
+		return ERR_PTR(-EINVAL);
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
@@ -659,6 +791,10 @@ int genl_register_family(struct genl_family *family)
 		goto errout_locked;
 	}
 
+	err = genl_sk_privs_alloc(family);
+	if (err)
+		goto errout_locked;
+
 	/*
 	 * Sadly, a few cases need to be special-cased
 	 * due to them having previously abused the API
@@ -679,7 +815,7 @@ int genl_register_family(struct genl_family *family)
 				      start, end + 1, GFP_KERNEL);
 	if (family->id < 0) {
 		err = family->id;
-		goto errout_locked;
+		goto errout_sk_privs_free;
 	}
 
 	err = genl_validate_assign_mc_groups(family);
@@ -698,6 +834,8 @@ int genl_register_family(struct genl_family *family)
 
 errout_remove:
 	idr_remove(&genl_fam_idr, family->id);
+errout_sk_privs_free:
+	genl_sk_privs_free(family);
 errout_locked:
 	genl_unlock_all();
 	return err;
@@ -728,6 +866,9 @@ int genl_unregister_family(const struct genl_family *family)
 	up_write(&cb_lock);
 	wait_event(genl_sk_destructing_waitq,
 		   atomic_read(&genl_sk_destructing_cnt) == 0);
+
+	genl_sk_privs_free(family);
+
 	genl_unlock();
 
 	genl_ctrl_event(CTRL_CMD_DELFAMILY, family, NULL, 0);
@@ -1708,6 +1849,7 @@ static int __net_init genl_pernet_init(struct net *net)
 		.input		= genl_rcv,
 		.flags		= NL_CFG_F_NONROOT_RECV,
 		.bind		= genl_bind,
+		.release	= genl_release,
 	};
 
 	/* we'll bump the group number right afterwards */
-- 
2.43.0



Return-Path: <netdev+bounces-54569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4225280777B
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 19:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B2371C20F05
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 18:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EE06F63C;
	Wed,  6 Dec 2023 18:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="MCG4//m/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BBE18D
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 10:21:33 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54cde11d0f4so105004a12.2
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 10:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701886891; x=1702491691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8eRZcUioOUuE0TTLNday3/b0ppj4X7HB0QVPAfV+1E=;
        b=MCG4//m//B92j3GaGFj32o+9zr3T3LpiPKA2y2pSICwfZbzSnvRNFcO6fg6GhYBajs
         t8eEANfPjxShMqiAmLrtE/od0fwz/3QtdoPPFBgvR3Q8C6HLlAKk9AlR1OLNMmwgwSkH
         0JsF2M8MfBWt1+D60Qe0fyFnTXEgKPPhvPDR4Xqv8aXIo/ztLyQZrdv2TqZtnVayD1aR
         8Vozu/iddBjEzR9Nq1SArKggEC6opYmSnIHzOpu3dMBxjVCpANJxiUGulsL7KARceoY7
         g/cGLTeehWpZzWuJVbq0PPczPOR97Rm5qVNxTFatb9B8OfA72kbMWJKPBAJY7LK8tERq
         IKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701886891; x=1702491691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8eRZcUioOUuE0TTLNday3/b0ppj4X7HB0QVPAfV+1E=;
        b=JTJRuNJExBB978mh+9DtbYlm9lt3deqi9dgahwfIC5zHoeYgmPVWjLq4hSM9sWIFuR
         P8gGgdR9J6Kk6eNLFt6iZxZ/9+vBVX3liOTwn3sEvdiiq/Wcns/Jdb+7ueMntQ0ZwFJb
         RpApPashnmWMXC0bSOoBFfHcbK02UClsLzbl/IEzL1inOZF/Su5emsforlbWH2pSXCse
         AJv0N9uRZjONkd8+TQBubifmWjD87IgYyNkDGh76orkuxswyjadBPdBvL+od5CDVlrga
         uSK1h0NidInhX+8rnDtu5cd24QnC6ftiMiKpqpwmjlaT6KtF2ATyw3TACFhOCexXVjO9
         wm6w==
X-Gm-Message-State: AOJu0Yz4h4Bo1nGR+bz5RQiZkCqUX6OK5ga8R5OmSQHJ3RP+acWqaMqI
	a54Ayg4UI80HnXSE78M/GnJ3uzKIIEsIOmbxw1Y=
X-Google-Smtp-Source: AGHT+IH3dR6Pjq3GKO6Rr1LDIMManT4l1jkVSh3Zc94ZvK25bUaEx9NsjklY6D7fxHk7owUJqCSWRQ==
X-Received: by 2002:a17:906:6cf:b0:a1d:2739:7776 with SMTP id v15-20020a17090606cf00b00a1d27397776mr893958ejb.12.1701886891746;
        Wed, 06 Dec 2023 10:21:31 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id e3-20020a1709062c0300b00a1c99f67834sm259349ejh.70.2023.12.06.10.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 10:21:31 -0800 (PST)
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
Subject: [patch net-next v5 5/9] genetlink: introduce per-sock family private storage
Date: Wed,  6 Dec 2023 19:21:16 +0100
Message-ID: <20231206182120.957225-6-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231206182120.957225-1-jiri@resnulli.us>
References: <20231206182120.957225-1-jiri@resnulli.us>
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
v4->v5:
- s/Returns/Return/ in function comments
- introduced wrapper genl sock struct and store xarray there
- changed family helpers to genl_sk_priv_get() and __genl_sk_priv_get()
- introduced sock_priv_size for family and use this to allocate the priv
  in generic netlink code
- introduced init/destroy callbacks for family privs
v3->v4:
- new patch
---
 include/net/genetlink.h  |   6 ++
 net/netlink/af_netlink.c |   2 +-
 net/netlink/af_netlink.h |  15 ++++
 net/netlink/genetlink.c  | 146 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 168 insertions(+), 1 deletion(-)

diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index e18a4c0d69ee..dbf11464e96a 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -87,6 +87,9 @@ struct genl_family {
 	int			id;
 	/* starting number of multicast group IDs in this family */
 	unsigned int		mcgrp_offset;
+	size_t			sock_priv_size;
+	void			(*sock_priv_init)(void *priv);
+	void			(*sock_priv_destroy)(void *priv);
 };
 
 /**
@@ -301,6 +304,9 @@ int genl_unregister_family(const struct genl_family *family);
 void genl_notify(const struct genl_family *family, struct sk_buff *skb,
 		 struct genl_info *info, u32 group, gfp_t flags);
 
+void *__genl_sk_priv_get(struct sock *sk, struct genl_family *family);
+void *genl_sk_priv_get(struct sock *sk, struct genl_family *family);
+
 void *genlmsg_put(struct sk_buff *skb, u32 portid, u32 seq,
 		  const struct genl_family *family, int flags, u8 cmd);
 
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
index 2145979b9986..1b3ed8919574 100644
--- a/net/netlink/af_netlink.h
+++ b/net/netlink/af_netlink.h
@@ -60,6 +60,21 @@ static inline struct netlink_sock *nlk_sk(struct sock *sk)
 
 #define nlk_test_bit(nr, sk) test_bit(NETLINK_F_##nr, &nlk_sk(sk)->flags)
 
+struct genl_sock {
+	struct netlink_sock nlk_sk;
+	struct xarray *family_privs;
+};
+
+static inline struct genl_sock *genl_sk(struct sock *sk)
+{
+	return container_of(nlk_sk(sk), struct genl_sock, nlk_sk);
+}
+
+/* Size of netlink sock is size of the biggest user with priv,
+ * which is currently just Generic Netlink.
+ */
+#define NETLINK_SOCK_SIZE sizeof(struct genl_sock)
+
 struct netlink_table {
 	struct rhashtable	hash;
 	struct hlist_head	mc_list;
diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 92ef5ed2e7b0..51720c2c6bda 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -22,6 +22,8 @@
 #include <net/sock.h>
 #include <net/genetlink.h>
 
+#include "af_netlink.h"
+
 static DEFINE_MUTEX(genl_mutex); /* serialization of message processing */
 static DECLARE_RWSEM(cb_lock);
 
@@ -1699,12 +1701,156 @@ static int genl_bind(struct net *net, int group)
 	return ret;
 }
 
+struct genl_sk_priv {
+	void (*destructor)(void *priv);
+	long priv[];
+};
+
+static struct genl_sk_priv *genl_sk_priv_alloc(struct genl_family *family)
+{
+	struct genl_sk_priv *priv;
+
+	priv = kzalloc(size_add(sizeof(*priv), family->sock_priv_size),
+		       GFP_KERNEL);
+	if (!priv)
+		return ERR_PTR(-ENOMEM);
+	priv->destructor = family->sock_priv_destroy;
+	if (family->sock_priv_init)
+		family->sock_priv_init(priv->priv);
+	return priv;
+}
+
+static void genl_sk_priv_free(struct genl_sk_priv *priv)
+{
+	if (priv->destructor)
+		priv->destructor(priv->priv);
+	kfree(priv);
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
+again:
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
+		xa_destroy(family_privs);
+		kfree(family_privs);
+		genl_unlock();
+		goto again;
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
+	if (xa_is_err(old_priv))
+		return ERR_PTR(xa_err(old_priv));
+	else if (!old_priv)
+		return priv->priv;
+
+	/* Race happened, priv was already inserted. */
+	genl_sk_priv_free(priv);
+	return old_priv->priv;
+}
+
 static int __net_init genl_pernet_init(struct net *net)
 {
 	struct netlink_kernel_cfg cfg = {
 		.input		= genl_rcv,
 		.flags		= NL_CFG_F_NONROOT_RECV,
 		.bind		= genl_bind,
+		.release	= genl_release,
 	};
 
 	/* we'll bump the group number right afterwards */
-- 
2.41.0



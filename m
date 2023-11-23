Return-Path: <netdev+bounces-50634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAEA7F660F
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 19:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03C09281BC7
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 18:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9CF4C3D8;
	Thu, 23 Nov 2023 18:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="X/SF3aNF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B254018B
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 10:15:57 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a02ba1f500fso169021966b.0
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 10:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700763356; x=1701368156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mwwy3+g0/2vUJo5CWrvXTd3PHNIA9OhF9t50ZvzUSNU=;
        b=X/SF3aNFyVTIqC+pmzXtYT8HOR0UQ/Xd6riJ5M5tqosqHfLRAdc5DR9ESY8t1Syn1F
         yO59uTGD0OvbQ7OxYfH2MRyCsIvuJYnox9VTtPreqIzpSuUHMcVvvDrdd3TR1T2AZcEL
         uRfJQdOAIO/QKphMUd4tMFJWECvfV97q3S8KwV0KGlszcEylh3q+r/VVCU0YTevxx7Ej
         PEAtdZ94RVoSAdMkamBKh38PsACw5ZAJTe1N0xF+gM52Rttch2Ybm9+Iq7n/OeTqHhbx
         CX/LZUfENE59NVcyf0tCHZwd1Ih5BYPdqZQYmIqrzkaSuraGQtiH/nUYAwElr38iAYk4
         JUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700763356; x=1701368156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mwwy3+g0/2vUJo5CWrvXTd3PHNIA9OhF9t50ZvzUSNU=;
        b=XwwgNO9qXuyblVUNCe4XJeUPwk848EKMraYFFs/YgZ1URMiPVjLEP/QE6gofTAEOqK
         Ww5pBdbtHoewIX/LO2COR2kKrB6jqBeWi6/XhWtkja0p5gNb4SbKMa/zka333LSjF7Og
         tS91yJBFPXtqB6xcATEfy6RHNEaEg2iTozpDzGtTpb/a8Jk7nDCITYhVZ9tJo+14RRoU
         DDQ+nE1a/pL6qpE1TTcwNpp2VXT3G1TVM++dDHGx/vIaI2N+gWIVSJtCoeVCCHEWPYNT
         1jktp2hxlDnOvNO7dAJNIg4psE1FefdY5UnBIkbWUc4lh6cUqXdV3jDrffAEBkVsUjDL
         WZvw==
X-Gm-Message-State: AOJu0YwseOzZ3VWvQYky/OMR3v1nQlntE3DKQJcVxUyR8m+p2+0MpaBN
	3HsDY6ncyazNQnQ1xJVYY5NhmtTW7VtIW0cuyZM=
X-Google-Smtp-Source: AGHT+IEO/sV/u7A6u53y0ur8lxUWuHEWJ9X2YtGpGlbUM78NrGoyYLvLYcJ31WwDjKH23Goz3YDuDw==
X-Received: by 2002:a17:906:de:b0:a00:35d9:eb0 with SMTP id 30-20020a17090600de00b00a0035d90eb0mr94194eji.1.1700763355998;
        Thu, 23 Nov 2023 10:15:55 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id t24-20020a17090616d800b009ffb4af0505sm1065515ejd.104.2023.11.23.10.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 10:15:55 -0800 (PST)
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
	horms@kernel.org
Subject: [patch net-next v4 5/9] genetlink: introduce per-sock family private pointer storage
Date: Thu, 23 Nov 2023 19:15:42 +0100
Message-ID: <20231123181546.521488-6-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123181546.521488-1-jiri@resnulli.us>
References: <20231123181546.521488-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Introduce a priv pointer into struct netlink_sock. Use it to store a per
socket xarray that contains family->id indexed priv pointer storage.
Note I used xarray instead of suggested linked list as it is more
convenient, without need to have a container struct that would
contain struct list_head item.

Introduce genl_sk_priv_store() to store the priv pointer.
Introduce genl_sk_priv_get() to obtain the priv pointer under RCU
read lock.

Assume that kfree() is good for free of privs for now, as the only user
introduced by the follow-up patch (devlink) will use kzalloc() for the
allocation of the memory of the stored pointer. If later on
this needs to be made custom, a callback is going to be needed.
Until then (if ever), do this in a simple way.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v3->v4:
- new patch
---
 include/net/genetlink.h  |  3 ++
 net/netlink/af_netlink.h |  1 +
 net/netlink/genetlink.c  | 98 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+)

diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index e18a4c0d69ee..66c1e50415e0 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -300,6 +300,9 @@ int genl_register_family(struct genl_family *family);
 int genl_unregister_family(const struct genl_family *family);
 void genl_notify(const struct genl_family *family, struct sk_buff *skb,
 		 struct genl_info *info, u32 group, gfp_t flags);
+void *genl_sk_priv_get(struct sock *sk, struct genl_family *family);
+void *genl_sk_priv_store(struct sock *sk, struct genl_family *family,
+			 void *priv);
 
 void *genlmsg_put(struct sk_buff *skb, u32 portid, u32 seq,
 		  const struct genl_family *family, int flags, u8 cmd);
diff --git a/net/netlink/af_netlink.h b/net/netlink/af_netlink.h
index 2145979b9986..5d96135a4cf3 100644
--- a/net/netlink/af_netlink.h
+++ b/net/netlink/af_netlink.h
@@ -51,6 +51,7 @@ struct netlink_sock {
 	struct rhash_head	node;
 	struct rcu_head		rcu;
 	struct work_struct	work;
+	void __rcu		*priv;
 };
 
 static inline struct netlink_sock *nlk_sk(struct sock *sk)
diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 92ef5ed2e7b0..aae5e63fa50b 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -21,6 +21,7 @@
 #include <linux/idr.h>
 #include <net/sock.h>
 #include <net/genetlink.h>
+#include "af_netlink.h"
 
 static DEFINE_MUTEX(genl_mutex); /* serialization of message processing */
 static DECLARE_RWSEM(cb_lock);
@@ -1699,12 +1700,109 @@ static int genl_bind(struct net *net, int group)
 	return ret;
 }
 
+struct genl_sk_ctx {
+	struct xarray family_privs;
+};
+
+static struct genl_sk_ctx *genl_sk_ctx_alloc(void)
+{
+	struct genl_sk_ctx *ctx;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return NULL;
+	xa_init_flags(&ctx->family_privs, XA_FLAGS_ALLOC);
+	return ctx;
+}
+
+static void genl_sk_ctx_free(struct genl_sk_ctx *ctx)
+{
+	unsigned long family_id;
+	void *priv;
+
+	xa_for_each(&ctx->family_privs, family_id, priv) {
+		xa_erase(&ctx->family_privs, family_id);
+		kfree(priv);
+	}
+	xa_destroy(&ctx->family_privs);
+	kfree(ctx);
+}
+
+/**
+ * genl_sk_priv_get - Get per-socket private pointer for family
+ *
+ * @sk: socket
+ * @family: family
+ *
+ * Lookup a private pointer stored per-socket by a specified
+ * Generic netlink family.
+ *
+ * Caller should make sure this is called in RCU read locked section.
+ *
+ * Returns: valid pointer on success, otherwise NULL.
+ */
+void *genl_sk_priv_get(struct sock *sk, struct genl_family *family)
+{
+	struct genl_sk_ctx *ctx;
+
+	ctx = rcu_dereference(nlk_sk(sk)->priv);
+	if (!ctx)
+		return NULL;
+	return xa_load(&ctx->family_privs, family->id);
+}
+
+/**
+ * genl_sk_priv_store - Store per-socket private pointer for family
+ *
+ * @sk: socket
+ * @family: family
+ * @priv: private pointer
+ *
+ * Store a private pointer per-socket for a specified
+ * Generic netlink family.
+ *
+ * Caller has to make sure this is not called in parallel multiple times
+ * for the same sock and also in parallel to genl_release() for the same sock.
+ *
+ * Returns: previously stored private pointer for the family (could be NULL)
+ * on success, otherwise negative error value encoded by ERR_PTR().
+ */
+void *genl_sk_priv_store(struct sock *sk, struct genl_family *family,
+			 void *priv)
+{
+	struct genl_sk_ctx *ctx;
+	void *old_priv;
+
+	ctx = rcu_dereference_raw(nlk_sk(sk)->priv);
+	if (!ctx) {
+		ctx = genl_sk_ctx_alloc();
+		if (!ctx)
+			return ERR_PTR(-ENOMEM);
+		rcu_assign_pointer(nlk_sk(sk)->priv, ctx);
+	}
+
+	old_priv = xa_store(&ctx->family_privs, family->id, priv, GFP_KERNEL);
+	if (xa_is_err(old_priv))
+		return ERR_PTR(xa_err(old_priv));
+	return old_priv;
+}
+
+static void genl_release(struct sock *sk, unsigned long *groups)
+{
+	struct genl_sk_ctx *ctx;
+
+	ctx = rcu_dereference_raw(nlk_sk(sk)->priv);
+	if (ctx)
+		genl_sk_ctx_free(ctx);
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



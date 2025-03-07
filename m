Return-Path: <netdev+bounces-172996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26451A56CCC
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 16:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C99E1786DF
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 15:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CA122155C;
	Fri,  7 Mar 2025 15:57:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F6F21D3E8;
	Fri,  7 Mar 2025 15:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363050; cv=none; b=Fb3zA6CGmeIS+66ou3e4TNNBC+q+r66zSSVqJT4edR62Fvr4Ct+EcTP7zqDK9UZjwqw34vBWX94jfXfNP0JqvBelyK+XzddE/IUrqiUnMJuljgV8JifxH+4O7+6j761sJMJBCdDJbAyGuvAJoubcD0BEllAiWMCyeVwvV8mRBz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363050; c=relaxed/simple;
	bh=qju+Hmli1ujUwi/eHfGIMx2HJZ38f7cehV6nsoGzrPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNzmvLqzQMeTvA0K34J6a1ZGQ6362SzQ7nvNAe4TYULDvlN1tpXqOwmTax8lmDbKsJ2Z8OdITB83vybNYnnD9WsJf9U62fXhdhuue/ZAZOBd0YIL1wIWte6KDhsLp1V6hTHCydy4Irs8CnUeOKRTMRRKdPAB+lThwkw9Qc3IUHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22359001f1aso51236105ad.3;
        Fri, 07 Mar 2025 07:57:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741363047; x=1741967847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVxQV/o7jQOh5fqVSpMsD4HSovMAgVf5MADEYdzA/sg=;
        b=lggxoZPQKIf6nm2fsSVyOChnMiOXhYjKGP1BoJi3RVGFOrqqf9ev8lO7epNbgZjjv3
         k8CeHId2Ve+Wo/CDcpB44AaHX3eiaKWmhgi9nuYlSsS4DLYIrsGVRAlAk2OKBkN5bFLa
         dO6tWg+vV3o+65DzzBhpoRDfmHm8ZQxSj09JDWWYid9KyETr/oZeq3ahb0hSIbgJgDdj
         IjuDDJmFt/1Pc9xcIIO93YbmZCLKvbbZa/g7zvVQvrCMqDBqG1fbWDB11CknJ9IkJ/Cy
         s9TgYbL/9xOTCGnBAhXMaxbpfkCnmfZ0hdbi4cTZiyC4nY1GUAw79Xx90NhLCkYz4Up5
         HdBg==
X-Forwarded-Encrypted: i=1; AJvYcCXEo6TJVmFEIKO+XMv7MIVxS57C51k33L1dU1CHesy2y52avdvphze8kNG7Vbj+gpW+Yoy75Mz988JL8RI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQkKJBC7eOoJIJCJlk1mPE2ojGFpJ2oebzFv8OvZzp0n9FMmLT
	7wIyNV+1f5WgykrPUIo+MSHjZrzzMSFH+WnKu4PZZgeyQ6sGXDGe4gCf
X-Gm-Gg: ASbGncs0H0y8UIgSDIVhhlXEVLi4BsN9wmFBAbhb144PHH5JAuXDgqNbgna9ZCEnOp2
	ICd0Gkbm+kwDCrd9iA2k71xcoKILqVuAwn9l5HP3aqEjgag5u0YpNY2qbZCgCc0K3FIL7UkS3bX
	pdc3x+Dq2rhTnsZiSFRdG1fJU9rVXIMnDY/lDWTokEsWhVFLBYDJwY3VYnb5Kpkh+lajA2X8ATI
	kOP2/bMxCfAkfFY0zxHM4/HVSf9DE/bFzLI1SPPvIvsFKzdVPqgwMkT0YuIlznbD/yoAKxshhc2
	lgJlWTgARWUQBTiaoKppzs4xdV7aFwy+rzR6LR3geaCi
X-Google-Smtp-Source: AGHT+IEuQhykDNqkZGL2g86S4EFJk8gdinVKZb1LKs3IA6FYGr29hXd6nnPoQT+BI7iTYA8Lwi9Veg==
X-Received: by 2002:a05:6a00:b51:b0:736:6043:69f9 with SMTP id d2e1a72fcca58-736aaadf584mr5762887b3a.19.1741363047536;
        Fri, 07 Mar 2025 07:57:27 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73698538829sm3505998b3a.174.2025.03.07.07.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:57:27 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	donald.hunter@gmail.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	andrew+netdev@lunn.ch,
	jdamato@fastly.com,
	sdf@fomichev.me,
	xuanzhuo@linux.alibaba.com,
	almasrymina@google.com,
	asml.silence@gmail.com,
	dw@davidwei.uk
Subject: [PATCH net-next v1 1/4] net: create netdev_nl_sock to wrap bindings list
Date: Fri,  7 Mar 2025 07:57:22 -0800
Message-ID: <20250307155725.219009-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307155725.219009-1-sdf@fomichev.me>
References: <20250307155725.219009-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional changes. Next patches will add more granular locking
to netdev_nl_sock.

Cc: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 Documentation/netlink/specs/netdev.yaml |  4 ++--
 include/net/netdev_netlink.h            | 11 +++++++++++
 net/core/netdev-genl-gen.c              |  4 ++--
 net/core/netdev-genl-gen.h              |  6 +++---
 net/core/netdev-genl.c                  | 19 +++++++++----------
 5 files changed, 27 insertions(+), 17 deletions(-)
 create mode 100644 include/net/netdev_netlink.h

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 36f1152bfac3..f5e0750ab71d 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -745,8 +745,8 @@ name: netdev
             - irq-suspend-timeout
 
 kernel-family:
-  headers: [ "linux/list.h"]
-  sock-priv: struct list_head
+  headers: [ "net/netdev_netlink.h"]
+  sock-priv: struct netdev_nl_sock
 
 mcast-groups:
   list:
diff --git a/include/net/netdev_netlink.h b/include/net/netdev_netlink.h
new file mode 100644
index 000000000000..1599573d35c9
--- /dev/null
+++ b/include/net/netdev_netlink.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __NET_NETDEV_NETLINK_H
+#define __NET_NETDEV_NETLINK_H
+
+#include <linux/list.h>
+
+struct netdev_nl_sock {
+	struct list_head bindings;
+};
+
+#endif	/* __NET_NETDEV_NETLINK_H */
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index 996ac6a449eb..739f7b6506a6 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -9,7 +9,7 @@
 #include "netdev-genl-gen.h"
 
 #include <uapi/linux/netdev.h>
-#include <linux/list.h>
+#include <net/netdev_netlink.h>
 
 /* Integer value ranges */
 static const struct netlink_range_validation netdev_a_page_pool_id_range = {
@@ -217,7 +217,7 @@ struct genl_family netdev_nl_family __ro_after_init = {
 	.n_split_ops	= ARRAY_SIZE(netdev_nl_ops),
 	.mcgrps		= netdev_nl_mcgrps,
 	.n_mcgrps	= ARRAY_SIZE(netdev_nl_mcgrps),
-	.sock_priv_size	= sizeof(struct list_head),
+	.sock_priv_size	= sizeof(struct netdev_nl_sock),
 	.sock_priv_init	= __netdev_nl_sock_priv_init,
 	.sock_priv_destroy = __netdev_nl_sock_priv_destroy,
 };
diff --git a/net/core/netdev-genl-gen.h b/net/core/netdev-genl-gen.h
index e09dd7539ff2..17d39fd64c94 100644
--- a/net/core/netdev-genl-gen.h
+++ b/net/core/netdev-genl-gen.h
@@ -10,7 +10,7 @@
 #include <net/genetlink.h>
 
 #include <uapi/linux/netdev.h>
-#include <linux/list.h>
+#include <net/netdev_netlink.h>
 
 /* Common nested types */
 extern const struct nla_policy netdev_page_pool_info_nl_policy[NETDEV_A_PAGE_POOL_IFINDEX + 1];
@@ -42,7 +42,7 @@ enum {
 
 extern struct genl_family netdev_nl_family;
 
-void netdev_nl_sock_priv_init(struct list_head *priv);
-void netdev_nl_sock_priv_destroy(struct list_head *priv);
+void netdev_nl_sock_priv_init(struct netdev_nl_sock *priv);
+void netdev_nl_sock_priv_destroy(struct netdev_nl_sock *priv);
 
 #endif /* _LINUX_NETDEV_GEN_H */
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 2b774183d31c..a219be90c739 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -829,8 +829,8 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *tb[ARRAY_SIZE(netdev_queue_id_nl_policy)];
 	struct net_devmem_dmabuf_binding *binding;
-	struct list_head *sock_binding_list;
 	u32 ifindex, dmabuf_fd, rxq_idx;
+	struct netdev_nl_sock *priv;
 	struct net_device *netdev;
 	struct sk_buff *rsp;
 	struct nlattr *attr;
@@ -845,10 +845,9 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 	ifindex = nla_get_u32(info->attrs[NETDEV_A_DEV_IFINDEX]);
 	dmabuf_fd = nla_get_u32(info->attrs[NETDEV_A_DMABUF_FD]);
 
-	sock_binding_list = genl_sk_priv_get(&netdev_nl_family,
-					     NETLINK_CB(skb).sk);
-	if (IS_ERR(sock_binding_list))
-		return PTR_ERR(sock_binding_list);
+	priv = genl_sk_priv_get(&netdev_nl_family, NETLINK_CB(skb).sk);
+	if (IS_ERR(priv))
+		return PTR_ERR(priv);
 
 	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!rsp)
@@ -909,7 +908,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 			goto err_unbind;
 	}
 
-	list_add(&binding->list, sock_binding_list);
+	list_add(&binding->list, &priv->bindings);
 
 	nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id);
 	genlmsg_end(rsp, hdr);
@@ -931,17 +930,17 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
-void netdev_nl_sock_priv_init(struct list_head *priv)
+void netdev_nl_sock_priv_init(struct netdev_nl_sock *priv)
 {
-	INIT_LIST_HEAD(priv);
+	INIT_LIST_HEAD(&priv->bindings);
 }
 
-void netdev_nl_sock_priv_destroy(struct list_head *priv)
+void netdev_nl_sock_priv_destroy(struct netdev_nl_sock *priv)
 {
 	struct net_devmem_dmabuf_binding *binding;
 	struct net_devmem_dmabuf_binding *temp;
 
-	list_for_each_entry_safe(binding, temp, priv, list) {
+	list_for_each_entry_safe(binding, temp, &priv->bindings, list) {
 		rtnl_lock();
 		net_devmem_unbind_dmabuf(binding);
 		rtnl_unlock();
-- 
2.48.1



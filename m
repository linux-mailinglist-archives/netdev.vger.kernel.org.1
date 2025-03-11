Return-Path: <netdev+bounces-173931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8DDA5C40E
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 15:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD0FC3A5170
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 14:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107C825CC6C;
	Tue, 11 Mar 2025 14:40:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630BD25BABA;
	Tue, 11 Mar 2025 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741704032; cv=none; b=ZteE25YgyxB2V0HHs1pOOY6+vxXk2nOn4a6BmxQJy7hRwgfs4cIAbjrfz5/7qvkMFB5qy5JhjBAgJSOZx0CT5IJ9sAc77K3ATw8jMFMzOSKS7F0eIwELa2Fr3g1rgd7d75CXpFiZ3b8YT/KLclf+jyb3UCAC0Aqvo2acLfSEdek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741704032; c=relaxed/simple;
	bh=qju+Hmli1ujUwi/eHfGIMx2HJZ38f7cehV6nsoGzrPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gp7nSBsaLBdPxST51rzdSM5b5igghT1GjDfO2RVw0V6lH3mTP8llI/G/i0gNT7sbYzasl+A+qt6XZcJaceGe1J6MyQKlATUVYJcrj/qse6lJMJPKymszUfHSrkic4HGiHWmLXiox6jDCmLjXIveUJcxPyNZUGCn78RJ12ZnO4fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-225477548e1so57045525ad.0;
        Tue, 11 Mar 2025 07:40:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741704029; x=1742308829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVxQV/o7jQOh5fqVSpMsD4HSovMAgVf5MADEYdzA/sg=;
        b=QZKpZI0HzBGXSNxxcfDqRMz7JpEhKj3++EpPFF5kGb7/goMAZH2tE5MXp0gh5vqXku
         D2fDgNYJl++12kSiwZk65b+0ZDAPWPcXyloTkH33vj3M8x+jAfPa2PO3Ad0L2bZTP+UA
         Z9/lw2WUCI+5zfbDaOXeqc+sVRqBDqdw9T55NaK+a/YQlburGpdml9GAj0MtqowanwKt
         3ausujlnt6hUuICetqwbKQnDHpuU8xiuYcXQ0ve85OAoAsEFp1ImrRLWunji9S8l/3e6
         GInW7FRlW1jlb+s9p7gqYydWPdLNcXwh8JxnwjRFqKKPioUFCV5ukaw3UQ75VnQhhA+H
         OnaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/ZbxqqgHhIGexqYiMHiSEvvDiK9sSkw57wqFNORpreh6QaMSoUKeuQzmczTiTf0EiSp3GJvH1bxsqhXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV9OQPBe3GY41C+Wb5TrIDF+5iRMkY+rR+E/TxQkh+MkspuR5Z
	CinitQNjJ0cQf4XtlapKmzOXdTOE8iA2vdXGKjKK+sZmHqiyS5niFPnUjBq8AQ==
X-Gm-Gg: ASbGncv+MebMRLeBr/+gs1qE8SXBzxucmslIw+QYg6yfNSJnrxhQupAHr8OQW4KBhkg
	gX8UBGsqD0MxiMJwPW2ayJBtIVSzObE4DqHjDZrq0UFn7QtXtR745sOw/xLL+a1ndFvT5EW6Iu0
	gW8dh4GZ8fhA6/C0eeY9p2R9uTIFEJ6BZxi2FaGJUFuzZhviP0YcAXxu6M8IE1jHGMIQPsdJoAH
	SYZuyE48Zb1r9RnrgP4/dh597bIhiFVcpbRnWLF3Q8ysVfiovAmTQc8zztQHt17FhZKT51SMFFu
	EcQtvOVTZPbX0t12BteMoabBY3Y37aUjKFTrboWwI7hA
X-Google-Smtp-Source: AGHT+IHaX2qbjIYUcszsoL1Qc/4/MkKcnuQcIMzCiKWztuO4F1U3trDrX/2LGOUFG0REstFQON234A==
X-Received: by 2002:a17:902:ef4e:b0:223:5c33:56a2 with SMTP id d9443c01a7336-22428aa2fdemr334764975ad.28.1741704029395;
        Tue, 11 Mar 2025 07:40:29 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-224109e99dfsm98585225ad.91.2025.03.11.07.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 07:40:28 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	donald.hunter@gmail.com,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	andrew+netdev@lunn.ch,
	jdamato@fastly.com,
	xuanzhuo@linux.alibaba.com,
	sdf@fomichev.me,
	almasrymina@google.com,
	asml.silence@gmail.com,
	dw@davidwei.uk
Subject: [PATCH net-next v2 1/3] net: create netdev_nl_sock to wrap bindings list
Date: Tue, 11 Mar 2025 07:40:24 -0700
Message-ID: <20250311144026.4154277-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311144026.4154277-1-sdf@fomichev.me>
References: <20250311144026.4154277-1-sdf@fomichev.me>
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



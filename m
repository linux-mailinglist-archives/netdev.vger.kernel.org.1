Return-Path: <netdev+bounces-193179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDF9AC2BF6
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 01:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 000801BA7F59
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 23:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D17217704;
	Fri, 23 May 2025 23:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F1QLlBBn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A1C214A64
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 23:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748041532; cv=none; b=cZQjCiWjUZkayOEiXTXGy49CdE0GwfzM9eIYdyxSR7wiGtcEq/B5SaXe4MBXZ+son66lg8nWpaUBqtEqWi+89nlJ4bXSiuiFxbCtI1rCq/AtQMZq+jxK0m+6Y2QseFixvl5QfhFKBaXbIEhrvWl7Ox8eNSHHtcsmN9THRok6z/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748041532; c=relaxed/simple;
	bh=9bBgqUTKUTvL8dGZ7fOUimIIQDGeubiMLtI87rh+SaI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RrrnY/UJMUlz9ALrm35BgU96lv9710lV1iTamg01PFe2q0u21MT13D3YyLZbMZr1ck1olzpk6ZXiw+/akoizO5tOhRYL/4HneBoFdaGEHF32zWwuG63zKfiFxoUalNGmk6vKI/mY8C3vruoYvpDO+LjZ2LxGkZTGM6O5t6NmvX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F1QLlBBn; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-231e76f6eafso3016045ad.0
        for <netdev@vger.kernel.org>; Fri, 23 May 2025 16:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748041530; x=1748646330; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A3Y8BwizNgJ8oalQ93WgymucSdo1pRhF9lv1bG0FZic=;
        b=F1QLlBBneBeoElw7DJswg/g5uXYv9TFmvDrqhKzxQUfws2IsMC916485EaxFTM96Oa
         fZLQ52K/8SjCvPUZOt/mMeXfHvLi0dErA4lS/PmFYBYCaK2444GN1ITxuG9tN1p40TbU
         XQbe4KHujYF/XKSKubK8LcufP8fALHCWt7fAV9bREvkyYip9z/zUembynr1+iztHD/KL
         NQUTNinrdr/ZL9RxeSSEKQi0bINZroJr1bYLDO2GvxS2i31ei/C0T6sZPMVZM9PbiiII
         YJV/1WzCBpAP2aYhI204toJ0YcmZxE4GK4FySlFbCmwKZI3fM9nYWQgW6daXjb174A2Y
         L08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748041530; x=1748646330;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A3Y8BwizNgJ8oalQ93WgymucSdo1pRhF9lv1bG0FZic=;
        b=Evx8is9RxDwbXQKQJl5Fdx3qFoHejfl2+/u7O+uXfPYLQk95rMIiVgSsOXIO3my0KF
         xDH37Xj8QkMjjtOmU92wTJIgNtH/XPJJIuR2O3dSrBWrlz2T5XZVOObzjmLpUkhGm3UT
         H4RBapxxYJvvmW5hUnXPke9ZkqWKz+5p75FDfW5OsKIRskyE0F1jfDPArOu7LQY0g4RK
         YaHWY/Ipkc4jRE/d8tQ/EFyQPv8XK8dRRgxRuwxXE1HsQAc8v6FTWQdbwmJ4+whtisM5
         O01Jj7OsihQszt7UKZZwF23vqRZnXF3kq3mDjVUtm3fSL8hrzqASRt5lPbr85aTMVJHu
         kaxg==
X-Gm-Message-State: AOJu0YyVnD9urcTuKP0GjCGQVWCVLVFOwBMoi77Bn6nxfAsXxAZTbF7J
	CqCOpkFop3MjgQD/pcYBn1uc80euHFXsqvdj9woUwpJ9PIkch7L57xOp8OQ/NUcC/fA+C8NBnEm
	FKbuOSG4h8gCczhlGR68JZFqFOV018y7S5TrXdqMMKiIE5kXhdBoC9Q5Aa10VDKaaSYW161Auby
	0tN3JOtxkdzBhgh+EbLN1Z4RsltZ8sSK5NNMevHM7A8iUNLyQWvNtMvIfK3oaK97A=
X-Google-Smtp-Source: AGHT+IH4Fzn2Wn5un9IcegOD3XvdTAfnS/c9KAmp12UOskBBU8tWlxhI3ZaVLU3vOkIU9iaEtUmCYsqbvBCAu6Fdxg==
X-Received: from plil14.prod.google.com ([2002:a17:903:17ce:b0:21f:4f0a:c7e2])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d2d1:b0:234:e88:f23 with SMTP id d9443c01a7336-23414f34dd5mr16574955ad.6.1748041530499;
 Fri, 23 May 2025 16:05:30 -0700 (PDT)
Date: Fri, 23 May 2025 23:05:17 +0000
In-Reply-To: <20250523230524.1107879-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523230524.1107879-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523230524.1107879-2-almasrymina@google.com>
Subject: [PATCH net-next v2 1/8] net: devmem: move list_add to net_devmem_bind_dmabuf.
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, David Ahern <dsahern@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	ap420073@gmail.com, praan@google.com, shivajikant@google.com
Content-Type: text/plain; charset="UTF-8"

It's annoying for the list_add to be outside net_devmem_bind_dmabuf, but
the list_del is in net_devmem_unbind_dmabuf. Make it consistent by
having both the list_add/del be inside the net_devmem_[un]bind_dmabuf.

Cc: ap420073@gmail.com
Signed-off-by: Mina Almasry <almasrymina@google.com>
Tested-by: Taehee Yoo <ap420073@gmail.com>

---
 net/core/devmem.c      | 5 ++++-
 net/core/devmem.h      | 5 ++++-
 net/core/netdev-genl.c | 8 ++------
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 0dba26baae18..b3a62ca0df65 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -178,7 +178,8 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 struct net_devmem_dmabuf_binding *
 net_devmem_bind_dmabuf(struct net_device *dev,
 		       enum dma_data_direction direction,
-		       unsigned int dmabuf_fd, struct netlink_ext_ack *extack)
+		       unsigned int dmabuf_fd, struct netdev_nl_sock *priv,
+		       struct netlink_ext_ack *extack)
 {
 	struct net_devmem_dmabuf_binding *binding;
 	static u32 id_alloc_next;
@@ -299,6 +300,8 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 	if (err < 0)
 		goto err_free_chunks;
 
+	list_add(&binding->list, &priv->bindings);
+
 	return binding;
 
 err_free_chunks:
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 58d8d3c1b945..e7ba77050b8f 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -11,6 +11,7 @@
 #define _NET_DEVMEM_H
 
 #include <net/netmem.h>
+#include <net/netdev_netlink.h>
 
 struct netlink_ext_ack;
 
@@ -82,7 +83,8 @@ void __net_devmem_dmabuf_binding_free(struct work_struct *wq);
 struct net_devmem_dmabuf_binding *
 net_devmem_bind_dmabuf(struct net_device *dev,
 		       enum dma_data_direction direction,
-		       unsigned int dmabuf_fd, struct netlink_ext_ack *extack);
+		       unsigned int dmabuf_fd, struct netdev_nl_sock *priv,
+		       struct netlink_ext_ack *extack);
 struct net_devmem_dmabuf_binding *net_devmem_lookup_dmabuf(u32 id);
 void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding);
 int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
@@ -170,6 +172,7 @@ static inline void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 static inline struct net_devmem_dmabuf_binding *
 net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 		       enum dma_data_direction direction,
+		       struct netdev_nl_sock *priv,
 		       struct netlink_ext_ack *extack)
 {
 	return ERR_PTR(-EOPNOTSUPP);
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 762570dcda61..2afa7b2141aa 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -908,7 +908,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	binding = net_devmem_bind_dmabuf(netdev, DMA_FROM_DEVICE, dmabuf_fd,
-					 info->extack);
+					 priv, info->extack);
 	if (IS_ERR(binding)) {
 		err = PTR_ERR(binding);
 		goto err_unlock;
@@ -943,8 +943,6 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 			goto err_unbind;
 	}
 
-	list_add(&binding->list, &priv->bindings);
-
 	nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id);
 	genlmsg_end(rsp, hdr);
 
@@ -1020,15 +1018,13 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_unlock_netdev;
 	}
 
-	binding = net_devmem_bind_dmabuf(netdev, DMA_TO_DEVICE, dmabuf_fd,
+	binding = net_devmem_bind_dmabuf(netdev, DMA_TO_DEVICE, dmabuf_fd, priv,
 					 info->extack);
 	if (IS_ERR(binding)) {
 		err = PTR_ERR(binding);
 		goto err_unlock_netdev;
 	}
 
-	list_add(&binding->list, &priv->bindings);
-
 	nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id);
 	genlmsg_end(rsp, hdr);
 
-- 
2.49.0.1151.ga128411c76-goog



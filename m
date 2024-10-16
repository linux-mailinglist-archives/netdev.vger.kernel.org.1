Return-Path: <netdev+bounces-136242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA169A11EC
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1FF71F2512B
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 18:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93CC18C348;
	Wed, 16 Oct 2024 18:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="spKfnELA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD252144B1
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 18:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729104787; cv=none; b=fu/q5koPkYkAPuS13rJucdL+LpyqZZO3yJ+vJLPL4JZxBgWl/wtMdrDMwC51IXpq3ONCsSQGe8+bzP9Y5Im283Y12b0wcpuy2nmtorYx/1tu2VjDlHTIRZ+8Iff5mQoJeW+ubr/ukVhGof9xQMaEnLBtG3uMSpzXXZaD3ln2pz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729104787; c=relaxed/simple;
	bh=GYfv98ZUd48uxOI6Ts+rl9u4lukVAUinedFku6rUGEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=quzLSd3qDKgIbeDJ7sgDMdLDsg2mxeQxHfztEnG9fKHRiWuYWUwPg4BaSGj3XK7jQdGHAs/FAd1ZAU/XKcAt77ZuoIVQ2Gpf2my3ULFkZ0scSgho06/q7OK4ZVr+22UKepyD+C+LHLVSby1I1HDOdQeZjLa2mULzJ3EQuTyez00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=spKfnELA; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20c805a0753so1399735ad.0
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 11:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1729104786; x=1729709586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEYTOkkPbOMOeAXcMwBoyyLeSIseQx5WZXYwap0u980=;
        b=spKfnELAPJm2zelVThTwzx8WES+MRHkBOTrVagE3bV7jwP1Oo0ZwtJKg+9wC1UuuP/
         M67MP1ZUXAvAjHmWNdLvwoAI2OcKI5d0gGVmuvcJxfar0LbqeR4DvzsFJwKpnbQx0xD5
         WD5A4IKh3cLVlQuh472P5RdrdaEiEzqnfeXOooSiHDYrraU7ptLRal+5Ym9gAZRfPvxG
         derkvGASPI7tnt+ywA0IIg2nR+I6NO3kAk8tcU1GBLPLJA9fzc+/oPLCtAuM7gExs69o
         feOwYG/P9BjNdlffQ0REaONZPgGnzZYpnaJjECVBY89HH7yfalzmS5T9A2vpEf34X/cy
         LIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729104786; x=1729709586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gEYTOkkPbOMOeAXcMwBoyyLeSIseQx5WZXYwap0u980=;
        b=m138bf5snr7NYuxjD0LB8JQwNMwkgBKqzNgldfMo+rKhj/aMywKYhv/GbFlKK91LZh
         wXE6WnkqYmE0wf3CNW0jpyFuQAcL/T2jSC3HkQpbs5Tt2NAcSo1G0KsKPgNHrqnmPqNG
         p4fqAA3YOpgKtM+tPC/rHNTaJwIOCYT9KQJ1YKQ36RCI070pkTQ98K79gmjCKeeq3sDh
         pedIMjxRBynT3blq0Qo34a3mw8QBtcy7VqgizLfrRsdZ+L1Pl5YUDu+Rul/s7MdjaBYn
         NxbAtUljwUA22iu4pOR+JNPvl7t6jahnZ5sIw7BB8h4D0qhqSN1jN4TQ7znM6iDAqPYt
         IPFA==
X-Forwarded-Encrypted: i=1; AJvYcCUtDfmLSj70svFLgGaKqqlsKNLI1rDaG46q6sKk7U9J+8/5nCJDugEELdD1GMUxkk5FRAY143k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpGLE2NKVtP2vP6X/HOwlYWo4G4EpKVl4rsBP2+eKc/TfmlVRP
	9QOrKmkr/o+qKMNzuaVv1jFrg1jKW3+a9HkqToWPv3xLJAYdh8xzGvltyjPjc64=
X-Google-Smtp-Source: AGHT+IES12a7fAsskB7fQc1zYGG7uvcmwMhCjQS6javdYbymUS1L+VyRgNNviWjhI77NB23qHN3O+g==
X-Received: by 2002:a17:903:2283:b0:20b:a10c:9bdf with SMTP id d9443c01a7336-20d27ed02f5mr62699775ad.32.1729104785844;
        Wed, 16 Oct 2024 11:53:05 -0700 (PDT)
Received: from localhost (fwdproxy-prn-116.fbsv.net. [2a03:2880:ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1804b734sm31677265ad.222.2024.10.16.11.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 11:53:05 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: David Wei <dw@davidwei.uk>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Joe Damato <jdamato@fastly.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH v6 04/15] net: prepare for non devmem TCP memory providers
Date: Wed, 16 Oct 2024 11:52:41 -0700
Message-ID: <20241016185252.3746190-5-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241016185252.3746190-1-dw@davidwei.uk>
References: <20241016185252.3746190-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavel Begunkov <asml.silence@gmail.com>

There is a good bunch of places in generic paths assuming that the only
page pool memory provider is devmem TCP. As we want to reuse the net_iov
and provider infrastructure, we need to patch it up and explicitly check
the provider type when we branch into devmem TCP code.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 net/core/devmem.c         | 10 ++++++++--
 net/core/devmem.h         |  8 ++++++++
 net/core/page_pool_user.c | 15 +++++++++------
 net/ipv4/tcp.c            |  6 ++++++
 4 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 01738029e35c..78983a98e5dc 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -28,6 +28,12 @@ static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);
 
 static const struct memory_provider_ops dmabuf_devmem_ops;
 
+bool net_is_devmem_page_pool_ops(const struct memory_provider_ops *ops)
+{
+	return ops == &dmabuf_devmem_ops;
+}
+EXPORT_SYMBOL_GPL(net_is_devmem_page_pool_ops);
+
 static void net_devmem_dmabuf_free_chunk_owner(struct gen_pool *genpool,
 					       struct gen_pool_chunk *chunk,
 					       void *not_used)
@@ -316,10 +322,10 @@ void dev_dmabuf_uninstall(struct net_device *dev)
 	unsigned int i;
 
 	for (i = 0; i < dev->real_num_rx_queues; i++) {
-		binding = dev->_rx[i].mp_params.mp_priv;
-		if (!binding)
+		if (dev->_rx[i].mp_params.mp_ops != &dmabuf_devmem_ops)
 			continue;
 
+		binding = dev->_rx[i].mp_params.mp_priv;
 		xa_for_each(&binding->bound_rxqs, xa_idx, rxq)
 			if (rxq == &dev->_rx[i]) {
 				xa_erase(&binding->bound_rxqs, xa_idx);
diff --git a/net/core/devmem.h b/net/core/devmem.h
index a2b9913e9a17..a3fdd66bb05b 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -116,6 +116,8 @@ struct net_iov *
 net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding);
 void net_devmem_free_dmabuf(struct net_iov *ppiov);
 
+bool net_is_devmem_page_pool_ops(const struct memory_provider_ops *ops);
+
 #else
 struct net_devmem_dmabuf_binding;
 
@@ -168,6 +170,12 @@ static inline u32 net_devmem_iov_binding_id(const struct net_iov *niov)
 {
 	return 0;
 }
+
+static inline bool
+net_is_devmem_page_pool_ops(const struct memory_provider_ops *ops)
+{
+	return false;
+}
 #endif
 
 #endif /* _NET_DEVMEM_H */
diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index 48335766c1bf..604862a73535 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -214,7 +214,7 @@ static int
 page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
 		  const struct genl_info *info)
 {
-	struct net_devmem_dmabuf_binding *binding = pool->mp_priv;
+	struct net_devmem_dmabuf_binding *binding;
 	size_t inflight, refsz;
 	void *hdr;
 
@@ -244,8 +244,11 @@ page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
 			 pool->user.detach_time))
 		goto err_cancel;
 
-	if (binding && nla_put_u32(rsp, NETDEV_A_PAGE_POOL_DMABUF, binding->id))
-		goto err_cancel;
+	if (net_is_devmem_page_pool_ops(pool->mp_ops)) {
+		binding = pool->mp_priv;
+		if (nla_put_u32(rsp, NETDEV_A_PAGE_POOL_DMABUF, binding->id))
+			goto err_cancel;
+	}
 
 	genlmsg_end(rsp, hdr);
 
@@ -353,16 +356,16 @@ void page_pool_unlist(struct page_pool *pool)
 int page_pool_check_memory_provider(struct net_device *dev,
 				    struct netdev_rx_queue *rxq)
 {
-	struct net_devmem_dmabuf_binding *binding = rxq->mp_params.mp_priv;
+	void *mp_priv = rxq->mp_params.mp_priv;
 	struct page_pool *pool;
 	struct hlist_node *n;
 
-	if (!binding)
+	if (!mp_priv)
 		return 0;
 
 	mutex_lock(&page_pools_lock);
 	hlist_for_each_entry_safe(pool, n, &dev->page_pools, user.list) {
-		if (pool->mp_priv != binding)
+		if (pool->mp_priv != mp_priv)
 			continue;
 
 		if (pool->slow.queue_idx == get_netdev_rx_queue_index(rxq)) {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e928efc22f80..31e01da61c12 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -277,6 +277,7 @@
 #include <net/ip.h>
 #include <net/sock.h>
 #include <net/rstreason.h>
+#include <net/page_pool/types.h>
 
 #include <linux/uaccess.h>
 #include <asm/ioctls.h>
@@ -2476,6 +2477,11 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 			}
 
 			niov = skb_frag_net_iov(frag);
+			if (net_is_devmem_page_pool_ops(niov->pp->mp_ops)) {
+				err = -ENODEV;
+				goto out;
+			}
+
 			end = start + skb_frag_size(frag);
 			copy = end - offset;
 
-- 
2.43.5



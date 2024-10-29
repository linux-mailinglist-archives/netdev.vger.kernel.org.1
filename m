Return-Path: <netdev+bounces-140160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2A69B5661
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 00:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5F24283EA5
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 23:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D19920C01D;
	Tue, 29 Oct 2024 23:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="SxQWDtx2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA6520C003
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 23:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730243166; cv=none; b=U+B70EiiMJ6cFOCLaSryT7Ahsjug89dVKoNWPBWofm5M48L3T+yPeASI6BmmimFUB39Y7RBYMSdFjRJRAbh5osX3XKG1HhNtdjA65Wy8M4E6ca7cWzoXZWedn9MFMth7Wmh41sgjuTyYAzljhC3a53yljMArgIfYda7zSa6apIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730243166; c=relaxed/simple;
	bh=GYfv98ZUd48uxOI6Ts+rl9u4lukVAUinedFku6rUGEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9/gZrKpAhANoo3uSHeVEDnk+dqg2+UFLbTpSehENwl0gizGT9MtEX/yx9ujZgG0NvAiLSOoe0iOTaugC8zm08bTp1+DwiUXOwr8irF1toUEjWsPvENLxfqe71eus5/2K9VBd4DLbEjjheyZJWVEY4U+7si951pwwCAVN6fqN/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=SxQWDtx2; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e2e050b1c3so267401a91.0
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 16:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1730243163; x=1730847963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEYTOkkPbOMOeAXcMwBoyyLeSIseQx5WZXYwap0u980=;
        b=SxQWDtx21283UW+E1i5gAUXCbr/pRi834bY2PNtsBTk5bqQ9enQP9cRb3hgxs6HLsx
         S6KiBST9uf6jt7DOnb15c3FqafBvaJwQ2CSO2CKXR3HFGqtHMTGZUU/9NLhKxCi7zWpp
         MULloBi5SpylMrNRfNgjr1fqiVtziLg//HS9UTVB4KJSPB/I4THptRvlxBzk8DlWLR0U
         AJKiTTPspGCEN/W0jNk9tDWSPCCzc5cd79xRHxbQXwpm0qJec+pP81WRKrJJnYEMUziR
         RGnMP+V2KG5JhhVfq6lZwA94BEtWB+zm9O3VKNfVm8DgLi+c686sNkm2VvaQxhOpcMXT
         hWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730243163; x=1730847963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gEYTOkkPbOMOeAXcMwBoyyLeSIseQx5WZXYwap0u980=;
        b=e7F4GrBOHnEQtq4/7gZxmZ1qKBnb0WtuApSB6GkyEySPgr7o07tWmQo+JSwmfx7BgQ
         UxIQ3PaDglmyjmbLLxwTGdKjzcxJ4P/ucNReNebAVHTB7BuWc4upNpA/uOF3ZP88JZhv
         MLY5LXdIrI5Uwh9JwmDTdtSTfeB8ihRK6il2+86Coz71IlQfhVnRQW1UTeNJ6JQ51Jy1
         Ss/g2TAJW9zo61Ya24mRaqhMbAedsJLmzMUO+ivwK6NmeKMvVcp6xoGb1QqqkmsBd4IF
         RuYLEIptIvDlPqbCTkgJLYUp54jnw5L+xg2dMf5uxV5vCYG5e8isBMqHuq804qsAiw0q
         3yNA==
X-Forwarded-Encrypted: i=1; AJvYcCUkKZtyVmSZCK2kzI+Hj/2Go6qH7L1Na3s1EyIuwWlGM874Pql8ju9dRvROUod5IxYa6QlQTEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjAyp5WA9mRULK1SdUgkYqyMr3JTpwkZHsLYPvNGk1K7Pff06r
	eOGNxBke2INcyN4JaezV2ZnnKWILCmzonlgTS4eLTqcfzqpDXwp/P/SApr9pay4=
X-Google-Smtp-Source: AGHT+IHTU5ADR4gEYZY0iOEGwaRYT9DQcx2ogML1ynhS3o5kEpPN+pJTbCGnV2xsXRJU/BcKnPFwSw==
X-Received: by 2002:a17:90a:c685:b0:2e2:a5fd:7e4c with SMTP id 98e67ed59e1d1-2e922388b86mr5329536a91.8.1730243163575;
        Tue, 29 Oct 2024 16:06:03 -0700 (PDT)
Received: from localhost (fwdproxy-prn-024.fbsv.net. [2a03:2880:ff:18::face:b00c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92faa650dsm220914a91.48.2024.10.29.16.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 16:06:03 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
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
Subject: [PATCH v7 04/15] net: prepare for non devmem TCP memory providers
Date: Tue, 29 Oct 2024 16:05:07 -0700
Message-ID: <20241029230521.2385749-5-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241029230521.2385749-1-dw@davidwei.uk>
References: <20241029230521.2385749-1-dw@davidwei.uk>
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



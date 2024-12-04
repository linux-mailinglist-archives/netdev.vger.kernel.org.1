Return-Path: <netdev+bounces-149091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D706D9E444E
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 20:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96CBBB47910
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 17:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836F12144A8;
	Wed,  4 Dec 2024 17:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="a5kyLfUP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95B7213258
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 17:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332966; cv=none; b=N+ge6ZDwYUgPGhF4T/gmiZDlgNW8hhs23UPSqPQAskHNC90d3Ozmaefp5gUiqpBg8c8NhfkG9Woh3OwZuOxRx3WzDzL0hQyPkvzI1hcbE0wv6mIQiri3vUe9JXF7wfZSy5uJasKp6yk0MqS6wTZByVUT7+unodkDXrCo07x89XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332966; c=relaxed/simple;
	bh=frqeAzwkJ9oMlnR6KCmqaH2uYtAqksDh6+nrwl2/U64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mI24x+bpb5/WxK/Tm9GRds+tIv3s/Rvl8WU8hGhPcmtYdJ0W9l2bUPGqOOML+uS9VbBKdwLeNLRDnB44Exo1PA0iQRSYqZZTAcLGcitpEFvc5ROum96zwdsuITgBFJwGVpHTQtWIawn+A540gCzlwYMHQvPV0tEzvxc3rP32JgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=a5kyLfUP; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7fd10cd5b10so23552a12.2
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 09:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1733332964; x=1733937764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsSDsak9FzFqdyI2Y+zWFMkiWrzR17UOTNp3LeYZscU=;
        b=a5kyLfUP0QNGoxXgbrrkF55HxlzVfpm/W62HRfVIqX/iIQxX1oZlv5xOPp+e9n5tgz
         HYYsFytDurN6+WbrtwjRXp7g7EhXcHq8HOnOWGap5BjUK41T129b5VrKr0XLvf2tHVf/
         iAGKwOHzKVCc01aQY1kDKGd3l1/Sbx03aVNYdYr/s4QVD8a+cWp9GrbhOc9e6AvrQADZ
         EpEi/F3Hk42zBRXWvsMdDuMQlj3aFh/936QzXAWGCXFQZwnl28NxsLIkgPvvSzHlPZtQ
         vHjoDV5NsTfRenisbiQWkB1DVVP/Cosfxjdz3OErQdkR8K/xRT/aGLxutYx/d2ODMPJp
         JfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733332964; x=1733937764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsSDsak9FzFqdyI2Y+zWFMkiWrzR17UOTNp3LeYZscU=;
        b=LrEPqppPMnhRNZG0AWSC5TivN5OTIzP4qqZmzNCH8937KCvzGy9B9gsb5+dp0/PUu8
         lKfi62fhG/+p1wc49ET/kJ5QTtkGzVdqTHH1WCeSeloK2OrzbxnTVJh19Yw3IS2NYjRI
         A+o8uuNyA6A1Yn2OezzLfGb+pqx9hNFeIgClVIADcesjeFjJKKH6wTXA02BuTYm9WMbm
         5uv6JCLUe/ODOknXFfLAJqfyy3Dk2L8mj76sDIuiBcAwFVQY4h61X9GyAukRVsrqkr2K
         5/T5UuFsWS4NNt6WTofebOjJJ8vKFen/m5i8rU5r3yLX3MzXG4ZzJDUh3/tT2d6qMRCX
         ZmfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbSj8rvtfRGJK2mF7COl3izH2RHxrWVDmWOpT3hDzfRW6p8xBT6B8R7FqfjlsXzE/1JuZAv3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPb7U/+8dyRJtS4rcBh0TWZ+eNAICSEqnyU2uRh/Go1qhjxUoP
	n4lnKn6XDaZ98i+xqiGi1k9RRB0zhcIUco0St3gdu15EjT3QtS97TH7oPbqUpgI=
X-Gm-Gg: ASbGncurLs3QvSD/M66xxUC5nnk3gDroiwzhBNL7FJuD8kC3m36ZDjj/50UfTANazg7
	AhRwuY+OmDw+LdWZFzxxwfV3xTL0HbiGwNOV9EXNuOaHX0wmDU/vsbWZkDblJErG9S8pXDdMl66
	ij0eIPoQK6yKLj3l/Lko8sPdD/mcjqhsxT5RobyOkffWvh1bc5FbsoqSb4oknFNsgM1QYXh+WX2
	CKR7ee/OMmk3QYls+ZZKWglF6G/lkzSYw==
X-Google-Smtp-Source: AGHT+IEC4bk4CdmOVdnpPRWZFJhbzn+ahGy9UpBnkTNPDZgSdGijktQsaZAHSW0Pbhm4QCPQ6BVQNA==
X-Received: by 2002:a05:6a20:9144:b0:1e0:d796:b079 with SMTP id adf61e73a8af0-1e1653bb99dmr11860869637.17.1733332964158;
        Wed, 04 Dec 2024 09:22:44 -0800 (PST)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c2d4bc6sm11747507a12.9.2024.12.04.09.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 09:22:43 -0800 (PST)
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
Subject: [PATCH net-next v8 02/17] net: generalise net_iov chunk owners
Date: Wed,  4 Dec 2024 09:21:41 -0800
Message-ID: <20241204172204.4180482-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241204172204.4180482-1-dw@davidwei.uk>
References: <20241204172204.4180482-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavel Begunkov <asml.silence@gmail.com>

Currently net_iov stores a pointer to struct dmabuf_genpool_chunk_owner,
which serves as a useful abstraction to share data and provide a
context. However, it's too devmem specific, and we want to reuse it for
other memory providers, and for that we need to decouple net_iov from
devmem. Make net_iov to point to a new base structure called
net_iov_area, which dmabuf_genpool_chunk_owner extends.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/net/netmem.h | 21 ++++++++++++++++++++-
 net/core/devmem.c    | 25 +++++++++++++------------
 net/core/devmem.h    | 25 +++++++++----------------
 3 files changed, 42 insertions(+), 29 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 8a6e20be4b9d..3795ded30d2c 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -24,11 +24,20 @@ struct net_iov {
 	unsigned long __unused_padding;
 	unsigned long pp_magic;
 	struct page_pool *pp;
-	struct dmabuf_genpool_chunk_owner *owner;
+	struct net_iov_area *owner;
 	unsigned long dma_addr;
 	atomic_long_t pp_ref_count;
 };
 
+struct net_iov_area {
+	/* Array of net_iovs for this area. */
+	struct net_iov *niovs;
+	size_t num_niovs;
+
+	/* Offset into the dma-buf where this chunk starts.  */
+	unsigned long base_virtual;
+};
+
 /* These fields in struct page are used by the page_pool and net stack:
  *
  *        struct {
@@ -54,6 +63,16 @@ NET_IOV_ASSERT_OFFSET(dma_addr, dma_addr);
 NET_IOV_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
 #undef NET_IOV_ASSERT_OFFSET
 
+static inline struct net_iov_area *net_iov_owner(const struct net_iov *niov)
+{
+	return niov->owner;
+}
+
+static inline unsigned int net_iov_idx(const struct net_iov *niov)
+{
+	return niov - net_iov_owner(niov)->niovs;
+}
+
 /* netmem */
 
 /**
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 858982858f81..5c10cf0e2a18 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -32,14 +32,15 @@ static void net_devmem_dmabuf_free_chunk_owner(struct gen_pool *genpool,
 {
 	struct dmabuf_genpool_chunk_owner *owner = chunk->owner;
 
-	kvfree(owner->niovs);
+	kvfree(owner->area.niovs);
 	kfree(owner);
 }
 
 static dma_addr_t net_devmem_get_dma_addr(const struct net_iov *niov)
 {
-	struct dmabuf_genpool_chunk_owner *owner = net_iov_owner(niov);
+	struct dmabuf_genpool_chunk_owner *owner;
 
+	owner = net_devmem_iov_to_chunk_owner(niov);
 	return owner->base_dma_addr +
 	       ((dma_addr_t)net_iov_idx(niov) << PAGE_SHIFT);
 }
@@ -82,7 +83,7 @@ net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
 
 	offset = dma_addr - owner->base_dma_addr;
 	index = offset / PAGE_SIZE;
-	niov = &owner->niovs[index];
+	niov = &owner->area.niovs[index];
 
 	niov->pp_magic = 0;
 	niov->pp = NULL;
@@ -250,9 +251,9 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 			goto err_free_chunks;
 		}
 
-		owner->base_virtual = virtual;
+		owner->area.base_virtual = virtual;
 		owner->base_dma_addr = dma_addr;
-		owner->num_niovs = len / PAGE_SIZE;
+		owner->area.num_niovs = len / PAGE_SIZE;
 		owner->binding = binding;
 
 		err = gen_pool_add_owner(binding->chunk_pool, dma_addr,
@@ -264,17 +265,17 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 			goto err_free_chunks;
 		}
 
-		owner->niovs = kvmalloc_array(owner->num_niovs,
-					      sizeof(*owner->niovs),
-					      GFP_KERNEL);
-		if (!owner->niovs) {
+		owner->area.niovs = kvmalloc_array(owner->area.num_niovs,
+						   sizeof(*owner->area.niovs),
+						   GFP_KERNEL);
+		if (!owner->area.niovs) {
 			err = -ENOMEM;
 			goto err_free_chunks;
 		}
 
-		for (i = 0; i < owner->num_niovs; i++) {
-			niov = &owner->niovs[i];
-			niov->owner = owner;
+		for (i = 0; i < owner->area.num_niovs; i++) {
+			niov = &owner->area.niovs[i];
+			niov->owner = &owner->area;
 			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
 						      net_devmem_get_dma_addr(niov));
 		}
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 99782ddeca40..a2b9913e9a17 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -10,6 +10,8 @@
 #ifndef _NET_DEVMEM_H
 #define _NET_DEVMEM_H
 
+#include <net/netmem.h>
+
 struct netlink_ext_ack;
 
 struct net_devmem_dmabuf_binding {
@@ -51,17 +53,11 @@ struct net_devmem_dmabuf_binding {
  * allocations from this chunk.
  */
 struct dmabuf_genpool_chunk_owner {
-	/* Offset into the dma-buf where this chunk starts.  */
-	unsigned long base_virtual;
+	struct net_iov_area area;
+	struct net_devmem_dmabuf_binding *binding;
 
 	/* dma_addr of the start of the chunk.  */
 	dma_addr_t base_dma_addr;
-
-	/* Array of net_iovs for this chunk. */
-	struct net_iov *niovs;
-	size_t num_niovs;
-
-	struct net_devmem_dmabuf_binding *binding;
 };
 
 void __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding);
@@ -75,20 +71,17 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 void dev_dmabuf_uninstall(struct net_device *dev);
 
 static inline struct dmabuf_genpool_chunk_owner *
-net_iov_owner(const struct net_iov *niov)
+net_devmem_iov_to_chunk_owner(const struct net_iov *niov)
 {
-	return niov->owner;
-}
+	struct net_iov_area *owner = net_iov_owner(niov);
 
-static inline unsigned int net_iov_idx(const struct net_iov *niov)
-{
-	return niov - net_iov_owner(niov)->niovs;
+	return container_of(owner, struct dmabuf_genpool_chunk_owner, area);
 }
 
 static inline struct net_devmem_dmabuf_binding *
 net_devmem_iov_binding(const struct net_iov *niov)
 {
-	return net_iov_owner(niov)->binding;
+	return net_devmem_iov_to_chunk_owner(niov)->binding;
 }
 
 static inline u32 net_devmem_iov_binding_id(const struct net_iov *niov)
@@ -98,7 +91,7 @@ static inline u32 net_devmem_iov_binding_id(const struct net_iov *niov)
 
 static inline unsigned long net_iov_virtual_addr(const struct net_iov *niov)
 {
-	struct dmabuf_genpool_chunk_owner *owner = net_iov_owner(niov);
+	struct net_iov_area *owner = net_iov_owner(niov);
 
 	return owner->base_virtual +
 	       ((unsigned long)net_iov_idx(niov) << PAGE_SHIFT);
-- 
2.43.5



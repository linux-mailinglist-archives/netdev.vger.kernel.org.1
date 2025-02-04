Return-Path: <netdev+bounces-162760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F417AA27DE3
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 22:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBE363A643D
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 21:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B048421B1AA;
	Tue,  4 Feb 2025 21:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="uYhmAm+j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A2121ADCB
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 21:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738706189; cv=none; b=CybM5+u1DurUPLKKvCX7OQTOxX4loueUyCrpbSKHojxhNsecbq5oLOkDVEy8ZACr95qHeT8I50A6yIjhQgJH4jkL1ooGXxkDTJkxIRyA7uTDx0P3PyykgnA52LXPJaT4RjVTYoOzPKNf0osF+5nYYH8FXFFx8d041CgzgdIXbVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738706189; c=relaxed/simple;
	bh=wQAH12+u9SH8s8aaHLbjLYo2wle02yX3U3c5UV1vGPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tq/Fkv460dKxbSrbMMAGD2mE5fkT9yCemBS84MmnO+ZGmcVvBx2WlrdFSOTrnSBpfBVQ/Yqz2bRyeEbalQHi3Dwu5YYTiYhK2aoca3pnRlQrl3cVrjoKeavLNQqTsCqA4n4eaKilUb6wYj6uR3rDsw0bCbld8rdG6Oxbkmd2wiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=uYhmAm+j; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21644aca3a0so142689145ad.3
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 13:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1738706187; x=1739310987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TA1fLy5emdqDCQ/2QEOFVDqLJ+sP5b06n93RKtRhfIs=;
        b=uYhmAm+jn7G+iIK9kgZ02DoUF/BHz/nmEg6PbSPIc6Ntd++aNs5YmC5CNc8gPG+zVf
         hcEllqCPbQCe5mlb9l01V6ZcqXOgFKj4ETo3MSbfURK0fG5R4bEdxNNwoSBKmhVpLbka
         oDMTWjSXQLy05lkZCbNzrIeEI0trF6o3yYC/C9PFjeiYwZwppb/mz58qU5jZYDZ0l07C
         GB4Ca+ky1Wq5TF5qGyO1S1/QlEJRnDZ3CiB4BGRpS/z8i89hGuZgrskJBtH7au4xf833
         XQUXAVduZrWls2jrD0a8gCdK9mzOsAh2y1PazURioXTYzNhLpcMpGjoW3OS7fxMkq1XM
         zQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738706187; x=1739310987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TA1fLy5emdqDCQ/2QEOFVDqLJ+sP5b06n93RKtRhfIs=;
        b=IHsaUP/vrD5VXyP8nL6s/UtYGs4yEz4CnF/ES7xTkfPLfboCE6Zxly+DJ8fHPcfVyJ
         zejkKzkdp7bYhpuyhPmfx2FtN7f8ZmAmqJnBbpfYC4b5g95bhv18E5ke+UR28Yi3xuc5
         AFlMZfgn5V1Mduq86oWxh6zVRAfPDiYg5r3RHOzgssY3hz5MLkcUDfYy+HU0Vn8NLvbj
         FgAO/1qDMyAd67+TjaEz3LwFAAw/84F1SkHWUaHKLy41jpBDuYwKBK1M2jqJpFyuRdPO
         zE8ZwIYfUn3g5hOBGc4iodotKEnVp4uTFabr6jZuxqisOVCQkLSrWVrjegFlB67WO5F1
         /GtQ==
X-Gm-Message-State: AOJu0YzBDFn7LYC0oHON/fYOT4laMuLWfTp1I6mmaoa5c5tNma4XRpNC
	dDDgmggvQe5/CvfViYv4T5XdKCHBduoSupJtmu89r8/rR7vHOCrVIKd4V6BCX6GCTLfUQBV0pf6
	1
X-Gm-Gg: ASbGncufXSqfs5qkNMQS3QpnCY1Yz+YbbNDrtHtxgGshazurgY+WiVqBuTylgyaqduf
	dL0BzS8Hq3MPyI4uXCI/LDNfh+tVmcVMgoslHgWQHPmW+TkrRIEUXdsVDfbu2JxKg8/8TxWGL43
	oikXarrc8Q2fdkm/U5yzs3md0yeJPb81Qrdf5wCI+bhoYqQ1kc+e3xBmiN0lyeMj+FFks/nfkz3
	g9HsXXKbdsJuj0367KnkP+PgoBCYL4zyVTiDMMcalVNfAcCZC1b7D3KV7UyU+o7nmlO+E1kWmo=
X-Google-Smtp-Source: AGHT+IFcOjF4szIQP/QooPu2iC+61phwbnzxSGwIujrnK2BA803J0CiAlPwLtMIwNTtqoxHJrm59IA==
X-Received: by 2002:a17:902:ced1:b0:216:2d42:2e05 with SMTP id d9443c01a7336-21f17e272c9mr9167375ad.22.1738706187322;
        Tue, 04 Feb 2025 13:56:27 -0800 (PST)
Received: from localhost ([2a03:2880:ff:3::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de31ee206sm100839705ad.16.2025.02.04.13.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 13:56:27 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>,
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
Subject: [PATCH net-next v13 03/10] net: generalise net_iov chunk owners
Date: Tue,  4 Feb 2025 13:56:14 -0800
Message-ID: <20250204215622.695511-4-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250204215622.695511-1-dw@davidwei.uk>
References: <20250204215622.695511-1-dw@davidwei.uk>
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

Reviewed-by: Mina Almasry <almasrymina@google.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/net/netmem.h | 21 ++++++++++++++++++++-
 net/core/devmem.c    | 25 +++++++++++++------------
 net/core/devmem.h    | 25 +++++++++----------------
 3 files changed, 42 insertions(+), 29 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 1b58faa4f20f..c61d5b21e7b4 100644
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
index 66cd1ab9224f..fb0dddcb4e60 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -33,14 +33,15 @@ static void net_devmem_dmabuf_free_chunk_owner(struct gen_pool *genpool,
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
@@ -83,7 +84,7 @@ net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
 
 	offset = dma_addr - owner->base_dma_addr;
 	index = offset / PAGE_SIZE;
-	niov = &owner->niovs[index];
+	niov = &owner->area.niovs[index];
 
 	niov->pp_magic = 0;
 	niov->pp = NULL;
@@ -261,9 +262,9 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 			goto err_free_chunks;
 		}
 
-		owner->base_virtual = virtual;
+		owner->area.base_virtual = virtual;
 		owner->base_dma_addr = dma_addr;
-		owner->num_niovs = len / PAGE_SIZE;
+		owner->area.num_niovs = len / PAGE_SIZE;
 		owner->binding = binding;
 
 		err = gen_pool_add_owner(binding->chunk_pool, dma_addr,
@@ -275,17 +276,17 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
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



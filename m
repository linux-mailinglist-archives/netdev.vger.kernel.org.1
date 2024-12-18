Return-Path: <netdev+bounces-152765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A67CD9F5BCF
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 01:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 460831896862
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 00:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A985928691;
	Wed, 18 Dec 2024 00:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="SMaVC01T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A74136671
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 00:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734482293; cv=none; b=tghxbCrHK3Lb3tkZZts7OEurzRwtvsjuProU+u/9ayIxF4bvFDaO1TQdxf2t6QhEOcaTM2jckV1tU9wLJKNlaOQuNyD9fl22qiFBdZ5vpztXyQOj12o9l97Hr+MbaShxyTOchqqDVdSuw53Kiq4+LfTEWogpPkU+APbRNgcBHIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734482293; c=relaxed/simple;
	bh=3FYWOzv7GI9lx7mwhuutMTOmOihGpo6sHz92R4r6kzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxcfXF03ivpdbliLRR/1rUg/2GlOGT98uCEhrD9p5ANyzvpCppMdND67EgSjGWbeFporE3PSeAn5n2WQ5mUX2dr9yR6kl41PHGbkbgpZC+ym6QTEabGG8Rk0d9jgAyxGYjsnwiJZ5+VaauAicvCq5goKei3pwM/gafVD7mtlHro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=SMaVC01T; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7fd17f2312bso4147877a12.0
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 16:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1734482291; x=1735087091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHQGzO085Dbg8z+SUztmKbhehQYfjKmzsCXFZJE+G38=;
        b=SMaVC01TISE3JoQWpkZqkJYEoFnnpLfZjmHua9Vb+iNL3VZwPIB0FiyLWE+o7kL8Sz
         2O1ZNkoqDBWxxFJVmdDOHrtSS5GDMwLr5ABlNo/xQJbaQkokOJQ2O1QRumH4DHIQuoLy
         dVs7s6nDl/l7hbYbqt5tYMuSTk+4WhJexLymhWD2lb95ChbpB57h5I++/Dz3KLm1maIW
         ZRvPjWkMch/XGoUXM3E5nCIHwJLJR8xniCFvxLcqRUHZMKU8KO5fwVuQasXj77C0stKT
         iopwfmt9pl4TMJKviUbLSIgHY+bRqCKjM9rMXI7xN143IVW90U85YKyzX52S0YwTvsTw
         NIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734482291; x=1735087091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHQGzO085Dbg8z+SUztmKbhehQYfjKmzsCXFZJE+G38=;
        b=LtrFeBvfkTJNp2u2FYfm/aqqZMRJ72FQxdgiRbyZJEpGwnWIOxGubsBhY8HsulbqEu
         z/UEJhBwZ2RCX4NUMZ4cANIcn6tByHHpNpMv60oCVFzWGjXQxg9FqSALkVonO5uslKTE
         bgsQUA3+CEgkne6DnCKrpQ/LWoqdGlI0VbO9p1DsRnMkLV1gDR5e48viGhX8qJ5eATIU
         3nQfUY0X1M2Ydd6ECdAWiAVKHvgq5O2nhJ1IZLDuvVLwWEEA0wt/A/clkJvVDakx4C/b
         W31Y+1XqdPLUkIqwwKzSYfIPFAB4jp8+dbH+td5KTDLmv0fJTDESbTQgE7zpy6CNKVpt
         LjiA==
X-Forwarded-Encrypted: i=1; AJvYcCVuFFwZK1YUaElppOVbgifkfFU11WOQnLjohFRYgHbfOxJJjT/DPEmnU+tl7db6lHZ/Pp7H9mY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRr4B5+F66v0gVeayD+yW28SL8eMG2p0iKgJkXtCiIkj2+K0kn
	Uy29KYIl9hPNTsaJG6LIl1orVNFHRlR5Bq//nCivzgqJOPGiPg0YuybBnAMCrLs=
X-Gm-Gg: ASbGncukIoAhHuO0h8+6mjJotwNMJKIoo+8Pih5jaghGGYu2vayis4z/KHdkVytoWHm
	O9bSDzriF6dWFQcDeXjA11/ZW/qvStXEeqE3/VEawgDfg4sU1TbYjjXMZ4JGh3PuvrcC0I00Du+
	biB2VKOM46ysTXSMQsffzHq3+nCtimVLn6tcImItbQmguq7KPmGoc0Y/j+UppHk8VAaKBf8Gi2y
	dIMb7EJAj7iwO8nG+nX1Y/7P6JnjO7iE11uf2H9kQ==
X-Google-Smtp-Source: AGHT+IHyJo80ER+2cYHjOYQYCiTLHf0WPuVqPkbdGqdarTU8UyCaxQIIjztwSgcQbCsUmwCDhcsOoA==
X-Received: by 2002:a17:90a:d00b:b0:2ee:ba84:5cac with SMTP id 98e67ed59e1d1-2f2e91a9adbmr1275798a91.7.1734482291218;
        Tue, 17 Dec 2024 16:38:11 -0800 (PST)
Received: from localhost ([2a03:2880:ff:74::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ed62cdabsm131945a91.14.2024.12.17.16.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 16:38:10 -0800 (PST)
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
Subject: [PATCH net-next v9 13/20] net: page pool: export page_pool_set_dma_addr_netmem()
Date: Tue, 17 Dec 2024 16:37:39 -0800
Message-ID: <20241218003748.796939-14-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241218003748.796939-1-dw@davidwei.uk>
References: <20241218003748.796939-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Export page_pool_set_dma_addr_netmem() in page_pool/helpers.h. This is
needed by memory provider implementations that are outside of net/ to be
able to set the dma addrs on net_iovs during alloc/free.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/net/page_pool/helpers.h |  5 +++++
 net/core/page_pool.c            | 16 ++++++++++++++++
 net/core/page_pool_priv.h       | 17 -----------------
 3 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index d968eebc4322..00eea5dd6f88 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -486,6 +486,7 @@ static inline void page_pool_nid_changed(struct page_pool *pool, int new_nid)
 #if defined(CONFIG_PAGE_POOL)
 void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem);
 void page_pool_clear_pp_info(netmem_ref netmem);
+bool page_pool_set_dma_addr_netmem(netmem_ref netmem, dma_addr_t addr);
 
 void page_pool_mp_return_in_cache(struct page_pool *pool, netmem_ref netmem);
 #else
@@ -493,6 +494,10 @@ static inline void page_pool_set_pp_info(struct page_pool *pool,
 					 netmem_ref netmem)
 {
 }
+static inline bool page_pool_set_dma_addr_netmem(netmem_ref netmem,
+						 dma_addr_t addr)
+{
+}
 static inline void page_pool_clear_pp_info(netmem_ref netmem)
 {
 }
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index bd7f33d02652..3d1ed8b8f79e 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -655,6 +655,22 @@ void page_pool_clear_pp_info(netmem_ref netmem)
 	netmem_set_pp(netmem, NULL);
 }
 
+bool page_pool_set_dma_addr_netmem(netmem_ref netmem, dma_addr_t addr)
+{
+	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA) {
+		netmem_set_dma_addr(netmem, addr >> PAGE_SHIFT);
+
+		/* We assume page alignment to shave off bottom bits,
+		 * if this "compression" doesn't work we need to drop.
+		 */
+		return addr != (dma_addr_t)netmem_get_dma_addr(netmem)
+				       << PAGE_SHIFT;
+	}
+
+	netmem_set_dma_addr(netmem, addr);
+	return false;
+}
+
 static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
 							 netmem_ref netmem)
 {
diff --git a/net/core/page_pool_priv.h b/net/core/page_pool_priv.h
index 11a45a5f3c9c..cac300c83e29 100644
--- a/net/core/page_pool_priv.h
+++ b/net/core/page_pool_priv.h
@@ -13,23 +13,6 @@ int page_pool_list(struct page_pool *pool);
 void page_pool_detached(struct page_pool *pool);
 void page_pool_unlist(struct page_pool *pool);
 
-static inline bool
-page_pool_set_dma_addr_netmem(netmem_ref netmem, dma_addr_t addr)
-{
-	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA) {
-		netmem_set_dma_addr(netmem, addr >> PAGE_SHIFT);
-
-		/* We assume page alignment to shave off bottom bits,
-		 * if this "compression" doesn't work we need to drop.
-		 */
-		return addr != (dma_addr_t)netmem_get_dma_addr(netmem)
-				       << PAGE_SHIFT;
-	}
-
-	netmem_set_dma_addr(netmem, addr);
-	return false;
-}
-
 static inline bool page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
 {
 	return page_pool_set_dma_addr_netmem(page_to_netmem(page), addr);
-- 
2.43.5



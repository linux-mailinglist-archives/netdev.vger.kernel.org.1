Return-Path: <netdev+bounces-152759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 007DF9F5BC0
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 01:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49394188957B
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 00:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1935F7082E;
	Wed, 18 Dec 2024 00:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="wlYzYFlw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A3A5FEE6
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 00:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734482287; cv=none; b=bs0UjVMTm8sb+GBQujen/rP6Muc5k9BYhC9yl0I9t/tTDg0EJMnUY2cOshLA/vsZRj8RRpsqPFGsmR0ERuZpY9+ji+fvk8TFdMwL9hwCDe3JbJzuexGhxUj+IN+cgxxcoP2bUv2w5k936B0SMY3oYYPAnbqop5sQckLEpDMJIx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734482287; c=relaxed/simple;
	bh=uPSiaeh6DtHd5VRMdyGgXwFwrt2HnMjLjuGJrg5Ylco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MfCQOEa9EYwY8zu5lrWJAq3oXY4WUR9S5U+srjZe4QppiFlHm732G5uQKHoZAkCopu+94wQMzMWWB6SEA/SRvxQRQDet+/L56EZA3lA2suj5d5r2wP7WfrgFvSV5PJDe35KMHL1dxnyeFOZURLJ9L6scu2xW+bDYM+OjM++ZvEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=wlYzYFlw; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2161eb95317so54856525ad.1
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 16:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1734482285; x=1735087085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQ0gxue1w/Dl+jX0cfhVJPh/MBAFHEZUjUzY9/gknQk=;
        b=wlYzYFlwzC7B7N1t+bkxXGKgez2Qq78Q5HHqq/NGw35f0VrYNJPz8WiSa7LrfWkbBU
         dhGWORqE1kUYn7wb7yc2eiJ3PVnvF3mPTqV/BEdNBEY4qrGiWGLmsgOcLgzqdT7iGQcb
         dvUp8+mnkuvh1xUQ8PL4zYPg2CzW4yZSZpw4pJLRVN6vijHhgc3P/haRJkoeP+hEiQzQ
         AAMitippFXNiX8gKaePp/qrMqZIRKc3ZCtcetSbHvIOPIsWcSg/S7MxPXiPlEIt2DLjU
         H5uTavLV7sap3SUugaEoKRRh3ijjt0+HvQvG5Q7lzYcIatSxYzsKDn1EqNG/KrqDsPNM
         cZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734482285; x=1735087085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQ0gxue1w/Dl+jX0cfhVJPh/MBAFHEZUjUzY9/gknQk=;
        b=N+6g48ub0n2SPTteb+dGyh8I9G5a9VzjCCpsLBerX3/P7CEVWdx3qaWpApLeRWIImD
         YHCx+0wAU3lEIb9hysgQjMlc8IDNDC4burUCpryigsmrbLknM3DUzfIII7WOW7M57XUn
         0CnIbteKV/X/GkmsfO7+hMseZWQ7B+1AqBLJb/2ZAgkhgLKNUcaqTxZT/17nBMpJKpmf
         H+xrfXUVrjXZv9ol3wA9NHXRv9zEMHwTiz/jQeegWMyvN9lcDoyPSOgg8TDdbRLgrB9N
         AAn3yMT6lK/Sb/RdqmaXvybj9RV81jRjOKxxoHJ847gfLU1e0p4GihHz/Tjv+lm9ScMe
         0WaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXm3G0y+BSrKJtEzz5a2Ntta6UL+9loc+kAPgBkZWGyHrbCAL/VFBX2hMd/jSDWlezYo5ULkkY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/PM9NT55A62zFJNb+DHfdYBsgnrMKIOqGq+uj3qkNLGsLGAzQ
	euQYaFJjVGLPNe3roGtYjzeChi3oXpjSMtKfAx07KJNfprDpGBx54kWoGRqcNCA=
X-Gm-Gg: ASbGncvKHerMilkQ5biAUitkecR9e8ohI/OeC43FZVe45c4iIX64KoYV271MrjpkNwu
	gwa6yCxL3YBQ2/ezPTVlOEozeQcex9JGNVKDhO1hptvU2DjUXXR2amdzewthqsvv5cDO8EUXGu0
	4S3rhBx7PaCuIAv2W1Hx6NodWDSC/xcyN/xYEmYFP4WXjFc9+JrjmgaKddKc/LMJgqbxk3W7XAl
	zOkCcv1TuIIlsXDneCowfyF2ySle/l8dZsUhkXuXg==
X-Google-Smtp-Source: AGHT+IF263LqxEpg2kL0USvJQC0hWKInn1I93+k0bqBXdHYZk1LYQyelqDgccvsESwAXqztJWYW15A==
X-Received: by 2002:a17:902:e5ca:b0:216:3436:b87e with SMTP id d9443c01a7336-218d72437ccmr11411065ad.44.1734482285091;
        Tue, 17 Dec 2024 16:38:05 -0800 (PST)
Received: from localhost ([2a03:2880:ff:20::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e5011bsm65265705ad.152.2024.12.17.16.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 16:38:04 -0800 (PST)
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
Subject: [PATCH net-next v9 08/20] net: expose page_pool_{set,clear}_pp_info
Date: Tue, 17 Dec 2024 16:37:34 -0800
Message-ID: <20241218003748.796939-9-dw@davidwei.uk>
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

From: Pavel Begunkov <asml.silence@gmail.com>

Memory providers need to set page pool to its net_iovs on allocation, so
expose page_pool_{set,clear}_pp_info to providers outside net/.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/net/page_pool/helpers.h | 13 +++++++++++++
 net/core/page_pool_priv.h       |  9 ---------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index e555921e5233..872947179bae 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -483,4 +483,17 @@ static inline void page_pool_nid_changed(struct page_pool *pool, int new_nid)
 		page_pool_update_nid(pool, new_nid);
 }
 
+#if defined(CONFIG_PAGE_POOL)
+void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem);
+void page_pool_clear_pp_info(netmem_ref netmem);
+#else
+static inline void page_pool_set_pp_info(struct page_pool *pool,
+					 netmem_ref netmem)
+{
+}
+static inline void page_pool_clear_pp_info(netmem_ref netmem)
+{
+}
+#endif
+
 #endif /* _NET_PAGE_POOL_HELPERS_H */
diff --git a/net/core/page_pool_priv.h b/net/core/page_pool_priv.h
index 57439787b9c2..11a45a5f3c9c 100644
--- a/net/core/page_pool_priv.h
+++ b/net/core/page_pool_priv.h
@@ -36,18 +36,9 @@ static inline bool page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
 }
 
 #if defined(CONFIG_PAGE_POOL)
-void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem);
-void page_pool_clear_pp_info(netmem_ref netmem);
 int page_pool_check_memory_provider(struct net_device *dev,
 				    struct netdev_rx_queue *rxq);
 #else
-static inline void page_pool_set_pp_info(struct page_pool *pool,
-					 netmem_ref netmem)
-{
-}
-static inline void page_pool_clear_pp_info(netmem_ref netmem)
-{
-}
 static inline int page_pool_check_memory_provider(struct net_device *dev,
 						  struct netdev_rx_queue *rxq)
 {
-- 
2.43.5



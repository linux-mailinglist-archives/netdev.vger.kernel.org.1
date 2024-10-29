Return-Path: <netdev+bounces-140163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936649B5668
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 00:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A5FDB21713
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 23:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B584920C002;
	Tue, 29 Oct 2024 23:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="d2frfurz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF97620C012
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 23:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730243170; cv=none; b=JTgflgRHWQriDtPUwG0xQlqeS4uXpmAGi94e9nhVnNGswEIdCXzBKblOzCWN43+tAbcGptH+AEiDlUmcZdEBWp8b9S/1+A00MuGu415H5H81bqV0ZE6qe8gHu5htniQKa/tijFIBKDPKu+LZIv5V8S27yikea7vNtebYgupY3Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730243170; c=relaxed/simple;
	bh=stlUgp33BwTRN/0cQTOTCoDhqZGc/HHCVuHNB1SnHKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYLUrdQt0sZXC5CXrbbAyD69M1cQjqhml5Fi43E6vy0TawPGZTEVKTUNrnIUMuRr+ult1SrbkqWDPVmj0f+Dc6ua9Df0EAK2xAbn6fmTyWfZHh3Pf/66EKDcL3sRtbLfu1lxA5MQr7nXZKBzyBQr9MMC9DFjM5gg3g6mvaYdi18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=d2frfurz; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7db54269325so4490734a12.2
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 16:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1730243167; x=1730847967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKhajILgXPnH7N489X2OSTc+5BkU3eYPAK3guNmJgN4=;
        b=d2frfurzGiu+SFA3MBxCcN5cD5PdPOoYx3BJz0pClVPPS+geE/oDjLxiB9diQx4JBi
         vF+Bat06+YfuN+nsQ4eOHliGdUqYcdf9h4Lec/Zh4PmxQrv4H5OgxcFVGSR9LkzXXusa
         iQrHOmuoRjERPPio2wqzI6FjgZuDMmHtdPZPF1XtiOIkA0a03dsea1vJxkaKoS3tZeFC
         24HmLRsMgzLDpE4aBruToVIu5WPmrbiN9uSE22VZTwYh1BhTV2dXIgOI66Q2tUlhVDzZ
         2dBto9djLCK8wFcSVlUdZdoQ7vT5ffnQ0ejohizXMcMjMEM2SWfxcol1t/Tqxl/oq5RO
         W5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730243167; x=1730847967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kKhajILgXPnH7N489X2OSTc+5BkU3eYPAK3guNmJgN4=;
        b=s0ehHDmwFWzeVqZ1xeR3pyUz5FAo6KpGIR2aIj3iI+/trSws8/b7yWmDndr9DmwgCC
         MWvb28zS766JDlLCg26A8ClWqFKhffu3curEkWIQ3OaefRifFYV6sXZpIrJfKFd+JtTd
         KFS5O7k1USb7xBQheq0qqQn9CwCVb5EflvJWnxVwZYuqHzfyTStD1/SpKNI5tbBMPo77
         Y8BDO633RKRrloDPI/2HDjdAiJ4LAs5seHNNx2MaFXr2XFRdIEZna8dOtMw1lXRksZeJ
         Bk+a3tKhvxQMRzSgmpFI0vo5Q/XH6rnPFCmqLuOlsCTwYjVtV3fmPSQi7hahFlLzDsns
         3o4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXY+qTbVIliz9NWmRse8QTcU79rjGL70JS6vSt3T7HBlm/i/16BRrld0XGY3LbPJXSj9UuPQSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMRYjZ1fOn3GXMrxU7OBsieT/HqV17EnOFWlshQbRNNaSgpkLP
	gGh06HFJOYXnWwYUVMfckjzwuZP92Sq8ghtajlnVuAZ9XJkaBLWAEtfbOfJKAyc=
X-Google-Smtp-Source: AGHT+IFKq9rWBt4cvk/yDhXhh+xoR+B2yrWeOrfM5fMiR5plRwcI2P/zJU2Cz3e3qfWrlkA83yK5fA==
X-Received: by 2002:a05:6a20:6d0a:b0:1d9:c679:2b0 with SMTP id adf61e73a8af0-1d9c67903d5mr8966233637.12.1730243167392;
        Tue, 29 Oct 2024 16:06:07 -0700 (PDT)
Received: from localhost (fwdproxy-prn-016.fbsv.net. [2a03:2880:ff:10::face:b00c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057931a06sm8099610b3a.55.2024.10.29.16.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 16:06:07 -0700 (PDT)
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
Subject: [PATCH v7 07/15] net: page_pool: introduce page_pool_mp_return_in_cache
Date: Tue, 29 Oct 2024 16:05:10 -0700
Message-ID: <20241029230521.2385749-8-dw@davidwei.uk>
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

Add a helper that allows a page pool memory provider to efficiently
return a netmem off the allocation callback.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/net/page_pool/memory_provider.h |  4 ++++
 net/core/page_pool.c                    | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/net/page_pool/memory_provider.h b/include/net/page_pool/memory_provider.h
index 83d7eec0058d..352b3a35d31c 100644
--- a/include/net/page_pool/memory_provider.h
+++ b/include/net/page_pool/memory_provider.h
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
 #ifndef _NET_PAGE_POOL_MEMORY_PROVIDER_H
 #define _NET_PAGE_POOL_MEMORY_PROVIDER_H
 
@@ -7,4 +9,6 @@ int page_pool_mp_init_paged_area(struct page_pool *pool,
 void page_pool_mp_release_area(struct page_pool *pool,
 				struct net_iov_area *area);
 
+void page_pool_mp_return_in_cache(struct page_pool *pool, netmem_ref netmem);
+
 #endif
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 8bd4a3c80726..9078107c906d 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -1213,3 +1213,22 @@ void page_pool_mp_release_area(struct page_pool *pool,
 		page_pool_release_page_dma(pool, net_iov_to_netmem(niov));
 	}
 }
+
+/*
+ * page_pool_mp_return_in_cache() - return a netmem to the allocation cache.
+ * @pool:	pool from which pages were allocated
+ * @netmem:	netmem to return
+ *
+ * Return already allocated and accounted netmem to the page pool's allocation
+ * cache. The function doesn't provide synchronisation and must only be called
+ * from the napi context.
+ */
+void page_pool_mp_return_in_cache(struct page_pool *pool, netmem_ref netmem)
+{
+	if (WARN_ON_ONCE(pool->alloc.count >= PP_ALLOC_CACHE_REFILL))
+		return;
+
+	page_pool_dma_sync_for_device(pool, netmem, -1);
+	page_pool_fragment_netmem(netmem, 1);
+	pool->alloc.cache[pool->alloc.count++] = netmem;
+}
-- 
2.43.5



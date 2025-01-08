Return-Path: <netdev+bounces-156462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2583CA067DB
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 23:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8706F1883325
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 22:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83643204F7A;
	Wed,  8 Jan 2025 22:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="dN+BxL+h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A48204F72
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 22:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736374036; cv=none; b=Ka92JIf7yYaTG7CtZf0SBnZkq9eq+qTSZDFyKpoIbilh87FccnQ2Jz5ERjXIj3po/amkPthmuWcIGubmp93vrHCjgYNLE3jvQ1aF8vctYqMTXefnI4pTEVsXGEcoJc7dKTDNedxG4/waQSnyhn3B3zLiMbzbeiqVWy0ounj68Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736374036; c=relaxed/simple;
	bh=BvfCg8XrKhKo+Hk/JZ2OOE7Gn15jev1hzSbcDK9JqTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZLZ/2h8xK/0TyamgBDmAiKcIDLQzdPQ14VrVPaBhuO6CHGEDVCAcUxCmDtJWwy3P18koqeTAdSLZR38a5WqSNpEs6ehp6neDVJTZG52IfqQGi8LqwWuWHYcgz9xjBpZrxGHqPumVgbXEOVeqgSw4Cvk/eXgXSapO+au5yyC27I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=dN+BxL+h; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ee786b3277so381877a91.1
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 14:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1736374033; x=1736978833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOwH1TpuoWZADqKN7mEhLSZxCObxMi7MjYf6hC9Eb50=;
        b=dN+BxL+hHm1w4Nb+CcA4G9t09t/zwCQBrlB1KvSLx4ksZzOI2qgj/fxDRoWXRM5ope
         f+fsZrfv0EfARkLZt9kwyNeG+KSQtEBuaM1d79YUh5xJ5D2G7bViZaQ//QlqH5hUGG9H
         i9UXD7b6RxUvhBFhTr+DcQlsv1AthLxgbNvCmLo2D71XkSB5d4QEjAizNaqen7hGt0Hk
         4y4WSEN0bLEwa8pz0yyv9xO1oWxfYj8YFcRhCppYV35qOjUcC22lsKr1drpKnUEPmEhm
         V8ajrqMF99hAxNaETvXEPVSMe0yqOB9QLRXan57hEKoiNHt5kep9ZA4Iqz2kgxQjmije
         8M/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736374033; x=1736978833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOwH1TpuoWZADqKN7mEhLSZxCObxMi7MjYf6hC9Eb50=;
        b=gBgSXD6WVRH8rXpRisDD1XYZ5G/AxzbueTF3NhOEORJeuufuMZXe2e/QjhnYUBwoyo
         g8F7Oi3aI1IIb8SABseHVb7/YrYNN7YXXyvRstLHPjT/tSsZCBSQE8RslQyShq5Rp1tO
         YpSq2P/2EqX02cE78EfUkft4rVzpBF3Wzpey2VJeZdzkpp6mQdJ5Kse/twgleHYcAW7z
         7X/GRsEuul9EsjNfGF/EssrSATps/XI9Br3Xsi9+lSWRgmK9nkI8cLfZYfJi6pM1ocP0
         kSuiAAyfit8NsdvaasWCM243paJ27NjYmVOPNxKhQ/EWw9RbkeaUqiMmBLtQhtPTRsep
         orCA==
X-Forwarded-Encrypted: i=1; AJvYcCX7a7b48kjYkUr81EGP2VlECqyHWzazHtbEmtZkGOUE6S5Vht7Q1xvzBCPqHBKlSYz/fmtB+hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYOjn6R9kBZLZtV9KnhHgcZQtbn0I5P5FYdzarrZCuH+c7E1sv
	qNeqO2mL2vi91KJ5cYwie8KvHI2oAFlDRVI2G1XoU0N575bODr/hjTOmI1fKB98=
X-Gm-Gg: ASbGnctoEO449r/R1QP+2b0iJ/0rM2dX2eFyx51RQ0U4GLMH+AzhGzCvC3NLxfChp83
	nCLsUlGHk3KZlqQRT0mijslMhA6jGlUdiaKekmqi4PLC0Wo7YhnXEOyJvERuqE4iAOtR/+6MOqH
	P0G4X9ZsfvMTYGHRPjXmJPfsz9lsjOG6Ud8kDtRLmA/yqyIKwkT2aPoJKa+gTDMXGJglZh9t9XA
	HouxvmBPUL3bEVK2U1BBwJS4jg9Hgap/PJHbbrY
X-Google-Smtp-Source: AGHT+IGUwFlPuQwssBrA77nLgmuppWrqbXs2hiwqrPLXGXlmES2mfWsoRU0mbok3y06DaBxzYzsStw==
X-Received: by 2002:a17:90a:d64f:b0:2ee:94d1:7a89 with SMTP id 98e67ed59e1d1-2f548ea62aemr6394544a91.1.1736374033276;
        Wed, 08 Jan 2025 14:07:13 -0800 (PST)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f54a2f4d55sm2077432a91.51.2025.01.08.14.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 14:07:12 -0800 (PST)
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
Subject: [PATCH net-next v10 08/22] net: page_pool: add callback for mp info printing
Date: Wed,  8 Jan 2025 14:06:29 -0800
Message-ID: <20250108220644.3528845-9-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250108220644.3528845-1-dw@davidwei.uk>
References: <20250108220644.3528845-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavel Begunkov <asml.silence@gmail.com>

Add a mandatory callback that prints information about the memory
provider to netlink.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/net/page_pool/memory_provider.h |  5 +++++
 net/core/devmem.c                       | 10 ++++++++++
 net/core/netdev-genl.c                  | 11 ++++++-----
 net/core/page_pool_user.c               |  5 ++---
 4 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/include/net/page_pool/memory_provider.h b/include/net/page_pool/memory_provider.h
index 79412a8714fa..5f9d4834235d 100644
--- a/include/net/page_pool/memory_provider.h
+++ b/include/net/page_pool/memory_provider.h
@@ -10,11 +10,16 @@
 #include <net/netmem.h>
 #include <net/page_pool/types.h>
 
+struct netdev_rx_queue;
+struct sk_buff;
+
 struct memory_provider_ops {
 	netmem_ref (*alloc_netmems)(struct page_pool *pool, gfp_t gfp);
 	bool (*release_netmem)(struct page_pool *pool, netmem_ref netmem);
 	int (*init)(struct page_pool *pool);
 	void (*destroy)(struct page_pool *pool);
+	int (*nl_fill)(void *mp_priv, struct sk_buff *rsp,
+		       struct netdev_rx_queue *rxq);
 };
 
 #endif
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 48833c1dcbd4..c0bde0869f72 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -395,9 +395,19 @@ bool mp_dmabuf_devmem_release_page(struct page_pool *pool, netmem_ref netmem)
 	return false;
 }
 
+static int mp_dmabuf_devmem_nl_fill(void *mp_priv, struct sk_buff *rsp,
+				    struct netdev_rx_queue *rxq)
+{
+	const struct net_devmem_dmabuf_binding *binding = mp_priv;
+	int type = rxq ? NETDEV_A_QUEUE_DMABUF : NETDEV_A_PAGE_POOL_DMABUF;
+
+	return nla_put_u32(rsp, type, binding->id);
+}
+
 static const struct memory_provider_ops dmabuf_devmem_ops = {
 	.init			= mp_dmabuf_devmem_init,
 	.destroy		= mp_dmabuf_devmem_destroy,
 	.alloc_netmems		= mp_dmabuf_devmem_alloc_netmems,
 	.release_netmem		= mp_dmabuf_devmem_release_page,
+	.nl_fill		= mp_dmabuf_devmem_nl_fill,
 };
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 2d3ae0cd3ad2..4bc05fb27890 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -10,6 +10,7 @@
 #include <net/sock.h>
 #include <net/xdp.h>
 #include <net/xdp_sock.h>
+#include <net/page_pool/memory_provider.h>
 
 #include "dev.h"
 #include "devmem.h"
@@ -368,7 +369,6 @@ static int
 netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 			 u32 q_idx, u32 q_type, const struct genl_info *info)
 {
-	struct net_devmem_dmabuf_binding *binding;
 	struct netdev_rx_queue *rxq;
 	struct netdev_queue *txq;
 	void *hdr;
@@ -385,15 +385,16 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 	switch (q_type) {
 	case NETDEV_QUEUE_TYPE_RX:
 		rxq = __netif_get_rx_queue(netdev, q_idx);
+		struct pp_memory_provider_params *params;
+
 		if (rxq->napi && nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID,
 					     rxq->napi->napi_id))
 			goto nla_put_failure;
 
-		binding = rxq->mp_params.mp_priv;
-		if (binding &&
-		    nla_put_u32(rsp, NETDEV_A_QUEUE_DMABUF, binding->id))
+		params = &rxq->mp_params;
+		if (params->mp_ops &&
+		    params->mp_ops->nl_fill(params->mp_priv, rsp, rxq))
 			goto nla_put_failure;
-
 		break;
 	case NETDEV_QUEUE_TYPE_TX:
 		txq = netdev_get_tx_queue(netdev, q_idx);
diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index 8d31c71bea1a..bd017537fa80 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -7,9 +7,9 @@
 #include <net/netdev_rx_queue.h>
 #include <net/page_pool/helpers.h>
 #include <net/page_pool/types.h>
+#include <net/page_pool/memory_provider.h>
 #include <net/sock.h>
 
-#include "devmem.h"
 #include "page_pool_priv.h"
 #include "netdev-genl-gen.h"
 
@@ -214,7 +214,6 @@ static int
 page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
 		  const struct genl_info *info)
 {
-	struct net_devmem_dmabuf_binding *binding = pool->mp_priv;
 	size_t inflight, refsz;
 	void *hdr;
 
@@ -244,7 +243,7 @@ page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
 			 pool->user.detach_time))
 		goto err_cancel;
 
-	if (binding && nla_put_u32(rsp, NETDEV_A_PAGE_POOL_DMABUF, binding->id))
+	if (pool->mp_ops && pool->mp_ops->nl_fill(pool->mp_priv, rsp, NULL))
 		goto err_cancel;
 
 	genlmsg_end(rsp, hdr);
-- 
2.43.5



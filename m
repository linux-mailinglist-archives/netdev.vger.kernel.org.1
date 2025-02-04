Return-Path: <netdev+bounces-162763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEA0A27DE8
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 22:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625C73A6826
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 21:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC3A21C17B;
	Tue,  4 Feb 2025 21:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="0KewW2DQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F1421B18B
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 21:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738706192; cv=none; b=sm2Sb7+EV/87DU1jvgfwNXmqdPUYodNIEIUUBsodOAqmAL8PVxR6i8OYtekzZH+FR0gxN9cGRQ5HUubrv3xujz0gSIK3l4ZkQMRBdSMfJ1d4SVaO3Afsv1ynBP3BwN+Ui66YCUsaPWKMLPm9dBHI+TDYge01LAWFeEaSUvfzV/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738706192; c=relaxed/simple;
	bh=cwr/uINJIRGEk6puk3yj3oy/axiwQJMW5fmJKx7ZmAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNbm34BcH+VNqWvNGEb730yWL02QcHHoxbE4tbQjgWym4AbxDWhgbGmC5v13e/BZwi+OIJ9kbvlaeZIVAGBw/rMSJ0zpEjHgMU3XQ8FIPadXf+uyRCmrrMDpPCCYdVC3yb5CUOQ6Dn6Ec/SqDODqEpA8l3osW3Xz533+AC/trWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=0KewW2DQ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21669fd5c7cso111695765ad.3
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 13:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1738706190; x=1739310990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYyvUQb7OoVlPjPLuelYlwYke/iL4QRP4ZkF3M/sZ3s=;
        b=0KewW2DQtAQBzaYIQhjXP3W0UEarNQDbxeKx2jWTDYPm1R/7uHXLnoidW7hxQLKuMX
         eG/OQJgaBqQhPJlLEa1DV05aUA3Qf92DWkK2f9fON+RkryLqFZS4ymeIDU4DFYCf4VDB
         fmAKWPoJEyuhRbOeTaDB0O/vYVWpny/vgjeQSvKgiTy3E9zClcmzA4O4IbQiSlMLLle0
         XsJa4URLaYCF2J+7DwC5RUcrJd8XQq0RCpoiT5speG/Vx1l8coJpMvcXMPyNP04tT4EG
         R51v/vqBImxGcCpS5urjfG45QyUtNl1b+J+pGEPBkpC1KmSeiITtYdC5ozVsZgueZ6CK
         k71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738706190; x=1739310990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IYyvUQb7OoVlPjPLuelYlwYke/iL4QRP4ZkF3M/sZ3s=;
        b=ILGiEIR1jo7uJV+EWpAnyt0eRkjMVilNspx0kzKTAqrCzbf1prMqTDswnUhekXwdDI
         Wdc+wRZx9LxGJDH1tH2kZ3OoLNqqa2GgPk3N9JAIhWxwCEI2InMoM2S1tLxSpWHM31LP
         ISZVVrxBmDEDkVvaCYxCjYisFSmpd1xEyu++Z83z2WonpgehxhvMRKL6l5RC1pJHk3vn
         IsTOvMkcRPxyuUpINiGEXxdP780ALlbKWkqUGdCjJ6VFWTCH4g3hRVI6JetrEH1nxzp1
         a/7opiEhwbhukXTotXQH5AxqHcf8on6+/A4hthl8ZmHko1JReDYC2luu558nZ5y8B7+/
         8vxQ==
X-Gm-Message-State: AOJu0YztVroUsMWgZigNPCbGx37hu6vTtVWEhfExOOwRTYdr+t0V5hw2
	Am2n57sSH3CEOF9q+sqRY+hMAsZpVYfj4dGegHStuQ69XYS/ddXgtQcqBDDaFUmqQz2P2Qf+nYM
	G
X-Gm-Gg: ASbGncvHMEqY7Led/WzIOBlfzbTk5joHL0iAaxVK32oMv5UfILS7bOSOW1N0q7QQHYf
	vZt1PQKq35rSKrRdU5qd5e9DSblr10HEHGzKJvMhNtlBGM9b7t2EZphC4H96RdJwpZAJgVugLiu
	MEbCYqZoHhPhL18Uxpc8h5asxo9k9+YSIbyHxkXEDJ9iYibD9kbCcsus3OCiLeXDgucjyNqOGMv
	gLqzkHLBM9NFuCwCFISSWijJeveFvw/Eor/ZI5msjnRKI0M2Sgp7YeFS906S1MVHUxl1hs3Vmg=
X-Google-Smtp-Source: AGHT+IFbdI6LPbRYj8oFr8xHMtENhnI2TMzfXgrhOgMB2oIJ80an0Hyi0mQxyJ5AvIYjY7RA+lvRhA==
X-Received: by 2002:a05:6a00:1411:b0:72a:bc54:be9e with SMTP id d2e1a72fcca58-730351ec0c5mr664744b3a.15.1738706190175;
        Tue, 04 Feb 2025 13:56:30 -0800 (PST)
Received: from localhost ([2a03:2880:ff:3::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe631be20sm11086030b3a.34.2025.02.04.13.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 13:56:29 -0800 (PST)
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
Subject: [PATCH net-next v13 06/10] net: page_pool: add callback for mp info printing
Date: Tue,  4 Feb 2025 13:56:17 -0800
Message-ID: <20250204215622.695511-7-dw@davidwei.uk>
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

Add a mandatory callback that prints information about the memory
provider to netlink.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/net/page_pool/memory_provider.h |  5 +++++
 net/core/devmem.c                       | 10 ++++++++++
 net/core/netdev-genl.c                  | 11 ++++++-----
 net/core/page_pool_user.c               |  5 ++---
 4 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/include/net/page_pool/memory_provider.h b/include/net/page_pool/memory_provider.h
index e49d0a52629d..6d10a0959d00 100644
--- a/include/net/page_pool/memory_provider.h
+++ b/include/net/page_pool/memory_provider.h
@@ -5,11 +5,16 @@
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
index c81625ca57c6..63b790326c7d 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -406,9 +406,19 @@ bool mp_dmabuf_devmem_release_page(struct page_pool *pool, netmem_ref netmem)
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
index 715f85c6b62e..5b459b4fef46 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -10,6 +10,7 @@
 #include <net/sock.h>
 #include <net/xdp.h>
 #include <net/xdp_sock.h>
+#include <net/page_pool/memory_provider.h>
 
 #include "dev.h"
 #include "devmem.h"
@@ -368,7 +369,7 @@ static int
 netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 			 u32 q_idx, u32 q_type, const struct genl_info *info)
 {
-	struct net_devmem_dmabuf_binding *binding;
+	struct pp_memory_provider_params *params;
 	struct netdev_rx_queue *rxq;
 	struct netdev_queue *txq;
 	void *hdr;
@@ -385,15 +386,15 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 	switch (q_type) {
 	case NETDEV_QUEUE_TYPE_RX:
 		rxq = __netif_get_rx_queue(netdev, q_idx);
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
index d5e214c30c31..9d8a3d8597fa 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -8,9 +8,9 @@
 #include <net/netdev_rx_queue.h>
 #include <net/page_pool/helpers.h>
 #include <net/page_pool/types.h>
+#include <net/page_pool/memory_provider.h>
 #include <net/sock.h>
 
-#include "devmem.h"
 #include "page_pool_priv.h"
 #include "netdev-genl-gen.h"
 
@@ -216,7 +216,6 @@ static int
 page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
 		  const struct genl_info *info)
 {
-	struct net_devmem_dmabuf_binding *binding = pool->mp_priv;
 	size_t inflight, refsz;
 	unsigned int napi_id;
 	void *hdr;
@@ -249,7 +248,7 @@ page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
 			 pool->user.detach_time))
 		goto err_cancel;
 
-	if (binding && nla_put_u32(rsp, NETDEV_A_PAGE_POOL_DMABUF, binding->id))
+	if (pool->mp_ops && pool->mp_ops->nl_fill(pool->mp_priv, rsp, NULL))
 		goto err_cancel;
 
 	genlmsg_end(rsp, hdr);
-- 
2.43.5



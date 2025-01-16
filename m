Return-Path: <netdev+bounces-159092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7126BA14557
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 00:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9265216A87A
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 23:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84704246A16;
	Thu, 16 Jan 2025 23:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="nhRfmHda"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB962459DF
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 23:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737069448; cv=none; b=Yzq/aBSbqsMn4m9SErtRfbesEvy/b1dVsytiT4BjnP7BpdV2Ed+yHoF06XyPCvtFRWVX3K7i0od50bYSvL0XYJxlfStl8n6pW3l7MkgLx/X9CzK31YlCawojPh4fX0PyX6rtoKKmeesKfl3OmPQdYbXnCsnJVgXPKuVlkPRD028=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737069448; c=relaxed/simple;
	bh=aaiuE7B0Uw9ab/FPPlzbqlWb3TL6spaAqgcWcyjNhxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FkIocoK8GHWs2YjvIYo7tX4iUG9v5rgmEeVTpzau6ZfpWpTdbNvPiuElKOVVLiJ6/MBD0ZUsF8w9xRaP+588Gu3DdGGdm0XwcwFvSPscxRkDcrkgX8PLC8jJ5kiMjAUBoyNBTdOw2q6Aiy+RtzKfTAue5LORgHmHkL2TwEnsEpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=nhRfmHda; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21a7ed0155cso23470095ad.3
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 15:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1737069446; x=1737674246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwASS/pkxGxpaFbA4C1raSo9vng4y3SjehvEloDLjXY=;
        b=nhRfmHdadOWuX97rWflDkVYa7gIOxKnECfRyDJ4cwpbfPxBfOBA5Fjlv2HBTKLjizr
         9keEYf9U4DSRXaBj7wusydF+6aOAjM+3VQgiBsoU/KmMZxoxlVWNwI+ZqQTYyPxGx8P+
         pCiFzwy9I4HiLmI21+OiPApqS+cORsPGOyKSG5sA2vBF857CLcaD6S5c9JGvt2huprgQ
         fk90NStPmWziTKvjr2bM9rk4Za7NgV3Vl4J4XU27pH/lHpGMGJEjn1eX4C2HyIVXCh7a
         6a3Jlz7cf6SkT6RRDGsWj45R1HWqg2xyMFF/Hsd4kWl56eHu/2pmzhiyTlA4W4CN42Px
         pySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737069446; x=1737674246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwASS/pkxGxpaFbA4C1raSo9vng4y3SjehvEloDLjXY=;
        b=Wk4w/ughK3+ePU62S6LxtZHgzZB0qWJK455eS7g73y/RaTPU2jvof6xAOGkXlwX0kU
         4edXQQbK+CCaZ9fSGhRde5JwAXF5Dd4j6ZcdQ6EycYkf/QJm7BOyLf3WiMLG7A9AbMUj
         91qLjO8aG2gL5kDLxWzT6R1POo+JW7CR/2abXcEZ0y+aeZEe3dIZBdOgrtAB5D/cUdN+
         nDProDpQJdfdqmL0bPejnUO4midsJwZCkblFGR+mnGxCJn1XGCgzoX78x39CPZ+KH9mm
         j5S7sT9v8DxFGsUSYGzRDjRHTy4ev7YU2DxG6pp0JADsHXLKhHNZi6P4JPXmTaxc4cb5
         Ex5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEOlI+v1d0xpW0FZt/0NDIBuQ1r+KnVy+k0ztHaUlzYkR2Tc+LFCTOy//Zm8OxIbmwmsTRL7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkbyHZRiGSoatunD4of9VIOtjO6ZRWCi8XU9SEGw8Cj+tm4AkJ
	IHpdxprPfeXdJcONI6eLmSycjOCbQ9HafWvNT3fF3MATWCDJ4ALoCMA8b2T3Pdc=
X-Gm-Gg: ASbGncuk+Jej7bcSaWsp82Lvx5iHlJ2O3z9osAvEj+iZ7GWn0vvU4lFH5zXVbQomm43
	qM0gFx0bL9Xl7M6mqF5VhbOCq6axb/f2n40alCDgubdu2YZsr/KatiiXHkQ2uYRZwuXr0QRU56S
	X6sSH69YCY+XsLl/Dkm9xigpQCiyq864mbPDN5HzdGO4YMsptSFtSW1WEpdl1ZqFurPi95sAsTB
	hmw5kll4JaX4pI3hmoSAGqRoqyMQZOFuZRBppImApM5EC2NSyN1OA==
X-Google-Smtp-Source: AGHT+IGWPRJrAGpTE9j1xAdi52aAn8Lrq8yYbBH7KWYEm/w6Up58D7ZFXVzSE2VV3k7HIRyIC29zgQ==
X-Received: by 2002:a05:6a00:3c8a:b0:725:f4c6:6b68 with SMTP id d2e1a72fcca58-72daf93116bmr997647b3a.4.1737069446466;
        Thu, 16 Jan 2025 15:17:26 -0800 (PST)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72daba4895csm544961b3a.130.2025.01.16.15.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 15:17:26 -0800 (PST)
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
Subject: [PATCH net-next v11 17/21] io_uring/zcrx: set pp memory provider for an rx queue
Date: Thu, 16 Jan 2025 15:16:59 -0800
Message-ID: <20250116231704.2402455-18-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250116231704.2402455-1-dw@davidwei.uk>
References: <20250116231704.2402455-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set the page pool memory provider for the rx queue configured for zero
copy to io_uring. Then the rx queue is reset using
netdev_rx_queue_restart() and netdev core + page pool will take care of
filling the rx queue from the io_uring zero copy memory provider.

For now, there is only one ifq so its destruction happens implicitly
during io_uring cleanup.

Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 io_uring/zcrx.c | 47 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 8 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index cecfb04a117c..0cfa8c0ecff8 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -11,11 +11,12 @@
 #include <net/page_pool/helpers.h>
 #include <net/page_pool/memory_provider.h>
 #include <net/netlink.h>
-
-#include <trace/events/page_pool.h>
+#include <net/netdev_rx_queue.h>
 #include <net/tcp.h>
 #include <net/rps.h>
 
+#include <trace/events/page_pool.h>
+
 #include <uapi/linux/io_uring.h>
 
 #include "io_uring.h"
@@ -275,8 +276,32 @@ static void io_zcrx_drop_netdev(struct io_zcrx_ifq *ifq)
 	spin_unlock(&ifq->lock);
 }
 
+static void io_close_queue(struct io_zcrx_ifq *ifq)
+{
+	struct net_device *netdev;
+	netdevice_tracker netdev_tracker;
+	struct pp_memory_provider_params p = {
+		.mp_ops = &io_uring_pp_zc_ops,
+		.mp_priv = ifq,
+	};
+
+	if (ifq->if_rxq == -1)
+		return;
+
+	spin_lock(&ifq->lock);
+	netdev = ifq->netdev;
+	netdev_tracker = ifq->netdev_tracker;
+	ifq->netdev = NULL;
+	spin_unlock(&ifq->lock);
+
+	if (netdev)
+		net_mp_close_rxq(netdev, ifq->if_rxq, &p);
+	ifq->if_rxq = -1;
+}
+
 static void io_zcrx_ifq_free(struct io_zcrx_ifq *ifq)
 {
+	io_close_queue(ifq);
 	io_zcrx_drop_netdev(ifq);
 
 	if (ifq->area)
@@ -291,6 +316,7 @@ static void io_zcrx_ifq_free(struct io_zcrx_ifq *ifq)
 int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 			  struct io_uring_zcrx_ifq_reg __user *arg)
 {
+	struct pp_memory_provider_params mp_param = {};
 	struct io_uring_zcrx_area_reg area;
 	struct io_uring_zcrx_ifq_reg reg;
 	struct io_uring_region_desc rd;
@@ -341,7 +367,6 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 		goto err;
 
 	ifq->rq_entries = reg.rq_entries;
-	ifq->if_rxq = reg.if_rxq;
 
 	ret = -ENODEV;
 	ifq->netdev = netdev_get_by_index(current->nsproxy->net_ns, reg.if_idx,
@@ -358,16 +383,20 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 	if (ret)
 		goto err;
 
+	mp_param.mp_ops = &io_uring_pp_zc_ops;
+	mp_param.mp_priv = ifq;
+	ret = net_mp_open_rxq(ifq->netdev, reg.if_rxq, &mp_param);
+	if (ret)
+		goto err;
+	ifq->if_rxq = reg.if_rxq;
+
 	reg.offsets.rqes = sizeof(struct io_uring);
 	reg.offsets.head = offsetof(struct io_uring, head);
 	reg.offsets.tail = offsetof(struct io_uring, tail);
 
 	if (copy_to_user(arg, &reg, sizeof(reg)) ||
-	    copy_to_user(u64_to_user_ptr(reg.region_ptr), &rd, sizeof(rd))) {
-		ret = -EFAULT;
-		goto err;
-	}
-	if (copy_to_user(u64_to_user_ptr(reg.area_ptr), &area, sizeof(area))) {
+	    copy_to_user(u64_to_user_ptr(reg.region_ptr), &rd, sizeof(rd)) ||
+	    copy_to_user(u64_to_user_ptr(reg.area_ptr), &area, sizeof(area))) {
 		ret = -EFAULT;
 		goto err;
 	}
@@ -444,6 +473,8 @@ void io_shutdown_zcrx_ifqs(struct io_ring_ctx *ctx)
 
 	if (ctx->ifq)
 		io_zcrx_scrub(ctx->ifq);
+
+	io_close_queue(ctx->ifq);
 }
 
 static inline u32 io_zcrx_rqring_entries(struct io_zcrx_ifq *ifq)
-- 
2.43.5



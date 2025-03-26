Return-Path: <netdev+bounces-177677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F17A71275
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 09:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6AFC1896858
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 08:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68FD171C9;
	Wed, 26 Mar 2025 08:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/sR19bV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCE416C850
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 08:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742977143; cv=none; b=ip7mb/EyD0wJE2ERPuTMxQHYqERJmxZ7MLpL3u+KhVb3GXK0dksCmiQuR03h1kvu1U+uZce8HH0yM/G6Za4nrZrTenYfmlwpFjTkMEuuMAXObqBKtuCcMPl32tEwGtA6TYVePvzmpzXxafVNXTSyECYL/b3mmCntOh7cpkItkLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742977143; c=relaxed/simple;
	bh=vSoD9pwpfcSbP4dGBoxGCSAK3A6a6LNtloWC3DjyTGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V14k3mCWZug2shFmJGnsVPNebDaqIbFSFWLHTTBTOv+4IUziSD62s0L0WNE0N5cK/5SQ91kvd+mZeQ8KmJsB0fwfgiN/2vSQX/vzEQ9boVf/My7IqmBip5ZW7qnhjohkdmhdxobLwZ8rDVDegDXQ64XTcKMkohtfePLxOnwz1pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O/sR19bV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742977140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pOTdxZD/uqiBEKSTfpgx9RU52PQylymJns53moyygZc=;
	b=O/sR19bV54AzrwpWli1rvN1VtvjGUNYNP2vlZRaH75mzqbmVZRp7RgO1Dm7F/QTw+3fH9n
	HiH+iXqxTpdZuP4NTe19t9H4RVFvKcAaBpRigpkbEHPVBxKkI9F3kBSyUCNS9DFf8k1yzn
	lx5/3AJo1TPsszYy1CXBYPfyFRdTb4E=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-s8M4MuzhNzC4DP6ftPkWqQ-1; Wed, 26 Mar 2025 04:18:59 -0400
X-MC-Unique: s8M4MuzhNzC4DP6ftPkWqQ-1
X-Mimecast-MFC-AGG-ID: s8M4MuzhNzC4DP6ftPkWqQ_1742977138
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5e6c14c0a95so4858950a12.0
        for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 01:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742977138; x=1743581938;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOTdxZD/uqiBEKSTfpgx9RU52PQylymJns53moyygZc=;
        b=qB9Tj6NnfNPh2NEuKc/ip1Xn/cZsOsmGSIt4MZqIsW0bcJhOd2gu2CA/uQTG++UQvg
         R3qgUaHJrkgn22xpMGnxH7bqSJB8mtMhrxjepjRZAEydpecf8BYaoNWiSingF14oR8i/
         E2q0lVtgYPAmmYQzXtEe+EIkv/l+JWrpHE2G+MIG5iHOkvDoS79cDGk6hWIbQ7NZiaeT
         mzi05R5UNJI4BqFJ+91XstFL/KxdPwBQL+/fiLUYOex3G/w6d7T08Gfmorw6oFJXsOBA
         xwdgxMEa4fjfm5ZSw0xt41L+emZNLJ+0p/Zt0WWB3H34MfKJaVvy2jlXu0FRZjTNIV2t
         Ud3A==
X-Gm-Message-State: AOJu0YxZN03JVZx3rxQVNDwCNFncaQC3XKiFfK9VhRNa5we9PPNENWJH
	xkBallNo98gJeZ4vKiPo37P/Pi2YcgFZqdU17uPv6GxHdGot8Ea6xYipo14Fy4Eby6tNXGo/Gwj
	I2RY05+QOnHXWSnfv0bo27pVSkxpnCbLFTg4YWsFxOOjoA+2X93TFrw==
X-Gm-Gg: ASbGnctKjzmSUHGsWndjpLeNExVerhu6SOj4YcxwgYorwReI9Y8SmaWRWBcQa7GGcG7
	JxPrwzHjjYWSSVatQ9Gctf3vi20bLXrzPQmxw+uRS//NSEwR/L6YugvqKlNYVfQs9An0XY3ilIv
	ZvYYVdpWvSTyVIcQv+ngIWk4AfXlS2g/KYI/nrk9RMB8w5bxOBN3mTD20defyu/7vZnVK+kYjdP
	2uk9gFzh8oJPKOKoDCm1qG5WI7ApVIPcpSu4wpg401yaWwaGozIaCTj2d1fxA5ZO6LJ3B+QKWTm
	s/YQSyL3S0sP5VabdUcXghMPRtWOwn+Kx+qbtdur
X-Received: by 2002:a05:6402:2345:b0:5ed:1909:d422 with SMTP id 4fb4d7f45d1cf-5ed1909d5d6mr4532637a12.2.1742977137788;
        Wed, 26 Mar 2025 01:18:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbdeo79z8qV2b7AKSc5yQktiHryMqsZHBcfBd1BlUWJgmAJ39Ce+nU2q92PUFekHQpyPfq7Q==
X-Received: by 2002:a05:6402:2345:b0:5ed:1909:d422 with SMTP id 4fb4d7f45d1cf-5ed1909d5d6mr4532610a12.2.1742977137314;
        Wed, 26 Mar 2025 01:18:57 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebccfae189sm8870097a12.37.2025.03.26.01.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 01:18:56 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 5291A18FC9CE; Wed, 26 Mar 2025 09:18:54 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Wed, 26 Mar 2025 09:18:39 +0100
Subject: [PATCH net-next v3 2/3] page_pool: Turn dma_sync into a full-width
 bool field
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250326-page-pool-track-dma-v3-2-8e464016e0ac@redhat.com>
References: <20250326-page-pool-track-dma-v3-0-8e464016e0ac@redhat.com>
In-Reply-To: <20250326-page-pool-track-dma-v3-0-8e464016e0ac@redhat.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Mina Almasry <almasrymina@google.com>, 
 Yonglong Liu <liuyonglong@huawei.com>, 
 Yunsheng Lin <linyunsheng@huawei.com>, 
 Pavel Begunkov <asml.silence@gmail.com>, 
 Matthew Wilcox <willy@infradead.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org, 
 linux-mm@kvack.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.14.2

Change the single-bit boolean for dma_sync into a full-width bool, so we
can read it as volatile with READ_ONCE(). A subsequent patch will add
writing with WRITE_ONCE() on teardown.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Tested-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/net/page_pool/types.h | 6 +++---
 net/core/page_pool.c          | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index df0d3c1608929605224feb26173135ff37951ef8..d6c93150384fbc4579bb0d0afb357ebb26c564a3 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -173,10 +173,10 @@ struct page_pool {
 	int cpuid;
 	u32 pages_state_hold_cnt;
 
-	bool has_init_callback:1;	/* slow::init_callback is set */
+	bool dma_sync;				/* Perform DMA sync for device */
+	bool dma_sync_for_cpu:1;		/* Perform DMA sync for cpu */
 	bool dma_map:1;			/* Perform DMA mapping */
-	bool dma_sync:1;		/* Perform DMA sync for device */
-	bool dma_sync_for_cpu:1;	/* Perform DMA sync for cpu */
+	bool has_init_callback:1;	/* slow::init_callback is set */
 #ifdef CONFIG_PAGE_POOL_STATS
 	bool system:1;			/* This is a global percpu pool */
 #endif
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index acef1fcd8ddcfd1853a6f2055c1f1820ab248e8d..fb32768a97765aacc7f1103bfee38000c988b0de 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -466,7 +466,7 @@ page_pool_dma_sync_for_device(const struct page_pool *pool,
 			      netmem_ref netmem,
 			      u32 dma_sync_size)
 {
-	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev))
+	if (READ_ONCE(pool->dma_sync) && dma_dev_need_sync(pool->p.dev))
 		__page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
 }
 

-- 
2.48.1



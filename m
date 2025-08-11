Return-Path: <netdev+bounces-212538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D84AEB21212
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 18:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460F2622EEC
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 16:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8084E296BB6;
	Mon, 11 Aug 2025 16:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Du53Ffud"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21F3296BA4
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754929719; cv=none; b=nCc8mzUxuVWY1rQE0EsDocxM3Z2yYWBChO9qfRI8f+81f0CR0C5ZynL3kMlbJz6eoHsj9j6HrAY6SCALMQ2V5lnIVMDjSndSjQIradkDEAtvR5F70igH0SGa+IaSPtSaMHEwfs/nslFxhPvwomkEd0XMeJKWVO/5A7sV9fgb8Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754929719; c=relaxed/simple;
	bh=fMq9auiW2BEr/2lJq6b9Npp00isK+t+8CDgsd+AEtok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zc6LVpqsiJVvi74px02Oo3uZfHGp18GT49O/OWo4BHOdy9jlIvIJqkovMLuRYv12bzMa+pV12JMqm6NY8zxQZyknxPu33uvCNgNmeuOpI6iNSjpZTXISK4ws8YQPooZ/euqpP8RlsOQxRxqAAUBvqJycuKekY2njdxGdP9ED2u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Du53Ffud; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-459d44d286eso23892755e9.0
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 09:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754929715; x=1755534515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUI4Ic9KKaPcu/RPk7BuOe3LmPYhln5mpS28jft1E1s=;
        b=Du53FfudaK/Z/PrZqxXA8woi8l3DBcH4lFU4KTApXYqERW8+fBnbRx6e8guQ0dD6tw
         I9LAsS/0f2i0VlhfI/DZKnRo9VEeLEHDXuMlLsRXRvewrPoe1uaA0hmSzK1MfeVtifaq
         rEiEegEjAuUW87dvpXLHdN9VuKJYWW1aXw58upZrxz5y5BX8uyfQaAuN/XLoqwA1AVLB
         7vQrjzLMsHDU3c7/vituHrapRIxJzIxNmCXUc4Vk76+JQ9kaTxVHrcImbvwwwbCGK3Og
         Nj2B0WzU8ZxINnlK19DuVl2QqjEEezFUj7M4G4Sbc+IlYQgbSxBN4dAfn9P1R+WHGbeO
         d1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754929715; x=1755534515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUI4Ic9KKaPcu/RPk7BuOe3LmPYhln5mpS28jft1E1s=;
        b=IYjWHgBdjHecYfZBIrHIR2D+/GZMa2IIfAPkY5RGpmWzPfgMVYv7sJKp/XvBm9dpCY
         bRg7IWCbFIV8He7uozAJ9Y2oTi1VYSJzKSr6ziRJi5b0uZhD0xYtE9tWrPVWqcGdtRiW
         MQjjiIl/3LB2oKs6RMKF3yX4Xgg05KfJ6l4xLSdjYNgMvYTaK6eWXMCkCNPTOFcR+CUC
         5ffP+CjXD+5RiEXQesoQMib61Ps11PGlg0ZTWz7RF0payk6KWu9b2rNWQimRuYsNGTLM
         9lmrdtyK5D8Q9g/A4hMI5DEzOEfJ0JJNfiAdB6me738lOYqr4oZPOwMdM88UlNnZ4BfL
         bhqQ==
X-Gm-Message-State: AOJu0YxOEA75dxvP8tPwEbnahFYaeQQy1+xSoFsyC3aoyFhMFwvWPp0u
	lASRWCI/Plu+sdyZ1YAUyutcw147HyGYMConP/sxD/Ic+1a9zm9r3jEH/grbMA==
X-Gm-Gg: ASbGncu6fbG/MPtSJHeMY7Typq5bNLa5Zkgo3927PVIc2FBbKizJh60nEelnRkgju9e
	fIcD7k3EJ/HdPyg0n125QCmUgH1XHueUkBTq3esSFBHDuh4r6N8+4iIRJIPbt6KH86MX20kPm94
	BDJ/Bw80+CDNYzC8HtErurH0xaV62FzMyTlqi6/y5C0Hc2ro+M78gPKJ9YgtjQL1yHn8EHHmVa6
	2c66w0hII0e3NH3Itxt1w99tpteJKBkudw1l7DsjAK22k964d9gqONEpCERLipIM1yPmPkjJg62
	RdsPL5mo/S8g7/E8ixhhjNEQ4yP/Bh28srTnVqAT7blhoG+7Uy70PPwRgPR8qKMn8h8dWhL3u0g
	ve88BMg==
X-Google-Smtp-Source: AGHT+IGsXfOcmUwWt5Nk7NocwFfAFCf+rZx0BvM9tPO/9LbsopnD3OvuAseW/QqIMk9PadDsWNmKcQ==
X-Received: by 2002:a05:600c:1c98:b0:456:942:b162 with SMTP id 5b1f17b1804b1-45a10d966cfmr2356985e9.11.1754929715432;
        Mon, 11 Aug 2025 09:28:35 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:628b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58554f2sm260267515e9.12.2025.08.11.09.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 09:28:34 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Byungchul Park <byungchul@sk.com>,
	asml.silence@gmail.com
Subject: [RFC net-next v1 6/6] io_uring/zcrx: avoid netmem casts with nmdesc
Date: Mon, 11 Aug 2025 17:29:43 +0100
Message-ID: <7468b556ab5f9ac79f00a530464590e65f65e712.1754929026.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1754929026.git.asml.silence@gmail.com>
References: <cover.1754929026.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a bunch of hot path places where zcrx casts a net_iov to a
netmem just to pass it to a generic helper, which will immediately
remove NET_IOV from it. It's messy, and compilers can't completely
optimise it. Use newly introduced netmem_desc based helpers to avoid the
overhead.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index e5ff49f3425e..9c733a490122 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -301,7 +301,7 @@ static void io_zcrx_sync_for_device(const struct page_pool *pool,
 	if (!dma_dev_need_sync(pool->p.dev))
 		return;
 
-	dma_addr = page_pool_get_dma_addr_netmem(net_iov_to_netmem(niov));
+	dma_addr = page_pool_get_dma_addr_nmdesc(&niov->desc);
 	__dma_sync_single_for_device(pool->p.dev, dma_addr + pool->p.offset,
 				     PAGE_SIZE, pool->p.dma_dir);
 #endif
@@ -752,7 +752,6 @@ static void io_zcrx_ring_refill(struct page_pool *pp,
 {
 	unsigned int mask = ifq->rq_entries - 1;
 	unsigned int entries;
-	netmem_ref netmem;
 
 	spin_lock_bh(&ifq->rq_lock);
 
@@ -784,8 +783,7 @@ static void io_zcrx_ring_refill(struct page_pool *pp,
 		if (!io_zcrx_put_niov_uref(niov))
 			continue;
 
-		netmem = net_iov_to_netmem(niov);
-		if (page_pool_unref_netmem(netmem, 1) != 0)
+		if (page_pool_unref_nmdesc(&niov->desc, 1) != 0)
 			continue;
 
 		if (unlikely(niov->pp != pp)) {
@@ -794,7 +792,7 @@ static void io_zcrx_ring_refill(struct page_pool *pp,
 		}
 
 		io_zcrx_sync_for_device(pp, niov);
-		net_mp_netmem_place_in_cache(pp, netmem);
+		net_mp_netmem_place_in_cache(pp, net_iov_to_netmem(niov));
 	} while (--entries);
 
 	smp_store_release(&ifq->rq_ring->head, ifq->cached_rq_head);
@@ -950,7 +948,7 @@ static struct net_iov *io_zcrx_alloc_fallback(struct io_zcrx_area *area)
 	spin_unlock_bh(&area->freelist_lock);
 
 	if (niov)
-		page_pool_fragment_netmem(net_iov_to_netmem(niov), 1);
+		page_pool_fragment_nmdesc(&niov->desc, 1);
 	return niov;
 }
 
@@ -1070,7 +1068,7 @@ static int io_zcrx_recv_frag(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
 	 * Prevent it from being recycled while user is accessing it.
 	 * It has to be done before grabbing a user reference.
 	 */
-	page_pool_ref_netmem(net_iov_to_netmem(niov));
+	page_pool_ref_nmdesc(&niov->desc);
 	io_zcrx_get_niov_uref(niov);
 	return len;
 }
-- 
2.49.0



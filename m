Return-Path: <netdev+bounces-29939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8B4785483
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 11:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A3041C20BB6
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 09:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB1CA955;
	Wed, 23 Aug 2023 09:48:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2C4A92F
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 09:48:03 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251F9128
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 02:48:02 -0700 (PDT)
Date: Wed, 23 Aug 2023 11:47:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1692784080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=J/qrEyStB/EbDwp39Zj5wIHFsVReCcFwb8tljX55cMk=;
	b=i7WK3LV/JKVHj4cCCJ7ZhL4+uzYJsHirI5UpsmaPRBr6uxc08BP0YDKx9MSejlLDhvugYs
	+OeuFZcOYEfXzXGLg3syZFpXp/vljVuXBxIGmnlFQOFY4u7w5HyYh+SmYTfcnCgbCkMZ2F
	87ErwcGeIYaRk+kmlNBZDsR7+PJmfHO0+gwd3MeFg6EAQ8QrzcYNfQETn4ER+a/AcW9nfD
	++qrt0eedxsQtWuWl0R7DIFlAJlYFebgwd7tpwcQW40GT6evnPGd3N+q/AfoKvo3QwClyg
	dBGgmvTGuRxcJmJlCXW7kyKF0wZceqCOKjZnBYmZMkuM0ti20UIleX2lPa79tg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1692784080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=J/qrEyStB/EbDwp39Zj5wIHFsVReCcFwb8tljX55cMk=;
	b=ubEcJaCUW2qxIZJianrG4WgaTBJoNu6lh5RUdCeQPkKWqbpQklBXgMq9lozUhwPnDuhkrx
	KeL75Rdm+GpugABQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: netdev@vger.kernel.org, Ratheesh Kannoth <rkannoth@marvell.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	hariprasad <hkelam@marvell.com>
Subject: [BUG] Possible unsafe page_pool usage in octeontx2
Message-ID: <20230823094757.gxvCEOBi@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

I've been looking at the page_pool locking.

page_pool_alloc_frag() -> page_pool_alloc_pages() ->
__page_pool_get_cached():

There core of the allocation is:
|         /* Caller MUST guarantee safe non-concurrent access, e.g. softirq */
|         if (likely(pool->alloc.count)) {
|                 /* Fast-path */
|                 page = pool->alloc.cache[--pool->alloc.count];

The access to the `cache' array and the `count' variable is not locked.
This is fine as long as there only one consumer per pool. In my
understanding the intention is to have one page_pool per NAPI callback
to ensure this.

The pool can be filled in the same context (within allocation if the
pool is empty). There is also page_pool_recycle_in_cache() which fills
the pool from within skb free, for instance:
 napi_consume_skb() -> skb_release_all() -> skb_release_data() ->
 napi_frag_unref() -> page_pool_return_skb_page().

The last one has the following check here:
|         napi = READ_ONCE(pp->p.napi);
|         allow_direct = napi_safe && napi &&
|                 READ_ONCE(napi->list_owner) == smp_processor_id();

This eventually ends in page_pool_recycle_in_cache() where it adds the
page to the cache buffer if the check above is true (and BH is disabled). 

napi->list_owner is set once NAPI is scheduled until the poll callback
completed. It is safe to add items to list because only one of the two
can run on a single CPU and the completion of them ensured by having BH
disabled the whole time.

This breaks in octeontx2 where a worker is used to fill the buffer:
  otx2_pool_refill_task() -> otx2_alloc_rbuf() -> __otx2_alloc_rbuf() ->
  otx2_alloc_pool_buf() -> page_pool_alloc_frag().

BH is disabled but the add of a page can still happen while NAPI
callback runs on a remote CPU and so corrupting the index/ array.

API wise I would suggest to

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 7ff80b80a6f9f..b50e219470a36 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -612,7 +612,7 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
 			page_pool_dma_sync_for_device(pool, page,
 						      dma_sync_size);
 
-		if (allow_direct && in_softirq() &&
+		if (allow_direct && in_serving_softirq() &&
 		    page_pool_recycle_in_cache(page, pool))
 			return NULL;
 
because the intention (as I understand it) is to be invoked from within
the NAPI callback (while softirq is served) and not if BH is just
disabled due to a lock or so.

It would also make sense to a add WARN_ON_ONCE(!in_serving_softirq()) to
page_pool_alloc_pages() to spot usage outside of softirq. But this will
trigger in every driver since the same function is used in the open
callback to initially setup the HW.

Sebastian


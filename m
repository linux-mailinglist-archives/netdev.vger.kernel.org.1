Return-Path: <netdev+bounces-287065-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPD+NFEBA2rdzQEAu9opvQ
	(envelope-from <netdev+bounces-287065-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:30:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D9651E93C
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26335307B07E
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C2D349CC5;
	Tue, 12 May 2026 10:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QS02qgoF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31835349CDD
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 10:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778581531; cv=none; b=qDZdtSupuJNn7KkR2HeE4i66HiV6TxEcDxRM6v6Qdla3ZrtbN9m2tz832jhn/C/acSjbvM4q/pBgAYR4aD4IsPanUjJ8lJjOuRpYY9eJl1/pmm4rsQ9LLYeXOqNmpU2Gh2kmrOM6NnfCgv/8DrJmqxtnLhXtL7iItNS84QvWl00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778581531; c=relaxed/simple;
	bh=1vn5OdSwunYdWDdLRdg9aJHA90DFJiuaPYCr9qiNZwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SUztMlyWTlM+72Th+yaZuTbUHsl9HrNR9iBFPz6KuXQCC2AFY3ZyQ4pE2gF6GyqSNW8rVUuuWslAGLjGdcBb/wpViDZwbt6402ubcDyWsJxxGAhRt0AIqrdVxzUwU2cDKGEF5Iqyc6y6VekTePxLNKNGZsQypcn3GA1eFoEp6hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QS02qgoF; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488d2079582so56800025e9.2
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 03:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778581528; x=1779186328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XstbOyK4fmvp/hBZJymT61ZK4QhFZhfKKenEPwYfOXI=;
        b=QS02qgoFi/1ADbgPqXFbpQXGBht0PIfl+evb/eOyqtdpSJcDLwb+0Nx+ID9R68+/OU
         WO2j8/Ue9TrfhyvePQtOemVDhvZ4t365G+EMRu1wqD8NYCdhatRTJtp/Z0v1jStFOr+U
         NFJ1dhjjDW7l1sXR9huFXyAMBy0H9/nKyhud9DogKC9rUpRDNEi7/XM4uBsxz1e042FW
         MSIYTkv1t62JW6Ne5RI9bI18LVp7FP2ThKuuTBHci3s/7djxZj1dMxt64Sbjyn8yM+eK
         k5I8/BIGvqiJ5I6dUv0ub/93xlpHfDx628LmeblshwzdOtEp/WM10V16o9tREZ5DVg/l
         By8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778581528; x=1779186328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XstbOyK4fmvp/hBZJymT61ZK4QhFZhfKKenEPwYfOXI=;
        b=rrVxgpRlf37iU6cU+KFOLlgsBc38v+EIxt4WTVCaIUZu+bvk4sriL+v82fYyn5jG9m
         ofcD85zS9vSnQpIQ51fo3s6tmqPH0yktQ0W9W55RzLQ2mQair94PCL+dUpuwRF49kB7s
         BxbPpzTThGsSQZmLWWqYlw/JVlA3XGZJPbR2dXRELe6YOygRPXssuSm9aoUvCOHIG+NJ
         8tLawy8SjIXAxubZpXE1/F1w0uFDO1Ww3WSRNCAzJPcs5EqPMCDJSjCmC5cPu7IGvTgZ
         KKs3CFo85FlWY2MrK5qxlv8C4nmaZh5kjLKODT7bAim4na+t3byfjJk99cyOglax05KK
         z1gQ==
X-Forwarded-Encrypted: i=1; AFNElJ/4yrqN9SLAc6b/JUM4gZnqnI0+xbuhHKqvA7taggRut5jeYiobBRKILLrpFxzN4YRnB6fi8DE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVYonxquN9g8PMzwjMSaghPPFifJBAiU4L2w5E+7P9S0vcCtwh
	CNHRd20TUrNF1jWLr8dIg8opTOXSKFG0nd7/H8aDitC0NnmYRvxEy8Ta
X-Gm-Gg: Acq92OEQGhd8g5VdjThvBUIpXqVWg1pxSJsXl2Jy6re48zyxOWFrQ4EsU+HKZC3Krv4
	YLM7/nH2Tdn2KGRcAUEHhyWJE6OhqEuDV6yIJz5If4Y1S+/JmM77EMq15P1WjHv1hN9uCvI4XLi
	JmPN9lAqFivz/clAXikivU2/pE8GWrWAmnD6V+ZeuIdpgpbF7Dg/2qrOPlHTFE1ojRrwvYvGTi0
	gnUzlzqkn949Xqjg7C0cBYO1UAGsf/YYy+ESSB5iOqfnVhOi/lQSAvBSrrPhCWEKuxIP7Ly6tO+
	IIefU3Ksjsi7bXCCBsXPwTGTsUutMH//1YHN5OU9UVrBI8qQNILyGSC74NSznZSawY6r8kqMRvb
	KJtgsC1c5GexW/F7UJzzw9WCVQ9lLFjGF4/0rm55vpuvrjWb27SjV1SYLKppLzXtux2TqmWoSVZ
	CVguIV15wgmnFoOJHBCqgwOZTbbcFfhOStoGjqqvnXScrrEl+cOuvoUzvBe8tOtVBrcqbOVxq/S
	UnAAn1swarj2gaFzHvn
X-Received: by 2002:a05:600c:35d2:b0:487:4eb:d125 with SMTP id 5b1f17b1804b1-48e51e15589mr468390325e9.9.1778581528439;
        Tue, 12 May 2026 03:25:28 -0700 (PDT)
Received: from 127.net ([2620:10d:c092:600::1:8c90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e9052c9fesm74352255e9.1.2026.05.12.03.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 03:25:27 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [RFC 3/6] io_uring/zcrx: store area pointers in an array
Date: Tue, 12 May 2026 11:25:03 +0100
Message-ID: <b741a6a8df4af49128285859b9fc8999b973a810.1778581283.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778581283.git.asml.silence@gmail.com>
References: <cover.1778581283.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 54D9651E93C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-287065-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Currently, we have only a one area per zcrx instance, and struct
io_zcrx_ifq stores a single pointer. To prepare for adding more areas,
replace it with an array of areas.

We'll be creating them at runtime, and io_zcrx_append_area() will take
care of synchronisation. The array is protected by 3 locks: ->pp_lock,
->alloc_lock and ->rq.lock. It takes all of them when switching arrays,
and readers should hold either of them.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 112 ++++++++++++++++++++++++++++++++++--------------
 io_uring/zcrx.h |   5 ++-
 2 files changed, 85 insertions(+), 32 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 563bef1e724b..0ec491587a36 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -279,12 +279,12 @@ static int io_import_area(struct io_zcrx_ifq *ifq,
 	return io_import_umem(ifq, mem, area_reg);
 }
 
-static void io_zcrx_unmap_area(struct io_zcrx_ifq *ifq,
-				struct io_zcrx_area *area)
+static void io_zcrx_unmap_area(struct io_zcrx_ifq *ifq, struct io_zcrx_area *area)
 {
 	int i;
 
-	guard(mutex)(&ifq->pp_lock);
+	lockdep_assert_held(&ifq->pp_lock);
+
 	if (!area->is_mapped)
 		return;
 	area->is_mapped = false;
@@ -302,6 +302,17 @@ static void io_zcrx_unmap_area(struct io_zcrx_ifq *ifq,
 	}
 }
 
+static void io_zcrx_unmap_areas(struct io_zcrx_ifq *ifq)
+{
+	int area_idx;
+
+	/* ->pp_lock protect ->nr_areas and ->areas reads */
+	lockdep_assert_held(&ifq->pp_lock);
+
+	for (area_idx = 0; area_idx < ifq->nr_areas; area_idx++)
+		io_zcrx_unmap_area(ifq, ifq->areas[area_idx]);
+}
+
 static void zcrx_sync_for_device(struct page_pool *pp, struct io_zcrx_ifq *zcrx,
 				 netmem_ref *netmems, unsigned nr)
 {
@@ -410,7 +421,8 @@ static void io_free_rbuf_ring(struct io_zcrx_ifq *ifq)
 static void io_zcrx_free_area(struct io_zcrx_ifq *ifq,
 			      struct io_zcrx_area *area)
 {
-	io_zcrx_unmap_area(ifq, area);
+	scoped_guard(mutex, &ifq->pp_lock)
+		io_zcrx_unmap_area(ifq, area);
 	io_release_area_mem(&area->mem);
 
 	if (area->mem.account_pages)
@@ -427,13 +439,30 @@ static int io_zcrx_append_area(struct io_zcrx_ifq *ifq,
 				struct io_zcrx_area *area)
 {
 	bool kern_readable = !area->mem.is_dmabuf;
+	struct io_zcrx_area **areas, **old_areas;
+	unsigned old_nr;
 
-	if (WARN_ON_ONCE(ifq->area))
-		return -EINVAL;
 	if (WARN_ON_ONCE(ifq->kern_readable != kern_readable))
 		return -EINVAL;
 
-	ifq->area = area;
+	guard(mutex)(&ifq->pp_lock);
+	old_areas = ifq->areas;
+	old_nr = ifq->nr_areas;
+
+	areas = kmalloc_array(old_nr + 1, sizeof(areas[0]),
+			      GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+	if (!areas)
+		return -ENOMEM;
+	if (old_areas)
+		memcpy(areas, old_areas, old_nr * sizeof(areas[0]));
+	areas[old_nr] = area;
+
+	scoped_guard(spinlock_bh, &ifq->rq.lock) {
+		guard(spinlock_bh)(&ifq->alloc_lock);
+		ifq->areas = areas;
+		ifq->nr_areas = old_nr + 1;
+	}
+	kfree(old_areas);
 	return 0;
 }
 
@@ -540,8 +569,6 @@ static struct io_zcrx_ifq *io_zcrx_ifq_alloc(struct io_ring_ctx *ctx)
 
 static void io_zcrx_drop_netdev(struct io_zcrx_ifq *ifq)
 {
-	guard(mutex)(&ifq->pp_lock);
-
 	if (!ifq->netdev)
 		return;
 	netdev_put(ifq->netdev, &ifq->netdev_tracker);
@@ -576,13 +603,15 @@ static void io_close_queue(struct io_zcrx_ifq *ifq)
 
 static void io_zcrx_ifq_free(struct io_zcrx_ifq *ifq)
 {
+	int i;
+
 	if (WARN_ON_ONCE(ifq->if_rxq != -1))
 		return;
 	if (WARN_ON_ONCE(ifq->netdev != NULL))
 		return;
 
-	if (ifq->area)
-		io_zcrx_free_area(ifq, ifq->area);
+	for (i = 0; i < ifq->nr_areas; i++)
+		io_zcrx_free_area(ifq, ifq->areas[i]);
 	if (ifq->mm_account)
 		mmdrop(ifq->mm_account);
 	if (ifq->dev)
@@ -591,6 +620,7 @@ static void io_zcrx_ifq_free(struct io_zcrx_ifq *ifq)
 	io_free_rbuf_ring(ifq);
 	free_uid(ifq->user);
 	mutex_destroy(&ifq->pp_lock);
+	kfree(ifq->areas);
 	kfree(ifq);
 }
 
@@ -636,14 +666,10 @@ static void io_zcrx_return_niov(struct net_iov *niov)
 	page_pool_put_unrefed_netmem(niov->desc.pp, netmem, -1, false);
 }
 
-static void io_zcrx_scrub(struct io_zcrx_ifq *ifq)
+static void io_zcrx_scrub_area(struct io_zcrx_ifq *ifq, struct io_zcrx_area *area)
 {
-	struct io_zcrx_area *area = ifq->area;
 	int i;
 
-	if (!area)
-		return;
-
 	/* Reclaim back all buffers given to the user space. */
 	for (i = 0; i < area->nia.num_niovs; i++) {
 		struct net_iov *niov = &area->nia.niovs[i];
@@ -657,6 +683,15 @@ static void io_zcrx_scrub(struct io_zcrx_ifq *ifq)
 	}
 }
 
+static void io_zcrx_scrub(struct io_zcrx_ifq *ifq)
+{
+	int i;
+
+	guard(mutex)(&ifq->pp_lock);
+	for (i = 0; i < ifq->nr_areas; i++)
+		io_zcrx_scrub_area(ifq, ifq->areas[i]);
+}
+
 static void zcrx_unregister_user(struct io_zcrx_ifq *ifq)
 {
 	if (refcount_dec_and_test(&ifq->user_refs)) {
@@ -1019,12 +1054,15 @@ static inline bool io_parse_rqe(struct io_uring_zcrx_rqe *rqe,
 	unsigned niov_idx, area_idx;
 	struct io_zcrx_area *area;
 
+	lockdep_assert_held(&ifq->rq.lock);
+
 	area_idx = off >> IORING_ZCRX_AREA_SHIFT;
 	niov_idx = (off & ~IORING_ZCRX_AREA_MASK) >> ifq->niov_shift;
 
-	if (unlikely(rqe->__pad || area_idx))
+	if (unlikely(rqe->__pad || area_idx >= ifq->nr_areas))
 		return false;
-	area = ifq->area;
+	area_idx = array_index_nospec(area_idx, ifq->nr_areas);
+	area = ifq->areas[area_idx];
 
 	if (unlikely(niov_idx >= area->nia.num_niovs))
 		return false;
@@ -1080,18 +1118,24 @@ static unsigned io_zcrx_ring_refill(struct page_pool *pp,
 static unsigned io_zcrx_refill_slow(struct page_pool *pp, struct io_zcrx_ifq *ifq,
 				    netmem_ref *netmems, unsigned to_alloc)
 {
-	struct io_zcrx_area *area = ifq->area;
-	unsigned allocated = 0;
+	unsigned area_idx = 0;
+	unsigned allocated;
 
 	guard(spinlock_bh)(&ifq->alloc_lock);
 
-	for (allocated = 0; allocated < to_alloc; allocated++) {
-		struct net_iov *niov = zcrx_get_free_niov(area);
+	while (allocated < to_alloc) {
+		struct net_iov *niov = zcrx_get_free_niov(ifq->areas[area_idx]);
+
+		if (!niov) {
+			area_idx++;
+			if (area_idx >= ifq->nr_areas)
+				break;
+			continue;
+		}
 
-		if (!niov)
-			break;
 		net_mp_niov_set_page_pool(pp, niov);
 		netmems[allocated] = net_iov_to_netmem(niov);
+		allocated++;
 	}
 	return allocated;
 }
@@ -1178,9 +1222,9 @@ static void io_pp_uninstall(void *mp_priv, struct netdev_rx_queue *rxq)
 	struct pp_memory_provider_params *p = &rxq->mp_params;
 	struct io_zcrx_ifq *ifq = mp_priv;
 
+	guard(mutex)(&ifq->pp_lock);
 	io_zcrx_drop_netdev(ifq);
-	if (ifq->area)
-		io_zcrx_unmap_area(ifq, ifq->area);
+	io_zcrx_unmap_areas(ifq);
 
 	p->mp_ops = NULL;
 	p->mp_priv = NULL;
@@ -1319,16 +1363,22 @@ static bool io_zcrx_queue_cqe(struct io_kiocb *req, struct net_iov *niov,
 static struct net_iov *io_alloc_fallback_niov(struct io_zcrx_ifq *ifq)
 {
 	struct net_iov *niov = NULL;
+	unsigned area_idx;
 
 	if (!ifq->kern_readable)
 		return NULL;
 
-	scoped_guard(spinlock_bh, &ifq->alloc_lock)
-		niov = zcrx_get_free_niov(ifq->area);
+	guard(spinlock_bh)(&ifq->alloc_lock);
+
+	for (area_idx = 0; area_idx < ifq->nr_areas; area_idx++) {
+		niov = zcrx_get_free_niov(ifq->areas[area_idx]);
+		if (niov) {
+			page_pool_fragment_netmem(net_iov_to_netmem(niov), 1);
+			return niov;
+		}
+	}
 
-	if (niov)
-		page_pool_fragment_netmem(net_iov_to_netmem(niov), 1);
-	return niov;
+	return NULL;
 }
 
 struct io_copy_cache {
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index 687ca7c9f45b..85a15f4c04e3 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -49,7 +49,10 @@ struct zcrx_rq {
 };
 
 struct io_zcrx_ifq {
-	struct io_zcrx_area		*area;
+	/* read-protected by any of: ->pp_lock, ->alloc_lock, ->rq.lock */
+	struct io_zcrx_area		**areas;
+	unsigned			nr_areas;
+
 	unsigned			niov_shift;
 	struct user_struct		*user;
 	struct mm_struct		*mm_account;
-- 
2.53.0



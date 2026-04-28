Return-Path: <netdev+bounces-282014-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +H4PECHr8GmBbAEAu9opvQ
	(envelope-from <netdev+bounces-282014-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:15:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A424B489BD0
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C0023032740
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300B533F583;
	Tue, 28 Apr 2026 17:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCEoS+cb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804DF37BE8E
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 17:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777396142; cv=none; b=OHgQvPtNzizij6LCzOrmOYsmVeXymaI0JXMlmgphkzzpc2ABbOClPQ/pg6OMvwe2Y0muBgZGfn9Lw7HpTPqiWNcXmCO0ZZbAbGF3fzTEEmGdM8RhJWZF6GbpcF9ybI23qtNFbvEi1wPAVaV2RX+n8c0FK5OgcnjsFVjpmJgMWxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777396142; c=relaxed/simple;
	bh=8YLyXNnB0oYjgxp9TiGj9qYD9V/WfHzuABJsa8B7mgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dv4smHk4gFZl/DEAu1yBOOR8Nvi8G3n09sHAiG4SyUHztW2WQ6YxuWv4f1xT9XxDQAt81jrkc2YQsZzRw693pOsWImUnAP7AHX+zqaGZtE8BVs9QXCoXAsiQSo/ixpjEUz5gMQAyq7n2lqmfpMv7wGkEKm/E2qYqjyq/LZBuCZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCEoS+cb; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so143243055e9.2
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 10:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777396138; x=1778000938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hEFzS30I0lxmmb31xtJed7NArW5qRhMX/2eez5xcs/I=;
        b=SCEoS+cbU6ObFK6WGRhzkb6PpPXU+9cyRJEa+HN+OLzMlvSC43z3ce9FqL7E2NBvJ6
         3umfXA2UyhyV3Z/ZI5w9EA8elMb3psSUY3CKK67YgXyljZSJL9ENsR6WrHbdmByM6rUu
         a19XT626XFFl6dCrd5etugSvDE+J9TjNmOSj57kULA6I0AzWfmfhdxCNzhIdbj/EyW+N
         KrrEM/lNaTShp4d4U2RqUcTrccj5AIAp/naUp9NieXROI0VVY8g03ndyIfLB1mKLDnUY
         oeHEIFVIM0Z8CEQV6xkmxJ2Mef4lWW0Y9yTqXTstHPNnMMwYXQwoalhpRSXKkRyGQnP9
         mcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777396138; x=1778000938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEFzS30I0lxmmb31xtJed7NArW5qRhMX/2eez5xcs/I=;
        b=YCCoiPvPn2A+2EvkeLqnCSdEQyZb7gDj1eagZSL98szqP9RfYpX16JigLfviKcxvjr
         AqsHyG6sIp2N5pe2zsD5KhRPJTzsk4TTDt7SoXz1AYW8zqwsX2J/6osk63vv81EQ13Kj
         WtIohdHjZqtclahi30tahizFy80mQAe7pf9xRqNsdbmGETBJ2BzMlzA11LgVTuOAHFqi
         S+1jW/sHLvlIerzNNNFzN5CTOqKo/sgXPeaz8gad8YFX8zbtd3DKS+aHEs6Lgqcbd/hD
         g5sBteZUfrZAFUhETLvdE5llle3i/lrcIHmRhGjKedf6UINzd39pn84jcR8VLI+oG5uQ
         s2Nw==
X-Forwarded-Encrypted: i=1; AFNElJ+mJOgtCoFaTvzva6bGXPKCa4fydFvGuqdWJZ+omAqQSadw8hqywdi7E8foZAMHKpg1QPEqj4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlpHFZiXgypcni6mAzwtpRQgP7mCALy+RfyYSEs25VTKG8RxEJ
	GN5r8dMky1+Sx8ZVWUNuFtEf/Om9nQTUsMlY6CsRyO8TFZLn8cIZ5ZF8
X-Gm-Gg: AeBDiesnnQxjM6zv9oxsJrBucspm/X90d+3SjiGCPlUZJ0ofxmV2wFEQkJXmzdneetk
	tez/BSu+HMg+gufwLFrbLrH3m2bO6FGhY7VgjHljvdUopInW12MxrdOgcdsiCU1yv37GyKr+q+7
	5RsEuBQIYBmZ12SUY3lpQWMVTLj2Vm7XWg1zE6s9US3Q+CwmcBnnvdshLyBJAMcFM9jPsOxVeDP
	I5cf947x002vpoiKqiuK3EHyu6jJ0p/evIE2+8HWkk9DRT9uVVvo+jfe9nC20reFQ+RMG3TD1f2
	WCYeWIT2W5l3ol0OI+8J+9tAoy4zSZXs9jz4DnFNPvW89kXKgptcHkv4oFvsFHgyZ+u4YmkPM+w
	uwfXmsxS/Pe2wHeolvcYKKkjGlKKQL5KtLKBRO/T2MUGOpg3jwhrzY3txz/Je02OFl0QT57WdIP
	2VuM89XhIC0e5XB9gOYYuL3vqxbbgLmDY33zF0MYUR+0205L36weZSAhQnIer0u4ce3P1Wm4/IJ
	BWLswuu3K3jFOeyEHBBvQ==
X-Received: by 2002:a05:600c:630c:b0:486:d76c:fa57 with SMTP id 5b1f17b1804b1-48a77b0a60emr66577485e9.17.1777396138318;
        Tue, 28 Apr 2026 10:08:58 -0700 (PDT)
Received: from localhost.localdomain (200.178.141.77.rev.sfr.net. [77.141.178.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463d02f2a2sm7943324f8f.10.2026.04.28.10.08.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Apr 2026 10:08:57 -0700 (PDT)
From: Hasan Basbunar <basbunarhasan@gmail.com>
To: hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net
Cc: horms@kernel.org,
	almasrymina@google.com,
	asml.silence@gmail.com,
	kaiyuanz@google.com,
	willemb@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hasan Basbunar <basbunarhasan@gmail.com>
Subject: [PATCH] page_pool: fix memory-provider leak in page_pool_create_percpu() error path
Date: Tue, 28 Apr 2026 19:07:39 +0200
Message-ID: <20260428170739.34881-1-basbunarhasan@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A424B489BD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-282014-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[basbunarhasan@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

When page_pool_create_percpu() fails on page_pool_list(), it falls
through to its err_uninit: label, which calls page_pool_uninit().
At that point page_pool_init() has already taken two references
when the user requested PP_FLAG_ALLOW_UNREADABLE_NETMEM:

	pool->mp_ops->init(pool)
	static_branch_inc(&page_pool_mem_providers);

Neither is undone by page_pool_uninit(); both are only undone by
__page_pool_destroy() (success-side teardown). The error path
therefore leaks the per-provider reference taken by mp_ops->init
(io_zcrx_ifq->refs in the io_uring zcrx provider, the dmabuf
binding refcount in the devmem provider) plus one increment of
the page_pool_mem_providers static branch on every failure of
xa_alloc_cyclic() inside page_pool_list().

The leaked io_zcrx_ifq->refs in turn pins everything
io_zcrx_ifq_free() would release on cleanup: ifq->user (uid),
ifq->mm_account (mmdrop), ifq->dev (device refcount),
ifq->netdev_tracker (netdev refcount), and the rbuf region.
The leaked static branch increment forces all subsequent
page_pool_alloc_netmems() and page_pool_return_page() callers to
take the slow mp_ops branch for the lifetime of the kernel.

Reachable via the io_uring zcrx path:

	io_uring_register(IORING_REGISTER_ZCRX_IFQ)  /* CAP_NET_ADMIN */
	  -> __io_uring_register
	  -> io_register_zcrx
	  -> zcrx_register_netdev
	  -> netif_mp_open_rxq
	  -> driver ndo_queue_mem_alloc
	  -> page_pool_create_percpu
	    -> page_pool_init succeeds (mp_ops->init runs, branch++)
	    -> page_pool_list fails (xa_alloc_cyclic -ENOMEM)
	    -> goto err_uninit         <-- leak

The same shape applies to the devmem dmabuf provider via
mp_dmabuf_devmem_init()/mp_dmabuf_devmem_destroy().

Restore the cleanup symmetry by moving the mp_ops->destroy() and
static_branch_dec() calls out of __page_pool_destroy() and into
page_pool_uninit(), so page_pool_uninit() is again the strict
inverse of page_pool_init(). page_pool_uninit() has only two
callers (the err_uninit: path and __page_pool_destroy()), so this
preserves the single-call invariant on the success path while
fixing the err path. The error path of page_pool_init() itself
still skips the mp_ops cleanup correctly: mp_ops->init is the
last action that takes a reference before page_pool_init() returns
0, so when it returns an error neither the refcount nor the static
branch has been touched.

Triggering the bug requires xa_alloc_cyclic() to fail with -ENOMEM,
which under normal GFP_KERNEL retry behaviour is rare. It is
deterministic under CONFIG_FAULT_INJECTION with fail_page_alloc /
xa fault injection, or under sustained memory pressure. The leak
is silent: there is no warning, and the released kernel build
continues running with a permanently-incremented static branch.

Fixes: 0f9214046893 ("memory-provider: dmabuf devmem memory provider")
Signed-off-by: Hasan Basbunar <basbunarhasan@gmail.com>
---
 net/core/page_pool.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 877bbf7a1938..6e576dec80db 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -327,6 +327,11 @@ static void page_pool_uninit(struct page_pool *pool)
 	if (!pool->system)
 		free_percpu(pool->recycle_stats);
 #endif
+
+	if (pool->mp_ops) {
+		pool->mp_ops->destroy(pool);
+		static_branch_dec(&page_pool_mem_providers);
+	}
 }
 
 /**
@@ -1146,11 +1151,6 @@ static void __page_pool_destroy(struct page_pool *pool)
 	page_pool_unlist(pool);
 	page_pool_uninit(pool);
 
-	if (pool->mp_ops) {
-		pool->mp_ops->destroy(pool);
-		static_branch_dec(&page_pool_mem_providers);
-	}
-
 	kfree(pool);
 }
 
-- 
2.53.0



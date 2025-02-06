Return-Path: <netdev+bounces-163695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3F1A2B603
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 23:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50A9716314C
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 22:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221C51A5B94;
	Thu,  6 Feb 2025 22:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pult3Q98"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27442417C2
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 22:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738882614; cv=none; b=TFblzc5LHssNuCjgOcPCPBsqFFuqXj1NObZL8fsQBtpl8+hLqh+0+WpWK0FkNXxDsZezp6MVp0/psBoc0GPjRW4aaB/1DAh3D/U0Cf4AdGM1t9e+Vn8TgifVXqs0jLLs7m0r4KhHkv0aMSfNYnSH7G6BSn1sGQmSfPficq0nAEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738882614; c=relaxed/simple;
	bh=aQVqifDDLfTy/kPKJCug5LsaEptcu23/8jOmA6Y0OEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3YKi6yM9MMErMv+hDNXPN5v+fFA6Zhl/UWLQC0GVF6bHSFsQ5GNrEIoKNfCfb9p3+fI4hpUGWIl1eqkPvZdZpL4KVLZ+8iw4RKBlAGNRl4jpDbdT6a6EZkSTRRi2aU+3toew1KUQK0ukZOKC/wvOzaoS6u/V3cNI0995PtA3Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pult3Q98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3AAC4CEE5;
	Thu,  6 Feb 2025 22:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738882613;
	bh=aQVqifDDLfTy/kPKJCug5LsaEptcu23/8jOmA6Y0OEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pult3Q98ham6osDvltJXTyTugY4tf6B/BmhxvtzGSqndex0FQzbHrwTiqgjIOQESP
	 1bgSaFBIcRCGP/zM/tmV70Jqr51JQ0/tYiHCh8E+txtA+Yr5+pxSNvNE+ONvvSMJI3
	 6mxU1PCmm9Yai5HPvwY4SJoDDtE1PJuj7g6jfBhv19sx9Ijej5KxPlShZn/dPnhLve
	 5nRn/D3/OJMlkMUdSooDf32wLGgWKscdD1vAGmn6mhL3Pqx+S8d1jxSYZkedi+3igO
	 sAN/mCGCtCfe16TKHCBnZ6Ep/rJP8u8Wv3VK+gzj3wazt9Tr8uj+9qyJyK0v+XkB7h
	 DjuYMe8T/HgVg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	almasrymina@google.com,
	Jakub Kicinski <kuba@kernel.org>,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	jdamato@fastly.com
Subject: [PATCH net-next v2 3/4] net: page_pool: avoid false positive warning if NAPI was never added
Date: Thu,  6 Feb 2025 14:56:37 -0800
Message-ID: <20250206225638.1387810-4-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206225638.1387810-1-kuba@kernel.org>
References: <20250206225638.1387810-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We expect NAPI to be in disabled state when page pool is torn down.
But it is also legal if the NAPI is completely uninitialized.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2: new patch
v1: https://lore.kernel.org/20250205190131.564456-1-kuba@kernel.org

CC: hawk@kernel.org
CC: ilias.apalodimas@linaro.org
CC: jdamato@fastly.com
---
 net/core/dev.h       | 12 ++++++++++++
 net/core/page_pool.c |  7 ++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/core/dev.h b/net/core/dev.h
index a5b166bbd169..caa13e431a6b 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -299,6 +299,18 @@ void xdp_do_check_flushed(struct napi_struct *napi);
 static inline void xdp_do_check_flushed(struct napi_struct *napi) { }
 #endif
 
+/* Best effort check that NAPI is not idle (can't be scheduled to run) */
+static inline void napi_assert_will_not_race(const struct napi_struct *napi)
+{
+	/* uninitialized instance, can't race */
+	if (!napi->poll_list.next)
+		return;
+
+	/* SCHED bit is set on disabled instances */
+	WARN_ON(!test_bit(NAPI_STATE_SCHED, &napi->state));
+	WARN_ON(READ_ONCE(napi->list_owner) != -1);
+}
+
 void kick_defer_list_purge(struct softnet_data *sd, unsigned int cpu);
 
 #define XMIT_RECURSION_LIMIT	8
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index f5e908c9e7ad..b940c40ea2f2 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -25,6 +25,7 @@
 
 #include <trace/events/page_pool.h>
 
+#include "dev.h"
 #include "mp_dmabuf_devmem.h"
 #include "netmem_priv.h"
 #include "page_pool_priv.h"
@@ -1140,11 +1141,7 @@ void page_pool_disable_direct_recycling(struct page_pool *pool)
 	if (!pool->p.napi)
 		return;
 
-	/* To avoid races with recycling and additional barriers make sure
-	 * pool and NAPI are unlinked when NAPI is disabled.
-	 */
-	WARN_ON(!test_bit(NAPI_STATE_SCHED, &pool->p.napi->state));
-	WARN_ON(READ_ONCE(pool->p.napi->list_owner) != -1);
+	napi_assert_will_not_race(pool->p.napi);
 
 	mutex_lock(&page_pools_lock);
 	WRITE_ONCE(pool->p.napi, NULL);
-- 
2.48.1



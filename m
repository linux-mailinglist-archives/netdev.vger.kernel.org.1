Return-Path: <netdev+bounces-143484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5886B9C2982
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 03:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D595628378B
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 02:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BCD11C83;
	Sat,  9 Nov 2024 02:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muLAsyOa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A65436124
	for <netdev@vger.kernel.org>; Sat,  9 Nov 2024 02:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731119586; cv=none; b=LiH/AiNISLJINlqAjDOQ3GCKo5jJ70QVm/XyiDLenG/7SC9MFZAzH/EcX4itJrKcB5lnS7hi8sSDY0+IB4JKnjNl4x9WIPntC+RmcACTM1DpXsRgxRI7FoQhh7Qt+ltokfqIEb0tT/Ar+W8L4ilF777SWKEQIlkyTliOaIrsNIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731119586; c=relaxed/simple;
	bh=D4geBik0PQtO/GewgrLBIKe+2jD/TisPMo+Sej7oGXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N8S/ZmVmzmOWSGz5O1atplSfTUn2wUOSkPL/qxIMjW2gIpJpGl2Hk63n1rnDGIHiOSTL7M8ZvcDHSjfpkZe/XsMOXMriz76KTzdgCy2ClgocDWeLZq/Hl9rh0pVn/Ck+/HskzYKALo1Nq9Ba1MJ9LpJdXJILB+GDWvoUPrcEq4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muLAsyOa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E75AC4CECD;
	Sat,  9 Nov 2024 02:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731119585;
	bh=D4geBik0PQtO/GewgrLBIKe+2jD/TisPMo+Sej7oGXQ=;
	h=From:To:Cc:Subject:Date:From;
	b=muLAsyOascTv8clai4ExJDA8fqSnJ3wXxaxVcPaoq9r7/i99X2tr4NCCx8iaGtXJO
	 W7iPZWXOqcQFlnrp8brYxoYh90rT4B3SKrMRh/ElPjGfPvNpEjQQFFAHAUnra15mMQ
	 7cVMXGCgAU9jGOQWlGx2CgIqHNkPL/l0yWvXuhElTebuctgccg3pUM8bpCjR24EJfz
	 XDwRfIzDh5lUsjZgzYK9erCDfgiUoVeSwKygqiDJ1f35FrnvCwvQqsUz/ckLLZyFHM
	 FqfivOtVxoEryK4MsBMH1SLHvupaieSqLTpfyBHYssxE+3DaWlJKIRBgR6/HxjQUwp
	 2j17a/1XeVC5w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	lorenzo@kernel.org,
	wangjie125@huawei.com,
	huangguangbin2@huawei.com
Subject: [PATCH net-next] net: page_pool: do not count normal frag allocation in stats
Date: Fri,  8 Nov 2024 18:33:03 -0800
Message-ID: <20241109023303.3366500-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 0f6deac3a079 ("net: page_pool: add page allocation stats for
two fast page allocate path") added increments for "fast path"
allocation to page frag alloc. It mentions performance degradation
analysis but the details are unclear. Could be that the author
was simply surprised by the alloc stats not matching packet count.

In my experience the key metric for page pool is the recycling rate.
Page return stats, however, count returned _pages_ not frags.
This makes it impossible to calculate recycling rate for drivers
using the frag API. Here is example output of the page-pool
YNL sample for a driver allocating 1200B frags (4k pages)
with nearly perfect recycling:

  $ ./page-pool
    eth0[2]	page pools: 32 (zombies: 0)
		refs: 291648 bytes: 1194590208 (refs: 0 bytes: 0)
		recycling: 33.3% (alloc: 4557:2256365862 recycle: 200476245:551541893)

The recycling rate is reported as 33.3% because we give out
4096 // 1200 = 3 frags for every recycled page.

Effectively revert the aforementioned commit. This also aligns
with the stats we would see for drivers which do the fragmentation
themselves, although that's not a strong reason in itself.

On the (very unlikely) path where we can reuse the current page
let's bump the "cached" stat. The fact that we don't put the page
in the cache is just an optimization.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: hawk@kernel.org
CC: ilias.apalodimas@linaro.org
CC: lorenzo@kernel.org
CC: wangjie125@huawei.com
CC: huangguangbin2@huawei.com
---
 net/core/page_pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index a813d30d2135..f89cf93f6eb4 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -950,6 +950,7 @@ netmem_ref page_pool_alloc_frag_netmem(struct page_pool *pool,
 	if (netmem && *offset + size > max_size) {
 		netmem = page_pool_drain_frag(pool, netmem);
 		if (netmem) {
+			recycle_stat_inc(pool, cached);
 			alloc_stat_inc(pool, fast);
 			goto frag_reset;
 		}
@@ -974,7 +975,6 @@ netmem_ref page_pool_alloc_frag_netmem(struct page_pool *pool,
 
 	pool->frag_users++;
 	pool->frag_offset = *offset + size;
-	alloc_stat_inc(pool, fast);
 	return netmem;
 }
 EXPORT_SYMBOL(page_pool_alloc_frag_netmem);
-- 
2.47.0



Return-Path: <netdev+bounces-78542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 005DF875A0D
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 23:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 940FF1F21829
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 22:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C8D13B7A7;
	Thu,  7 Mar 2024 22:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oawyKyDk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BC4F4FC
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 22:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709849602; cv=none; b=F5+kTcHwV044IM5YItCFlYN4LJbnwVMLQgnfxu8zr65b8WQ/g4O1SVJNk96wC8ZT8OIshE8BjY24s9pGxAWqObGMu2e5LPyQ4sbysNTbX+5zCW9E6pjuqrkbX81YB/W+m87+5NRTKfCS+YfnSd0ZF01hkfy8zf6ZevnfzQKFXCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709849602; c=relaxed/simple;
	bh=NXp/VJlSX5gWHOl16OxdGk1E+53DTXPzfL1k+98ff8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HcyDOXuHm9AULzaBzsxctrLzKOAbJao6+DV+1As7AOq60M2o11GUr6LzqsqZskXKJySl8YOWTA1SkzyKbtgRhio+dgPCNcS4mY4SnuoFjSitu8ZNCKeknmqMOk+Eh6Oye2UGSSzbnt9hAPBOyXWV5ZwqEXfcXjmy0QBIwHLLnAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oawyKyDk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D78C433F1;
	Thu,  7 Mar 2024 22:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709849602;
	bh=NXp/VJlSX5gWHOl16OxdGk1E+53DTXPzfL1k+98ff8Q=;
	h=From:To:Cc:Subject:Date:From;
	b=oawyKyDkln/LJvOxlq32IBziWWoNJG7Ef4tyyurpQhdndx5AQKeT8BuEjdxJxJzau
	 Bu6KclCtTenayvuzG3ZJnB37bkk6exARH0CXBX1QRmygN+8LZUXYYF1NwqbjCBvILZ
	 9yg5WMhz23R61mGBzBAbvRwOWFkPpqtCmU5ADINCSTk0RIKDQsAhiGGiL8PrTFBg7z
	 AH7omr8ns0G2KNwXHFBk/2Gg0ZPd2qyCgNsYILdtOkF/cBP8mfl6x3kOYhKvUfq27L
	 y3icf2hIoFO5t6vsK3o/hDam37zGw2bZsJgF6CKXrTaPsePIZyMhDZu5qE5M2XFdC+
	 o5SUdsrteaDiA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	hawk@kernel.org
Subject: [PATCH net-next] ynl: samples: fix recycling rate calculation
Date: Thu,  7 Mar 2024 14:11:22 -0800
Message-ID: <20240307221122.2094511-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running the page-pool sample on production machines under moderate
networking load shows recycling rate higher than 100%:

$ page-pool
    eth0[2]	page pools: 14 (zombies: 0)
		refs: 89088 bytes: 364904448 (refs: 0 bytes: 0)
		recycling: 100.3% (alloc: 1392:2290247724 recycle: 469289484:1828235386)

Note that outstanding refs (89088) == slow alloc * cache size (1392 * 64)
which means this machine is recycling page pool pages perfectly, not
a single page has been released.

The extra 0.3% is because sample ignores allocations from the ptr_ring.
Treat those the same as alloc_fast, the ring vs cache alloc is
already captured accurately enough by recycling stats.

With the fix:

$ page-pool
    eth0[2]	page pools: 14 (zombies: 0)
		refs: 89088 bytes: 364904448 (refs: 0 bytes: 0)
		recycling: 100.0% (alloc: 1392:2331141604 recycle: 473625579:1857460661)

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: hawk@kernel.org
---
 tools/net/ynl/samples/page-pool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/net/ynl/samples/page-pool.c b/tools/net/ynl/samples/page-pool.c
index 098b5190d0e5..332f281ee5cb 100644
--- a/tools/net/ynl/samples/page-pool.c
+++ b/tools/net/ynl/samples/page-pool.c
@@ -95,6 +95,8 @@ int main(int argc, char **argv)
 
 		if (pp->_present.alloc_fast)
 			s->alloc_fast += pp->alloc_fast;
+		if (pp->_present.alloc_refill)
+			s->alloc_fast += pp->alloc_refill;
 		if (pp->_present.alloc_slow)
 			s->alloc_slow += pp->alloc_slow;
 		if (pp->_present.recycle_ring)
-- 
2.44.0



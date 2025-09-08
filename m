Return-Path: <netdev+bounces-220855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3AEB492F8
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 17:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E3154404AC
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 15:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A1530BF75;
	Mon,  8 Sep 2025 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbxiZ99F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB94304BA2;
	Mon,  8 Sep 2025 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757344887; cv=none; b=oRFjdF536xQIHCbMSXW2AKKrE/JhgPfuYUkCq7QBGZM3BilwAm+rrksD5YxrEH5cm5aqF1ICs27VmWlcpAz3GCCDfvCCCZHuUgAl3VVgEZEDgCTNK0l2ZRMfP7qXT1cs9fRB1+cG6LNbG5WIMcV18PaDLprp9CNuZTub+sfNw1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757344887; c=relaxed/simple;
	bh=OZYdUZ3F6fjaLvpJvs2wUT3CRDr/Uoo0+nPnQIDx9iM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZTc4nu7Y+HVTGQ5Wmpm/8w/cCpcYwUBLvc735bGIp1NqTM9fqelSINJeiS8YIiHyuMwuC0tcwqCdz+lcGd9HD0GkxLj/iliKQxQSuLMIeyExJbsuQMbKoj+drDz5ft4bM197BTsa9WUFK8nVj9SkotRRlcgBdauO3EK9bvwNytc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbxiZ99F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19AF4C4CEF1;
	Mon,  8 Sep 2025 15:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757344886;
	bh=OZYdUZ3F6fjaLvpJvs2wUT3CRDr/Uoo0+nPnQIDx9iM=;
	h=From:To:Cc:Subject:Date:From;
	b=mbxiZ99FTxf+pUeqyhMhwsLMESmbnzY3faUcsHhPyNut5cmiru8kMA7QOpuY+YtuI
	 t+DGPuOCYSZ2/Bu/rhP58qrYiIOHyxVv0zNQpuhpOQvlpZJyBAW2M4nSEsdGzWBVOn
	 tsC1Eeq0R8e3vOI4tPJzS54jfm1InhybiM8yYP2pimQpTBYvIfF09MakZnsJ+e2ZXU
	 PzRDhiPxPxJ9xa9c2fQpyPFXeDIad3OcxhlGwO0BCpiYpCjzU50scCSYRf7TkTXjlT
	 RX/6gcAYG5ba8rdS8iPrzuyIynfVZti7xuGWcXez3FBXThjNsG5l23H7WkT5HQ0pZg
	 +78P/Hw9vnZeg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	llvm@lists.linux.dev
Subject: [PATCH net-next] page_pool: always add GFP_NOWARN for ATOMIC allocations
Date: Mon,  8 Sep 2025 08:21:23 -0700
Message-ID: <20250908152123.97829-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver authors often forget to add GFP_NOWARN for page allocation
from the datapath. This is annoying to operators as OOMs are a fact
of life, and we pretty much expect network Rx to hit page allocation
failures during OOM. Make page pool add GFP_NOWARN for ATOMIC allocations
by default.

Don't compare to GFP_ATOMIC because it's a mask with 2 bits set.
We want a single bit so that the compiler can do an unconditional
mask and shift. clang builds the condition as:

    1c31: 89 e8                        	movl	%ebp, %eax
    1c33: 83 e0 20                     	andl	$0x20, %eax
    1c36: c1 e0 0d                     	shll	$0xd, %eax
    1c39: 09 e8                        	orl	%ebp, %eax

so there seems to be no need any more to use the old flag multiplication
tricks which is less readable. Pick the lowest bit out of GFP_ATOMIC
to limit the size of the instructions.

The specific change which makes me propose this is that bnxt, after
commit cd1fafe7da1f ("eth: bnxt: add support rx side device memory TCP"),
lost the GFP_NOWARN, again. It used to allocate with page_pool_dev_alloc_*
which added the NOWARN unconditionally. While switching to
__bnxt_alloc_rx_netmem() authors forgot to add NOWARN in the explicitly
specified flags.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: hawk@kernel.org
CC: ilias.apalodimas@linaro.org
CC: nathan@kernel.org
CC: nick.desaulniers+lkml@gmail.com
CC: morbo@google.com
CC: justinstitt@google.com
CC: llvm@lists.linux.dev
---
 net/core/page_pool.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index ba70569bd4b0..6ffce0e821e4 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -555,6 +555,13 @@ static noinline netmem_ref __page_pool_alloc_netmems_slow(struct page_pool *pool
 	netmem_ref netmem;
 	int i, nr_pages;
 
+	/* Unconditionally set NOWARN if allocating from the datapath.
+	 * Use a single bit from the ATOMIC mask to help compiler optimize.
+	 */
+	BUILD_BUG_ON(!(GFP_ATOMIC & __GFP_HIGH));
+	if (gfp & __GFP_HIGH)
+		gfp |= __GFP_NOWARN;
+
 	/* Don't support bulk alloc for high-order pages */
 	if (unlikely(pp_order))
 		return page_to_netmem(__page_pool_alloc_page_order(pool, gfp));
-- 
2.51.0



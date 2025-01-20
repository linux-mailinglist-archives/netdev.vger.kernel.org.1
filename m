Return-Path: <netdev+bounces-159792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF671A16ECC
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 15:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36B06168955
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 14:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385E11E3DEB;
	Mon, 20 Jan 2025 14:51:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F4D1E3DD3;
	Mon, 20 Jan 2025 14:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737384678; cv=none; b=Q29u37L4Fj/zYC9Tfp0JfdFNKVWohDJIGwMMzvgh+wMLYOA2376/yhvSnMV5c+B3GlRRkxpNSnidRg0nPPyCgJeNjAyG0FLnE4ok6zIW90JWW8/wtGtBRp4bYrfdDxf8qgPNH2disTMZqaF8Sp5belHqN5kJVetaFkn0teoz9Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737384678; c=relaxed/simple;
	bh=W28Rw4CA/EiQc3Ij36KUvuWvNJ9EFlSIZSspFngI3M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsM2rV05EBEPUvX8LOoW69Q39572MHSPc8RSZXDVyjxlWN4d6DTVGcQzy+2MHkCqMskMWJVxVH5RsJMewDaY2jf1NfrTMVVwtYKj1pK36PAcYuZ07Gdun90Mj6+wdRgYEmMDqLRiL0CxRYsEUk1nhamJHVhrFCnDwfyxmY7aYPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BAA7C4CEDD;
	Mon, 20 Jan 2025 14:51:16 +0000 (UTC)
Date: Mon, 20 Jan 2025 14:51:13 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	pabeni@redhat.com, Guo Weikang <guoweikang.kernel@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Networking for v6.13-rc7
Message-ID: <Z45i4YT1YRccf4dH@arm.com>
References: <20250109182953.2752717-1-kuba@kernel.org>
 <173646486752.1541533.15419405499323104668.pr-tracker-bot@kernel.org>
 <20250116193821.2e12e728@kernel.org>
 <Z4uwbqAwKvR4_24t@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4uwbqAwKvR4_24t@arm.com>

On Sat, Jan 18, 2025 at 01:45:18PM +0000, Catalin Marinas wrote:
> On Thu, Jan 16, 2025 at 07:38:21PM -0800, Jakub Kicinski wrote:
> > After 76d5d4c53e68 ("mm/kmemleak: fix percpu memory leak detection
> > failure") we get this on every instance of our testing VMs:
> > 
> > unreferenced object 0x00042aa0 (size 64):
> >   comm "swapper/0", pid 0, jiffies 4294667296
> >   hex dump (first 32 bytes on cpu 2):
> >     00 00 00 00 00 00 00 00 00 00 06 00 00 00 00 00  ................
> >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >   backtrace (crc 0):
> >     pcpu_alloc_noprof+0x4ad/0xab0
> >     setup_zone_pageset+0x30/0x290
> >     setup_per_cpu_pageset+0x6a/0x1f0
> >     start_kernel+0x2a4/0x410
> >     x86_64_start_reservations+0x18/0x30
> >     x86_64_start_kernel+0xba/0x110
> >     common_startup_64+0x12c/0x138
> 
> I doubt that's related to the networking pull request but I can see it
> caused by the above commit, now that we track per-cpu allocations. Most
> likely it's a false positive. I'll try to reproduce it next week but
> something like below might fix (untested):
> 
> diff --git a/mm/numa.c b/mm/numa.c
> index e2eec07707d1..c594d853cfe8 100644
> --- a/mm/numa.c
> +++ b/mm/numa.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  
> +#include <linux/kmemleak.h>
>  #include <linux/memblock.h>
>  #include <linux/printk.h>
>  #include <linux/numa.h>
> @@ -23,6 +24,9 @@ void __init alloc_node_data(int nid)
>  		      nd_size, nid);
>  	nd = __va(nd_pa);
>  
> +	/* needed to track related allocation stored in node_data[] */
> +	kmemleak_alloc(nd, nd_size, 0, 0);
> +
>  	/* report and initialize */
>  	pr_info("NODE_DATA(%d) allocated [mem %#010Lx-%#010Lx]\n", nid,
>  		nd_pa, nd_pa + nd_size - 1);

Hmm, I don't think this would make any difference as kmemleak does scan
the memblock allocations as long as they have a correspondent VA in the
linear map.

BTW, is NUMA enabled or disabled in your .config?

-- 
Catalin


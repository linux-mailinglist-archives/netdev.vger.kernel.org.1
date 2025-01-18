Return-Path: <netdev+bounces-159564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B7BA15D38
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 14:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88A303A8163
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 13:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D28918EFD4;
	Sat, 18 Jan 2025 13:45:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAA818A6A1;
	Sat, 18 Jan 2025 13:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737207923; cv=none; b=Qpr/ayF2Ge1UZtw4SKVwiCUlk5QvawcavdWtqi1aYcD8CnTKWfSkADtbklvh4naMYVPVZwZiA+4NVf/tWOiMaNKxFQP34AMdbL6WPHXWxpJxr21cbLKDvmubZyTqQG8gdT4UniBpV2Eegt8cZfLRgEBeicXuaD7tRPTwhHTP1LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737207923; c=relaxed/simple;
	bh=SwovSWE8oK7R1u3/KvMW8XzdLNhIpzc9XQqyxaYjrxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/HhNevWhJczZ5PWh/WPOw4GGQTqicUrRpv3umQ6wHPY6wqwSiAUrF36JjKe+7VKhuTOERUxEb+vNdphOcIM6DYnDI1T1MJyGqiWREYOxpOE+JqCzwBMjOPutgO4F2UrjEhGsDdKN0txsHElyPn/Fo9u3haO9s8/W8GBJxsp18s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D30F5C4CED1;
	Sat, 18 Jan 2025 13:45:20 +0000 (UTC)
Date: Sat, 18 Jan 2025 13:45:18 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	pabeni@redhat.com, Guo Weikang <guoweikang.kernel@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Networking for v6.13-rc7
Message-ID: <Z4uwbqAwKvR4_24t@arm.com>
References: <20250109182953.2752717-1-kuba@kernel.org>
 <173646486752.1541533.15419405499323104668.pr-tracker-bot@kernel.org>
 <20250116193821.2e12e728@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116193821.2e12e728@kernel.org>

On Thu, Jan 16, 2025 at 07:38:21PM -0800, Jakub Kicinski wrote:
> On Thu, 09 Jan 2025 23:21:07 +0000 pr-tracker-bot@kernel.org wrote:
> > The pull request you sent on Thu,  9 Jan 2025 10:29:53 -0800:
> > 
> > > git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.13-rc7  
> > 
> > has been merged into torvalds/linux.git:
> > https://git.kernel.org/torvalds/c/c77cd47cee041bc1664b8e5fcd23036e5aab8e2a
> 
> Hi Linus!
> 
> After 76d5d4c53e68 ("mm/kmemleak: fix percpu memory leak detection
> failure") we get this on every instance of our testing VMs:
> 
> unreferenced object 0x00042aa0 (size 64):
>   comm "swapper/0", pid 0, jiffies 4294667296
>   hex dump (first 32 bytes on cpu 2):
>     00 00 00 00 00 00 00 00 00 00 06 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 0):
>     pcpu_alloc_noprof+0x4ad/0xab0
>     setup_zone_pageset+0x30/0x290
>     setup_per_cpu_pageset+0x6a/0x1f0
>     start_kernel+0x2a4/0x410
>     x86_64_start_reservations+0x18/0x30
>     x86_64_start_kernel+0xba/0x110
>     common_startup_64+0x12c/0x138

I doubt that's related to the networking pull request but I can see it
caused by the above commit, now that we track per-cpu allocations. Most
likely it's a false positive. I'll try to reproduce it next week but
something like below might fix (untested):

diff --git a/mm/numa.c b/mm/numa.c
index e2eec07707d1..c594d853cfe8 100644
--- a/mm/numa.c
+++ b/mm/numa.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+#include <linux/kmemleak.h>
 #include <linux/memblock.h>
 #include <linux/printk.h>
 #include <linux/numa.h>
@@ -23,6 +24,9 @@ void __init alloc_node_data(int nid)
 		      nd_size, nid);
 	nd = __va(nd_pa);
 
+	/* needed to track related allocation stored in node_data[] */
+	kmemleak_alloc(nd, nd_size, 0, 0);
+
 	/* report and initialize */
 	pr_info("NODE_DATA(%d) allocated [mem %#010Lx-%#010Lx]\n", nid,
 		nd_pa, nd_pa + nd_size - 1);

-- 
Catalin


Return-Path: <netdev+bounces-160018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C35A17CAB
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 12:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 177BD1882B01
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 11:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212B81EF0BA;
	Tue, 21 Jan 2025 11:09:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E9D1B4137;
	Tue, 21 Jan 2025 11:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737457765; cv=none; b=LAW14AKxSHfzZ2b40OttW0CrDcsaTNJch38cyVbnqISOhjv4LasYO/V4UGbFkv4/G5O19dxwxbnIlei4bavpX1+/i4n1CKXYpuQPZZl2yQ1nmglg+Jkz06ElYEcWexdOyoEoDzExtne7vAQzAE4VhhjADQn3qnq2xyu1GS2D4Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737457765; c=relaxed/simple;
	bh=dD+xBfqSGsPI6+nWJiC9ZmrDveNjQcXDu10qaIcBF54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rL9D0O+gwJmNnQ9VCpy6HozU+KBsbE7WWTubuRVuMv5OyhQ8ShkKvfVrBUV0DhQzaTst7tGFrIVOX0mFA60YuunysSC/VV7c5khZXWzk1E4ofmzoFAWMs6sbfwXDgce0etUQYPsNWJRV+wNypGjvv/TQf2vDbTMLsm+lUiyJNqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB50C4CEDF;
	Tue, 21 Jan 2025 11:09:22 +0000 (UTC)
Date: Tue, 21 Jan 2025 11:09:20 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	pabeni@redhat.com, Guo Weikang <guoweikang.kernel@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Networking for v6.13-rc7
Message-ID: <Z4-AYDvWNaUo-ZQ7@arm.com>
References: <20250109182953.2752717-1-kuba@kernel.org>
 <173646486752.1541533.15419405499323104668.pr-tracker-bot@kernel.org>
 <20250116193821.2e12e728@kernel.org>
 <Z4uwbqAwKvR4_24t@arm.com>
 <Z45i4YT1YRccf4dH@arm.com>
 <20250120094547.202f4718@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120094547.202f4718@kernel.org>

On Mon, Jan 20, 2025 at 09:45:47AM -0800, Jakub Kicinski wrote:
> On Mon, 20 Jan 2025 14:51:13 +0000 Catalin Marinas wrote:
> > > +#include <linux/kmemleak.h>
> > >  #include <linux/memblock.h>
> > >  #include <linux/printk.h>
> > >  #include <linux/numa.h>
> > > @@ -23,6 +24,9 @@ void __init alloc_node_data(int nid)
> > >  		      nd_size, nid);
> > >  	nd = __va(nd_pa);
> > >  
> > > +	/* needed to track related allocation stored in node_data[] */
> > > +	kmemleak_alloc(nd, nd_size, 0, 0);
> > > +
> > >  	/* report and initialize */
> > >  	pr_info("NODE_DATA(%d) allocated [mem %#010Lx-%#010Lx]\n", nid,
> > >  		nd_pa, nd_pa + nd_size - 1);  
> > 
> > Hmm, I don't think this would make any difference as kmemleak does scan
> > the memblock allocations as long as they have a correspondent VA in the
> > linear map.
> > 
> > BTW, is NUMA enabled or disabled in your .config?
> 
> It's pretty much kernel/configs/debug.config, with virtme-ng, booted
> with 4 CPUs. LMK if you can't repro with that, I can provide exact
> cmdline.

Please do. I haven't tried to reproduce it yet on x86 as I don't have
any non-arm hardware around. It did not trigger on arm64. I think
virtme-ng may work with qemu. Anyway, I'll be off from tomorrow until
the end of the week, so more likely to try it next week.

-- 
Catalin


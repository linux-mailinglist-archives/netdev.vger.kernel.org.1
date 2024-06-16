Return-Path: <netdev+bounces-103894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 532C590A060
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 00:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7BA6B207C4
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 22:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692C473459;
	Sun, 16 Jun 2024 21:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QXAiNAUl"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD1773452;
	Sun, 16 Jun 2024 21:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718574995; cv=none; b=T74YUCSgGQndvrqgDaRLsELndsKWTVT6yMa0p0zEUfQ7xH/GHIlg8vHXF/lbflD3znFK2YQmc1XJCXRbdI1VaCnDJY8nBdigj9NwJ063FPDhr175GmAHde/od25o4zCmmFsaJGaufecYCixrpS4rD/hCugeCvqG4OS1DY1sVC7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718574995; c=relaxed/simple;
	bh=1CDTFfS1jwiAXhkGCFOhEM8WIUVdsGhoUumhvMDzAFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlw/Iq/BPeBNhhwMpn/C+AZ1nSqaOVuT9c2kB7lOW3BzTfKXZp/rYssEKvg5DqWhF5Vn4W0FLexA6Mit5GqqZEWNCPq4EVx2meTngiCeP0lgVmgODsqPreXLMF3nEWw9iEdIXZbiVBOapGW8Hzhe9IevDT5wfSakbEmT4HhrQvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QXAiNAUl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=QF+UPGbMrJOYseNtgY++ZYSrOvt8njcmF1sGqllQ8SM=; b=QXAiNAUlk5wcKgem5RJeg0fmGt
	ofGBWkJZgIBOU4G+OaQ133vdqngsO71MdNYeBRgrXGhhKzWJFlDul/paFtl07e3pim3/5/NetXCuG
	G3sxKh5xQV9tlt1K4Usubnoa/+m29IjmC4FnVI/+2yGi94bjnpKRNUKFYeM4+FwBT+EZbzoWzDwGV
	+M619dK24SqXUuUlCob9nJ4208ujKIT6hFsAzYazXq609C9WDZFg45GHcDgcOU4HOeQmgkLqEp+SR
	o1TsvSR4Zc8Z9Ys5JTS+Fu/MyY8JhBzbLYEWNfjj2r+LY7ekfQHFko0pGOALcwWM++LYB+9t36J8m
	plPq2jeQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIxrS-00000001UxS-1rXM;
	Sun, 16 Jun 2024 21:56:30 +0000
Date: Sun, 16 Jun 2024 22:56:30 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] net: micro-optimize skb_datagram_iter
Message-ID: <Zm9fju2J6vBvl-E0@casper.infradead.org>
References: <202406161539.b5ff7b20-oliver.sang@intel.com>
 <4937ffd4-f30a-4bdb-9166-6aebb19ca950@grimberg.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4937ffd4-f30a-4bdb-9166-6aebb19ca950@grimberg.me>

On Sun, Jun 16, 2024 at 12:24:28PM +0300, Sagi Grimberg wrote:
> > [   13.495377][  T189] ------------[ cut here ]------------
> > [   13.495862][  T189] kernel BUG at mm/usercopy.c:102!
> > [   13.496372][  T189] Oops: invalid opcode: 0000 [#1] PREEMPT SMP
> > [   13.496927][  T189] CPU: 0 PID: 189 Comm: systemctl Not tainted 6.10.0-rc2-00258-g18f0423b9ecc #1
> > [   13.497741][  T189] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [ 13.498663][ T189] EIP: usercopy_abort (mm/usercopy.c:102 (discriminator 12))
> > [   13.499424][  T194] usercopy: Kernel memory exposure attempt detected from kmap (offset 0, size 8192)!
> 
> Hmm, not sure I understand exactly why changing kmap() to kmap_local_page()
> expose this,
> but it looks like mm/usercopy does not like size=8192 when copying for the
> skb frag.
> 
> quick git browse directs to:
> --
> commit 4e140f59d285c1ca1e5c81b4c13e27366865bd09
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> Date:   Mon Jan 10 23:15:27 2022 +0000
> 
>     mm/usercopy: Check kmap addresses properly
> 
>     If you are copying to an address in the kmap region, you may not copy
>     across a page boundary, no matter what the size of the underlying
>     allocation.  You can't kmap() a slab page because slab pages always
>     come from low memory.
> 
>     Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>     Acked-by: Kees Cook <keescook@chromium.org>
>     Signed-off-by: Kees Cook <keescook@chromium.org>
>     Link:
> https://lore.kernel.org/r/20220110231530.665970-2-willy@infradead.org
> --
> 
> CCing willy.
> 
> The documentation suggest that under single-context usage kmap() can be
> freely converted
> to kmap_local_page()? But seems that when using kmap() the size is not an
> issue, still trying to
> understand why.

Probably because kmap() returns page_address() for non-highmem pages
while kmap_local_page() actually returns a kmap address:

        if (!IS_ENABLED(CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP) && !PageHighMem(page))
                return page_address(page);
        return __kmap_local_pfn_prot(page_to_pfn(page), prot);

so if skb frags are always lowmem (are they?) this is a false positive.
if they can be highmem, then you've uncovered a bug that nobody's
noticed because nobody's testing on 32-bit any more.


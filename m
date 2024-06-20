Return-Path: <netdev+bounces-105420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A749111CA
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 21:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A56BB230F8
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 18:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FB71B5821;
	Thu, 20 Jun 2024 18:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1Ksv8W/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073C01B3F0F;
	Thu, 20 Jun 2024 18:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718908906; cv=none; b=PaKbVm+tnXkY/FNWth1mFOzRKVUugd/0SRIx1r3T95EStI3pdZH0F8aiNXHLaC0jFF+zxwKz5U6xxhsUv4x+LCmGO8BquDSmmHgfZMiTe4838HucMkO1psyR084bMmwm6V73fOVlTVaN6iTXIJ+bUHAh2evfJ5B/ArlzGaP8Opc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718908906; c=relaxed/simple;
	bh=a0OvAmDcT+HUsVh7NHWlsxuonu7EIGyjpP5cNmXaiJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hvyw9r2h1EYmRi9r1dS+YSCIKTEUuQl/frcN7Gtjl/m2meppuQ8RTKJUsC9zdNYvCDY5IJfwD6GaPuimPATp727qXzk/s/KWO7++DmZxCAjwIAubE5IMTEnteV5wd6Icuj8CZeHkUZ8YsS43iAuTwYL7z8hoVj1usg5QmkaPR9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1Ksv8W/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815A3C2BD10;
	Thu, 20 Jun 2024 18:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718908905;
	bh=a0OvAmDcT+HUsVh7NHWlsxuonu7EIGyjpP5cNmXaiJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t1Ksv8W/rEtx6NZTGvA4yhN3GLcpoOPuO4kh/j/guKM4DuzWnsmxz0sETH+GZprW9
	 e95FrUmpaiWUZmYvTJYQSqr+cf6phCzKLhux981lvX1eOfjqE9/ON1wlrOs7DGh9px
	 e4Lz67fjNMKx3gi7VppJ1f4cHqkROxLzOHRB6QOR3sHw959Tkv9agzhyYxKeaBM05o
	 cYejZYgHWSRwXAYeajNNJFIe+VB/GAsvJ2LTUb1rW4YiQvlsVUKNKnhpmCcEEAblyB
	 TQf3z0puGRC85s7ZxlkPZv2pnSoQOdzsSAUJ6/6NUpocNDLK8PzUsRACgxqG+NAumZ
	 Pc4/grSmZr17Q==
Date: Thu, 20 Jun 2024 11:41:45 -0700
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	jvoisin <julien.voisin@dustri.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jann Horn <jannh@google.com>, Matteo Rizzo <matteorizzo@google.com>,
	Thomas Graf <tgraf@suug.ch>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v5 2/6] mm/slab: Plumb kmem_buckets into
 __do_kmalloc_node()
Message-ID: <202406201138.97812F8D48@keescook>
References: <20240619192131.do.115-kees@kernel.org>
 <20240619193357.1333772-2-kees@kernel.org>
 <7f122473-3d36-401d-8df4-02d981949f00@suse.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f122473-3d36-401d-8df4-02d981949f00@suse.cz>

On Thu, Jun 20, 2024 at 03:08:32PM +0200, Vlastimil Babka wrote:
> On 6/19/24 9:33 PM, Kees Cook wrote:
> > Introduce CONFIG_SLAB_BUCKETS which provides the infrastructure to
> > support separated kmalloc buckets (in the following kmem_buckets_create()
> > patches and future codetag-based separation). Since this will provide
> > a mitigation for a very common case of exploits, enable it by default.
> 
> No longer "enable it by default".

Whoops! Yes, thank you.

> 
> > 
> > To be able to choose which buckets to allocate from, make the buckets
> > available to the internal kmalloc interfaces by adding them as the
> > first argument, rather than depending on the buckets being chosen from
> 
> second argument now

Fixed.

> 
> > the fixed set of global buckets. Where the bucket is not available,
> > pass NULL, which means "use the default system kmalloc bucket set"
> > (the prior existing behavior), as implemented in kmalloc_slab().
> > 
> > To avoid adding the extra argument when !CONFIG_SLAB_BUCKETS, only the
> > top-level macros and static inlines use the buckets argument (where
> > they are stripped out and compiled out respectively). The actual extern
> > functions can then been built without the argument, and the internals
> > fall back to the global kmalloc buckets unconditionally.
> 
> Also describes the previous implementation and not the new one?

I think this still describes the implementation: the macros are doing
this work now. I wanted to explain in the commit log why the "static
inline"s still have explicit arguments (they will vanish during
inlining), as they are needed to detect the need for the using the
global buckets.

> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -273,6 +273,22 @@ config SLAB_FREELIST_HARDENED
> >  	  sacrifices to harden the kernel slab allocator against common
> >  	  freelist exploit methods.
> >  
> > +config SLAB_BUCKETS
> > +	bool "Support allocation from separate kmalloc buckets"
> > +	depends on !SLUB_TINY
> > +	help
> > +	  Kernel heap attacks frequently depend on being able to create
> > +	  specifically-sized allocations with user-controlled contents
> > +	  that will be allocated into the same kmalloc bucket as a
> > +	  target object. To avoid sharing these allocation buckets,
> > +	  provide an explicitly separated set of buckets to be used for
> > +	  user-controlled allocations. This may very slightly increase
> > +	  memory fragmentation, though in practice it's only a handful
> > +	  of extra pages since the bulk of user-controlled allocations
> > +	  are relatively long-lived.
> > +
> > +	  If unsure, say Y.
> 
> I was wondering why I don't see the buckets in slabinfo and turns out it was
> SLAB_MERGE_DEFAULT. It would probably make sense for SLAB_MERGE_DEFAULT to
> depends on !SLAB_BUCKETS now as the merging defeats the purpose, wdyt?

You mention this was a misunderstanding in the next email, but just to
reply here: I explicitly use SLAB_NO_MERGE, so if it ever DOES become
invisible, then yes, that would be unexpected!

Thanks for the review!

-- 
Kees Cook


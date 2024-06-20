Return-Path: <netdev+bounces-105423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F92F911183
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 20:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CF8B1C20BF7
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 18:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD1F1B5811;
	Thu, 20 Jun 2024 18:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gp6eNAqI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E58381B8;
	Thu, 20 Jun 2024 18:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718909671; cv=none; b=iop0XipZ5y96d1I5aOvEpMwjclmWslF7kWDyBqO9K23HVPu877aNNgORusBCN5gEnIUYZjKNvznWkOACs8Ta8QSM9vieHAiquioq/zwk0qykY9AKK7BdRHW6BlV/1tBXwgYdR7IABhxF4kR5wyc8raBnS4awDHgmVhgiIZLCnmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718909671; c=relaxed/simple;
	bh=irInUIXYcnVbTI7ZN+P72B/uLw4QMucaS01AdF/42Eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AeyLWUF8saPX4/6/4FhjeWy2hoMiBOio+3I1pbJMIQPLGBofVHIcR/K8TKoEfc9U84Qto3B1f/7mpuCiNKLIZJESunS315Pk0FqziVE4HJDTycx5JDf6pujeVpThas5FAs87nc2cFEu7tNUwMBEn/hL64lStzePu0Mkclh5zlgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gp6eNAqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2D7C32786;
	Thu, 20 Jun 2024 18:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718909670;
	bh=irInUIXYcnVbTI7ZN+P72B/uLw4QMucaS01AdF/42Eg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gp6eNAqIPyGLiPbiV0Qu6r4RvLzCvXDfeHg1l5u6Lj4fqtpVlopL4Wo/Tw3gTVhp2
	 c1WUHBMwKI1oqSfGKEI5k86f0alIltlVgu22U34GIPD6OvhpklgaONTjuHKiJY/u2p
	 SpvL/g+/zSYsKOnbS2FiVkBbohNE+/W+C/sTc68FGqDY7wNIWoUrUn2xAFkZof4hN7
	 GOdJA8+hRTgIf8VX50MsQ8d91l7S5N58nyR1k932gRhNcHx0tBCyVY25mJm3D2iliu
	 Xnuz3P5/gBez+6LWP0Nt8UFYr1octCbPQwL/Z1malrMErf/VaholdctTl/xtow5SaI
	 pzlxFCLAb3uhw==
Date: Thu, 20 Jun 2024 11:54:30 -0700
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
Subject: Re: [PATCH v5 4/6] mm/slab: Introduce kmem_buckets_create() and
 family
Message-ID: <202406201147.8152CECFF@keescook>
References: <20240619192131.do.115-kees@kernel.org>
 <20240619193357.1333772-4-kees@kernel.org>
 <cc301463-da43-4991-b001-d92521384253@suse.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc301463-da43-4991-b001-d92521384253@suse.cz>

On Thu, Jun 20, 2024 at 03:56:27PM +0200, Vlastimil Babka wrote:
> On 6/19/24 9:33 PM, Kees Cook wrote:
> > Dedicated caches are available for fixed size allocations via
> > kmem_cache_alloc(), but for dynamically sized allocations there is only
> > the global kmalloc API's set of buckets available. This means it isn't
> > possible to separate specific sets of dynamically sized allocations into
> > a separate collection of caches.
> > 
> > This leads to a use-after-free exploitation weakness in the Linux
> > kernel since many heap memory spraying/grooming attacks depend on using
> > userspace-controllable dynamically sized allocations to collide with
> > fixed size allocations that end up in same cache.
> > 
> > While CONFIG_RANDOM_KMALLOC_CACHES provides a probabilistic defense
> > against these kinds of "type confusion" attacks, including for fixed
> > same-size heap objects, we can create a complementary deterministic
> > defense for dynamically sized allocations that are directly user
> > controlled. Addressing these cases is limited in scope, so isolating these
> > kinds of interfaces will not become an unbounded game of whack-a-mole. For
> > example, many pass through memdup_user(), making isolation there very
> > effective.
> > 
> > In order to isolate user-controllable dynamically-sized
> > allocations from the common system kmalloc allocations, introduce
> > kmem_buckets_create(), which behaves like kmem_cache_create(). Introduce
> > kmem_buckets_alloc(), which behaves like kmem_cache_alloc(). Introduce
> > kmem_buckets_alloc_track_caller() for where caller tracking is
> > needed. Introduce kmem_buckets_valloc() for cases where vmalloc fallback
> > is needed.
> > 
> > This can also be used in the future to extend allocation profiling's use
> > of code tagging to implement per-caller allocation cache isolation[1]
> > even for dynamic allocations.
> > 
> > Memory allocation pinning[2] is still needed to plug the Use-After-Free
> > cross-allocator weakness, but that is an existing and separate issue
> > which is complementary to this improvement. Development continues for
> > that feature via the SLAB_VIRTUAL[3] series (which could also provide
> > guard pages -- another complementary improvement).
> > 
> > Link: https://lore.kernel.org/lkml/202402211449.401382D2AF@keescook [1]
> > Link: https://googleprojectzero.blogspot.com/2021/10/how-simple-linux-kernel-memory.html [2]
> > Link: https://lore.kernel.org/lkml/20230915105933.495735-1-matteorizzo@google.com/ [3]
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> >  include/linux/slab.h | 13 ++++++++
> >  mm/slab_common.c     | 78 ++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 91 insertions(+)
> > 
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index 8d0800c7579a..3698b15b6138 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -549,6 +549,11 @@ void *kmem_cache_alloc_lru_noprof(struct kmem_cache *s, struct list_lru *lru,
> >  
> >  void kmem_cache_free(struct kmem_cache *s, void *objp);
> >  
> > +kmem_buckets *kmem_buckets_create(const char *name, unsigned int align,
> > +				  slab_flags_t flags,
> > +				  unsigned int useroffset, unsigned int usersize,
> > +				  void (*ctor)(void *));
> 
> I'd drop the ctor, I can't imagine how it would be used with variable-sized
> allocations.

I've kept it because for "kmalloc wrapper" APIs, e.g. devm_kmalloc(),
there is some "housekeeping" that gets done explicitly right now that I
think would be better served by using a ctor in the future. These APIs
are variable-sized, but have a fixed size header, so they have a
"minimum size" that the ctor can still operate on, etc.

> Probably also "align" doesn't make much sense since we're just
> copying the kmalloc cache sizes and its implicit alignment of any
> power-of-two allocations.

Yeah, that's probably true. I kept it since I wanted to mirror
kmem_cache_create() to make this API more familiar looking.

> I don't think any current kmalloc user would
> suddenly need either of those as you convert it to buckets, and definitely
> not any user converted automatically by the code tagging.

Right, it's not needed for either the explicit users nor the future
automatic users. But since these arguments are available internally,
there seems to be future utility,  it's not fast path, and it made things
feel like the existing API, I'd kind of like to keep it.

But all that said, if you really don't want it, then sure I can drop
those arguments. Adding them back in the future shouldn't be too
much churn.

-- 
Kees Cook


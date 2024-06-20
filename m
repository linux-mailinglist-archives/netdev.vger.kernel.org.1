Return-Path: <netdev+bounces-105489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A327F9116BB
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 01:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 611742837D5
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 23:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F1314387C;
	Thu, 20 Jun 2024 23:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vI7naTbg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6471F7D08D;
	Thu, 20 Jun 2024 23:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718926167; cv=none; b=uF9w8QtnCEp44u87S37Y/UxZ4FJJTOTbf3VfAz8euub6Gc2UJVfAObcx4KieokptdWpQRTy+tztqty8m3AtPNrsV8OKhpSVQMgHtC+nLCRGzfcMMCCDYPgnOaEzU1Crlq1jt0wpM4oCyxLaz7uLh0nWkaysr+MMFR6pP1aI9AHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718926167; c=relaxed/simple;
	bh=/sadit87DkhqYLioSkOH0TfD3gxDb0YHnkI1SLYBgSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6gvWTejzt99biNrZAllPptNhCIlqeVJ9P/smYWrC/XEC2SjLWgUVq0SjV5q3OJIGxfeGizO7KMGB1xZ6t33JvivJ9CLal0kYDYRHU/2ppatNh58HrupB9WescYcOfkXYmoP0L3hiMm1MWopQOQAgib+yVjKTyDjCKqST03pAr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vI7naTbg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F06C2BD10;
	Thu, 20 Jun 2024 23:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718926167;
	bh=/sadit87DkhqYLioSkOH0TfD3gxDb0YHnkI1SLYBgSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vI7naTbg3JsloxxZ0TMaMBhRn9jCCMpzIRnnznh402AZg3Xjtbw9aAv3Durp4e++N
	 taLRY6lqcGpI1Ve7YymtUQJd1ok8eitlLBVT0IguNvLTOxSiuVgNbJnkPGOwcnDnBx
	 EJ8v+kEyT53Mf/pFzMO+hLRctCONcinjlkTUs6/e+TAdagrQHu3jvLnshX9Ja5DjFb
	 J/D8B3X2ItjVP7lO+HxFDgX1g5+VcNQbV7vedmGH0NX3tMcf69SJa87Jthbxrs6HP3
	 lTmmfVBhhlC3KxY2yeJJ4wHNyP5trc7njZLla/AsmKfUs/ROEQKWS0E08t5ovG63an
	 fVLl49P474idA==
Date: Thu, 20 Jun 2024 16:29:26 -0700
From: Kees Cook <kees@kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
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
Message-ID: <202406201620.0392F7E45@keescook>
References: <20240619192131.do.115-kees@kernel.org>
 <20240619193357.1333772-4-kees@kernel.org>
 <87r0crut6v.fsf@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0crut6v.fsf@linux.intel.com>

On Thu, Jun 20, 2024 at 03:48:24PM -0700, Andi Kleen wrote:
> Kees Cook <kees@kernel.org> writes:
> 
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
> 
> Isn't the attack still possible if the attacker can free the slab page
> during the use-after-free period with enough memory pressure?
> 
> Someone else might grab the page that was in the bucket for another slab
> and the type confusion could hurt again.
> 
> Or is there some other defense against that, other than
> CONFIG_DEBUG_PAGEALLOC or full slab poisoning? And how expensive
> does it get when any of those are enabled?
> 
> I remember reading some paper about a apple allocator trying similar
> techniques and it tried very hard to never reuse memory (probably
> not a good idea for Linux though)
> 
> I assume you thought about this, but it would be good to discuss such
> limitations and interactions in the commit log.

Yup! It's in there; it's just after what you quoted above. Here it is:

> > Memory allocation pinning[2] is still needed to plug the Use-After-Free
> > cross-allocator weakness, but that is an existing and separate issue
> > which is complementary to this improvement. Development continues for
> > that feature via the SLAB_VIRTUAL[3] series (which could also provide
> > guard pages -- another complementary improvement).
> > [...]
> > Link: https://googleprojectzero.blogspot.com/2021/10/how-simple-linux-kernel-memory.html [2]
> > Link: https://lore.kernel.org/lkml/20230915105933.495735-1-matteorizzo@google.com/ [3]

Let me know if you think this description needs to be improved...

-Kees

-- 
Kees Cook


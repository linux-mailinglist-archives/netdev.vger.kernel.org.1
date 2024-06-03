Return-Path: <netdev+bounces-100398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4A78FA5FB
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 00:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FF7D1F24B69
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 22:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64AB13D26C;
	Mon,  3 Jun 2024 22:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LgLq+8y8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A6D13D25F;
	Mon,  3 Jun 2024 22:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454700; cv=none; b=p3rF0cyEh0aUUywLYrnCNr8pSrMXnCtBoMZdEhHcVeuh37vISFZ9MVPuFkEee+c7s52l9y2c8928tkDhGHqjuZR+jXrF1C4kkfrQk8esB/3dKrrQs0gwfX/FjzxguMwpFpSFejqgiUMOoG9ROd6+NZ6mj6Yvl04MP8E2fisCbd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454700; c=relaxed/simple;
	bh=SS7haSNVEINimgm5/W3mtfCykszqT69zvNdWxSykOjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLss/wV/rLJgZU1rrFS6/mRQ9lf9yQv4MANyl8d3+mR5GBmNSY2NVT4ulQAtzpZHUvpLO8m6ymaAWjh/fmYBXZ3R8aLLU1bj9vbwd/qOBMkMympOWuIjFB0PkhzXMA8+b+Xe6ypvv9VrK1b+/XIz6JkcyP5QKyySAoVaNR/Xsl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LgLq+8y8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9B4C2BD10;
	Mon,  3 Jun 2024 22:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717454700;
	bh=SS7haSNVEINimgm5/W3mtfCykszqT69zvNdWxSykOjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LgLq+8y8Z9DNbcbleJK889AVVnanG0dEtt5fKMT90XrX8yhVQXh+DJYOmUBI7RoRr
	 92hDsbxfH0jlFkbi+R9Sqkv2vkYfpeQWyhYTNoZnLI89Skr/P+hbBMh1M0Z0Zig+Oq
	 gVcGlkOzJB4aP/MlGkVI9O0VFhlfk/cWGKCGNUqeYLcPQloFR9ps99dXIeZChYlhpO
	 Al6nt2qihiHJVIwBqarO7DDgq1Zhsrl5ep4Mn0fXRPp/rivGBk43FftWgOBsrQmBUF
	 9bTKITNMbFRd5u+qk9Rw3US4QpdF+jLNIwZPzDCD6xEzESRlNqQpgQrpQKxGeffyUT
	 aWai68IuOUsyQ==
Date: Mon, 3 Jun 2024 15:44:59 -0700
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	jvoisin <julien.voisin@dustri.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jann Horn <jannh@google.com>, Matteo Rizzo <matteorizzo@google.com>,
	Thomas Graf <tgraf@suug.ch>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 2/6] mm/slab: Plumb kmem_buckets into
 __do_kmalloc_node()
Message-ID: <202406031539.3A465006@keescook>
References: <20240531191304.it.853-kees@kernel.org>
 <20240531191458.987345-2-kees@kernel.org>
 <8c0c4af3-4782-4dbc-b413-e2f3b79c0246@suse.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c0c4af3-4782-4dbc-b413-e2f3b79c0246@suse.cz>

On Mon, Jun 03, 2024 at 07:06:15PM +0200, Vlastimil Babka wrote:
> On 5/31/24 9:14 PM, Kees Cook wrote:
> > Introduce CONFIG_SLAB_BUCKETS which provides the infrastructure to
> > support separated kmalloc buckets (in the follow kmem_buckets_create()
> > patches and future codetag-based separation). Since this will provide
> > a mitigation for a very common case of exploits, enable it by default.
> 
> Are you sure? I thought there was a policy that nobody is special enough
> to have stuff enabled by default. Is it worth risking Linus shouting? :)

I think it's important to have this enabled given how common the
exploitation methodology is and how cheap this solution is. Regardless,
if you want it "default n", I can change it.

> I found this too verbose and tried a different approach, in the end rewrote
> everything to verify the idea works. So I'll just link to the result in git:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slab-buckets-v4-rewrite
> 
> It's also rebased on slab.git:slab/for-6.11/cleanups with some alloc_hooks()
> cleanups that would cause conflicts otherwkse.
> 
> But the crux of that approach is:
> 
> /*
>  * These macros allow declaring a kmem_buckets * parameter alongside size, which
>  * can be compiled out with CONFIG_SLAB_BUCKETS=n so that a large number of call
>  * sites don't have to pass NULL.
>  */
> #ifdef CONFIG_SLAB_BUCKETS
> #define DECL_BUCKET_PARAMS(_size, _b)   size_t (_size), kmem_buckets *(_b)
> #define PASS_BUCKET_PARAMS(_size, _b)   (_size), (_b)
> #define PASS_BUCKET_PARAM(_b)           (_b)
> #else
> #define DECL_BUCKET_PARAMS(_size, _b)   size_t (_size)
> #define PASS_BUCKET_PARAMS(_size, _b)   (_size)
> #define PASS_BUCKET_PARAM(_b)           NULL
> #endif
> 
> Then we have declaration e.g.
> 
> void *__kmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags, int node)
>                                 __assume_kmalloc_alignment __alloc_size(1);
> 
> and the function is called like (from code not using buckets)
> return __kmalloc_node_noprof(PASS_BUCKET_PARAMS(size, NULL), flags, node);
> 
> or (from code using buckets)
> #define kmem_buckets_alloc(_b, _size, _flags)   \
>         alloc_hooks(__kmalloc_node_noprof(PASS_BUCKET_PARAMS(_size, _b), _flags, NUMA_NO_NODE))
> 
> And implementation looks like:
> 
> void *__kmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags, int node)
> {
>         return __do_kmalloc_node(size, PASS_BUCKET_PARAM(b), flags, node, _RET_IP_);
> }
> 
> The size param is always the first, so the __alloc_size(1) doesn't need tweaking.
> size is also used in the macros even if it's never mangled, because it's easy
> to pass one param instead of two, but not zero params instead of one, if we want
> the ending comma not be part of the macro (which would look awkward).
> 
> Does it look ok to you? Of course names of the macros could be tweaked. Anyway feel
> free to use the branch for the followup. Hopefully this way is also compatible with
> the planned codetag based followup.

This looks really nice, thank you! This is well aligned with the codetag
followup, which also needs to have "size" be very easy to find (to the
macros can check for compile-time-constant or not).

I will go work from your branch...

Thanks!

-Kees

-- 
Kees Cook


Return-Path: <netdev+bounces-101130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B32F88FD6D1
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 21:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F0D11C21D4A
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 19:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941F6154C14;
	Wed,  5 Jun 2024 19:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bo+Tymvp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6878C154BF9;
	Wed,  5 Jun 2024 19:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717617281; cv=none; b=Kfl1syNWNudVCil5nKZiG8t6HS5+9fKCuPoZIgVXmFLb1nEz72rjzWp7JoaueDn3lv6Sf7aNWRpqOCcuRaPpAiw19S9V/59awVIDBAbEI5XwQyy3fwec5lLXjp96PAbSuk5yfe7ZNbqF4FGitk4OKeeaLcvRRMbglpdDKcBmkE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717617281; c=relaxed/simple;
	bh=C/d+QzzEEXD3nP3fLH1CEjnoNOPR1mWYBBp0rsQc8ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdVqB52L53dKHW8jBUVx8VCkkNXo2uDoG/VKW/Rb7Z/W4IY8Oi9oVm5kqNxdfwBbjXqAnPcQ0VOUjgRI5qm5kylNcKN/zCzwazS8Ua8mNkV7LA3q271T7VNqWqSgK8wB/vrUOSQEEiCkxv6ytsLl62QIxFaKfMBaINDtuFTRy9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bo+Tymvp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46803C2BD11;
	Wed,  5 Jun 2024 19:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717617281;
	bh=C/d+QzzEEXD3nP3fLH1CEjnoNOPR1mWYBBp0rsQc8ZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bo+TymvpxxRc2c3hAxES9XbNbQqulQYx1SsCVi28ZwWJLt7AFPjcGIX9mbNoBkJ65
	 jDahOBbTgwf17xQ4MB/Paf0qi84pSEdTOsZU03OVY+Mo76vLIlYJzMofh0I4bQF2h3
	 LTFJ6sQzuBR5IuaobyoHBIQLudhDWvyRUaxN783YjdX7bWIUmjqAcw+UloBJNWpprc
	 t/6aZNUqUZTX7TsETyB5gt4XVB3sUmwOsaaNu/kOtJ8waFsyKw0wgl2Hm0ER40ncaG
	 GGVUd//wgrYXjnuHbZx1++O21swJtbbqoEcau3lj8WW9wCEFFQ2EZUSKuNbTLgofRW
	 O7u+xQN4j/MLg==
Date: Wed, 5 Jun 2024 20:54:33 +0100
From: Simon Horman <horms@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Tycho Andersen <tycho@tycho.pizza>, Vlastimil Babka <vbabka@suse.cz>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	jvoisin <julien.voisin@dustri.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jann Horn <jannh@google.com>, Matteo Rizzo <matteorizzo@google.com>,
	Thomas Graf <tgraf@suug.ch>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 4/6] mm/slab: Introduce kmem_buckets_create() and
 family
Message-ID: <20240605195433.GA791188@kernel.org>
References: <20240531191304.it.853-kees@kernel.org>
 <20240531191458.987345-4-kees@kernel.org>
 <20240604150228.GS491852@kernel.org>
 <Zl+RjJDOX45DH6gR@tycho.pizza>
 <202406041749.27CAE270@keescook>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202406041749.27CAE270@keescook>

On Tue, Jun 04, 2024 at 05:49:20PM -0700, Kees Cook wrote:
> On Tue, Jun 04, 2024 at 04:13:32PM -0600, Tycho Andersen wrote:
> > On Tue, Jun 04, 2024 at 04:02:28PM +0100, Simon Horman wrote:
> > > On Fri, May 31, 2024 at 12:14:56PM -0700, Kees Cook wrote:
> > > > +	for (idx = 0; idx < ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]); idx++) {
> > > > +		char *short_size, *cache_name;
> > > > +		unsigned int cache_useroffset, cache_usersize;
> > > > +		unsigned int size;
> > > > +
> > > > +		if (!kmalloc_caches[KMALLOC_NORMAL][idx])
> > > > +			continue;
> > > > +
> > > > +		size = kmalloc_caches[KMALLOC_NORMAL][idx]->object_size;
> > > > +		if (!size)
> > > > +			continue;
> > > > +
> > > > +		short_size = strchr(kmalloc_caches[KMALLOC_NORMAL][idx]->name, '-');
> > > > +		if (WARN_ON(!short_size))
> > > > +			goto fail;
> > > > +
> > > > +		cache_name = kasprintf(GFP_KERNEL, "%s-%s", name, short_size + 1);
> > > > +		if (WARN_ON(!cache_name))
> > > > +			goto fail;
> > > > +
> > > > +		if (useroffset >= size) {
> > > > +			cache_useroffset = 0;
> > > > +			cache_usersize = 0;
> > > > +		} else {
> > > > +			cache_useroffset = useroffset;
> > > > +			cache_usersize = min(size - cache_useroffset, usersize);
> > > > +		}
> > > > +		(*b)[idx] = kmem_cache_create_usercopy(cache_name, size,
> > > > +					align, flags, cache_useroffset,
> > > > +					cache_usersize, ctor);
> > > > +		kfree(cache_name);
> > > > +		if (WARN_ON(!(*b)[idx]))
> > > > +			goto fail;
> > > > +	}
> > > > +
> > > > +	return b;
> > > > +
> > > > +fail:
> > > > +	for (idx = 0; idx < ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]); idx++) {
> > > > +		if ((*b)[idx])
> > > > +			kmem_cache_destroy((*b)[idx]);
> > > 
> > > nit: I don't think it is necessary to guard this with a check for NULL.
> > 
> > Isn't it? What if a kasprintf() fails halfway through the loop?
> 
> He means that kmem_cache_destroy() already checks for NULL. Quite right!
> 
> void kmem_cache_destroy(struct kmem_cache *s)
> {
>         int err = -EBUSY;
>         bool rcu_set;
> 
>         if (unlikely(!s) || !kasan_check_byte(s))
>                 return;

Yes, thanks. That is what I was referring to.


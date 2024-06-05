Return-Path: <netdev+bounces-100793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D715A8FC0F1
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 02:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 769F21F2364B
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 00:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DBC804;
	Wed,  5 Jun 2024 00:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrP0zECe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DF2163;
	Wed,  5 Jun 2024 00:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717548561; cv=none; b=T5lWdtdAhE52P9sDejCuhzC30cb1MtfhASHL0Eey8bJPEoCDWc70pPfC2LcSR1uO96oHPQpNxNXhjKh2LE5hmFdOh12D9kHGbPu43lcgwfszzrfseD/UWdwo4t0c0fGeEq+V8fbHH2DFsOMmb5+bglTIfPRUXyvejf+1bqdbEt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717548561; c=relaxed/simple;
	bh=CR+MCqNdStHiS0XLFyUo6nxzn/REAjoufJhdXky59KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srM3Y+UVCszaaEsPw7MQ99wnNGOxenGmXvh9PuwEJr6mvW1dBNws5wKEUFGN1iq7t4d10cFmba7/67jsJTnaBtTQ12CSHaAUa0Zr+a3nMRVP8ptUronIj6GB5kJJXXk/IOB4+aIDOI0OuH9Ag6mfm/+A1zoGNfy8nbbvxzrtbvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrP0zECe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75901C2BBFC;
	Wed,  5 Jun 2024 00:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717548561;
	bh=CR+MCqNdStHiS0XLFyUo6nxzn/REAjoufJhdXky59KA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MrP0zECelgyKwrURJfgOosDnxpIQQ5F5AK1p/r00kffo/Mgut/vP1+QwIgHoCtlYg
	 VLgMqlp2VbEdHQnyVdddKLExUxaZQHSOObBXvsKo/O3dZf9aafy/JJCliTn3rqiDEr
	 58va7PeALemCo5HmhjUJcE32TjpUGEeYenj+LIjpv/LaaZTFxAfdc9HxSgg+Hgfm1p
	 vVBe7wojcXtK3JR9K6E0CgkXP231fblNe/4/bvWy8+cvaeaEdcfMndba79P1/YpXUA
	 2p4T7ckStMD2as5t+zPkOF1g/TGq4y+CyxfKIShA2rwvn3BwTFsjDWdYNG75C9r0vT
	 7zTEzC8+/5VyQ==
Date: Tue, 4 Jun 2024 17:49:20 -0700
From: Kees Cook <kees@kernel.org>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Simon Horman <horms@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
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
Message-ID: <202406041749.27CAE270@keescook>
References: <20240531191304.it.853-kees@kernel.org>
 <20240531191458.987345-4-kees@kernel.org>
 <20240604150228.GS491852@kernel.org>
 <Zl+RjJDOX45DH6gR@tycho.pizza>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zl+RjJDOX45DH6gR@tycho.pizza>

On Tue, Jun 04, 2024 at 04:13:32PM -0600, Tycho Andersen wrote:
> On Tue, Jun 04, 2024 at 04:02:28PM +0100, Simon Horman wrote:
> > On Fri, May 31, 2024 at 12:14:56PM -0700, Kees Cook wrote:
> > > +	for (idx = 0; idx < ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]); idx++) {
> > > +		char *short_size, *cache_name;
> > > +		unsigned int cache_useroffset, cache_usersize;
> > > +		unsigned int size;
> > > +
> > > +		if (!kmalloc_caches[KMALLOC_NORMAL][idx])
> > > +			continue;
> > > +
> > > +		size = kmalloc_caches[KMALLOC_NORMAL][idx]->object_size;
> > > +		if (!size)
> > > +			continue;
> > > +
> > > +		short_size = strchr(kmalloc_caches[KMALLOC_NORMAL][idx]->name, '-');
> > > +		if (WARN_ON(!short_size))
> > > +			goto fail;
> > > +
> > > +		cache_name = kasprintf(GFP_KERNEL, "%s-%s", name, short_size + 1);
> > > +		if (WARN_ON(!cache_name))
> > > +			goto fail;
> > > +
> > > +		if (useroffset >= size) {
> > > +			cache_useroffset = 0;
> > > +			cache_usersize = 0;
> > > +		} else {
> > > +			cache_useroffset = useroffset;
> > > +			cache_usersize = min(size - cache_useroffset, usersize);
> > > +		}
> > > +		(*b)[idx] = kmem_cache_create_usercopy(cache_name, size,
> > > +					align, flags, cache_useroffset,
> > > +					cache_usersize, ctor);
> > > +		kfree(cache_name);
> > > +		if (WARN_ON(!(*b)[idx]))
> > > +			goto fail;
> > > +	}
> > > +
> > > +	return b;
> > > +
> > > +fail:
> > > +	for (idx = 0; idx < ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]); idx++) {
> > > +		if ((*b)[idx])
> > > +			kmem_cache_destroy((*b)[idx]);
> > 
> > nit: I don't think it is necessary to guard this with a check for NULL.
> 
> Isn't it? What if a kasprintf() fails halfway through the loop?

He means that kmem_cache_destroy() already checks for NULL. Quite right!

void kmem_cache_destroy(struct kmem_cache *s)
{
        int err = -EBUSY;
        bool rcu_set;

        if (unlikely(!s) || !kasan_check_byte(s))
                return;


-- 
Kees Cook


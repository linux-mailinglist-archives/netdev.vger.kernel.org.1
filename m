Return-Path: <netdev+bounces-105421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C999911155
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 20:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E64A41F212F5
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 18:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649BC1B4C34;
	Thu, 20 Jun 2024 18:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uK+JbPGH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345481B3731;
	Thu, 20 Jun 2024 18:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718909203; cv=none; b=nGLwwT2uK7b/2SRa7M8QXH1lufZcy49/pexOY0UCTi7lzSHsNxMdGcfyTBCp+Zs5fYNuGFr1dXCXVyKF1+dB8MmDVSDrisO9o4dIhXQaKSoPSnycVWdi7aUQAUXPShTsD3hDFa4sFmPvkzT8BxofOSev7uC9f6pa4jFNRswsf6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718909203; c=relaxed/simple;
	bh=I3joilslbsTLNhXOXgFwVeASkXdC28bcARNwfLKI8vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TX6Gxbjv4i4MgiaplJcqyeAozLEYu2l85dpAGmYfgyOh4JlnBPTU/gdA3vPpEcuclneH7L4PoG3c8jD5JPOF3Le5xZ1AFCCFsjKEGHSKqoVxJbo5AJV+z0VFVx+G5zS+JKszIUsJxmGgtqfgL/qMYsew22fjlZ61Xkc4ue4fD8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uK+JbPGH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4DA0C2BD10;
	Thu, 20 Jun 2024 18:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718909202;
	bh=I3joilslbsTLNhXOXgFwVeASkXdC28bcARNwfLKI8vY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uK+JbPGHAN8r05cRgDkZQTsmELs6UZrtg2JBK9smm3uLdlJWaL4l8aS7al4jNu+KH
	 /arX2rg8N8O+LOODJDJpA4nAiXuxMMUW6iA4EVO4/ycET4EkJgK/mk+60vIHHQ5yHS
	 hLptnexYsErWkzpNLBnPe1HzGVCqUa5vrp2wILiLY3mQCVw8e2SV2KAkTvOcr5/OQi
	 ByPyQKnQ/3VCumQRaojNgAwFL9ARtQzSFzh7a4rmVhdqno8D9OHj+R+rxGWkY7zrmT
	 vGOSOUhoQYBJfCnvP65Ry+c2yGG55UMEI3PLXUCSGOu47ziiF1T6VQhMgkVBClpw6W
	 ECXKB8H5QyJqw==
Date: Thu, 20 Jun 2024 11:46:42 -0700
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
Message-ID: <202406201144.289A1A14@keescook>
References: <20240619192131.do.115-kees@kernel.org>
 <20240619193357.1333772-2-kees@kernel.org>
 <7f122473-3d36-401d-8df4-02d981949f00@suse.cz>
 <88954479-01a3-4bbe-8558-1a71b11503f8@suse.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88954479-01a3-4bbe-8558-1a71b11503f8@suse.cz>

On Thu, Jun 20, 2024 at 03:37:31PM +0200, Vlastimil Babka wrote:
> On 6/20/24 3:08 PM, Vlastimil Babka wrote:
> > On 6/19/24 9:33 PM, Kees Cook wrote:
> > I was wondering why I don't see the buckets in slabinfo and turns out it was
> > SLAB_MERGE_DEFAULT. It would probably make sense for SLAB_MERGE_DEFAULT to
> > depends on !SLAB_BUCKETS now as the merging defeats the purpose, wdyt?
> 
> Hm I might have been just blind, can see them there now. Anyway it probably
> doesn't make much sense to have SLAB_BUCKETS and/or RANDOM_KMALLOC_CACHES
> together with SLAB_MERGE_DEFAULT?

It's already handled so that the _other_ caches can still be merged if
people want it. See new_kmalloc_cache():

#ifdef CONFIG_RANDOM_KMALLOC_CACHES
        if (type >= KMALLOC_RANDOM_START && type <= KMALLOC_RANDOM_END)
                flags |= SLAB_NO_MERGE;
#endif

-- 
Kees Cook


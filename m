Return-Path: <netdev+bounces-108612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678E69248CF
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 22:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF823B226A1
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 20:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9010220012F;
	Tue,  2 Jul 2024 20:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1GvyUGk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F5B1BD4EF;
	Tue,  2 Jul 2024 20:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719951177; cv=none; b=SS8KACsDgU5r0xrJcENUzDGqCst4iNsG6urxpSy1WTz/o1pbIJZZ+iKGJbJLfAajoVNto5t7d1Dkz9NF06yXbTB0WF0GlFlHq+RG0IgCRdwO1TuP7Z/TsiEnnbBWAfD8K4yJI8z+Ffa72jbhPfZ51T5eAvRTI6ttPyBWTlJLpKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719951177; c=relaxed/simple;
	bh=C6b9hc9GQw/hUIKi8BoAMgaCAAFhMQsy++IqseLR5QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VAo84pVRpvQ4gdqkGYCPa/Tkp8yyQfxfd16P3OBj/CqSp8o8GJyRSABOrceEo1TqzgN4Y9hzleTtRJmQXPed9hH7PYtVZG5qnsfsRfpyI2mb8ycd1iZk4O/Bsubt+Q9SBFPyRN9GNcDJB3OBUp9KHqxUHt2JtNMFTo8DaTmY20E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1GvyUGk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1766C116B1;
	Tue,  2 Jul 2024 20:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719951176;
	bh=C6b9hc9GQw/hUIKi8BoAMgaCAAFhMQsy++IqseLR5QA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d1GvyUGkyK/a0waMqt29NoCeQ62cuqRD4qqLRK3nO/mKg+pb/2aWLNmjtKEch0c93
	 hxOubkSl81uSYil+Xx7S38ha9rXcLwcyr3PFBm+yKDzCqgUoyNcHGuiY3bx+8PokLG
	 IJiDQPjne9Gd0ZLjenKm9PLMNwPXWsMrBG8cIC2P/xRHiLuwQ2PBDXM1l5YSj+sMxf
	 BtufjrXvtpg9eTRsAL6ajII2LL/xbKP1kqcLO+OCm09GTYSNgyo0p/SNGbadltDw47
	 LbISXa8ZSf4wduamlIv582Ej2Bx9jor6C6aChKZNvgsqstcmX3ATumHFAZ0NaHpOwH
	 lkrcqYxeZ7Oqw==
Date: Tue, 2 Jul 2024 13:12:56 -0700
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
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-hardening@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v6 0/6] slab: Introduce dedicated bucket allocator
Message-ID: <202407021311.1EDB7AE3@keescook>
References: <20240701190152.it.631-kees@kernel.org>
 <e74d47c7-0873-4adb-88a3-60597bf31af6@suse.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e74d47c7-0873-4adb-88a3-60597bf31af6@suse.cz>

On Tue, Jul 02, 2024 at 11:24:57AM +0200, Vlastimil Babka wrote:
> On 7/1/24 9:12 PM, Kees Cook wrote:
> > 
> > Kees Cook (6):
> >   mm/slab: Introduce kmem_buckets typedef
> >   mm/slab: Plumb kmem_buckets into __do_kmalloc_node()
> >   mm/slab: Introduce kvmalloc_buckets_node() that can take kmem_buckets
> >     argument
> >   mm/slab: Introduce kmem_buckets_create() and family
> >   ipc, msg: Use dedicated slab buckets for alloc_msg()
> >   mm/util: Use dedicated slab buckets for memdup_user()
> 
> pushed to slab/for-6.11/buckets, slab/for-next

Great! Thanks for the review and improvements! :) I'll get started on
the next step getting it hooked up to the codetag bits...

-- 
Kees Cook


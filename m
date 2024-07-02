Return-Path: <netdev+bounces-108611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 205459248CD
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 22:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1839285459
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 20:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EF120012E;
	Tue,  2 Jul 2024 20:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIMuzbG9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B1A200118;
	Tue,  2 Jul 2024 20:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719951111; cv=none; b=dZCndAbg2Ic0ZHeaRVDI7Re0CvhxvFeMZYlzwsGoxXh9Rpf4b6Z/w7WucWA+1hVojffqf6xSxUd0KweErz1mc3SVQN8yV8HRj+D+0zLgQhfAFpOTeGRHYs8Jnc6Y32H830QlXyaOg5wMGAbi0JGW1z4QiSPz+nozT84TjE9ZhMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719951111; c=relaxed/simple;
	bh=lvt2df83NkLUTgsbk8BOq8Dapmt5UAWGkzhq+iigNqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4hdV7vM8PccfagMsdlVJyoMcQ5BGOiccfXiF5wYcLoz81j1sDyWWcLVeuRCON2Wsg6k1wZU5TbENkCW1HMQk9qGrn16TVqsiyvbNIqyP/kPdvN0lIrotGTWDG9aSXk+zsNl5dOemXtqk7f76wu7G39D2LyhWkSvoP9dydFunNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIMuzbG9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA71C116B1;
	Tue,  2 Jul 2024 20:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719951110;
	bh=lvt2df83NkLUTgsbk8BOq8Dapmt5UAWGkzhq+iigNqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WIMuzbG906YGZpjUEAEondBndofI68Am1PNAkSAzHFzCQIuQhARm55mSr+30UGg/W
	 KUG/fORw60SBI6qCY4gYxh9rm/JK8bXtRA0F9QygwWnkNbvtqUUcRXmrLQyMTy4jmO
	 Is+CeCJ0eG7qcJiXjiNcOyGarMxtr107YgUXZy1FoMQ7T6N+mA5DrifAasjX6ZIcfg
	 nG7uyklKekPzrfi6j1ITmYh7uJ+sxMgv0msYAq9FC3ZKKvdi5O66Omnxe8VEUA21A3
	 ma2NEaklA64JfjRwg4AUQR8l+jF1a3W+8iOzz7Ykkh6nLVk2eY4gZ+9Dy4C2Q2Zsdg
	 B+aqE16h7B44Q==
Date: Tue, 2 Jul 2024 13:11:50 -0700
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
Subject: Re: [PATCH v6 4/6] mm/slab: Introduce kmem_buckets_create() and
 family
Message-ID: <202407021311.A594875FC6@keescook>
References: <20240701190152.it.631-kees@kernel.org>
 <20240701191304.1283894-4-kees@kernel.org>
 <5b8e6ddc-6472-4acd-a506-98bc3586f1f3@suse.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b8e6ddc-6472-4acd-a506-98bc3586f1f3@suse.cz>

On Tue, Jul 02, 2024 at 11:19:28AM +0200, Vlastimil Babka wrote:
> On 7/1/24 9:13 PM, Kees Cook wrote:
> >  #ifdef SLAB_SUPPORTS_SYSFS
> >  /*
> >   * For a given kmem_cache, kmem_cache_destroy() should only be called
> > @@ -931,6 +1023,10 @@ void __init create_kmalloc_caches(void)
> >  
> >  	/* Kmalloc array is now usable */
> >  	slab_state = UP;
> > +
> > +	kmem_buckets_cache = kmem_cache_create("kmalloc_buckets",
> > +					       sizeof(kmem_buckets),
> > +					       0, SLAB_NO_MERGE, NULL);
> 
> Locally adjusted to put this behind "if (IS_ENABLED(CONFIG_SLAB_BUCKETS))"

Oops, yes, good catch. Thank you!

-- 
Kees Cook


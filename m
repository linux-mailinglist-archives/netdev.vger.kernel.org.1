Return-Path: <netdev+bounces-107535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4662191B629
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 07:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EF27B2261A
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 05:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9473BB21;
	Fri, 28 Jun 2024 05:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJqSI7u9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E462249F5;
	Fri, 28 Jun 2024 05:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719552945; cv=none; b=urvDHG9w8mXkyXNQhblNKpa6dWHT5DXbk3grQxPtxNnko/t2QbUcMC+dLjTmZ/bX0hTjUKMijDHZ2R/giUtUufoARtIwp//jq3X0xJZsxRDO9dMTMth0rSigYC/M0kzoJgLf2J/fcBOnlBpFW60aCUKNngFBsvQnQ+/0/03VOmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719552945; c=relaxed/simple;
	bh=IlQ4xRDR9vSYKjMYL2WxDtkD3cu6REFBuu+GLyGSAG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orfF7QYy/lDaBT6SxP+TqkEXLng2ITZNs83uPaMuk/8+ltECjMd6U5VWTTkd5R+TSfe0DFrQ69tdF8Uw6s7oAsO+uXh8j86lgSQNGaPy5Vk7kp+JGTJ/xVlz0nnjXuaF4Fobd2nRrhS67ulOFkxHFoSSSOSGz1ZzXNmil54/kEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJqSI7u9; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-48f5b8cde8cso70213137.2;
        Thu, 27 Jun 2024 22:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719552943; x=1720157743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BD+z54TW9IfkYnjMzOI9a5At2j/hB/YpkVnnQF4DGJY=;
        b=XJqSI7u9OcCdxdkubtMM7TnEjllGxVVhHvmNdzPOYgOW5Y29YjWKDG/4MJmjYaCHUE
         z0/SdtiW1srpWZb/v1sw0JP55ddjKJq24H4hAxS2X/ieOCKZpnkrj2I8QS/4SsG41Ik8
         WhA1e6fbFjV/eBYcohw+tuHWOs6AfJM1/XVWcoAJZaiqcplD7TeujO1fRAdF3Bki961i
         XTx+3nq9+dpMtxYH9QBgdRjGUNjueor8+GK5y9vnkNBON+kjeOskN8BoT4aKk/jeAEMr
         L7UK+3isCIjMjt04Vs84DJual1kJgwhfHwH8VqbkotHU7VfI+Jv11dgdwVp7mcMIV6d4
         AEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719552943; x=1720157743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BD+z54TW9IfkYnjMzOI9a5At2j/hB/YpkVnnQF4DGJY=;
        b=a1G1rsPewqRvMy7pshRuLnD4FYG7hKBulFrh4nWX+zeszIfUUoem6MA52z6WOuM7Fd
         qw11BHivSPuHeaUtp6VlIwchnPU8Gs8k15nz8vdUHPDSYgwigaktcUZY7eyXPZQpvboK
         QovTBJ+VpmJMLdZdNr6kVUAMdXAu9PpggfYEkEuKoU7b2PfUoMQAuCwaCgU4sJec+PYB
         dsf29utnvOy7TeoMr5v2RMcwN349xxAVzCy9dk0fk/aY6QafYNJhG2OtXIpNPDAr4nld
         dHGo/xj5nj4CHyJerG8uVtznMGWxi6DRm567V16qPkY6f5u+oFMurVS1IUMyFEQ5kJyC
         /5Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWUgXEqsBal73R7/HlNWLOksAfBxsapEoQJqSuJSQlci85WvkRkA3KXhdvL9OjYB5bfLKG9KkWQKE4i0KjrRLFWFUb0Ra7vsgvKZBz+hz3vDpsK0iI2Xd5Wio9HDuo7FvR0xyONIeYPk4LQFVwEM/JOeUW0KAXDEX0iDJlbBvlq4A358I62wyomcodieen8+NxIXm/GRGHk0edXM+LlK06CP8sBx44=
X-Gm-Message-State: AOJu0YyUDsxyD6Yl1M6e743kUi8lnt//iR62aEk00T5V53wEQqgdgOYA
	YrtVdCfw0Etx1q/IQ3QjnfIyDEu2yhD/EAQ8jORKyD0D9nWv67ZB
X-Google-Smtp-Source: AGHT+IGghsZyTtJONCT4wuQZ86eZ7o7Mbz4W7tvHc+RnW+oKueDx7rXUJ8zzubnuKDPNXOVbgLb+UQ==
X-Received: by 2002:a05:6102:3585:b0:48f:6581:c16c with SMTP id ada2fe7eead31-48f6581c945mr15269960137.6.1719552942915;
        Thu, 27 Jun 2024 22:35:42 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d69302057sm44472385a.100.2024.06.27.22.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 22:35:39 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id EA24F1200068;
	Fri, 28 Jun 2024 01:35:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 28 Jun 2024 01:35:37 -0400
X-ME-Sender: <xms:qUt-ZmqaHNsCY2ddke710YaM0kHbtOeTvROhMLDkFljAY8kJyWCFgA>
    <xme:qUt-ZkoXl4v7y-i9DgBt5BfK6akRpGb3_Swe22ybFRdURUKgep28o3nfuG-UazxU3
    z7vMHdb8DN4R7SdYg>
X-ME-Received: <xmr:qUt-ZrO-2clO789RFIEUsgbABcBZgAoBl_e63DaPSacY6BZILQ1fKGoy3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtdehgddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:qUt-Zl5w8t43AsFIWsJa-NUmwY_FS7MDCGZSCItXjjLnbYwgUg_6CQ>
    <xmx:qUt-Zl4QGhUHpmK463Dj9yiRePg2XjDSDMSDQX4xhmCSO_dy8GLfEA>
    <xmx:qUt-ZlgIXIJvZSu1xj0PWO77UyYnlYyLj2zoZUqVO_WHNMsViaPdMA>
    <xmx:qUt-Zv4ubKSy75dLhfdDogpBhQQGP5NOZzCsb0cYkQKaGTDfvbUSLw>
    <xmx:qUt-ZgIDIdN3blAFpx8Bn6eNZrsWDKn09NV2o4P90W4cLiaFbST6-E1U>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Jun 2024 01:35:37 -0400 (EDT)
Date: Thu, 27 Jun 2024 22:35:36 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <kees@kernel.org>, "GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
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
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 4/6] mm/slab: Introduce kmem_buckets_create() and
 family
Message-ID: <Zn5LqMlnbuSMx7H3@Boquns-Mac-mini.home>
References: <20240619192131.do.115-kees@kernel.org>
 <20240619193357.1333772-4-kees@kernel.org>
 <cc301463-da43-4991-b001-d92521384253@suse.cz>
 <202406201147.8152CECFF@keescook>
 <1917c5a5-62af-4017-8cd0-80446d9f35d3@suse.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1917c5a5-62af-4017-8cd0-80446d9f35d3@suse.cz>

On Thu, Jun 20, 2024 at 10:43:39PM +0200, Vlastimil Babka wrote:
> On 6/20/24 8:54 PM, Kees Cook wrote:
> > On Thu, Jun 20, 2024 at 03:56:27PM +0200, Vlastimil Babka wrote:
> >> > @@ -549,6 +549,11 @@ void *kmem_cache_alloc_lru_noprof(struct kmem_cache *s, struct list_lru *lru,
> >> >  
> >> >  void kmem_cache_free(struct kmem_cache *s, void *objp);
> >> >  
> >> > +kmem_buckets *kmem_buckets_create(const char *name, unsigned int align,
> >> > +				  slab_flags_t flags,
> >> > +				  unsigned int useroffset, unsigned int usersize,
> >> > +				  void (*ctor)(void *));
> >> 
> >> I'd drop the ctor, I can't imagine how it would be used with variable-sized
> >> allocations.
> > 
> > I've kept it because for "kmalloc wrapper" APIs, e.g. devm_kmalloc(),
> > there is some "housekeeping" that gets done explicitly right now that I
> > think would be better served by using a ctor in the future. These APIs
> > are variable-sized, but have a fixed size header, so they have a
> > "minimum size" that the ctor can still operate on, etc.
> > 
> >> Probably also "align" doesn't make much sense since we're just
> >> copying the kmalloc cache sizes and its implicit alignment of any
> >> power-of-two allocations.
> > 
> > Yeah, that's probably true. I kept it since I wanted to mirror
> > kmem_cache_create() to make this API more familiar looking.
> 
> Rust people were asking about kmalloc alignment (but I forgot the details)

It was me! The ask is whether we can specify the alignment for the
allocation API, for example, requesting a size=96 and align=32 memory,
or the allocation API could do a "best alignment", for example,
allocating a size=96 will give a align=32 memory. As far as I
understand, kmalloc() doesn't support this.

> so maybe this could be useful for them? CC rust-for-linux.
> 

I took a quick look as what kmem_buckets is, and seems to me that align
doesn't make sense here (and probably not useful in Rust as well)
because a kmem_buckets is a set of kmem_caches, each has its own object
size, making them share the same alignment is probably not what you
want. But I could be missing something.

Regards,
Boqun

> >> I don't think any current kmalloc user would
> >> suddenly need either of those as you convert it to buckets, and definitely
> >> not any user converted automatically by the code tagging.
> > 
> > Right, it's not needed for either the explicit users nor the future
> > automatic users. But since these arguments are available internally,
> > there seems to be future utility,  it's not fast path, and it made things
> > feel like the existing API, I'd kind of like to keep it.
> > 
> > But all that said, if you really don't want it, then sure I can drop
> > those arguments. Adding them back in the future shouldn't be too
> > much churn.
> 
> I guess we can keep it then.
> 


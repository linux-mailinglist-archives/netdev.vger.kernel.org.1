Return-Path: <netdev+bounces-108521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 519DB92417A
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 16:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07B4E285B5B
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 14:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3191BA071;
	Tue,  2 Jul 2024 14:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ew905hG1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A771015B547;
	Tue,  2 Jul 2024 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719932132; cv=none; b=hCb6qBFDWg5+krixCkM0AuNb+vrT9xuzWkXC5g2OE+CWXwtdBi1pu3w/Hsk2eB3cLHSxuMtL/QuR9vdsPsa8OQUawImkGcypSlnfa/8RGiQWRM7eAYvqPlDVHtOoFfJ3/MT32iG7vV2SjhrFRrMVk1avG5PwbnklWVOLdF4khmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719932132; c=relaxed/simple;
	bh=fV11fb9p3oP4r4E8yDJgpWdiPgOI/dcSEi2VCpv9g+4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tdLbdJkcNWjdKC9yN5tvHkfUhG6FbS0Sw3MECzyaimDxMn789FPxVhCoopWi0CblKx60qMJNSNG0oavQz9r3Esn26MLbLUmL3areUkBLdPN+15O28bPVqeuGnnsisZ9y19ATiaKyLCHmrb1XOZa9sa4dte8dR0MwFn2ZbBLKcZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ew905hG1; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7066c9741fbso3647500b3a.2;
        Tue, 02 Jul 2024 07:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719932130; x=1720536930; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9OGXbzNGbjnsLUjt5Zv9TpCqKrLdjkqV9+QuFlxbk8g=;
        b=ew905hG18GuXg2pZWNR06R3QXlS/vK/XUSqcIJ7IuMKUmH6g+cywbyTb4B2nAOYLoV
         qGM2f3e5hKWS05w9CoLfBajmIKB6Kr53ndjhz30QHExHffAKAyBD3kmeSf7JZEVmOkqN
         U5/xQuZPoRSh/VaA/tY7AQqxKMTuBUms1kVRHprauB7w5qR30Z5nImEkCWDg7sPbaj2Z
         pMwshv/EAnt2vMS8/HErLe7AGAD7VrCpUM4+nC9j6fKDLe+n/ZTMQ5Ra6jRhu3YcLSsM
         IJOeOj/CDajEPCeB4l4cvzoW966VbmFVSPw57vcHdq9pAFnO1HJbAx5lBa7SADMuviVI
         tgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719932130; x=1720536930;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9OGXbzNGbjnsLUjt5Zv9TpCqKrLdjkqV9+QuFlxbk8g=;
        b=QC4qb33SyiV6zVMZVjk9s3YGAWnWhyXz48bwgPiZStYxR9KcGJi1F9NsDCckM8/hNK
         lGjkxLCXsxkFtH8Y58Zkh8fESOlXL20Pmxf5MyUfPwgFfWhfoE661qaxqfRe5r8Pf2Z1
         b//EJAtsxRJv7aCnNzmw61D1suLmrtUjP5oZATooTm9yEKAOzEQGcks8YFljTsdtknIY
         lkswV2ZaG1/xKlWTPbC7n3XzcEu2zbAgTbIyFOo1v+LDEInMdG6wuY5lPp4sGC1+/d5r
         Nx5hiynRO4jRBKRRpYsAyoeU5A3Zix0Ai7+V8xJBNioxMmIV14oLa8+DW1M0X4EixZaw
         S0Qg==
X-Forwarded-Encrypted: i=1; AJvYcCXKEeC68RoqDAS4MmnZJn45z2xD+msCtYAnQOx/QgCk5F2wlnHcT4TelkBbtZ3gQDpi8bv6BGt5guWaxhPvrTXkN7Kf0hmdxOONd7B6
X-Gm-Message-State: AOJu0YzNNeak09PLh6MM2UxUusocOi9pNAadd23rR8w43Vf6Qs/5z0ph
	G25KdF4sVj3/oC3JVfm8HRhzZrjsRG7DXOedy00rhAzF+NNuhegq
X-Google-Smtp-Source: AGHT+IH1YECTFAEimrLkU/d6q9/7iZflbsv/ea8MM+wfWUwMRnC8OwhPU9DqE4O7i8GWtuklPaTkyQ==
X-Received: by 2002:a05:6a00:1daa:b0:706:62b6:cbd3 with SMTP id d2e1a72fcca58-70aaaeecaf1mr13669707b3a.26.1719932129674;
        Tue, 02 Jul 2024 07:55:29 -0700 (PDT)
Received: from ?IPv6:2605:59c8:829:4c00:82ee:73ff:fe41:9a02? ([2605:59c8:829:4c00:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70801e57ac8sm8611992b3a.8.2024.07.02.07.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 07:55:29 -0700 (PDT)
Message-ID: <a026c32218cabc7b6dc579ced1306aefd7029b10.camel@gmail.com>
Subject: Re: [PATCH net-next v9 06/13] mm: page_frag: reuse existing space
 for 'size' and 'pfmemalloc'
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org,  pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton
	 <akpm@linux-foundation.org>, linux-mm@kvack.org
Date: Tue, 02 Jul 2024 07:55:27 -0700
In-Reply-To: <808be796-6333-c116-6ecb-95a39f7ad76e@huawei.com>
References: <20240625135216.47007-1-linyunsheng@huawei.com>
	 <20240625135216.47007-7-linyunsheng@huawei.com>
	 <12a8b9ddbcb2da8431f77c5ec952ccfb2a77b7ec.camel@gmail.com>
	 <808be796-6333-c116-6ecb-95a39f7ad76e@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-02 at 20:35 +0800, Yunsheng Lin wrote:
> On 2024/7/2 8:08, Alexander H Duyck wrote:
> > On Tue, 2024-06-25 at 21:52 +0800, Yunsheng Lin wrote:
> > > Currently there is one 'struct page_frag' for every 'struct
> > > sock' and 'struct task_struct', we are about to replace the
> > > 'struct page_frag' with 'struct page_frag_cache' for them.
> > > Before begin the replacing, we need to ensure the size of
> > > 'struct page_frag_cache' is not bigger than the size of
> > > 'struct page_frag', as there may be tens of thousands of
> > > 'struct sock' and 'struct task_struct' instances in the
> > > system.
> > >=20
> > > By or'ing the page order & pfmemalloc with lower bits of
> > > 'va' instead of using 'u16' or 'u32' for page size and 'u8'
> > > for pfmemalloc, we are able to avoid 3 or 5 bytes space waste.
> > > And page address & pfmemalloc & order is unchanged for the
> > > same page in the same 'page_frag_cache' instance, it makes
> > > sense to fit them together.
> > >=20
> > > Also, it is better to replace 'offset' with 'remaining', which
> > > is the remaining size for the cache in a 'page_frag_cache'
> > > instance, we are able to do a single 'fragsz > remaining'
> > > checking for the case of cache not being enough, which should be
> > > the fast path if we ensure size is zoro when 'va' =3D=3D NULL by
> > > memset'ing 'struct page_frag_cache' in page_frag_cache_init()
> > > and page_frag_cache_drain().
> > >=20
> > > After this patch, the size of 'struct page_frag_cache' should be
> > > the same as the size of 'struct page_frag'.
> > >=20
> > > CC: Alexander Duyck <alexander.duyck@gmail.com>
> > > Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> > > ---
> > >  include/linux/page_frag_cache.h | 76 +++++++++++++++++++++++-----
> > >  mm/page_frag_cache.c            | 90 ++++++++++++++++++++-----------=
--
> > >  2 files changed, 118 insertions(+), 48 deletions(-)
> > >=20
> > > diff --git a/include/linux/page_frag_cache.h b/include/linux/page_fra=
g_cache.h
> > > index 6ac3a25089d1..b33904d4494f 100644
> > > --- a/include/linux/page_frag_cache.h
> > > +++ b/include/linux/page_frag_cache.h
> > > @@ -8,29 +8,81 @@
> > >  #define PAGE_FRAG_CACHE_MAX_SIZE	__ALIGN_MASK(32768, ~PAGE_MASK)
> > >  #define PAGE_FRAG_CACHE_MAX_ORDER	get_order(PAGE_FRAG_CACHE_MAX_SIZE=
)
> > > =20
> > > -struct page_frag_cache {
> > > -	void *va;
> > > +/*
> > > + * struct encoded_va - a nonexistent type marking this pointer
> > > + *
> > > + * An 'encoded_va' pointer is a pointer to a aligned virtual address=
, which is
> > > + * at least aligned to PAGE_SIZE, that means there are at least 12 l=
ower bits
> > > + * space available for other purposes.
> > > + *
> > > + * Currently we use the lower 8 bits and bit 9 for the order and PFM=
EMALLOC
> > > + * flag of the page this 'va' is corresponding to.
> > > + *
> > > + * Use the supplied helper functions to endcode/decode the pointer a=
nd bits.
> > > + */
> > > +struct encoded_va;
> > > +
> >=20
> > Why did you create a struct for this? The way you use it below it is
> > just a pointer. No point in defining a struct that doesn't exist
> > anywhere.
>=20
> The encoded_va is mirroring the encoded_page below:
> https://elixir.bootlin.com/linux/v6.10-rc6/source/include/linux/mm_types.=
h#L222
> https://github.com/torvalds/linux/commit/70fb4fdff5826a48886152fd5c5db04e=
b6c59a40
>=20
> "So this introduces a 'struct encoded_page' pointer that cannot be used f=
or
> anything else than to encode a real page pointer and a couple of extra
> bits in the low bits.  That way the compiler can trivially track the stat=
e
> of the pointer and you just explicitly encode and decode the extra bits."
>=20
> It seems to be similar for encoded_va case too, I guess this is more of p=
ersonal
> preference for using a struct or unsigned long here, I have no strong pre=
ference
> here and it can be changed if you really insist.
>=20

Really this seems like a bad copy with none of the guardrails. I still
think you would be better off just storing this as a long rather than a
pointer. It doesn't need to be a pointer and it creates a bunch of
unnecessary extra overhead.

In addition if you store it as a long as I mentioned it will make it
much easier to extract the size and pfmemalloc fields. Basically this
thing is more bitfield(2 items) than pointer(1 item) which is why I
think it would make more sense as an unsigned long. Then you only have
to cast to get the pointer in and the pointer out.

> >=20
> > > +#define PAGE_FRAG_CACHE_ORDER_MASK		GENMASK(7, 0)
> > > +#define PAGE_FRAG_CACHE_PFMEMALLOC_BIT		BIT(8)
> > > +#define PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT	8
> > > +
> > > +static inline struct encoded_va *encode_aligned_va(void *va,
> > > +						   unsigned int order,
> > > +						   bool pfmemalloc)
> > > +{
> > >  #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> > > -	__u16 offset;
> > > -	__u16 size;
> > > +	return (struct encoded_va *)((unsigned long)va | order |
> > > +			pfmemalloc << PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT);
> > >  #else
> > > -	__u32 offset;
> > > +	return (struct encoded_va *)((unsigned long)va |
> > > +			pfmemalloc << PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT);
> > > +#endif
> > > +}
> > > +

This is missing any and all protection of the example you cited. If I
want to pass order as a 32b value I can and I can corrupt the virtual
address. Same thing with pfmemalloc. Lets only hope you don't hit an
architecture where a bool is a u8 in size as otherwise that shift is
going to wipe out the value, and if it is a u32 which is usually the
case lets hope they stick to the values of 0 and 1.

> > > +static inline unsigned long encoded_page_order(struct encoded_va *en=
coded_va)
> > > +{
> > > +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> > > +	return PAGE_FRAG_CACHE_ORDER_MASK & (unsigned long)encoded_va;
> > > +#else
> > > +	return 0;
> > > +#endif
> > > +}
> > > +
> > > +static inline bool encoded_page_pfmemalloc(struct encoded_va *encode=
d_va)
> > > +{
> > > +	return PAGE_FRAG_CACHE_PFMEMALLOC_BIT & (unsigned long)encoded_va;
> > > +}
> > > +
> >=20
> > My advice is that if you just make encoded_va an unsigned long this
> > just becomes some FIELD_GET and bit operations.
>=20
> As above.
>=20

The code you mentioned had one extra block of bits that was in it and
had strict protections on what went into and out of those bits. You
don't have any of those protections.

I suggest you just use a long and don't bother storing this as a
pointer.

> > > +static inline void *encoded_page_address(struct encoded_va *encoded_=
va)
> > > +{
> > > +	return (void *)((unsigned long)encoded_va & PAGE_MASK);
> > > +}
> > > +
> > > +struct page_frag_cache {
> > > +	struct encoded_va *encoded_va;
> >=20
> > This should be an unsigned long, not a pointer since you are storing
> > data other than just a pointer in here. The pointer is just one of the
> > things you extract out of it.
> >=20
> > > +
> > > +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <=3D 32=
)
> > > +	u16 pagecnt_bias;
> > > +	u16 remaining;
> > > +#else
> > > +	u32 pagecnt_bias;
> > > +	u32 remaining;
> > >  #endif
> > > -	/* we maintain a pagecount bias, so that we dont dirty cache line
> > > -	 * containing page->_refcount every time we allocate a fragment.
> > > -	 */
> > > -	unsigned int		pagecnt_bias;
> > > -	bool pfmemalloc;
> > >  };
> > > =20
> > >  static inline void page_frag_cache_init(struct page_frag_cache *nc)
> > >  {
> > > -	nc->va =3D NULL;
> > > +	memset(nc, 0, sizeof(*nc));
> >=20
> > Shouldn't need to memset 0 the whole thing. Just setting page and order
> > to 0 should be enough to indicate that there isn't anything there.
>=20
> As mentioned in the commit log:
> 'Also, it is better to replace 'offset' with 'remaining', which
> is the remaining size for the cache in a 'page_frag_cache'
> instance, we are able to do a single 'fragsz > remaining'
> checking for the case of cache not being enough, which should be
> the fast path if we ensure 'remaining' is zero when 'va' =3D=3D NULL by
> memset'ing 'struct page_frag_cache' in page_frag_cache_init()
> and page_frag_cache_drain().'
>=20
> Yes, we are only really depending on nc->remaining being zero
> when 'va' =3D=3D NULL untill next patch refactors more codes in
> __page_frag_alloc_va_align() to __page_frag_cache_refill().
> Perhap I should do the memset() thing in next patch.
>=20

I get that. You reverted the code back to where it was in patch 3 but
are retaining the bottom up direction. If you were going to do that you
might as well just did the "remaining" change in patch 3 and saved me
having to review the same block of logic twice.

>=20
>=20
> >=20
> > >  static struct page *__page_frag_cache_refill(struct page_frag_cache =
*nc,
> > >  					     gfp_t gfp_mask)
> > >  {
> > >  	struct page *page =3D NULL;
> > >  	gfp_t gfp =3D gfp_mask;
> > > +	unsigned int order;
> > > =20
> > >  #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> > >  	gfp_mask =3D (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
> > >  		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
> > >  	page =3D alloc_pages_node(NUMA_NO_NODE, gfp_mask,
> > >  				PAGE_FRAG_CACHE_MAX_ORDER);
> > > -	nc->size =3D page ? PAGE_FRAG_CACHE_MAX_SIZE : PAGE_SIZE;
> > >  #endif
> > > -	if (unlikely(!page))
> > > +	if (unlikely(!page)) {
> > >  		page =3D alloc_pages_node(NUMA_NO_NODE, gfp, 0);
> > > +		if (unlikely(!page)) {
> > > +			memset(nc, 0, sizeof(*nc));
> > > +			return NULL;
> > > +		}
> > > +
> > > +		order =3D 0;
> > > +		nc->remaining =3D PAGE_SIZE;
> > > +	} else {
> > > +		order =3D PAGE_FRAG_CACHE_MAX_ORDER;
> > > +		nc->remaining =3D PAGE_FRAG_CACHE_MAX_SIZE;
> > > +	}
> > > =20
> > > -	nc->va =3D page ? page_address(page) : NULL;
> > > +	/* Even if we own the page, we do not use atomic_set().
> > > +	 * This would break get_page_unless_zero() users.
> > > +	 */
> > > +	page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
> > > =20
> > > +	/* reset page count bias of new frag */
> > > +	nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
> >=20
> > I would rather keep the pagecnt_bias, page reference addition, and
> > resetting of remaining outside of this. The only fields we should be
> > setting are order, the virtual address, and pfmemalloc since those are
> > what is encoded in your unsigned long variable.
>=20
> Is there any reason why you want to keep them outside of this?

Because this is now essentially a function to allocate an encoded page.
The output should be your encoded virtual address with the size and
pfmemalloc flags built in.

> For resetting of remaining, it seems we need more check to decide the
> value of remaining if it is kept outside of this.
>=20
> Also, for the next patch, more common codes are refactored out of
>  __page_frag_alloc_va_align() to __page_frag_cache_refill(), so that
> the new API can make use of them, so I am not sure it really matter
> that much.
>=20
> >=20
> > > +	nc->encoded_va =3D encode_aligned_va(page_address(page), order,
> > > +					   page_is_pfmemalloc(page));
> > >  	return page;
> > >  }
> > > =20
> > >  void page_frag_cache_drain(struct page_frag_cache *nc)
> > >  {
> > > -	if (!nc->va)
> > > +	if (!nc->encoded_va)
> > >  		return;
> > > =20
> > > -	__page_frag_cache_drain(virt_to_head_page(nc->va), nc->pagecnt_bias=
);
> > > -	nc->va =3D NULL;
> > > +	__page_frag_cache_drain(virt_to_head_page(nc->encoded_va),
> > > +				nc->pagecnt_bias);
> > > +	memset(nc, 0, sizeof(*nc));
> >=20
> > Again, no need for memset when "nv->encoded_va =3D 0" will do.
> >=20
> > >  }
> > >  EXPORT_SYMBOL(page_frag_cache_drain);
> > > =20
> > > @@ -62,51 +89,41 @@ void *__page_frag_alloc_va_align(struct page_frag=
_cache *nc,
> > >  				 unsigned int fragsz, gfp_t gfp_mask,
> > >  				 unsigned int align_mask)
> > >  {
> > > -	unsigned int size =3D PAGE_SIZE;
> > > +	struct encoded_va *encoded_va =3D nc->encoded_va;
> > >  	struct page *page;
> > > -	int offset;
> > > +	int remaining;
> > > +	void *va;
> > > =20
> > > -	if (unlikely(!nc->va)) {
> > > +	if (unlikely(!encoded_va)) {
> > >  refill:
> > > -		page =3D __page_frag_cache_refill(nc, gfp_mask);
> > > -		if (!page)
> > > +		if (unlikely(!__page_frag_cache_refill(nc, gfp_mask)))
> > >  			return NULL;
> > > =20
> > > -		/* Even if we own the page, we do not use atomic_set().
> > > -		 * This would break get_page_unless_zero() users.
> > > -		 */
> > > -		page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
> > > -
> > > -		/* reset page count bias and offset to start of new frag */
> > > -		nc->pfmemalloc =3D page_is_pfmemalloc(page);
> > > -		nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
> > > -		nc->offset =3D 0;
> > > +		encoded_va =3D nc->encoded_va;
> > >  	}
> > > =20
> > > -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> > > -	/* if size can vary use size else just use PAGE_SIZE */
> > > -	size =3D nc->size;
> > > -#endif
> > > -
> > > -	offset =3D __ALIGN_KERNEL_MASK(nc->offset, ~align_mask);
> > > -	if (unlikely(offset + fragsz > size)) {
> > > -		page =3D virt_to_page(nc->va);
> > > -
> > > +	remaining =3D nc->remaining & align_mask;
> > > +	remaining -=3D fragsz;
> > > +	if (unlikely(remaining < 0)) {
> >=20
> > Now this is just getting confusing. You essentially just added an
> > additional addition step and went back to the countdown approach I was
> > using before except for the fact that you are starting at 0 whereas I
> > was actually moving down through the page.
>=20
> Does the 'additional addition step' mean the additional step to calculate
> the offset using the new 'remaining' field? I guess that is the disadvant=
age
> by changing 'offset' to 'remaining', but it also some advantages too:
>=20
> 1. it is better to replace 'offset' with 'remaining', which
>    is the remaining size for the cache in a 'page_frag_cache'
>    instance, we are able to do a single 'fragsz > remaining'
>    checking for the case of cache not being enough, which should be
>    the fast path if we ensure size is zoro when 'va' =3D=3D NULL by
>    memset'ing 'struct page_frag_cache' in page_frag_cache_init()
>    and page_frag_cache_drain().
> 2. It seems more convenient to implement the commit/probe API too
>    when using 'remaining' instead of 'offset' as those API needs
>    the remaining size of the page_frag_cache anyway.
>=20
> So it is really a trade-off between using 'offset' and 'remaining',
> it is like the similar argument about trade-off between allocating
> fragment 'countdown' and 'countup' way.
>=20
> About confusing part, as the nc->remaining does mean how much cache
> is left in the 'nc', and nc->remaining does start from
> PAGE_FRAG_CACHE_MAX_SIZE/PAGE_SIZE to zero naturally if that was what
> you meant by 'countdown', but it is different from the 'offset countdown'
> before this patchset as my understanding.
>=20
> >=20
> > What I would suggest doing since "remaining" is a negative offset
> > anyway would be to look at just storing it as a signed negative number.
> > At least with that you can keep to your original approach and would
> > only have to change your check to be for "remaining + fragsz <=3D 0".
>=20
> Did you mean by using s16/s32 for 'remaining'? And set nc->remaining like
> below?
> nc->remaining =3D -PAGE_SIZE or
> nc->remaining =3D -PAGE_FRAG_CACHE_MAX_SIZE

Yes. Basically if we used it as a signed value then you could just work
your way up and do your aligned math still.

> struct page_frag_cache {
>         struct encoded_va *encoded_va;
>=20
> #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <=3D 32)
>         u16 pagecnt_bias;
>         s16 remaining;
> #else
>         u32 pagecnt_bias;
>         s32 remaining;
> #endif
> };
>=20
> If I understand above correctly, it seems we really need a better name
> than 'remaining' to reflect that.

It would effectively work like a countdown. Instead of T - X in this
case it is size - X.

> > With that you can still do your math but it becomes an addition instead
> > of a subtraction.
>=20
> And I am not really sure what is the gain here by using an addition
> instead of a subtraction here.
>=20

The "remaining" as it currently stands is doing the same thing so odds
are it isn't too big a deal. It is just that the original code was
already somewhat confusing and this is just making it that much more
complex.

> > > +		page =3D virt_to_page(encoded_va);
> > >  		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
> > >  			goto refill;
> > > =20
> > > -		if (unlikely(nc->pfmemalloc)) {
> > > -			free_unref_page(page, compound_order(page));
> > > +		if (unlikely(encoded_page_pfmemalloc(encoded_va))) {
> > > +			VM_BUG_ON(compound_order(page) !=3D
> > > +				  encoded_page_order(encoded_va));
> > > +			free_unref_page(page, encoded_page_order(encoded_va));
> > >  			goto refill;
> > >  		}
> > > =20
> > >  		/* OK, page count is 0, we can safely set it */
> > >  		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
> > > =20
> > > -		/* reset page count bias and offset to start of new frag */
> > > +		/* reset page count bias and remaining of new frag */
> > >  		nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
> > > -		offset =3D 0;
> > > -		if (unlikely(fragsz > PAGE_SIZE)) {
> > > +		nc->remaining =3D remaining =3D page_frag_cache_page_size(encoded_=
va);
> > > +		remaining -=3D fragsz;
> > > +		if (unlikely(remaining < 0)) {
> > >  			/*
> > >  			 * The caller is trying to allocate a fragment
> > >  			 * with fragsz > PAGE_SIZE but the cache isn't big
> >=20
> > I find it really amusing that you went to all the trouble of flipping
> > the logic just to flip it back to being a countdown setup. If you were
> > going to bother with all that then why not just make the remaining
> > negative instead? You could save yourself a ton of trouble that way and
> > all you would need to do is flip a few signs.
>=20
> I am not sure I understand the 'a ton of trouble' part here, if 'flipping
> a few signs' does save a ton of trouble here, I would like to avoid 'a
> ton of trouble' here, but I am not really understand the gain here yet as
> mentioned above.

It isn't about flipping the signs. It is more the fact that the logic
has now become even more complex then it originally was. With my work
backwards approach the advantage was that the offset could be updated
and then we just recorded everything and reported it up. Now we have to
keep a temporary "remaining" value, generate our virtual address and
store that to a temp variable, we can record the new "remaining" value,
and then we can report the virtual address. If we get the ordering on
the steps 2 and 3 in this it will cause issues as we will be pointing
to the wrong values. It is something I can see someone easily messing
up.



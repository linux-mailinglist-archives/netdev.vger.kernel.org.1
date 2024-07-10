Return-Path: <netdev+bounces-110592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7624D92D4F6
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 17:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5BE4B23902
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 15:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671221946AA;
	Wed, 10 Jul 2024 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVueqHrL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE541946A6;
	Wed, 10 Jul 2024 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720625341; cv=none; b=Ygnx3579+J2VL+cyfTSrVeOF8UyHnrD2k8lOKMAkkl/hvztk3J1d7AUP9R4ID/nsI/D7p2Ov+hV2rCP1Ef8mXhFOaPJ0AXN0ahn6S3VDldY18Q2YoGsnvopK/4juwlgEL49QOe99x263fcxSzthGQnvlGYc94fY6lWjxO7mO2NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720625341; c=relaxed/simple;
	bh=IyehjWIsM53J0ddO234KxdBr5Cv7RUieRqPY2cLjUMo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dBy4cVo6SK38+ZhBFLW927D/vjXEiCFhGlpA2raas8t3ls8rfTpe9+Reewv7uVvSNugwNqnKy9zln0+9nVAlX/Yb2LLwUjCMh2iZOU/AvaPmWISBnm13ZB8LsDCWM7E5MdDwbc0i8u/OCIDS4pLzRHgtsFZNNYwUDa5tBUWyhmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVueqHrL; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f65a3abd01so46184785ad.3;
        Wed, 10 Jul 2024 08:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720625339; x=1721230139; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IffoAPp/uRB21Wuq/BVZOeJyN/KRhfS7IzKLX03THPE=;
        b=UVueqHrLveXI5DWNU584Aqa9LkNLMbTokbwEfyJb5axcQ2YsUFuPJlsPe8G5KgmeJi
         wbmVSXP2c5lEP2J1fFT/N/59J1lbEemLdQVcCHVAbGFcM1dsZDWO5YMfIqo9/JD8j6eH
         FVass+Yqsz7/VjRiniF2ylwUGOfKb5KmKcIWCPcQiG8gxt0f4hUFsBVatrI1Xb72YaF/
         cKFlTtaFjEoy/yJJDsLZvCfa+W8/nSP79g9Bn21uhRyDphg1lBz6fj+u+QYpfJQfdb7h
         IXGje6AblEyEk3ObnBwIFCgR7y4RSuoi4QQGEx9YFMA35PnPvGeMwhXLQPdm7sC7oZ+2
         XlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720625339; x=1721230139;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IffoAPp/uRB21Wuq/BVZOeJyN/KRhfS7IzKLX03THPE=;
        b=kob7PbVWbKVnqFIO/4+pDsg5U8nUCVlQnA2+3Gbm21uUepcv4Xj6LykvMBnbzpXjDk
         SCaF7q+K7k32lpQUrAZjZAyRsgstoD3FWMrtZErZXNWEav1fKfaxPXwxleN1QKtnLcdw
         FxvI6q1u6/unJ6le4MOZqujC8l/T5q2xpxmPZd6cxwlkSbS4NXdNlMTJ+AZB/xl2vGNd
         AeGot7nF1w2WqVmEpPXYSDtl32FsJCRGFtnKZNLKDxT1gJR8/4kPVJI40QsRwE8ioN4E
         Trs8qvkDpwGYQculC6GPjieIBKzDFNKfXypBQKvUm1jqivn6uOvd/ei5RB06tw1ThwGq
         FRyw==
X-Forwarded-Encrypted: i=1; AJvYcCXEWMxcGM3HM1YBF3hn+qU22LsSVp2NJflmiPHYStlujxbGzUxrat4G6dwwSeHrR4IdleaDGfnrhuUyYnRbeE1Zaj+35dZUrRhBePG8
X-Gm-Message-State: AOJu0Yy1nLgn5RmqvgwDLeKb/enp4iWY2pE1eB9XpsL/9AgZwtsxFq06
	w6IU3OiB3/GxDgbUWAzML/vCEHJBV6tRY1E+4HnMb6d/lDRXqVRn01mGtQ==
X-Google-Smtp-Source: AGHT+IHzbwMb4GCeUTF2MfsmHbs6JXfo5QT3zEqHKAmP61FIteS1Ky18Yv4INpdFi/2h/DHYnoqagQ==
X-Received: by 2002:a17:903:11d1:b0:1fb:e31:b4e9 with SMTP id d9443c01a7336-1fbb6ed5761mr61219275ad.53.1720625338787;
        Wed, 10 Jul 2024 08:28:58 -0700 (PDT)
Received: from [192.168.0.128] ([98.97.103.43])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fbb6a1174asm35093825ad.1.2024.07.10.08.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 08:28:58 -0700 (PDT)
Message-ID: <96b04ebb7f46d73482d5f71213bd800c8195f00d.camel@gmail.com>
Subject: Re: [PATCH net-next v9 06/13] mm: page_frag: reuse existing space
 for 'size' and 'pfmemalloc'
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org,  pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton
	 <akpm@linux-foundation.org>, linux-mm@kvack.org
Date: Wed, 10 Jul 2024 08:28:57 -0700
In-Reply-To: <f4ff5a42-9371-bc54-8523-b11d8511c39a@huawei.com>
References: <20240625135216.47007-1-linyunsheng@huawei.com>
	 <20240625135216.47007-7-linyunsheng@huawei.com>
	 <12a8b9ddbcb2da8431f77c5ec952ccfb2a77b7ec.camel@gmail.com>
	 <808be796-6333-c116-6ecb-95a39f7ad76e@huawei.com>
	 <a026c32218cabc7b6dc579ced1306aefd7029b10.camel@gmail.com>
	 <f4ff5a42-9371-bc54-8523-b11d8511c39a@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-07-03 at 20:33 +0800, Yunsheng Lin wrote:
> On 2024/7/2 22:55, Alexander H Duyck wrote:
>=20
> ...
>=20
> >=20
> > > >=20
> > > > > +#define PAGE_FRAG_CACHE_ORDER_MASK		GENMASK(7, 0)
> > > > > +#define PAGE_FRAG_CACHE_PFMEMALLOC_BIT		BIT(8)
> > > > > +#define PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT	8
> > > > > +
> > > > > +static inline struct encoded_va *encode_aligned_va(void *va,
> > > > > +						   unsigned int order,
> > > > > +						   bool pfmemalloc)
> > > > > +{
> > > > >  #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> > > > > -	__u16 offset;
> > > > > -	__u16 size;
> > > > > +	return (struct encoded_va *)((unsigned long)va | order |
> > > > > +			pfmemalloc << PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT);
> > > > >  #else
> > > > > -	__u32 offset;
> > > > > +	return (struct encoded_va *)((unsigned long)va |
> > > > > +			pfmemalloc << PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT);
> > > > > +#endif
> > > > > +}
> > > > > +
> >=20
> > This is missing any and all protection of the example you cited. If I
> > want to pass order as a 32b value I can and I can corrupt the virtual
> > address. Same thing with pfmemalloc. Lets only hope you don't hit an
> > architecture where a bool is a u8 in size as otherwise that shift is
> > going to wipe out the value, and if it is a u32 which is usually the
> > case lets hope they stick to the values of 0 and 1.
>=20
> I explicitly checked that the protection is not really needed due to
> performance consideration:
> 1. For the 'pfmemalloc' part, it does always stick to the values of 0
>    and 1 as below:
> https://elixir.bootlin.com/linux/v6.10-rc6/source/Documentation/process/c=
oding-style.rst#L1053
>=20
> 2. For the 'order' part, its range can only be within 0~3.
>=20
> >=20
> > > > > +static inline unsigned long encoded_page_order(struct encoded_va=
 *encoded_va)
> > > > > +{
> > > > > +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> > > > > +	return PAGE_FRAG_CACHE_ORDER_MASK & (unsigned long)encoded_va;
> > > > > +#else
> > > > > +	return 0;
> > > > > +#endif
> > > > > +}
> > > > > +
> > > > > +static inline bool encoded_page_pfmemalloc(struct encoded_va *en=
coded_va)
> > > > > +{
> > > > > +	return PAGE_FRAG_CACHE_PFMEMALLOC_BIT & (unsigned long)encoded_=
va;
> > > > > +}
> > > > > +
> > > >=20
> > > > My advice is that if you just make encoded_va an unsigned long this
> > > > just becomes some FIELD_GET and bit operations.
> > >=20
> > > As above.
> > >=20
> >=20
> > The code you mentioned had one extra block of bits that was in it and
> > had strict protections on what went into and out of those bits. You
> > don't have any of those protections.
>=20
> As above, the protection masking/checking is explicitly avoided due
> to performance consideration and reasons as above for encoded_va.
>=20
> But I guess it doesn't hurt to have a VM_BUG_ON() checking to catch
> possible future mistake.
>=20
> >=20
> > I suggest you just use a long and don't bother storing this as a
> > pointer.
> >=20
>=20
> ...
>=20
> > > > > -
> > > > > +	remaining =3D nc->remaining & align_mask;
> > > > > +	remaining -=3D fragsz;
> > > > > +	if (unlikely(remaining < 0)) {
> > > >=20
> > > > Now this is just getting confusing. You essentially just added an
> > > > additional addition step and went back to the countdown approach I =
was
> > > > using before except for the fact that you are starting at 0 whereas=
 I
> > > > was actually moving down through the page.
> > >=20
> > > Does the 'additional addition step' mean the additional step to calcu=
late
> > > the offset using the new 'remaining' field? I guess that is the disad=
vantage
> > > by changing 'offset' to 'remaining', but it also some advantages too:
> > >=20
> > > 1. it is better to replace 'offset' with 'remaining', which
> > >    is the remaining size for the cache in a 'page_frag_cache'
> > >    instance, we are able to do a single 'fragsz > remaining'
> > >    checking for the case of cache not being enough, which should be
> > >    the fast path if we ensure size is zoro when 'va' =3D=3D NULL by
> > >    memset'ing 'struct page_frag_cache' in page_frag_cache_init()
> > >    and page_frag_cache_drain().
> > > 2. It seems more convenient to implement the commit/probe API too
> > >    when using 'remaining' instead of 'offset' as those API needs
> > >    the remaining size of the page_frag_cache anyway.
> > >=20
> > > So it is really a trade-off between using 'offset' and 'remaining',
> > > it is like the similar argument about trade-off between allocating
> > > fragment 'countdown' and 'countup' way.
> > >=20
> > > About confusing part, as the nc->remaining does mean how much cache
> > > is left in the 'nc', and nc->remaining does start from
> > > PAGE_FRAG_CACHE_MAX_SIZE/PAGE_SIZE to zero naturally if that was what
> > > you meant by 'countdown', but it is different from the 'offset countd=
own'
> > > before this patchset as my understanding.
> > >=20
> > > >=20
> > > > What I would suggest doing since "remaining" is a negative offset
> > > > anyway would be to look at just storing it as a signed negative num=
ber.
> > > > At least with that you can keep to your original approach and would
> > > > only have to change your check to be for "remaining + fragsz <=3D 0=
".
> > >=20
> > > Did you mean by using s16/s32 for 'remaining'? And set nc->remaining =
like
> > > below?
> > > nc->remaining =3D -PAGE_SIZE or
> > > nc->remaining =3D -PAGE_FRAG_CACHE_MAX_SIZE
> >=20
> > Yes. Basically if we used it as a signed value then you could just work
> > your way up and do your aligned math still.
>=20
> For the aligned math, I am not sure how can 'align_mask' be appiled to
> a signed value yet. It seems that after masking nc->remaining leans
> towards -PAGE_SIZE/-PAGE_FRAG_CACHE_MAX_SIZE instead of zero for
> a unsigned value, for example:
>=20
> nc->remaining =3D -4094;
> nc->remaining &=3D -64;
>=20
> It seems we got -4096 for above, is that what we are expecting?

No, you have to do an addition and then the mask like you were before
using __ALIGN_KERNEL.

As it stands I realized your alignment approach in this patch is
broken. You should be aligning the remaining at the start of this
function and then storing it before you call
page_frag_cache_current_va. Instead you do it after so the start of
your block may not be aligned to the requested mask if you have
multiple callers sharing this function or if you are passing an
unaligned size in the request.

> >=20
> > > struct page_frag_cache {
> > >         struct encoded_va *encoded_va;
> > >=20
> > > #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <=3D 32)
> > >         u16 pagecnt_bias;
> > >         s16 remaining;
> > > #else
> > >         u32 pagecnt_bias;
> > >         s32 remaining;
> > > #endif
> > > };
> > >=20
> > > If I understand above correctly, it seems we really need a better nam=
e
> > > than 'remaining' to reflect that.
> >=20
> > It would effectively work like a countdown. Instead of T - X in this
> > case it is size - X.
> >=20
> > > > With that you can still do your math but it becomes an addition ins=
tead
> > > > of a subtraction.
> > >=20
> > > And I am not really sure what is the gain here by using an addition
> > > instead of a subtraction here.
> > >=20
> >=20
> > The "remaining" as it currently stands is doing the same thing so odds
> > are it isn't too big a deal. It is just that the original code was
> > already somewhat confusing and this is just making it that much more
> > complex.
> >=20
> > > > > +		page =3D virt_to_page(encoded_va);
> > > > >  		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
> > > > >  			goto refill;
> > > > > =20
> > > > > -		if (unlikely(nc->pfmemalloc)) {
> > > > > -			free_unref_page(page, compound_order(page));
> > > > > +		if (unlikely(encoded_page_pfmemalloc(encoded_va))) {
> > > > > +			VM_BUG_ON(compound_order(page) !=3D
> > > > > +				  encoded_page_order(encoded_va));
> > > > > +			free_unref_page(page, encoded_page_order(encoded_va));
> > > > >  			goto refill;
> > > > >  		}
> > > > > =20
> > > > >  		/* OK, page count is 0, we can safely set it */
> > > > >  		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
> > > > > =20
> > > > > -		/* reset page count bias and offset to start of new frag */
> > > > > +		/* reset page count bias and remaining of new frag */
> > > > >  		nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
> > > > > -		offset =3D 0;
> > > > > -		if (unlikely(fragsz > PAGE_SIZE)) {
> > > > > +		nc->remaining =3D remaining =3D page_frag_cache_page_size(enco=
ded_va);
> > > > > +		remaining -=3D fragsz;
> > > > > +		if (unlikely(remaining < 0)) {
> > > > >  			/*
> > > > >  			 * The caller is trying to allocate a fragment
> > > > >  			 * with fragsz > PAGE_SIZE but the cache isn't big
> > > >=20
> > > > I find it really amusing that you went to all the trouble of flippi=
ng
> > > > the logic just to flip it back to being a countdown setup. If you w=
ere
> > > > going to bother with all that then why not just make the remaining
> > > > negative instead? You could save yourself a ton of trouble that way=
 and
> > > > all you would need to do is flip a few signs.
> > >=20
> > > I am not sure I understand the 'a ton of trouble' part here, if 'flip=
ping
> > > a few signs' does save a ton of trouble here, I would like to avoid '=
a
> > > ton of trouble' here, but I am not really understand the gain here ye=
t as
> > > mentioned above.
> >=20
> > It isn't about flipping the signs. It is more the fact that the logic
> > has now become even more complex then it originally was. With my work
> > backwards approach the advantage was that the offset could be updated
> > and then we just recorded everything and reported it up. Now we have to
>=20
> I am supposing the above is referring to 'offset countdown' way
> before this patchset, right?
>=20
> > keep a temporary "remaining" value, generate our virtual address and
> > store that to a temp variable, we can record the new "remaining" value,
> > and then we can report the virtual address. If we get the ordering on
>=20
> Yes, I noticed it when coding too, that is why current virtual address is
> generated in page_frag_cache_current_va() basing on nc->remaining instead
> of the local variable 'remaining' before assigning the local variable
> 'remaining' to nc->remaining. But I am not sure I understand how using a
> signed negative number for 'remaining' will change the above steps. If
> not, I still fail to see the gain of using a signed negative number for
> 'nc->remaining'.
>=20
> > the steps 2 and 3 in this it will cause issues as we will be pointing
> > to the wrong values. It is something I can see someone easily messing
> > up.
>=20
> Yes, agreed. It would be good to be more specific about how to avoid
> the above problem using a signed negative number for 'remaining' as
> I am not sure how it can be done yet.
>=20

My advice would be to go back to patch 3 and figure out how to do this
re-ordering without changing the alignment behaviour. The old code
essentially aligned both the offset and fragsz by combining the two and
then doing the alignment. Since you are doing a count up setup you will
need to align the remaining, then add fragsz, and then I guess you
could store remaining and then subtract fragsz from your final virtual
address to get back to where the starting offset is actually located.

Basically your "remaining" value isn't a safe number to use for an
offset since it isn't aligned to your starting value at any point.

As far as the negative value, it is more about making it easier to keep
track of what is actually going on. Basically we can use regular
pointer math and as such I suspect the compiler is having to do extra
instructions to flip your value negative before it can combine the
values via something like the LEA (load effective address) assembler
call.


Return-Path: <netdev+bounces-224217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B73B825EF
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 02:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB971C21048
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 00:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07751A23AC;
	Thu, 18 Sep 2025 00:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oazycJrL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D211922FD
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 00:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758155346; cv=none; b=Vwpv8YC5qgFKt4GiAVUePYbIn2/kCGLFYElRCdFzMhIVf4PRD6xaisja9yXuPtAKFN70MS00LJyBLF8gbVmcYNRLz/sCQpGj8B8aQu0/jlUkPeXEbCny2Z0Wwu/L0S+PKNlI3lmW77gMLIIrBLk48OzGv/DiBfAysQTTHdl4MxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758155346; c=relaxed/simple;
	bh=iKVleLXPMdTEUOCAdPUfZCXVuL2WYzcult73kEnoxlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a4cZtkqNwDCUu9XwqytQPulYsoc5fYhrqipvpHH4x83cfEVbLxb46bWq46FL5FRC8ClALHHjWbvXU4IlIR675j5abqoFVtcPNPyu6qVGmnKk5797bU/4gdir4IyGuYFO/GdwHEN7klrgafhNGz7coMWfWEvZ9VNV4VOBIPNsbp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oazycJrL; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-560885b40e2so4436e87.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 17:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758155343; x=1758760143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otTjDvMKcuz7B7FSDzuZ9ONktzk3szEQfjJL8I6CUh4=;
        b=oazycJrLdu7PleYCqBHgRrl2FEBJDQSaRuGEVusN0ifIvtpj9p4draGM+tOo5p93p1
         gEEJolDSGsAlyAVS3tP7qgKpgecPRgfUqfFnJfT+NzlWPaphslu1ejHmq+shhQopo3N5
         v6mpotg55exuAVWr7YliLXQdpPmmfKdA0tvZmJPt2GVHA/Kiv7WGvKyzzxG01+MchUlN
         gSe5CZdYDp8Zo0Xn8dfoKH65u4nfkzR1/FIa4PdmEkuBp5qALhOdwaSApKmIxRqxsAip
         zjPtJ2aNTuMWi0kSox6PBVOTHOqUciAkDTlELWBqXhXWeCcDBb+TDIv33jRLR7LYTAaj
         BnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758155343; x=1758760143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=otTjDvMKcuz7B7FSDzuZ9ONktzk3szEQfjJL8I6CUh4=;
        b=mAAMLDTuW3+SMRAmM4fafszBbLkYFEmp3trORe9fCeIyE9cCCOOcY1cgwltD7BAnqh
         U++0un9E4GHINJoaG8+5hIzKtdP4RuaITvHz+zivrSzNfLi+SJG4oqm6Iw/15gYMdikV
         E2Q3dFwOGrRg/98VYO6PxZAAtTDTLNrRVcWrGMciC33G0j88de0O8610PHIMvdwq3vOW
         gRC7zoIbTVSlQBS6I5ORoQRy9/5/emYmYdZNcOp1C9rK5sag2oPbZCIhyCP6twKCAnMf
         cwpKq3i7z5bcBeA5TeCAU3uvT9TNdIz4AEWLvHroh15pvO6wlBMkn7oeYuhnO0BgpfNI
         OiCg==
X-Forwarded-Encrypted: i=1; AJvYcCWNZengYIg4ey5IoEVTSy8auJutInZRNWodspDcLe/rNbaQVxZoeVCrs4ika265Rso1tJ+LEUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9QtchRSiyLhgRrMZlbN6SkD1gQnaBO69eAwPZ4F3zIPVIJlnX
	1YednNe9ysLBbw73Elrirwu4tSnhmjn8EHbzWJdJ1QYckiHJ0zqwxl6LGATuzZJS7kyV3CxktY3
	WGS9xtlGceNEjRXWwVfgc+3N0D4JnZKNylcpscxHe
X-Gm-Gg: ASbGncut+5BYaHdultUvt1nwWu067ZxIYIRaSaUI7AYop0O5LOOBCjiM0sBjkkql/rr
	uFLxI4h//ha06eYusriYZzgju0d4Q0h2HSISboiMdYph4AhMNvx+EC2ZJ/JSRNRPI3kMOac9Xzc
	wMgLkkz4N6Qgfv7D0hy36NdQ9odTbWDRAREd9F7lsuI7for4bA9cfca3z3V075GtqR8FYxuVQKO
	mRXy90BO20b8KnZ7zYZMmQMPdhowHKlcMM9meGPuL0nxRDahZTU5EywSKZ1uNk=
X-Google-Smtp-Source: AGHT+IHBOQjrzCEaZsycseI/wvvGjPucCWK4u9AySoDeQE47ePlR8NeAKnDsZf2mX/C9kzOariJXaqbjhJoYXdHQF1g=
X-Received: by 2002:a05:6512:2086:b0:55f:6aa7:c20 with SMTP id
 2adb3069b0e04-577502fde9dmr430214e87.2.1758155342586; Wed, 17 Sep 2025
 17:29:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aMSni79s6vCCVCFO@p100> <87zfawvt2f.fsf@toke.dk>
 <f64372ec-c127-457f-b8e2-0f48223bd147@gmx.de> <CAHS8izMjKub2cPa9Qqiga96XQ7piq3h0Vb_p+9RzNbBXXeGQrw@mail.gmail.com>
 <87y0qerbld.fsf@toke.dk> <CAHS8izOY3aSe96aUQBV76ZRpqj5mXwkPenNvmN6yN0cJmceLUA@mail.gmail.com>
 <87tt11qtl8.fsf@toke.dk>
In-Reply-To: <87tt11qtl8.fsf@toke.dk>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 17 Sep 2025 17:28:49 -0700
X-Gm-Features: AS18NWDUfv05rf0NZaG4uxGpfp0qugFcIQfECemqL0cSXbjzvnAAJACWkN9nrA8
Message-ID: <CAHS8izNMHYuRk9w0BUEbXBob38NVkMOVMmvvcq30TstGFpob6A@mail.gmail.com>
Subject: Re: [PATCH][RESEND][RFC] Fix 32-bit boot failure due inaccurate page_pool_page_is_pp()
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Helge Deller <deller@gmx.de>, Helge Deller <deller@kernel.org>, 
	David Hildenbrand <david@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S. Miller" <davem@davemloft.net>, 
	Linux Memory Management List <linux-mm@kvack.org>, netdev@vger.kernel.org, 
	Linux parisc List <linux-parisc@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 3:09=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> Mina Almasry <almasrymina@google.com> writes:
>
> > On Tue, Sep 16, 2025 at 2:27=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgense=
n <toke@redhat.com> wrote:
> >>
> >> Mina Almasry <almasrymina@google.com> writes:
> >>
> >> > On Mon, Sep 15, 2025 at 6:08=E2=80=AFAM Helge Deller <deller@gmx.de>=
 wrote:
> >> >>
> >> >> On 9/15/25 13:44, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >> >> > Helge Deller <deller@kernel.org> writes:
> >> >> >
> >> >> >> Commit ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unma=
p them when
> >> >> >> destroying the pool") changed PP_MAGIC_MASK from 0xFFFFFFFC to 0=
xc000007c on
> >> >> >> 32-bit platforms.
> >> >> >>
> >> >> >> The function page_pool_page_is_pp() uses PP_MAGIC_MASK to identi=
fy page pool
> >> >> >> pages, but the remaining bits are not sufficient to unambiguousl=
y identify
> >> >> >> such pages any longer.
> >> >> >
> >> >> > Why not? What values end up in pp_magic that are mistaken for the
> >> >> > pp_signature?
> >> >>
> >> >> As I wrote, PP_MAGIC_MASK changed from 0xFFFFFFFC to 0xc000007c.
> >> >> And we have PP_SIGNATURE =3D=3D 0x40  (since POISON_POINTER_DELTA i=
s zero on 32-bit platforms).
> >> >> That means, that before page_pool_page_is_pp() could clearly identi=
fy such pages,
> >> >> as the (value & 0xFFFFFFFC) =3D=3D 0x40.
> >> >> So, basically only the 0x40 value indicated a PP page.
> >> >>
> >> >> Now with the mask a whole bunch of pointers suddenly qualify as bei=
ng a pp page,
> >> >> just showing a few examples:
> >> >> 0x01111040
> >> >> 0x082330C0
> >> >> 0x03264040
> >> >> 0x0ad686c0 ....
> >> >>
> >> >> For me it crashes immediately at bootup when memblocked pages are h=
anded
> >> >> over to become normal pages.
> >> >>
> >> >
> >> > I tried to take a look to double check here and AFAICT Helge is corr=
ect.
> >> >
> >> > Before the breaking patch with PP_MAGIC_MASK=3D=3D0xFFFFFFFC, basica=
lly
> >> > 0x40 is the only pointer that may be mistaken as a valid pp_magic.
> >> > AFAICT each bit we 0 in the PP_MAGIC_MASK (aside from the 3 least
> >> > significant bits), doubles the number of pointers that can be mistak=
en
> >> > for pp_magic. So with 0xFFFFFFFC, only one value (0x40) can be
> >> > mistaken as a valid pp_magic, with  0xc000007c AFAICT 2^22 values ca=
n
> >> > be mistaken as pp_magic?
> >> >
> >> > I don't know that there is any bits we can take away from
> >> > PP_MAGIC_MASK I think? As each bit doubles the probablity :(
> >> >
> >> > I would usually say we can check the 3 least significant bits to tel=
l
> >> > if pp_magic is a pointer or not, but pp_magic is unioned with
> >> > page->lru I believe which will use those bits.
> >>
> >> So if the pointers stored in the same field can be any arbitrary value=
,
> >> you are quite right, there is no safe value. The critical assumption i=
n
> >> the bit stuffing scheme is that the pointers stored in the field will
> >> always be above PAGE_OFFSET, and that PAGE_OFFSET has one (or both) of
> >> the two top-most bits set (that is what the VMSPLIT reference in the
> >> comment above the PP_DMA_INDEX_SHIFT definition is alluding to).
> >>
> >
> > I see... but where does the 'PAGE_OFFSET has one (or both) of the two
> > top-most bits set)' assumption come from? Is it from this code?
>
> Well, from me grepping through the code and trying to make sense of all
> the different cases of the preprocessor and config directives across
> architectures. Seems I did not quite succeed :/
>
> > /*
> >  * PAGE_OFFSET -- the first address of the first page of memory.
> >  * When not using MMU this corresponds to the first free page in
> >  * physical memory (aligned on a page boundary).
> >  */
> > #ifdef CONFIG_MMU
> > #ifdef CONFIG_64BIT
> > ....
> > #else
> > #define PAGE_OFFSET _AC(0xc0000000, UL)
> > #endif /* CONFIG_64BIT */
> > #else
> > #define PAGE_OFFSET ((unsigned long)phys_ram_base)
> > #endif /* CONFIG_MMU */
> >
> > It looks like with !CONFIG_MMU we use phys_ram_base and I'm unable to
> > confirm that all the values of this have the first 2 bits set. I
> > wonder if his setup is !CONFIG_MMU indeed.
>
> Right, that's certainly one thing I missed. As was the parisc arch
> thing, as Helge followed up with. Ugh :/
>
> > It also looks like pp_magic is also union'd with __folio_index in
> > struct page, and it looks like the data there is sometimes used as a
> > pointer and sometimes not.
>
> Not according to my pahole:
>
> [...]
>                         union {
>                                 long unsigned int __folio_index; /*    32=
     8 */
> [...]
>         struct {
>                         long unsigned int pp_magic;      /*     8     8 *=
/
>
> So I think we're good with this, no?
>
> So given the above, we could do something equivalent to this, I think?
>
> diff --git i/include/linux/mm.h w/include/linux/mm.h
> index 1ae97a0b8ec7..615aaa19c60c 100644
> --- i/include/linux/mm.h
> +++ w/include/linux/mm.h
> @@ -4175,8 +4175,12 @@ int arch_lock_shadow_stack_status(struct task_stru=
ct *t, unsigned long status);
>   */
>  #define PP_DMA_INDEX_BITS MIN(32, __ffs(POISON_POINTER_DELTA) - PP_DMA_I=
NDEX_SHIFT)
>  #else
> +#if PAGE_OFFSET > PP_SIGNATURE
>  /* Always leave out the topmost two; see above. */
> -#define PP_DMA_INDEX_BITS MIN(32, BITS_PER_LONG - PP_DMA_INDEX_SHIFT - 2=
)
> +#define PP_DMA_INDEX_BITS MIN(32, __fls(PAGE_OFFSET) - PP_DMA_INDEX_SHIF=
T - 1)

Shouldn't have this been:

#define PP_DMA_INDEX_BITS MIN(32, __ffs(PAGE_OFFSET) - PP_DMA_INDEX_SHIFT)

I.e. you're trying to use the space between the least significant bit
set in PAGE_OFFSET and the most significant bit set in PP_SIGNATURE.
Hmm. I'm not sure I understand this, I may be reading wrong.

> +#else
> +#define PP_DMA_INDEX_BITS 0
> +#endif /* PAGE_OFFSET > PP_SIGNATURE */
>  #endif
>
>  #define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS +  PP_DMA_INDEX_SHIF=
T - 1, \
>
>
> Except that it won't work in this form as-is because PAGE_OFFSET is not
> always a constant (see the #define PAGE_OFFSET ((unsigned
> long)phys_ram_base) that your quoted above), so we'll have to turn it
> into an inline function or something.
>
> I'm not sure adding this extra complexity is really worth it, or if we
> should just go with the '#define PP_DMA_INDEX_BITS 0' when
> POISON_POINTER_DELTA is unset and leave it at that for the temporary
> workaround. WDYT?
>

I think this would work. It still wouldn't handle cases where the data
in pp_magic ends up used as a non-pointer at all or a pointer to some
static variable in the code like `.mp_ops =3D &dmabuf_devmem_ops,`
right? Because these were never allocated from memory so are unrelated
to PAGE_OFFSET.

But I guess things like that would have been a problem with the old
code anwyway, so should be of no concern?

--=20
Thanks,
Mina


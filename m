Return-Path: <netdev+bounces-225306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B51B920C7
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 17:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B689178C15
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 15:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2608330BB8F;
	Mon, 22 Sep 2025 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJeOGrLG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C29430B50C
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758556182; cv=none; b=IzEDZjCSCq8K4hStJehDwwCiUgzGlNCGUqfwSCTEfJ2tvuOQv7kjjB9Ig9V6FyL2nGhr0Ti/MUDyZPkxfgl9TD5uXSrIA2H1RLIMx+eYqTneI50eVsXpCqwPY6/0kmFUKUYC7pr86Dil3bH2p88HNO70LPqFSXinyZKizXWbiP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758556182; c=relaxed/simple;
	bh=pnY7yIXTpkGY3uS9XymIrzISP7ZJeyapBkly5cHR7tQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YShYhXfl8Z5y5cygHyp0EbcOZTVf7yCttnNSg+1tBHaXu6pkivvbNsumvwBaPRi1BeCXY6kUiOLAOUzCAClPddT7/dmURO26mxr0rErGUsQXi9W0HJ/I2AXBP0VdBrJLxeH9RPOCLIXIBILj/lGMbnHtHANCAMpvZDc4cfqhxPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jJeOGrLG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758556179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WywYXktQLEVHQCnoOhp4jbR+ceLDEmxLbtgIxFgQwIk=;
	b=jJeOGrLGKGKcnD6NReFX8XT9IRgiiw3U7aVl/PkHgjVkzgete3ALIPnee4gtLEz+xbBN1l
	qIVRKW7505kIXkixedlnN1eDPEJPpWXA84yP8n5MFMnrx9OhFNGn1+pNuvPfrOzxlPgKak
	IM01wcnsMy8SRy1zilLR0HXTjJBtwpw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-S5X9gEmGOI25sFXuyyn9lw-1; Mon, 22 Sep 2025 11:49:36 -0400
X-MC-Unique: S5X9gEmGOI25sFXuyyn9lw-1
X-Mimecast-MFC-AGG-ID: S5X9gEmGOI25sFXuyyn9lw_1758556174
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-aff0df4c4abso348923866b.1
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 08:49:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758556174; x=1759160974;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WywYXktQLEVHQCnoOhp4jbR+ceLDEmxLbtgIxFgQwIk=;
        b=j2FVStW6nLbD5iK/ZTbYFcD78agp8+HUdrvIN2TfbzH145jeG71GJo5EKwlTbLaFEH
         K91qD6KR+U+8PCtUwnkfktqadK51P7RcuPU+y6tI3JOHCeQ2V3fcLZpQ6+GsT2BZwvlQ
         YsAFyjHz6V9+7ljXMuX+avwExPpWvaF0byfc/GvIJ6UTA0+VarysPGK94/V35hYKWfRk
         MupL6lFR83ciyVnJUFRZT+3Y2wQT0T8wyjJC7cDojHpHj+Lx8wKvQntQfOsE2scH9B79
         xQAbki0NBE+MXTWEegipEJIC9c+zMAsx8r/dqRQjpjVDKUGyU0yR3HaPBILy2uwsyN9N
         I1MA==
X-Forwarded-Encrypted: i=1; AJvYcCVE794NgszFVKddIpaAd/d41Oo+ZM3JluSFBGLRpz3vfuOrYVYoApmunzxQ0c73UoyP9lWArRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKt7oYT4SQm8G+50hqELjM/UF/m7Zf9ugrsxrMn6m+PqJTSXkh
	NRxhjxNfgfmsxmYOvtO0ZdBSEdu9ZzC1QEz9vwG+QZX1gEevgauJGthzqMOER2G3RmJoNwZcQ8I
	cfsKb3L4CPJNTUYMAEe8LigEXc8+mXsC+VlGgOcNISbs9Y4BdGVJOzMydzA==
X-Gm-Gg: ASbGncv4zG5zGMxRW6PhcPpNGMcriTpzfJUPu1YlKmhNVDAnXhYe2W0mHbe1X8tn28Q
	P10D/7HKC0Qsz+VAAVqwAMzuDV5H7w9yvhogV9go+pQaTnovTh3T1aTFXidCNmck0GC1fOPL/lq
	hzEy61lQKIGGu1jdLmQPgFRwVakgqVcr7bxY3+hioUndPqcOfzBKN0JCuTsCdO91lDkf/5b+qWt
	hd1jpZK0Q/OXNsNl43ESqzW16Tk9hcZPK/pATpscGYcrepRarM9H1k4zksYRPbleFtAyJJ66MIQ
	AXbYSAhtKfbG2Bxfhghkvla4QXDlp3HxnnLYsqbr8fTXeqES8q1ECaAldg1p4uezFHk=
X-Received: by 2002:a17:907:1df2:b0:b2d:b5d3:9623 with SMTP id a640c23a62f3a-b2db5d398c8mr186933766b.54.1758556174286;
        Mon, 22 Sep 2025 08:49:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9PXzNI7iuT6NoL+4FC5uVdHnMWrw8Q4gLh9w8pt9x5WwEnqsqHm/CAfVJFEadke+VixQp6w==
X-Received: by 2002:a17:907:1df2:b0:b2d:b5d3:9623 with SMTP id a640c23a62f3a-b2db5d398c8mr186931566b.54.1758556173806;
        Mon, 22 Sep 2025 08:49:33 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b288062c045sm590259966b.45.2025.09.22.08.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 08:49:33 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id AA3F1276A38; Mon, 22 Sep 2025 17:49:31 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Helge Deller <deller@gmx.de>, Helge Deller <deller@kernel.org>, David
 Hildenbrand <david@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S. Miller"
 <davem@davemloft.net>, Linux Memory Management List <linux-mm@kvack.org>,
 netdev@vger.kernel.org, Linux parisc List <linux-parisc@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH][RESEND][RFC] Fix 32-bit boot failure due inaccurate
 page_pool_page_is_pp()
In-Reply-To: <CAHS8izNMHYuRk9w0BUEbXBob38NVkMOVMmvvcq30TstGFpob6A@mail.gmail.com>
References: <aMSni79s6vCCVCFO@p100> <87zfawvt2f.fsf@toke.dk>
 <f64372ec-c127-457f-b8e2-0f48223bd147@gmx.de>
 <CAHS8izMjKub2cPa9Qqiga96XQ7piq3h0Vb_p+9RzNbBXXeGQrw@mail.gmail.com>
 <87y0qerbld.fsf@toke.dk>
 <CAHS8izOY3aSe96aUQBV76ZRpqj5mXwkPenNvmN6yN0cJmceLUA@mail.gmail.com>
 <87tt11qtl8.fsf@toke.dk>
 <CAHS8izNMHYuRk9w0BUEbXBob38NVkMOVMmvvcq30TstGFpob6A@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 22 Sep 2025 17:49:31 +0200
Message-ID: <87cy7iv65w.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mina Almasry <almasrymina@google.com> writes:

> On Wed, Sep 17, 2025 at 3:09=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@redhat.com> wrote:
>>
>> Mina Almasry <almasrymina@google.com> writes:
>>
>> > On Tue, Sep 16, 2025 at 2:27=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgens=
en <toke@redhat.com> wrote:
>> >>
>> >> Mina Almasry <almasrymina@google.com> writes:
>> >>
>> >> > On Mon, Sep 15, 2025 at 6:08=E2=80=AFAM Helge Deller <deller@gmx.de=
> wrote:
>> >> >>
>> >> >> On 9/15/25 13:44, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> >> >> > Helge Deller <deller@kernel.org> writes:
>> >> >> >
>> >> >> >> Commit ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unm=
ap them when
>> >> >> >> destroying the pool") changed PP_MAGIC_MASK from 0xFFFFFFFC to =
0xc000007c on
>> >> >> >> 32-bit platforms.
>> >> >> >>
>> >> >> >> The function page_pool_page_is_pp() uses PP_MAGIC_MASK to ident=
ify page pool
>> >> >> >> pages, but the remaining bits are not sufficient to unambiguous=
ly identify
>> >> >> >> such pages any longer.
>> >> >> >
>> >> >> > Why not? What values end up in pp_magic that are mistaken for the
>> >> >> > pp_signature?
>> >> >>
>> >> >> As I wrote, PP_MAGIC_MASK changed from 0xFFFFFFFC to 0xc000007c.
>> >> >> And we have PP_SIGNATURE =3D=3D 0x40  (since POISON_POINTER_DELTA =
is zero on 32-bit platforms).
>> >> >> That means, that before page_pool_page_is_pp() could clearly ident=
ify such pages,
>> >> >> as the (value & 0xFFFFFFFC) =3D=3D 0x40.
>> >> >> So, basically only the 0x40 value indicated a PP page.
>> >> >>
>> >> >> Now with the mask a whole bunch of pointers suddenly qualify as be=
ing a pp page,
>> >> >> just showing a few examples:
>> >> >> 0x01111040
>> >> >> 0x082330C0
>> >> >> 0x03264040
>> >> >> 0x0ad686c0 ....
>> >> >>
>> >> >> For me it crashes immediately at bootup when memblocked pages are =
handed
>> >> >> over to become normal pages.
>> >> >>
>> >> >
>> >> > I tried to take a look to double check here and AFAICT Helge is cor=
rect.
>> >> >
>> >> > Before the breaking patch with PP_MAGIC_MASK=3D=3D0xFFFFFFFC, basic=
ally
>> >> > 0x40 is the only pointer that may be mistaken as a valid pp_magic.
>> >> > AFAICT each bit we 0 in the PP_MAGIC_MASK (aside from the 3 least
>> >> > significant bits), doubles the number of pointers that can be mista=
ken
>> >> > for pp_magic. So with 0xFFFFFFFC, only one value (0x40) can be
>> >> > mistaken as a valid pp_magic, with  0xc000007c AFAICT 2^22 values c=
an
>> >> > be mistaken as pp_magic?
>> >> >
>> >> > I don't know that there is any bits we can take away from
>> >> > PP_MAGIC_MASK I think? As each bit doubles the probablity :(
>> >> >
>> >> > I would usually say we can check the 3 least significant bits to te=
ll
>> >> > if pp_magic is a pointer or not, but pp_magic is unioned with
>> >> > page->lru I believe which will use those bits.
>> >>
>> >> So if the pointers stored in the same field can be any arbitrary valu=
e,
>> >> you are quite right, there is no safe value. The critical assumption =
in
>> >> the bit stuffing scheme is that the pointers stored in the field will
>> >> always be above PAGE_OFFSET, and that PAGE_OFFSET has one (or both) of
>> >> the two top-most bits set (that is what the VMSPLIT reference in the
>> >> comment above the PP_DMA_INDEX_SHIFT definition is alluding to).
>> >>
>> >
>> > I see... but where does the 'PAGE_OFFSET has one (or both) of the two
>> > top-most bits set)' assumption come from? Is it from this code?
>>
>> Well, from me grepping through the code and trying to make sense of all
>> the different cases of the preprocessor and config directives across
>> architectures. Seems I did not quite succeed :/
>>
>> > /*
>> >  * PAGE_OFFSET -- the first address of the first page of memory.
>> >  * When not using MMU this corresponds to the first free page in
>> >  * physical memory (aligned on a page boundary).
>> >  */
>> > #ifdef CONFIG_MMU
>> > #ifdef CONFIG_64BIT
>> > ....
>> > #else
>> > #define PAGE_OFFSET _AC(0xc0000000, UL)
>> > #endif /* CONFIG_64BIT */
>> > #else
>> > #define PAGE_OFFSET ((unsigned long)phys_ram_base)
>> > #endif /* CONFIG_MMU */
>> >
>> > It looks like with !CONFIG_MMU we use phys_ram_base and I'm unable to
>> > confirm that all the values of this have the first 2 bits set. I
>> > wonder if his setup is !CONFIG_MMU indeed.
>>
>> Right, that's certainly one thing I missed. As was the parisc arch
>> thing, as Helge followed up with. Ugh :/
>>
>> > It also looks like pp_magic is also union'd with __folio_index in
>> > struct page, and it looks like the data there is sometimes used as a
>> > pointer and sometimes not.
>>
>> Not according to my pahole:
>>
>> [...]
>>                         union {
>>                                 long unsigned int __folio_index; /*    3=
2     8 */
>> [...]
>>         struct {
>>                         long unsigned int pp_magic;      /*     8     8 =
*/
>>
>> So I think we're good with this, no?
>>
>> So given the above, we could do something equivalent to this, I think?
>>
>> diff --git i/include/linux/mm.h w/include/linux/mm.h
>> index 1ae97a0b8ec7..615aaa19c60c 100644
>> --- i/include/linux/mm.h
>> +++ w/include/linux/mm.h
>> @@ -4175,8 +4175,12 @@ int arch_lock_shadow_stack_status(struct task_str=
uct *t, unsigned long status);
>>   */
>>  #define PP_DMA_INDEX_BITS MIN(32, __ffs(POISON_POINTER_DELTA) - PP_DMA_=
INDEX_SHIFT)
>>  #else
>> +#if PAGE_OFFSET > PP_SIGNATURE
>>  /* Always leave out the topmost two; see above. */
>> -#define PP_DMA_INDEX_BITS MIN(32, BITS_PER_LONG - PP_DMA_INDEX_SHIFT - =
2)
>> +#define PP_DMA_INDEX_BITS MIN(32, __fls(PAGE_OFFSET) - PP_DMA_INDEX_SHI=
FT - 1)
>
> Shouldn't have this been:
>
> #define PP_DMA_INDEX_BITS MIN(32, __ffs(PAGE_OFFSET) - PP_DMA_INDEX_SHIFT)
>
> I.e. you're trying to use the space between the least significant bit
> set in PAGE_OFFSET and the most significant bit set in PP_SIGNATURE.
> Hmm. I'm not sure I understand this, I may be reading wrong.

No, you're right, that was me getting things mixed up; but looks like
you got the gist of it so that's good :)

>> +#else
>> +#define PP_DMA_INDEX_BITS 0
>> +#endif /* PAGE_OFFSET > PP_SIGNATURE */
>>  #endif
>>
>>  #define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS +  PP_DMA_INDEX_SHI=
FT - 1, \
>>
>>
>> Except that it won't work in this form as-is because PAGE_OFFSET is not
>> always a constant (see the #define PAGE_OFFSET ((unsigned
>> long)phys_ram_base) that your quoted above), so we'll have to turn it
>> into an inline function or something.
>>
>> I'm not sure adding this extra complexity is really worth it, or if we
>> should just go with the '#define PP_DMA_INDEX_BITS 0' when
>> POISON_POINTER_DELTA is unset and leave it at that for the temporary
>> workaround. WDYT?
>>
>
> I think this would work. It still wouldn't handle cases where the data
> in pp_magic ends up used as a non-pointer at all or a pointer to some
> static variable in the code like `.mp_ops =3D &dmabuf_devmem_ops,`
> right? Because these were never allocated from memory so are unrelated
> to PAGE_OFFSET.
>
> But I guess things like that would have been a problem with the old
> code anwyway, so should be of no concern?

Yeah, this relies on the overlapping field only ever being used for
kernel-space pointers; which I believe is the case with page->lru (since
it's a list_head).

I'll see if I can find a way around the "PAGE_OFFSET may be a variable
reference" issue and post a proper patch, hopefully tomorrow.

-Toke



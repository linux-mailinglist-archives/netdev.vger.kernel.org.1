Return-Path: <netdev+bounces-223942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8B7B7DC70
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1FE81BC4FFD
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 10:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B6034A339;
	Wed, 17 Sep 2025 10:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BLKjY5hk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED562E8B7D
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 10:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103750; cv=none; b=BOeoiFYceOOdK0fJWFBNoji0ZPCu8nqAU+meDCCL3VuIncuYeWXTxNC/OgvOjbeIvg4BbJBCh7M7pmHHFz0Vj2Y6xfOL108wU0B8P8ujU3aaKkK5XgcRAdbDSWP418PLkpxKyjBewy6oFU/sL017mgMs3tB/3/R1eZ9zoP+2bb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103750; c=relaxed/simple;
	bh=szTTxEBPHPFyvC3fivaGHc5XHLQPzhURz0O81w1UKe4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Oz9zheJgnne+A0+uXlSWNKkf3AefNGPAfD9rCo4SeCUr6qvxWUn7jtWf8Qk8Mubqo8V6IQza8ANo2NmAn9yHYhR3/Sl89oUGLh/DctVxeT0vV8awZUGLmHUlG0n2zxtwA8RFcVPAfX2qQjyz9XlGrdDnQYdTjkEH8fYFcVdcY8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BLKjY5hk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758103747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MSOmPKgNbwtM2LXmxImTNwZCiqRgQA6WDM55Gtf8iCI=;
	b=BLKjY5hklCiuhKMhZUF62N7ilZtNF1mnfZoHvWPJhZU+u9xfa0Q4FAHsaYyBOBkob37YsM
	JmGwbq5kYiYyjGkO6Tj+xt1j9GNNIwqZs6h6K9GeOpEs86vYWmyF4QsQ8TTRk5bd2Pud3T
	FrrJzVlMXbDPUl3i6i4Ls9KQ0uAYxQQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-4IEuvprgOCmpeESwOmieMA-1; Wed, 17 Sep 2025 06:09:00 -0400
X-MC-Unique: 4IEuvprgOCmpeESwOmieMA-1
X-Mimecast-MFC-AGG-ID: 4IEuvprgOCmpeESwOmieMA_1758103739
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-62f5135a320so2488588a12.1
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 03:09:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758103739; x=1758708539;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSOmPKgNbwtM2LXmxImTNwZCiqRgQA6WDM55Gtf8iCI=;
        b=hERvhX85DzFAqIgdmTh59UQqXIjxOdfhtWbVj+sszByq7DgrF8lxKqyPslzp4x+5k5
         EVkVjIFRo9XKdnm708O4z+FaSak7LvQNCLPbm0Md4pP6OCgTSHUQkK1S3aEed6LHwpNI
         neX9b8GmqZPzMjuKaFOW2s/GJsw772AqMKDo/K954rLc0AVAml0XxEnC/AsZsCLMm7R8
         FQy9Oyfqgb7xwhNyJRdf2N6N1gQNZTcdIdXsPmZbHEelDLMjVNgkkTG9tWGBQo8JW5UF
         k69B1/mMMalLmsvSUVzvn7tNsF5shAu2xftu/klVGQhPI9ZpJcJMunQbmHOOkixCjumU
         kD2Q==
X-Forwarded-Encrypted: i=1; AJvYcCX+SQRTtxk8rVedFlADxDPXFg+9RocNuxypzx0daA3+WSiRaMWDcbEzHXgyNSk3Et7caZiITko=@vger.kernel.org
X-Gm-Message-State: AOJu0YytAnbWSZw6033W/gCr/rdkkidz8UNpmTE2CBxAX+DTJXzfpKDy
	RZWNpKnYIlJLV3gJrCJ5cdGgMiP4XLRgVn7/mcMN7WkxIrBElxLjsZIGmzTOhYOX2PfupGHad17
	4heROUToCYXv0xt940b2eOaeUw4ZBlH/z0sto6HGPN1rJCKvVSTHzfMvaEA==
X-Gm-Gg: ASbGncuRPlGpVQSr0RgOsuC+t7/cbDC9h50ZT5zIqzn9H+0A2RuI8Yu5MJ8ga0mgblh
	K9dcMjgTrqPREpxpeYCjPGuiR7yRx6LK7fJ2QH68jRrreaWsCFwvMaAdFgyP5UgKk920wIvEfFU
	LCyuf37YDgjwx5KTOZdUBJXp2PFkbNY78s9ULHlHD0Zew61aXcMLAr8QT7D3nYtG6vE1K2oeRlG
	JfmUEdTAVS/BL2fLzqY48JU9MdzAAHLyOBlEfNCVXrN4Cd7yqafNvWrYo0j10e3ZD9PhsQDEGPR
	CTs71OKdQR4UAdGpzCPdg+j3nS0gigdgyl0oRRkL9EB0C1L1iQCJwT70G076DXLeIrQ=
X-Received: by 2002:a05:6402:46cb:b0:628:aace:ee7f with SMTP id 4fb4d7f45d1cf-62f84213e1cmr1661584a12.15.1758103738962;
        Wed, 17 Sep 2025 03:08:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCI1bwwBAT5IkwS4xgabTZJQZfa1X7g+mAYVRtNfR3fNJSI8m+TnvZR9JSOQ17ir48t7RJGw==
X-Received: by 2002:a05:6402:46cb:b0:628:aace:ee7f with SMTP id 4fb4d7f45d1cf-62f84213e1cmr1661562a12.15.1758103738506;
        Wed, 17 Sep 2025 03:08:58 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62ec33ad242sm13053380a12.17.2025.09.17.03.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 03:08:57 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 87B8B25C74B; Wed, 17 Sep 2025 12:08:51 +0200 (CEST)
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
In-Reply-To: <CAHS8izOY3aSe96aUQBV76ZRpqj5mXwkPenNvmN6yN0cJmceLUA@mail.gmail.com>
References: <aMSni79s6vCCVCFO@p100> <87zfawvt2f.fsf@toke.dk>
 <f64372ec-c127-457f-b8e2-0f48223bd147@gmx.de>
 <CAHS8izMjKub2cPa9Qqiga96XQ7piq3h0Vb_p+9RzNbBXXeGQrw@mail.gmail.com>
 <87y0qerbld.fsf@toke.dk>
 <CAHS8izOY3aSe96aUQBV76ZRpqj5mXwkPenNvmN6yN0cJmceLUA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 17 Sep 2025 12:08:51 +0200
Message-ID: <87tt11qtl8.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mina Almasry <almasrymina@google.com> writes:

> On Tue, Sep 16, 2025 at 2:27=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@redhat.com> wrote:
>>
>> Mina Almasry <almasrymina@google.com> writes:
>>
>> > On Mon, Sep 15, 2025 at 6:08=E2=80=AFAM Helge Deller <deller@gmx.de> w=
rote:
>> >>
>> >> On 9/15/25 13:44, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> >> > Helge Deller <deller@kernel.org> writes:
>> >> >
>> >> >> Commit ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap =
them when
>> >> >> destroying the pool") changed PP_MAGIC_MASK from 0xFFFFFFFC to 0xc=
000007c on
>> >> >> 32-bit platforms.
>> >> >>
>> >> >> The function page_pool_page_is_pp() uses PP_MAGIC_MASK to identify=
 page pool
>> >> >> pages, but the remaining bits are not sufficient to unambiguously =
identify
>> >> >> such pages any longer.
>> >> >
>> >> > Why not? What values end up in pp_magic that are mistaken for the
>> >> > pp_signature?
>> >>
>> >> As I wrote, PP_MAGIC_MASK changed from 0xFFFFFFFC to 0xc000007c.
>> >> And we have PP_SIGNATURE =3D=3D 0x40  (since POISON_POINTER_DELTA is =
zero on 32-bit platforms).
>> >> That means, that before page_pool_page_is_pp() could clearly identify=
 such pages,
>> >> as the (value & 0xFFFFFFFC) =3D=3D 0x40.
>> >> So, basically only the 0x40 value indicated a PP page.
>> >>
>> >> Now with the mask a whole bunch of pointers suddenly qualify as being=
 a pp page,
>> >> just showing a few examples:
>> >> 0x01111040
>> >> 0x082330C0
>> >> 0x03264040
>> >> 0x0ad686c0 ....
>> >>
>> >> For me it crashes immediately at bootup when memblocked pages are han=
ded
>> >> over to become normal pages.
>> >>
>> >
>> > I tried to take a look to double check here and AFAICT Helge is correc=
t.
>> >
>> > Before the breaking patch with PP_MAGIC_MASK=3D=3D0xFFFFFFFC, basically
>> > 0x40 is the only pointer that may be mistaken as a valid pp_magic.
>> > AFAICT each bit we 0 in the PP_MAGIC_MASK (aside from the 3 least
>> > significant bits), doubles the number of pointers that can be mistaken
>> > for pp_magic. So with 0xFFFFFFFC, only one value (0x40) can be
>> > mistaken as a valid pp_magic, with  0xc000007c AFAICT 2^22 values can
>> > be mistaken as pp_magic?
>> >
>> > I don't know that there is any bits we can take away from
>> > PP_MAGIC_MASK I think? As each bit doubles the probablity :(
>> >
>> > I would usually say we can check the 3 least significant bits to tell
>> > if pp_magic is a pointer or not, but pp_magic is unioned with
>> > page->lru I believe which will use those bits.
>>
>> So if the pointers stored in the same field can be any arbitrary value,
>> you are quite right, there is no safe value. The critical assumption in
>> the bit stuffing scheme is that the pointers stored in the field will
>> always be above PAGE_OFFSET, and that PAGE_OFFSET has one (or both) of
>> the two top-most bits set (that is what the VMSPLIT reference in the
>> comment above the PP_DMA_INDEX_SHIFT definition is alluding to).
>>
>
> I see... but where does the 'PAGE_OFFSET has one (or both) of the two
> top-most bits set)' assumption come from? Is it from this code?

Well, from me grepping through the code and trying to make sense of all
the different cases of the preprocessor and config directives across
architectures. Seems I did not quite succeed :/

> /*
>  * PAGE_OFFSET -- the first address of the first page of memory.
>  * When not using MMU this corresponds to the first free page in
>  * physical memory (aligned on a page boundary).
>  */
> #ifdef CONFIG_MMU
> #ifdef CONFIG_64BIT
> ....
> #else
> #define PAGE_OFFSET _AC(0xc0000000, UL)
> #endif /* CONFIG_64BIT */
> #else
> #define PAGE_OFFSET ((unsigned long)phys_ram_base)
> #endif /* CONFIG_MMU */
>
> It looks like with !CONFIG_MMU we use phys_ram_base and I'm unable to
> confirm that all the values of this have the first 2 bits set. I
> wonder if his setup is !CONFIG_MMU indeed.

Right, that's certainly one thing I missed. As was the parisc arch
thing, as Helge followed up with. Ugh :/

> It also looks like pp_magic is also union'd with __folio_index in
> struct page, and it looks like the data there is sometimes used as a
> pointer and sometimes not.

Not according to my pahole:

[...]
			union {
				long unsigned int __folio_index; /*    32     8 */
[...]
       	struct {
			long unsigned int pp_magic;      /*     8     8 */
=09
So I think we're good with this, no?

So given the above, we could do something equivalent to this, I think?

diff --git i/include/linux/mm.h w/include/linux/mm.h
index 1ae97a0b8ec7..615aaa19c60c 100644
--- i/include/linux/mm.h
+++ w/include/linux/mm.h
@@ -4175,8 +4175,12 @@ int arch_lock_shadow_stack_status(struct task_struct=
 *t, unsigned long status);
  */
 #define PP_DMA_INDEX_BITS MIN(32, __ffs(POISON_POINTER_DELTA) - PP_DMA_IND=
EX_SHIFT)
 #else
+#if PAGE_OFFSET > PP_SIGNATURE
 /* Always leave out the topmost two; see above. */
-#define PP_DMA_INDEX_BITS MIN(32, BITS_PER_LONG - PP_DMA_INDEX_SHIFT - 2)
+#define PP_DMA_INDEX_BITS MIN(32, __fls(PAGE_OFFSET) - PP_DMA_INDEX_SHIFT =
- 1)
+#else
+#define PP_DMA_INDEX_BITS 0
+#endif /* PAGE_OFFSET > PP_SIGNATURE */
 #endif
=20
 #define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS +  PP_DMA_INDEX_SHIFT =
- 1, \


Except that it won't work in this form as-is because PAGE_OFFSET is not
always a constant (see the #define PAGE_OFFSET ((unsigned
long)phys_ram_base) that your quoted above), so we'll have to turn it
into an inline function or something.

I'm not sure adding this extra complexity is really worth it, or if we
should just go with the '#define PP_DMA_INDEX_BITS 0' when
POISON_POINTER_DELTA is unset and leave it at that for the temporary
workaround. WDYT?

-Toke



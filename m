Return-Path: <netdev+bounces-227438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C3ABAF67B
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 09:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EAFE2A2BD9
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 07:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D76827057D;
	Wed,  1 Oct 2025 07:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hUvpAq8C"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EE826FDB2
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 07:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759303873; cv=none; b=mGqeIKYX1jRxCb3JBn2KHszJv0swI1Srj6NCwUxpTju1M8lQFMuM1mPW4u25yFMp826+yDsO6RpsSCcZOtu2jHW4qFnIOncDsBh1MQFwunG/BQVNYt9qcSmYA2HxOqloJ8YKlRQllC3K44ToM1yEZ7H5BOsWzpuWc3nKejjHpBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759303873; c=relaxed/simple;
	bh=XjdO0jasj3kJDtIuE+ndTHYJCmrbLe5P1/yUmczOEmA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NavhpUOUytI2LXpwnucn3UHFW8UGC+mbWZnKG6w+EZWWQFAblTc86FFxWzFcKqpF4E55baaehG07yoVEKqRsh12K0K2IrDhrkfzPgkopBA+iJhSuVWPJtDHybGgiso3kelpRtDLjkjk8Y7FwIBh2N12us9KRATzWAFBqK7mqbjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hUvpAq8C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759303871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XwqCn0F38LGIwrz+84m4s4y5WBK50BZnma0porbfnQQ=;
	b=hUvpAq8CXxEajUMCnV0Gj/dofyUTyszpi3dvoWd3i4Ppm5XcSowUQjq2Bfpy3kbih8XLIJ
	7ocl6TRGqJgAiLanmLdHI7cjlF6iwaosldwbSrGAyNw10CYPeIjfw5thvhMkP9wbacdPTS
	hfo6samg30sL/BIkdX4Mnq+8kxoQji8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-becKKLHHOrCGuGozqbXqEg-1; Wed, 01 Oct 2025 03:31:10 -0400
X-MC-Unique: becKKLHHOrCGuGozqbXqEg-1
X-Mimecast-MFC-AGG-ID: becKKLHHOrCGuGozqbXqEg_1759303869
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b04a8ae1409so959732066b.2
        for <netdev@vger.kernel.org>; Wed, 01 Oct 2025 00:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759303869; x=1759908669;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XwqCn0F38LGIwrz+84m4s4y5WBK50BZnma0porbfnQQ=;
        b=uDPBj7QVObkeUrtA0+V+xU/6WWFxPVV1dKvJsZoJMTfj65XaEPguqj7a6FQbKBmR7f
         B3k7mwtzRZTtKmF6Ijkk1dZSInNeBmSS2XRHUzCYxGvdKb+Yuo4DnWTWv4c0PHIFKAjt
         FQaA1co7WWZoo9leFMOs/WupupujjQMBJe9OcsNI1KFfHJMK+/vzzeTIxybZyBMnSfxB
         oqAUVFQRBaiqszJ2kql9xo7HczeWpxHqQUTNI0j+p4qpFm/SbXR/6B/uLvyAFStNtDxn
         6dORGgKaCxoSz2Vpl9132wakBdq4lnQjVm8vh5gzfs0z+Qv0Rz32eVTUSePFEYdCygvo
         70Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWrEwaY+RUcD8WdTYS59Ji8x0uUCUzOJ6QptzGtYn8+8TCvqK7SgZZiOqrzPnlRvasSl8CYdDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfoDCuGdPxsw9lfVoxi5Yp9cD14B7VI/lJKzQCi2io5RML2c5W
	92i4scI4fAqKhx34qRe4FlQakl455UNDrVjjEAQusy/4487PQ8Ng1qe1tgzKUvxu+V+ABQVt7gH
	jHBtQ87GN/EZcwad8NJs5jZ+2CeL3QQW4IPfZQca9n825svINTgUNaF1IZw==
X-Gm-Gg: ASbGncvhLVHryB0lMbAhJ414B/FUQereZ8lJnjhnTNeRFuf4+skIR55+UC/YudNgDJo
	/zMm5PnzjHF3EA7wnU0o05GKecaFJFHgzRfy4fNUQwp5/Y1HlwKtXFSlH4/eF+av+P0vAjFHq7f
	fRRc3FHX6dYtvYU9Rudy5lWhc3NE6fdH4/MwN9f8RNew3aparxGMM1+Jk3i47QZeq1e8sNGvFPK
	WZoDN3//RP7DI3Y0oJbbWKEjHuUKSQL30Sekp3yjuggi68Bd+41S/osl2Qxg9tLpgejoe8WbrML
	fiDpBurxWAMUDMauPqUnINIpvnpEyaxDco3589cKMFzEL6akmyDUuH8yWfUOj2El7OnAnAP3
X-Received: by 2002:a17:907:3f1f:b0:b45:1063:fb65 with SMTP id a640c23a62f3a-b46e82a70a0mr303996166b.39.1759303868643;
        Wed, 01 Oct 2025 00:31:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaIeVy1GaiMx10rrLM9SRhGSq3TBVSFud/vfhJoekCF5qafntVq/Ev6Ut7hpUPRh8DghTnmw==
X-Received: by 2002:a17:907:3f1f:b0:b45:1063:fb65 with SMTP id a640c23a62f3a-b46e82a70a0mr303990066b.39.1759303868123;
        Wed, 01 Oct 2025 00:31:08 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3dc2cf61dbsm648421166b.29.2025.10.01.00.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 00:31:07 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 455952779A0; Wed, 01 Oct 2025 09:31:06 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
 <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Jakub Kicinski
 <kuba@kernel.org>, stable@vger.kernel.org, Helge Deller <deller@gmx.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, linux-mm@kvack.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] page_pool: Fix PP_MAGIC_MASK to avoid crashing
 on some 32-bit arches
In-Reply-To: <CAHS8izPGxvdDu7JwEWK2=fk=qHoYgFzOs1FjOWjmNwqrU2r0kA@mail.gmail.com>
References: <20250930114331.675412-1-toke@redhat.com>
 <CAHS8izPGxvdDu7JwEWK2=fk=qHoYgFzOs1FjOWjmNwqrU2r0kA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 01 Oct 2025 09:31:06 +0200
Message-ID: <878qhvm62t.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mina Almasry <almasrymina@google.com> writes:

> On Tue, Sep 30, 2025 at 4:43=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@redhat.com> wrote:
>>
>> Helge reported that the introduction of PP_MAGIC_MASK let to crashes on
>> boot on his 32-bit parisc machine. The cause of this is the mask is set
>> too wide, so the page_pool_page_is_pp() incurs false positives which
>> crashes the machine.
>>
>> Just disabling the check in page_pool_is_pp() will lead to the page_pool
>> code itself malfunctioning; so instead of doing this, this patch changes
>> the define for PP_DMA_INDEX_BITS to avoid mistaking arbitrary kernel
>> pointers for page_pool-tagged pages.
>>
>> The fix relies on the kernel pointers that alias with the pp_magic field
>> always being above PAGE_OFFSET. With this assumption, we can use the
>> lowest bit of the value of PAGE_OFFSET as the upper bound of the
>> PP_DMA_INDEX_MASK, which should avoid the false positives.
>>
>> Because we cannot rely on PAGE_OFFSET always being a compile-time
>> constant, nor on it always being >0, we fall back to disabling the
>> dma_index storage when there are not enough bits available. This leaves
>> us in the situation we were in before the patch in the Fixes tag, but
>> only on a subset of architecture configurations. This seems to be the
>> best we can do until the transition to page types in complete for
>> page_pool pages.
>>
>> v2:
>> - Make sure there's at least 8 bits available and that the PAGE_OFFSET
>>   bit calculation doesn't wrap
>>
>> Link: https://lore.kernel.org/all/aMNJMFa5fDalFmtn@p100/
>> Fixes: ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap them w=
hen destroying the pool")
>> Cc: stable@vger.kernel.org # 6.15+
>> Tested-by: Helge Deller <deller@gmx.de>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>  include/linux/mm.h   | 22 +++++++------
>>  net/core/page_pool.c | 76 ++++++++++++++++++++++++++++++--------------
>>  2 files changed, 66 insertions(+), 32 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 1ae97a0b8ec7..0905eb6b55ec 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -4159,14 +4159,13 @@ int arch_lock_shadow_stack_status(struct task_st=
ruct *t, unsigned long status);
>>   * since this value becomes part of PP_SIGNATURE; meaning we can just u=
se the
>>   * space between the PP_SIGNATURE value (without POISON_POINTER_DELTA),=
 and the
>>   * lowest bits of POISON_POINTER_DELTA. On arches where POISON_POINTER_=
DELTA is
>> - * 0, we make sure that we leave the two topmost bits empty, as that gu=
arantees
>> - * we won't mistake a valid kernel pointer for a value we set, regardle=
ss of the
>> - * VMSPLIT setting.
>> + * 0, we use the lowest bit of PAGE_OFFSET as the boundary if that valu=
e is
>> + * known at compile-time.
>>   *
>> - * Altogether, this means that the number of bits available is constrai=
ned by
>> - * the size of an unsigned long (at the upper end, subtracting two bits=
 per the
>> - * above), and the definition of PP_SIGNATURE (with or without
>> - * POISON_POINTER_DELTA).
>> + * If the value of PAGE_OFFSET is not known at compile time, or if it i=
s too
>> + * small to leave at least 8 bits available above PP_SIGNATURE, we defi=
ne the
>> + * number of bits to be 0, which turns off the DMA index tracking altog=
ether
>> + * (see page_pool_register_dma_index()).
>>   */
>>  #define PP_DMA_INDEX_SHIFT (1 + __fls(PP_SIGNATURE - POISON_POINTER_DEL=
TA))
>>  #if POISON_POINTER_DELTA > 0
>> @@ -4175,8 +4174,13 @@ int arch_lock_shadow_stack_status(struct task_str=
uct *t, unsigned long status);
>>   */
>>  #define PP_DMA_INDEX_BITS MIN(32, __ffs(POISON_POINTER_DELTA) - PP_DMA_=
INDEX_SHIFT)
>>  #else
>> -/* Always leave out the topmost two; see above. */
>> -#define PP_DMA_INDEX_BITS MIN(32, BITS_PER_LONG - PP_DMA_INDEX_SHIFT - =
2)
>> +/* Use the lowest bit of PAGE_OFFSET if there's at least 8 bits availab=
le; see above */
>> +#define PP_DMA_INDEX_MIN_OFFSET (1 << (PP_DMA_INDEX_SHIFT + 8))
>> +#define PP_DMA_INDEX_BITS ((__builtin_constant_p(PAGE_OFFSET) && \
>> +                           PAGE_OFFSET >=3D PP_DMA_INDEX_MIN_OFFSET && \
>> +                           !(PAGE_OFFSET & (PP_DMA_INDEX_MIN_OFFSET - 1=
))) ? \
>> +                             MIN(32, __ffs(PAGE_OFFSET) - PP_DMA_INDEX_=
SHIFT) : 0)
>> +
>>  #endif
>
> It took some staring at, but I think I understand this code and it is
> correct. This is the critical check, it's making sure that the bits
> used by PAGE_OFFSET are not shared with the bits used for the
> dma-index:
>
>> +                           !(PAGE_OFFSET & (PP_DMA_INDEX_MIN_OFFSET - 1=
))) ? \
>
> The following check confused me for a while, but I think I figured it
> out. It's checking that the bits used for PAGE_OFFSET are 'higher'
> than the bits used for PP_DMA_INDEX:
>
>> +                           PAGE_OFFSET >=3D PP_DMA_INDEX_MIN_OFFSET && \
>
> And finally this calculation should indeed be the bits we can use (the
> empty space between the lsb set by PAGE_OFFSET and the msb set by the
> pp magic:
>
>> +                             MIN(32, __ffs(PAGE_OFFSET) - PP_DMA_INDEX_=
SHIFT) : 0)

Yup, exactly! Thanks for walking through it and confirming that the
logic is sound :)

> AFAIU we should not need the MIN anymore, since that subtraction is
> guaranteed to be positive, but that's a nit.

The MIN was originally there to limit how many bits we use for 64-bit
systems that don't set POISON_POINTER_DELTA, since xarray uses a u32 for
the size of the limits. Not sure if such a combination exists in the
real world, but I figure that having it there doesn't hurt in any case.

> Reviewed-by: Mina Almasry <almasrymina@google.com>

Thanks!

-Toke



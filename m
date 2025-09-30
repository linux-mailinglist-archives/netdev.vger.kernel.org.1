Return-Path: <netdev+bounces-227285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C410BABE1F
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 09:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EA2C16413C
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 07:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CEC21C17D;
	Tue, 30 Sep 2025 07:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eAp3HhXT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEC833F6
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 07:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759218351; cv=none; b=Kr8N5SnFFLdL9o8mKrjyxUW+e39B/EUGs3697Aflf8pWeIGM5NA9dAyZWrrqaYv0M5eciRTzsa5QREnwbI5Mb8piJLgeNKBXzCcRYFGbaaTXlpNWU52Av9a7RGWZN4UCvPNeEY/oVnUoyc6kD1gv2tFGXLYR6X6r7eogntBgoVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759218351; c=relaxed/simple;
	bh=lhV/oMe1moZjqkSPiqSUxEkiqRh/qOVQ7UH+AGv3Gsg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dvOyCG5ICuS0retT563Ua0wWZPXpnRG6TDvy0/NQrHBiqj2XD/cY40d+dgsrNWtW9usmmatF/gRafSXHVmgmx0ZMdkDkZdyBWzqGjMHYH7yG3yaWeczyd2V59Adz9t24Ei7Ah6BExQ9etIFSrmUayF70aCUNNOLpHtAup2XFA+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eAp3HhXT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759218348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vceb7qiM17XunDAIdaIla5/4nlWZXJrRMpO0J7bj8yo=;
	b=eAp3HhXTHNvRI8TJWDonDQbjqZO4qjLjzQP9xe2DtjZbha4/q5mtmY6ugkqkLnu6jcZBuv
	R6kPStGmvtvFaArN+cS5soNHM9iHvpg2W1H8M0hCG89zXgeli1t1tDd4USmhbphQ3RmvbV
	pRWmlkPy89LOjhdLxVkigvqLN7ZHcMw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-Qnm2adlqONmupPKvePxSXw-1; Tue, 30 Sep 2025 03:45:46 -0400
X-MC-Unique: Qnm2adlqONmupPKvePxSXw-1
X-Mimecast-MFC-AGG-ID: Qnm2adlqONmupPKvePxSXw_1759218345
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b335fbe7c0dso669119266b.1
        for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 00:45:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759218345; x=1759823145;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vceb7qiM17XunDAIdaIla5/4nlWZXJrRMpO0J7bj8yo=;
        b=NVioHiciOdMf33Zv+gqWzZfyjInsE3t2Ph07ZPTtUVn91+uRgcgrR52+V72Kb8cU3G
         sLFId/RtNrB/pyFEv5Hg7Cr1qdzaHuioZ+UZTZ74CraZU8viwbxAAGrUVuNRM3vyt5yN
         yUDdZHfxwFFE6l0YPr0X9Ch9wborO2N2GGILUKAIGLcS3+RPKdVVTm12cVumiZXvQTYM
         f2SLhn9jwumHurEPsJGl9GrtNQKotgPvzI8s1ZsfFFKjnjffj/uNQ4ynqjEUYRBVUcWq
         3re2OacNdB15EecPDor18yarikykR0Syy1YolIioxL4vyGQNZbsPjH4w8oGX2FoMCK5N
         Pcfg==
X-Forwarded-Encrypted: i=1; AJvYcCXgLvT54TMAwwA48g6ftk5pDavyTDAA75Fm8e8HzyZBRo6yQJzp5KyJ0WDwKsAjuZodqGccIZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFc1ufL8usEvE+nPSpVYIf1jM6io2xdLB164VA6SUf4y9VgGG+
	pQDh+7fZLQIOJoPpjZh6hx3Mz+TgVTYW67pvI1GRqeuJ2R6JYV5RzYyQf2qARTU+x50uzbK4l+J
	BOVUqlYGoLuIfHt+c9lwOjJPVfi4F3xHcQK9nwzkHkavbLg5zIPchFOZwGvvVbqS8KQ==
X-Gm-Gg: ASbGncsFpfTZKfKizjpdZHzg8GfSBapPhjvDggwsALT+3hxOYUeAKVQ3qvaleOlV3ab
	nKW2AAOspdX5wluieQwGxLWl7KkbWTTU9hUkSNzjWm68Hjd8xotv2oR9gKecDrMP0X/rHlh0JYc
	lORF2euZCdTpQQS0/sxaNqwPeD+4vyOML0ujGXHRyy5LeR3mVYBvT2dJgrdDg7Th3HF5rEmyB43
	DBt37ucmtvW1qlDOf7Ig5jbs5LFBNk5rQOzMIoEI6/B4l1XKizROUeKjmXyp/LMpkI5JbZ9YUlK
	xWAg61xsz14ZGku0fIIsZOzgdCmoqxNlOaNhnbI3H3Yd5hYRIsGtmPLyT2KwqsYiUraJYcFG
X-Received: by 2002:a17:907:d8b:b0:b2e:6b3b:fbe7 with SMTP id a640c23a62f3a-b34b218e997mr2161350766b.0.1759218344866;
        Tue, 30 Sep 2025 00:45:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFgyijEcuMJ8a8fkflLc/115VPCF1zLIQJ0BUnXCH1k3T3ny0OxuymgESptWICrjF2yX14gA==
X-Received: by 2002:a17:907:d8b:b0:b2e:6b3b:fbe7 with SMTP id a640c23a62f3a-b34b218e997mr2161348166b.0.1759218344430;
        Tue, 30 Sep 2025 00:45:44 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3f945d90adsm307755966b.87.2025.09.30.00.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 00:45:43 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A91A527777D; Tue, 30 Sep 2025 09:45:42 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
 <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Jakub Kicinski
 <kuba@kernel.org>, Helge Deller <deller@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-mm@kvack.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net] page_pool: Fix PP_MAGIC_MASK to avoid crashing on
 some 32-bit arches
In-Reply-To: <CAHS8izMsRq4tfx8603R3HLKPYGqEsLqvPH8qfENFnzeB5Ja8AA@mail.gmail.com>
References: <20250926113841.376461-1-toke@redhat.com>
 <CAHS8izMsRq4tfx8603R3HLKPYGqEsLqvPH8qfENFnzeB5Ja8AA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 30 Sep 2025 09:45:42 +0200
Message-ID: <873484o02h.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mina Almasry <almasrymina@google.com> writes:

> On Fri, Sep 26, 2025 at 4:40=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen =
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
>> dma_index storage when there are no bits available. This leaves us in
>> the situation we were in before the patch in the Fixes tag, but only on
>> a subset of architecture configurations. This seems to be the best we
>> can do until the transition to page types in complete for page_pool
>> pages.
>>
>> Link: https://lore.kernel.org/all/aMNJMFa5fDalFmtn@p100/
>> Fixes: ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap them w=
hen destroying the pool")
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>> Sorry for the delay on getting this out. I have only compile-tested it,
>> since I don't have any hardware that triggers the original bug. Helge, I=
'm
>> hoping you can take it for a spin?
>>
>>  include/linux/mm.h   | 18 +++++------
>>  net/core/page_pool.c | 76 ++++++++++++++++++++++++++++++--------------
>>  2 files changed, 62 insertions(+), 32 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 1ae97a0b8ec7..28541cb40f69 100644
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
>> + * small to leave some bits available above PP_SIGNATURE, we define the=
 number
>> + * of bits to be 0, which turns off the DMA index tracking altogether (=
see
>> + * page_pool_register_dma_index()).
>>   */
>>  #define PP_DMA_INDEX_SHIFT (1 + __fls(PP_SIGNATURE - POISON_POINTER_DEL=
TA))
>>  #if POISON_POINTER_DELTA > 0
>> @@ -4175,8 +4174,9 @@ int arch_lock_shadow_stack_status(struct task_stru=
ct *t, unsigned long status);
>>   */
>>  #define PP_DMA_INDEX_BITS MIN(32, __ffs(POISON_POINTER_DELTA) - PP_DMA_=
INDEX_SHIFT)
>>  #else
>> -/* Always leave out the topmost two; see above. */
>> -#define PP_DMA_INDEX_BITS MIN(32, BITS_PER_LONG - PP_DMA_INDEX_SHIFT - =
2)
>> +/* Constrain to the lowest bit of PAGE_OFFSET if known; see above. */
>> +#define PP_DMA_INDEX_BITS ((__builtin_constant_p(PAGE_OFFSET) && PAGE_O=
FFSET > PP_SIGNATURE) ? \
>> +                             MIN(32, __ffs(PAGE_OFFSET) - PP_DMA_INDEX_=
SHIFT) : 0)
>
> Do you have to watch out for an underflow of __ffs(PAGE_OFFSET) -
> PP_DMA_INDEX_SHIFT (at which point we'll presumably use 32 here
> instead of the expected 0)? Or is that guaranteed to be positive for
> some reason I'm not immediately grasping.

That's what the 'PAGE_OFFSET > PP_SIGNATURE' in the ternary operator is
for. I'm assuming that PAGE_OFFSET is always a "round" number (e.g.,
0xc0000000), in which case that condition should be sufficient, no?

-Toke



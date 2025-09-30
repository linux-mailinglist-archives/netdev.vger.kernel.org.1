Return-Path: <netdev+bounces-227334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AA2BACAFD
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 13:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C77E23B2741
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 11:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71594220687;
	Tue, 30 Sep 2025 11:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ae96GESw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2FF22D78A
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 11:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759231850; cv=none; b=fu6wd1oVm3UuaI0VzthD7DDu+bcyLCzRHJCdb1qXEDtXrPOj+bqtpXhc9ZV6aRm/jSC2Akvyg+gXvkWOlaOHQY1Ywj98Myvo2ikrGKF/l4iz8dmrhnDrt7P1QfWH9Rft/AoMQ/ZpNHgJiy3v7ExFyx4OjBKpD+oZHccLA/krPlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759231850; c=relaxed/simple;
	bh=MTsvK3jrS07VqWht0gwmr+dU/ix2pmbgCIWI1SsU2L8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u9knlqDYZjWsDTaggTmD5Jy7yQcNeAh8aMmeW6OXTCf4Mr+nB6oSEKYDjKBc0d5AxotLqK0fALxTcOZuMX1quJOiEklrYABH0SonYsIo+kzI02hJcVNRQ/cQj/dyjcboara8OzLKm534POqYn7qKMjROzFaXv7ukt9oJgTHCjAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ae96GESw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759231847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=60uGyvQqOvx3NZbN7PM8fFSOU0EVqBan1owFG0+88fM=;
	b=Ae96GESwoCC4SKWgI1FHyIcVlPF0V8wINNzVq2/UPtKpu/wp8z3QY7ZF+pnDQQ8JOaDIvz
	xYBhQikgYKZHeKV9D0q108TVWUGV1JzEljdi72SXaps/TJwy+GUT9kG6VlsR7UdV/e8x2Z
	7YiAfb/S89E1lQ9zEU3wWB9nN8UoQDY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-YObBXMvbMFO8hDcTat8teg-1; Tue, 30 Sep 2025 07:30:46 -0400
X-MC-Unique: YObBXMvbMFO8hDcTat8teg-1
X-Mimecast-MFC-AGG-ID: YObBXMvbMFO8hDcTat8teg_1759231845
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b2e6b2bb443so589438066b.2
        for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 04:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759231845; x=1759836645;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60uGyvQqOvx3NZbN7PM8fFSOU0EVqBan1owFG0+88fM=;
        b=thKID3Lmmvmf33sWu/epjQCYGTbX4YEVQSJlWYkWRmrbd7/H7IHxSGrEILnjKzYuym
         rpp3jvSUfX8012yOCpU/tOzt8+3yd54MKQjy/UJbeDTQ63UV2jN2cbiT3RMXht2Vmdfm
         HrFnno9HlAwCRX4t/ddGvh8aS4zxlm+3QgTPkrm65Lc2w3MkZfOGHOCVYlFj/C3klRro
         /ieJsUhJREsxzayVN1ovZFbO0erGMtFw3HWvoQzMc1mueWym/HwL9C+oa8HqY40MR33r
         LKMzgMYlvi9/YhvAl/GXvuqRu4BS2x3fpUQXnnuAEWezwwQd4hrfY+s5bLCPmeqF3wn6
         QO5w==
X-Forwarded-Encrypted: i=1; AJvYcCXGiTEWjDLmrEEQTWp/m7pO/O/JHZAle9L9AoqxoNpOvWCHtQrKRznmIuU1x671A06RBYS92ng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykf/dFG//UsuNLJBgi8ejS9/bCbeiOfULmtzWLTr0UGYbutYVW
	4kvSG06K6J8QRcMofSIAfDmDaZlxURXvbZsW2UnoMJYLKghG8JTbNFM26h+T7I+EtZ2YusZNitJ
	d6uVz/OBmFCQ1KyOmsrl6VEuSnsV0FBcCicav+JZrJADh5DMzDpVO8xA+AQ==
X-Gm-Gg: ASbGncvWFr/+V+T6738EsYe2ytSdoTx6zJyqhlbaz+3cGudMmc/7HwT76+q3C4VNS6U
	MVTf9r5gtvTd7Txxky9fWt1bCRvGQvzAYm58UkByN8ZH3zhym/KSBaALTW/OMnHF4iQsM+AFeTK
	XfVWqTTqYtQajJk+UHXHHbBOtKHNbXkap/bl9IEyp6dtFKm3No5kBjurOP9jYCssP9su3o6bVay
	9E/ro8UKRQ5GfDX4e+TSmPrnOl/0Zl/LTje5N6hYp6JJOe1091EQ3IXOUXAhnlXZ0rb+vN2ogmm
	W2M2zbxMuS4cJakFXeUajjf3hpZHSkistWxX/cBIIOIFeNDoWxEbidMcCq/d5tl8YH0ECg==
X-Received: by 2002:a17:907:94cf:b0:b3d:73e1:d810 with SMTP id a640c23a62f3a-b3d73e1ef38mr857565766b.49.1759231844928;
        Tue, 30 Sep 2025 04:30:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoB1+OY95A0NTLqmIVmGw9vxLbsBNmzGnI34+lOhNkGW9jiRWgh55f3njKeLEh37AJ/qzJWA==
X-Received: by 2002:a17:907:94cf:b0:b3d:73e1:d810 with SMTP id a640c23a62f3a-b3d73e1ef38mr857561366b.49.1759231844384;
        Tue, 30 Sep 2025 04:30:44 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b40ac59a4b5sm278533166b.22.2025.09.30.04.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 04:30:43 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B956E2777F9; Tue, 30 Sep 2025 13:30:42 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>, Mina Almasry <almasrymina@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
 <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Jakub Kicinski
 <kuba@kernel.org>, Helge Deller <deller@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Simon Horman
 <horms@kernel.org>, linux-mm@kvack.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] page_pool: Fix PP_MAGIC_MASK to avoid crashing on
 some 32-bit arches
In-Reply-To: <0dc3f975-c769-4a78-9211-80869509cfd2@redhat.com>
References: <20250926113841.376461-1-toke@redhat.com>
 <CAHS8izMsRq4tfx8603R3HLKPYGqEsLqvPH8qfENFnzeB5Ja8AA@mail.gmail.com>
 <873484o02h.fsf@toke.dk> <0dc3f975-c769-4a78-9211-80869509cfd2@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 30 Sep 2025 13:30:42 +0200
Message-ID: <87ms6cmb31.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni@redhat.com> writes:

> On 9/30/25 9:45 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Mina Almasry <almasrymina@google.com> writes:
>>> On Fri, Sep 26, 2025 at 4:40=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgense=
n <toke@redhat.com> wrote:
>>>>
>>>> Helge reported that the introduction of PP_MAGIC_MASK let to crashes on
>>>> boot on his 32-bit parisc machine. The cause of this is the mask is set
>>>> too wide, so the page_pool_page_is_pp() incurs false positives which
>>>> crashes the machine.
>>>>
>>>> Just disabling the check in page_pool_is_pp() will lead to the page_po=
ol
>>>> code itself malfunctioning; so instead of doing this, this patch chang=
es
>>>> the define for PP_DMA_INDEX_BITS to avoid mistaking arbitrary kernel
>>>> pointers for page_pool-tagged pages.
>>>>
>>>> The fix relies on the kernel pointers that alias with the pp_magic fie=
ld
>>>> always being above PAGE_OFFSET. With this assumption, we can use the
>>>> lowest bit of the value of PAGE_OFFSET as the upper bound of the
>>>> PP_DMA_INDEX_MASK, which should avoid the false positives.
>>>>
>>>> Because we cannot rely on PAGE_OFFSET always being a compile-time
>>>> constant, nor on it always being >0, we fall back to disabling the
>>>> dma_index storage when there are no bits available. This leaves us in
>>>> the situation we were in before the patch in the Fixes tag, but only on
>>>> a subset of architecture configurations. This seems to be the best we
>>>> can do until the transition to page types in complete for page_pool
>>>> pages.
>>>>
>>>> Link: https://lore.kernel.org/all/aMNJMFa5fDalFmtn@p100/
>>>> Fixes: ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap them=
 when destroying the pool")
>>>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>>> ---
>>>> Sorry for the delay on getting this out. I have only compile-tested it,
>>>> since I don't have any hardware that triggers the original bug. Helge,=
 I'm
>>>> hoping you can take it for a spin?
>>>>
>>>>  include/linux/mm.h   | 18 +++++------
>>>>  net/core/page_pool.c | 76 ++++++++++++++++++++++++++++++--------------
>>>>  2 files changed, 62 insertions(+), 32 deletions(-)
>>>>
>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>> index 1ae97a0b8ec7..28541cb40f69 100644
>>>> --- a/include/linux/mm.h
>>>> +++ b/include/linux/mm.h
>>>> @@ -4159,14 +4159,13 @@ int arch_lock_shadow_stack_status(struct task_=
struct *t, unsigned long status);
>>>>   * since this value becomes part of PP_SIGNATURE; meaning we can just=
 use the
>>>>   * space between the PP_SIGNATURE value (without POISON_POINTER_DELTA=
), and the
>>>>   * lowest bits of POISON_POINTER_DELTA. On arches where POISON_POINTE=
R_DELTA is
>>>> - * 0, we make sure that we leave the two topmost bits empty, as that =
guarantees
>>>> - * we won't mistake a valid kernel pointer for a value we set, regard=
less of the
>>>> - * VMSPLIT setting.
>>>> + * 0, we use the lowest bit of PAGE_OFFSET as the boundary if that va=
lue is
>>>> + * known at compile-time.
>>>>   *
>>>> - * Altogether, this means that the number of bits available is constr=
ained by
>>>> - * the size of an unsigned long (at the upper end, subtracting two bi=
ts per the
>>>> - * above), and the definition of PP_SIGNATURE (with or without
>>>> - * POISON_POINTER_DELTA).
>>>> + * If the value of PAGE_OFFSET is not known at compile time, or if it=
 is too
>>>> + * small to leave some bits available above PP_SIGNATURE, we define t=
he number
>>>> + * of bits to be 0, which turns off the DMA index tracking altogether=
 (see
>>>> + * page_pool_register_dma_index()).
>>>>   */
>>>>  #define PP_DMA_INDEX_SHIFT (1 + __fls(PP_SIGNATURE - POISON_POINTER_D=
ELTA))
>>>>  #if POISON_POINTER_DELTA > 0
>>>> @@ -4175,8 +4174,9 @@ int arch_lock_shadow_stack_status(struct task_st=
ruct *t, unsigned long status);
>>>>   */
>>>>  #define PP_DMA_INDEX_BITS MIN(32, __ffs(POISON_POINTER_DELTA) - PP_DM=
A_INDEX_SHIFT)
>>>>  #else
>>>> -/* Always leave out the topmost two; see above. */
>>>> -#define PP_DMA_INDEX_BITS MIN(32, BITS_PER_LONG - PP_DMA_INDEX_SHIFT =
- 2)
>>>> +/* Constrain to the lowest bit of PAGE_OFFSET if known; see above. */
>>>> +#define PP_DMA_INDEX_BITS ((__builtin_constant_p(PAGE_OFFSET) && PAGE=
_OFFSET > PP_SIGNATURE) ? \
>>>> +                             MIN(32, __ffs(PAGE_OFFSET) - PP_DMA_INDE=
X_SHIFT) : 0)
>>>
>>> Do you have to watch out for an underflow of __ffs(PAGE_OFFSET) -
>>> PP_DMA_INDEX_SHIFT (at which point we'll presumably use 32 here
>>> instead of the expected 0)? Or is that guaranteed to be positive for
>>> some reason I'm not immediately grasping.
>>=20
>> That's what the 'PAGE_OFFSET > PP_SIGNATURE' in the ternary operator is
>> for. I'm assuming that PAGE_OFFSET is always a "round" number (e.g.,
>> 0xc0000000), in which case that condition should be sufficient, no?
>
> IDK if such assumption is obviously true. I think it would be safer to
> somehow express it with a build time constraint.

Alright, I'll respin and constrain it further.

-Toke



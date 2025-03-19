Return-Path: <netdev+bounces-176102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8886BA68C9F
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 13:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82E35189B1EC
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 12:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E837254AF0;
	Wed, 19 Mar 2025 12:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XH3O8qHw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3159524E013
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 12:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742386730; cv=none; b=E5lEtyTm34bTDp7obU3Jfaw8G5EMsKcEVftxM4nHZyOR62nAj8D8BhYNGbpy89aRKX8CBj/MkgLvUrRevlccZvPxdlrivXEuhGLXnDr657jtlJMJWTLaBSH4k//hx16EP6/3ziwwIwK1YxMPVw2le9xbDVH/FK5riAmcGhqSLWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742386730; c=relaxed/simple;
	bh=KYPJ5Nm5CiOpKZSaHN1aE1WNqtcEvX3sSRLdvIfud/Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DkwV2TuyVDtuAfnEWZRnVxpbU7BiZn9D65YVug7h6hHGiN64onJHiSzuD1E8QNaQ/T2nRA7WxIQgKdtpBL9HT0RYTrchyswGl18HOvALy8pQZKESzpt4KZdKTrhogdb2e1UODEcSvl/cd1jMV9G9MV9YxO+PV9kbWjNvfAkH+ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XH3O8qHw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742386727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zHAuof8mNqwebJdSvdzZnag+45htJDLXlVltgIFNUY8=;
	b=XH3O8qHw1NvzT+ynkQVm3dvfCfIhj/+wyr9kCxtoHh1gJ22yHhHtlJMq/bvwwb/doOohbZ
	M/xL8z9F3IEaIgXPVEGTlhGwXpvoU71fuAbU+JJkeS0BtoBwbE8jgaLlKWfHdvcoxaxVXR
	tdAtDWNSy6U2Lz8fDTWOEQdchLiRKq4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-hSggcidvNl-YaJ3N-ARaVw-1; Wed, 19 Mar 2025 08:18:45 -0400
X-MC-Unique: hSggcidvNl-YaJ3N-ARaVw-1
X-Mimecast-MFC-AGG-ID: hSggcidvNl-YaJ3N-ARaVw_1742386724
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-549adfc38d8so3450645e87.1
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 05:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742386724; x=1742991524;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zHAuof8mNqwebJdSvdzZnag+45htJDLXlVltgIFNUY8=;
        b=bKyp7f51Cwdp9M5a+V7bV4/wiZNnqFYG8K3unB6zubM8JBSZnQDYIvss9sSzjA4c+7
         1E87Ap1GfmNo+DRNkKrs75IHhxJc7urccKH/QSQGRj3/NuBmKsZY+yO3SEPIhGyazkIK
         eKTSRi57nmodfJsYYqpdcrdMy8xLW+g2YIfrfj0LlZfMrt8RSaHd/jnooRQz/laby82j
         6U45ljpbIThXlUY6eSPMxhLLKwUywf7V7M9Rd3ZD+G3loYjob17012UwChBcLohrBAwo
         SKcWvGdK4MET0TVp+ymDtJuyHKNd9QboInHmhfk6PjMCok5aGjy4FpjSHqRjfSHm10oi
         s0yQ==
X-Gm-Message-State: AOJu0YysVXXFy/dqQQc+UnV97n3zOYQ1+J88IcNBGc4ZMMS7jdwsrWiZ
	z+vPJo2Ifw7DefpzuG2PGEV6nPydHa4AzsGU9Shn3ZTi60k0wyIK9hcgD/x5BaPQJg9j/Rk+JNv
	i9NK8GOEz0gjLOs4RsYGB1fW2alH6hpfgnwgtFYEcx4TERJZycW/kpw==
X-Gm-Gg: ASbGncsVGbNsgQH8YIpC/IM/gzklD0z1ST+EnLkNe8CRiRvE7BwzhQs+LGPtGtSNOFh
	7COc22j9RoQIj+s9DmQ/DNByh15s2QzqNZUGZJ61Ny3PcjdV9UcPKP+s4frHpAlZxGD1A76n3Ki
	SxZ9euhjN5tQm2pWvC12ZdeP3g7FL4R+ZT6ppqD7u0UDBkvsIvF3c+Sd444mFBaK8npsLjR49lB
	t3ujlFgAdkxJcGaMlqi5Oy3e+Vj4Qv4Uq8mXpXqCeUrYTPy13tdkpQt7RAum8mYHp49rCEwW+gT
	AivNupGQ68Ub8TL/N22YjVKek5GdudyDXDRlSOR/
X-Received: by 2002:a05:6512:10cb:b0:545:d54:2ebe with SMTP id 2adb3069b0e04-54acb22365dmr1045592e87.43.1742386723734;
        Wed, 19 Mar 2025 05:18:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyGYm0L4Zrm63gwHHSEdeVhZIEKSSrhZNtgIfcLFC9WB6N+6dtsumfvF4gPJciZl+hjDy7ZQ==
X-Received: by 2002:a05:6512:10cb:b0:545:d54:2ebe with SMTP id 2adb3069b0e04-54acb22365dmr1045551e87.43.1742386723083;
        Wed, 19 Mar 2025 05:18:43 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba88536csm1927357e87.177.2025.03.19.05.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 05:18:41 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1634218FC0C2; Wed, 19 Mar 2025 13:18:34 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, Yunsheng Lin
 <yunshenglin0825@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon
 Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mina
 Almasry <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>,
 Pavel Begunkov <asml.silence@gmail.com>, Matthew Wilcox
 <willy@infradead.org>, Robin Murphy <robin.murphy@arm.com>, IOMMU
 <iommu@lists.linux.dev>, segoon@openwall.com, solar@openwall.com,
 oss-security@lists.openwall.com, kernel-hardening@lists.openwall.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, Qiuling Ren <qren@redhat.com>, Yuying Ma
 <yuma@redhat.com>
Subject: Re: [PATCH net-next 3/3] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
In-Reply-To: <ce6ca18b-0eda-4d62-b1d3-e101fe6dcd4e@huawei.com>
References: <20250314-page-pool-track-dma-v1-0-c212e57a74c2@redhat.com>
 <20250314-page-pool-track-dma-v1-3-c212e57a74c2@redhat.com>
 <db813035-fb38-4fc3-b91e-d1416959db13@gmail.com> <87jz8nhelh.fsf@toke.dk>
 <7a76908d-5be2-43f1-a8e2-03b104165a29@huawei.com> <87wmcmhxdz.fsf@toke.dk>
 <ce6ca18b-0eda-4d62-b1d3-e101fe6dcd4e@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 19 Mar 2025 13:18:34 +0100
Message-ID: <87r02ti57p.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yunsheng Lin <linyunsheng@huawei.com> writes:

> On 2025/3/19 4:55, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Yunsheng Lin <linyunsheng@huawei.com> writes:
>>=20
>>> On 2025/3/17 23:16, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> Yunsheng Lin <yunshenglin0825@gmail.com> writes:
>>>>
>>>>> On 3/14/2025 6:10 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>
>>>>> ...
>>>>>
>>>>>>
>>>>>> To avoid having to walk the entire xarray on unmap to find the page
>>>>>> reference, we stash the ID assigned by xa_alloc() into the page
>>>>>> structure itself, using the upper bits of the pp_magic field. This
>>>>>> requires a couple of defines to avoid conflicting with the
>>>>>> POINTER_POISON_DELTA define, but this is all evaluated at compile-ti=
me,
>>>>>> so does not affect run-time performance. The bitmap calculations in =
this
>>>>>> patch gives the following number of bits for different architectures:
>>>>>>
>>>>>> - 24 bits on 32-bit architectures
>>>>>> - 21 bits on PPC64 (because of the definition of ILLEGAL_POINTER_VAL=
UE)
>>>>>> - 32 bits on other 64-bit architectures
>>>>>
>>>>>  From commit c07aea3ef4d4 ("mm: add a signature in struct page"):
>>>>> "The page->signature field is aliased to page->lru.next and
>>>>> page->compound_head, but it can't be set by mistake because the
>>>>> signature value is a bad pointer, and can't trigger a false positive
>>>>> in PageTail() because the last bit is 0."
>>>>>
>>>>> And commit 8a5e5e02fc83 ("include/linux/poison.h: fix LIST_POISON{1,2=
}=20
>>>>> offset"):
>>>>> "Poison pointer values should be small enough to find a room in
>>>>> non-mmap'able/hardly-mmap'able space."
>>>>>
>>>>> So the question seems to be:
>>>>> 1. Is stashing the ID causing page->pp_magic to be in the mmap'able/
>>>>>     easier-mmap'able space? If yes, how can we make sure this will not
>>>>>     cause any security problem?
>>>>> 2. Is the masking the page->pp_magic causing a valid pionter for
>>>>>     page->lru.next or page->compound_head to be treated as a vaild
>>>>>     PP_SIGNATURE? which might cause page_pool to recycle a page not
>>>>>     allocated via page_pool.
>>>>
>>>> Right, so my reasoning for why the defines in this patch works for this
>>>> is as follows: in both cases we need to make sure that the ID stashed =
in
>>>> that field never looks like a valid kernel pointer. For 64-bit arches
>>>> (where CONFIG_ILLEGAL_POINTER_VALUE), we make sure of this by never
>>>> writing to any bits that overlap with the illegal value (so that the
>>>> PP_SIGNATURE written to the field keeps it as an illegal pointer value=
).
>>>> For 32-bit arches, we make sure of this by making sure the top-most bit
>>>> is always 0 (the -1 in the define for _PP_DMA_INDEX_BITS) in the patch,
>>>> which puts it outside the range used for kernel pointers (AFAICT).
>>>
>>> Is there any season you think only kernel pointer is relevant here?
>>=20
>> Yes. Any pointer stored in the same space as pp_magic by other users of
>> the page will be kernel pointers (as they come from page->lru.next). The
>> goal of PP_SIGNATURE is to be able to distinguish pages allocated by
>> page_pool, so we don't accidentally recycle a page from somewhere else.
>> That's the goal of the check in page_pool_page_is_pp():
>>=20
>> (page->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE
>>=20
>> To achieve this, we must ensure that the check above never returns true
>> for any value another page user could have written into the same field
>> (i.e., into page->lru.next). For 64-bit arches, POISON_POINTER_DELTA
>
> POISON_POINTER_DELTA is defined according to CONFIG_ILLEGAL_POINTER_VALUE,
> if CONFIG_ILLEGAL_POINTER_VALUE is not defined yet, POISON_POINTER_DELTA
> is defined to zero.
>
> It seems only the below 64-bit arches define CONFIG_ILLEGAL_POINTER_VALUE
> through grepping:
> a29815a333c6 core, x86: make LIST_POISON less deadly
> 5c178472af24 riscv: define ILLEGAL_POINTER_VALUE for 64bit
> f6853eb561fb powerpc/64: Define ILLEGAL_POINTER_VALUE for 64-bit
> bf0c4e047324 arm64: kconfig: Move LIST_POISON to a safe value
>
> The below 64-bit arches don't seems to define the above config yet:
> MIPS64, SPARC64, System z(S390X),loongarch
>
> Does ID stashing cause problem for the above arches?

Well, not from a "number of bits available" perspective. In that case we
have plenty of bits, but we limit the size of the ID we stash to 32 bits
in all cases, so we will just end up with the 21 leading bits being
all-zero. So for those arches we basically end up in the same situation
as on 32-bit (see below).

>> serves this purpose. For 32-bit arches, we can leave the top-most bits
>> out of PP_MAGIC_MASK, to make sure that any valid pointer value will
>> fail the check above.
>
> The above mainly explained how to ensure page_pool_page_is_pp() will
> not return false positive result from the page_pool perspective.
>
> From MM/security perspective, most of the commits quoted above seem
> to suggest that poison pointer should be in the non-mmap'able or
> hardly-mmap'able space, otherwise userspace can arrange for those
> pointers to actually be dereferencable, potentially turning an oops
> to an expolit, more detailed example in the below paper, which explains
> how to exploit a vulnerability which hardened by the 8a5e5e02fc83 commit:
> https://www.usenix.org/system/files/conference/woot15/woot15-paper-xu.pdf
>
> ID stashing seems to cause page->lru.next (aliased to page->pp_magic) to
> be in the mmap'able space for some arches.

Right, okay, I see what you mean. So the risk is basically the
following:

If some other part of the kernel ends up dereferencing the
page->lru.next pointer of a page that is owned by page_pool, and which
has an ID stashed into page->pp_magic, that dereference can end up being
to a valid userspace mapping, which can lead to Bad Things(tm), cf the
paper above.

This is mitigated by the fact that it can only happen on architectures
that don't set ILLEGAL_POINTER_VALUE (which includes 32-bit arches, and
the ones you listed above). In addition, this has to happen while the
page is owned by page_pool, and while it is DMA-mapped - we already
clear the pp_magic field when releasing the page from page_pool.

I am not sure to what extent the above is a risk we should take pains to
avoid, TBH. It seems to me that for this to become a real problem, lots
of other things will already have gone wrong. But happy to defer to the
mm/security folks here.

>>> It seems it is not really only about kernel pointers as round_hint_to_m=
in()
>>> in mm/mmap.c suggests and the commit log in the above commit 8a5e5e02fc=
83
>>> if I understand it correctly:
>>> "Given unprivileged users cannot mmap anything below mmap_min_addr, it
>>> should be safe to use poison pointers lower than mmap_min_addr."
>>>
>>> And the above "making sure the top-most bit is always 0" doesn't seems =
to
>>> ensure page->signature to be outside the range used for kernel pointers
>>> for 32-bit arches with VMSPLIT_1G defined, see arch/arm/Kconfig, there
>>> is a similar config for x86 too:
>
> ...
>
>>=20
>> Ah, interesting, didn't know this was configurable. Okay, so AFAICT, the
>> lowest value of PAGE_OFFSET is 0x40000000 (for VMSPLIT_1G), so we need
>> to leave two bits off at the top instead of just one. Will update this,
>> and try to explain the logic better in the comment.
>
> It seems there was attempt of doing 4G/4G split too, and that is the kind
> of limitation or complexity added to the ARCH and MM subsystem by doing t=
he
> ID stashing I mentioned earlier.
> https://lore.kernel.org/lkml/Pine.LNX.4.44.0307082332450.17252-100000@loc=
alhost.localdomain/

Given that this is all temporary until the folio rework Matthew alluded
to is completed, I think that particular concern is somewhat theoretical :)

>>> IMHO, even if some trick like above is really feasible, it may be
>>> adding some limitation or complexity to the ARCH and MM subsystem, for
>>> example, stashing the ID in page->signature may cause 0x*40 signature
>>> to be unusable for other poison pointer purpose, it makes more sense to
>>> make it obvious by doing the above trick in some MM header file like
>>> poison.h instead of in the page_pool subsystem.
>>=20
>> AFAIU, PP_SIGNATURE is used for page_pool to be able to distinguish its
>> own pages from those allocated elsewhere (cf the description above).
>> Which means that these definitions are logically page_pool-internal, and
>> thus it makes the most sense to keep them in the page pool headers. The
>> only bits the mm subsystem cares about in that field are the bottom two
>> (for pfmemalloc pages and compound pages).
>
> All I asked is about moving PP_MAGIC_MASK macro into poison.h if you
> still want to proceed with reusing the page->pp_magic as the masking and
> the signature to be masked seems reasonable to be in the same file.

Hmm, my thinking was that this would be a lot of irrelevant stuff to put
into poison.h, but I suppose we could do so if the mm folks don't object :)

-Toke



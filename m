Return-Path: <netdev+bounces-17269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23060750F7D
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 19:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 580881C2117B
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 17:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBDA20F8F;
	Wed, 12 Jul 2023 17:19:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498BF14F74
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 17:19:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D484C433C8;
	Wed, 12 Jul 2023 17:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689182367;
	bh=B1zrVw53HP9fl1Bt8nVhkDzVX3NwiuI8wtKtFcXLGAQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FFqnCr+apZn/AdPHC7wYAfPXDMGTaESeG2TpTKs4LcmmUGghfe4XEJ3cPVlVgMTKB
	 ssizHfjmi3/8Rqrppm6kuEixPP/DuF/03VIZirEUwV0EMhFl1PckUsAU9Zb6o/bRoT
	 t5p14w1j2NAzfLyPqUuIr2bEIFbqOWbTsIFdnP5n4fLuLpgts4eIUhNOcEc22d1Fl1
	 AjHN9HEbTWzgOshRdoJ22Em3sWgPR4IFuyc+JfJ+eIiqlXxf6iULQtEXo5tq7bNKQs
	 DoMIfBA6LHCKM7Z39x2ESbuFQV3+jPbKgZHiZMcaRUiUJ9i1D5fDf9EhV7ViLWI4rm
	 3Qo+Pf1KJ2U3A==
Date: Wed, 12 Jul 2023 10:19:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc: brouer@redhat.com, netdev@vger.kernel.org, almasrymina@google.com,
 hawk@kernel.org, ilias.apalodimas@linaro.org, edumazet@google.com,
 dsahern@gmail.com, michael.chan@broadcom.com, willemb@google.com, Ulrich
 Drepper <drepper@redhat.com>
Subject: Re: [RFC 00/12] net: huge page backed page_pool
Message-ID: <20230712101926.6444c1cc@kernel.org>
In-Reply-To: <28bde9e2-7d9c-50d9-d26c-a3a9d37e9e50@redhat.com>
References: <20230707183935.997267-1-kuba@kernel.org>
	<1721282f-7ec8-68bd-6d52-b4ef209f047b@redhat.com>
	<20230711170838.08adef4c@kernel.org>
	<28bde9e2-7d9c-50d9-d26c-a3a9d37e9e50@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Jul 2023 16:00:46 +0200 Jesper Dangaard Brouer wrote:
> On 12/07/2023 02.08, Jakub Kicinski wrote:
> >> Generally the pp_provider's will have to use the refcnt schemes
> >> supported by page_pool.  (Which is why I'm not 100% sure this fits
> >> Mina's use-case).
> >>
> >> [IOTLB details]:
> >>
> >> As mentioned on [RFC 08/12] there are other techniques for reducing
> >> IOTLB misses, described in:
> >>    IOMMU: Strategies for Mitigating the IOTLB Bottleneck
> >>     - https://inria.hal.science/inria-00493752/document
> >>
> >> I took a deeper look at also discovered Intel's documentation:
> >>    - Intel virtualization technology for directed I/O, arch spec
> >>    -
> >> https://www.intel.com/content/www/us/en/content-details/774206/intel-v=
irtualization-technology-for-directed-i-o-architecture-specification.html
> >>
> >> One problem that is interesting to notice is how NICs access the packe=
ts
> >> via ring-queue, which is likely larger that number of IOTLB entries.
> >> Thus, a high change of IOTLB misses.  They suggest marking pages with
> >> Eviction Hints (EH) that cause pages to be marked as Transient Mappings
> >> (TM) which allows IOMMU to evict these faster (making room for others).
> >> And then combine this with prefetching. =20
> >=20
> > Interesting, didn't know about EH.
>=20
> I was looking for a way to set this Eviction Hint (EH) the article
> talked about, but I'm at a loss.

Could possibly be something that the NIC has to set inside the PCIe
transaction headers? Like the old cache hints that predated DDIO?

> >> In this context of how fast a page is reused by NIC and spatial
> >> locality, it is worth remembering that PP have two schemes, (1) the fa=
st
> >> alloc cache that in certain cases can recycle pages (and it based on a
> >> stack approach), (2) normal recycling via the ptr_ring that will have a
> >> longer time before page gets reused. =20
> >=20
> > I read somewhere that Intel IOTLB can be as small as 256 entries. =20
>=20
> Are IOTLB hardware different from the TLB hardware block?
>=20
> I can find data on TLB sizes, which says there are two levels on Intel,
> quote from "248966-Software-Optimization-Manual-R047.pdf":
>=20
>   Nehalem microarchitecture implements two levels of translation=20
> lookaside buffer (TLB). The first level consists of separate TLBs for=20
> data and code. DTLB0 handles address translation for data accesses, it=20
> provides 64 entries to support 4KB pages and 32 entries for large pages.
> The ITLB provides 64 entries (per thread) for 4KB pages and 7 entries=20
> (per thread) for large pages.
>=20
>   The second level TLB (STLB) handles both code and data accesses for=20
> 4KB pages. It support 4KB page translation operation that missed DTLB0=20
> or ITLB. All entries are 4-way associative. Here is a list of entries
> in each DTLB:
>=20
>   =E2=80=A2 STLB for 4-KByte pages: 512 entries (services both data and=20
> instruction look-ups).
>   =E2=80=A2 DTLB0 for large pages: 32 entries.
>   =E2=80=A2 DTLB0 for 4-KByte pages: 64 entries.
>=20
>   An DTLB0 miss and STLB hit causes a penalty of 7cycles. Software only=20
> pays this penalty if the DTLB0 is used in some dispatch cases. The=20
> delays associated with a miss to the STLB and PMH are largely nonblocking.

No idea :( This is an old paper from Rolf in his Netronome days which
says ~Sandy Bridge had only IOTLB 64 entries:

https://dl.acm.org/doi/pdf/10.1145/3230543.3230560

But it's a pretty old paper.

> > So it seems pretty much impossible for it to cache accesses to 4k
> > pages thru recycling. I thought that even 2M pages will start to
> > be problematic for multi queue devices (1k entries on each ring x
> > 32 rings =3D=3D 128MB just sitting on the ring, let alone circulation).
> >  =20
>=20
> Yes, I'm also worried about how badly these NIC rings and PP ptr_ring
> affects the IOTLB's ability to cache entries.  Why I suggested testing
> out the Eviction Hint (EH), but I have not found a way to use/enable
> these as a quick test in your environment.

FWIW the first version of the code I wrote actually had the coherent
ring memory also use the huge pages - the MEP allocator underlying the
page pool can be used by the driver directly to allocate memory for
other uses than the page pool.

But I figured that's going to be a nightmare to upstream, and Alex said
that even on x86 coherent DMA memory is just write combining not cached
(which frankly IDK why, possibly yet another thing we could consider
optimizing?!)

So I created two allocators, one for coherent (backed by 2M pages) and
one for non-coherent (backed by 1G pages).

For the ptr_ring I was considering bumping the refcount of pages
allocated from outside the 1G pool, so that they do not get recycled.
I deferred optimizing that until I can get some production results.
The extra CPU cost of loss of recycling could outweigh the IOTLB win.

All very exciting stuff, I wish the days were slightly longer :)


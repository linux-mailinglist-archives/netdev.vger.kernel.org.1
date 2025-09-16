Return-Path: <netdev+bounces-223439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3638B5922F
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 11:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 793901893BB7
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 09:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415A2299A90;
	Tue, 16 Sep 2025 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHNvd5va"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C19296BB8
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 09:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758014871; cv=none; b=eGBFaRs27cxljVE9RTHA4syJ7eNcK9mY2itsI/dFwf9ftUm67VI3QCkdgeifJaSv0kEsv973VQQuAaB2yxjmosAFGvymfEfCuLVj5EztucIj7KQzH5iC/WiNKlpHhhX2WrPEfSbrj8aVyHmv225klPtk6mAz+PwVIWG1aR068eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758014871; c=relaxed/simple;
	bh=f6Hkb2IbHXvzDMjazvLPUHVmBYT9BamRJ6xKHDHBWvo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EChVmycOVsG/807/Z/nAwNz6/auwQE8cBXj9dg4xZqF95WrVmm8tvQ5M+PR5P1gwGamJHPRn69UUHLhllMBv13Qmz9BGMMsxhMTdngMuCycUugWNf1hxV0R8pfcQaz7BpUVSHUwdoh6X/KtATET9VAXntKCvj4SAlbINgo5isbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bHNvd5va; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758014867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J59OiJgG+nalIV3FMKbGlZSlucF0/CWesH+hT77dSmU=;
	b=bHNvd5va2Q/W6oCEz782FceJgXN4pPmBlXu7Fr4BvSm8jXzyEdBkTMrKZEF7Rxd0D6s+qf
	1tncEbsdJ270rpzN2LCMjHZXQStrlHSWxUYVkx1Z4I1tVCqGkbmCCXaD982gwMYHExfY4L
	k8ZEqE0HmO8LG0BGNiTwxMrRnoiM1lE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-6A4X-VIpMyqW9Ik0ad80HA-1; Tue, 16 Sep 2025 05:27:46 -0400
X-MC-Unique: 6A4X-VIpMyqW9Ik0ad80HA-1
X-Mimecast-MFC-AGG-ID: 6A4X-VIpMyqW9Ik0ad80HA_1758014865
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-afe81959e5cso504884366b.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 02:27:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758014864; x=1758619664;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J59OiJgG+nalIV3FMKbGlZSlucF0/CWesH+hT77dSmU=;
        b=FNIuihMRfZVwoiZkx+iWwYWDfvubUrRGMjEQYGNVYroyuOWNvtg33xrg5L/89ASzxw
         DPFnw8Pi5uflbqNG+XZFq1J8vHS2soGwlkamZzOOnInW/ahYaX/yUh4dZ+/rcfh/uSIO
         pBLBlO2DP+tp5wlYutTU5IqDX/lF8/olBkLbnF9k/IpuiOYPhrsDNwpz9EQkyy9ecoFr
         bMW2ygNeboENsePBLNML0oLV+BsGv0ocl3hCW2PN1OafkjW8a2NrmKCOWeLcBJxESE/s
         m5XZr5Bfgp1C+GMrFo8V15P4k0TDWg8X1PSwmypO7yeR7PKDMts9EFs+R5wM6cHqQzdQ
         dnCw==
X-Forwarded-Encrypted: i=1; AJvYcCV+SOKitmBOozEunGo4FMM2HglxdjLcSEKDsTD96lJvmKaQ3xXams3ltDRjBZNZZi2y4F+hMFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YygRvzKu7xH6gUCjuyANKX+R2a5dmlxAhs7POCGnisWbdR3gr1b
	s1P1h/i0AzEenrT8IlYWSagq7UdCpWdb/d7B+f/F87GLnOyes0TclB1JnevJyIYtUlgKnZNEkVM
	p8NxTG933PxQHngWTiush5NzzZ4ZfQLtsXua2oh2C/Yp1uJWoKaPg92BWwA==
X-Gm-Gg: ASbGncvR36KHRcvf/is/D2VNBSYz2hpnQGGseCmZ28+ky1lA9gUB43r098fqAj44EOy
	Bqz1Bxj4OEtjVRxooI8OC+NqtIKNv+/5J/wO5ngaQ5MiQ0hIEroimMzSz2EdrtdapyoUC/HVxVw
	2fcEd5MpPa+Jg5QDPYQ50oCCFWyBeKlXfcTqY0YkNG0IVGpXoW+SO+qerxki//28q4X+uPlS5gU
	F2Nps3JcK2Gn4xNCfpPqN/SikuWEx4y7x4B29pA5uMWUVXGIFU6idhof+p1qofiEWIwZhBTcaEe
	1GtJveO8Qs4TmPM25/v1HNQ8a4Q2O8j6bFSh1T3DOd1JfwRfJBdupbOMVAzkn6vq
X-Received: by 2002:a17:906:b310:b0:b07:de2c:1268 with SMTP id a640c23a62f3a-b07de2c15famr931578866b.5.1758014864435;
        Tue, 16 Sep 2025 02:27:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGk1ALl6UsSbSFvHQ00Kgc7RvzsxEkP3PZF56LrtF0J0ob9LrtksUQ3RV5zpsIq7u1tOeNfbg==
X-Received: by 2002:a17:906:b310:b0:b07:de2c:1268 with SMTP id a640c23a62f3a-b07de2c15famr931576466b.5.1758014864011;
        Tue, 16 Sep 2025 02:27:44 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b333437bsm1107159566b.95.2025.09.16.02.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 02:27:43 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0EDB025C5AA; Tue, 16 Sep 2025 11:27:42 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Mina Almasry <almasrymina@google.com>, Helge Deller <deller@gmx.de>
Cc: Helge Deller <deller@kernel.org>, David Hildenbrand <david@redhat.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, "David S. Miller" <davem@davemloft.net>,
 Linux Memory Management List <linux-mm@kvack.org>, netdev@vger.kernel.org,
 Linux parisc List <linux-parisc@vger.kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH][RESEND][RFC] Fix 32-bit boot failure due inaccurate
 page_pool_page_is_pp()
In-Reply-To: <CAHS8izMjKub2cPa9Qqiga96XQ7piq3h0Vb_p+9RzNbBXXeGQrw@mail.gmail.com>
References: <aMSni79s6vCCVCFO@p100> <87zfawvt2f.fsf@toke.dk>
 <f64372ec-c127-457f-b8e2-0f48223bd147@gmx.de>
 <CAHS8izMjKub2cPa9Qqiga96XQ7piq3h0Vb_p+9RzNbBXXeGQrw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 16 Sep 2025 11:27:42 +0200
Message-ID: <87y0qerbld.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mina Almasry <almasrymina@google.com> writes:

> On Mon, Sep 15, 2025 at 6:08=E2=80=AFAM Helge Deller <deller@gmx.de> wrot=
e:
>>
>> On 9/15/25 13:44, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> > Helge Deller <deller@kernel.org> writes:
>> >
>> >> Commit ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap the=
m when
>> >> destroying the pool") changed PP_MAGIC_MASK from 0xFFFFFFFC to 0xc000=
007c on
>> >> 32-bit platforms.
>> >>
>> >> The function page_pool_page_is_pp() uses PP_MAGIC_MASK to identify pa=
ge pool
>> >> pages, but the remaining bits are not sufficient to unambiguously ide=
ntify
>> >> such pages any longer.
>> >
>> > Why not? What values end up in pp_magic that are mistaken for the
>> > pp_signature?
>>
>> As I wrote, PP_MAGIC_MASK changed from 0xFFFFFFFC to 0xc000007c.
>> And we have PP_SIGNATURE =3D=3D 0x40  (since POISON_POINTER_DELTA is zer=
o on 32-bit platforms).
>> That means, that before page_pool_page_is_pp() could clearly identify su=
ch pages,
>> as the (value & 0xFFFFFFFC) =3D=3D 0x40.
>> So, basically only the 0x40 value indicated a PP page.
>>
>> Now with the mask a whole bunch of pointers suddenly qualify as being a =
pp page,
>> just showing a few examples:
>> 0x01111040
>> 0x082330C0
>> 0x03264040
>> 0x0ad686c0 ....
>>
>> For me it crashes immediately at bootup when memblocked pages are handed
>> over to become normal pages.
>>
>
> I tried to take a look to double check here and AFAICT Helge is correct.
>
> Before the breaking patch with PP_MAGIC_MASK=3D=3D0xFFFFFFFC, basically
> 0x40 is the only pointer that may be mistaken as a valid pp_magic.
> AFAICT each bit we 0 in the PP_MAGIC_MASK (aside from the 3 least
> significant bits), doubles the number of pointers that can be mistaken
> for pp_magic. So with 0xFFFFFFFC, only one value (0x40) can be
> mistaken as a valid pp_magic, with  0xc000007c AFAICT 2^22 values can
> be mistaken as pp_magic?
>
> I don't know that there is any bits we can take away from
> PP_MAGIC_MASK I think? As each bit doubles the probablity :(
>
> I would usually say we can check the 3 least significant bits to tell
> if pp_magic is a pointer or not, but pp_magic is unioned with
> page->lru I believe which will use those bits.

So if the pointers stored in the same field can be any arbitrary value,
you are quite right, there is no safe value. The critical assumption in
the bit stuffing scheme is that the pointers stored in the field will
always be above PAGE_OFFSET, and that PAGE_OFFSET has one (or both) of
the two top-most bits set (that is what the VMSPLIT reference in the
comment above the PP_DMA_INDEX_SHIFT definition is alluding to).

The crash Helge reported obviously indicates that this assumption
doesn't hold. What I'd like to understand if whether this is because I
have completely misunderstood how things work, or whether it is only on
*some* 32-bit systems that this assumption on the range of kernel
pointers doesn't hold?

> AFAICT, only proper resolution I see is a revert of the breaking patch
> + reland after we can make pp a page-flag and deprecate using
> pp_magic. Sorry about that. Thoughts Toke? Anything better you can
> think of here?

We can just conditionally disable the tracking if we don't have enough
bits? Something like the below (which could maybe be narrowed down
further depending on the answer to my question above).

-Toke


diff --git i/include/linux/mm.h w/include/linux/mm.h
index 1ae97a0b8ec7..3e3b090104d9 100644
--- i/include/linux/mm.h
+++ w/include/linux/mm.h
@@ -4175,8 +4175,8 @@ int arch_lock_shadow_stack_status(struct task_struct =
*t, unsigned long status);
  */
 #define PP_DMA_INDEX_BITS MIN(32, __ffs(POISON_POINTER_DELTA) - PP_DMA_IND=
EX_SHIFT)
 #else
-/* Always leave out the topmost two; see above. */
-#define PP_DMA_INDEX_BITS MIN(32, BITS_PER_LONG - PP_DMA_INDEX_SHIFT - 2)
+/* Can't store the DMA index if we don't have a poison offset */
+#define PP_DMA_INDEX_BITS 0
 #endif
=20
 #define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_SHIFT -=
 1, \
diff --git i/net/core/netmem_priv.h w/net/core/netmem_priv.h
index cd95394399b4..afc5a56bba03 100644
--- i/net/core/netmem_priv.h
+++ w/net/core/netmem_priv.h
@@ -38,6 +38,7 @@ static inline void netmem_set_dma_addr(netmem_ref netmem,
=20
 static inline unsigned long netmem_get_dma_index(netmem_ref netmem)
 {
+#if PP_DMA_INDEX_BITS > 0
 	unsigned long magic;
=20
 	if (WARN_ON_ONCE(netmem_is_net_iov(netmem)))
@@ -46,11 +47,13 @@ static inline unsigned long netmem_get_dma_index(netmem=
_ref netmem)
 	magic =3D __netmem_clear_lsb(netmem)->pp_magic;
=20
 	return (magic & PP_DMA_INDEX_MASK) >> PP_DMA_INDEX_SHIFT;
+#endif
 }
=20
 static inline void netmem_set_dma_index(netmem_ref netmem,
 					unsigned long id)
 {
+#if PP_DMA_INDEX_BITS > 0
 	unsigned long magic;
=20
 	if (WARN_ON_ONCE(netmem_is_net_iov(netmem)))
@@ -58,5 +61,6 @@ static inline void netmem_set_dma_index(netmem_ref netmem,
=20
 	magic =3D netmem_get_pp_magic(netmem) | (id << PP_DMA_INDEX_SHIFT);
 	__netmem_clear_lsb(netmem)->pp_magic =3D magic;
+#endif
 }
 #endif
diff --git i/net/core/page_pool.c w/net/core/page_pool.c
index ba70569bd4b0..427fdf92b82c 100644
--- i/net/core/page_pool.c
+++ w/net/core/page_pool.c
@@ -495,6 +495,7 @@ static bool page_pool_dma_map(struct page_pool *pool, n=
etmem_ref netmem, gfp_t g
 		goto unmap_failed;
 	}
=20
+#if PP_DMA_INDEX_BITS > 0
 	if (in_softirq())
 		err =3D xa_alloc(&pool->dma_mapped, &id, netmem_to_page(netmem),
 			       PP_DMA_INDEX_LIMIT, gfp);
@@ -507,6 +508,7 @@ static bool page_pool_dma_map(struct page_pool *pool, n=
etmem_ref netmem, gfp_t g
 	}
=20
 	netmem_set_dma_index(netmem, id);
+#endif
 	page_pool_dma_sync_for_device(pool, netmem, pool->p.max_len);
=20
 	return true;
@@ -688,6 +690,7 @@ static __always_inline void __page_pool_release_netmem_=
dma(struct page_pool *poo
 		 */
 		return;
=20
+#if PP_DMA_INDEX_BITS > 0
 	id =3D netmem_get_dma_index(netmem);
 	if (!id)
 		return;
@@ -698,7 +701,7 @@ static __always_inline void __page_pool_release_netmem_=
dma(struct page_pool *poo
 		old =3D xa_cmpxchg_bh(&pool->dma_mapped, id, page, NULL, 0);
 	if (old !=3D page)
 		return;
-
+#endif
 	dma =3D page_pool_get_dma_addr_netmem(netmem);
=20
 	/* When page is unmapped, it cannot be returned to our pool */



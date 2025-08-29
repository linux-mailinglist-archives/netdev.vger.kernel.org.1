Return-Path: <netdev+bounces-218244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA443B3BA59
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 13:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDEAB1CC0FF7
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 11:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54652FC880;
	Fri, 29 Aug 2025 11:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WNUDebRf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC192FE07C
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 11:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756468652; cv=none; b=mcAMvEu5k75Nlg8XVZ2R9+kcFFFteGuZcJFgpXBuU8XzwbLHLl4DP7MWS+BHDWWwMT9bpXihiylcuafOqxDU/eJg4SdXmQaN4eEi3iCXxqqg56su0DtRQRDjMwtNeoAQsX8+GMNruJq0eWnUSzotpALDlYhpR2+oawAhCULuO8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756468652; c=relaxed/simple;
	bh=5Lp4Ng+SdyxZXZ9PSEkbl/hklhBiTxJ5cZJWR1+SKa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZKViXWkrmQZ0vpV2JlsP5pMUYKqgoXzavQ5RGd9DRen4gsQrN4Z9tMqyMFb9Sl7IcUetRQmwzU/WgfYa/TG5oQNk9m5oas4Dus3t9+bbru7aOyDpAbfSakns1OqXOwTjdEDZXMaWP3Yqu9vUfG15CgXN0MxEQiqqEEgNSW4G78g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WNUDebRf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756468649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hoDokfG1MQmzSDgEaptCicCjaaQpWxY2iqh8txE4sWo=;
	b=WNUDebRfNSHeOMmvbUJuY8y3p3G32ZuitizzR43nZsBipDvV/JarfsvJc3YXwMMhIFPhVf
	eRjZqcrHAcrTLu5NM1nC0CeX86hlF/kvQ+CR+GPH2pj6nuyLLbuYJ6VcgivC5g1KzL8cVy
	cKd0aUU/b/MmK+K8NS6xTv4maVBnCPg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-O4DZSn5JMSS29kicLc8gHA-1; Fri, 29 Aug 2025 07:57:27 -0400
X-MC-Unique: O4DZSn5JMSS29kicLc8gHA-1
X-Mimecast-MFC-AGG-ID: O4DZSn5JMSS29kicLc8gHA_1756468646
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b74ec7cd0so12904105e9.2
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 04:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756468646; x=1757073446;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hoDokfG1MQmzSDgEaptCicCjaaQpWxY2iqh8txE4sWo=;
        b=g3dW91kvsnrFsi9nX0F3F0ziwN7ivVie4eVmZ39AIsqsErJUdZZgcOuqsmaBxwlma4
         fuP6sryOnBTUKPNV0196L2EKJRLTkOC58znVYbllpO+VeZtOQEp1Z/koEYuwJUAdsoDk
         goXus45oiUPeUgq2EBiUUQCOl+Q260ituMhzwgeU+QJQnBIfIG7BdUYdlndobqh64rqD
         C2YeR1HgjKljmqdPL1yeO/lDaCytkeICt/cAXD6QJSS5X6KmTFxGNCQnFUkOkrTZ0u0n
         Yio0z45/KhgHO+nATfS49a4Ym9zS+asK4Cyl66uiIOvaVGZHkCfrbZ4gMZJKDrFamF2H
         Jm7A==
X-Forwarded-Encrypted: i=1; AJvYcCX1ZLRp1PBmFzuVh24XslRd+oxpFTbnqBGc+OqlhvVs17dMgTb5nbYvvZ5KKhabelZbFD/RO+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1R24hVCmC/nXu0/JCr/GGJyB80RICi06552e4DqdehWUaQRmo
	7Y8WZsU5Yapddc5ilGFzUoqT6CWtOOL1YlilRRvhsgW4QMSMUNTAMAT9UhT/91LoxThbhoXiUsL
	ECx6KgoSiHdnapWt7D9+8qJ1wBo4iWngV73871tfd4EmSY6adhxLldAI/sQ==
X-Gm-Gg: ASbGncu62Zr620C1xRokuK+bZxU9xKSQFXgzsWphsuMFgWTFNvevr/upYx7baRYw4uE
	oJWnnAaclG+OGOQ/UOhuy/c8HfuBdmYR1pcSkws4WcI4uJH42IQ38vrhODXkFs5GNVOM6cngt4p
	Dm0fHYPHp826zvnFbMvogLVmT0nDrLS2m3vsmVAA13WlZTssmmLwTKkkybp19vJ0x7B28tt0JG/
	ORUEf98MCJcaGusoIHAsCnrDi7lOQ2eS7BloCIA0iyLJ4WRHlHwnOoOyDurSzkf5QG3CvTHNS+k
	oyOVP9WYZgU5iJ15xVPzOp9m9oJfQd5+yKzsHbDcphe6DhsT8tOwKwW8BuTm7T6n4vJtNNcImru
	C/0b3lnwl3FCcx62MaP1HGcJuxnx//xBEYKqlfJ3SCxtCwjerHzeVdMyzk4CJTWM=
X-Received: by 2002:a05:600c:348d:b0:45b:80ab:3359 with SMTP id 5b1f17b1804b1-45b80ab35acmr15395115e9.0.1756468645784;
        Fri, 29 Aug 2025 04:57:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG95+220rsAfy23meKWNy4rnKbzYvRZ5zPoY4wdVrGBgRqoKPVywzJTjIuqBTuNai4wkDfQaw==
X-Received: by 2002:a05:600c:348d:b0:45b:80ab:3359 with SMTP id 5b1f17b1804b1-45b80ab35acmr15394435e9.0.1756468645290;
        Fri, 29 Aug 2025 04:57:25 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1d:100:4f8e:bb13:c3c7:f854? (p200300d82f1d01004f8ebb13c3c7f854.dip0.t-ipconnect.de. [2003:d8:2f1d:100:4f8e:bb13:c3c7:f854])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0c6b99sm116739135e9.4.2025.08.29.04.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 04:57:24 -0700 (PDT)
Message-ID: <eff8badd-0ddd-4a5f-a2ef-0e3ded39687a@redhat.com>
Date: Fri, 29 Aug 2025 13:57:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 11/36] mm: limit folio/compound page sizes in
 problematic kernel configs
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Alexander Potapenko <glider@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Brendan Jackman <jackmanb@google.com>, Christoph Lameter <cl@gentwo.org>,
 Dennis Zhou <dennis@kernel.org>, Dmitry Vyukov <dvyukov@google.com>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 iommu@lists.linux.dev, io-uring@vger.kernel.org,
 Jason Gunthorpe <jgg@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
 Johannes Weiner <hannes@cmpxchg.org>, John Hubbard <jhubbard@nvidia.com>,
 kasan-dev@googlegroups.com, kvm@vger.kernel.org,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-arm-kernel@axis.com,
 linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, Marco Elver <elver@google.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Michal Hocko <mhocko@suse.com>,
 Muchun Song <muchun.song@linux.dev>, netdev@vger.kernel.org,
 Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, Suren Baghdasaryan <surenb@google.com>,
 Tejun Heo <tj@kernel.org>, virtualization@lists.linux.dev,
 Vlastimil Babka <vbabka@suse.cz>, wireguard@lists.zx2c4.com, x86@kernel.org
References: <20250827220141.262669-1-david@redhat.com>
 <20250827220141.262669-12-david@redhat.com>
 <baa1b6cf-2fde-4149-8cdf-4b54e2d7c60d@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <baa1b6cf-2fde-4149-8cdf-4b54e2d7c60d@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.08.25 17:10, Lorenzo Stoakes wrote:
> On Thu, Aug 28, 2025 at 12:01:15AM +0200, David Hildenbrand wrote:
>> Let's limit the maximum folio size in problematic kernel config where
>> the memmap is allocated per memory section (SPARSEMEM without
>> SPARSEMEM_VMEMMAP) to a single memory section.
>>
>> Currently, only a single architectures supports ARCH_HAS_GIGANTIC_PAGE
>> but not SPARSEMEM_VMEMMAP: sh.
>>
>> Fortunately, the biggest hugetlb size sh supports is 64 MiB
>> (HUGETLB_PAGE_SIZE_64MB) and the section size is at least 64 MiB
>> (SECTION_SIZE_BITS == 26), so their use case is not degraded.
>>
>> As folios and memory sections are naturally aligned to their order-2 size
>> in memory, consequently a single folio can no longer span multiple memory
>> sections on these problematic kernel configs.
>>
>> nth_page() is no longer required when operating within a single compound
>> page / folio.
>>
>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Realy great comments, like this!
> 
> I wonder if we could have this be part of the first patch where you fiddle
> with MAX_FOLIO_ORDER etc. but not a big deal.

I think it belongs into this patch where we actually impose the 
restrictions.

[...]

>> +/*
>> + * Only pages within a single memory section are guaranteed to be
>> + * contiguous. By limiting folios to a single memory section, all folio
>> + * pages are guaranteed to be contiguous.
>> + */
>> +#define MAX_FOLIO_ORDER		PFN_SECTION_SHIFT
> 
> Hmmm, was this implicit before somehow? I mean surely by the fact as you say
> that physical contiguity would not otherwise be guaranteed :))

Well, my patches until this point made sure that any attempt to use a 
larger folio would fail in a way that we could spot now if there is any 
offender.

That is why before this change, nth_page() was required within a folio.

Hope that clarifies it, thanks!

-- 
Cheers

David / dhildenb



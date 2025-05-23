Return-Path: <netdev+bounces-192982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C1CAC1F21
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 11:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28AB850544F
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 09:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACECA2236F0;
	Fri, 23 May 2025 09:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d5Aaz3bF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127FA8F5C
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 09:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747990870; cv=none; b=pFxxaLUkIZU9wquqK/EEn7rd7KsFZDxE6XIawPYpjKxMYk+TNI5ISRC653s5nqXIYhI2NE31tX8ZhwuGW7tj8WcnbNHND5Ux9YeahjDSRG2x6ESGHPXcrxW0v+56Cul3JumjhH9HFU8pQPhYsCdSQ24xNB2PHtJDv81KG+edX/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747990870; c=relaxed/simple;
	bh=6AD71GZ1oJAgToKv63EU9Cvf388e1iJs65ueGm/PeYg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DP8rt6k24emsUIMRd2ZjWFGrbOxEpCRx/GWdzK4cqprGWOGPG8u1NO6GH/zt3dSHQtrZnfgWeobZfqvXzkALlE+NdGrDb6jQTBfSfgIGHUk1DgoeSF/RYSBY0JSax8Z9d5VB0PdHnHkwgLuXDpZuELsKoyrnT7DqI7KfMjqMPoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d5Aaz3bF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747990868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W9137AuC1JXl/uRnv3Q7irr3oyxG/GyI+XTAgsgelrk=;
	b=d5Aaz3bF4jDpd69DJVwXPTIb75s6NYnTkQbo8cAQXa+/spoVDGxvVNstZO0mzZDAWd6SlV
	sgAQMN5AVp3a1cMmhTJ1i/tGDJtsU1nJGWyb92zp1pV/Fzr4Aa7H3kGYJ1s/ea2vO/DxIt
	rk5K/46YR1KecPdLSOLiPfH2dAE+7nc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-qDRetYYdNhin2WRWbI_9fQ-1; Fri, 23 May 2025 05:01:05 -0400
X-MC-Unique: qDRetYYdNhin2WRWbI_9fQ-1
X-Mimecast-MFC-AGG-ID: qDRetYYdNhin2WRWbI_9fQ_1747990864
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-30d6a0309f6so50006691fa.2
        for <netdev@vger.kernel.org>; Fri, 23 May 2025 02:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747990864; x=1748595664;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W9137AuC1JXl/uRnv3Q7irr3oyxG/GyI+XTAgsgelrk=;
        b=qKWgDsCqbasbHEDeEFuoGKf0iClzvyd1Lkf7prnaYnrrY3IbprjWsuhBRsxGUDBEz1
         XbyI3e5WTsGe/IAPdDVNP5PVBTK6akW1fxGhlYfFIJQnrdTZ7bNe325oWH73Y3RKoimS
         15d4sSlcURmzW2d369zfRkwo1lOibUPiuWMC/mF4PA+NqAJrrPbqS+G/1/HRDU5h2M0B
         KMlSrrg/ZAmuqkgcLIEe8uxHSU4JnSL3ZD+aI6dbm7SmDutMP26fBSb6mbiwMHND3G1L
         fKAUuqXF3px5wtkWRmKiRVOdkq4NCNyHFATOOS6ZH2VAfIvW1JsDfA8+Vx4JFMxqg1hx
         iUsg==
X-Forwarded-Encrypted: i=1; AJvYcCXWfU2pASGNMJ46j/zfSc5dN5X0+llEQZtt3CTaYgQXSEZUTGaUlMS7uF6ddxtEPXkjpOH1PZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAjnrI1/ge5yjZnc60wwUsgm1zYM4taWbaeC+uLoNavvfvrwTV
	pRTTp+rROGWJ+U4R4496e7zO0AaaxfQaUBzeJoSvaKRMEYR7YlDYIWwKAJn+RIzPNIvfDqfEcer
	8nkhojhuKzFH5cdgGmPCrGGoc5imcnC7pXPOnHisC3ywSy+c4+G0ApRTN5Q==
X-Gm-Gg: ASbGncsiy4RbD1qbupiJ2RxkgszDPjy6EfRj2Rlxv8fbCAXtTnzxPmdqyb0wFtQ8rh2
	6kVHBfkzGLMIeMHvH39g+XkAIV3OiduLbWXR64voqPnYyU7jsUCi0bdW1rMimw3NXw/jDPzbp2e
	e/ShvKXBFAslH4B89wgzWvFcvqkoKlqZhU5TO+GNMO4/4U7dsuMe7o91FtRMPlB2EdvJomz8Fpq
	vDv4IaBMsLVZW3dsbkcN0G6F+w9zY+CVZ6FCJ78JDncWkfh36appXT23GB2ZDcw8aIniTQw9DXm
	VlI8L5D7
X-Received: by 2002:a05:6512:3d05:b0:549:4bf7:6463 with SMTP id 2adb3069b0e04-550e98ff25dmr10391816e87.44.1747990863817;
        Fri, 23 May 2025 02:01:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZQSs+uyNdVjrDhVHs2IglUPHTshvnWvanx+qtFny8cuAL31NdNk4CU+Vw4AmeBNf/utBp3w==
X-Received: by 2002:a05:6512:3d05:b0:549:4bf7:6463 with SMTP id 2adb3069b0e04-550e98ff25dmr10391773e87.44.1747990863352;
        Fri, 23 May 2025 02:01:03 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e703f606sm3782184e87.238.2025.05.23.02.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 02:01:02 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 957971AA3B8F; Fri, 23 May 2025 11:01:01 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, asml.silence@gmail.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
 leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Subject: Re: [PATCH 01/18] netmem: introduce struct netmem_desc
 struct_group_tagged()'ed on struct net_iov
In-Reply-To: <20250523032609.16334-2-byungchul@sk.com>
References: <20250523032609.16334-1-byungchul@sk.com>
 <20250523032609.16334-2-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 23 May 2025 11:01:01 +0200
Message-ID: <87bjrjn1ki.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Byungchul Park <byungchul@sk.com> writes:

> To simplify struct page, the page pool members of struct page should be
> moved to other, allowing these members to be removed from struct page.
>
> Introduce a network memory descriptor to store the members, struct
> netmem_desc, reusing struct net_iov that already mirrored struct page.
>
> While at it, relocate _pp_mapping_pad to group struct net_iov's fields.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  include/linux/mm_types.h |  2 +-
>  include/net/netmem.h     | 43 +++++++++++++++++++++++++++++++++-------
>  2 files changed, 37 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 56d07edd01f9..873e820e1521 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -120,13 +120,13 @@ struct page {
>  			unsigned long private;
>  		};
>  		struct {	/* page_pool used by netstack */
> +			unsigned long _pp_mapping_pad;
>  			/**
>  			 * @pp_magic: magic value to avoid recycling non
>  			 * page_pool allocated pages.
>  			 */
>  			unsigned long pp_magic;
>  			struct page_pool *pp;
> -			unsigned long _pp_mapping_pad;
>  			unsigned long dma_addr;
>  			atomic_long_t pp_ref_count;
>  		};

The reason that field is called "_pp_mapping_pad" is that it's supposed
to overlay the page->mapping field, so that none of the page_pool uses
set a value here. Moving it breaks that assumption. Once struct
netmem_desc is completely decoupled from struct page this obviously
doesn't matter, but I think it does today? At least, trying to use that
field for the DMA index broke things, which is why we ended up with the
bit-stuffing in pp_magic...

-Toke



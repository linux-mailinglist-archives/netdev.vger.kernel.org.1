Return-Path: <netdev+bounces-112346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FE0938631
	for <lists+netdev@lfdr.de>; Sun, 21 Jul 2024 23:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 523DAB20BD9
	for <lists+netdev@lfdr.de>; Sun, 21 Jul 2024 21:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D9AD529;
	Sun, 21 Jul 2024 21:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f571CSwt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2C8322E;
	Sun, 21 Jul 2024 21:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721598099; cv=none; b=jBQRJiml9xE124MITein3Mo5aGrR9I/yGCe7sZOl3cExLTlTPONuiXYI1bXyya12I9g1VhSRi15vveDdlIOvYQ0s3rOkS8lwjY9uiweeoKlFXTKnPpNNeKi3R3TySB2ynxQGvLin0uUAvtxCw+McJ/M5SHC454NRijfh92AR3SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721598099; c=relaxed/simple;
	bh=mAHzhjWbek3GgowqFLnchV5N8Qpm9WSixPjR+kltElc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jdoU5L3DNdzn/4AJixnpddvr//qen/2g57RhZIa2MuvtSe2R2Pel+e5ecIuzvZGWZOOQmly0Ms1QOm76aqnca+pPRGQAerZvunT4zGnSXnPUEF+H/ZQaGHEFLBG5u21vTL726OOEiJAGq7MJCG+0Gml7yQ62sX5jeOoUBUgB3Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f571CSwt; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3992f09efa7so6797425ab.2;
        Sun, 21 Jul 2024 14:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721598097; x=1722202897; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0nJBFOve/nzOSIc3tl9SNeSNgkEB09v1kPl4DmpsSPc=;
        b=f571CSwtVHJW9RZ0FfVBG67unwU3lp3quhQL1N8V2Qo6pE674AditzhtkSWRP9bupg
         9IE4umXJcPY8FdtL6TXXrdDVfigiYteZAwQWAcC+aHuZpj6no362vuOPfJDPk6e9S38r
         hmvXsD7nsXdF9SmWxgFoJZCHHekjKTUWFqEbsJandyAJPGKDIL3yRHZf2CnlBJ7nkfUN
         4eIzcDXsgEQ/JZCfT3dmV5hoTYVKYLNq1aLXGzOHtPLN3B3YadIsxwbLVN9bsL4I/pyQ
         9xsBB+0tMNhfxDyJE2mCRJZnuGRQ2ltfCXJwkQ2amoVkF5s3Ubd739I+WrNmrLm1nsqG
         M5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721598097; x=1722202897;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0nJBFOve/nzOSIc3tl9SNeSNgkEB09v1kPl4DmpsSPc=;
        b=wYsPVNIaoRSutTnH9yN6WJablr1UNXrvZIZWcQFWFDeX2IHXArpLMpI8Tuo2xtkc6C
         CXTlx797LDZnzXFtH9kB2cIvoEunQbFNy78FE+N8BxLsJp93MSnwjgjLWtEUU/3rNwKH
         xbPxsryHH5r1b664NUPB38+XekHE8/igWJXJlww4j+1RN3X1hJyCKTOfz9sFA9a6VbhP
         ute5ICKPsQjDtRqh28err6sSQrREETchgOhE4m1cJgNPnLm+VVrF/ZrXMCUk0MekitYF
         CliFZURERdaGjt2jM6Bw/Xuc9Kn3zTDboUacpL21+3qORHD+FeXljdZdybbwT32h/cnO
         hxMw==
X-Forwarded-Encrypted: i=1; AJvYcCXCCII98XVLmf6BCzfRqAVmd6vXRz5QOAI7fhlCsqFfCb7e+MKwFnjCBXqJo6oj50KfoKDwLKDFvezT+KFMogB+GVthGPXPHQMM6lUS
X-Gm-Message-State: AOJu0YyloFyUGq73qXe3nkPAaMdr7+Yw58bb94N3uj/837WAMdY9v1z0
	eIbpWzZhMZ/L8GmQtS9qr6KYwFXbDMEBL/rurynu1tnAq0wCidTN
X-Google-Smtp-Source: AGHT+IFPCrRoqgoOPxRC6ckPS8S/2QD5STC1qy8/ICCKYIJOKNY6tmwsfglePPXXZ9/QaoHcg71MmQ==
X-Received: by 2002:a05:6e02:1a88:b0:374:9916:92 with SMTP id e9e14a558f8ab-399403db700mr59896895ab.22.1721598096853;
        Sun, 21 Jul 2024 14:41:36 -0700 (PDT)
Received: from ?IPv6:2605:59c8:829:4c00:82ee:73ff:fe41:9a02? ([2605:59c8:829:4c00:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fd6f44e96csm40855585ad.216.2024.07.21.14.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 14:41:36 -0700 (PDT)
Message-ID: <e9982acd0eba5d06d178d0157aedfba569d5a09a.camel@gmail.com>
Subject: Re: [RFC v11 09/14] mm: page_frag: use __alloc_pages() to replace
 alloc_pages_node()
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org,  pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton
	 <akpm@linux-foundation.org>, linux-mm@kvack.org
Date: Sun, 21 Jul 2024 14:41:34 -0700
In-Reply-To: <20240719093338.55117-10-linyunsheng@huawei.com>
References: <20240719093338.55117-1-linyunsheng@huawei.com>
	 <20240719093338.55117-10-linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-07-19 at 17:33 +0800, Yunsheng Lin wrote:
> There are more new APIs calling __page_frag_cache_refill() in
> this patchset, which may cause compiler not being able to inline
> __page_frag_cache_refill() into __page_frag_alloc_va_align().
>=20
> Not being able to do the inlining seems to casue some notiable
> performance degradation in arm64 system with 64K PAGE_SIZE after
> adding new API calling __page_frag_cache_refill().
>=20
> It seems there is about 24Bytes binary size increase for
> __page_frag_cache_refill() and __page_frag_cache_refill() in
> arm64 system with 64K PAGE_SIZE. By doing the gdb disassembling,
> It seems we can have more than 100Bytes decrease for the binary
> size by using __alloc_pages() to replace alloc_pages_node(), as
> there seems to be some unnecessary checking for nid being
> NUMA_NO_NODE, especially when page_frag is still part of the mm
> system.
>=20
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  mm/page_frag_cache.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> index d9c9cad17af7..3f162e9d23ba 100644
> --- a/mm/page_frag_cache.c
> +++ b/mm/page_frag_cache.c
> @@ -59,11 +59,11 @@ static struct page *__page_frag_cache_refill(struct p=
age_frag_cache *nc,
>  #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>  	gfp_mask =3D (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
>  		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
> -	page =3D alloc_pages_node(NUMA_NO_NODE, gfp_mask,
> -				PAGE_FRAG_CACHE_MAX_ORDER);
> +	page =3D __alloc_pages(gfp_mask, PAGE_FRAG_CACHE_MAX_ORDER,
> +			     numa_mem_id(), NULL);
>  #endif
>  	if (unlikely(!page)) {
> -		page =3D alloc_pages_node(NUMA_NO_NODE, gfp, 0);
> +		page =3D __alloc_pages(gfp, 0, numa_mem_id(), NULL);
>  		if (unlikely(!page)) {
>  			memset(nc, 0, sizeof(*nc));
>  			return NULL;

So if I am understanding correctly this is basically just stripping the
checks that were being performed since they aren't really needed to
verify the output of numa_mem_id.

Rather than changing the code here, it might make more sense to update
alloc_pages_node_noprof to move the lines from
__alloc_pages_node_noprof into it. Then you could put the VM_BUG_ON and
warn_if_node_offline into an else statement which would cause them to
be automatically stripped for this and all other callers. The benefit
would likely be much more significant and may be worthy of being
accepted on its own merit without being a part of this patch set as I
would imagine it would show slight gains in terms of performance and
binary size by dropping the unnecessary instructions.


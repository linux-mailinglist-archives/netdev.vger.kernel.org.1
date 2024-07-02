Return-Path: <netdev+bounces-108548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 741A092426A
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 17:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C701CB23D8D
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 15:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DDB1BC06C;
	Tue,  2 Jul 2024 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQ+z8Zao"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B611BBBD8;
	Tue,  2 Jul 2024 15:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719934220; cv=none; b=M/PfSx9YQTSSZaL0FebcCm3r4HsdOgSkHBCujG0iH218WbSZBcCC0dqcwxcb28O1Du6Ok0Rd1LhT0wv0zWUMpoPIPNpdgR9Zm/fGacS+JqbBH+Ao9HLb9P/mBp+73GLk4ySiC5NZ7Q2M7i8FTGkwv7fWUO5uMJ3qxwIfcCO/xAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719934220; c=relaxed/simple;
	bh=SBpdP7VoWKn2/dU6E0nRIksvVLS5nXG9PQDxVWPP4x0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hYvZqiqaI+5mLyd+CpUiIp/0sHuKpSjE6cGQtO3aauwJ7lMwTQzZ2nqmZfeT/igDH4Kanqtt7pBeN9y1GHxpKQhNkFDf+x2OFn065Xl87uWhxERJux4kqHcqoQmwyLUFMa8GHbjlVml0mbkTnaOEbg8NO7ynvf4o4GNdzOaGWCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQ+z8Zao; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fa78306796so25795205ad.3;
        Tue, 02 Jul 2024 08:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719934218; x=1720539018; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9WziBX23oZK9QDnqDHzmJlEPl4STCd/KkEbB1uUJ7YU=;
        b=gQ+z8Zaoewf01UfXGDckGJScXiWJ+c58FjHpfY6PNVcyAhhPP35cUHmoWc818i3atI
         R27kVCQsS8hxddegARr+3GyW2+e/cLwXb0MTJOAmLQeTyeEqBjfiEvvTKV+ZjwffJA7e
         D5qJtfC9YL5O5W6FZJ8COSaR+u2SN7EHz9mLDfcdaPhnwE0gJxUH62R5kqpYJRAsLLq5
         LKlZzxu/G0vgGlrlE0cSRenM+GNAXEAG3Ag4nzcYfWCVmRpG6RLcRPmxPeZq13iQKo6j
         7j8f961fu1irYkQZSdvmFYc3rXVSuicPDhL2aB/Q+VjMcaA23t5Ey2ASowAzSNedCrbl
         4ihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719934218; x=1720539018;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9WziBX23oZK9QDnqDHzmJlEPl4STCd/KkEbB1uUJ7YU=;
        b=XQ1p0qT8HydLCtcR1tDkOxrH5i48VrEbgVpUcSacH4Czlr0o2RgaGAoj7EJvbniT/j
         FryOr3Q4DVQpwbIh1TkIJwMhu+UNFocsbw7IACh0j2f3k9hO6EZWFkSHRhj1MG7BDwSQ
         pqsKeatt+57ut9aD2L+mfLoVyTFRZobZSdUqgIRqNoTgujHASMCcLAbpIKPVl8qQTL1I
         nJrCwBst6pgC65t1Y1rumbLiaElBJZIz+Mcx3WayO5/a6yHBL7CfFbA7feJbyYZ1Oc0r
         yJ6fQ9TcNFhns76tToIR3Hd0TSbYVKDwb24X12jBMFtpamMnFpGsKfKwTzQcvynXydKR
         1ofw==
X-Forwarded-Encrypted: i=1; AJvYcCVl6UBIEudrtziIN6T+Y32wJOkBe3WXwsmvjIIbdtFWpJvqecScC8BN/R4wA8AkRqXdKXBqPV+cc16Md9Uo8aLh/9oaEwRn9lnGIDd0
X-Gm-Message-State: AOJu0YyV/5ub+4lZcmgjHf1mEt6k5UpKD5FdaXmiUKryihf7Awd6ONtc
	BYcR7clRGesRwobSLuzxU4QSbU/Kn2+Id4TS5as8jbSQj10LZI7E
X-Google-Smtp-Source: AGHT+IEo6xTMHEJQfZVZ4CqyWceq1noeoaurNROb6sO/XV/kvW5mqIJE7/2OugE/CjbTXef4Lhkx0g==
X-Received: by 2002:a17:903:32cb:b0:1f4:620b:6a27 with SMTP id d9443c01a7336-1fadbc5b950mr59205545ad.13.1719934217867;
        Tue, 02 Jul 2024 08:30:17 -0700 (PDT)
Received: from ?IPv6:2605:59c8:829:4c00:82ee:73ff:fe41:9a02? ([2605:59c8:829:4c00:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fac10e22c1sm85831715ad.72.2024.07.02.08.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 08:30:17 -0700 (PDT)
Message-ID: <ce969484bc8deee1438a019f19b97618937b0047.camel@gmail.com>
Subject: Re: [PATCH net-next v9 07/13] mm: page_frag: some minor refactoring
 before adding new API
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org,  pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton
	 <akpm@linux-foundation.org>, linux-mm@kvack.org
Date: Tue, 02 Jul 2024 08:30:16 -0700
In-Reply-To: <20240625135216.47007-8-linyunsheng@huawei.com>
References: <20240625135216.47007-1-linyunsheng@huawei.com>
	 <20240625135216.47007-8-linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-25 at 21:52 +0800, Yunsheng Lin wrote:
> Refactor common codes from __page_frag_alloc_va_align()
> to __page_frag_cache_refill(), so that the new API can
> make use of them.
>=20
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>

I am generally not a fan of the concept behind this patch. I really
think we should keep the page_frag_cache_refill function to just
allocating the page, or in this case the encoded_va and populating only
that portion of the struct.

> ---
>  mm/page_frag_cache.c | 61 ++++++++++++++++++++++----------------------
>  1 file changed, 31 insertions(+), 30 deletions(-)
>=20
> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> index a3316dd50eff..4fd421d4f22c 100644
> --- a/mm/page_frag_cache.c
> +++ b/mm/page_frag_cache.c
> @@ -29,10 +29,36 @@ static void *page_frag_cache_current_va(struct page_f=
rag_cache *nc)
>  static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
>  					     gfp_t gfp_mask)
>  {
> -	struct page *page =3D NULL;
> +	struct encoded_va *encoded_va =3D nc->encoded_va;
>  	gfp_t gfp =3D gfp_mask;
>  	unsigned int order;
> +	struct page *page;
> +
> +	if (unlikely(!encoded_va))
> +		goto alloc;
> +
> +	page =3D virt_to_page(encoded_va);
> +	if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
> +		goto alloc;
> +
> +	if (unlikely(encoded_page_pfmemalloc(encoded_va))) {
> +		VM_BUG_ON(compound_order(page) !=3D
> +			  encoded_page_order(encoded_va));
> +		free_unref_page(page, encoded_page_order(encoded_va));
> +		goto alloc;
> +	}
> +
> +	/* OK, page count is 0, we can safely set it */
> +	set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);

Why not just make this block of code a function onto itself? You put an
if statement at the top that essentially is just merging two functions
into one. Perhaps this logic could be __page_frag_cache_recharge which
would return an error if the page is busy or the wrong type. Then
acting on that you could switch to the refill attempt.

Also thinking about it more the set_page_count in this function and
page_ref_add in the other can probably be merged into the recharge and
refill functions since they are acting directly on the encoded page and
not interacting with the other parts of the page_frag_cache.

> +
> +	/* reset page count bias and remaining of new frag */
> +	nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
> +	nc->remaining =3D page_frag_cache_page_size(encoded_va);

These two parts are more or less agnostic to the setup and could be
applied to refill or recharge. Also one thought occurs to me. You were
encoding "order" into the encoded VA. Why use that when your choices
are either PAGE_FRAG_CACHE_MAX_SIZE or PAGE_SIZE. It should be a single
bit and doesn't need to be a fully byte to store that. That would allow
you to reduce this down to just 2 bits, one for pfmemalloc and one for
max order vs order 0.

> +
> +	return page;
> =20
> +alloc:
> +	page =3D NULL;
>  #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>  	gfp_mask =3D (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
>  		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
> @@ -89,40 +115,15 @@ void *__page_frag_alloc_va_align(struct page_frag_ca=
che *nc,
>  				 unsigned int fragsz, gfp_t gfp_mask,
>  				 unsigned int align_mask)
>  {
> -	struct encoded_va *encoded_va =3D nc->encoded_va;
> -	struct page *page;
> -	int remaining;
> +	int remaining =3D nc->remaining & align_mask;
>  	void *va;
> =20
> -	if (unlikely(!encoded_va)) {
> -refill:
> -		if (unlikely(!__page_frag_cache_refill(nc, gfp_mask)))
> -			return NULL;
> -
> -		encoded_va =3D nc->encoded_va;
> -	}
> -
> -	remaining =3D nc->remaining & align_mask;
>  	remaining -=3D fragsz;
>  	if (unlikely(remaining < 0)) {

I see, so this is why you were using the memset calls everywhere.

> -		page =3D virt_to_page(encoded_va);
> -		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
> -			goto refill;
> -
> -		if (unlikely(encoded_page_pfmemalloc(encoded_va))) {
> -			VM_BUG_ON(compound_order(page) !=3D
> -				  encoded_page_order(encoded_va));
> -			free_unref_page(page, encoded_page_order(encoded_va));
> -			goto refill;
> -		}
> -
> -		/* OK, page count is 0, we can safely set it */
> -		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
> +		if (unlikely(!__page_frag_cache_refill(nc, gfp_mask)))
> +			return NULL;
> =20
> -		/* reset page count bias and remaining of new frag */
> -		nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
> -		nc->remaining =3D remaining =3D page_frag_cache_page_size(encoded_va);
> -		remaining -=3D fragsz;
> +		remaining =3D nc->remaining - fragsz;
>  		if (unlikely(remaining < 0)) {
>  			/*
>  			 * The caller is trying to allocate a fragment




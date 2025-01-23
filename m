Return-Path: <netdev+bounces-160636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30875A1AA2A
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 20:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA8461887558
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 19:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF151ADC85;
	Thu, 23 Jan 2025 19:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OLIupzOM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6521ADC7D
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 19:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737659746; cv=none; b=Jgc4W1jzdQzE0ILNQqT6sO7c4UdV8odtL+e8Lrvw8KJV9B+60kAE5fg3x8JehHyMcZgOkyyYFJQHa+uFW94tLot8GLqsm9NuAlDivbrwiGwnZ6FWls3UzJelCtqka88+XcK0DVxezTbON8ugrZ2FNhtTb26U3H0M2bV4BOjhYC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737659746; c=relaxed/simple;
	bh=kRRt54FiAehiQzMiLPRm46XON0PG/b3TG8LSRhcZfG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nVx7bfXP1i2tMUyN/tAwGTQKHuPlItYIOmxP3I83T11UcjaD1qsjsBzt00yj2NVy93icAcaCSiFTjEteuFquf/g2Y9ZcDCMW20BSWlvDhUtNIgkDgNYEi+mudy314XRU7YqSnHYOeWm+HCu839qfxk2Ht6vS1313YHQLnEM1ooo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OLIupzOM; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-29fb532b668so511033fac.0
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 11:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737659742; x=1738264542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HnJvSTVR0fS0wa+dUqbJdWCgGezng9ZoAaMMJSy6tf8=;
        b=OLIupzOMe3Tr170fU4N2LFlTTAwNXAuS4M6Ube3WcY/+ULESwhHkJCPJ0ynbYDlmLL
         IElNc1dEUu/XpiEDzYZsHV7eYilKfF3/uUTz92BeYr5iK5AUMXV5vUIvvEuc+wvI/IhJ
         xHCKF03DgekNoqiWRGDtv4wmxAssRV+t6ao1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737659742; x=1738264542;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnJvSTVR0fS0wa+dUqbJdWCgGezng9ZoAaMMJSy6tf8=;
        b=mVKLOOAs3R6qTL5Ik9g4VIOXbrGSbJVL3DXpeuqlO2Y7XK+4wJ+b5FGZ/HBoiAQcPi
         KRg6eEXQoG9RnNUijjam6ngO97gaTyqIvbhUoCcJySJFBr1VbfPzDk9AlC1X6biIlCKv
         ybVFuzW4ffebP2nYhpf43phz6SxS5InYRfad5xv1X3dc2ytFpvtHFOv/WsFYIipjsK51
         STh7EeV4uKatfZMhxuwruLmI00+78fBrQdelJvXEOP4yEsPIJvBnAVrbLU6z67uLc7+q
         8g+39eZmRudQOPc1veRRqi8qFrO1iMwzU/HcMVdI0E+65qGkR8o3QlCC5wHVk53r2K7s
         7hEg==
X-Gm-Message-State: AOJu0YzU/ooelrIzuDFDcKBfrJtBkkQtYsZMsryuIMPdx6Q+D2z6umnU
	hQZX7OgEtepN4jRKoDrYTt7UKZY3ijOJyqle8y0gY/aW9jxzkRiyGXHa0CrBOg==
X-Gm-Gg: ASbGncs8v7kJBnYaBrXbXikNzDJ5/IW+0NtLuNyKPQWs9hqM0NL/asKbcNfyQuVUcSI
	vx4t/cgsIJq8wr6EpyoyjiLAHPu3Mwkyjlbs2fQXAdhxEEm5YRSZSHIB9eNly6s2+OtEZdZYook
	MMscRD8xmnXo5BKXD62Pt33KgdunN6bcZ8m3DScYw1c8nUdXRHTOT+tU5+1rZlZMU6RpV4Qu3TC
	whDE2DkcDO3j/4/iSiAI6yKXM0O/ugI/S4JisOI9/Vge/uoX6ELUXFZFSK4p1jQzpqmsPoeONMd
	RABhPtnACzdW2oZrMGYm+dGY5/oAEHMqH1npXPXd6DAK
X-Google-Smtp-Source: AGHT+IHIVxKAgSqXn2eM0iDzQzIQA25Ho3Dn76vYa+h95i5hEpcxeTfnY+Civ4sgq1HbMHAC/O8daA==
X-Received: by 2002:a05:6871:691:b0:29e:80d8:31a9 with SMTP id 586e51a60fabf-2b1c08255c9mr16230341fac.2.1737659742090;
        Thu, 23 Jan 2025 11:15:42 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b28f48b2f4sm131010fac.45.2025.01.23.11.15.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 11:15:41 -0800 (PST)
Message-ID: <2ef8b7d4-7fae-4a08-9db1-4a33cd56ec9c@broadcom.com>
Date: Thu, 23 Jan 2025 11:15:39 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v23 3/7] mm: page_frag: use initial zero offset
 for page_frag_alloc_align()
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexander Duyck <alexander.duyck@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Linux-MM <linux-mm@kvack.org>,
 Alexander Duyck <alexanderduyck@fb.com>
References: <20241028115343.3405838-1-linyunsheng@huawei.com>
 <20241028115343.3405838-4-linyunsheng@huawei.com>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20241028115343.3405838-4-linyunsheng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Yunsheng,

On 10/28/24 04:53, Yunsheng Lin wrote:
> We are about to use page_frag_alloc_*() API to not just
> allocate memory for skb->data, but also use them to do
> the memory allocation for skb frag too. Currently the
> implementation of page_frag in mm subsystem is running
> the offset as a countdown rather than count-up value,
> there may have several advantages to that as mentioned
> in [1], but it may have some disadvantages, for example,
> it may disable skb frag coalescing and more correct cache
> prefetching
> 
> We have a trade-off to make in order to have a unified
> implementation and API for page_frag, so use a initial zero
> offset in this patch, and the following patch will try to
> make some optimization to avoid the disadvantages as much
> as possible.
> 
> 1. https://lore.kernel.org/all/f4abe71b3439b39d17a6fb2d410180f367cadf5c.camel@gmail.com/
> 
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: Linux-MM <linux-mm@kvack.org>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>

Sorry for the late feedback, this patch causes the bgmac driver in is 
.ndo_open() function to return -ENOMEM, the call trace looks like this:

  bgmac_open
   -> bgmac_dma_init
     -> bgmac_dma_rx_skb_for_slot
       -> netdev_alloc_frag

BGMAC_RX_ALLOC_SIZE = 10048 and PAGE_FRAG_CACHE_MAX_SIZE = 32768.

Eventually we land into __page_frag_alloc_align() with the following 
parameters across multiple successive calls:

__page_frag_alloc_align: fragsz=10048, align_mask=-1, size=32768, offset=0
__page_frag_alloc_align: fragsz=10048, align_mask=-1, size=32768, 
offset=10048
__page_frag_alloc_align: fragsz=10048, align_mask=-1, size=32768, 
offset=20096
__page_frag_alloc_align: fragsz=10048, align_mask=-1, size=32768, 
offset=30144

So in that case we do indeed have offset + fragsz (40192) > size (32768) 
and so we would eventually return NULL.

Any idea on how to best fix that within the bgmac driver?

Thanks!

> ---
>   mm/page_frag_cache.c | 46 ++++++++++++++++++++++----------------------
>   1 file changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> index 609a485cd02a..4c8e04379cb3 100644
> --- a/mm/page_frag_cache.c
> +++ b/mm/page_frag_cache.c
> @@ -63,9 +63,13 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
>   			      unsigned int fragsz, gfp_t gfp_mask,
>   			      unsigned int align_mask)
>   {
> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> +	unsigned int size = nc->size;
> +#else
>   	unsigned int size = PAGE_SIZE;
> +#endif
> +	unsigned int offset;
>   	struct page *page;
> -	int offset;
>   
>   	if (unlikely(!nc->va)) {
>   refill:
> @@ -85,11 +89,24 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
>   		/* reset page count bias and offset to start of new frag */
>   		nc->pfmemalloc = page_is_pfmemalloc(page);
>   		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
> -		nc->offset = size;
> +		nc->offset = 0;
>   	}
>   
> -	offset = nc->offset - fragsz;
> -	if (unlikely(offset < 0)) {
> +	offset = __ALIGN_KERNEL_MASK(nc->offset, ~align_mask);
> +	if (unlikely(offset + fragsz > size)) {
> +		if (unlikely(fragsz > PAGE_SIZE)) {
> +			/*
> +			 * The caller is trying to allocate a fragment
> +			 * with fragsz > PAGE_SIZE but the cache isn't big
> +			 * enough to satisfy the request, this may
> +			 * happen in low memory conditions.
> +			 * We don't release the cache page because
> +			 * it could make memory pressure worse
> +			 * so we simply return NULL here.
> +			 */
> +			return NULL;
> +		}
> +
>   		page = virt_to_page(nc->va);
>   
>   		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
> @@ -100,33 +117,16 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
>   			goto refill;
>   		}
>   
> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> -		/* if size can vary use size else just use PAGE_SIZE */
> -		size = nc->size;
> -#endif
>   		/* OK, page count is 0, we can safely set it */
>   		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
>   
>   		/* reset page count bias and offset to start of new frag */
>   		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
> -		offset = size - fragsz;
> -		if (unlikely(offset < 0)) {
> -			/*
> -			 * The caller is trying to allocate a fragment
> -			 * with fragsz > PAGE_SIZE but the cache isn't big
> -			 * enough to satisfy the request, this may
> -			 * happen in low memory conditions.
> -			 * We don't release the cache page because
> -			 * it could make memory pressure worse
> -			 * so we simply return NULL here.
> -			 */
> -			return NULL;
> -		}
> +		offset = 0;
>   	}
>   
>   	nc->pagecnt_bias--;
> -	offset &= align_mask;
> -	nc->offset = offset;
> +	nc->offset = offset + fragsz;
>   
>   	return nc->va + offset;
>   }


-- 
Florian


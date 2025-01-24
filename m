Return-Path: <netdev+bounces-160842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C9EA1BC83
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 19:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95AA81883820
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 18:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F222248AC;
	Fri, 24 Jan 2025 18:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hKUKSRjq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DF31D54D8
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 18:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737744928; cv=none; b=n++M8JQdNCTdI6JfLjpvFgsh7FM/cHcbsyOmpHuGpYnTer72I6nGN/Lw/r4VI3+tYOLFAAxiwwH+9jEaGJ7u8/QGY5L9de9F6nJOeNhnwB2SStQoJ3Y0DrX/DcRxD4nvPL2xf4Q5z979ndiL4TSNQtpfixXxJvFS/FMvfphgKbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737744928; c=relaxed/simple;
	bh=2qe6Qb0Z9UOJ4lSuhRpQUQvF0J1wYewJ2oQiAd3ZUqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fbd7CnAMxg7YSNlCCLZH1vK8Z+nhGoX53FFxUYCQN/PH+gWJeMf+6OXgY8/shiRtiOzyC1QSzG/bzdmqEsLwXTif/8lRtKz2OPyuouGiRMwkWrfrELXUIFf7GDgwNUgWxpGsQehRFXx/34N5tz5YvuhzvfvVBEDetusoK808mOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hKUKSRjq; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3eb9101419cso1480383b6e.0
        for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 10:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737744926; x=1738349726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p/AsADTBfGWUpUUArfkz8RqP+OWTJhAps4ZyikpDhAs=;
        b=hKUKSRjqYc+3Lcz3aE68sEP8JMBgZxN+pvrP9kvwwmrGQi7TqRPtZj4QmTS1mx0LRL
         oZyzD/i2CDZNlNGVOFiBk6B5EOdky/7TYbQZ6YMwacfeqtA/bbUncn50zwrl1YNzfi9n
         AcgRrL9EQ2ExIj/qtvpjeAXxLSin3MgeNYjec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737744926; x=1738349726;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/AsADTBfGWUpUUArfkz8RqP+OWTJhAps4ZyikpDhAs=;
        b=mwUN8Pb3mh96Q5NuhGmkwBcp3uTCAL5fv8ggcO9hCNJXjA8qwGPKQl2yG2EyaGkuZG
         JmT6q/yL734hYRi2kNgHAMB53Etag9MNjGqlYrRhUWuaERCUuH/sIlxT3uJRmulqLw+b
         SipcbNbmAzxCaxN3+D63XuH0G2L8vtF8JDGYNcrXy7uuheC3HdUfe6Y/+RYOEZ6F4JRy
         3JACKcaEsGFdfPmxf8gOkOzfumHebShBS+XO9SGLNooV7PUimar08kj3WUONww9EnkOE
         6B8lyRs7eNQXvJTakFcgDJ/MGaF0vM7/rD5UOnhu/SjEG7gZEfzlt8DXx6yFckNeWLnV
         2QdA==
X-Gm-Message-State: AOJu0Yx0aM+wAty/7BPUO11BsYYXxlU1NTmsRwzwUYWBq3i5zTkkdVwS
	NoNM3VLNEXGxo9/jYLNbibML3dMGjYHLjyPzdPM2trM90JkoSTWOMTo0MP2vSg==
X-Gm-Gg: ASbGncsOvq/WOH7zT1Ar6wEeNndSmIVDbGMlRg0afyWCdTZxq+/bZBJO2FqFxPba1Oc
	dg7DeYekZ4lh7134AdHkwlc5sncR5e82dWJNnPUsLW6soSPlLUmyDWAqruIa4c/Upz5615kUmEJ
	6O9JqR37qOxh0loxL82kslk2rN/KzpUTw5YE51eWShtwOLRORcrHuDTW3OQ/LaW56oo+BqGXaEA
	vIXEvAR59YOCh/vK26vOa3PnLCFOuLse5vR5IxILorgktb4ZgeQwy1noB9fs7Xd5IJC4LtkDAOL
	dcEORWQFixPWchW+l3b3RUo/csUvXuBssfSyCuU58y+L
X-Google-Smtp-Source: AGHT+IFNofcV4cIdaVI+zk5heo0JWzhvbLoBns5GzokoyEGNl6Aao5MsDKKZo+urWMsRTfyl8JW9Qg==
X-Received: by 2002:a05:6808:11d1:b0:3e7:a15c:467b with SMTP id 5614622812f47-3f19fcda5e6mr21223232b6e.34.1737744926010;
        Fri, 24 Jan 2025 10:55:26 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f1f085eab5sm552257b6e.1.2025.01.24.10.55.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 10:55:24 -0800 (PST)
Message-ID: <371240e0-5f95-4d5b-9eea-9029e5dcb4b1@broadcom.com>
Date: Fri, 24 Jan 2025 10:55:22 -0800
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
 <2ef8b7d4-7fae-4a08-9db1-4a33cd56ec9c@broadcom.com>
 <ead00fb7-8538-45b3-8322-8a41386e7381@huawei.com>
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
In-Reply-To: <ead00fb7-8538-45b3-8322-8a41386e7381@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/24/25 01:52, Yunsheng Lin wrote:
> On 2025/1/24 3:15, Florian Fainelli wrote:
>>
>> Sorry for the late feedback, this patch causes the bgmac driver in is .ndo_open() function to return -ENOMEM, the call trace looks like this:
> 
> Hi, Florian
> Thanks for the report.
> 
>>
>>   bgmac_open
>>    -> bgmac_dma_init
>>      -> bgmac_dma_rx_skb_for_slot
>>        -> netdev_alloc_frag
>>
>> BGMAC_RX_ALLOC_SIZE = 10048 and PAGE_FRAG_CACHE_MAX_SIZE = 32768.
> 
> I guess BGMAC_RX_ALLOC_SIZE being bigger than PAGE_SIZE is the
> problem here, as the frag API is not really supporting allocating
> fragment that is bigger than PAGE_SIZE, as it will fall back to
> allocate the base page when order-3 compound page allocation fails,
> see __page_frag_cache_refill().
> 
> Also, it seems strange that bgmac driver seems to always use jumbo
> frame size to allocate fragment, isn't more  appropriate to allocate
> the fragment according to MTU?

Totally, even though my email domain would suggest otherwise, I am just 
an user of that driver here, not its maintainer, though I do have some 
familiarity with it, I don't know why that choice was made.

> 
>>
>> Eventually we land into __page_frag_alloc_align() with the following parameters across multiple successive calls:
>>
>> __page_frag_alloc_align: fragsz=10048, align_mask=-1, size=32768, offset=0
>> __page_frag_alloc_align: fragsz=10048, align_mask=-1, size=32768, offset=10048
>> __page_frag_alloc_align: fragsz=10048, align_mask=-1, size=32768, offset=20096
>> __page_frag_alloc_align: fragsz=10048, align_mask=-1, size=32768, offset=30144
>>
>> So in that case we do indeed have offset + fragsz (40192) > size (32768) and so we would eventually return NULL.
> 
> It seems the changing of '(unlikely(offset < 0))' checking to
> "fragsz > PAGE_SIZE" causes bgmac driver to break more easily
> here. But bgmac driver might likely break too if the system
> memory is severely fragmented when falling back to alllocate
> base page before this patch.
> 
>>
>> Any idea on how to best fix that within the bgmac driver?
> 
> Maybe use the page allocator API directly when allocating fragment
> with BGMAC_RX_ALLOC_SIZE > PAGE_SIZE for a quick fix.
> 
> In the long term, maybe it makes sense to use the page_pool API
> as more drivers are converting to use page_pool API already.

Short term, I think I am going to submit a quick fix that is inspired by 
the out of tree patches carried in OpenWrt:

https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=target/linux/bcm53xx/patches-6.6/700-bgmac-reduce-max-frame-size-to-support-just-MTU-1500.patch;h=3a2f4b06ed6d8cda1f3f0be23e1066267234766b;hb=HEAD

Thanks!
-- 
Florian


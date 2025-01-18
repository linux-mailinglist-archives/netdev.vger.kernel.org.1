Return-Path: <netdev+bounces-159563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC99A15D34
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 14:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCAA21633AF
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 13:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D933C18C00B;
	Sat, 18 Jan 2025 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQ/4xIuJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF8A185B6B;
	Sat, 18 Jan 2025 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737207423; cv=none; b=nt5nC2V62SDyBqI+C+qDQqq+8dGrFHyL5/Uvs2em/DbdUUwyr2SsyvIr5b4LDToxu9hmVUO9RX2vE2u/c1O3eBlxFxEeaK1PAP3AiLw9D/XZvoAxvEFlK4IJOq2+BnJg3GpPUgs1eEBlW2uuZ1uyGVHT7q+CeOE0OTXSF2TzUPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737207423; c=relaxed/simple;
	bh=dfkCDEjreWc0tw7VC3I2BHlPVozZjZ/VrjMc8whqjno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ms2pVaTOaWsPoAmhcn2+tMqucO3FWGGpugRhqJNgcWfOEN9u/ZgksTlc4WReOFBWRrcPUdY6Dv6c0vqYgtO5+k1TpsN3bDwds+AwoDVrZTVrNpDA2KbykDKqdH9Evq5vKvOT0p+CDx66JtRC1NlZGVTkUiCS8DLZtV8dvGhV9nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQ/4xIuJ; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-21636268e43so71463625ad.2;
        Sat, 18 Jan 2025 05:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737207422; x=1737812222; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fl7q3Ow0SI/mPnfg6y3Pb7fNtW/ik4Ugk2pGzG5GGpY=;
        b=PQ/4xIuJdwVkccnSwuilBYfJT/XkKS+c72M+WPyYeORFtiiZLe+g/IpnIIUNuveri1
         MzhOGSbTX1Xb4riLdTy3CLn7d2TQDmo1gfvKTu4Z1aWOHJrYVeO3cicQr3zrGkyze4Hs
         WoO8XY1Wh6dEr6I9L5slXfuQ+ZCpce1DzvWC1ucot+T1CvZGLob0OF2REZW7cTmbzJVU
         HwBUozkF5VHOqLIM7jbnP6UoGk26KWrvVo3vZ6rkCBjqqE7z9gsnS3/TiCMXO8Vi9wcx
         0T12v5AQ7ZxDNrcYxh21VPv71or0EMjfuEKpNVgO3x3Xgud8+gWgA1MRLwc/BZkC1IXM
         1i5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737207422; x=1737812222;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fl7q3Ow0SI/mPnfg6y3Pb7fNtW/ik4Ugk2pGzG5GGpY=;
        b=F4QbbrLS8HMeiqOa9u3fWUFU1Dm6EnVywK4eaFU76U+2A/ztJDtZQmb1UzL7bYno5F
         GfqiTOvXVx5JiZme9J14zc5ufm3TQJdsydySrncWx/+dEJnqLgVn38yHDGKVBhHqVblg
         HDyXR5aiOJrKH0NAhYktifL7ThZOvjVxkQ/BN1yoI0xZHjtWzQTwzI+HirnGLrWlG1lU
         f8jKQKJvuMqH1xfTjupdJkczUQWe/9D9921tNy8MLBhFuDdwbtVqolYXUk+RGXq4j9nO
         SUNng04awYqQWXrm1b2dvcrKD+P9CzpVM8qXH1/ka6ITkYxzZSC9j2BW6IkGGHvxGhzu
         FH5g==
X-Forwarded-Encrypted: i=1; AJvYcCUrZkjzQ3/OPRlBnmrsPKy8qVRoVCvLRLMNKAOWZZCuKj70lyRyE9BvND4PabjrebCwA4IW7SmlJWAF+dM=@vger.kernel.org, AJvYcCVM8Phe11vZGv7vH+hco4mKUrU27DwzT2izQMucv+ReQpJOxlmvXjcod0dmIDbC/aWmvAU0O442@vger.kernel.org
X-Gm-Message-State: AOJu0YzFqEHiwYrOAbg6azU5ZRVFVDTt7nnN9vmy5EiMhM3u3n2H0faR
	Wd+UGeKp5dPAbe01jOrZ7wGpN0JPz2ZkOTdWlJaNybtnzC5DgLc5
X-Gm-Gg: ASbGnctzv7j4xOU1NLcKZLg/2OFVP5BIVx6T4Kbtr6DFPpuAWByZpBQUkRVuspRLdly
	fiqDGDn8O++YifCZUm4jNAhkVPcVUVw8+Y6MQ4J5WWMjgIVobSErzzmB0oX9jxnNdQgkxwh3OWM
	yAQ3R+mmmhT7XbApaa1YH1bsyq2CRi8Y+fiMBgn7iMy2oiCCU2gp4FJ5AgtaCBEOybO5SvjiWbz
	Mfer+mhuDHVShJBUPS0TnGksvqBhYCtonti7U8uef7EnGmbaSgoU7s/okwiGQUDiBfdQRNkWjca
	s0U3wCQzKEVkyLu6hpKlfvJUvpwzX+iKMBOGra6gvtfsPJxzdqa6xbl/Hg==
X-Google-Smtp-Source: AGHT+IEr0UwAYjH54uv/p9tjrBBxTcKHekQANUfyWsFG5hb9xxGI3N4cbP/XpAUP9uw0bRrU4OjjPw==
X-Received: by 2002:a05:6a00:4fd3:b0:72a:8461:d172 with SMTP id d2e1a72fcca58-72daf9becfamr10317751b3a.3.1737207421525;
        Sat, 18 Jan 2025 05:37:01 -0800 (PST)
Received: from ?IPV6:2409:8a55:301b:e120:28db:76a6:1c67:659f? ([2409:8a55:301b:e120:28db:76a6:1c67:659f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab84b639sm3744765b3a.84.2025.01.18.05.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jan 2025 05:37:01 -0800 (PST)
Message-ID: <3795e5e1-8a6a-4ee3-9778-1828ac5b2748@gmail.com>
Date: Sat, 18 Jan 2025 21:36:52 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 3/8] page_pool: fix IOMMU crash when driver
 has already unbound
To: Jesper Dangaard Brouer <hawk@kernel.org>,
 Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com
Cc: zhangkun09@huawei.com, liuyonglong@huawei.com, fanghaiqing@huawei.com,
 Robin Murphy <robin.murphy@arm.com>,
 Alexander Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet
 <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 kernel-team <kernel-team@cloudflare.com>
References: <20250110130703.3814407-1-linyunsheng@huawei.com>
 <20250110130703.3814407-4-linyunsheng@huawei.com>
 <921c827c-41b7-40af-8c01-c21adbe8f41f@kernel.org>
 <2b5a58f3-d67a-4bf7-921a-033326958ac6@huawei.com>
 <95f258b2-52f5-4a80-a670-b9a182caec7c@kernel.org>
 <92bb3a19-a619-4bf7-9ef5-b9eb12a57983@huawei.com>
 <eb2381d2-34a4-4915-b0b5-b07cc81646d3@kernel.org>
Content-Language: en-US
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <eb2381d2-34a4-4915-b0b5-b07cc81646d3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/18/2025 12:56 AM, Jesper Dangaard Brouer wrote:

...

>> I am not really sure about that, as using the PAGE_SIZE block to hold the
>> item seems like a implementation detail, which might change in the 
>> future,
>> renaming other function to something like that doesn't seem right to 
>> me IMHO.
>>
>> Also the next patch will add page_pool_item_blk_add() to support 
>> unlimited
>> inflight pages, it seems a better name is needed for that too, perheps 
>> rename
>> page_pool_item_blk_add() to page_pool_dynamic_item_add()?
>>
> 
> Hmmm... not sure about this.
> I think I prefer page_pool_item_blk_add() over 
> page_pool_dynamic_item_add().
> 
>> For __page_pool_item_init(), perhaps just inline it back to 
>> page_pool_item_init()
>> as __page_pool_item_init() is only used by page_pool_item_init(), and 
>> both of them
>> are not really large function.
> 
> I like that you had a helper function. So, don't merge 
> __page_pool_item_init() into page_pool_item_init() just to avoid naming 
> it differently.

Any particular reason for the above suggestion?

After reusing the page_pool_item_uninit() to fix the similar
use-after-freed problem，it seems reasonable to not expose the
item_blcok as much as possible as item_blcok is really an
implementation detail that should be hidden as much as possible
IMHO.

If it is able to reused for supporting the unlimited item case,
then I am agreed that it might be better to refactor it out,
but it is not really reusable.

static int page_pool_item_init(struct page_pool *pool)
{
#define PAGE_POOL_MIN_INFLIGHT_ITEMS            512
         struct page_pool_item_block *block;
         int item_cnt;

         INIT_LIST_HEAD(&pool->item_blocks);
         init_llist_head(&pool->hold_items);
         init_llist_head(&pool->release_items);

         item_cnt = pool->p.pool_size * 2 + PP_ALLOC_CACHE_SIZE +
                 PAGE_POOL_MIN_INFLIGHT_ITEMS;
         for (; item_cnt > 0; item_cnt -= ITEMS_PER_PAGE) {
                 struct page *page;
                 unsigned int i;

                 page = alloc_pages_node(pool->p.nid, GFP_KERNEL, 0);
                 if (!page) {
                         page_pool_item_uninit(pool);
                         return -ENOMEM;
                 }

                 block = page_address(page);
                 block->pp = pool;
                 list_add(&block->list, &pool->item_blocks);

                 for (i = 0; i < ITEMS_PER_PAGE; i++) {
                         page_pool_item_init_state(&block->items[i]);
                         __llist_add(&block->items[i].lentry, 
&pool->hold_items);
                 }
         }

         return 0;
}

> 
> Let me be more explicit what I'm asking for:
> 
> IMHO you should rename:
>   - __page_pool_item_init() to __page_pool_item_block_init()
> and rename:
>   - page_pool_item_init() to page_pool_item_block_init()
> 
> I hope this make it more clear what I'm saying.
 > > --Jesper
> 



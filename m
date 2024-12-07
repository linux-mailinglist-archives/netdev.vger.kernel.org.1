Return-Path: <netdev+bounces-149885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8458D9E7E6F
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 06:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CD8A1887969
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 05:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36AF43AA9;
	Sat,  7 Dec 2024 05:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GszL8tvW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A1B1A270;
	Sat,  7 Dec 2024 05:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733550741; cv=none; b=boGDtk08rDIR5s3l+tIO4EdxXbRU1lBaLpI+X/6g2e5DSGudZIyUFtHv3bwtA60bbCGZo9hvBUQVIZBZtVUPd8WNb9hQ+sp1/vnInHVJARas0pxfwRpjB/3czvW8Gr8k4c3rhfiPJUiShN//LLmR+knBy4u5CUScQFnq+lzkT/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733550741; c=relaxed/simple;
	bh=aqDCM0KsocK2et+w7xx3eEN9UJyf4EVPP5BSEH8TBtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qqpPsuPlXGni/CxjCBUieYEP7VyoiyAdwaL28FFraE+YFgig3sQFTNORvPWKH5jzC9fbzqm33fYBtbvPv4fvW7LHuLQF22/3fCbIZa36+LNJZZw/OkDIdZgDeLYC52ipflfzppXuqbb6NpQ0CBymd4/lgxogM1iIVhUMYUGjKys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GszL8tvW; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-7f71f2b1370so1834796a12.1;
        Fri, 06 Dec 2024 21:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733550738; x=1734155538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mJgh6HZ29MQRitMQg2IixJr8vYmFNlOQ56zSD16GOxk=;
        b=GszL8tvWAG3J4O/2q1thXAwZgZqzLIn6eMt7yYlIc5Z7PmuIIf8XNi9aPrjSiHa3V0
         euMjqxpoUi+NYExJeYGxbdtY+tFfm1zIN3r0aiRqXtlbCx5sGMbMBrTla0mzZ2X5at1H
         GQZ997v+X0QEK9mp0lOuW0iackuSVg6ESDkyokEQi8HTLZQJBFXn2qg7zG2tUvLfMOV8
         UxRbMoKIFIVURPA2u/ekZGEvG11L9hRqfz4P5gvbwZrzYm+Pht5sMw/rBesZw3VKi5vV
         OXoiZVM9WnD7ldwYT2cRXJo2sGUbSixkaFgX9jKgakuy4W9aLF9XVdpDuEECOvwG7Pim
         y6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733550738; x=1734155538;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mJgh6HZ29MQRitMQg2IixJr8vYmFNlOQ56zSD16GOxk=;
        b=BtJBhZQJ1Id+OW3Df9cT1ABNq1U5GcPd5NST9zV0WVqgL842BLiX6i3hpu3Ao4co1W
         eLjw6eTJsSJnafUXMhYIy8b0WLju6lbDv5+UBq1R4VEI7YVUO/06WYcto4CqGobdnoCY
         OH0W+zYvbjdI3yrNpdxMDGAQRzEYyMbLquWFCSIH83TIvQdYksq1oDDpOyyjogjjUz5D
         DLqC7JajNwbCDuRebqn4quAuVcQBRKuOUglqzUFKBwXQkNNfL5FODSYlfN2urtLIyeRj
         5Ll/fxOAA4yro7x8ICNARAj5EvIvaCtbIlp6oNoPIq8O9y6U9Lf9xDC2objlcOVH//aD
         +POg==
X-Forwarded-Encrypted: i=1; AJvYcCUMrPGaLKX/aBW+1aI2gyDMgONJOx1zPLx5fMsobm8+H9afjD0MJHAjpjVxZ5Gno6SdkUO/c+gz/pEiGdo=@vger.kernel.org, AJvYcCXIt9yF/5Zc4wM9Fzi4Dmch/2wUCI3ZsChYwW9DPJY42/z+xCkzBm8YqO14I+4DaKBGPhvn2zUp@vger.kernel.org
X-Gm-Message-State: AOJu0YzdmAU6UhRWOAD+Jr7ZQxnj37spX046sSjqob0OspssiUjHG3ym
	BYfjwMvM/NzeQjP8tbJBXVxOxE51ITibjdu6JhmHg8EVB40cRdOi
X-Gm-Gg: ASbGncsuV81fTNE2VvMAfVINXMoa/1wQLa48+DxfvzI7UV6T3gM/X+Q7aGsP4Rr1Vqa
	dsIRv9Gf8ekl7Sffjv7traHaGFXNm8ERwIbBMTBHrwH+ryvN4xyUZpnu/mv95um66ZjEJ4MhrE2
	dAk00Jc4FNE/gA4BK+0Byw5V1leC6/m5sy+T82rZgrAuykLyb17kIW48S+b5KjJXYdcTEfUr87L
	1TMrZDk0ctgLwFTQ5b2CwocMGszZc8f5LME9b6KXWdj8PgPPGhIADJBVHjeG7YoR6x0+DawEKMD
	SzEGlRazndoSXe4co/gcG5XO2MsKZLkDqbqjwg==
X-Google-Smtp-Source: AGHT+IEZwNvdgEXpe5iTA98ZGxPdI4RrVKAOyDuL03IRKSXh5VOdXTUzoNWf8W7H7pG+xSFjVjvRWQ==
X-Received: by 2002:a05:6a21:890d:b0:1e0:d229:253 with SMTP id adf61e73a8af0-1e18711a4c9mr8352029637.32.1733550738486;
        Fri, 06 Dec 2024 21:52:18 -0800 (PST)
Received: from ?IPV6:2409:8a55:301b:e120:2dd9:b3de:f5f4:bfdf? ([2409:8a55:301b:e120:2dd9:b3de:f5f4:bfdf])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a29ebdacsm3832507b3a.74.2024.12.06.21.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 21:52:18 -0800 (PST)
Message-ID: <87a40a3f-1f96-4a21-a546-f057e78bd44f@gmail.com>
Date: Sat, 7 Dec 2024 13:52:11 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 1/3] page_pool: fix timing for checking and
 disabling napi_local
To: Jakub Kicinski <kuba@kernel.org>, Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, pabeni@redhat.com, liuyonglong@huawei.com,
 fanghaiqing@huawei.com, zhangkun09@huawei.com,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Wei <dw@davidwei.uk>, Shailend Chand <shailend@google.com>,
 Michael Chan <michael.chan@broadcom.com>
References: <20241120103456.396577-1-linyunsheng@huawei.com>
 <20241120103456.396577-2-linyunsheng@huawei.com>
 <20241202184954.3a4095e3@kernel.org>
 <e053e75a-bde1-4e69-9a8d-d1f54be06bdb@huawei.com>
 <20241204172846.5b360d32@kernel.org>
 <70aefeb1-6a78-494c-9d5b-e03696948d11@huawei.com>
 <20241205164233.64512141@kernel.org>
 <c2b306af-4817-4169-814b-adbf25803919@huawei.com>
 <20241206080943.32da477c@kernel.org>
Content-Language: en-US
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <20241206080943.32da477c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/7/2024 12:09 AM, Jakub Kicinski wrote:

...

>>
>> It seems the napi_disable() is called before netdev_rx_queue_restart()
>> and napi_enable() and ____napi_schedule() are called after
>> netdev_rx_queue_restart() as there is no napi API called in the
>> implementation of 'netdev_queue_mgmt_ops' for bnxt driver?
>>
>> If yes, napi->list_owner is set to -1 before step 1 and only set to
>> a valid cpu in step 6 as below:
>> 1. napi_disable()
>> 2. allocate new queue memory & create new page_pool.
>> 3. stop old rx queue.
>> 4. start new rx queue with new page_pool.
>> 5. free old queue memory + destroy old page_pool.
>> 6. napi_enable() & ____napi_schedule()
>>
>> And there are at least three flows involved here:
>> flow 1: calling napi_complete_done() and set napi->list_owner to -1.
>> flow 2: calling netdev_rx_queue_restart().
>> flow 3: calling skb_defer_free_flush() with the page belonging to the old
>>         page_pool.
>>
>> The only case of page_pool_napi_local() returning true in flow 3 I can
>> think of is that flow 1 and flow 3 might need to be called in the softirq
>> of the same CPU and flow 3 might need to be called before flow 1.
>>
>> It seems impossible that page_pool_napi_local() will return true between
>> step 1 and step 6 as updated napi->list_owner is always seen by flow 3
>> when they are both called in the softirq context of the same CPU or
>> napi->list_owner != CPU that calling flow 3, which seems like an implicit
>> assumption for the case of napi scheduling between different cpus too.
>>
>> And old page_pool is destroyed in step 5, I am not sure if it is necessary
>> to call page_pool_disable_direct_recycling() in step 3 if page_pool_destroy()
>> already have the synchronize_rcu() in step 5 before enabling napi.
>>
>> If not, maybe I am missing something here.
> 
> Yes, I believe you got the steps 5 and 6 backwards.

Maybe, but I am not sure how is it possible that step 6 is called before
step 5 yet.
As it seems two drivers implement 'netdev_queue_mgmt_ops' now and
only bnxt calls page_pool_disable_direct_recycling(), and its
implementation doesn't call napi related API, see bnxt_queue_mgmt_ops:
https://elixir.bootlin.com/linux/v6.13-rc1/source/drivers/net/ethernet/broadcom/bnxt/bnxt.c#L15539

And netdev_rx_queue_restart() seems to call the above ops without
calling any napi related API:
https://elixir.bootlin.com/linux/v6.12.3/source/net/core/netdev_rx_queue.c#L9

The napi related API seems to be only called in bnxt_open_nic() and
bnxt_close_nic() in bnxt driver, and they don't seems to be related
directly to the queue_mgmt_ops.

+cc relevant author and maintainer to see if there is some clarifying
from them as I am not really similar with queue mgmt related sequence.


Return-Path: <netdev+bounces-56786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B85810DAB
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 10:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F862819FC
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 09:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A293121100;
	Wed, 13 Dec 2023 09:49:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7426211D
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 01:49:25 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50bcf41379bso1852020e87.1
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 01:49:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702460963; x=1703065763;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3zb0zFvmGrXCV4bXxD7qGBK+l8y0JfGz1f2hK2OsISA=;
        b=ERRZX1VtDjq4seqZc2mvjJtLZNQag3qrzMgvgjEzJHNTXtF2GYZzphPtwK/0bEkAE6
         Zqx1lEenZ4gbqjOmp9RsI2G0/MQsGdKcb5GlsfaV5Vagsamm36aGBdakUqf8GISYYjqI
         fICwboCc6JH0fc4NdFrKLWM6I80YMpTF79uY3g5QtpDmL4Z6JaDg33CKtkqDGgKRanNT
         gOUWgEa6fagGolresH8drTdQhYjpw5xPjTHVuIAJ9CbpTmOILW/HxVr1nE+4zT07nu5X
         Ys7Cyv/g80DPOSgUiXlrA7rp2Sb5O23stOW61vlE29dJ5QrTe954NWcx5cX2QGFNK0QE
         H3xA==
X-Gm-Message-State: AOJu0YwnExyyXh769zun9Bi/nlAB0L9Q9rl7GHb0kruTpmdbdCVkZWw/
	FoWQg20fexr0JFk4NXzfKEw=
X-Google-Smtp-Source: AGHT+IHa1G0rfWfvK4SyhYBeXWOWC71Jvh8vX76aVfKZVRomsic9JRnRhzWp1K5OWqTFvRil2oK08A==
X-Received: by 2002:a05:651c:1a20:b0:2c9:acf4:310a with SMTP id by32-20020a05651c1a2000b002c9acf4310amr7349967ljb.3.1702460962972;
        Wed, 13 Dec 2023 01:49:22 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e17-20020a05600c4e5100b0040c34cb896asm18510532wmq.41.2023.12.13.01.49.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 01:49:22 -0800 (PST)
Message-ID: <5a166754-390a-46f8-9861-38bc90111c4f@grimberg.me>
Date: Wed, 13 Dec 2023 11:49:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 05/20] nvme-tcp: Add DDP offload control path
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Aurelien Aptel <aaptel@nvidia.com>,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org, hch@lst.de,
 kbusch@kernel.org, axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net,
 kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, brauner@kernel.org
References: <20231122134833.20825-1-aaptel@nvidia.com>
 <20231122134833.20825-6-aaptel@nvidia.com>
 <debbb5ef-0e80-45e1-b9cc-1231a1c0f46a@grimberg.me>
 <253plzsis4h.fsf@nvidia.com>
 <97e6efa4-8d70-98e1-f5af-1d34672c2e2b@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <97e6efa4-8d70-98e1-f5af-1d34672c2e2b@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


> Hi Sagi,
> 
> On 29/11/2023 15:52, Aurelien Aptel wrote:
>> Hi Sagi,
>>
>> Sagi Grimberg <sagi@grimberg.me> writes:
>>>> +     ok = ulp_ddp_query_limits(netdev, &ctrl->ddp_limits,
>>>> +                               ULP_DDP_NVME, ULP_DDP_CAP_NVME_TCP,
>>>> +                               ctrl->ctrl.opts->tls);
>>>> +     if (!ok) {
>>>
>>> please use a normal name (ret).
>>
>> Ok, we will rename to ret and make ulp_ddp_query_limits() return int 0
>> on success to be consistent with the name.
>>
>>> Plus, its strange that a query function receives a feature and returns
>>> true/false based on this. The query should return the limits, and the
>>> caller should look at the limits and see if it is appropriately
>>> supported.
>>
>> We are not sure how to proceed as this seems to conflict with what you
>> suggested in v12 [1] about hiding the details of checking supports in
>> the API. Limits just dictate some constants the nvme-layer should use
>> once we know it is supported.
>>
>> We can rename ulp_ddp_query_limits() to ulp_ddp_check_support(). This
>> function checks the support of the specified offload capability and also
>> returns the limitations of it.
>>
>> Alternatively, we can split it in 2 API functions (check_support
>> and query_limits).
>>
>> Let us know what you prefer.
>>
>> Thanks
>>
>> 1: 
>> https://lkml.kernel.org/netdev/bc5cd2a7-efc4-e4df-cae5-5c527dd704a6@grimberg.me/
> 
> We would like to submit another version by the end of this week and 
> hopefully progress with this series.
> To address your comment, I was thinking about something like:
> 
> +    if (!ulp_ddp_is_cap_active(netdev, ULP_DDP_CAP_NVME_TCP))
> +        goto err;
> +
> +    ret = ulp_ddp_get_limits(netdev, &ctrl->ddp_limits, ULP_DDP_NVME);
> +    if (ret)
> +        goto err;
> +
> +    if (ctrl->ctrl.opts->tls && !ctrl->ddp_limits.tls)
> +        goto err;
> 
> I would like to remind you that the community didn't want to add ulp_ddp 
> caps and limits context to the netdev structure (as we have for example 
> in the block layer q) and preferred the design of ops/cbs.

Seems fine to me.


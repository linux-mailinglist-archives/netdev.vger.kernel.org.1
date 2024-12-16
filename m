Return-Path: <netdev+bounces-152404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E77829F3CE5
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 22:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 259C116983C
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 21:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957881D5161;
	Mon, 16 Dec 2024 21:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="Pt2QWpzk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6E313211A
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 21:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734385311; cv=none; b=kf2gGbBMDMNJQ1iHc17uv0UYnp6/8onQJgtEWQSAuvyn3X5yd61TdGk9tCod8NcOXVN1xaNejWs+XIJUa0OxfJo+EGZEgpWprRRr8yEKMVcQ0XpvGydalN/TYIiWmrPX4WrtfcQu9aVePdlr8VuBgS5YA546/txaGTiLnOw5S1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734385311; c=relaxed/simple;
	bh=H+DEkopHyUZ8fjMMbFdqeVE72ZzQvogJyT/DWZ9NiWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HvfCxuPKOXbtUXG2OhZzpGCdIloQBQil1TJFu72BNV/wIbAp/iOQvmxVY5n+yyzhrTDHZSBMqHx0nr5zRx22mUe/a/LQ7jBbu/loy6TydzwCk1OeZeUkzzL34ov9KBoLyW9HyKp57IcNthBNRBQtpiifuR8i90U7ulD682YrRz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=Pt2QWpzk; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21649a7bcdcso43188015ad.1
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 13:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1734385309; x=1734990109; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g0z9sMKz4Z9a9d8p9fuZ4J8mSK4NVP4AwfgAs6izk00=;
        b=Pt2QWpzkEM0SwkOXRU4psk1TOyPe8q5GqoqMKkLWFaZ8LoQO9Xo+tKh68l7n0o85d0
         7x8nlHu6xhJMgjNfQpQIQItoJzJWtGnJK7qUD1LhSODpFnD4I5vMz3OuoTaLRkeryIqU
         nAu9hxsHUFxOEawbpKN2gDd2WRKL9IQtTgquVsfPJsf260SJk5nq8YvBqU9cjSuUBJKc
         3aqtTxxwazc1rT3MUCWvd+pDpJQ9+MUR7ty07SZUCv3MaE897dulzudEp0vv7J0sRSRY
         FcWfsfs4+Dnl6jM3bBwrPkDQiOq7CxPEetCczYBoDjL29ZRQqV3L4qNoiCt8/rYkwIID
         k0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734385309; x=1734990109;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g0z9sMKz4Z9a9d8p9fuZ4J8mSK4NVP4AwfgAs6izk00=;
        b=WMHI2MjYZF3MR7Goch/pMFZCbIYhLfv76pVCOWGO+Ztwsk/Eooqvvadw2BYHHbcsq4
         02CM7eershviEExMzKRZt8wCSGC6RWTHSyktZsXmr+njXAutqX8Hu1jWJfmPg3qFXvs0
         OzXL2Io2Ppxy+2UYg8CRd1/785466XYxOAIEbC2d70s5mitebpd2X/V3UV9LpKGAUw2J
         PyuoiSLYk38/jk6w4lTuwWNGdKVgFwhdCjKAoWDVyzWSSGRFspyXGRdb710uK/8jhJpT
         Ri/8YejOfcrkOlIQZIs1txxHuRHH5xpbzjpkoGtvlFcz9AQbUNjGU/6MqDAtVcxHMkLz
         Ub4g==
X-Forwarded-Encrypted: i=1; AJvYcCWUPGSdsbdrZdJQyFojHZN2Ix7eqXXI7yGtTABLH/Esys8XXzni8YKbRzHCbH3ipyEeHjLiK3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+L30Hu1zhV96EVocE2NV1DC9peoD5huw1c5o/pzEecEU2+AgK
	92Pd+Y9H60zUJbRGCLvaSDX+ETNmUZk9tkbgx/M7Qb8GGpZqa1o7KvTnGVcgCXU=
X-Gm-Gg: ASbGncv0kp5nvpGrLJVB8G+E7XpFUP5cLXsMc/+u1VH7yxY8f/4OOoQddtLxxii0k4i
	5d05lku32IBI2jSPjMMhCy9LpzlLDKexFVWydAQFLy91wQmbdFCiH2WxCkU7b2UYe85j3JI6jZZ
	uNioWdgqbHhWmOajgMWn/zSIO6WL49HeM/lNI48xEyXIYy1mmqHlyZufHSx4jEvkFs5q7FwD0mc
	dSspijvthCUmEH2dM91hI4a4HJnkMPjfhGujuwkUsjHTQ1GZiPB/oXApPC4Nrcgc87jDWCQD4v9
	KFFt6F1JQ28vqu0X0w==
X-Google-Smtp-Source: AGHT+IHD9UZ3FTOoLro4bjK5fttlC+QHPR8wTlevsSeUa2OPGYJvb8swbvvH8QvWqiuQenNpzCbIPw==
X-Received: by 2002:a17:902:d50c:b0:215:bc30:c952 with SMTP id d9443c01a7336-2189298a144mr201629635ad.6.1734385309132;
        Mon, 16 Dec 2024 13:41:49 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1256:1:80c:c984:f4f1:951f? ([2620:10d:c090:500::5:e499])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e72870sm47197355ad.279.2024.12.16.13.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 13:41:48 -0800 (PST)
Message-ID: <2d7f6fe0-9205-4eaf-bc43-dc36b14925a4@davidwei.uk>
Date: Mon, 16 Dec 2024 13:41:46 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 3/3] bnxt_en: handle tpa_info in queue API
 implementation
Content-Language: en-GB
To: Michael Chan <michael.chan@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, netdev@vger.kernel.org,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20241204041022.56512-1-dw@davidwei.uk>
 <20241204041022.56512-4-dw@davidwei.uk>
 <9ca8506d-c42d-40a0-9532-7a95c06fed39@huawei.com>
 <0bc60b9d-fbf7-4421-ab6a-5854355d68f4@davidwei.uk>
 <a1d5ffda-1e6c-4730-8b36-6ba644bb0118@huawei.com>
 <fedc8606-b3bc-4fb1-8803-a004cb24216e@davidwei.uk>
 <CACKFLik1-rQB2QHY1pZ3eF0GYGUCgXFHvhh50DNboXV+A7MCuA@mail.gmail.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <CACKFLik1-rQB2QHY1pZ3eF0GYGUCgXFHvhh50DNboXV+A7MCuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-12-11 09:11, Michael Chan wrote:
> On Wed, Dec 11, 2024 at 8:10 AM David Wei <dw@davidwei.uk> wrote:
>>
>> On 2024-12-11 04:32, Yunsheng Lin wrote:
>>> On 2024/12/11 2:14, David Wei wrote:
>>>> On 2024-12-10 04:25, Yunsheng Lin wrote:
>>>>> On 2024/12/4 12:10, David Wei wrote:
>>>>>
>>>>>>    bnxt_copy_rx_ring(bp, rxr, clone);
>>>>>> @@ -15563,6 +15580,8 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
>>>>>>    bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
>>>>>>    rxr->rx_next_cons = 0;
>>>>>>    page_pool_disable_direct_recycling(rxr->page_pool);
>>>>>> +  if (bnxt_separate_head_pool())
>>>>>> +          page_pool_disable_direct_recycling(rxr->head_pool);
>>>>>
>>>>> Hi, David
>>>>> As mentioned in [1], is the above page_pool_disable_direct_recycling()
>>>>> really needed?
>>>>>
>>>>> Is there any NAPI API called in the implementation of netdev_queue_mgmt_ops?
>>>>> It doesn't seem obvious there is any NAPI API like napi_enable() &
>>>>> ____napi_schedule() that is called in bnxt_queue_start()/bnxt_queue_stop()/
>>>>> bnxt_queue_mem_alloc()/bnxt_queue_mem_free() through code reading.
>>>>>
>>>>> 1. https://lore.kernel.org/all/c2b306af-4817-4169-814b-adbf25803919@huawei.com/
>>>>
>>>> Hi Yunsheng, there are explicitly no napi_enable/disable() calls in the
>>>> bnxt implementation of netdev_queue_mgmt_ops due to ... let's say HW/FW
>>>> quirks. I looked back at my discussions w/ Broadcom, and IIU/RC
>>>> bnxt_hwrm_vnic_update() will prevent any work from coming into the rxq
>>>> that I'm trying to stop. Calling napi_disable() has unintended side
>>>> effects on the Tx side.
>>>
>>> It seems that bnxt_hwrm_vnic_update() sends a VNIC_UPDATE cmd to disable
>>> a VNIC? and a napi_disable() is not needed?
>>
>> Correct.
>>
>>> Is it possible that there may
>>> be some pending NAPI work is still being processed after bnxt_hwrm_vnic_update()
>>> is called?
>>
>> Possibly, I don't know the details of how the HW works.
>>
> 
> bnxt_hwrm_vnic_update() only stops the HW from receiving more packets.
> The completion may already have lots of RX entries and TPA entries.
> NAPI may be behind and it can take a while to process a batch of 64
> entries at a time to go through all the remaining entries.
> 
>> At the time I just wanted something to work, and not having
>> napi_enable/disable() made it work. :) Looking back though it does seem
>> odd, so I'll try putting it back.
> 
> Yeah, I think it makes sense to add napi_disable().  Thanks.

Michael, Som. I can't add napi_disable()/enable() because the NAPI
instance is shared between the Rx and Tx queues. If I disable a NAPI
instance, then it affects the corresponding Tx queue because it is not
quiesced. Only the Rx queue is quiesced indirectly by preventhing the HW
from receiving packets via the call to bnxt_hwrm_vnic_update().

The other implementation of queue API (gve) will quiesce all queues for
an individual queue stop/start operation. To call
napi_disable()/enable() I believe we will need the same thing for bnxt.


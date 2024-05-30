Return-Path: <netdev+bounces-99284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E17708D4477
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 06:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 100481C2101B
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 04:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB9B142E88;
	Thu, 30 May 2024 04:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iqjch8gA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361DA28E7;
	Thu, 30 May 2024 04:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717042921; cv=none; b=JxfTzlA3vuLeEE4vcT0DmXQpiFtO0/krHOVGgC+9zg78q6mtSS1gP2cXQUX9fAu9pQqdHBz5vTeneqT5IaoZJXMbc05Mzbdg7qVjqok8rsCELE8WYOccYOWV8hNKvjA3kSkTFXSEgdFSIJzjjl0Xf9AXEdqdpFyLboNiq+8rZz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717042921; c=relaxed/simple;
	bh=HvHUlYrVomARIHnkZekH0LjPMDAiqzdro3h1eChDqfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HTJq0cMqHaPpN9vc9PQVsHnxJsai4Dk3LhV9UrMsDNIqHvWndsGxOxf8zMKcqHhnLSCHj7yLMCl2fYJHdo0iS3L8qAvcbg5a/QW3IGFIRBcqhOevpSyXGkgxb2SThLGTyCWmnoShh3irhgaH8KkoiqD71mkfwVXjrVMto3O65ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iqjch8gA; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ff6fe215c6so412709b3a.3;
        Wed, 29 May 2024 21:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717042919; x=1717647719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xBLzkMhspMVVnxkqgoE5gR4vmWralf60H1wWDRcdvnw=;
        b=Iqjch8gAdpDFQc2wGFFyaniJISMOGOUypXQINqYXKhwTtBmPxdf3jidkJwAsnKpi9D
         sTNGB1GQ3c7wqlN59eYXhqVbCrJxVx9QOw8HTWrYQeyNiIO8c+BwOSjv6FBOQWpozQZl
         G2q2EckXgfwL+hluvoivv8bqufqCXzjUAMqGfOCB1xKGOBfmoZADzDXz/PCEow6f/kdX
         ynSVx3MEru5BFAh/10CdOa0ghZkb0g34SyReiBv7MtQQviRJ3bccKAIhs2kjWEbLXyAS
         0ojL6rRtb1JJKG3Mdz1T/g/KoRBB1htFgOZ4YpTyyCdRiekJFarSxzP3Kn3JC+rsxf8H
         nBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717042919; x=1717647719;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBLzkMhspMVVnxkqgoE5gR4vmWralf60H1wWDRcdvnw=;
        b=kMAEaZem/PAQc/K4ZLwL+DVIrfMVvxpgUWqdeF6r1158Nc3WuWTtUgakNQpZg5qVjD
         u7sEt6UktRzOvSNcr5THpTulbQs7Re1EHqPseJe5mYJnPI7WkHcDDC9imsc+d35HuH/c
         SYZ4fxQjgxFUKalAvG0zfrh1GtIfqY8U8pY6adDMRI5a4D5eVQ3rETIlVknpP1jOCcnc
         DaQlpxZoW3IzXAkw+jTNcO1ftdu1cUbcMQMj4kGUP0/v91ljFxg4i+Pn6SON9+aQBbHK
         A+GF4mlD9UJjmKDgRWT5l9/d35leNipKih7bh6agbH4Hf7LvgodclKLt/c9W5VsnBmeZ
         WADw==
X-Forwarded-Encrypted: i=1; AJvYcCWYew8L5VwEDgcx2sqzesygo/m6qstR+BX/kEezT1TCQrpGF3WL8j9k8p4g17AfKQS1I55HAJRxqCcFDRHz4Wu4LMtQfkc91Leq4f7ef5JM86GJOAoD4Hzc/s3J/cBxJAo7Pr+n
X-Gm-Message-State: AOJu0YwRlrg7qevM2WHoCp84tHrtjw3FKviGCNpFAZ0yh6tmTtC8Hvuj
	Ao19qhi9HkZjq+OCB+EvPxdu4TI/nVR5LTbVcy4cozcGclL0FUza
X-Google-Smtp-Source: AGHT+IELWc+Ian0RzmubNr/PJ38WEIz0KL3Ieb7m/tuYvJNFgMjfxZG8fmC9atETuYx6gTQgx8Gu6Q==
X-Received: by 2002:a05:6a00:3485:b0:6f8:effd:7942 with SMTP id d2e1a72fcca58-702310daf06mr1253461b3a.2.1717042919124;
        Wed, 29 May 2024 21:21:59 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fcfe6cd2sm8765866b3a.162.2024.05.29.21.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 21:21:58 -0700 (PDT)
Message-ID: <ce9fe740-8c9a-4fc0-a65d-464f2c7da377@gmail.com>
Date: Wed, 29 May 2024 21:21:54 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net v2] net: ethernet: mtk_eth_soc: handle dma buffer size soc
 specific
To: =?UTF-8?B?QmMtYm9jdW4gQ2hlbiAo6Zmz5p+P5p2RKQ==?=
 <bc-bocun.chen@mediatek.com>, "daniel@makrotopia.org"
 <daniel@makrotopia.org>, "sgoutham@marvell.com" <sgoutham@marvell.com>
Cc: =?UTF-8?B?TWFyay1NQyBMZWUgKOadjuaYjuaYjCk=?= <Mark-MC.Lee@mediatek.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 =?UTF-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
 <SkyLake.Huang@mediatek.com>, =?UTF-8?B?U2FtIFNoaWggKOWPsueiqeS4iSk=?=
 <Sam.Shih@mediatek.com>, "linux@fw-web.de" <linux@fw-web.de>,
 "john@phrozen.org" <john@phrozen.org>, "nbd@nbd.name" <nbd@nbd.name>,
 "lorenzo@kernel.org" <lorenzo@kernel.org>,
 "frank-w@public-files.de" <frank-w@public-files.de>,
 Sean Wang <Sean.Wang@mediatek.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 =?UTF-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "angelogioacchino.delregno@collabora.com"
 <angelogioacchino.delregno@collabora.com>
References: <20240527142142.126796-1-linux@fw-web.de>
 <BY3PR18MB4737D0ED774B14833353D202C6F02@BY3PR18MB4737.namprd18.prod.outlook.com>
 <kbzsne4rm4232w44ph3a3hbpgr3th4xvnxazdq3fblnbamrloo@uvs3jyftecma>
 <395096cbf03b25122b710ba684fb305e32700bba.camel@mediatek.com>
 <BY3PR18MB4737EC8554AA453AF4B332E8C6F22@BY3PR18MB4737.namprd18.prod.outlook.com>
 <4611828c0f2a4e9c8157e583217b7bc5072dc4ea.camel@mediatek.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <4611828c0f2a4e9c8157e583217b7bc5072dc4ea.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/29/2024 6:46 PM, Bc-bocun Chen (陳柏村) wrote:
> On Wed, 2024-05-29 at 17:50 +0000, Sunil Kovvuri Goutham wrote:
>>   	
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>   On Mon, 2024-05-27 at 17:13 +0100, Daniel Golle wrote:
>>>> On Mon, May 27, 2024 at 03:55:55PM GMT, Sunil Kovvuri Goutham
>>> wrote:
>>>>>>
>>>>>>
>>>>>>>> -----Original Message-----
>>>>>>>> From: Frank Wunderlich <linux@fw-web.de>
>>>>>>>> Sent: Monday, May 27, 2024 7:52 PM
>>>>>>>> To: Felix Fietkau <nbd@nbd.name>; Sean Wang <
>>>>>>>> sean.wang@mediatek.com>;
>>>>>>>> Mark Lee <Mark-MC.Lee@mediatek.com>; Lorenzo Bianconi
>>>>>>>> <lorenzo@kernel.org>; David S. Miller <
>> davem@davemloft.net>
>>>>> ; Eric
>>>>>>>> Dumazet
>>>>>>>> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>;
>>>>> Paolo
>>>>>>>> Abeni
>>>>>>>> <pabeni@redhat.com>; Matthias Brugger <
>>>>> matthias.bgg@gmail.com>;
>>>>>>>> AngeloGioacchino Del Regno <
>>>>>>>> angelogioacchino.delregno@collabora.com>
>>>>>>>> Cc: Frank Wunderlich <frank-w@public-files.de>; John
>>>>> Crispin
>>>>>>>> <john@phrozen.org>; netdev@vger.kernel.org;
>>>>>>>> linux-kernel@vger.kernel.org;
>>>>>>>> linux-arm-kernel@lists.infradead.org;
>>>>>>>> linux-mediatek@lists.infradead.org;
>>>>>>>> Daniel Golle <daniel@makrotopia.org>
>>>>>>>> Subject: [net v2] net: ethernet: mtk_eth_soc: handle dma
>>>>> buffer
>>>>>>>> size soc specific
>>>>>>>>
>>>>>>>> From: Frank Wunderlich <frank-w@public-files.de>
>>>>>>>>
>>>>>>>> The mainline MTK ethernet driver suffers long time from
>>>>> rarly but
>>>>>>>> annoying tx
>>>>>>>> queue timeouts. We think that this is caused by fixed dma
>>>>> sizes
>>>>>>>> hardcoded for
>>>>>>>> all SoCs.
>>>>>>>>
>>>>>>>> Use the dma-size implementation from SDK in a per SoC
>>>>> manner.
>>>>>>>>
>>>>>>>> Fixes: 656e705243fd ("net-next: mediatek: add support for
>>>>> MT7623
>>>>>>>> ethernet")
>>>>>>>> Suggested-by: Daniel Golle <daniel@makrotopia.org>
>>>>>>>> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
>>>>
>>>>>>
>>>>>> ..............
>>>>>>>>
>>>>>>>> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
>>>>>>>> b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
>>>>>>>> index cae46290a7ae..f1ff1be73926 100644
>>>>>>>> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
>>>>>>>> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
>>>>
>>>>>>
>>>>>> .............
>>>>>>>> @@ -1142,40 +1142,46 @@ static int mtk_init_fq_dma(struct
>>>>> mtk_eth
>>>>>>>> *eth)
>>>>>>>>                              cnt * soc-
>>>>>>>>> tx.desc_size,
>>>>>>>>                              &eth-
>>>>>>>>> phy_scratch_ring,
>>>>>>>>                              GFP_KERNEL);
>>>>
>>>>>>
>>>>>> ..............
>>>>>>>> -  for (i = 0; i < cnt; i++) {
>>>>>>>> -      dma_addr_t addr = dma_addr + i *
>> MTK_QDMA_PAGE_SIZE;
>>>>>>>> -      struct mtk_tx_dma_v2 *txd;
>>>>>>>> +      dma_addr = dma_map_single(eth->dma_dev,
>>>>>>>> +                  eth->scratch_head[j], len *
>>>>>>>> MTK_QDMA_PAGE_SIZE,
>>>>>>>> +                  DMA_FROM_DEVICE);
>>>>>>>>
>>>>
>>>>>>
>>>>>> As per commit msg, the fix is for transmit queue timeouts.
>>>>>> But the DMA buffer changes seems for receive pkts.
>>>>>> Can you please elaborate the connection here.
>>>
>>>>
>>>> *I guess* the memory window used for both, TX and RX DMA
>>> descriptors
>>>> needs to be wisely split to not risk TX queue overruns, depending
>>> on
>>>> the
>>>> SoC speed and without hurting RX performance...
>>>>
>>>> Maybe someone inside MediaTek (I've added to Cc now) and more
>>>> familiar
>>>> with the design can elaborate in more detail.
>>   
>>> We've encountered a transmit queue timeout issue on the MT79888 and
>>> have identified it as being related to the RSS feature.
>>> We suspect this problem arises from a low level of free TX DMADs,
>> the
>>> TX Ring alomost full.
>>> Since RSS is enabled, there are 4 Rx Rings, with each containing
>> 2048
>>> DMADs, totaling 8192 for Rx. In contrast, the Tx Ring has only 2048
>>> DMADs. Tx DMADs will be consumed rapidly during a 10G LAN to 10G WAN
>>> forwarding test, subsequently causing the transmit queue to stop.
>>> Therefore, we reduced the number of Rx DMADs for each ring to
>> balance
>>> both Tx and Rx DMADs, which resolves this issue.
>>
>> Okay, but it’s still not clear why it’s resulting in a transmit
>> timeout.
>> When transmit queue is stopped and after some Tx pkts in the pipeline
>> are flushed out, isn’t
>> Tx queue wakeup not happening ?
>>   
> Yes, the transmit timeout is caused by the Tx queue not waking up.
> The Tx queue stops when the free counter is less than ring->thres, and
> it will wake up once the free counter is greater than ring->thres.
> If the CPU is too late to wake up the Tx queues, it may cause a
> transmit timeout.
> Therefore, we balanced the TX and RX DMADs to improve this error
> situation.

All of this needs to go into the commit message please, thanks!
-- 
Florian


Return-Path: <netdev+bounces-129385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC30982606
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 23:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B23611C20E8A
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 21:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6303E824A1;
	Mon, 23 Sep 2024 21:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmYslcXY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE68177103;
	Mon, 23 Sep 2024 21:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727126041; cv=none; b=A/4TTymljYqNH9ylWiIqiOQYdMsz3mBWB9PU12bAWbBgavq6ooycsv2bs2fHxJfMT6FUdtg3Qv9RToifzVdq1p8Q3St2fvbKjdABsclYgNxyWfX5nPU7n8Y1HVVpfy4btxOfeW80x8ZKA8MxsoPfgLop91WzIBdFj993aNnoAWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727126041; c=relaxed/simple;
	bh=MiwbVUI+875lhjAtIuwhzEJNCWQ4HTqGbr0KOUhu2xo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NjVUASYSkbV7dewkIGeMZm/+9RIRq1wijEk9Iaz/47Ih2mKHKfw3Itoxz5X5b5n0LGoqr82ShTgY+Q5Hp/Bn7uNjhFSpGkyF/s9VaPN7zit18ZZGBAeterVLE0AkFrHzysNTXpfTh8AxXMUiiFYztZqsZTNGkfuu3GzHoqg4AV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmYslcXY; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7b0c9bbddb4so3251907a12.3;
        Mon, 23 Sep 2024 14:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727126039; x=1727730839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pO/6d/gDXXUTcDXUJlrlfTdrh2B/Xbl+JiNfLlhN/5M=;
        b=SmYslcXY71Rd5TrLk8BA92Y9QH7Ylhf9PtQPkLgMUV6TO7o4jSY+jguiUPbujUOrOr
         kf8xkuenwApVZiDjlcf8UH98HRDMZIzDp2iolzoQdBdv0XtY7q9wtdxjDXiXen4raOPA
         pjUSW1d1x6sVGfqgRu5OnlSZRdc2TJgYMna9xUft/ILH6IBTIjoclH9ImbMHa5b0OoFg
         HP4usBXVYBmiaZnpTxXgmYcw+CyARCy63v+K9POogu+MbRKDnjLFUsExI5erUvktopHU
         3AKbVe13LhNXAWNGSUxfJT1TnoIoVAewcFVaHyzR2G6Ho7mLiMSqHx3cGGJ0H0WOJW/X
         LXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727126039; x=1727730839;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pO/6d/gDXXUTcDXUJlrlfTdrh2B/Xbl+JiNfLlhN/5M=;
        b=duz2ow9434WRRXd2NCjXu2O2e9CGcYu5dBIwJmjlMxsZZXPwQ3cN15RirHgmhYACLb
         R4OWQ6SOnLX+L6dos04IpN1KY51avgw00KMOqfnxJ5QeLrNkU0TThTNvnPzzT8bg/XEd
         5laodE1QpKb2fNVoZ1wzhPVKVdnXepat1Fta2EKaK2ORRXQ6OlOzcbFm3fyLdA5xKkZO
         1OlJyMd+FuNjaK3QLM2YzFICbhQpSdYPmwOw53fd7YdwpYo92yvC6VOJr+6nE5ozgU7k
         KQgufS0kjys1OphXID5HCrR2UCsw7mdkwAic9FsffJrFLLaGhvtJxVb9Q9RLweOE7rT9
         SqDA==
X-Forwarded-Encrypted: i=1; AJvYcCWBS8c7O9P36YK95p1wiJrsr3BxHMauGfyTAOSy9RW4/ARIS2PhADKBaoY2lhGFmyaHMiCaYdg/@vger.kernel.org, AJvYcCX8/dEPFyiJucLccAp2lAWLVZqSTwctXiF1UkXIGwJDRxVq1yxOHuBdJSy2QglPe5KUOxJCEkNpUiUuJ1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvAMh10xn7vo/mf6NcpSOivYJUhLanMSsTFJo+E6VxC8VES9iB
	M018kuw2jq0v5jIr/BpoGkENTgzjFXI9qXoQGMg1IDf6fogW08qf
X-Google-Smtp-Source: AGHT+IEAnW7yN6qCtrsyo7BIQtrP3+Vy4EfhwZQvPPu/0xGPuycMmFaz2h8wFToO40DI/Ee+ma6LCQ==
X-Received: by 2002:a05:6a20:9d8f:b0:1cf:1251:9a47 with SMTP id adf61e73a8af0-1d30a9bcf0amr16966274637.31.1727126038988;
        Mon, 23 Sep 2024 14:13:58 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc9c67d7sm55473b3a.187.2024.09.23.14.13.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 14:13:58 -0700 (PDT)
Message-ID: <ec046bcf-06ce-4abe-b0ea-b6741c9ff004@gmail.com>
Date: Mon, 23 Sep 2024 14:13:56 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/1] net: ethernet: lantiq_etop: fix memory
 disclosure
To: Aleksander Jan Bajkowski <olek2@wp.pl>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jacob.e.keller@intel.com, andrew@lunn.ch, horms@kernel.org,
 john@phrozen.org, ralph.hempel@lantiq.com, ralf@linux-mips.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240921105801.14578-1-olek2@wp.pl>
 <20240921105801.14578-2-olek2@wp.pl>
 <0a9830fe-790d-4ccd-bec9-3fbb32f18aa8@gmail.com>
 <991dc2b6-12ef-458d-b37f-562c15a73a07@wp.pl>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <991dc2b6-12ef-458d-b37f-562c15a73a07@wp.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/23/24 14:08, Aleksander Jan Bajkowski wrote:
> Hi Florian,
> 
> 
> On 23.09.2024 20:21, Florian Fainelli wrote:
>> On 9/21/24 03:58, Aleksander Jan Bajkowski wrote:
>>> When applying padding, the buffer is not zeroed, which results in memory
>>> disclosure. The mentioned data is observed on the wire. This patch uses
>>> skb_put_padto() to pad Ethernet frames properly. The mentioned function
>>> zeroes the expanded buffer.
>>>
>>> In case the packet cannot be padded it is silently dropped. Statistics
>>> are also not incremented. This driver does not support statistics in the
>>> old 32-bit format or the new 64-bit format. These will be added in the
>>> future. In its current form, the patch should be easily backported to
>>> stable versions.
>>>
>>> Ethernet MACs on Amazon-SE and Danube cannot do padding of the packets
>>> in hardware, so software padding must be applied.
>>>
>>> Fixes: 504d4721ee8e ("MIPS: Lantiq: Add ethernet driver")
>>> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
>>> ---
>>>   drivers/net/ethernet/lantiq_etop.c | 11 ++++++-----
>>>   1 file changed, 6 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ 
>>> ethernet/lantiq_etop.c
>>> index 3c289bfe0a09..36f1e3c93ca5 100644
>>> --- a/drivers/net/ethernet/lantiq_etop.c
>>> +++ b/drivers/net/ethernet/lantiq_etop.c
>>> @@ -477,11 +477,11 @@ ltq_etop_tx(struct sk_buff *skb, struct 
>>> net_device *dev)
>>>       struct ltq_etop_priv *priv = netdev_priv(dev);
>>>       struct ltq_etop_chan *ch = &priv->ch[(queue << 1) | 1];
>>>       struct ltq_dma_desc *desc = &ch->dma.desc_base[ch->dma.desc];
>>> -    int len;
>>>       unsigned long flags;
>>>       u32 byte_offset;
>>>   -    len = skb->len < ETH_ZLEN ? ETH_ZLEN : skb->len;
>>> +    if (skb_put_padto(skb, ETH_ZLEN))
>>> +        return NETDEV_TX_OK;
>>
>> You should consider continuing to use the temporary variable 'len' 
>> here, and just re-assign it after the call to skb_put_padto() and 
>> avoid introducing potential user-after-free near the point where you 
>> program the buffer length into the HW. This also minimizes the amount 
>> of lines to review.
> 
> To the best of my knowledge, the skb is not released until the DMA 
> finishes the transfer.
> Then the ltq_etop_poll_tx() function is called, which releases the skb. 
> Can you explain
> what sequence of events can lead to a use-after-free error?

There is none right now, but assuming you might add byte queue limits in 
the future, or just re-structure the code, reading from skb->len is 
error prone and is better left avoided, especially since this will 
result in few lines being changed in your case.

> 
> -->ltq_etop_tx()
>       |
>       | (dma irq fires)
>       |
>       -->ltq_etop_dma_irq()
>            |
>            | (napi task schedule)
>            |
>            -->ltq_etop_poll_tx()
>                 |
>                 |
>                 |
>                 -->dev_kfree_skb_any()
> 
> Regards
> 


-- 
Florian


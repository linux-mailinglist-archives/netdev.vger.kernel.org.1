Return-Path: <netdev+bounces-114561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8924E942E72
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 14:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07EB01F27467
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 12:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66B91AED22;
	Wed, 31 Jul 2024 12:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AlVcMgQA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1E71AD9C7
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 12:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722429154; cv=none; b=pUK13AoHvQGBIhBit4UxwwvbjY+yoRTYjcPYQfTXrpk31/7s4CxtKoSpsv+Avc1GdQk38U66VkMfsPlGOOFLb26rfNjH3KoEWAcFnjjpgQqlKDAngSAMKjyvI19fW1DKBPqbKPOSDMmCRt3HY9ErrwdB/HK1I2wT+6jPphrMc4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722429154; c=relaxed/simple;
	bh=nIaMDXTEvvVu5TaAZ+M1p28NLK3Hau+a0RwSgozPyD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cSeonDSrJ9GaTwbl/fqcVZmjD5Cy8hIbMRA68TUAj20XUSGWrlCxoO6r9zilQfD7Hz+rK05IlSmeJATAkVgbd1gI0pggw4IfkUxQvb2TzUyR9RtGq/5crfUf/os/x/hrdMVaN+9ZI5y8uNyAlIC+0ScithRaAaSldfzpzEGG8zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AlVcMgQA; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3db1270da60so4010404b6e.2
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 05:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722429152; x=1723033952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IBnztp7MHGTNI2WLXQ1z2xFUTFJyK2sGTn7NhQG6Jn0=;
        b=AlVcMgQAGT/ovaQ0yhU9w1xd9ptI33OPPN8qu72CatjT5eBTzXgUQbKle/1/IO5NCD
         OgYq6VZigX/fIzvWYAYgy+3Gfjszo+Rze2+if5gv/prSkMViYkLbUrNQic0sQ3L2bJqU
         SexjW1hXVxeXJerYag/C+7r4YSYK7/lRYSFNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722429152; x=1723033952;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBnztp7MHGTNI2WLXQ1z2xFUTFJyK2sGTn7NhQG6Jn0=;
        b=DZqkuMBgUsaRMyh+/wCPDqYGn9EYloGPMQPpbdtDwQ4pE3o6frbdmSI+9rl4cJfq9C
         rYlIWt+fZPlrBwxH86fR28zRAHLEUsdGfbiMvdP3HA+4FfaUpLKT3ztUtf26EeO1msbL
         IadKXG7bMKxDVX3uiV0RcvfjG3gjS0OKorvzPpChW7yf2tGXdPqTguZXtRkoCNYRA+Gq
         Wx5HlF/98ZFBHNMFk8fBreJUsASYyxnvTf3s2wQDddxw96Q/92Gzf5ejq8ZE8Pfme7NS
         V4DLAsjHsXnL5GlgyVSV2JegmOuhC/5YctTF8r0GbHwW6dw1Gwk8ZJkBbQnSGUeTr+02
         YR6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXtcEnedgmJoPzzzn8O5LOY99SFfYJXKmXsEp4vkKOGNvTJk7Kq2YLVkgburSbSFeZCjtlHfM32wNAp+FT0+0beRuIGr+sA
X-Gm-Message-State: AOJu0YzTgrq7m7cInvW9b7iij+wqFHR5y80jSoa4UF7QNwf9sJoWFgxq
	JdaK+IvWOT6C0PxJgwwPg7O0Sv969CKdyRHHT44OifydgAoWFxUeVw6GRT7AGw==
X-Google-Smtp-Source: AGHT+IGub2mfcUjNyEK7FnlmoAJsUg+UOYRuhDDZrKgslzcgZXVtSEKgXAyfNVfLpTCXJ5MAH3GXUw==
X-Received: by 2002:a05:6808:201c:b0:3da:e219:bf with SMTP id 5614622812f47-3db23d37550mr17331120b6e.43.1722429151648;
        Wed, 31 Jul 2024 05:32:31 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8206b5bsm57935951cf.65.2024.07.31.05.32.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 05:32:31 -0700 (PDT)
Message-ID: <6e34c814-a6dc-4a96-9e46-ca25af67f4f6@broadcom.com>
Date: Wed, 31 Jul 2024 14:32:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] wifi: brcmfmac: Add optional lpo clock enable
 support
To: Alexey Charkov <alchark@gmail.com>
Cc: Jacobe Zang <jacobe.zang@wesion.com>, robh@kernel.org,
 krzk+dt@kernel.org, heiko@sntech.de, kvalo@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 conor+dt@kernel.org, efectn@protonmail.com, dsimic@manjaro.org,
 jagan@edgeble.ai, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, arend@broadcom.com,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org, megi@xff.cz,
 duoming@zju.edu.cn, bhelgaas@google.com, minipli@grsecurity.net,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 nick@khadas.com
References: <20240731061132.703368-1-jacobe.zang@wesion.com>
 <20240731061132.703368-5-jacobe.zang@wesion.com>
 <0a78a0fb-0a5e-424f-a801-4a63b9ee1a49@gmail.com>
 <3ded8aea-ee11-43da-9dd7-1259cf931747@broadcom.com>
 <CABjd4YxiSY0A0iVHGHw9RDey+avxmzUapoLLLyf=80MzVX0yWA@mail.gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <CABjd4YxiSY0A0iVHGHw9RDey+avxmzUapoLLLyf=80MzVX0yWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/31/2024 2:01 PM, Alexey Charkov wrote:
> On Wed, Jul 31, 2024 at 2:15 PM Arend van Spriel
> <arend.vanspriel@broadcom.com> wrote:
>>
>> On 7/31/2024 12:16 PM, Alexey Charkov wrote:
>>> Hi Jacobe,
>>>
>>>
>>> On 31/07/2024 9:11 am, Jacobe Zang wrote:
>>>   > WiFi modules often require 32kHz clock to function. Add support to
>>>   > enable the clock to PCIe driver and move "brcm,bcm4329-fmac" check
>>>   > to the top of brcmf_of_probe
>>>   >
>>>   > Co-developed-by: Ondrej Jirman <megi@xff.cz>
>>>   > Signed-off-by: Ondrej Jirman <megi@xff.cz>
>>>   > Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
>>>   > ---
>>>   >  .../net/wireless/broadcom/brcm80211/brcmfmac/of.c    | 12 +++++++++++-
>>>   >  1 file changed, 11 insertions(+), 1 deletion(-)
>>>   >
>>>   > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
>>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
>>>   > index e406e11481a62..7e0a2ad5c7c8a 100644
>>>   > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
>>>   > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
>>>   > @@ -6,6 +6,7 @@
>>>   >  #include <linux/of.h>
>>>   >  #include <linux/of_irq.h>
>>>   >  #include <linux/of_net.h>
>>>   > +#include <linux/clk.h>
>>>   >
>>>   >  #include <defs.h>
>>>   >  #include "debug.h"
>>>   > @@ -70,12 +71,16 @@ void brcmf_of_probe(struct device *dev, enum
>>> brcmf_bus_type bus_type,
>>>   >  {
>>>   >      struct brcmfmac_sdio_pd *sdio = &settings->bus.sdio;
>>>   >      struct device_node *root, *np = dev->of_node;
>>>   > +    struct clk *clk;
>>>   >      const char *prop;
>>>   >      int irq;
>>>   >      int err;
>>>   >      u32 irqf;
>>>   >      u32 val;
>>>   >
>>>   > +    if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
>>>   > +        return;
>>>
>>> Did you test this? The DTS patch you sent as part of this series doesn't
>>> list "brcm,bcm4329-fmac" in the compatible, so this will probably return
>>> right here, skipping over the rest of your patch.
>>>
>>> Please test before resending, both with and without the driver for the
>>> Bluetooth part of the chip (since it also touches clocks).
>>>
>>> You are also changing the behavior for other systems by putting this
>>> check further up the probe path, which might break things for no reason.
>>> Better put your clk-related addition below where this check was
>>> originally, rather than reorder stuff you don't have to reorder.
>>
>> That was upon my suggestion. That check was originally at the top of the
>> function, but people added stuff before that. I agree that makes the
>> compatible "brcm,brcm4329-fmac" required which is what the textual
>> binding stated before the switch to YAML was made:
>>
>> """
>> Broadcom BCM43xx Fullmac wireless SDIO devices
>>
>> This node provides properties for controlling the Broadcom wireless
>> device. The
>> node is expected to be specified as a child node to the SDIO controller that
>> connects the device to the system.
>>
>> Required properties:
>>
>>    - compatible : Should be "brcm,bcm4329-fmac".
>> """
>>
>> Not sure whether this is still true for YAML version (poor YAML reading
>> skills ;-) ), but it should as the switch from textual to YAML should
>> not have changed the bindings specification.
>>
>>>   > +
>>>   >      /* Apple ARM64 platforms have their own idea of board type,
>>> passed in
>>>   >       * via the device tree. They also have an antenna SKU parameter
>>>   >       */
>>>   > @@ -113,8 +118,13 @@ void brcmf_of_probe(struct device *dev, enum
>>> brcmf_bus_type bus_type,
>>>   >          of_node_put(root);
>>>   >      }
>>>   >
>>>   > -    if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
>>>   > +    clk = devm_clk_get_optional_enabled(dev, "lpo");
>>>   > +    if (!IS_ERR_OR_NULL(clk)) {
>>>   > +        brcmf_dbg(INFO, "enabling 32kHz clock\n");
>>>   > +        clk_set_rate(clk, 32768);
>>>   > +    } else {
>>>   >          return;
>>>
>>> Why return here? If the clock is optional, a lot of systems will not
>>> have it - that shouldn't prevent the driver from probing. And you are
>>> still not handling the -EPROBE_DEFER case which was mentioned on your
>>> previous submission.
>>
>> Right. The else statement above could/should be:
>>
>> } else if (clk && PTR_ERR(clk) == -EPROBE_DEFER) {
>>           return PTR_ERR(clk);
>> }
> 
> ... plus change the function prototype to return int and propagate
> that error code through brcmf_get_module_param to brcmf_pcie_probe's
> return value. I guess checking clk for NULL is also redundant in this
> case?

Only wanted to give the suggestion to get started. Propagating the 
return value seemed obvious to me, but you are absolutely right. 
PTR_ERR(NULL) will probably be something else than -EPROBE_DEFER but it 
seems odd to me. Maybe PTR_ERR_OR_ZERO(clk) is a better option here.

Regards,
Arend


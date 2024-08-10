Return-Path: <netdev+bounces-117429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9488694DDEB
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 20:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 148721F217A1
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 18:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A304962C;
	Sat, 10 Aug 2024 18:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CEyQHuRj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACD23AC2B
	for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 18:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723314769; cv=none; b=fC8fsxSZaGPULSxzmQlIgUFqZopz/Vpst/k/Tmly+tObm7TneWbrU/0EyjtQUFXexqi1W+DqJ3o/7WWjlHK4/CxJV20yXVblfeo9qqO+RHBofs3yoyK4OSfjswso38xgXdxkiTmOKfIl3ufdj4STuKdb8sldCGt8Zp6BLfUABYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723314769; c=relaxed/simple;
	bh=VacrKqjT12DQWFLHJLsfIBg5hsy8fLzWFq+alMsvooM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qPS9CeJWEdf+DXWhg8iIO3Vsps7MlUyn+32szp1UtTwd2wcdjM5y85uu/cD0Ce/Qkz1zQIzRbeKMgqs3J9trM7WCREahkNAMW6OyxV43krBc/4k3N5AaV/NODnDs+2TQjPCU1cIh5fIeYrTDOaqQOTBWzw6IxqMP+/dWFsulz7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CEyQHuRj; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a15692b6f6so3475414a12.0
        for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 11:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723314766; x=1723919566; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u8muDajrGX3FO5dD48egl2aXV9/qSThjd9VJkKWphN4=;
        b=CEyQHuRjxHC6llSCjeeK71HNeNrRvFQBFWJGE61IYUxT20wB4okj9CowPWtn1U0yZ7
         6FEeYMAssetNYiQM89haRRqYO0c+/7orXgusqO8+KIz7epo3VBfK5sAfpqohIMt/FVn5
         OgEgW1ktP3t7nWVHX69pFXajGGrh537jt9bFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723314766; x=1723919566;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u8muDajrGX3FO5dD48egl2aXV9/qSThjd9VJkKWphN4=;
        b=F6M8CW+PRHKF54WiXb8XxfClbLyJDlkX68sun5S+7tA2TyAAQGk5Mqks5MO4cgyrOi
         LiVAEjRJCkjRZYimMr4F23XSy7tf470WCyGh7ClkBxjvPXQgehqsFu32YUJf18rgFnzG
         wPYdnFk/GyIDNwbba6x+6pA+fdSzq5LTw2yLdUdNCLTQdhf0V5EPnRvnfZxFp7rBmYkH
         lBSYmdGRinagx/VUGLT4j4yyTInEp1HGjnaoVXK6Hj6RW7JMzomk2FxYQzamQ5Ar6jf5
         +lJugGmBO8KBhY5EW2ZFpLr7uFyZIuyqZIeSARECQyorBwpUQLjRSEe7tfQp06ORkUWa
         jxQg==
X-Forwarded-Encrypted: i=1; AJvYcCWn6ao30+JCtTWYmVrqwC0ak+fR0GIN02DTp7HqRAT7fOTHIcA46Gb4P1ANiLFhFgUrJoCjn1IawFWzKWSy67V0bFiDLXRi
X-Gm-Message-State: AOJu0Yy++JuAwnq7TyYa305AHhvaVdrDTLiuSolD/pH2lCCqCQ+o94vu
	l2fL6OtB7dLthCJTIX3vNhowvLf94rzGPPf7COf+AQTWVGC4Me/mWDCawoTDNg==
X-Google-Smtp-Source: AGHT+IGop/ZoDA+Oc8+5qDzv25GL3CgFjr289f/SrTe7d5Ea2cqgNbnjGz8/e5qHIsy+G1LA+Xr+wA==
X-Received: by 2002:a05:6402:90e:b0:59e:65d1:a56b with SMTP id 4fb4d7f45d1cf-5bd0a6668camr4516382a12.34.1723314765837;
        Sat, 10 Aug 2024 11:32:45 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd187f2abasm768760a12.8.2024.08.10.11.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Aug 2024 11:32:45 -0700 (PDT)
Message-ID: <fb9947fa-bca8-4c51-9feb-bf7ac6c6cc22@broadcom.com>
Date: Sat, 10 Aug 2024 20:32:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/5] wifi: brcmfmac: Add optional lpo clock enable
 support
To: jacobe.zang@wesion.com, Sai Krishna Gajula <saikrishnag@marvell.com>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "heiko@sntech.de" <heiko@sntech.de>,
 "kvalo@kernel.org" <kvalo@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "efectn@protonmail.com" <efectn@protonmail.com>,
 "dsimic@manjaro.org" <dsimic@manjaro.org>,
 "jagan@edgeble.ai" <jagan@edgeble.ai>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "arend@broadcom.com" <arend@broadcom.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "megi@xff.cz"
 <megi@xff.cz>, "duoming@zju.edu.cn" <duoming@zju.edu.cn>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "minipli@grsecurity.net" <minipli@grsecurity.net>,
 "brcm80211@lists.linux.dev" <brcm80211@lists.linux.dev>,
 "brcm80211-dev-list.pdl@broadcom.com" <brcm80211-dev-list.pdl@broadcom.com>,
 "nick@khadas.com" <nick@khadas.com>
References: <20240810035141.439024-1-jacobe.zang@wesion.com>
 <20240810035141.439024-5-jacobe.zang@wesion.com>
 <BY3PR18MB47072A9CC7E1EEB4BD1FC063A0BB2@BY3PR18MB4707.namprd18.prod.outlook.com>
 <d9a182e4-c620-476d-8eb2-752dfd1ba4f8@wesion.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <d9a182e4-c620-476d-8eb2-752dfd1ba4f8@wesion.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/10/2024 12:08 PM, jacobe.zang@wesion.com wrote:
> 
> 
> On 2024/8/10 17:44, Sai Krishna Gajula <saikrishnag@marvell.com> wrote:
>>
>> > -----Original Message-----
>> > From: Jacobe Zang <jacobe.zang@wesion.com>
>> > Sent: Saturday, August 10, 2024 9:22 AM
>> > To: robh@kernel.org; krzk+dt@kernel.org; heiko@sntech.de;
>> > kvalo@kernel.org; davem@davemloft.net; edumazet@google.com;
>> > kuba@kernel.org; pabeni@redhat.com; conor+dt@kernel.org;
>> > arend.vanspriel@broadcom.com
>> > Cc: efectn@protonmail.com; dsimic@manjaro.org; jagan@edgeble.ai;
>> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; 
>> linux-
>> > rockchip@lists.infradead.org; linux-kernel@vger.kernel.org;
>> > arend@broadcom.com; linux-wireless@vger.kernel.org;
>> > netdev@vger.kernel.org; megi@xff.cz; duoming@zju.edu.cn;
>> > bhelgaas@google.com; minipli@grsecurity.net; brcm80211@lists.linux.dev;
>> > brcm80211-dev-list.pdl@broadcom.com; nick@khadas.com; Jacobe Zang
>> > <jacobe.zang@wesion.com>
>> > Subject:  [PATCH v9 4/5] wifi: brcmfmac: Add optional lpo clock
>> > enable support
>> >
>> > WiFi modules often require 32kHz clock to function. Add support to 
>> enable
>> > the clock to PCIe driver and move "brcm,bcm4329-fmac" check to the 
>> top of
>> > brcmf_of_probe. Change function prototypes from void to int and add
>> > appropriate errno's for return
>> > WiFi modules often require 32kHz clock to function. Add support to 
>> enable
>> > the clock to PCIe driver and move "brcm,bcm4329-fmac" check to the 
>> top of
>> > brcmf_of_probe. Change function prototypes from void to int and add
>> > appropriate errno's for return values that will be send to bus when 
>> error
>> > occurred.
>> >
>> > Co-developed-by: Ondrej Jirman <megi@xff.cz>
>> > Signed-off-by: Ondrej Jirman <megi@xff.cz>
>> > Co-developed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>> > Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>> > Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
>> > ---
>> >   .../broadcom/brcm80211/brcmfmac/bcmsdh.c      |  4 +-
>> >   .../broadcom/brcm80211/brcmfmac/common.c      |  3 +-
>> >   .../wireless/broadcom/brcm80211/brcmfmac/of.c | 53 
>> +++++++++++--------
>> > .../wireless/broadcom/brcm80211/brcmfmac/of.h |  9 ++--
>> >   .../broadcom/brcm80211/brcmfmac/pcie.c        |  3 ++
>> >   .../broadcom/brcm80211/brcmfmac/sdio.c        | 24 ++++++---
>> >   .../broadcom/brcm80211/brcmfmac/usb.c         |  3 ++
>> >   7 files changed, 63 insertions(+), 36 deletions(-)
>> >
>> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>> > b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>> > index 13391c2d82aae..b2ede4e579c5c 100644
>> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>> > @@ -947,8 +947,8 @@ int brcmf_sdiod_probe(struct brcmf_sdio_dev
>> > *sdiodev)
>> >
>> >       /* try to attach to the target device */
>> >       sdiodev->bus = brcmf_sdio_probe(sdiodev);
>> > -    if (!sdiodev->bus) {
>> > -        ret = -ENODEV;
>> > +    if (IS_ERR(sdiodev->bus)) {
>> > +        ret = PTR_ERR(sdiodev->bus);
>> >           goto out;
>> >       }
>> >       brcmf_sdiod_host_fixup(sdiodev->func2->card->host);
>> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
>> > b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
>> > index b24faae35873d..58d50918dd177 100644
>> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
>> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
>> > @@ -561,7 +561,8 @@ struct brcmf_mp_device
>> > *brcmf_get_module_param(struct device *dev,
>> >       if (!found) {
>> >           /* No platform data for this device, try OF and DMI data */
>> >           brcmf_dmi_probe(settings, chip, chiprev);
>> > -        brcmf_of_probe(dev, bus_type, settings);
>> > +        if (brcmf_of_probe(dev, bus_type, settings) == -
>> > EPROBE_DEFER)
>> > +            return ERR_PTR(-EPROBE_DEFER);
>> >           brcmf_acpi_probe(dev, bus_type, settings);
>> >       }
>> >       return settings;
>> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
>> > b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
>> > index e406e11481a62..f19dc7355e0e8 100644
>> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
>> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
>> > @@ -6,6 +6,7 @@
>> >   #include <linux/of.h>
>> >   #include <linux/of_irq.h>
>> >   #include <linux/of_net.h>
>> > +#include <linux/clk.h>
>> >
>> >   #include <defs.h>
>> >   #include "debug.h"
>> > @@ -65,17 +66,21 @@ static int brcmf_of_get_country_codes(struct device
>> > *dev,
>> >       return 0;
>> >   }
>> >
>> > -void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
>> > -            struct brcmf_mp_device *settings)
>> > +int brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
>> > +           struct brcmf_mp_device *settings)
>> >   {
>> >       struct brcmfmac_sdio_pd *sdio = &settings->bus.sdio;
>> >       struct device_node *root, *np = dev->of_node;
>> > +    struct clk *clk;
>> >       const char *prop;
>>
>> Small nit, please check if reverse x-mas tree order need to be follow 
>> here.
>>
>> >       int irq;
>> >       int err;
>> >       u32 irqf;
> 
> It can be seen from this line that there should be no need to follow the 
> reverse x-mas tree order. Because it is a struct variable, so place with 
> other struct ones.

As driver maintainer I do not care about such neatness, but maybe Kalle 
has another preference. The code above looks fine to me.

Regards,
Arend




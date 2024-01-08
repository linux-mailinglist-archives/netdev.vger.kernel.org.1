Return-Path: <netdev+bounces-62303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 469A9826865
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 08:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 390D3B20B1B
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 07:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9535879EE;
	Mon,  8 Jan 2024 07:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="phI3eXm5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639DFB661
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 07:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cd0f4f306fso15931381fa.0
        for <netdev@vger.kernel.org>; Sun, 07 Jan 2024 23:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1704697559; x=1705302359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+W5MR0GZTvvVT7Ez94bP6YWkWN8S36H3wYikt4HSl4Q=;
        b=phI3eXm59qPP0jQ8DwkFvWbXhXYGoID3/wYE1adMQ60hFPVf6xzqQ+lSTk9whbAidC
         Kjmx36XSDGf+EE+n2rEIXlOMb/CAOidVvXyLYhhA4w1jMg8853SSEOSk+P+mtgVmk5lw
         kKldn4woAzVrFPtjQD85wE/VDnrQhV8slyl/ttwnrkqDwh+zzQW+Yti9pUcVsowqnIVr
         Dmdu0tpwtA+XMQL9syRoUcK7f2tjTB0tfzQmFTIi2Ice1U00oX4IGZURPOZQJ4qYiajn
         puZzodbWzUYfukddEviLWRv7JXXoP/d52KCLGZsZu7PtF8Mea7GZkRruSrYegAUD2FPd
         lrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704697559; x=1705302359;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+W5MR0GZTvvVT7Ez94bP6YWkWN8S36H3wYikt4HSl4Q=;
        b=maTIA9WEVG5Cc/fi9Yc1CZ2LnqQw06ydGosN5C9ERw/7MnxfjWBK+iQ6f+EAXNXrQZ
         z1+c1RFJz1IX7ccproSY1l6DtB6YcPwyCy6IJPEdFuHd64adB9X4G9xupz7WTv4JNg+m
         lvx5XyIQ5vyK5gTvp4Re5ltpAwoatsV3YrqYTE9f65C0XhHH4GuG+rMvE4xkkioO0XPO
         GpyUkpDdpN19VSGX/b794qUhYVLo+Up+JdwLowx7fNK2Gu0z0Bh3PEwYnKOhq1YeJqs6
         PvvJcjqcjjl+zHM0K0hMKAPwbbeqPAofx+3ZlEwJqyC2RRvhJV6uINjjDZBOuX0q8ESQ
         fLEg==
X-Gm-Message-State: AOJu0YzFN1EZ9P2im2qqWy02ZFe2P4NqeX/Tx6Q9qJDYB9K6s9q8rLFV
	fW6+avmpuLaxcbDjyr6xEY369Lv6HsblJw==
X-Google-Smtp-Source: AGHT+IF2PtwQKrEqWSIs9T+bjTD2KsvisYFdWZg8Aq53R2YUIdp6yibADBbGYZSvkWNnhjOzoyIUyg==
X-Received: by 2002:a05:6512:b23:b0:50e:a942:e6f3 with SMTP id w35-20020a0565120b2300b0050ea942e6f3mr1367517lfu.10.1704697559144;
        Sun, 07 Jan 2024 23:05:59 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.5])
        by smtp.gmail.com with ESMTPSA id ez10-20020a1709070bca00b00a28a7f56dc4sm1063479ejc.188.2024.01.07.23.05.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jan 2024 23:05:58 -0800 (PST)
Message-ID: <bd76083f-c1de-4581-820c-50d9084b3942@tuxon.dev>
Date: Mon, 8 Jan 2024 09:05:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 03/19] net: ravb: Make reset controller
 support mandatory
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 p.zabel@pengutronix.de, yoshihiro.shimoda.uh@renesas.com,
 wsa+renesas@sang-engineering.com, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 geert+renesas@glider.be, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com>
 <20240105082339.1468817-4-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdWTE=AUEd5iqd4Qm04sgFcGtHkbYEQJH9A=qPWph=S4+g@mail.gmail.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdWTE=AUEd5iqd4Qm04sgFcGtHkbYEQJH9A=qPWph=S4+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Geert,

On 05.01.2024 11:38, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Fri, Jan 5, 2024 at 9:24 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> On the RZ/G3S SoC the reset controller is mandatory for the IP to work.
>> The device tree binding documentation for the ravb driver specifies that
>> the resets are mandatory. Based on this, make the resets mandatory also in
>> driver for all ravb devices.
>>
>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>> @@ -2645,7 +2645,7 @@ static int ravb_probe(struct platform_device *pdev)
>>                 return -EINVAL;
>>         }
>>
>> -       rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
>> +       rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
>>         if (IS_ERR(rstc))
>>                 return dev_err_probe(&pdev->dev, PTR_ERR(rstc),
>>                                      "failed to get cpg reset\n");
> 
> Upon second look, you also have to make config RAVB select
> RESET_CONTROLLER.
> Currently, you can build an R-Car Gen[234] kernel with RESET_CONTROLLER
> disabled, causing devm_reset_control_get_exclusive() to fail
> unconditionally.

ok, I'll update it. Thanks!

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 


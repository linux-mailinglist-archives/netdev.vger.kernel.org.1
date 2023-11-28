Return-Path: <netdev+bounces-51564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F567FB28D
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 08:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF199281C41
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 07:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C862412E4D;
	Tue, 28 Nov 2023 07:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="g07ucgNF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C277FD4B
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 23:19:25 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40b4a8db314so5108725e9.3
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 23:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1701155964; x=1701760764; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0O6zkzqcbMXlk51y4qrd5QMvvb/RA7s3YqrHm2H8b8s=;
        b=g07ucgNF2LPg6dltMpU375rif5bDG3ZExzY2cjdjiTWV81RIsfMliqyICRuenVzTUh
         wn/e3ZyRmb8i+q17MdQnTkThENDaO9WdJOqa+tA/gcffCL9rriCgnOp0SWEwc2ywIXtM
         usxiPKh69JpcZEYyoXXCgoZxLMAKwID+xUu/BV1sFUSJujKC1iHiqVuDlNEHUhnZVtTb
         hu4KwMYA6PTnfV2+tPQ3XjiOG0YYHf/KcSKg1VQsoo9jdk+RvKKYlhicCAtASjhW/WNI
         o/FE93WJ9T0MtmNjgfZLDsPzbY4zqkgBlfyZlGkyqW1FEgYbepp+h8D0ibLwcgjhYIoS
         H2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701155964; x=1701760764;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0O6zkzqcbMXlk51y4qrd5QMvvb/RA7s3YqrHm2H8b8s=;
        b=GOrZY17Wmyz0BQ9vg45DpucF3qojL8cjuDaZaFoFLwfi+DGGETASyEKzWsEiPp+zER
         5/teMZVKgNHF+aFF03sx9OfWvhQsoaXR5PrKGa7NUtOIBEx3h6EwkB+w7CJOq4W7k3l7
         h5IPqeMhRwtgehsWwhUDLL4sfxeBGePU0rVg4c6xaaJ/hR1ItbMMdmo5IzdIHNl+lL5e
         sLBs2Fa2RdRb0zWC7JJe/IVtcr2jFxk4v2V0U5hPjRURfmO/BjwOUofkIHIC748Igiz5
         udZ8xvofUp4m7j9cPvZiVnciK/io0lJIQS40BO1cNde/OqmqS+uf4lHD5uzA0Q/6CKYV
         M9ow==
X-Gm-Message-State: AOJu0Yxi+1IqRFu7+H+/jFZ11fN2ArBs2Poo3jIukxCWl1WFgezwgY4h
	gH+UzTLgbpW7I4mgMldVTgjXxQ==
X-Google-Smtp-Source: AGHT+IF5taK0NZHqg4xe1+c8aXbHW/UIOdJy182/wWh13QjbphEIYyGBNwkaFNNSrctEIo5miCp7kg==
X-Received: by 2002:a05:600c:3b16:b0:40b:4007:11f1 with SMTP id m22-20020a05600c3b1600b0040b400711f1mr6444085wms.11.1701155964070;
        Mon, 27 Nov 2023 23:19:24 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.125])
        by smtp.gmail.com with ESMTPSA id s9-20020a05600c45c900b0040b3829eb50sm14869836wmo.20.2023.11.27.23.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 23:19:23 -0800 (PST)
Message-ID: <20811ebf-04e0-4196-9d0e-bd46a88065dd@tuxon.dev>
Date: Tue, 28 Nov 2023 09:19:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] net: ravb: Check return value of
 reset_control_deassert()
Content-Language: en-US
To: Sergey Shtylyov <s.shtylyov@omp.ru>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, p.zabel@pengutronix.de,
 yoshihiro.shimoda.uh@renesas.com, geert+renesas@glider.be,
 wsa+renesas@sang-engineering.com, robh@kernel.org,
 biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 mitsuhiro.kimura.kc@renesas.com, masaru.nagai.vx@renesas.com
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20231127090426.3761729-1-claudiu.beznea.uj@bp.renesas.com>
 <20231127090426.3761729-2-claudiu.beznea.uj@bp.renesas.com>
 <b23a5e0c-cc55-b7b2-a6dc-1eac0a674814@omp.ru>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <b23a5e0c-cc55-b7b2-a6dc-1eac0a674814@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 27.11.2023 18:39, Sergey Shtylyov wrote:
> On 11/27/23 12:04 PM, Claudiu wrote:
> 
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> reset_control_deassert() could return an error. Some devices cannot work
>> if reset signal de-assert operation fails.
> 
>    Well, I think all devices can't work if the reset line is connected at all. :-)

I was thinking at the fact that the de-assert support was added just 2
years ago, while the driver seems to be ~8 years old.

> 
>> To avoid this check the return
>> code of reset_control_deassert() in ravb_probe() and take proper action.
> 
>    I'd also mention moving of the free_nedev() call...

ok

> 
>> Fixes: 0d13a1a464a0 ("ravb: Add reset support")
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> [...]
> 
> MBR, Sergey


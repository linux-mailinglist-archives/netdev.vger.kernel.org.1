Return-Path: <netdev+bounces-62893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6330F829B10
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 14:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03744B21167
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 13:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4034A4879B;
	Wed, 10 Jan 2024 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="mhD0fveQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A913748CC0
	for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 13:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3376555b756so2376651f8f.0
        for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 05:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1704892659; x=1705497459; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vszx2G9uELuU9hK0zj2S4/o3kowknqBc1/GUoklXrQI=;
        b=mhD0fveQa7CF90Ky9sh1YCxbb3rlxicaqTGfktrGiPCkLetzcuZ2kkJjWINHjNedZi
         /eTXv5QcR1H47zBlFYItCeuJBTWHnORKSaiCCf+AWv6wTMj0KQpvF+q2aRElBf9TPIfa
         nPH6QwJfdC7hb9FmhtgG7aR891OF4R7zvwgTcBFewmaOnw9Mlu6ONQ9CSBrX9IRleyj7
         cFeBBIPgAIVG9WOpPxmMKHmnHQx5y1cyFybyO/hRBXsoIOw5KWJIBrnuGT5xT6m7dCG4
         dLgkYZjY3Rw4FJ67pQEcHK5Xxf2+eJgAYWVh/++CuzZ3yplVokvyfRuignYc2bLvh3ss
         xJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704892659; x=1705497459;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vszx2G9uELuU9hK0zj2S4/o3kowknqBc1/GUoklXrQI=;
        b=UTrmzOU1qKXqRUsaEoLQRoG3dKkZo+mR1SR1SfZGDfrSmZ8MqFiszqPWJv5cyRdOMO
         ST2tK7yyN9ZQxZ28ydTOCA6isPVqkkIWL5dopaKUBomzMzuQpSZYjTvEdipfuZ2v5JRw
         iPr4vYiHKhRrR+2J8D/7JhoeSMX2CyXekPe0cMg2nQIMTzZGjvz3+TOd+fbtd5mqCCaw
         2lLtn7BuR+VGS5Y4e7Cpqg/MwBSlUOFLwh8WrNsKFkY9XChwC+//YlzD4rYhJCkEryH/
         RuVaOofwnzkXOoE3YFnCp51MVuSOcJbBBpFyDugO5ZrD3xg8UKzs+z+eXOB2J9jMkvom
         Ed3g==
X-Gm-Message-State: AOJu0Yys5hBMqmKy0WZ11kHi6ExJBmf50F0uWrdh4fnVNWnNufBOrati
	ZurEk8NaQ3A/lgu9gYvfACttPgu7Vx555Q==
X-Google-Smtp-Source: AGHT+IG0xqvK/uM4BvzNCZURD1QaAj22eknZfkbaekHf4jMRg2ppp46KcuhVFANDknFKAjAN6yVkKg==
X-Received: by 2002:adf:b182:0:b0:336:5b1e:ee66 with SMTP id q2-20020adfb182000000b003365b1eee66mr20524wra.31.1704892658708;
        Wed, 10 Jan 2024 05:17:38 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.5])
        by smtp.gmail.com with ESMTPSA id z15-20020adff74f000000b0033740e109adsm4920854wrp.75.2024.01.10.05.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 05:17:38 -0800 (PST)
Message-ID: <aed6534b-ad5e-4f5c-9861-9a784968adcc@tuxon.dev>
Date: Wed, 10 Jan 2024 15:17:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 17/19] net: ravb: Return cached statistics if
 the interface is down
Content-Language: en-US
To: Sergey Shtylyov <s.shtylyov@omp.ru>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, p.zabel@pengutronix.de,
 yoshihiro.shimoda.uh@renesas.com, wsa+renesas@sang-engineering.com
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, geert+renesas@glider.be,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com>
 <20240105082339.1468817-18-claudiu.beznea.uj@bp.renesas.com>
 <af5ab82e-5904-c33b-983e-b37844dab3f5@omp.ru>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <af5ab82e-5904-c33b-983e-b37844dab3f5@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 08.01.2024 22:22, Sergey Shtylyov wrote:
> On 1/5/24 11:23 AM, Claudiu wrote:
> 
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Return the cached statistics in case the interface is down. There should be
>> no drawback to this, as cached statistics are updated in ravb_close().
>>
>> The commit prepares the code for the addition of runtime PM support.
>>
>> Suggested-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> [...]
> 
>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>> index 76035afd4054..168b6208db37 100644
>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>> @@ -2117,6 +2117,9 @@ static struct net_device_stats *ravb_get_stats(struct net_device *ndev)
>>  	const struct ravb_hw_info *info = priv->info;
>>  	struct net_device_stats *nstats, *stats0, *stats1;
>>  
>> +	if (!(ndev->flags & IFF_UP))
> 
>    Well, I guess it's OK to read the counters in the reset mode... BUT
> won't this race with pm_runtime_put_autosuspend() when its call gets added
> to ravb_close()?

I re-checked it and, yes, this is true. A sync runtime suspend would be
better here. But, as of my current investigation, even with this
ravb_get_stats() can still race with ravb_open()/ravb_close() as they are
called though different locking scheme (ravb_open()/ravb_close() is called
with rtnl locked while ravb_get_stats() can be called only with
dev_base_lock rwlock locked for reading).

A mutex in the driver should to help with this.

Thank you,
Claudiu Beznea

> 
>> +		return &ndev->stats;
>> +
>>  	nstats = &ndev->stats;
>>  	stats0 = &priv->stats[RAVB_BE];
>>  
> [...]
> 
> MBR, Sergey
> 


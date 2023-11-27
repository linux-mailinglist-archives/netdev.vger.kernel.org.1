Return-Path: <netdev+bounces-51209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAD37F991A
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 07:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7242BB20A09
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 06:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD35747F;
	Mon, 27 Nov 2023 06:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Uh1l1gXP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F84E1
	for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 22:11:20 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a00a9d677fcso516967066b.0
        for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 22:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1701065479; x=1701670279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SHtEQi8g8hzQmGEKqbL9kvJSOxbU+L25q3WrEMfx6eQ=;
        b=Uh1l1gXPo7uM8iGaJofaS8/4NydXffpDdIQmWcgijf7grcElrxTzECzpDTQawXa/oI
         m1fK4P03WRWJydU808yf9q1hOn5AB1LJA8ownmlo9Wvy4rIkruhdOEg6I4fUlbqUHWkW
         iEfYFznnlUlvkcISwAQus/jYl3gqEP8XdwUpEfC7bysajtxxUfDu0Jh+wUCLiMUF3sGK
         0o4eeAL0enBGO4c87vfPqmt0HWF76WBAzDgA0AMNGuuFH6hctNsXJNLTPEtr5QuNfWna
         3RAU3HhgNM98WYp327BTbCb6wZ4dKrI7zSkYnyPLufEeDdEJxoKsN3OPEskD1iPXfJqC
         2I/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701065479; x=1701670279;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SHtEQi8g8hzQmGEKqbL9kvJSOxbU+L25q3WrEMfx6eQ=;
        b=BkWFV/HJu31yvfqqpok7UttXtoA4RwhF5OIDG1NAOxm4aDLnDcaWLGhAR/AinnYd8K
         7BJgKbNGknuw/ovISbifkIPziC2d7VUMF+8HIIOQjFvexAT2YfSn+tykjzpAvGtSvovx
         pDvGkhuFnb9z1yCFyxLqEJbsbF7weSYnPhCHMFpKjHENZAxf5eGXaSfJXzUd8ZoDBhjQ
         BtiLkdgnIyfySCVRqgwNVDI+rXYeEPhm9gXvhjW+zuB2FHMlfzQig2IHiiFkmHlOBYAw
         +9jvt0xz99P2ePKQC6IjcEi4oQtj8Kir/KpKoRWK9YTHZrN34ZuWl1d6t87q0dEZy4+U
         6V9A==
X-Gm-Message-State: AOJu0Yz+Wuj07H9EAFtJOhnDq4kiJITWewo56Fo5P12VLKZifdYl7Zpr
	+ZOU9cutHp5LONq3dOBBS2lMJg==
X-Google-Smtp-Source: AGHT+IHDT8N++R7ZLkzcyLrDWB71eEFcl94wuhPsn7nZeHq/4nGrhvFaJXjkUFoAUv4VU1TMjwiX9g==
X-Received: by 2002:a17:907:1255:b0:9de:32bb:fa95 with SMTP id wc21-20020a170907125500b009de32bbfa95mr5686417ejb.35.1701065479311;
        Sun, 26 Nov 2023 22:11:19 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.125])
        by smtp.gmail.com with ESMTPSA id 20-20020a170906319400b00a097c5162b0sm3840401ejy.87.2023.11.26.22.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Nov 2023 22:11:18 -0800 (PST)
Message-ID: <7ea4c3fe-a911-4161-af13-7f1d55def7e3@tuxon.dev>
Date: Mon, 27 Nov 2023 08:11:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net: macb: Unregister nedev before MDIO bus in remove
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: nicolas.ferre@microchip.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, jgarzik@pobox.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231126141046.3505343-1-claudiu.beznea@tuxon.dev>
 <20231126141046.3505343-3-claudiu.beznea@tuxon.dev>
 <086fc661-0974-4bb6-a8ae-daa9d53361d9@lunn.ch>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <086fc661-0974-4bb6-a8ae-daa9d53361d9@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 26.11.2023 19:13, Andrew Lunn wrote:
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
>> index cebae0f418f2..73d041af3de1 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -5165,11 +5165,11 @@ static void macb_remove(struct platform_device *pdev)
>>  
>>  	if (dev) {
>>  		bp = netdev_priv(dev);
>> +		unregister_netdev(dev);
>>  		phy_exit(bp->sgmii_phy);
>>  		mdiobus_unregister(bp->mii_bus);
>>  		mdiobus_free(bp->mii_bus);
>>  
>> -		unregister_netdev(dev);
>>  		tasklet_kill(&bp->hresp_err_tasklet);
> 
> 
> I don't know this driver...
> 
> What does this tasklet do? 

It handles bus errors that my happens while DMA fetches data from system
memory. It re-initializes the TX/RX, DMA buffers, clear interrupts,
stop/start all tx queues.

> Is it safe for it to run after the netdev
> is unregistered, and the PHY and the mdio bus is gone? 

Not really, as it accesses netdev specific data.

> Maybe this
> tasklet_kill should be after the interrupt is disabled, but before the
> netdev is unregistered?

That would be a better place, indeed.

Thank you,
Claudiu Beznea

> 
> If you have one bug here, there might be others.
> 
> 	Andrew


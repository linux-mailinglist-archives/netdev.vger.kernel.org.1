Return-Path: <netdev+bounces-195517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F32CAD0E8E
	for <lists+netdev@lfdr.de>; Sat,  7 Jun 2025 18:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117841888A60
	for <lists+netdev@lfdr.de>; Sat,  7 Jun 2025 16:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C871DB551;
	Sat,  7 Jun 2025 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhBXPxmd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111B517333F;
	Sat,  7 Jun 2025 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749313474; cv=none; b=I2AX1MqaSz/QJ9HrP0KTPseW64R04qA12mpMfDRVhU+tGoyW8M/fOhVk53Q1EWl3ddMoq/uUPXrj01SHxJSpTV1w6w3ZF9Xt9k93I/OskVEuFkzrUlLxyI3GAqJ2TQeITn9zL2Bptua//UGECnGY98VmdvdE+xpo5ZJkk2nzhRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749313474; c=relaxed/simple;
	bh=3bU5yjFVV7T2otPUrIkTee3DVZ2qTrxSCWneSSL1sxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i3N+NI66Li3Whr/Dta+ZUCp3HGKr9+NPpZ/aBD3EX/NkjBs3bvvJd3RiVoJHFZx1ty2eB7xnLEx0d16HZcHWSH1Fh2fP8n91ImF0qVyTPq4vb6udmbmFcRcrlKUZQNkHyZTHXjDmhbxew4xZW8bGL+yqpqXHE0hzbxrxxplWays=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhBXPxmd; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a510432236so2354147f8f.0;
        Sat, 07 Jun 2025 09:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749313471; x=1749918271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gWvqpwxBQgeNeqBRUmbQp9k01HnTrsFJhw9gb80zZD4=;
        b=HhBXPxmdFfVo8gf3Y31lqTpd7d59UYorfiD5PPgW2S/ASljTlEJj+5RjnXkDXn4M6N
         L82GpgT8nYVPW0xeJCDyuH4pmTVEdugQ4oKajOUa+ygVzqzj9A3cvSvprhoC7bnfyFIO
         qBqwDhhtSZFL1Izm3Dn/C1HLq/70OlVVhbTd/fYfhNZJw/nk10rsK7S3DMBT7Cyr09Y3
         POcYo6WIPcBr/W9vUERcV3es5kVfaaBD89aFCo6CRnh0DcSS5Vn8RP2Hx2wbzqLfphc0
         l0ZLCWGBoBtzCW811S5DaeEfjis+GHTEYIuWuDUJVZvDpptCZqIEZQFkBWj109fXWqdp
         +ucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749313471; x=1749918271;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWvqpwxBQgeNeqBRUmbQp9k01HnTrsFJhw9gb80zZD4=;
        b=A5VS/JoYk95zfB/3OUlAqZyV9T3xVFWcSKD9RSV00k3oY7UWQ/alyjPx5ds4DQ3lR0
         Y6BUAfgpfgukS4Gsm5MtHx3kRaKUjVIiJ/4Ka6NCJzWbghLPSfbFvvMhyURwbISRVESe
         DsW9uu9uYDP6AleRIbpJJD8bkUgKFo84pFvWCthkNESvN/yX2MRg1a6SDg0AP/7gKCGh
         4yp02/+CY/bXNGj1n0HdMuuYgspXIUmE1XvZXdSGr+5S01HGyFl9bOwY//YgwEbTZD1E
         hU4UyvHF08eBdaMaNvDMR0Bl5nwewW0Ge2aBeooS9vGNkW0LvaBdErIDCyB8C1IblNT3
         NRhw==
X-Forwarded-Encrypted: i=1; AJvYcCXOmd8pnyMqg8a+Hh8JxnZXgTMCb+PEgIZ/v3tJigb8nqxqaES6PRfKNxGX8SgV890ovpnF32f8@vger.kernel.org, AJvYcCXfGG+BYsmO9bHvQFpvELVNcwhC/Jrl0SwJpdD7y+Q8L+ilYtWZlT/2xPxXP+Wi6nXAohNIFy2SkwE398A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5PTDl47N1pVpyOYL/Te9QIBfL1Bvv0UlCVgRIShWNSocq+oxK
	guduCAqhIobew3ADKuq4FDhY9CIV/4KnDFZ8HdfKPZb09jMcDH3Xl4Ok
X-Gm-Gg: ASbGncuMjzdQFL0QteuCyxAh9+Ms5N0AVbQE+BOZERMKdKhL0HU94STNi1e7KcJ8fAe
	ChLcYFjz+lyiEqgv0zB4pdDttC7Zn+k6fc2R9TXJZj9wK9BvjvRikFlkY67YxZr64pbN6fMGm8I
	UNyXP3zNSVJEPpc+gWtojjOHTozzteFQHEP6tt7z90o/Nysx4kV0JsmQwEn1x7an/C7icIe0FGZ
	WvUIKKz73r5Z/Q9+xHGZRRDWhur7qZbXLydRWo2TX2HBDM834zn1nkKAnrC7j3IflrfJDZvZS6o
	96jZvYYLxyUFYPUUl3q3HsIQNXwP04MXhoZt9LwZ0LjO5AQPORIE8MN0KtPKjFIMkIOmUWavObE
	cLTnE4nuY9jgGaR4ZwkpXRidO3bZhFCUGrDCh0YeJVIRkMto0GBgFse7/Wu98JjJBmbqAM/vBm8
	0NY29yD1u/EmdBGPs=
X-Google-Smtp-Source: AGHT+IGiCuIu7EP2zMdEElFmvY/k+sS3SQuLkI6GARQoDErWLlLxYyz5XijaT2PdQ13xHoEdmn/7MA==
X-Received: by 2002:a05:6000:2204:b0:3a5:2e84:cc7b with SMTP id ffacd0b85a97d-3a5319b17b3mr6789653f8f.11.1749313471158;
        Sat, 07 Jun 2025 09:24:31 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f0c:9700:a5c6:969e:f94f:61ea? (p200300ea8f0c9700a5c6969ef94f61ea.dip0.t-ipconnect.de. [2003:ea:8f0c:9700:a5c6:969e:f94f:61ea])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a5324641c2sm5005784f8f.93.2025.06.07.09.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jun 2025 09:24:30 -0700 (PDT)
Message-ID: <129a670d-14b5-4f9e-b01b-0a88a0017741@gmail.com>
Date: Sat, 7 Jun 2025 18:24:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: macb: Add shutdown operation support
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Abin Joseph <abin.joseph@amd.com>, nicolas.ferre@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: git@amd.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250607075713.1829282-1-abin.joseph@amd.com>
 <07d527e5-32d9-4e8c-ad19-92f5a722bfd5@tuxon.dev>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <07d527e5-32d9-4e8c-ad19-92f5a722bfd5@tuxon.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07.06.2025 14:28, Claudiu Beznea wrote:
> Hi, Abin,
> 
> On 07.06.2025 10:57, Abin Joseph wrote:
>> Implement the shutdown hook to ensure clean and complete deactivation of
>> MACB controller. The shutdown sequence is protected with 'rtnl_lock()'
>> to serialize access and prevent race conditions while detaching and
>> closing the network device. This ensure a safe transition when the Kexec
>> utility calls the shutdown hook, facilitating seamless loading and
>> booting of a new kernel from the currently running one.
>>
>> Signed-off-by: Abin Joseph <abin.joseph@amd.com>
>> ---
>>
>> Changes in v2:
>> Update the commit description
>> Update the code to call the close only when admin is up
>>
>> ---
>>  drivers/net/ethernet/cadence/macb_main.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
>> index e1e8bd2ec155..5bb08f518d54 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -5650,6 +5650,19 @@ static int __maybe_unused macb_runtime_resume(struct device *dev)
>>  	return 0;
>>  }
>>  
>> +static void macb_shutdown(struct platform_device *pdev)
>> +{
>> +	struct net_device *netdev = platform_get_drvdata(pdev);
>> +
>> +	rtnl_lock();
>> +	netif_device_detach(netdev);
>> +
>> +	if (netif_running(netdev))
>> +		dev_close(netdev);
> 
> Apart from closing the interface should we also invoke the remove?
> 
As part of closing the interface dev_close() sends notifiers.
I don't think that's something we want during shutdown.
Typically the shutdown() callback just has to quiesce the device.

> Consider the new loaded kernel will not use this interface and some
> hardware resources may remain on while not used by the newly loaded kernel.
> 
> E.g., there is this code in macb_remove():
> 
> 		if (!pm_runtime_suspended(&pdev->dev)) {
> 			macb_clks_disable(bp->pclk, bp->hclk, bp->tx_clk,
> 					  bp->rx_clk, bp->tsu_clk);
> 			pm_runtime_set_suspended(&pdev->dev);
> 		}
> 
> 
> Thank you,
> Claudiu
> 
>> +
>> +	rtnl_unlock();
>> +}
>> +
>>  static const struct dev_pm_ops macb_pm_ops = {
>>  	SET_SYSTEM_SLEEP_PM_OPS(macb_suspend, macb_resume)
>>  	SET_RUNTIME_PM_OPS(macb_runtime_suspend, macb_runtime_resume, NULL)
>> @@ -5663,6 +5676,7 @@ static struct platform_driver macb_driver = {
>>  		.of_match_table	= of_match_ptr(macb_dt_ids),
>>  		.pm	= &macb_pm_ops,
>>  	},
>> +	.shutdown	= macb_shutdown,
>>  };
>>  
>>  module_platform_driver(macb_driver);
> 
> 



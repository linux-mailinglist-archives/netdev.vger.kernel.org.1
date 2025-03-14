Return-Path: <netdev+bounces-174847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF935A60FEA
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 12:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605E51B635E0
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 11:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9B41FA243;
	Fri, 14 Mar 2025 11:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyxj2TJy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B591F5420;
	Fri, 14 Mar 2025 11:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741951587; cv=none; b=gyzZ2ZxXFO4ld7Vvq5il3a01apF9miIQriP57pOsTRgSw9mNHtFtSjGXt8MZUhXjH7DPk9rufV2vY74Oq1s8053TCFHapE8UJt+FW8Ii/tWKnz4bS8FlXFUYWt8Quy35W2h6Rs83bZNTSJ7aUkBZpdTC0MAvsjd/3xu0MtK0JSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741951587; c=relaxed/simple;
	bh=4ntD1cwFdaQcLnh2bwJuR/GuC6o+bxGys8jSPxAo8Eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r0bdZWXhh/UK9bLNlH2l0iklkezSASvZ/gIvdLOqeZ9caOu+kfeh0kwveQNmOXBfgOeRpER/GS2OKPX45eHC4kN/ykV6q5ypPePrBkKR18+t0+RpZ0ZEft+ooGoCkK46NzgbDkBcyVWstenoUli16g/D4YnGq2FW1ywHrTtHDSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyxj2TJy; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3913cf69784so1693832f8f.1;
        Fri, 14 Mar 2025 04:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741951584; x=1742556384; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KE3xg+7mLecpB+0WFc0EAlR8lfnEYh8APc9w0z2bxJo=;
        b=fyxj2TJyLnmV/KLgsSW/judIEfpIw+rnd8OyPCQLo8NrPXgdm5h1u+P3WiBqiHGrti
         5Nxtl46Y/V/e8sOkVHQAqWa+vhteOh3LzrIOIHyXdmC88XDYU70k7zNCzFtZmqmUaE6j
         SWn26wjDvkv4Y44Xk5Gp2avRbZpr+Ax+YK2RCj86vCu5WhOAkI6+/Mg988Lcbno27Nkh
         OUDwlpA76B3aEqIVugWYR+SdyL0QJXtQQv9QhBaz2jmoi3anay0bGBheeUcE47lLpBCQ
         D4jWrIsG9Go0l4mLdNfOM5dAGCC3C+AmJcDfDmjKglXbFVZpZjSVGjNxFBvOr/2qo0Oq
         YFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741951584; x=1742556384;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KE3xg+7mLecpB+0WFc0EAlR8lfnEYh8APc9w0z2bxJo=;
        b=RwEPn6AXwpyo5ojeRpoxrq866vmsjpGpNSE5gQ65FUppf4ICKencTYT/fxKISP/KRd
         6L0Wgsle4upfE/ci0Q2FfNMZn8MEjuVqKDwd5f9JAVV90WGqY4eJDkV1sARcoDUOBVHM
         qUgqdKR4+b2arIyOs31VnUDifFIkn66O7CccjJeuu9Z1OZ8tweCTvu6lXpnQQbklZe0N
         m7O1qpkRe78R+hUUzmhm0De3o5WQMtWlM6qX2dcu31XZQbiPA19w03mwfhTk43KiOMNc
         NauVn13cdVWXiwON9283ON64uxjCgZ8yRnbKYBo+wd54OBY/ogun156DhjwVVub0kmLO
         b9NA==
X-Forwarded-Encrypted: i=1; AJvYcCUaRIH06ciqIQ1sXRDeiMj2MJ88KymDWWDrnye8F4QkLa83WiRWweGHoq60El+QBUba7j8YjLFMSt9geA==@vger.kernel.org, AJvYcCV4DJue4jFhty3qi3Fk55u790QiO1ZucqYGnnNnoE08U3ksrI2SoOsfdjesQn7XyYrBUb9re4MY@vger.kernel.org
X-Gm-Message-State: AOJu0YyOLoyi69DK1QjKx3tX07E8Mdlrt7xzyCNqn4gm7HIhO/+GOA31
	JdzL2HmbUQp1Rr76cSZ0oTbNVhUeJHVAj6+nGa+/jrLLohWIsV5w
X-Gm-Gg: ASbGncuTKgYEu4Tjn0gwY2VJ08R8Ojbm621oydbPtr/0gDtqucWO08wTyYlJtLxG5/E
	TI2ZbAwoEeIPCk+gNAtl3GMzX702KuiV6rOIEaUzJo5GSgzL4mSoFdWRWWW3wurK4/jsLS9Z88C
	wPNg4OW+goel9eq91XOL2I0/+MXC1IbqsmopJcDYdzXNdH9dUqDt6u9bvY2VZyAKMMFkkIXTYxl
	Fk+Tm1VBeYQR4/MbeVRkwuWqbIfCVo9zns+lPdQDMDV4dmpznx5C5XYkRRan2KX8U3iBIUIA/aG
	9IHO8iFDOu8oy1lIzsCdQTJOTfOHpgemn47GY5/2nUZ1oET2wKnC2KL0xR5pHVj3MtiQTNuBfoH
	GxBBRZ2Yur10HBvuG6kUCHIant02wVQ0O5Da7fPEXCN1Q+6HZl/r56eRljll/auhhC+ICrdmuk3
	PG+eD3OpZf2ZgbkQKRGEi6HPg6ziYkiYDLVw==
X-Google-Smtp-Source: AGHT+IHOdvibFKm3jVEMp6vbeZRkccq3Vd64WZb5LCwbnOkKBkfgGB6cay2gT4t53qL+ywQr8n2UeA==
X-Received: by 2002:a05:6000:2ad:b0:391:306f:57de with SMTP id ffacd0b85a97d-3972077867bmr2706231f8f.45.1741951583855;
        Fri, 14 Mar 2025 04:26:23 -0700 (PDT)
Received: from ?IPV6:2a02:3100:acc2:9400:c68:8c54:c04c:f0e3? (dynamic-2a02-3100-acc2-9400-0c68-8c54-c04c-f0e3.310.pool.telefonica.de. [2a02:3100:acc2:9400:c68:8c54:c04c:f0e3])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-395cb7eb9d7sm5145012f8f.89.2025.03.14.04.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 04:26:23 -0700 (PDT)
Message-ID: <5bb890a8-6436-4aa9-a5ea-5377c67a1d2d@gmail.com>
Date: Fri, 14 Mar 2025 12:26:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/4] net: phy: tja11xx: remove call to
 devm_hwmon_sanitize_name
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Xu Liang <lxu@maxlinear.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
References: <198f3cd0-6c39-4783-afe7-95576a4b8539@gmail.com>
 <4452cb7e-1a2f-4213-b49f-9de196be9204@gmail.com>
 <20250314084554.322e790c@fedora-2.home>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20250314084554.322e790c@fedora-2.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14.03.2025 08:45, Maxime Chevallier wrote:
> Hello Heiner,
> 
> On Thu, 13 Mar 2025 20:45:06 +0100
> Heiner Kallweit <hkallweit1@gmail.com> wrote:
> 
>> Since c909e68f8127 ("hwmon: (core) Use device name as a fallback in
>> devm_hwmon_device_register_with_info") we can simply provide NULL
>> as name argument.
>>
>> Note that neither priv->hwmon_name nor priv->hwmon_dev are used
>> outside tja11xx_hwmon_register.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/net/phy/nxp-tja11xx.c | 19 +++++--------------
>>  1 file changed, 5 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/net/phy/nxp-tja11xx.c b/drivers/net/phy/nxp-tja11xx.c
>> index 601094fe2..07e94a247 100644
>> --- a/drivers/net/phy/nxp-tja11xx.c
>> +++ b/drivers/net/phy/nxp-tja11xx.c
>> @@ -87,8 +87,6 @@
>>  #define TJA110X_RMII_MODE_REFCLK_IN       BIT(0)
>>  
>>  struct tja11xx_priv {
>> -	char		*hwmon_name;
>> -	struct device	*hwmon_dev;
>>  	struct phy_device *phydev;
>>  	struct work_struct phy_register_work;
>>  	u32 flags;
>> @@ -508,19 +506,12 @@ static const struct hwmon_chip_info tja11xx_hwmon_chip_info = {
>>  static int tja11xx_hwmon_register(struct phy_device *phydev,
>>  				  struct tja11xx_priv *priv)
>>  {
>> -	struct device *dev = &phydev->mdio.dev;
>> -
>> -	priv->hwmon_name = devm_hwmon_sanitize_name(dev, dev_name(dev));
>> -	if (IS_ERR(priv->hwmon_name))
>> -		return PTR_ERR(priv->hwmon_name);
>> -
>> -	priv->hwmon_dev =
>> -		devm_hwmon_device_register_with_info(dev, priv->hwmon_name,
>> -						     phydev,
>> -						     &tja11xx_hwmon_chip_info,
>> -						     NULL);
>> +	struct device *hdev, *dev = &phydev->mdio.dev;
>>  
>> -	return PTR_ERR_OR_ZERO(priv->hwmon_dev);
>> +	hdev = devm_hwmon_device_register_with_info(dev, NULL, phydev,
>> +						    &tja11xx_hwmon_chip_info,
>> +						    NULL);
>> +	return PTR_ERR_OR_ZERO(hdev);
>>  }
> 
> The change look correct to me, however I think you can go one step
> further and remove the field tja11xx_priv.hwmon_name as well as
> hwmon_dev.
> 
This is part of the patch. Or what do you mean?

> One could argue that we can even remove tja11xx_hwmon_register()
> entirely
> 
It's called from two places, and we would have to duplicate some things
like IS_ERR(). I think it's ok to leave this function in.

> Thanks,
> 
> Maxime

Heiner


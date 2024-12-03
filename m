Return-Path: <netdev+bounces-148390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF3B9E1465
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 08:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF657280D0B
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 07:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1D118FDB9;
	Tue,  3 Dec 2024 07:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFs93RFE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4315713F43A;
	Tue,  3 Dec 2024 07:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733211511; cv=none; b=Z0tCa3sp1d3XUy6poRBldKKf+L68Bv3hafu9b2zeWYI+mNa0ugLylZVOSxj/XMmT8BDRW5vYby1N3SxKUcIQODvxyL18nBEAnLStDNHJTVLEye1+jiP+ofjMDpLi7Bc09MJ+liHLEsfh0h/5bmz6jewjTvBZIIq8g6hfZ/tnfGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733211511; c=relaxed/simple;
	bh=LfAsjNM2FDjgHiA/SxBN/GnqJgqQqY/3raWjyMi2ffg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aKtjCuWqfxap9evw1xnuknIQH2u1py+WoU6z3yDFDI9sAhaOVmWeuH1Fw3gHjSGaKHzE8dx/H+ERbL1eKCLmI/zLooTwlJVHJqFMceeOw3ewR3G4jJ9syDzaSukmZ+P94bEjg0smZOt6UwTqNLSwkWSEi09gnjqQxtzwu+P+uu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFs93RFE; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d0bfa52bd9so4180335a12.2;
        Mon, 02 Dec 2024 23:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733211508; x=1733816308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nOtRHJ4QkmQ/mtrp8xZ1MRXfe+BKWbXiAg3Rkf2GO34=;
        b=hFs93RFECofPkf5pC8vENUoN25Sd9RT/Wl/zG4FhfrMWqAPi/QypZ+djRvXLygNlrY
         kr12Q54pSELOY/HzSz0EygbUdBL+dd24LmmxWdl1H1/D0M5+wkqL+Op8rOu3xWVBhGSc
         ErMLEo9igX9Tm3pl+D6JRKacLiyLzWnRBJ4nLWjiR5HFXinYGIHgI58/TMbnxyL3INIj
         e7nhnUCNAZqaby2tvRjTOZZdi+qf40b+46uX4ffyH5r6fTUNFcEe2NglIoJqsIt1N3Sx
         oEIpwpkxNre6stDwufVWsO8RpX/kR4fMTx9/FKdnblFTVzfcZvLbaGPOxYF4QfuqHK7p
         N1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733211508; x=1733816308;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOtRHJ4QkmQ/mtrp8xZ1MRXfe+BKWbXiAg3Rkf2GO34=;
        b=OhRsU59gopNYR7995XEO8SmBidXlIt8TGKpGqhGMwqHiRxK+kqzZtUvd2DaGlj7De+
         tfvqBO4PRR377MR1aF98EAjxx2EcZ1ZNvGI5GcyUcc/p5cMI3/lRFnB9x/N/s1qHLXzr
         tyz6VqTrlHwr4hrQ/WpMGgu3+66CjOffc5sDvytIiyasvFnoExWlqr441rdk8zmq2gMW
         7l3UzqGoDwxcnly+oodM+Qw+zesVXt3793b+LDIDh6pQJOX8QZBrY9CUdJiE8gXzhrxP
         29prxAsE8y7LAWKzlwTGI667JZrzx13g45O+s/QQMOaMtB2SJn9x8e8U2Ryo9WmU9j17
         k/7w==
X-Forwarded-Encrypted: i=1; AJvYcCWjitDurmsYoQuwi6qq3B0tjKTddlIQs8F81EKf1hvTskqiNrL6a8VvDiRhrBG9xlpM/LUeQTbm@vger.kernel.org, AJvYcCXJc4dXegykslYgCiidl1zmhfFLkWVUS3UAw7r9GS3n4N9mhpk6Fv4eZyuAcdXkP8cSN2IFq22pr1fGuvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu/3pUgbkOm21I6P5l3d8nAA8IcSUApgBdThgVn6SxraOYz3zl
	2mvJKdcG7N5e2BkWP+QCB3kY6FeCAD47vcazFq5MMFFxskJjZTtg
X-Gm-Gg: ASbGncvmUnf90Gp5POBoa9M+nb9ygvOESCod6q+XFyxdkhFVRDAsb63B7+DXig+QOf3
	cLk8Uef+keneuNeZ8kVagUekh/R2ISHlAM0GcZm1NJouHv0Hh0skoSZvprt9bx/p7a0LKHD68jq
	UiMxrZ6zliub+3YOoFWzXs5nnw8198f7vLsmDJz02F0JTNnN7+ei9Pgk/e8e3HyVtouhjXLqDS4
	redhPtOS5/cPlh5ncm7GIXwFdc4XP2PCee6RuUXMHOf1M8jyTR4jK/Iy+wWkHXUK9Gl2RyHowiy
	LHxNshhbVkSqIDftgpevLeF2dznNqeqD/X7TTVvqHgSMetuePSFWhVzbbWBNSvdhS6kcPWh5nbA
	TIDffxGzECWjb+8YkAkYcoY2VF/o60E1VzG+fFU4=
X-Google-Smtp-Source: AGHT+IH0goE4fUnQD2xSNVOe619F4MNitk1PPxe+Kt+J9GpPgj/ZnSjT/fmFC87y+KeNf7G8HoPgOQ==
X-Received: by 2002:a17:906:1da9:b0:aa5:39a6:2b48 with SMTP id a640c23a62f3a-aa5f7ecd694mr92330566b.47.1733211508305;
        Mon, 02 Dec 2024 23:38:28 -0800 (PST)
Received: from ?IPV6:2a02:3100:9d09:7500:e91b:2682:897:11e8? (dynamic-2a02-3100-9d09-7500-e91b-2682-0897-11e8.310.pool.telefonica.de. [2a02:3100:9d09:7500:e91b:2682:897:11e8])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aa5996c11b4sm579702866b.7.2024.12.02.23.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 23:38:27 -0800 (PST)
Message-ID: <d2490036-418e-4ed9-99f6-2c4134fece7b@gmail.com>
Date: Tue, 3 Dec 2024 08:38:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: phy: realtek: disable broadcast address
 feature of rtl8211f
To: Zhiyuan Wan <kmlinuxm@gmail.com>
Cc: linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, willy.liu@realtek.com,
 Yuki Lee <febrieac@outlook.com>, andrew@lunn.ch
References: <7a322deb-e20e-4b32-9fef-d4a48bf0c128@gmail.com>
 <20241203071853.2067014-1-kmlinuxm@gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20241203071853.2067014-1-kmlinuxm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03.12.2024 08:18, Zhiyuan Wan wrote:
> This feature is enabled defaultly after a reset of this transceiver.
> When this feature is enabled, the phy not only responds to the
> configuration PHY address by pin states on board, but also responds
> to address 0, the optional broadcast address of the MDIO bus.
> 
> But some MDIO device like mt7530 switch chip (integrated in mt7621
> SoC), also use address 0 to configure a specific port, when use
> mt7530 and rtl8211f together, it usually causes address conflict,
> leads to the port of RTL8211FS stops working.
> 
> This patch disables broadcast address feature of rtl8211f, and
> returns -ENODEV if using broadcast address (0) as phy address.
> 
> Reviewed-by: Yuki Lee <febrieac@outlook.com>

Take care to remove the Rb tag if you make changes to the patch.

> Signed-off-by: Zhiyuan Wan <kmlinuxm@gmail.com>
> ---
>  drivers/net/phy/realtek.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> index f65d7f1f3..8a38b02ad 100644
> --- a/drivers/net/phy/realtek.c
> +++ b/drivers/net/phy/realtek.c
> @@ -31,6 +31,7 @@
>  #define RTL8211F_PHYCR1				0x18
>  #define RTL8211F_PHYCR2				0x19
>  #define RTL8211F_INSR				0x1d
> +#define RTL8211F_PHYAD0_EN			BIT(13)
>  
>  #define RTL8211F_LEDCR				0x10
>  #define RTL8211F_LEDCR_MODE			BIT(15)
> @@ -139,6 +140,17 @@ static int rtl821x_probe(struct phy_device *phydev)
>  		return dev_err_probe(dev, PTR_ERR(priv->clk),
>  				     "failed to get phy clock\n");
>  
> +	dev_dbg(dev, "disabling MDIO address 0 for this phy");
> +	ret = phy_modify_paged_changed(phydev, 0xa43, RTL8211F_PHYCR1,
> +				       RTL8211F_PHYAD0_EN, 0);

This still uses the _changed version even if not needed.

> +	if (ret < 0) {
> +		dev_err(dev, "disabling MDIO address 0 failed: %pe\n",
> +			ERR_PTR(ret));

You may want to use dev_err_probe() here. And is it by intent that
the error is ignored and you go on?

> +	}
> +	/* Don't allow using broadcast address as PHY address */
> +	if (phydev->mdio.addr == 0)
> +		return -ENODEV;
> +
>  	ret = phy_read_paged(phydev, 0xa43, RTL8211F_PHYCR1);
>  	if (ret < 0)
>  		return ret;

And one more formal issue:
You annotated the patch as 1/2, but submit it as single patch.



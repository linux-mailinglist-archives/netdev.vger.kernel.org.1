Return-Path: <netdev+bounces-148345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 406489E1388
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 07:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E430B21D16
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 06:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E1818132F;
	Tue,  3 Dec 2024 06:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDjh6ejV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBF614F104;
	Tue,  3 Dec 2024 06:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733208646; cv=none; b=j1bWCfSprNvIawcpVIRnBXb/aKnR48m6AZSj9KqsmNyX6GeI1M/gamABOojEJsTbLROcowPMMUZinmoOBQMwjpMlvx/1Aw83a0OFkD/ohv8lWHnsY1kXzhdaUBcmjYQAggsg8ZU1Sqn9DCWUQ+Iurz8PwpO68P6czl13zr3Pdi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733208646; c=relaxed/simple;
	bh=JSHruDBztrs/q8PI7b7ZROkSdM4VTDPtybEgr9mzyRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MdMKxaeDkl6Kh8Yiv2PdumukHRzh4kHGCUZ6P9HrSJjP+WIuCy+JjjYT3cMcllkrFTA3AAHFVDD/ZIU3Oqrpt2+6yNDtZr1zgczVhQ1P3iaijZTs1turb1OGg0vOmewEfx8v8/4cXr9F0EoM/lJhN6UDsMQ1YRmUzf7KrO5mkEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDjh6ejV; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d0cfb9fecaso4080280a12.2;
        Mon, 02 Dec 2024 22:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733208643; x=1733813443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NI/werPgmltxPsDMyZ5Steam/JI1907/cU3EYFBKodA=;
        b=EDjh6ejVBBPdGSh/im0GUEI9HIn2YcHClv6xEqPsw3TikLGqY/5b8LCAYULOCKLnF1
         NMC4yAEov1WNoGOFAsIdRIJWiXGP6Ct4iCEYELJhnuyZOe9vWX2UJxEE74XnfWfs1lIE
         h4px/HGZElYMGQ4u3ShLYG8Mi7eRJNfxJttHLftusnmYQN5XoHFLC58X94l6JD386LfL
         31FKlYxngCjeDVk9TLq+tj9a0QspRRobaUp79JSiD+eVX7BgeGIrPLB776sy3RbdFz5D
         wFYT3+1tyn2ARtuC/VvNl3Cbsdp8qKXttJa9rN3BKqx6YKMSk00fBE98SpTgPeeAwi1q
         wBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733208643; x=1733813443;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NI/werPgmltxPsDMyZ5Steam/JI1907/cU3EYFBKodA=;
        b=okkdaikfTyykyUUp4G0xU9mZ0F7XfwI8jExt2TVZ5X8KC0FD94hFk8B5ULPbHvf7wJ
         932Y3yb7fh1KjrYS+WoAU384gUqWwIe64s737DGYL4BfZbBfFS1/fFHwXN6G2MBc5/OI
         fYOv3EdCp29/vw0XPH9isjJQrtcHXYRfXcfAkxQrUVkeWy/6SdPbq21f3PczV9GclAlM
         dAPpwG4B/fWvXQiu1LLEAX32FYoI7pMQZNFWG12hNDzYqCDwdD5MFr5owMj8Y05crBVO
         DpXl4G69lndZPUsHJadpXC8lQJvD0QDnnXcSWCStOKIndmg9/kJjjgMA6Ok963hcJ6cG
         FN7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhKQ6UPKpfHGGP3blDKYHVX0LUkWoTslCf+irs7zdntcObP6W9Ab62V2Id5dDf83Pai041JFwh@vger.kernel.org, AJvYcCXF9hDgwpiv2/P740gBQ6FVLVsO/MHLF5oUl8qJey/hBFY7dy8yyKo2EjKGuJAkO8jZPE1vreaSboNennk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmrcsVqV7p8GJISyT9ijpysfrSqcwuq6hqOxu6THeXoiFbR10x
	UJgjilMBsHpZtDSXTDStEEiDaus7wKZ3HJSxSxCVlF4Iv8hOQp/f
X-Gm-Gg: ASbGncsc9uTxWorg0qbacUsNcH248at1f4BzipmOrjhR46ivk55QC7uzgamCVbSCuem
	i5HryqGmKyWYMhRNXIlm7UWoHD5fjx7x3yBQm/SrEEunb0IKeB15pbOUzXv1iuz+sU2g3RM1YNt
	ocij6qqqHBrMPqyRDgLs0DWtisBaVCk8k9bre1JjwJwbH7pkgcYkXJkR5+CXptwCgzK3vs/xwR5
	sMMaUP3mIh+8SLU3k/z5+VzwcUuiBgkYPRfc+KEEEJjvt4OzP2r9j+obIJg6NGqcTZXr2vnlKjE
	5/xYc/gVnuB+C6+dLiEb7bFjpsBlAwHJ0MzCm7qjsSxj5z1G6qfj/byJ8eHKEUyCPFdPOMyhUYb
	LDxx1jaU9IARF1K67vTkrr5v0bMG3cbve5a48LxU=
X-Google-Smtp-Source: AGHT+IGcaH2H6IltS88+VsO3IgzpTZmbGobwHpKZsc+psm7G+ViCqqDF2MyAMurUyiW+FfzU6XdKYQ==
X-Received: by 2002:a05:6402:26c1:b0:5d0:cc0d:9935 with SMTP id 4fb4d7f45d1cf-5d10cb55a03mr924793a12.9.1733208642458;
        Mon, 02 Dec 2024 22:50:42 -0800 (PST)
Received: from ?IPV6:2a02:3100:9d09:7500:e91b:2682:897:11e8? (dynamic-2a02-3100-9d09-7500-e91b-2682-0897-11e8.310.pool.telefonica.de. [2a02:3100:9d09:7500:e91b:2682:897:11e8])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d0c6999e45sm4084026a12.52.2024.12.02.22.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 22:50:41 -0800 (PST)
Message-ID: <7a322deb-e20e-4b32-9fef-d4a48bf0c128@gmail.com>
Date: Tue, 3 Dec 2024 07:50:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] net: phy: realtek: disable broadcast address
 feature of rtl8211f
To: Zhiyuan Wan <kmlinuxm@gmail.com>, andrew@lunn.ch
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 willy.liu@realtek.com, Yuki Lee <febrieac@outlook.com>
References: <cb8b5a36-fe5c-4b10-ac28-5f31f95262ab@lunn.ch>
 <20241203042631.2061737-1-kmlinuxm@gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20241203042631.2061737-1-kmlinuxm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03.12.2024 05:26, Zhiyuan Wan wrote:
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

Why do you use the _changed version if you don't use the related feature?

And formal aspects:
- patch should be annotated net-next
- you missed to address all maintainers, use the get_maintainers.pl
  script

> +	if (ret < 0) {
> +		dev_err(dev, "disabling MDIO address 0 failed: %pe\n",
> +			ERR_PTR(ret));
> +	}
> +	/* Don't allow using broadcast address as PHY address */
> +	if (phydev->mdio.addr == 0)
> +		return -ENODEV;
> +
>  	ret = phy_read_paged(phydev, 0xa43, RTL8211F_PHYCR1);
>  	if (ret < 0)
>  		return ret;



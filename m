Return-Path: <netdev+bounces-76922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 284AF86F711
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 21:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4544B1C20AF0
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 20:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF9B43AB5;
	Sun,  3 Mar 2024 20:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3INmaLB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FDA6BFA4
	for <netdev@vger.kernel.org>; Sun,  3 Mar 2024 20:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709498554; cv=none; b=Fh0NnIaQpfsYTL4OJ4TlNFjTWt49zbPwJPvXmARVAi7xlSTTVRMnUB1WL2eJdTi9K1o0fo3fzqO8pBdMJkYbVQTec47MU3q/qfO03R+Fn06aXN2w5D38PJ26ffLtgEf2VUXWKNP9Iz8RynfLqinDhcAYOUgxWM4Ocjv3TQzSJFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709498554; c=relaxed/simple;
	bh=d005lyndxSj1K8DtVIV5JJRqCBlreLvb17WW1GVaqaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NbphvlPHVnbRpGzvJFqggRtEGV9ByEItqd6wWhtSGKTk2dgOA2Op8X4PvBfBRFMrTjdp7zsiM3nOlkxLrKfJio/xpteThDl3Wylc7RGa6kkvBv6W2O8Z1pc+vtzP3focPNf3bm5FE4ndLKPeiPUlIGAskdRgG/dEgn+6xWb4p7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3INmaLB; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-412e554635cso111155e9.0
        for <netdev@vger.kernel.org>; Sun, 03 Mar 2024 12:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709498551; x=1710103351; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NttVCvUVD63bB5RfUP94PUM2AgloFFQMH3SW+/IVenI=;
        b=m3INmaLB22cDh+9Lyu2CvM+HqTcPtMsl8UCo3vPqJQMrBBksnWPJ6mTM3DdLxa3u3t
         dWdcz5h3OjCvOL9ouumNLKBTH+KfLDEdeskA0ZLmlEBVI+fDPFt2duV6xG93lgVRwo4/
         OTieHJ1HsI1aqavviRCyAVjxit3PnUoEERyDNrhjSJ6yY24yvwJl4u5hyJnBotkiAJJN
         UEkMvQvSaX01O47OrvKo0ph65DkJR1YZCA+3q4fEE5wfcx9ehBSOv3Gv1yBYimA6g7/r
         byC8v38kqEW5fIZb3v9Zmt+KuWgWSI/ghI6fjtnm6Y9TaSE2aBy4ti6H1+NLzUxTO5KD
         wD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709498551; x=1710103351;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NttVCvUVD63bB5RfUP94PUM2AgloFFQMH3SW+/IVenI=;
        b=gsr8KJx7IYoSl4WMmKJ41gsk+CBC9GfHwVfsyhttp7QQwYEzs7jzHl3Hg2V6AAt04h
         MgGnk6WQKUEmQnEBXFP7WM4Ty0V3UcxN/3YaOxoTpkY/gGWYiHP2hBDcNfoDbOnBIh/S
         d4x0nAs9Ob/qjI0svUJCPIZ3V1ynoQqA/AWI0EtlIDRzXQiMhKE4A+Mz9XXRJuxLWtok
         8FqvboUBfGEspaTB6zuIVoIPOhU3na0EQdeqYgCwJNgnU5kZvh0e+qKrmaFpuqtnu/Uu
         kylI/aOCx1zMicRSVEjSL1pprjAJh1MA+JT519QeaKn3y5q/I2y5F1+h7veHFEl8p41i
         Gddg==
X-Gm-Message-State: AOJu0Yx0LPuA4h0j2NqVBdVqCNweWnqJGb3AkszjArP3O3aDzMaEv8aU
	DTiHOSwmTratf6/VzEdKKI5AB85U/2R6ZxFZ/EDEqcEB1UBfzUM9
X-Google-Smtp-Source: AGHT+IEfyNwBixrs9qzZk8G35qYgJrRd6Q9U9VMjsv/ILn/ZNI7xzlY60R5v9eba0p23KhrMqoFNZw==
X-Received: by 2002:a05:600c:4f15:b0:412:6101:915c with SMTP id l21-20020a05600c4f1500b004126101915cmr4958709wmq.19.1709498550794;
        Sun, 03 Mar 2024 12:42:30 -0800 (PST)
Received: from ?IPV6:2a01:c22:6e8f:5600:2922:1b4d:388a:be15? (dynamic-2a01-0c22-6e8f-5600-2922-1b4d-388a-be15.c22.pool.telefonica.de. [2a01:c22:6e8f:5600:2922:1b4d:388a:be15])
        by smtp.googlemail.com with ESMTPSA id jl24-20020a05600c6a9800b004126732390asm15494769wmb.37.2024.03.03.12.42.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 12:42:30 -0800 (PST)
Message-ID: <f587013b-8f2c-4ae1-83b8-0c69ba99f3ea@gmail.com>
Date: Sun, 3 Mar 2024 21:42:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 1/7] net: phy: realtek: configure SerDes mode
 for rtl822x/8251b PHYs
To: Eric Woudstra <ericwouds@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, Alexander Couzens <lynxis@fe80.eu>
References: <20240303102848.164108-1-ericwouds@gmail.com>
 <20240303102848.164108-2-ericwouds@gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20240303102848.164108-2-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03.03.2024 11:28, Eric Woudstra wrote:
> From: Alexander Couzens <lynxis@fe80.eu>
> 
> The rtl822x series and rtl8251b support switching SerDes mode between
> 2500base-x and sgmii based on the negotiated copper speed.
> 
> Configure this switching mode according to SerDes modes supported by
> host.
> 
> There is an additional datasheet for RTL8226B/RTL8221B called
> "SERDES MODE SETTING FLOW APPLICATION NOTE" where this sequence to
> setup interface and rate adapter mode.
> 
> However, there is no documentation about the meaning of registers
> and bits, it's literally just magic numbers and pseudo-code.
> 
> Signed-off-by: Alexander Couzens <lynxis@fe80.eu>
> [ refactored, dropped HiSGMII mode and changed commit message ]
> Signed-off-by: Marek Behún <kabel@kernel.org>
> [ changed rtl822x_update_interface() to use vendor register ]
> [ always fill in possible interfaces ]
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  drivers/net/phy/realtek.c | 99 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 97 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> index 1fa70427b2a2..8a876e003774 100644
> --- a/drivers/net/phy/realtek.c
> +++ b/drivers/net/phy/realtek.c
> @@ -54,6 +54,16 @@
>  						 RTL8201F_ISR_LINK)
>  #define RTL8201F_IER				0x13
>  
> +#define RTL822X_VND1_SERDES_OPTION			0x697a
> +#define RTL822X_VND1_SERDES_OPTION_MODE_MASK		GENMASK(5, 0)
> +#define RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX_SGMII		0
> +#define RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX		2
> +
> +#define RTL822X_VND1_SERDES_CTRL3			0x7580
> +#define RTL822X_VND1_SERDES_CTRL3_MODE_MASK		GENMASK(5, 0)
> +#define RTL822X_VND1_SERDES_CTRL3_MODE_SGMII			0x02
> +#define RTL822X_VND1_SERDES_CTRL3_MODE_2500BASEX		0x16
> +
>  #define RTL8366RB_POWER_SAVE			0x15
>  #define RTL8366RB_POWER_SAVE_ON			BIT(12)
>  
> @@ -659,6 +669,60 @@ static int rtl822x_write_mmd(struct phy_device *phydev, int devnum, u16 regnum,
>  	return ret;
>  }
>  
> +static int rtl822x_config_init(struct phy_device *phydev)
> +{
> +	bool has_2500, has_sgmii;
> +	u16 mode;
> +	int ret;
> +
> +	has_2500 = test_bit(PHY_INTERFACE_MODE_2500BASEX,
> +			    phydev->host_interfaces) ||
> +		   phydev->interface == PHY_INTERFACE_MODE_2500BASEX;
> +
> +	has_sgmii = test_bit(PHY_INTERFACE_MODE_SGMII,
> +			     phydev->host_interfaces) ||
> +		    phydev->interface == PHY_INTERFACE_MODE_SGMII;
> +
> +	/* fill in possible interfaces */
> +	__assign_bit(PHY_INTERFACE_MODE_2500BASEX, phydev->possible_interfaces,
> +		     has_2500);
> +	__assign_bit(PHY_INTERFACE_MODE_SGMII, phydev->possible_interfaces,
> +		     has_sgmii);
> +
> +	if (!has_2500 && !has_sgmii)
> +		return 0;
> +
> +	/* determine SerDes option mode */
> +	if (has_2500 && !has_sgmii)
> +		mode = RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX;
> +	else
> +		mode = RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX_SGMII;
> +
> +	/* the following sequence with magic numbers sets up the SerDes
> +	 * option mode
> +	 */
> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x75f3, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_VEND1,
> +				     RTL822X_VND1_SERDES_OPTION,
> +				     RTL822X_VND1_SERDES_OPTION_MODE_MASK,
> +				     mode);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x6a04, 0x0503);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x6f10, 0xd455);
> +	if (ret < 0)
> +		return ret;
> +
> +	return phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x6f11, 0x8020);
> +}
> +
>  static int rtl822x_get_features(struct phy_device *phydev)
>  {
>  	int val;
> @@ -695,6 +759,28 @@ static int rtl822x_config_aneg(struct phy_device *phydev)
>  	return __genphy_config_aneg(phydev, ret);
>  }
>  
> +static void rtl822x_update_interface(struct phy_device *phydev)
> +{
> +	int val;
> +
> +	if (!phydev->link)
> +		return;
> +
> +	/* Change interface according to serdes mode */
> +	val = phy_read_mmd(phydev, MDIO_MMD_VEND1, RTL822X_VND1_SERDES_CTRL3);
> +	if (val < 0)
> +		return;
> +
> +	switch (val & RTL822X_VND1_SERDES_CTRL3_MODE_MASK) {
> +	case RTL822X_VND1_SERDES_CTRL3_MODE_2500BASEX:
> +		phydev->interface = PHY_INTERFACE_MODE_2500BASEX;
> +		break;
> +	case RTL822X_VND1_SERDES_CTRL3_MODE_SGMII:
> +		phydev->interface = PHY_INTERFACE_MODE_SGMII;
> +		break;
> +	}
> +}
> +
>  static int rtl822x_read_status(struct phy_device *phydev)
>  {
>  	int ret;
> @@ -709,11 +795,13 @@ static int rtl822x_read_status(struct phy_device *phydev)
>  						  lpadv);
>  	}
>  
> -	ret = genphy_read_status(phydev);
> +	ret = rtlgen_read_status(phydev);
>  	if (ret < 0)
>  		return ret;
>  
> -	return rtlgen_get_speed(phydev);
> +	rtl822x_update_interface(phydev);
> +
> +	return 0;
>  }
>  
>  static bool rtlgen_supports_2_5gbps(struct phy_device *phydev)
> @@ -976,6 +1064,7 @@ static struct phy_driver realtek_drvs[] = {
>  		.match_phy_device = rtl8226_match_phy_device,
>  		.get_features	= rtl822x_get_features,
>  		.config_aneg	= rtl822x_config_aneg,
> +		.config_init    = rtl822x_config_init,

Did you test this (and the rest of the series) on RTL8125A, where
MMD register access for the integrated 2.5G PHY isn't supported?

>  		.read_status	= rtl822x_read_status,
>  		.suspend	= genphy_suspend,
>  		.resume		= rtlgen_resume,
> @@ -988,6 +1077,7 @@ static struct phy_driver realtek_drvs[] = {
>  		.name		= "RTL8226B_RTL8221B 2.5Gbps PHY",
>  		.get_features	= rtl822x_get_features,
>  		.config_aneg	= rtl822x_config_aneg,
> +		.config_init    = rtl822x_config_init,
>  		.read_status	= rtl822x_read_status,
>  		.suspend	= genphy_suspend,
>  		.resume		= rtlgen_resume,
> @@ -1000,6 +1090,7 @@ static struct phy_driver realtek_drvs[] = {
>  		.name           = "RTL8226-CG 2.5Gbps PHY",
>  		.get_features   = rtl822x_get_features,
>  		.config_aneg    = rtl822x_config_aneg,
> +		.config_init    = rtl822x_config_init,
>  		.read_status    = rtl822x_read_status,
>  		.suspend        = genphy_suspend,
>  		.resume         = rtlgen_resume,
> @@ -1010,6 +1101,7 @@ static struct phy_driver realtek_drvs[] = {
>  		.name           = "RTL8226B-CG_RTL8221B-CG 2.5Gbps PHY",
>  		.get_features   = rtl822x_get_features,
>  		.config_aneg    = rtl822x_config_aneg,
> +		.config_init    = rtl822x_config_init,
>  		.read_status    = rtl822x_read_status,
>  		.suspend        = genphy_suspend,
>  		.resume         = rtlgen_resume,
> @@ -1019,6 +1111,7 @@ static struct phy_driver realtek_drvs[] = {
>  		PHY_ID_MATCH_EXACT(0x001cc849),
>  		.name           = "RTL8221B-VB-CG 2.5Gbps PHY",
>  		.get_features   = rtl822x_get_features,
> +		.config_init    = rtl822x_config_init,
>  		.config_aneg    = rtl822x_config_aneg,
>  		.read_status    = rtl822x_read_status,
>  		.suspend        = genphy_suspend,
> @@ -1030,6 +1123,7 @@ static struct phy_driver realtek_drvs[] = {
>  		.name           = "RTL8221B-VM-CG 2.5Gbps PHY",
>  		.get_features   = rtl822x_get_features,
>  		.config_aneg    = rtl822x_config_aneg,
> +		.config_init    = rtl822x_config_init,
>  		.read_status    = rtl822x_read_status,
>  		.suspend        = genphy_suspend,
>  		.resume         = rtlgen_resume,
> @@ -1040,6 +1134,7 @@ static struct phy_driver realtek_drvs[] = {
>  		.name           = "RTL8251B 5Gbps PHY",
>  		.get_features   = rtl822x_get_features,
>  		.config_aneg    = rtl822x_config_aneg,
> +		.config_init    = rtl822x_config_init,
>  		.read_status    = rtl822x_read_status,
>  		.suspend        = genphy_suspend,
>  		.resume         = rtlgen_resume,



Return-Path: <netdev+bounces-180038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1FFA7F2D9
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 04:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CAAD188CD87
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 02:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5131DE2A1;
	Tue,  8 Apr 2025 02:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="MFSBWKSS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E64C1C6B4
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 02:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744080980; cv=none; b=UAgXScKaLqp8xT8TSAolJ3CKEW9tI18bsmY2kUFYBQi+DILPaLfVws9YKLHqM4x+i3Su6GRDabPryqv+Dr2ZDoVO34nme4NT+YV3AjJozODYXe+JQrsCxtUibXfbVj8PFcIFenaPex1HOwhfrWzLsRhFt3HMsC6vmu9YL/iUTac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744080980; c=relaxed/simple;
	bh=IRQX6FnE5MUIklYEtMa+zEA/SgwB8IzLIYokjzXBmWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OC1Q+WAJSxyOgObj1OLqH0w2qhtarSZEz6YA7hvqEXhOkRuC9yMOUGnquXgUXmPhAwit5CgvJ3tcTfWYtCTmbn/a5+QnuW6Gt1qLntmCgbArxnwnYQosOQ0CgfIVkB/zuBMKkalQhN9gbV6baAj6V0ODldZnqrtfANYxjEh1Ufk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=MFSBWKSS; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso5295523b3a.2
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 19:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1744080978; x=1744685778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zo7thYEk15AQtYFUXhpvpFSCu3cxGHzMkjACCgnp/lU=;
        b=MFSBWKSSsfV87CHo/MWx7mq8gnBdbrueuLc8dzjxH8TOE/sexfLwNG7gCOrlP9nvHC
         mcfHO0jCvNM3/qOvlXGpMRyejFESN+gClWW2laSF3m9ALKYrqZOaHzIvAqt9i22y9LVH
         yjgQlrvPGfmgmpsd0eV5XzqbKRXL5gJ5vqlew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744080978; x=1744685778;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zo7thYEk15AQtYFUXhpvpFSCu3cxGHzMkjACCgnp/lU=;
        b=k6bm3J0XyXn2wRDE7v4JpwNzzoxxQsZAbB9ph2R2hGZ4Qm597OwV+wUqCg9/OPp3LO
         +IAR6JtCTwi0VO4zh7uQj+VkSkzEYfEAnYtnIZcftX2b7G3lXjM2RRMcFanbtNv07kTI
         mp0a5tbqdt82cmBEFtISvb0C8TsA1F2siqfO4WkpncKtTUn3mTp37TFscPfjSfLOSAnq
         kTQlxbyUi+AV9rhdCr+7IKfLiavH/8SSXpkrqzZ7Zkhla1H0nf4+Y9CwH8Ti3ELQm9m1
         NCYYemd5s1csovEry9PM5aneHPi0ILsyvuhkWJjI7sdIsu+QAxENdUvbF4dSNB2DdY8L
         Hdfg==
X-Forwarded-Encrypted: i=1; AJvYcCWzBBc3RAGMsw8tpxFlnr9cdPgO3ONxPYk4kuRXbqebY0zokuJklj83XwbLASTe75Ttxag2u7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmnFOuGPI7vXVEB4mHIcz9dqdaxLUW3EvftY46FhflFGNvekXv
	PFFHOZk0K8BQS8CbvtUJzsTh0xDecnhKLwfNeQu0ybS9v23dLQwc5zfHyOabsUk=
X-Gm-Gg: ASbGncutBkQwlfUhhfX/eSPCN+nkUSxaCHtXDE17BtoaIDFJWXZVopmcaF5jIXacu5M
	mKXXZTytyDryRenOXqw7B/qnBpEo7o1ucPtxaMXKGAcD7LQi7kNz8G9G7vAVIpyPyQN/HqxrTTm
	BgGS6t561AjCbXXBYKZmvdh43Bwu5Ai64ivQ2HjazpDgRpptYekxBgvcdjxkkt9kLIEh+b3cm3r
	/YYgDou1B9SjEd2p/c9NtLi611+SfpJVrgokbCZxj4cV98VA7NpvXo8ytbnL3PZ3YlxNyKkQc7b
	UTR/T8O+iYYH9j6CpIweyFr+rV16KA9VfsDRVVDsnBAaZw2rimwT/6qKHZgLEVgKr3vjnOmy1Ri
	SzjadYoz7A40zwyvDPnkP0w==
X-Google-Smtp-Source: AGHT+IF39pNN6cU68fx9ODvUvpTInT6A2EN2f9pvyQLUfRl60UGSNF352rkRljHG/9VD401YHWnMqg==
X-Received: by 2002:a05:6a21:6e01:b0:1f5:889c:3ccc with SMTP id adf61e73a8af0-2010461ce81mr24283036637.14.1744080977704;
        Mon, 07 Apr 2025 19:56:17 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc323877sm7964377a12.29.2025.04.07.19.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 19:56:17 -0700 (PDT)
Date: Mon, 7 Apr 2025 19:56:14 -0700
From: Joe Damato <jdamato@fastly.com>
To: Michael Klein <michael@fossekall.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND net-next v5 2/4] net: phy: realtek: Clean up RTL8211E
 ExtPage access
Message-ID: <Z_SQTi-uKk4wqRcL@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Michael Klein <michael@fossekall.de>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250407182155.14925-1-michael@fossekall.de>
 <20250407182155.14925-3-michael@fossekall.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407182155.14925-3-michael@fossekall.de>

On Mon, Apr 07, 2025 at 08:21:41PM +0200, Michael Klein wrote:
> - Factor out RTL8211E extension page access code to
>   rtl8211e_modify_ext_page() and clean up rtl8211e_config_init()
> 
> Signed-off-by: Michael Klein <michael@fossekall.de>
> ---
>  drivers/net/phy/realtek/realtek_main.c | 38 +++++++++++++++-----------
>  1 file changed, 22 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> index b27c0f995e56..e60c18551a4e 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c
> @@ -37,9 +37,11 @@
>  
>  #define RTL821x_INSR				0x13
>  
> -#define RTL821x_EXT_PAGE_SELECT			0x1e
>  #define RTL821x_PAGE_SELECT			0x1f
>  
> +#define RTL8211E_EXT_PAGE_SELECT		0x1e
> +#define RTL8211E_SET_EXT_PAGE			0x07
> +
>  #define RTL8211E_CTRL_DELAY			BIT(13)
>  #define RTL8211E_TX_DELAY			BIT(12)
>  #define RTL8211E_RX_DELAY			BIT(11)
> @@ -135,6 +137,21 @@ static int rtl821x_write_page(struct phy_device *phydev, int page)
>  	return __phy_write(phydev, RTL821x_PAGE_SELECT, page);
>  }
>  
> +static int rtl8211e_modify_ext_page(struct phy_device *phydev, u16 ext_page,
> +				    u32 regnum, u16 mask, u16 set)
> +{
> +	int oldpage, ret = 0;
> +
> +	oldpage = phy_select_page(phydev, RTL8211E_SET_EXT_PAGE);
> +	if (oldpage >= 0) {
> +		ret = __phy_write(phydev, RTL8211E_EXT_PAGE_SELECT, ext_page);
> +		if (ret == 0)
> +			ret = __phy_modify(phydev, regnum, mask, set);
> +	}
> +
> +	return phy_restore_page(phydev, oldpage, ret);
> +}
> +
>  static int rtl821x_probe(struct phy_device *phydev)
>  {
>  	struct device *dev = &phydev->mdio.dev;
> @@ -607,7 +624,9 @@ static int rtl8211f_led_hw_control_set(struct phy_device *phydev, u8 index,
>  
>  static int rtl8211e_config_init(struct phy_device *phydev)
>  {
> -	int ret = 0, oldpage;
> +	const u16 delay_mask = RTL8211E_CTRL_DELAY |
> +			       RTL8211E_TX_DELAY |
> +			       RTL8211E_RX_DELAY;
>  	u16 val;
>  
>  	/* enable TX/RX delay for rgmii-* modes, and disable them for rgmii. */
> @@ -637,20 +656,7 @@ static int rtl8211e_config_init(struct phy_device *phydev)
>  	 * 12 = RX Delay, 11 = TX Delay
>  	 * 10:0 = Test && debug settings reserved by realtek
>  	 */
> -	oldpage = phy_select_page(phydev, 0x7);
> -	if (oldpage < 0)
> -		goto err_restore_page;
> -
> -	ret = __phy_write(phydev, RTL821x_EXT_PAGE_SELECT, 0xa4);
> -	if (ret)
> -		goto err_restore_page;
> -
> -	ret = __phy_modify(phydev, 0x1c, RTL8211E_CTRL_DELAY
> -			   | RTL8211E_TX_DELAY | RTL8211E_RX_DELAY,
> -			   val);
> -
> -err_restore_page:
> -	return phy_restore_page(phydev, oldpage, ret);
> +	return rtl8211e_modify_ext_page(phydev, 0xa4, 0x1c, delay_mask, val);
>  }

Seems good to add RTL8211E_SET_EXT_PAGE to remove a constant from
the code. Any reason to avoid adding constants for 0xa4 and 0x1c ?


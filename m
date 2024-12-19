Return-Path: <netdev+bounces-153506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E30BB9F85B1
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 21:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E542318991E5
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 20:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629D61FDE12;
	Thu, 19 Dec 2024 20:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBgSS7W/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8491EE7A4;
	Thu, 19 Dec 2024 20:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734639189; cv=none; b=RYeZLqQuF4LvJPBJZze7igNY5j2H92HR8IP4egfy0S/GOPD0a3Co8hSUIRHOwvpNlTVm3JAbqPm9e8PkG3hoWPFYBMKTb7K5jcrkUts7qPr6uxoux9v6YezU/Ua2N8dd5O84dwcGnw6cdDYeTpxR5ps2kuXi77mag79dVgP7Sgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734639189; c=relaxed/simple;
	bh=AFOLYZHJnWgPb0PjpgFano2bOAyUMAmJ+Kbe29Akxm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G0u7GWLBCbZxX+A+hYBm6PD2QczHyBj54CdxlEJOzRNZHMyI7NiCEU3pHIkvJNqorSQ/w7dbXugvrPiV6yzTtsnBxwYzB7FMXscAFE1t7vqKaqws9xGG72GoUbGJKIrJI0QaI0+UiYGO/ViqTgLjzQmpHcfcoG2La8GhJ7VCmuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBgSS7W/; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d0ac27b412so1497108a12.1;
        Thu, 19 Dec 2024 12:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734639185; x=1735243985; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6EyJWHgpBem8dO64Q2TCZDr+W2RuZXw9hq4ZkTsYIs8=;
        b=jBgSS7W/Ns7oZ+mtRNi36GyEGX/IdnBDX2aQetLdJ0EXvY65LEyTjaLA9c3kSyd5a8
         f54Kqn364zZzBaqfwFryfJ5GPeC4h0VPKB7lmR5TEtQ0QzwDPDdIkDcS1wTtjw/kBGjc
         osHTw2z4Ds+joEIEG8XkpDr1rf/smoTiGtb63s6/gM/1mYEUJwc4TsVki5Sc0jsEWsu8
         Y7cIsJGUxLl9ba0v7tgMcTAW49mvjWzf6a7pCuEBWHegBo9bErjZxXqH/mRxsKVxE0oj
         LxG72QVUgctPuj+4jffux6/YY4ZTNUPmOQv8vTrK72jxbyP1S9trNObqDqYEwrIFDs48
         aW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734639185; x=1735243985;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6EyJWHgpBem8dO64Q2TCZDr+W2RuZXw9hq4ZkTsYIs8=;
        b=hevr/fUGN0zrkN6x6vRHvFkohLCxdSp1sRNH7cF2xWC1V0x+MdkXujMGTy6qTt3Lmt
         DC+PzRnBLjKGyxcnIwT0pVdvPVAu5C8nCHIjw9I2ebX5X3Sm7rChp3I762UytxXRzawG
         nf0e1koX7tFuMX5519mcr/ly2CEdxnMvU0rv4dvYwmyFGGUurRlK/G3Zu3Iy7Ay2LPZs
         LQX2BOyPLrIn/DKWdjIFRd9i/65MKukJeaMgQmGvLiuqjV5wIQ0cweKMzJyyG5QyM50J
         Lu5WY0B4lxuNf3RuoHKgZhMPyF+lWSMKP2DfgeoA3y5W9okxoj4uT5J/fpu1/ICJuYUi
         YEGw==
X-Forwarded-Encrypted: i=1; AJvYcCWQc0J3m1P3c/71/OFpEOEObAi1Rw+FbVTL4ezi4TS4qnzlNjnwe8yPbQGMDvf477zR92kCaCjMSbQSHgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YykeDgFwWcqYjzs14RDCyaMWqfW9rJLppY7UrW46DN2oic7w1Le
	A1wvwwbZySTOJAZj1AUBZAjAdJEuehMcudtSrXmI6DcINJckKCIM
X-Gm-Gg: ASbGncuHywG2d+N/sAT428VRRMGgK4/ojFXsR39uilxesvo3V/8kdvP3BurrEeQl+hI
	++rai1HSeKRJ5wc9e0MdBMj8eTF59UUFMr1GDX3mPxV5CC74bPKRNAe2yzZo9SrFk24Qk9z8q4p
	3x9aV00IDGtSiX52B5rZ81WaN3PUyoxj78wqJMMNHJBPTGiiaABtTIkqQXof1IwzFcZN7Tw0R/R
	YvN4B6VEH6IQ+304Zlq2Kh/C8/dyxD+FnYFzgTKcVAauO7FklldblqIFOxGGG+beCzpKRJUi6Y0
	cPBiedXTjPm3OE+JRevfacpxJIo7tgFZZfDBJgmD/sNmfQeqYo3MztjhdFpkAb+XijPMBckHBa0
	avN2KtI+xMgMn4uor3eGkD/LR51ftOi3B+dQkoi+Cm7A6wH4P
X-Google-Smtp-Source: AGHT+IGOxZy9cGiDjdNOtTIkhMdnpgFPp+1ZxGXHhxFDcg7CvxIr/zWf0ryupFw8mHSLxaDHsGG/fw==
X-Received: by 2002:a05:6402:3217:b0:5d4:4143:c06c with SMTP id 4fb4d7f45d1cf-5d81ddffa67mr159467a12.23.1734639184486;
        Thu, 19 Dec 2024 12:13:04 -0800 (PST)
Received: from ?IPV6:2a02:3100:addf:be00:cc80:8682:850f:88d2? (dynamic-2a02-3100-addf-be00-cc80-8682-850f-88d2.310.pool.telefonica.de. [2a02:3100:addf:be00:cc80:8682:850f:88d2])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d80678c8cfsm952748a12.39.2024.12.19.12.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 12:13:03 -0800 (PST)
Message-ID: <1ad8ccdb-8621-42c7-b679-c6e67acb8396@gmail.com>
Date: Thu, 19 Dec 2024 21:13:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] r8169: add support for RTL8125BP rev.b
To: Hayes Wang <hayeswang@realtek.com>, nic_swsd@realtek.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ChunHao Lin <hau@realtek.com>
References: <20241219084933.8757-1-hayeswang@realtek.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20241219084933.8757-1-hayeswang@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19.12.2024 09:49, Hayes Wang wrote:
> From: ChunHao Lin <hau@realtek.com>
> 
> Add support for RTL8125BP rev.b. Its XID is 0x689. This chip supports
> DASH and its dash type is "RTL_DASH_25_BP".
> 
Is this MAC version based on RTL8125B or RTL8125D?
I'm asking because this patch misses functionality which would be
typical for the two mentioned chip versions.

E.g. rtl8125_quirk_udp_padto() isn't enabled, what more indicates
a RTL8125D.

Is there any system out there yet with this new chip version?

> Signed-off-by: ChunHao Lin <hau@realtek.com>
> ---
>  drivers/net/ethernet/realtek/r8169.h          |  1 +
>  drivers/net/ethernet/realtek/r8169_main.c     | 29 +++++++++++++++++++
>  .../net/ethernet/realtek/r8169_phy_config.c   | 23 +++++++++++++++
>  3 files changed, 53 insertions(+)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/realtek/r8169.h
> index e0817f2a311a..7a194a8ab989 100644
> --- a/drivers/net/ethernet/realtek/r8169.h
> +++ b/drivers/net/ethernet/realtek/r8169.h
> @@ -70,6 +70,7 @@ enum mac_version {
>  	RTL_GIGA_MAC_VER_63,
>  	RTL_GIGA_MAC_VER_64,
>  	RTL_GIGA_MAC_VER_65,
> +	RTL_GIGA_MAC_VER_66,
>  	RTL_GIGA_MAC_VER_70,
>  	RTL_GIGA_MAC_VER_71,
>  	RTL_GIGA_MAC_NONE
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 5724f650f9c6..17ac50fcc9c8 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -58,6 +58,7 @@
>  #define FIRMWARE_8125B_2	"rtl_nic/rtl8125b-2.fw"
>  #define FIRMWARE_8125D_1	"rtl_nic/rtl8125d-1.fw"
>  #define FIRMWARE_8125D_2	"rtl_nic/rtl8125d-2.fw"
> +#define FIRMWARE_8125BP_2	"rtl_nic/rtl8125bp-2.fw"
>  #define FIRMWARE_8126A_2	"rtl_nic/rtl8126a-2.fw"
>  #define FIRMWARE_8126A_3	"rtl_nic/rtl8126a-3.fw"
>  
> @@ -142,6 +143,7 @@ static const struct {
>  	[RTL_GIGA_MAC_VER_63] = {"RTL8125B",		FIRMWARE_8125B_2},
>  	[RTL_GIGA_MAC_VER_64] = {"RTL8125D",		FIRMWARE_8125D_1},
>  	[RTL_GIGA_MAC_VER_65] = {"RTL8125D",		FIRMWARE_8125D_2},
> +	[RTL_GIGA_MAC_VER_66] = {"RTL8125BP",		FIRMWARE_8125BP_2},
>  	[RTL_GIGA_MAC_VER_70] = {"RTL8126A",		FIRMWARE_8126A_2},
>  	[RTL_GIGA_MAC_VER_71] = {"RTL8126A",		FIRMWARE_8126A_3},
>  };
> @@ -632,6 +634,7 @@ enum rtl_dash_type {
>  	RTL_DASH_NONE,
>  	RTL_DASH_DP,
>  	RTL_DASH_EP,
> +	RTL_DASH_25_BP,
>  };
>  
>  struct rtl8169_private {
> @@ -1361,10 +1364,19 @@ static void rtl8168ep_driver_start(struct rtl8169_private *tp)
>  		rtl_loop_wait_high(tp, &rtl_ep_ocp_read_cond, 10000, 30);
>  }
>  
> +static void rtl8125bp_driver_start(struct rtl8169_private *tp)
> +{
> +	r8168ep_ocp_write(tp, 0x01, 0x14, OOB_CMD_DRIVER_START);
> +	r8168ep_ocp_write(tp, 0x01, 0x18, 0x00);
> +	r8168ep_ocp_write(tp, 0x01, 0x10, 0x01);
> +}
> +
>  static void rtl8168_driver_start(struct rtl8169_private *tp)
>  {
>  	if (tp->dash_type == RTL_DASH_DP)
>  		rtl8168dp_driver_start(tp);
> +	else if (tp->dash_type == RTL_DASH_25_BP)
> +		rtl8125bp_driver_start(tp);
>  	else
>  		rtl8168ep_driver_start(tp);
>  }
> @@ -1385,10 +1397,19 @@ static void rtl8168ep_driver_stop(struct rtl8169_private *tp)
>  		rtl_loop_wait_low(tp, &rtl_ep_ocp_read_cond, 10000, 10);
>  }
>  
> +static void rtl8125bp_driver_stop(struct rtl8169_private *tp)
> +{
> +	r8168ep_ocp_write(tp, 0x01, 0x14, OOB_CMD_DRIVER_STOP);
> +	r8168ep_ocp_write(tp, 0x01, 0x18, 0x00);
> +	r8168ep_ocp_write(tp, 0x01, 0x10, 0x01);
> +}
> +
>  static void rtl8168_driver_stop(struct rtl8169_private *tp)
>  {
>  	if (tp->dash_type == RTL_DASH_DP)
>  		rtl8168dp_driver_stop(tp);
> +	else if (tp->dash_type == RTL_DASH_25_BP)
> +		rtl8125bp_driver_stop(tp);
>  	else
>  		rtl8168ep_driver_stop(tp);
>  }
> @@ -1411,6 +1432,7 @@ static bool rtl_dash_is_enabled(struct rtl8169_private *tp)
>  	case RTL_DASH_DP:
>  		return r8168dp_check_dash(tp);
>  	case RTL_DASH_EP:
> +	case RTL_DASH_25_BP:
>  		return r8168ep_check_dash(tp);
>  	default:
>  		return false;
> @@ -1425,6 +1447,8 @@ static enum rtl_dash_type rtl_get_dash_type(struct rtl8169_private *tp)
>  		return RTL_DASH_DP;
>  	case RTL_GIGA_MAC_VER_51 ... RTL_GIGA_MAC_VER_53:
>  		return RTL_DASH_EP;
> +	case RTL_GIGA_MAC_VER_66:
> +		return RTL_DASH_25_BP;
>  	default:
>  		return RTL_DASH_NONE;
>  	}
> @@ -2261,6 +2285,9 @@ static enum mac_version rtl8169_get_mac_version(u16 xid, bool gmii)
>  		{ 0x7cf, 0x64a,	RTL_GIGA_MAC_VER_71 },
>  		{ 0x7cf, 0x649,	RTL_GIGA_MAC_VER_70 },
>  
> +		/* 8125BP family. */
> +		{ 0x7cf, 0x681,	RTL_GIGA_MAC_VER_66 },
> +
>  		/* 8125D family. */
>  		{ 0x7cf, 0x689,	RTL_GIGA_MAC_VER_65 },
>  		{ 0x7cf, 0x688,	RTL_GIGA_MAC_VER_64 },
> @@ -3842,6 +3869,7 @@ static void rtl_hw_config(struct rtl8169_private *tp)
>  		[RTL_GIGA_MAC_VER_63] = rtl_hw_start_8125b,
>  		[RTL_GIGA_MAC_VER_64] = rtl_hw_start_8125d,
>  		[RTL_GIGA_MAC_VER_65] = rtl_hw_start_8125d,
> +		[RTL_GIGA_MAC_VER_66] = rtl_hw_start_8125d,
>  		[RTL_GIGA_MAC_VER_70] = rtl_hw_start_8126a,
>  		[RTL_GIGA_MAC_VER_71] = rtl_hw_start_8126a,
>  	};
> @@ -3861,6 +3889,7 @@ static void rtl_hw_start_8125(struct rtl8169_private *tp)
>  	case RTL_GIGA_MAC_VER_61:
>  	case RTL_GIGA_MAC_VER_64:
>  	case RTL_GIGA_MAC_VER_65:
> +	case RTL_GIGA_MAC_VER_66:
>  		for (i = 0xa00; i < 0xb00; i += 4)
>  			RTL_W32(tp, i, 0);
>  		break;
> diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drivers/net/ethernet/realtek/r8169_phy_config.c
> index 968c8a2185a4..cf95e579c65d 100644
> --- a/drivers/net/ethernet/realtek/r8169_phy_config.c
> +++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
> @@ -1102,6 +1102,28 @@ static void rtl8125d_hw_phy_config(struct rtl8169_private *tp,
>  	rtl8125_config_eee_phy(phydev);
>  }
>  
> +static void rtl8125bp_hw_phy_config(struct rtl8169_private *tp,
> +				    struct phy_device *phydev)
> +{
> +	r8169_apply_firmware(tp);
> +	rtl8168g_enable_gphy_10m(phydev);
> +
> +	r8168g_phy_param(phydev, 0x8010, 0x0800, 0x0000);
> +
> +	phy_write(phydev, 0x1f, 0x0b87);
> +	phy_write(phydev, 0x16, 0x8088);
> +	phy_modify(phydev, 0x17, 0xff00, 0x9000);
> +	phy_write(phydev, 0x16, 0x808f);
> +	phy_modify(phydev, 0x17, 0xff00, 0x9000);
> +	phy_write(phydev, 0x1f, 0x0000);
> +
> +	r8168g_phy_param(phydev, 0x8174, 0x2000, 0x1800);
> +
> +	rtl8125_legacy_force_mode(phydev);
> +	rtl8168g_disable_aldps(phydev);
> +	rtl8125_config_eee_phy(phydev);
> +}
> +
>  static void rtl8126a_hw_phy_config(struct rtl8169_private *tp,
>  				   struct phy_device *phydev)
>  {
> @@ -1163,6 +1185,7 @@ void r8169_hw_phy_config(struct rtl8169_private *tp, struct phy_device *phydev,
>  		[RTL_GIGA_MAC_VER_63] = rtl8125b_hw_phy_config,
>  		[RTL_GIGA_MAC_VER_64] = rtl8125d_hw_phy_config,
>  		[RTL_GIGA_MAC_VER_65] = rtl8125d_hw_phy_config,
> +		[RTL_GIGA_MAC_VER_66] = rtl8125bp_hw_phy_config,
>  		[RTL_GIGA_MAC_VER_70] = rtl8126a_hw_phy_config,
>  		[RTL_GIGA_MAC_VER_71] = rtl8126a_hw_phy_config,
>  	};

What is the PHY ID of the integrated PHY? Is an extension to the Realtek PHY driver needed?

Under rtl_hw_config() you don't add an entry for the new chip version,
what doesn't feel right, e.g. MAC EEE isn't initialized.
Is this by intent?



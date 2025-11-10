Return-Path: <netdev+bounces-237270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCDFC47F8C
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 17:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C40D188CEF2
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F8827A904;
	Mon, 10 Nov 2025 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODpHXld4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005432749D2
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792573; cv=none; b=lcFydlmrXWAAnA7HBBbgvWbiafZ3XU5JNm0QW8eN6T0ZiJKANete5yMNtUbUolzXjqIBsYJC74RGgiJQDKtfs76X7Cj4Q2VrwE/e8v7qRT392mewoYKo6v1hjnrX4dOkt0ZYAcrI2zQzGxsVugHtUty8CyuSgJFtJbmp+fhZU1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792573; c=relaxed/simple;
	bh=yNST3azyTjbEzIfSXsR4ftDpA3b1K/IxtYd636Ors3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QJrxsIkXsh0nGWN0NWTUW8jrN/X9x96Fs1qSOYaCc5Isyx0EdBXqCOIRulMk+ANg9yC0guSvjt2YGVROFGE0vAY78X/5s9SjKrDO+FPhcfen7wjnVqBlz7zQUmDGI19q2ZjKVb0OJXWL3DvD/eT+XfKGntXRZ3RcSrdu2Ja8mZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODpHXld4; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so22724895e9.1
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 08:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762792570; x=1763397370; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nhAB4koRV8OuSw3ZkNH4jbevIDkGt3mgNcrifk4gAgI=;
        b=ODpHXld4lc46GHDiy6xfLCTyRQdy6+PFZCBgyLe04sSo1Iw5/MYyYwH+Kz1FFiQS9y
         WK5s8fOmzLAcTELmELc3SxARKxaoam519UkWodjCaQgaAiM31RYzyPi6u8riWeC+Z6i6
         KRJEspwxE3JDcodZLnmaiGpuS99ETEB7dcL/IUk1p2VFuGiolAJFaYcwt6Lj73vqkpQf
         b57GU+9mWrD0eDmiDKHAQgTt81zYXiOoYZfOKWCfXPFIxJnpqHxwkSo0sXnGxIAejNYI
         2MtCn5lKs0bEUBK7tLCcgL87oi7t6MTFKr0u6nlW/ZzeFyhh/0akpYKyBS5S+bEjb4+m
         u5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792570; x=1763397370;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nhAB4koRV8OuSw3ZkNH4jbevIDkGt3mgNcrifk4gAgI=;
        b=Mi35tfHxmk5wkeVzmwz/HKr4izSbhZqPR7lDRRgkrO/g5NCbDEV7gFwGDlrh6w7ECr
         lt8ZgOG8usUHnNlwLOX8swiA1g8PaXtOdNuPBGyYr5EACmNdVk6A34mGl4ABuc0QB8LO
         B+oYNRhconq014LujKxuwzgWfuwgK1+OVlhekTrSZlp+tKFMHlypM/8oLZjsC4HBfLbx
         3UuvfNETEenLnDNU4A/P19xVdYXQTC3StzDRnSmvgPyJd8dsw/hvhT4fKCPOJwtbYn+b
         R0HtPJPeHpk+S6V7Q9rm/8JSRrz6jTrclM+rWGRrcqspHyTr9Iq8S4NiTgZftZG4meny
         769Q==
X-Gm-Message-State: AOJu0YwkTZGPebjihhQxwAt8Zv3twXJ66xDEjD1MZl4ZzC6M9Q+8iyZ/
	/bH4Aray8P5S4vx46uq4+SHf8NrM9THDE4FIVCZ1+1kPdab2vaxvK7pg
X-Gm-Gg: ASbGncuiGYQqG8HIYQ/xt6Rzv4vdOA+gk1V/bsj0YQkoGOya9Tf3N+s/Tu8o1J2Ru8l
	ydYLWzLbYPUUnQqQb2K2fyYuyMb4x1iJOyjoIUdXa1fkNvsBUWulFrSjes43qwIKbrrq5QSW3OG
	ybUA6NGFL6yPdcoE0s+XizdSYbOKqeayRSugYGkUwnofdjFOfPKUoj6Jrif2Osh4J0jX1HTBikJ
	yyOM8HtHGE6aYIgmSct3/E+COlwttzupoVYRMWONxEnZUBzJy463xtKySxOGzorW2toFvrU780U
	3Zul+3giY3UUo/+fJqfUwipLMBnHpjFp6tpYP9PkHUE5t3TXjesEamtznbSC1BiTXSQNdzK5iY8
	Zst9wASNbhIBjO9z6OOfdPFGNsgJgvp5Qjp+k2uB0K0zTsHBQa8Vlpnb6N0E+CMsUV4nVIZkEjr
	ZQrjyLqzSUjJlB8vjnvrqjvBNEA5j8zTANdINbjWzYpSu82MaUMSxlvmQRkajmGinczq0/CLw44
	U9P/qW/pi1yg6r7e/TgyFMNwkVvEKifHrw8gduif76r1I13Y+KfWQ==
X-Google-Smtp-Source: AGHT+IGs5J1xMt/Q53jRJfEgjoMy3/YUcsKcG5K93obiroIZyFWnVkswPcCfCztZiqkkrd0lEC/Ppg==
X-Received: by 2002:a05:600c:3b11:b0:477:fcb:2256 with SMTP id 5b1f17b1804b1-4777323ec9amr65987355e9.17.1762792569980;
        Mon, 10 Nov 2025 08:36:09 -0800 (PST)
Received: from ?IPV6:2003:ea:8f33:1e00:300e:33dd:b203:22f9? (p200300ea8f331e00300e33ddb20322f9.dip0.t-ipconnect.de. [2003:ea:8f33:1e00:300e:33dd:b203:22f9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4777f1b61acsm32277365e9.3.2025.11.10.08.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 08:36:09 -0800 (PST)
Message-ID: <f341419d-d565-446e-8030-bd2e7ee5d764@gmail.com>
Date: Mon, 10 Nov 2025 17:36:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] r8169: add support for RTL8125K
To: javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251110093558.3180-1-javen_xu@realsil.com.cn>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20251110093558.3180-1-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/2025 10:35 AM, javen wrote:
> This adds support for chip RTL8125K. Its XID is 0x68a. It is basically
> based on the one with XID 0x688, but with different firmware file.
> 
If the only difference is the firmware, then you don't need to add a new
chip version number. You can reuse RTL_GIGA_MAC_VER_64.

{ 0x7cf, 0x68a, RTL_GIGA_MAC_VER_64, "RTL8125K", FIRMWARE_8125K_1 }

> Signed-off-by: javen <javen_xu@realsil.com.cn>
> ---
>  drivers/net/ethernet/realtek/r8169.h            | 1 +
>  drivers/net/ethernet/realtek/r8169_main.c       | 5 +++++
>  drivers/net/ethernet/realtek/r8169_phy_config.c | 1 +
>  3 files changed, 7 insertions(+)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/realtek/r8169.h
> index 2c1a0c21af8d..050ba3f4f874 100644
> --- a/drivers/net/ethernet/realtek/r8169.h
> +++ b/drivers/net/ethernet/realtek/r8169.h
> @@ -68,6 +68,7 @@ enum mac_version {
>  	RTL_GIGA_MAC_VER_61,
>  	RTL_GIGA_MAC_VER_63,
>  	RTL_GIGA_MAC_VER_64,
> +	RTL_GIGA_MAC_VER_65,
>  	RTL_GIGA_MAC_VER_66,
>  	RTL_GIGA_MAC_VER_70,
>  	RTL_GIGA_MAC_VER_80,
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index d18734fe12e4..2adffbc691b3 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -57,6 +57,7 @@
>  #define FIRMWARE_8125B_2	"rtl_nic/rtl8125b-2.fw"
>  #define FIRMWARE_8125D_1	"rtl_nic/rtl8125d-1.fw"
>  #define FIRMWARE_8125D_2	"rtl_nic/rtl8125d-2.fw"
> +#define FIRMWARE_8125K_1	"rtl_nic/rtl8125k-1.fw"
>  #define FIRMWARE_8125BP_2	"rtl_nic/rtl8125bp-2.fw"
>  #define FIRMWARE_8126A_2	"rtl_nic/rtl8126a-2.fw"
>  #define FIRMWARE_8126A_3	"rtl_nic/rtl8126a-3.fw"
> @@ -110,6 +111,7 @@ static const struct rtl_chip_info {
>  	{ 0x7cf, 0x681,	RTL_GIGA_MAC_VER_66, "RTL8125BP", FIRMWARE_8125BP_2 },
>  
>  	/* 8125D family. */
> +	{ 0x7cf, 0x68a, RTL_GIGA_MAC_VER_65, "RTL8125K", FIRMWARE_8125K_1 },
>  	{ 0x7cf, 0x689,	RTL_GIGA_MAC_VER_64, "RTL8125D", FIRMWARE_8125D_2 },
>  	{ 0x7cf, 0x688,	RTL_GIGA_MAC_VER_64, "RTL8125D", FIRMWARE_8125D_1 },
>  
> @@ -770,6 +772,7 @@ MODULE_FIRMWARE(FIRMWARE_8125A_3);
>  MODULE_FIRMWARE(FIRMWARE_8125B_2);
>  MODULE_FIRMWARE(FIRMWARE_8125D_1);
>  MODULE_FIRMWARE(FIRMWARE_8125D_2);
> +MODULE_FIRMWARE(FIRMWARE_8125K_1);
>  MODULE_FIRMWARE(FIRMWARE_8125BP_2);
>  MODULE_FIRMWARE(FIRMWARE_8126A_2);
>  MODULE_FIRMWARE(FIRMWARE_8126A_3);
> @@ -3844,6 +3847,7 @@ static void rtl_hw_config(struct rtl8169_private *tp)
>  		[RTL_GIGA_MAC_VER_61] = rtl_hw_start_8125a_2,
>  		[RTL_GIGA_MAC_VER_63] = rtl_hw_start_8125b,
>  		[RTL_GIGA_MAC_VER_64] = rtl_hw_start_8125d,
> +		[RTL_GIGA_MAC_VER_65] = rtl_hw_start_8125d,
>  		[RTL_GIGA_MAC_VER_66] = rtl_hw_start_8125d,
>  		[RTL_GIGA_MAC_VER_70] = rtl_hw_start_8126a,
>  		[RTL_GIGA_MAC_VER_80] = rtl_hw_start_8127a,
> @@ -3863,6 +3867,7 @@ static void rtl_hw_start_8125(struct rtl8169_private *tp)
>  	switch (tp->mac_version) {
>  	case RTL_GIGA_MAC_VER_61:
>  	case RTL_GIGA_MAC_VER_64:
> +	case RTL_GIGA_MAC_VER_65:
>  	case RTL_GIGA_MAC_VER_66:
>  	case RTL_GIGA_MAC_VER_80:
>  		for (i = 0xa00; i < 0xb00; i += 4)
> diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drivers/net/ethernet/realtek/r8169_phy_config.c
> index 032d9d2cfa2a..dff1daafc8a7 100644
> --- a/drivers/net/ethernet/realtek/r8169_phy_config.c
> +++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
> @@ -1344,6 +1344,7 @@ void r8169_hw_phy_config(struct rtl8169_private *tp, struct phy_device *phydev,
>  		[RTL_GIGA_MAC_VER_61] = rtl8125a_2_hw_phy_config,
>  		[RTL_GIGA_MAC_VER_63] = rtl8125b_hw_phy_config,
>  		[RTL_GIGA_MAC_VER_64] = rtl8125d_hw_phy_config,
> +		[RTL_GIGA_MAC_VER_65] = rtl8125d_hw_phy_config,
>  		[RTL_GIGA_MAC_VER_66] = rtl8125bp_hw_phy_config,
>  		[RTL_GIGA_MAC_VER_70] = rtl8126a_hw_phy_config,
>  		[RTL_GIGA_MAC_VER_80] = rtl8127a_1_hw_phy_config,



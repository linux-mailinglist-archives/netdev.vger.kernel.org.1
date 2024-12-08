Return-Path: <netdev+bounces-150006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 023389E87FF
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 22:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B175E2808B5
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 21:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA74189521;
	Sun,  8 Dec 2024 21:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnQLy+wZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00CD381AF;
	Sun,  8 Dec 2024 21:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733691714; cv=none; b=FBCfkXdtliOLa1bi3IDds2cQTNx6jRAvWegQUPUfEdYNRcPq3iUFhtC0E1m5fHCKMoy7gTDxqea8ERHyt3Iute0PiHNv+NH75HgjCGd5uhmJJ+V3zQyhuzhvDPpFySfOZfyg9RP3mfpxSTmJpAHWODpCTOEK+54ot/hGF01E/JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733691714; c=relaxed/simple;
	bh=f30at0/0ceFYBghQDHOfUSVB7yLvlLBQj2G+9DkF+II=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f0pptcgaulbuAiT4rVaCvYYwB8JXMjXXYQvBZ6ux9dnqsbj8qL5MSut28nDQRraIcQud7oh2kqyFI8V0BeHzacPl79YMf8u4DcfIufINbwVqIOnaSheEe8/aqA236mNp6SGFBVDmcp1JN3VdsPC0Yyr8CxoB/JVAaKU8NShL8aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnQLy+wZ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa662795ca3so181731866b.1;
        Sun, 08 Dec 2024 13:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733691711; x=1734296511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QkF/BFoc8wVK8BvfjolpvGexi4hII2fZHEMeMmm+v7w=;
        b=GnQLy+wZ1Cwrh8uQRtL6+DpoMjA6SL3A/ooihNLkVXEqKEgs8AyfPUcW8ULbWMSQwC
         fVo5TSkSeDBfg4c9Ga0e0TtlUa/CF8kUMF3FRiz3OPbAcTQcJdUpb+qXd+fGLhEPs2NI
         +qUHipN4BVo9GEERqA4oYi681kI0gf9vDZNRqynqow2QeMkpgRjSiWeQMoIDJ8cUc21/
         vSauDQuRjOJ6QMn2a3SfVBDcq61vQfve98z0+FaxXCXJuYWFzG0MDDdFwlK7Ua6EibQH
         JuNDUob9efaSmjALEfgzZjczWFx55bPGWFvUOGKK/q66NmJHJs36qYKr4iB8FOLPfbqO
         kyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733691711; x=1734296511;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkF/BFoc8wVK8BvfjolpvGexi4hII2fZHEMeMmm+v7w=;
        b=r5mTOsgQSb8+99S9qsPmiFzCGwxU3GadeuYkzqwI/VggNl6c8FCKTjIx71UN6W8S+k
         cayXOEdUA3HA6M/E/6mQAzCtu4SuuHD4sVVZOH1IN9Fzm8eTZiUBewA8AZfLvo8Rolxi
         L1CRfzKGJAetCjTeq31TBYT0FB2oPtSVJo7aTQivesVadkFnHjKJFfblI3hOo1xpuRYP
         YGgu3wiooT0l+FSgCyW7X5A8vh8uw5X5HBRMhlhSgN2S0y+uN1sYAc8Y/iAZmJDowyXA
         czObbRHos/oI6IHnPcMovQX3I+7VMsK+njldRlbkA+71TRZbgX/gHbcQDQ9CZjFuRi2p
         p/dg==
X-Forwarded-Encrypted: i=1; AJvYcCVL0/cATMGxOtnaNVL6shAtrLEChxGrumHrfwvltpzHPwFwydSYsqR1K3tiwth2QP21S7Dh+VTX@vger.kernel.org, AJvYcCX2U+FuwiN9LOuxbQrszs4VFOL5zVHoifWpeGO+UkCNaNybis38Zj74AQNiMBf3oWPY5fEG6QWmhje7G4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys0/7Cu+XzNPEK1BeiNeloLLfR8XZXQw5MXSFYHQ4NoNCExwP4
	T68F/rILgiwchTnSg4CUsBbUQLSHpziAUscbl2Tt3ccYrvbZ7/zA
X-Gm-Gg: ASbGncsitpHO2dOsmC2uelM/7BQgVFm9qZjHi+6GfuAwkHhjZYNUhbJFRc3xIsHyjJ9
	XTfGVyYBEBy3RmwyDQ2OcxAq9A01IHg0mcDHizLTo3kPmSbpQt6FeRCqjJEzwJWaVgPj7d6wA4N
	qczv/Bn2Us36HEmn8FrZgzzQWUBjPv+eGDElfZL4yHBZT8QZ+TPqLQVk9e/aueJA+K4pNb8+mC+
	V4JNhg2upsLgPnbuUjnjjaXp0ZyW82lhZw+dRg0zvgKivdJk9tmZavQY8z7xz+fgMDFTWVF/ieq
	+f8ARlh3ZKv0+8/ecJlB7799qmof5RxUOyuxYkDGMihNN4QkVyf6bOqjiRW1AzdTfaJp4R/Tq3T
	eEnXirfMqjwpF2MFmZydrYDo/NANt3zARdd/2BzI=
X-Google-Smtp-Source: AGHT+IGrTakZqolaY1s1Gzi8Jy1XSaqaVqRv7YXvto5Po8BX57yWFJIbuKO3KwY14QSdrc+i11G7CA==
X-Received: by 2002:a17:907:724e:b0:aa6:68bc:160d with SMTP id a640c23a62f3a-aa668bc192emr493582366b.16.1733691710604;
        Sun, 08 Dec 2024 13:01:50 -0800 (PST)
Received: from ?IPV6:2a02:3100:a0a2:300:591f:8fe7:8c1e:2d69? (dynamic-2a02-3100-a0a2-0300-591f-8fe7-8c1e-2d69.310.pool.telefonica.de. [2a02:3100:a0a2:300:591f:8fe7:8c1e:2d69])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aa68c894472sm24548066b.87.2024.12.08.13.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2024 13:01:50 -0800 (PST)
Message-ID: <9e966066-b98b-4fb9-b6ea-161d0e2f1992@gmail.com>
Date: Sun, 8 Dec 2024 22:01:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] r8169: Add quirks to enable ASPM on Dell platforms
To: Guy Chronister <guyc.linux.patches@gmail.com>
Cc: nic_swsd@realtek.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Koba Ko <koba.ko@canonical.com>, Timo Aaltonen
 <timo.aaltonen@canonical.com>, Andrea Righi <andrea.righi@canonical.com>
References: <20241208191039.2240-1-guyc.linux.patches@gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20241208191039.2240-1-guyc.linux.patches@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08.12.2024 20:10, Guy Chronister wrote:
> Some non-Dell platforms equipped with r8168h/r8111 have issues with ASPM. It's very hard to fix all known issues in a short time and r8168h/r8111 is not a brand new NIC chip, so introduce the quirk for Dell platforms. It's also easier to track the Dell platform and ask for Realtek's effort.

Which known issues do you refer to? If it's very hard to fix all, then fix some.

Did you verify that ASPM L1.2 doesn't result in missed rx packets even under heavy load?
Check chip hw stats. I have a test system with RTL8168h which works fine up to ASPM L1.1,
but misses rx packets with ASPM L1.2 under heavy load.

> Make the original matching logic more explicit.
> 
> Signed-off-by: Koba Ko <koba.ko@canonical.com>
> Signed-off-by: Timo Aaltonen <timo.aaltonen@canonical.com>
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> Signed-off-by: Guy Chronister <guyc.linux.patches@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 83 ++++++++++++++++++++++-
>  1 file changed, 80 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 6934bdee2a91..3c1cf704492f 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -15,6 +15,7 @@
>  #include <linux/etherdevice.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> +#include <linux/dmi.h>
>  #include <linux/ethtool.h>
>  #include <linux/hwmon.h>
>  #include <linux/phy.h>
> @@ -5322,13 +5323,89 @@ static void rtl_init_mac_address(struct rtl8169_private *tp)
>  	rtl_rar_set(tp, mac_addr);
>  }
>  
> +static bool rtl_aspm_dell_workaround(struct rtl8169_private *tp)
> +{
> +	static const struct dmi_system_id sysids[] = {
> +		{
> +			.ident = "Dell",
> +			.matches = {
> +				DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +				DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 16 5640"),
> +				DMI_MATCH(DMI_PRODUCT_SKU, "0CA0"),
> +			},
> +		},
> +		{
> +			.ident = "Dell",
> +			.matches = {
> +				DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +				DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 14 3440"),
> +				DMI_MATCH(DMI_PRODUCT_SKU, "0CA5"),
> +			},
> +		},
> +		{
> +			.ident = "Dell",
> +			.matches = {
> +				DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +				DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 14 3440"),
> +				DMI_MATCH(DMI_PRODUCT_SKU, "0CA6"),
> +			},
> +		},
> +		{
> +			.ident = "Dell",
> +			.matches = {
> +				DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +				DMI_MATCH(DMI_PRODUCT_NAME, "Latitude 3450"),
> +				DMI_MATCH(DMI_PRODUCT_SKU, "0C99"),
> +			},
> +		},
> +		{
> +			.ident = "Dell",
> +			.matches = {
> +				DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +				DMI_MATCH(DMI_PRODUCT_NAME, "Latitude 3450"),
> +				DMI_MATCH(DMI_PRODUCT_SKU, "0C97"),
> +			},
> +		},
> +		{
> +			.ident = "Dell",
> +			.matches = {
> +				DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +				DMI_MATCH(DMI_PRODUCT_NAME, "Latitude 3550"),
> +				DMI_MATCH(DMI_PRODUCT_SKU, "0C9A"),
> +			},
> +		},
> +		{
> +			.ident = "Dell",
> +			.matches = {
> +				DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +				DMI_MATCH(DMI_PRODUCT_NAME, "Latitude 3550"),
> +				DMI_MATCH(DMI_PRODUCT_SKU, "0C98"),
> +			},
> +		},
> +		{}
> +	};
> +
> +	if (tp->mac_version == RTL_GIGA_MAC_VER_46 && dmi_check_system(sysids))
> +		return true;
> +
> +	return false;
> +}
> +
>  /* register is set if system vendor successfully tested ASPM 1.2 */
>  static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
>  {
> -	if (tp->mac_version >= RTL_GIGA_MAC_VER_61 &&
> -	    r8168_mac_ocp_read(tp, 0xc0b2) & 0xf)
> +	 /* definition of 0xc0b2,
> +	  * 0: L1
> +	  * 1: ASPM L1.0
> +	  * 2: ASPM L0s
> +	  * 3: CLKEREQ
> +	  * 4-7: Reserved
> +	  */
> +	if ((tp->mac_version >= RTL_GIGA_MAC_VER_61 &&
> +		 (r8168_mac_ocp_read(tp, 0xc0b2) & 0x0F)) ||
> +		rtl_aspm_dell_workaround(tp)) {
>  		return true;
> -
> +	}
>  	return false;
>  }
>  

This approach doesn't scale. I don't want to end up with hundreds of such dmi checks.
I understand that the driver works as-is, you just want to enable ASPM per default
on these systems. You have two options to enable ASPM:

1. Check with Realtek whether this register 0xc0b2 (or an equivalent) can be used on
   RTL8168h and these Dell systems too. If yes, may require a BIOS update to enable
   the functionality.
2. (Re-)enable ASPM states from user space: Use attributes under /sys/class/net/<if>/device/link



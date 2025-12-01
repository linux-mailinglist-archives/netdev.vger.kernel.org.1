Return-Path: <netdev+bounces-243057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E38FC98FBA
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 21:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0F7B3A3F68
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 20:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558A0A937;
	Mon,  1 Dec 2025 20:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMnHAgss"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8A336D50A
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 20:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764620148; cv=none; b=b0UdTE11Ig9qlZTkl0lgTocdZNE6ta8pnL0lV0YcM87VyOXERnXafo0ZnbgqtUFldLTMEXFMgCD+2NwBBDt8E2NeIimxTPrbYYp6LWYmxVAQQqNimVv/hJX6TirlnafzVSW6wtOGRU99RwNFR2y7sHZXyiUfHAJjNg8Z+fm28P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764620148; c=relaxed/simple;
	bh=kFVJ0uvHtyOaEmgu4wk5KU8D9SYhRs+1WyqkDyQ/xaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J5dvzGQA2r0dz/OtuPMiEDuQVsya+mLN1SHNUx++jsrN4BWWt1NvXnkknR0VFrCeSSWRWSGviaCFs+Lat/MozoFueRoVLrLmtSacypxz/uqli0du47lgN9U3vOEctHucyUbxKT0uX0eL6p95fML2JlI+OKaTnIbAW6g7VRtMdS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMnHAgss; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47778b23f64so26995395e9.0
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 12:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764620145; x=1765224945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8NpD0pPWvoSBxfekaJFv0hp8Kg1sYiWIA99eWAPfld4=;
        b=cMnHAgssHgIkwWGKpKqxsou9mYPKhSrXoXQf21Ax1uPeMXIwNKFp1k9C3qcplj1FWm
         24/htlMeNGWK2u0NIKUtwCk0JIPkzG26/XWd/t58qQnumJd87S4gpT8etGtC+RAmHi7Y
         WjBFQSK2UBpy6C6zjeugTCpusEV9BwHTVZCsrVKShXU2fUwlAVkfnOzbJgsYDcfw4kyZ
         X5ZbDuerEtwaLBCoj+BVoCllWSmv5PmGuSKevz6DW2rWwr02WWc9QE6I6B4QVcxbcRyB
         /MGwerr1AGKr2LCDeXkr1H4JdhwD0J1oV+5sFWX/vRdrc6pfvIqelHE9QNtrlltPTLnN
         9XGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764620145; x=1765224945;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8NpD0pPWvoSBxfekaJFv0hp8Kg1sYiWIA99eWAPfld4=;
        b=lAyyM+Xagkj4AAPgoabS4mkz94t+dJDgI25Zz9Hy1/5zlAnVttO7AnoDpEf2up9xN1
         PufI1FRE0DLMV2dcw2yGHtDvUg7dJLlJn2OxJ8s3wM6nz79B/VJyILNO12as8s+ci/8+
         +oEcevbpMBForaQwdf/sWlORgs4UA3iJFiBWazGahOiT9pDk25HTGRp9gJyzZamFaFsb
         /BbSF8jkLYiN+bEJMWTJycgfAXXh/zHmwThC56ycTruoev1c2VQYRp++212cmbUBxYy1
         sSydLG/OJW2Tn6XSqCUFWOWdvejyr/En8+xN8AmWtnv1cABI9iRRa0EQzQrxIbddJlV6
         96Gw==
X-Forwarded-Encrypted: i=1; AJvYcCVzLTcVtbQs4jA037P+QtZMiR+H4QYsK02FvX3szVifGeEFFJsuKfxATZTfsRolA50hLdCEBLA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxntw+UgEuiyBbAlGPmIrBZTiFKFBaQUqvsJy07VYPOYveliCdG
	XenR/jdyrXWvXPEpqFip5Ui2LWY5oxA9pu7K8KzFZXBKyT44p0em0gij
X-Gm-Gg: ASbGncsJO714BJLhyx19U3RFjFYwS1MGPNw41hVAUHmUMkXgYywTV2Eb0q+v2xHqrwa
	F8eMVPD+IhEeuq5xh2LkvtdTVw2a2Vr6MIGdOd+L3UIP03BfR2DH3UkH/ZDZiJ3P6NMNYuMtwj8
	R6arz28f3tLtwUT6bb3Tc6t27BoY7jI9R40D/8qEGC27svq4SpKE4GdwLMAjLmwIlRegLDiO1ik
	kAWT8uq4PbEKlZXmnufY/NgLI/yJdoNJsjayW/pmTBBPlySSwiIlAlOST/ZpXfmxFprXGcIHWj7
	M12OyVAXa047UGU/4IJ8GtVA3GaOphpCM6Rpfi61Fs5gAiGJySXsZB0A7WV3EaDLC/ptli+zmXN
	SleOsWnklkr8DgD9rSzhDci9ip6UQw838XjmFgSgk41tCo0xx+ywlE446+B2M/bngc+Y86LTcQC
	Iv89PCECg9qH0oafTbFNg0r31yT+a5MhYG2HeHiqbNsI9OGH++ueJC14YbwhZBOeWiJ/4PR6qnd
	ZL11j58EdxPr5TKmHNzHUC8SrTwsyImhkcYk4Z9AV2LsXF6OUfxaNMSKKLIt8wS
X-Google-Smtp-Source: AGHT+IGK+uZRODdESFZnol9e6RZIL/hUBWeUaa06uOaeB556F+J1KquchH326zAjH0pihfCfLObN9g==
X-Received: by 2002:a05:600c:3b08:b0:477:214f:bd95 with SMTP id 5b1f17b1804b1-477c114df06mr364851105e9.23.1764620144329;
        Mon, 01 Dec 2025 12:15:44 -0800 (PST)
Received: from ?IPV6:2003:ea:8f22:2e00:255f:6a3a:f305:e725? (p200300ea8f222e00255f6a3af305e725.dip0.t-ipconnect.de. [2003:ea:8f22:2e00:255f:6a3a:f305:e725])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca1a3e4sm28578880f8f.25.2025.12.01.12.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Dec 2025 12:15:43 -0800 (PST)
Message-ID: <8bee22b7-ed4c-43d1-9bf2-d8397b5e01e5@gmail.com>
Date: Mon, 1 Dec 2025 21:15:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] r8169: fix RTL8117 Wake-on-Lan in DASH mode
To: =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactco.de>, netdev@vger.kernel.org
Cc: nic_swsd@realtek.com
References: <20251201.201706.660956838646693149.rene@exactco.de>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20251201.201706.660956838646693149.rene@exactco.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/1/2025 8:17 PM, René Rebe wrote:
> Wake-on-Lan does currently not work in DASH mode, e.g. the ASUS Pro WS
> X570-ACE with RTL8168fp/RTL8117.
> 
> Fix by not returning early in rtl_prepare_power_down when dash_enabled.
Good

> While this fixes WOL, it still kills the OOB RTL8117 remote management
> BMC connection. Fix by not calling rtl8168_driver_stop if wol is enabled.
> 
You mean remote management whilst system is powered down and waiting
for a WoL packet? Note that link speed is reduced to a minimum then,
and DMA is disabled. Who would drive the MAC?
Realtek doesn't provide any chip documentation, therefore it's hard to
say what is expected from the MAC driver in DASH case.

> While at it, enable wake on magic packet by default, like most other
> Linux drivers do.
> 
It's by intent that WoL is disabled per default. Most users don't use WoL
and would suffer from higher power consumption if system is suspended
or powered down.
Which benefit would you see if WoL would be enabled by default
(in DASH and non-DASH case)?

> Signed-off-by: René Rebe <rene@exactco.de>

Your patch apparently is meant to be a fix. Therefore please add Fixes
tag and address to net tree.
https://www.kernel.org/doc/Documentation/networking/netdev-FAQ.rst
And please add all netdev maintainers when re-submitting.
scripts/get_maintainer.pl provides all needed info.

> ---
> 
> There is still another issue that should be fixed: the dirver init
> kills the OOB BMC connection until if up, too. We also should probaly
> not even conditionalize rtl8168_driver_stop on wol_enabled as the BMC
> should always be accessible. IMHO even on module unload.
> 
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 853aabedb128..e2f9b9027fe2 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -2669,9 +2669,6 @@ static void rtl_wol_enable_rx(struct rtl8169_private *tp)
>  
>  static void rtl_prepare_power_down(struct rtl8169_private *tp)
>  {
> -	if (tp->dash_enabled)
> -		return;
> -
>  	if (tp->mac_version == RTL_GIGA_MAC_VER_32 ||
>  	    tp->mac_version == RTL_GIGA_MAC_VER_33)
>  		rtl_ephy_write(tp, 0x19, 0xff64);
> @@ -4807,7 +4804,7 @@ static void rtl8169_down(struct rtl8169_private *tp)
>  	rtl_disable_exit_l1(tp);
>  	rtl_prepare_power_down(tp);
>  
> -	if (tp->dash_type != RTL_DASH_NONE)
> +	if (tp->dash_type != RTL_DASH_NONE && !tp->saved_wolopts)
>  		rtl8168_driver_stop(tp);
>  }
>  
> @@ -5406,6 +5403,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	tp->pci_dev = pdev;
>  	tp->supports_gmii = ent->driver_data == RTL_CFG_NO_GBIT ? 0 : 1;
>  	tp->ocp_base = OCP_STD_PHY_BASE;
> +	tp->saved_wolopts = WAKE_MAGIC;
>  
>  	raw_spin_lock_init(&tp->mac_ocp_lock);
>  	mutex_init(&tp->led_lock);
> @@ -5565,6 +5563,9 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (rc)
>  		return rc;
>  
> +	if (tp->saved_wolopts)
> +		__rtl8169_set_wol(tp, tp->saved_wolopts);
> +
>  	rc = register_netdev(dev);
>  	if (rc)
>  		return rc;



Return-Path: <netdev+bounces-247430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F0BCFA50C
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 19:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CB5233CB11E
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 18:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D632701BB;
	Tue,  6 Jan 2026 18:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENGjtcp4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8A819258E
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 18:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767722801; cv=none; b=mq/7sf2LWMWAIMNOUTMiZNf19IW++/Wa9uFpF72VGpfqq6JleyfbAKQMA1ylgpbeZBChcpC7iRiOW2ZG93+alHipo0OKP1xSSubg1ZCi9k2kpRfu3u5E0nLbjzc93hJQ2vhw3AY3dHnaO6RooZKBbiinDhdNxmIUShfdb/BieuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767722801; c=relaxed/simple;
	bh=NPyQcav2krgnLWyDGTohZLZVur0OnTqQHzvso3gS9gU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q8bG6EtbgkmPm8YGhjBObedoJAhUuzgDUrH5X0RO5swK3g/QADXJIJRdPNvk4tpQV0KRVGLmQbdxr4m0pRVJyUwvWHc6bEEQYesri2m9tABybhV09m86aVgSU2lSsAXmvk6GnO13Wa4ZceI0WJfV7aFKUqCbWyQJIRCm4+wZUug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENGjtcp4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47d5e021a53so9348225e9.3
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 10:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767722798; x=1768327598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R7u5jLTYA4c3DVTtb38caOiF3uMdXpHH3qq8F4raeWk=;
        b=ENGjtcp4f4vyipweeNfAq52XeDg7ch1zWlGbDi7D28gElNFREpqba/INddgmnmYPq0
         rwcDZqJO5K4snQoIdDAByNSHKfqhqB0YkzVLWpTtosV1Xy2PR//hudOSe+rQxZXxTXwg
         uGrbx5//tHWUo7V4HxoYZVL0v92ybz2NsTrzhoz7McgIhvtplZi4OCaRjrgbwMvj01y3
         2ZGlY6PXoR9krYIRKXkG6qU+yB6qs+nzURbAK9DqD9krIZnSi/eGF5Cjp4AE8uzMoRZ+
         c3+mdYGbFMrt3T2pROqWTACbSbGQxo1zTpBUcRcmC56op7+haq1u6hpaaqd1oaNrInlQ
         3Ipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767722798; x=1768327598;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R7u5jLTYA4c3DVTtb38caOiF3uMdXpHH3qq8F4raeWk=;
        b=XUvfnB6D7SrgyJbsyivYJe00wFWsTzNnZQIDjhU0MQx3ntPYjNxCzVeQTsNCPGcBYY
         UvF1jHIwAepycYqbztM1Is1JTcpbcYADEbw0x7tQ7ihWBUHuJfYnlJ6SMIuWJEnxTrzF
         CJzCP0cjLrEN7HY08i0IwRvW2+2st1mq0SzIj+Zetr7ea+G1sdqozOH/4mvilo7vsndu
         fP4JytBiKoVlLH5knIkLy7b20FHVmEy8psL3FQD6HGwNOkb8K+GmOKPTThdEqKjgKJQ5
         csHFz7nLk0OPPbM/n/XJPUDrMVNw5g09yMhDEjCM3nnrLsBwQWgKJI69tNIrIH+hGdd/
         egcg==
X-Gm-Message-State: AOJu0YwiJN0e/AZagh3SRBbnKqMeM/Q9gYIuU8ZszZK/RirPVsdfdFJ/
	EyBoa736WpEetfw9boHrUhl6T+YUBby9xFvc0xy0V/ssQ+lX3pGr1+BJ
X-Gm-Gg: AY/fxX79b12V0tz1F4LaWei3+daH1yv1HnKHQ9lFPcQ+UtAt2XhNc6trqP9GVK8L/tg
	0eAPL+TFgf7czcFvlrVfzjX70IFqb1W2BgkVQi0nOht5KqW2VaOba25vtWqhiQ+DXW3ZpuXI7TX
	Eg6ltwdCzOid2lzDfvknbsqq1YrFm/uQuGJcbjCjTZuwjQpnpU7Ne2fH90DR+210w0lFk0Yi/Y9
	Wk27JK9wqFwOar5zw+UM3W2alG5BNswHWwsbamG8AjLF7bTixvzSGR2pKyxjkmt3eiMRslS6Yy6
	lbJnGvJPXdRH10XcAkM1BVM3MrtCgCfy9tBXcFlFVCK/4IV8P4lF5OttHta8TSQPrqktVG1Xc+C
	eY+TNbdaEV5NGxK87DEB3I7S0d0HWDTSsxiu2w2hBaAdAV1w8c4Xke8xnJFuv5u1fSl79oGbqBF
	ZAGxdNGvaEWrDLZZxzXvlyjXNwWZsM9s4B4m84zWVh1UPPiJW6zxPeRJOoELg/NqeSttoD/6j7Y
	ArvejJpuL5V0SVUcP06yoh0c1/I+WwWqPROGudmsNsaZ6T4x2+fUg==
X-Google-Smtp-Source: AGHT+IGQnGQuOjKBpcWKWE8MAMWFzkunB1Kbez2otk2nshi3587ggVic6q7KQQUr8YjWL1BQKCQDrQ==
X-Received: by 2002:a05:600c:a02:b0:477:7c7d:d9b7 with SMTP id 5b1f17b1804b1-47d7f0a9337mr39992515e9.33.1767722797943;
        Tue, 06 Jan 2026 10:06:37 -0800 (PST)
Received: from ?IPV6:2003:ea:8f35:e900:51c5:daf3:bde4:546e? (p200300ea8f35e90051c5daf3bde4546e.dip0.t-ipconnect.de. [2003:ea:8f35:e900:51c5:daf3:bde4:546e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f418538sm54360335e9.5.2026.01.06.10.06.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 10:06:37 -0800 (PST)
Message-ID: <847e626b-c103-4884-beca-f8b0e74e3613@gmail.com>
Date: Tue, 6 Jan 2026 19:06:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] r8169: enable LTR support
To: javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260106083012.164-1-javen_xu@realsil.com.cn>
 <20260106083012.164-3-javen_xu@realsil.com.cn>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20260106083012.164-3-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/6/2026 9:30 AM, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch will enable
> RTL8168FP/RTL8168EP/RTL8168H/RTL8125/RTL8126/RTL8127 LTR support.
> 
Few questions:
- Is there a reason to ever disable LTR?
- Is there any known LTR-related problem with the existing code?
  IOW: Should your patch be treated as a fix?
- What is the chip default after a hw reset? Is LTR enabled or disabled?
- Can at least some register numbers (and bits in these registers) be replaced with
  names according to the data sheet? I think of OCP reg 0xe032 and register 0xb6.

> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 98 +++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index f9df6aadacce..97abf95502dc 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -2919,6 +2919,101 @@ static void rtl_disable_exit_l1(struct rtl8169_private *tp)
>  	}
>  }
>  
> +static void rtl_enable_ltr(struct rtl8169_private *tp)
> +{
> +	switch (tp->mac_version) {
> +	case RTL_GIGA_MAC_VER_80:
> +		r8168_mac_ocp_write(tp, 0xcdd0, 0x9003);
> +		r8168_mac_ocp_modify(tp, 0xe034, 0x0000, 0xc000);
> +		r8168_mac_ocp_modify(tp, 0xe0a2, 0x0000, BIT(0));
> +		r8168_mac_ocp_write(tp, 0xcdd2, 0x8c09);
> +		r8168_mac_ocp_write(tp, 0xcdd8, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcdd4, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcdda, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcdd6, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcddc, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcde8, 0x887a);
> +		r8168_mac_ocp_write(tp, 0xcdea, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcdec, 0x8c09);
> +		r8168_mac_ocp_write(tp, 0xcdee, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcdf0, 0x8a62);
> +		r8168_mac_ocp_write(tp, 0xcdf2, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcdf4, 0x883e);
> +		r8168_mac_ocp_write(tp, 0xcdf6, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcdf8, 0x8849);
> +		r8168_mac_ocp_write(tp, 0xcdfa, 0x9003);
> +		r8168_mac_ocp_modify(tp, 0xe032, 0x0000, BIT(14));
> +		break;
> +	case RTL_GIGA_MAC_VER_70:
> +		r8168_mac_ocp_write(tp, 0xcdd0, 0x9003);
> +		r8168_mac_ocp_modify(tp, 0xe034, 0x0000, 0xc000);
> +		r8168_mac_ocp_modify(tp, 0xe0a2, 0x0000, BIT(0));
> +		r8168_mac_ocp_write(tp, 0xcdd2, 0x8c09);
> +		r8168_mac_ocp_write(tp, 0xcdd8, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcdd4, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcdda, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcdd6, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcddc, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcde8, 0x887a);
> +		r8168_mac_ocp_write(tp, 0xcdea, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcdec, 0x8c09);
> +		r8168_mac_ocp_write(tp, 0xcdee, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcdf0, 0x8a62);
> +		r8168_mac_ocp_write(tp, 0xcdf2, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcdf4, 0x883e);
> +		r8168_mac_ocp_write(tp, 0xcdf6, 0x9003);
> +		r8168_mac_ocp_modify(tp, 0xe032, 0x0000, BIT(14));
> +		break;
> +	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_66:
> +		r8168_mac_ocp_write(tp, 0xcdd0, 0x9003);
> +		r8168_mac_ocp_modify(tp, 0xe034, 0x0000, 0xc000);
> +		r8168_mac_ocp_modify(tp, 0xe0a2, 0x0000, BIT(0));
> +		r8168_mac_ocp_write(tp, 0xcdd2, 0x889c);
> +		r8168_mac_ocp_write(tp, 0xcdd8, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcdd4, 0x8c30);
> +		r8168_mac_ocp_write(tp, 0xcdda, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcdd6, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcddc, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcde8, 0x883e);
> +		r8168_mac_ocp_write(tp, 0xcdea, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcdec, 0x889c);
> +		r8168_mac_ocp_write(tp, 0xcdee, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcdf0, 0x8C09);
> +		r8168_mac_ocp_write(tp, 0xcdf2, 0x9003);
> +		r8168_mac_ocp_modify(tp, 0xe032, 0x0000, BIT(14));
> +		break;
> +	case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_52:
> +		r8168_mac_ocp_modify(tp, 0xe034, 0x0000, 0xc000);
> +		r8168_mac_ocp_modify(tp, 0xe0a2, 0x0000, BIT(0));
> +		r8168_mac_ocp_write(tp, 0xe02c, 0x1880);
> +		r8168_mac_ocp_write(tp, 0xe02e, 0x4880);
> +		r8168_mac_ocp_write(tp, 0xcdd8, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcdda, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcddc, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcdd2, 0x883c);
> +		r8168_mac_ocp_write(tp, 0xcdd4, 0x8c12);
> +		r8168_mac_ocp_write(tp, 0xcdd6, 0x9003);
> +		RTL_W8(tp, 0xb6, RTL_R8(tp, 0xb6) | BIT(0));
> +		break;
> +	default:
> +		return;
> +	}
> +	/* chip can trigger LTR */
> +	r8168_mac_ocp_modify(tp, 0xe032, 0x0003, BIT(0));
> +}
> +
> +static void rtl_disable_ltr(struct rtl8169_private *tp)
> +{
> +	switch (tp->mac_version) {
> +	case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_80:
> +		r8168_mac_ocp_modify(tp, 0xe032, 0x0003, 0);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>  static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
>  {
>  	u8 val8;
> @@ -2947,6 +3042,7 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
>  			break;
>  		}
>  
> +		rtl_enable_ltr(tp);
>  		switch (tp->mac_version) {
>  		case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
>  		case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_LAST:
> @@ -2968,6 +3064,7 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
>  			break;
>  		}
>  
> +		rtl_disable_ltr(tp);
>  		switch (tp->mac_version) {
>  		case RTL_GIGA_MAC_VER_70:
>  		case RTL_GIGA_MAC_VER_80:
> @@ -4811,6 +4908,7 @@ static void rtl8169_down(struct rtl8169_private *tp)
>  
>  	rtl8169_cleanup(tp);
>  	rtl_disable_exit_l1(tp);
> +	rtl_disable_ltr(tp);
>  	rtl_prepare_power_down(tp);
>  
>  	if (tp->dash_type != RTL_DASH_NONE && !tp->saved_wolopts)



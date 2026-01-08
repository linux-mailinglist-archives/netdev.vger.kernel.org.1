Return-Path: <netdev+bounces-248195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 907D8D04EA3
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 18:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3814C3025C5A
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 17:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A83233B6EA;
	Thu,  8 Jan 2026 17:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXaSVbwP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A192D8367
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 17:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767892517; cv=none; b=XheZ7S/gwX9yC+NPZ7Mx7qw1LXkdU9+1vT6FjqCp90+RVnzTOixu56DudtZ2dB9ug2TDiLVbZf2iT02WZUvDprAVg692yDl1soZmvEK7OpPFrIsle3NjdKYyzdnrQD8wCp7ztpkqvoFxSccDbFLNt1JUulY9iRUhFBMvklWhcaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767892517; c=relaxed/simple;
	bh=AuDE9ebKxrkOdSB7ljmI0tbKZlH425IN5gpjPydiKnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GhWuiUKYkZcheMot+t9rW2VvKgmoaMSahfpsJCDO4WLtceKUZaY5dws1gJUe5mhYQJlsa144atGnTd/c6HgnykoY44P8BymoiuKoOSiT2simXvDVblT37Q3KzpzsPTTOvdGpIVATZmQezDqfa/mi52qzvpUm66xONn5HCG/dw8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXaSVbwP; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4775ae5684fso16539035e9.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 09:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767892514; x=1768497314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6D1o9jEKajQa0GbPakJfCRGl0DmafU0V8KV51S4R/vU=;
        b=OXaSVbwP4zMzzr7HUJKACWS6H7qgK8onO/qxvKG7TjNKGOFoiqrbXdow9hsP1MM1hn
         rUnFEPVXt48jix8NmFmZ6qbYAzeb67uOHuTIslCXXt+pW83eDtnHQxuStwt1DOhkQYeB
         oW7axzyu696H5jrHkfceSIq1o6JmsPQGTUwDCGHxJP9KOqRAdvtaab/GnJGcKM8/Ou4+
         vDk+QQl8KEEeZtKvedPuCYUscNxjmQl5ASF1eHTQRelYS59cjEMExUdSQnoKpoJPkxk9
         B9fkonuKCbkHHLAcWsy5hPpTVbv08nTMH0ZX29k27gfwbH6smEWA51HzRvj4R9HH6gEE
         si5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767892514; x=1768497314;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6D1o9jEKajQa0GbPakJfCRGl0DmafU0V8KV51S4R/vU=;
        b=TpbybQw3WPJ6TOztujdB0pJs6PhnJmIgU0rfCU0b4ELu4pM464IEKQsetfVvqiOWgb
         fXaisXAt+jYO6sXWNxNsneMH2/dKtnf7Zh1nREZTvhjzVmgp6Pn4bLWDZ+SqaIUp7aDm
         quQ6ZFHJSM3RVxBMaNG5mq/t3tlh/9+KyfFfA9eEqLD3/hOZ7joLyytfznNkHlBxhaLA
         8tDFZrHyZlSaZyNTd8YRQiONtIB3swz1d9h2fRdC8DFtD4tmmCNuy0XRShN38TsEi3ZO
         9knOctnT+abfjGJkL1Nog4svHTQ+pzl8Wfu/F4Zz3rxKpHbcZSh7zcH4526DagOhQDX2
         bDHg==
X-Gm-Message-State: AOJu0YyNivPLob9drPp7dAYNcZgOBeMiyFmkm3cLtnn2BXWmJA7sJU1/
	eUqPs1+hIyX6Q5QEPD6C6T2DU8y40hjvJoalv5WQm/KMjWudgeLF1125
X-Gm-Gg: AY/fxX7tWa6WscfqiG2V5NReYUFRZou9KHkxgeP3IDqzQ2WrLZRCHThLVjhW11uBRgQ
	/Do98QfwwzZrvvOJy4p3KvgtVQOvVgbRK2tBCSjGiRQ54yvnPTBx8USDAAp8FuwDEMu2UxL4E6X
	NWJMv0Z4+1TISf8l0B4ZqjnpdIqdv0fB99jbioPIGIkMYwp7pwYd4fQQaEWXrYIGclh8hXvHrzE
	Dl+CZaz0sdlYB3e04m94+EnGJ4pC/8fmOTkFJZsYdvb9jIoAfXCistfnJASAmGc3QlgQZYq3Kuf
	nRnbZowpWzJTG3ij80i6C9eZx9QtYdq/r8wN1fuWlI36iC1hg9KDrpKlcjhi8FOxRhu93AYVcAN
	wkSelAEuKqV6rgUw5r+c+PTe26RoBvPUgg+gDlYB/67XhV5begvDrMxLhLIpbK9VlQPLV9xcNyn
	Ivvh8JecI8EgDSrQsdjXRI8jRAf2DSKZF0XwI+thW5sqEKs69M+WckuncxBWw17IBnGFjQ6GHgf
	b6vCsLbpndsHYgnoM+zZycvXYGe4p4OFx0STNxSLnkuKA0fnXbQqa7cgi57AyV+
X-Google-Smtp-Source: AGHT+IFcCGgMU+hS+RTRrNzIAjwIWMe0mOqLZMiGxQZB6qJ1qYyPKCs8tNXAEosP7J/qcndq2yiglw==
X-Received: by 2002:a05:600c:3e0d:b0:477:63a4:88fe with SMTP id 5b1f17b1804b1-47d84b0a279mr77807385e9.2.1767892513604;
        Thu, 08 Jan 2026 09:15:13 -0800 (PST)
Received: from ?IPV6:2003:ea:8f14:a400:1d60:60fb:9b76:bf18? (p200300ea8f14a4001d6060fb9b76bf18.dip0.t-ipconnect.de. [2003:ea:8f14:a400:1d60:60fb:9b76:bf18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f653cd6sm171439465e9.9.2026.01.08.09.15.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 09:15:13 -0800 (PST)
Message-ID: <4294bfc4-ca9c-4a37-9079-bcd13dcfa3ac@gmail.com>
Date: Thu, 8 Jan 2026 18:15:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] r8169: enable LTR support
To: javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260108023523.1019-1-javen_xu@realsil.com.cn>
 <20260108023523.1019-3-javen_xu@realsil.com.cn>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20260108023523.1019-3-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/8/2026 3:35 AM, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch will enable
> RTL8168FP/RTL8168EP/RTL8168H/RTL8125/RTL8126/RTL8127 LTR support.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> 
> ---
> v2: Replace some register numbers with names according to datasheet.
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 112 ++++++++++++++++++++++
>  1 file changed, 112 insertions(+)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index f9df6aadacce..1ee5a0b5a6a0 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -312,6 +312,15 @@ enum rtl_registers {
>  	IBIMR0          = 0xfa,
>  	IBISR0          = 0xfb,
>  	FuncForceEvent	= 0xfc,
> +
> +	ALDPS_LTR	= 0xe0a2,
> +	LTR_OBFF_LOCK	= 0xe032,
> +	LTR_SNOOP	= 0xe034,
> +
> +#define ALDPS_LTR_EN			BIT(0)
> +#define LTR_OBFF_LOCK_EN		BIT(0)
> +#define LINK_SPEED_CHANGE_EN		BIT(14)
> +#define LTR_SNOOP_EN			GENMASK(15, 14)
>  };
>  
>  enum rtl8168_8101_registers {
> @@ -397,6 +406,8 @@ enum rtl8168_registers {
>  #define PWM_EN				(1 << 22)
>  #define RXDV_GATED_EN			(1 << 19)
>  #define EARLY_TALLY_EN			(1 << 16)
> +	COMBO_LTR_EXTEND = 0xb6,
> +#define COMBO_LTR_EXTEND_EN 	BIT(0)
>  };
>  
>  enum rtl8125_registers {
> @@ -2919,6 +2930,104 @@ static void rtl_disable_exit_l1(struct rtl8169_private *tp)
>  	}
>  }
>  
> +static void rtl_enable_ltr(struct rtl8169_private *tp)
> +{
> +	switch (tp->mac_version) {
> +	case RTL_GIGA_MAC_VER_80:
> +		r8168_mac_ocp_write(tp, 0xcdd0, 0x9003);
> +		r8168_mac_ocp_modify(tp, LTR_SNOOP, 0x0000, LTR_SNOOP_EN);
> +		r8168_mac_ocp_modify(tp, ALDPS_LTR, 0x0000, ALDPS_LTR_EN);
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
> +		r8168_mac_ocp_modify(tp, LTR_OBFF_LOCK, 0x0000, LINK_SPEED_CHANGE_EN);
> +		break;
> +	case RTL_GIGA_MAC_VER_70:
> +		r8168_mac_ocp_write(tp, 0xcdd0, 0x9003);
> +		r8168_mac_ocp_modify(tp, LTR_SNOOP, 0x0000, LTR_SNOOP_EN);
> +		r8168_mac_ocp_modify(tp, ALDPS_LTR, 0x0000, ALDPS_LTR_EN);
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
> +		r8168_mac_ocp_modify(tp, LTR_OBFF_LOCK, 0x0000, LINK_SPEED_CHANGE_EN);
> +		break;
> +	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_66:
> +		r8168_mac_ocp_write(tp, 0xcdd0, 0x9003);
> +		r8168_mac_ocp_modify(tp, LTR_SNOOP, 0x0000, LTR_SNOOP_EN);
> +		r8168_mac_ocp_modify(tp, ALDPS_LTR, 0x0000, ALDPS_LTR_EN);
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
> +		r8168_mac_ocp_modify(tp, LTR_OBFF_LOCK, 0x0000, LINK_SPEED_CHANGE_EN);
> +		break;
> +	case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
> +	case RTL_GIGA_MAC_VER_52:
> +		r8168_mac_ocp_modify(tp, ALDPS_LTR, 0x0000, ALDPS_LTR_EN);
> +		RTL_W8(tp, COMBO_LTR_EXTEND, RTL_R8(tp, COMBO_LTR_EXTEND) | COMBO_LTR_EXTEND_EN);
> +		fallthrough;
> +	case RTL_GIGA_MAC_VER_51:
> +		r8168_mac_ocp_modify(tp, LTR_SNOOP, 0x0000, LTR_SNOOP_EN);
> +		r8168_mac_ocp_write(tp, 0xe02c, 0x1880);
> +		r8168_mac_ocp_write(tp, 0xe02e, 0x4880);
> +		r8168_mac_ocp_write(tp, 0xcdd8, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcdda, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcddc, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcdd2, 0x883c);
> +		r8168_mac_ocp_write(tp, 0xcdd4, 0x8c12);
> +		r8168_mac_ocp_write(tp, 0xcdd6, 0x9003);
> +		break;
> +	default:
> +		return;
> +	}
> +	/* chip can trigger LTR */
> +	r8168_mac_ocp_modify(tp, LTR_OBFF_LOCK, 0x0003, LTR_OBFF_LOCK_EN);
> +}
> +
> +static void rtl_disable_ltr(struct rtl8169_private *tp)
> +{

You wrote in response to my question on v1: "We generally do not recommend disabling LTR."
Then, can't this function be removed? Or what would be the impact of leaving LTR enabled?

Please also address the checkpatch warnings, as reported by CI:
https://patchwork.kernel.org/project/netdevbpf/patch/20260108023523.1019-3-javen_xu@realsil.com.cn/


> +	switch (tp->mac_version) {
> +	case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_80:
> +		r8168_mac_ocp_modify(tp, 0xe032, 0x0003, 0);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
> +
>  static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
>  {
>  	u8 val8;
> @@ -2947,6 +3056,7 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
>  			break;
>  		}
>  
> +		rtl_enable_ltr(tp);
>  		switch (tp->mac_version) {
>  		case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
>  		case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_LAST:
> @@ -2968,6 +3078,7 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
>  			break;
>  		}
>  
> +		rtl_disable_ltr(tp);
>  		switch (tp->mac_version) {
>  		case RTL_GIGA_MAC_VER_70:
>  		case RTL_GIGA_MAC_VER_80:
> @@ -4811,6 +4922,7 @@ static void rtl8169_down(struct rtl8169_private *tp)
>  
>  	rtl8169_cleanup(tp);
>  	rtl_disable_exit_l1(tp);
> +	rtl_disable_ltr(tp);
>  	rtl_prepare_power_down(tp);
>  
>  	if (tp->dash_type != RTL_DASH_NONE && !tp->saved_wolopts)



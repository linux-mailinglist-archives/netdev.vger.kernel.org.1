Return-Path: <netdev+bounces-190620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 915D3AB7D90
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 08:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A77733A44E2
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 06:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2278327FB09;
	Thu, 15 May 2025 06:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWL3qWo0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741811B3955;
	Thu, 15 May 2025 06:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747289345; cv=none; b=XE+PbF+Id/c6Uc6B3uMDg4vD3atMBvS7LhmCrcIesDKWbPmYXM4/pYVN81Y2Mx1RN3DqIGBIRFuOaOHPjtRoratFX4rsaDmEO04h3rk/7cEUL40Yfr7if+RVrCes5u/07weEbIZr3pbSdGN6Q/JCt53D3061PMKd1lPKAnMnmeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747289345; c=relaxed/simple;
	bh=KnissWuxPnhkyIz3FxnCSYt2jihhNFIvuG7M+p0Ou0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N9q47vWQnDSn34QXTlW+azvCHqsj5zmmY3GH/DCT/tcmrYcErjaUjs6XDt3huv87bJda/DfUBzQEHEhO/8YnpqzDLCMD2WrsLzf6xFyypXxwtkuUvs3u0Pjdz5aHzT8wHel8aJOzcNGLnIdIEqV/VLeC3FFLgpzhRFv2jVUZo8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWL3qWo0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-442ea341570so3138775e9.1;
        Wed, 14 May 2025 23:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747289341; x=1747894141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Qt0T5/jtNix2QqfuYL0znRNIzRtSiz+765l47tEvGhs=;
        b=NWL3qWo0pKFoCcug7jDJRGclagQXYcALytXKPXp6e09xT96EfkQWhDZ5O9YW2D+f58
         np2C+ppZEX6+uoSVu/79znz1jBleoT3MQdzUgsUeqmfWzYglUSRUYYiuNIYc6U9CwHGF
         mA/smbmrAAWr4pHSN3HNXOImJASjYiN9yCMZ8AOwudE4D7CklqDLfBeXZM50DXq9RjGu
         qgh7P1bUeGxabgOJtzOBwBjFpXkxSHCSFv8Y7zMm2HqT8C5N+cAOAyTKb4FlQWNJgd3U
         DLRaGwi220ynv9LwrQrtBjNUcTlbauJICuSHxjAeOlCsxXEFBDjKkIrNs7fAOJ0qGbJQ
         DLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747289341; x=1747894141;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qt0T5/jtNix2QqfuYL0znRNIzRtSiz+765l47tEvGhs=;
        b=Pj+6ytCvM/D27Uxjxm3bpqlaHoEV5fjNwbLN4yMuKyq/9eLzZSrJpuDqO5y0yDROip
         XlTwkd+3r0U6qWwDbItN9Ar/L8j7uK3qjs7CVFDiDda+ZuMapKiNT6bcBGYacFD81uzQ
         +6GXkYAjvBxYyjR4MOffJZ4Iaf4ldCdEBetR8cYrWmMB125+i4wPwiG6yq9d3Uz6koNC
         2RoTow9CrBD6NmAgc46vqskdJH/Uw3fmxilDTHkQ79RmhNPtpoZ/tKJmmBlf+E66JoYV
         d1TqrtqFuNMO3r5U/JUJDiichJWWdgzlI/WRzGQl9SzcOGUtLZRvUJ5oXMljGeYxV/4a
         68FA==
X-Forwarded-Encrypted: i=1; AJvYcCVQuJlGjq6S97Ip2gtwIXscBQvTjBZOJ57UQQAPbEiNFG0cbhfR/Zaq/LQgU2bt8tYk/HPC9DTLURVWs0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlNEx08U880E2PuBlsvGuXlrb7LVgF3jhNPB7zw6Cp2Nk1wA9m
	cA2bLB8XXo8eTYF4ON9AESFHj21l85yL+7KghVdO1G1pE7zCYYW7
X-Gm-Gg: ASbGncuuTuM4IFB01cifHeT6yHZ3U1hkXxnAMvQdUjgU3qjxmlOwB1o72atkOM3s+x5
	tCFtvwB2qL/erHlGWeW8jlT9BMr6vfmq+PsQavSMpw1vmDDZd1kQ3VQIHb+TOmrQS/grnWPsy2k
	a1ZNVXOzu7tkOmz9XODUQ//GO50qJXciraGhWWZzjV61T2KqxfQvT3UhlIB1n40CytOtkMUi8iw
	hh+1eJQTcGgF4X5WcuAycyTcqev5D/pzGYsvuS2M1Qp7mgW0cYGU4qkMld95QyIyAIL95BfJuGl
	FSr7WjeUXk70PODNIJjY0F2jG3MLK9PE2JBApfErW9JyoXaeJYRScMPaAO2hPMFc0cZzEkkici+
	Pd5xUibNdPBrux7atfMt5Hx/N7pbWFUoVRjXzNqVYUaJoNiDJ6LrqCWPQpp76o3gARKOQcran18
	8Qlcc97qSENxjatAT6XPRAabI=
X-Google-Smtp-Source: AGHT+IGvH22e+3hquBD7CMKjiTJ22BV/BaGLDOPQPYEORRXIa1Y/tEjxlg4MvjI3kc0C6Yi8C/rjAQ==
X-Received: by 2002:a05:600c:5492:b0:442:d9fb:d9f1 with SMTP id 5b1f17b1804b1-442f96e2c3bmr7432235e9.4.1747289340299;
        Wed, 14 May 2025 23:09:00 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f4a:2300:108a:494:9658:90b2? (p200300ea8f4a2300108a0494965890b2.dip0.t-ipconnect.de. [2003:ea:8f4a:2300:108a:494:9658:90b2])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442f39e851bsm57045915e9.28.2025.05.14.23.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 23:08:59 -0700 (PDT)
Message-ID: <c57f0ef9-62c6-4821-a695-e8e4724f1cb7@gmail.com>
Date: Thu, 15 May 2025 08:09:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] r8169: add support for RTL8127A
To: ChunHao Lin <hau@realtek.com>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250515030323.4602-1-hau@realtek.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20250515030323.4602-1-hau@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15.05.2025 05:03, ChunHao Lin wrote:
> This adds support for 10Gbs chip RTL8127A.
> 
Thanks, Hau. One question wrt EEE:
Curently we disable EEE at 5Gbps, likely because support in
RTL8126 still has some flaws. Not 100% sure, but I assume
also 10Gbps supports EEE. How about EEE support at 5Gbps and
10Gbps in RTL8127? Can it be enabled or better not?

I'm asking because I have a M.2 card with RTL8126 (w/o heatsink)
and enabling EEE at 2.5Gbps reduces the chip temperature by 30°C.
So EEE has a quite massive impact.

> Signed-off-by: ChunHao Lin <hau@realtek.com>
> ---
>  drivers/net/ethernet/realtek/r8169.h          |   1 +
>  drivers/net/ethernet/realtek/r8169_main.c     |  29 +++-
>  .../net/ethernet/realtek/r8169_phy_config.c   | 158 ++++++++++++++++++
>  3 files changed, 185 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/realtek/r8169.h
> index f05231030925..2c1a0c21af8d 100644
> --- a/drivers/net/ethernet/realtek/r8169.h
> +++ b/drivers/net/ethernet/realtek/r8169.h
> @@ -70,6 +70,7 @@ enum mac_version {
>  	RTL_GIGA_MAC_VER_64,
>  	RTL_GIGA_MAC_VER_66,
>  	RTL_GIGA_MAC_VER_70,
> +	RTL_GIGA_MAC_VER_80,
>  	RTL_GIGA_MAC_NONE,
>  	RTL_GIGA_MAC_VER_LAST = RTL_GIGA_MAC_NONE - 1
>  };
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 7bf71a675362..43170500d566 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -60,6 +60,7 @@
>  #define FIRMWARE_8125BP_2	"rtl_nic/rtl8125bp-2.fw"
>  #define FIRMWARE_8126A_2	"rtl_nic/rtl8126a-2.fw"
>  #define FIRMWARE_8126A_3	"rtl_nic/rtl8126a-3.fw"
> +#define FIRMWARE_8127A_1	"rtl_nic/rtl8127a-1.fw"
>  
>  #define TX_DMA_BURST	7	/* Maximum PCI burst, '7' is unlimited */
>  #define InterFrameGap	0x03	/* 3 means InterFrameGap = the shortest one */
> @@ -98,6 +99,9 @@ static const struct rtl_chip_info {
>  	const char *name;
>  	const char *fw_name;
>  } rtl_chip_infos[] = {
> +	/* 8127A family. */
> +	{ 0x7cf, 0x6c9,	RTL_GIGA_MAC_VER_80, "RTL8127A", FIRMWARE_8127A_1 },
> +
>  	/* 8126A family. */
>  	{ 0x7cf, 0x64a,	RTL_GIGA_MAC_VER_70, "RTL8126A", FIRMWARE_8126A_3 },
>  	{ 0x7cf, 0x649,	RTL_GIGA_MAC_VER_70, "RTL8126A", FIRMWARE_8126A_2 },
> @@ -222,8 +226,10 @@ static const struct pci_device_id rtl8169_pci_tbl[] = {
>  	{ 0x0001, 0x8168, PCI_ANY_ID, 0x2410 },
>  	{ PCI_VDEVICE(REALTEK,	0x8125) },
>  	{ PCI_VDEVICE(REALTEK,	0x8126) },
> +	{ PCI_VDEVICE(REALTEK,	0x8127) },
>  	{ PCI_VDEVICE(REALTEK,	0x3000) },
>  	{ PCI_VDEVICE(REALTEK,	0x5000) },
> +	{ PCI_VDEVICE(REALTEK,	0x0e10) },

What's the background of this non-standard device id?

>  	{}
>  };
>  
> @@ -769,6 +775,7 @@ MODULE_FIRMWARE(FIRMWARE_8125D_2);
>  MODULE_FIRMWARE(FIRMWARE_8125BP_2);
>  MODULE_FIRMWARE(FIRMWARE_8126A_2);
>  MODULE_FIRMWARE(FIRMWARE_8126A_3);
> +MODULE_FIRMWARE(FIRMWARE_8127A_1);
>  
>  static inline struct device *tp_to_dev(struct rtl8169_private *tp)
>  {
> @@ -2937,6 +2944,7 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
>  		rtl_mod_config5(tp, 0, ASPM_en);
>  		switch (tp->mac_version) {
>  		case RTL_GIGA_MAC_VER_70:
> +		case RTL_GIGA_MAC_VER_80:
>  			val8 = RTL_R8(tp, INT_CFG0_8125) | INT_CFG0_CLKREQEN;
>  			RTL_W8(tp, INT_CFG0_8125, val8);
>  			break;
> @@ -2968,6 +2976,7 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
>  
>  		switch (tp->mac_version) {
>  		case RTL_GIGA_MAC_VER_70:
> +		case RTL_GIGA_MAC_VER_80:
>  			val8 = RTL_R8(tp, INT_CFG0_8125) & ~INT_CFG0_CLKREQEN;
>  			RTL_W8(tp, INT_CFG0_8125, val8);
>  			break;
> @@ -3687,10 +3696,13 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
>  	/* disable new tx descriptor format */
>  	r8168_mac_ocp_modify(tp, 0xeb58, 0x0001, 0x0000);
>  
> -	if (tp->mac_version == RTL_GIGA_MAC_VER_70)
> +	if (tp->mac_version == RTL_GIGA_MAC_VER_70 ||
> +	    tp->mac_version == RTL_GIGA_MAC_VER_80)
>  		RTL_W8(tp, 0xD8, RTL_R8(tp, 0xD8) & ~0x02);
>  
> -	if (tp->mac_version == RTL_GIGA_MAC_VER_70)
> +	if (tp->mac_version == RTL_GIGA_MAC_VER_80)
> +		r8168_mac_ocp_modify(tp, 0xe614, 0x0f00, 0x0f00);
> +	else if (tp->mac_version == RTL_GIGA_MAC_VER_70)
>  		r8168_mac_ocp_modify(tp, 0xe614, 0x0700, 0x0400);
>  	else if (tp->mac_version == RTL_GIGA_MAC_VER_63)
>  		r8168_mac_ocp_modify(tp, 0xe614, 0x0700, 0x0200);
> @@ -3708,7 +3720,8 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
>  	r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0030);
>  	r8168_mac_ocp_modify(tp, 0xe040, 0x1000, 0x0000);
>  	r8168_mac_ocp_modify(tp, 0xea1c, 0x0003, 0x0001);
> -	if (tp->mac_version == RTL_GIGA_MAC_VER_70)
> +	if (tp->mac_version == RTL_GIGA_MAC_VER_70 ||
> +	    tp->mac_version == RTL_GIGA_MAC_VER_80)
>  		r8168_mac_ocp_modify(tp, 0xea1c, 0x0300, 0x0000);
>  	else
>  		r8168_mac_ocp_modify(tp, 0xea1c, 0x0004, 0x0000);
> @@ -3786,6 +3799,12 @@ static void rtl_hw_start_8126a(struct rtl8169_private *tp)
>  	rtl_hw_start_8125_common(tp);
>  }
>  
> +static void rtl_hw_start_8127a(struct rtl8169_private *tp)
> +{
> +	rtl_set_def_aspm_entry_latency(tp);
> +	rtl_hw_start_8125_common(tp);
> +}
> +
>  static void rtl_hw_config(struct rtl8169_private *tp)
>  {
>  	static const rtl_generic_fct hw_configs[] = {
> @@ -3829,6 +3848,7 @@ static void rtl_hw_config(struct rtl8169_private *tp)
>  		[RTL_GIGA_MAC_VER_64] = rtl_hw_start_8125d,
>  		[RTL_GIGA_MAC_VER_66] = rtl_hw_start_8125d,
>  		[RTL_GIGA_MAC_VER_70] = rtl_hw_start_8126a,
> +		[RTL_GIGA_MAC_VER_80] = rtl_hw_start_8127a,
>  	};
>  
>  	if (hw_configs[tp->mac_version])
> @@ -3846,8 +3866,11 @@ static void rtl_hw_start_8125(struct rtl8169_private *tp)
>  	case RTL_GIGA_MAC_VER_61:
>  	case RTL_GIGA_MAC_VER_64:
>  	case RTL_GIGA_MAC_VER_66:
> +	case RTL_GIGA_MAC_VER_80:
>  		for (i = 0xa00; i < 0xb00; i += 4)
>  			RTL_W32(tp, i, 0);
> +		if (tp->mac_version == RTL_GIGA_MAC_VER_80)
> +			RTL_W16(tp, INT_CFG1_8125, 0x0000);

For my understanding: What is this register write doing and why is it not
needed on e.g. RTL8125D (VER_64)?

>  		break;
>  	case RTL_GIGA_MAC_VER_63:
>  	case RTL_GIGA_MAC_VER_70:
> diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drivers/net/ethernet/realtek/r8169_phy_config.c
> index 5403f8202c79..9815a143c762 100644
> --- a/drivers/net/ethernet/realtek/r8169_phy_config.c
> +++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
> @@ -1130,6 +1130,163 @@ static void rtl8126a_hw_phy_config(struct rtl8169_private *tp,
>  	rtl8125_common_config_eee_phy(phydev);
>  }
>  
> +static void rtl8127a_1_hw_phy_config(struct rtl8169_private *tp,
> +				     struct phy_device *phydev)
> +{
> +	r8169_apply_firmware(tp);
> +	rtl8168g_enable_gphy_10m(phydev);
> +
> +	r8168g_phy_param(phydev, 0x8415, 0xff00, 0x9300);
> +	r8168g_phy_param(phydev, 0x81a3, 0xff00, 0x0f00);
> +	r8168g_phy_param(phydev, 0x81ae, 0xff00, 0x0f00);
> +	r8168g_phy_param(phydev, 0x81b9, 0xff00, 0xb900);
> +	rtl8125_phy_param(phydev, 0x83b0, 0x0e00, 0x0000);
> +	rtl8125_phy_param(phydev, 0x83C5, 0x0e00, 0x0000);
> +	rtl8125_phy_param(phydev, 0x83da, 0x0e00, 0x0000);
> +	rtl8125_phy_param(phydev, 0x83ef, 0x0e00, 0x0000);
> +	phy_modify_paged(phydev, 0xbf3, 0x14, 0x01f0, 0x0160);
> +	phy_modify_paged(phydev, 0xbf3, 0x15, 0x001f, 0x0014);
> +	phy_modify_paged(phydev, 0xbf2, 0x14, 0x6000, 0x0000);
> +	phy_modify_paged(phydev, 0xbf2, 0x16, 0xc000, 0x0000);
> +	phy_modify_paged(phydev, 0xbf2, 0x14, 0x1fff, 0x0187);
> +	phy_modify_paged(phydev, 0xbf2, 0x15, 0x003f, 0x0003);
> +
> +	r8168g_phy_param(phydev, 0x8173, 0xffff, 0x8620);
> +	r8168g_phy_param(phydev, 0x8175, 0xffff, 0x8671);
> +	r8168g_phy_param(phydev, 0x817c, 0x0000, 0x2000);
> +	r8168g_phy_param(phydev, 0x8187, 0x0000, 0x2000);
> +	r8168g_phy_param(phydev, 0x8192, 0x0000, 0x2000);
> +	r8168g_phy_param(phydev, 0x819d, 0x0000, 0x2000);
> +	r8168g_phy_param(phydev, 0x81a8, 0x2000, 0x0000);
> +	r8168g_phy_param(phydev, 0x81b3, 0x2000, 0x0000);
> +	r8168g_phy_param(phydev, 0x81be, 0x0000, 0x2000);
> +	r8168g_phy_param(phydev, 0x817d, 0xff00, 0xa600);
> +	r8168g_phy_param(phydev, 0x8188, 0xff00, 0xa600);
> +	r8168g_phy_param(phydev, 0x8193, 0xff00, 0xa600);
> +	r8168g_phy_param(phydev, 0x819e, 0xff00, 0xa600);
> +	r8168g_phy_param(phydev, 0x81a9, 0xff00, 0x1400);
> +	r8168g_phy_param(phydev, 0x81b4, 0xff00, 0x1400);
> +	r8168g_phy_param(phydev, 0x81bf, 0xff00, 0xa600);
> +
> +	phy_modify_paged(phydev, 0xaea, 0x15, 0x0028, 0x0000);
> +
> +	rtl8125_phy_param(phydev, 0x84f0, 0xffff, 0x201c);
> +	rtl8125_phy_param(phydev, 0x84f2, 0xffff, 0x3117);
> +
> +	phy_modify_paged(phydev, 0xaec, 0x13, 0xffff, 0x0000);
> +	phy_modify_paged(phydev, 0xae2, 0x10, 0xffff, 0xffff);
> +	phy_modify_paged(phydev, 0xaec, 0x17, 0xffff, 0xffff);
> +	phy_modify_paged(phydev, 0xaed, 0x11, 0xffff, 0xffff);
> +	phy_modify_paged(phydev, 0xaec, 0x14, 0xffff, 0x0000);
> +	phy_modify_paged(phydev, 0xaed, 0x10, 0x0001, 0x0000);
> +	phy_modify_paged(phydev, 0xadb, 0x14, 0xffff, 0x0150);
> +	rtl8125_phy_param(phydev, 0x8197, 0xff00, 0x5000);
> +	rtl8125_phy_param(phydev, 0x8231, 0xff00, 0x5000);
> +	rtl8125_phy_param(phydev, 0x82cb, 0xff00, 0x5000);
> +	rtl8125_phy_param(phydev, 0x82cd, 0xff00, 0x5700);
> +	rtl8125_phy_param(phydev, 0x8233, 0xff00, 0x5700);
> +	rtl8125_phy_param(phydev, 0x8199, 0xff00, 0x5700);
> +
> +	rtl8125_phy_param(phydev, 0x815a, 0xffff, 0x0150);
> +	rtl8125_phy_param(phydev, 0x81f4, 0xffff, 0x0150);
> +	rtl8125_phy_param(phydev, 0x828e, 0xffff, 0x0150);
> +	rtl8125_phy_param(phydev, 0x81b1, 0xffff, 0x0000);
> +	rtl8125_phy_param(phydev, 0x824b, 0xffff, 0x0000);
> +	rtl8125_phy_param(phydev, 0x82e5, 0xffff, 0x0000);
> +
> +	rtl8125_phy_param(phydev, 0x84f7, 0xff00, 0x2800);
> +	phy_modify_paged(phydev, 0xaec, 0x11, 0x0000, 0x1000);
> +	rtl8125_phy_param(phydev, 0x81b3, 0xff00, 0xad00);
> +	rtl8125_phy_param(phydev, 0x824d, 0xff00, 0xad00);
> +	rtl8125_phy_param(phydev, 0x82e7, 0xff00, 0xad00);
> +	phy_modify_paged(phydev, 0xae4, 0x17, 0x000f, 0x0001);
> +	rtl8125_phy_param(phydev, 0x82ce, 0xf000, 0x4000);
> +
> +	rtl8125_phy_param(phydev, 0x84ac, 0xffff, 0x0000);
> +	rtl8125_phy_param(phydev, 0x84ae, 0xffff, 0x0000);
> +	rtl8125_phy_param(phydev, 0x84b0, 0xffff, 0xf818);
> +	rtl8125_phy_param(phydev, 0x84b2, 0xff00, 0x6000);
> +
> +	rtl8125_phy_param(phydev, 0x8ffc, 0xffff, 0x6008);
> +	rtl8125_phy_param(phydev, 0x8ffe, 0xffff, 0xf450);
> +
> +	rtl8125_phy_param(phydev, 0x8015, 0x0000, 0x0200);
> +	rtl8125_phy_param(phydev, 0x8016, 0x0800, 0x0000);
> +	rtl8125_phy_param(phydev, 0x8fe6, 0xff00, 0x0800);
> +	rtl8125_phy_param(phydev, 0x8fe4, 0xffff, 0x2114);
> +
> +	rtl8125_phy_param(phydev, 0x8647, 0xffff, 0xa7b1);
> +	rtl8125_phy_param(phydev, 0x8649, 0xffff, 0xbbca);
> +	rtl8125_phy_param(phydev, 0x864b, 0xff00, 0xdc00);
> +
> +	rtl8125_phy_param(phydev, 0x8154, 0xc000, 0x4000);
> +	rtl8125_phy_param(phydev, 0x8158, 0xc000, 0x0000);
> +
> +	rtl8125_phy_param(phydev, 0x826c, 0xffff, 0xffff);
> +	rtl8125_phy_param(phydev, 0x826e, 0xffff, 0xffff);
> +
> +	rtl8125_phy_param(phydev, 0x8872, 0xff00, 0x0e00);
> +	r8168g_phy_param(phydev, 0x8012, 0x0000, 0x0800);
> +	r8168g_phy_param(phydev, 0x8012, 0x0000, 0x4000);
> +	phy_modify_paged(phydev, 0xb57, 0x13, 0x0000, 0x0001);
> +	r8168g_phy_param(phydev, 0x834a, 0xff00, 0x0700);
> +	rtl8125_phy_param(phydev, 0x8217, 0x3f00, 0x2a00);
> +	r8168g_phy_param(phydev, 0x81b1, 0xff00, 0x0b00);
> +	rtl8125_phy_param(phydev, 0x8fed, 0xff00, 0x4e00);
> +
> +	r8168g_phy_param(phydev, 0x8370, 0xffff, 0x8671);
> +	r8168g_phy_param(phydev, 0x8372, 0xffff, 0x86c8);
> +	r8168g_phy_param(phydev, 0x8401, 0xffff, 0x86c8);
> +	r8168g_phy_param(phydev, 0x8403, 0xffff, 0x86da);
> +	r8168g_phy_param(phydev, 0x8406, 0x1800, 0x1000);
> +	r8168g_phy_param(phydev, 0x8408, 0x1800, 0x1000);
> +	r8168g_phy_param(phydev, 0x840a, 0x1800, 0x1000);
> +	r8168g_phy_param(phydev, 0x840c, 0x1800, 0x1000);
> +	r8168g_phy_param(phydev, 0x840e, 0x1800, 0x1000);
> +	r8168g_phy_param(phydev, 0x8410, 0x1800, 0x1000);
> +	r8168g_phy_param(phydev, 0x8412, 0x1800, 0x1000);
> +	r8168g_phy_param(phydev, 0x8414, 0x1800, 0x1000);
> +	r8168g_phy_param(phydev, 0x8416, 0x1800, 0x1000);
> +
> +	r8168g_phy_param(phydev, 0x82bd, 0xffff, 0x1f40);
> +
> +	phy_modify_paged(phydev, 0xbfb, 0x12, 0x07ff, 0x0328);
> +	phy_modify_paged(phydev, 0xbfb, 0x13, 0xffff, 0x3e14);
> +
> +	r8168g_phy_param(phydev, 0x81c4, 0xffff, 0x003b);
> +	r8168g_phy_param(phydev, 0x81c6, 0xffff, 0x0086);
> +	r8168g_phy_param(phydev, 0x81c8, 0xffff, 0x00b7);
> +	r8168g_phy_param(phydev, 0x81ca, 0xffff, 0x00db);
> +	r8168g_phy_param(phydev, 0x81cc, 0xffff, 0x00fe);
> +	r8168g_phy_param(phydev, 0x81ce, 0xffff, 0x00fe);
> +	r8168g_phy_param(phydev, 0x81d0, 0xffff, 0x00fe);
> +	r8168g_phy_param(phydev, 0x81d2, 0xffff, 0x00fe);
> +	r8168g_phy_param(phydev, 0x81d4, 0xffff, 0x00c3);
> +	r8168g_phy_param(phydev, 0x81d6, 0xffff, 0x0078);
> +	r8168g_phy_param(phydev, 0x81d8, 0xffff, 0x0047);
> +	r8168g_phy_param(phydev, 0x81da, 0xffff, 0x0023);
> +
> +	rtl8125_phy_param(phydev, 0x88d7, 0xffff, 0x01a0);
> +	rtl8125_phy_param(phydev, 0x88d9, 0xffff, 0x01a0);
> +	rtl8125_phy_param(phydev, 0x8ffa, 0xffff, 0x002a);
> +	rtl8125_phy_param(phydev, 0x8fee, 0xffff, 0xffdf);
> +	rtl8125_phy_param(phydev, 0x8ff0, 0xffff, 0xffff);
> +	rtl8125_phy_param(phydev, 0x8ff2, 0xffff, 0x0a4a);
> +	rtl8125_phy_param(phydev, 0x8ff4, 0xffff, 0xaa5a);
> +	rtl8125_phy_param(phydev, 0x8ff6, 0xffff, 0x0a4a);
> +	rtl8125_phy_param(phydev, 0x8ff8, 0xffff, 0xaa5a);
> +	rtl8125_phy_param(phydev, 0x88d5, 0xff00, 0x0200);
> +
> +	r8168g_phy_param(phydev, 0x84bb, 0xff00, 0x0a00);
> +	r8168g_phy_param(phydev, 0x84c0, 0xff00, 0x1600);
> +
> +	phy_modify_paged(phydev, 0xa43, 0x10, 0x0000, 0x0003);
> +

For recently added chip versions like RTL8126 no such lengthy
PHY configuration was needed, and it seems all required PHY
config adjustments were part of the firmware.
Why aren't the settings here included in the firmware?
Would it be possible to create an updated firmware version
including these settings?

> +	rtl8125_legacy_force_mode(phydev);
> +	rtl8168g_disable_aldps(phydev);
> +	rtl8125_common_config_eee_phy(phydev);
> +}
> +
>  void r8169_hw_phy_config(struct rtl8169_private *tp, struct phy_device *phydev,
>  			 enum mac_version ver)
>  {
> @@ -1181,6 +1338,7 @@ void r8169_hw_phy_config(struct rtl8169_private *tp, struct phy_device *phydev,
>  		[RTL_GIGA_MAC_VER_64] = rtl8125d_hw_phy_config,
>  		[RTL_GIGA_MAC_VER_66] = rtl8125bp_hw_phy_config,
>  		[RTL_GIGA_MAC_VER_70] = rtl8126a_hw_phy_config,
> +		[RTL_GIGA_MAC_VER_80] = rtl8127a_1_hw_phy_config,
>  	};
>  
>  	if (phy_configs[ver])



Return-Path: <netdev+bounces-177074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C11A6DB6B
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 14:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8831170D8D
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 13:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7898B25E834;
	Mon, 24 Mar 2025 13:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUNRGfNw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39C11A5B87;
	Mon, 24 Mar 2025 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742822826; cv=none; b=RmGTJ+FOynrfjgu+yI2IP3U/Gn7qyebT90xDeQtr9OYV2ByrhmHHLq/IglZ4azAjE7UhGNOdsG2w29vy6wV70wfFmRt38nsQl4nNyudZVilSfpvJaLVGAIrIYwDSGUvlB2taRwoypllP7CQOPnFAC1bhW2Y1OAHVXUCnaeXwDrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742822826; c=relaxed/simple;
	bh=5sZBlHVtn1C8OV5e2ku2m5KWTP6DMHMSGyyhoJks77s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O0aG9BaOhZYA5JO+SgDtMT2Xn9C5BZXfsww3e+XkWdazuMRvbo5gtePWvkyB/3XXFuNphcw1PPa7LaEEEuJDAaN/SyJwx0kDvCVWDdM9veeanB4dWqf31mCaufNOvZ11HNb+1YCqR4jvh3tIw1Y/RBNMzJxdT4++J6KxSrJT8x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUNRGfNw; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e5c7d6b96fso7847338a12.3;
        Mon, 24 Mar 2025 06:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742822823; x=1743427623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vtKD5Ixyls+GlGaGbqNHd27FH7AwDFQvpdpQe15ZNcQ=;
        b=PUNRGfNwTqoz3E39NKaj2E6gV9xYWyILAkrtFtm6lSsZ5PucLsZTCg43xXnhy8fOrG
         Wq3Hj60jSvbBKkyGkNHQUr8z5oXHgE8ioAEn+Ib1k7ahHbTsActMk7KSeK7HL/CyWttK
         itVzDUz6U10+aRQVwOiIHbHSBtpzcveOQcU1CF5aEJGuODtduHteYgtlOwRy5pgd9OaB
         35VuQM4Pp1gEg7L7HYEI4tNqpdNLrhDU8EoRUjulD61hXJCXQm757d82pPFp3i7ZYais
         7U4jlHC82k3C38cdplSCotNxz4OThdoYzh/zU/3ALM7oDOCKNikcqScpa8gz5+kutBET
         ZqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742822823; x=1743427623;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtKD5Ixyls+GlGaGbqNHd27FH7AwDFQvpdpQe15ZNcQ=;
        b=vRDDkzhwu3zKiJva3rBWHt4T+Eyx8WYMwutn68PZfFxMACfWqNx8BV9bmw8bswbfaA
         6ZAXuOUA9gQTVq8/q5lK/zN7NCc2YoYNk/ZL6pu5t9pLiy/q4gAfSB20MbmkelmyEk3S
         qaZxZ2L0kRnZg4thKLKBgJSn/gF1ibh+dp9s/zEUMsbLL8VxND6EyZqaMVJRXA5dNiwN
         j8DDY7tW8OmIAtF+RRa+Fzj6HJh8CWD/TXSaz+KaEE0g6PljR76poywVpidrcMrvLrbC
         EgM0gn3DEItdOjjdfs4mbi+5dkO7EcKgesVdNan/zyis8B9FmACvGuYTmMFAFZX+iJIb
         pmjg==
X-Forwarded-Encrypted: i=1; AJvYcCVXCMWtBEPYHNx9eRWcLwuB86LHElbjwKFTIhcdnSSofJJe6p5BS3tGWimpwRsZ40cHfhuLtlVS@vger.kernel.org, AJvYcCXic//FPw3t/szDUZg5zwmsMvtGG4YHGy6nxgcbaRDvQDTPLOMVUugre25QJI5Z88JEIZ3f8mI1CGZn2TQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHqS72dDW10tKfSj1zoJqTxoYmTHnDQf+ehGgWmUkopg+Vx7jd
	veAjhsEJSq1/ugvep63zoycXj+Dh/FKKKLr1io06j+tO8eLlhSAE
X-Gm-Gg: ASbGncvzABQml7lZfK0ZWpEDcgyjseGLlHd+4Tbrnc7PhyDLrf2P24OPywfBgcgozGo
	HXV6MIHwB3qi6j2tTlS5kFtzpsNvw2Hp864545WOLnQXPaNsDElpY1EiPYM1kpWWMkZZktjZYTN
	HOAnsLLafGKXglUbCm9pl39OfBXzXoTLJb6UO1nOOhO/EFGTit4CiQPWPOBXemDQhb9bZTc0lVW
	8X5bSH4UOJtANzeGQWttxCK3dD40iy1g9c5A3zLNtEWj2UWuJXj7959ocJQMyyRgbCLQcoU4nPo
	9nr3IQkoA9l1nf4P93msMVwdFeEXyd5CrIoaQaRNaXwFaMA9VoHCxEtV/fznn+6aGvLSRS4ni5Z
	FBmerwGzv+qbRuiDVgtKIbrcDAa9RkEQJWMJW2X+//WTX5N/J4TuGp6uN1GdFhJKjYS+FdcnvSh
	rKIQvCUFxJtm/HrEINfWwjJ7iY2PptQ2aiGvFnOd4y5HVwKLY=
X-Google-Smtp-Source: AGHT+IET41uBrBbBiCBJPv6lZWsn6AnwlrIitx4QWzfhAd4ak8jqluxUmOQVbqSwQw2zeiKFmh0HlQ==
X-Received: by 2002:a17:907:9692:b0:abf:52e1:2615 with SMTP id a640c23a62f3a-ac3f20f7f03mr1197676266b.7.1742822822488;
        Mon, 24 Mar 2025 06:27:02 -0700 (PDT)
Received: from ?IPV6:2a02:3100:aff5:aa00:414d:867b:b44f:8e2e? (dynamic-2a02-3100-aff5-aa00-414d-867b-b44f-8e2e.310.pool.telefonica.de. [2a02:3100:aff5:aa00:414d:867b:b44f:8e2e])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ac3ef8e5105sm686496366b.50.2025.03.24.06.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 06:27:01 -0700 (PDT)
Message-ID: <278ceb1e-a817-4c63-9bc9-095d0b081e50@gmail.com>
Date: Mon, 24 Mar 2025 14:27:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] r8169: add module parameter aspm_en_force
To: Crag Wang <crag0715@gmail.com>, nic_swsd@realtek.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: crag.wang@dell.com, dell.client.kernel@dell.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250324125543.6723-1-crag0715@gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20250324125543.6723-1-crag0715@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24.03.2025 13:55, Crag Wang wrote:
> ASPM is disabled by default and is enabled if the chip register is
> pre-configured, as explained in #c217ab7.
> 
> A module parameter is being added to the driver to allow users to
> override the default setting. This allows users to opt in and forcefully
> enable or disable ASPM power-saving mode.
> 
> -1: default unset
>  0: ASPM disabled forcefully
>  1: ASPM enabled forcefully
> 
> Signed-off-by: Crag Wang <crag0715@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 53e541ddb439..161b2f2edf52 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -35,6 +35,10 @@
>  #include "r8169.h"
>  #include "r8169_firmware.h"
>  
> +static int aspm_en_force = -1;
> +module_param(aspm_en_force, int, 0444);
> +MODULE_PARM_DESC(aspm_en_force, "r8169: An integer, set 1 to force enable link ASPM");
> +
>  #define FIRMWARE_8168D_1	"rtl_nic/rtl8168d-1.fw"
>  #define FIRMWARE_8168D_2	"rtl_nic/rtl8168d-2.fw"
>  #define FIRMWARE_8168E_1	"rtl_nic/rtl8168e-1.fw"
> @@ -5398,6 +5402,14 @@ static void rtl_init_mac_address(struct rtl8169_private *tp)
>  /* register is set if system vendor successfully tested ASPM 1.2 */
>  static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
>  {
> +	if (aspm_en_force == 0) {
> +		dev_info(tp_to_dev(tp), "ASPM disabled forcefully");
> +		return false;
> +	} else if (aspm_en_force > 0) {
> +		dev_info(tp_to_dev(tp), "ASPM enabled forcefully");
> +		return true;
> +	}
> +
>  	if (tp->mac_version >= RTL_GIGA_MAC_VER_61 &&
>  	    r8168_mac_ocp_read(tp, 0xc0b2) & 0xf)
>  		return true;

Adding module parameters is discouraged.
Also note that you have the option already to re-activate ASPM, you can use the
standard PCI sysfs attributes under /sys/class/net/<if>/device/link for this.



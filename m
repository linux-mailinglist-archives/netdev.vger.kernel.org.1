Return-Path: <netdev+bounces-219816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBB0B43224
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 08:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5BA8188CDB8
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 06:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6484D248F52;
	Thu,  4 Sep 2025 06:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSZm5JM5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C98A24A069;
	Thu,  4 Sep 2025 06:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756966560; cv=none; b=Cu/pp5QwPYbgzsSJe4F0kVNPy3nQBDzo1fowZ/YhyfHZyrXrFHq3OTAXfYoNUGxuODul6+hEoTamJKKztfzZtlrN4OdqKzGR5byl7jEtlZvmUikcocks2r+zjeD2+TpZZBS17Jhyl4Y8Ixg77zt5xPGwExvgYs0gumRZdYWDMcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756966560; c=relaxed/simple;
	bh=prej2Dk0aUjjO8xjjG0H5c17ggcOQuXgsx1QKzQZCWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZZG0Fn/7FzkzH1ykOD2QLJLDLODG8gV6XIMkNX1838sq7e+g3oiCqejjF4gghqrbcast/fvMmuJ9csyInLF4Krdph/2i1RtlrMF1QJMW/tyZxXimmluIp3W2USVoKY+RSKRtMBx9c+z5GqzKIujHlEeVy7e2+ujJWrA4SZSQWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSZm5JM5; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b0475ce7f41so128843666b.1;
        Wed, 03 Sep 2025 23:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756966557; x=1757571357; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HmOvqGHiZR3oT513KZSDuYlalXY/WYls0uiqjHaczM4=;
        b=aSZm5JM59ugAM/dOcXK8ijiofHvyzyyaB3v4oCqtGQYgmCWjwO8IEBN2wITAomDutC
         dzaJd19nI+psNDHvdKFyYnoOKFblIYkNSq6b2mFcWdKg5C0/M3zLXwSoQG2tH0f7ieRM
         S6Se6hvZ+hs+AhBkkW1ypPDFv69fANfxLbvqCs3o1KM9FJMg4JygTW4neuE9RCloqwDQ
         z/jHK1HYuF5yxdcaja53W/D28qz6TvbAYGKK5nrIUmTMVxbo+iiB/Wl2jAiqyc45SgbL
         tOCygnuHVQ1/65sRiADMrqRE1NIzQi3IoFl+DxCvpG1glYvkqp3XtTpYipMWge/zzV5K
         1FVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756966557; x=1757571357;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmOvqGHiZR3oT513KZSDuYlalXY/WYls0uiqjHaczM4=;
        b=ii81fYCWg5MUHtppCepEr33utZ91KUaBPVe+ckTAUfAThB2YSvXgKfLJSPPEAZJekK
         m+/jupPLLsyzg9rExD5bwyT75Kzj95Y1pvlQMWvBjp5na7A5VjbDbKUXfyKHoXnyUzhF
         reAacYsGKKSKbacjoCOiz8Wzq6phQ3GJ0FKhyaqtSrs8XIEXK0hT3IZ+ASINgh3AtUUa
         loQWFhsi/z5EJILxmz3b8Nfv+uG3vQ421+ihpC7QcfnW+vSj6IwOjJsjFIwbFOTEWfXw
         tz0VfKKmnYmwwm+DoXjLvYdo8UfDhYrqI7ibJIbV/74vUxso/HGB+H0OPfwkjfrlvVZ1
         0jBA==
X-Forwarded-Encrypted: i=1; AJvYcCWxAfLF/rjFey9vU7Sq15x1KeDdXu/iDlrueS9GcdN4OJTTo95lbBn1BZ2F0huX7lVU6MOe9m55UK8TU6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya5C76EXoxQekrk0pO8YjixQsvxxEmafVESKwM5HAewYD0oVxC
	sR7uZvOMj50KbxPYL2RrmcLndeFRnzKPDuZl23bft5JzCe8h8EoYhU4B
X-Gm-Gg: ASbGncvFF+K51LmV8z6VMgOIIe+q5O1EHk/o74Dasq5RNRbVdmlmOjsJu4ZX68kuVwL
	RA1V08raoi1fJoVna9jU+ZZlT0S7hpHE6vqmhw/yfVihDQLMGDdUNG24R3Zs87m0NLlDJJVU5T2
	6LoGLBQRiSUatnaOK+Bgp7iLwuKVRv6ss5QsaW3eCtOu//vydfSyH5IQs2dGXMFG0fbNU0bWLtk
	C+J0AYj/YKEkzAoDhkVw9iyf9nUrWySxr+nwgz3vtA+c55XYxVxIrVDuPVy8pbYdBQuuzQtdlsf
	p30IlABdUDRiG2fQs7DUcgBCybnbgymh6pMap1SBIobBhwbPIYDqvegjtTqql9h5VIFgmKsDN9v
	bdehgWTNv84nGl/1ZS5YB5DRQ4HKjg8NFvBMcxmqCSW089uEptnFHtev7E/56C6L3zu8EdXTa5E
	n7uttef8GNByym902fsqBKXZFGaVe02ymFC3z1kYVF3j3oz2GOgaXfxOHHk7wKRrr3mEaFIclXz
	E8C0l8G
X-Google-Smtp-Source: AGHT+IFe7I4td4ovEFFq3DeDtfBpbV1Za0u/GxQEz1vPTnTkR5Lho4bgpnmHJLkGYCUQwswiBPzW+A==
X-Received: by 2002:a17:907:7e8d:b0:b04:2a50:3c13 with SMTP id a640c23a62f3a-b042a5061aemr1262429266b.6.1756966556538;
        Wed, 03 Sep 2025 23:15:56 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f1f:b00:1062:8af8:2f20:2501? (p200300ea8f1f0b0010628af82f202501.dip0.t-ipconnect.de. [2003:ea:8f1f:b00:1062:8af8:2f20:2501])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b0467f47d4csm359895466b.11.2025.09.03.23.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 23:15:56 -0700 (PDT)
Message-ID: <d78dd279-54ed-46c3-b0b1-09c0be04557a@gmail.com>
Date: Thu, 4 Sep 2025 08:16:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] r8169: set EEE speed down ratio to 1
To: ChunHao Lin <hau@realtek.com>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250904021123.5734-1-hau@realtek.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20250904021123.5734-1-hau@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/2025 4:11 AM, ChunHao Lin wrote:
> EEE speed down ratio (mac ocp 0xe056[7:4]) is used to control EEE speed down
> rate. The larger this value is, the more power can save. But it actually save
> less power then expected, but will impact compatibility. So set it to 1 (mac
> ocp 0xe056[7:4] = 0) to improve compatibility.
> 
Hi Hau,

what kind of speed is this referring to? Some clock, or link speed, or ..?
Is EEE speed down a Realtek-specific feature?

Are there known issues with the values used currently? Depending on the
answer we might consider this a fix.

Heiner

> Signed-off-by: ChunHao Lin <hau@realtek.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 9c601f271c02..e5427dfce268 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -3409,7 +3409,7 @@ static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
>  		r8168_mac_ocp_modify(tp, 0xd412, 0x0fff, sw_cnt_1ms_ini);
>  	}
>  
> -	r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0070);
> +	r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0000);
>  	r8168_mac_ocp_modify(tp, 0xe052, 0x6000, 0x8008);
>  	r8168_mac_ocp_modify(tp, 0xe0d6, 0x01ff, 0x017f);
>  	r8168_mac_ocp_modify(tp, 0xd420, 0x0fff, 0x047f);
> @@ -3514,7 +3514,7 @@ static void rtl_hw_start_8117(struct rtl8169_private *tp)
>  		r8168_mac_ocp_modify(tp, 0xd412, 0x0fff, sw_cnt_1ms_ini);
>  	}
>  
> -	r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0070);
> +	r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0000);
>  	r8168_mac_ocp_write(tp, 0xea80, 0x0003);
>  	r8168_mac_ocp_modify(tp, 0xe052, 0x0000, 0x0009);
>  	r8168_mac_ocp_modify(tp, 0xd420, 0x0fff, 0x047f);
> @@ -3715,7 +3715,7 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
>  	r8168_mac_ocp_modify(tp, 0xc0b4, 0x0000, 0x000c);
>  	r8168_mac_ocp_modify(tp, 0xeb6a, 0x00ff, 0x0033);
>  	r8168_mac_ocp_modify(tp, 0xeb50, 0x03e0, 0x0040);
> -	r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0030);
> +	r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0000);
>  	r8168_mac_ocp_modify(tp, 0xe040, 0x1000, 0x0000);
>  	r8168_mac_ocp_modify(tp, 0xea1c, 0x0003, 0x0001);
>  	if (tp->mac_version == RTL_GIGA_MAC_VER_70 ||



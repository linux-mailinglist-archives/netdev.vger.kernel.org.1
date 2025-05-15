Return-Path: <netdev+bounces-190741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D0FAB8900
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 16:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08AC24A770B
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 14:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213F31B0F0A;
	Thu, 15 May 2025 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DLKLsNXv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380ED1B0421
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747318486; cv=none; b=nywGMB5EPauKVS9qUVOsGXoB1KGY00PO1oLeBndmGLDF3oFQ2cJb8lMWGczYM3ho0PDyh3WT1RSGZCUckIgwz1sYOOIjxLAC8UBbFRxfxrtN0N5lnMWGng145tHYu9Vcgu10en9OdWg4hvwxema0HUp75SHK2p7IJYoHL0LE2x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747318486; c=relaxed/simple;
	bh=7sHf8o3NZ5bDIFD+jjcnBwORMnEoCBZ2UA+OhW9DhHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aHk+qriYzD0Wx/SS31xN30ktUg462/9tzOlgUQXDWqYhma+sCKcMDdrfBqD8a25lLbLts9mAdRTIMXt3Ul8vUjvxxBzGbkA0khkdtCkfv6ScEZtrH5zQMsU/8Lm9uIQZb2sav56G0KC7iAV9n18lQ7J6BbFBxKFTje5UUMx/ii8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DLKLsNXv; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-442e9c7cf0eso627645e9.2
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 07:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747318482; x=1747923282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IdanuI9FFBmKg3eJuW9J0Y0E35bPKps3EOBryMkRX+8=;
        b=DLKLsNXv4O+VL8TZUvbMRUpEdWYSyRqyd4l3nrObOgicWpNmZmut1a7//QiLd9tRIO
         Hbg4ejfeXgkhVgYhlyKGOflQc8WWdIj1xj+9izJri7L+Gq0z0nbr+1f9d+Hca73/5Mwr
         hb7beexAgKTD8xllcZK1LaNvbfu5OOveb2mJHFCw+mikmvS2Yyma1CXeNNE+bQBJ36GC
         eqAt4Kk7ch+2OIWPIjfZIayDP1kidEAL27CxMnKhBR2CC3FPPEnMv6APWW3dZo9Mj20e
         6vcWgH4wI51nSYrC38cqC+oJowXg/DNOteW0I4Zt2Rkn1DtUP8mi7VDK+hidjnGY5mHj
         jnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747318482; x=1747923282;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IdanuI9FFBmKg3eJuW9J0Y0E35bPKps3EOBryMkRX+8=;
        b=CVBw+lyS7NYLKllUdkOnNxMh/Ofy8s3HNinMtoAgTqoN7vw70q2OC6AOkZMXigQTx8
         15vnCazJU5MAJG4+mlpmydlW5kJYE3pKogKz+xd0pQZSG8q2yalRZutmRdhfokWcTuNV
         Krk4ADJUsnmQXP0QjdLcZxIFyz8zfvGv+ACvCTf6j1VF0M6olwRI/xBRiNK09HFVLxeH
         k3kNTd5EIBMOMLKk+yTxjFE+P2GopfDf4s8ijdy+G20XLbrJNPkJ7IHGEZXwmByYldVc
         6gB33epD7/q5ZZfLTk4B1BHslWA0YXvMjfWvLX0V8rpUhZDsLIrhnxKRfXNnPNkGiWNq
         HGHA==
X-Forwarded-Encrypted: i=1; AJvYcCVyvjoKzPmnNZNKz6UjEbmop4PqJ937XkEDCzp6nVO/NH2hC1tXiFXu4yoO57vmZGmX8P9rmCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRee1OAcZTYPISTwABjOvcckqoZRc+4SzCHBL2BxX971BrkjOR
	QSpAjgi4XYZOiOJgBDIagQmN7FkseBBDSv4vR9eVlVzZwpPNMAxnsaqPb/rWDCw=
X-Gm-Gg: ASbGncuNCzAW9hBr5mh4p5DpKAFwtsb5nPQn3RXy3QAc7XsbhbLIv2TwPiXi6RN9M5y
	VNN6GER+wU2mG5kgA/jSkP7KHoHCTh6+91ql0kwe91g3RkpKIJhoY/NgPxxXHLOMtTayEtVk4UL
	XhbucK8e8/gpNXouRD9FDJQw3P92qoj1lb3tqM7nRDum+9P++tii6++M6M8PXZs6jOogH/xjqm9
	rkVbsscCEP+F7ZE65pOWY/kSNFLDH3arMxb8BeL+v8n5ZdZvbQcHhvFQAAXxvAa7o8qxsaW9QrW
	9LZXkfx8YO8cgTmoVKwPLjQJuAijN8VNtLem8MpIO8ZQsqu9YusIu+ZRqK5pgzTZPzp5QlRqSCH
	E6LNb+iICvs5uggjqLQ==
X-Google-Smtp-Source: AGHT+IFAmJg4wpr3hF9P8GAjAflVvpkpnKEcQeHhz9VqEGobdz9a9bNtA3qV5TpyI3z2iahlvZdVDg==
X-Received: by 2002:a05:600c:3b02:b0:43b:ca39:a9b8 with SMTP id 5b1f17b1804b1-442f20bfcbamr26969135e9.2.1747318482412;
        Thu, 15 May 2025 07:14:42 -0700 (PDT)
Received: from [10.61.0.48] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f39790afsm74996325e9.33.2025.05.15.07.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 07:14:41 -0700 (PDT)
Message-ID: <878caa72-df94-4530-95b8-ae827b82f2e4@linaro.org>
Date: Thu, 15 May 2025 16:14:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mux: mmio: Fix missing CONFIG_REGMAP_MMIO
To: Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Davis <afd@ti.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Samuel Holland <samuel@sholland.org>, Arnd Bergmann <arnd@arndb.de>
References: <20250515140555.325601-2-krzysztof.kozlowski@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20250515140555.325601-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/05/2025 16:05, Krzysztof Kozlowski wrote:
> MMIO mux uses now regmap_init_mmio(), so one way or another
> CONFIG_REGMAP_MMIO should be enabled, because there are no stubs for
> !REGMAP_MMIO case:
> 
>   ERROR: modpost: "__regmap_init_mmio_clk" [drivers/mux/mux-mmio.ko] undefined!
> 
> REGMAP_MMIO should be, because it is a non-visible symbol, but this
> causes a circular dependency:
> 
>   error: recursive dependency detected!
>   symbol IRQ_DOMAIN is selected by REGMAP
>   symbol REGMAP default is visible depending on REGMAP_MMIO
>   symbol REGMAP_MMIO is selected by MUX_MMIO
>   symbol MUX_MMIO depends on MULTIPLEXER
>   symbol MULTIPLEXER is selected by MDIO_BUS_MUX_MULTIPLEXER
>   symbol MDIO_BUS_MUX_MULTIPLEXER depends on MDIO_DEVICE
>   symbol MDIO_DEVICE is selected by PHYLIB
>   symbol PHYLIB is selected by ARC_EMAC_CORE
>   symbol ARC_EMAC_CORE is selected by EMAC_ROCKCHIP
>   symbol EMAC_ROCKCHIP depends on OF_IRQ
>   symbol OF_IRQ depends on IRQ_DOMAIN
> 
> ... which we can break by changing dependency in EMAC_ROCKCHIP from
> OF_IRQ to OF.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202505150312.dYbBqUhG-lkp@intel.com/
> Fixes: 61de83fd8256 ("mux: mmio: Do not use syscon helper to build regmap")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: Arnd Bergmann <arnd@arndb.de>


Note for netdev folks:

If this looks correct approach, please kindly ack because:
1. The MUX Kconfig part is a fix for a patch in my tree going through
Greg's.
2. Above exposes circular dependency, thus should be fixed in the same
commit.


Best regards,
Krzysztof


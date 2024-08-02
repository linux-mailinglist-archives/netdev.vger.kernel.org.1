Return-Path: <netdev+bounces-115426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A435794659F
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 23:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8BE1F22FF5
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 21:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9908C76405;
	Fri,  2 Aug 2024 21:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1BEJbz1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CE8137764;
	Fri,  2 Aug 2024 21:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722635655; cv=none; b=WszwlGRNDeBfAJHc1SUeUYtXsnZe+VaTQOMowtEysfX/5CAnH/solUPOKygKmLLBiPBjZ5iTPd9UryQPvOmNKR+m0deTqRWsEulTqFM6Tfng2RbvtSy1eTzNa9nmT+6y4mfZUcWtpjcYnVkd5v7mFwBHtWbgbHfGLfByj1Dw7Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722635655; c=relaxed/simple;
	bh=8YXO6f9RdBNTctlY+5xX2A/AC6bVTvUondEtVWXmLTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QQW+RIU5s+bOfM3K/aVnEYdbqXgAA52urlHFLFz8kB83muzXJPz6D9w0Ir8o2FpS5qyPJFsGVVGb+VAh/FVm3qDMklaXAAwP0yfh2Vk7xPcitWcie/wJCZRtVJxkHDyJvc0E2v8lwtrXYpJASwh/Z9mNGdyOCEWrhVAJggnZuhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1BEJbz1; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a1e4c75488so500697885a.0;
        Fri, 02 Aug 2024 14:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722635653; x=1723240453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q9W4/1VvEkJzhWBDNE7mzeFJGT5hOKki+uKotNf6ypo=;
        b=P1BEJbz1Vu0xxDUU7fTLJCKif2mx3A0DhEdG8A8xA6Pn3lvMzQDnBSRF1Ds8Bt3EmD
         OKbOliZPGo9BabPu1I9o4HxbfxixjB1HtM6/fBqYa7Wr+qUKwV6mgweoMyrwXrtDXAMF
         4Yn7rXYVUPBCGSOJjfXwDmu/vFYfo81c5+feuac+wdiHjEF+nT14pqy6SlADBVwVRQLf
         1iPeM0bs0/VMaIeA6z7WblXDHr4F3Hhb85mS4Wem8sL7xqm8vECg4NDXbY7y3xi3nMLS
         5M74j4T5GZg9gNmvMZK5HSsiUV0Z81zYnqQul8Mle7Bq+lvygkufKfqOEs48VKHdx/X+
         VwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722635653; x=1723240453;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9W4/1VvEkJzhWBDNE7mzeFJGT5hOKki+uKotNf6ypo=;
        b=No5F9QOyI9tj1LtK4fnQCIMsOXsc2iSAvLrqrFxoYHUYRfbZvZJ57XogfOr2r3Tjpo
         PFs61pjldJHScGIqoLD5RwvC9J9mGD5p7kWkG+ZwdQCP10b5DXH8EKoqE98x4pLRUgFL
         f2wCCfEzMLHq/Viy0G62nbU7eYQKcNmYMaYYOudXVsM1Pz13eQpVtH3SrKGIXxEWNOLo
         pBAldVLNeuAU40LwmrI9PKNz9WgU9iFYGBJSvOUjP1ohvM+6pltDZ14i3f4Ybxj6PyQ6
         NhDOCSGxGtNQaweg26gxFuiMEISt+hmw/yRqsaBzsZ98Wi85Ij1w+UPTOOy0bqPQZ6J/
         hS4g==
X-Forwarded-Encrypted: i=1; AJvYcCWSrD49oskp1gMGw7f9kj3qWvfKe5wuqVNoxrdpQ6UFR3M0eN58Y6wQ987x20POyRnBRij4DG/GG7KAmOtDMpLrMyOzqnEoKSvu9WA/InTRPMpVg3yKTylfAxexwVKG4Z38Ub+n
X-Gm-Message-State: AOJu0Yz2n0lnX4jC7kJbuj1qDocP9C3vTY5mabwMwwMrVzCq2XVO2l+/
	vTIcB8gtwslqj3WCu/7vYUbUrYFLiMHAvRQSG1/dLPFlqxnlhEfr
X-Google-Smtp-Source: AGHT+IGeLYG/3Ga3hUyWUoMLRsgKLe/czk8qX/sdRETqvRpbrNDB8I+z/I9KCrgp7bzjy/T0457wmw==
X-Received: by 2002:a05:620a:bc4:b0:79f:dce:76c7 with SMTP id af79cd13be357-7a34efbac0dmr515088685a.68.1722635652887;
        Fri, 02 Aug 2024 14:54:12 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7a34f6fd852sm122277485a.66.2024.08.02.14.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Aug 2024 14:54:11 -0700 (PDT)
Message-ID: <4bccf28f-5618-426b-a399-ad31ddff0852@gmail.com>
Date: Fri, 2 Aug 2024 14:54:06 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/6] net: dsa: vsc73xx: fix port MAC configuration in
 full duplex mode
To: Pawel Dembicki <paweldembicki@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Linus Walleij <linus.walleij@linaro.org>,
 linux-kernel@vger.kernel.org
References: <20240802080403.739509-1-paweldembicki@gmail.com>
 <20240802080403.739509-2-paweldembicki@gmail.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240802080403.739509-2-paweldembicki@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/2/24 01:03, Pawel Dembicki wrote:
> According to the datasheet description ("Port Mode Procedure" in 5.6.2),
> the VSC73XX_MAC_CFG_WEXC_DIS bit is configured only for half duplex mode.
> 
> The WEXC_DIS bit is responsible for MAC behavior after an excessive
> collision. Let's set it as described in the datasheet.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian



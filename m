Return-Path: <netdev+bounces-156477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 097C1A06803
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 23:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE8267A0856
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 22:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE2E20409E;
	Wed,  8 Jan 2025 22:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+USAGhh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1F1202F97
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 22:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736374439; cv=none; b=MeCpjfiPxwxxFBVI3WdLIv6dwn4JecuH+Z4ezOqItGU7ayHlRFokON1ccD8MsdJf4xnYHen8b5/H6JfHukpBjj/mujACX2Ut1F/LO7WAQJz9dBMggM0bLzpnsZ2ulfsMw44yaXoUALoxwW0/AAXTs2CQN++m05FwCcwuIzYVQaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736374439; c=relaxed/simple;
	bh=RwmIyN+ffMtJ0IEaRffjXwvT1TtiJF4oQBjoYISf8Yc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Wysb46wBvFC08rnmNtbfFH7FAUumGdk0xEx1VIg0w5wT3HIlELh+nZup6BrUmd/Rv3H5onhT2GHWQ9G+gCuzTU/En39trOVA4kDzd/J+Ikw+4VVljXVZ/RvtRE3bBeo1mo+SkKKJIm8pnaJUyJhVFmRy9agkVmLbWDXw+xMiHcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+USAGhh; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43618283d48so2544345e9.1
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 14:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736374436; x=1736979236; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=01EL5PxRZWr1MpEZPSIqOZvVlFLzdeOPH5lUFGSPCwA=;
        b=A+USAGhh7YURm9ny3Y1LOwajGK9ryyIwd29mhtUMBeWAFIoxLJgQao+eg9Z12PnhaM
         JMQOmPRRvtz4JVMVxif5c+SvkHj0Laa6TmJHC/hdaOhudoaVBlYxGqo6pKgC9GcJfxOJ
         ehFe6UN39lDXNUufn8opdvLwRDkneYzDSdcaWWytdOmveL6G3xJRcaewcHxt6Ilv9EMb
         YNRc+yLm4NHQ45KibqVP7n6b/nydOkuM3TX8TmQXayAIiaDOxrzEZlTVlOc6wmAXMnVP
         DITPU1xnArxs79fbdhmvmfWUkg/Tk0Bb1IkWdIfd1nuvffKdO1bT+osgKo36RtctGg1D
         XNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736374436; x=1736979236;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=01EL5PxRZWr1MpEZPSIqOZvVlFLzdeOPH5lUFGSPCwA=;
        b=V+XV0LN+6zVcwcr/jISb/AUOkxkcoLM2hyY+X7glvCM2CkalUUtcZruZO91ml4UV+T
         ul5qnQ2nIlbXeoSg714XPaRa0EHJo7LHRe3Kezo+QICfSAWoKzTz39EEwMv4/ubxbcxc
         j6o9Jm9kaMtXwJppW5GDH0ULLGJbhrMHostM8Mp9V69GF7SyDn8IcUpIiYaLWx50oy2E
         5yClUK5YVi99SZ+j4KHY4/vct3a7V/jpXw1OEP+WCFAl3tGaIX8QeFdpW0JmM235n6Q9
         o6F3sOlk6qkzznWNrywY5imBudZVKAWLqDPxlCa2eaLSSDp6fogIY2b56K9KAAtZY2G9
         YgNQ==
X-Gm-Message-State: AOJu0YyZu32wdQ0FT6ob5DSqhr+qTMqyk2uJnvEZc6YaJBqrXkZ5Us35
	lZ5d+MnIZqqDZcNe8ovT48rmtJWiOHyg8Q6qGxAW0ZB0kNJADEIy
X-Gm-Gg: ASbGncvEZvoMzsC6d3NBoPETnZIE8mRYlGI3OaGjNqkeF5BEBBv0XSKlHhbHrKmDoZX
	WftBxBDFhupDuOF7/6IVUwZnWxga+eLSYgCukIJZ02pHH3MZD1aMZk4XSW+3SnBgyfhjue7VihL
	Drd14uRgYFUL8W2KaGfqfdb7eE3U/Sr7+MzcW+oZZyQvFkat72gBJCwUaQNUJiXpCQTznzrAIJ8
	6kswvyLg07abltMvHskI2gPYnm88uYmfY+TuuJ25SXKuBKcgwEVfdntHfBzbNoLgVsH2yYEtNOE
	a657DqW2y2NkeqJgbPMQ9L+0wjzw/Vc54HY8lLRLHNvuMdljJYSAkjIrWWnpHp6AdpHifo+E6tv
	2w9wCoHHOetEUbz6ylq6P8wwWE6xlhe/k0XNIYrtaVDo1nlvR
X-Google-Smtp-Source: AGHT+IEBGrXmxWc80jSjXmx1Y7eoC5lypRfWjuT5yThbv4yM1xLUjJe2EjpySiREzJG1BJRLjHq4WQ==
X-Received: by 2002:a05:600c:3143:b0:434:a929:42bb with SMTP id 5b1f17b1804b1-436e26b9d45mr35276915e9.18.1736374435519;
        Wed, 08 Jan 2025 14:13:55 -0800 (PST)
Received: from ?IPV6:2a02:3100:a467:5600:9df3:f3ec:1de6:b471? (dynamic-2a02-3100-a467-5600-9df3-f3ec-1de6-b471.310.pool.telefonica.de. [2a02:3100:a467:5600:9df3:f3ec:1de6:b471])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38a8e4b80d4sm28954f8f.85.2025.01.08.14.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 14:13:55 -0800 (PST)
Message-ID: <ec3119cc-9812-40c7-898c-a921a72eee38@gmail.com>
Date: Wed, 8 Jan 2025 23:13:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] r8169: extend hwmon support
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <97bc1a93-d5d5-4444-86f2-a0b9cc89b0c8@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <97bc1a93-d5d5-4444-86f2-a0b9cc89b0c8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06.01.2025 19:00, Heiner Kallweit wrote:
> This series extends the hwmon support and adds support for the
> over-temp threshold.
> 
> Heiner Kallweit (2):
>   r8169: prepare for extending hwmon support
>   r8169: add support for reading over-temp threshold
> 
>  drivers/net/ethernet/realtek/r8169_main.c | 30 +++++++++++++++++------
>  1 file changed, 23 insertions(+), 7 deletions(-)
> 
These patches are superseded. The temperature sensor is also available
in the standalone version of the integrated PHY, so I'll move the hwmon
support to the Realtek PHY driver.



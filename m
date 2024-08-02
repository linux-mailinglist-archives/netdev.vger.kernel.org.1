Return-Path: <netdev+bounces-115429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CAB9465A6
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 23:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B051F22E28
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 21:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B298139597;
	Fri,  2 Aug 2024 21:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQPzExsH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F908120A;
	Fri,  2 Aug 2024 21:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722635874; cv=none; b=jpuxYSQfAyrIj/xh2Dsk+7xWFHW+bMgz7tB7OLcvw2psJ6ecJkbk4dqIPKQBaq1xPI1H19lGakFktMz1GGKOqU7f/1/WXbWyqbMOAHxPgLr0ZkSdsDI1emwtP6pCpcMU8ulJnkC6M5JWRDBcdk6uTHOo7nYiLNluBcFqiW7m9xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722635874; c=relaxed/simple;
	bh=N/jzdE2JNfP8kPtcekX+ld+Ycjy6CXEvs3NSj7LtiBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UFo+a1hbi2ns13+Mcs0f654iaC6CdLghBzKHODqVX90YIELm5llTKW9cgDcIYGXZp1uo/OQZSijaPbXnyH9aAPAJrvPq88heue4J2JBd23EoZNvnog8rZp39ZFkF1GRH2NiUdYnbI0BncVGPaArl749fz2FukaDLlQZPjBG6oQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQPzExsH; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-44ff6f3c427so40966901cf.1;
        Fri, 02 Aug 2024 14:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722635872; x=1723240672; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Yisz4Kz62zQUPtoQOO3Y0OYrQh+KvOxC9+yB/2FF7c=;
        b=eQPzExsHhcmwqPdds8Dv2khY2OowgNyGpE8RYrEH7T8jdriQivyZxvHiuC1V8DkRw6
         XA61hirzhzaQSOmZH0DCCJ0E67P2qem8geF4oBdx49XepXFE2vT3WgxftIn0GkivgQAa
         ofkF7i3lcQuJwEUsUQ6J331wVyynL12BvkOgYP3LdHYb7qwR8LaEbFO5AIRFM12EygPj
         eWeuY6b+N1ck2rZiUZC8Hr+wM9iml1GPZa5rZBPezSqb8k9WDjFrqL2l6RIwoJQF0XK3
         CklCEpHQtfFGvR1DZSD4mO7MrTHRW2+66VSjqU98hx7icZSkq9fgURgb2d63pN89DVQV
         TKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722635872; x=1723240672;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Yisz4Kz62zQUPtoQOO3Y0OYrQh+KvOxC9+yB/2FF7c=;
        b=c9bsgDcv9xtWjaKGekoMUZoNgiliR8zH2T1NHB/E5py6/s3HjGbGNlcinclIfGMmsS
         VZFwdfwq6ruG1gC0RyDMi9POm0pX8w1pHB5deyveifN5O63TsfZMVgksefeqoQnlLGqA
         BO+AHqlX7fbFNUbr9ZtcG8tYDPvmqXmbU1ZZ3UIf0xxLgYuoWMPuIV+TQ0XkPRVetkV/
         /uAQoJ+ssAYMeJPS32sYuWNT4USAS6X4dY7olTT5BVXpfSgEa/IA844qQhurIKZDaqFg
         S0Am1fsYmN1fIlsh7xJNB7zDFJ3fQ9A0lJ0CJ+GFxaXyt56l/cOLRG3LWnkmDOxvrzyT
         Ax4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXDnrVF75PuoJqxF3hZxUw/YBf817WCKN9Ll70wkkDyUqNfIZ902/4aWe+i/A1FX+rdr3KGlL4AeDOB7qW8Cv1xT5QY909EvOAqeqYq95UO4Twh34Z+8WQ9iRCMz+LpkZt2rUAY
X-Gm-Message-State: AOJu0Yzt7ijU9f3PzsXkff9B87zPyUrHy6La0L4c/4LYsuWVqakD8QbF
	OTLYjflqud90TiM/TWxDZrHsJ6nqXlnNDcLQ7RsduXjBZiHZwg8V
X-Google-Smtp-Source: AGHT+IFmdkNyrozE2ZfgDzqy38j0LNUKqFWzKOLzIx9aVoRU4Mqocs+swC217vp+5qkHW37ZrdcOtA==
X-Received: by 2002:ac8:7f0a:0:b0:446:49f1:79a with SMTP id d75a77b69052e-45189287653mr69777701cf.24.1722635871789;
        Fri, 02 Aug 2024 14:57:51 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d75a77b69052e-4518a76c7dfsm10409591cf.88.2024.08.02.14.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Aug 2024 14:57:51 -0700 (PDT)
Message-ID: <3248ea5b-5bb6-43d9-a7f4-dbae5193ec5b@gmail.com>
Date: Fri, 2 Aug 2024 14:57:47 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/6] net: dsa: vsc73xx: use defined values in phy
 operations
To: Pawel Dembicki <paweldembicki@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Linus Walleij <linus.walleij@linaro.org>,
 linux-kernel@vger.kernel.org
References: <20240802080403.739509-1-paweldembicki@gmail.com>
 <20240802080403.739509-4-paweldembicki@gmail.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240802080403.739509-4-paweldembicki@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/2/24 01:04, Pawel Dembicki wrote:
> This commit changes magic numbers in phy operations.
> Some shifted registers was replaced with bitfield macros.
> 
> No functional changes done.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian



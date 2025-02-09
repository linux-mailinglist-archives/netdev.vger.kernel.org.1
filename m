Return-Path: <netdev+bounces-164445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AA1A2DD2D
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 12:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A783A4203
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 11:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2B61CCEDB;
	Sun,  9 Feb 2025 11:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/V8Ks2k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55B51BD9CE
	for <netdev@vger.kernel.org>; Sun,  9 Feb 2025 11:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739101991; cv=none; b=HegQi1Nm8+uawUF8P2eGgER3tA9i393sjTJv3jHd0w4FyDrLNuoob4MkiGr33ALwoYprIZlY7WMwCS+DgyMTUq38xLRdB0gW++z0eLbMyhQWepT8DnyJxH1pJXoGnHAvIeJjM6qK0O9Oyj+CRMBkwKwsjIiuNXohDmrbfM7wewc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739101991; c=relaxed/simple;
	bh=/XDHJ8sr6t4n+Vz6TwxZY32yF7gE7n/9Na8VeFaq8/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cURtRecgWW4Z3qIFvNclyC3G/Fw8rcwXGRkWiZf3mHxn2MMHnLRdCwrYvknRx90Pfv4dklHQQysv4CAmZeTO67/RGyuxGdr52+5q4/1DFfCptuzhCOPnYvnjYxqVhbetJs7LfC+fOCRzZj1pXMbtsaw+CJ/Y4SNAXvDIiBPzOyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/V8Ks2k; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab2b29dfc65so555092666b.1
        for <netdev@vger.kernel.org>; Sun, 09 Feb 2025 03:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739101988; x=1739706788; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jLSLghMasTDx86lV/S59OCcHiw086kUYUqJjjTP6bVg=;
        b=Q/V8Ks2k7m32SUahqCLf2A1F29s4jhi9XKPhOWJxYajLlDx5Vn7N8hFqcCxfQ1xFRT
         Q0edHHgJJUrXAt9ggxtVgl/UnHdR3y5haVzmbhTrRteZweg1G6K3Q9MUABbCbIqa+Ba3
         eM0exYDXsjnU6YlyMnZoPPMJrB31Qg5ZRs/4q/gOWJkZ97GOR1Iw6o4hi/NFDlmMtHN5
         PCmGYHxdrKJZQiWyCeQeIRSqLBKAVTHfPGjjG9WlaqofT7BKv8dXZqCdvYr3IO4wWtw3
         nrXEl/Xc+IyEgvGsB9A46gckcb+zS2ZYRjVqn/ylIVFOJJth7F9huw5U7jqCc1rD3OUP
         zSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739101988; x=1739706788;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLSLghMasTDx86lV/S59OCcHiw086kUYUqJjjTP6bVg=;
        b=tuFp0K1NsxcxydWGdzV29FMYuTQNgfjqgATTdAjjl2B5xK7IqH3nV7TjgB2M1sSSSt
         jvBa4a2aLYyH6ADxVb64Y04nl1EZyiGXz+YzPUTpf5GJB/ehNI6Eh9DtMjv273GYKd/5
         +oTo6EActokH4x/QD2MwVIqiHYOP2IcOrZ7YH1f8kljI/c+k830GRY1wg5ns4Itrf7pK
         mQ716hVK8rTd9DUNzgnndWwaSuJo8tSRiEtoTHT68IeoThA7YY8+p2S9z2Pj+RxAoGS+
         6zAEni/Nx9EZKajyFXxmmXkDTtj23ra3uUuZfS9cFzMBax5l2PMfjbP+sYqNGsOutvPY
         0BUg==
X-Gm-Message-State: AOJu0YzhcVOFDoGpE/no9LJY2lcb3BDKV1UsNOGRqfYpzP1pUsbP+5oX
	dFOEwpaWWJnStXZQiilGWwUyKQcWxaGHlrUSeA6KV6okrrfLEvk/
X-Gm-Gg: ASbGnctr593OqpYLu6PlsQsEeciTncVaM1FHdEjS76TNU3JjSOqCRbVm8cGlBnxkqoX
	LUg+IAWD5KN9nfyL0/JL6CzI7YDXKjAOzEpT/6JS668PeO8x2tF3vSBPo7KLGXfgDBuaNT9Sj1/
	rZOCHeFa9eXuIBbiKi2dz5sbzaomhowOR+egjhRD8y1qjzNaNghSMlc6N+3YTpJG6xx6Zdoq9qV
	QgXAeByMO4u0f5kcW+lL13Y/uXoltvSLiAaxxsUcr2g8rPtGFX6WTk5uDvvSelIgnXT9nprHD2Z
	ohDGCNZMsvb5k2s8lwGUpEbM3N7kADL42yWATdvO3uYqN8n7xKckIapQDgqkJd65byQdPrtokfD
	f8/gxOXVZ4S3fXE/Ge4qfDiDUtk3y9JtcRZonfH6ymm3ksCl5EeQwva15hNVzmSseOT9QvJJHXB
	SXDoTRCbI=
X-Google-Smtp-Source: AGHT+IEAmRFatxs5HFZpaqxhC6KAsurPDfElH5RS0jBNWRJQo3BlU7WLnlPdq2L8wy4k2OiUDwlHUw==
X-Received: by 2002:a17:906:f5a4:b0:ab7:b08:dab2 with SMTP id a640c23a62f3a-ab789b39591mr1133994966b.22.1739101987651;
        Sun, 09 Feb 2025 03:53:07 -0800 (PST)
Received: from ?IPV6:2a02:3100:acf0:cb00:e533:c1d0:f45f:da1c? (dynamic-2a02-3100-acf0-cb00-e533-c1d0-f45f-da1c.310.pool.telefonica.de. [2a02:3100:acf0:cb00:e533:c1d0:f45f:da1c])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab78d5771easm489169366b.83.2025.02.09.03.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2025 03:53:07 -0800 (PST)
Message-ID: <2257559d-6528-48c9-a2cf-b60a3a976037@gmail.com>
Date: Sun, 9 Feb 2025 12:53:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: remove unused PHY_INIT_TIMEOUT
 definitions
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <11be8192-b722-4680-9d1c-3e4323afc27f@gmail.com>
 <0203253b-4bda-4e66-b7e6-e74300c44c80@csgroup.eu>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <0203253b-4bda-4e66-b7e6-e74300c44c80@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09.02.2025 10:28, Christophe Leroy wrote:
> 
> 
> Le 08/02/2025 à 22:14, Heiner Kallweit a écrit :
>> Both identical definitions of PHY_INIT_TIMEOUT aren't used,
>> so remove them.
> 
> Would be good to say when it stopped being used, ie which commit or commits removed its use.
> 
> Also why only remove PHY_INIT_TIMEOUT ? For instance PHY_FORCE_TIMEOUT also seems to be unused. PHY_CHANGE_TIME as well.
> 
I stumbled just across PHY_INIT_TIMEOUT. You're right, I will include other apparently unused
definitions as well.

>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>   drivers/net/ethernet/freescale/ucc_geth.h | 1 -
>>   include/linux/phy.h                       | 1 -
>>   2 files changed, 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/freescale/ucc_geth.h b/drivers/net/ethernet/freescale/ucc_geth.h
>> index 38789faae..03b515240 100644
>> --- a/drivers/net/ethernet/freescale/ucc_geth.h
>> +++ b/drivers/net/ethernet/freescale/ucc_geth.h
>> @@ -890,7 +890,6 @@ struct ucc_geth_hardware_statistics {
>>                                  addresses */
>>     #define TX_TIMEOUT                              (1*HZ)
>> -#define PHY_INIT_TIMEOUT                        100000
>>   #define PHY_CHANGE_TIME                         2
>>     /* Fast Ethernet (10/100 Mbps) */
>> diff --git a/include/linux/phy.h b/include/linux/phy.h
>> index 3028f8abf..9cb86666c 100644
>> --- a/include/linux/phy.h
>> +++ b/include/linux/phy.h
>> @@ -293,7 +293,6 @@ static inline long rgmii_clock(int speed)
>>       }
>>   }
>>   -#define PHY_INIT_TIMEOUT    100000
>>   #define PHY_FORCE_TIMEOUT    10
>>     #define PHY_MAX_ADDR    32
> 
--
pw-bot: cr



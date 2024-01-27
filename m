Return-Path: <netdev+bounces-66395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BFE83ED41
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 14:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A71BD1C212C8
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 13:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1C32557A;
	Sat, 27 Jan 2024 13:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9aDPKzx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483F421115
	for <netdev@vger.kernel.org>; Sat, 27 Jan 2024 13:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706361704; cv=none; b=Uirn7edBDn93axjkMBFmh06AosrHTcJvEZ8gBpofhXwPtGncc/F4sQzy/T54NYsm3LoYd0Nkqf3wm01BISYVdUPWPnlEWYHy6txpHx81/fmO3y4MmDSAvVzYPzW6wHlv452L295x/WaF1LCITEINQbyocBn+nVQP4rKMl9+BSIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706361704; c=relaxed/simple;
	bh=gguaVdJbE3Y4OQdaodm23TeHI3T+DLhuJdZTsTl4r2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RUeswyjSpFGasWnFQibWhREbt2/SOKc9SivnWTK3yCDbC+EoqPGy5d2B5fcucy2OIwDGPzVOT7i8wbFAWux/5+s6dD4eTmP43lrHG9IfzpGOyGYRyWPBI9MAK/iHGEFXOVsTmcp+rccxj+DIaq5Isvfc0qyrLTpaPC33ne61780=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9aDPKzx; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40ed3101ce3so26125165e9.2
        for <netdev@vger.kernel.org>; Sat, 27 Jan 2024 05:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706361701; x=1706966501; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5Z8S2MLcX417QFcztKUEx6YA3X1Ot48Skf/WqFzVRn8=;
        b=d9aDPKzx6ALmRyzb0gAw7sc/UvhVLfkBnquI3umJW+HTtxw0jN99C6cBJG2RXUyxkN
         s57MXA/A6VGu2U8vxvPfrQFUy9gfXVEVsHRfhU9aXQ1I8sMPmOzxm/KlIJFQzzgdGxDk
         Q5ziU+aO2Vw5KZcLOLVfIUQLB64hMev8sxLufrMF3ARmYwGmQGKvkbyonTNwMe0jpRUa
         RaFLgQFrN0CW3k0D+PbhWW13zl0hsk0d+TlUH1lyWMf+qPUKn9PD8EIn3FSE/bKYBSnV
         GtHHh+XcGp7YzVW/lYGTXkBgzmZIzfM63lfg7QduP9Qcqf06lKDzF5jxxWFQO40KyrFu
         zAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706361701; x=1706966501;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Z8S2MLcX417QFcztKUEx6YA3X1Ot48Skf/WqFzVRn8=;
        b=gzj6nJ5i2JmApReyFPs9UNfMrHJMeg+yK1qODw19bbaStu+wX42inNK7KuR+Ewet3w
         XYzLLLTQ6Ezn0j5Smdj0FVaUMuF6ALGXnZgTOo3XHbX1TllXTrbkJ6tCofF8292Vx3Re
         eR78XvZA7g7RwaHsluI35CND8RrV5ULD5PwIsAfFt/PG27L7iGo6tibjjhEYOqeK7rS8
         nZ1nDNT6qOqmlkxQKpFGIu6alcNCzlyYVRTE8XHoCqarx4vDh+a/WN0cos9PEYfuwNdF
         5su5JfXIzHMm4+EJRhq7UDA6Ugxmr3qCA6QXExrKKlvA7qsazd2JcFsPuX+jq4X6ECLp
         zdDw==
X-Gm-Message-State: AOJu0Yw2ZiAYo0WXARtsApifAkP5BJ8jRv02qUIkzj9ONx8U63FjAIJJ
	Q0CvHhtN70e/5eW0bj5fDZLmVp1KaY1W5ZY/O0K58NqZdwsqfXw2pFf5L5Ry
X-Google-Smtp-Source: AGHT+IGd/+DwJIMTIFJMIInwchv339UrOhgzUw+MTBdjZmKGEA8JSMn4hg5y+8qaTFlrZaOL+CdsAQ==
X-Received: by 2002:a05:6000:227:b0:337:bec0:f8e1 with SMTP id l7-20020a056000022700b00337bec0f8e1mr838854wrz.244.1706361701094;
        Sat, 27 Jan 2024 05:21:41 -0800 (PST)
Received: from ?IPV6:2a01:c23:b938:5400:11ba:857c:4df8:38b0? (dynamic-2a01-0c23-b938-5400-11ba-857c-4df8-38b0.c23.pool.telefonica.de. [2a01:c23:b938:5400:11ba:857c:4df8:38b0])
        by smtp.googlemail.com with ESMTPSA id y14-20020a5d470e000000b00337cd6b1890sm3457946wrq.80.2024.01.27.05.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jan 2024 05:21:40 -0800 (PST)
Message-ID: <d8ef9ed4-196e-48f4-84fe-a23d46c99d5a@gmail.com>
Date: Sat, 27 Jan 2024 14:21:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 4/6] ethtool: add suffix _u32 to legacy bitmap
 members of struct ethtool_keee
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 David Miller <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <c28077f6-74e2-42fc-b57e-9545816cc813@gmail.com>
 <e6ec45ea-0bfe-48f5-8169-a34e070732cb@gmail.com>
 <20240126212040.0fe28d88@kernel.org>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20240126212040.0fe28d88@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27.01.2024 06:20, Jakub Kicinski wrote:
> On Fri, 26 Jan 2024 23:15:33 +0100 Heiner Kallweit wrote:
>> This is in preparation of using the existing names for linkmode
>> bitmaps.
>>
>> Suggested-by: Andrew Lunn <andrew@lunn.ch>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> missed some?
> 
Indeed, thanks.

> drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c:719:30: error: no member named 'supported' in 'struct ethtool_keee'
>   719 |                 eee->advertised_u32 = eee->supported;
>       |                                       ~~~  ^



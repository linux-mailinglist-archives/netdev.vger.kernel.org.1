Return-Path: <netdev+bounces-189447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC85AB21D5
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 09:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A29A34C33DC
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 07:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060371E5B8E;
	Sat, 10 May 2025 07:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9nbBgld"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB452E401;
	Sat, 10 May 2025 07:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746863652; cv=none; b=JLV3KGgEe8Y47kqQVvb4okUf0VZNzMFDDZThTBRGpZqCVgQIM/l8IyUbkL0LUwrB1CtC6cSfYdU7IJAo1nsG6eN9EXpuaqfyLT7/Cykr4xwU3OS+XfQu4/IDFtxLDIImzL/HQRUaGuEqcCtaxnnUQyhT6s1eY5pFdsEdrmwJvTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746863652; c=relaxed/simple;
	bh=RYkWhSNdMlYZJA83fatCTnranXOAZI1gdWNf1gvfuXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFDLrOOvVgA/z3F2hxG3LTfXYSHkbZqGI61yVHw/5ajMp0wcbL0yKJRYA0h9aooK+NeLIsDSAVuWN/ZfSLf3tT9Xezft2P/RR68xL7PJ/ZNF4oe5MEP+BaA2NelwYKzI1K/S4i8+sgTxEaPmvpcbOzOkg+t+BQwLkUFYDg3Fr4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9nbBgld; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5fbc736f0c7so4224642a12.2;
        Sat, 10 May 2025 00:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746863648; x=1747468448; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RYkWhSNdMlYZJA83fatCTnranXOAZI1gdWNf1gvfuXA=;
        b=i9nbBgldYOGOlJcg4YDWDwtl2IPvoj7uzk574hbJ2WSaehsTiusJ8e2yVvpILYhYi6
         vxDCXNJdMzqjFYosBK+qKNweQnPt6o/2IMT/aZO2GvUhsjFfQPWQ1oUTnXUK8qvwjNw9
         r1/3Rmujr1QiZ1U/50drKyaTcG2EJqATmO5dsndODzEjfSVpHOAzlV8a7FQ7T47jxIOv
         8btN0eH+A2ZhlKOW7/c50QNzLhwoTLEL7qP8lVTmqyhoGpuyP6YDgUv0Tk/LFAOB56A4
         QcWG+tgk/MPPQPxdEaTlX3y14EYGFelDmlX9D55SfOWXs7EorPXqKazmwBJkRKHcYcs5
         wozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746863648; x=1747468448;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RYkWhSNdMlYZJA83fatCTnranXOAZI1gdWNf1gvfuXA=;
        b=kUlSDgxOora8Dd5jXSC477+j1y110kWYJ8mxt8SMy/KjCNis8wifN07GwpUzFAv4MA
         7tEVqEQkjxFK+3B5QfBdvRRifD+MkeqY/ZTSGFIJ+8icHHzk3lQNX0PwUBD8DxDj5S93
         v34Lf5o6DHnJFgdftFDtP/Hw+mn3oZRrKcf7e5SSWJR0uDUNDEo9MTosObQ8qtiQL74b
         4zSTYwYDTqXQNnIGDl5EKEfK+q2s4HnpiW3YoLzjRL2k0FgxeuzSCSk2gdmtxeDwM7z+
         MdZQd9B/uCpSuhRUCHgElUzFEkBUlMYXo41j4/CStUZ2X5EiJzwcNZoTyA0oJbRs1drP
         tg9A==
X-Forwarded-Encrypted: i=1; AJvYcCVHdA35GjykaUr2g/AW4JYiUXSvwuBJp/UGcfP5b2VGr2jZ4+Kn2j5nm1074dVNi0noGSlHfO5c@vger.kernel.org, AJvYcCW1ma3LiKg27Q4s65JGT6oGPsUonVvDCP4zh+BIiKsi7npvX5TMZEaDHtBgNyeRTzgAe03r+TlG/HVpC4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Q/bzGKE1+D7g6cesF7VleHNPh9IhbIZ/QqkkUWhrbOGN+rnJ
	Vv3fSpcF2Q+X7FpxcaXHGA6sN+7hTMmOgDtkaJgSmTmXp1lRQmd9sUcW6CJ4
X-Gm-Gg: ASbGncswRURA2jJSJfwyQ79O9ckksYrnYM79QYqimcVv6U0ItuObOPnNpbZziUoExhI
	CF38KuZ49X6eurRdChZppPbtnDJtGAsaaQbo4O7F9Y+5MopSHZoEvmPM6cf9YqEB3eSRATYmiRX
	855Rzx5eFPmeHqYu5LEeKnTRSS1dC96tEQvC7j45Azqp8ES0945If2U/c7wBmgOUZXH9jUP4az7
	tIbDxI+7GOE8xa1DbLSEzG/waBm+sKJtUDDjnXM4wjUo2zruN8X3muBcPAMU9/gvB7xgQkb7Cv0
	TlPtZ3IvKIcqkyuJ2khhzj8qcFuULWHd4x5zkTyV3X3CBQqGq2vvt9mzd5viRAoFgkJm9GYhpCH
	3HF4oPVoIuJtOgjw4gP7qtOnSrXLqF0EyU+1ICIHkIkl2B8U7YYUb4UX3Q0H3fOj4PS6p9jadRL
	JtDUNFakCsA1QseDIUV1XKQXLOrzeB
X-Google-Smtp-Source: AGHT+IGgstwKokpN3dlJzftnW9zdzWGVvrMswOt5GCKDaR1pR2NzfOEvjdJkdVhAlcaMUFx9AyqdOg==
X-Received: by 2002:a17:907:724d:b0:ac0:6e7d:cd0b with SMTP id a640c23a62f3a-ad219115e4amr404337866b.34.1746863648172;
        Sat, 10 May 2025 00:54:08 -0700 (PDT)
Received: from ?IPV6:2a02:8388:180a:cd80:ae73:baa1:6de4:2169? (2a02-8388-180a-cd80-ae73-baa1-6de4-2169.cable.dynamic.v6.surfer.at. [2a02:8388:180a:cd80:ae73:baa1:6de4:2169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21933bec1sm276906366b.45.2025.05.10.00.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 May 2025 00:54:07 -0700 (PDT)
Message-ID: <bd271340-7bc8-427e-9536-8ab390493cc9@gmail.com>
Date: Sat, 10 May 2025 09:54:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dsa: microchip: linearize skb for tail-tagging
 switches
Content-Language: en-US
To: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, quentin.schulz@cherry.de,
 Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 George McCollister <george.mccollister@gmail.com>
References: <20250509071820.4100022-1-jakob.unterwurzacher@cherry.de>
 <e76f230c-a513-4185-ae3f-72c033aeeb1e@lunn.ch>
 <20250509125631.cckfc2ychkyobqqo@skbuf>
From: Jakob Unterwurzacher <jakobunt@gmail.com>
In-Reply-To: <20250509125631.cckfc2ychkyobqqo@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.05.25 14:56, Vladimir Oltean wrote:
> Jakob, when you resend v2 retargeted to "net" and with the Fixes: tag
> added, could you also address xrs700x and sja1110, or should I?

xrs700x seems clear enough, but sja1110 looks... complicated.
I'd prefer to only touch ksz.

I will send v2 on monday.

Thanks, Jakob


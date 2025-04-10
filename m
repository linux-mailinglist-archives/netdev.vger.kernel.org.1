Return-Path: <netdev+bounces-181311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A07A84619
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 16:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7970C1B60FBB
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 14:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F385228C5B9;
	Thu, 10 Apr 2025 14:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="BwJMNJvC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446731C174A
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744294619; cv=none; b=Mm28w7aPCXhR84h5iCCBfvgU77Al3uFLHiRuok8Er9PB39mBVVVa3Dw6iTD1by1mJNesNcoGFzy1BqwdVIRDt+K8c/HpD6uY0lNBHut4n+TXGG4IKfCXKkZbnwamzHt6GHKFApLxk3MJi+r5odBSe7x72VtfXHzW6lElNB20Res=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744294619; c=relaxed/simple;
	bh=bOHvdimLqDaAbnABZ4HW9IQe4zFEb1qT6LsJTR6qRu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kcuKoe9jiQaNyqRhbKXPQN+jk47tOdaeZrIneBWdpw1JoOv18Yt98btVwR0z6LRRuny7qVPmuZnm6Tyzuf7uR2lz0voIRlXq/5i/UDc4F8p5IOvD5VEvNX0C2391b3LojGzX8TWCPnC8E6wqSYt3reXUD+UFdSzi/QIYOJeBvr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=BwJMNJvC; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abbb12bea54so170184866b.0
        for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 07:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744294614; x=1744899414; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UlZPMsmoVGB6t2rST7vEZ644AG6qFhEWTnum5nMbQnw=;
        b=BwJMNJvCOsPbF3ucBUDTEbrxjm6Go6VD6dDpQnX2QXebOqtD65U7hASn4ymdLntXs7
         eAv2u5GCpNnbsySzdmdSa9zLW2ErmIB36ryB8o2dtiFiZj9Y+z4/0PtK/jNcuOuPICQ4
         GagFCJFk/36WdBK09loE4B5wFGmq9NiGFuBJJ1q+o2Eedc4fSkJR32F3kXRsC5Rxt/bQ
         LJ1qLZbXAp+UaGzJzu0GLNB9sET/WCAX1gz/dsmvgkx8IqTiHNqmrQrC02eryezmYA4o
         9xy0LV5ejp/NzJj/SrrDfOJpcF5GQ7VeqkvLqtdel3U3AyhJ366/LZZqcwIc5eE1vWUD
         eleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744294614; x=1744899414;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UlZPMsmoVGB6t2rST7vEZ644AG6qFhEWTnum5nMbQnw=;
        b=sJ/uNG5IndrMM6pUeQfb5oOidPxt5OsMLEvlPzhi5eazSXRpX2dAHVYZIZLCWX94me
         S6JHXwpt3MyfZ05hP9APBMH0A51r/sSxSVjYypiVuccvYmA0x7RxUFCtqGR62YqW1dBr
         e2ieiqu0ZyxFrquKcAswhohVSu480B3dLfsgfjHTlnKyfoO+SgqKWVhPuQGwVThdXrd7
         L3C9rmKBRcu5S9FbBU0s3sUTjYoNS+QFGw4cyFMuw4KTJpf04rSNtD7Z9bMLPXkygIQI
         3eBypbAqWd+2QaWwEdZjlh+r6U57vVNkYcTsOSz6YHQN90Y+zAaXStcNbRuMYG8+Ll3D
         RcUA==
X-Gm-Message-State: AOJu0YxQEcgbOqPyufi8FrS5qK3buGNGSpddiyhNBDC0OT+wuFKk71tA
	392rNHcDSy5GXaeJ9X2iVyeZgknrm89HzYurPgiNyTGK0so9Hx3NDpKN6iriH4tG+eIpwc1IcCY
	oonKAqHjTr2M7exLJNWBYwuMwRGF5A9Zq4v1Qmb/GDmBSIZU=
X-Gm-Gg: ASbGncsKmSw0uuf8W3oLlj+b6BWl407V06sBsoOhMTyP7nKSbPiDItMht5FxrS8wFxO
	6jKQdUSsN3kkdbTX4H2mhMZOvVSasOicpnTUGOIpcY1a4/smluKP5pFhdniRBz/SlHDDxKN3+EI
	DlETcAZSp+pfI3fCKWii95bIFqshxLJh+atWGGU2D6ALrJyBNxYFL9aGotX88unUPwEtVXpYeXY
	UGFa/3fklg5+krBMjgVogwtU1JMYzT74w+ttB7ys8/TOIoydddBZaXH0AQUbNDCmLTmvF8fcLeL
	iMpLOBDgDi7RRilW3Vqeuyt68uwiC+XALoJG0ZoZ51kmgYtNouO5a/Xy4YvDzvotw75gr4VApso
	5
X-Google-Smtp-Source: AGHT+IEGkBT3acal4UyeSngNCtmRV8oa/MYqWgCOSt9yirlKqpb+QacYlcTKXCGRlIFeTs9Q7RldZQ==
X-Received: by 2002:a17:906:5653:b0:aca:c8aa:5899 with SMTP id a640c23a62f3a-acac8aa5e19mr58880066b.22.1744294614336;
        Thu, 10 Apr 2025 07:16:54 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:18b2:79f:732d:517c? ([2001:67c:2fbc:1:18b2:79f:732d:517c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1cb40e3sm279365366b.122.2025.04.10.07.16.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 07:16:53 -0700 (PDT)
Message-ID: <1d0f3363-1699-4d9b-93ba-fc9e38493e33@openvpn.net>
Date: Thu, 10 Apr 2025 16:16:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v25 00/23] Introducing OpenVPN Data Channel
 Offload
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>,
 steffen.klassert@secunet.com, antony.antony@secunet.com,
 willemdebruijn.kernel@gmail.com, David Ahern <dsahern@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Shuah Khan <skhan@linuxfoundation.org>
References: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
 <Z_fPzdq3PSw1efTW@krikkit>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z_fPzdq3PSw1efTW@krikkit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/04/2025 16:03, Sabrina Dubroca wrote:
[...]
> For the series:
> Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
> 
> Thanks again for your patience, Antonio.

Thank you (!) Sabrina for all the effort you've put during this long 
journey.
You've been of incredible help to the ovpn prototype and to me.

"And we're just getting started!"

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.



Return-Path: <netdev+bounces-50852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE737F749E
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 14:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 178EB1C20D2B
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 13:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6664B1CAAF;
	Fri, 24 Nov 2023 13:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="R/NCGz6A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B20F11F
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 05:12:03 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9fa2714e828so262424466b.1
        for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 05:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1700831522; x=1701436322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AJHJos/MKkmaxuQUOarNarE5ADwzWf0NrTDPJkxCgW4=;
        b=R/NCGz6AP3gHPkB4n+2IeCYlQobmwWDxQEF+VC/11p8xDE+vDvevomOZbJFwQu78E/
         UvubpBEN24udx4VkOWIsIa44syW3y5rn+Cpy935r4Hsq80JgyZm6LVRn75Y8Mab36KY1
         P0xXz5hDhNJjd4jr0JxdFBHZDBdbXpJP2PaVIVMKrg5+R0t4tQRs+VG0jiCULC0tOeRo
         4J/fE4/gDwxeEi2O2FDGPMn+KPjPJi8VmEY9YyNGsUZ7+vGPa/cLxscwfisfWucvV0BF
         9wnZQHAc4UD28LPlxs+IFHwHiH31kmSwrz6ST9FMej+Uqqz4A6e95KVBF2lgUaav9ThG
         Mgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700831522; x=1701436322;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AJHJos/MKkmaxuQUOarNarE5ADwzWf0NrTDPJkxCgW4=;
        b=vYFUPhEyFpPPvYZU+U5DwfYXeJ5kw218aThtgi5Tv5Ew+jw6Qb0oQUkI1cAzOjzRHD
         ZXBuSVp0S2Mecl1QD4fmHDe+V5Tbr1X5Hj7TjDkEw4zcEuw9M/hBV5gq8TwK73mkDEfh
         7OTt8m3wQPqsJrUVHq/EHdhDwfkgtGXkUkhonh2Krzv/DGsGVnk3SRvuJcaK2V5Qd7FH
         FTetjUvNCIr62A81t+UZr5bAe4OIH0tMqFrfXTShLajpCKjGW6JfW7UvOtxPXBrxtXkv
         hRIb13nXEpC4ZzzmgZjT5t58ihm5H8xiycJzxdV9miiravzfb+WKokOPpJPOxEsOMvOh
         9Ubw==
X-Gm-Message-State: AOJu0YxRlL9g48DOjmaPqM3NKZ8pqyBk1x6p2+9r5GlmAv7rHXi7kcEo
	Ic3mpdBsKfH9ObxHUcYWYqrHzA==
X-Google-Smtp-Source: AGHT+IELi5L3NUF5zWIffAnBMyk2kO+1j331p0K0QdU0EoCInCMaMQrXk0kvlXsEg8HN5wEC+6MWFw==
X-Received: by 2002:a17:906:fd4d:b0:a03:8cf4:8762 with SMTP id wi13-20020a170906fd4d00b00a038cf48762mr1880682ejb.37.1700831521875;
        Fri, 24 Nov 2023 05:12:01 -0800 (PST)
Received: from [192.168.0.106] (starletless.turnabout.volia.net. [93.73.214.90])
        by smtp.gmail.com with ESMTPSA id r17-20020a170906a21100b009ae57888718sm2025665ejy.207.2023.11.24.05.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 05:12:01 -0800 (PST)
Message-ID: <4f6e4b0b-d58b-902a-9f83-9d48a45cd7b3@blackwall.org>
Date: Fri, 24 Nov 2023 15:12:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCHv2 net-next 09/10] docs: bridge: add netfilter doc
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ido Schimmel <idosch@idosch.org>, Roopa Prabhu <roopa@nvidia.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Florian Westphal <fw@strlen.de>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Marc Muehlfeld <mmuehlfe@redhat.com>
References: <20231123134553.3394290-1-liuhangbin@gmail.com>
 <20231123134553.3394290-10-liuhangbin@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231123134553.3394290-10-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/23/23 15:45, Hangbin Liu wrote:
> Add netfilter part for bridge document.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>   Documentation/networking/bridge.rst | 36 +++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
> 

Good,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>




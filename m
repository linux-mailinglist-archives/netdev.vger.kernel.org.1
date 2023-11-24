Return-Path: <netdev+bounces-50848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2217F748F
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 14:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25D54B20EF5
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 13:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5181CAAF;
	Fri, 24 Nov 2023 13:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="x1iJwwnh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420D6D60
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 05:08:02 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54b0c7987easo116091a12.3
        for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 05:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1700831281; x=1701436081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ycEvB4nADbVSTsBtOgxqKC+DxyPjvcDYRYWNkGeLii4=;
        b=x1iJwwnhwX0EbZMPUYh5soiln+oHWL+GSuT5yPFWZUpyDoe78pqVIl+9HKkGN+CW29
         bbaYKUKUzxxKYAbzK2RZi9YnFQSwOC+bxMnRxo85ZjtDMND6lMseYR3L3se9UjOqX2W0
         BE/4gzJHnyfSqCmstGn3erP/hz3yfAUU782VTUSYqanDbUoAQgNOLY6QJq7Y4eVWNGPw
         klV87MkL1G0f7k2Yg94RvMjnt9EeqQUBu3fkvkgndVfmgfNP0eUZf2q15ZIoZY3Tr8Uk
         9lKegA2g4s73jaNE4j6+mM8F2dSvpcEvWxfVOwF0bZZEr/ls1JmCkGv4eGVPnqlBKzJe
         vRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700831281; x=1701436081;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ycEvB4nADbVSTsBtOgxqKC+DxyPjvcDYRYWNkGeLii4=;
        b=qXO078B0CsVFROolYYnrG8RrtkQ9Gvs0uCzpM2LoqeQTi8qTRghCiUhCciVrBsEWRD
         OyylWUduXxP8lH5yjskdkBM06zmERpbWynLaoWhheTo/SIWHGtyLNUPb1QAE3Vjhf8zn
         yQx3nG+vNLTqeZcddEOmZxi997HUyOSNjKfsiQ3wxhSoHgZ22+yXiWjAXiBYdnykKAq/
         MItGRoQKPU9j9HN6vJ3b/2JtMUfODLjFhqThM+pFFt1MiBDgSY+c7UCeLaUtNPhjn1qr
         tlsm3VOSDxizOGAAyIRVCeWRHkmqeYg3/9jAC2Cb7RF1oLSpT5oex1HM7K2WwQfLX+0k
         JLWQ==
X-Gm-Message-State: AOJu0YyAjiV7E/jZTW4yWeJ1ptp23FG0rKeVgLQ7xY9Ezfr0TGHsmMax
	F6CHYpeEwnKxFt7IeU1/uiNm/Q==
X-Google-Smtp-Source: AGHT+IG6cERNRSR6i70GisQIPLqY9o7fPNBzeo2U9Vy8d1VyF+2D0up5fFDG9TANPTdjEFt28Ct1jA==
X-Received: by 2002:aa7:de0e:0:b0:54a:fe99:1064 with SMTP id h14-20020aa7de0e000000b0054afe991064mr1336281edv.8.1700831274701;
        Fri, 24 Nov 2023 05:07:54 -0800 (PST)
Received: from [192.168.0.106] (starletless.turnabout.volia.net. [93.73.214.90])
        by smtp.gmail.com with ESMTPSA id e12-20020a50fb8c000000b0053e88c4d004sm1724717edq.66.2023.11.24.05.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 05:07:54 -0800 (PST)
Message-ID: <f9295a1f-26ef-16a3-1a5b-74dc48601186@blackwall.org>
Date: Fri, 24 Nov 2023 15:07:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCHv2 net-next 06/10] docs: bridge: add VLAN doc
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
 <20231123134553.3394290-7-liuhangbin@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231123134553.3394290-7-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/23/23 15:45, Hangbin Liu wrote:
> Add VLAN part for bridge document.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>   Documentation/networking/bridge.rst | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 

A good start. :)
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>




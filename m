Return-Path: <netdev+bounces-50853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B41F7F749F
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 14:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FC31B20FCC
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 13:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF1F282D6;
	Fri, 24 Nov 2023 13:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="hDcOMEHv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDD4D60
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 05:12:30 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9e1021dbd28so256343866b.3
        for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 05:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1700831549; x=1701436349; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5BsuWnrRcZkkgpQbsgya7ZwPbqHX9xbaQduqsiiJ6x4=;
        b=hDcOMEHv+mTRewOAL4yoz4VQcwk0R3fdumtqZ8tii+5XyX1jPL8EU06StDIIlXRvJF
         TxZlxEQvIuTalR4WrLxdKWVVLj4a6Cj/ZR16QqWh9xtO+2wO892uEaq8ss4cZGO502Aw
         jfP6o5MRx+mkQ+HzgPx9TqvZVfe7Bn+cKd5tGDDyku2Gyr4zQXTu2Fw+gfaWqm7HdkxD
         2zxA0pqQuhqvoDLBHMioti+NHiuhUbsmyJb+X0PhpSFadeaXKtOfxFW8f99CE3UBcwIC
         9Q2JRpJHsPKNRJ+hJG0ZCrwP1ud5RrPndAHCVAwjOCLkuY/L+9zqUJszBbp+SeWU8Rb2
         wW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700831549; x=1701436349;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5BsuWnrRcZkkgpQbsgya7ZwPbqHX9xbaQduqsiiJ6x4=;
        b=PirLFRskWc1k9ySqwN6E+gqvnzF/YuEXGrRaPUXdqnnk4dP8kSGghzVxNltyPntKcg
         ML/kgSdmiJCG8HIIpHJL4TzDyqhOYPEREg41RMYN+4/NbsBErcKgN3FQGBBpraB1iLmz
         8nHw/wmDNEEhxVCs4tncZO943qJyfmjvDW0WAs7fJFkWdv0dpbyseppLhuqGUkbrGLtX
         hEPZI0t3THF9h7Mwe7jkFdCbIiT1GJdNUPRvuewxJu8P6n+ytK0AMQs1pLxuAk1DS2G+
         17GNyBAKPtBsbBiLBa9vVJgE4zWTCYC8oCpKbuTrPOKxVr184sRH1qLiDH9LTFNAf7fy
         tAhQ==
X-Gm-Message-State: AOJu0Yz3gUoe/JWzh+A+/dMGVPAQoWlZq5BXj8+7kFtBDpZKsWX81BeV
	B3e1E9Jgzm6b/yffpPqhkHwZbw==
X-Google-Smtp-Source: AGHT+IG1XNv/St6TR2faGYpwyWwLdZhAS8Rcz0lbN5LBmVvkGGX/b/PgXPcZBmMTmgKiwxff+p7JWA==
X-Received: by 2002:a17:906:3386:b0:9b8:b683:5837 with SMTP id v6-20020a170906338600b009b8b6835837mr2215497eja.46.1700831549418;
        Fri, 24 Nov 2023 05:12:29 -0800 (PST)
Received: from [192.168.0.106] (starletless.turnabout.volia.net. [93.73.214.90])
        by smtp.gmail.com with ESMTPSA id mf12-20020a170906cb8c00b009a13fdc139fsm2045209ejb.183.2023.11.24.05.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 05:12:29 -0800 (PST)
Message-ID: <74f1034a-ee20-b887-e23a-83566e7403a3@blackwall.org>
Date: Fri, 24 Nov 2023 15:12:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCHv2 net-next 10/10] docs: bridge: add other features
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
 <20231123134553.3394290-11-liuhangbin@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231123134553.3394290-11-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/23/23 15:45, Hangbin Liu wrote:
> Add some features that are not appropriate for the existing section to
> the "Others" part of the bridge document.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>   Documentation/networking/bridge.rst | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
> index 772bbe28aefe..54118d9da2a4 100644
> --- a/Documentation/networking/bridge.rst
> +++ b/Documentation/networking/bridge.rst
> @@ -274,6 +274,20 @@ So, br_netfilter is only needed if users, for some reason, need to use
>   ip(6)tables to filter packets forwarded by the bridge, or NAT bridged
>   traffic. For pure link layer filtering, this module isn't needed.
>   
> +Other Features
> +==============
> +
> +The Linux bridge also supports `IEEE 802.11 Proxy ARP
> +<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=958501163ddd6ea22a98f94fa0e7ce6d4734e5c4>`_,
> +`Media Redundancy Protocol (MRP)
> +<https://lore.kernel.org/netdev/20200426132208.3232-1-horatiu.vultur@microchip.com/>`_,
> +`Media Redundancy Protocol (MRP) LC mode
> +<https://lore.kernel.org/r/20201124082525.273820-1-horatiu.vultur@microchip.com>`_,
> +`IEEE 802.1X port authentication
> +<https://lore.kernel.org/netdev/20220218155148.2329797-1-schultz.hans+netdev@gmail.com/>`_,
> +and `MAC Authentication Bypass (MAB)
> +<https://lore.kernel.org/netdev/20221101193922.2125323-2-idosch@nvidia.com/>`_.
> +
>   FAQ
>   ===
>   

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



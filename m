Return-Path: <netdev+bounces-50850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FA57F7497
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 14:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 515F01C20BF6
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 13:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FCC28695;
	Fri, 24 Nov 2023 13:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="DawqqtOT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471CC11F
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 05:11:12 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a0029289b1bso269856166b.1
        for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 05:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1700831471; x=1701436271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zZrX8N9P7nQS95hsgkRnvTq/mu6dTIqTvXfgAJ4Y/5o=;
        b=DawqqtOThwd54S5hApdaNzCwziu/9EUfqBX91yNDmGYJ1aQQpctiJ57LquXs+4IWzD
         q1uPAwyrOXxT2XLKd9y/laqGtMj97DEswgvWUwnGdTesGUGeVtMg1ExemCne15snnhIl
         qmwjftbkrrBScLdoWeBxyyYrYhT8qWNYCTtwz4UIlkYX62F2GRqsK3mRyZbF2FmomkhJ
         UkmRE7TLTv2u+ng9Kw21N+rF8Chxihz5ctA66RKnEfYZpYnKJ0aUsVFcuOA9wJjj2Qx7
         +De29iLUWp3/akibj7OxeglAuTpVmywbylXArdABI8JXgvzy9JxIPJ3VQarQ+B3+g661
         oYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700831471; x=1701436271;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zZrX8N9P7nQS95hsgkRnvTq/mu6dTIqTvXfgAJ4Y/5o=;
        b=lGQXIsTNEVAQVirNRiLiJ8HF6bgOW4EaeMnUlw5EHhP1SkZ3ZTO+/DFsHYUoSbHTrn
         k6EEEmqVZif4kBo+QYcU4WItotCRTLVUo2qps670scc3wZk7nTWAT7+VKqv7ELxzpOF3
         +PnVrdqyHfAbfkDHJCMlBFiFTUBurDMwu+clUiGJVeUg+HhZCuH/5fXV/0OZzMHSpRo+
         jNHOtXnU49G11/H0X6Uu2pLwm/z8gDec9ixu3VuIXc81deodeOQTqyfAOP9j625JyD3P
         cesRQA4O0d6sJqjRJVokRquLT4zcm8okavIi+2VBK/evAoSWnNjHwJHXUEPPk8DwF4Lx
         13QA==
X-Gm-Message-State: AOJu0YyAPXoA3Azzr0ZokTm/f7NhVBRWKprniew0Rk6H3Hss3gZN17+u
	glxwVx46rZQojj5h8ysFk4HbpA==
X-Google-Smtp-Source: AGHT+IEfWmnyy6taGAj851E9AR1+Fj8KbqyJUETf2FYFnxAwQyUsa1ZLmD8e79MC31hTxSy6mcDk6Q==
X-Received: by 2002:a17:907:7413:b0:9fd:a469:b367 with SMTP id gj19-20020a170907741300b009fda469b367mr1569223ejc.39.1700831470389;
        Fri, 24 Nov 2023 05:11:10 -0800 (PST)
Received: from [192.168.0.106] (starletless.turnabout.volia.net. [93.73.214.90])
        by smtp.gmail.com with ESMTPSA id v16-20020a1709067d9000b009fcb10eecb2sm2029668ejo.84.2023.11.24.05.11.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 05:11:10 -0800 (PST)
Message-ID: <0b2cddb9-7e7c-3826-8209-a084df7db977@blackwall.org>
Date: Fri, 24 Nov 2023 15:11:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCHv2 net-next 08/10] docs: bridge: add switchdev doc
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
 <20231123134553.3394290-9-liuhangbin@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231123134553.3394290-9-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/23/23 15:45, Hangbin Liu wrote:
> Add switchdev part for bridge document.
> 
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>   Documentation/networking/bridge.rst | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 

lgtm, I guess swdev people would have a lot more to add :)
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



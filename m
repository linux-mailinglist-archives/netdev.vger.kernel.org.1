Return-Path: <netdev+bounces-50849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6260A7F7494
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 14:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 937111C20A6B
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 13:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11CD286AC;
	Fri, 24 Nov 2023 13:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="OnYWc3gm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E2611F
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 05:10:15 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a04196fc957so278577666b.2
        for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 05:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1700831414; x=1701436214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fnu/5ikzAPrU6zwT28cYrDgRKtsDcq4MuqSVunjiDDI=;
        b=OnYWc3gmdXia/6IWqduN4xCVDoO3LN5eepQiUYZQzrmA1ZPlsWe6tYO5avAZoLHqDT
         s4/kL1GeWqay5gnvTP4+HKrsCa+V6n9P4UTGl7QOnVf39eWhUUdNHLlWPCCO65vd3tzf
         K//8i1G2cB+Y+FQJoEPFMFLz2NA9xTUonAJAs67SnaB1+2XKF7W3ApOB2taXDwAPt77W
         kvxic29ayQNWsoTWdukTRaXeXI9PqK6uagsh829gCr4zU2NpDrB1ej1QqsebZB/rqOCP
         mmo8BasYgKPFrGa5xK8LUY+CQTafuKsaRAjPaEx1yiD5eRHJH1gL18Y1UWSvmvI9WwL0
         7DBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700831414; x=1701436214;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fnu/5ikzAPrU6zwT28cYrDgRKtsDcq4MuqSVunjiDDI=;
        b=ArvEATQSLaR7WWo6WcW7QQU4vLJiz2dsmxVFiK8FjdtOJM4hvNsjO1J20jne/yufJx
         j00O50MWBiIzt6wnaI45yFH+vOOxD2iRq1G3CZtUtfbTo/k1U6qsQ7pTFfChU0fmWQI9
         ifVjj2vdJ+P+ebUeynUMKuuRD0XcG+KmufiCMygLXU1L8AzP2Dr+2SJofd96ZeAgd5Lu
         gADgli5LatNLX+6u3NyK/E09XfwQHFZZ2wI9bwzEAe2/9N5XNi+a/2jl7MrjYIsm0F1M
         ulSmn/TRLKZkr16fJGVNG2LukG1+XUi3sF2cqVVkcWHkAGBMgKpqurD/saJpm67DNb6B
         yNKQ==
X-Gm-Message-State: AOJu0YzEhW879aew998N5ZI6/lPKhml5mESf0hE8JqtU5DR0gHqQgnEU
	wzeGnanE136gSKCAYl/dAU3m3w==
X-Google-Smtp-Source: AGHT+IGDLUv+V92t3KHbPdlAvSu7DCOY2CMPAdxAZSEs7eaKNW5sBrIu4IcD+8Onb0Q8yoa42LIqxw==
X-Received: by 2002:a17:907:b011:b0:9bd:bbc1:1c5f with SMTP id fu17-20020a170907b01100b009bdbbc11c5fmr1746962ejc.35.1700831413707;
        Fri, 24 Nov 2023 05:10:13 -0800 (PST)
Received: from [192.168.0.106] (starletless.turnabout.volia.net. [93.73.214.90])
        by smtp.gmail.com with ESMTPSA id v10-20020a170906292a00b009be14e5cd54sm2039490ejd.57.2023.11.24.05.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 05:10:13 -0800 (PST)
Message-ID: <80dad3a4-4b8e-0a50-48ee-9eb44e686fb8@blackwall.org>
Date: Fri, 24 Nov 2023 15:10:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCHv2 net-next 07/10] docs: bridge: add multicast doc
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
 <20231123134553.3394290-8-liuhangbin@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231123134553.3394290-8-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/23/23 15:45, Hangbin Liu wrote:
> Add multicast part for bridge document.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>   Documentation/networking/bridge.rst | 55 +++++++++++++++++++++++++++++
>   1 file changed, 55 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>




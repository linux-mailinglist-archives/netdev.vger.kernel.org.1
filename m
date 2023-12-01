Return-Path: <netdev+bounces-52873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BF6800803
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 11:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4168C28252A
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 10:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7077A208C8;
	Fri,  1 Dec 2023 10:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="pv7zH4bL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B982C7
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 02:13:52 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50bc21821a1so2732991e87.0
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 02:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1701425630; x=1702030430; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7syhfJR+YIS2yn6iWJ6fgCLPtD3zXsOkdqoN0el3Ou0=;
        b=pv7zH4bLp3xxI4GhHwLUiIziNAiZyF0mLwlbHQSGi4bWwjQ/pS5GVMR2mTMPIc3ITZ
         munOuD3VnUDo10bbex0mBiifRtQZs6DMet8QQXfZi1deyJTWAwaO0k5IAhnbsbeq7Jm9
         uYPCtkX9xnSS1RxJZ0+IvD3mEt6AC1PSepsWtgQ1XvvCjUfv8Sj0plCHXPR0pBZiSbBi
         Z98psf4SR7sBeNv4Ciw1k/rRPSfIzvFCbSVFK4ZKGXo8JNQJ/sPEOsywvMwyoFxVtCW5
         eHCnLiHtaGGriwkdHz+SOG1QjDcAXreScVZIGWukQNTe9lVYooEApfNWasv2srVNEx/g
         JJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701425630; x=1702030430;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7syhfJR+YIS2yn6iWJ6fgCLPtD3zXsOkdqoN0el3Ou0=;
        b=SX9vw52Zw0Dp/NAMuJGZkGEonhu29zPeKLpjsz0c1ysHIEog4Zv4iaAGeYvAFrNm9B
         ASP6xyh7e4U9on+WU3KIvcrYad4WvSJ8W0Z3aGSx7QgtFqO6FHh4OyUkH6ikAi0qdswl
         g4TI8Qo4w50eOSMuxHimUIWikkSTFh7MPZoRZg4WrQfKBQrA96fNqURAIz5hvH8stUvw
         VIvvPpKOYEbF5k/IB9tT3Qocr9KhJUGDIN2Qf9eDgjKcna4/SH31pMm01jgdpOxjUUeC
         7+FkV3G/FVXbNdhcvGv4UrQrXPYPjjLrfZZmHfr/sGkvL+TUJal3b2viLIPD6+VhpH+a
         ifIw==
X-Gm-Message-State: AOJu0Yz7iyIUFs8vL4HoR76IAbo6fOAGLNOB52t+d+2uL0tclaeowpWV
	wKubaC/qVBvv7uP3fE/hWhcESQ==
X-Google-Smtp-Source: AGHT+IGdgmWjfzJsW2gt/5mZVCBGEtpahVng9qEREHx5B9TJWFIOyzBvH27bcDrXqpLTfhRQ5xWbtA==
X-Received: by 2002:ac2:5bc5:0:b0:50b:d764:8055 with SMTP id u5-20020ac25bc5000000b0050bd7648055mr582989lfn.136.1701425630117;
        Fri, 01 Dec 2023 02:13:50 -0800 (PST)
Received: from [192.168.0.106] (starletless.turnabout.volia.net. [93.73.214.90])
        by smtp.gmail.com with ESMTPSA id iv11-20020a05600c548b00b0040b4cb14d40sm8587747wmb.19.2023.12.01.02.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 02:13:49 -0800 (PST)
Message-ID: <45803994-19cf-0b4a-1863-26f09437e661@blackwall.org>
Date: Fri, 1 Dec 2023 12:13:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCHv4 net-next 03/10] net: bridge: add document for
 IFLA_BRPORT enum
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
References: <20231201081951.1623069-1-liuhangbin@gmail.com>
 <20231201081951.1623069-4-liuhangbin@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231201081951.1623069-4-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/1/23 10:19, Hangbin Liu wrote:
> Add document for IFLA_BRPORT enum so we can use it in
> Documentation/networking/bridge.rst.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>   include/uapi/linux/if_link.h | 241 +++++++++++++++++++++++++++++++++++
>   1 file changed, 241 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



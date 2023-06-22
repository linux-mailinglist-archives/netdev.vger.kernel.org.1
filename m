Return-Path: <netdev+bounces-13112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AED373A525
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 17:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12FCD28175B
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 15:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413FC1F949;
	Thu, 22 Jun 2023 15:35:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359341DCB0
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 15:35:18 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F56E42;
	Thu, 22 Jun 2023 08:35:17 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3111cb3dda1so8496146f8f.0;
        Thu, 22 Jun 2023 08:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687448115; x=1690040115;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h2TJoFECB6t4sqL5YMeSKcsMzE117N+yUh85Xr1fd2s=;
        b=e8Gnp3e5iDDRxhypYJgW24al9gM4HL/uwNlwSO7LTiylKH1j0xYeuTuWnvWghJRAs1
         et9/bg7DYUowP30XDwVQP8HeGB/oTmqPKQChAdG4x8+6nbGsWBPD5s/nEjDbIFq++BPF
         76I1QEB/tauxfGjqy6b3vzB+4gF+7tmGa6VNLDZuy9ThrCtxs21W6A1OCvQCuKy/JLCD
         og72tEYMiWvjyBiha8Lg/aK1O1kuYHFGQQVQ7Hu/Em1n6gYap76pR5rO37ZAQkIsGw7i
         B3yA1lvvB2a8v2iq0CLPV4EgzHLODAVHwvFYBBWC7sg5Otg9vQusxs5wfHrZXz8e0SKN
         SxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687448115; x=1690040115;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h2TJoFECB6t4sqL5YMeSKcsMzE117N+yUh85Xr1fd2s=;
        b=dHKcCz6ScmRtZZnt2E2C5dIlecL+Fjpw4IjVlikqkKlJyQbuo6ir8Pfrme/BcIun6q
         XEp6cyrKteDdG4GNnfMU+5aJNTDF2yEK67Cz44Y8NBMKOJVIA1NtN4Z7yLeiR926tsct
         1AlkJWciRDGkrIKkr69v9TRPo2q07LY9Y7VaU2L1sGjJqJQHkcHRtK07Cs9Z1fgFtD46
         hSJwFanjszf0uxhuz12J/z9P1oQiGoDakxmfOjgwaZ72pBlVvpfoko2Q7iKEgtgUdFGV
         EbMZFGL4iJciLTcJpRvj/jXPRHqFxB3XS2W81/4UJZ8x6ZyKGLliyRYtuT1C30FD+QHB
         dRiw==
X-Gm-Message-State: AC+VfDziuP66pxFFH7CJzscggO6PsgRq4vvwS8lEI8+7sQYL+bt3oIj/
	4zlIhXZ3C+j1aP/FGB+7LTU=
X-Google-Smtp-Source: ACHHUZ5HJlPGa7b2VV41grDvuNKRHkG1LFKz4exMX3PndFymwKCviwmChm3N/8fRLDwDK4lNKRx8Mg==
X-Received: by 2002:a5d:5348:0:b0:30e:5578:280c with SMTP id t8-20020a5d5348000000b0030e5578280cmr16852542wrv.67.1687448115207;
        Thu, 22 Jun 2023 08:35:15 -0700 (PDT)
Received: from [10.178.67.29] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id d4-20020a5d5384000000b003112b38fe90sm7316093wrv.79.2023.06.22.08.35.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 08:35:14 -0700 (PDT)
Message-ID: <639bb65e-26c2-529b-3371-90c3da5db05e@gmail.com>
Date: Thu, 22 Jun 2023 16:35:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [net-next PATCH] net: dsa: qca8k: add support for additional
 modes for netdev trigger
Content-Language: en-US
To: Christian Marangi <ansuelsmth@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Pavel Machek <pavel@ucw.cz>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230621095409.25859-1-ansuelsmth@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230621095409.25859-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/21/2023 10:54 AM, Christian Marangi wrote:
> The QCA8K switch supports additional modes that can be handled in
> hardware for the LED netdev trigger.
> 
> Add these additional modes to further support the Switch LEDs and
> offload more blink modes.
> 
> Add additional modes:
> - link_10
> - link_100
> - link_1000
> - half_duplex
> - full_duplex
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


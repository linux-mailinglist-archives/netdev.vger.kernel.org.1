Return-Path: <netdev+bounces-17556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AD8751FB5
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 13:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4F821C211F3
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 11:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB48810979;
	Thu, 13 Jul 2023 11:17:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD47010971
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 11:17:51 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CFA26A1
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 04:17:49 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbfcc6daa9so4924555e9.3
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 04:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689247068; x=1691839068;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jQg97wBXe3P0z07YZIHkWsGOthPp2ylFeuaEh8lcL5g=;
        b=fnT0JxbBGGoisk9+3XNkZZcv2SkvY8ojpQLL8pva71+onsqpaGXHZCsn7i2GLweYFl
         9hWiYrw/Ewjk7pN7/Q5hwbkTvrXVeCgpEx8J3oXbWljZqUkCGAKsyFQqygMikg04m1fF
         HgUD604I2qNi05XgZKtkc/j9dx+9YrXjRgGFlIay3w2t8ZeZghgJY4U6hMpzQvRy9aEU
         pFd6SdERn3qrw+qEe0NjSzxnPDGKR3nzV9EP8axpOz0aQio+chMOpTFEkvU36KgwV37o
         uqPYVo9RqPup0SGnN5xa4BZhhMvEhfjyispMYjYaPdLOG8gjoGPM5E1tCeNUjd/wd6Sp
         nEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689247068; x=1691839068;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jQg97wBXe3P0z07YZIHkWsGOthPp2ylFeuaEh8lcL5g=;
        b=O8znQULQJ2sIdihGfHZ9gvAzLDm/AzW8CP0iox5a1WQXEilKPgdz79u5tajpgdZEVt
         D8yYiIY9hhhlyI/v0rmKTR6SoDHtbjtSi18bKw665cpoQvPe3YCM5gVn835ZslF8Zybt
         bL/YaQpbi9j9qdozMDYrMznNtiY55PoplI5cGRhRMu31fdnEpjToe6k6lY9qSU+VTP7T
         Wkf52sPn4kjwQxMFI6UORS2qhZQnKr+RCt/F6Cc90DiPaJE1YJbyWPDVqkhyQpm0QldJ
         FtfRWo019JtWMAvpF4yjT2BoiIIjDpsF/aOkEVLYckyC3MmL7yg0PWGV0HQIJkIPlacQ
         /3uw==
X-Gm-Message-State: ABy/qLZRLU399C/kIi22LrnsS6zuWAb/CfmOZEC7NFBqkC1GQecnksim
	VVkflqeY+oivroS7BrUOPRRZZg==
X-Google-Smtp-Source: APBJJlH87+cyagSht4LdOPuIJ+1dwMis7Qky9NEDILlxQd4l8J85GnFiCzPwZ/cdZ2oAsxEtwt50HA==
X-Received: by 2002:a5d:5966:0:b0:313:ebbf:3696 with SMTP id e38-20020a5d5966000000b00313ebbf3696mr1098202wri.46.1689247068442;
        Thu, 13 Jul 2023 04:17:48 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id n2-20020a05600c294200b003fc17e8a1efsm7832235wmd.45.2023.07.13.04.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 04:17:48 -0700 (PDT)
Message-ID: <61ca392d-fbfb-2c1d-16ce-771193252e67@linaro.org>
Date: Thu, 13 Jul 2023 13:17:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 net-next 2/9] dt-bindings: net: mediatek,net: add
 mt7988-eth binding
Content-Language: en-US
To: Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Felix Fietkau <nbd@nbd.name>,
 John Crispin <john@phrozen.org>, Sean Wang <sean.wang@mediatek.com>,
 Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>, =?UTF-8?Q?Bj=c3=b8rn_Mork?=
 <bjorn@mork.no>, Florian Fainelli <f.fainelli@gmail.com>,
 Greg Ungerer <gerg@kernel.org>
References: <cover.1689012506.git.daniel@makrotopia.org>
 <6c2e9caddfb9427444307d8443f1b231e500787b.1689012506.git.daniel@makrotopia.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <6c2e9caddfb9427444307d8443f1b231e500787b.1689012506.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 13/07/2023 04:17, Daniel Golle wrote:
> Introduce DT bindings for the MT7988 SoC to mediatek,net.yaml.
> The MT7988 SoC got 3 Ethernet MACs operating at a maximum of
> 10 Gigabit/sec supported by 2 packet processor engines for
> offloading tasks.
> The first MAC is hard-wired to a built-in switch which exposes
> four 1000Base-T PHYs as user ports.
> It also comes with built-in 2500Base-T PHY which can be used
> with the 2nd GMAC.
> The 2nd and 3rd GMAC can be connected to external PHYs or provide
> SFP(+) cages attached via SGMII, 1000Base-X, 2500Base-X, USXGMII,
> 5GBase-R or 10GBase-KR.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

It does not look like you tested the bindings, at least after quick
look. Please run `make dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).
Maybe you need to update your dtschema and yamllint.

Beside that:
1. no underscores in property names.
2. Don't use syscon as an excuse for laziness. PLL is a clock, not syscon.

Best regards,
Krzysztof



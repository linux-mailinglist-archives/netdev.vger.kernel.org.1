Return-Path: <netdev+bounces-17778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7D0753075
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 06:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 071B31C214F3
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 04:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DC74A16;
	Fri, 14 Jul 2023 04:17:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29E4ED1
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 04:17:13 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1854C2699
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 21:17:11 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbc12181b6so14291845e9.2
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 21:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689308229; x=1691900229;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xB/IGZDPnnKzBMS/uR9nCWt1rTBAIheIt2NnWe/dYHI=;
        b=UNYIAl0vsymRIV81hpbAM66PgpgMTE89AFouUWLP1w1RraUDKL9AvjeiYIumNQwc29
         svyZaYTBvy/b1O7qxhoTGLCGlueRkm90gCIbBaj+ctopiT9P0fp4UaH/VdEkk8uBKNam
         pnoa7lhg4Re/qsnUu/tH8l/aRlpa3sYXkDZLiz49CID4eOdzRIcuZdWPPRltQ0XA5Jzo
         fUeH6GdsYvrJgdKZUzbsFcpXbR3kritk4CX7KtLt11FWVerJPuoNNMDGG96a/dRUXnP+
         SAAuKA3n14tOiSVYjJkH1almbhqT1yOXW5cQF/2UX+yq9CC6zUGeSf6yZw52IPaCruYU
         Uv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689308229; x=1691900229;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xB/IGZDPnnKzBMS/uR9nCWt1rTBAIheIt2NnWe/dYHI=;
        b=SJg+utqQAzKTmzjuBY6JfwKmW2TJVDfSS504G67xe+lat+IMPmaPx1EEs6YSJ0bLLq
         NlGJT9Tr7llCN0dL2+ROUT5m5LI+YBOVtKbM0YxAoNJul2/Blyv2EY0tJTKc/XIzuPn0
         cZb3eISOfrI5Y0jHvdfR1egFwlT0UGDTX9Xp8cyIx7d2bTzNvEezHQ6lLPltATq4kmzY
         en8iyZP6bX9emqi4O2HXq3S0DIXoehG4bcpQRmXBzFCQvxz+Y3NVDxLWm/iKRpzONzSE
         IiNk3ZY4PhtUxLyUwGDW0eEiBD0nt7fYg8dlCRcjXH/H7zrToVkGChBgpbPuf/DAI20n
         3Iew==
X-Gm-Message-State: ABy/qLbBkmJDeg+c0lQqRtXbRF3d+rDMFHIO8BED64xXPN9WVBnb6UPE
	W2R2qaJo8apEG+7JDfEf4ivTsA==
X-Google-Smtp-Source: APBJJlGMTT+Q4sPyu75nqGgHG+kkV8epB2p2rGKmjJwUcZIt6Tzxsk9RJHs91dM0VdrCYvMc8ap/lQ==
X-Received: by 2002:a1c:7c0b:0:b0:3fb:ce46:c0b3 with SMTP id x11-20020a1c7c0b000000b003fbce46c0b3mr3107048wmc.35.1689308229457;
        Thu, 13 Jul 2023 21:17:09 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id z16-20020a05600c221000b003fbaa2903f4sm480617wml.19.2023.07.13.21.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 21:17:08 -0700 (PDT)
Message-ID: <391132d5-de6b-8208-8996-bb3db250d9c4@linaro.org>
Date: Fri, 14 Jul 2023 06:17:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] dt-bindings: net: xilinx_gmii2rgmii: Convert to json
 schema
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Pranavi Somisetty <pranavi.somisetty@amd.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 michal.simek@amd.com, harini.katakam@amd.com, git@amd.com,
 radhey.shyam.pandey@amd.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20230713103453.24018-1-pranavi.somisetty@amd.com>
 <f6c11605-56d7-7228-b86d-bc317a8496d0@linaro.org>
 <a17b0a4f-619d-47dd-b0ad-d5f3c1a558fc@lunn.ch>
 <ebd30cd0-5081-f05d-28f7-5d5b637041e4@linaro.org>
 <cd0fb281-b621-4d6b-be94-be6095e35328@lunn.ch>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <cd0fb281-b621-4d6b-be94-be6095e35328@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 13/07/2023 21:30, Andrew Lunn wrote:
> On Thu, Jul 13, 2023 at 08:53:34PM +0200, Krzysztof Kozlowski wrote:
>> On 13/07/2023 17:59, Andrew Lunn wrote:
>>>>> +examples:
>>>>> +  - |
>>>>> +    mdio {
>>>>> +        #address-cells = <1>;
>>>>> +        #size-cells = <0>;
>>>>> +        phy: ethernet-phy@0 {
>>>>> +            reg = <0>;
>>>>> +        };
>>>>
>>>> Drop this node, quite obvious.
>>>
>>> Dumb question. Isn't it needed since it is referenced by phy-handle =
>>> <&phy> below. Without it, the fragment is not valid DT and so the
>>> checking tools will fail?
>>
>> No, because the example is compiled with silencing missing phandles.
> 
> Ah, thanks.
> 
> This is a rather odd device, there is no other like it in mainline, so
> i think having that PHY is useful, even if you think it is obvious
> what is going on here.

For almost all other devices in other subsystems we do not provides such
nodes. The "ethernet-phy" node should be obvious because nothing else is
expected to be in "phy-handle". However, if you find it useful, then I
am also fine with it.

Best regards,
Krzysztof



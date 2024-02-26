Return-Path: <netdev+bounces-74829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35258866B69
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 08:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEA432812EF
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 07:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917C21BF37;
	Mon, 26 Feb 2024 07:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bdaOx070"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEE91BDD8
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 07:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708934024; cv=none; b=p+TruYENrqK9ArKbrzxWGDIoS8l6rt/uXWpj9RpDBS4NnvolLNTDDoExb/5aH0dN9uw5/i8WTxDDS/8vgCrfHrIm/zu7OaYs+D4QLBb39gREDotITBmUR4OtLh5aXH4Ac6R9V5TFON1kxBIsl85HFWcBhNQ6dYdsjadn/BttMYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708934024; c=relaxed/simple;
	bh=jWrestbauhzJd0m8daFAKXgwLPZ8JR4s9F2fzNxtn0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mvl3yr3f7Wr0NnYAGN1fTbUiyvFzMuL5eUPHAU0rqj/GRaztWrDvJR3LjZNFLnWZdmbLF3AxkY5Yq0hqLYt+Lv/Hde9HVlWM5ZLmyitP/4DHOrd+RLDtCGgyCuE/fMDBQQry7937gVwig+D52ETbv0u3QQL76ZhoMlG7iYWB7Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bdaOx070; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so440180866b.2
        for <netdev@vger.kernel.org>; Sun, 25 Feb 2024 23:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708934021; x=1709538821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VVPGySiF1lkE5GOQxNpUv3vrBT/NdYoSVD5UYkQL3gI=;
        b=bdaOx070yrBv+VOJs3ooMU/BmwBmMFZ8EJF9MToVCnnF3DFWnFlbkFN4rxChvoQHIY
         s5PZ8dVdCN8TORPIxDodKCMEQ6PpyueLdq4Vkur0GBk18EvSTvNOYM6dOyvwAbJRW26J
         u8XbyFG+yKQDXKThg1OhvWd2pD+ChvktMlU3sJ+ZabJbhfwNCaLWEnoEyd0fvOZrLayq
         HnCdAYjcSwI6rtssxvoOzTkXyNqNwik9PXLmidSR4ApOxtFjjhXxu99H9Qi2G7yZO+pj
         C8eNUEQKk3Bl6la1POLuZiyGW2U1uYw2z8aHK2nD66skYQm8gPVT+dJO2iEogQDMpHEh
         aIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708934021; x=1709538821;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VVPGySiF1lkE5GOQxNpUv3vrBT/NdYoSVD5UYkQL3gI=;
        b=SFSsCNiYPN8ZAvRqYbCe6UXt0u05isoy92eve115YdYpAnR1I1z2Avg+BujOlDwk2g
         spo9lvFmAbo8bi6OIIaOUBH3goeAiukCmEdle3w4FPxsHf+QiQ7bKJrJEdBxzkDL5XH5
         D/mE8MhWQ0DWNkHHRLh53BLQYpNy3xiSsDm0JTd+5+Sp7ci+NPCKS6GbEGC/snyGdLq4
         4puFFAPOmgo83YTZjPAqZRZMT9vK93bwPZQKuPseWuX5NKQ2aNJ6q6EtHZ2ANAkpiEu5
         kL91X3zm/alpONEhelcdOkw8cy+6GQy5Pfdm2KJb5V4m5tcr0tpZkxExP1fI3k8MjUEu
         flWQ==
X-Gm-Message-State: AOJu0YxJdRhW/WFDSQvYV3LFExIP9wq3W4Y5q4yMQ2+E4OxDFQX+DvW3
	uQK7HwHHg+B15qvm2RcZ+SuWucobwBQhiKvXzPj3Y7qaHjfXKZzLx0IOrocwxeU=
X-Google-Smtp-Source: AGHT+IHmA7JsMe1/5wWQfv0WO8vf7gWHpLV/2iOPxtKcXlorJx/SnFXJ/VsQgfIUkWj8F7WGP5oYsw==
X-Received: by 2002:a17:906:2419:b0:a3e:f7ae:49b6 with SMTP id z25-20020a170906241900b00a3ef7ae49b6mr3644885eja.49.1708934020912;
        Sun, 25 Feb 2024 23:53:40 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id vg9-20020a170907d30900b00a42ec389486sm2115596ejc.207.2024.02.25.23.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Feb 2024 23:53:40 -0800 (PST)
Message-ID: <fefef6bb-16b3-4d50-aa3c-ec28848f1c00@linaro.org>
Date: Mon, 26 Feb 2024 08:53:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 4/6] dt-bindings: net: add
 hisilicon,hisi-femac
Content-Language: en-US
To: forbidden405@outlook.com, Yisen Zhuang <yisen.zhuang@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240222-net-v4-0-eea68f93f090@outlook.com>
 <20240222-net-v4-4-eea68f93f090@outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240222-net-v4-4-eea68f93f090@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/02/2024 13:43, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> Compared to previous txt based binding doc, the following changes are
> made according to the TRM:
> 
> - Remove unmaintained Hi3516 SoC, add Hi3798MV200
> - add MDIO subnode, because MDIO bus is integrated
> - add ahb bus clock, phy clock and reset
> 
> Also remove "hisi-femac-v1/2" binding.

Where?

> 
> The difference between versions is unknown and not documented anywhere.
> Nor is it used in driver. Remove it until it's needed in the future.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  .../bindings/net/hisilicon,hisi-femac.yaml         | 116 +++++++++++++++++++++
>  1 file changed, 116 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
> new file mode 100644
> index 000000000000..56d7c8a26d0c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml
> @@ -0,0 +1,116 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/hisilicon,hisi-femac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Hisilicon Fast Ethernet MAC controller
> +
> +maintainers:
> +  - Yang Xiwen <forbidden405@foxmail.com>
> +
> +allOf:
> +  - $ref: ethernet-controller.yaml
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - hisilicon,hi3798mv200-femac
> +      - const: hisilicon,hisi-femac

If you were re-designing schema, then this should be dropped. No generic
compatibles which even the author does not understand what it is.

But if you re-use existing binding, then it is a proof that previous
commit did something odd.

> +
> +  reg:
> +    items:
> +      - description: The first region is the MAC core register base and size.
> +      - description: The second region is the global MAC control register.
> +
> +  ranges:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 3
> +
> +  clock-names:
> +    items:
> +      - const: mac
> +      - const: macif
> +      - const: phy
> +
> +  resets:
> +    maxItems: 2
> +
> +  reset-names:
> +    items:
> +      - const: mac
> +      - const: phy
> +
> +  hisilicon,phy-reset-delays-us:
> +    items:
> +      - description: The 1st cell is reset pre-delay in micro seconds.

Drop redundant parts: "The 1st cell" and "micro seconds" and instead
describe something useful. You have here nine words out of which 7 are
redundant or not describing actual property and only two say something.
What is "reset pre-delay"? Explain this.

> +      - description: The 2nd cell is reset pulse in micro seconds.
> +      - description: The 3rd cell is reset post-delay in micro seconds.
> +
> +patternProperties:
> +  '^mdio@[0-9a-f]+$':
> +    $ref: hisilicon,hisi-femac-mdio.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - phy-connection-type
> +  - phy-handle
> +  - hisilicon,phy-reset-delays-us
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    ethernet@9c30000 {
> +        compatible = "hisilicon,hi3798mv200-femac", "hisilicon,hisi-femac";
> +        reg = <0x9c30000 0x1000>, <0x9c31300 0x200>;
> +        ranges = <0x0 0x9c30000 0x10000>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&clk_femac>,
> +                 <&clk_femacif>,
> +                 <&clk_fephy>;
> +        clock-names = "mac", "macif", "phy";
> +        resets = <&crg 0xd0 3>, <&crg 0x388 4>;
> +        reset-names = "mac", "phy";
> +        phy-handle = <&fephy>;
> +        phy-connection-type = "mii";
> +        // To be filled by bootloader
> +        mac-address = [00 00 00 00 00 00];
> +        hisilicon,phy-reset-delays-us = <10000 10000 500000>;
> +        status = "okay";

Didn't you receive feedback here already?

Best regards,
Krzysztof



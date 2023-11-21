Return-Path: <netdev+bounces-49738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 272F17F34DC
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 18:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA4ADB21320
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 17:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7095B1EC;
	Tue, 21 Nov 2023 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SF7s24De"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C26ABA
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 09:21:31 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c50cf61f6dso74741861fa.2
        for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 09:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700587290; x=1701192090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T9KhpseVCRqnVPX/aL5q95RXoXkoLm71yAXQWJbIK+o=;
        b=SF7s24De898iY4zEIQZrhXO4MoSjWWjm+BsusX0WCPy4+gX8XlYBL6VuAmBWnldOc+
         RYfKQAcn3yTZ4gAw81eFs9x2zOyQy5PO+d/o74i85/8LtdYLhqCLI/ERj594JMt90bKY
         lJC0CSz2xPOY4XBNbrYiccNMERuG/uRNlBSoSxNRzFOhHBHTAXg0l0TIr0CN+DvRxlb+
         ukGjMMgZ6/axzQXp7iHqNq1JI8xVSp6wZVcq7CBhd/fi4e4Osedioa6gweHJR94sNM1T
         eY2rb6Lw4wjVQ6u73iPpxqjc7kg0YVBZrD2Vpts1/Ntv46WqwJ4y56d1dXnuzpxe2/ug
         Qq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700587290; x=1701192090;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T9KhpseVCRqnVPX/aL5q95RXoXkoLm71yAXQWJbIK+o=;
        b=A30OR1aY5VdcgswUBtWniA5sJVUpfJPzabSazVpVy10Qy4MpgQiojCuBcA1h08Goyv
         ledY2KlT3HVLPkpqGiqw6gOsGNCNbw2BjoksOUoOE8CyqqLU7ydP5VC1zFhPR065LPrK
         8otJ3UlEjc2bx69wZLCcQ5bTmJ/8bP3qRookke9HIV3hZIWNUvMsR/oW+KpCEi4DFqez
         vIKLocvQ17i8Q8loEUE/jZW6cpj3rfbRTlH/YCx+HDFjyJy8xlfmi+lGJOU0T2k7h4up
         8+mcEs3VUxNGG+Nx9vGb9g97qfgf1qCQ1rSsLuTZyAFsLWXiZS01867HxHSL1nujdm3f
         CsnQ==
X-Gm-Message-State: AOJu0YxoTodXZQbScJqB4qMmI8/59jQpaE+Ws395eeVGc3RWQXmHMhnp
	YJDCsK5edj1nWqCc0mdewg/oag==
X-Google-Smtp-Source: AGHT+IF9rKdg29KmvbGoiol8+DcDTD5EhEIhgWEZouPowfRE16GQ2s4RCdQ19p304MnGowgbD3jCTw==
X-Received: by 2002:a2e:2a83:0:b0:2c8:2e3a:e974 with SMTP id q125-20020a2e2a83000000b002c82e3ae974mr7647015ljq.44.1700587289886;
        Tue, 21 Nov 2023 09:21:29 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.11])
        by smtp.gmail.com with ESMTPSA id x18-20020a05600c421200b00406443c8b4fsm21518854wmh.19.2023.11.21.09.21.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 09:21:29 -0800 (PST)
Message-ID: <8c1649b6-a9c8-4262-aa0d-5f073897ed0f@linaro.org>
Date: Tue, 21 Nov 2023 18:21:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: net: Add support NPCM dwmac
Content-Language: en-US
To: Tomer Maimon <tmaimon77@gmail.com>, davem@davemloft.net,
 edumazet@google.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 alexandre.torgue@foss.st.com, peppe.cavallaro@st.com, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com, avifishman70@gmail.com, tali.perry1@gmail.com,
 joel@jms.id.au, andrew@codeconstruct.com.au, venture@google.com,
 yuenn@google.com, benjaminfair@google.com, j.neuschaefer@gmx.net
Cc: openbmc@lists.ozlabs.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20231121151733.2015384-1-tmaimon77@gmail.com>
 <20231121151733.2015384-2-tmaimon77@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231121151733.2015384-2-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/11/2023 16:17, Tomer Maimon wrote:
> Add documentation to describe Nuvoton BMC NPCM dwmac driver(sgmii).
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../bindings/net/nuvoton,npcm8xx-sgmii.yaml   | 72 +++++++++++++++++++
>  .../devicetree/bindings/net/snps,dwmac.yaml   |  1 +
>  2 files changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/nuvoton,npcm8xx-sgmii.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/nuvoton,npcm8xx-sgmii.yaml b/Documentation/devicetree/bindings/net/nuvoton,npcm8xx-sgmii.yaml
> new file mode 100644
> index 000000000000..6a5f2cade7c9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/nuvoton,npcm8xx-sgmii.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/nuvoton,npcm8xx-sgmii.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton NPCM DWMAC SGMII Ethernet controller
> +
> +maintainers:
> +  - Tomer Maimon <tmaimon77@gmail.com>
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - nuvoton,npcm8xx-sgmii

This must be specific compatible, no wildcards. Then use the same for
filename.

> +  required:
> +    - compatible
> +
> +allOf:
> +  - $ref: snps,dwmac.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - nuvoton,npcm8xx-sgmii
> +          - const: snps,dwmac-3.50a

Blank line

> +  reg:
> +    items:
> +      - description:
> +          The first range represent DWMAC controller registers.

Keep it in one line and drop redundant "The first range represent".

> +      - description:
> +          The second range represent PCS configuration registers.
> +
> +  clocks:
> +    items:
> +      - description: GMAC main clock
> +
> +  clock-names:
> +    items:
> +      - const: stmmaceth
> +

Constrain also interrupts and resets.

> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/nuvoton,npcm845-clk.h>
> +
> +    ahb {
> +      #address-cells = <2>;
> +      #size-cells = <2>;

Your indentation is mixed. Use 4 spaces for example indentation.

> +
> +      gmac0: ethernet@f0802000 {

Best regards,
Krzysztof



Return-Path: <netdev+bounces-149579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A19A9E64B5
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 04:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F7B16A1FC
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 03:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04B617B502;
	Fri,  6 Dec 2024 03:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Afse77TG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2EE175BF;
	Fri,  6 Dec 2024 03:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733455190; cv=none; b=g4+GWIcdWPgY/lwWa/uaa9kzibAUshA60Yw+WV/s0ECoy/CSNXX+Pr6v0AMD6Ahe3SYXk2b4pHWeNocxlR6QIxm0xeVENDjmkvWZskqeoHq/n3N3GqwanPX+G9yuQzkSwTrOwC9Dx30xcJVVrJ57duoJI7eHBOIQfz+TV/2Wh/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733455190; c=relaxed/simple;
	bh=qPqQ+wNsjqTxctx8MISRF3Ki9z5d0UPs2JnHnsZDIn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VbdSqxcg3PXXQlMOnCtm0SkI5DmDcdi84fIBKtJw+tKFskKZcUrhkyIE1lJjXIB7RtLit3Nc9/RYEiTOQ3Kwg3roml3uC5GQwiM9rUHyBZK4tgAwhT/W3WlOds6LCJ8T6HKtgd8A4g5yHL28xjQ6AXQBn2nJ/kVCViyNbgOqYic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Afse77TG; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-215a0390925so16941825ad.0;
        Thu, 05 Dec 2024 19:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733455188; x=1734059988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o1J08d2GpR5DBDse4TbjdicR+imRnKLikvjMWBZLku0=;
        b=Afse77TGI0GWWXxk3d64mgUBlSz+LJ7HZ90GT5p1HpsyWSNeKXWLZlzF+yAY1zmQAQ
         j5LdQqAQXtsZRKUbK7s54VjV3sjL9XHHb0e4gGisP7gYEbC7sLsbgpraCQ89sJqUwXvj
         8Qph0IAeAEjB9q95sTUhovtp8fQpkN/UPuM9oQuyeSyhqWllhgvxznQ3i9xWy9P6ET5K
         76zkk2L8F9qxopQcs4HKm+XfJ/KzKxjteTQr/G8o/dUSU8TJILrOy8DfUGIBtOky1u02
         PyRTGa77VH/7M81/oyRZN8eRJs7PqpUq8NrDeK37TEYRqc3+jYsXgkzBKv1DHz889zmG
         AKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733455188; x=1734059988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o1J08d2GpR5DBDse4TbjdicR+imRnKLikvjMWBZLku0=;
        b=Jc02cGuLdoIFDKZWFmBdu9S65kPDnLtNfChFHc89fLbIejrPKrVykQWlExWGvlE/oH
         YIm2wlTpaipGSqLl1U4rWN5MUXEF86C8Eqxq/SBmntNKP/8Tfcj6/XV+C3761fxk2LOh
         ubf3NM8zKIl0TehEtT+zmnL2EYhu/eCYf/e2hZmJneoXFx7YW1qD4/egwXxqdDOdKPzU
         CtEW1OtjtiDP9Vxo4KsZYoRLgm59rNMLqFC+MxYzb5uL2h18QWf3FzQ9o4NpbxWFrHvQ
         3TlCrAkFeJ7izz5pMf4xMeYu9ahv1kQmtFTixNEs7CpEMAsl/QJkpPh37mhrGul96ifp
         nDQA==
X-Forwarded-Encrypted: i=1; AJvYcCWWPT7hPlQLsWXHNOMZC90lvKRCe7CouXzM7okoUfiDRvVcDfC4MOktQVso4VZjrirOjHs1GCaK@vger.kernel.org, AJvYcCWgRFG6B2zaKdWlQHlQVJrd+wJ0QYB/tlY14L/AM/IYz1eicOes0uqCKj4fwVLLUsDVlDaY14GxmHiJ@vger.kernel.org, AJvYcCWiTTmveouW0ADjcXtX2x4nO3m9Utzdy+3Oo2Z+6nQU2HQSFTpdqdp29ER+sXhjGZ8hn0ivbtDTbUP0q5uI@vger.kernel.org
X-Gm-Message-State: AOJu0YzSezoVfErTNCV6gXdDg57Out29bN/GTejBRlUYrssIjGoJjdFR
	eHqvau+FIrhnIV5KDbqCNPQa14BB03EfiXawfR9+AYzytVvbXSSafSdfmw==
X-Gm-Gg: ASbGnctEIAYAkeZkX+8Pp9xYKBoKR/evbxkx5Cb9yvKnx3Yr4Xm8FgvBMzwlRke33hc
	v003jOyj3r6N4P1WZnaFsFlYuH1XSgkAHmZ0nF9oOZv7Des+Ff0mM5MvhX3bxOarZ/BDq7Q/h/t
	91rYi92XCMqp/Lx9Ue25FB/U/6fEC3BS4Y6r0MyFgKaUsI1XJ9494+g00m+HrY+QRT8BES/qhoH
	LhJNrfaPv5tRg1mfjWpKBski/w+k/plwcqak/2wmv+agaNL/ojM5yaE37kO2JbDiqsM/Yi9PB+q
	qzT6O0oajn6FEaZquvRHvTD/e1SJ
X-Google-Smtp-Source: AGHT+IF785ewAXxfZzF45gbEj/3x8DTYf9enjYTZG3Qjck/WxskvwgRBw9uMc142aJEKW0klUE6onw==
X-Received: by 2002:a17:903:240a:b0:215:6816:6345 with SMTP id d9443c01a7336-21614d74ed8mr23832465ad.16.1733455188374;
        Thu, 05 Dec 2024 19:19:48 -0800 (PST)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21610638673sm5075265ad.271.2024.12.05.19.19.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 19:19:47 -0800 (PST)
Message-ID: <a04cd927-63cb-4271-bfc7-3ec97c5a978d@gmail.com>
Date: Fri, 6 Dec 2024 11:19:43 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] dt-bindings: net: nuvoton: Add schema for Nuvoton
 MA35 family GMAC
To: Rob Herring <robh@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, ychuang3@nuvoton.com,
 schung@nuvoton.com, yclu4@nuvoton.com, peppe.cavallaro@st.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com
References: <20241202023643.75010-1-a0987203069@gmail.com>
 <20241202023643.75010-2-a0987203069@gmail.com>
 <20241204142722.GA177756-robh@kernel.org>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <20241204142722.GA177756-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Rob,

Thank you for your reply.

Rob Herring 於 12/4/2024 10:27 PM 寫道:
> On Mon, Dec 02, 2024 at 10:36:41AM +0800, Joey Lu wrote:
>> Create initial schema for Nuvoton MA35 family Gigabit MAC.
>>
>> Signed-off-by: Joey Lu <a0987203069@gmail.com>
>> ---
>>   .../bindings/net/nuvoton,ma35d1-dwmac.yaml    | 134 ++++++++++++++++++
>>   .../devicetree/bindings/net/snps,dwmac.yaml   |   1 +
>>   2 files changed, 135 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml b/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
>> new file mode 100644
>> index 000000000000..e44abaf4da3e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
>> @@ -0,0 +1,134 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/net/nuvoton,ma35d1-dwmac.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Nuvoton DWMAC glue layer controller
>> +
>> +maintainers:
>> +  - Joey Lu <yclu4@nuvoton.com>
>> +
>> +description:
>> +  Nuvoton 10/100/1000Mbps Gigabit Ethernet MAC Controller is based on
>> +  Synopsys DesignWare MAC (version 3.73a).
>> +
>> +allOf:
>> +  - $ref: snps,dwmac.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - nuvoton,ma35d1-dwmac
>> +
>> +  reg:
>> +    maxItems: 1
>> +    description:
>> +      Register range should be one of the GMAC interface.
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: MAC clock
>> +      - description: PTP clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: stmmaceth
>> +      - const: ptp_ref
>> +
>> +  nuvoton,sys:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    items:
>> +      - items:
>> +          - description: phandle to access syscon registers.
>> +          - description: GMAC interface ID.
>> +            enum:
>> +              - 0
>> +              - 1
>> +    description:
>> +      A phandle to the syscon with one argument that configures system registers
>> +      for MA35D1's two GMACs. The argument specifies the GMAC interface ID.
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  reset-names:
>> +    items:
>> +      - const: stmmaceth
>> +
>> +  phy-mode:
>> +    enum:
>> +      - rmii
>> +      - rgmii
>> +      - rgmii-id
>> +      - rgmii-txid
>> +      - rgmii-rxid
>> +
>> +  tx-internal-delay-ps:
>> +    default: 0
>> +    minimum: 0
>> +    maximum: 2000
>> +    description:
>> +      RGMII TX path delay used only when PHY operates in RGMII mode with
>> +      internal delay (phy-mode is 'rgmii-id' or 'rgmii-txid') in pico-seconds.
>> +      Allowed values are from 0 to 2000.
>> +
>> +  rx-internal-delay-ps:
>> +    default: 0
>> +    minimum: 0
>> +    maximum: 2000
>> +    description:
>> +      RGMII RX path delay used only when PHY operates in RGMII mode with
>> +      internal delay (phy-mode is 'rgmii-id' or 'rgmii-rxid') in pico-seconds.
>> +      Allowed values are from 0 to 2000.
>> +
>> +  mdio:
>> +    $ref: /schemas/net/mdio.yaml#
> Drop. snps,dwmac.yaml already has this.
Got it.
>
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - interrupt-names
> Drop all 4. Already required by snps,dwmac.yaml.
Got it.
>
>> +  - clocks
>> +  - clock-names
>> +  - nuvoton,sys
>> +  - resets
>> +  - reset-names
>> +  - phy-mode
> Drop this one too.
Got it.
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
>> +    #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
>> +    ethernet@40120000 {
>> +        compatible = "nuvoton,ma35d1-dwmac";
>> +        reg = <0x40120000 0x10000>;
>> +        interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
>> +        interrupt-names = "macirq";
>> +        clocks = <&clk EMAC0_GATE>, <&clk EPLL_DIV8>;
>> +        clock-names = "stmmaceth", "ptp_ref";
>> +
>> +        nuvoton,sys = <&sys 0>;
>> +        resets = <&sys MA35D1_RESET_GMAC0>;
>> +        reset-names = "stmmaceth";
>> +
>> +        phy-mode = "rgmii-id";
>> +        phy-handle = <&eth_phy0>;
>> +        mdio {
>> +            compatible = "snps,dwmac-mdio";
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +
>> +            ethernet-phy@0 {
>> +                reg = <0>;
>> +            };
>> +        };
>> +    };
>> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>> index eb1f3ae41ab9..4bf59ab910cc 100644
>> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>> @@ -67,6 +67,7 @@ properties:
>>           - ingenic,x2000-mac
>>           - loongson,ls2k-dwmac
>>           - loongson,ls7a-dwmac
>> +        - nuvoton,ma35d1-dwmac
>>           - qcom,qcs404-ethqos
>>           - qcom,sa8775p-ethqos
>>           - qcom,sc8280xp-ethqos
>> -- 
>> 2.34.1

Thanks!

BR,

Joey



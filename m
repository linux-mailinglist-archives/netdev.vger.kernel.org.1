Return-Path: <netdev+bounces-142726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E91A59C020E
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 11:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A87281B5E
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 10:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAE61E0E19;
	Thu,  7 Nov 2024 10:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZwJVaoj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6502019ABCB;
	Thu,  7 Nov 2024 10:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730974559; cv=none; b=A3PsaJjRWUCgmjUjm6Az83n9L/P4nvLOk1R9XPsXG2N5bTfLxRypOw/bey1zFxNKZAgFTbXXK9whyqNmHVrmNeFNbo1R4AA4kty1mKNTsP5B051GbC+QMB6952q8bFqtlmVNd91qmsq+Hr+iHO9oTg5v3IosB4IEkOvPIqEdRc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730974559; c=relaxed/simple;
	bh=CLnyjHafwPfEPk6khrd+w+ls6AiJpgKD9HVj4fkhFVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tu9o33cGY+4ZpkTTnzK1xzub02ZCCqeGz1gZJWrl24SVPHAgP4xkAcHVevwoC8YdfG2bJc8AtosAtU+kcSoQVoalbf+IMtCv/xR9WxVEX+ExlDfXEC459ZfvVfBfRYLKXwmTsqW2oZQm/MWpRXM/shRMIDWn/APbRg8UoKfzG0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZwJVaoj; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cbca51687so7630735ad.1;
        Thu, 07 Nov 2024 02:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730974558; x=1731579358; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6uC1tGDKghOkea1zNnMHJyn2LWZSucub90BQiLOEDDk=;
        b=AZwJVaojM/oUAjaJ5jh+axr6JtCSO0Lg8TYoPuKqhyVALTofnnol31zFXtOVn7r0m1
         Anj2TPfzleEnUjsRoyJ9Sv2aKpiJ8Oh3cT83YVTwa0HPH1NVtYHXQXQCuTjJJFzVFluY
         mer811Gw5Uc+Ozuem4iwZHdOxuVYoDjJRu3IQCRDs1TBzURVxPGP/lFkf1QQj73tJs6p
         EIB+iCXATOVXcTOvf7TH8KX5wheN/fuWnNzoLLB2/0JL1eBWpnLLDe6RtFVdy8suJ2eh
         949SYhSR/rDIcNoPABnQNz7+ftyXXjx0GcvYVs42iNv+hrJRZsm5vJnht4OryoQNMF4E
         qtgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730974558; x=1731579358;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6uC1tGDKghOkea1zNnMHJyn2LWZSucub90BQiLOEDDk=;
        b=KErtGzURw28X84PadAF5ItKG/R577NZsbBzI++5FAjMbPsNyGXx2VLZe5sIWzi9F0t
         cfGavGcGP3QrPo+d/UWRHpDQtNhuMNIrwhVSXAb7N9ZVqMuweyDJkiUP3wk9ZsiEPImn
         EGi7bcUrSnPd8VFUu7N/67cv5wzLmdOnX9hL6z6RgcekLnzfaPNLsvBop9t+EzY4MA6c
         lWxT819dHtzhwxsuuKtAvrEW7BlU+aRzlSJ+Rfqrgerab8cp42NaVech2NOoRVCrok/R
         wUXw5enL1fyzM8qTu7oSO7iCeHFrzPnKSvSCrQwHz9GHrUgvUBGiahsHeL1f6I+w+yG8
         HWNw==
X-Forwarded-Encrypted: i=1; AJvYcCUIMip4CHsfdQGNBQTXKVAJWILCGyx4hRfur8ujeEiRs9tRgM5Tr0A/4R7fEvtzf2UXYfDYYfsR64bFA8Ix@vger.kernel.org, AJvYcCUkUzqKpdEbaOGYh1Ejt40dA0c0bFIBoRmc643pqn1pCpzdLXHBun6Wjb7ygSGoWYP+O4WG8Rnd+sY4@vger.kernel.org, AJvYcCWgf5IudBFtMDDNPz6TInAeNrp+dVuZPzC3g563gkzoCmQ1Asb5OVoDiMUrh/v5dLe+gGuPke4v@vger.kernel.org
X-Gm-Message-State: AOJu0YycvBIGaevWukvx9XOrhFsauGdzwLJPxvWw2+c2DbaxMlo+Y0bd
	ez4g8FkTRJSDTtvKoqNWFRnYgsjGbH5LAFPI6DCSA0+D2d3eqrlm
X-Google-Smtp-Source: AGHT+IG072GIpekpia0RPF6UHV7Q1vjZLLM17qv655ofL8si24CR7LuYWccsfVgbbHuGdYv/1tSAPA==
X-Received: by 2002:a17:902:9009:b0:20c:968e:4dcd with SMTP id d9443c01a7336-2111aec8494mr240923005ad.7.1730974557542;
        Thu, 07 Nov 2024 02:15:57 -0800 (PST)
Received: from [192.168.0.104] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177ddc940sm8817035ad.58.2024.11.07.02.15.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 02:15:57 -0800 (PST)
Message-ID: <7c2f6af3-5686-452a-8d8a-191899b3d225@gmail.com>
Date: Thu, 7 Nov 2024 18:15:51 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: net: nuvoton: Add schema for Nuvoton
 MA35 family GMAC
To: Conor Dooley <conor@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, ychuang3@nuvoton.com,
 schung@nuvoton.com, yclu4@nuvoton.com, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20241106111930.218825-1-a0987203069@gmail.com>
 <20241106111930.218825-2-a0987203069@gmail.com>
 <20241106-bloated-ranch-be94506d360c@spud>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <20241106-bloated-ranch-be94506d360c@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Conor,

Thank you for your reply.

Conor Dooley 於 11/6/2024 11:44 PM 寫道:
> On Wed, Nov 06, 2024 at 07:19:28PM +0800, Joey Lu wrote:
>> Create initial schema for Nuvoton MA35 family Gigabit MAC.
>>
>> Signed-off-by: Joey Lu <a0987203069@gmail.com>
>> ---
>>   .../bindings/net/nuvoton,ma35xx-dwmac.yaml    | 163 ++++++++++++++++++
>>   1 file changed, 163 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/net/nuvoton,ma35xx-dwmac.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/net/nuvoton,ma35xx-dwmac.yaml b/Documentation/devicetree/bindings/net/nuvoton,ma35xx-dwmac.yaml
>> new file mode 100644
>> index 000000000000..f4d24ca872b2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/nuvoton,ma35xx-dwmac.yaml
>> @@ -0,0 +1,163 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/net/nuvoton,ma35xx-dwmac.yaml#
> The filename needs to match the compatible.
I will fix it.
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
>> +# We need a select here so we don't match all nodes with 'snps,dwmac'
>> +select:
>> +  properties:
>> +    compatible:
>> +      contains:
>> +        enum:
>> +          - nuvoton,ma35d1-dwmac
>> +  required:
>> +    - compatible
>> +
>> +allOf:
>> +  - $ref: snps,dwmac.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    - items:
>> +        - enum:
>> +            - nuvoton,ma35d1-dwmac
>> +        - const: snps,dwmac-3.70a
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    minItems: 2
>> +    items:
>> +      - description: MAC clock
>> +      - description: PTP clock
>> +
>> +  clock-names:
>> +    minItems: 2
>> +    contains:
>> +      - enum:
>> +          - stmmaceth
>> +          - ptp_ref
> This can just be an items list like interrupt-names, since the clocks
> property has a fixed order.
I will fix it.
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  interrupt-names:
>> +    items:
>> +      - const: macirq
> This name carries no information, this is an interrupt for a mac after
> all. You don't need a name since you only have one interrupt.
This interrupt name is an argument required by the stmmac driver to 
obtain interrupt information.
>> +  nuvoton,sys:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description: phandle to access GCR (Global Control Register) registers.
> Why do you need a phandle to this? You appear to have multiple dwmacs on
> your device if the example is anything to go by, how come you don't need
> to access different portions of this depending on which dwmac instance
> you are?
On our platform, a system register is required to specify the TX/RX 
clock path delay control, switch modes between RMII and RGMII, and 
configure other related settings.
>> +  resets:
>> +    maxItems: 1
>> +
>> +  reset-names:
>> +    items:
>> +      - const: stmmaceth
>> +
>> +  mac-id:
>> +    maxItems: 1
>> +    description:
>> +      The interface of MAC.
> A vendor prefix is required for custom properties, but I don't think you
> need this and actually it is a bandaid for some other information you're
> missing. Probably related to your nuvoton,sys property only being a
> phandle with no arguments.
This property will be removed.
>> +
>> +  phy-mode:
>> +    enum:
>> +      - rmii
>> +      - rgmii-id
>> +
>> +  tx_delay:
> Needs constraints, a type, a vendor prefix and a unit suffix. No
> underscores in property names either. See the amlogic dwmac binding for
> an example.
I will fix it.
>> +    maxItems: 1
>> +    description:
>> +      Control transmit clock path delay in nanoseconds.
>> +
>> +  rx_delay:
> Ditto here.
I will fix it.
>
>> +    maxItems: 1
>> +    description:
>> +      Control receive clock path delay in nanoseconds.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - interrupt-names
>> +  - clocks
>> +  - clock-names
>> +  - nuvoton,sys
>> +  - resets
>> +  - reset-names
>> +  - mac-id
>> +  - phy-mode
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
>> +    #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
>> +    //Example 1
>> +    eth0: ethernet@40120000 {
> The eth0 label is not used, drop it.
The label is used in dtsi and dts.
>> +        compatible = "nuvoton,ma35d1-dwmac";
>> +        reg = <0x0 0x40120000 0x0 0x10000>;
>> +        interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
>> +        interrupt-names = "macirq";
>> +        clocks = <&clk EMAC0_GATE>, <&clk EPLL_DIV8>;
>> +        clock-names = "stmmaceth", "ptp_ref";
>> +
>> +        nuvoton,sys = <&sys>;
>> +        resets = <&sys MA35D1_RESET_GMAC0>;
>> +        reset-names = "stmmaceth";
>> +        mac-id = <0>;
>> +
>> +        clk_csr = <4>;
> This property is not documented.
This unused property will be removed.
>
> Cheers,
> Conor.
>
>> +        phy-mode = "rgmii-id";
>> +        phy-handle = <&eth_phy0>;
>> +        mdio0 {
>> +            compatible = "snps,dwmac-mdio";
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +
>> +            eth_phy0: ethernet-phy@0 {
>> +                reg = <0>;
>> +            };
>> +        };
>> +    };
>> +
>> +  - |
>> +    //Example 2
>> +    eth1: ethernet@40130000 {
>> +        compatible = "nuvoton,ma35d1-dwmac";
>> +        reg = <0x0 0x40130000 0x0 0x10000>;
>> +        interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
>> +        interrupt-names = "macirq";
>> +        clocks = <&clk EMAC1_GATE>, <&clk EPLL_DIV8>;
>> +        clock-names = "stmmaceth", "ptp_ref";
>> +
>> +        nuvoton,sys = <&sys>;
>> +        resets = <&sys MA35D1_RESET_GMAC1>;
>> +        reset-names = "stmmaceth";
>> +        mac-id = <1>;
>> +
>> +        clk_csr = <4>;
>> +        phy-mode = "rmii";
>> +        phy-handle = <&eth_phy1>;
>> +        mdio1 {
>> +            compatible = "snps,dwmac-mdio";
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +
>> +            eth_phy1: ethernet-phy@1 {
>> +                reg = <1>;
>> +            };
>> +        };
>> +    };
>> -- 
>> 2.34.1

Thanks!

BR,

Joey



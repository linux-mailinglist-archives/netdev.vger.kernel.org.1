Return-Path: <netdev+bounces-251744-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yE4MGXBGcGnXXAAAu9opvQ
	(envelope-from <netdev+bounces-251744-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:22:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CA169505D2
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05AFB4E5086
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1923570C4;
	Wed, 21 Jan 2026 03:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiBNDyLm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D16335066
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 03:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768965733; cv=none; b=O5dZFvJwhPiZ8pol/RNQc8LnhNVIan1fgjQDpnTuX5wCc0KKWQhOlQILPvozaHGEUqj1z+2iZiTdPwn8VWJ3ykqHwswXBjBi77ZF0E9SCmM7mTK2wzEJu3t5O8RhmPJyATt+aC3eqL2JCnjGfQacSyCjU3rZsngYfu7mq6pIrp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768965733; c=relaxed/simple;
	bh=Js3T4IvOaXPj4fPOtMtJbaWGL24WVy0ZxTTlddVnvJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IUoFdfaIjuvJ2IQEhE25ft0gTY/nLKhqMK/+gExLDRktyhauk9ncPtwirgJZx6NUtz3EsDevbODjV7AI6wsEtf0EvqGeCWUFzh3/WMxvzFoRNUy85yFtV43C/JOKvr9Uv+opOFVFZ+Dj9NXru1IlTUIgf6RTX7FE2hRKH3Dh00Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fiBNDyLm; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-81f4c0e2b42so3167688b3a.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 19:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768965730; x=1769570530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=17+DNkkNcmMDigIJBL8XgDaqQaWKVbdBHFS6qgPE1RU=;
        b=fiBNDyLmBKQT9W4Mop06iQfKJ6IkuCsCLfceil7HV3XN/0H4cqiZfoTEQETVDnYP9u
         VQKdKzHyjz8+pbUKMfdgD2zu0qeKln0oSb5DYhq7Djih6za8s7Mt5sUmzSeWQ3hVdJBx
         NtchlpzjY9OuvvWtMw0WzyON8yu0bdPVql/j/ZpNzA3qvBJHb3olyXm9bKcTuHGWSVQ6
         EQSC4Oslm644OWmbqyisi4ahAq6d6S6ba7AFI3qjTFAj3tGGF/fyFXwGchaJ8OvhqMs8
         93jw+NYjiEWVT7GzijKhE2DcNTdA10oVvVdpFdA/Y2IIOHwwG0ON2vzZinBILQsy75aU
         JbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768965730; x=1769570530;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=17+DNkkNcmMDigIJBL8XgDaqQaWKVbdBHFS6qgPE1RU=;
        b=mw7+/zdbnIDi4TN1heRalqGogiCcn9x8B9rlSLeAxjVXK/QgqNY9StcxGgM85I7r9F
         zyUdWtU4fhxZ7TLpa8FnUkc88hRZQY4507lYnNfkv9kf9NMkOnUE6Kso7ZXOcqqzGZ5D
         ILzvuLcrnNqEuQ78nOBbvYBxopHvVRi2yfBwSObOHIRHxhzFm2CLFqBrt7JYpS9WfH0h
         Q/a8UoKib9jzC70lj2w+8HuHQsrKV9FF61J3AP8iuNvrGt2CY44Z+RVk6afyNDMC86pX
         Hw6i6Q1Zm057BVVESzPiCpXNiFRQzRycoJktu2tgWD1OvuvpfbU6alGXosJ9LZrSaM3p
         SHtA==
X-Forwarded-Encrypted: i=1; AJvYcCX/Zgkeebmrjgmj2vQtsbwQam5LH685PDAS5jiqDlAApIV0t2H0avTQU5DX8WpU7XBraNrfNj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZkJRzjiVjPgnb2NpAVBfuhyMG8RI7LDOTMbgTkLs7sLmu1/p2
	QGqU1BAhqDv639tYC1cMOlV4mO7kXrRw6A/dUtKSaBy8WVzS2y6GVFC9
X-Gm-Gg: AZuq6aI8bQcxHpWjcxqtURJ2P8AvN/MpxGdtq6cGC5vBu1/jIXPWaSTtKXK9OEKF/NK
	KUAg4DQUeeJIIuTc8RQs+NLXYpWb25DhbHoDGMqeAG3fkNu6YcqCPjEOQGX+tNU6gMXzxij9wCL
	I/nEkcWcdKiEkKvyQaS6fup5C0eu+6kFrTBYEohjvk4ZZjpmPVrs1sp1grb/KaUmrOK/bN7kGve
	cElkWcrABYYNU51CBVpz83N/sA+20FKr9wzCXTnoaFQQK4IiX+eTol3GqrIZFiyuBFOXvs4lW2j
	2qNQKyLSyJq9v7pONIf9c0N6k3aWO33G9hC7adKymZQ3MOuc0IV7loqcJdHu2zNL82v8o31eM5M
	u6vxNbqiBdo6wPpP6K5TLpWpLT/WZyxasS9VO3amqcDHKTewkHQog1cYA7dkJv7KCQHoKn/8LFK
	S1TP+B0DSWLugq+LeJk9OMYZlY3KRMLUDrDkDltTt5iGIGncFn6JrZnhMHRyMkj8a7
X-Received: by 2002:aa7:888b:0:b0:81e:81fb:b392 with SMTP id d2e1a72fcca58-81fe87db4bamr3212275b3a.11.1768965730358;
        Tue, 20 Jan 2026 19:22:10 -0800 (PST)
Received: from [192.168.0.102] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1291135sm13268978b3a.47.2026.01.20.19.22.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 19:22:10 -0800 (PST)
Message-ID: <7a43bedf-6d31-4ae1-b2c6-97cb3757ad9f@gmail.com>
Date: Wed, 21 Jan 2026 11:22:03 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 1/3] dt-bindings: net: nuvoton: Add schema for
 Nuvoton MA35 family GMAC
To: Rob Herring <robh@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, ychuang3@nuvoton.com,
 schung@nuvoton.com, yclu4@nuvoton.com, peppe.cavallaro@st.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com
References: <20260119073342.3132502-1-a0987203069@gmail.com>
 <20260119073342.3132502-2-a0987203069@gmail.com>
 <20260121020728.GA1671298-robh@kernel.org>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <20260121020728.GA1671298-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,synopsys.com,nuvoton.com,st.com,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,st-md-mailman.stormreply.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251744-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a0987203069@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[2.100.46.192:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,0.0.0.0:email,nuvoton.com:email]
X-Rspamd-Queue-Id: CA169505D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Rob Herring 於 1/21/2026 10:07 AM 寫道:
> On Mon, Jan 19, 2026 at 03:33:39PM +0800, Joey Lu wrote:
>> Create initial schema for Nuvoton MA35 family Gigabit MAC.
>>
>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>> Signed-off-by: Joey Lu <a0987203069@gmail.com>
>> ---
>>   .../bindings/net/nuvoton,ma35d1-dwmac.yaml    | 126 ++++++++++++++++++
>>   .../devicetree/bindings/net/snps,dwmac.yaml   |   1 +
>>   2 files changed, 127 insertions(+)
>>   create mode 100755 Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
> This should not be executable.
>
> Rob
Thanks for catching this.

I will fix the file mode in the next revision.

Joey

>> diff --git a/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml b/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
>> new file mode 100755
>> index 000000000000..8eaddfdc937c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
>> @@ -0,0 +1,126 @@
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
>> +required:
>> +  - clocks
>> +  - clock-names
>> +  - nuvoton,sys
>> +  - resets
>> +  - reset-names
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
>> +            eth_phy0: ethernet-phy@0 {
>> +                reg = <0>;
>> +            };
>> +        };
>> +    };
>> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>> index dd3c72e8363e..10cb5e555750 100644
>> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>> @@ -69,6 +69,7 @@ properties:
>>           - ingenic,x2000-mac
>>           - loongson,ls2k-dwmac
>>           - loongson,ls7a-dwmac
>> +        - nuvoton,ma35d1-dwmac
>>           - nxp,s32g2-dwmac
>>           - qcom,qcs404-ethqos
>>           - qcom,sa8775p-ethqos
>> -- 
>> 2.43.0
>>


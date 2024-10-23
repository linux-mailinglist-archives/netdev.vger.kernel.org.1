Return-Path: <netdev+bounces-138431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C355E9AD88E
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 01:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E40A31C21820
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 23:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06B41FEFA4;
	Wed, 23 Oct 2024 23:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="RF0A4JEh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083231A08DF
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 23:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729726897; cv=none; b=HArmTHfkoq5Vm80m2i4Cipr4TgRHIbyNks03Cr4y+aH/yoL4D2ZABVmNrayYgdZmQ+fLXJZdjlpjz6PXvobr2/FOu9CakEnAhlYanAgRb+UFgb55JJbN2OS1zVfpT0kFgPVW8VlzZTk7xUb3enwsf/0rFoYh1iYGVb0Dji19t/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729726897; c=relaxed/simple;
	bh=OHH+9AiQirB+dOyiwIMPVlTShOnN7SWnulXQ+fk22iw=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U2lYo1GsAeJp9TLL3lYs/EJ3WJY/bJJNVr6P0kkwDEEtQMkRf2E3C/MF7SvQhDJJblS1iM+aJV78PdiVpWOLFcSnVC5u8mMh+gaR3vWcd1fKa6lpuL+B0W9yamodSlCikSAmBBw74Olt5pZ9886FU+QyoyQSUNocDCiY55f9zyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=RF0A4JEh; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A88483F458
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 23:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1729726890;
	bh=3PGQu02YnHPlZo11QYKayLhqc6TqDv+KCeQ0Xgfz3C4=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=RF0A4JEhv4fQi8Q/4ca7vHqBrqF1I01GzTTSSRD9kseDfap9qNtRdBIWobry9259j
	 AeViUjXLJbPuR22jwguGXjOO/IrQzLXaJer7WrZGGtM8/wXVoPeGkscR1t/Czmdc02
	 QMkUbYqjrU9E5z0G7P+sr0YVlmREoYG7t5JI5Q1XZGqHvB13ARpaGASIX08rcXnHzR
	 wsJrQFjUz4pOG4Tay6OrtFB3G1ahEOJOQnDDunQmN9Ljavc2wes+PAOedsIXYNkatB
	 s7syojT0Wd14M+CQ3+Cfp8CAfpRjUM7jzuYix+ZIYE7DJkdxez+9FdiMNNgtrK4N7K
	 GaIETST73euGA==
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5eb7e223383so210859eaf.0
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 16:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729726889; x=1730331689;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3PGQu02YnHPlZo11QYKayLhqc6TqDv+KCeQ0Xgfz3C4=;
        b=UasywNg0XbqL2la3ecUl5pKuS4vpaaH4lv2D0eAbHtvsxj8nIIf70lKEnVXQMc5Zsv
         LnttIdrwyBJ28+M409Smcb1rGRoZE2zCN8eqXFcjXdgr5PAo3sCoE/RQNxAZad73pfeD
         XPK7Crey8Up0aO2/065bTZLMpvK9gjwl9OXN9G//nRC97Kl6by3BHP+/JeeHtFF0yBIp
         p/SbKDU48DGbeH4T8U89EuuKu7dVaSjkN0M61Jv0cAhzK728q39fUyd8UBDEy+lQxzuX
         GxkdD8lHOIyM/OBc48syifQlcCrdyM+wI8b4dSji6TUgS4re+Houk4p2T4RGRHqSCrzS
         GfNw==
X-Forwarded-Encrypted: i=1; AJvYcCUrDwQkB3k5NZna7qrEKO9W3GjaCHCkHKOn7ItJNPIkRPaEugg8OaudneIrsjUfk7Xun+eeyE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwffvftlnTTmkgLBqA62lkDUCg0+2ZF+r+JXm5OCEneda+Z3YEY
	O6VMCUNQLQtwGhVz0xI038Bya0pYikY1lp4I/h2AdqGLnFk+7BiPcV2Ljm/XZr+YjkBQTQtHCFU
	CgwvOQfrrUdWJvXECBHggd0JJYUTuTDCQOiVW2coVyTCp8Gb2CyBhduCC/TDNCvKpBbP9q3VmpA
	vjFzCw7qA32XK7ewLKc5UG7oP8I/z0LfsT55HT6Fr7cVY4
X-Received: by 2002:a05:6870:a2d4:b0:288:50aa:7714 with SMTP id 586e51a60fabf-28ccb83f8b8mr4707243fac.24.1729726889084;
        Wed, 23 Oct 2024 16:41:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmoFBHnCYHUIGE5FQoeW7XP6jvjOogMHggvGexa+v1/qSORAbovEejIXVxUVEWGhexV1ySLJ9KlbQa+3yyW4Y=
X-Received: by 2002:a05:6870:a2d4:b0:288:50aa:7714 with SMTP id
 586e51a60fabf-28ccb83f8b8mr4707213fac.24.1729726888692; Wed, 23 Oct 2024
 16:41:28 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Oct 2024 19:41:28 -0400
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20241021103617.653386-3-inochiama@gmail.com>
References: <20241021103617.653386-1-inochiama@gmail.com> <20241021103617.653386-3-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Wed, 23 Oct 2024 19:41:28 -0400
Message-ID: <CAJM55Z8SnjQFui0J2hOD34HmBsGqZfxn8e_KAWhXxiqswqv6Ww@mail.gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: net: Add support for Sophgo SG2044 dwmac
To: Inochi Amaoto <inochiama@gmail.com>, Chen Wang <unicorn_wang@outlook.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Inochi Amaoto <inochiama@outlook.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Yixun Lan <dlan@gentoo.org>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Inochi Amaoto wrote:
> The GMAC IP on SG2044 is almost a standard Synopsys DesignWare MAC
> with some extra clock.
>
> Add necessary compatible string for this device.
>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  .../devicetree/bindings/net/snps,dwmac.yaml   |   1 +
>  .../bindings/net/sophgo,sg2044-dwmac.yaml     | 145 ++++++++++++++++++
>  2 files changed, 146 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
>
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index 3c4007cb65f8..69f6bb36970b 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -99,6 +99,7 @@ properties:
>          - snps,dwmac-5.30a
>          - snps,dwxgmac
>          - snps,dwxgmac-2.10
> +        - sophgo,sg2044-dwmac
>          - starfive,jh7100-dwmac
>          - starfive,jh7110-dwmac
>
> diff --git a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> new file mode 100644
> index 000000000000..93c41550b0b6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> @@ -0,0 +1,145 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/sophgo,sg2044-dwmac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH7110 DWMAC glue layer

I think you forgot to change this when you copied the binding.

/Emil

> +
> +maintainers:
> +  - Inochi Amaoto <inochiama@gmail.com>
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - sophgo,sg2044-dwmac
> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: sophgo,sg2044-dwmac
> +      - const: snps,dwmac-5.30a
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: GMAC main clock
> +      - description: PTP clock
> +      - description: TX clock
> +
> +  clock-names:
> +    items:
> +      - const: stmmaceth
> +      - const: ptp_ref
> +      - const: tx
> +
> +  sophgo,syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to syscon that configures phy
> +          - description: offset of phy mode register
> +          - description: length of the phy mode register
> +    description:
> +      A phandle to syscon with two arguments that configure phy mode.
> +      The argument one is the offset of phy mode register, the
> +      argument two is the length of phy mode register.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - interrupt-names
> +  - resets
> +  - reset-names
> +
> +allOf:
> +  - $ref: snps,dwmac.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: sophgo,sg2044-dwmac
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 1
> +          maxItems: 1
> +
> +        interrupt-names:
> +          minItems: 1
> +          maxItems: 1
> +
> +        resets:
> +          maxItems: 1
> +
> +        reset-names:
> +          const: stmmaceth
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    ethernet@30006000 {
> +      compatible = "sophgo,sg2044-dwmac", "snps,dwmac-5.30a";
> +      reg = <0x30006000 0x4000>;
> +      clocks = <&clk 151>, <&clk 152>, <&clk 154>;
> +      clock-names = "stmmaceth", "ptp_ref", "tx";
> +      interrupt-parent = <&intc>;
> +      interrupts = <296 IRQ_TYPE_LEVEL_HIGH>;
> +      interrupt-names = "macirq";
> +      resets = <&rst 30>;
> +      reset-names = "stmmaceth";
> +      snps,multicast-filter-bins = <0>;
> +      snps,perfect-filter-entries = <1>;
> +      snps,aal;
> +      snps,tso;
> +      snps,txpbl = <32>;
> +      snps,rxpbl = <32>;
> +      snps,mtl-rx-config = <&gmac0_mtl_rx_setup>;
> +      snps,mtl-tx-config = <&gmac0_mtl_tx_setup>;
> +      snps,axi-config = <&gmac0_stmmac_axi_setup>;
> +      status = "disabled";
> +
> +      gmac0_mtl_rx_setup: rx-queues-config {
> +        snps,rx-queues-to-use = <8>;
> +        snps,rx-sched-wsp;
> +        queue0 {};
> +        queue1 {};
> +        queue2 {};
> +        queue3 {};
> +        queue4 {};
> +        queue5 {};
> +        queue6 {};
> +        queue7 {};
> +      };
> +
> +      gmac0_mtl_tx_setup: tx-queues-config {
> +        snps,tx-queues-to-use = <8>;
> +        queue0 {};
> +        queue1 {};
> +        queue2 {};
> +        queue3 {};
> +        queue4 {};
> +        queue5 {};
> +        queue6 {};
> +        queue7 {};
> +      };
> +
> +      gmac0_stmmac_axi_setup: stmmac-axi-config {
> +        snps,blen = <16 8 4 0 0 0 0>;
> +        snps,wr_osr_lmt = <1>;
> +        snps,rd_osr_lmt = <2>;
> +      };
> +    };
> --
> 2.47.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


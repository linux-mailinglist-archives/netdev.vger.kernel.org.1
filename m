Return-Path: <netdev+bounces-101349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A34D8FE38E
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 11:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381691C235AB
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 09:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DED617E90D;
	Thu,  6 Jun 2024 09:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVCst6jk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F73517E8FF;
	Thu,  6 Jun 2024 09:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717667681; cv=none; b=EpM1BMu60mD6uaSUhhGm5jMjHPvgZ6XDjdJPNIu6QH06GOWYXbPRpJejAmygnX3JDyxFlQNioaxEvwijxc32NE/2YDgIYny4SfUf9heF3kBXQ3jU98l6slivaqDsOeZJPfZkO7A0yZIzpa7ra6L98GMdT9VWvCcQqQ5z/aZfGB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717667681; c=relaxed/simple;
	bh=Z2VMccOOSDatzJeze9t5UPPkyLkp/fkXGrpo/4e/Fos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Az1Y764sIp24UwRstuAR8LW+w7SJDIt7+3WU/oBn7HPDuTC90VXWsjA/3vZlJRjpnZS+umOUhRlAaVBPQ8cPsfRQoHBo2eaYfwR8/3rOvdJTNu0O9YXARbugblEr8AjGk9h5992tukhQvKqmOv3/0qr9Ljq3pXm4GuZyXbnfCfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVCst6jk; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eaad2c673fso9905651fa.3;
        Thu, 06 Jun 2024 02:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717667677; x=1718272477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j7ZwTo7cubPdTqgiQ3bolCsFuxVdpo9KUozcuDCSqoc=;
        b=DVCst6jk3edpR/3dogHtrJE9PReTxgZY1NGJpOd4CF0o4ehFJUaBXKz7hb0F6E/O82
         33YHdSvYQQBnuUhNCX3O2bzgU3BGkRSVSGW9R+97zI7dp26e2iYZ+xWEBc1cvqWzUTLr
         W7uAq61teZv7ZSlkdzObJZhOSyZDTdQzOVHg6DPmIIKXekWBdkTQjYPGpILFa9kHE9zh
         jap7CYH+8RgRchtT3pavT9XRSZ89x2SScgsuPXDn+TDqu1FNCGf+/0RZFOruXj0yWQlC
         qiH6SMn2q/bv1dVRDqF/7wFKzvHQSfUBpOH1iJVgX5fQuG6T+RDwThqbTU0iFJj1mdk9
         BZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717667677; x=1718272477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7ZwTo7cubPdTqgiQ3bolCsFuxVdpo9KUozcuDCSqoc=;
        b=oW6WuWrjIokW88DXdIpifIdXqRZbrXFe9XO8NtkCK4eZ+6UGR5qsXm0/DLkcA9z7eJ
         MvYvHv81/vTNpVueK+j4MVcLFXudLnzsCfmipzrfAB/8/OgijDPO3n+QnYJ+mKJTh8vn
         hCw1+inGJfxEkWtsnn29klijxQ2QDJHxXotjbdA+GXJz1SiAvX1DxjUlEjfZbIZ1yCY9
         KlFzAk4TYzYvQ7TRdimtA5fSx/VyjmLh1aBA9kqHMrD0hpMVsS0yPmmJu8DCxVflMzVO
         oQa49Kkhgya+o9y7IE/Dtm3ZSc5zZPe4NtwbQzoBkNYg5cJcujqT37cmngtlQyxKv0qt
         hMmg==
X-Forwarded-Encrypted: i=1; AJvYcCWKsv0R49zPb1paRvuaZW9h4clEI9brw0PcyCWjpASXH4JqhqJ4BLHYbeREvz0hP0aQKq9KqITTTtXkzlHIwSnJfk4n917Nm+AeAjxvFLQ+nhq5Rq2iN13zhTekAo2MzFVxp38Xnp7k7afCL3uGtBhukEAFFWP2xScoVqlvtxo6lA==
X-Gm-Message-State: AOJu0YzxXE3ihZraSkCT2n9uhsiZjopbIwqotBx1cCL7ZymTjB8spawd
	Ku+tRsBBH7UCr2F3YQbNoyYJavuyhalTvHNeEhKtWX+LP8FkiYVQ
X-Google-Smtp-Source: AGHT+IH5n69aXPBRxoZg81CcKGwp0ngW28+xp43M7nAJ2tqTWlt88QYTqbsfeuor6ja2zNiMeyzhYw==
X-Received: by 2002:a2e:9201:0:b0:2ea:823d:c33a with SMTP id 38308e7fff4ca-2eac7a6850amr39864101fa.33.1717667677058;
        Thu, 06 Jun 2024 02:54:37 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ead41b0748sm1430241fa.88.2024.06.06.02.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 02:54:36 -0700 (PDT)
Date: Thu, 6 Jun 2024 12:54:33 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Jose Abreu <Jose.Abreu@synopsys.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Sagar Cheluvegowda <quic_scheluve@quicinc.com>, 
	Abhishek Chauhan <quic_abchauha@quicinc.com>, Andrew Halaney <ahalaney@redhat.com>, 
	Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	Tomer Maimon <tmaimon77@gmail.com>, openbmc@lists.ozlabs.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 06/10] dt-bindings: net: Add Synopsys DW xPCS
 bindings
Message-ID: <d57e77t4cz434qfdnuq7qek6zxcaehxmzlqtb3ezloh74ihclb@wn7gbfd6wbw7>
References: <20240602143636.5839-1-fancer.lancer@gmail.com>
 <20240602143636.5839-7-fancer.lancer@gmail.com>
 <20240605232916.GA3400992-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605232916.GA3400992-robh@kernel.org>

On Wed, Jun 05, 2024 at 05:29:16PM -0600, Rob Herring wrote:
> On Sun, Jun 02, 2024 at 05:36:20PM +0300, Serge Semin wrote:
> > Synopsys DesignWare XPCS IP-core is a Physical Coding Sublayer (PCS) layer
> > providing an interface between the Media Access Control (MAC) and Physical
> > Medium Attachment Sublayer (PMA) through a Media independent interface.
> > >From software point of view it exposes IEEE std. Clause 45 CSR space and
> > can be accessible either by MDIO or MCI/APB3 bus interfaces. In the former
> > case the PCS device is supposed to be defined under the respective MDIO
> > bus DT-node. In the later case the DW xPCS will be just a normal IO
> > memory-mapped device.
> > 
> > Besides of that DW XPCS DT-nodes can have an interrupt signal and clock
> > source properties specified. The former one indicates the Clause 73/37
> > auto-negotiation events like: negotiation page received, AN is completed
> > or incompatible link partner. The clock DT-properties can describe up to
> > three clock sources: peripheral bus clock source, internal reference clock
> > and the externally connected reference clock.
> > 
> > Finally the DW XPCS IP-core can be optionally synthesized with a
> > vendor-specific interface connected to the Synopsys PMA (also called
> > DesignWare Consumer/Enterprise PHY). Alas that isn't auto-detectable in a
> > portable way. So if the DW XPCS device has the respective PMA attached
> > then it should be reflected in the DT-node compatible string so the driver
> > would be aware of the PMA-specific device capabilities (mainly connected
> > with CSRs available for the fine-tunings).
> > 
> > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > 
> > ---
> > 
> > Changelog v2:
> > - Drop the Management Interface DT-node bindings. DW xPCS with MCI/APB3
> >   interface is just a normal memory-mapped device.
> > ---
> >  .../bindings/net/pcs/snps,dw-xpcs.yaml        | 133 ++++++++++++++++++
> >  1 file changed, 133 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml b/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
> > new file mode 100644
> > index 000000000000..7927bceefbf3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
> > @@ -0,0 +1,133 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/pcs/snps,dw-xpcs.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Synopsys DesignWare Ethernet PCS
> > +
> > +maintainers:
> > +  - Serge Semin <fancer.lancer@gmail.com>
> > +
> > +description:
> > +  Synopsys DesignWare Ethernet Physical Coding Sublayer provides an interface
> > +  between Media Access Control and Physical Medium Attachment Sublayer through
> > +  the Media Independent Interface (XGMII, USXGMII, XLGMII, GMII, etc)
> > +  controlled by means of the IEEE std. Clause 45 registers set. The PCS can be
> > +  optionally synthesized with a vendor-specific interface connected to
> > +  Synopsys PMA (also called DesignWare Consumer/Enterprise PHY) although in
> > +  general it can be used to communicate with any compatible PHY.
> > +
> > +  The PCS CSRs can be accessible either over the Ethernet MDIO bus or directly
> > +  by means of the APB3/MCI interfaces. In the later case the XPCS can be mapped
> > +  right to the system IO memory space.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - description: Synopsys DesignWare XPCS with none or unknown PMA
> > +        const: snps,dw-xpcs
> > +      - description: Synopsys DesignWare XPCS with Consumer Gen1 3G PMA
> > +        const: snps,dw-xpcs-gen1-3g
> > +      - description: Synopsys DesignWare XPCS with Consumer Gen2 3G PMA
> > +        const: snps,dw-xpcs-gen2-3g
> > +      - description: Synopsys DesignWare XPCS with Consumer Gen2 6G PMA
> > +        const: snps,dw-xpcs-gen2-6g
> > +      - description: Synopsys DesignWare XPCS with Consumer Gen4 3G PMA
> > +        const: snps,dw-xpcs-gen4-3g
> > +      - description: Synopsys DesignWare XPCS with Consumer Gen4 6G PMA
> > +        const: snps,dw-xpcs-gen4-6g
> > +      - description: Synopsys DesignWare XPCS with Consumer Gen5 10G PMA
> > +        const: snps,dw-xpcs-gen5-10g
> > +      - description: Synopsys DesignWare XPCS with Consumer Gen5 12G PMA
> > +        const: snps,dw-xpcs-gen5-12g
> > +
> > +  reg:
> > +    items:
> > +      - description:
> > +          In case of the MDIO management interface this just a 5-bits ID
> > +          of the MDIO bus device. If DW XPCS CSRs space is accessed over the
> > +          MCI or APB3 management interfaces, then the space mapping can be
> > +          either 'direct' or 'indirect'. In the former case all Clause 45
> > +          registers are contiguously mapped within the address space
> > +          MMD '[20:16]', Reg '[15:0]'. In the later case the space is divided
> > +          to the multiple 256 register sets. There is a special viewport CSR
> > +          which is responsible for the set selection. The upper part of
> > +          the CSR address MMD+REG[20:8] is supposed to be written in there
> > +          so the corresponding subset would be mapped to the lowest 255 CSRs.
> > +
> > +  reg-names:
> > +    items:
> > +      - enum: [ direct, indirect ]
> > +
> > +  reg-io-width:
> > +    description:
> > +      The way the CSRs are mapped to the memory is platform depended. Since
> > +      each Clause 45 CSR is of 16-bits wide the access instructions must be
> > +      two bytes aligned at least.
> > +    default: 2
> > +    enum: [ 2, 4 ]
> > +
> > +  interrupts:
> > +    description:
> > +      System interface interrupt output (sbd_intr_o) indicating Clause 73/37
> > +      auto-negotiation events':' Page received, AN is completed or incompatible
> > +      link partner.
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    description:
> > +      Both MCI and APB3 interfaces are supposed to be equipped with a clock
> > +      source connected via the clk_csr_i line.
> > +
> > +      PCS/PMA layer can be clocked by an internal reference clock source
> > +      (phyN_core_refclk) or by an externally connected (phyN_pad_refclk) clock
> > +      generator. Both clocks can be supplied at a time.
> > +    minItems: 1
> > +    maxItems: 3
> > +
> > +  clock-names:
> > +    minItems: 1
> > +    maxItems: 3
> > +    anyOf:
> > +      - items:
> > +          enum: [ core, pad ]
> 

> This has no effect. If it is true, then the 2nd entry is too.

Yeah, from the anyOf logic it's redundant indeed. But the idea was to
signify that the DT-node may have one the next clock-names
combination:
   clock-names = "pad";
or clock-names = "core";
or clock-names = "core", "pad";
or clock-names = "pclk";
or clock-names = "pclk", "core";
or clock-names = "pclk", "pad";
or clock-names = "pclk", "core", "pad";
> 
> You are saying all the clocks are optional and any combination/order is 
> valid. Do we really need it so flexible? Doubtful the h/w is that 
> flexible.

Well, I failed to figure out a more restrictive but still simple
constraint. Here are the conditions which need to be taken into
account:
1. "pclk" is specific for the memory-mapped DW XPCS only (DT-nodes
found under normal system bus super-node). DT-nodes placed under the
MDIO-bus super-node obviously have the MDIO-bus communication channel
which is clocked by the internal clock generator.
2. "core" (also mentioned as "alt" in the HW-databooks) and "pad"
clock sources can be found on XPCS with DW Enterprise Gen2, Gen4, Gen5
and Gen6 PMAs. (At least that's what I managed to find in the DW XPCS
v3.11a HW-manual.) Both of these clock sources can be specified at a
time. So it's the software responsibility to choose which one to use.

So based on the notes above it's still possible to have no clock
source specified if it's an MDIO-based DW XPCS with a PMA/PHY with no
ref-clock required.

Any idea of how to implement the constraint with these conditions
followed?

-Serge(y)

> 
> > +      - items:
> > +          enum: [ pclk, core, pad ]
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    ethernet-pcs@1f05d000 {
> > +      compatible = "snps,dw-xpcs";
> > +      reg = <0x1f05d000 0x1000>;
> > +      reg-names = "indirect";
> > +
> > +      reg-io-width = <4>;
> > +
> > +      interrupts = <79 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +      clocks = <&ccu_pclk>, <&ccu_core>, <&ccu_pad>;
> > +      clock-names = "pclk", "core", "pad";
> > +    };
> > +  - |
> > +    mdio-bus {
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +
> > +      ethernet-pcs@0 {
> > +        compatible = "snps,dw-xpcs";
> > +        reg = <0>;
> > +
> > +        clocks = <&ccu_core>, <&ccu_pad>;
> > +        clock-names = "core", "pad";
> > +      };
> > +    };
> > +...
> > -- 
> > 2.43.0
> > 


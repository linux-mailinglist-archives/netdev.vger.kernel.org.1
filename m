Return-Path: <netdev+bounces-103386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FEA907D68
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 22:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B6E41C24C1D
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 20:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D22D13A240;
	Thu, 13 Jun 2024 20:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnKeyJvu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731EE824A4;
	Thu, 13 Jun 2024 20:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718309999; cv=none; b=bVqcGVYq2otPJgKlDLZevQqUg/a7mLv92xtGNUCphRZlIdO1UNA0YF1+0/7kX6m4N7GTqaDtJGvxjCkaXERJYYBysRWwHabfzumwuLka5VzIDTQ8cmUp/Dlq/tSjRUVKkS/T6BeEx4uhm/ciDGhQxtL5LAFew2AUnVtYh+/8Bwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718309999; c=relaxed/simple;
	bh=V/ohRnl28oyDkoRIfL5uvZjED2GpbSlnYYCHYbUE/xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrJOlD6nqyxzWFyo0UHvsaiEseRKz1+ARzWwuFhOFebFSmwImYmWBL0vCk5w4KD/cJvXCgEcmTC5VL1ql620oFRJJfYTDFzI9aLLpPPjHzZWRjY+vnDJAN0pT280mh74v4n/a9INRVR0+wChQ4dHDjh2pFvWj4N9+0oUvrESaic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnKeyJvu; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52bd48cf36bso1829857e87.3;
        Thu, 13 Jun 2024 13:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718309995; x=1718914795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=thBf8i7EEHE/1IDtEKHUzXgXRMaKSMoMlRxJ2tobSiA=;
        b=EnKeyJvuDzve9iAANq8wB986Sz2hlTPe8LtYKRFTto1VzZHmA1sdhxtJfWL+QzOKFf
         GzNSvfrAiipw930qyLgSDmOgPf+ri+OETTr059LXPdPBKG3RmQl06fKEUHtMfK9rksYD
         PvjZYOcx73YdYKAZmrYMtFwrlJrrbcoMAtAzefCfxW4E4RewDLvzJq5bMydir+jyzi9V
         Q5gXvPI+CodVFJD2ErpC5Xo6NnrzWbSTBjGCKMIuXYYvtakjidYuxSl8mmHGIZ8drk/s
         eTqkS5y8VuPaA/z908pN2NSgSadUyqKyECEr7MTEYHkq1TJ0Jq59fNc7dVOHxIeH5OSh
         Qqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718309995; x=1718914795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thBf8i7EEHE/1IDtEKHUzXgXRMaKSMoMlRxJ2tobSiA=;
        b=I0Q/5x8mblRJnGh4ZhZYcIH/jgLNd+5zcfbiy708kG7H92h2NcAQuZfFGhetmDBFnL
         7ps02Q4ZGRVE6HkH84bPSyw07Dmk/lGoXmE91qFmPXeh39BwwyyyTnR4ncpb2VSWTgfC
         sByyL+GpQp8Lgn+Xi5GQNLSTHa4cMkIldHZAbTa3CtislcZztP9jGa92oBZP8m2AvIZy
         PhGHI8NXMUCtNngxIQpMVBmxL2+VdnkA1sZovb6Nt9wZSf8jDuX4ixfuJJkRerVWS6ge
         IlPDkd75OIX6FpDxeL0EeZ75Kb8yTGiUqPOBh6LyrcdT5CQbmlT+xS3cJPeCF+im1X7h
         hjpw==
X-Forwarded-Encrypted: i=1; AJvYcCX9ImbRat8dcmsx39I33SlhCf4VS8OneWQqTelyqD8dhq92Lkxj7WCFhNp23EW9e3yuM6ez2VIj5m7wywtnJ47Rd/TDAsblroeusiI1yJ/qf/ii6F2olIVHY4EcD0UorxWIoep6mM24UCCQzZDsPmpeBJoivbsI3R2KDdyJt8RlFg==
X-Gm-Message-State: AOJu0Yzwr1NvURsgILLb4Vo4TFJ8U35BTtopEmvV/iuEZAgWZx3Bd3ev
	KcodqUh/unecxP5fxP0Zj68rlO2eqmYs010GJabnJGQPzbTEj7vo
X-Google-Smtp-Source: AGHT+IHKdhL4ZZ221gRS/nvpLVeZ1jNMizZz1RZ/oM1RZofw526OCquol3tzA3iwaEcNDIMdoaInkA==
X-Received: by 2002:a19:f816:0:b0:52c:99cc:eef4 with SMTP id 2adb3069b0e04-52ca6e564afmr594244e87.4.1718309995045;
        Thu, 13 Jun 2024 13:19:55 -0700 (PDT)
Received: from mobilestation ([176.213.10.53])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca282567bsm332884e87.54.2024.06.13.13.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 13:19:54 -0700 (PDT)
Date: Thu, 13 Jun 2024 23:19:52 +0300
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
Message-ID: <kxb23k56nwtp6744r2nghgqecjw3aex5v56dk2bgkri3hwj3p5@awcsno3xbjkk>
References: <20240602143636.5839-1-fancer.lancer@gmail.com>
 <20240602143636.5839-7-fancer.lancer@gmail.com>
 <20240605232916.GA3400992-robh@kernel.org>
 <d57e77t4cz434qfdnuq7qek6zxcaehxmzlqtb3ezloh74ihclb@wn7gbfd6wbw7>
 <20240610214916.GA3120860-robh@kernel.org>
 <hx5pcbxao3ozymwh5pe4m3aje65lhxh5fzqynvphphfmpmnopk@2akvqrpxyg2v>
 <20240613154125.GA1877114-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613154125.GA1877114-robh@kernel.org>

On Thu, Jun 13, 2024 at 09:41:25AM -0600, Rob Herring wrote:
> On Tue, Jun 11, 2024 at 01:45:16PM +0300, Serge Semin wrote:
> > Hi Rob
> > 
> > On Mon, Jun 10, 2024 at 03:49:16PM -0600, Rob Herring wrote:
> > > On Thu, Jun 06, 2024 at 12:54:33PM +0300, Serge Semin wrote:
> > > > On Wed, Jun 05, 2024 at 05:29:16PM -0600, Rob Herring wrote:
> > > > > On Sun, Jun 02, 2024 at 05:36:20PM +0300, Serge Semin wrote:
> > > > > > Synopsys DesignWare XPCS IP-core is a Physical Coding Sublayer (PCS) layer
> > > > > > providing an interface between the Media Access Control (MAC) and Physical
> > > > > > Medium Attachment Sublayer (PMA) through a Media independent interface.
> > > > > > >From software point of view it exposes IEEE std. Clause 45 CSR space and
> > > > > > can be accessible either by MDIO or MCI/APB3 bus interfaces. In the former
> > > > > > case the PCS device is supposed to be defined under the respective MDIO
> > > > > > bus DT-node. In the later case the DW xPCS will be just a normal IO
> > > > > > memory-mapped device.
> > > > > > 
> > > > > > Besides of that DW XPCS DT-nodes can have an interrupt signal and clock
> > > > > > source properties specified. The former one indicates the Clause 73/37
> > > > > > auto-negotiation events like: negotiation page received, AN is completed
> > > > > > or incompatible link partner. The clock DT-properties can describe up to
> > > > > > three clock sources: peripheral bus clock source, internal reference clock
> > > > > > and the externally connected reference clock.
> > > > > > 
> > > > > > Finally the DW XPCS IP-core can be optionally synthesized with a
> > > > > > vendor-specific interface connected to the Synopsys PMA (also called
> > > > > > DesignWare Consumer/Enterprise PHY). Alas that isn't auto-detectable in a
> > > > > > portable way. So if the DW XPCS device has the respective PMA attached
> > > > > > then it should be reflected in the DT-node compatible string so the driver
> > > > > > would be aware of the PMA-specific device capabilities (mainly connected
> > > > > > with CSRs available for the fine-tunings).
> > > > > > 
> > > > > > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > > > > > 
> > > > > > ---
> > > > > > 
> > > > > > Changelog v2:
> > > > > > - Drop the Management Interface DT-node bindings. DW xPCS with MCI/APB3
> > > > > >   interface is just a normal memory-mapped device.
> > > > > > ---
> > > > > >  .../bindings/net/pcs/snps,dw-xpcs.yaml        | 133 ++++++++++++++++++
> > > > > >  1 file changed, 133 insertions(+)
> > > > > >  create mode 100644 Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
> > > > > > 
> > > > > > diff --git a/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml b/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
> > > > > > new file mode 100644
> > > > > > index 000000000000..7927bceefbf3
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
> > > > > > @@ -0,0 +1,133 @@
> > > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > > +%YAML 1.2
> > > > > > +---
> > > > > > +$id: http://devicetree.org/schemas/net/pcs/snps,dw-xpcs.yaml#
> > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > +
> > > > > > +title: Synopsys DesignWare Ethernet PCS
> > > > > > +
> > > > > > +maintainers:
> > > > > > +  - Serge Semin <fancer.lancer@gmail.com>
> > > > > > +
> > > > > > +description:
> > > > > > +  Synopsys DesignWare Ethernet Physical Coding Sublayer provides an interface
> > > > > > +  between Media Access Control and Physical Medium Attachment Sublayer through
> > > > > > +  the Media Independent Interface (XGMII, USXGMII, XLGMII, GMII, etc)
> > > > > > +  controlled by means of the IEEE std. Clause 45 registers set. The PCS can be
> > > > > > +  optionally synthesized with a vendor-specific interface connected to
> > > > > > +  Synopsys PMA (also called DesignWare Consumer/Enterprise PHY) although in
> > > > > > +  general it can be used to communicate with any compatible PHY.
> > > > > > +
> > > > > > +  The PCS CSRs can be accessible either over the Ethernet MDIO bus or directly
> > > > > > +  by means of the APB3/MCI interfaces. In the later case the XPCS can be mapped
> > > > > > +  right to the system IO memory space.
> > > > > > +
> > > > > > +properties:
> > > > > > +  compatible:
> > > > > > +    oneOf:
> > > > > > +      - description: Synopsys DesignWare XPCS with none or unknown PMA
> > > > > > +        const: snps,dw-xpcs
> > > > > > +      - description: Synopsys DesignWare XPCS with Consumer Gen1 3G PMA
> > > > > > +        const: snps,dw-xpcs-gen1-3g
> > > > > > +      - description: Synopsys DesignWare XPCS with Consumer Gen2 3G PMA
> > > > > > +        const: snps,dw-xpcs-gen2-3g
> > > > > > +      - description: Synopsys DesignWare XPCS with Consumer Gen2 6G PMA
> > > > > > +        const: snps,dw-xpcs-gen2-6g
> > > > > > +      - description: Synopsys DesignWare XPCS with Consumer Gen4 3G PMA
> > > > > > +        const: snps,dw-xpcs-gen4-3g
> > > > > > +      - description: Synopsys DesignWare XPCS with Consumer Gen4 6G PMA
> > > > > > +        const: snps,dw-xpcs-gen4-6g
> > > > > > +      - description: Synopsys DesignWare XPCS with Consumer Gen5 10G PMA
> > > > > > +        const: snps,dw-xpcs-gen5-10g
> > > > > > +      - description: Synopsys DesignWare XPCS with Consumer Gen5 12G PMA
> > > > > > +        const: snps,dw-xpcs-gen5-12g
> > > > > > +
> > > > > > +  reg:
> > > > > > +    items:
> > > > > > +      - description:
> > > > > > +          In case of the MDIO management interface this just a 5-bits ID
> > > > > > +          of the MDIO bus device. If DW XPCS CSRs space is accessed over the
> > > > > > +          MCI or APB3 management interfaces, then the space mapping can be
> > > > > > +          either 'direct' or 'indirect'. In the former case all Clause 45
> > > > > > +          registers are contiguously mapped within the address space
> > > > > > +          MMD '[20:16]', Reg '[15:0]'. In the later case the space is divided
> > > > > > +          to the multiple 256 register sets. There is a special viewport CSR
> > > > > > +          which is responsible for the set selection. The upper part of
> > > > > > +          the CSR address MMD+REG[20:8] is supposed to be written in there
> > > > > > +          so the corresponding subset would be mapped to the lowest 255 CSRs.
> > > > > > +
> > > > > > +  reg-names:
> > > > > > +    items:
> > > > > > +      - enum: [ direct, indirect ]
> > > > > > +
> > > > > > +  reg-io-width:
> > > > > > +    description:
> > > > > > +      The way the CSRs are mapped to the memory is platform depended. Since
> > > > > > +      each Clause 45 CSR is of 16-bits wide the access instructions must be
> > > > > > +      two bytes aligned at least.
> > > > > > +    default: 2
> > > > > > +    enum: [ 2, 4 ]
> > > > > > +
> > > > > > +  interrupts:
> > > > > > +    description:
> > > > > > +      System interface interrupt output (sbd_intr_o) indicating Clause 73/37
> > > > > > +      auto-negotiation events':' Page received, AN is completed or incompatible
> > > > > > +      link partner.
> > > > > > +    maxItems: 1
> > > > > > +
> > > > > > +  clocks:
> > > > > > +    description:
> > > > > > +      Both MCI and APB3 interfaces are supposed to be equipped with a clock
> > > > > > +      source connected via the clk_csr_i line.
> > > > > > +
> > > > > > +      PCS/PMA layer can be clocked by an internal reference clock source
> > > > > > +      (phyN_core_refclk) or by an externally connected (phyN_pad_refclk) clock
> > > > > > +      generator. Both clocks can be supplied at a time.
> > > > > > +    minItems: 1
> > > > > > +    maxItems: 3
> > > > > > +
> > > > > > +  clock-names:
> > > > > > +    minItems: 1
> > > > > > +    maxItems: 3
> > > > > > +    anyOf:
> > > > > > +      - items:
> > > > > > +          enum: [ core, pad ]
> > > > > 
> > > > 
> > > > > This has no effect. If it is true, then the 2nd entry is too.
> > > > 
> > > > Yeah, from the anyOf logic it's redundant indeed. But the idea was to
> > > > signify that the DT-node may have one the next clock-names
> > > > combination:
> > > >    clock-names = "pad";
> > > > or clock-names = "core";
> > > > or clock-names = "core", "pad";
> > > > or clock-names = "pclk";
> > > > or clock-names = "pclk", "core";
> > > > or clock-names = "pclk", "pad";
> > > > or clock-names = "pclk", "core", "pad";
> > > 
> > > That would be:
> > > 
> > > oneOf:
> > >   - minItems: 1
> > >     items:
> > >       - enum: [core, pad]
> > >       - const: pad
> > >   - minItems: 1
> > >     items:
> > >       - const: pclk
> > >       - enum: [core, pad]
> > >       - const: pad
> > > 
> > > *-names is enforced to be 'uniqueItems: true', so we don't have to worry 
> > > about repeated entries.
> > > 
> > > This also nicely splits between MMIO and MDIO.
> > 
> > I had such approach in mind, but it seemed to me more complicated and
> > weakly scaleable (should we need to add some more clocks). Isn't the
> > next constraint look more readable:
> 
> Hardware is magically growing more clocks?

There is a non-zero probability I could have missed some additional
clocks defined in the DW XPCS IP-core databooks or there are some
vendor-specific clock sources we can't predict. Moreover the new
IP-core releases may have the clock sources list extended. So the
magic may happen.)

> 
>  
> > anyOf:
> >   - description: DW XPCS accessible over MDIO-bus
> >     minItems: 1
> >     maxItems: 2
> >     items:
> >       enum: [core, pad]
> >   - description: DW XPCS with the MCI/APB3 CSRs IO interface
> >     minItems: 1
> >     maxItems: 3
> >     items:
> >       enum: [pclk, core, pad]
> >     contains:
> >       const: pclk
> > ?
> 
> I don't see how that is much better in simplicity or scaleability. I 
> would just do this over the above:
> 
> minItems: 1
> maxItems: 3
> items:
>   enum: [pclk, core, pad]
> 
> Either you define the order or you don't. The former is strongly 
> preferred. The latter is done when it's too much a mess or we just don't 
> care to discuss it any more.

Ok. Since the order-based constraint is strongly preferable, then
there is nothing to discuss. I'll make sure the order is defined.
Thanks for review.

-Serge(y)

> 
> Rob


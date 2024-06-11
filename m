Return-Path: <netdev+bounces-102530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6740E903925
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 12:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51A71F23D41
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 10:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6922514F9CD;
	Tue, 11 Jun 2024 10:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6yX2Ykx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C295684;
	Tue, 11 Jun 2024 10:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718102724; cv=none; b=chbLeuermioQH8PBjL4fCoOqdmin6Siv63VrY5C156RjV9XLgj/jnqG1OpVxaCjJN7GJ/+jyhBMeiYwfHJxFZ1ORjcyTNdpY5JvHPvKDWYEBnLeS5CrbbUsUl25I7CkmcI+OXhow5wVfD28NP3p9m6RKCg232aoZmh2fGUqwnzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718102724; c=relaxed/simple;
	bh=jo5QslCTK5QXmsowolZnhBevQaA9+/LzhsvwBUIruSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qa8JMoknLdIkwbjSHVTY3v/yUhIOscuk193FXfV79HzpZWZrwgLSciVAo/r45AEb1PeokkMaw3AN00M6Iml9gZutXkz/05/lK/XDUeRFJLMUa3TS8CwloJHfxb5H+hlzhD0A4dpUQ89fG8/4ApLXO13xviG1XbipyjHm16jmGfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6yX2Ykx; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ebeefb9b56so10868121fa.0;
        Tue, 11 Jun 2024 03:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718102720; x=1718707520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zWkoJZm+wf71oqm8bs2xOqaLprb58bSzB+r/33WlqSs=;
        b=A6yX2Ykxqlg2vtv3F5UvU1h9+i6gRkvfrGmVV3zr2/FZlDgRpylPfsGgECxRPQd1sA
         Zbc9R/w/v/HfP82eWmI4cUuVa67xjgzDyyN6Ovi2fxBHxxM13p/s8P2q9iieA3JTNVN8
         FWGvjVhSanCAqGsn3AZSezedkSYxiz5jJ9x/w6bIZnRcj+9x/RYVkhZv1/uv7RS6nzLD
         REyFmm25n7DKCW+FZjH8UmRQfXgX0xjwZYFKGafS1BwGZECmfgX0KvaGWMyLELtoVE0G
         WmgyEN1UNL3KRlUq0RUJwgOPzW51BP8tQlnpMlPH2ibl1IgnopLylHAPS4X2V4DJ+Vpi
         pVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718102720; x=1718707520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWkoJZm+wf71oqm8bs2xOqaLprb58bSzB+r/33WlqSs=;
        b=KY8Y59ToswWcz5+LOIpL0d56/0Yy8w074qWox02z980ReywWMOAKT4pucttb3m9xno
         xljbg88FneA9/oyu8Sww6zI1aEDw6/yTKWoECp9bjXomvoSfh+A4ycizcBy1YompFQRe
         eqktejPGV4iBnsAOiW/i1SunnXiC8CUeWuG/16DnzIkkkak1BWQBxrn+j1LMkUkY1gsp
         uQ/A+ygFcmuNVK7djSTZFDKa2AR2WiW74TSIoSea5+xErFOYGLPF2grjc4LC/UaMeCqq
         YBoZpdA02ZHqcciMOozGEq+nsXQFcYxm8u2s569DUs2ia4PD3JZwzb+wwW2MBXebOCn3
         9Ejw==
X-Forwarded-Encrypted: i=1; AJvYcCWV+0pJ2nClHsHREHLdfDrgeFgSC6klA8Nex7k1rvgUl8aytsJmnSuya2Ng+94MAYgpd+wnt6mgu3v5J9vYI0U0+ZttbNqomqCGE/0Ds1mFAGZPGyeQjwHqq0GTnYiNKcPrNJdOXXW5Rv/kivi8Yk2aCuUX9OOxkeGHGlyFcWJXJw==
X-Gm-Message-State: AOJu0Yyf1TvWbGtxr8sCmJ/X4uUrPvUIUIzMGzmxjehsr/4A31T/7y0b
	dXFaIw65bmF3uYa3nPMBjagtkj2nyzcvk+ziJrFbBGFyXYq/U4tL
X-Google-Smtp-Source: AGHT+IHbC7MfT6rze+web9JyXu6fT9h9TCeT1QTPEjGzhq3rSmuo0rdDA0FvLZ7d2OhhmBjMQmwphA==
X-Received: by 2002:a05:651c:150:b0:2e5:61f4:2c11 with SMTP id 38308e7fff4ca-2eadce9a12cmr87018671fa.45.1718102720088;
        Tue, 11 Jun 2024 03:45:20 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ebd8e99702sm14625021fa.2.2024.06.11.03.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 03:45:19 -0700 (PDT)
Date: Tue, 11 Jun 2024 13:45:16 +0300
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
Message-ID: <hx5pcbxao3ozymwh5pe4m3aje65lhxh5fzqynvphphfmpmnopk@2akvqrpxyg2v>
References: <20240602143636.5839-1-fancer.lancer@gmail.com>
 <20240602143636.5839-7-fancer.lancer@gmail.com>
 <20240605232916.GA3400992-robh@kernel.org>
 <d57e77t4cz434qfdnuq7qek6zxcaehxmzlqtb3ezloh74ihclb@wn7gbfd6wbw7>
 <20240610214916.GA3120860-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610214916.GA3120860-robh@kernel.org>

Hi Rob

On Mon, Jun 10, 2024 at 03:49:16PM -0600, Rob Herring wrote:
> On Thu, Jun 06, 2024 at 12:54:33PM +0300, Serge Semin wrote:
> > On Wed, Jun 05, 2024 at 05:29:16PM -0600, Rob Herring wrote:
> > > On Sun, Jun 02, 2024 at 05:36:20PM +0300, Serge Semin wrote:
> > > > Synopsys DesignWare XPCS IP-core is a Physical Coding Sublayer (PCS) layer
> > > > providing an interface between the Media Access Control (MAC) and Physical
> > > > Medium Attachment Sublayer (PMA) through a Media independent interface.
> > > > >From software point of view it exposes IEEE std. Clause 45 CSR space and
> > > > can be accessible either by MDIO or MCI/APB3 bus interfaces. In the former
> > > > case the PCS device is supposed to be defined under the respective MDIO
> > > > bus DT-node. In the later case the DW xPCS will be just a normal IO
> > > > memory-mapped device.
> > > > 
> > > > Besides of that DW XPCS DT-nodes can have an interrupt signal and clock
> > > > source properties specified. The former one indicates the Clause 73/37
> > > > auto-negotiation events like: negotiation page received, AN is completed
> > > > or incompatible link partner. The clock DT-properties can describe up to
> > > > three clock sources: peripheral bus clock source, internal reference clock
> > > > and the externally connected reference clock.
> > > > 
> > > > Finally the DW XPCS IP-core can be optionally synthesized with a
> > > > vendor-specific interface connected to the Synopsys PMA (also called
> > > > DesignWare Consumer/Enterprise PHY). Alas that isn't auto-detectable in a
> > > > portable way. So if the DW XPCS device has the respective PMA attached
> > > > then it should be reflected in the DT-node compatible string so the driver
> > > > would be aware of the PMA-specific device capabilities (mainly connected
> > > > with CSRs available for the fine-tunings).
> > > > 
> > > > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > > > 
> > > > ---
> > > > 
> > > > Changelog v2:
> > > > - Drop the Management Interface DT-node bindings. DW xPCS with MCI/APB3
> > > >   interface is just a normal memory-mapped device.
> > > > ---
> > > >  .../bindings/net/pcs/snps,dw-xpcs.yaml        | 133 ++++++++++++++++++
> > > >  1 file changed, 133 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml b/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
> > > > new file mode 100644
> > > > index 000000000000..7927bceefbf3
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
> > > > @@ -0,0 +1,133 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/net/pcs/snps,dw-xpcs.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Synopsys DesignWare Ethernet PCS
> > > > +
> > > > +maintainers:
> > > > +  - Serge Semin <fancer.lancer@gmail.com>
> > > > +
> > > > +description:
> > > > +  Synopsys DesignWare Ethernet Physical Coding Sublayer provides an interface
> > > > +  between Media Access Control and Physical Medium Attachment Sublayer through
> > > > +  the Media Independent Interface (XGMII, USXGMII, XLGMII, GMII, etc)
> > > > +  controlled by means of the IEEE std. Clause 45 registers set. The PCS can be
> > > > +  optionally synthesized with a vendor-specific interface connected to
> > > > +  Synopsys PMA (also called DesignWare Consumer/Enterprise PHY) although in
> > > > +  general it can be used to communicate with any compatible PHY.
> > > > +
> > > > +  The PCS CSRs can be accessible either over the Ethernet MDIO bus or directly
> > > > +  by means of the APB3/MCI interfaces. In the later case the XPCS can be mapped
> > > > +  right to the system IO memory space.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    oneOf:
> > > > +      - description: Synopsys DesignWare XPCS with none or unknown PMA
> > > > +        const: snps,dw-xpcs
> > > > +      - description: Synopsys DesignWare XPCS with Consumer Gen1 3G PMA
> > > > +        const: snps,dw-xpcs-gen1-3g
> > > > +      - description: Synopsys DesignWare XPCS with Consumer Gen2 3G PMA
> > > > +        const: snps,dw-xpcs-gen2-3g
> > > > +      - description: Synopsys DesignWare XPCS with Consumer Gen2 6G PMA
> > > > +        const: snps,dw-xpcs-gen2-6g
> > > > +      - description: Synopsys DesignWare XPCS with Consumer Gen4 3G PMA
> > > > +        const: snps,dw-xpcs-gen4-3g
> > > > +      - description: Synopsys DesignWare XPCS with Consumer Gen4 6G PMA
> > > > +        const: snps,dw-xpcs-gen4-6g
> > > > +      - description: Synopsys DesignWare XPCS with Consumer Gen5 10G PMA
> > > > +        const: snps,dw-xpcs-gen5-10g
> > > > +      - description: Synopsys DesignWare XPCS with Consumer Gen5 12G PMA
> > > > +        const: snps,dw-xpcs-gen5-12g
> > > > +
> > > > +  reg:
> > > > +    items:
> > > > +      - description:
> > > > +          In case of the MDIO management interface this just a 5-bits ID
> > > > +          of the MDIO bus device. If DW XPCS CSRs space is accessed over the
> > > > +          MCI or APB3 management interfaces, then the space mapping can be
> > > > +          either 'direct' or 'indirect'. In the former case all Clause 45
> > > > +          registers are contiguously mapped within the address space
> > > > +          MMD '[20:16]', Reg '[15:0]'. In the later case the space is divided
> > > > +          to the multiple 256 register sets. There is a special viewport CSR
> > > > +          which is responsible for the set selection. The upper part of
> > > > +          the CSR address MMD+REG[20:8] is supposed to be written in there
> > > > +          so the corresponding subset would be mapped to the lowest 255 CSRs.
> > > > +
> > > > +  reg-names:
> > > > +    items:
> > > > +      - enum: [ direct, indirect ]
> > > > +
> > > > +  reg-io-width:
> > > > +    description:
> > > > +      The way the CSRs are mapped to the memory is platform depended. Since
> > > > +      each Clause 45 CSR is of 16-bits wide the access instructions must be
> > > > +      two bytes aligned at least.
> > > > +    default: 2
> > > > +    enum: [ 2, 4 ]
> > > > +
> > > > +  interrupts:
> > > > +    description:
> > > > +      System interface interrupt output (sbd_intr_o) indicating Clause 73/37
> > > > +      auto-negotiation events':' Page received, AN is completed or incompatible
> > > > +      link partner.
> > > > +    maxItems: 1
> > > > +
> > > > +  clocks:
> > > > +    description:
> > > > +      Both MCI and APB3 interfaces are supposed to be equipped with a clock
> > > > +      source connected via the clk_csr_i line.
> > > > +
> > > > +      PCS/PMA layer can be clocked by an internal reference clock source
> > > > +      (phyN_core_refclk) or by an externally connected (phyN_pad_refclk) clock
> > > > +      generator. Both clocks can be supplied at a time.
> > > > +    minItems: 1
> > > > +    maxItems: 3
> > > > +
> > > > +  clock-names:
> > > > +    minItems: 1
> > > > +    maxItems: 3
> > > > +    anyOf:
> > > > +      - items:
> > > > +          enum: [ core, pad ]
> > > 
> > 
> > > This has no effect. If it is true, then the 2nd entry is too.
> > 
> > Yeah, from the anyOf logic it's redundant indeed. But the idea was to
> > signify that the DT-node may have one the next clock-names
> > combination:
> >    clock-names = "pad";
> > or clock-names = "core";
> > or clock-names = "core", "pad";
> > or clock-names = "pclk";
> > or clock-names = "pclk", "core";
> > or clock-names = "pclk", "pad";
> > or clock-names = "pclk", "core", "pad";
> 
> That would be:
> 
> oneOf:
>   - minItems: 1
>     items:
>       - enum: [core, pad]
>       - const: pad
>   - minItems: 1
>     items:
>       - const: pclk
>       - enum: [core, pad]
>       - const: pad
> 
> *-names is enforced to be 'uniqueItems: true', so we don't have to worry 
> about repeated entries.
> 
> This also nicely splits between MMIO and MDIO.

I had such approach in mind, but it seemed to me more complicated and
weakly scaleable (should we need to add some more clocks). Isn't the
next constraint look more readable:

anyOf:
  - description: DW XPCS accessible over MDIO-bus
    minItems: 1
    maxItems: 2
    items:
      enum: [core, pad]
  - description: DW XPCS with the MCI/APB3 CSRs IO interface
    minItems: 1
    maxItems: 3
    items:
      enum: [pclk, core, pad]
    contains:
      const: pclk
?

AFAICS The only reason of using the pattern suggested by you would be
to define the ordered clock phandle settings. Is it so necessary
that we should sacrifice the readability in favor of the more strict
and less scalable solution?

-Serge(y)

> 
> > > 
> > > You are saying all the clocks are optional and any combination/order is 
> > > valid. Do we really need it so flexible? Doubtful the h/w is that 
> > > flexible.
> > 
> > Well, I failed to figure out a more restrictive but still simple
> > constraint. Here are the conditions which need to be taken into
> > account:
> > 1. "pclk" is specific for the memory-mapped DW XPCS only (DT-nodes
> > found under normal system bus super-node). DT-nodes placed under the
> > MDIO-bus super-node obviously have the MDIO-bus communication channel
> > which is clocked by the internal clock generator.
> > 2. "core" (also mentioned as "alt" in the HW-databooks) and "pad"
> > clock sources can be found on XPCS with DW Enterprise Gen2, Gen4, Gen5
> > and Gen6 PMAs. (At least that's what I managed to find in the DW XPCS
> > v3.11a HW-manual.) Both of these clock sources can be specified at a
> > time. So it's the software responsibility to choose which one to use.
> > 
> > So based on the notes above it's still possible to have no clock
> > source specified if it's an MDIO-based DW XPCS with a PMA/PHY with no
> > ref-clock required.
> > 
> > Any idea of how to implement the constraint with these conditions
> > followed?
> > 
> > -Serge(y)


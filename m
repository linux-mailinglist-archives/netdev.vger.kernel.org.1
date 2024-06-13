Return-Path: <netdev+bounces-103298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9404C907762
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 17:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 082E2288D3A
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 15:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2411012E1D9;
	Thu, 13 Jun 2024 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPbmQmFA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB73CA23;
	Thu, 13 Jun 2024 15:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718293287; cv=none; b=I8/KcZxvJQ+mhsuxt1uM8Aa+51bhGcaOteyNxki6hFr6/1coZRiMcFyYvGzp/dud6fJbETGuG1fSFH48dffsNP28jMicktDZqKgh3lZYJ5enEVs7hbFT5cS3/PmNAsPVKI5q15a2WJyPXvPkLDA+WLjG/K6O1/dt6pAaZsqR+oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718293287; c=relaxed/simple;
	bh=YcjcybhFmJnsqfSE8eTPWvKYNxPhZQkQFO3sAufAsCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9VgAEKd92G8jgDM4EHxvlkVEwYoVJUmL/1l5kruUcqP9ooFOhTn6kzrh8xCb0OfvspjdhcfJ+nULyR0WYsRt8DNu3b4qTrzL5PPyPgQI75P4cEBh/qBaTXTyiGls/J3Ffd79QXDFWVtc2Z+vt0K9breE/Lhh0S9vUieJ9qeTYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPbmQmFA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A868C2BBFC;
	Thu, 13 Jun 2024 15:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718293286;
	bh=YcjcybhFmJnsqfSE8eTPWvKYNxPhZQkQFO3sAufAsCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tPbmQmFAiDkaErzTfrPfQyv0v0h+Aju08yNx0TX2Oj0eDPOAbj3HOMM8eJzvKfy3N
	 KWfmMToLD60jHg4tk1+NcbaO2T4zelJUWPevh9CQJEat8XGgfw90fEGOhYBWSTHNYm
	 9pVXqO1x9bDE27jDHUzf54sW8CO8/dxBI2BngtdCxHdEC60K7154qZMJXobxL2rgAB
	 eiIPHHphQtgniei+AIK+4ZtMyDte9luGROpnanL5dKiRd6ZU5TMZ1c2QgRs2pAXrc4
	 vYkm0LBvs5s4AcSczdHJNWXlzlt1i83kG2bWIw2qVTON4H4goBlq5qm5Ceo8scQS1z
	 aEmNwaEv9rwOA==
Date: Thu, 13 Jun 2024 09:41:25 -0600
From: Rob Herring <robh@kernel.org>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sagar Cheluvegowda <quic_scheluve@quicinc.com>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Tomer Maimon <tmaimon77@gmail.com>, openbmc@lists.ozlabs.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 06/10] dt-bindings: net: Add Synopsys DW xPCS
 bindings
Message-ID: <20240613154125.GA1877114-robh@kernel.org>
References: <20240602143636.5839-1-fancer.lancer@gmail.com>
 <20240602143636.5839-7-fancer.lancer@gmail.com>
 <20240605232916.GA3400992-robh@kernel.org>
 <d57e77t4cz434qfdnuq7qek6zxcaehxmzlqtb3ezloh74ihclb@wn7gbfd6wbw7>
 <20240610214916.GA3120860-robh@kernel.org>
 <hx5pcbxao3ozymwh5pe4m3aje65lhxh5fzqynvphphfmpmnopk@2akvqrpxyg2v>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hx5pcbxao3ozymwh5pe4m3aje65lhxh5fzqynvphphfmpmnopk@2akvqrpxyg2v>

On Tue, Jun 11, 2024 at 01:45:16PM +0300, Serge Semin wrote:
> Hi Rob
> 
> On Mon, Jun 10, 2024 at 03:49:16PM -0600, Rob Herring wrote:
> > On Thu, Jun 06, 2024 at 12:54:33PM +0300, Serge Semin wrote:
> > > On Wed, Jun 05, 2024 at 05:29:16PM -0600, Rob Herring wrote:
> > > > On Sun, Jun 02, 2024 at 05:36:20PM +0300, Serge Semin wrote:
> > > > > Synopsys DesignWare XPCS IP-core is a Physical Coding Sublayer (PCS) layer
> > > > > providing an interface between the Media Access Control (MAC) and Physical
> > > > > Medium Attachment Sublayer (PMA) through a Media independent interface.
> > > > > >From software point of view it exposes IEEE std. Clause 45 CSR space and
> > > > > can be accessible either by MDIO or MCI/APB3 bus interfaces. In the former
> > > > > case the PCS device is supposed to be defined under the respective MDIO
> > > > > bus DT-node. In the later case the DW xPCS will be just a normal IO
> > > > > memory-mapped device.
> > > > > 
> > > > > Besides of that DW XPCS DT-nodes can have an interrupt signal and clock
> > > > > source properties specified. The former one indicates the Clause 73/37
> > > > > auto-negotiation events like: negotiation page received, AN is completed
> > > > > or incompatible link partner. The clock DT-properties can describe up to
> > > > > three clock sources: peripheral bus clock source, internal reference clock
> > > > > and the externally connected reference clock.
> > > > > 
> > > > > Finally the DW XPCS IP-core can be optionally synthesized with a
> > > > > vendor-specific interface connected to the Synopsys PMA (also called
> > > > > DesignWare Consumer/Enterprise PHY). Alas that isn't auto-detectable in a
> > > > > portable way. So if the DW XPCS device has the respective PMA attached
> > > > > then it should be reflected in the DT-node compatible string so the driver
> > > > > would be aware of the PMA-specific device capabilities (mainly connected
> > > > > with CSRs available for the fine-tunings).
> > > > > 
> > > > > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > > > > 
> > > > > ---
> > > > > 
> > > > > Changelog v2:
> > > > > - Drop the Management Interface DT-node bindings. DW xPCS with MCI/APB3
> > > > >   interface is just a normal memory-mapped device.
> > > > > ---
> > > > >  .../bindings/net/pcs/snps,dw-xpcs.yaml        | 133 ++++++++++++++++++
> > > > >  1 file changed, 133 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml b/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..7927bceefbf3
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
> > > > > @@ -0,0 +1,133 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/net/pcs/snps,dw-xpcs.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: Synopsys DesignWare Ethernet PCS
> > > > > +
> > > > > +maintainers:
> > > > > +  - Serge Semin <fancer.lancer@gmail.com>
> > > > > +
> > > > > +description:
> > > > > +  Synopsys DesignWare Ethernet Physical Coding Sublayer provides an interface
> > > > > +  between Media Access Control and Physical Medium Attachment Sublayer through
> > > > > +  the Media Independent Interface (XGMII, USXGMII, XLGMII, GMII, etc)
> > > > > +  controlled by means of the IEEE std. Clause 45 registers set. The PCS can be
> > > > > +  optionally synthesized with a vendor-specific interface connected to
> > > > > +  Synopsys PMA (also called DesignWare Consumer/Enterprise PHY) although in
> > > > > +  general it can be used to communicate with any compatible PHY.
> > > > > +
> > > > > +  The PCS CSRs can be accessible either over the Ethernet MDIO bus or directly
> > > > > +  by means of the APB3/MCI interfaces. In the later case the XPCS can be mapped
> > > > > +  right to the system IO memory space.
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    oneOf:
> > > > > +      - description: Synopsys DesignWare XPCS with none or unknown PMA
> > > > > +        const: snps,dw-xpcs
> > > > > +      - description: Synopsys DesignWare XPCS with Consumer Gen1 3G PMA
> > > > > +        const: snps,dw-xpcs-gen1-3g
> > > > > +      - description: Synopsys DesignWare XPCS with Consumer Gen2 3G PMA
> > > > > +        const: snps,dw-xpcs-gen2-3g
> > > > > +      - description: Synopsys DesignWare XPCS with Consumer Gen2 6G PMA
> > > > > +        const: snps,dw-xpcs-gen2-6g
> > > > > +      - description: Synopsys DesignWare XPCS with Consumer Gen4 3G PMA
> > > > > +        const: snps,dw-xpcs-gen4-3g
> > > > > +      - description: Synopsys DesignWare XPCS with Consumer Gen4 6G PMA
> > > > > +        const: snps,dw-xpcs-gen4-6g
> > > > > +      - description: Synopsys DesignWare XPCS with Consumer Gen5 10G PMA
> > > > > +        const: snps,dw-xpcs-gen5-10g
> > > > > +      - description: Synopsys DesignWare XPCS with Consumer Gen5 12G PMA
> > > > > +        const: snps,dw-xpcs-gen5-12g
> > > > > +
> > > > > +  reg:
> > > > > +    items:
> > > > > +      - description:
> > > > > +          In case of the MDIO management interface this just a 5-bits ID
> > > > > +          of the MDIO bus device. If DW XPCS CSRs space is accessed over the
> > > > > +          MCI or APB3 management interfaces, then the space mapping can be
> > > > > +          either 'direct' or 'indirect'. In the former case all Clause 45
> > > > > +          registers are contiguously mapped within the address space
> > > > > +          MMD '[20:16]', Reg '[15:0]'. In the later case the space is divided
> > > > > +          to the multiple 256 register sets. There is a special viewport CSR
> > > > > +          which is responsible for the set selection. The upper part of
> > > > > +          the CSR address MMD+REG[20:8] is supposed to be written in there
> > > > > +          so the corresponding subset would be mapped to the lowest 255 CSRs.
> > > > > +
> > > > > +  reg-names:
> > > > > +    items:
> > > > > +      - enum: [ direct, indirect ]
> > > > > +
> > > > > +  reg-io-width:
> > > > > +    description:
> > > > > +      The way the CSRs are mapped to the memory is platform depended. Since
> > > > > +      each Clause 45 CSR is of 16-bits wide the access instructions must be
> > > > > +      two bytes aligned at least.
> > > > > +    default: 2
> > > > > +    enum: [ 2, 4 ]
> > > > > +
> > > > > +  interrupts:
> > > > > +    description:
> > > > > +      System interface interrupt output (sbd_intr_o) indicating Clause 73/37
> > > > > +      auto-negotiation events':' Page received, AN is completed or incompatible
> > > > > +      link partner.
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  clocks:
> > > > > +    description:
> > > > > +      Both MCI and APB3 interfaces are supposed to be equipped with a clock
> > > > > +      source connected via the clk_csr_i line.
> > > > > +
> > > > > +      PCS/PMA layer can be clocked by an internal reference clock source
> > > > > +      (phyN_core_refclk) or by an externally connected (phyN_pad_refclk) clock
> > > > > +      generator. Both clocks can be supplied at a time.
> > > > > +    minItems: 1
> > > > > +    maxItems: 3
> > > > > +
> > > > > +  clock-names:
> > > > > +    minItems: 1
> > > > > +    maxItems: 3
> > > > > +    anyOf:
> > > > > +      - items:
> > > > > +          enum: [ core, pad ]
> > > > 
> > > 
> > > > This has no effect. If it is true, then the 2nd entry is too.
> > > 
> > > Yeah, from the anyOf logic it's redundant indeed. But the idea was to
> > > signify that the DT-node may have one the next clock-names
> > > combination:
> > >    clock-names = "pad";
> > > or clock-names = "core";
> > > or clock-names = "core", "pad";
> > > or clock-names = "pclk";
> > > or clock-names = "pclk", "core";
> > > or clock-names = "pclk", "pad";
> > > or clock-names = "pclk", "core", "pad";
> > 
> > That would be:
> > 
> > oneOf:
> >   - minItems: 1
> >     items:
> >       - enum: [core, pad]
> >       - const: pad
> >   - minItems: 1
> >     items:
> >       - const: pclk
> >       - enum: [core, pad]
> >       - const: pad
> > 
> > *-names is enforced to be 'uniqueItems: true', so we don't have to worry 
> > about repeated entries.
> > 
> > This also nicely splits between MMIO and MDIO.
> 
> I had such approach in mind, but it seemed to me more complicated and
> weakly scaleable (should we need to add some more clocks). Isn't the
> next constraint look more readable:

Hardware is magically growing more clocks?

 
> anyOf:
>   - description: DW XPCS accessible over MDIO-bus
>     minItems: 1
>     maxItems: 2
>     items:
>       enum: [core, pad]
>   - description: DW XPCS with the MCI/APB3 CSRs IO interface
>     minItems: 1
>     maxItems: 3
>     items:
>       enum: [pclk, core, pad]
>     contains:
>       const: pclk
> ?

I don't see how that is much better in simplicity or scaleability. I 
would just do this over the above:

minItems: 1
maxItems: 3
items:
  enum: [pclk, core, pad]

Either you define the order or you don't. The former is strongly 
preferred. The latter is done when it's too much a mess or we just don't 
care to discuss it any more.

Rob


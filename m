Return-Path: <netdev+bounces-249848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A09BED1F450
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 15:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ECC633033B8F
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 13:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B02285C8B;
	Wed, 14 Jan 2026 13:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiEXazXp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DAC26D4E5
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768399156; cv=none; b=i7nhpQgIXSib7k+5OatMV2Eq4wxoo3U0TRSxrUA91shWhCR7x7k78tewCK5K3hng0zV+gYg38V0pRh6j0Rd6JnJwKfhQ3SgOwFCJa1MoWFjtcO61rSsWg7pPmhX5ewMcpb2TvMqF6CXjjSr9gF0SFiHvLkS0GOR40ZulowhCYbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768399156; c=relaxed/simple;
	bh=gYAs+GiUAFkMCDQrR3u5pdD4FSYPs2j0+wx/RwM8PKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEP9tG+L5P0dsFAabTkHOjfLHFe/kOu8rwhMX5Y4UOxxLf0hk2vW5OgoEZKtSAqqEGdB0ZCufbN+IsoyU7Z6am81whxVE9kzJx6kcez0CR+PWruktZtUHEu9uO8eI7a8SZu509Z+7ZbVzAn1ycQyCJldKugCEqEBbr3LjnvUBlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiEXazXp; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42fbc3056afso5107021f8f.2
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 05:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768399151; x=1769003951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjISU1Ys6kFELGuTaFOhYFGc8VZvMTxp6QPAynHRfdA=;
        b=eiEXazXp7arbFMwC5gBLX86tK5pqixxQzzePTHriABNoZKYNUCbfJf/vH0S7sf1KY5
         3eoA0lb0eXz1Nx/lFkBbTOb6CMi6lpKsbJXKBRd7k9zo3BCABMITEPHTNN2eQo1S1UH8
         geLlVEGxqIvK6Jo9x82IvS3miRxoVfmJdSad9xhudZNYe4RdEfWfW70TGVJg9E/dK2QQ
         s8NSDvJ2uqQL/qIfUlBCx7iB6DGZ6eGR3NMTKf34dpp8D7SlbRgx8Y05xOYSU2YfQZci
         CpOBqQuu3YDQR/NymYCHssv8KHPTCmU/CQTaFDCpmQRkVxU8CBiON6GaOHrs83F8Ep0o
         J+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768399151; x=1769003951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZjISU1Ys6kFELGuTaFOhYFGc8VZvMTxp6QPAynHRfdA=;
        b=mT4mHiqYRDAvo0sNqnBnJ1putnAishB98EhFREav4A5mUraQfIpSOG1DAIa5RiVCNv
         K6G41y2TYRrE1sGH8C6NQk5EJeOMkj4zsP/qRNtzPKwAlEKzybB4CMgFi/RbKR4hC2b9
         MOn2V7TgHu2ANX0W/7cixvNaYIjjD4lRbaJ0ImC+kVurSMSjAbFMtv896BT3jp+EshyI
         ZqttyiJ6neTU/yI4enxjd6EpRBa1j/PKqAU0hOcpGICh7aOKI9dwf5Z8T2tWv6DWsL19
         f3cOFS6juohUSlJhDl7kCV0smZWye32V4tjj1qLxL8tYwnAhWLXxDsh6hSrtwgq/A9/5
         tHWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSZv3k8vxYk7JEpcLBXFUYPKrpNOO6nHnHD0oOhW0470/afVMimbWC8mNlb9bdq5Qe2m5SOpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTTxD3BZVWitxMKNYu4tpEoWmgQahzDzeFcPnzzQZ0YPKAoeiq
	EmZQL1XJ9sKqxDwB7Mv9CNJgXopsoKdnaZ4BZfQH1PG1d81bphylsmw1
X-Gm-Gg: AY/fxX7/HZLvvM2eolEsCuWK45Q1cUwZAIUEbIThWHjP6CmZAyapsT0wVi1pqlKymfo
	aXX9s5/nQFZ2gSno41xniqswBnI/dN/Cxwl8CdYLDWngDdtI+k5OHU5tLaS3R+IJyQoV41apyxP
	FeArUUp6k+pQ+ADYw3qSqrvEDy8s3ew6M99ihFTt1QsRMKiiHP4uKb3BoS7GOX+1eqIXcoqXm6m
	HM/3CcYpkjfABV2yZ7E+vXo8U6YHhDT6NL09m0+UKMfnpRwmJFu8g6O+XrPdobLM7cir0vO7toB
	ddE94KlAfA0UTsk6wkAQf6Mp14nwmjjLOkQV0LwMDsII4HLtzD31i1m5tfNxymp3EU98kEA/CtM
	KM5eko7dpbU54g1uTQpyOWhdDoHAxcS+fIvtHyY4eZRn5R1JJthD9xKUjJ36qBcyzxWkoIG0n1Q
	aIi32ZK58jE9s=
X-Received: by 2002:a5d:50cf:0:b0:432:5b81:497 with SMTP id ffacd0b85a97d-4342c5746cbmr2792373f8f.58.1768399151177;
        Wed, 14 Jan 2026 05:59:11 -0800 (PST)
Received: from eichest-laptop ([2a02:168:af72:0:7e78:ef69:9397:b410])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5edd51sm50337530f8f.29.2026.01.14.05.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 05:59:10 -0800 (PST)
Date: Wed, 14 Jan 2026 14:59:08 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: net: micrel: Convert to DT schema
Message-ID: <aWehLGtr1EhOx4mb@eichest-laptop>
References: <20260108125208.29940-1-eichest@gmail.com>
 <20260108125208.29940-2-eichest@gmail.com>
 <20260108184845.GA758009-robh@kernel.org>
 <aWC6e9N0rJt1JHsw@eichest-laptop>
 <20260113230548.GA392296-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113230548.GA392296-robh@kernel.org>

On Tue, Jan 13, 2026 at 05:05:48PM -0600, Rob Herring wrote:
> On Fri, Jan 09, 2026 at 09:21:15AM +0100, Stefan Eichenberger wrote:
> > On Thu, Jan 08, 2026 at 12:48:45PM -0600, Rob Herring wrote:
> > > On Thu, Jan 08, 2026 at 01:51:27PM +0100, Stefan Eichenberger wrote:
> > > > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > > > 
> > > > Convert the devicetree bindings for the Micrel PHYs and switches to DT
> > > > schema.
> > > > 
> > > > Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > > > ---
> > > >  .../devicetree/bindings/net/micrel.txt        |  57 --------
> > > >  .../devicetree/bindings/net/micrel.yaml       | 133 ++++++++++++++++++
> > > >  2 files changed, 133 insertions(+), 57 deletions(-)
> > > >  delete mode 100644 Documentation/devicetree/bindings/net/micrel.txt
> > > >  create mode 100644 Documentation/devicetree/bindings/net/micrel.yaml
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/net/micrel.txt b/Documentation/devicetree/bindings/net/micrel.txt
> > > > deleted file mode 100644
> > > > index 01622ce58112..000000000000
> > > > --- a/Documentation/devicetree/bindings/net/micrel.txt
> > > > +++ /dev/null
> > > > @@ -1,57 +0,0 @@
> > > > -Micrel PHY properties.
> > > > -
> > > > -These properties cover the base properties Micrel PHYs.
> > > > -
> > > > -Optional properties:
> > > > -
> > > > - - micrel,led-mode : LED mode value to set for PHYs with configurable LEDs.
> > > > -
> > > > -	Configure the LED mode with single value. The list of PHYs and the
> > > > -	bits that are currently supported:
> > > > -
> > > > -	KSZ8001: register 0x1e, bits 15..14
> > > > -	KSZ8041: register 0x1e, bits 15..14
> > > > -	KSZ8021: register 0x1f, bits 5..4
> > > > -	KSZ8031: register 0x1f, bits 5..4
> > > > -	KSZ8051: register 0x1f, bits 5..4
> > > > -	KSZ8081: register 0x1f, bits 5..4
> > > > -	KSZ8091: register 0x1f, bits 5..4
> > > > -	LAN8814: register EP5.0, bit 6
> > > > -
> > > > -	See the respective PHY datasheet for the mode values.
> > > > -
> > > > - - micrel,rmii-reference-clock-select-25-mhz: RMII Reference Clock Select
> > > > -						bit selects 25 MHz mode
> > > > -
> > > > -	Setting the RMII Reference Clock Select bit enables 25 MHz rather
> > > > -	than 50 MHz clock mode.
> > > > -
> > > > -	Note that this option is only needed for certain PHY revisions with a
> > > > -	non-standard, inverted function of this configuration bit.
> > > > -	Specifically, a clock reference ("rmii-ref" below) is always needed to
> > > > -	actually select a mode.
> > > > -
> > > > - - clocks, clock-names: contains clocks according to the common clock bindings.
> > > > -
> > > > -	supported clocks:
> > > > -	- KSZ8021, KSZ8031, KSZ8081, KSZ8091: "rmii-ref": The RMII reference
> > > > -	  input clock. Used to determine the XI input clock.
> > > > -
> > > > - - micrel,fiber-mode: If present the PHY is configured to operate in fiber mode
> > > > -
> > > > -	Some PHYs, such as the KSZ8041FTL variant, support fiber mode, enabled
> > > > -	by the FXEN boot strapping pin. It can't be determined from the PHY
> > > > -	registers whether the PHY is in fiber mode, so this boolean device tree
> > > > -	property can be used to describe it.
> > > > -
> > > > -	In fiber mode, auto-negotiation is disabled and the PHY can only work in
> > > > -	100base-fx (full and half duplex) modes.
> > > > -
> > > > - - coma-mode-gpios: If present the given gpio will be deasserted when the
> > > > -		    PHY is probed.
> > > > -
> > > > -	Some PHYs have a COMA mode input pin which puts the PHY into
> > > > -	isolate and power-down mode. On some boards this input is connected
> > > > -	to a GPIO of the SoC.
> > > > -
> > > > -	Supported on the LAN8814.
> > > > diff --git a/Documentation/devicetree/bindings/net/micrel.yaml b/Documentation/devicetree/bindings/net/micrel.yaml
> > > > new file mode 100644
> > > > index 000000000000..52d1b187e1d3
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/net/micrel.yaml
> > > > @@ -0,0 +1,133 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/net/micrel.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Micrel KSZ series PHYs and switches
> > > > +
> > > > +maintainers:
> > > > +  - Andrew Lunn <andrew@lunn.ch>
> > > > +  - Stefan Eichenberger <eichest@gmail.com>
> > > > +
> > > > +description:
> > > > +  The Micrel KSZ series contains different network phys and switches.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - ethernet-phy-id000e.7237  # KSZ8873MLL
> > > > +      - ethernet-phy-id0022.1430  # KSZ886X
> > > > +      - ethernet-phy-id0022.1435  # KSZ8863
> > > > +      - ethernet-phy-id0022.1510  # KSZ8041
> > > > +      - ethernet-phy-id0022.1537  # KSZ8041RNLI
> > > > +      - ethernet-phy-id0022.1550  # KSZ8051
> > > > +      - ethernet-phy-id0022.1555  # KSZ8021
> > > > +      - ethernet-phy-id0022.1556  # KSZ8031
> > > > +      - ethernet-phy-id0022.1560  # KSZ8081, KSZ8091
> > > > +      - ethernet-phy-id0022.1570  # KSZ8061
> > > > +      - ethernet-phy-id0022.161a  # KSZ8001
> > > > +      - ethernet-phy-id0022.1720  # KS8737
> > > > +
> > > > +  micrel,fiber-mode:
> > > > +    type: boolean
> > > > +    description: |
> > > > +      If present the PHY is configured to operate in fiber mode.
> > > > +
> > > > +      The KSZ8041FTL variant supports fiber mode, enabled by the FXEN
> > > > +      boot strapping pin. It can't be determined from the PHY registers
> > > > +      whether the PHY is in fiber mode, so this boolean device tree
> > > > +      property can be used to describe it.
> > > > +
> > > > +      In fiber mode, auto-negotiation is disabled and the PHY can only
> > > > +      work in 100base-fx (full and half duplex) modes.
> > > > +
> > > > +  micrel,led-mode:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    description: |
> > > > +      LED mode value to set for PHYs with configurable LEDs.
> > > > +
> > > > +      Configure the LED mode with single value. The list of PHYs and the
> > > > +      bits that are currently supported:
> > > > +
> > > > +      KSZ8001: register 0x1e, bits 15..14
> > > > +      KSZ8041: register 0x1e, bits 15..14
> > > > +      KSZ8021: register 0x1f, bits 5..4
> > > > +      KSZ8031: register 0x1f, bits 5..4
> > > > +      KSZ8051: register 0x1f, bits 5..4
> > > > +      KSZ8081: register 0x1f, bits 5..4
> > > > +      KSZ8091: register 0x1f, bits 5..4
> > > > +
> > > > +      See the respective PHY datasheet for the mode values.
> > > > +    minimum: 0
> > > > +    maximum: 3
> > > > +
> > > > +allOf:
> > > > +  - $ref: ethernet-phy.yaml#
> > > > +  - if:
> > > > +      not:
> > > > +        properties:
> > > > +          compatible:
> > > > +            contains:
> > > > +              const: ethernet-phy-id0022.1510
> > > > +    then:
> > > > +      properties:
> > > > +        micrel,fiber-mode: false
> > > > +  - if:
> > > > +      not:
> > > > +        properties:
> > > > +          compatible:
> > > > +            contains:
> > > > +              enum:
> > > > +                - ethernet-phy-id0022.1510
> > > > +                - ethernet-phy-id0022.1555
> > > > +                - ethernet-phy-id0022.1556
> > > > +                - ethernet-phy-id0022.1550
> > > > +                - ethernet-phy-id0022.1560
> > > > +                - ethernet-phy-id0022.161a
> > > > +    then:
> > > > +      properties:
> > > > +        micrel,led-mode: false
> > > > +  - if:
> > > > +      properties:
> > > > +        compatible:
> > > > +          contains:
> > > > +            enum:
> > > > +              - ethernet-phy-id0022.1555
> > > > +              - ethernet-phy-id0022.1556
> > > > +              - ethernet-phy-id0022.1560
> > > > +    then:
> > > > +      properties:
> > > > +        clocks:
> > > > +          maxItems: 1
> > > 
> > > This has no effect because ethernet-phy.yaml already defines this.
> > 
> > Thanks for the info. That means I would only set the clock-names and
> > remove maxItems. I will fix that in the next version.
> > 
> > > > +        clock-names:
> > > > +          const: rmii-ref
> > > > +          description:
> > > > +            The RMII reference input clock. Used to determine the XI input
> > > > +            clock.
> > > > +        micrel,rmii-reference-clock-select-25-mhz:
> > > > +          type: boolean
> > > > +          description: |
> > > > +            RMII Reference Clock Select bit selects 25 MHz mode
> > > > +
> > > > +            Setting the RMII Reference Clock Select bit enables 25 MHz rather
> > > > +            than 50 MHz clock mode.
> > > 
> > > These should be defined at the top-level. Then use the if/then schema to 
> > > disallow the properties.
> > 
> > The problem with this approach is, that because it has clock in its
> > name, the DT schema valdiator will complain:
> > devicetree/bindings/net/micrel.yaml: properties:micrel,rmii-reference-clock-select-25-mhz: 'anyOf' conditional failed, one must be fixed:
> >         'maxItems' is a required property
> >                 hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
> >         'type' is not one of ['maxItems', 'description', 'deprecated']
> >                 hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
> >         Additional properties are not allowed ('type' was unexpected)
> >                 hint: Arrays must be described with a combination of minItems/maxItems/items
> >         'type' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
> >         hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
> >         from schema $id: http://devicetree.org/meta-schemas/cell.yaml
> > 
> > I couldn't find another way to define that Boolean type at top level. Is
> > there an option to make the validator happy?
> 
> Ah, because it collides with the standard -mhz unit suffix...
> 
> Using '$ref: /schemas/types.yaml#/definitions/flag' instead of 'type: 
> boolean' might happen to work. If not, just leave it as-is.

Thanks for the hin, unfortunately it will still complain about it:
Documentation/devicetree/bindings/net/micrel.yaml: properties:micrel,rmii-reference-clock-select-25-mhz: '$ref' should not be valid under {'const': '$ref'}
        hint: Standard unit suffix properties don't need a type $ref
        from schema $id: http://devicetree.org/meta-schemas/core.yaml

So I will leave it as-is for now and only remove the maxItems for clocks
in v3.

Regards,
Stefan


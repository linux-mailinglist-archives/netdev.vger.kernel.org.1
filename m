Return-Path: <netdev+bounces-248391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA61D07C4F
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 09:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2DE1305EE77
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 08:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96ED030B520;
	Fri,  9 Jan 2026 08:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYR91u1t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A66303CAF
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 08:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767946905; cv=none; b=pTup4dvBIbKbYA55lVhc1bFQt0nItyIXnaKuv36N5jmOyGknQCZh01nqX8srX/qctWXDthwMgaQgeAOtVtCU+QNFTJD7XSQ23JxdOenmWrc9yte/z/M5Ny/uYSMnJHhQWCcsTRMEa0JOuu4L/89wCfzuqBv+zR2gROTBf4rWlPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767946905; c=relaxed/simple;
	bh=4+/JZMqsrTLvC6BTE/UnUz/uSOHAYm++AXfPzhoMcRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=necBgocHrlcaWoJN8YhWBdxdzpnbezb9+M8sGouxeZpbzZHJhYP1s38K332qYE0ICFqx1C0wfkI1KumTFF4NUMhnyC+bOuUVrRMKNy7PZEOk8xP595uOVsx3cYRu2KRDMnL/lOdXmGnxVzbuVbnBSZeWb88fV7wOok75Kk+lBoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYR91u1t; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-432d2670932so963839f8f.2
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 00:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767946878; x=1768551678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bAaqO1edMEpG8D22KcxmchMJQR+sscKFymxMmmUQ79s=;
        b=lYR91u1tgFImxRaA57eDTiiDuLpo2OhULig6AU8/ccw+G9EWuxlJkkcJPjcbeYLaOa
         M5ubmACC1zPfHq3FeXWQX/G/TrxRCmOwFV1HyBILLdUDrnjHsctOwqVE7+T9f4ZGdKKq
         UEUy4WcducJGnvLMHcHPXOBiWNXCCTnAQ8tSZErCkyRBTjlEe7fWQ3YtWm4Uj5PtypPJ
         xTfOesO8CqRZsydws9jxDEIUw4nvSJPZsHmRfouR15Szu49JxQl/4bmUCaRPH/D4koal
         j/9wZ1LofQjOByxTUjYkTWIdzb8TWgXTuYc4D3bgVKeCusOM8v7fH2JbFoDCfwTczpje
         YBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767946878; x=1768551678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAaqO1edMEpG8D22KcxmchMJQR+sscKFymxMmmUQ79s=;
        b=SeN5YbVvf1Rzfm3pZ5IAcpmU6syMF5h3jt/FxmYpPqLK4L8mPFmYxv3pc+KHLHclTG
         LXXyrxjjDepZUPnCkoOFmUWnkyuZ92ClIAGFujty/06EIox45YkMTi0hnQ43FMWKBA64
         AyrP+Sb3FeJ4sIqfjyUWEHxd+vhM311lthowMyWKvI9L9F/B0K1mtw90X1Hb4GCjmIvU
         CE3ORxLTp2fQhlU/LuIQthS7FgufvvKg6K6oJ5OHwBoT5+K1O96EB28PKBsOThbUfAWa
         +E396K8cKsXIjD3a98OXwwyUtshAr0BW9figCwMVDJYwrEKpdZSmeAl1/hhUYpwD9hFX
         NmXg==
X-Forwarded-Encrypted: i=1; AJvYcCX4GWel1EjMH4sgZKq4xIADCak8GyuJrAPdWy2Ll8zs65GucoG3REe1r+ZcdzebAJ/ntas20VE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZy3MPqAV7WF/PSGmEu5x/pw8hM2Yg+W2UYDHonpW0Ibt+X/tu
	paVJi/Fv2sVy/EFHZlAstcD0D58pEJPgH3WoZRu/4nZIhggU4pMrFYgt
X-Gm-Gg: AY/fxX7lIrq0uFkQkZ5bK87bH7dybSY/rbChfnHYPcBAj8Z68/74fhOOPi6iDUvbb1Y
	GCGnBDkgx/Zb6Tozy0ICOalLaBnSD0FLPdpNYZoq72UR5kwpkq6gn+X4nvmRkSVltcCYS+QsVvR
	HLvgpOwIVrjkTOTgvp83BVHX7g7ofACT0rczzb4cFxP/QfFC9yaGVN6W5DIwefHbXmvve61HKRK
	woi3IBveExUDB/9I9Xgb3Wh74GYG6wd3KERlSgeOz83zUKh3An1M/oozEgWDtvwUd5XW+uRYywv
	0Tnk4VEpa1lLIKu1HGoaMya5/Q0HmXZui6irkWl9oRzdl5ruIUcueNc5APTGDqiAuLkWgVMFETO
	Gi8ZQ0QZsCaXiuHPbkKOC4TNMfT+xZEqfOg1Vxth/eDGZqXDsIeasH85yyYgYBeqC2xoYot63dA
	B0QpXbxThe9Ec=
X-Google-Smtp-Source: AGHT+IG9ya1IwVVkPrvQpXEW25miZ+F+tc85mHm67h5wQbXXz3z9xmfaPgBjvwnR9GqSZrgo1n09wg==
X-Received: by 2002:a5d:5d0e:0:b0:431:66a:cbc3 with SMTP id ffacd0b85a97d-432c378a081mr8988878f8f.6.1767946878227;
        Fri, 09 Jan 2026 00:21:18 -0800 (PST)
Received: from eichest-laptop ([2a02:168:af72:0:66a2:be50:e0d3:29f9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5fe83bsm21421414f8f.38.2026.01.09.00.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 00:21:17 -0800 (PST)
Date: Fri, 9 Jan 2026 09:21:15 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: net: micrel: Convert to DT schema
Message-ID: <aWC6e9N0rJt1JHsw@eichest-laptop>
References: <20260108125208.29940-1-eichest@gmail.com>
 <20260108125208.29940-2-eichest@gmail.com>
 <20260108184845.GA758009-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108184845.GA758009-robh@kernel.org>

On Thu, Jan 08, 2026 at 12:48:45PM -0600, Rob Herring wrote:
> On Thu, Jan 08, 2026 at 01:51:27PM +0100, Stefan Eichenberger wrote:
> > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > 
> > Convert the devicetree bindings for the Micrel PHYs and switches to DT
> > schema.
> > 
> > Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > ---
> >  .../devicetree/bindings/net/micrel.txt        |  57 --------
> >  .../devicetree/bindings/net/micrel.yaml       | 133 ++++++++++++++++++
> >  2 files changed, 133 insertions(+), 57 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/net/micrel.txt
> >  create mode 100644 Documentation/devicetree/bindings/net/micrel.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/net/micrel.txt b/Documentation/devicetree/bindings/net/micrel.txt
> > deleted file mode 100644
> > index 01622ce58112..000000000000
> > --- a/Documentation/devicetree/bindings/net/micrel.txt
> > +++ /dev/null
> > @@ -1,57 +0,0 @@
> > -Micrel PHY properties.
> > -
> > -These properties cover the base properties Micrel PHYs.
> > -
> > -Optional properties:
> > -
> > - - micrel,led-mode : LED mode value to set for PHYs with configurable LEDs.
> > -
> > -	Configure the LED mode with single value. The list of PHYs and the
> > -	bits that are currently supported:
> > -
> > -	KSZ8001: register 0x1e, bits 15..14
> > -	KSZ8041: register 0x1e, bits 15..14
> > -	KSZ8021: register 0x1f, bits 5..4
> > -	KSZ8031: register 0x1f, bits 5..4
> > -	KSZ8051: register 0x1f, bits 5..4
> > -	KSZ8081: register 0x1f, bits 5..4
> > -	KSZ8091: register 0x1f, bits 5..4
> > -	LAN8814: register EP5.0, bit 6
> > -
> > -	See the respective PHY datasheet for the mode values.
> > -
> > - - micrel,rmii-reference-clock-select-25-mhz: RMII Reference Clock Select
> > -						bit selects 25 MHz mode
> > -
> > -	Setting the RMII Reference Clock Select bit enables 25 MHz rather
> > -	than 50 MHz clock mode.
> > -
> > -	Note that this option is only needed for certain PHY revisions with a
> > -	non-standard, inverted function of this configuration bit.
> > -	Specifically, a clock reference ("rmii-ref" below) is always needed to
> > -	actually select a mode.
> > -
> > - - clocks, clock-names: contains clocks according to the common clock bindings.
> > -
> > -	supported clocks:
> > -	- KSZ8021, KSZ8031, KSZ8081, KSZ8091: "rmii-ref": The RMII reference
> > -	  input clock. Used to determine the XI input clock.
> > -
> > - - micrel,fiber-mode: If present the PHY is configured to operate in fiber mode
> > -
> > -	Some PHYs, such as the KSZ8041FTL variant, support fiber mode, enabled
> > -	by the FXEN boot strapping pin. It can't be determined from the PHY
> > -	registers whether the PHY is in fiber mode, so this boolean device tree
> > -	property can be used to describe it.
> > -
> > -	In fiber mode, auto-negotiation is disabled and the PHY can only work in
> > -	100base-fx (full and half duplex) modes.
> > -
> > - - coma-mode-gpios: If present the given gpio will be deasserted when the
> > -		    PHY is probed.
> > -
> > -	Some PHYs have a COMA mode input pin which puts the PHY into
> > -	isolate and power-down mode. On some boards this input is connected
> > -	to a GPIO of the SoC.
> > -
> > -	Supported on the LAN8814.
> > diff --git a/Documentation/devicetree/bindings/net/micrel.yaml b/Documentation/devicetree/bindings/net/micrel.yaml
> > new file mode 100644
> > index 000000000000..52d1b187e1d3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/micrel.yaml
> > @@ -0,0 +1,133 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/micrel.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Micrel KSZ series PHYs and switches
> > +
> > +maintainers:
> > +  - Andrew Lunn <andrew@lunn.ch>
> > +  - Stefan Eichenberger <eichest@gmail.com>
> > +
> > +description:
> > +  The Micrel KSZ series contains different network phys and switches.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - ethernet-phy-id000e.7237  # KSZ8873MLL
> > +      - ethernet-phy-id0022.1430  # KSZ886X
> > +      - ethernet-phy-id0022.1435  # KSZ8863
> > +      - ethernet-phy-id0022.1510  # KSZ8041
> > +      - ethernet-phy-id0022.1537  # KSZ8041RNLI
> > +      - ethernet-phy-id0022.1550  # KSZ8051
> > +      - ethernet-phy-id0022.1555  # KSZ8021
> > +      - ethernet-phy-id0022.1556  # KSZ8031
> > +      - ethernet-phy-id0022.1560  # KSZ8081, KSZ8091
> > +      - ethernet-phy-id0022.1570  # KSZ8061
> > +      - ethernet-phy-id0022.161a  # KSZ8001
> > +      - ethernet-phy-id0022.1720  # KS8737
> > +
> > +  micrel,fiber-mode:
> > +    type: boolean
> > +    description: |
> > +      If present the PHY is configured to operate in fiber mode.
> > +
> > +      The KSZ8041FTL variant supports fiber mode, enabled by the FXEN
> > +      boot strapping pin. It can't be determined from the PHY registers
> > +      whether the PHY is in fiber mode, so this boolean device tree
> > +      property can be used to describe it.
> > +
> > +      In fiber mode, auto-negotiation is disabled and the PHY can only
> > +      work in 100base-fx (full and half duplex) modes.
> > +
> > +  micrel,led-mode:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: |
> > +      LED mode value to set for PHYs with configurable LEDs.
> > +
> > +      Configure the LED mode with single value. The list of PHYs and the
> > +      bits that are currently supported:
> > +
> > +      KSZ8001: register 0x1e, bits 15..14
> > +      KSZ8041: register 0x1e, bits 15..14
> > +      KSZ8021: register 0x1f, bits 5..4
> > +      KSZ8031: register 0x1f, bits 5..4
> > +      KSZ8051: register 0x1f, bits 5..4
> > +      KSZ8081: register 0x1f, bits 5..4
> > +      KSZ8091: register 0x1f, bits 5..4
> > +
> > +      See the respective PHY datasheet for the mode values.
> > +    minimum: 0
> > +    maximum: 3
> > +
> > +allOf:
> > +  - $ref: ethernet-phy.yaml#
> > +  - if:
> > +      not:
> > +        properties:
> > +          compatible:
> > +            contains:
> > +              const: ethernet-phy-id0022.1510
> > +    then:
> > +      properties:
> > +        micrel,fiber-mode: false
> > +  - if:
> > +      not:
> > +        properties:
> > +          compatible:
> > +            contains:
> > +              enum:
> > +                - ethernet-phy-id0022.1510
> > +                - ethernet-phy-id0022.1555
> > +                - ethernet-phy-id0022.1556
> > +                - ethernet-phy-id0022.1550
> > +                - ethernet-phy-id0022.1560
> > +                - ethernet-phy-id0022.161a
> > +    then:
> > +      properties:
> > +        micrel,led-mode: false
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - ethernet-phy-id0022.1555
> > +              - ethernet-phy-id0022.1556
> > +              - ethernet-phy-id0022.1560
> > +    then:
> > +      properties:
> > +        clocks:
> > +          maxItems: 1
> 
> This has no effect because ethernet-phy.yaml already defines this.

Thanks for the info. That means I would only set the clock-names and
remove maxItems. I will fix that in the next version.

> > +        clock-names:
> > +          const: rmii-ref
> > +          description:
> > +            The RMII reference input clock. Used to determine the XI input
> > +            clock.
> > +        micrel,rmii-reference-clock-select-25-mhz:
> > +          type: boolean
> > +          description: |
> > +            RMII Reference Clock Select bit selects 25 MHz mode
> > +
> > +            Setting the RMII Reference Clock Select bit enables 25 MHz rather
> > +            than 50 MHz clock mode.
> 
> These should be defined at the top-level. Then use the if/then schema to 
> disallow the properties.

The problem with this approach is, that because it has clock in its
name, the DT schema valdiator will complain:
devicetree/bindings/net/micrel.yaml: properties:micrel,rmii-reference-clock-select-25-mhz: 'anyOf' conditional failed, one must be fixed:
        'maxItems' is a required property
                hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
        'type' is not one of ['maxItems', 'description', 'deprecated']
                hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
        Additional properties are not allowed ('type' was unexpected)
                hint: Arrays must be described with a combination of minItems/maxItems/items
        'type' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
        hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
        from schema $id: http://devicetree.org/meta-schemas/cell.yaml

I couldn't find another way to define that Boolean type at top level. Is
there an option to make the validator happy?

Regards,
Stefan


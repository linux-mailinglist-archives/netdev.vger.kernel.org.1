Return-Path: <netdev+bounces-246221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D2DCE64E0
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 10:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 50CF2300F607
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 09:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEF02737E3;
	Mon, 29 Dec 2025 09:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IW2qyP2R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF0F3C2D
	for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 09:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767001074; cv=none; b=TgomfpeqnLkI+xey8vEfKt47g0LYmtJckkpMXiaPivBaXcFJa17Fpj6D3sJky6l4TUmhYDppWyRJFWj0QMzwZPCeqpDVvflN9eRm77ndcmLzzlFHce/GZeNGg06r9ZqV5ygYovPNpvns2cQXIahffw2UyQOFr4X4VlwBXSCRU5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767001074; c=relaxed/simple;
	bh=ZeLo/0hLSY9n2UB+qZNYZtHxg817oGsq7GuA8/DYKC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Op2U00AeezCxnl+e3uArENpIAyuJTy8il5FRSiZTAiwLu4kE+YQ60o5AGXUbAcQyXIDu/CqJXm0f1gsz/zG1QcUaCGEstBzDMcrM+WU09MXVLt25t+FvJazOhBjruxQTWiIXicUrL8g4Q/bRB2iAcq6lyjSPTctHM1BCVB/Dpl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IW2qyP2R; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so69785325e9.3
        for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 01:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767001071; x=1767605871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z7xTL0ht63Yvfquwj8JBduOSEbhvKNXqPm5yX4HgFIE=;
        b=IW2qyP2RROhHtFB5j871xFJ8DxCSys/pOvyOEQ4irsuIxVx+6hM5aFe2K1UDopxqiU
         GtM2wVx5ngIpkAWdwCbOJAO8DNjo/KO52ybzvELRKWFiST5t6ipkH9cM9i4kBqcOdq46
         A0G6qhh7vcn+a3b4DHyZ+UV3GmJGrDjQP4tUebYnn5cKPeoOU+H9bJ1n0UDVTqR2aKjB
         jSBqOz6oRkjbCcq3A9tQZVhh0QhVaFuUH3GIRUZ23yVhdRTrfoNBWD9iblRgMy3zOh7Q
         RXKe6sJ31lTFqArAM0QtEY4MYgn4LgZNO8fTPrm+lgFQyvFcajEzlvWXwJEdPpKBnTOr
         eQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767001071; x=1767605871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z7xTL0ht63Yvfquwj8JBduOSEbhvKNXqPm5yX4HgFIE=;
        b=NtcyHm1WUXRVti+DxrGGHmpVFUQV0SQnLdgueAnzbYu2hPAR1+4zJ74/AdM5YkSXzo
         T4xzyv0BfjyMUsmbAdvZxuvQ8xiUR5Py5iXSd0Mq/xayaSyMGbsJu1fVnmxYjYTeI+/z
         MAGOQdEn1uuyZKkU8b2dW65LJNxpRoXg7p/jRXXm9k2yIA7OnpAv+YooGBhgK/A+9PrE
         ZlysDY0s/DCFjw0saXs31XbcmtY/gwMAjPxl2rSd9NbIgjjZyym0SHeasv1m3xyaj65m
         8YVoxxfXSaUHXEhmGGxsDJRPDwSRyE9d2Os+mDFlW3ciQ4L33GMYF6CJvx3nRnESID9S
         3sow==
X-Forwarded-Encrypted: i=1; AJvYcCXQPvdgHcxfddOMkV6GbOHu6GQMih6ThINtPfY+EioWJ6QW8fGh+73Vk3WibtO0LXQiF0SzM60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4evH6/0rNAlViMAoHOha6IaOfmxn08Gdl6RlLo97GBcCaviwA
	QGHDDRcqw0z1JVlLUKoAydujfnshOvmrCGq/8OHzQ2+5xWC1VszC/Pzf
X-Gm-Gg: AY/fxX40pnHALdNtp3FL1VFy9SA7Bn7BvA/GwXu+0bT6kNjCYQJcXNHA7InTcgUc3+2
	Ams5IjlOQxxbsbdMhP8rsqYUgD+hNNL3XS9VFiDvY0NvqE617wXpgqwOrY82PEk7s2pH93vOxII
	ZWqoZ/dOwoh5mI/GcMFXd3eNLpHf9SEFfrtxOG0M0LHWBJXlhQJ4HTLLYjPnSxw/GhX31/2S1IC
	cisIYsYphFBk1ULf8RIcE/ab+D9bQX75a8eM0uuCogWCmd+wEEK2MMAZOFo37fuhgMeKVUDJOZ2
	m+uVBBDOfHYa1ODLsdNzMuXDFDORX4pGrpBcHPz56ca6XO36wuPWyT4KJsSr2msKSTmgq1O8iYb
	esVAi6f0RmuLg+eqTnL+dyNTBo0BKyO36jZv6g76mS/ayplCvMHvn5KXEGXLqoC2p5XbAduhD5t
	sKBWJvgRATEJQ=
X-Google-Smtp-Source: AGHT+IGPOUKX7q14yTgj2CVuuih5QA+xT8nKnXEoSheROymAO9OlKOilKdPI40ok2uMZOMYd5WRLqQ==
X-Received: by 2002:a05:600c:350b:b0:477:aed0:f403 with SMTP id 5b1f17b1804b1-47d19549a95mr305713395e9.8.1767001070934;
        Mon, 29 Dec 2025 01:37:50 -0800 (PST)
Received: from eichest-laptop ([2a02:168:af72:0:305a:a3c6:f52d:de0f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1aee5sm62443610f8f.4.2025.12.29.01.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 01:37:50 -0800 (PST)
Date: Mon, 29 Dec 2025 10:37:49 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	horms@kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: net: micrel: Convert to DT schema
Message-ID: <aVJL7b_dG3JT5Pt1@eichest-laptop>
References: <20251223133446.22401-1-eichest@gmail.com>
 <20251223133446.22401-2-eichest@gmail.com>
 <20251228153609.GA2198936-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251228153609.GA2198936-robh@kernel.org>

On Sun, Dec 28, 2025 at 09:36:09AM -0600, Rob Herring wrote:
> On Tue, Dec 23, 2025 at 02:33:39PM +0100, Stefan Eichenberger wrote:
> > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > 
> > Convert the devicetree bindings for the Micrel PHYs and switches to DT
> > schema.
> > 
> > Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > ---
> >  .../devicetree/bindings/net/micrel.txt        |  57 --------
> >  .../devicetree/bindings/net/micrel.yaml       | 132 ++++++++++++++++++
> >  2 files changed, 132 insertions(+), 57 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/net/micrel.txt
> >  create mode 100644 Documentation/devicetree/bindings/net/micrel.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/net/micrel.txt b/Documentation/devicetree/bindings/net/micrel.txt
> > deleted file mode 100644
> > index 01622ce58112e..0000000000000
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
> > index 0000000000000..a8e532fbcb6f5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/micrel.yaml
> > @@ -0,0 +1,132 @@
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
> > +description: |
> 
> Don't need '|' if no formatting to preserve.
> 
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
> 
> blank line
> 
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
> 
> blank line
> 
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
> > +        clock-names:
> > +          const: rmii-ref
> > +          description: |
> > +            supported clocks:
> 
> Drop this line.
> 
> > +              - The RMII reference input clock. Used to determine the XI
> > +                input clock.
> > +        micrel,rmii-reference-clock-select-25-mhz:
> > +          type: boolean
> > +          description: |
> > +            RMII Reference Clock Select bit selects 25 MHz mode
> > +
> > +            Setting the RMII Reference Clock Select bit enables 25 MHz rather
> > +            than 50 MHz clock mode.
> > +
> > +dependentRequired:
> > +  micrel,rmii-reference-clock-select-25-mhz: [ clock-names ]
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    ethernet {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        ethernet-phy@5 {
> > +            compatible = "ethernet-phy-id0022.1510";
> > +            reg = <5>;
> > +            micrel,led-mode = <2>;
> > +            micrel,fiber-mode;
> > +        };
> > +    };

Thanks for the review, I will fix these points in the next version.

Regards,
Stefan


Return-Path: <netdev+bounces-169413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F4FA43C1D
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 11:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 547D81884D02
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2061B1A239E;
	Tue, 25 Feb 2025 10:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="cFuUV6cm"
X-Original-To: netdev@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEED19E994
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 10:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740480300; cv=none; b=cJSGv5Zr3iKSR/vxI1SOcE73P3fEYpwIB8uKpxh/NBm8bVT17Cy0xugvUEZGk9UZdaZcF1sXKO1kM3HcyN1W0BNhVwErWMZZ/GkO+x52sT3GMmzSb8uMjHRZbc0/602ABfKw9iodHoAgdDbySsXp2tLyWgftq4GF8GOZPYje0Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740480300; c=relaxed/simple;
	bh=J6ud03xBUei5hve99chh9QBHJ7vCcnVOXXWngWIzsB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3WUgsmpIBLT/Qok1RhHxduxretldnYjyqdua1yFVIusTuHO9cZHlFmU9cN7m+3VubGUGplMzvna1S4uoYJ7JDiyHauN9QvZvh6kINsSD1CEJTV05QXWIF0Air2mLvYwGIyUtUYPsy7rv5JcRucSWsgfTOlnxwQIM3B/5oMXqpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=cFuUV6cm; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 6E50C240103
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 11:44:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1740480296; bh=J6ud03xBUei5hve99chh9QBHJ7vCcnVOXXWngWIzsB4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=cFuUV6cmgHpdt2ZhN3Hb5NMGw8NXHw0r05Mqz6mdjb09YD7pt1QS4Sw9UJTwQFNyr
	 9HqBKPyLjkgLY8bJIExqT1/0qPRS8y/vWOFMfsf+dvqb2Ugz9GrrFOc8FZkiefjmpt
	 ABP/OuWKNcbkKiMzn4WcN16+S/EIxHDgZDg6+DjVn6Pyal56RT9Kula71WDSKCy/4l
	 k3CS+3w8iKUuChFJN9HwPSbhXMiUw7nU4ua8snIisdO4lvxXPxMNsnSsOQI/BGseOk
	 d0WVMAjFLxQwDTFt2LiMGw7B6wvJr7RXjVkFo16qSx8ccMzDtadBm10pj62lExIcwo
	 G9VCXSZoBcj8A==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Z2Dks6y7zz9rxN;
	Tue, 25 Feb 2025 11:44:53 +0100 (CET)
Date: Tue, 25 Feb 2025 10:44:53 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Rob Herring <robh@kernel.org>
Cc: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: net: Convert fsl,gianfar to YAML
Message-ID: <Z72fJSqng8od-5Z7@probook>
References: <20250220-gianfar-yaml-v1-0-0ba97fd1ef92@posteo.net>
 <20250220-gianfar-yaml-v1-3-0ba97fd1ef92@posteo.net>
 <20250221233523.GA372501-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250221233523.GA372501-robh@kernel.org>

On Fri, Feb 21, 2025 at 05:35:23PM -0600, Rob Herring wrote:
> On Thu, Feb 20, 2025 at 06:29:23PM +0100, J. Neuschäfer wrote:
> > Add a binding for the "Gianfar" ethernet controller, also known as
> > TSEC/eTSEC.
> > 
> > Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> > ---
> >  .../devicetree/bindings/net/fsl,gianfar.yaml       | 242 +++++++++++++++++++++
> >  .../devicetree/bindings/net/fsl-tsec-phy.txt       |  39 +---
> >  2 files changed, 243 insertions(+), 38 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/fsl,gianfar.yaml b/Documentation/devicetree/bindings/net/fsl,gianfar.yaml
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..dc75ceb5dc6fdee8765bb17273f394d01cce0710
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/fsl,gianfar.yaml
> > @@ -0,0 +1,242 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/fsl,gianfar.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Freescale Three-Speed Ethernet Controller (TSEC), "Gianfar"
[...]
> > +  "#address-cells": true
> 
> enum: [ 1, 2 ]
> 
> because 3 is not valid here.
> 
> > +
> > +  "#size-cells": true
> 
> enum: [ 1, 2 ]
> 
> because 0 is not valid here.

Good point.

> 
> 
> > +
> > +  cell-index:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  interrupts:
> > +    maxItems: 3
> 
> Based on the if/then schema, you need 'minItems' here if the min is not 3.
> 
> Really, move the descriptions here and make them work for the combined 
> interrupt case (just a guess).

The difference here (as previously documented in prose) is by device
variant:

 for FEC:

   - one combined interrupt

 for TSEC, eTSEC:

   - transmit interrupt
   - receive interrupt
   - error interrupt

Combining these cases might look like this, not sure if it's good:

  interrupts:
    minItems: 1
    description:
      items:
        - Transmit interrupt or combined interrupt
        - Receive interrupt
        - Error interrupt

> 
> > +
> > +  dma-coherent:
> > +    type: boolean
> 
> dma-coherent: true

Will do.


> > +
> > +  fsl,num_rx_queues:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: Number of receive queues
> 
> Constraints? I assume there's at least more than 0.
> 
> > +
> > +  fsl,num_tx_queues:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: Number of transmit queues
> 
> Constraints?

Good point, for both of these the only value I can find in use is 8,
which corresponds to the number of queues documented in at least one
hardware manual (MPC8548E).


> > +  # eTSEC2 controller nodes have "queue group" subnodes and don't need a "reg"
> > +  # property.
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: fsl,etsec2
> > +    then:
> > +      patternProperties:
> > +        "^queue-group@[0-9a-f]+$":
> > +          type: object
> > +
> > +          properties:
> > +            "#address-cells": true
> > +
> > +            "#size-cells": true
> 
> These have no effect if there are not child nodes or a 'ranges' 
> property.

Ah, good point, these properties are used in existing DTs, but I see no
reason to keep them. I'll remove them.

> 
> > +
> > +            reg:
> > +              maxItems: 1
> > +
> > +            interrupts:
> > +              maxItems: 3
> 
> Need to define what each one is.

Will do.


> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    soc1 {
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> 
> You don't need the soc1 node.

Ah, true.

> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    soc2 {
> 
> bus {

Will rename.


Thanks,
J. Neuschäfer


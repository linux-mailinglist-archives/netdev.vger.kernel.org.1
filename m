Return-Path: <netdev+bounces-181673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B322EA860FF
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 16:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77B7C1899A2B
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 14:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0C41DD9AC;
	Fri, 11 Apr 2025 14:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKK8RTdV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF94136A;
	Fri, 11 Apr 2025 14:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744382791; cv=none; b=KF+sswdrbGx1yskjmpMavHNtsx5dStJs/QbotWFJMo53YjIFKDaLT/lsVPF/lG2vhcER6rG45dtvSMNXk0TBm79g96O6cxi2D2mEqrcTzqaj23vDRLA14I2kL2ee8ryhE9JpXhOw2om+Ig4k5bFC5gRy4PvGtwu4FIhKlTL3ABs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744382791; c=relaxed/simple;
	bh=Bv4WfyfmVmF7hRkpF+0ZvKaumGH3BR2ukC/ouCyuHqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRX6fRtPyoV0euCsSQvP+Wv3W3zYSpwlwQ/7h7quE0cVv7qBwU/SqAou5xFyYuBxFhlnnxQZYRT7oufICVBHlXkzp26aHT1GemlXMCn2xJGr4sLH/O+Cn05XQbQtjnNRb/Beq58hoat8I1olPaEkujUFIKwFqNzdiC5igTaYHc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKK8RTdV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A396C4CEEB;
	Fri, 11 Apr 2025 14:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744382790;
	bh=Bv4WfyfmVmF7hRkpF+0ZvKaumGH3BR2ukC/ouCyuHqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qKK8RTdVzRm3FZ76rmw9V7LuFRybMzPQjR9gckgbPmZEQ/b5GS7owyemcvXCMnCjL
	 MHAQF6NDjjimEGSQ32g2Ms/TqzYpr64fItAE18dwvIpjefiivBBVaNJ5gpDHK7wNoC
	 9goeHtWbQcRsKad3LhLeRX/bonO2RgcjDx3HhV1iI7KxYS1SZ3gv4YuH5vXY9mnanc
	 uvqbbiGBEAv7Ck/ljZLLvmrOWqPZtr+E81dr/hJgNdKKPd8GAwS6YPmgoffZ+u5Cz0
	 7R24QoTpvztlS2qjs4CsdPsvz9WZ3DVogauTy65aVc4AQOo53SdQNzTu+20aChjys4
	 N8+Q5fUru5P7g==
Date: Fri, 11 Apr 2025 09:46:29 -0500
From: Rob Herring <robh@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	upstream@airoha.com, Christian Marangi <ansuelsmth@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Robert Hancock <robert.hancock@calian.com>,
	devicetree@vger.kernel.org
Subject: Re: [net-next PATCH v2 01/14] dt-bindings: net: Add Xilinx PCS
Message-ID: <20250411144629.GA3223171-robh@kernel.org>
References: <20250407231746.2316518-1-sean.anderson@linux.dev>
 <20250407231746.2316518-2-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407231746.2316518-2-sean.anderson@linux.dev>

On Mon, Apr 07, 2025 at 07:17:32PM -0400, Sean Anderson wrote:
> Add a binding for the Xilinx 1G/2.5G Ethernet PCS/PMA or SGMII LogiCORE
> IP. This device is a soft device typically used to adapt between GMII
> and SGMII or 1000BASE-X (possbilty in combination with a serdes).
> pcs-modes reflects the modes available with the as configured when the
> device is synthesized. Multiple modes may be specified if dynamic
> reconfiguration is supported.
> 
> One PCS may contain "shared logic in core" which can be connected to
> other PCSs with "shared logic in example design." This primarily refers
> to clocking resources, allowing a reference clock to be shared by a bank
> of PCSs. To support this, if #clock-cells is defined then the PCS will
> register itself as a clock provider for other PCSs.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
> Changes in v2:
> - Change base compatible to just xlnx,pcs
> - Drop #clock-cells description
> - Move #clock-cells after compatible
> - Remove second example
> - Rename pcs-modes to xlnx,pcs-modes
> - Reword commit message
> 
>  .../devicetree/bindings/net/xilinx,pcs.yaml   | 115 ++++++++++++++++++
>  1 file changed, 115 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/xilinx,pcs.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/xilinx,pcs.yaml b/Documentation/devicetree/bindings/net/xilinx,pcs.yaml
> new file mode 100644
> index 000000000000..f9ec032127cf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/xilinx,pcs.yaml
> @@ -0,0 +1,115 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/xilinx,pcs.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx 1G/2.5G Ethernet PCS/PMA or SGMII LogiCORE IP
> +
> +maintainers:
> +  - Sean Anderson <sean.anderson@seco.com>
> +
> +description:

Needs '>' modifier for paragraphs.

With that,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

> +  This is a soft device which implements the PCS and (depending on
> +  configuration) PMA layers of an IEEE Ethernet PHY. On the MAC side, it
> +  implements GMII. It may have an attached SERDES (internal or external), or
> +  may directly use LVDS IO resources. Depending on the configuration, it may
> +  implement 1000BASE-X, SGMII, 2500BASE-X, or 2.5G SGMII.
> +
> +  This device has a notion of "shared logic" such as reset and clocking
> +  resources which must be shared between multiple PCSs using the same I/O
> +  banks. Each PCS can be configured to have the shared logic in the "core"
> +  (instantiated internally and made available to other PCSs) or in the "example
> +  design" (provided by another PCS). PCSs with shared logic in the core are
> +  reset controllers, and generally provide several resets for other PCSs in the
> +  same bank.


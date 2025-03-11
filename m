Return-Path: <netdev+bounces-173999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD40A5CF2A
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 20:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F8B517953F
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 19:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254992641F0;
	Tue, 11 Mar 2025 19:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnzpMvk0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB62A2641E8;
	Tue, 11 Mar 2025 19:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741720822; cv=none; b=tsnlhR7HFH+je4xZRwYMBcxKF0kQ+/+sBciuuBgEHYmkOWrP6yHbsBXsaCogbJ5bpefR8NF6zjBeLtalGQadOI5BeBd7Tq/8qsFlme/MHNOO7XUXcHKObnnHkwm8cdViyG64UPXgq6kvKUZ77XY6TOn/Uoea7aknbulZjb6GLOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741720822; c=relaxed/simple;
	bh=kcpuPf65uj8+Xtj1e9eOmZyXND0tqkIgzzMQ+yLTfRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXOqv0J3YJMGN3myWbgp3uFhJHhRcXVh2PbIZ5LtiNE1KUlsi2u8QIW9UhAv2DYIoRJ5Pk7IvwLWnl/a9BNPEiQATZxZ/CpErwuWs/RqM2ukaTKC+xXmkFwXhjKbBSmYm9cUb42ZLPNd4NniRPeXUydzUT74mDmpRIUMT9hYjNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnzpMvk0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2667BC4CEE9;
	Tue, 11 Mar 2025 19:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741720821;
	bh=kcpuPf65uj8+Xtj1e9eOmZyXND0tqkIgzzMQ+yLTfRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KnzpMvk0sZD2ybFPnFuUmHST+AHXtX+XKsjOttTZFgArB5KLfUeESvN6y3+9+rnvV
	 zvBj0jTFY0ExBrdPpeJKq76DplD1a30rUmSPJFLcPBG3mS/lYfSKymTCjNF7SrQY2/
	 zfE7Z3vjDtaCDNORb4zfB/ZhF8mBtDq2Wa8R2kC8NXHwXd6druJpSOsDpOI85Z3k3a
	 Jd7VGh5yRZmaTG5uABfqNuOwqiaD9WrGSpRlxkGqXqs7yOJjoFX794Bfj+8N5dk85d
	 1CsQpuPwHE2QYmpwVFE4iOCRfCvzB2jrBT+bCeiE1cltEk5loeXcgCKrrtNdP/QIrZ
	 3A7illovJkQUw==
Date: Tue, 11 Mar 2025 14:20:19 -0500
From: Rob Herring <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v12 03/13] dt-bindings: net: dsa: Document
 support for Airoha AN8855 DSA Switch
Message-ID: <20250311192019.GA4067643-robh@kernel.org>
References: <20250309172717.9067-1-ansuelsmth@gmail.com>
 <20250309172717.9067-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309172717.9067-4-ansuelsmth@gmail.com>

On Sun, Mar 09, 2025 at 06:26:48PM +0100, Christian Marangi wrote:
> Document support for Airoha AN8855 5-port Gigabit Switch.
> 
> It does expose the 5 Internal PHYs on the MDIO bus and each port
> can access the Switch register space by configurting the PHY page.
> 
> Each internal PHY might require calibration with the fused EFUSE on
> the switch exposed by the Airoha AN8855 SoC NVMEM.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../net/dsa/airoha,an8855-switch.yaml         | 105 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml b/Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
> new file mode 100644
> index 000000000000..63bcbebd6a29
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/dsa/airoha,an8855-switch.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Airoha AN8855 Gigabit Switch
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +description: >
> +  Airoha AN8855 is a 5-port Gigabit Switch.
> +
> +  It does expose the 5 Internal PHYs on the MDIO bus and each port
> +  can access the Switch register space by configurting the PHY page.
> +
> +  Each internal PHY might require calibration with the fused EFUSE on
> +  the switch exposed by the Airoha AN8855 SoC NVMEM.
> +
> +$ref: dsa.yaml#

This needs to be:

dsa.yaml#/$defs/ethernet-ports

As that restricts custom properties.

> +
> +properties:
> +  compatible:
> +    const: airoha,an8855-switch
> +
> +  reset-gpios:
> +    description:
> +      GPIO to be used to reset the whole device
> +    maxItems: 1
> +
> +  airoha,ext-surge:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Calibrate the internal PHY with the calibration values stored in EFUSE
> +      for the r50Ohm values.

Should you be using nvmem binding to the efuse block? Or the efuses are 
within this block?

> +
> +required:
> +  - compatible
> +
> +unevaluatedProperties: false


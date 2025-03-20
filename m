Return-Path: <netdev+bounces-176547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7D4A6AC09
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 18:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E8883AC010
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 17:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2A02236EB;
	Thu, 20 Mar 2025 17:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L60tobDY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A43529CE6;
	Thu, 20 Mar 2025 17:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742491921; cv=none; b=UnMyguEI41Hrf2tjYDbAlrXyj4aKoMuul9o5uvuZyRTcz6uBHYO9lhLwl5R2MagODfNiQet/e4ooqmZfrpoC+6zYSTxprNqrfDStyKvzq4TCGChgZmtU8EOF2Q7c02wiqm+eWEjc37dMrcBDWeCkovIZCTtYlxSSWn1AKDLrjpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742491921; c=relaxed/simple;
	bh=3HOTPhubQPxetyMqoktnFvF63Tzt8GgfFAKqGmDS3xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYtmESK9N4IBi6AcaqwXAK15UqmJ23qPnM6YKfmE0zmCx1j+sGL5oaLOjIwcTTUQH+asmiRrk07dWQBIOuDLJkkB+ITRAZmX4kSSbYZPqx6aFQSJIdHuzDjdWkiHw95COUiKVG+eKTt99MR0RId9dTSSvLvj8UGn1GsjrLomoYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L60tobDY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CE7C4CEE7;
	Thu, 20 Mar 2025 17:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742491920;
	bh=3HOTPhubQPxetyMqoktnFvF63Tzt8GgfFAKqGmDS3xw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L60tobDYIbX0us2wQjzggEFQMCohxpSUt5d48FIZ6+R4ieavMitBq05mXTA4yrtvC
	 DKO7zbZc+tNrMOAU6seLeunDoYbbJWRW7ThKQMWnvfpFLtnrilpL1VKz290J5GJLOB
	 WHO6Y/EDPfX0Axxf8x4ljDRo+2Oa2DD6GrLL9JDK/ps4YnFsZcne1EMPpuiQRjSmwl
	 am/zcQZyNiDoO1EuYKuXNHfmaVVEhyvzm2VjiRAEkD8X5ee2YKN/k3R/nXARfi2sJa
	 ekEBzjTVTt64hgJEy+pFYujcywwSTHdX1SKfygy7KhAczBGGBdtr98QU6JtANpdBBN
	 6q9VN2uvlWBEg==
Date: Thu, 20 Mar 2025 17:31:54 +0000
From: Simon Horman <horms@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
Subject: Re: [net-next PATCH v12 02/13] dt-bindings: net: Document support
 for Airoha AN8855 Switch Virtual MDIO
Message-ID: <20250320173154.GE892515@horms.kernel.org>
References: <20250309172717.9067-1-ansuelsmth@gmail.com>
 <20250309172717.9067-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309172717.9067-3-ansuelsmth@gmail.com>

On Sun, Mar 09, 2025 at 06:26:47PM +0100, Christian Marangi wrote:
> Document support for Airoha AN8855 Virtual MDIO Passtrough. This is needed

nit: passthrough

> as AN8855 require special handling as the same address on the MDIO bus is
> shared for both Switch and PHY and special handling for the page
> configuration is needed to switch accessing to Switch address space
> or PHY.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/net/airoha,an8855-mdio.yaml      | 56 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml b/Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
> new file mode 100644
> index 000000000000..3078277bf478
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/airoha,an8855-mdio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Airoha AN8855 MDIO Passtrough

Ditto.

> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +description:
> +  Airoha AN8855 Virtual MDIO Passtrough. This is needed as AN8855

Ditto.

> +  require special handling as the same address on the MDIO bus is
> +  shared for both Switch and PHY and special handling for the page
> +  configuration is needed to switch accessing to Switch address space
> +  or PHY.

...


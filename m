Return-Path: <netdev+bounces-200524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72282AE5DAC
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 09:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F3FB188C3A8
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 07:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EA5255E34;
	Tue, 24 Jun 2025 07:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gukn8GYs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CB624EA85;
	Tue, 24 Jun 2025 07:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750750126; cv=none; b=g1WvrpTxne0P6s514wSqk+3FdkitxxclbBJrf805L5gZxrNgLtgUuOnFx6qNrHG3aZySwZICLqUzr9+a511MS3bKfDbEE8n32FdgOYGH6Xl+F5HIpWB90xth81PIGf0V9x4to0jB7UYyx/9ePi+3bgkE8+bfvJONBw+fY9M5Y4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750750126; c=relaxed/simple;
	bh=g0pXc/fIN30kvH2Virs4nkVnamuyy0huOlw1+j0TCiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5nb35kzmqObpReTOqCii6eV1iMi2sX/JA+0QoalAlHDkCoogWTFBDFgZ5TOygyEfUG5lsz4Qo/v+yiV8uZcSHg6uJ7eHrARBWKj+5wdgvikfLso+x1dMM56zGx2QWBB3mmZe46cuhk9A4T8FYk4B5VC8Wjg4AJqLngX/P6xBts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gukn8GYs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532B9C4CEE3;
	Tue, 24 Jun 2025 07:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750750126;
	bh=g0pXc/fIN30kvH2Virs4nkVnamuyy0huOlw1+j0TCiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gukn8GYs+wpCJs8dwZyrg7QtHcLeHxgvHUf5Q6yYFg2C9BOEmDGLZizI6sGEa26dd
	 AXs2VFgQ42jn313Jggk4V0ILiINJVwDGLMci1cSQWA/Wnat7vTWZPJqUqLwIF40C2w
	 DB5SetH/wVRGB4WLiqemm7k1keA5ZvZmhtE6Frd6ifdr8+9XFWkT36y+r7uY0iPWVK
	 7wqVd1s0PcAv5xA2AqsBduQdkOjE/CGEwb+m9pvBvE3rpcfh+prPNg4r7+X/NZWbZj
	 vz5KuBRA5M7nLhYwD3ZCbZbORFWCzuMpELU5hnh9Hkq8OxdNOzUNWWy2+/pxZnl9TL
	 tv2j3pfN4Gt8w==
Date: Tue, 24 Jun 2025 09:28:43 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Joy Zou <joy.zou@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, catalin.marinas@arm.com, will@kernel.org, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	ulf.hansson@linaro.org, richardcochran@gmail.com, kernel@pengutronix.de, 
	festevam@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-pm@vger.kernel.or, frank.li@nxp.com, ye.li@nxp.com, 
	ping.bai@nxp.com, aisheng.dong@nxp.com
Subject: Re: [PATCH v6 2/9] dt-bindings: soc: imx-blk-ctrl: add i.MX91
 blk-ctrl compatible
Message-ID: <urgfsmkl25woqy5emucfkqs52qu624po6rd532hpusg3fdnyg3@s5iwmhnfsi26>
References: <20250623095732.2139853-1-joy.zou@nxp.com>
 <20250623095732.2139853-3-joy.zou@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250623095732.2139853-3-joy.zou@nxp.com>

On Mon, Jun 23, 2025 at 05:57:25PM +0800, Joy Zou wrote:
> Add new compatible string "fsl,imx91-media-blk-ctrl" for i.MX91,
> which has different input clocks compared to i.MX93. Update the
> clock-names list and handle it in the if-else branch accordingly.
> 
> Keep the same restriction for the existed compatible strings.
> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---
> Changes for v5:
> 1. modify the imx93-blk-ctrl binding for imx91 support.

This is just vague. Anything can be "modify". Why are you doing this?
What are you doing here?

> ---
>  .../soc/imx/fsl,imx93-media-blk-ctrl.yaml     | 55 +++++++++++++++----
>  1 file changed, 43 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
> index b3554e7f9e76..db5ee65f8eb8 100644
> --- a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
> +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
> @@ -18,7 +18,9 @@ description:
>  properties:
>    compatible:
>      items:
> -      - const: fsl,imx93-media-blk-ctrl
> +      - enum:
> +          - fsl,imx91-media-blk-ctrl
> +          - fsl,imx93-media-blk-ctrl
>        - const: syscon
>  
>    reg:
> @@ -31,21 +33,50 @@ properties:
>      maxItems: 1
>  
>    clocks:
> +    minItems: 8
>      maxItems: 10
>  
>    clock-names:
> -    items:
> -      - const: apb
> -      - const: axi
> -      - const: nic
> -      - const: disp
> -      - const: cam
> -      - const: pxp
> -      - const: lcdif
> -      - const: isi
> -      - const: csi
> -      - const: dsi
> +    minItems: 8
> +    maxItems: 10
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,imx93-media-blk-ctrl
> +    then:
> +      properties:

Missing constraints for clocks

> +        clock-names:
> +          items:
> +            - const: apb
> +            - const: axi
> +            - const: nic
> +            - const: disp
> +            - const: cam
> +            - const: pxp
> +            - const: lcdif
> +            - const: isi
> +            - const: csi
> +            - const: dsi

Keep list in comon part.

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,imx91-media-blk-ctrl

This should be before if: for imx93. 91 < 93

> +    then:
> +      properties:

Why imx91 now has 10 clocks?

v6 and this has basic issues. The quality of NXP patches decreases :/

> +        clock-names:
> +          items:
> +            - const: apb
> +            - const: axi
> +            - const: nic
> +            - const: disp
> +            - const: cam
> +            - const: lcdif
> +            - const: isi
> +            - const: csi

No, look at other bindings how they share clock lists.

Best regards,
Krzysztof



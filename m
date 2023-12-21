Return-Path: <netdev+bounces-59573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5949281B5C1
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 13:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13E46285F54
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 12:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D2A6E5A4;
	Thu, 21 Dec 2023 12:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGCmU/UP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647F06EB4D;
	Thu, 21 Dec 2023 12:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA82C433C8;
	Thu, 21 Dec 2023 12:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703161683;
	bh=J2GyZ8aGWp7U98Pt2mOw9MgQsZYwZuIkfyz563PoLJE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vGCmU/UP6emTfpnku2LK8WhzlJtNBm0gInWGLiJwT1pK5dlFdWmmvu/IQCbLKRvMn
	 onWiX0ramxB7xXhsRoA2X2yK0Tu1AvdJJH5ZcLAwQHQfw5rsltGUwdoDEHb/Twwv5P
	 JqL05R8B1tPbBfQQICKplp6BXQm/5XkZ5hdjXE2cVHcuYvR8yMWRpbR2D4pk1KJX93
	 3Rgx3m1GK1UsieoQer5CGjr6n+vl4/IWn5LLRfJh+i6uePjCmEPRmd4EyKUdqwbTRe
	 G6yOu8ky5T6eL6Jp81XbeWf5UBUxgpshG/Ox/mU0Jnk6PKmg1QJ9AJChTH+9BfvL6R
	 4N3RKrCii2X1A==
Message-ID: <37f1df31-82c7-49ae-8f21-0939b04115e6@kernel.org>
Date: Thu, 21 Dec 2023 14:27:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next 1/8] dt-bindings: net: Add support for AM65x
 SR1.0 in ICSSG
Content-Language: en-US
To: Diogo Ivo <diogo.ivo@siemens.com>, danishanwar@ti.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>
References: <20231219174548.3481-1-diogo.ivo@siemens.com>
 <20231219174548.3481-2-diogo.ivo@siemens.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231219174548.3481-2-diogo.ivo@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 19/12/2023 19:45, Diogo Ivo wrote:
> Silicon Revision 1.0 of the AM65x came with a slightly different ICSSG
> support: Only 2 PRUs per slice are available and instead 2 additional
> DMA channels are used for management purposes. We have no restrictions
> on specified PRUs, but the DMA channels need to be adjusted.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
> ---
>  .../bindings/net/ti,icssg-prueth.yaml         | 62 +++++++++++++------
>  1 file changed, 44 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> index 229c8f32019f..fbe51731854a 100644
> --- a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> +++ b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> @@ -19,30 +19,15 @@ allOf:
>  properties:
>    compatible:
>      enum:
> -      - ti,am642-icssg-prueth  # for AM64x SoC family
> -      - ti,am654-icssg-prueth  # for AM65x SoC family
> +      - ti,am642-icssg-prueth      # for AM64x SoC family
> +      - ti,am654-icssg-prueth      # for AM65x SoC family, SR2.x

You don't need to explicitly mention SR2.x here and in the rest of the patches.
That way there are fewer changes.

> +      - ti,am654-icssg-prueth-sr1  # for AM65x SoC family, SR1.0
>  
>    sram:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description:
>        phandle to MSMC SRAM node
>  
> -  dmas:
> -    maxItems: 10
> -
> -  dma-names:
> -    items:
> -      - const: tx0-0
> -      - const: tx0-1
> -      - const: tx0-2
> -      - const: tx0-3
> -      - const: tx1-0
> -      - const: tx1-1
> -      - const: tx1-2
> -      - const: tx1-3
> -      - const: rx0
> -      - const: rx1
> -
>    ti,mii-g-rt:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description:
> @@ -122,6 +107,47 @@ properties:
>        - required:
>            - port@1
>  
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - ti,am654-icssg-prueth-sr1
> +then:
> +  properties:
> +    dmas:
> +      maxItems: 12
> +    dma-names:
> +      items:
> +        - const: tx0-0
> +        - const: tx0-1
> +        - const: tx0-2
> +        - const: tx0-3
> +        - const: tx1-0
> +        - const: tx1-1
> +        - const: tx1-2
> +        - const: tx1-3
> +        - const: rx0
> +        - const: rx1
> +        - const: rxmgm0
> +        - const: rxmgm1
> +else:
> +  properties:
> +    dmas:
> +      maxItems: 10
> +    dma-names:
> +      items:
> +        - const: tx0-0
> +        - const: tx0-1
> +        - const: tx0-2
> +        - const: tx0-3
> +        - const: tx1-0
> +        - const: tx1-1
> +        - const: tx1-2
> +        - const: tx1-3
> +        - const: rx0
> +        - const: rx1
> +
>  required:
>    - compatible
>    - sram

-- 
cheers,
-roger


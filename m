Return-Path: <netdev+bounces-161361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 316B3A20D61
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E6D518822F3
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 15:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7E41CF5E2;
	Tue, 28 Jan 2025 15:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPoFvl2F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5241AAE0D;
	Tue, 28 Jan 2025 15:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738079139; cv=none; b=kEOcOeCYkS3rHlc5/kjfAwNZMQB+OaXGOX5YQD6nyYqhrMA1k0u8e3eDHOUsTk0LC2kAMLDY7ke+P8nzpXZ/TDTaY0srK4q2il2M6nhIs9cKKA0XZw7l8/iC7YNLSJYZd2AvDOVsXoGUcvf69XikKiDkwV+r1VunL/fjFklxP84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738079139; c=relaxed/simple;
	bh=y5fiGOpqHsjA5txZTC792Ta1uJ8fD21vvbxKBCkhSwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2rBfU5ThkFWHQcrPJVbaF13DyI+SN0hVwDuv19+xlnZwR4BBgc1xPmjEKjX2sK+qxpKxJEazgtSbgocCAoQVFR9w1yS2fa8MyfG0BLGnCf3tlZZLJZUW90/xzN+IQH4JO6GzU3472HK1ku25WdrS+AA2dqJzC8vRJR1XVL3Krk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPoFvl2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE9EC4CED3;
	Tue, 28 Jan 2025 15:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738079139;
	bh=y5fiGOpqHsjA5txZTC792Ta1uJ8fD21vvbxKBCkhSwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PPoFvl2FNra+3ckqpvLYQ20USwf3/15iHNEjTckFICgs2tuHlAlYKYTP0rkMEset1
	 +7+d+0SHBn/GgPvU5ceG5sebvE0j3K0cciKjUD7+tEYR9qYWc8cGOw4Wc2hpb3uWFv
	 iC8P+SoIQItyVKJQPgU8T/w50bAnmdh9z6/9GfdBExaxHwPFY5o/rXUy0qs12oU2J3
	 KmQimFQVwb9+qvwfBqDMGKa7BVNhEABtAkKzYVMTwNHARi2lO2FhRJzKBPH3FcXTXK
	 Ef0TAu9UF2NFaBmsbEJx01KpyWggysiT2/b7kqNKivKBCWXnxUpgkRZ2FDcqNnyM6b
	 nYAR8cq2vDu1A==
Date: Tue, 28 Jan 2025 09:45:38 -0600
From: Rob Herring <robh@kernel.org>
To: Swathi K S <swathi.ks@samsung.com>
Cc: krzk@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, conor+dt@kernel.org,
	richardcochran@gmail.com, mcoquelin.stm32@gmail.com, andrew@lunn.ch,
	alim.akhtar@samsung.com, linux-fsd@tesla.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, alexandre.torgue@foss.st.com,
	peppe.cavallaro@st.com, joabreu@synopsys.com, rcsekar@samsung.com,
	ssiddha@tesla.com, jayati.sahu@samsung.com,
	pankaj.dubey@samsung.com, ravi.patel@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v5 1/4] dt-bindings: net: Add FSD EQoS device tree
 bindings
Message-ID: <20250128154538.GA3539469-robh@kernel.org>
References: <20250128102558.22459-1-swathi.ks@samsung.com>
 <CGME20250128102725epcas5p44b02ac2980a3aeb0016ce9fdef011ecf@epcas5p4.samsung.com>
 <20250128102558.22459-2-swathi.ks@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128102558.22459-2-swathi.ks@samsung.com>

On Tue, Jan 28, 2025 at 03:55:55PM +0530, Swathi K S wrote:
> Add FSD Ethernet compatible in Synopsys dt-bindings document. Add FSD
> Ethernet YAML schema to enable the DT validation.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Ravi Patel <ravi.patel@samsung.com>
> Signed-off-by: Swathi K S <swathi.ks@samsung.com>
> ---
>  .../devicetree/bindings/net/snps,dwmac.yaml   |  5 +-
>  .../bindings/net/tesla,fsd-ethqos.yaml        | 91 +++++++++++++++++++
>  2 files changed, 94 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/tesla,fsd-ethqos.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index 91e75eb3f329..2243bf48a0b7 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -103,6 +103,7 @@ properties:
>          - starfive,jh7100-dwmac
>          - starfive,jh7110-dwmac
>          - thead,th1520-gmac
> +        - tesla,fsd-ethqos
>  
>    reg:
>      minItems: 1
> @@ -126,7 +127,7 @@ properties:
>  
>    clocks:
>      minItems: 1
> -    maxItems: 8
> +    maxItems: 10
>      additionalItems: true
>      items:
>        - description: GMAC main clock
> @@ -138,7 +139,7 @@ properties:
>  
>    clock-names:
>      minItems: 1
> -    maxItems: 8
> +    maxItems: 10
>      additionalItems: true
>      contains:
>        enum:
> diff --git a/Documentation/devicetree/bindings/net/tesla,fsd-ethqos.yaml b/Documentation/devicetree/bindings/net/tesla,fsd-ethqos.yaml
> new file mode 100644
> index 000000000000..579a7bd1701d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/tesla,fsd-ethqos.yaml
> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/tesla,fsd-ethqos.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: FSD Ethernet Quality of Service
> +
> +maintainers:
> +  - Swathi K S <swathi.ks@samsung.com>
> +
> +description:
> +  Tesla ethernet devices based on dwmmac support Gigabit ethernet.
> +
> +allOf:
> +  - $ref: snps,dwmac.yaml#
> +
> +properties:
> +  compatible:
> +    const: tesla,fsd-ethqos.yaml

Humm...


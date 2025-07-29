Return-Path: <netdev+bounces-210860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30955B15262
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 19:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2241885BA0
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 17:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F064298CD5;
	Tue, 29 Jul 2025 17:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4iKMO1R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14605298CB1;
	Tue, 29 Jul 2025 17:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753811655; cv=none; b=J3lRQymJqH2Zm7pFhDZEbRMsC+2jOLwGiOt61XrlRyIRDGbhu48Z1+qhTWPVkWRYXXNfNIEn0i80BTFGh1h74E+H4Rlhrdo4D1n30LCtQzyf5IcVh+1SNL/FeX3/htMxbXksvh3jTPPxqVhNsfOMqAgbkVIL05xrEiqYEUVnLes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753811655; c=relaxed/simple;
	bh=J6y7muyFDzOpaWbidr++rX+I7mcOedEEEF1hRm5TL9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATncG86X9kYYhA8ASzxi0NamVM52nTPAQKtsEqmuf1Z+/jqKJYkXqlUGrMlRVymwDcM1yFGud4MkLN+QKF09xHpdP5cKuqxRdGwSqoH0+W76QgSHcx4HOV83Vj2rDXIByjhVEB/RQtg6wck0wY9fGxsAQBG6fuzBsIQj1hoaeBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4iKMO1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585CDC4CEF4;
	Tue, 29 Jul 2025 17:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753811654;
	bh=J6y7muyFDzOpaWbidr++rX+I7mcOedEEEF1hRm5TL9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d4iKMO1R9RObKxmf2UyIzWWqHARsbZ+po8iimkSzRynrxyAPla44caaU0nbDr4YvS
	 MlBR3YcpjA14F/lXXIZnm09ursqrw1Il9rsl32RoTvFMtPwGNwMtSKg8oPakc1b3Cr
	 k4ZXntCF81Q50cKGaVued3T+Zrg4B5PuXkt0nb+QHTErPx2qadZCcbsce1YhR2ElSg
	 ubzceejBv/ihLj49353LlJMO9lIEtmHQvuPbDkPKODBRVHmC5fDwbmO0cxk63K/4g9
	 ZAf0z0wL6S7tnCrnwMhi61F5/rpdUe2u3vxxRmPDAOETpoIowlKEkAFOA7TMpaT0QF
	 QYBJmSUzyjBcw==
Date: Tue, 29 Jul 2025 10:54:12 -0700
From: Drew Fustini <fustini@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Jisheng Zhang <jszhang@kernel.org>, linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/3] dt-bindings: net: thead,th1520-gmac: Describe
 APB interface clock
Message-ID: <aIkKxM3zfVjaa1we@x1>
References: <20250729093734.40132-1-ziyao@disroot.org>
 <20250729093734.40132-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729093734.40132-2-ziyao@disroot.org>

On Tue, Jul 29, 2025 at 09:37:32AM +0000, Yao Zi wrote:
> Besides ones for GMAC core and peripheral registers, the TH1520 GMAC
> requires one more clock for configuring APB glue registers. Describe
> it in the binding.
> 
> Though the clock is essential for operation, it's not marked as required
> for now to avoid introducing new dt-binding warnings to existing dts.
> 
> Fixes: f920ce04c399 ("dt-bindings: net: Add T-HEAD dwmac support")
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  .../devicetree/bindings/net/thead,th1520-gmac.yaml        | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml b/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
> index 6d9de3303762..fea9fbc1d006 100644
> --- a/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
> +++ b/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
> @@ -59,14 +59,18 @@ properties:
>        - const: apb
>  
>    clocks:
> +    minItems: 2
>      items:
>        - description: GMAC main clock
>        - description: Peripheral registers interface clock
> +      - description: APB glue registers interface clock
>  
>    clock-names:
> +    minItems: 2
>      items:
>        - const: stmmaceth
>        - const: pclk
> +      - const: apb
>  
>    interrupts:
>      items:
> @@ -88,8 +92,8 @@ examples:
>          compatible = "thead,th1520-gmac", "snps,dwmac-3.70a";
>          reg = <0xe7070000 0x2000>, <0xec003000 0x1000>;
>          reg-names = "dwmac", "apb";
> -        clocks = <&clk 1>, <&clk 2>;
> -        clock-names = "stmmaceth", "pclk";
> +        clocks = <&clk 1>, <&clk 2>, <&clk 3>;
> +        clock-names = "stmmaceth", "pclk", "apb";
>          interrupts = <66>;
>          interrupt-names = "macirq";
>          phy-mode = "rgmii-id";
> -- 
> 2.50.1
> 

Thanks for figuring out that this clock is needed for the APB glue
registers. The schema passes W=1 dt_binding_check with no warnings.

Regarding minItems, I think it would be okay to change to 3 as the APB
clock should have been there from the start but I missed it. We can fix
the in-tree dts at the same time so that seems okay to me. But let's see
what the dt bindings maintainers think.

-Drew


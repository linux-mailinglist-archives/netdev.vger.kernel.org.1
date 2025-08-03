Return-Path: <netdev+bounces-211492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E513DB194CD
	for <lists+netdev@lfdr.de>; Sun,  3 Aug 2025 20:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946AF1890952
	for <lists+netdev@lfdr.de>; Sun,  3 Aug 2025 18:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789601E98E6;
	Sun,  3 Aug 2025 18:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCIvEGXx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B19142AA1;
	Sun,  3 Aug 2025 18:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754246492; cv=none; b=DCPRoOixiKttL32UGdIhFdiO4tHTc7SDoGl01I2WkYG1etOFHBKiRdaVWpZv2C/h3O/Ba6G3OLEpcg3GDpT9ydXs7N4m3g+WWIfg6SVMQ1KQFeHEhJkGFihGwfvU2ig0Q6CiXYVH1/KSc2tnxaSkBkPQOjeprnkGdTrHfFUA06Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754246492; c=relaxed/simple;
	bh=pJSchiabA1YRkiP0bPpnxJ359/pK8eXxW74NJWXuqas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRSGs3xSbKN5QqYXE0r+lgvi9ksiG6bkxt21qWiWnYeTUq4KemD7cd0acvF1K7in6pfvwDfRKxAdmMV71Kwo5u3zi3oow2XK3OweQVngWDcRQsVzFJoP0ixvhVkNEinixTfemHk0P00UuGMwzeM5ucIufN8uGxi1Um+YRbK0C1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCIvEGXx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE3DC4CEEB;
	Sun,  3 Aug 2025 18:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754246491;
	bh=pJSchiabA1YRkiP0bPpnxJ359/pK8eXxW74NJWXuqas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SCIvEGXxXcaJO7lhp3U+LpgyENujnhMCxTpx6ocsZeW1drmbEMm4p4oYQIZTp8V/Q
	 85IpAkiJem8EkFX+fPMj66W0/8QFgLr8O7T3AYpal4jC2NgoTZZWQ+cG1zYxZqKFmN
	 KpJDKxFJdRtko9VgrbcjDVh8KaLrg3UDvTtyY9I8rxUPMQ6RXNZrTP+4i3OuOKL7Kh
	 v3qd7fjIMPxeN2oVQLbM89wIkipSg+PCzkM25wGrHxfhAlbpNtDeo7pjVIpTQ4t7Aq
	 0O7cxtRStpGSu26pbtUAgbuDEt4GPTvoqUnrI6+3ZJ/h5wCiexuxjNd/IyJ1gASew+
	 SkC8ae8zIAJMA==
Date: Sun, 3 Aug 2025 11:41:27 -0700
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
Subject: Re: [PATCH net v2 1/3] dt-bindings: net: thead,th1520-gmac: Describe
 APB interface clock
Message-ID: <aI-tV0qk6fGP7yJ-@gen8>
References: <20250801091240.46114-1-ziyao@disroot.org>
 <20250801091240.46114-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801091240.46114-2-ziyao@disroot.org>

On Fri, Aug 01, 2025 at 09:12:38AM +0000, Yao Zi wrote:
> Besides ones for GMAC core and peripheral registers, the TH1520 GMAC
> requires one more clock for configuring APB glue registers. Describe
> it in the binding.
> 
> Fixes: f920ce04c399 ("dt-bindings: net: Add T-HEAD dwmac support")
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> Tested-by: Drew Fustini <fustini@kernel.org>
> ---
>  .../devicetree/bindings/net/thead,th1520-gmac.yaml          | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml b/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
> index 6d9de3303762..b3492a9aa4ef 100644
> --- a/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
> +++ b/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
> @@ -62,11 +62,13 @@ properties:
>      items:
>        - description: GMAC main clock
>        - description: Peripheral registers interface clock
> +      - description: APB glue registers interface clock
>  
>    clock-names:
>      items:
>        - const: stmmaceth
>        - const: pclk
> +      - const: apb
>  
>    interrupts:
>      items:
> @@ -88,8 +90,8 @@ examples:
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

Reviewed-by: Drew Fustini <fustini@kernel.org>

Thank you for making all 3 clocks required.

Drew




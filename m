Return-Path: <netdev+bounces-139399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3199B2066
	for <lists+netdev@lfdr.de>; Sun, 27 Oct 2024 21:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C09E1F21A26
	for <lists+netdev@lfdr.de>; Sun, 27 Oct 2024 20:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8272617C7C4;
	Sun, 27 Oct 2024 20:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdvjmXHB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56656B640;
	Sun, 27 Oct 2024 20:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730061360; cv=none; b=oUBJWv7akzZqzG6wz4A/HDE7fu0X1SK4CRCc7kqLwlkMHnYwj8BWE4r+Bgw/9DaKtyak1Ef6zhHSvVprUFCyS8/1IJwh4vPQ/mAI5BagnSYEZ1QhMHabkxRpb5lleL3euCWlSC1qcpW7GjesiYLXiCmbKwCj8UG02PwEfZ38BeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730061360; c=relaxed/simple;
	bh=6Pmsfn3UxhCWmSXYNuTtCkIJ/1rryCxBFsSk1I6wK2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVYePxvbT+iKnQZ0lyw8eI9nmWcNkwzi80EQ6M5HHjAGs0FPttrCYaBEsBS2Y8nM9OaV/WW7E6Hr7mrcrSTjqDoVwi3e6nTrXr2YgfGXkdpl/+nbQwj0oL1UWx+HW4JGkOMRl5UZzgIOuMK08px2OulmRxkaMgrRlovH0I0BjEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdvjmXHB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D846DC4CEC3;
	Sun, 27 Oct 2024 20:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730061359;
	bh=6Pmsfn3UxhCWmSXYNuTtCkIJ/1rryCxBFsSk1I6wK2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GdvjmXHBclQ+H8qDqDMxr5h/OZYeOxS82/fn0aRZvoXukCGft7x+1LDtIQUayJ/hs
	 aO5+GssudxAnfBqG4biD7EdXt4Jm6YMCb/CW8qi0GKkJfEJJnom0yhuzQbl3SRp7IB
	 DbajJdz3LcCQ/Y6RaUbWKFnC1dy4JOrZnGoqBW4JLqMQPiWebtF/n2xq8ZAp91afbU
	 BWI+cUyQ0bfW4HllsfTAQrhdQ4upyKhCx41mZFuxSkyO1vZt5ZIMNnM+mcu1J9TZEx
	 hrNRM1YcwCKjgd12r3Zd0qkxfGq03GZFokyls7HNHDhUI6Qp/z1OapcYekJzcroe6j
	 rE0uJrB+65LBA==
Date: Sun, 27 Oct 2024 21:35:56 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Chen Wang <unicorn_wang@outlook.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Inochi Amaoto <inochiama@outlook.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/4] dt-bindings: net: snps,dwmac: Add dwmac-5.30a
 version
Message-ID: <c7ue72h3wvzgpcr3joqrtchoy4352ibsp63cpqps2y77oek6k4@5nd54nyk6mpx>
References: <20241025011000.244350-1-inochiama@gmail.com>
 <20241025011000.244350-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241025011000.244350-2-inochiama@gmail.com>

On Fri, Oct 25, 2024 at 09:09:57AM +0800, Inochi Amaoto wrote:
> Add compatible string for dwmac-5.30a IP.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index 4e2ba1bf788c..3c4007cb65f8 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -31,6 +31,7 @@ select:
>            - snps,dwmac-4.20a
>            - snps,dwmac-5.10a
>            - snps,dwmac-5.20
> +          - snps,dwmac-5.30a

Same as for Enclustra patchset... this is incomplete approach. These are
just fallbacks, visible by "contains" keyword and you should come with
proper specific compatible. Look how other compatibles are arranged.

Best regards,
Krzysztof



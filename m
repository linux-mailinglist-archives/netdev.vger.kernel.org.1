Return-Path: <netdev+bounces-154295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1749FCB17
	for <lists+netdev@lfdr.de>; Thu, 26 Dec 2024 14:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81571882F25
	for <lists+netdev@lfdr.de>; Thu, 26 Dec 2024 13:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF7B1D4612;
	Thu, 26 Dec 2024 13:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="GnuPGQvy"
X-Original-To: netdev@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EA2186E2E;
	Thu, 26 Dec 2024 13:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735218995; cv=none; b=DXC54BWb8PvrYO2hh1LL+PrFr+/rZqWwWqVVn1ZShrjYW3AJXjHv4m1u2/qmB9xjNpky1FQb4BwfqXTxV2/6vlvlcgdSNrHoxzMCXzPoRNd/Ir/zsfDBykp6bVIwuPQiaIh0zGxFiQ6UnqM5mooRj1T1Agu5tUb1Ql8iE+/pkpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735218995; c=relaxed/simple;
	bh=92gIK5JZeIgDe9mZrNSpSJi3SNTyhHoTFhHtPt+5ZKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hbIdOxs4lCai2U71aU0NHyICm6Pj/DouJSoDa8ookFZXVGNT5Bpk4oKKb9iFJO3/hAwJGfFG914x2dgBtHwboe3J8gdhdYEhejjzIV6uhgYNti1ARFrh1iBHk0Gy/GX8ELoucUJYKpSXdSKkyTpm6/NpUYgvXMfRAqc0bv/5li8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=GnuPGQvy; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QuJVCoe+jVx4z79HAuyYsWkjoMo2LtRn7644iNoaWLA=; b=GnuPGQvyArjMdrL9VcBZZkB3Vl
	T6JnZ3JyobbLLJ9QJcjl1xR3kcDg8q6HsgtYKJ2KTG8Eo6xICT1Ck3EEjMqcWYbC22DM5kPPMC8b1
	+uviOCiKqpTgF5A3LqvR0CypyVLvbfMcZiLFTxgtqq44gcJd0MwEzEhIerH85eRxx3tsBlcYMX+Yz
	uCMXRRTRoGxBE6QnkYN8S+KJn3d9WXu60TfML0LmYwU6PrDpSpYKTNacF3bOKZVYXuWqgZv1Bz7xo
	6layAcavmEia3Rw/kt0XWtFKBLjLYKYZNRXoQ4a76bfRJCe+aGwg7IHGTo+2NsHRniE5hnecoG4EI
	yY87AfoA==;
Received: from i5e860d12.versanet.de ([94.134.13.18] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tQnj1-00044c-3w; Thu, 26 Dec 2024 14:16:27 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org,
 Kever Yang <kever.yang@rock-chips.com>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Rob Herring <robh@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 David Wu <david.wu@rock-chips.com>, Paolo Abeni <pabeni@redhat.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH 1/3] dt-bindings: net: Add support for rk3562 dwmac
Date: Thu, 26 Dec 2024 14:16:26 +0100
Message-ID: <3453500.5fSG56mABF@phil>
In-Reply-To: <20241224094124.3816698-1-kever.yang@rock-chips.com>
References: <20241224094124.3816698-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Kever,

Am Dienstag, 24. Dezember 2024, 10:41:22 CET schrieb Kever Yang:
> Add a rockchip,rk3562-gmac compatible for supporting the 2 gmac
> devices on the rk3562.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> 
>  Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> index f8a576611d6c..02b7d9e78c40 100644
> --- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> @@ -24,6 +24,7 @@ select:
>            - rockchip,rk3366-gmac
>            - rockchip,rk3368-gmac
>            - rockchip,rk3399-gmac
> +          - rockchip,rk3562-gmac
>            - rockchip,rk3568-gmac
>            - rockchip,rk3576-gmac
>            - rockchip,rk3588-gmac
> @@ -49,9 +50,11 @@ properties:
>                - rockchip,rk3366-gmac
>                - rockchip,rk3368-gmac
>                - rockchip,rk3399-gmac
> +              - rockchip,rk3562-gmac
>                - rockchip,rv1108-gmac
>        - items:
>            - enum:
> +              - rockchip,rk3562-gmac
>                - rockchip,rk3568-gmac
>                - rockchip,rk3576-gmac
>                - rockchip,rk3588-gmac

You only need to add the rk3562 only to one of those blocks.
The bottom one contains the snps,dwmac-4.20a element and looking at the
soc devicetree, it seems that is the correct one:
	compatible = "rockchip,rk3562-gmac", "snps,dwmac-4.20a";

So you only need the second addition where the newer socs are in the enum.

> @@ -59,7 +62,7 @@ properties:
>            - const: snps,dwmac-4.20a
>  
>    clocks:
> -    minItems: 5
> +    minItems: 4
>      maxItems: 8

This should get mentioned in the commit message


Heiko




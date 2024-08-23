Return-Path: <netdev+bounces-121411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AF395CFFB
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 16:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57D3D1C241BB
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 14:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBAF198E63;
	Fri, 23 Aug 2024 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="a22HQPNS"
X-Original-To: netdev@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC9718F2F6;
	Fri, 23 Aug 2024 14:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724422889; cv=none; b=NjBgjwCyvsNEj61VP4lOfKye/m4lynF+O69Bwrsb309CpyxQGtoxlCt9oHiAw8H7bI1QtCIOB/f2AtXPdFH5y1znyx07myhpo3YSC1Zs2bt2rNUmG/wfDxCH35TPyZT8fMk5riqlPEEnRWu7w88drT5ZpaAdMInOlMlq7ENLR/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724422889; c=relaxed/simple;
	bh=KDRD2oYXYie9kDAA42seyxHGHOyyCETQhmnxsrJHo/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BEYUDZaq7v0avAetBgDmd4jFS51Ubk0L9u154gC230birx95XYJpLULTYQXYwI6fpoXBv1ovJuQpVLtYdYKMwCRnzxTF22H6tST9kUftvwMJaJ4BImZ9o/zt0sBv9flp4s/cD9AY8aEpwXHa0l4ryVQDp+OmkonTx1hKnuh3myQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=a22HQPNS; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HfhTAcd3m1L5HJA9yejn7UHuUl2R1wfvxVwgaWJLsos=; b=a22HQPNSHQGY5pRF+CT2WXlT0o
	J04wjqrnAacN3RU3ohkdIg4BOvqfxDRascAyQnsAm64tDKblDlu4ajfIkzw5yMeEyt0YyBAaSb6N7
	+L5P93oAtCwvyi94N0tPaEZXTrweurK0y1eAkkKUbdt2U0yZus2nZdtZHu5XefjvHNuRWcXfuB1Ns
	uP9IBsOUetBGOSkRAYZK82CkUcRfzbWy6FRa6/RpICx44rhpU3jJjQuTmKRtEWZuz/zK7spYDqJgp
	vAdVWG+ya9fkrGWqGq6UfX8FQi+XOLAa8IKZ1ZEIwGsHOHlvXFS359UO0I06wQtQcyiQ4KhiB8Kwt
	W8wlg1Mg==;
Received: from i53875ae2.versanet.de ([83.135.90.226] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1shVAB-0005tA-Ep; Fri, 23 Aug 2024 16:21:15 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-kernel@vger.kernel.org,
 Detlev Casanova <detlev.casanova@collabora.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 David Wu <david.wu@rock-chips.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com,
 kernel@collabora.com, Detlev Casanova <detlev.casanova@collabora.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: net: Add support for rk3576 dwmac
Date: Fri, 23 Aug 2024 16:21:58 +0200
Message-ID: <9856424.ag9G3TJQzC@diego>
In-Reply-To: <20240823141318.51201-3-detlev.casanova@collabora.com>
References:
 <20240823141318.51201-1-detlev.casanova@collabora.com>
 <20240823141318.51201-3-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Freitag, 23. August 2024, 16:11:14 CEST schrieb Detlev Casanova:
> Add a rockchip,rk3576-gmac compatible for supporting the 2 gmac
> devices on the rk3576.
> 
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

>  Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 2 ++
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml     | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> index 6bbe96e352509..f8a576611d6c1 100644
> --- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> @@ -25,6 +25,7 @@ select:
>            - rockchip,rk3368-gmac
>            - rockchip,rk3399-gmac
>            - rockchip,rk3568-gmac
> +          - rockchip,rk3576-gmac
>            - rockchip,rk3588-gmac
>            - rockchip,rv1108-gmac
>            - rockchip,rv1126-gmac
> @@ -52,6 +53,7 @@ properties:
>        - items:
>            - enum:
>                - rockchip,rk3568-gmac
> +              - rockchip,rk3576-gmac
>                - rockchip,rk3588-gmac
>                - rockchip,rv1126-gmac
>            - const: snps,dwmac-4.20a
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index 3eb65e63fdaec..4e2ba1bf788c9 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -80,6 +80,7 @@ properties:
>          - rockchip,rk3328-gmac
>          - rockchip,rk3366-gmac
>          - rockchip,rk3368-gmac
> +        - rockchip,rk3576-gmac
>          - rockchip,rk3588-gmac
>          - rockchip,rk3399-gmac
>          - rockchip,rv1108-gmac
> 






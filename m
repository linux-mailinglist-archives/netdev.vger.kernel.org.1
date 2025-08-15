Return-Path: <netdev+bounces-214146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B8CB285AE
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 20:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5C121B67049
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 18:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCF31FDA89;
	Fri, 15 Aug 2025 18:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XeDhmJ4y"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B1531770A;
	Fri, 15 Aug 2025 18:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755281880; cv=none; b=RvzE2AVEpK+Pr8rgWHAiIa9dxyxn+JS9AtCcvRO9tuRDzuKKvluLtbtxgOIw8G6jQFW1ita0uBViksbSht4HNkhTi+M/ONGcbsK9fZUgoz2o0ubgeuXWaBsEs+5V+5b5eOI/1ZTP0sI4nU0Z8oBXIy/VIcOXLTFeo6ZfM6ITQHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755281880; c=relaxed/simple;
	bh=6WA1AzM68wUn5rKZorqUBe/a24Hl7xLvSiCclzH9bes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJrZiUZe+UHPer/zvQKkh8mheUCGoD9AmVCHNFRXq7uVTNBMJpgVOX+PfqLCaGL68Y8q5BjY5EfFMSRkpzM5HPBjP6bZycvv3TTxXEv33+5b4pfLHrB+vzhPfzix3WfI9XihC8i+AWW8GfFRXN68ZXk3nAKlPAki60zEwwDxafc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XeDhmJ4y; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=x991MXHST0EKiSJEKhetd564OkHnAL8jVf76/MDrS0c=; b=XeDhmJ4y9KKDkVdDuflrq5rn09
	L5mL6HhGn0XktAYU7n3gE40QDLQ2HzzS51Uyk61sD2QFliAjVGRBjC2aHH5+x+mbqWGvu9fWqUilP
	PFN6P/BWLU60i0PyUv3v+2ex0B4ftLx92Ab83vIpqI3OPteQ4f3sG9XgovWaSO/8S3G4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1umyzl-004qln-V5; Fri, 15 Aug 2025 20:17:41 +0200
Date: Fri, 15 Aug 2025 20:17:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Simon Horman <horms@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Po-Yu Chuang <ratbert@faraday-tech.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	taoren@meta.com, bmc-sw2@aspeedtech.com
Subject: Re: [net-next v2 3/4] ARM: dts: aspeed: ast2600evb: Add delay
 setting for MAC
Message-ID: <0f0383dd-a55b-48e6-824c-798c2a9e173e@lunn.ch>
References: <20250813063301.338851-1-jacky_chou@aspeedtech.com>
 <20250813063301.338851-4-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813063301.338851-4-jacky_chou@aspeedtech.com>

> @@ -149,6 +155,9 @@ &mac2 {
>  
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_rgmii3_default>;
> +
> +	rx-internal-delay-ps = <2000>;
> +	tx-internal-delay-ps = <2000>;
>  };
>  
>  &mac3 {
> @@ -159,6 +168,9 @@ &mac3 {
>  
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_rgmii4_default>;
> +
> +	rx-internal-delay-ps = <2000>;
> +	tx-internal-delay-ps = <2000>;
>  };

Documentation/devicetree/bindings/net/ethernet-controller.yaml

# Sometimes there is a need to fine tune the delays. Often the MAC or
# PHY can perform this fine tuning. In the MAC node, the Device Tree
# properties 'rx-internal-delay-ps' and 'tx-internal-delay-ps' should
# be used to indicate fine tuning performed by the MAC. The values
# expected here are small. A value of 2000ps, i.e 2ns, and a phy-mode
# of 'rgmii' will not be accepted by Reviewers.

    Andrew

---
pw-bot: cr


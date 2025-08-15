Return-Path: <netdev+bounces-214148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FEAB285C5
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 20:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64D0D1CE1784
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 18:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE63F219A67;
	Fri, 15 Aug 2025 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="n/45N6OG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5573176E2;
	Fri, 15 Aug 2025 18:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755282210; cv=none; b=eTd0YB/tGOvyYij6nkK0pnABvJAWwgugeA8pHWRXCaGmWnsDWGPyoMs8aWeRJFU4YBnb3O8pSbfaMEJI0i0na6v2u7Q3Yb8LXG/DLVUXiri82Dnp+ea4phGbJwUBvzOZYFkOE3x1tCsgChzNoodBqXH5rdKQVDirsQrLimL3FxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755282210; c=relaxed/simple;
	bh=Ipd9XhHEZVXYNsqJzb7rVv3+FxGlnct+yET8iOci/y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ClT2FGLkYtKIiTmXLx4E0r6QIhfq2Iqhg4ZQOKKqFO7O6Nhh/RAxoW/D5f3LVaNcvDfSIkIG9ytnpAxGFmoIdaMQizzewYDZvWaNRFGFY0IedOLai8q3Y2oyBM2k9nUmTlUIIu801prcZbUcwnNMBQwCNWN3nvLgf+6bWx45svs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=n/45N6OG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wyQuAg7wHg8xPlkwj5ueliqGmECn9lBdw6/y92GmRzc=; b=n/45N6OGRV3bCfvLHGn3LmHV8A
	re3KLppUfb3uwkIiPx0oJBx9dNZAOBkoKFNLc7hUyVoOnpnuZ2/CtqrsdMTaCaGSAyhGbfcoo0sY9
	p+7kT80BQe2dJCO3YnGoF66HMv1zgjCS4AlJE5FB/++t900OV+YgnCMRga4AkXxCkxbM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1umz54-004qod-Ok; Fri, 15 Aug 2025 20:23:10 +0200
Date: Fri, 15 Aug 2025 20:23:10 +0200
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
Subject: Re: [net-next v2 4/4] net: ftgmac100: Add RGMII delay configuration
 for AST2600
Message-ID: <d0948803-b1cb-4a8b-8c4d-55785d5ba39b@lunn.ch>
References: <20250813063301.338851-1-jacky_chou@aspeedtech.com>
 <20250813063301.338851-5-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813063301.338851-5-jacky_chou@aspeedtech.com>

On Wed, Aug 13, 2025 at 02:33:01PM +0800, Jacky Chou wrote:
> In AST2600, the RGMII delay is configured in SCU register.
> The MAC0/1 and the MAC2/3 on AST2600 have different delay unit with
> their delay chain.
> These MACs all have the 32 stage to configure delay chain.
>       |Delay Unit|Delay Stage|TX Edge Stage|RX Edge Stage|
> ------+----------+-----------+-------------+-------------+
> MAC0/1|     45 ps|        32 |           0 |           0 |
> ------+----------+-----------+-------------+-------------+
> MAC2/3|    250 ps|        32 |           0 |          26 |
> ------+----------+-----------+-------------+-------------+
> The RX edge stage of MAC2 and MAC3 are strating from 26.

strating? 

> +static void ftgmac100_set_internal_delay(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct regmap *scu;
> +	u32 rgmii_tx_delay;
> +	u32 rgmii_rx_delay;
> +	int dly_mask;
> +	int dly_reg;
> +	int id;
> +
> +	if (!(of_device_is_compatible(np, "aspeed,ast2600-mac01") ||
> +	      of_device_is_compatible(np, "aspeed,ast2600-mac23")))
> +		return;
> +
> +	/* If lack one of them, do not configure anything */
> +	if (of_property_read_u32(np, "tx-internal-delay-ps", &rgmii_tx_delay)) {
> +		dev_warn(&pdev->dev, "failed to get tx-internal-delay-ps\n");
> +		return;
> +	}
> +	if (of_property_read_u32(np, "rx-internal-delay-ps", &rgmii_rx_delay)) {
> +		dev_warn(&pdev->dev, "failed to get tx-internal-delay-ps\n");
> +		return;
> +	}

If these properties are required, but are missing, the DT blob is
broken. Please return -EINVAL, and fail the probe.

Please make all errors in this function due to a bad DT blob fatal.

	Andrew


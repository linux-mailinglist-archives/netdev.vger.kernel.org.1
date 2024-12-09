Return-Path: <netdev+bounces-150275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCF19E9C04
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 17:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C688628383A
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 16:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3220A14A60D;
	Mon,  9 Dec 2024 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nly65iiU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C52145B18;
	Mon,  9 Dec 2024 16:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733762670; cv=none; b=rxcyagD04LaPzEXe5gmQfBsClv7ILzsBcEWHruq5vdw5TLG0NdU2CV/TSA5/q6mItVHiOTQFT+zMrJbs3nykT6o0KlvV294sxCumM3WzhjRQKwJuDH5cQz0zNBMxRqtewBB5ZFQZpjTCy1QnCRAUrPFT7aMzzO5gDk6tC14zd/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733762670; c=relaxed/simple;
	bh=V1dLeYThwe2B8vhJXKUtFChaWqgR+yEpf4Z1K5NjUEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bl4HY5Pp+NMnIcf5P73dY0BNh+/Oz3R4I6tH7+cAO5qpWJ2ExopBqMizpRKheyu6XOjYWmkUMKonHHnOIdTw72V6zX6Cru5uqNUejKQhaisfDwac41w0Tw9/wtgAVMyDK/6TUmXgBMx3DDxA9lz3JXMo5JEKXbknRePxIL+m8Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nly65iiU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mZntX+8hMA0rPvn3vcWIzlKbets+ctrcbHV8oQBSKks=; b=nly65iiUoMyszAoKNFpqkvbeOd
	FdilF6M2bA1FCQjl/22Iw+HuvpSZ546qpUnFtcMKWsLO1ReTDBmvmxf4Mitq3wkBcFByO2cSP/LYR
	P0bMKAd1K3TB0OcqXSf8aA9YF1dWqjiGl/5AXkli5flaqVKQSt9ViT1mgmrq/FmkB50s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKgrm-00Fh56-6l; Mon, 09 Dec 2024 17:44:14 +0100
Date: Mon, 9 Dec 2024 17:44:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Roan van Dijk <roan@protonic.nl>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 4/4] arm: dts: stm32: Add Priva E-Measuringbox
 devicetree
Message-ID: <eaec5732-7a24-46ba-8d76-7896304264ac@lunn.ch>
References: <20241209103434.359522-1-o.rempel@pengutronix.de>
 <20241209103434.359522-5-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209103434.359522-5-o.rempel@pengutronix.de>

> +	/* DP83TD510E PHYs have max MDC rate of 1.75MHz.

Really? That breaks IEEE 802.3, which requires 2.5MHz. Humm, says it
multiple times in the datasheet. Seems like a language lawyer was
involved in the data sheet.

  The DP83TD510E is an ultra-low power Ethernet
  physical layer transceiver compliant with the IEEE
  802.3cg 10Base-T1L specification

I would not be surprised to find that 802.3cg says nothing about MDC,
that is in the base 802.3 standard, which they don't say they are
compliant to.

>        * Since we can't reduce
> +	 * stmmac MDC clock without reducing system bus rate, we need to use
> +	 * gpio based MDIO bus.
> +	 */

At least there is a simple workaround, even if it is much slower than
what you really need.

	Andrew


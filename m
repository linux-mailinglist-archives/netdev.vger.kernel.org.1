Return-Path: <netdev+bounces-172652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE91A55A1E
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 23:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 643DC177D7F
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 22:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4DE202F7C;
	Thu,  6 Mar 2025 22:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OfEm/pu2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9634DA2D;
	Thu,  6 Mar 2025 22:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741301215; cv=none; b=oUV31Voed9my6SdH2zbl4NDuRo8nOKgAl2otLqh6904Trk+4YK+T0yb3bgiKoEDLMYs2TZKzWcMECHaKK5Wg/VU0nBwvpd07XdAFwNMRhy1jF/B79M6ljU0yO2GT8xQ2QUfAziWwDNNy2kCWHNWaDubG+t3i55YuzD8bo4WKlKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741301215; c=relaxed/simple;
	bh=zs7g5b8i1KCeLS8bZsz0/RmzAKizQG5V0mKic0zbqZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pp5TiYPCYMow1jBdCstM340kzn0O2DqmU+/LohjhQtO1h6+mpAS4J+4J19xWDkgrw6nLLoopamfv/9y+jiPdn+kN3+8jJv2Q1WrpZUdFU1fhsuuDD0KkVJsO2SkN27qcAIKwJIgk5yOBdVyzaaCUHQqPNYAJSJINtMWaELC3/5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OfEm/pu2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WLg3duqCK2hWUeRlR2AWlamGy6Hsm8C3eYidl98LRSk=; b=OfEm/pu2toLz8/Xyzv0lALa3nZ
	g91nhITzmWSogS26PvhjV1wX0ump/l/NHKrlqbzEY2xKc+YEjrmnQupJVoK+OgpAxOKn/KAEL9Dat
	expL+6hVxhKMlG2xEZEeQGibmPe8TSrIsV4XTXiZ3n4Jhw6ix5MPIvBYzJOhLQfcQPas=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tqJzD-002wTu-Hw; Thu, 06 Mar 2025 23:46:39 +0100
Date: Thu, 6 Mar 2025 23:46:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yao Zi <ziyao@disroot.org>,
	linux-rockchip@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: Add GMAC nodes for RK3528
Message-ID: <a827e7e9-882a-40c6-9f2c-03d8181dff88@lunn.ch>
References: <20250306221402.1704196-1-jonas@kwiboo.se>
 <20250306221402.1704196-4-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306221402.1704196-4-jonas@kwiboo.se>

On Thu, Mar 06, 2025 at 10:13:56PM +0000, Jonas Karlman wrote:
> Rockchip RK3528 has two Ethernet controllers based on Synopsys DWC
> Ethernet QoS IP.
> 
> Add device tree nodes for the two Ethernet controllers in RK3528.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> gmac0 is missing the integrated-phy and has not been tested bacause I do
> not have any board that use this Ethernet controller.

What do you know about the integrated PHY? Does it use one of the
standard phy-modes? RMII? Does the datasheet indicate what address it
uses on the MDIO bus? If you know these two bits of information, you
can probably add it.

    Andrew


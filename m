Return-Path: <netdev+bounces-185809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D93A9BC97
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 04:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 323FA1BA3276
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 02:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D253FBA7;
	Fri, 25 Apr 2025 02:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mrpwuK5B"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E564F4C7C;
	Fri, 25 Apr 2025 02:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745546516; cv=none; b=IN74NdB6qnN6Ys+7QtXL2DHAmbdEDjFQOSOy+EJNGB3T1tTnKl3r54S10/lZE4IZrhVZ9kowZONvLomzKoLTkBGREeyaVD35xqU8363gbKEADns/TufiY8PcYgQ5+5GhKdQhbEiABI16VZy+VwicXZ0JQEVNbZIulZ4udPl1I8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745546516; c=relaxed/simple;
	bh=pme5iQz5eKFu7fHxQXgGPqQvVq1us5JDlFMnADx3js0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQjlY/aGcNZoWCP6vduXa7u1uyMvMDVXm5YW2vyTkpNnfk9G+UuUXaIXeG+s8bp+0XhzD7dXksmo0BpLFgBFVPgrJy5/486dVAkdgkene9wHNX2B3GhyRyWt8NJy29Ud/bGY7jGYbT4bmT92n7zua8Wp+HwjbI2QD7yDNZwwKbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mrpwuK5B; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ICF52ZSrljFNaTIWgavSI5WbnW464jwCjST74huipR8=; b=mrpwuK5B/JJe+wE22m8iiXPB5s
	KVemoUn5f883G+1qcgAZoJTkUhHQSmUNJP9siqokmXeAGKiU0+o2W3+efjBkzS/bKemfKa0rg7lIj
	tciOhSvPBB1NSm4/KOaLSPYukDt3NswXnwJvpQlk3ditdHmGBPSjBlhvJS3Okb5HvaA8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u88Ne-00AWyd-Cl; Fri, 25 Apr 2025 04:01:30 +0200
Date: Fri, 25 Apr 2025 04:01:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
	Yixun Lan <dlan@gentoo.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, clabbe.montjoie@gmail.com
Subject: Re: [PATCH 4/5] arm64: dts: allwinner: a527: add EMAC0 to Radxa A5E
 board
Message-ID: <3681181a-0fbb-4979-9a7e-b8fe5c1b7c3c@lunn.ch>
References: <20250423-01-sun55i-emac0-v1-0-46ee4c855e0a@gentoo.org>
 <4ba3e7b8-e680-40fa-b159-5146a16a9415@lunn.ch>
 <20250424150037.0f09a867@donnerap.manchester.arm.com>
 <4643958.LvFx2qVVIh@jernej-laptop>
 <20250424235658.0c662e67@minigeek.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424235658.0c662e67@minigeek.lan>

> Ah, right, I dimly remembered there was some hardware setting, but your
> mentioning of those strap resistors now tickled my memory!
> 
> So according to the Radxa board schematic, RGMII0-RXD0/RXDLY is pulled
> up to VCCIO via 4.7K, while RGMII0-RXD1/TXDLY is pulled to GND (also via
> 4K7). According to the Motorcom YT8531 datasheet this means that RX
> delay is enabled, but TX delay is not.
> The Avaota board uses the same setup, albeit with an RTL8211F-CG PHY,
> but its datasheet confirms it uses the same logic.
> 
> So does this mean we should say rgmii-rxid, so that the MAC adds the TX
> delay? Does the stmmac driver actually support this? I couldn't find
> this part by quickly checking the code.

No. It is what the PCB provides which matters. A very small number of
PCB have extra long clock lines to add the 2ns delay. Those boards
should use 'rgmii'. All other boards should use rgmii-id, meaning the
delays need to be provided somewhere else. Typically it is the PHY
which adds the delays.

The strapping should not matter, the PHY driver will override that. So
'rgmii-id' should result in the PHY doing the basis 2ns in both
directions. The MAC DT properties then add additional delays, which i
consider fine tuning. Most systems don't actually need fine tuning,
but the YT8531 is funky, it often does need it for some reason.

	Andrew


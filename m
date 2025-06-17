Return-Path: <netdev+bounces-198593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB398ADCCFD
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 15:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C166E3BF018
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2825F2E7191;
	Tue, 17 Jun 2025 13:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iNa0xfO4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7CF2E7166;
	Tue, 17 Jun 2025 13:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750166096; cv=none; b=A0CFZi+NkIovxPNEjyZvJQGCJJGeDIZCG6UnejjBuEJpsub6hFBleA9OpCNNLmcazcr1HL434V3Pz0IEBkjzMw6nDhPVXUXE6lHlW7hdyJLHCb3xlcLuZgQ8DZMare1EI1t1BUgBE4WVtHMcoCMR++z77ipfEOXVD8JqJG0lvAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750166096; c=relaxed/simple;
	bh=jWHsSqNV6uTusVU5NnYNCN38+Xz/eWr0z5GEMNQdJ0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0i+1PT5iTQoKt2Gkh6iEVcWp+jO0czH5oy/KQYltoGzi0psLRZ5GKEso3VtMGCFPx1U0C1pLR2l7XW2k4uP9MiYvSxka/fXDvWc8GJ0mjGbSz139rPAeBOhQwVYnFrngnJ4czmiHpss4VgvnwqvspGtESQ6UrGiCAhhaQBWx18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iNa0xfO4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uFLVJFpH5AQoGq4DYrwcdK29TEFz0/SXGmStaKvh9BQ=; b=iNa0xfO4f+V3dWu6OtwziiklHV
	0IJbfpT5pYTvjelAZi7SLIUz1B2jI+jxV2Bl7wn7Kyx2lP3m7taNuoWdw3sawN3A6NuNcMxIJiWOC
	OWPE8t/U79D6l66Bf8vpY0PEv64H7lkmHTDjIyxDBRcb4PKKarmyZljW4ZZuy1SBNwYI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uRW90-00GAVk-BT; Tue, 17 Jun 2025 15:14:30 +0200
Date: Tue, 17 Jun 2025 15:14:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2 2/2] net: mdio: Add MDIO bus controller for
 Airoha AN7583
Message-ID: <065e26cf-1bfb-462c-8cbc-9b4b29f1262d@lunn.ch>
References: <20250617091655.10832-1-ansuelsmth@gmail.com>
 <20250617091655.10832-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617091655.10832-2-ansuelsmth@gmail.com>

On Tue, Jun 17, 2025 at 11:16:53AM +0200, Christian Marangi wrote:
> Airoha AN7583 SoC have 2 dedicated MDIO bus controller in the SCU
> register map. To driver register an MDIO controller based on the DT
> reg property and access the register by accessing the parent syscon.
> 
> The MDIO bus logic is similar to the MT7530 internal MDIO bus but
> deviates of some setting and some HW bug.
> 
> On Airoha AN7583 the MDIO clock is set to 25MHz by default and needs to
> be correctly setup to 2.5MHz to correctly work (by setting the divisor
> to 10x).
> 
> There seems to be Hardware bug where AN7583_MII_RWDATA
> is not wiped in the context of unconnected PHY and the
> previous read value is returned.
> 
> Example: (only one PHY on the BUS at 0x1f)
>  - read at 0x1f report at 0x2 0x7500
>  - read at 0x0 report 0x7500 on every address
> 
> To workaround this, we reset the Mdio BUS at every read
> to have consistent values on read operation.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


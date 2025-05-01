Return-Path: <netdev+bounces-187239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D15AAA5E2A
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 14:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E17973AA9AA
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 12:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3BC4315E;
	Thu,  1 May 2025 12:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PdK4Okro"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F74219A297
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 12:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746101767; cv=none; b=SymBvrkyEp5AfOuRrxUBHbeLlA8JEY9hoIoZpCNFne/jmVmH+r5rqCURHWHl+3D+Q1FYDDjgW5rXlSuvsrO0LS+XI/ZazssDWRU+KRB0tSXN1XALtcVV6di0WZwDiaLBj7UzUEEkX3U01ukHdCUh8Fq5K88BOQpI5R4nygO6dJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746101767; c=relaxed/simple;
	bh=EQnsnf+Aw4Rn9fa2zsRWw//6hmLpuhxAiByCwgMdZxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xd2B+DjYs3maNt8iwsItEYvOfGWeZBuxXFiNKscy5P871CLNgVlHBFe+slmbZEFEh5Ow14OyYjQP8oLIwS7ahcsL22oxq/y/6c1rsboCD1qow8YYpZ7Y+W7Weq2qxhrd3fteJAOHGmFxQk2sFEHVxMzIHcGZu16LQOoNVU3T+0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PdK4Okro; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tC1+C2NdYFgBLdpMekNLt5gvPrAXo0lWj4NjN0Vtv8g=; b=PdK4Okro3ouZq6qHChLkwhG/KS
	s3a1eK03Siw86LUKTs6TWWmvZ3b5HcvHtawM5kkPppeBbEPua9D2DdpCL2Pd64KppOo08nPizRwha
	5qBqz+NWR3UEY2jpbyFA62MFNNs6eMXZ+ibBkxEZdB3Q3naImFH618Ju2RB+pLzhUwlk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uASpZ-00BJKc-7v; Thu, 01 May 2025 14:15:57 +0200
Date: Thu, 1 May 2025 14:15:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 4/6] net: stmmac: intel: move phy_interface init
 to tgl_common_data()
Message-ID: <f9bd9712-60ab-412e-aebe-7d8c1196e3d0@lunn.ch>
References: <aBNe0Vt81vmqVCma@shell.armlinux.org.uk>
 <E1uASLs-0021Qk-Qt@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uASLs-0021Qk-Qt@rmk-PC.armlinux.org.uk>

On Thu, May 01, 2025 at 12:45:16PM +0100, Russell King (Oracle) wrote:
> Move the initialisation of plat->phy_interface to tgl_common_data()
> as all callers set this same interface mode. This moves it to a
> single location to make the change to get_interfaces() more obvious.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


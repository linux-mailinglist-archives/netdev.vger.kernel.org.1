Return-Path: <netdev+bounces-230211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED6BBE55A0
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 22:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA5094E4D50
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 20:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82463221FA8;
	Thu, 16 Oct 2025 20:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aCkbIvx1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0970A1A9F93
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 20:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760645822; cv=none; b=PRqhw1HhlwP6tkFzKxFZSRCx7D6FrAMOHuoiQ/2CUSALMc+HgKbRqruQSpNUl/R+BybOBuQFiuke+IF5gZ4ADhIA6M1LHzanmsTRK5L2xFYlPhWb1gfBtt8nfS2DCR4PUIi8hcZzOJFVzm1QFOfoLIixRMlstmnppN6h9UaRgdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760645822; c=relaxed/simple;
	bh=mB5tbBx/Y84v2TSowDFdCWG+0hEu5qKq1ASV8Lb4Mho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuk5J/iCsDI+BnuP5OWFdK7U8bRhWSWK3Gw05p/h1o7f/td6H0ghrYQPeBGImJnPkxAsnDV/YJPbtVbJAyEl5iol7fwMgK7mUOsOCCwXc072zDNE9qAHvawV9ROgj+IJFsV2wZykt4P1NAxN31/RoizMML26iwBK6SPr+eH9x74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aCkbIvx1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=w1O/aO97nPYYdbzk164KnQEpaZP73kNMXnyNRWyK5vM=; b=aCkbIvx1D3uGBHmHUciIMOW93P
	JUA/W6ZNCEA/ilmN9PCmPvysq7MJfPOXBSFTl4O2OD1O423w51jbgicHC/cBrpdQPyzkOvsQVfKbR
	pduN1sNyBMmt0rMZd8r+WcNCPGCLzHAq/dkiq1tF1JCXnSS01ufI4/yo5edJxrxUm0vI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v9UP5-00BCgD-Fi; Thu, 16 Oct 2025 22:16:51 +0200
Date: Thu, 16 Oct 2025 22:16:51 +0200
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
Subject: Re: [PATCH net-next 3/5] net: stmmac: avoid PHY speed change when
 configuring MTU
Message-ID: <1e231ecd-a4eb-4596-82a2-8c7448287d50@lunn.ch>
References: <aO_HIwT_YvxkDS8D@shell.armlinux.org.uk>
 <E1v945T-0000000AmeV-2BvU@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1v945T-0000000AmeV-2BvU@rmk-PC.armlinux.org.uk>

On Wed, Oct 15, 2025 at 05:10:51PM +0100, Russell King (Oracle) wrote:
> There is no need to do the speed-down, speed-up dance when changing
> the MTU as there is little power saving that can be gained from such
> a brief interval between these, and the autonegotiation they cause
> takes much longer.
> 
> Move the calls to phylink_speed_up() and phylink_speed_down() into
> stmmac_open() and stmmac_release() respectively, reducing the work
> done in the __-variants of these functions.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


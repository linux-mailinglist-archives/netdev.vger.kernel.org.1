Return-Path: <netdev+bounces-170432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 878E7A48B32
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 23:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EC207A5A9C
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 22:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4096D26B975;
	Thu, 27 Feb 2025 22:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UUs1oId+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C89225A48
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 22:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740694636; cv=none; b=ndmOGw0E5uBd4SYnDk7873EE5GKx4pjqkHF4PyIkFZ+AlO7GayxPQGct/AtimqTedNEaKEqd8Y3ZNGWdr+ARw4hLHY2WXr5+UHKXSuGL73vwFoidPh2GgdK9SRksqpCaEZZ/4e0pba+HoerBFQvXPSLGvm9KCumXulOvoZdmRZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740694636; c=relaxed/simple;
	bh=gWlIQIEltm4pFVT0HLHXO6ICUNqyNhHaVSCNz8lff8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+SE3kPddWOpnkEDfvXCgdOB2s5HK5TF8lzaX3eoq3+lnM+b3mICpErTMnXhl70iBNmXyyqHKMBXtBCRUFGxBFXkKOyXdf3p5d1xVVMpj/P4RSW2+BlmblhDv3DmxFmIkrlkD7nlcXlXufUzBLW5ufVjTYFJ91pXW7OacLaLZRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UUs1oId+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EE25XAsvhnFPgPLYy6dng4+2igaG0tj5/voU58VKW+w=; b=UUs1oId+Z3hGUPkm+ucjt98CV+
	psoOP9GEioeCf4nrItaN615xIiMApAJvd2LS7kYvsgooKqOJEYq88LAKDYnTOTXDlckJgd7IWUam4
	WPdVee/CYkaIWtTHsTHsRAxVGygdj9D6COxC0358AIPapodzCVBFqc3M3VZBfvHDcy0s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tnmBm-000jkS-MQ; Thu, 27 Feb 2025 23:17:06 +0100
Date: Thu, 27 Feb 2025 23:17:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH RFC net-next 3/5] net: stmmac: remove unnecessary
 stmmac_mac_set() in stmmac_release()
Message-ID: <dca35d31-e9af-4453-be2d-cae3a86a8ac9@lunn.ch>
References: <Z8B-DPGhuibIjiA7@shell.armlinux.org.uk>
 <E1tnfRo-0057SL-Dz@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tnfRo-0057SL-Dz@rmk-PC.armlinux.org.uk>

On Thu, Feb 27, 2025 at 03:05:12PM +0000, Russell King (Oracle) wrote:
> stmmac_release() calls phylink_stop() and then goes on to call
> stmmac_mac_set(, false). However, phylink_stop() will call
> stmmac_mac_link_down() before returning, which will do this work.
> Remove this unnecessary call.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


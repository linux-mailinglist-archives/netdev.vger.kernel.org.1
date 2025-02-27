Return-Path: <netdev+bounces-170370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2B4A485CB
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 17:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADD57172FDC
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4C31D90A9;
	Thu, 27 Feb 2025 16:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Hlh6+D5q"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E0F1D5CD3
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674791; cv=none; b=MBpvpbEs2XW5g6ry4nBjtJEmIYnRBJniHQA5+JIh1kaHroQCMOODMDk6PV4S3g0MMGGcn/3Gab9841Fc6FkMfNGSUqS/Z/tN0itFgYw4+yt+esysM+JDftJRzh8hFuF1KXHNUMnaM7KIIe6RQ5I19r3HORlVSgoCMo347kkN5rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674791; c=relaxed/simple;
	bh=2Hew64eUgtYI+b4CbBcudWtqEw1Pb3LJxqSeIPSs9zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=riRnj5EiggPFHC8FOciY+B8y5QRgbVL6o9FEb8ieNrLiQKm4lwuY+gKUTIK25Bn3ZfUlMuR+MRumMJS5P2Ck3mejdEOH0R5YtF+L/IzjlqBazVILo6zZ1ebdFPxDmF/+8zux8CWDR0XhaDaHbIwAr1itE0xPnjCKA0s+z8x255s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Hlh6+D5q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8scTYSNjvNwWNGDv8cFaYLgRcjxLemT0t7RinzRoLjg=; b=Hlh6+D5qwKdQFbqPkctTmcIoKK
	9J7/3/cYULfpfk2xhqpaPfIv+JwBmEJvrx4HfZBLwcKxPsSFxiYK2t/cb+Uc0CWHBdeE94qVCG0Aj
	op2r5bn9/engzVOhCUovdOgS0kAdC4Y78NeAOioRdGjbv3gCaCrKb2XA59ymUXlnmSD8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tnh1i-000enI-BX; Thu, 27 Feb 2025 17:46:22 +0100
Date: Thu, 27 Feb 2025 17:46:22 +0100
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
Subject: Re: [PATCH RFC net-next 4/5] net: stmmac: move phylink_resume()
 after resume setup is complete
Message-ID: <cd931fc7-07ee-4687-948a-173d0aedf15e@lunn.ch>
References: <Z8B4tVd4nLUKXdQ4@shell.armlinux.org.uk>
 <E1tnf1X-0056LI-9i@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tnf1X-0056LI-9i@rmk-PC.armlinux.org.uk>

On Thu, Feb 27, 2025 at 02:38:03PM +0000, Russell King (Oracle) wrote:
> Move phylink_resume() to be after the setup in stmmac_resume() has
> completed, as phylink_resume() may result in an immediate call to the
> .mac_link_up method, which will enable the transmitter and receiver,
> and enable the transmit queues.
> 
> This behaviour has been witnessed by Jon Hunter on the Jetson TX2
> platform (Tegra 186).
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


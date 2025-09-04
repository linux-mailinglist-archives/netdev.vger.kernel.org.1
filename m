Return-Path: <netdev+bounces-220077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 701CAB44608
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 21:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C45F188EB19
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 19:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A931172625;
	Thu,  4 Sep 2025 19:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xTLoCH3O"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94BD242909
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 19:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757012463; cv=none; b=LFLDkjet37BtAsqDOSKagRYo4i+NOPKEZ8opHM511DnX1crNdE4mTe36Qz8Q/NpTA4dMnCarK+jfZXWe7IDAd/j8shjDPRaILAd82KR4OS4RylPwMKhnrzALQsYWuN0CIuZ0h6H/obttYy8axcR22mVPxRw+MD1Sefd1i/rPT+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757012463; c=relaxed/simple;
	bh=MiLSsmoa6BTcNouZYaS/Y7LjIHciU+ITVkaxcYzCSqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGbLymuetYFCz/TNwVvSbc2GIMh2RsbDfGPX9DSX8/VWvTacXRgsEllwSnZ159HvodMFCX4kCDKWaWwYhbG+g+9+IsfLhfmJoRq5lxbV5d0S9ToYlgD9nBnV5JUGu4+rVXEiV4OKfr+w97lQDyTT9Hfh3UJa5iOG/GRabrFk7tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xTLoCH3O; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2XxwIb9cEpOzD+jKESQeG9xxvQlZKxby81gZM0Qml6A=; b=xTLoCH3OMnPJ4EIQh9GOeFzWsH
	SVZHEieH5xegTmc3ZnnxpZ8j0lIMxxrVAE8wzG/aIzqVgPiCdSJWHeUUNzrc+CnIy3Yt8pYqTvab7
	MZau6prgjuYt0dAdRk7Jc8QAKuy0hKuFCZgNcoZWFAOR3qNk+cmWUuA24+o/5663TYwg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uuFCT-007G5r-Kk; Thu, 04 Sep 2025 21:00:49 +0200
Date: Thu, 4 Sep 2025 21:00:49 +0200
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
Subject: Re: [PATCH net-next v2 05/11] net: stmmac: mdio: merge
 stmmac_mdio_read() and stmmac_mdio_write()
Message-ID: <fab13c83-157a-41c9-a006-c10aa2392c0f@lunn.ch>
References: <aLmBwsMdW__XBv7g@shell.armlinux.org.uk>
 <E1uu8oC-00000001vos-2JnA@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uu8oC-00000001vos-2JnA@rmk-PC.armlinux.org.uk>

On Thu, Sep 04, 2025 at 01:11:20PM +0100, Russell King (Oracle) wrote:
> stmmac_mdio_read() and stmmac_mdio_write() are virtually identical
> except for the final read in the stmmac_mdio_read(). Handle this as
> a flag.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


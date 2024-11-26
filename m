Return-Path: <netdev+bounces-147515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AA19D9EA9
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 22:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D102166968
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 21:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D1A1DEFFC;
	Tue, 26 Nov 2024 21:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2YmdRRZZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3BF17C219
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 21:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732655165; cv=none; b=JsJwz0UPh+DNPk8WobFjPaaXEHka0cC2tMNEEwelAqUQExfgkfysTFzglF1A5ACS1rBKJHMmE/FY0oeyrpsExYcyVVc2BDcKX/i3B7n0tD3aWKhKMtR4JSQFmAkf3q9e1aMaSotxoocXEJSKIywVTvyxctTeXXXcOoIU2RM3iXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732655165; c=relaxed/simple;
	bh=1vUYb/aajj4eZrfFQ1ZOzaqUhBu34FEPUSr0glqKTkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lulVwF+OXPDw7VBAvxfFpupiOutT6fPRzhg0k5JF44eo3/vdoIiOryz6GD0TfGwbcEA+GubzQ5WiE3d0/w3fYQjLJW2p86rev4wHqdav1zbXcfrHow3+RcM6nPf4vyWfg/ISRfx2NMDCjnl99zRHac4V1mKqZiJvc/m5xw4Tyn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2YmdRRZZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vmbIlKcAVLKjRxHa4VqPo5WKB6DBh0l4jMgac7lFpys=; b=2YmdRRZZY4+znhtWTOHGszWkHO
	XKS4VJ6cFoEnwfe+1zYyvj2QNk8+PYK1euFHc8u1Ls3yto/aFg5E3Jrx2mvIr2QwTj5K/P5Hs697N
	kFoEUXWw6s+MfOGqaj9bY0qlCef+z5uXd7E+0INSpUGiQRVK0o13tIsctWj1ebVHdn1c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tG2kf-00EZCH-OJ; Tue, 26 Nov 2024 22:05:41 +0100
Date: Tue, 26 Nov 2024 22:05:41 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC net-next 09/16] net: phylink: add pcs_inband_caps()
 method
Message-ID: <7dcf8936-29fb-45f3-9ce9-69ef2a1e9f1e@lunn.ch>
References: <Z0WTpE8wkpjMiv_J@shell.armlinux.org.uk>
 <E1tFrob-005xQS-Hz@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tFrob-005xQS-Hz@rmk-PC.armlinux.org.uk>

On Tue, Nov 26, 2024 at 09:25:01AM +0000, Russell King (Oracle) wrote:
> Add a pcs_inband_caps() method to query the PCS for its inband link
> capabilities, and use this to determine whether link modes used with
> optical SFPs can be supported.
> 
> When a PCS does not provide a method, we allow inband negotiation to
> be either on or off, making this a no-op until the pcs_inband_caps()
> method is implemented by a PCS driver.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


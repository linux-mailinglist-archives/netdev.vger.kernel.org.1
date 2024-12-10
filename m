Return-Path: <netdev+bounces-150658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 719749EB220
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFF4A2844F7
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 13:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2EB1AA1C9;
	Tue, 10 Dec 2024 13:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zc+A3xnM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A28123DE8D;
	Tue, 10 Dec 2024 13:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733838298; cv=none; b=ZyCfltQsJmOe99vCxwV4M2BpEsQhvU3o6X4QPg/G96Kh8B1Tiw4ivif6ZT2J7ksx7EKbLfVAF8FJ9216pCDSAb3SZEH+QSn08iGb3ws1uqxCvMELHhlqPyeKegbF9QdoEni/zjRJrkOjYEZe61e2uaC7XQ6+E2TPF9lBzbsB69o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733838298; c=relaxed/simple;
	bh=fmtAwz9r7mdCnu6Pbec9pEFR3UL2H2XM9OAzzlbAAKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ob9hAOhIPYHZyNzcWjAJ691KQ6+R4ehXHxStXNPvl24AO1OBM6kFiggJj6Sq8DdfZ2qZPdzvomW4H3HFoWM1Xj8z3lIpCR5p2JQtbZpRi3Q8eh770Du1gOfAdsmvCWwPXFpm1BZkrFmIKM45kMtVlqaZI17hmSD/UUcPGdt3Cag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zc+A3xnM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HlnfhHdfjevXdjQVYFmiX94WQ1u9RlobiSXLEyJd84I=; b=zc+A3xnM3QJ/QkIQSdFTQ6kjXb
	GAUlBaviwPU7VJNt1qDCmdzvvFQSQufg2HAAMfYAArt9aZL92r6TuBpsl4/+/qE2ysWy7EulYylWS
	zRyOP67PSLb1zD7L2NXalQKhtiWUQyCyQneWi/LZ2UAhPfQqbO2q0XGM8UHNTadftJA0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tL0XZ-00Fo03-VK; Tue, 10 Dec 2024 14:44:41 +0100
Date: Tue, 10 Dec 2024 14:44:41 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	imx@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: fec: use phydev->eee_cfg.tx_lpi_timer
Message-ID: <649e70e2-5690-4f6c-95d2-3e74c9636d2c@lunn.ch>
References: <E1tKzVS-006c67-IJ@rmk-PC.armlinux.org.uk>
 <Z1g2md_S1kEjOKQH@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1g2md_S1kEjOKQH@shell.armlinux.org.uk>

On Tue, Dec 10, 2024 at 12:39:53PM +0000, Russell King (Oracle) wrote:
> On Tue, Dec 10, 2024 at 12:38:26PM +0000, Russell King (Oracle) wrote:
> > Rather than maintaining a private copy of the LPI timer, make use of
> > the LPI timer maintained by phylib. In any case, phylib overwrites the
> > value of tx_lpi_timer set by the driver in phy_ethtool_get_eee().
> > 
> > Note that feb->eee.tx_lpi_timer is initialised to zero, which is just
> > the same with phylib's copy, so there should be no functional change.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> Note that this need testing on compatible hardware - I only have iMX6
> which doesn't have EEE support in FEC.

The FEC hardware i have does not have EEE either. Sorry.

	Andrew


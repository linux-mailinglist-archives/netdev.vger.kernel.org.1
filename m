Return-Path: <netdev+bounces-147512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 035809D9E92
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 21:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE0D6283892
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 20:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A834A1DF75D;
	Tue, 26 Nov 2024 20:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="b5oJKaKV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAB51D63E9
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 20:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732654718; cv=none; b=ofqAZ+ZGJmVsHLpc7e100xULP6U7epetrfwGWBjJ35aoBe1zgGU91wKHa0PtUMZes0zHNID8KZhYptXjzkTdcGpbcnAtJ/9Bvhk+XbbroQyFanrIXrcbBExZp0XmM2vDxt4x7AGHBHmoXs12LUQpw+o8jMVrLPjbfhT+/0H7hlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732654718; c=relaxed/simple;
	bh=HNN0Clz+jn45GuqrZswChyl7C1Koj+1u7lWyKBtz6Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coroKg+Aw6cJ3E1Ay4vJuKphAb4G7AQyki6zEwwPPJehzyigW1XFhmJzYcHg1sI+JJ7AzEOoJAvdNMsqhvtJkabpwsPpzVTM4VAMBf7ZiCPRsZFZVuAzR4UbNpH7dTyiye+HrEWwgdZwOwdvdZJvpgaDSFKUkq0gX6pgXWZFuQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=b5oJKaKV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lx8vdZBD2Yjtb5JOApwawLh1tjrZFtP7efpYFVXksk8=; b=b5oJKaKV0cPBizpR8xJdfk1BWX
	rEHb7aFvMmaS99O6B4/bDuHwYkCDjuqnbG/htG0lyAvqQ7Y64rqQc3jyUPddzHyPNldFaUkPoDXn+
	nU472aESQQRV/m6yUruoCzzkLAdp08IyrX4zOcTQIH7fdn61OaslppWw3cxZahHb9rv0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tG2da-00EZ7D-6k; Tue, 26 Nov 2024 21:58:22 +0100
Date: Tue, 26 Nov 2024 21:58:22 +0100
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
Subject: Re: [PATCH RFC net-next 06/16] net: phy: marvell: implement
 phy_inband_caps() method
Message-ID: <1c4c1d14-88cc-46cd-870c-eb7a987c0495@lunn.ch>
References: <Z0WTpE8wkpjMiv_J@shell.armlinux.org.uk>
 <E1tFroM-005xQ8-6e@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tFroM-005xQ8-6e@rmk-PC.armlinux.org.uk>

On Tue, Nov 26, 2024 at 09:24:46AM +0000, Russell King (Oracle) wrote:
> Provide an implementation for phy_inband_caps() for Marvell PHYs used
> on SFP modules, so that phylink knows the PHYs capabilities.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


Return-Path: <netdev+bounces-147510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A07DE9D9E8F
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 21:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D4B283A1D
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 20:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB65C1DF73C;
	Tue, 26 Nov 2024 20:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wx9R1gAj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D424B1DF253
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 20:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732654628; cv=none; b=OV9D6kxHAVR3YShelpiDjLX8HD81ROFlxzdLL/iO3aTyGfptSBANdapBDlQCju/qaXWiEBsQESVijU6dYsxi0yuGAYYibxcpAx7E03Aeqmg0h9ar+VxTwxRvQPaxt1J5Sc3bv/nXbIdsJIOuAKsPKAfmjYzgACoUOJc7gdsQMI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732654628; c=relaxed/simple;
	bh=FeFCgNv/6Fni+1yuNE92SHdaQM7DSwpMtzt8vE/zKWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLS9Yvg2T2w4VtYt/2bxYxMH1uXRw85x4gGp00JfcsDl0t4IFZNKrO9IQvsiGyZfVe4nVey3Tt0BVrWU63RmI0+DLbmsNtlDeCTVkpuYRDnj8vc7eZx82gBmGaxNcfmeAuLGscf3cu96iXvwtPn3r4HC4o+ZitvmNPZpS4J9HRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wx9R1gAj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8bk0eDi4lhzSA0jEmiEZSOhunHrYMNImxYTUhwQ+4mo=; b=wx9R1gAjXtyw7VRv8VzC+CBjfB
	zy/UdOGExHBw7LZgdoAqOacDJ2KHU5JO87lWgMemogbZc/H9BkbfZWnQ369rnwIvWxCtZ9v4nuQe0
	LbF2L6auyTVFpgoi+sZ3RZ6x2Th2KbJns+PJof+n/evLF8fAS9PhFJ4qIEDCc8urY9U0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tG2c3-00EZ5A-Tj; Tue, 26 Nov 2024 21:56:47 +0100
Date: Tue, 26 Nov 2024 21:56:47 +0100
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
Subject: Re: [PATCH RFC net-next 04/16] net: phy: add phy_inband_caps()
Message-ID: <4484cd63-87f7-4b3b-8251-b99b35b4d3a8@lunn.ch>
References: <Z0WTpE8wkpjMiv_J@shell.armlinux.org.uk>
 <E1tFroB-005xPw-Vd@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tFroB-005xPw-Vd@rmk-PC.armlinux.org.uk>

On Tue, Nov 26, 2024 at 09:24:35AM +0000, Russell King (Oracle) wrote:
> Add a method to query the PHY's in-band capabilities for a PHY
> interface mode.
> 
> Where the interface mode does not have in-band capability, or the PHY
> driver has not been updated to return this information, then
> phy_inband_caps() should return zero. Otherwise, PHY drivers will
> return a value consisting of the following flags:
> 
> LINK_INBAND_DISABLE indicates that the hardware does not support
> in-band signalling, or can have in-band signalling configured via
> software to be disabled.
> 
> LINK_INBAND_ENABLE indicates that the hardware will use in-band
> signalling, or can have in-band signalling configured via software
> to be enabled.
> 
> LINK_INBAND_BYPASS indicates that the hardware has the ability to
> bypass in-band signalling when enabled after a timeout if the link
> partner does not respond to its in-band signalling.
> 
> This reports the PHY capabilities for the particular interface mode,
> not the current configuration.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


Return-Path: <netdev+bounces-149964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E28D19E8462
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 10:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3ABA281979
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 09:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E1D12BF24;
	Sun,  8 Dec 2024 09:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FCa9oBeQ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9DF6F305
	for <netdev@vger.kernel.org>; Sun,  8 Dec 2024 09:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733649220; cv=none; b=vCdL/I0USDtVbDcBsbNxvJXGL3yAQq4f3ynxSAtYNivxEkYq0pLIRgokyU13OOeYlQ3uu/qhtRsBULSUCVLTv3N9oG85frekY10sP4FpnGpgVRqE5eWCNx9zmMJT4X3acCyzN/eSQui0a2fNapl/ayb16ZTFu01Gn1DsJmSN/ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733649220; c=relaxed/simple;
	bh=CneTU8FL5Dj1MGwd9gP4wLjqIfHLiUEl8GDx6JqW6pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRmId8vAq8LS86K3D4SGyLq5aPjShqcNpRyhI7JXgkgDqWpUxzEwYyqSwlhZKp8kGA0bl8l0zV+jIlJR3KA3+u5PJXu40gp8rMGS+ncSGUHtEyd3eOz/sm8WB0oLl0sECCByLhN+LK08Wy5M7k600QaFOuruKRD78Gx5xXOBpPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FCa9oBeQ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=e8OK8knLfdvUAL608L+NqsoFFkIWemXmAfHLj7NzNMU=; b=FCa9oBeQDol/UjpKrgK2Wh14Xn
	cfjEmozeyf5yDFgIEwndXBhNfIcmKNmBodIKz4tmMJVx2/Sxqv8nzp0KNBhZkTQeiHy7V022X8juf
	pOKnW56mphlgVc0VEX6gtPNStKIWMOjcHR4rLcaqoYu2xg28qlottDx4+wDzT/s1ZgIV3zXilavOT
	l7iUGxeH275ih97A9L1d+eNxnfRLx9/+I61Tq7NR1/iRPjKR3gGt4HNkD4rJB51bY1GNX/f+Bwbjh
	ch0tq1LUpIKLUIvqKXVuvm80FxuPuwd4R2G8SnGvCzJNYMHetNiuC36Gu8NXrOmSHAGFLCiXWaU1h
	IIA4OQQQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40238)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tKDLp-0007zK-05;
	Sun, 08 Dec 2024 09:13:17 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tKDLj-0000vv-29;
	Sun, 08 Dec 2024 09:13:11 +0000
Date: Sun, 8 Dec 2024 09:13:11 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 2/3] net: pcs: pcs-mtk-lynxi: implement
 pcs_inband_caps() method
Message-ID: <Z1VjJ8ago-HetCxi@shell.armlinux.org.uk>
References: <Z1F1b8eh8s8T627j@shell.armlinux.org.uk>
 <E1tJ8NR-006L5P-E3@rmk-PC.armlinux.org.uk>
 <Z1UMEnlZ_ivTsru5@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1UMEnlZ_ivTsru5@pidgin.makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Dec 08, 2024 at 03:01:38AM +0000, Daniel Golle wrote:
> On Thu, Dec 05, 2024 at 09:42:29AM +0000, Russell King (Oracle) wrote:
> > Report the PCS in-band capabilities to phylink for the LynxI PCS.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> >  drivers/net/pcs/pcs-mtk-lynxi.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-lynxi.c
> > index 4f63abe638c4..7de804535229 100644
> > --- a/drivers/net/pcs/pcs-mtk-lynxi.c
> > +++ b/drivers/net/pcs/pcs-mtk-lynxi.c
> > @@ -88,6 +88,21 @@ static struct mtk_pcs_lynxi *pcs_to_mtk_pcs_lynxi(struct phylink_pcs *pcs)
> >  	return container_of(pcs, struct mtk_pcs_lynxi, pcs);
> >  }
> >  
> > +static unsigned int mtk_pcs_lynxi_inband_caps(struct phylink_pcs *pcs,
> > +					      phy_interface_t interface)
> > +{
> > +	switch (interface) {
> > +	case PHY_INTERFACE_MODE_1000BASEX:
> > +	case PHY_INTERFACE_MODE_2500BASEX:
> > +	case PHY_INTERFACE_MODE_SGMII:
> > +	case PHY_INTERFACE_MODE_QSGMII:
> 
> QSGMII is not supported by this PCS.

Well...
- lynx_pcs_get_state(), lynx_pcs_config(), and lynx_pcs_link_up()
  include QSGMII in their case statements.
- lynx_pcs_config_giga() refers to QSGMII in a comment, grouping it
  with SGMII configuration.

I think if the hardware doesn't support QSGMII, these references to it
should be removed?

I also think that adding a .pcs_validate() method would be a good idea
to reject interface modes that the PCS does not support.

> Apart from that looks good to me.
> 
> Reviewed-by: Daniel Golle <daniel@makrotopia.org>

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


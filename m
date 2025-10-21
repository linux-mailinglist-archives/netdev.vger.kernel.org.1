Return-Path: <netdev+bounces-231098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C47ABF4F09
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 09:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68E604F3694
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 07:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFB927B335;
	Tue, 21 Oct 2025 07:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="hrcX/nfW"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2BE27B331;
	Tue, 21 Oct 2025 07:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761031478; cv=none; b=IkbIOCxRyTMWMHn31fTXiL03oijSuiCZoorZ5P3bW4IlMDjTRXxy9euP9Eb8xxf3eb0ptnfmW6rbuPHde+CUfwyBrHSaznI/yjNVGo0uibFj+17CMI5DlqH6PERqorJkhACFGsoAjbkVYREw/YaR6jSK59e0rkjnr+pBZWqgPBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761031478; c=relaxed/simple;
	bh=wrvOnxEGwa6S6SGZDKdNUB9ChPEBhfrsVSb4fcPlT1c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6wAH2JS9+cNzxD5MiKBbu+SJnFfPPa46RlFdvzlI8a3MrNLMOUFXODwtBL1eVxDml4Zm4n+XffjWUkPJaKCY1MukAiS6j46QJUV3PzJZ04St3pDhSvQ5WnXsW1uyOSpC8PAE5Wxwtihz7yG+xQYZslGqTdM2S+9WjFnM7KRfNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=hrcX/nfW; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id C2919A0771;
	Tue, 21 Oct 2025 09:24:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-type:content-type:date:from:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=mail; bh=gsdios+6sipJyD9KcVqTCicUa97jHb3NO/XyOWAPPI4=; b=
	hrcX/nfWwny5slj7IbVSHwDZC0FpGCjJs/fSFr6JWlPCMmJMwxzoRI7cJpkHBNoM
	5dr8juZmzbqkMCzonEKep9K6KuFKKW2UdLu70ezcyJ42e8DkSOTBy4g4qyCijRa0
	63V5XPUkkuEuI9hit+YPRK9s9wUNwjvLVrpoLv0VX7gcw83BiDSnhAj6KPOzBxYo
	NsvO0APOpXyxD4YNxg9JDT29/E+QWfIN3/MIHPvD4hWneMgWBNOcUeUR8i8VSqWE
	xMmKDU1qIswfg4D1rU4oyvYY/GHE6ZR8C5RTTvoICH5eglsAclcTlk1R/dgLPSGC
	cOG3U7LLwen+eWjnEN5lPFAFuE78FMO4a7XxE7X+WDVnhFrUMZO0PdHpsd585pzu
	RTCmrf66thOR0Ni20BSA6VJJtBsEZDL7YjMnSkx93Vm0e0S8eV5lKcvJJF0Eomf7
	jCXciCnzaTGJLMATo1BvoevFw7Y+O5zLbM3Z41dYkHX6Ncrcdi+tK3YOwum+iF1K
	vAWR+jlcHh10ysIx+IOMbd3TCluCHuXlVikVvZ9vGbdVYVPKFcHCVLkbgfCwAU9o
	QDiBC610x6W4NHjJ4WC6nMEILMw3h9zG1BKt0ZyZPQyF3zOGMB0wLDRw1ijk4tDi
	rFyOYln3LXpQHd477lCDv2F3Z5BOuBAanGbpHzRb4xk=
Date: Tue, 21 Oct 2025 09:24:18 +0200
From: Buday Csaba <buday.csaba@prolan.hu>
To: Philipp Zabel <p.zabel@pengutronix.de>
CC: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 4/4] net: mdio: reset PHY before attempting
 to access registers in fwnode_mdiobus_register_phy
Message-ID: <aPc1Ii7eVFRaXy4-@debianbuilder>
References: <cover.1760620093.git.buday.csaba@prolan.hu>
 <cb6640fa11e4b148f51d4c8553fe177d5bdb4d37.1760620093.git.buday.csaba@prolan.hu>
 <af5211fbb818c873f22b6622526fa8e0c9eb2fde.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <af5211fbb818c873f22b6622526fa8e0c9eb2fde.camel@pengutronix.de>
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1761031466;VERSION=8000;MC=1079157708;ID=129845;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155F64736A

Thank you!
I do not know how that slipped.
I will fix it in v4.

Regards,
Csaba

On Mon, Oct 20, 2025 at 11:16:11AM +0200, Philipp Zabel wrote:
> On Fr, 2025-10-17 at 18:10 +0200, Buday Csaba wrote:
> > Implement support for the `phy-id-read-needs-reset` device tree
> > property.
> > 
> > When the ID of an ethernet PHY is not provided by the 'compatible'
> > string in the device tree, its actual ID is read via the MDIO bus.
> > For some PHYs this could be unsafe, since a hard reset may be
> > necessary to safely access the MDIO registers.
> > 
> > This patch performs the hard-reset before attempting to read the ID,
> > when the mentioned device tree property is present.
> > 
> > Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
> > ---
> > V2 -> V3: kernel-doc replaced with a comment (fixed warning)
> > V1 -> V2:
> >  - renamed DT property `reset-phy-before-probe` to
> >   `phy-id-read-needs-reset`
> 
> Not completely, see below.
> 
> >  - renamed fwnode_reset_phy_before_probe() to
> >    fwnode_reset_phy()
> >  - added kernel-doc for fwnode_reset_phy()
> >  - improved error handling in fwnode_reset_phy()
> > ---
> >  drivers/net/mdio/fwnode_mdio.c | 35 +++++++++++++++++++++++++++++++++-
> >  1 file changed, 34 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
> > index ba7091518..8e8f9182a 100644
> > --- a/drivers/net/mdio/fwnode_mdio.c
> > +++ b/drivers/net/mdio/fwnode_mdio.c
> > @@ -114,6 +114,36 @@ int fwnode_mdiobus_phy_device_register(struct mii_bus *mdio,
> >  }
> >  EXPORT_SYMBOL(fwnode_mdiobus_phy_device_register);
> >  
> > +/* Hard-reset a PHY before registration */
> > +static int fwnode_reset_phy(struct mii_bus *bus, u32 addr,
> > +			    struct fwnode_handle *phy_node)
> > +{
> > +	struct mdio_device *tmpdev;
> > +	int err;
> > +
> > +	tmpdev = mdio_device_create(bus, addr);
> > +	if (IS_ERR(tmpdev))
> > +		return PTR_ERR(tmpdev);
> > +
> > +	fwnode_handle_get(phy_node);
> > +	device_set_node(&tmpdev->dev, phy_node);
> > +	err = mdio_device_register_reset(tmpdev);
> > +	if (err) {
> > +		mdio_device_free(tmpdev);
> > +		return err;
> > +	}
> > +
> > +	mdio_device_reset(tmpdev, 1);
> > +	mdio_device_reset(tmpdev, 0);
> > +
> > +	mdio_device_unregister_reset(tmpdev);
> > +
> > +	mdio_device_free(tmpdev);
> > +	fwnode_handle_put(phy_node);
> > +
> > +	return 0;
> > +}
> > +
> >  int fwnode_mdiobus_register_phy(struct mii_bus *bus,
> >  				struct fwnode_handle *child, u32 addr)
> >  {
> > @@ -129,8 +159,11 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
> >  		return PTR_ERR(mii_ts);
> >  
> >  	is_c45 = fwnode_device_is_compatible(child, "ethernet-phy-ieee802.3-c45");
> > -	if (is_c45 || fwnode_get_phy_id(child, &phy_id))
> > +	if (is_c45 || fwnode_get_phy_id(child, &phy_id)) {
> > +		if (fwnode_property_present(child, "reset-phy-before-probe"))
> 
> Commit message says this should be "phy-id-read-needs-reset" now.
> 
> regards
> Philipp
> 



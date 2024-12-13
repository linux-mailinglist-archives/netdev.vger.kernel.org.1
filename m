Return-Path: <netdev+bounces-151840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C47309F13A1
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 18:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D1F16A27F
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 17:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87481E47C6;
	Fri, 13 Dec 2024 17:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AQalMVSi"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038C057C9F;
	Fri, 13 Dec 2024 17:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734110951; cv=none; b=End50oCl1TWc7ZEfVtJ/ABDGdip1clDk2LJu7/nWQlOUfzbNNQz+S+oGrUS1fGe7weXJNI6kMHOZN6Vrz1Jk7TNBl2XucaPm5mSTGndo2DPWVGcxPtYApGUNOp2O8LTx3hexwtW+iyxkXLQdfgFhxKs3y5iv7zLOFWZY44mZ7Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734110951; c=relaxed/simple;
	bh=h9Bxlh2biHmc4yS2UvVFQRIM10ksU2ALa5LmieToxyY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=crMSvlQX/ZPkxgfB2OEnzur8BwGKbL4DC2I/z29gaBx6g0MO/G89ga+WzINP4hd88UpiwT2oezFkFXPwDms9iD61gBb3l6TMDPKCTG3wEK6FCzMFUG64u1klq5dL82EAzasMzsEA83iGhBJdH5pJZ3PkO9TmAoJjEIW/4vWGv6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AQalMVSi; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B246AC0006;
	Fri, 13 Dec 2024 17:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734110947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qh9Zm1VmGUbfUfimsR2fhN/wfQpXtijhFkCUNze7318=;
	b=AQalMVSihDbNV7GO0/TcVv+Jhxil4XJ9NFon+gfZ3+6jeSdAs/h2D5x4du/rqyku1zjsEV
	jHledJm9X3nJ9w/4ZYxXw0VGSJimYUxqJ2s7zL1IRogsrEsmFXny/JyaNE4JgKPxUltoXy
	bbOy0xSAhT1e+eUsKmwMHTGP17gg9mYmUQW4nwllTH/iqF08QdwVGr37xpWqsLFGtsWoW5
	jZshQRSQEbs4NovEj0tT4w4O937zHMToa5TiLjA7aQyKPOnG8nS8dGnN/uSWCG71EeKxtF
	Gm+ZyztxUyEfCuw6id5w3/SylvJxbMdvOSj166I4N4yZfmDzMOv0yGa8ls6Z4A==
Date: Fri, 13 Dec 2024 18:29:04 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexis =?UTF-8?B?TG90aG9yw6k=?=
 <alexis.lothore@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: stmmac: dwmac-socfpga: Set interface
 modes from Lynx PCS as supported
Message-ID: <20241213182904.55eb2504@fedora.home>
In-Reply-To: <Z1wnFXlgEU84VX8F@shell.armlinux.org.uk>
References: <20241213090526.71516-1-maxime.chevallier@bootlin.com>
	<20241213090526.71516-3-maxime.chevallier@bootlin.com>
	<Z1wnFXlgEU84VX8F@shell.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Russell,

On Fri, 13 Dec 2024 12:22:45 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Fri, Dec 13, 2024 at 10:05:25AM +0100, Maxime Chevallier wrote:
> > On Socfpga, the dwmac controller uses a variation of the Lynx PCS to get
> > additional support for SGMII and 1000BaseX. The switch between these
> > modes may occur at runtime (e.g. when the interface is wired to an SFP
> > cage). In such case, phylink will validate the newly selected interface
> > between the MAC and SFP based on the internal "supported_interfaces"
> > field.
> > 
> > For now in stmmac, this field is populated based on :
> >  - The interface specified in firmware (DT)
> >  - The interfaces supported by XPCS, when XPCS is in use.
> > 
> > In our case, the PCS in Lynx and not XPCS.
> > 
> > This commit makes so that the .pcs_init() implementation of
> > dwmac-socfpga populates the supported_interface when the Lynx PCS was
> > successfully initialized.  
> 
> I think it would also be worth adding this to Lynx, so phylink also
> gets to know (via its validation) which PHY interface modes the PCS
> can support.
> 
> However, maybe at this point we need to introduce an interface bitmap
> into struct phylink_pcs so that these kinds of checks can be done in
> phylink itself when it has the PCS, and it would also mean that stmmac
> could do something like:
> 
> 	struct phylink_pcs *pcs;
> 
> 	if (priv->hw->xpcs)
> 		pcs = xpcs_to_phylink_pcs(priv->hw->xpcs);
> 	else
> 		pcs = priv->hw->phylink_pcs;
> 
> 	if (pcs)
> 		phy_interface_or(priv->phylink_config.supported_interfaces,
> 				 priv->phylink_config.supported_interfaces,
> 				 pcs->supported_interfaces);
> 
> and not have to worry about this from individual PCS or platform code.

I like the idea, I will give it a go and send a series for that if
that's ok :)

Thanks,

Maxime


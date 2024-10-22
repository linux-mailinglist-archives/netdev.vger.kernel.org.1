Return-Path: <netdev+bounces-137857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBA59AA195
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 13:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D3CE282601
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 11:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55E119CC21;
	Tue, 22 Oct 2024 11:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ymV/nUhL"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CE9199FAB
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 11:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729598391; cv=none; b=knSbxqBnsYb7vjVjBp56S4HrPyd6/eR6wFAqG2yh8iULPtYJ0LPX+w43PRyyeOGlduZogCnaXKw601L7abt3aYmss67aYk/o6BCiH0kRVaGpS4Gs7Uy7ng19TcWRuVfMKPPMkX933/pR6hJaonifrjt+GIRxIriO+ui7AKTPn2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729598391; c=relaxed/simple;
	bh=wmIdsPtQd5PnHD/1bSH1SW7AShrZCClLpLxLB51PMWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTOjPwUMHdlIBZX0ijt1XDG+dds6wUkiAw/37mFcZOTuW0G+iogME66DNurYv3OTEhfY8wnh7Ryihf7EhqQCLd5P6KZL9QWhtjEWqO83mfb26sv41gqIzHawv6xf3Pp0LaZI/tkj4rdZ/DQmDYRZGwJus9TdBBU0Q9WjEo9dE6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ymV/nUhL; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qk6/Vsj3O50ws4yZfDe4RHHxGsSX2m2udVAEWBK9ImU=; b=ymV/nUhLPCNLooqZo4xZAG1gER
	EBUrah71L6tlfI4vcjXSkyuQuqodBWWRpP9dYOoLF1b7UQA3m87WShfMuxkUKuU0oQ2THqOi1vnuh
	89S8o+FI3HRLEGusA+njoSFHkrE6thlbNvcUK8B4qeBl1qZCnbbetFIfkSFrW22j3KoSPRMtz3O63
	E/HJ5e40voOXG8RKEn6+2iztRqqZToR47KRE2HmhlQ9/ZVm65WIiDKUqrMwFj6ewjd9qste28ZzHj
	ycu1he1rMMANaG7Ot4sSVNxNaflVE1sBSqa9GsQirWsavJr6C6FKyiDzy7w8dscWkqTgr7by0Wyza
	8BiIIp+Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51466)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1t3DY8-0004pD-2k;
	Tue, 22 Oct 2024 12:59:45 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1t3DY8-0002h0-0e;
	Tue, 22 Oct 2024 12:59:44 +0100
Date: Tue, 22 Oct 2024 12:59:44 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 0/3] net: phylink: simplify SFP PHY attachment
Message-ID: <ZxeTsApaFCIjl5RH@shell.armlinux.org.uk>
References: <ZxeO2oJeQcH5H55X@shell.armlinux.org.uk>
 <20241022135447.391b6f59@device-21.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022135447.391b6f59@device-21.home>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Oct 22, 2024 at 01:54:47PM +0200, Maxime Chevallier wrote:
> Hello Russell,
> 
> On Tue, 22 Oct 2024 12:39:06 +0100
> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> 
> > Hi,
> > 
> > These two patches simplify how we attach SFP PHYs.
> > 
> > The first patch notices that at the two sites where we call
> > sfp_select_interface(), if that fails, we always print the same error.
> > Move this into its own function.
> > 
> > The second patch adds an additional level of validation, checking that
> > the returned interface is one that is supported by the MAC/PCS.
> > 
> > The last patch simplifies how SFP PHYs are attached, reducing the
> > number of times that we do validation in this path.
> > 
> >  drivers/net/phy/phylink.c | 82 ++++++++++++++++++++++++-----------------------
> >  1 file changed, 42 insertions(+), 40 deletions(-)
> 
> It looks like the patches didn't make it through, there're also not on
> lore nor patchwork :(

You're too quick. I was delaying the patches for two reasons:

1) to ensure Jakub's nipa bot bug doesn't get me again.
2) build-testing the series, as I'd made a change... and unsurprisingly
   not waiting for that to finish, and sending the patches, immediately
   after sending it found a problem. :(

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


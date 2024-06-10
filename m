Return-Path: <netdev+bounces-102203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A86901E1A
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 11:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ED412811FE
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 09:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C9B757F3;
	Mon, 10 Jun 2024 09:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gWKnx8ln"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E3C74C08
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 09:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011472; cv=none; b=Hij2e5Psbku7o8kr0afGObQy+pFbQjbC7oZ/T6ys/kNmBGOM8dMtokF8GPI5NGOWkFyDuK2imTq6QwhD5aMyU3kmTltES+ddCyQLjj8mxUo7TpSq6VkWUB9XA7Vt25mnIanBUgUn8P3gSj6ETTbY+/XddNQ76qh6SgBgL2oWDjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011472; c=relaxed/simple;
	bh=mopJdlwLgTcdOOfB3A1fbAyaQ2Q50Cx0pZ0UJCHVAxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJyuOufmGZqvxScFTcu3VsD41/7H21uSq9ZHAgRPGJRp9e8QVOTmXtmc2qqp/XF4N6RA7bCSfn2miFrNQZ4lmOdmUjnNE8ApCuOyEy223YZSSBEmlK5BgR1NmG9TOYC6qZ76GTBtDiVpm4u3EBuypSrzaF+qaYRLD931ocPbIWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=gWKnx8ln; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ia89vxLEHsjxSOnYnkE5CVk6E9NLeLG5CVMk/7Pv5aQ=; b=gWKnx8ln8WyqO2KHfLJhbYL82+
	M1+6mgxQ8fboi7A9pGxTgeeTQE5lY26ZRGsha8DuNeHWbhjR/xV2mM9BIj8RqoEj8MDUYNuRrRHCB
	8UVjxeA18PE6dPf90Z5QKtbNQG3OMB46Dc9YkkIvgH8Gbv/+2wrQBVXNpaCW/mv5Z8NX0VYmtZBGR
	sHYzQNTrB3yJEG3eQtO4fdJiVUw2mGm2gl+L2+VGMcKhB0tpV5W2kIXOka9bDU9uvVK/RcofZhYkN
	TiVzr2f05L1iipPvCMMByOa2+3MaiKC8FgX1Xt9f3mCb/5B7oCyro/mQR2M7gZH0c6S5MQXbYT6nY
	bAue5opA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47070)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sGbGE-0001EV-1D;
	Mon, 10 Jun 2024 10:24:18 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sGbGF-0006lX-TT; Mon, 10 Jun 2024 10:24:19 +0100
Date: Mon, 10 Jun 2024 10:24:19 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC net-next v2 3/8] net: stmmac: dwmac1000: convert
 sgmii/rgmii "pcs" to phylink
Message-ID: <ZmbGQ8bnxBIudT1S@shell.armlinux.org.uk>
References: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
 <E1sD0Ov-00EzBu-BC@rmk-PC.armlinux.org.uk>
 <6n4xvu6b43aptstdevdkzx2uqblwabaqndle2omqx5tcxk4lnz@wm3zqdrcr6m5>
 <6qpcartwgkgdmtxwj4puxn2exbpiv6t6fxv2b3kecu6ezzdogs@yii3j3xtougr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6qpcartwgkgdmtxwj4puxn2exbpiv6t6fxv2b3kecu6ezzdogs@yii3j3xtougr>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jun 05, 2024 at 04:59:14PM -0500, Andrew Halaney wrote:
> On Wed, Jun 05, 2024 at 03:05:43PM GMT, Andrew Halaney wrote:
> > This seems to me that you're doing the TODO here? Maybe I'm
> > misunderstanding... maybe not :)
> > 
> > > +		phylink_pcs_change(&hw->mac_pcs, false);
> 
> Continuing to read through this all, sorry for the double reply and
> possibly dumb question. Should we be passing in false unconditionally
> here?

It depends whether there is a way to get the current status of the link
without side effects (e.g. where a read clears a latched-low link
status.) If that's not possible, then passing "false" is safe provided
there aren't any spurious interrupts, since we'll always assume that
the link has dropped. If there are spurious interrupts, then the link
will go down/up each time there's a spurious interrupt. Even so, that's
better than missing a change in the link status which may result in
loss of link without manual intervention.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


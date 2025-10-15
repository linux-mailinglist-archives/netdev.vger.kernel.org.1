Return-Path: <netdev+bounces-229649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07550BDF47F
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 17:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB8A73A384B
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 15:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FF926D4C2;
	Wed, 15 Oct 2025 15:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="04hQz4eK"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C9E17B50F;
	Wed, 15 Oct 2025 15:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760540821; cv=none; b=cYRuelq83WJW6kJBS7fxyU0GAn8cIzLfdJHusEt6KG8ab4bDdww+LgZwZdHzEfW2oQP2z13KHp4flIrI/dZuLIiMunpxjbRp3O2yPyieGDg8jevFv/UK8X7tmrOaFG5yFh9Vm4VChKXf4PGJRNY/WDbshUdleEOTuNha2TTlyPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760540821; c=relaxed/simple;
	bh=paHTQ7+eFNh+tQ69LcRC1uClOsSq9bwcalYHiasb8S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2wYhcx9bUvLTUYVrQL7vSRu4uZUzAiisvuA8MiiHhhg+OdmogtBvbTeMdn7oWzx9xIbNR1O5TQ7qD/jd86NxcBNQacymNZY16LvNZnfJ2kh/O2xZ5hRIolSt/wk8GfDrUjP+JRz/d3IzPeAezkXjhKE6j3vG2KiSY1ZRbncHh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=04hQz4eK; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=i8WH71db750jps9WxI3z1NEUJwkE3VXRhtPG7iUgTWY=; b=04hQz4eK43+AW/wKb5wdQbpX7W
	9qjxEPcOHoILOsxV1PI8IytNEk84VUOiE3we1jZwRHbOWnulNKUJp706hKrMypx3oAeFgwVnxQJp1
	7NcBfL3w49o/pLRiGOLUQIQ/mWRC0KCTP8+VfDs1dsu+lXWJju+rDn+BWTwR/+t0mRP2hDyld2Iy+
	Y+3njCB/O24OWRDwUd5m5IiCMsrA2qo8dBfgqnXLAfyzO2XLKOXq0hFkLwNxW1dEVY+Dz3X9mnDRT
	2VTa9nPxpngzLSATgjGK+7eSuRfEQT3c4w5Fc5pxwzaBcGyASUd1jlsNEB+d8MwZ634P3VQG8TnLz
	W4C0Q8HQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37834)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v935W-000000004wH-29yk;
	Wed, 15 Oct 2025 16:06:50 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v935S-000000002Le-3AO4;
	Wed, 15 Oct 2025 16:06:46 +0100
Date: Wed, 15 Oct 2025 16:06:46 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: stmmac: Move subsecond increment
 configuration in dedicated helper
Message-ID: <aO-4hnUINpQ0JORE@shell.armlinux.org.uk>
References: <20251015102725.1297985-1-maxime.chevallier@bootlin.com>
 <20251015102725.1297985-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015102725.1297985-2-maxime.chevallier@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Oct 15, 2025 at 12:27:21PM +0200, Maxime Chevallier wrote:
> +static void stmmac_update_subsecond_increment(struct stmmac_priv *priv)
> +{
> +	bool xmac = priv->plat->has_gmac4 || priv->plat->has_xgmac;

Just to say that I have patches that get rid of these has_xxx flags for
the cores, and these changes (and the additional platform glue patches
that have been posted) will conflict with them.

Given the rate of change in stmmac, at some point we're going to have
to work out some way of stopping stmmac development to get such an
invasive cleanup change merged - but with my variability and pressures
on the time I can spend even submitting patches, I've no idea how that
will work... I was going to send them right at the start of this
cycle, but various appointments on Monday and Tuesday this week plus
work pressures prevented that happening.

So, I decided instead to send out the first stmmac PCS series... which
means I now need to wait for that to be merged before I can think about
sending out anything else stmmac-related. (and there's more PCS patches
to come beyond the 14 I sent today.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


Return-Path: <netdev+bounces-95718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D41948C32A9
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 19:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88BBF281F8D
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 17:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33091B960;
	Sat, 11 May 2024 17:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1noDtvzm"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5FFD27A;
	Sat, 11 May 2024 17:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715447579; cv=none; b=rFwtp5wHunyJ1hXktedB06VaNYC2dlWvqyLyMxlYbsUSC4tamuu16Ob+tPYc0YRlTtPJp8ECzxV+ntyyCmstUEv8hJJxLlLuD5fUxI+nrLo+N4eIfscm5WvpTOgJTluSvpnw9HQTsnKakqo596x6/rcLRBWHGsAck550TvRKwn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715447579; c=relaxed/simple;
	bh=Ea+0lH4nexc0bSRa2hoF5FRkiDGoufVtdVxTU4cEfOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucKEina5H4JTtFxb4c42/G2/W4UqU1P4iLZ0qhK62X225UgmAJdOeeXQB97ZAco9aTrE3ZpNI/DlZGQccdRyCoCPhol6IXG7DNaQYNtM9Nh1PXp88eKEQxMBlNqMJCwd5dH05/kz0OojYYyNG/brB757eGOtfylsWG9sCC7qVRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1noDtvzm; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+PYJZKJmp4DNEIJz0QH32REFiAYsuHCbhSQAQyPwHDQ=; b=1noDtvzmo/8NcsHS2R9xnr2nF/
	+HZYubHFsdnVYYib9Z4ABljM4TQHtabJKRYloqxpCmcUtZ0Gq4xCAxPqdPaSo55mmK8XQlBOUX4pS
	OsnNiL+moSUHSzGX5//3on5yr9Nk6tDf1w1lp8maVEuk+EYk99alEjby65oXCH3jSMSrin6dJcHz9
	Ce5ZpGad1DHE87yKIpjwEhSAPbsWX6Pue65cWdIacoVDJAjZAjJVJu3x3T/UtfWRRv2HeE8TDz0Il
	313vTSJPzuwe9M5308HtX7F5SiNWix7eXwAZi+FtAu/K44SZj112tAe60ewKePUYdXj1B2GMT2ECV
	OgChaOng==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41854)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s5qH3-00005T-1n;
	Sat, 11 May 2024 18:12:41 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s5qH0-0004QC-WA; Sat, 11 May 2024 18:12:39 +0100
Date: Sat, 11 May 2024 18:12:38 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>,
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	bcm-kernel-feedback-list@broadcom.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
	richardcochran@gmail.com, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2, net-next, 2/2] net: stmmac: PCI driver for BCM8958X
 SoC
Message-ID: <Zj+nBpQn1cqTMJxQ@shell.armlinux.org.uk>
References: <20240510000331.154486-3-jitendra.vegiraju@broadcom.com>
 <20240511015924.41457-1-jitendra.vegiraju@broadcom.com>
 <4ede8911-827d-4fad-b327-52c9aa7ed957@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ede8911-827d-4fad-b327-52c9aa7ed957@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, May 11, 2024 at 06:16:52PM +0200, Andrew Lunn wrote:
> > +	/* This device interface is directly attached to the switch chip on
> > +	 *  the SoC. Since no MDIO is present, register fixed_phy.
> > +	 */
> > +	brcm_priv->phy_dev =
> > +		 fixed_phy_register(PHY_POLL,
> > +				    &dwxgmac_brcm_fixed_phy_status, NULL);
> > +	if (IS_ERR(brcm_priv->phy_dev)) {
> > +		dev_err(&pdev->dev, "%s\tNo PHY/fixed_PHY found\n", __func__);
> > +		return -ENODEV;
> > +	}
> > +	phy_attached_info(brcm_priv->phy_dev);
> 
> What switch is it? Will there be patches to extend SF2?

... and why is this legacy fixed_phy even necessary when stmmac uses
phylink which supports fixed links, including with custom fixed status?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


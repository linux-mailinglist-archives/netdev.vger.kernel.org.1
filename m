Return-Path: <netdev+bounces-149364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 274789E5443
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 12:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6E81282821
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 11:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE8020DD43;
	Thu,  5 Dec 2024 11:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eVGB/+Yr"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B16020D4E4
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 11:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733399037; cv=none; b=WxF4dxuITrg+528PvQ4Vi6XK/AnDpm2mQ8NABZK5xQWzgJbm69/4dE7M02vkJ4B+lSpsGaINonjcNzCb179EMl676HdSRBQCwIQ3+C1dFo4ysFMcax++WoyZDfUODEn45TVXN03K0Dc6B0ioJ7x6fqtb/1hTDPPCygPrfVUhS3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733399037; c=relaxed/simple;
	bh=HHL7WUf0Vbc1n79DRZ9GUyeHgpAJVWe/6hvmlPdI4z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QaDliR20PEDOgZVWeoJl4RkUnFq3CvvKN2iM7kIlANxQ2y72MZWPKJZDy/BFxmQnkARJ1IrK4iDI1BkSXW8NjTUA/TmtXImqY/y2LQTGlLrPZCXisSxutB/QG3/8SjVPmHLoRoYA9kf0o4mY/QkJrspeACzyTvLPW8anS5XdFHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=eVGB/+Yr; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EJpz9kvuFPysHQmq1MMpQks3yX2kXuHQ3KUTI61q5eU=; b=eVGB/+YrrLDJMuadDzXo+IOdly
	dHWLL2yVpBPte1noEwtOEPyoA47q8hVERwLHmcqSUwZhgh0UKScTxsIMD50M38afeaQOyo0yANu5e
	IRG7MXsi+E5URtgr2nU3hY+9TGZVsxunqDuViWj+g1AcxhFD83fdCojD2TIGH07QHC+EU1unfdW+S
	XjSDn2o34zKSWQLxM1QC2pbwbIktuYXYEZGyhb38hQf2I8Op1DmQ50e2WTEKdx0NP/X0EsdvtbbAl
	anUp8tXA+maFH7tDpWQggq2lI4kdcS8JAx/eLEp2TVWPYUHC15V6xqNR10UqkL4WqiBAtpUneSGek
	Rm91zGVA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48100)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tJAGt-0004f3-00;
	Thu, 05 Dec 2024 11:43:51 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tJAGs-0006Vi-1I;
	Thu, 05 Dec 2024 11:43:50 +0000
Date: Thu, 5 Dec 2024 11:43:50 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: phy: avoid
 genphy_c45_ethtool_get_eee() setting eee_enabled
Message-ID: <Z1GR9oofMyE2I38p@shell.armlinux.org.uk>
References: <Z1GDZlFyF2fsFa3S@shell.armlinux.org.uk>
 <E1tJ9J7-006LIn-Jr@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tJ9J7-006LIn-Jr@rmk-PC.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Dec 05, 2024 at 10:42:05AM +0000, Russell King (Oracle) wrote:
> genphy_c45_ethtool_get_eee() is only called from phy_ethtool_get_eee(),
> which then calls eeecfg_to_eee(). eeecfg_to_eee() will overwrite
> keee.eee_enabled, so there's no point setting keee.eee_enabled in
> genphy_c45_ethtool_get_eee(). Remove this assignment.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

I seem to have missed adding Heiner's r-b given in the RFC posting:

Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


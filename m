Return-Path: <netdev+bounces-68916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576D4848D59
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 13:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 896631C20D2C
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 12:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D16522097;
	Sun,  4 Feb 2024 12:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zThtl2JY"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00722208E
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 12:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707048173; cv=none; b=kAC1GHI2PRzxzRQg5ytTqdcLEjtPobvRJasZZ0lFVRQ9BhcVInPX/YEVkz5ZBhpORcRv55C7aC6a5WoGSOEZSvagoV5tj3/J4kXKEFOGwUzVx/yl/3y9W7fGKpXifYD/c/Xm8R0/PuFnLiA5i+59sLW6z9gVVyOC1AM0nzm2wGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707048173; c=relaxed/simple;
	bh=3WpcA3ywwgNgEtJUwIHwnjZPtrJREOuDVhnyZKVOgzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLaUW8QyZh3BOXTs+4nZ/7yhmfecfSbwlZEHFLfh0QD8W7gANPqj9unQqcsRj2V0UfBS+MR8evkJHPsM5i9VoAA4OyxbakUcsJux00gVjp8XXy4+fcsZgiw4/nXIOyYspK4Kc8193dNpQ+1UNNwe9rumLPxLrl5/NlVm56WLGhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zThtl2JY; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AD+IVUHMa3dw9w4MF7Be3IiiFcnBNwHoY6xljGZOJKM=; b=zThtl2JYDIKy1ZxaplyiFGGYjx
	AVdesRkik9VBjoUP+J2Yofbu1kkroUFDrPwPFrvSeDM0L735yGGANTBuDyQF+X0Q0JCkyCM9Q3Bit
	y6s9IvCbe7X7RYSeYbyGi1KUk20OOEQN8SRdFEyRcgOwvSjce/n7AMMGDWs7zMcU63hRbFJTMb7Ye
	Da4eHsYX0gnUwC0l1EIkrWY2DNdSlbFIFjIO8dw7B7T2Nf7+yiKNWd/POk51sPN8jd/aBmR19oyip
	dUsNfkN4r/QB+7BCTgIsvJoZqET/CyGOVQkh7gPmiwULqUqh18Afcd5OpI5q1TjMJNcRtS3SFS+FS
	mlzTzAsA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33984)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rWbCk-0007uZ-2d;
	Sun, 04 Feb 2024 12:02:34 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rWbCe-0001jb-Kc; Sun, 04 Feb 2024 12:02:28 +0000
Date: Sun, 4 Feb 2024 12:02:28 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Byungho An <bh74.an@samsung.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Doug Berger <opendmb@gmail.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	Justin Chen <justin.chen@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	NXP Linux Team <linux-imx@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Vladimir Oltean <olteanv@gmail.com>, Wei Fang <wei.fang@nxp.com>
Subject: Re: [PATCH net-next 4/6] net: bcmgenet: remove
 eee_enabled/eee_active in bcmgenet_get_eee()
Message-ID: <Zb981J0wwFYhXPEo@shell.armlinux.org.uk>
References: <Zby24IKSgzpvRDNF@shell.armlinux.org.uk>
 <E1rVpvs-002Pe6-1w@rmk-PC.armlinux.org.uk>
 <e04888df-adba-49fc-b7f3-3b930e80af81@broadcom.com>
 <4586d004-a7b7-4e60-9493-0a1bbe7d79ba@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4586d004-a7b7-4e60-9493-0a1bbe7d79ba@broadcom.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Feb 02, 2024 at 05:21:57PM -0800, Florian Fainelli wrote:
> 
> 
> On 2/2/2024 5:17 PM, Florian Fainelli wrote:
> > 
> > 
> > On 2/2/2024 1:34 AM, Russell King (Oracle) wrote:
> > > bcmgenet_get_eee() sets edata->eee_active and edata->eee_enabled from
> > > its own copy, and then calls phy_ethtool_get_eee() which in turn will
> > > call genphy_c45_ethtool_get_eee().
> > > 
> > > genphy_c45_ethtool_get_eee() will overwrite eee_enabled and eee_active
> > > with its own interpretation from the PHYs settings and negotiation
> > > result.
> > > 
> > > Therefore, setting these members in bcmgenet_get_eee() is redundant,
> > > and can be removed. This also makes priv->eee.eee_active unnecessary,
> > > so remove this and use a local variable where appropriate.
> > > 
> > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > 
> > Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> > 
> > Is not there an opportunity for no longer overriding eee_enabled as well
> > since genphy_c45_ethtool_get_eee() will set that variable too?
> 
> Scratch that comment, you are doing it in the getter.

Also, priv->eee.eee_enabled is used in bcmmii.c, so we can't get rid of
it in the setter.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


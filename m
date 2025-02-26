Return-Path: <netdev+bounces-169897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA86A4652E
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 16:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FAC716DEF9
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 15:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94B82222A6;
	Wed, 26 Feb 2025 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Nr0yY4QO"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06248221DAD;
	Wed, 26 Feb 2025 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584102; cv=none; b=BlISPjEjGcN80PwqRrsiD3Da+CjQ6/yPo7BJYFqLu1Jb8ET+Z1sJJQ0/R4ioyyhWxdn2xJS00KLnrvqW+dPwPSNJXPdNrgRxIy2JLjwEW5iqMGHxbjRG63xtCS1RPwVrAGVjJKjN59xLJc0PzOuHV6JCIs749J4yUlu+fZdHHZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584102; c=relaxed/simple;
	bh=33i2bTQp+ZsHKxRZbNCSdJ8c5HwFI463KJdRgZDmFH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oN9OAmXouZXuXjqShP1bq/b8dU0CA/ummb4rfVEQx7WSv2RhZP0zrS67IdTCYHIhsy95csKw3x6llFMqlYqkkB994jUCsh99KTYkU2pg9t3hbeufhdngxdQBMSIMX8suFQ65huExZGTzym5Hc/GOX16iqiYQuE9aMFbOASj2wGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Nr0yY4QO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=We2PZZN/Z/OuW0OC8GwI1XN1ZlLiDb7BHXEm1VKevUk=; b=Nr0yY4QOvO504vfmWBFQmckDao
	kNFatIEDpJJ49/rgYpfiH++mWZHYZIFvqFiGiXICM9+pzthfUMdPm085ugAORIS3wfA6892RzO7ys
	XfghSaloouVCRP/vJ4x1dPqWm4qT9JOLDlXny/EWwtvq2FoQRvL01pJn6YNuVsEDQ2AQbmNrF1sMQ
	prEvODafyJe2vhYMbMrOCqIzl76gHh8JPgUgK0HbiqTvGpBjuY6PfdNEeMiouWLF5C7wG2IiUlS9m
	XFFePb5qrC1YziycPejRxgJ/jMXRSUZrhxfnRbnOM6zeZFJ4JKzGAho6Vn3ki5ucSBQ0Uy6i9xN8H
	fIvMutIA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42746)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tnJQQ-0004iF-1A;
	Wed, 26 Feb 2025 15:34:18 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tnJQG-0007CL-1X;
	Wed, 26 Feb 2025 15:34:08 +0000
Date: Wed, 26 Feb 2025 15:34:08 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: Simon Horman <horms@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	David E Box <david.e.box@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Serge Semin <fancer.lancer@gmail.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v8 1/6] net: phylink: use pl->link_interface in
 phylink_expects_phy()
Message-ID: <Z780cM9bejxhzTXO@shell.armlinux.org.uk>
References: <20250226074837.1679988-1-yong.liang.choong@linux.intel.com>
 <20250226074837.1679988-2-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226074837.1679988-2-yong.liang.choong@linux.intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Feb 26, 2025 at 03:48:32PM +0800, Choong Yong Liang wrote:
> The phylink_expects_phy() function allows MAC drivers to check if they are
> expecting a PHY to attach. The checking condition in phylink_expects_phy()
> aims to achieve the same result as the checking condition in
> phylink_attach_phy().
> 
> However, the checking condition in phylink_expects_phy() uses
> pl->link_config.interface, while phylink_attach_phy() uses
> pl->link_interface.
> 
> Initially, both pl->link_interface and pl->link_config.interface are set
> to SGMII, and pl->cfg_link_an_mode is set to MLO_AN_INBAND.
> 
> When the interface switches from SGMII to 2500BASE-X,
> pl->link_config.interface is updated by phylink_major_config().
> At this point, pl->cfg_link_an_mode remains MLO_AN_INBAND, and
> pl->link_config.interface is set to 2500BASE-X.
> Subsequently, when the STMMAC link goes down and comes up again,
> it is blocked by phylink_expects_phy().

I thought we ascertained that it's not "link goes down" but when the
interface is taken down administratively. "Link goes down" to most
people mean an event such as the network cable being unplugged.
Please fix the patch description.

> Since phylink_expects_phy() and phylink_attach_phy() aim to achieve the
> same result, phylink_expects_phy() should check pl->link_interface,
> which never changes, instead of pl->link_config.interface, which is
> updated by phylink_major_config().
> 
> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>

With, and *only* with the above fixed:

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


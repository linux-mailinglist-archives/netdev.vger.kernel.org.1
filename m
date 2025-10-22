Return-Path: <netdev+bounces-231818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDA5BFDCD7
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 20:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A4775355119
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 18:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F022E7F25;
	Wed, 22 Oct 2025 18:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WzZGa/PW"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B758D33030D
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 18:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761157308; cv=none; b=GyjZBb5tjwnzdyZY5n0/AxrjPxGNgmSY8SlKq4dexy92mF6Na3ifhcGhR7F4K93p/lb6r1xGyC3QrmM+spb9w1tEWdNg0gPcxl4EHRt61mRZ5OEz3njwtOlWapHM2U3d2HClxv9Ua2CyG3W2P34YliKL26xgeEHT6/wRUb3L7ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761157308; c=relaxed/simple;
	bh=lELXTrKaiyhaK8Gx0X2Cev3upaWWSLx9rZPi1vP4M+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEGJfL6f5SG2xKHjfSX7xb+8T3g2GuqZ/dq6M+cVqmAc+kv7ml6PLHKzMckOdZHthu+LiGC9dcm/khh7tqKcN9J2eD0bwi0EtkbOoHXntq8Zj7kQnTfJCJqX0nAnZDy9SpkOfkmRb1zZ51xdtIENHhfc2o3ax53VhdTDNVBVC1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=WzZGa/PW; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Bku8ZfM1vd1cxkJC/JuPNt08MeKU8abxyCWkKmsYXbM=; b=WzZGa/PWzfHHLyzzZox92f11dx
	jfzyLEMXDOhoxlluvfXPRcA3iQ0LQWc22quFb5M9ZwO9ZNQglgdRhMkb/nMPeqzDpKL1na/fPd5bT
	Z2Ur+DfOCNO2NcllHSm7JcoNHtPDQaa/5omjJOUiWV8Te+tNc97UdHHv+nHrPJ9qk2K52/Vz73CQy
	c344P5Tn+IAbIOkGjXrnr8Bycjyz3NQEntfS2ODGglEHKEtvF2bog2NrGzJLAWxL46H8sNf9wiK5E
	stmTVIU6yCX79eMwav6tOmj905wLBoEC/Ix/xyYRsq5CsKxjFHk++iLDPiJdI5j8Urg+bLDWo3lT0
	OpD80XVQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50792)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vBdSv-000000005Iv-0yvw;
	Wed, 22 Oct 2025 19:21:41 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vBdSt-000000000vC-2c8q;
	Wed, 22 Oct 2025 19:21:39 +0100
Date: Wed, 22 Oct 2025 19:21:39 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/6] net: phy: add phy_may_wakeup()
Message-ID: <aPkgs44E2ahwsaWx@shell.armlinux.org.uk>
References: <aPIwqo9mCEOb7ZQu@shell.armlinux.org.uk>
 <E1v9jCO-0000000B2O4-1L3V@rmk-PC.armlinux.org.uk>
 <432ac9c4-845d-4fe4-84fb-1b2407b88b3f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <432ac9c4-845d-4fe4-84fb-1b2407b88b3f@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Oct 22, 2025 at 11:14:08AM -0700, Florian Fainelli wrote:
> On 10/17/25 05:04, Russell King (Oracle) wrote:
> > Add phy_may_wakeup() which uses the driver model's device_may_wakeup()
> > when the PHY driver has marked the device as wakeup capable in the
> > driver model, otherwise use phy_drv_wol_enabled().
> > 
> > Replace the sites that used to call phy_drv_wol_enabled() with this
> > as checking the driver model will be more efficient than checking the
> > WoL state.
> > 
> > Export phy_may_wakeup() so that phylink can use it.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Note my reply to Maxime, I've changed the description to:

+/**
+ * phy_may_wakeup() - indicate whether PHY has wakeup enabled
+ * @phydev: The phy_device struct
+ *
+ * Returns: true/false depending on the PHY driver's device_set_wakeup_enabled()
+ * setting if using the driver model, otherwise the legacy determination.
+ */
+bool phy_may_wakeup(struct phy_device *phydev);
+

Are you still okay for me to add your r-b?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


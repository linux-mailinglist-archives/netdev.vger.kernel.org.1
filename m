Return-Path: <netdev+bounces-175258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD7BA64A09
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 11:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3F318891AE
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 10:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5607233702;
	Mon, 17 Mar 2025 10:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="x+bhBU1o"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C7313B7A3;
	Mon, 17 Mar 2025 10:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207329; cv=none; b=QkysIlZJZjHfv7Mben8gydjhfOnEEeZP89hFVDR2pC5xlMsi7hXpFeu/7LPtn6u33uTtNxeIus4q9prdLd171jd2/3L57QQVLY5czLmHYY70KQKJyxpWdK0b+QK1oqtd3JenF33phWcAFbfc1YQpr8OLWT/9OR9g31UPg8Sk/Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207329; c=relaxed/simple;
	bh=D475GWEV9xZkUiRyncrmvUAsUnBc2KaZ13XrCGru9zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhjenMTA76+UoCm2sC1trQUXalT46oQoGYJSXx5TPiIBjBK4l2wbvB8k1zWhMOe4Esf5MJHVeRXWpbeC9sCQPqJISBwqtBaSML0+Xa4AG5Ihe4IkhyqLgjQH5BNojNQ1NXNYM2BkMeXqx/HF1coz2dED5szYlMxmYvZHRklZn6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=x+bhBU1o; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tzhM71c7XeDXnGaEMVePBynM75aidEmqvkMrNMTXDQI=; b=x+bhBU1ozAin+2pMbdUoolbzcR
	1tX9ivxR2w4CSndXSYOkO5+ofjj2hAwRUz84zpzsZ5dsxVJTvAxC+GNIaiSL0zd4wwNDGU+ikEeVu
	BdbNJDByWGYrQHs3kLGFjSG28wG8ZACc33HVSuG76dToZo1BdiP6DCXR/xzngvWxd+TRtXvf8DQYU
	0QsVEhG/X1Zl7ryUyFsCX0eItCYNHFksGz58gKP/Cwzrdr0oPiYILhiCEzST1dgGSYFEvQOln5UCN
	nr6nIs1c1af+w8D1HiWbRDz6EYdj8Q+A82eE7ymRgQRM9MEeyLJxws60pBKLJ9oyE3f3qP+ToYsCh
	GiOgrpMA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54150)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tu7i0-0003Ll-1n;
	Mon, 17 Mar 2025 10:28:36 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tu7hx-0003U7-1w;
	Mon, 17 Mar 2025 10:28:33 +0000
Date: Mon, 17 Mar 2025 10:28:33 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Jim Liu <jim.t90615@gmail.com>, JJLIU0@nuvoton.com,
	florian.fainelli@broadcom.com, andrew@lunn.ch, hkallweit1@gmail.com,
	kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] net: phy: broadcom: Correct BCM5221 PHY model
 detection failure
Message-ID: <Z9f5UQPRTPT8lbXm@shell.armlinux.org.uk>
References: <20250317035005.3064083-1-JJLIU0@nuvoton.com>
 <Z9fhqbfoQGSm1Njx@mev-dev.igk.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9fhqbfoQGSm1Njx@mev-dev.igk.intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Mar 17, 2025 at 09:47:37AM +0100, Michal Swiatkowski wrote:
> It will be nice to have wider explanation what it is fixing in commit
> message. Is phydev->phy_id different than phydev->driver->phy_id? Looks
> like masking isn't crucial as phydev->driver->phy_id is initialized by
> PHY_ID_BCM5221 which is already masked.

The two are very different, and this driver just gets it totally wrong.

phydev->phy_id is the ID read from the PHY. It includes the revision
field.

phydev->drv is one of the phy_driver entries at the bottom of the file.
These contain whatever the driver author puts there, which in this
case would be PHY_ID_BCM5221, and PHY_ID_BCM5221 is defined without
the revision number.

So doing the masking is entirely redundant if you're comparing the
drv->phy_id that was initialised with a definition against the same
definition.

As pointed out in my review with v2, there's more problems in this
driver _because_ this has not been understood. In an attempt to get
rid of some of this stuff, I introduced phydev_id_compare() and
phy_id_compare() helpers into core phylib code, but didn't get
around to updating broadcom.c. See my comments against v2.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


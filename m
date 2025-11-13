Return-Path: <netdev+bounces-238461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1048C592E7
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 18:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE1CE3BE1B8
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 17:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3E9363C4A;
	Thu, 13 Nov 2025 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="N6muQlnU"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAA93624DA
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053071; cv=none; b=m961XqCGnIXJYR9uu/MHS2tdCI77K+bLr0DGUe70O4Vvl1fi5159xV0JNc+GRDlaAOA5WE+oycB0WS50SHAXFS4CgFIk9JmibVXuTzT60gUPN99CZM7BvLI5jW4AnFjW983ERAI+h9peyhmJBreU2po8uS/3UIVCpxEi28dH0+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053071; c=relaxed/simple;
	bh=GsiIuFMPyEhM9m3oM9BLSo8sJf2sEZPjOUyuPkrXzVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdH99zLgVhb/5Ifct7LpVFt1Xn/vqkqybZhYCIrEdTcc9D0dXfpCmzkbMCTmrShK4G18zYSTPX3fMpnk8cb/IoM85nAjYFESUzDqqDvHdw+GcIwkbBKU3WrOZXbN6gR5OCAoqIu9Pn7x7P9pgyGxoeDXGyWXyDdXTKhssR+oD7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=N6muQlnU; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8s0PE/C6/d9X2Y5y63gtWcf3V6dmVDKLvpF2qEq2KEQ=; b=N6muQlnUR3nxd4X7/g+FHFX0/e
	B+ZBfhjWge1FceXbJx9B7w0Jb/4GUyHuCJoMYQkSE/amQ3y7QrquM6ZME5cb1kjc8bAPT0e934qzS
	81caGGrhN5e1h7rvQkGJguoaDhDehRkzuXRRQwx1a/++N9zfQ9dzvdikRAE78G7S6vSrM77nfPSfQ
	vw7fOkHgZDPoNfeT+uohZWv0loKYU3gHOyekzuJJEf3ZLdVfFOUFEIfKzhRYMlCBpWBGNM32MORZY
	n4c0R/JcUN6vbLIzyTH9jm3SwClTXcSlYzg+cqkE2ve6kaBH8ZdmmoPxyudKNDh7HDTTuhkrteNwf
	Qojyi3oA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46336)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vJada-000000005k9-1dm2;
	Thu, 13 Nov 2025 16:57:34 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vJadX-0000000051U-0ROr;
	Thu, 13 Nov 2025 16:57:31 +0000
Date: Thu, 13 Nov 2025 16:57:30 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/9] phy: add hwtstamp_get callback to phy
 drivers
Message-ID: <aRYN-r7T9tz2eLip@shell.armlinux.org.uk>
References: <20251113113207.3928966-1-vadim.fedorenko@linux.dev>
 <20251113113207.3928966-3-vadim.fedorenko@linux.dev>
 <aRXIuckumra-3Y0L@shell.armlinux.org.uk>
 <12c8b9e9-4375-4d52-b8f4-afccba49448c@linux.dev>
 <a4b391f4-7acd-4109-a144-b128b2cc09b2@lunn.ch>
 <b428f0f0-d194-4f93-affd-dae34d0c86f1@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b428f0f0-d194-4f93-affd-dae34d0c86f1@linux.dev>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Nov 13, 2025 at 04:48:00PM +0000, Vadim Fedorenko wrote:
> If the above is correct, then yes, there is no reason to implement
> SIOCGHWTSTAMP, and even more, SIOCSHWTSTAMP can be technically removed
> as a dead code.

I think you're missing the clarification in this sentence "... to
implement SIOCGHWTSTAMP in phy_mii_ioctl(), and even more,
SIOCSHWTSTAMP can be removed from this function as dead code.""

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


Return-Path: <netdev+bounces-171367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2010A4CAB7
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 19:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7C4188953E
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 18:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F3C216395;
	Mon,  3 Mar 2025 18:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JK9Psfj2"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0D9148316
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 18:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741025188; cv=none; b=unkooX58v8pXb66/FlBDd5eIcWN0CLqgJRMjZHTNiiL6Y9LH5IkljOBMHIInnB7NflpZX3R62I//R4YvC8gzFl/R8v1vJJq7rIw/OsH0Ff3CW96HbzfzOZoWwtRqf81SKUH3cjK7rxaaXKFBS2izoaxQ0zj9djQeFWtomvpWuKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741025188; c=relaxed/simple;
	bh=U5eVyaYrbXRrJo0wEGBq00Mdav7PnBDwDXgoQyPRJgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbZzdfB/PUTaO1yqQT2wkBFdH8UMGg2iMtnzp1ra8ktPtALonL5oOP/cWN5LhwpgcLeBJUtT+4BxhfIAmkqOaKDralesxZdntMLK/ckg7CdWZr9S5dGhraLNm2jGOml4NV8pwgycQD4E/EG+O09l9kJKMN+M0T5biKuAdgqaAB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=JK9Psfj2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=25mkCHA1BXIrwlgkMaAtp4ZzJJLVw8s7X8UGxF/O8OA=; b=JK9Psfj2pmvAklZB/t3bpQwGqI
	VEhuswIPt0O21VhEQPJFMyqIYlzwmrqIidrdYuAdCNC/jvRCIwnDIlGKVKyNrK4t7JM3n9pJyL1pZ
	IF7iE2mVCm+CUDFG2lN5QboSfnd81MmeySGwldIX5xQI8YchOOS3dCo/lKks+b9I/12UFkwlkNGyV
	icEzxtlyqd/PAmgCezaDkiDvvyHcKqNZqxusEcmHmRFtstEyoGAoA+mxvS3AtD/fU+pKd9m3veKVm
	3uN6KF5f+xc05Bv9rItOlcTQdFiUyJxk8TR60i+HDdKC0h4v+/XlQ/V3IcaBpqVrA1Gu54BWg9zxg
	Y8yDm9HQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55960)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tpABJ-00017B-1D;
	Mon, 03 Mar 2025 18:06:21 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tpABG-0003ym-1u;
	Mon, 03 Mar 2025 18:06:18 +0000
Date: Mon, 3 Mar 2025 18:06:18 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Wei Fang <wei.fang@nxp.com>
Subject: Re: [RFC PATCH net] net: phy: allow MDIO bus PM ops to start/stop
 state machine for phylink-controlled PHY
Message-ID: <Z8Xvmqp2sukNPzvt@shell.armlinux.org.uk>
References: <20250225153156.3589072-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225153156.3589072-1-vladimir.oltean@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Feb 25, 2025 at 05:31:56PM +0200, Vladimir Oltean wrote:
> DSA has 2 kinds of drivers:
> 
> 1. Those who call dsa_switch_suspend() and dsa_switch_resume() from
>    their device PM ops: qca8k-8xxx, bcm_sf2, microchip ksz
> 2. Those who don't: all others. The above methods should be optional.
> 
> For type 1, dsa_switch_suspend() calls dsa_user_suspend() -> phylink_stop(),
> and dsa_switch_resume() calls dsa_user_resume() -> phylink_start().
> These seem good candidates for setting mac_managed_pm = true because
> that is essentially its definition, but that does not seem to be the
> biggest problem for now, and is not what this change focuses on.
> 
> Talking strictly about the 2nd category of drivers here, I have noticed
> that these also trigger the
> 
> 	WARN_ON(phydev->state != PHY_HALTED && phydev->state != PHY_READY &&
> 		phydev->state != PHY_UP);
> 
> from mdio_bus_phy_resume(), because the PHY state machine is running.
> It's running as a result of a previous dsa_user_open() -> ... ->
> phylink_start() -> phy_start(), and AFAICS, mdio_bus_phy_suspend() was
> supposed to have called phy_stop_machine(), but it didn't. So this is
> why the PHY is in state PHY_NOLINK by the time mdio_bus_phy_resume()
> runs.
> 
> mdio_bus_phy_suspend() did not call phy_stop_machine() because for
> phylink, the phydev->adjust_link function pointer is NULL. This seems a
> technicality introduced by commit fddd91016d16 ("phylib: fix PAL state
> machine restart on resume"). That commit was written before phylink
> existed, and was intended to avoid crashing with consumer drivers which
> don't use the PHY state machine - phylink does.
> 
> Make the conditions dependent on the PHY device having a
> phydev->phy_link_change() implementation equal to the default
> phy_link_change() provided by phylib. Otherwise, just check that the
> custom phydev->phy_link_change() has been provided and is non-NULL.
> Phylink provides phylink_phy_change().
> 
> Thus, we will stop the state machine even for phylink-controlled PHYs
> when using the MDIO bus PM ops.
> 
> Reported-by: Wei Fang <wei.fang@nxp.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> I've only spent a few hours debugging this, and I'm unsure which patch
> to even blame. I haven't noticed other issues apart from the WARN_ON()
> originally added by commit 744d23c71af3 ("net: phy: Warn about incorrect
> mdio_bus_phy_resume() state").

I think the commit looks correct to restore the intended behaviour,
but I'm puzzled why we haven't seen this before.

As for the right commit, you're correct that 744d23c71af3 brings the
warning. Phylink was never tested with suspend/resume initially, and
that's been something of an after-thought (I don't have platforms that
support suspend/resume and phylink, so this is something for other
people to test.)

However, your patch also brings up another concern:

commit 4715f65ffa0520af0680dbfbedbe349f175adaf4
Author: Richard Cochran <richardcochran@gmail.com>
Date:   Wed Dec 25 18:16:15 2019 -0800

adding that call to MII timestamping stuff looks wrong to me - it means
MII timestamping doesn't get to know about link state if phylink is
being used. I'm not sure whether it needs to or not. Maybe Richard can
comment.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


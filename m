Return-Path: <netdev+bounces-182792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E40A89EAC
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 14:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B093B167B3F
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755622957DB;
	Tue, 15 Apr 2025 12:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="AgYA7pvR"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8992949FF;
	Tue, 15 Apr 2025 12:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744721752; cv=none; b=TpOvJpen5dz2xtM089rXkd5bjxSvcXH92BjFrQmwsLeq4WVP4O4jh2+PNFWxmTyYDuNkA4aVWu2O/406zX4yDs9d/lI/UYeeY5RaJyVtgopcS2biyV4J4C4/g6Zhvp7FbCev2dqUSCpaCSHTOO6ZczIOpMyQ6kxImQYrBWsMjSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744721752; c=relaxed/simple;
	bh=Qc1beZhg8W61Jad1DzACEJaCmaxNI95ow2kqDu0VoJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hl3rJH3yQgm8YskdAMJDl2bHnrQxDRGAQYM1+Bj/2Z8GQqewcUFsx/hz9SGf3avBcRgHVRfymrHOxvspNO0mJeXBvSa7qjdVhWWJaN7QIffwNq9EdzOum3eTV4eRkndBYL2nAzXdUScKyXBJQO33UgivEA2fxVBkEJfzbExmptw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=AgYA7pvR; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cZ9ww5Wf2A7DsMhOJkQSMUnamiSCUOwvhWBPhIE/bfI=; b=AgYA7pvRGwAGDSnjYnFU5RwaW+
	BeUAodoKhzF3gChuYa0Yn31AyyZrsEOdLPPLjWbGJYSEZuUyKHuP9PIHHXY9zVE3NjKblEiMp+nHz
	IuEgOzyCwUi8glzS/A5BGgABPbxr6voC4XaA+dE80e8eSTVczhf1EWGtwIVvQ+nBgTvS2E1lGy5El
	BVrxv/an7HemkiAMeqtbIZQCXgwlo+Oj0f3G4L5V2AYaAVhedq+eE44blnoe4mGl1aWEl2LtdkuHd
	JHAKSr9eSuJ62JhQDLBXuuSt2/ktoMi/RL9I7eFmcCnzoHBU8MyaLGs51ksYhpKm+aGtUDTBJmSAp
	glM6miIQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34594)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u4fp9-0008Al-1x;
	Tue, 15 Apr 2025 13:55:35 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u4fp3-0000Nz-2p;
	Tue, 15 Apr 2025 13:55:29 +0100
Date: Tue, 15 Apr 2025 13:55:29 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Eric Woudstra <ericwouds@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.or
Subject: Re: [net-next PATCH v7 5/6] net: phy: Add support for Aeonsemi
 AS21xxx PHYs
Message-ID: <Z_5XQZvgdW6Wfo06@shell.armlinux.org.uk>
References: <20250410095443.30848-1-ansuelsmth@gmail.com>
 <20250410095443.30848-6-ansuelsmth@gmail.com>
 <Z_4o7SBGxHBdjWFZ@shell.armlinux.org.uk>
 <67fe41e5.5d0a0220.1003f3.9737@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67fe41e5.5d0a0220.1003f3.9737@mx.google.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 15, 2025 at 01:24:16PM +0200, Christian Marangi wrote:
> On Tue, Apr 15, 2025 at 10:37:49AM +0100, Russell King (Oracle) wrote:
> > > +static int aeon_ipcs_wait_cmd(struct phy_device *phydev, bool parity_status)
> > > +{
> > > +	u16 val;
> > > +
> > > +	/* Exit condition logic:
> > > +	 * - Wait for parity bit equal
> > > +	 * - Wait for status success, error OR ready
> > > +	 */
> > > +	return phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1, VEND1_IPC_STS, val,
> > > +					 FIELD_GET(AEON_IPC_STS_PARITY, val) == parity_status &&
> > > +					 (val & AEON_IPC_STS_STATUS) != AEON_IPC_STS_STATUS_RCVD &&
> > > +					 (val & AEON_IPC_STS_STATUS) != AEON_IPC_STS_STATUS_PROCESS &&
> > > +					 (val & AEON_IPC_STS_STATUS) != AEON_IPC_STS_STATUS_BUSY,
> > > +					 AEON_IPC_DELAY, AEON_IPC_TIMEOUT, false);
> > 
> > Hmm. I'm wondering whether:
> > 
> > static bool aeon_ipc_ready(u16 val, bool parity_status)
> > {
> > 	u16 status;
> > 
> > 	if (FIELD_GET(AEON_IPC_STS_PARITY, val) != parity_status)
> > 		return false;
> > 
> > 	status = val & AEON_IPC_STS_STATUS;
> > 
> > 	return status != AEON_IPC_STS_STATUS_RCVD &&
> > 	       status != AEON_IPC_STS_STATUS_PROCESS &&
> > 	       status != AEON_IPC_STS_STATUS_BUSY;
> > }
> > 
> > would be better, and then maybe you can fit the code into less than 80
> > columns. I'm not a fan of FIELD_PREP_CONST() when it causes differing
> > usage patterns like the above (FIELD_GET(AEON_IPC_STS_STATUS, val)
> > would match the coding style, and probably makes no difference to the
> > code emitted.)
> > 
> 
> You are suggesting to use a generic readx function or use a while +
> sleep to use the suggested _ready function?

To write the other part of it (I thought this would be obvious!):

+	return phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1, VEND1_IPC_STS, val,
+					 aeon_ipc_ready(val, parity_status),
+					 AEON_IPC_DELAY, AEON_IPC_TIMEOUT, false);

> Mhhh I think I will have to create __ function for locked and non-locked
> variant. I think I woulkd just handle the lock in the function using
> send and rcv and maybe add some smatch tag to make sure the lock is
> taken when entering those functions.

If you don't need the receive part, then pass NULL in for the receive
data pointer, and use that to conditionalise that part?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


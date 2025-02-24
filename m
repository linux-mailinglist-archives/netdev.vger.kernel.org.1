Return-Path: <netdev+bounces-169041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C31CEA423B2
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 15:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A764417B1
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 14:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4BA191493;
	Mon, 24 Feb 2025 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WzZfFuix"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110FD245006;
	Mon, 24 Feb 2025 14:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407949; cv=none; b=pODkmrW/hAQLsXZ1SNU/oomeg0VWQ3iKlxB3ywjRFffS0hr7G7ZwtIC6i/Mfe4VaynNKtSbdsCUBy59vE5db+hVgpnf/6o5baMu9BszaX/6v0q8ABgIwy2AvthIkMt4UTofpcsafpJiQgaV0QHZH6i48he/1gx3qPUfbEw/GqTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407949; c=relaxed/simple;
	bh=fMonh/pKAVHu07dY8Vw+0UdrpHd7C1ki/HDFFIv2F+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZYFQyKWhW/4HvFgHB5iNYsbylRH2uWP0QLlHKWY6ePs/baFcLCeKwCds6dNF+4QgGnmgSy09kEeYemTbeSg80aPfA6EEwsO9kUSz1jE6vOoqdpxczR9I81XUduqhkkF+jvgyZVEopMLEvv62Db4Ze4J4F671b/hrEsd+ZmQuFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=WzZfFuix; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oZBH+BBvL/hgtaMob59TY/eIeJhL38EKvFH99ZsXxXM=; b=WzZfFuixs4bggs/CuH1/ino7Aq
	kP5Ug2KPxPDM+7ABlB53uXRnElwtHPfiscmCflcSs8jBFu2/xx0YBSYR4QxgzgXqDkGkDTfpmJzdx
	EWdrBl9RkuIAFyPw3p/MKcWazcymxG1zaa88y+kNqeBpeSjn4s/JTC/rx89AKUptrb7qmtrdmxh+2
	6Fk68d72cl+rQxN9Qz+yowEPnXW2l/Di61nbL3AWdUZSFTHvSyDPJTcWP2E8WoI5uuhBzl4KYF9Wi
	Vy27njJqV9t6KPeDjMbFosJdHdF7W3x02uXi+RnelsTQ33Gx//mBkKx/+XnhrGGIvOAJaGxAq17sh
	v3Gcpy3w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52904)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tmZbm-0006da-26;
	Mon, 24 Feb 2025 14:38:58 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tmZbk-00054V-1k;
	Mon, 24 Feb 2025 14:38:56 +0000
Date: Mon, 24 Feb 2025 14:38:56 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH net-next 0/2] net: phy: sfp: Add single-byte SMBus SFP
 access
Message-ID: <Z7yEgFR9scO2aRYh@shell.armlinux.org.uk>
References: <20250223172848.1098621-1-maxime.chevallier@bootlin.com>
 <87r03otsmm.fsf@miraculix.mork.no>
 <Z7uFhc1EiPpWHGfa@shell.armlinux.org.uk>
 <3c6b7b3f-04a2-48ce-b3a9-2ea71041c6d2@lunn.ch>
 <87ikozu86l.fsf@miraculix.mork.no>
 <7c456101-6643-44d1-812a-2eae3bce9068@lunn.ch>
 <Z7x4oxR5_KtyvSYg@shell.armlinux.org.uk>
 <kqur446k5sryspwh4zzndytfqhpupfybimhgbtq5m7fm7vom7s@hhqlh3llrsxl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <kqur446k5sryspwh4zzndytfqhpupfybimhgbtq5m7fm7vom7s@hhqlh3llrsxl>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Feb 24, 2025 at 03:32:43PM +0100, Marek Behún wrote:
> On Mon, Feb 24, 2025 at 01:48:19PM +0000, Russell King (Oracle) wrote:
> 
> ...
> 
> > "Please note:
> > This hardware is broken by design. There is nothing that the kernel or
> 
> Doesn't "broken by design" mean "broken intentionally" ?

The point of this part of the discussion is to find a form of words
that folk are happy with, so please feel free to suggest an
alternative.

To put it bluntly, it does come down to "broken by the hardware
engineer not having full knowledge of the requirements of SFP modules
as documented in the SNIA documentation and selecting hardware that
violates some of the requirements."

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


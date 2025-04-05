Return-Path: <netdev+bounces-179423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94387A7C89A
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 11:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64B8717657F
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 09:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7542D1D07BA;
	Sat,  5 Apr 2025 09:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WFMenlku"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009D9182BD
	for <netdev@vger.kernel.org>; Sat,  5 Apr 2025 09:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743846206; cv=none; b=pzXVPwY/s+SsCXKrhpHalRnz9Cv2/+NVo4yc+RjN2ylkhorKorKwTlj6pu+9zruety14k8J9F9PVF6dL9wDuh+W0XMLsBrJDTswL9JQ+9sNt2v9auMgcsChI1pchdHWR5Q5zDxTv8rwtYdPkzljuJPaXgky95J9RhH9Ylj24sEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743846206; c=relaxed/simple;
	bh=jO0udsPDEQ7Nfe7ki3uRGy7FgiP7fizueRFlW56a5AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOOtqdSxKFyk5OoKDQPLAumsm9itY+HWcPFnLfwvYhz0GqRhRxgo+fy4jCf80xkNn9lBB32EyCaEq3dcllIgBPz/iiArchmFVET+uBZ0tkgQNHl5jO0Pt2PSvrqAtT5qkSi4dP/5mkv2RIhM8jjAzHX0JYsN3lL7vKqlCGOx4AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=WFMenlku; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fCyHzMT9B7EjrULS5lWPObXtm1VDGBfkJ18QCfNzvPI=; b=WFMenlkuAXCkmkYAQlyoo+HVhN
	mf2GDYTMS5SsDU6miWz2uI/XzoD6sQQsrjtpir/iLigSfNgMiaoL1AjLOm8ABywglfkMh6DuAL3s8
	nPSfhReTDB2wVNnkmMV0inpwTFy7o9dRNUGVAMukKyzKoU5RPbC74UwxQwULSTzW4sc+IUvDAx119
	nz/X7Ui+R8JVPA+t6eskuo9SpxRO37KsMixtVjFrc1VD/Lr7mkSc0OrYZAvHiYoLA9plQebyFn91i
	uY1tfK5XvPQPmLKNCZcus1Z6mCWQMMrUOXHCnMpqEAwMVnb3+4r/Rh3nm5e7QosTNt8MphicqbbcL
	Lwhplf1Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57482)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u103a-0003Om-2R;
	Sat, 05 Apr 2025 10:43:18 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u103X-0006h4-31;
	Sat, 05 Apr 2025 10:43:15 +0100
Date: Sat, 5 Apr 2025 10:43:15 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, hkallweit1@gmail.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [net PATCH 1/2] net: phy: Cleanup handling of recent changes to
 phy_lookup_setting
Message-ID: <Z_D7M4QGrRB8lezC@shell.armlinux.org.uk>
References: <174354264451.26800.7305550288043017625.stgit@ahduyck-xeon-server.home.arpa>
 <174354300640.26800.16674542763242575337.stgit@ahduyck-xeon-server.home.arpa>
 <Z-6hcQGI8tgshtMP@shell.armlinux.org.uk>
 <20250403172953.5da50762@fedora.home>
 <de19e9f1-4ae3-4193-981c-e366c243352d@lunn.ch>
 <CAKgT0UdhTT=g+ODpzR5uoTEOkC8u+cfCp7H-8718Zphd=24buw@mail.gmail.com>
 <Z-8XZiNHDoEawqww@shell.armlinux.org.uk>
 <CAKgT0UepS3X-+yiXcMhAC-F87Zcd74W2-2RDzLEBZpL3ceGNUw@mail.gmail.com>
 <3087356b-305f-402a-9666-4776bb6206a1@lunn.ch>
 <CAKgT0UfG6Du3RepV4v0hyta4f5jcUt3P1Bh7E2Jo2Cn4kWJtGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgT0UfG6Du3RepV4v0hyta4f5jcUt3P1Bh7E2Jo2Cn4kWJtGw@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Apr 04, 2025 at 03:46:38PM -0700, Alexander Duyck wrote:
> On Fri, Apr 4, 2025 at 9:33 AM Andrew Lunn <andrew@lunn.ch> wrote:
> > So for us, we have:
> >
> > MAC - PHY
> > MAC - PCS - PHY
> > MAC - PCS - SFP cage
> > MAC - PCS - PHY - SFP cage
> 
> Is this last one correct? I would have thought it would be MAC - PCS -
> SFP cage - PHY. At least that is how I remember it being with some of
> the igb setups I worked on back in the day.

Yes.

Macchiatobin:

-Part of SoC -|                         /----- RJ45
MAC - PCS --------- 88X3310 Ethernet PHY
--------------|                         \----- SFP cage

Things get more interesting when one plugs in a SFP which itself
contains a PHY, where we effectively end up with:

MAC - PCS - PHY - PHY on SFP module - media

which we don't support very well, partly because it doesn't fit into
the higher levels of the networking model (that's being worked on), and
the 88X3310 doesn't support SGMII on its "fibre" port.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


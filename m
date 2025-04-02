Return-Path: <netdev+bounces-178867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE046A793D7
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 19:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F3B18945F7
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 17:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C721917C2;
	Wed,  2 Apr 2025 17:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="z8GqY5ZR"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314C01373
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 17:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743615066; cv=none; b=OCMwhibIlSLKJ74Znsy3vgsH/bv7yZtZrR6c0Pb4qW5GS3yDaxgAti18GNZDgp+49Q2InRb+Th1SnkLgBnJ4cN2qKeW6/K+HyIWUTHeexNOuHOnSDtsfIlwiVozGxlrSCNvOQJSjNRYVcjgAsg21wuy6YszFOdcBmf2wl/1XHL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743615066; c=relaxed/simple;
	bh=Rw73D4wmRhYR/8cPfLJuF3y9r+weWvIxpWYWc3s4Prg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqonMr7doszJSWMyI6id7TDDWUOJh3OT1CBATpIWCiKo8qtsGCS5qlzs757iiLQCbr7vnHRMPFQ8ttAJG9FTni1VV2XzHi8YfPHrMWWUTev8QNmWTZPLbQk/QqNLAzkMAgJ2j2Gt73SkjoszXePSCvAq4KflYINLqV/i/ALjqB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=z8GqY5ZR; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xMnnGkvXuR8AjeO8Jb3XrWEt1kBCTt4Bl1A61qhZ8kg=; b=z8GqY5ZRQ9QgIp/8iFXSIR3N1c
	4MSPrvlK05hI7wE00vL9txkJbnB4klJJOWSqUR44WfOXriSW/KPqXWnm/gA3u0fDHKYzQgdenMVJK
	Cp+XkhnjACOFCkVVTR/IcP0boShcb7SJwNpah+W8FXSC8slgBYbaQZKHekO7KUX+alePkIXQSnhuG
	bvBLjjTO+uAH2w6J+NGpomj9k/F/MWDSPGmeygE6cMbGtA49NbPTqwsJgSY2J5bYrocujUJZER+sP
	4soZTbAPaTSdLMdJzMlHZJe23e5UkNmbLh+s+MiuMCKAmnnoCiYUzL+a3wsdEYwpC6Vz7+EL88FlG
	ldp9kNSg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37738)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u01vU-0007wz-0Q;
	Wed, 02 Apr 2025 18:30:56 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u01vS-0003t4-0q;
	Wed, 02 Apr 2025 18:30:54 +0100
Date: Wed, 2 Apr 2025 18:30:54 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexander H Duyck <alexander.duyck@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net PATCH 1/2] net: phy: Cleanup handling of recent changes to
 phy_lookup_setting
Message-ID: <Z-10ToqF15roQ2u4@shell.armlinux.org.uk>
References: <174354264451.26800.7305550288043017625.stgit@ahduyck-xeon-server.home.arpa>
 <174354300640.26800.16674542763242575337.stgit@ahduyck-xeon-server.home.arpa>
 <20250402090040.3a8b0ad4@fedora.home>
 <de9d0233962ebd37c413997b47f3c715731cfffd.camel@gmail.com>
 <20250402101720.23017b02@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402101720.23017b02@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Apr 02, 2025 at 10:17:20AM -0700, Jakub Kicinski wrote:
> On Wed, 02 Apr 2025 07:21:05 -0700 Alexander H Duyck wrote:
> > If needed I can resubmit.
> 
> Let's get a repost, the pw-bots are sensitive to subject changes
> so I shouldn't edit..

Note that I've yet to review this.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


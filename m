Return-Path: <netdev+bounces-166462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45710A360CF
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09FBD170715
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 14:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAD6265CA9;
	Fri, 14 Feb 2025 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="LTdduK5v"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8352641F7
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739544859; cv=none; b=Th2vtYWEmgRsh+C7n+Xyb6WsNErCS/3Dqt2Koetptv0ZpcbS5ApXKbDTq3gbvrSgNRFIsoNkJcwqPjFKn/Drf/nWiCgVfLDfVVvZDOOaO0ffBOqKV6jEBSwuIXbGcOiIMGWEEvjxGPWivZzzamn7YLCVs4dptS2k722yO5iOMl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739544859; c=relaxed/simple;
	bh=eK4Ufny9o5ZnhwGSdbWej7QKOWpWgDuzFDc0c4Qd2f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ish7FzQUfcKtg9JdzND3o+UMRYqvGY/a3fLVrgohybjUGKARIOOzo/QZQ5l5aY4kpZR2zVQncUqvpzPnSWrDG2hJ76BtpnFTyU4+VBJl9JXjZl55Z9VUmwV7qa+iNk5OMjOocf66MBCoFrt8RcnHkiVPoKW1EiEG5Sls2QzYdkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=LTdduK5v; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JE1kHbtfqQF9VMh3qY/5PDRL3y+rkuMo/3ZK86g64ps=; b=LTdduK5vAiyiI0G2HBsi5eiHeh
	r0WeXf8ptVoxKj8bpno3MkCbmqmSpkRQqS1Sz0x/XbR0Tzf+ItVrL+VBSj0EvrWEm2zNWCl8cxny6
	ON8MdO70zGmi/LFGkhwqY7Ich9P6X4n9QiX46k2j4eig7nlhH1sxIZa25rpBB4a8hI4V2nuuyxWeJ
	uwkore1qjPczi0UQNjTBW6cL+5K7u1uXKgSvbsZapY1OkIzUuDdI8VSAOADjms4ATKDFtey3bF1SM
	KIa6KbEddz93wQGgv/uVYe3mjorhuXr1a+Iv6kIckGjbxsyhUxljuDaC3xx0LvCsclqpSijx6lkWx
	571V2OGw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50452)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tix51-0005U6-39;
	Fri, 14 Feb 2025 14:54:12 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tix50-0003Fx-2c;
	Fri, 14 Feb 2025 14:54:10 +0000
Date: Fri, 14 Feb 2025 14:54:10 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 4/4] net: phy: remove helper phy_is_internal
Message-ID: <Z69ZEiaRodNnb92p@shell.armlinux.org.uk>
References: <d14f8a69-dc21-4ff7-8401-574ffe2f4bc5@gmail.com>
 <f3f35265-80a9-4ed7-ad78-ae22c21e288b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3f35265-80a9-4ed7-ad78-ae22c21e288b@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Feb 13, 2025 at 10:51:53PM +0100, Heiner Kallweit wrote:
> Helper phy_is_internal() is just used in two places phylib-internally.
> So let's remove it from the API.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

My grep confirms.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


Return-Path: <netdev+bounces-161081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46855A1D3DC
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 10:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C2BE3A581D
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 09:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BFE1FBEBC;
	Mon, 27 Jan 2025 09:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="q2T1rl1S"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9777625A63B;
	Mon, 27 Jan 2025 09:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737971520; cv=none; b=nGoXxf8iwBToOo73bBuIkSuPFMG/L+7xuGlBuzX0w9IGxZHwXCaZNJBYOuZOAQHQkHKnBMt8i7F3XqVyr70ylGYJQWQfsQK+PwPWTqDcvabhhbWQ00lvDtHeuyK8lmzM2Ni/0stZK3GMZtiXgGnY+E1r2Cytf57MaTkaFEwzaHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737971520; c=relaxed/simple;
	bh=XFuY5id5+aUlSSI1C8giUKyyGGp3mPyCmEYrZyMMf0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFapFOcurVZfYAZ0ojTc2ZpMuKysT8wdOuB9wyIMM7QGS+4lhts2ZXJUFgB0nVETYD2jyxplqWbSMCrEfKUasJkSLij0nTnjRnUC6qyOEVhYs1gqPE1IfSDzU7MDT5AAF2jgLVzPGDOzwrbXagaRuzxReIyamjBB1MJGW6E5fv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=q2T1rl1S; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=emuqLGn2iU6jwoZrczhMrnjopGMTGD+Ycm8ZZp4rDeY=; b=q2T1rl1S3/FvC5Db9YCSHkSLpx
	YTFiF1H4Zcgy+sh4Anuv2JOnLSdQ9CxQJR3ifcquciw4yWbFSAZkFN2poy/YcsAYfGpuotRVtkZDS
	3BllJgp5+wjHek+zrAdrdeGlxeLyd59wYqHUG7mpp3WsLjz1DgT+kUZIGDlroP6UvEm+uIizo7BcS
	ZBy5E8C3BINk5hxoVh+yV6+Q86IIYayIq1Y9raVUFCZslGYsYsTawywJBB9LnGNUSeKVcEASCFYGZ
	KlhhK/doddlBjkRhuXQRbvqm8/krMcv0WooXi+anPXtbrYu4wihfzUSpLy1ppwppTpqXjyCco/lPs
	8piUrr4g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56962)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tcLmO-0005RD-2N;
	Mon, 27 Jan 2025 09:51:40 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tcLmJ-0001V0-23;
	Mon, 27 Jan 2025 09:51:35 +0000
Date: Mon, 27 Jan 2025 09:51:35 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/3] net: stmmac: Fix usage of maximum queue number
 macros
Message-ID: <Z5dXJ1EIUx8DAh6J@shell.armlinux.org.uk>
References: <20250127092450.2945611-1-hayashi.kunihiko@socionext.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127092450.2945611-1-hayashi.kunihiko@socionext.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 27, 2025 at 06:24:47PM +0900, Kunihiko Hayashi wrote:
> The maximum number of Rx and Tx queues is defined by MTL_MAX_RX_QUEUES and
> MTL_MAX_TX_QUEUES respectively.
> 
> There are some places where Rx and Tx are used in reverse. Currently these
> two values as the same and there is no impact, but need to fix the usage
> to keep consistency.

I disagree that this should be targetting the net tree - I think it
should be the net-next tree. Nothing is currently broken, this isn't
fixing a regression, there is no urgent need to get it into mainline.
It is merely a cleanup because both macros have the same value:

include/linux/stmmac.h:#define MTL_MAX_RX_QUEUES        8
include/linux/stmmac.h:#define MTL_MAX_TX_QUEUES        8

Please re-send for net-next after the merge window and net-next has
re-opened.

In any case, for the whole series:

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


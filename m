Return-Path: <netdev+bounces-214730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2AAB2B18E
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 21:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 361A25E84A8
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 19:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B8E25485F;
	Mon, 18 Aug 2025 19:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="goN7U/QS"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1135FE555;
	Mon, 18 Aug 2025 19:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755545178; cv=none; b=AGS37eX4DFP/nl4trb6z+ZqCT0jjXfBr5FKBFPdarKWJJcRZamsh+JEd/6FXLqw/GqEab07sH9sRZOVYyhVAsBtJwIBwQxDHao+DRF+hHRsB1KDDk40lPxTTV7HwcfJb81qZQzArc1wkOPrGvUIsnQd+VZ1dUJ3q1N/im5qepc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755545178; c=relaxed/simple;
	bh=69W23qFghf8b0DLplTxLuxTLlICbMFs0XcgmXglH2hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3pAkkLvum+SA7HoMZH2L92nyN8RU5xD5fbVAHUSZGM2DcHt0dHod3i2uMy43wz80HLxSQ3Orui4nVy2J91xZxxEYkryHVlT4llhL8JOTvPNDfT26bWCgIUdo8nnrlkU1WUWv5SXaXnbbhfTuxXQcHGMjkgZd0eCD7coxjUdUI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=goN7U/QS; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Kd+IXbkrMS5qiS+Sd0sXzW37rFNI73FRN7pVjSKY668=; b=goN7U/QS6bPVXFS85mifHaha++
	mt627KyDXT7bQ2rbldEKEwyKL+Ibd3XZWKVfwmUKRPWs3t+Vc1yCjqDWYl17Ix4BhYydjKdaEZURC
	XHvfokBXFoV5bhY0UTdkJlpesXobGS0EwLeQ/oyzLRnnH7xpjYU/6iMO6iUKYenZO9bRO6C/IWgA1
	XYISo4fsVze3vSN3CN5MvoopPNbxehtEildTjTg1dncrsgZTrIfNJI7qUfpN5o+MhsQCFJ0Ho0T9t
	CzW+rD19rT5+KsztxLUvx/66g58mMe3/Q5KbH6nxNwBpzLPjihysdilfP3aOMmW+4kbsMhxj0YpYA
	dY/3SAaA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38234)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uo5Uf-00028K-1Q;
	Mon, 18 Aug 2025 20:26:10 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uo5Ub-0002hA-1M;
	Mon, 18 Aug 2025 20:26:05 +0100
Date: Mon, 18 Aug 2025 20:26:05 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC] net: stmmac: Make DWMAC_ROCKCHIP and DWMAC_STM32
 depend on PM_SLEEP
Message-ID: <aKN-Tdfvc3_hD2p7@shell.armlinux.org.uk>
References: <7ee6a142-1ed9-4874-83b7-128031e41874@paulmck-laptop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ee6a142-1ed9-4874-83b7-128031e41874@paulmck-laptop>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Aug 18, 2025 at 12:11:09PM -0700, Paul E. McKenney wrote:
> Hello!
> 
> This might be more of a bug report than a patch, but here goes...
> 
> Running rcuscale or refscale performance tests on datacenter ARM systems
> gives the following build errors with CONFIG_HIBERNATION=n:
> 
> ERROR: modpost: "stmmac_simple_pm_ops" [drivers/net/ethernet/stmicro/stmmac/dwmac-rk.ko] undefined!
> ERROR: modpost: "stmmac_simple_pm_ops" [drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.ko] undefined!

The kernel build bot caught this, and I asked questions of Rafael last
week and have been waiting for a response that still hasn't come.

However, there was some discussion over the weekend (argh) on IRC from
rdd and arnd, but I didn't have time over a weekend (shocking, I know,
we're supposed to work 24x7 on the kernel, rather than preparing to
travel to a different location for medical stuff) to really participate
in that discussion.

Nevertheless, I do have a patch with my preferred solution - but whether
that solution is what other people prefer seems to be a subject of
disagreement according to that which happened on IRC. This affects every
driver that I converted to use stmmac_simple_pm_ops, which is more than
you're patching.

I've been missing around with medical stuff today, which means I also
haven't had time today to do anything further.

It's a known problem, but (1) there's been no participation from the
kernel community to help address it and (2) over the last few days I've
been busy myself doing stuff related to medical stuff.

Yea, it's shocking, but it's also real life outside of the realms of
kernel hacking.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


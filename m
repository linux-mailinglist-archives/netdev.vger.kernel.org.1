Return-Path: <netdev+bounces-180440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D14A81532
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 486027B65F8
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1402323E334;
	Tue,  8 Apr 2025 18:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="f7wmzVm0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057C1217704
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 18:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744138645; cv=none; b=bmmbSRxHSsu0zuIH022gL7rtmA90Lo22SzrabKPPPKTmLGjU7dE/qBBj9B+GNz8t4BSNdTk7bE/QVQBL5I798LLHe3cl5CKRgUGYBP8dZUdALRvPgcgMM0bgvCTGOmNw7DqjEICoAdvwBXN/F8u+b2pJjDiZAZlU0mo2YBBOF1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744138645; c=relaxed/simple;
	bh=9uH0lZXvs0k0rGA3jaYTAn9OB4T5DDC3+SjSGKeXpOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5hKDQWQieBwPtR9gtPsj0BoXUs7jsz5sIl/4uOLvJsHICxQzXQlyaBiWuQn4Akij2SbVJU29PXpqsM0RbMrYVE3cBuoktv8wzOOzOrkJZzAmxydl42bzqSMJa76/rXeAsE3J9d0y2ScwUkjq1sl7njaMkqMR7/OhVOX5Hxowpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=f7wmzVm0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Kxhy/MU+jM2mvtkwqYk+GNtd8TQv1qCRiZaPwKzXy6w=; b=f7wmzVm0yENgf1jtAMnXqOppa6
	4dZG4oHrxR6uv7oY3lW8PbQKQAvxaioN1VCv+qC6zGfiazdj0xWav37licIejUgUbni5gFnB8o+HP
	ssAe+bQFfAwO7ta0oOB4iF+0mfbHq7hwDOqvIKUI8F5Sh5+E/sTPmNxd61oAMqvBTGNk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u2E8I-008RG0-Cp; Tue, 08 Apr 2025 20:57:14 +0200
Date: Tue, 8 Apr 2025 20:57:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Richard Cochran <richardcochran@gmail.com>,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH net-next 2/5] net: stmmac: intel: remove eee_usecs_rate
 and hardware write
Message-ID: <f8fe981e-3351-469b-9d76-803eb4563932@lunn.ch>
References: <Z_QgOTC1hOSkIdur@shell.armlinux.org.uk>
 <E1u1rgO-0013gj-5r@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1u1rgO-0013gj-5r@rmk-PC.armlinux.org.uk>

On Mon, Apr 07, 2025 at 07:58:56PM +0100, Russell King (Oracle) wrote:
> Remove the write to GMAC_1US_TIC_COUNTER for two reasons:
> 
> 1. during initialisation or reinitialisation of the DWMAC core, the
>    core is reset, which sets this register back to its default value.
>    Writing it prior to stmmac_dvr_probe() has no effect.
> 
> 2. Since commit 8efbdbfa9938 ("net: stmmac: Initialize
>    MAC_ONEUS_TIC_COUNTER register"), GMAC4/5 core code will set
>    this register based on the rate of plat->stmmac_clk. This clock
>    is created by the same code which initialises plat->eee_usecs_rate,
>    which is also created to run at this same rate. Since Marek's
>    commit, this will set this register appropriately using the
>    rate of this clock.
> 
> Therefore, dwmac-intel.c writing GMAC_1US_TIC_COUNTER serves no
> useful purpose and can be removed.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


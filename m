Return-Path: <netdev+bounces-170284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD65EA480BB
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 15:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB1DB18907F6
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 14:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E282356DB;
	Thu, 27 Feb 2025 14:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="w4SRFl51"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DB722D4EB
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 14:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665061; cv=none; b=NxOGaLL7bgzGMDn6VbJl3BgeezOMe/3CYeEdq5ARbDBQGv7356YbnZn/awGJufhwITj+PMLk5wtxHitwqLoNmHmKQ80BpUdtVSvNPWpfOlyfK7EAI7NnO/NJ/sF3oYIVGM4apg+nl0tNpuYHqkE2K/Ejn5k+UzM0IKr3W9n0YqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665061; c=relaxed/simple;
	bh=B72fjSSgs0/WFVdWynSOfWB4kCVDuLfyes9/VtT816U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKVfXY3sG2KtixXHGxetS+QMTBmps3XKyLCju1BbTY11BiR4qhFzUpw/aHkOm5OS6ofRRGDtfdNphFHmVCmOk7DUA828NEvpckFSgkh40fqULGSFLNmXFFHa6se5g3tctvjrnYUhFuhy97nZ3ebeb1Nj1Bkb+4AjpNcQlXYMEaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=w4SRFl51; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hhbjhVI6L7X1Yp3pBuL+czttai3RVbeLQIKlHMJuY0Q=; b=w4SRFl513DU+MAiNNSNxibPh0Q
	Y7vuhemGk9JrO2K1FOMUg/CRHt0AVe16tMsaRG+aFB8wy9i94mT0P4SSeM0c5M8LHcx91B52yHzu3
	YCSEOrS3fLYWhF67UYmjiLa2syHG5FoE7EiA/JcTTn5SfdunnM+vwX0WALdNIiPgYSzg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tneUh-000c4W-G8; Thu, 27 Feb 2025 15:04:07 +0100
Date: Thu, 27 Feb 2025 15:04:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Drew Fustini <drew@pdp7.com>, Eric Dumazet <edumazet@google.com>,
	Fu Wei <wefu@redhat.com>, Guo Ren <guoren@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 11/11] net: stmmac: thead: switch to use
 set_clk_tx_rate() hook
Message-ID: <50bb7ed7-189f-4ad4-a486-5ec39b5e0a75@lunn.ch>
References: <Z8AtX-wyPal1auVO@shell.armlinux.org.uk>
 <E1tna14-0052tT-S4@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tna14-0052tT-S4@rmk-PC.armlinux.org.uk>

On Thu, Feb 27, 2025 at 09:17:14AM +0000, Russell King (Oracle) wrote:
> Switch from using the fix_mac_speed() hook to set_clk_tx_rate() to
> manage the transmit clock.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


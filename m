Return-Path: <netdev+bounces-197058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4116EAD76D8
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E2181883582
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA3E21FF44;
	Thu, 12 Jun 2025 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fQioXdDv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2A4156C69
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743069; cv=none; b=pwdiXK13QBlrj93vlRQullTU3+mni+h58rZEdfUd4ieapJi0se80L73wgN8wXVZSWRCCb2rWpym0VX238qLgRDgleEgjt4QarzXPAnE/LByp0ywidL5vOLlGilp+YkJWFGTCB91UKlOxKP2veIdcYEP7fLGhv/ohwQGwc+Woj9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743069; c=relaxed/simple;
	bh=8frz3kDUf7xiKbtlx6p0SE5iKfNoFfiQ+vKaDHbp3ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAnE8gY9gMuNa6co7BxObBLgYN+rfQGR3f5x91M0DpXooSw+MgTW2T/Uhirj69ajiHcVLUAx8h9tv2TZakXtPhtf/mUIS41eJWYxA5VsMjGXA+U9EHrWUFD5f8f07aleLgBmxe5bkgnFGlE9tjXuxtklIIMA+s27SD2GQpZq5VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fQioXdDv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oFVqscBuDB6XCAkbPeDvoERlJXGPjkbiwgQjtupWEvE=; b=fQioXdDvR+3n87uy0LcT7pJTvB
	0u5UA5v8ziZc+WuUFHgIetdKpF8sLoDEfNaSA+/ZMsPxzaq4WTZNaLHxMS/q0fizjanbuRwT2z9oH
	uR5jFU6lADjBI6/spVCNhUFLpzm5JBQlxlhn6MV+O42FNU5pvJnGthNFnWie7sx6AZEQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uPk6C-00FZ0o-B6; Thu, 12 Jun 2025 17:44:16 +0200
Date: Thu, 12 Jun 2025 17:44:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: stmmac: improve .set_clk_tx_rate() method
 error message
Message-ID: <68547db8-2f4c-4f94-af0f-0d14dc3669eb@lunn.ch>
References: <E1uPjjx-0049r5-NN@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uPjjx-0049r5-NN@rmk-PC.armlinux.org.uk>

On Thu, Jun 12, 2025 at 04:21:17PM +0100, Russell King (Oracle) wrote:
> Improve the .set_clk_tx_rate() method error message to include the
> PHY interface mode along with the speed, which will be helpful to
> the RK implementations.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


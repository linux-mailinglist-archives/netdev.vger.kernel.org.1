Return-Path: <netdev+bounces-220078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E731B4460C
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 21:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE07317FAF6
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 19:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616DF23D7EC;
	Thu,  4 Sep 2025 19:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yH5PxegS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C661FDE09
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 19:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757012517; cv=none; b=Mh0JIfciagEL7Si/38NShVLgo3Nvyua1U4MkIL6BXF+dRTl7jzTuip/8WWhNM6n3Cmxah/mxQ437roJw2gkHWiLjnWAya/CUyws76L2QAdKpHmuSgzJqVgENiPHeOiY7vdukFd4WCaS0ybGRSXDX+ujon2kRBVctUDZch51+8t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757012517; c=relaxed/simple;
	bh=VLBB1Bxi9fqnzP7fPHBPJ+N5xXiWKeAiJBww/V/RRlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVtU31LBwPKt0/VQm3oldxJVvXBxt9vyz84GHgBZxzgFEC/LkW/m06U4KQ8l2spLjbw9n393tXdjRJ10oi7cMNQ3xdC/ORQod5Y5eLdtEXGFcVu0nNZpHzR2vP2ACGCFkcrFCHBn65830d/ONAgcjtVgEm8dH0ObEG7xTRBHChk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yH5PxegS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=q3pn9TnjQfwZCp4ep03XzbkPjs7VTHJmIkhrvceeOQE=; b=yH5PxegSC+b0gCn+t+qzIpSrfg
	bMn/XR9un/cuiddzcelNEzoGoVzzE7/fvdRln82emie0WZ2gqHu5aZfBTnuYxJogfZ5wp31RyKHEd
	vRn0BK44bCbTyu0rsj431SAYTIK5xcDTXSEkE8nmruoKV7qqtR4wFfNp5mUt3yNLCXIo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uuFDP-007G77-59; Thu, 04 Sep 2025 21:01:47 +0200
Date: Thu, 4 Sep 2025 21:01:47 +0200
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
Subject: Re: [PATCH net-next v2 06/11] net: stmmac: mdio: move runtime PM
 into stmmac_mdio_access()
Message-ID: <a4264648-2d70-4131-befa-35e81e98ac6a@lunn.ch>
References: <aLmBwsMdW__XBv7g@shell.armlinux.org.uk>
 <E1uu8oH-00000001voy-2jfU@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uu8oH-00000001voy-2jfU@rmk-PC.armlinux.org.uk>

On Thu, Sep 04, 2025 at 01:11:25PM +0100, Russell King (Oracle) wrote:
> Move the runtime PM handling into the common stmmac_mdio_access()
> function, rather than having it in the four top-level bus access
> functions.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


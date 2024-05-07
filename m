Return-Path: <netdev+bounces-93905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6142B8BD8E1
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 03:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1573B1F21838
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 01:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087F115D1;
	Tue,  7 May 2024 01:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fzY+tXi/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D781862;
	Tue,  7 May 2024 01:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715044868; cv=none; b=YTBYHgFGrZSvksIt+hSd78LjcVKHNA3QhyGwCk1qtTuIevvlibX5bwFB9CmXZhguAragMrJ92bp3w2YCDxExiHODvEmKbFTtLZccJ8bxcWSuzuLQlBGpTBrxvwE8TxTog4GVTvUW75a1cwXbOmxGFcyPvq/DmZGqVmjGReQ1EeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715044868; c=relaxed/simple;
	bh=F+aIFNOTgHondlXqavvm/br/vmlFTyMWVANA4aI+mjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XefUvsOWHKFvZnL2ZOgQTD/239D0c3fmj6M5FHTUvCTDGg4sBN4VtnxN8hNpkOhjYcZWwB+dbEIT+X/XAPhY/ljZaTNkM44eqOK6Ld8HmRfHHay+EijBTBsFYrPTPE7lz7xmpdjc0YOQkVxkdD+hlw+42M7N7uKKaTZT3zWnGSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fzY+tXi/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fYpJZptr+CFQVFJZql4DSBtvy01u2b9drswZ42yZ9Oo=; b=fzY+tXi/UsTDExwmPFhCAbXewZ
	lsK2vDYSdz8FqNFQQ2eZPjxsNprlfX6702/O/6xy5Arh+dlo2hBmw2Ui9DScqeAr14sC1VYM46qTA
	tCw9c1tY2CDe1anO5oki7aDzMmeYzrDyVahiOOFXkl05vbBaB7DDml4QjMZ6M1NE+UAE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s49Vi-00EoGZ-0X; Tue, 07 May 2024 03:20:50 +0200
Date: Tue, 7 May 2024 03:20:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] net: stmmac: dwmac-ipq806x: account for
 rgmii-txid/rxid/id phy-mode
Message-ID: <33b28b54-dd25-4ec2-a3b2-89c223e16057@lunn.ch>
References: <20240506123248.17740-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506123248.17740-1-ansuelsmth@gmail.com>

On Mon, May 06, 2024 at 02:32:46PM +0200, Christian Marangi wrote:
> Currently the ipq806x dwmac driver is almost always used attached to the
> CPU port of a switch and phy-mode was always set to "rgmii" or "sgmii".
> 
> Some device came up with a special configuration where the PHY is
> directly attached to the GMAC port and in those case phy-mode needs to
> be set to "rgmii-id" to make the PHY correctly work and receive packets.
> 
> Since the driver supports only "rgmii" and "sgmii" mode, when "rgmii-id"
> (or variants) mode is set, the mode is rejected and probe fails.
> 
> Add support also for these phy-modes to correctly setup PHYs that requires
> delay applied to tx/rx.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


Return-Path: <netdev+bounces-155540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C84FA02E93
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 18:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240AB1886983
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 17:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3C01DD543;
	Mon,  6 Jan 2025 17:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FgllUqI7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44901DC99E
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 17:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736183112; cv=none; b=hB1wXeb4i30QOKAdZYxjWmj7blzTE3Q7VCGxy96yRYtB9Oz77Y+PbLlaSXGUxolYcBrxGx6+AQeuAM1iVck29CFBdel0k5uP3gh5LjDWrpaiGlwoZratH5ct+oR2ziVOZi/P7HlWtUqMD/q3KLAp661WIS4bT5oZnVGhU8Q3uTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736183112; c=relaxed/simple;
	bh=neFNyFpPOSqtyGE0AdYtaaHexojYivTTayWtgTNSeZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4AMXu0PA9+ashrKbXHo4s9w5azFJ4Hh3CnrEcKqufowzWb63GsjzlHpR/+6QDwKfmtxt7VAX6LrZvDexbKoWD7zQxvzhiZbYf6k2lAwzTMc3fagzrHRjP0I4y/kXFMVw/sxC9nsvIWXxeS9Bo3xY9E2lawhy9+OmtTt5DMTcJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FgllUqI7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8VTs1+x2pTFe8tnSREU+rvWGLKyWyVEaBCjCFPKHqA4=; b=FgllUqI7GoH19JKvDzk+sRkikO
	prK8orwoVZPvT+67lKbx+yXcuoYqtjQ6EcxxdF5vBXV26KIB9taM+/24Nl0wLYZZQO0g3wwhdYnFF
	uOXeaxOIt0Ph28t5ErohAqyxrYTcNeheeC4uM6LoOs1nS2VZGZYmX/JCvQZxsLKjo2lU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tUqXE-001wMB-MI; Mon, 06 Jan 2025 18:05:00 +0100
Date: Mon, 6 Jan 2025 18:05:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 12/17] net: stmmac: move priv->eee_active
 into stmmac_eee_init()
Message-ID: <59f77c8e-bca6-4b9d-b6cd-167be4012ecf@lunn.ch>
References: <Z3vLbRQ9Ctl-Rpdg@shell.armlinux.org.uk>
 <E1tUmAz-007VXn-0o@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tUmAz-007VXn-0o@rmk-PC.armlinux.org.uk>

On Mon, Jan 06, 2025 at 12:25:45PM +0000, Russell King (Oracle) wrote:
> Since all call sites of stmmac_eee_init() assign priv->eee_active
> immediately before, pass this state into stmmac_eee_init() and
> assign priv->eee_active within this function.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


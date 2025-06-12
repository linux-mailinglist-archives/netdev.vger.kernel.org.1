Return-Path: <netdev+bounces-197077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49121AD7744
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 18:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CCA8188B003
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E23298CB5;
	Thu, 12 Jun 2025 15:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CSMzHpNG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526D12989B5
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743489; cv=none; b=usPyHoRL9RURqVa/Tz9YN913iPLS32aBt2ydlI7KwLCSxGC0GrVUQLJZu2zkJGb9qYMbgSpY8EMZ5cgyWPnfGqFD+cKp09PnoCX+DHGQ+UKEG7Swt+tgdQy8aMc9GxAQBdC3AE384wh6ohr306cOa3XT8RzCg+4roC38jqlcPiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743489; c=relaxed/simple;
	bh=+oLk89fYpVMmj5ox9RUgv+QlsXlann/uSQgQrxfcZC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTKvyKfLnAPpbUC0XH6StY4c+9DNHwrmAc6d2wGQnumJ66e9MfEUMJAEiLwCoSlI7BxhswSEe7+F5w3F9C5+1sTfhnISTEwGXjOZdo3LVv9kXigfqk2S86kbRh/pcnqFXyRKPQT30HRqbLHQY/4/vsTP4iU8QQs4VZlzbOPpDDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CSMzHpNG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tkfjVEKFOzj0a7pCRXpz7lWWXfngyymyfaKG/KilTm4=; b=CSMzHpNGvshGmE6pFbWM7AxiAY
	zz9nF5tji5P1lwNv1GmvSO0YaIU4HX8QOJrOKNEX2W8Rm9HxtzZ9jxks+4ggNyTmbiOrr6cwbeglh
	lA1IpC0XjJz+imWdz1GR2agMfoQ+1TKMzOL87mn63Zsz+m2OoLj/GbmCMam0YgRLpNIs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uPkD1-00FZEt-UZ; Thu, 12 Jun 2025 17:51:19 +0200
Date: Thu, 12 Jun 2025 17:51:19 +0200
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
Subject: Re: [PATCH net-next 6/9] net: stmmac: rk: combine .set_*_speed()
 methods
Message-ID: <76cdb7b9-1c2c-4c0e-b948-4863dc1756db@lunn.ch>
References: <aEr1BhIoC6-UM2XV@shell.armlinux.org.uk>
 <E1uPk39-004CFf-7a@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uPk39-004CFf-7a@rmk-PC.armlinux.org.uk>

On Thu, Jun 12, 2025 at 04:41:07PM +0100, Russell King (Oracle) wrote:
> As a result of the previous patches, many of the .set_rgmii_speed()
> and .set_rmii_speed() implementations are identical apart from the
> interface mode. Add a new .set_speed() function which takes the
> interface mode in addition to the speed, and use it to combine the
> separate implementations, calling the common rk_set_reg_speed()
> function.
> 
> Also convert rk_set_clk_mac_speed() to be called by this new method
> pointer, rather than having these implementations called from both
> .set_*_speed() methods.
> 
> Remove all the error messages from the .set_speed() methods, as these
> return an error code which is propagated up to stmmac_mac_link_up()
> which will print the error.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


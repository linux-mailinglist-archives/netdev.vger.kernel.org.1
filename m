Return-Path: <netdev+bounces-184609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63101A965E5
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 12:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8871898CB0
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 10:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B732116EB;
	Tue, 22 Apr 2025 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="yBHj99j4"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5F2201269;
	Tue, 22 Apr 2025 10:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745317607; cv=none; b=L7/6hLnUCz/aLZLEnmOoL+C4H4tECKlFxEKaTM7ACJC8F4Jmw11lYsSjQyyCdQFrqp33e6QWio8/ZiPgbje05YEwbZ/h+j+0TKTh/xJclbPIiHO2ZTquejV1Xcu31HgHSifSBTWEaA0JIKbB0+qAkCbqKrx5p0yu+jJaXaJtqg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745317607; c=relaxed/simple;
	bh=tsT7/Vbp/ii+NEg4JvuVurAGlG/LhXs3Ua6xAPXKgPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XN4gPNrKmaxjqigCkOi7pWHj2Os1Uk/v8LP+IuoIGOWb1RoZf5Y+U92NISX/pa19ocDg5eYQW6jTXKDeG/9OfB/5bEGgP+iRfWLfTyNprBPw9yRNTgNx7p/Sn87E4wCWnifaA7Jty4fugGA0BMTMCkVfcTrJ1hcb19npDjfJAYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=yBHj99j4; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=a9dTCY3Nlp7h9AK5R2DiWnTdza2u2KFojRHvK65dh+I=; b=yBHj99j4Coe1EfxIyA/tbYMttZ
	pmxe6tjJqp646nbhlnmY7uK+i8zegBk2v8gZdp+mRsbhstkt2WpMTmKr3X937lZRkGm2U1PRJKLMw
	ggLCFxrSlh/PqlaEhXsQyqtJhhwArsADhViNEC4Il6v5UtGLBybaY1nD3OKvedHqAV3pawpGv1U+N
	cBgQQb3A7EsYz0AMsNeQ5J2uNna2WQFc5EB0aU+Q94UujO7RVe28TlbRtlXWIE/3m52La8RjF+cac
	OoDEgKrmzrkHXw+ZWgWlw1lOiV5zszuRRIjegY/Lx7hQGPwbjGILB7L+OCPaInKhMk0fiBx0cCmUq
	huZMrIKg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34152)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u7Apt-0004Cz-2s;
	Tue, 22 Apr 2025 11:26:42 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u7Aps-0007PU-2R;
	Tue, 22 Apr 2025 11:26:40 +0100
Date: Tue, 22 Apr 2025 11:26:40 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, Simon Horman <horms@kernel.org>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>
Subject: Re: [PATCH net 3/3] net: stmmac: socfpga: Remove unused pcs-mdiodev
 field
Message-ID: <aAdu4EGoVMMUzsXb@shell.armlinux.org.uk>
References: <20250422094701.49798-1-maxime.chevallier@bootlin.com>
 <20250422094701.49798-4-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422094701.49798-4-maxime.chevallier@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 22, 2025 at 11:46:57AM +0200, Maxime Chevallier wrote:
> When dwmac-socfpga was converted to using the Lynx PCS (previously
> referred to in the driver as the Altera TSE PCS), the
> lynx_pcs_create_mdiodev() was used to create the pcs instance.
> 
> As this function didn't exist in the early versions of the series, a
> local mdiodev object was stored for PCS creation. It was never used, but
> still made it into the driver, so remove it.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


Return-Path: <netdev+bounces-212185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBA5B1E9B2
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 15:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94D691892E6C
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 13:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E921494A8;
	Fri,  8 Aug 2025 13:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2EzPM4n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F959146A66
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 13:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754661433; cv=none; b=nRWOl+TOaITdZBaQQwKtjcuVWgC59O04jg0Tw0CuDJDKQ2teV72RZqMWB4qqgbN3MHvmT3PsH4UuvlULbJGernkDXABl+atSg4FNC2UXWamnCEK7+A4T7kP/OijWxW+vAa41339jJxEusapWNUzkiP6xZ/ADJ2Vfy8RqDzCCfkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754661433; c=relaxed/simple;
	bh=AgMrnqxhNaxCNBFzW1CbjSj7+1BQvkwh3Ak4/ManYq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqihnQoo+2s4yh5NKTsJVCJwyL7uGPfc/K/7iPve8wxvGzvqjvF3PFK0XV3xCaZx+LJIhEx7vBf7KRdA76YEDKfbRqB+mnuSfatN9pqLv1s3FDn4sjarOVBrh9jF7ri+4Slve9vXORbVggqDlan5szmPJmv/zZPOsKyTlRoOSbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2EzPM4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29736C4CEED;
	Fri,  8 Aug 2025 13:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754661432;
	bh=AgMrnqxhNaxCNBFzW1CbjSj7+1BQvkwh3Ak4/ManYq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n2EzPM4nZP1QcAlZ2twuc6dYXtrX046zg9nolGES4MFdm9zE1vVUiCwVbbZcrZUkq
	 8MsDCMRT/j1bJ1by3EKEKcJ+EyKNVRQyRaNZaQZAv9D5S2NVYU+6+w4wIR9kkAdl8G
	 YEK5X/uSDR5qfFnqqWpQiCVTLFHoflYMh8ZYAmuRA7upA/QBkKt8DE+43Heob76niF
	 s0fxTYvCxFbM1rqIUIXv/tmoMUSTtQoeIBRojgMhHTwJkHrL2Okg15442yUdORHMMc
	 NsN+a7LihHhlyyD0Z1MmnOMIDrdSbHVirL1Cw7/xiOBCNhQtdcAqnQds49wexNRLz9
	 oF6XD8AsFZAwg==
Date: Fri, 8 Aug 2025 14:57:07 +0100
From: Simon Horman <horms@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, David Wu <david.wu@rock-chips.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v2] net: stmmac: rk: put the PHY clock on remove
Message-ID: <20250808135707.GE1705@horms.kernel.org>
References: <E1ukM1S-0086qo-PC@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1ukM1S-0086qo-PC@rmk-PC.armlinux.org.uk>

On Fri, Aug 08, 2025 at 01:16:34PM +0100, Russell King (Oracle) wrote:
> The PHY clock (bsp_priv->clk_phy) is obtained using of_clk_get(), which
> doesn't take part in the devm release. Therefore, when a device is
> unbound, this clock needs to be explicitly put. Fix this.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> Spotted this resource leak while making other changes to dwmac-rk.
> Would be great if the dwmac-rk maintainers can test it.
> 
> v2: fix build error

Thanks for the update Russell.

This fix looks good to me.
Reviewed-by: Simon Horman <horms@kernel.org>

And I guess it ought to be marked with.
Fixes: fecd4d7eef8b ("net: stmmac: dwmac-rk: Add integrated PHY support")

If correct, then I don't think any further action is required as supplying
tags via email should be sufficient.



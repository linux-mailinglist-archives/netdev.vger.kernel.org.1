Return-Path: <netdev+bounces-235411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 924DAC30233
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 10:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AAC4D4FB023
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 08:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0A625FA10;
	Tue,  4 Nov 2025 08:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FcnvnJJO"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979B8A41;
	Tue,  4 Nov 2025 08:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246691; cv=none; b=NfOezXiw8OEIyff6U86RrFUUiTenEwm/fMNUg3QPYfU5kaagqeUa7/9Nw/plm9xxjhdkP4uv/GZel6PdokyqY+aqRsJvQuZ3tJqt/QnmCsk4uVBBWNYLgoGTP2Uvh0yl0sM2zCL+W8YfaUo1SeE5uYzIcoj3B2AEzgB+sjm8smo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246691; c=relaxed/simple;
	bh=P/AjJRz/CdLEZ4MqDYR4thnIkJGNgnUAUoznYrOg/nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIWVKtSAg9TVbiiNMxfQHS3iSeNNZlP8M3k1hRLqDkbL9HMhS+6iNY0cSAM8aQV05qSSMntvxUXIgZLuqLgCBEJj8GAG/WYNh3SPTeImMB9jYBw+utUPRW3gbgb77/jX10UBq+ZFxcTrpRFyUqVibQWNaLwBPfC0gpdJCpw8pGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FcnvnJJO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=K8mvk5vBxcHAFNc6juyiFWMLoFgbqb6bZHiYWEtQNQU=; b=FcnvnJJOyvaLViID66dl5B+rAa
	H+pUylzMoeTO7DOnBMfr1DTbmqhKtWLjfJjeseJtwL6lc+ecqeqn23MjsbOyRjaWgelBeGl9y072+
	221zuPB6b9OIhe3HP6cSRqDIrZ7VMrp5N8RZXrVDG0U4njF0xQneaRYQiFQqTS43Ou/sqmCQiSoY5
	prJKq/WntFM23ARCST2fE7Z1zQdTQPJ5fZ5qKQ7m53Z2jN835WbLsiKZELzQtSlrqrVGqukTErf7z
	cp/SagUUNYKIgVuJZolz3Vgi088lP7plAwWVSePijPNeyK/YTqu/uYFGusIz7sH1grtX5iXY+X5qp
	Z12kpUiQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44012)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vGCrZ-000000001uO-3svy;
	Tue, 04 Nov 2025 08:58:02 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vGCrX-000000004dk-39Q3;
	Tue, 04 Nov 2025 08:57:59 +0000
Date: Tue, 4 Nov 2025 08:57:59 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: phy: dp83869: Restart PHY when
 configuring mode
Message-ID: <aQnAFxSTyo6SofZ7@shell.armlinux.org.uk>
References: <20251104-sfp-1000basex-v1-0-f461f170c74e@bootlin.com>
 <20251104-sfp-1000basex-v1-1-f461f170c74e@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104-sfp-1000basex-v1-1-f461f170c74e@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Nov 04, 2025 at 09:50:34AM +0100, Romain Gantois wrote:
> The DP83869 PHY requires a software restart when the OP_MODE is changed.
> 
> Add this restart in dp83869_configure_mode().
> 
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> ---
>  drivers/net/phy/dp83869.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
> index 1f381d7b13ff..fecacaa83b04 100644
> --- a/drivers/net/phy/dp83869.c
> +++ b/drivers/net/phy/dp83869.c
> @@ -797,6 +797,10 @@ static int dp83869_configure_mode(struct phy_device *phydev,
>  		return -EINVAL;
>  	}
>  
> +	ret = phy_write(phydev, DP83869_CTRL, DP83869_SW_RESTART);

So if dp83869_configure_fiber() returns an error, that doesn't matter?
(This overwrites its error.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


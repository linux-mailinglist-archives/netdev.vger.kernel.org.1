Return-Path: <netdev+bounces-216875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FFEB35A1F
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 12:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F903BB383
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 10:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187EE2BDC2F;
	Tue, 26 Aug 2025 10:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jZ6BNJTq"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4852FAC1C
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 10:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756204272; cv=none; b=VcI/WGCknhP0BIwThEQtjkmoxDacZn7fVl0qco4RsqEJuGjMZMr56dyDScJJJj2y/egCabAd3kcTbzDr5w3Tnn7yo7CVFx2TDivpboXO1hHjjsbkTLCdQdyQwiJTYHOjntLc4ltlOkknHmcJdOqpF5R0tFQ+jtOlN3IlBUcUEkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756204272; c=relaxed/simple;
	bh=Iu/jaGqr4qxc3Z1Hc1rsVy2GmgQD1sxytMAByJj37iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsqjgZPuCX9G9dJCdPUlcZ4Yi/LX7RNy11dNWmtQq05WXjRZx47ebJtQxYAvyyTIq/8mH9yIkQEd9heWnAqtR1sTPHePpBNDbK7Uk290vL6zVAfyE8bzYsw58Gvu3ZfhTLs11AzPYlq5Mx2H8858qhYW5wbYpSgE/kWa/gYTpog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jZ6BNJTq; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KF2ObC+OsVZ7or0LZchP/vk8UwZrfHhQgcnlOB8aCz4=; b=jZ6BNJTq2lIQwKfYvco0uRWf8+
	oV5k1oBfbLni7eapsB1h9rcCAp1N6+8fnG8gR5EdVvRlyLx8tx4l9tdvLBB5RjkYf1FEyZZE4GBvV
	d4TvThynTfshIl5sypaefRXA470zgUaMTNnq+e80GQOrHvf9C7YojtO6FUDr29BStnggw8ukriw+3
	BInjVJzkMkOnF5QZsbzLA4ROI8AE75BNQcWnQ3bNw7v9wN74/rFp72E5Ls1vguaXrPbF+AaAnbEBp
	qqIlvPDcA3eta/73J35HFoH+FUG+qe9MTwnF6vlNvi/TVAfSqxhfYX5kw8YsilHSBnG0eiO++PXWk
	G8BuwNgQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45122)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uqqx5-000000007iq-07K9;
	Tue, 26 Aug 2025 11:30:55 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uqqx0-000000001Ap-2cp5;
	Tue, 26 Aug 2025 11:30:50 +0100
Date: Tue, 26 Aug 2025 11:30:50 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: david.wu@rock-chips.com, jonas@kwiboo.se, mcoquelin.stm32@gmail.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next] net: stmmac: rk: remove incorrect _DLY_DISABLE
 bit definition
Message-ID: <aK2M2j7-CpnydtUh@shell.armlinux.org.uk>
References: <20250826102219.49656-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826102219.49656-1-alok.a.tiwari@oracle.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Aug 26, 2025 at 03:22:15AM -0700, Alok Tiwari wrote:
> The RK3328 GMAC clock delay macros define enable/disable controls for
> TX and RX clock delay. While the TX definitions are correct, the
> RXCLK_DLY_DISABLE macro incorrectly clears bit 0.
> 
> The macros RK3328_GMAC_TXCLK_DLY_DISABLE and
> RK3328_GMAC_RXCLK_DLY_DISABLE are not referenced anywhere
> in the driver code. Remove them to clean up unused definitions.
> 
> No functional change.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Looks correct to me!

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


Return-Path: <netdev+bounces-100137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FCE8D7F1C
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 11:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C3B91F2447E
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 09:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D59584DFF;
	Mon,  3 Jun 2024 09:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ByhlWGRI"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7948B667;
	Mon,  3 Jun 2024 09:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407503; cv=none; b=W2xabk+ESShePnQVum+2UtgtYXabC6N6Bmx8ZJbIZ43HTHaETcmJZRZYpuelHJwicWyiqkHiEquvePZ9ri2a97yXuSuBlnZ+17r2koCA4UL0wA3cZC0LCnC+1VaG7SJSWXPBArksloSeOMkHSKGObJzJSF6iXHnSS6M5ZxOAR6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407503; c=relaxed/simple;
	bh=nsLDjTZTaB6IlVf1YN+Z1Ok82/GbhJFUrL0xBcqN0mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uADUAhITw3PJJP0CnxXmboeRGAEvdXfEHlBxjMB8M3qNC0+HqQRU8DwgpD3SNoZ/hUY+jk4p87RvowI8WfZVPMACJ01yluB85kPLWllAXktURPUihBCLM4oVYmMMQt1A4rDQ968cw+cgKLQuSxueVIDuk7AzoUSs6Q69UqUzDRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ByhlWGRI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=U7Ho4zKhkkiYFTzTY91pGPL2i6KvNE8h4Vbogb5wZs0=; b=ByhlWGRI2Ktx47DAPDLPq8dnm1
	B+CX9jUK47LjL+lCl8e6Mu8Syjci2Ufq1RkI4Z127sWqr85wz6jhqmCKiL0uopS32LmM8l6iaRhUp
	2x5rRl0dhueE2SS1UwhflKFjjY+lm5ObcN3H1OykMtzbKp/UFET4iJldTTwxKTymYbOYYQcQCIMMV
	YCknfBryxH45AJqMzIsExz4ZGIES33S6GCQlD/WLTB6ljQw1Lk20MBTSqmdIws+jFyOsKe98OaqXb
	xpLDDT54wpVXB5pdsJGyFsl9lmfw0cdeQGASvSQKYp/Zu6qb9+tqTavOkS7Dz1Drpgtqh0aeQUX7o
	pdWUlSew==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44764)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sE48g-0002Xl-1z;
	Mon, 03 Jun 2024 10:38:02 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sE48g-0000Jm-09; Mon, 03 Jun 2024 10:38:02 +0100
Date: Mon, 3 Jun 2024 10:38:01 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christophe Roullier <christophe.roullier@foss.st.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/11] net: stmmac: dwmac-stm32: Separate out external
 clock rate validation
Message-ID: <Zl2O+eJF9vOTqFx2@shell.armlinux.org.uk>
References: <20240603092757.71902-1-christophe.roullier@foss.st.com>
 <20240603092757.71902-3-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603092757.71902-3-christophe.roullier@foss.st.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jun 03, 2024 at 11:27:48AM +0200, Christophe Roullier wrote:
> +static int stm32mp1_validate_ethck_rate(struct plat_stmmacenet_data *plat_dat)
> +{
> +	struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
> +	const u32 clk_rate = clk_get_rate(dwmac->clk_eth_ck);
> +
> +	switch (plat_dat->mac_interface) {

Should these be phy_interface? Does this clock depend on the interface
mode used with the PHY?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


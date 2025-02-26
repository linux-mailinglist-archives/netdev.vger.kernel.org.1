Return-Path: <netdev+bounces-169839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E482A45F13
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 13:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C0EC3B353E
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 12:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC69A219315;
	Wed, 26 Feb 2025 12:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="N+imwegb"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900282185B8
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572668; cv=none; b=dpbB77Pq9WNB8obMUiPJTwa6kUgax7qkLTBbiMwsnXQIE2I0cEWUydjCczxtuxftZttfdgLV5pnwNeXx2ljZI2ZN6Rykhk+DOmL96DeVikIf3bSZ5/08wzzStZBCT58szgacPigBeE34+migAEd+FfUHguLuLe5yRjxY0IdEjak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572668; c=relaxed/simple;
	bh=9rs9YIROSTDROXiWn1+ofokJYQaBLiJncXJIoYCnK9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOgE/iVSdNYnLL+XYJOWMiEvhsU/dz2Xcecuv2dWlacwtqGXZ+YGNWDWaNMaGDsuoVZ2lPCksLljkYpZUMV/Yn9LMU+W8g1gm4lhRDgrihSvsVBPv41cCBYeoM6qa0PfcgO1KZz85pC8cD6tvGDUmfqOCEkJsA1JUMEVKFyUXwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=N+imwegb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=emOQzapFrQT5vVxsL8UHzprrVS/y5Fj4+zQUs5X4tHE=; b=N+imwegbzOoqUjYGfsuVGY8h1/
	UTPAQv5dwe/+Om4CMF/zSIMQ9vqmslf+3Ayv8tpsS9JP9gtvjdjN6HDFB0uBduYrpb/oiIYctKuUU
	yXPBzbaZDpnaLob4tBw338prJhgmbNg0eihxO4SJJXcPFYne4B7k+VzViKgmK0RULvkohOcU5IdGQ
	4XEG+2G+wbIzDigQl06K6kQMt18qejm82FahjXyLULVH+XglcvAvg/bimsdDx/cFpuK95yOPMdBp4
	eNP0//PJIwXFeOkHGYiZ5HbUJiVDzM5iKY2Mmw+wlh6fbhzQhByx++P0HqQm9gg77CEf932RoFTpf
	KYd9CVDA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47836)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tnGSV-0004Cg-0N;
	Wed, 26 Feb 2025 12:24:15 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tnGSS-00074i-2i;
	Wed, 26 Feb 2025 12:24:12 +0000
Date: Wed, 26 Feb 2025 12:24:12 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
	Inochi Amaoto <inochiama@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Minda Chen <minda.chen@starfivetech.com>, netdev@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH RFC net-next 5/7] net: stmmac: s32: use generic
 stmmac_set_clk_tx_rate()
Message-ID: <Z78H7F7oBsC-cCB-@shell.armlinux.org.uk>
References: <Z7RrnyER5ewy0f3T@shell.armlinux.org.uk>
 <E1tkLZ6-004RZO-0H@rmk-PC.armlinux.org.uk>
 <x56yik7opvpr3o5vjlxoxzxdicrz2pimsh4lkpxol7c64r6irs@t7dfqy7ybn2a>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x56yik7opvpr3o5vjlxoxzxdicrz2pimsh4lkpxol7c64r6irs@t7dfqy7ybn2a>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Feb 25, 2025 at 09:43:56PM +0100, Thierry Reding wrote:
> On Tue, Feb 18, 2025 at 11:15:00AM +0000, Russell King (Oracle) wrote:
> > Use the generic stmmac_set_clk_tx_rate() to configure the MAC transmit
> > clock.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> I wonder if the clk_set_rate() call for gmac->tx_clk could also be
> removed from s32_gmac_init(). Comparing to the other drivers that
> doesn't seem to be relevant since ->set_clk_tx_rate() will be called
> anyway when the interface is brought up.
> 
> But it might be more difficult because somebody would actually have to
> go and test this, whereas this patch here is the equivalent of the
> previous code, so:
> 
> Reviewed-by: Thierry Reding <treding@nvidia.com>

I'd prefer not to change the code behaviour in this patch series. It's
entirely possible that's somehow necessary to ensure a correct clock
is supplied before attempting to reset the MAC core on this hardware.

It could be something to be cleaned up in the future.

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


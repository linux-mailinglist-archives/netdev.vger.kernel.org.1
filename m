Return-Path: <netdev+bounces-166790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF40CA37536
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 16:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14ACE3AB39A
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 15:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD8042A99;
	Sun, 16 Feb 2025 15:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="TH/sXzoG"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5E7C8E0;
	Sun, 16 Feb 2025 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739720883; cv=none; b=sQn5Bj/zKblUDitbbKPxDmmHZEgerYls3jI4FYzTZA4y39c2gshG/bz0ObxfUYdhubNxXxTN9/P13iEAHwF1cmmBsg9G829IcH5Xi/l12OI2iTnWqC4ysoPxhAX2EYnBYEWzVzryju7x9CSQ5uCQy3khzT3+xKH1MnzQot1y4Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739720883; c=relaxed/simple;
	bh=JqQMD0hqYOzs5dOw+guRhjn4l01nDPpTFW7xyP6E+tA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHYws73Q0q0sDp6ClAzsAF1Arsqmj2lsrZEkAHhRaERNZTmxKctQF0M2C3nGGq3/5F7X9hFgums6qOelmEjUcDoEvB4ZerabxY8USLYu+3Watjg6Wzh5v9CjezYKn8rX/BSk/wclvd2UNd2a82kb3xLrLRhkRdLsAlexE9r3+Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=TH/sXzoG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/FrEnAM0Ty8b3TT2wk1qUCREpGSXW5825yX1yLHlP7U=; b=TH/sXzoGZDKFZxyyyYNMJfCCcJ
	haaiHeMXtkJd0EXixYhy5qRVdKxKvo6QU4s+3xu/7RPBJy8inXCaysxqUhpogLaQcnHn5agZHY7vC
	ISA3JdH8ZIaySnObQY2s/fgesQH838h2X0hJ3Ddzde/x05GIMag/3XwrgarNWLs68l5ow65dSA6Ez
	GZTTUyKV3vIU8VQAcZF8t39IRm/HYkxgn7wil+eIRf85b52fO03F2CLRoj36JaFDK0f/aQ/io0ge3
	q8X+LcpW8NGBveQyqdM7nD9heEDOB1Jz6Zd2z8FuDZLqL3ahCTvqdWKkxt/Upnvkzk8EOTmfUfgiT
	8owusuhQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39494)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tjgrh-0003Z0-1w;
	Sun, 16 Feb 2025 15:47:29 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tjgrW-0005Ji-15;
	Sun, 16 Feb 2025 15:47:18 +0000
Date: Sun, 16 Feb 2025 15:47:18 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Furong Xu <0x1207@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Serge Semin <fancer.lancer@gmail.com>,
	Lothar Rubusch <l.rubusch@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next v5 3/3] net: stmmac: Add glue layer for Sophgo
 SG2044 SoC
Message-ID: <Z7IIht2Q-iXEFw7x@shell.armlinux.org.uk>
References: <20250216123953.1252523-1-inochiama@gmail.com>
 <20250216123953.1252523-4-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250216123953.1252523-4-inochiama@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Feb 16, 2025 at 08:39:51PM +0800, Inochi Amaoto wrote:
> +static void sophgo_dwmac_fix_mac_speed(void *priv, unsigned int speed, unsigned int mode)
> +{
> +	struct sophgo_dwmac *dwmac = priv;
> +	long rate;
> +	int ret;
> +
> +	rate = rgmii_clock(speed);
> +	if (rate < 0) {
> +		dev_err(dwmac->dev, "invalid speed %u\n", speed);
> +		return;
> +	}
> +
> +	ret = clk_set_rate(dwmac->clk_tx, rate);
> +	if (ret)
> +		dev_err(dwmac->dev, "failed to set tx rate %ld: %pe\n",
> +			rate, ERR_PTR(ret));
> +}

There are a bunch of other platform support in stmmac that are doing
the same:

dwmac-s32.c is virtually identical
dwmac-imx.c does the same, although has some pre-conditions
dwmac-dwc-qos-eth.c is virually identical but the two steps are split
  across a bunch of register writes
dwmac-starfive.c looks the same
dwmac-rk.c also
dwmac-intel-plat.c also

So, I wonder whether either this should be a helper, or whether core
code should be doing this. Maybe something to look at as a part of
this patch submission?

We really need to stop writing the same code in different ways and
think more about how to reuse the code that's already present!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


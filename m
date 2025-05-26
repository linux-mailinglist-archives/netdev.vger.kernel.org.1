Return-Path: <netdev+bounces-193447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77644AC411D
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 16:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0790162B4C
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 14:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD4720459A;
	Mon, 26 May 2025 14:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ci1RKDb6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E0F1A9B24;
	Mon, 26 May 2025 14:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748268857; cv=none; b=ee5GGvc/37YzYNOFX5ee/4cBVlGdj3CR7aMr20b6xMLw72YDwY+ln4Hy0jc4wo1XoT1veP/ppmYZZtyE3ZNijw/hNwa+/V2/R13dlIrXvm0hqG+tGmBs4HrqBmZ/c4sziHRgwAvK3tlL8qx6iC7dOLJzXI5SM7c2USNucWGyBQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748268857; c=relaxed/simple;
	bh=ETTjRBcczpFag2Ns20oIEcNc2E4vGNitf8zIGNoNDaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjcNj2Ou9pKi8vqhDcyUENMnhtzXtJPV1ActAPGhwSBDFedeEHAusHIY+lQCXhEh9DiuHSSwQ1mllNKBWpt6Ixy8jaapvUwslCz5t7slphgZz5Rf8MuxWeNyDoX52+oeZd0fExoOMJjfUhD84pMLC7oyjt5TyUNZlp8LjldFmLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ci1RKDb6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gTUQIv6xtVQdEIhWmKs1GCL0HyslUp2+oj7lqnt+NHQ=; b=Ci1RKDb6871pfBSzyscgJXu0GQ
	rqWL6a6oZXu1JWVoZrzBArnlLSOMg0jGzEsX9C+54h22e0E79PbXd5vCv/kb/scMxfqVR+0Sy5rkj
	FTHPaIn1AIf27eudzyyjNlNPfgrVDJ8XFac94nsGGF8cxeHADlC+aoh5itlnIaFaCM44=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uJYad-00E0Oq-Sg; Mon, 26 May 2025 16:14:07 +0200
Date: Mon, 26 May 2025 16:14:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: James Hilliard <james.hilliard1@gmail.com>, netdev@vger.kernel.org,
	linux-sunxi@lists.linux.dev, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Yinggang Gu <guyinggang@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Feiyang Chen <chenfeiyang@loongson.cn>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Paul Kocialkowski <paulk@sys-base.io>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] net: stmmac: dwmac-sun8i: Allow runtime
 AC200/AC300 phy selection
Message-ID: <4a2c60a2-03a7-43b8-9f40-ea2b0a3c4154@lunn.ch>
References: <20250526002924.2567843-1-james.hilliard1@gmail.com>
 <20250526002924.2567843-2-james.hilliard1@gmail.com>
 <aDQgmJMIkkQ922Bd@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDQgmJMIkkQ922Bd@shell.armlinux.org.uk>

On Mon, May 26, 2025 at 09:04:40AM +0100, Russell King (Oracle) wrote:
> On Sun, May 25, 2025 at 06:29:22PM -0600, James Hilliard wrote:
> > +	if (!nvmem_cell_read_u16(dev, "ac300", &val)) {
> > +		const char *phy_name = (val & AC300_KEY) ? "ac300" : "ac200";
> > +		int index = of_property_match_string(dev->of_node, "phy-names", phy_name);
> > +		if (index < 0) {
> > +			dev_err(dev, "PHY name not found in device tree\n");
> > +			return -EINVAL;
> > +		}
> > +
> > +		plat_dat->phy_node = of_parse_phandle(dev->of_node, "phys", index);
> > +		if (!plat_dat->phy_node) {
> > +			dev_err(dev, "Failed to get PHY node from phys property\n");
> > +			return -EINVAL;
> > +		}
> > +	}
> 
> 1. You are re-using the drivers/phy binding for ethernet PHYs driven by
>    phylib here.
> 2. You need to update
>    Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
>    in a separate patch.

A real user, i.e. a patch to a .dts file, would also be good.

  Andrew


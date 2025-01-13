Return-Path: <netdev+bounces-157817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD76A0BE3A
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 18:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 668E91882825
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 17:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D9870807;
	Mon, 13 Jan 2025 17:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="f8iBETVc"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA815240243;
	Mon, 13 Jan 2025 17:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736787717; cv=none; b=flBnTNUY/r3eQKvO0vUmKKVjgYLRvPY9nfrwuBB62EWjScfkbB363CzGWuUHPNJN7nQKZ8gH97O2oF1rBQZGNntfpgm3yny/V+yTJ0UWcKyy1LK+4puNizpiHEZXmxhP3ZgPsPduzNDNdravLc2x46ly07At3XpQ9vvHPqN8N1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736787717; c=relaxed/simple;
	bh=3p8GtCHTj/BY7sgQySkaxArgCN3QMRE8FLDEVnwJS/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvq3lQgDPdFW3I85bRhWIjRsU6MZKPpAh7ayaFfjh9v4dN7bdDC4ynLp7bB8xNOxUGYhzDoO2cF4/nJnxONxEf4IdLK4E3QDnrcFqy1NTnv06TNoiS8EDzJ3NSL5DltRKopYf5F8JYLFhc1xWJZz2BLWW1up/QuJ44WtHv+WoYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=f8iBETVc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=258ufSRhmAKCNH7ZmIiFnUQr7BuMTzRbL7O6cvZOqdU=; b=f8
	iBETVcZeENe2KuK9+Iy18jnMuirgQ/hRPCOx2rLaLlicuMaOXL8rdhDRoW1J3quvkUQKdiLu1YWeV
	YGTl1z0lCXqNWsCoGTCykYSkg5wl8hkOkkrX04qPOoRlQH8xIGw6S3hbgdVKClW2y1BsZNomObUrY
	reA/JawS4XnvhSs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tXNol-0049xb-4Q; Mon, 13 Jan 2025 18:01:35 +0100
Date: Mon, 13 Jan 2025 18:01:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yanteng Si <si.yanteng@linux.dev>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com, imx@lists.linux.dev
Subject: Re: [PATCH net-next 5/5] net: stmmac: stm32: Use
 syscon_regmap_lookup_by_phandle_args
Message-ID: <c4714984-8250-4bf2-9ac1-5a9204d3aca8@lunn.ch>
References: <20250112-syscon-phandle-args-net-v1-0-3423889935f7@linaro.org>
 <20250112-syscon-phandle-args-net-v1-5-3423889935f7@linaro.org>
 <5d97dd34-f293-4403-b605-c0ae7b5490fd@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d97dd34-f293-4403-b605-c0ae7b5490fd@linux.dev>

On Mon, Jan 13, 2025 at 04:05:13PM +0800, Yanteng Si wrote:
> 在 2025/1/12 21:32, Krzysztof Kozlowski 写道:
> > Use syscon_regmap_lookup_by_phandle_args() which is a wrapper over
> > syscon_regmap_lookup_by_phandle() combined with getting the syscon
> > argument.  Except simpler code this annotates within one line that given
> > phandle has arguments, so grepping for code would be easier.
> > 
> > There is also no real benefit in printing errors on missing syscon
> > argument, because this is done just too late: runtime check on
> > static/build-time data.  Dtschema and Devicetree bindings offer the
> > static/build-time check for this already.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >   drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c | 9 ++-------
> >   1 file changed, 2 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> > index 1e8bac665cc9bc95c3aa96e87a8e95d9c63ba8e1..1fcb74e9e3ffacdc7581b267febb55d015a83aed 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> > @@ -419,16 +419,11 @@ static int stm32_dwmac_parse_data(struct stm32_dwmac *dwmac,
> >   	}
> >   	/* Get mode register */
> > -	dwmac->regmap = syscon_regmap_lookup_by_phandle(np, "st,syscon");
> > +	dwmac->regmap = syscon_regmap_lookup_by_phandle_args(np, "st,syscon",
> > +							     1, &dwmac->mode_reg);
> The network subsystem still requires that the length of
> each line of code should not exceed 80 characters.
> So, let's silence the warning:
> 
> WARNING: line length of 83 exceeds 80 columns
> #33: FILE: drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c:307:
> +							     &dwmac->intf_reg_off);

checkpatch should be considered a guide, not a strict conformance
tool. You often need to look at its output and consider does what it
suggest really make the code better? In this case, i would disagree
with checkpatch and allow this code.

If the code had all been on one long line, then i would suggest to
wrap it. But as it is, it keeps with the spirit of 80 characters, even
if it is technically not.

	Andrew


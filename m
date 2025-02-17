Return-Path: <netdev+bounces-167117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9A6A38F90
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 00:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D8A1881CBA
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 23:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5D51AAA1F;
	Mon, 17 Feb 2025 23:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NESdsBBL"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698ED14D444;
	Mon, 17 Feb 2025 23:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739834528; cv=none; b=qwVXfG1J0k1XVtl7JevFh8ANj4ZfZ0A7tCbkD7w5SvzLBZhmYNxJHdvgofdLAqWILc+Z6KtjIQowu8Hc/4ZNk2hH0dx41i66xzrlDmgy4xjaGCoyx7MBVBvzS1EU/J1qfxMi6KsHxJK7SfT9dqrW4tkR2TW8mhzDNB6WJnNNLAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739834528; c=relaxed/simple;
	bh=f83O3KxdUX2e1SDP+npF3Cm47CLmohfTTXT+mmIhBIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwOh+uGx3U6SGGTnNSBeNxtldVL0BJnQlN86f9OmJyW7GUCGjRlhfNRmZvl11Jj0bKf74KY7Cyi5buchiJYKLxq1aoQNQlccjNQqkH5bNIe2iURB7n4KEXO7BPhepFKSupHVBJ8pnwZ5y0m3glQ80ADyHxAOBKLc/nr95mK60tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=NESdsBBL; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=z4zZA+SHhnpmJYDOp0NswBWcZOVtoN7RDeuxjfGWwYM=; b=NESdsBBLeV/I0kXm45xJYp1bTL
	oWkZIdEUuBRoCa45X0wQa6fuOpZrM5lGjcanXPnllxXNH6pTn1/m/7yaJSbv+O7Ymg8dAVt6f6Wfy
	bTaDLLNYsjGRf6lT0m/MGUsLjIfJH8mjAgK522uHle1UDz8LcWyCv9GGcplS0nfP5EJExAltRINzo
	559KURpSKhEvCcEG6EkJCXOKVEhh1HF/8QUJ+jAMhz8We6zWJ8UKFVmvqyELxtyrh+n7v4aMZoSpb
	zbBToIGKwNOQVgqeJzR0WJabFApK02ghl42zyjJ6ciFTq1R2nXF2o6jG0J5tRuff5bcvWFqPSewg1
	TGBaTskA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58678)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tkAQk-0008Gn-2z;
	Mon, 17 Feb 2025 23:21:39 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tkAQb-0006c4-02;
	Mon, 17 Feb 2025 23:21:29 +0000
Date: Mon, 17 Feb 2025 23:21:28 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
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
Message-ID: <Z7PEeGmNvlYD33rZ@shell.armlinux.org.uk>
References: <20250216123953.1252523-1-inochiama@gmail.com>
 <20250216123953.1252523-4-inochiama@gmail.com>
 <Z7IIht2Q-iXEFw7x@shell.armlinux.org.uk>
 <5e481b95-3cf8-4f71-a76b-939d96e1c4f3@lunn.ch>
 <js3z3ra7fyg4qwxbly24xqpnvsv76jyikbhk7aturqigewllbx@gvus6ub46vow>
 <24eecc48-9061-4575-9e3b-6ef35226407a@lunn.ch>
 <Z7NDakd7zpQ_345D@shell.armlinux.org.uk>
 <rsysy3p5ium5umzz34rtinppcu2b36klgjdtq5j4lm3mylbqbz@z44yeje5wgat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rsysy3p5ium5umzz34rtinppcu2b36klgjdtq5j4lm3mylbqbz@z44yeje5wgat>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Feb 18, 2025 at 06:50:24AM +0800, Inochi Amaoto wrote:
> On Mon, Feb 17, 2025 at 02:10:50PM +0000, Russell King (Oracle) wrote:
> > On Mon, Feb 17, 2025 at 02:25:33PM +0100, Andrew Lunn wrote:
> > > > I am not sure all whether devices has this clock, but it appears in
> > > > the databook. So I think it is possible to move this in the core so
> > > > any platform with these clock can reuse it.
> > > 
> > > Great
> > > 
> > > The next problem will be, has everybody called it the same thing in
> > > DT. Since there has been a lot of cut/paste, maybe they have, by
> > > accident.
> > 
> > Tegra186: "tx"
> > imx: "tx"
> > intel: "tx_clk"
> > rk: "clk_mac_speed"
> > s32: "tx"
> > starfive: "tx"
> > sti: "sti-ethclk"
> > 
> 
> The dwc-qos-eth also use clock name "tx", but set the clock with
> extra calibration logic.

Yep, that's what I meant by "Tegra186" above.

> > so 50% have settled on "tx" and the rest are doing their own thing, and
> > that horse has already bolted.
> > 
> 
> The "rx" clock in s32 also uses the same logic. I think the core also
> needs to take it, as this rx clock is also mentioned in the databook.

The "rx" clock on s32 seems to only be set to 125MHz, and the driver
seems to be limited to RGMII.

This seems weird as the receive clock is supposed to be supplied by the
PHY, and is recovered from the media (and thus will be 2.5, 25 or
125MHz as determined by the PHY.) So, I'm not sure that the s32 "rx"
clock is really the clk_rx_i clock supplied to the DWMAC core.

Certainly on stm32mp151, it states that ETH_RX_CLK in RGMII mode will
be 2.5, 25 or 125MHz provided by the PHY, and the clock tree indicates
that ETH_RX_CLK in RGMII mode will be routed directly to the clk_rx_i
input on the DWMAC(4) core.

> > I have some ideas on sorting this out, and I'm working on some patches
> > today.
> 
> Great, Could you cc me when you submit them? So I can take it and
> change my series.

Will do - I'm almost at that point, I have three other cleanup patches
I will be sending before hand, so I'll send those out and then this
series as RFC.

The only platform drivers I've left with a call to rgmii_clock() are
sti, imx (for imx93 only as that does extra fiddling after setting the
clock and I'm not sure if there's an ordering dependency there) and
the rk platforms.

Five platforms converted, three not, and hopefully your platform can
also use the helper as well!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


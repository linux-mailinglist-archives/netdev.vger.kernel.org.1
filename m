Return-Path: <netdev+bounces-196933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D57E4AD6FC6
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 14:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BB563A896B
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7161B2367B0;
	Thu, 12 Jun 2025 12:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2LIglMtb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285F0135A53;
	Thu, 12 Jun 2025 12:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749730227; cv=none; b=KPhKeQJv6YvmgSE+3+vsz/ziEAEfO/3HK4BKUxgmSB/CJJYQNlSp6OlTyNRg4Dv9PeTLQrN6tsCTNPDpqyeNZUIBpBzrv4omn/og1MmCcyNB2+QsyA7ZQYAP8t3B9vsp9Skv3e4i0N/eP4bJaS7RlqpmxEgcULypTIZDkrd/8gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749730227; c=relaxed/simple;
	bh=H9NJWiH2c9+Etg3LvjiRDue9bBHO+8cssyfivJ1glb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6fE9jimuYwsK/wt37WVrHP4/SFRMhACEf3VyvLdflnDFG/+SUNZrx7quJsHQZcGzGt9yEBUL5FiZ2X8AuZP5gXP+84TQhe0GsGRdTA4ngk2HHmKa1jM+88amzprSztjtbfxcZ+HWyOfGUkyzq7Wsp9kGZKzQICiYPPKWCUvSUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2LIglMtb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cmVDxvCmu0v4WQ1j07pv65fsLSYRgUeNwxzAs1gLv18=; b=2LIglMtbmSted5mvl3BE2Ec5mp
	huXz6cKG637jVKAjFuK1/mRcmoHROfssZe+Bl4pkoySko4kJABtTL9Xhel+OiyS6fPw8HEavC3/Bs
	yjh+PoVGNeuSGWdSurM7cDRCiSHr7tUNgzLZ2Zrdsq/4/5g3EReD5SLBB5liqSo3bMog=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uPgkw-00FXGb-Sh; Thu, 12 Jun 2025 14:10:06 +0200
Date: Thu, 12 Jun 2025 14:10:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-tegra@vger.kernel.org,
	Alexis Lothorrr <alexis.lothore@bootlin.com>
Subject: Re: [PATCH] net: stmmac: Fix PTP ref clock for Tegra234
Message-ID: <85e27a26-b115-49aa-8e23-963bff11f3f6@lunn.ch>
References: <20250612062032.293275-1-jonathanh@nvidia.com>
 <aEqyrWDPykceDM2x@a5393a930297>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEqyrWDPykceDM2x@a5393a930297>

On Thu, Jun 12, 2025 at 10:57:49AM +0000, Subbaraya Sundeep wrote:
> Hi,
> 
> On 2025-06-12 at 06:20:32, Jon Hunter (jonathanh@nvidia.com) wrote:
> > Since commit 030ce919e114 ("net: stmmac: make sure that ptp_rate is not
> > 0 before configuring timestamping") was added the following error is
> > observed on Tegra234:
> > 
> >  ERR KERN tegra-mgbe 6800000.ethernet eth0: Invalid PTP clock rate
> >  WARNING KERN tegra-mgbe 6800000.ethernet eth0: PTP init failed
> > 
> > It turns out that the Tegra234 device-tree binding defines the PTP ref
> > clock name as 'ptp-ref' and not 'ptp_ref' and the above commit now
> > exposes this and that the PTP clock is not configured correctly.
> > 
> > Ideally, we would rename the PTP ref clock for Tegra234 to fix this but
> > this will break backward compatibility with existing device-tree blobs.
> > Therefore, fix this by using the name 'ptp-ref' for devices that are
> > compatible with 'nvidia,tegra234-mgbe'.

> AFAIU for Tegra234 device from the beginning, entry in dts is ptp-ref.
> Since driver is looking for ptp_ref it is getting 0 hence the crash
> and after the commit 030ce919e114 result is Invalid error instead of crash.
> For me PTP is not working for Tegra234 from day 1 so why to bother about
> backward compatibility and instead fix dts.
> Please help me understand it has been years I worked on dts.

Please could you expand on that, because when i look at the code....


  	/* Fall-back to main clock in case of no PTP ref is passed */
 	plat->clk_ptp_ref = devm_clk_get(&pdev->dev, "ptp_ref");
  	if (IS_ERR(plat->clk_ptp_ref)) {
  		plat->clk_ptp_rate = clk_get_rate(plat->stmmac_clk);
  		plat->clk_ptp_ref = NULL;

if the ptp_ref does not exist, it falls back to stmmac_clk. Why would
that cause a crash?

While i agree if this never worked, we can ignore backwards
compatibility and just fix the DT, but i would like a fuller
explanation why the fallback is not sufficient to prevent a crash.

	Andrew



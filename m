Return-Path: <netdev+bounces-196950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FC2AD70AD
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 14:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FFAC3A78D1
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E71F19007D;
	Thu, 12 Jun 2025 12:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NTn8e+6g"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87502F4306;
	Thu, 12 Jun 2025 12:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749732328; cv=none; b=qirKPD2rQlspTAFQ9xMzaPrkn/C2aM1O7896mmMOrTBIXonA3KYn39sVIcWRwgRUwmRTq9UuOpzxq+8sYOhnvrKvJGZRqRqF34H6472XCnEx4LVt2XseBsqcgPYllHZjCe77cqJbVvaBU9MkgNxXrSl7Gl5QctUKdqIhVTSmjn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749732328; c=relaxed/simple;
	bh=8MKRQTb/7JzqiplCl8iXB7PfHb6PwfHGnuzaemLIaj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4gOe0wEdjeVr5yaJo5f8RaCLx8hDS4wrZFYCCE4xG4AZ1RQ51z+H13aqgmPW80bgbW1pbyNc+vtyC9UPKVSF3hNESa5mWZQBF8d+cYxyjrk2/HZBrVgvhDTGE4zfuGfKZy476KLOe0uBDY5Dqms8jW2maSILhBjX0QZIqelaR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NTn8e+6g; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=23ZG+xJSw4YpAjmPdytqobZOImtcUHEUQlR+e/rQiqI=; b=NTn8e+6gKdA3pIbp0py+2v72Mi
	jTjyRpKf6fLT7hpmfyodEh7uknxaaSBFccw61FIxbUPhz5+05UVGkAbKoa1uQSYbW6UgkBo85/L0G
	/9F7l5826yfE8XQr3N0hpst+Fk8xhcwYnifPsU5AelPsi2sImXP76Bh/wrAOgikqSthw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uPhIv-00FXUq-UD; Thu, 12 Jun 2025 14:45:13 +0200
Date: Thu, 12 Jun 2025 14:45:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Subbaraya Sundeep <sbhatta@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-tegra@vger.kernel.org,
	Alexis Lothorrr <alexis.lothore@bootlin.com>
Subject: Re: [PATCH] net: stmmac: Fix PTP ref clock for Tegra234
Message-ID: <353f4fd1-5081-48f4-84fd-ff58f2ba1698@lunn.ch>
References: <20250612062032.293275-1-jonathanh@nvidia.com>
 <aEqyrWDPykceDM2x@a5393a930297>
 <85e27a26-b115-49aa-8e23-963bff11f3f6@lunn.ch>
 <e720596d-6fbb-40a4-9567-e8d05755cf6f@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e720596d-6fbb-40a4-9567-e8d05755cf6f@nvidia.com>

On Thu, Jun 12, 2025 at 01:26:55PM +0100, Jon Hunter wrote:
> 
> On 12/06/2025 13:10, Andrew Lunn wrote:
> > On Thu, Jun 12, 2025 at 10:57:49AM +0000, Subbaraya Sundeep wrote:
> > > Hi,
> > > 
> > > On 2025-06-12 at 06:20:32, Jon Hunter (jonathanh@nvidia.com) wrote:
> > > > Since commit 030ce919e114 ("net: stmmac: make sure that ptp_rate is not
> > > > 0 before configuring timestamping") was added the following error is
> > > > observed on Tegra234:
> > > > 
> > > >   ERR KERN tegra-mgbe 6800000.ethernet eth0: Invalid PTP clock rate
> > > >   WARNING KERN tegra-mgbe 6800000.ethernet eth0: PTP init failed
> > > > 
> > > > It turns out that the Tegra234 device-tree binding defines the PTP ref
> > > > clock name as 'ptp-ref' and not 'ptp_ref' and the above commit now
> > > > exposes this and that the PTP clock is not configured correctly.
> > > > 
> > > > Ideally, we would rename the PTP ref clock for Tegra234 to fix this but
> > > > this will break backward compatibility with existing device-tree blobs.
> > > > Therefore, fix this by using the name 'ptp-ref' for devices that are
> > > > compatible with 'nvidia,tegra234-mgbe'.
> > 
> > > AFAIU for Tegra234 device from the beginning, entry in dts is ptp-ref.
> > > Since driver is looking for ptp_ref it is getting 0 hence the crash
> > > and after the commit 030ce919e114 result is Invalid error instead of crash.
> > > For me PTP is not working for Tegra234 from day 1 so why to bother about
> > > backward compatibility and instead fix dts.
> > > Please help me understand it has been years I worked on dts.
> > 
> > Please could you expand on that, because when i look at the code....
> > 
> > 
> >    	/* Fall-back to main clock in case of no PTP ref is passed */
> >   	plat->clk_ptp_ref = devm_clk_get(&pdev->dev, "ptp_ref");
> >    	if (IS_ERR(plat->clk_ptp_ref)) {
> >    		plat->clk_ptp_rate = clk_get_rate(plat->stmmac_clk);
> >    		plat->clk_ptp_ref = NULL;
> > 
> > if the ptp_ref does not exist, it falls back to stmmac_clk. Why would
> > that cause a crash?
> >  > While i agree if this never worked, we can ignore backwards
> > compatibility and just fix the DT, but i would like a fuller
> > explanation why the fallback is not sufficient to prevent a crash.
> 
> The problem is that in the 'ptp-ref' clock name is also defined in the
> 'mgbe_clks' array in dwmac-tegra.c driver. All of these clocks are requested
> and enabled using the clk_bulk_xxx APIs and so I don't see how we can simply
> fix this now without breaking support for older device-trees.

So you can definitively say, PTP does actually work? You have ptp4l
running with older kernels and DT blob, and it has sync to a grand
master?

	Andrew


Return-Path: <netdev+bounces-146041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC9C9D1CD0
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 01:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42485B20C3E
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 00:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614801CA84;
	Tue, 19 Nov 2024 00:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gdJAWpZk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7502E571;
	Tue, 19 Nov 2024 00:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731977452; cv=none; b=pPVIjDKYRETkR8UUdXWjOqpqHT3zSiApYc8He3yUm7K3bE+N6ucrz2GpkxGA1cL/wFoivfth6za5dAVjetFbUzodAmcrq4AHRHc0EEU7TjAkwczFBCjj9tNPw/rCygYV5FDPd5ZyonOzKFpkCtzympxWMMgew9eOyqSNgYhpDhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731977452; c=relaxed/simple;
	bh=oKvwEHGtm66d7BtQ1RrEnikv3MNsf9JdLDKGDfa9S8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzTKAQF3GaMPV5NQ/Aj0DZmXQlGW3WmsqbF3e5WkBC17amFPV/HelUy0gro4Acd2THWp4Kd/rdhKRHdzf1sPM065eWJ8cxv6qouoOdgegdU3pTBI8bBry0d+/AuyDVFwBUWXvFDstesYViaYwOzJZ6JLTXTvlFPW/AhVMrZfTtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gdJAWpZk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/zdxN2vOlsEF33q9U+oiEdloUgcORSZgWWNMJG2WpeU=; b=gdJAWpZktRAlIE8dOIH3n2I7AI
	Hb84rSn0XKZd3SBkyAz4px0n7Ue0Z6EvSKneVjlhDoHp5BiQTiyJIpNk18dfGtwFKxHDBjkpPDQuG
	tW0kuUzTUGD02z+HiUBGReDEioYavOGrcsrVmOE2wGImuWefDqqAiZhsPG0vfGWj36MY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tDCRe-00Diud-Hx; Tue, 19 Nov 2024 01:50:18 +0100
Date: Tue, 19 Nov 2024 01:50:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Parker Newman <parker@finest.io>
Cc: Paolo Abeni <pabeni@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v1 1/1] net: stmmac: dwmac-tegra: Read iommu stream id
 from device tree
Message-ID: <984a8471-7e49-4549-9d8a-48e1a29950f6@lunn.ch>
References: <cover.1731685185.git.pnewman@connecttech.com>
 <f2a14edb5761d372ec939ccbea4fb8dfd1fdab91.1731685185.git.pnewman@connecttech.com>
 <ed2ec1c2-65c7-4768-99f1-987e5fa39a54@redhat.com>
 <20241115135940.5f898781.parker@finest.io>
 <bb52bdc1-df2e-493d-a58f-df3143715150@lunn.ch>
 <20241118084400.35f4697a.parker@finest.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118084400.35f4697a.parker@finest.io>

> This is not a new dt property, the "iommus" property is an existing property
> that is parsed by the Nvidia implementation of the arm-smmu driver.
> 
> Here is a snippet from the device tree:
> 
> smmu_niso0: iommu@12000000 {
>         compatible = "nvidia,tegra234-smmu", "nvidia,smmu-500";
> ...
> }
> 
> /* MGBE0 */
> ethernet@6800000 {
> 	compatible = "nvidia,tegra234-mgbe";
> ...
> 	iommus = <&smmu_niso0 TEGRA234_SID_MGBE>;
> ...
> }
> 
> /* MGBE1 */
> ethernet@6900000 {
> 	compatible = "nvidia,tegra234-mgbe";
> ...
> 	iommus = <&smmu_niso0 TEGRA234_SID_MGBE_VF1>;
> ...
> }

What i was meaning does the nvidia,tegra234-mgbe binding allow iommus?
I just checked, yes it does.

> If the iommus property is missing completely from the MGBE's device tree node it
> causes secure read/write errors which spam the kernel log and can cause crashes.
> 
> I can add the fallback in V2 with a warning if that is preferred.

The fact it crashed makes me think it is optional. Any existing users
must work, otherwise it would crash, and then be debugged. I guess you
are pushing the usage further, and so have come across this condition.

Is the iommus a SoC property, or a board property? If it is a SoC
property, could you review all the SoC .dtsi files and fix up any
which are missing the property?

Adding a warning is O.K, but ideally the missing property should be
added first.

The merge window is open now, so patches will need to wait two weeks.

	Andrew


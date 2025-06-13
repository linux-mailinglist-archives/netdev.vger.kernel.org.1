Return-Path: <netdev+bounces-197501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9852CAD8D5F
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 15:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3B51189FE66
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 13:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA4218DB2A;
	Fri, 13 Jun 2025 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="222hSjZA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065DB7263F;
	Fri, 13 Jun 2025 13:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749822117; cv=none; b=ZLwVf5OmuZGLBGXZyAzCLs/WBzG7mEzkYzrDEEdtXFaC+GR3vjM+N3mgt+BV5NwPVD+kGpBscoBSEhJ7enV5OsMzKSQ8sjriJ4C01/t3VoDjzHR0FQVBbNundvFeWngMEeCFyZ53LFzo9tQ07B1SMnSL6Hqy7UtqvP6fQYmlHlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749822117; c=relaxed/simple;
	bh=0nIyZ4MyeDdeiSp51SkAsGuluPdWk/x8w7SsHD1HA3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfHoZSgIEVZ4Mw+9A4wqZvmdCRd1ohOOAxEsZkiXmDTzLR5EVkTaEfhEfIlA/gLdSndPvuzeazBglXO6z59u5vQxnCWgepUq3fr0HrZUJqkTqOaZpA5akqmvcV+ttFNARHrwbiVyD/bFb8sle6MYw9sl5zvnffWbp1D08+pNTCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=222hSjZA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=J/1VT1Crk7ORRo4wf/zc9vgitXeT8UirNNabBH7Vvzo=; b=222hSjZA/oyZs4ilTUB7c2JN2w
	8cX5Yxn2Zp9N+h782WqqlOhuZmVrdeD6Jmahj7RgXZzZVEgh/bFc5TkHDymHdekvT0VbQRrWeGfER
	aOFyJaSQ5EZ2T3y6r00r+OxLBpFyCptDVqXVbKC4fMbkvhOSaR8v28FkxBWPtHQTuqDs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uQ4MP-00FiS1-4i; Fri, 13 Jun 2025 15:22:21 +0200
Date: Fri, 13 Jun 2025 15:22:21 +0200
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
Message-ID: <5a3e1026-740a-4829-bfd2-ce4c4525d2a0@lunn.ch>
References: <20250612062032.293275-1-jonathanh@nvidia.com>
 <aEqyrWDPykceDM2x@a5393a930297>
 <85e27a26-b115-49aa-8e23-963bff11f3f6@lunn.ch>
 <e720596d-6fbb-40a4-9567-e8d05755cf6f@nvidia.com>
 <353f4fd1-5081-48f4-84fd-ff58f2ba1698@lunn.ch>
 <9544a718-1c1a-4c6b-96ae-d777400305a7@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9544a718-1c1a-4c6b-96ae-d777400305a7@nvidia.com>

> > So you can definitively say, PTP does actually work? You have ptp4l
> > running with older kernels and DT blob, and it has sync to a grand
> > master?
> 
> So no I can't say that and I have not done any testing with PTP to be clear.
> However, the problem I see, is that because the driver defines the name as
> 'ptp-ref', if we were to update both the device-tree and the driver now to
> use the expected name 'ptp_ref', then and older device-tree will no longer
> work with the new driver regardless of the PTP because the
> devm_clk_bulk_get() in tegra_mgbe_probe() will fail.
> 
> I guess we could check to see if 'ptp-ref' or 'ptp_ref' is present during
> the tegra_mgbe_probe() and then update the mgbe_clks array as necessary.

Lets just consider for the moment, that it never worked.

If we change the device tree to the expected 'ptp_ref', some devices
actually start working. None regress, because none ever worked. We can
also get the DT change added to stable, so older devices start
working. We keep the code nice and clean, no special case.

Now, lets consider the case some devices do actually work. How are
they working? Must it be the fallback? The ptp-ref clock is actually
turned on, and if the ptp-ref clock and the main clock tick at the
same rate, ptp would work. I _guess_, if the main clock and the
ptp-ref clock tick at different rates, you get something from the ptp
hardware, but it probably does not get sync with a grand master, or if
it does, the jitter is high etc. So in effect it is still broken.

Can somebody with the datasheet actually determine where ptp-ref clock
comes from? Is it just a gated main clock? Is it from a pin?

If it does actually work, can we cause a regression by renaming the
clock in DT? I _guess_ so, if the DT also has the clock wrong. So it
is a fixed-clock, and that fixed clock has the wrong frequency set. It
is not used at the moment, so being wrong does not matter. But when we
start using it, things break. Is this possible? I don't know, i've not
looked at the DT.

Before we decide how to fix this, we need a proper understanding of
what is actually broken/works.

	Andrew


Return-Path: <netdev+bounces-156041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A4FA04BCE
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 22:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1274D7A2C17
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 21:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DDD1F76C5;
	Tue,  7 Jan 2025 21:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GT/V/j4l"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1481F669F;
	Tue,  7 Jan 2025 21:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736285583; cv=none; b=LjMSKZsT6xrAyTmDV2jBvOlYAJnOPzttV4DJ1GrpIcbuJvZ6LsKWEZl4gw7bcCbmdeKB6hGw397rcj82D6dJsJ08VMDpkivlTNKcvyJSzeUie2DdgstCJznsaLWD8pvEBzDIBw82NBkVLCNiBKmoyJOYCsBI1X62zGUpoL37rqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736285583; c=relaxed/simple;
	bh=PqqJW0k2n4WHWgkLtzct3KY5SNbkK5iZ2MfSApT70QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tvf4AQ3c5y3CwNGgDZPPKpBV1NJx0ORsvpVLawTgC+0ASdEacZfORD/SxVjcInlbBPt8O6FKqn+qYFLpGOk/mZxNp0xmS/0xMT84EYW/GoGI97flxd+MXts8TWNp0VxzQ8mIA6DoASlBHs6EHHE0+C9jdeNUYgYDhCmzXeHCt1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GT/V/j4l; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AhgWcoCLvDuU3iXlGfJqFb1GHe5S3rXm2SyYEs46NbI=; b=GT/V/j4l6WT6038x7aBKU7JGfM
	9aXDu9/lPGQ/a3YXqbkeMZRNDQL6JwcpnrqMizfFH1X36dGhwT3ZTtzOJsRf7ENOuK8MsNnfSKKrI
	aZVX8P0AdodR6SNeoPLY5RRal3J3LTeNjLfDkWeZq3iQYGokwtgT2rzRn6dLA/umFkD4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tVHBg-002MWV-PE; Tue, 07 Jan 2025 22:32:32 +0100
Date: Tue, 7 Jan 2025 22:32:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Parker Newman <parker@finest.io>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH net v2 1/1] net: stmmac: dwmac-tegra: Read iommu stream
 id from device tree
Message-ID: <cafc3656-fcd0-4217-81dc-f3fa0cefce10@lunn.ch>
References: <6fb97f32cf4accb4f7cf92846f6b60064ba0a3bd.1736284360.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fb97f32cf4accb4f7cf92846f6b60064ba0a3bd.1736284360.git.pnewman@connecttech.com>

On Tue, Jan 07, 2025 at 04:24:59PM -0500, Parker Newman wrote:
> From: Parker Newman <pnewman@connecttech.com>
> 
> Nvidia's Tegra MGBE controllers require the IOMMU "Stream ID" (SID) to be
> written to the MGBE_WRAP_AXI_ASID0_CTRL register.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


Return-Path: <netdev+bounces-129530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 767D8984529
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 13:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3972D285434
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 11:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E0C1A707C;
	Tue, 24 Sep 2024 11:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tg/SgI+I"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC2219F417;
	Tue, 24 Sep 2024 11:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727178620; cv=none; b=jKSkQfb5AVzR8ke0LaxYW/pDlo+RUeu8wGYt3XPRiB/HJJRMf7sm3oOS5B4Ti1NewrNYoUVixDMddoaY6XLOrwYfeGWDrsC3pjtWffXSCsTNJjK1zoxNcvpyttrrOWURRWt/ynr6Rs1uQa2PSnSVxU+HZ2t4myiRZVGQimJcNjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727178620; c=relaxed/simple;
	bh=sKGgcjMXqAOrfy3dc3fW6EZuhcrF2BE7ibEcA+Zd9r4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2y17/ck2U0/rod1huPvfH+W/yI598rqxfJylfQbAc8G4MytqHvK1cTJZktYjuCcL2U9VkE5ZddPgQrCd9BItUjuiykwbweVW/EIcDJt+9bnjNFYNbcTaVFtbIMcOXzz0yGxM9/PMIeeigDTWoyn+WEo00Hsasr8qlH0MOsqxqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tg/SgI+I; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=TGgqC7BlQKpaoFE9lFpMvcM1xzGjol6wiHaVuiyG0pc=; b=tg
	/SgI+IZN7nmrWgnYCK8liOxV5r/V5iXdDvXUh5knPc3F6BDUoQS5KnmfhWuNFSCTPlMDBWAqHwaSf
	0OUQICgu/JLwbAgbXiPB8tigFL5RVZIaeiNdZsU4NuOwcLZzMsR18aOuqEEnR2n9fSGnFORikEduj
	M7seFL4D3ELUfWU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1st43C-008CLh-C7; Tue, 24 Sep 2024 13:49:50 +0200
Date: Tue, 24 Sep 2024 13:49:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, horms@kernel.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Ong Boon Leong <boon.leong.ong@intel.com>,
	Wong Vee Khee <vee.khee.wong@intel.com>,
	Chuah Kim Tatt <kim.tatt.chuah@intel.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-imx@nxp.com, Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v3 net] net: stmmac: dwmac4: extend timeout for VLAN Tag
 register busy bit check
Message-ID: <d1c3503f-2d0f-4479-b75c-43c6c9782a2d@lunn.ch>
References: <20240923202602.506066-1-shenwei.wang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240923202602.506066-1-shenwei.wang@nxp.com>

On Mon, Sep 23, 2024 at 03:26:02PM -0500, Shenwei Wang wrote:
> Increase the timeout for checking the busy bit of the VLAN Tag register
> from 10µs to 500ms. This change is necessary to accommodate scenarios
> where Energy Efficient Ethernet (EEE) is enabled.
> 
> Overnight testing revealed that when EEE is active, the busy bit can
> remain set for up to approximately 300ms. The new 500ms timeout provides
> a safety margin.
> 
> Fixes: ed64639bc1e0 ("net: stmmac: Add support for VLAN Rx filtering")
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

Since you are respinning

Your Signed-off-by: should come last.

	Andrew


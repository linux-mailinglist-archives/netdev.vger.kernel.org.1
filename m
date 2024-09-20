Return-Path: <netdev+bounces-129122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD74F97D9B1
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 20:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 362B4281EC1
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 18:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92402183CAB;
	Fri, 20 Sep 2024 18:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="edG+lfwz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D958D183CBC;
	Fri, 20 Sep 2024 18:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726858774; cv=none; b=YIbqH7B1E2Q5QfyJCUE+yEA0kg3ufX9iw7ON6TdRsyggs/wSNfRuT7QxC+76DQ+zX3WYV/XxJbgjzLlWbyGGETkjikGNeJRrmM+KQ1kuv1n9qEDnE0KRfd29En5ZgsoEiZotSTJp2mEPbFv4uRIKXGYALGGkupDFuANVkTwkfmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726858774; c=relaxed/simple;
	bh=FIiUXDDhE9zbd68gJIezJAsCePp3nL6OLLP9FiSOdIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWKtYRr1JZby7P+5OaXX4CaiXhs4fBJgyvPs3WWKHVnvRtMjE1S0s8gh+swmEuwQDMv0/7sxARc08nK5qzR2ArjZzBbf6PvqnFB/2mQ0W1nVWabEbiGWe3EEQVDsev29f5pa1gQUQQ8d9jk1A8cSVdjB2prlx0uNhFrCQYBNIVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=edG+lfwz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aq3hCAqKsqk4dMRfVd5WIszunX0ClwtWKv8KPQdJx30=; b=edG+lfwzgYaBb2yEM992evL1tr
	Wdk1FraHVV6RM+/McKATu7lVruBDrXhDGkg5dzShuC85MDM3moW+gljXi8Cz9ggXTmqM8ANIDIpQF
	On2LkcfkWtMaeazkF23S1loKBPNa2dZY1sHVZa1ThGO4UD+PArpLZKgYNeJkQuhAcduY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sriqE-007wdS-2z; Fri, 20 Sep 2024 20:58:54 +0200
Date: Fri, 20 Sep 2024 20:58:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	"horms@kernel.org" <horms@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Ong Boon Leong <boon.leong.ong@intel.com>,
	Wong Vee Khee <vee.khee.wong@intel.com>,
	Chuah Kim Tatt <kim.tatt.chuah@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v2 net] net: stmmac: dwmac4: extend timeout for VLAN Tag
 register busy bit check
Message-ID: <e2ca8af5-dfca-4d3e-998c-b90d302ea61b@lunn.ch>
References: <20240918193452.417115-1-shenwei.wang@nxp.com>
 <2ca9a20c-59a9-4b95-bfe1-5729e2361d70@lunn.ch>
 <PAXPR04MB91856DCDAB12C39631542E33896C2@PAXPR04MB9185.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB91856DCDAB12C39631542E33896C2@PAXPR04MB9185.eurprd04.prod.outlook.com>

> > Could there be other registers which suffer from the same problem?
> > 
> 
> So far I think it only impact the VLAN status register because those bits are driven by another clock instead of CSR clock.
> Based on current observations, it appears that this issue primarily affects the VLAN status register. The reason for this 
> is that the bits in the VLAN status register are driven by a clock source distinct from the CSR clock.

Thanks for the explanation.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


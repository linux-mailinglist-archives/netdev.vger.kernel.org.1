Return-Path: <netdev+bounces-51916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D7A7FCADB
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 00:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9EF11C20CBF
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 23:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F83558AC2;
	Tue, 28 Nov 2023 23:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NQzUHNNU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852EB19B2;
	Tue, 28 Nov 2023 15:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lFBU8IhjZL/WEnPoZ4ruJNwwW8kAAIaljT/PQim0kSI=; b=NQzUHNNU2uQcmDwAFa9P8JXdwa
	KNs/FBr7pBpV7mPRdpVrUqxZCBMEyFoOseyV8MTcUfSUhveQNlolMDdvVLSvC8bBzEDReKfzyD/0j
	Hu0XLDi+Ya19v1nH1zbhS3I0Qtqxkz7nXdL2x5xZEqdENrxvAEB79yCS74JHy16q+anU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r87Y1-001VRR-9G; Wed, 29 Nov 2023 00:31:21 +0100
Date: Wed, 29 Nov 2023 00:31:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: alexandre.torgue@foss.st.com, tali.perry1@gmail.com,
	edumazet@google.com, krzysztof.kozlowski+dt@linaro.org,
	linux-stm32@st-md-mailman.stormreply.com, benjaminfair@google.com,
	openbmc@lists.ozlabs.org, joabreu@synopsys.com, joel@jms.id.au,
	devicetree@vger.kernel.org, j.neuschaefer@gmx.net,
	robh+dt@kernel.org, peppe.cavallaro@st.com,
	linux-arm-kernel@lists.infradead.org, avifishman70@gmail.com,
	venture@google.com, linux-kernel@vger.kernel.org,
	mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
	davem@davemloft.net
Subject: Re: [PATCH v1 2/2] net: stmmac: Add NPCM support
Message-ID: <a551aefa-777d-4fd3-b1a5-086dc3e62646@lunn.ch>
References: <20231121151733.2015384-1-tmaimon77@gmail.com>
 <20231121151733.2015384-3-tmaimon77@gmail.com>
 <6aeb28f5-04c2-4723-9da2-d168025c307c@lunn.ch>
 <CAP6Zq1j0kyrg+uxkXH-HYqHz0Z4NwWRUGzprius=BPC9+WfKFQ@mail.gmail.com>
 <9ad42fef-b210-496a-aafc-eb2a7416c4df@lunn.ch>
 <CAP6Zq1jw9uLP_FQGR8=p3Y2NTP6XcNtzkJQ0dm3+xVNE1SpsVg@mail.gmail.com>
 <CAP6Zq1ijfMSPjk1vPwDM2B+r_vAH3DShhSu_jr8xJyUkTQY89w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP6Zq1ijfMSPjk1vPwDM2B+r_vAH3DShhSu_jr8xJyUkTQY89w@mail.gmail.com>

On Mon, Nov 27, 2023 at 05:19:15PM +0200, Tomer Maimon wrote:
> Hi Andrew,
> 
> I took a look at the xpcs driver and the stmmac driver and it doesn't
> cover NPCM use.
> 
> in the NPCM case the stmmac ID=0x37 therefore the driver is linked to DWMAC1000
> https://elixir.bootlin.com/linux/v6.7-rc2/source/drivers/net/ethernet/stmicro/stmmac/hwif.c#L139
> 
> to enable the xpcs, the stmmac should support xgmac or gmac4 and in
> the NPCM is support only gmac.
> https://elixir.bootlin.com/linux/v6.7-rc2/source/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c#L555
> https://elixir.bootlin.com/linux/v6.7-rc2/source/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c#L573
> 
> and the most important thing is that the XPCS is handled through an
> indirect register access and not through MDIO. the MDIO is connected
> to the external PHY and not to the XPCS.

What really matters here is, is the PCS hardware block you have an
XPCS? We don't want two drivers for the same block of hardware. 

MDIO vs indirect register access can be solved with a bit of
layering. That is not a reason to write a second driver.

	Andrew


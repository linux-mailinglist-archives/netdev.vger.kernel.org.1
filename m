Return-Path: <netdev+bounces-96727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C67B08C7645
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 14:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8144228638C
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 12:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAF914AD3E;
	Thu, 16 May 2024 12:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DufbBNmQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16F814600D;
	Thu, 16 May 2024 12:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715862198; cv=none; b=tp+cnm3192ucJPFswa19hISD5GGo4rKTXBIYkSIMbed0u8PfDMEDpdmEeH2SV4o43z3O17TCn3BVLRKpyVettqq1b7EuJ1aNwQtFrich6MYWAOSikqz1uDdaAptMsB7L/2vMyltgICtdwfReYP7VOg17ZCCIYVVB+nZHZIxf2yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715862198; c=relaxed/simple;
	bh=qzak7sMWjW1eI0tpMtEBkZV5nI1gneKQVu4D3TQXJXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/bzgSa2F+3XxrFZpNHcM1fAzQHpeWiMf0XlPvc4ZBYnVf85vUSzhYtdP1AUEaySMXQmqEmVbdsVRGIp4vkCBfr210mqBeSM02Z5i6aiEmzYny1LoTiKyolcilBFBS4Tdft55ZHFSdp/eSche+YNFcNljZclIbi83l+aQdTI4pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DufbBNmQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=17qpjYbzklDpeN+YSOUwARueA/UNvwjrGY4gKlNC5dE=; b=DufbBNmQt2ByDUKFL2nLJEOyCO
	EKpvCZHk2g5cL5wbPaYrf/2rZZTZgXORzFBLNLT6Wy2E6Yk0zVSaQdFvQhwRFunVK9ugicqHe/WQN
	p92zW0tIEAVVBiOSlA99e7ZNEJotdLU9Uk/WZT3v3Ax+B/UXcpxqzndaPTiRf/RoOvkA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s7a8M-00FVje-Td; Thu, 16 May 2024 14:22:54 +0200
Date: Thu, 16 May 2024 14:22:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexandre TORGUE <alexandre.torgue@foss.st.com>
Cc: Marek Vasut <marex@denx.de>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/11] ARM: dts: stm32: add ethernet1 and ethernet2
 for STM32MP135F-DK board
Message-ID: <4b17d7e4-c135-4d91-8565-9a8b2c6341d2@lunn.ch>
References: <20240426125707.585269-1-christophe.roullier@foss.st.com>
 <20240426125707.585269-11-christophe.roullier@foss.st.com>
 <43024130-dcd6-4175-b958-4401edfb5fd8@denx.de>
 <8bf3be27-3222-422d-bfff-ff67271981d8@foss.st.com>
 <9c1d80eb-03e7-4d39-b516-cbcae0d50e4a@denx.de>
 <5544e11b-25a8-4465-a7cc-f1e9b1d0f0cc@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5544e11b-25a8-4465-a7cc-f1e9b1d0f0cc@foss.st.com>

> > I suspect it might make sense to add this WoL part separately from the
> > actual ethernet DT nodes, so ethernet could land and the WoL
> > functionality can be added when it is ready ?
> 
> If at the end we want to have this Wol from PHY then I agree we need to
> wait. We could push a WoL from MAC for this node before optee driver patches
> merge but not sure it makes sens.

In general, it is better if the PHY does WoL, since the MAC can then
be powered down. MAC WoL should only be used when the PHY does not
support the requested WoL configuration, but the MAC can. And
sometimes you need to spread it over both the PHY and the MAC.

	Andrew


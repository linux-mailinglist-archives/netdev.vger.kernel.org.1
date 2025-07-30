Return-Path: <netdev+bounces-211012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2BFB162C2
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 16:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8061AA1B2E
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 14:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6615263F4E;
	Wed, 30 Jul 2025 14:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cWTN2jpR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B7C86347;
	Wed, 30 Jul 2025 14:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753885683; cv=none; b=Cfjl4N2HAXdaZ8WFFS+3mbvsAo9Tj4y5sWcRv7CDf37fDhwSLDTR2Q5GVzbR30Y0zL0yyPAHH83zGC1rSyXs8ubWMuhoQEsfPjw1a+liwOXY9ueVavwP2VOTg3GHKXE2RLcNbD+Uwg17Z9en3cuOy6PnL0H6f0g/GzoE5bLme1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753885683; c=relaxed/simple;
	bh=DinYEeBOt6c9tCP6gCMhoCD1UZtBO8dFhn/bQEbO0ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqIjnVozAasj1oSOb3f96ppnYXcgtMphfs0RrmF5eJmcAPk3qqfyHE6JkhxQfqqjUCKViMaXHT2tKkncXSCxQKlRtSiB88ZwAf5nYN3m4jWi6hkHmH7Z16Q+oMcd1dE5mwMmBoJeWyzEsjHZN7GP6sV2SCw4bOWU0aizs8fhm/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cWTN2jpR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yDtUj+yMRtsh81u+6h/bP9XngquZjb4gJP2fgdLgwz4=; b=cWTN2jpR/c4Qfere2e1vXXQ+XT
	5zCKpBMC8cEPGm+bXGXDKy879Hlv+AK+02omzvvOatPgBOHzef5M9GBazczm4aRGAXkeqRtA2+Ngh
	/3osGea119Sj0dRJG2P5a14uNtjUdiOLYjhctoNMiKBCQ8tQ2/abndrl/WZKr939CzoY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uh7ma-003HoP-KT; Wed, 30 Jul 2025 16:27:52 +0200
Date: Wed, 30 Jul 2025 16:27:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Michael Walle <mwalle@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Roger Quadros <rogerq@kernel.org>, Simon Horman <horms@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com
Subject: Re: [PATCH net-next] Revert "net: ethernet: ti: am65-cpsw: fixup PHY
 mode for fixed RGMII TX delay"
Message-ID: <84588371-ddae-453e-8de9-2527c5e15740@lunn.ch>
References: <20250728064938.275304-1-mwalle@kernel.org>
 <57823bd1-265c-4d01-92d9-9019a2635301@lunn.ch>
 <DBOD5ICCVSL1.23R4QZPSFPVSM@kernel.org>
 <d9b845498712e2372967e40e9e7b49ddb1f864c1.camel@ew.tq-group.com>
 <DBOEPHG2V5WY.Q47MW1V5ZJZE@kernel.org>
 <2269f445fb233a55e63460351ab983cf3a6a2ed6.camel@ew.tq-group.com>
 <88972e3aa99d7b9f4dd1967fbb445892829a9b47.camel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88972e3aa99d7b9f4dd1967fbb445892829a9b47.camel@ew.tq-group.com>

> I can confirm that the undocumented/reserved bit switches the MAC-side TX delay
> on and off on the J722S/AM67A.

Thanks.

> I have not checked if there is anything wrong with the undelayed
> mode that might explain why TI doesn't want to support it, but
> traffic appears to flow through the interface without issue if I
> disable the MAC-side and enable the PHY-side delay.

I cannot say this is true for TI, but i've often had vendors say that
they want the MAC to do the delay so you can use a PHY which does not
implement delays. However, every single RGMII PHY driver in Linux
supports all four RGMII modes. So it is a bit of a pointless argument.

And MAC vendors want to make full use of the hardware they have, so
naturally want to do the delay in the MAC because they can.

TI is a bit unusual in this, in that they force the delay on. So that
adds a little bit of weight towards maybe there being a design issue
with it turned off.

	Andrew


Return-Path: <netdev+bounces-150465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCFA9EA503
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 03:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0BA169C26
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 02:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FF41A0BE1;
	Tue, 10 Dec 2024 02:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsDLJ3K/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC7E19E980;
	Tue, 10 Dec 2024 02:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733796893; cv=none; b=TTWjg9yTs92qAPy2KDemj4fVRKpGtCPXEGV6bRZQFnO1hmbfZ1NmvB7Y1jWGN/gL7rIXZ2UYA/LJyUmkZ+m6zfp3VZw2luZ6i8cqiBeJkShrwekWiVtaMS9Dx4/CDhesPDTWsSDpv4xEIL/JgnRPaQvh5L3/sxhGA99PO9ZhWQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733796893; c=relaxed/simple;
	bh=iEeMLAK3s8QRc68c6ccD44gGmo9G8TQpEajkRE0lQ2U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AGQu1Cyos4n03r6PTBoFL+3hB22Ra/Cxak0GdLx1zGskV7pJdaq98mqIIlg0zfvGcMsfTOx+HhtGhWFDrWVY9ZMX1wEN6TOgnttlxzh1Nbmf03pcG3Cd5ZVsbJQcaS0ni4+aWaVNjI7WRkeenTLqt25jjDWfnZYQlB36kGhZ29s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsDLJ3K/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79896C4CED1;
	Tue, 10 Dec 2024 02:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733796892;
	bh=iEeMLAK3s8QRc68c6ccD44gGmo9G8TQpEajkRE0lQ2U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XsDLJ3K/QUSm+36BJd30KiYIC+fj/XSMRabmqa+stzHqNNHE4SLoAfmYw6Dub8jeL
	 iYFumsF7Hhp4ZZJ6aKu0+2j+ZJlKwkmGZZywUL/ZZGSmVTnYtkuCeba1erTfQgzTls
	 xib6BeGelBB7yUIlUzGR6zG7Hmj6KNbPWFXfpRY5vG6y3t05/tNHLRk4R7hMC1tyBS
	 2iunX+GRXaFsDLQGiElWPMYl+lJ1vY52FzyYrjz9HNsiZmcD8lz74B7YTI0fkO+s/h
	 dIuhkc3Dk0KeyheyCnIXDIgWJhBzva3MkVwo122PW1Mfkvf1YF4ON2tn9mwBvYUuV3
	 2a2tRKIs0nDGA==
Date: Mon, 9 Dec 2024 18:14:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 florian.fainelli@broadcom.com, heiko.stuebner@cherry.de, fank.li@nxp.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v3 net] net: phy: micrel: Dynamically control external
 clock of KSZ PHY
Message-ID: <20241209181451.56790483@kernel.org>
In-Reply-To: <20241206012113.437029-1-wei.fang@nxp.com>
References: <20241206012113.437029-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Dec 2024 09:21:13 +0800 Wei Fang wrote:
> On the i.MX6ULL-14x14-EVK board, enet1_ref and enet2_ref are used as the
> clock sources for two external KSZ PHYs. However, after closing the two
> FEC ports, the clk_enable_count of the enet1_ref and enet2_ref clocks is
> not 0. The root cause is that since the commit 985329462723 ("net: phy:
> micrel: use devm_clk_get_optional_enabled for the rmii-ref clock"), the
> external clock of KSZ PHY has been enabled when the PHY driver probes,
> and it can only be disabled when the PHY driver is removed. This causes
> the clock to continue working when the system is suspended or the network
> port is down.
> 
> To solve this problem, the clock is enabled when phy_driver::resume() is
> called, and the clock is disabled when phy_driver::suspend() is called.
> Since phy_driver::resume() and phy_driver::suspend() are not called in
> pairs, an additional clk_enable flag is added. When phy_driver::suspend()
> is called, the clock is disabled only if clk_enable is true. Conversely,
> when phy_driver::resume() is called, the clock is enabled if clk_enable
> is false.

Sorry that nobody replied to you but yes, I believe the simpler fix you
proposed here:
https://lore.kernel.org/all/PAXPR04MB8510D36DDA1B9E98B2FB77B488362@PAXPR04MB8510.eurprd04.prod.outlook.com/
is better for net. In net-next we can try to keep the clock enabled
and/or try to fix the imbalance in resume calls that forces you to track
manually if the clock was enabled.


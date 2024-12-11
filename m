Return-Path: <netdev+bounces-150925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB5D9EC1D4
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 03:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5265B188A561
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 02:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791E01DF727;
	Wed, 11 Dec 2024 01:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WG1789Wz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA201DF721;
	Wed, 11 Dec 2024 01:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733882370; cv=none; b=QWUMV+XTF984aQkE6mS/gw1l/BPGFy6Nqs492vjsUVvK2K9BfUnt/aoqsHuUDucTuxQW2TW0FDYYwhnTCNY3ZpZELG+xAbL55KrCJwm7M3uRBS0l29yZTHT3/fozxOAyuUykL+r9CXNFiwhU4QXjfZ60QEZYxUD4L71fHibGJlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733882370; c=relaxed/simple;
	bh=zEazvVQelItOcABGIC78+sK4TYpwCtVbuqNNLAXsEQc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tCpxPccc/zOHbQnUohxSAcwY+QOxlr0OLhsQF6CIg2R98OwCcI8VBQzWo/IBb9J0kOvlO/TTEzx1Ay+RXmRWlwUEhcOuHn+4uvKiuA7pv4POlosqKvafuzcZOiylICj4Kgs6KgpW4JG+Ggnmpp6nlQ+WEwMZTO+s+DcpvbE+xzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WG1789Wz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33134C4CED6;
	Wed, 11 Dec 2024 01:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733882369;
	bh=zEazvVQelItOcABGIC78+sK4TYpwCtVbuqNNLAXsEQc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WG1789WzUIrT/CpBcevHJNOIBumrD1N6Qedrovy+G025hdAW+6EnIYdCcl6WNPWXr
	 rf6QcjjxYtDZD27rljp5BgkVDF13H4WF5weB07ZtroJQFBQHYR4DLq+QY6jvJkiUg+
	 JAC/Zb945iW1L3wz0RfR61iMWkomZLhzZjDLF5dtzjgLYPUOovWGZBC6F+/OjgldU2
	 R/kqEAk/RoFGc9lxa+n2mt1GUbo3yp0d6IT60Tb+PQ8xDevuSbsaHKxMIBnRh0L3nq
	 D+TO4pwuz7uDEg1FCcEvgrXHoGee7UYuAAAt1lVHtOlNrWQPSkFqlvD7ESAPTMgZEu
	 tcRetj1RhCpow==
Date: Tue, 10 Dec 2024 17:59:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>, "hkallweit1@gmail.com"
 <hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "florian.fainelli@broadcom.com" <florian.fainelli@broadcom.com>,
 "heiko.stuebner@cherry.de" <heiko.stuebner@cherry.de>, "fank.li@nxp.com"
 <fank.li@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH v3 net] net: phy: micrel: Dynamically control external
 clock of KSZ PHY
Message-ID: <20241210175928.39505f6c@kernel.org>
In-Reply-To: <PAXPR04MB8510008EBDA6EB1CF89246F8883E2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241206012113.437029-1-wei.fang@nxp.com>
	<20241209181451.56790483@kernel.org>
	<PAXPR04MB85104EC1BFE4075DF1A27B93883D2@PAXPR04MB8510.eurprd04.prod.outlook.com>
	<20241210164308.6af97d00@kernel.org>
	<PAXPR04MB8510008EBDA6EB1CF89246F8883E2@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Dec 2024 01:49:50 +0000 Wei Fang wrote:
> > I may be missing something but if you don't need to disable the generic
> > clock you can put the disable into the if () block for rmii-ref ?  
> 
> For my case, it's fine to disable rmii-ref because this clock source is always
> enabled in FEC driver. But the commit 99ac4cbcc2a5 ("net: phy: micrel: allow
> usage of generic ethernet-phy clock") was applied a year ago, so I raised a
> concern in V2 [1], if a new platform only enables rmii-ref in the PHY driver,
> disabling rmii-ref after getting the clock rate will cause problem, which will
> cause RMII to not work. I'm not sure if any platform actually does this, if so
> the following changes will be a more serious problem.

Put more of this explanation into the commit message and resend.
If it convinces Andrew we can apply.


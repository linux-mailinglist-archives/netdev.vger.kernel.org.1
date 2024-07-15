Return-Path: <netdev+bounces-111533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 252DC9317A1
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 17:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F35F1C217DE
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 15:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8112188CDC;
	Mon, 15 Jul 2024 15:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlNsUWJe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5231D699;
	Mon, 15 Jul 2024 15:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721057469; cv=none; b=OVZJ4xT58ZTcDvGKk9fkvv6IBrpvjjqnc6ft/fspeUitpgoIymloM1/InwJQJb93exQsrH+2H2HPdnD8OKBPoEq2g5dfs+2/ow7SyTaYodUbuJD+0Zq0Eug7qtYtyEVQSOMWAJr54L5aRRBws7TQ/Q7AgY07w6mb9zxTPqk419A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721057469; c=relaxed/simple;
	bh=qUbeTKUNfUxNwcUkEeWkqBBPsaKfmFCHj8LukVfb6AI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qj5Az4rxO73FUMCFoIRl5nMKm3Pbx/5lg0U2YEL/SEpK4DYCJOALvcoUU3LEjcTt3Dp8DeVWNnvmDVlxfoDzeEwuKH1tUtmxbimjHUoDsMdnEX0Lf8K40YWAmH7gXPJJbX7/r4SzcGcCv9lAJFDxh8TImM6x8RKtisiX71kJeHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlNsUWJe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1AAC32782;
	Mon, 15 Jul 2024 15:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721057469;
	bh=qUbeTKUNfUxNwcUkEeWkqBBPsaKfmFCHj8LukVfb6AI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HlNsUWJerWJ77g1T/M1mXQN1JTb9XfsZpVd13GmCSglpnrHp9Xo70lQLM1zihR8Tc
	 iGbbOg76G5TV9yrMh+kYsfPVj72+4fLbOFBgyEiTyz+nA7QzbJS8LMPl0S2a66EzOz
	 TTvIM2eMQ3t7RM1Dc7XSNTQKiMU4ZV3yUAUX3UkH79AE6Y4pIpoHUAFt7fJ2j4m2oD
	 TAw4R9J8wf64eJDZvrfPhmHV6GLLTE+E+35bRWTau0ZjuEkUqqQG0hqsxBfFhvLHp8
	 PZD6WcOhUikHd8VMNj3P+1+0aIwmQAzPgEavkFuVFO56o15RjKDIbvBWNF9DUazplG
	 mKLhOAD4LS58w==
Date: Mon, 15 Jul 2024 08:31:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Marek =?UTF-8?B?QmVow7pu?=
 <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Nathan Chancellor <nathan@kernel.org>, Antoine Tenart
 <atenart@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Dan Carpenter
 <dan.carpenter@linaro.org>, Romain Gantois <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next v17 00/14] Introduce PHY listing and
 link_topology tracking
Message-ID: <20240715083106.479093a6@kernel.org>
In-Reply-To: <20240709063039.2909536-1-maxime.chevallier@bootlin.com>
References: <20240709063039.2909536-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Jul 2024 08:30:23 +0200 Maxime Chevallier wrote:
> This is V17 of the phy_link_topology series, aiming at improving support
> for multiple PHYs being attached to the same MAC.
> 
> V17 is mostly a rebase of V16 on net-next, as the addition of new
> features in the PSE-PD command raised a conflict on the ethtool netlink
> spec, and patch 10 was updated :
> 
> 	("net: ethtool: pse-pd: Target the command to the requested PHY")
> 
> The new code was updated to make use of the new helpers to retrieve the
> PHY from the ethnl request, and an error message was also updated to
> better reflect the fact that we don't only rely on the attached PHY for
> configuration.

I lack the confidence to take this during the merge window, without
Russell's acks. So Deferred, sorry :(


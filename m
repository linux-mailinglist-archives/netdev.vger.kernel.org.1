Return-Path: <netdev+bounces-207660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F15B08159
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 02:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCB9C1C264C4
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 00:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB5A3B1AB;
	Thu, 17 Jul 2025 00:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mq7A5PVc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52752E3701;
	Thu, 17 Jul 2025 00:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752711644; cv=none; b=evUdxu98/qQtoa2G9lneGYJARbCIoxuz6BgoZG3jayp9zGBKPWDhKxs0c8ESfhpaU1dI7urEJuZTHrywmG2ZP3Ni+QSWekhkCsYyAbdIJznFgttB71W+AqgTDanV98Ftm0SOZsj3QgqPtteg+NrbKMRBpzCiMxc97VEOIYAzSEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752711644; c=relaxed/simple;
	bh=nWFxoukiglDbiZqiAdldrvFgESPD+QmMK1CjQSzvmz0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XQVyqTFDrgLCobn77VY+z63ty54myP82O5CQLthHw8CDqChr0iq6Zsh2ydp7LRPFItLLgZNPd0e52/2dVBANuFwgNwUptkHCpcmODnXCczWywGxEEbfgMI3Ek8Xk9PujSyYVfvV4Dj2oTvQ5EDZBWaWdGTk1NPEZ2T+EVoXGKnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mq7A5PVc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB04C4CEE7;
	Thu, 17 Jul 2025 00:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752711644;
	bh=nWFxoukiglDbiZqiAdldrvFgESPD+QmMK1CjQSzvmz0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mq7A5PVcQTZotimT/FVBTU6+PvR1SEyfM6CiDgwtXB9wibeU/qWxucBDGVhTNTpFA
	 Mi3vUw/VKGleuUsSRa5QV2cpfKcqyR2dMlOgj0BTvYp/kxWaaIBd3d8If55qPKx0Ad
	 PV3gQLhyFjq3m/QAHNQVx7yjlJQK5PsvG7oDCmSt8fdfsyZWySKweo7XnEwZGCCRI/
	 3EtBNRkcbDfm1plT1NmjappFAGMrz6/++UhWEmEe9RpHey0QZ/DTqXvCBRvfWt2OPv
	 Y22nQG+ZaJqqX4tC2c5Y1z3mdvtL5NDeiVlR+PAzTsleCBcemreBoGzAI0SN1UzZJD
	 Muh+frUxwcozw==
Date: Wed, 16 Jul 2025 17:20:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Heiner Kallweit
 <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, Russell King
 <linux@armlinux.org.uk>, netdev@vger.kernel.org, Andre Edich
 <andre.edich@microchip.com>, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH net v4 0/3] net: phy: smsc: use IRQ + relaxed polling to
 fix missed link-up
Message-ID: <20250716172043.195dd86c@kernel.org>
In-Reply-To: <20250714095240.2807202-1-o.rempel@pengutronix.de>
References: <20250714095240.2807202-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Jul 2025 11:52:37 +0200 Oleksij Rempel wrote:
> This series makes the SMSC LAN8700 (as used in LAN9512 and similar USB
> adapters) reliable again in configurations where it is forced to 10 Mb/s
> and the link partner still advertises autonegotiation.
> 
> In this scenario, the PHY may miss the final link-up interrupt, causing
> the network interface to remain down even though a valid link is
> present.

Could we get a PHY maintainer ack on these (especially patch 2)?


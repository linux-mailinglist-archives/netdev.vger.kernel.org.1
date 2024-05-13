Return-Path: <netdev+bounces-95869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D768C3B6B
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 08:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58C531C20F09
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 06:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3776F51016;
	Mon, 13 May 2024 06:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tTaxfkDW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C40614265;
	Mon, 13 May 2024 06:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715582200; cv=none; b=hTKuiHRp2hCxT7SB31HgZU1jo4J1/TyEJZ2nsQCAMmBSeRMUFeOBcDZNKhIOrij/OVMNehr0UsariJ4vwH63mbjTGaRWHLNH+4S80VbNcCK6XCJM60x5abTLUgq34Mduv7LL4g8nDLFh342SZ8M0j6L3J56bfr2UtOCICBPrWKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715582200; c=relaxed/simple;
	bh=TbOvTyRXh66VompTcjMDwvYNM69rIo59zf33ZAIoC3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIjdeOH36cMpBWmk5u8UJpYaZKQvnK4kpyEC36gaC/VEk3e2S6LW847kMBk23vM3CP0nufMU8GR/PlowD3OOzvh7S1c7NH8nF6RGIT4OFJFjQfGrFiLoOCj69P9HG9cZqBDSY3uUY+JGfkD59lh5qmznWTZhBfEU3nFo6XufPJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tTaxfkDW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A8EC113CC;
	Mon, 13 May 2024 06:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715582199;
	bh=TbOvTyRXh66VompTcjMDwvYNM69rIo59zf33ZAIoC3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tTaxfkDWkpFLHTwZC04kCtJkxNIENzZTmI5PYUKwkt1HRtZwwVBTYbFXCKWXcUsFE
	 lu793V3wsQpVnnxhiyy4l3w5M3BManAyomm+xMwTAyNaim5rV90eGNn3mMiMpD8jsA
	 UqfnBD4pUsnBApFDVrZ72bs8rFERvxkxKcnlGxScNmrpZTFJO+rliEnufnsu6y1QsJ
	 jdnX14KSi0SrFalr1dugXSDJs67FWBNS2YuhD+3FL8+CiNOMhnAtTO7NBueFaBX95U
	 Nzb7vZnq+/kTgT5lFs+P3Qv+b3a98AU3Lm85P6JH8vioKPHQYsZ7kJnumUdy3NbnRA
	 DYkUpN6BPUoVA==
Date: Sun, 12 May 2024 23:36:36 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
	Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH net-next 0/2] Fix phy_link_topology initialization
Message-ID: <20240513063636.GA652533@thelio-3990X>
References: <20240507102822.2023826-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507102822.2023826-1-maxime.chevallier@bootlin.com>

Hi Maxime,

On Tue, May 07, 2024 at 12:28:19PM +0200, Maxime Chevallier wrote:
> Nathan and Heiner reported issues that occur when phylib and phy drivers
> built as modules expect the phy_link_topology to be initialized, due to
> wrong use of IS_REACHABLE.
> 
> This small fixup series addresses that by moving the initialization code
> into net/core/dev.c, but at the same time implementing lazy
> initialization to only allocate the topology upon the first PHY
> insertion.
> 
> This needed some refactoring, namely pass the netdevice itself as a
> parameter for phy_link_topology helpers.
> 
> Thanks Heiner for the help on untangling this, and Nathan for the
> report.

Are you able to prioritize getting this series merged? This has been a
problem in -next for over a month now and the merge window is now open.
I would hate to see this regress in mainline, as my main system may be
affected by it (not sure, I got a new test machine that got bit by it in
addition to the other two I noticed it on).

Cheers,
Nathan


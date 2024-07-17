Return-Path: <netdev+bounces-111891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A496933F9B
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 17:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCA76B21FEB
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 15:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC86A181BB1;
	Wed, 17 Jul 2024 15:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCw3AXjB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F18181BA6;
	Wed, 17 Jul 2024 15:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721230020; cv=none; b=ssYU9MWmVIXdiAN6qcTrJ5yp3blR51sv1YJuxdcCswXSYTEmdoflmGm2uLoIaIutBuYji2DOaCw/k1PK9ZUSH4HS2zEEmHT8EZtrJLZ7pDTJzQ0uFRhtSXhqOKCKHtmPkCy/lF5NXLr7fFAVATpl+cnWJxPVO4wbyo+njOXIYw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721230020; c=relaxed/simple;
	bh=o6ksGgCZ4nXFQWa+KewLnEYozl+Ia2t1l93hAy52I+U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O4eBK9T2dyIAZYwScdBjxQE9r9lJ1My2b2abAnqmJ4t/F8lsaPfR3h58Ph4txhlQTarInxsToVLEMSi0z4s9IFBW4JH55mxidRTRRtkmyycNlVQpGO10UHiouhPUPXgm4222vRX6ll4TqVkNWoIAKqGH531IU/auVqFhiCDeKrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCw3AXjB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59587C32782;
	Wed, 17 Jul 2024 15:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721230020;
	bh=o6ksGgCZ4nXFQWa+KewLnEYozl+Ia2t1l93hAy52I+U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eCw3AXjBH9ZKHo9zYkGygBQGDA2e1faiOs4ZG905SSfYCbRWMZb4k37mRpR5pFFYO
	 hWVkTDSQIsN2cQFJCM7L56dd0D64lX9Yr/doEjbGs4iFVhAVVsqSRU2wjy/war0JES
	 FQ0Fv+67aOqCg97ypyLxgs/4Zhl/LyFkK67vQVXuG/UfDpOWmckcHIbyKGuv60C5TR
	 3eTD6ZJEErAcEmqlHq3ecMzRR+QLxTNTkKINLMNBru9HMVXGu+sq0tmgKSg7U7QRxi
	 ErISQ+VIekaZJ5whNZf9mlaZuHMNNZwIdFZOQ6CWvJpRWvu9wyr/WWfW0casS/3qWA
	 NUNfdCPJ5Dy/Q==
Date: Wed, 17 Jul 2024 08:26:58 -0700
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
Message-ID: <20240717082658.247939de@kernel.org>
In-Reply-To: <20240716101626.3d54a95d@fedora-2.home>
References: <20240709063039.2909536-1-maxime.chevallier@bootlin.com>
	<20240715083106.479093a6@kernel.org>
	<20240716101626.3d54a95d@fedora-2.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jul 2024 10:16:26 +0200 Maxime Chevallier wrote:
> > I lack the confidence to take this during the merge window, without
> > Russell's acks. So Deferred, sorry :(  
> 
> Understood. Is there anything I can make next time to make that series
> more digestable and easy to review ? I didn't want to split the netlink
> part from the core part, as just the phy_link_topology alone doesn't
> make much sense for now, but it that makes the lives of reviewers
> easier I could submit these separately.

TBH I can only review this from coding and netlink perspective, and 
it looks solid. Folk who actually know PHYs and SFPs may have more
meaningful feedback :(


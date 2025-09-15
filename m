Return-Path: <netdev+bounces-223116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76759B58004
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 17:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA1E62A2372
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180A333CEAE;
	Mon, 15 Sep 2025 15:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PosOuLmB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD86132A83C;
	Mon, 15 Sep 2025 15:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948843; cv=none; b=OMDDWLT4E/dXdR6yo0aOfKHCbAWLXIAp/j72fSTDGiyTbV4vGEVQUKgb3PV6BujvcZ6bPy/kolLJAn58qyPFx+sEtN6mK+vfIpcSnsL9zq5XCyRo3Abz6khWxJDl9IO6fNyJLC9rdpcAKHtAD98tKfzTPpSjLOqQhnhUrmUJvjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948843; c=relaxed/simple;
	bh=qbPCTs3eX0+uh0P69NXEX4fUArvMON49EQT3NNuN9Po=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UvAfdbICGbrwr2hZtP/N+iPaj3vEazeMjU4ZBUk/GARnNQXVDKG7JtxAhhE0Qo4qhpwrZliS4SBRaB7FDPuyzSN/TZCIH+dpzyBBuhrjAYjMrma/p2/tRF/NmitlG9a6vmaL7P94GPM9q9uhpGjD8kDys5x+8QT1Mo+Fnm8KtEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PosOuLmB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9860AC4CEF1;
	Mon, 15 Sep 2025 15:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757948842;
	bh=qbPCTs3eX0+uh0P69NXEX4fUArvMON49EQT3NNuN9Po=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PosOuLmBuBUvNGtRRuDafZCiLLmnY4Ha+lvfSFcYCfq/PT4DlFm/BXvrK7d3YP+85
	 yDkcejz0njoq8bXgBAsdMaX0VbPyyCbGPHm8jR1AMyk2zK3hfwuQCddKIk3C1+4MTk
	 d8R0uwHTqdYvOK2GygOmrXPMXwrcwfFzL2TbWuxjLanm5d81qBQ8vRMommbs/QCTvu
	 fGWjbylpWUUnnuTVbTxgYIpLCRZkHd9Zbaf3ncj5/kB0Ux9FCBxLALSJRvWllP7dup
	 GdvRDTgBX5Zw1AJkTf+ff/Fq3j73vXU31uCA8psG6oECY+Fz2wgBqMETnwpnrtShil
	 UaaTKa0Xet9Wg==
Date: Mon, 15 Sep 2025 08:07:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Kory Maincent
 <kory.maincent@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Nishanth Menon <nm@ti.com>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
 linux-doc@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>, Roan van Dijk
 <roan@protonic.nl>
Subject: Re: [PATCH net-next v5 2/5] ethtool: netlink: add
 ETHTOOL_MSG_MSE_GET and wire up PHY MSE access
Message-ID: <20250915080720.17646515@kernel.org>
In-Reply-To: <aMfczCuRf0bm2GgQ@pengutronix.de>
References: <20250908124610.2937939-1-o.rempel@pengutronix.de>
	<20250908124610.2937939-3-o.rempel@pengutronix.de>
	<20250911193440.1db7c6b4@kernel.org>
	<aMPw7kUddvGPJCzx@pengutronix.de>
	<20250912170053.24348da3@kernel.org>
	<aMfczCuRf0bm2GgQ@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Sep 2025 11:30:52 +0200 Oleksij Rempel wrote:
> On Fri, Sep 12, 2025 at 05:00:53PM -0700, Jakub Kicinski wrote:
> > On Fri, 12 Sep 2025 12:07:42 +0200 Oleksij Rempel wrote:  
> > > I would prefer to keep u64 for refresh-rate-ps and num-symbols.
> > > 
> > > My reasoning comes from comparing the design decisions of today's industrial
> > > hardware to the projected needs of upcoming standards like 800 Gbit/s. This
> > > analysis shows that future PHYs will require values that exceed the limits of a
> > > u32.  
> > 
> > but u64 may or may not also have some alignment expectations, which uint
> > explicitly excludes  
> 
> just to confirm - if we declare an attribute as type: uint in the YAML
> spec, the kernel side can still use nla_put_u64() to send a 64-bit
> value, correct? My understanding is that uint is a flexible integer
> type, so userspace decoders will accept both 4-byte and 8-byte encodings
> transparently.

Theoretically, and yes. But why would you use put_u64 and not
put_uint() ?


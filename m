Return-Path: <netdev+bounces-119252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF40C954FA0
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 19:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93316283492
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 17:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA93A1BF33D;
	Fri, 16 Aug 2024 17:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXo60pj2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846CF558A5;
	Fri, 16 Aug 2024 17:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723828279; cv=none; b=Ls00My870cipzvNseoUzH3y5O4HO27cc5vtyn8k9md0MaREE/NnwpDvOAlDL0NOX9P7TVLXuhqRnI7zxkhl1mCtqvUcd8aqXmhRq+/PEuJ2AFzWZb9GfACRBF//I6a6plT62fAC2PsU8cE0Xoo1xu7l3OiiUhxecJfbca1xYt50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723828279; c=relaxed/simple;
	bh=7ZCSSBpkj+vLMJqv+wX282n8HXJDJam7GZ7W+EmumiE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hUyO1iNo5uin1iD8Y7sg2vScIwKDpNnXX2Xne1BS+HoYoXtoQJrdqgbe/P0jpSMGJ/Jk8cGjxnSPfyQccRvG8Fa/MgeLJ7c5WFsFNvIXy5CS50cZKaq8MAl94AnuDmF8hGO5x8W1XHuQM6YWKXLRoxOAwks5vpO2q3NMVxQFQbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXo60pj2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A09C32782;
	Fri, 16 Aug 2024 17:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723828279;
	bh=7ZCSSBpkj+vLMJqv+wX282n8HXJDJam7GZ7W+EmumiE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iXo60pj2VY3Gva9TUtIWFPPu4lOEkpfd7KP17pIT/WKi7qEtQGuF41WJLLhFQCI38
	 JKkmP5NPY+xWbm2ptxxy/f8uQobX277WngPGA5EqxxwUGNreLrLMR7QXD75H+9sdf6
	 PE1oD3eppCqHAuqfzTg2IlmfR2UU6zqZpb0C2dv/xdTgyhwaZPjG5Luc8FX1ZX0wPE
	 UFVqjNYkhvJyBmdm/fTGwBeJQZKIAbczOsYpZRthmiOGtLyrR3Yk3G/K1N9GPB2sOa
	 zrWqlrgx5WhTMGTOMOW5w/jugI4Ds5STmNv49tLExhiUvNp3xxi1NgHQeHYS81NfgF
	 PFAhUIwJqP8rg==
Date: Fri, 16 Aug 2024 10:11:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Russell King <linux@armlinux.org.uk>, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Marek =?UTF-8?B?QmVow7pu?=
 <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Nathan Chancellor <nathan@kernel.org>, Antoine Tenart
 <atenart@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Dan Carpenter
 <dan.carpenter@linaro.org>, Romain Gantois <romain.gantois@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v17 00/14] Introduce PHY listing and
 link_topology tracking
Message-ID: <20240816101116.0e8e4d6d@kernel.org>
In-Reply-To: <a1231b3a-cd4d-4e74-9266-95350f880449@csgroup.eu>
References: <20240709063039.2909536-1-maxime.chevallier@bootlin.com>
	<20240715083106.479093a6@kernel.org>
	<20240716101626.3d54a95d@fedora-2.home>
	<20240717082658.247939de@kernel.org>
	<a1231b3a-cd4d-4e74-9266-95350f880449@csgroup.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Aug 2024 19:02:20 +0200 Christophe Leroy wrote:
> So it would be great if the series could be merged for v6.12, and I 
> guess the earliest it is merged into net-next the more time it spends in 
> linux-next before the merge window. Any chance to get it merged anytime 
> soon even without a formal feedback from Russell ? We are really looking 
> forward to getting that series merged and step forward with all the work 
> that depends on it and is awaiting.

Give Russell a few days to respond, then repost. 
Russell said his ability to review code right now may be limited.
I'm not sure whether he would like us to wait for him or just do
our best. In the absence of an opinion - we'll do the latter.


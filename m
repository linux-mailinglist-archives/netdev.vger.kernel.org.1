Return-Path: <netdev+bounces-255011-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sVAtKcAsfGk3LAIAu9opvQ
	(envelope-from <netdev+bounces-255011-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 05:00:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE1DB6F54
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 04:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E4A9300E70C
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C170E332EC8;
	Fri, 30 Jan 2026 03:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWfiVdSf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2182F5A01;
	Fri, 30 Jan 2026 03:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769745597; cv=none; b=Kn2c6DKtb8jLMkZOpF5pGUsRiff8+E2Yg5+rdZ9IMkdX78tiFTgEuig19d+2VylK/FkHkYdB+2KWlYuoDqpwzfYz7wkAOm+hQRwNBo6irwdjV/qyCpcYHiTrZewnvi7sincOGlvv/kcNHNup5U3oFE2LzNLjXWSjo6rEklmHE7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769745597; c=relaxed/simple;
	bh=s4giSpz+yGIzjA/y15OzHt1xqHdiUNeUS25nMuu48ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ev1ke//hOiASVH3fGRrtlbv5kSEzDmffHUfe1T0wOVMh8VFO5v4Cygdx4X8LHPqDogaAy+ceOgfMXjz1z7UBG4RNLkDVI82GsMWhkY56NDF6nqHla0LD0w2W2/39H1POH+R8Av8bzvvSpe6jiJ6TRVlQ6tQRyOjKjjZJG2NHzHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWfiVdSf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCACC4CEF7;
	Fri, 30 Jan 2026 03:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769745596;
	bh=s4giSpz+yGIzjA/y15OzHt1xqHdiUNeUS25nMuu48ZA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pWfiVdSf0CJyECAgt9PTsk4vZzCA4t3CBE2S09bPTwddYy5Sw69cFPNq6D1p//aYv
	 g7/VcsaKTYZCYtmtJRpttSMxEf6Izw8s9Mnowwf7gd5T8JLQXRBOXa26j/EuQ4pMhG
	 R+RE9rso5Ojf1f9332943Et0IjAZDxGXU2RCrfhmUyLdorQrYcxn/3BeeQe9QHUOrz
	 BOYIkNet4gfv/98EYGsW0TaX6tcwN2qOX5NKEUhqksTDVLQmF4wk5F9hd2iCJzVtop
	 +cMWmR9gQbYfZzF3MkPYLERw2c/QhB+4gxExvGj8+X5fzS3njxCSAxLLxE+9bCE7oF
	 syxb8zmaH2H8Q==
Date: Thu, 29 Jan 2026 19:59:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Romain Gantois <romain.gantois@bootlin.com>, Daniel
 Golle <daniel@makrotopia.org>, Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Subject: Re: [PATCH net-next v2 00/12] net: phy_port: SFP modules
 representation and phy_port listing
Message-ID: <20260129195955.3bbff4fd@kernel.org>
In-Reply-To: <20260128204526.170927-1-maxime.chevallier@bootlin.com>
References: <20260128204526.170927-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255011-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,google.com,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,bootlin.com,csgroup.eu,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EAE1DB6F54
X-Rspamd-Action: no action

On Wed, 28 Jan 2026 21:45:13 +0100 Maxime Chevallier wrote:
> Here's V2 of the second phy_port series, this time bringing support for
> more phy_port use especially for SFP, as well as the beggining of a
> ethnl uAPI. That's a quick repost, but with the build issues and AI
> review, I think it's worth getting this version out there for review.
> 
> It builds on the recent addition of phy_port representation to enable
> listing the front-facing ports of an interface. For now, we don't control
> these ports, we merely list their presence and their capabilities.
> 
> As the most common use-case of multi-port interfaces is combo-ports that
> provide both RJ45 and SFP connectors on a single MAC, there's a lot of
> SFP stuff in this series.
> 
> This series is in 2 main parts. The first one aims at representing the
> SFP cages and modules using phy_port, as combo-ports with RJ45 + SFP are
> by far the most common cases for multi-connector setups.
> 
> The second part is the netlink interface to list those ports, now that
> most use-cases are covered.

I'll send out the AI code review. The one on patch 9 looks plausible,
not sure about the rest. LMK if none of them in fact make sense.


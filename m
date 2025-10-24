Return-Path: <netdev+bounces-232722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B00DFC08480
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 01:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F12EB4FDBDC
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 23:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CEF30CDA1;
	Fri, 24 Oct 2025 23:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbIaTNwA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD21835B130;
	Fri, 24 Oct 2025 23:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761347535; cv=none; b=Dl5iwrDDuCu+e0kKoe0Uh+PS53X87P53tjcHugr+tA/ASs0lQXrirMhbEKRWi1hnZKMpPyZslNOL5l5OH16gKVXPGeMxdnn/OfLQp5UUj58BFjTMYjR4+K40Ng3GZJUPFXesXPGya//ZER11aZINCv0HkIquX8xRxseTyWED/GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761347535; c=relaxed/simple;
	bh=28QxlZisbpaE6gknR+JP2xBGWi2De4mog++hUTM3srg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f01Wqaxb2ZMjYS+/sUxdUE+EujCmW9pHdQuFiByXO7nRBAkE6qZ0DF1HIs0kFR8qau+qzHSV8Y7Bw9ET0ZQlNnDtZwm/sIaa3/9BTOy+31HKdUi9ziVTRWF3kvdO+xvP5CeNze7oo08QSG1fD4w4IyZV5xKe9U4j2XoincwAwvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbIaTNwA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1CAC4CEFB;
	Fri, 24 Oct 2025 23:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761347534;
	bh=28QxlZisbpaE6gknR+JP2xBGWi2De4mog++hUTM3srg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PbIaTNwAEJO1lUwOPxFA2fp9a9UBYmcb8PVJ04Kbjj17+ZOYk+a0K0+V81F0JAaNX
	 weW8FwIMmRtJ4VpvelGbwy+RVdrWD9P0aaeQu2axwFCK68KG0n484zpvuNClQU6thh
	 Aa0mJqhJ8Znf6fyuyhtzQKcaGdpSZn0kYCYnR4kv+FsZa5KArP1VMNUSgHWbdMQ9D2
	 sN7nJR7ITxbFqYhqMxHtOrNJlpGPXcZv0AjkEQ8o4ochPwxqNYiXJ/J0NBdMg9hkrb
	 hFdC+ZLaEVX8zu2edZltlYZ1jLRTH1JkG/1epkhPrzxMvwYNhtg2akYHzdJ5yisR5b
	 sbsvdGTnaKCxw==
Date: Fri, 24 Oct 2025 16:12:13 -0700
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
Subject: Re: [PATCH net-next v7 2/5] ethtool: netlink: add
 ETHTOOL_MSG_MSE_GET and wire up PHY MSE access
Message-ID: <20251024161213.2ed58127@kernel.org>
In-Reply-To: <aPt8jAXU0l1f2zPG@pengutronix.de>
References: <20251020103147.2626645-1-o.rempel@pengutronix.de>
	<20251020103147.2626645-3-o.rempel@pengutronix.de>
	<20251023181343.30e883a4@kernel.org>
	<aPt8jAXU0l1f2zPG@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Oct 2025 15:18:04 +0200 Oleksij Rempel wrote:
> Hi Jakub,
> 
> On Thu, Oct 23, 2025 at 06:13:43PM -0700, Jakub Kicinski wrote:
> > On Mon, 20 Oct 2025 12:31:44 +0200 Oleksij Rempel wrote:  
> > > +      -
> > > +        name: supported-caps
> > > +        type: nest
> > > +        nested-attributes: bitset
> > > +        enum: phy-mse-capability  
> > 
> > This is read only, does it really have to be a bitset?  
> 
> It describes the capabilities of the driver/hardware. You can get always
> everything... Hm... I think we continue without capabilities for now and
> also remove the specific channel request.

That's not what I'm saying. I'm just saying that it could be a basic
uint with appropriate enum rather than bitset? At least with YNL its
much easier to deal with. The main advantage of bitset is that you
can modify individual bits, but that doesn't apply to read-only fields.

Sorry if I'm confused.


Return-Path: <netdev+bounces-181448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B09F5A8507D
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 02:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBB179A1931
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 00:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899474A33;
	Fri, 11 Apr 2025 00:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KX5fRREF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605E023A9;
	Fri, 11 Apr 2025 00:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744330917; cv=none; b=jii2RaMXKJBxrPUgYMtTm/fu1rGWGzUPASzwdTtJ2Ze3tUzVgeEoKSk45QK0jUMWqSl95JjX14MIlBB1jy0xeymLIIrXc4ipQxwMT85MTduIB/TrrCbHsPsIkEQ+EzSqHrtmgHtj8bbpg7GLKVkVm4E/WbDKfoF3CV+azup6XBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744330917; c=relaxed/simple;
	bh=xbce/LIafrkgsAwqwYafme3DNQiuM8+sIryv9oj7aj8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EoChEP7peiRW2bbZJWSj54xZgl4YbAZKuUWrJQIqfSSmjeoQRLRWQKYFgTfikaMcAso9g+MtlOMYQsFgHkXPY0FabM8BYyKVdVsqjHzIATciiGUJ++f6Hiv/pDF/yMKAHQqScrd1UmUASVR+6Ilw7a61ME5pbGZb7WFIwJ5A3GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KX5fRREF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00707C4CEDD;
	Fri, 11 Apr 2025 00:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744330916;
	bh=xbce/LIafrkgsAwqwYafme3DNQiuM8+sIryv9oj7aj8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KX5fRREFpGXczmVZ8OzVc0AIahz4FVzSSkMU0suQvvN45aCmItNWu5ZparPs11O89
	 qXhnuXXvyD8r8tVyZXwxeHSQWeBhHQapcy5gBTgU5c1sXwg+7xN64EkrXzN7AoZaHL
	 Y1uNkz4BWufU9hzKYqpkvgsNCZ/2eXD6PDGEo4/WzyniCKRbpfUeLWWi+i9KXTaERK
	 VOq7v2FHaWFKAB0RQu6xai+Z2QEtv/pnAX1jciLDyHuBPk67B4oeKZnMNV3+eJlGGn
	 fEFSNQIfcoNy1nthc4MGowfg3kYkLQnXlQrNWIqJMzQEB6wtSOhHv5PyAbvx1vuze3
	 k3gNWOfq+ebCQ==
Date: Thu, 10 Apr 2025 17:21:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Simon Horman <horms@kernel.org>, Romain Gantois
 <romain.gantois@bootlin.com>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>
Subject: Re: [PATCH net-next v5 1/4] net: ethtool: Introduce per-PHY DUMP
 operations
Message-ID: <20250410172155.3cd854d8@kernel.org>
In-Reply-To: <20250410123350.174105-2-maxime.chevallier@bootlin.com>
References: <20250410123350.174105-1-maxime.chevallier@bootlin.com>
	<20250410123350.174105-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Apr 2025 14:33:46 +0200 Maxime Chevallier wrote:
> ethnl commands that target a phy_device need a DUMP implementation that
> will fill the reply for every PHY behind a netdev. We therefore need to
> iterate over the dev->topo to list them.
> 
> When multiple PHYs are behind the same netdev, it's also useful to
> perform DUMP with a filter on a given netdev, to get the capability of
> every PHY.
> 
> Implement dedicated genl ->start(), ->dumpit() and ->done() operations
> for PHY-targetting command, allowing filtered dumps and using a dump
> context that keep track of the PHY iteration for multi-message dump.

Transient warnings here that the new functions are not used :(
Would it work to squash the 3rd and 4th patches in?
Not ideal but better than having a warning.
-- 
pw-bot: cr


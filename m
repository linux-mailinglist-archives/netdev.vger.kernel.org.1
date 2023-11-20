Return-Path: <netdev+bounces-49416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 086F77F1F66
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 22:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E191C21343
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 21:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D9B38FA5;
	Mon, 20 Nov 2023 21:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xhk8t6N3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A511A279;
	Mon, 20 Nov 2023 21:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FB0C433C8;
	Mon, 20 Nov 2023 21:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700516753;
	bh=wTllnXLudtUSjHaEEAUK+L8ZBRUeteK9UhJ3dFHB6P8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xhk8t6N3NQbIK326t8vzbsC+Lh1F7QrLoyQS5Ngt/uCzxNxN1JnMsa3RF5AMjo7xP
	 1pKL4LaoF4ivTbBnK5MnMyKKLk03xf7wmnEKFUD8DGnnFmxJn1eZeW27On+/qwCKtQ
	 zX6ux2sLm96LaMruFuqUAX1Jy99M6InH4ZT1n3ddfUCWg6mjZvUXxPHxe1iB9k/7aS
	 Ttp3zViQ4WOpzAmGOkaZ1mKvrVk9rIFuOjdZ5acoNbUBA3U4s1BPhBWt3/TrgIPCSn
	 NOWtkHeoIjZkNPv/E3rDBr1ug2f/aounyeTdaO5Fb7z1WvjfhWhapi177br/EGlHEQ
	 g8CzuXOpLfAEw==
Date: Mon, 20 Nov 2023 13:45:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Radu
 Pirea <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh
 <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v7 15/16] net: ethtool: ts: Let the active time
 stamping layer be selectable
Message-ID: <20231120134551.30d0306c@kernel.org>
In-Reply-To: <20231120195858.wpaymolv6ws4hntp@skbuf>
References: <20231118183433.30ca1d1a@kernel.org>
	<20231120104439.15bfdd09@kmaincent-XPS-13-7390>
	<20231120105255.cgbart5amkg4efaz@skbuf>
	<20231120121440.3274d44c@kmaincent-XPS-13-7390>
	<20231120120601.ondrhbkqpnaozl2q@skbuf>
	<20231120144929.3375317e@kmaincent-XPS-13-7390>
	<20231120142316.d2emoaqeej2pg4s3@skbuf>
	<20231120093723.4d88fb2a@kernel.org>
	<157c68b0-687e-4333-9d59-fad3f5032345@lunn.ch>
	<20231120105148.064dc4bd@kernel.org>
	<20231120195858.wpaymolv6ws4hntp@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Nov 2023 21:58:58 +0200 Vladimir Oltean wrote:
> I'm still waiting for you to fully clarify the "per socket vs global"
> aspect, but independently of that, at least I understand why this is a
> counter-argument to my proposal. I need to tune it a bit (ASSUMING that
> we want DMA timestamps to "look like" hwtimestamps, and not like their
> own thing, to user space), because the PHC index would no longer fully
> identify a hwtstamp provider, so we need something more.
> 
> I imagine both ETHTOOL_MSG_TSINFO_GET and ETHTOOL_MSG_TSINFO_SET to
> support a new (nest) nlattr called ETHTOOL_A_TSINFO_HWSTAMP_PROVIDER.
> 
> This would contain (u32) ETHTOOL_A_TSINFO_HWSTAMP_PROVIDER_PHC_INDEX
> and (u32) ETHTOOL_A_TSINFO_HWSTAMP_PROVIDER_QUALIFIER. It could be
> extensible in the future, but this is the baseline and forms the key.
> 
> The latter takes values from an:
> 
> enum ethtool_hwstamp_provider_qualifier {
> 	ETHTOOL_HWSTAMP_PROVIDER_QUALIFIER_MAC,
> 	ETHTOOL_HWSTAMP_PROVIDER_QUALIFIER_PHY,
> 	ETHTOOL_HWSTAMP_PROVIDER_QUALIFIER_DMA,
> };

Sounds reasonable. Having more attributes than just PHC index works.
Given the lack of distinction between MAC and PHY for integrated NICs
I'd lean towards ditching the "layers" completely and exposing 
an "approximate" vs "precise" boolean. Approximate being the DMA point
for NICs, but more generically a point that is separated from the wire
by buffering or other variable length delay. Precise == IEEE 1588
quality.


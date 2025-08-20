Return-Path: <netdev+bounces-215272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD5EB2DDD4
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 15:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0012C188730F
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 13:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEFB31CA53;
	Wed, 20 Aug 2025 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xzA8smJ+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787F32EE60F;
	Wed, 20 Aug 2025 13:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755696746; cv=none; b=d08AUTcqOKZDwBEb/sS3pW2uWmaIIX4F0E0VIybv+04x6vsALPCYX5ZcoEo4rkOaxbBA7MlMc+6pYyAZM2MuewO9m7hkgk3Q8kCbOlIip7BvfV+q08zJT0Wj5NMwcjpovzB6qIENQgUpC+mx6y+tGHcVSwf/JnXYJt+OGBW+Ytc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755696746; c=relaxed/simple;
	bh=AQDZK5sNxcUBX/haeT3KGURh6b7HjK+2cetyVxAe/Hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYxJh5vV9MIA0ExUKzv1ONlVi1hXWi1qAFLHZdX5TsEi+DQQuoMk7SNcTkI10RW/DkSXIhTTZXBG5s0/Z3TFytvV3YQD9TzWRWL6wB/IuMxEfjn3K/JNgdUX3SDLQTB+7DN4Ug4bzgJRCxsot4vUKcOkVTbYFr1oMPbXTlac50w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xzA8smJ+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0RRO3wyFRhXuAJmaiFOy0RmE2iclZC8o3kvn5ptp9kE=; b=xzA8smJ+fQf9ZwZ8aCpF099aeV
	2G/xJhYRNYxyrXg9IFUg9Pz/OPwMPDVyYalQSnt3pPkVW4VmZDUfHQiVhF8eUw3sCefe+qTQ1ns0R
	Tq45fWyY6pAhc3so57CjgHaSrMyAwsFX3aVhvYrFfKG9tDYbT0R/yldbYeo5O3f7oqtU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uoiv6-005KIx-DC; Wed, 20 Aug 2025 15:32:04 +0200
Date: Wed, 20 Aug 2025 15:32:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Nishanth Menon <nm@ti.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, linux-doc@vger.kernel.org,
	Michal Kubecek <mkubecek@suse.cz>, Roan van Dijk <roan@protonic.nl>
Subject: Re: [PATCH net-next v2 5/5] net: phy: dp83td510: add MSE interface
 support for 10BASE-T1L
Message-ID: <703ba750-99cd-4499-8171-1a17964af3e0@lunn.ch>
References: <20250815063509.743796-1-o.rempel@pengutronix.de>
 <20250815063509.743796-6-o.rempel@pengutronix.de>
 <1df-68a2e100-1-20bf1840@149731379>
 <aKLwdrqn-_9KqMaA@pengutronix.de>
 <94745663-b68c-4a4c-95d8-36933c305e34@lunn.ch>
 <aKW-3sF2g2QrKDpG@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKW-3sF2g2QrKDpG@pengutronix.de>

> So far I know, following T2/T4 PHYs support MSE:
> LAN8830, KSZ9131, LAN8831, LAN8840, LAN8841
> DP83826*, DP83640, DP83867*, DP83869HM

O.K, that is plenty of justification.

Thanks
	Andrew


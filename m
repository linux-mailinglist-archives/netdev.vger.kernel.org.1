Return-Path: <netdev+bounces-156331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB10A061C4
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 17:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D22A1638AD
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 16:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B52F1FE47F;
	Wed,  8 Jan 2025 16:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jyIuwa/3"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248EE19F489;
	Wed,  8 Jan 2025 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736353502; cv=none; b=Rz8auN0N5CAgK3Q39uX7SnPU0zCmxuVpfGdniUrBYoHripSTdDIzZJr6cKLxc3QgvOJ4Hn9dlgoN0NG6nvFmrirSTK9gIr4cCC0twQPRVsrYpTCgbVfvOYzcNgNnvVjP9h+LHvKimn0BJSv9RN1by+fqRRUHQeve02uakVUpaHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736353502; c=relaxed/simple;
	bh=kPcx6EqSyZVL/wllFQBgnGtYWem7gRt24tVGvP/oRJY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OPhtxlcumSZBrv/Jd5xozF4maZdeMxJ97x4ojAerPxVeCmgd+GGURSBNep0G3W5VmTEAgtiNN2DV3Tky9fS6JwtdnDTgeMqJx4y1aeMg/HhbHDtoQ+cseH5lU1nj2bMzijaJJRnfTLCaPuw2gKlBWuorRdiybYHtInhS6iJRZFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jyIuwa/3; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 154F6C000B;
	Wed,  8 Jan 2025 16:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736353498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ywtVfbBrJlMkzZ3DHOkUmnWcxehi+NF/Go9lQQuP9pg=;
	b=jyIuwa/3h8m9CFtJWbn4mMTWJLXgd1MWVSLOyRzcff31dtX/En5BFl0Wmjva0jB72akhHa
	uLrCvbm4tTH6eT6fcP3ZcVbKKwj8mLBk1YObhV5lSxKVwf9/XdlpznhViGJlLNQjReLfQ9
	EWDCv9r9WC7wiM0Qkx1VEeu5We083nQP+D6atw6Cryk8hstRoIH46k/8xm+6k4r9LQkMmO
	StU+DNPHLqjVkeycrGIKZ998H/GdISoc3CPPtz4w8EWj0dzxC73z65FX4sbBFlbrflv5wP
	fTwenF8/n04WtvEBjFlGebvEMMWfGuNcPMflSrAVmNO0IIHWIdY9zb60iG2M6Q==
Date: Wed, 8 Jan 2025 17:24:56 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Jonathan
 Corbet <corbet@lwn.net>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Simon Horman
 <horms@kernel.org>, Russell King <linux@armlinux.org.uk>,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/8] net: ethtool: plumb PHY stats to PHY
 drivers
Message-ID: <20250108172456.522517ff@fedora.home>
In-Reply-To: <95111e20-d08a-42e5-b8cc-801e34d15040@lunn.ch>
References: <20250106083301.1039850-1-o.rempel@pengutronix.de>
	<20250106083301.1039850-3-o.rempel@pengutronix.de>
	<20250107180216.5802e941@kernel.org>
	<Z35ApuS2S1heAqXe@pengutronix.de>
	<95111e20-d08a-42e5-b8cc-801e34d15040@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Andrew, Oleksij,

On Wed, 8 Jan 2025 17:03:25 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > On one side I need to address the request to handle phydev specific
> > thing withing the PHYlib framework. On other side, I can't do it without
> > openen a pandora box of build dependencies. It will be a new main-side-quest
> > to resolve build dependency of net/ethtool/ and PHYlib. The workaround is to
> > put this functions to the header.  
> 
> Yes, the code is like this because phylib can be a module, and when it
> is, you would end up with unresolved symbols if ethtool code is built
> in. There are circular dependence as well, if both ethtool and phylib
> are module. The inlines help solve this.
> 
> However, the number of these inline functions keeps growing. At some
> point, we might want a different solution. Maybe phylib needs to
> register a structure of ops with ethtool when it loads?

Isn't it already the case with the ethtool_phy_ops singleton ? Maybe we
can add wrap the get_phy_stats / get_link_ext_stats ops to the
ethtool_phy_ops ? My understanding was that this singleton served this
purpose.

Thanks,

Maxime



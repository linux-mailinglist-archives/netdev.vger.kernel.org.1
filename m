Return-Path: <netdev+bounces-101277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A5F8FDF31
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 08:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74E81F23262
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 06:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD8512B17C;
	Thu,  6 Jun 2024 06:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FIiZKxzz"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9153119D898;
	Thu,  6 Jun 2024 06:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717657068; cv=none; b=dJlji2RUwFxFn9WhlX1KkM3+WtK7ga+Kfge6xjetbAwgKWXdF4jVk6TLdLImvjWhDpSya9Kf/6mzpezc3QnfiSXpq9aC1c18Aqm2kBDen1ZVDJcUuAN/f7SC/eDIkNI4liA/bwyFj6hc3q1fSIbNURXPq1sck/cBHKXLz+wvnng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717657068; c=relaxed/simple;
	bh=AWAgYsMCFjyvMefBAsZ3RW/Wl8868HRUypW9j9t8DcI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i9ftJIY0dsyicuN8DW7amMIr+lWS0HlhcoCtoiJ4mWeumVS1XwvdENJ+q41uSrhzUqwO32x8MqzfbJio5ztoZxNoFP1m1SxAalX7D6n54A9b/z3NPKrvvza6MWlnr13ykovigIDcNVBvednHZaXlytnPnnt80+xnkjrmBNfTS7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FIiZKxzz; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 30F6260004;
	Thu,  6 Jun 2024 06:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717657058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jgXWC6wrNxd7gBlX7Te69IijPU34lb7hb+iH3eHJsXo=;
	b=FIiZKxzzXuNWsWWUYEG9s1CHkdsJ69grzzhE1fJ75F9v5Ys2AuTSJdmoZO8Y7ExIAi0H9x
	D7UkSWOFwA5rcZ7uWjBFfyGHig5jG7cQkHEgVF9D0HIx2rFvJwWbgMivF7E88KuUExUAjK
	NVMGD+56L+Kkf3V0kw9e4YOZsvxoM4Qb/5J5gGmRyZmWl7vhLykq8me+cy7ve4kOYVt94T
	g82by/PcFlITDibCU0R6X8ywwCLUckU9bhKGGLdTSMP2xPaUR8hVa1Bo1rsBF2jx8CSVwt
	VWWMzrjSUKAYq1FQv6cuM6KZOxq3j2Zfkpk/bNnAYHJnLOjDDDP5f4uz4LYtBw==
Date: Thu, 6 Jun 2024 08:57:34 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
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
 <atenart@kernel.org>
Subject: Re: [PATCH net-next v12 03/13] net: phy: add helpers to handle sfp
 phy connect/disconnect
Message-ID: <20240606085734.73334c68@fedora>
In-Reply-To: <20240605201025.764f0881@kernel.org>
References: <20240605124920.720690-1-maxime.chevallier@bootlin.com>
	<20240605124920.720690-4-maxime.chevallier@bootlin.com>
	<20240605201025.764f0881@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Jakub,

On Wed, 5 Jun 2024 20:10:25 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Wed,  5 Jun 2024 14:49:08 +0200 Maxime Chevallier wrote:
> > +/**
> > + * phy_sfp_connect_phy - Connect the SFP module's PHY to the upstream PHY
> > + * @upstream: pointer to the upstream phy device
> > + * @phy: pointer to the SFP module's phy device
> > + *
> > + * This helper allows keeping track of PHY devices on the link. It adds the
> > + * SFP module's phy to the phy namespace of the upstream phy
> > + */
> > +int phy_sfp_connect_phy(void *upstream, struct phy_device *phy)  
> 
> We run scripts/kernel-doc with -Wall now, it wants return values
> to be documented, too. 

OK, I'll address that and make sure to run this script on all the
patches in the series.

Thanks,

Maxime


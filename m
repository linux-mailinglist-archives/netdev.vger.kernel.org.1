Return-Path: <netdev+bounces-128038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA2397792C
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 09:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DEFD2835D7
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 07:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11B81B9831;
	Fri, 13 Sep 2024 07:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Eo9+JBNH"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37641AD26C;
	Fri, 13 Sep 2024 07:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726211659; cv=none; b=D2aLVcN80CB7tWJEIl2gkQi1JSzugjc73k71tDMNW9fcJ4axmVBk2Abi7qVAi+37gUhx8+PeZ0TftMJm8APMRBicgwUwK/MS9nB27Cv9Q2S0JWGPcmMejIEWZKKFHfPruCiOuI6auQ7vOsp4XnbYno0+5h0G123gYRSrlYtqnkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726211659; c=relaxed/simple;
	bh=u6BEIAGg01TBeygvpi8qUqxmo2qGhpPfX0exboCwXeA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nM4l9aY6D6AkiH3ynrgKziSCyAIMyUcyLPcrXoWFZ5wfB2zI5ZAwrYTZRkxTEWbUpfHYi3Id08/jQoyiZmPE2ni1TBh4yThzfJ5OREGZ0u7AMpLqTsa8FyeWWMjHOSNGwpMB67IR6aI2Jb/00inJV2i9p1drbfGuupB2EqU2lVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Eo9+JBNH; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6FA651C0005;
	Fri, 13 Sep 2024 07:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726211649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RSAHK7BmZYU2deQi6bi3uBwOceUpjUsOskzSgu2a7TQ=;
	b=Eo9+JBNHpHFCOcLulM6Tf+tOj/4Vo7FvtPMYomLp8P0wBht4b36JYpVpGCZIFMsx5JSUkr
	2u56RLgv703SygEBuKsktPruXY1b7tvE/nIE4tNkxNCoSHYiYN7wupyz19xQn+m7gNmaTg
	x9lbSYOYp5m7yLAuR70q4JE6imprmHCaZG4jw7d/F3nBMFy5MQG50PBmUrZlL6vsGfWuOE
	qNdn8AQ6+nL7wxNrYKq7wfjOKU5/nzRPsBoNlYkf6/bfZ+pZY8IMX++MfApVGMyfkFsB8u
	1gQwudHlEW/t0AnxDkJZpGjB6OFfXsYntIP7vOD5w/EZQjAZu++B6kJt3xOzXw==
Date: Fri, 13 Sep 2024 09:14:04 +0200
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
 <atenart@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Dan Carpenter
 <dan.carpenter@linaro.org>, Romain Gantois <romain.gantois@bootlin.com>,
 syzbot+e9ed4e4368d450c8f9db@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next] net: ethtool: phy: Clear the netdev context
 pointer for DUMP requests
Message-ID: <20240913091404.3d4a9d19@fedora.home>
In-Reply-To: <20240912204438.629a3019@kernel.org>
References: <20240911134623.1739633-1-maxime.chevallier@bootlin.com>
	<20240912204438.629a3019@kernel.org>
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

Hello Jakub,

On Thu, 12 Sep 2024 20:44:38 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Wed, 11 Sep 2024 15:46:21 +0200 Maxime Chevallier wrote:
> > +		/* Clear the context netdev pointer so avoid a netdev_put from
> > +		 * the .done() callback
> > +		 */
> > +		ctx->phy_req_info->base.dev = NULL;  
> 
> Why do we assign to req_base.dev in the first place?
> req is for the parsed request in my mind, and I don't
> see anything in the PHY dump handlers actually using dev?

After reading the code back, that's true. It's just a leftover from
when I hadn't considered that dumps could be interrupted/resumed.

Let me clean that up then.

Thanks for the review Jakub,

Maxime


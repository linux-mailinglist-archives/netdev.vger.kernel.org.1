Return-Path: <netdev+bounces-127270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48919974CCA
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 10:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B91D1C20DD3
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 08:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C936154C12;
	Wed, 11 Sep 2024 08:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eYYayfks"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA9E1531C0;
	Wed, 11 Sep 2024 08:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726043872; cv=none; b=IgOP18hMAbA10Xn85pCiBqvEcc1VnIorMO3V3nvKKtv+71iqHenvyo8PrsUqRycWjm1c+8pNYyBH+IfZjPv5hqsLc7wk0XwluimdLIBtZXhnI/LCLTq0r1MYg/nbsglAA4Ywf1mJrMJ1QPYf7ZsWBodX1GWnO9DljQw8xVBfF2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726043872; c=relaxed/simple;
	bh=i+0kyB8haI5dhoaqNOrxFoDRJSmPx6K9xx1YTThJJR8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LdkHUtlhbLz+KrHEp/R2hmsVFlF0AqVW11HbdzaAS3kO5UkKC46547iIItCQ6Qeo9dJK9/oGPWhaVs1Crv14X3f5reO4iJ23nE74V3JSC9VKn0ERGhNyyMADrGeMS2kxMtN+6koN8UiBPLteMNLe7rcynGsYuSKkuAH32GerT+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eYYayfks; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D2FEF6000E;
	Wed, 11 Sep 2024 08:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726043868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i+0kyB8haI5dhoaqNOrxFoDRJSmPx6K9xx1YTThJJR8=;
	b=eYYayfkstuEDfjdi+nrhPLEqQwUd7gtlicFvSSUmnZ+d+jjH4gBD0yes6tpk7RdsLMAUT4
	gNrbPdOjoe+gP76gU84SioC/0zV2OI09+NSIYVbONGN7gy3o5XoWnkvC0uO1eAudIs5cAZ
	B5sWEozNCklDI7EzixAkLoGCt4sFsqitQiqqwrYVCwCdY98pklAL0qb/AhQtkaevBtd9Wp
	BcTk/zHCY3X3waGsqAzRIX1AOtmp5cAcMGyQvPNvf5iFNqoqJd3X1stvH++EI49x2nmGRj
	0lefyrd1PQd6Q8WGnUhllKE4lGStNZ+fy0RBp9+TqhPKyDkYXXODcXttOE4hSg==
Date: Wed, 11 Sep 2024 10:37:44 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
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
 <dan.carpenter@linaro.org>, Romain Gantois <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next] net: ethtool: phy: Check the req_info.pdn
 field for GET commands
Message-ID: <20240911103744.251b0246@fedora.home>
In-Reply-To: <20240911103322.20b7ff57@fedora.home>
References: <20240910174636.857352-1-maxime.chevallier@bootlin.com>
	<CANn89iKxDzbpMD6qV6YpuNM4Eq9EuUUmrms+7DKpuSUPv8ti-Q@mail.gmail.com>
	<20240911103322.20b7ff57@fedora.home>
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

Hi,

On Wed, 11 Sep 2024 10:33:22 +0200
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:


> Sorry for asking that, but I missed the report from this current patch,
> as well as the one you're referring to. I've looked-up the netdev
> archive and the syzbot web interface [1] and found no reports for both
> issues. I am clearly not looking at the right place, and/or I probably
> need to open my eyes a bit more.

Heh my bad, I just received the report in question. Looks like you are
getting these before I do :)

Thanks,

Maxime



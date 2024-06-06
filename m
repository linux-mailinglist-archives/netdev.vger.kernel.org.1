Return-Path: <netdev+bounces-101247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 157508FDD2F
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 05:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA21528885F
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 03:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C059C17BD8;
	Thu,  6 Jun 2024 03:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lq5z6O63"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974D7224FD;
	Thu,  6 Jun 2024 03:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717643427; cv=none; b=BKb7icJwP7zimGesFSW4LZqlvRj1jZdGnmUkWNm68DktWGVa7lpLXe6AjUoJ/HV2PZvxtfidtg9owLLfOE4ZmKEmtu8Cps1ukDqX2kzyepPAnjdkU0lBwFxuHXtQl0LguRtn9ld3Faoh2CWRkKfZC2G7LmV5Th4/iJ4KRcSowZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717643427; c=relaxed/simple;
	bh=fSvKb4xL6usgTVuwwJWrOkwMNU8N0nfeCoolR2MrPTE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dOe7EYTjf9hXZcArSgYyF3T85hD93Ub9OkY0Y1LRRgyBm2PEA2iMVtL912hooWjnJAVdr8Bx4MJ+JFz5b1FzD03y8U6qFD+Qn3NZa+apcdjQuCC5guIsstnaaTEk7TGglO1ZEOmrNreclcnAz+E/3Zgl2edcvEcKPRe+16bPq7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lq5z6O63; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BB0C2BD10;
	Thu,  6 Jun 2024 03:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717643427;
	bh=fSvKb4xL6usgTVuwwJWrOkwMNU8N0nfeCoolR2MrPTE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lq5z6O63dxZ5+bq+0SKBYgIvQEerPq0sxsgeOUmRamuruvYnh+Fj4TGn5tdmqwD3l
	 UA/LQKEkuTeQfrItj4/U1BuLgja1sSW2u0Elx2GECM/sAAmR6FICsjkWT5pC1uC+qD
	 192+/L+RMwcxAAYgbGuMFTteZa0V08FhW+OSQfdiAFx/mmaBRNCrqMO6S2qRJYmi1V
	 ddM6kQGVGLiRIEQfO2srA/o4HEdo4wX2HiI3al12yAB5n7z4eGFwI0V6yf7ZVQZqfv
	 nvpRRvGnT8KCz3jO2kFUECm3qvFyWUgyFffxdsMKmWwSWCBMRfDH/W/Zs/YqnMNmx/
	 JNdHIciVii+CQ==
Date: Wed, 5 Jun 2024 20:10:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
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
Message-ID: <20240605201025.764f0881@kernel.org>
In-Reply-To: <20240605124920.720690-4-maxime.chevallier@bootlin.com>
References: <20240605124920.720690-1-maxime.chevallier@bootlin.com>
	<20240605124920.720690-4-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Jun 2024 14:49:08 +0200 Maxime Chevallier wrote:
> +/**
> + * phy_sfp_connect_phy - Connect the SFP module's PHY to the upstream PHY
> + * @upstream: pointer to the upstream phy device
> + * @phy: pointer to the SFP module's phy device
> + *
> + * This helper allows keeping track of PHY devices on the link. It adds the
> + * SFP module's phy to the phy namespace of the upstream phy
> + */
> +int phy_sfp_connect_phy(void *upstream, struct phy_device *phy)

We run scripts/kernel-doc with -Wall now, it wants return values
to be documented, too. 


Return-Path: <netdev+bounces-128009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 439D1977774
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 05:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DEB11C245A4
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 03:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA791BAEFC;
	Fri, 13 Sep 2024 03:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQV1m+ie"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325A574402;
	Fri, 13 Sep 2024 03:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726199081; cv=none; b=ai+HkUlzMDoZ2rNH5SP43ZO/s4aDAIGCrcwQbdtw2IyvEnl+LAixxnrRCEO/3L5fW71LuwdZXdHmLgjFgOJCmDJLceNTDTU1vfe+dhnQpIn/rHiPxTO3EX8OHMVp8v/FBep/IovELeVwFZIV6jq0hQx1xB/VJPtSbvhGcW161Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726199081; c=relaxed/simple;
	bh=14FYnHIpK2VkIZXi1OjsNSbKcix+CkvkwHGueSrvBr4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Be/4bnreYhZ31Bc+DT16pg9IH4xxE1y41dk+nhGWm14j4T4fxiy3HdXXrVYS0KhAJVUe9lK5CY97E/bAAoc55jM+bBaTWK+QzzY1WeDjSAMarwsOiwRgrh+c1FmScMmWF/9AdjkbkgLgmtvWmaYNl8CG1cQliA3RqbyQDTqysRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQV1m+ie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7829AC4CEC0;
	Fri, 13 Sep 2024 03:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726199080;
	bh=14FYnHIpK2VkIZXi1OjsNSbKcix+CkvkwHGueSrvBr4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LQV1m+ieF8kilr4Pc0TdiGeaW/6bp1yTGccJ+bcdgww2EymrUdh2PnmVKWx2PxBZa
	 IK7ga/GcPhGlgnD10gZU63yrymwumSoN+EtgC4UY1V1GiBLN3NYeQQMg0eiMtkdScg
	 0wx4RH5qZFSgdMNMHr3TJwciaP3CfFDvhP3eJtpHf6/fQ8Rhs9NJVu6EkYLs7zxATK
	 3Iw+6SvDDhYLnCqgNG68+FXRXeYCcT//W6lpxI6kj3ynYtqXRwGs00HHF9TK8SQOpI
	 C6zSp5lyb8321l9H4WAxJJyJtRYaZaicraOZ2KeCTra4SpL1w7i6NLhtXgJjV3FWPc
	 bd3FcOYxJ6fOg==
Date: Thu, 12 Sep 2024 20:44:38 -0700
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
 <atenart@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Dan Carpenter
 <dan.carpenter@linaro.org>, Romain Gantois <romain.gantois@bootlin.com>,
 syzbot+e9ed4e4368d450c8f9db@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next] net: ethtool: phy: Clear the netdev context
 pointer for DUMP requests
Message-ID: <20240912204438.629a3019@kernel.org>
In-Reply-To: <20240911134623.1739633-1-maxime.chevallier@bootlin.com>
References: <20240911134623.1739633-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Sep 2024 15:46:21 +0200 Maxime Chevallier wrote:
> +		/* Clear the context netdev pointer so avoid a netdev_put from
> +		 * the .done() callback
> +		 */
> +		ctx->phy_req_info->base.dev = NULL;

Why do we assign to req_base.dev in the first place?
req is for the parsed request in my mind, and I don't
see anything in the PHY dump handlers actually using dev?


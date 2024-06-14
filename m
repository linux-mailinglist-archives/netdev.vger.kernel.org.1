Return-Path: <netdev+bounces-103441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6934908099
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 03:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 301552855D0
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 01:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A678181D14;
	Fri, 14 Jun 2024 01:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5yRX/sg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB4B3211;
	Fri, 14 Jun 2024 01:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718328376; cv=none; b=ULJYDw/9fxMVlwX1kRpH2WMEqRxXDF668ZeDbHQo5wq0/gw2D+6fAvsNltOSQg/B+UeHbp/LNKeE1+L7FB6bVx16Ge50dfUtvNqwuei+i6Sf4+rrV9krOZ3azJOIiETgw3qrDA8atacHR0tQHYnfq+xcRIhFwgx9eTjNavjMs2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718328376; c=relaxed/simple;
	bh=kLV3z/ZGpX0PFgVq4+W+L1l79K/SNekMA3Nls7V9LDI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uO49PQk69ojhrcqDwx2sKe+OjnJv1L/xTGFOzNp40rYy7ytP/5dqyhR/o221AqZ8vXxBpmKA07jJOXqe6NM2UGtAiUhPj+JXmgwIlBh/2fmfgqwbu6qy5a6LVHpAGRH9MUQH5FHhkmaceZ326h+RiuMG9ZNMS6QY2WnjfJwKCCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5yRX/sg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA883C2BBFC;
	Fri, 14 Jun 2024 01:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718328375;
	bh=kLV3z/ZGpX0PFgVq4+W+L1l79K/SNekMA3Nls7V9LDI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p5yRX/sgFHhSCyE1qpFsoNIBt6Y2UZ6rkbsoHegv2vTVfzQ55eJys+UTgCg6D/l7M
	 qxA6M4OM2bP4dPGmlTaSlSNQjHisl3Hq/uXybTsbLT6lchJxJlmVqUG3lNChcddAku
	 kD+1/v56gaENCnMg3QzlfBgjd5EAmb+WWrms4Nbl2XnlK4xyBVfizfeD1zA+lpUIaN
	 gLT1wkY3WkXsSS7NHdNvbwxrA8Tc2ga+sTxyeCFogKX7R5GgEmCGHXzwXAdwYdnzgT
	 jz7IYVTSxuMSb5qJApf88t5mUAShqacevfS4YPuoHNfBYZjiOEtEqBAr0Gday3MrMP
	 SnFGAiAt4d7og==
Date: Thu, 13 Jun 2024 18:26:13 -0700
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
Subject: Re: [PATCH net-next v13 05/13] net: ethtool: Allow passing a phy
 index for some commands
Message-ID: <20240613182613.5a11fca5@kernel.org>
In-Reply-To: <20240607071836.911403-6-maxime.chevallier@bootlin.com>
References: <20240607071836.911403-1-maxime.chevallier@bootlin.com>
	<20240607071836.911403-6-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Jun 2024 09:18:18 +0200 Maxime Chevallier wrote:
> +		if (tb[ETHTOOL_A_HEADER_PHY_INDEX]) {
> +			struct nlattr *phy_id;
> +
> +			phy_id = tb[ETHTOOL_A_HEADER_PHY_INDEX];
> +			phydev = phy_link_topo_get_phy(dev,
> +						       nla_get_u32(phy_id));

Sorry for potentially repeating question (please put the answer in the
commit message) - are phys guaranteed not to disappear, even if the
netdev gets closed? this has no rtnl protection

> +			if (!phydev) {
> +				NL_SET_BAD_ATTR(extack, phy_id);
> +				return -ENODEV;
> +			}
> +		} else {
> +			/* If we need a PHY but no phy index is specified, fallback
> +			 * to dev->phydev

please double check the submission for going over 80 chars, this one
appears to be particularly pointlessly over 80 chars...

> +			 */
> +			phydev = dev->phydev;


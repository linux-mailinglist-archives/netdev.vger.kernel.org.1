Return-Path: <netdev+bounces-171427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1266DA4CFBC
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 01:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DDDC170D57
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 00:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E723234;
	Tue,  4 Mar 2025 00:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSNxcxjQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564762905;
	Tue,  4 Mar 2025 00:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741047026; cv=none; b=uAoBB1qTJ9EfWra3VeyxUbI+lgumOn/eXvu8khVPZvDDRp3y3Y6THolOMUpduZbXJ+AUYp3Z56sU3JyIKwsyIZ7p73+IXBBfz6SCLEWMMNuOqNNe5CkVzKZTiOfIG4Kgo35PsLb+d04sn0e1kFLzVndUGKeGPbJY2SFlySe1DIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741047026; c=relaxed/simple;
	bh=mhb0R+JmZbuqZb2vKrLLB9HfKDaCWuI1Q6s/9+i/gkc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qpYY3lhvxZop5JRXoJ1CfXWPk4GXZWRzBOUy7Qv02VBqq7R3BbjikkXxwHLYvnM1WuRDboUODnkFsWow7kkp1IJ4oAAgpmnDmf8qX9cyYl7AR7GxG1L68ZIO0+3V1MMsN4Jfz1DS7U2mIffS+Z6X3OiPg+YmHtnFhGa1zCZm+nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSNxcxjQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3C1C4CEE4;
	Tue,  4 Mar 2025 00:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741047026;
	bh=mhb0R+JmZbuqZb2vKrLLB9HfKDaCWuI1Q6s/9+i/gkc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hSNxcxjQZv/RKSYZQNum16KV0wryu2LL8z+zTyog6YdTtK1gF1VttJ/xPPcbtjVHU
	 JZmil/BGqLpE9YLTHHzWIun8yrHJm+/uxcu/ucV3NF2apROYk68N6E6TFTzyEOSopS
	 Jty+DVMyr4zLFToJtTEvwTqvv8X+DC7+joSl3XW/C6igqAT6n6pUTWDTg91XHvJTEA
	 0WomYPJlQ6vQqWI2DjEtdX8BSwLWMZeK8AfhRVB1sbDI4T1aAiJ8xamF+Jv6J/tJ5w
	 3/yHvoE8D8dHNXXPhhPIcJdlAxr6SsqcrsyMxOIxvGr956jKnaxA93cLPHpNqQuYHZ
	 sskj05VhvjrOA==
Date: Mon, 3 Mar 2025 16:10:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Parthiban Veerasooran
 <parthiban.veerasooran@microchip.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Simon Horman <horms@kernel.org>, Romain Gantois
 <romain.gantois@bootlin.com>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>
Subject: Re: [PATCH net v2] net: ethtool: netlink: Allow NULL nlattrs when
 getting a phy_device
Message-ID: <20250303161024.43969294@kernel.org>
In-Reply-To: <20250301141114.97204-1-maxime.chevallier@bootlin.com>
References: <20250301141114.97204-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  1 Mar 2025 15:11:13 +0100 Maxime Chevallier wrote:
> ethnl_req_get_phydev() is used to lookup a phy_device, in the case an
> ethtool netlink command targets a specific phydev within a netdev's
> topology.
> 
> It takes as a parameter a const struct nlattr *header that's used for
> error handling :
> 
>        if (!phydev) {
>                NL_SET_ERR_MSG_ATTR(extack, header,
>                                    "no phy matching phyindex");
>                return ERR_PTR(-ENODEV);
>        }
> 
> In the notify path after a ->set operation however, there's no request
> attributes available.
> 
> The typical callsite for the above function looks like:
> 
> 	phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_XXX_HEADER],
> 				      info->extack);
> 
> So, when tb is NULL (such as in the ethnl notify path), we have a nice
> crash.
> 
> It turns out that there's only the PLCA command that is in that case, as
> the other phydev-specific commands don't have a notification.
> 
> This commit fixes the crash by passing the cmd index and the nlattr
> array separately, allowing NULL-checking it directly inside the helper.
> 
> Fixes: c15e065b46dc ("net: ethtool: Allow passing a phy index for some commands")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Well, this alone doesn't look too bad.. :) Hopefully we can address
adding more suitable handlers for phy ops in net-next.

Didn't someone report this, tho? I vaguely remember seeing an email,
unless they said they don't want to be credited maybe we should add
a Reported-by tag? You can post it in reply, no need to repost 
the patch.


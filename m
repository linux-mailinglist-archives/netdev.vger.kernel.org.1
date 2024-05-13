Return-Path: <netdev+bounces-96082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD54A8C43D6
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 17:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8B91C213A0
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 15:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375C2539C;
	Mon, 13 May 2024 15:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuH21bQ5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2D5538A;
	Mon, 13 May 2024 15:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715613101; cv=none; b=A2nuX3YMZ6N9CysOND5xbliMXrnuNbrIjUlj+2OFShJzpW0ETiiWX831uLQSEmXrcjIOp5brWAx/N+fKSzfI3kudNAXuvQdq5g0IAWGZvGKI/6b+THhx0Nq2zcNOc7lpCegWPGnUDBza6vuSfW34Z4RUdEN6vgsayPiVKgBKwx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715613101; c=relaxed/simple;
	bh=ZGgil73BE3HNKRxqE46JpywWmkJeK1/QT9NbcobOA2M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gRK55UGFdDzb315b2sDS98bbGkoCTdDl5Zhf/hMx84CZkRcIzCFuKaHSPUkCb1Mnz42U9cbCBmcJOsvyEQYGN1fKERVuST7o4Y7GIlhGpIZAPXk6+yvz/4TBgIFwbaR8tu/o6xUYCQLk6oulqi2MP9R3QHtvFEhmO6CMYpIvKOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuH21bQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895FCC113CC;
	Mon, 13 May 2024 15:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715613100;
	bh=ZGgil73BE3HNKRxqE46JpywWmkJeK1/QT9NbcobOA2M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VuH21bQ5WI78cvv9gorAje7f4LxViRt/6ZEJddl/oyAmKbrP+lHltNpQL7En0zFVG
	 4Uq9A1K7XYEfY9b0uLlVKsOP9J7JGYf1WTDVsPxMyA/uCanS57pMrZu4Qcis+z4ZKC
	 GL+RbGQPpb/DzobAJ14IPDP7DrrDTbLVHE/r3tr2jNgVJ69rk1eGVycB6pVZ6UO9ns
	 nBYGfYgPp5+xKss9kSexxs3Hb5wi/0WMxqQ/GuasaTR6g/R790e15nS6imntO1dDaV
	 m8N/krTeN5mp43/dcqavMvEArPbImlqsvNGabI2Gq6gl1zgOSL8iVsueVhhnllqiAr
	 Ss8SDnI1Ku3og==
Date: Mon, 13 May 2024 08:11:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Nathan Chancellor <nathan@kernel.org>, davem@davemloft.net, Paolo Abeni
 <pabeni@redhat.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, linux-arm-kernel@lists.infradead.org, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Marek =?UTF-8?B?QmVow7pu?=
 <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH net-next 0/2] Fix phy_link_topology initialization
Message-ID: <20240513081138.7e7eb3d0@kernel.org>
In-Reply-To: <ZkHaRD8WGrhrzemn@shell.armlinux.org.uk>
References: <20240507102822.2023826-1-maxime.chevallier@bootlin.com>
	<20240513063636.GA652533@thelio-3990X>
	<ZkHaRD8WGrhrzemn@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 May 2024 10:15:48 +0100 Russell King (Oracle) wrote:
> ... and Maxime has been working on trying to get an acceptable fix for
> it over that time, with to-and-fro discussions. Maxime still hasn't got
> an ack from Heiner for the fixes, and changes are still being
> requested.
> 
> I think, sadly, the only way forward at this point would be to revert
> the original commit. I've just tried reverting 6916e461e793 in my
> net-next tree and it's possible, although a little noisy:
> 
> $ git revert 6916e461e793
> Performing inexact rename detection: 100% (8904/8904), done.
> Auto-merging net/core/dev.c
> Auto-merging include/uapi/linux/ethtool.h
> Removing include/linux/phy_link_topology_core.h
> Removing include/linux/phy_link_topology.h
> Auto-merging include/linux/phy.h
> Auto-merging include/linux/netdevice.h
> Removing drivers/net/phy/phy_link_topology.c
> Auto-merging drivers/net/phy/phy_device.c
> Auto-merging MAINTAINERS
> hint: Waiting for your editor to close the file...
> 
> I haven't checked whether that ends up with something that's buildable.
> 
> Any views Jakub/Dave/Paolo?

I think you're right. The series got half-merged, we shouldn't push it
into a release in this state. We should revert all of it, I reckon?

6916e461e793 ("net: phy: Introduce ethernet link topology representation")
0ec5ed6c130e ("net: sfp: pass the phy_device when disconnecting an sfp module's PHY")
e75e4e074c44 ("net: phy: add helpers to handle sfp phy connect/disconnect")
fdd353965b52 ("net: sfp: Add helper to return the SFP bus name")
841942bc6212 ("net: ethtool: Allow passing a phy index for some commands")

Does anyone feel strongly that we should try to patch it up instead?


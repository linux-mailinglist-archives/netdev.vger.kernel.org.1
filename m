Return-Path: <netdev+bounces-177618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F0AA70BF3
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 22:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2157E179434
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 21:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A45F1DDC3E;
	Tue, 25 Mar 2025 21:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hc0tfI6p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DDA18CC13;
	Tue, 25 Mar 2025 21:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742937377; cv=none; b=kgpUtfZu11RgTDxifWMCxILVRpYIaxbnlEiqT/G6+aVWxVHCUaHl+Hm3YBqTdPb/PZXnR2zQBiRa2heRWhkUQDTvqqiBSR+pL2D82Zf5+kPp252yriiI0N5Wsjw3nBXpcr5rhUvPnK4QEWJ6J08pG8pxOmE71rCRy41MJVmrU8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742937377; c=relaxed/simple;
	bh=eor3PyjcjJdVgGion9iAlad6/v4xRcTAlRv7v4apa6c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+ceVQO+pMabkXW88+kAwJiT43tCKlvAzUY2n3mx/mb2v6aiyJNsYGV7m77H2+STEBFSZLHv9aYZ6ylhStMW2bep/jZ9PjoxLOYjl3aSml+VJDPyAx5dfuZOTXwB0jP49Hv2uc+itO110phK25rIISDua5j6ZzWp8lj6InB85xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hc0tfI6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E31C4CEE4;
	Tue, 25 Mar 2025 21:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742937376;
	bh=eor3PyjcjJdVgGion9iAlad6/v4xRcTAlRv7v4apa6c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hc0tfI6pqDq9Xprf6jGCFjnXRwkgWC2NAIqiRV3wtBhlAeHHZEcpea/AiCAImtZNb
	 kP0QSTnRbH4/rmcy/f9fTZpDze2TmZmsY8pWrfGlKU+H0kGapt4mqoD8MGZLaTfaBO
	 2Fy2/v0UdJ/ujsJcCCXJvNj2K6HqjhoebC/yI7Xirls0MD9MRgrafLKVTbGE0Y6WHD
	 u9LwYFLEmmayNqnVgPNWy+225SZvigw7PtbPJLxScq+vhcvKTVaH41J5XsQGKRdkYJ
	 SupwWpM0MJDTQim6al9YMSA83PJUEEHo71yVka1AkLsraB5PqqEEsTx8mARgZBWpHg
	 EsYjRKi2ruINw==
Date: Tue, 25 Mar 2025 14:16:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Simon Horman <horms@kernel.org>, Romain Gantois
 <romain.gantois@bootlin.com>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>
Subject: Re: [PATCH net-next v4 3/8] net: ethtool: netlink: Rename
 ethnl_default_dump_one
Message-ID: <20250325141605.684fc691@kernel.org>
In-Reply-To: <20250324104012.367366-4-maxime.chevallier@bootlin.com>
References: <20250324104012.367366-1-maxime.chevallier@bootlin.com>
	<20250324104012.367366-4-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Mar 2025 11:40:05 +0100 Maxime Chevallier wrote:
> As we work on getting more objects out of a per-netdev DUMP, rename
> ethnl_default_dump_one() into ethnl_default_dump_one_dev(), making it
> explicit that this dumps everything for one netdev.

Maybe ethnl_default_dump_dev() ?


Return-Path: <netdev+bounces-170905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0DDA4A813
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 03:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0FCB177F17
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 02:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1659B43AA1;
	Sat,  1 Mar 2025 02:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqOPMblY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07352BD11;
	Sat,  1 Mar 2025 02:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740795883; cv=none; b=OLQ0Oa5DCqhlb3onPFsiX0hVKq+N7Su8Nb+lqLGioG3+wCuU4DniLIo+PVoX5w8h6odlYSOWgYljPC/BgW4402z7weqDU95oGGBdvRD/89WBRHHK5iYtTnOLR2mUnUwr3SfO0X/ZXM0+smvh/QRIfGFdHL5mLP4CbeD2pTOfJf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740795883; c=relaxed/simple;
	bh=X4A2P0pAL5w+zEE9x8XbTmTjGewsrBxr+F1DGFTT8Jk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YiFYKLQfvmRdG/UZUSUlEC2UVh6JpDbif3F9sIhT8U7S5vlFfFgDTDhNBANHxuJplRW1DWwYQ5e/x9/X6VnoBNRPuMlWVx1qnXZCTXSARqd/zpKAYfcFCI+QFjXEUIHfE4Z4FmXoPnjjopcibptFp3kt8eo1ZvU3N9Uw8IUv3YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqOPMblY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1D9C4CED6;
	Sat,  1 Mar 2025 02:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740795882;
	bh=X4A2P0pAL5w+zEE9x8XbTmTjGewsrBxr+F1DGFTT8Jk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SqOPMblYHxWBy67SUWSrGjjjiQUJFZN5EZ/kkbU8ho8C3apRfWXcy1prcKCZHr7SG
	 MKHBs8IzsTlZiHrGdl0bGeD3qYY9bzu2cETN8EOoTinC4ZHKCIDHMk8z6rZOqq3nQh
	 rEpKNhke6shCtG8QqAqWEoQEp/d8vYn/HZ/Xeyruz1IEzNUgLE+Ql7l9nMiSjRDpoC
	 bTgg4+PupGZYjEP52NnwKFZqCj6SHpC5sD7EJ688AodWFUHVACVWLXa28+b5h6eci3
	 Rt2xFZxzrn+HesWhjeutzl4rLwrWBdbLhUBk0RU5Pm9LqALqus+XV7aHSjIjZgXxgN
	 0XNuN/Wv+U9OQ==
Date: Fri, 28 Feb 2025 18:24:40 -0800
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
Subject: Re: [PATCH net 2/2] net: ethtool: netlink: Pass a context for
 default ethnl notifications
Message-ID: <20250228182440.3c7f4709@kernel.org>
In-Reply-To: <20250227182454.1998236-3-maxime.chevallier@bootlin.com>
References: <20250227182454.1998236-1-maxime.chevallier@bootlin.com>
	<20250227182454.1998236-3-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 19:24:52 +0100 Maxime Chevallier wrote:
> The only relevant user for now is PLCA, and it very likely that we never
> ended-up in a situation where the follow-up notif wasn't targeting the
> correct PHY as :

PLCA uses the ethnl_default_* handlers but it seems to operate on PHYs
now. How does the dump work? Shoehorning the PHY support into
the ethnl_default_* handlers is starting to look pretty messy.


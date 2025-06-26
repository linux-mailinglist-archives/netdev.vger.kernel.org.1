Return-Path: <netdev+bounces-201667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807F3AEA568
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 20:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0563C564535
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 18:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8052EE5F1;
	Thu, 26 Jun 2025 18:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7GFK1a1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114682F1FCE;
	Thu, 26 Jun 2025 18:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750962596; cv=none; b=HThAFsVy2P4ds2I65PEpAfFQ1ofUOExzSSQ1XGyvBuRyNOuCzDrgjj9Pj7lec8bnJPWX2UhIeXnou7sPIp+4Zf04+LXw8EdtLhOaQLzvi5c/2eihyB2CukmCgRpYocnXU6/fRFTgtlNyYtgqEFJFPbmWuR5p6QIT6v0n4yGbteI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750962596; c=relaxed/simple;
	bh=TtyXTqZHS7WMCX37CORNs51o3WK6Gt83ngInIItezg8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VownYtsXBWRQVpWCaQUYrD+ltKOyWvFGzICzilxewt3DO/qyUxx2lWRPZgj+sdpQy1zm3E+6LtRmHfDX18gQ+6rQJj6EzltB2wcW/MH7ocj1YwsWX2g6Z+3h3z6Ej9YpGvu7pgg168+wNSyc68VuyP8c3Oht4OXG4T29nxiSdXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7GFK1a1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051E4C4CEEB;
	Thu, 26 Jun 2025 18:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750962595;
	bh=TtyXTqZHS7WMCX37CORNs51o3WK6Gt83ngInIItezg8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c7GFK1a1t9dBNPzGktr/+eb67PkxOiElidnZ6I1BZmYRVIP9Wf8ipLIWyboXhAbTy
	 fixal4soaaTKK0kHVAXftqWAdi+FOP3Tj3yBZXiw4VYjj9yUGPsQ2H9s2sPib+B0nL
	 OCFZzQ9TLb43FPlqlTEPkmDu+SwQIVLEez3pQRH5tNWyMRPgENeKDU2jAVe2INgbqM
	 AuGpM4Gwj+rLkvSOpasjJZi8zXUNRtvtNRGwQNDE5ea6OZDY6HW7wKUvNshUKTKaM4
	 WT1DPqiKdGbBqEPXS5MH7OsdBJC2h6TTKlzk1RbhX3Qev9D2tf2TsxtLhoCjF1FCXz
	 7cqTMPSjEtTuQ==
Date: Thu, 26 Jun 2025 11:29:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Woojung Huh <woojung.huh@microchip.com>, Simon Horman
 <horms@kernel.org>, Thangaraj Samynathan <Thangaraj.S@microchip.com>,
 netdev@vger.kernel.org, Phil Elwell <phil@raspberrypi.org>, Russell King
 <rmk+kernel@armlinux.org.uk>, linux-kernel@vger.kernel.org, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 kernel@pengutronix.de, Rengarajan Sundararajan
 <Rengarajan.S@microchip.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Paolo Abeni <pabeni@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v1 1/1] net: usb: lan78xx: fix WARN in
 __netif_napi_del_locked on disconnect
Message-ID: <20250626112954.5987f2e9@kernel.org>
In-Reply-To: <aF0edQRJAXSps5CV@pengutronix.de>
References: <20250620085144.1858723-1-o.rempel@pengutronix.de>
	<20250623165537.53558fdb@kernel.org>
	<aF0edQRJAXSps5CV@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Jun 2025 12:18:29 +0200 Oleksij Rempel wrote:
> > > This patch is intended for `net-next` since the issue existed before the
> > > PHYLINK migration, but is more naturally and cleanly addressed now that
> > > PHYLINK manages link state transitions.  
> > 
> > And repost that for net, please.. :)  
> 
> It will be not compatible with the PHYlink migration patch in the
> net-next. Should i wait until PHYlink patch goes to the net and then
> send different patch variants for stable before PHYlink migration and
> after?

The conflict will be relatively easy, we will have to cope.
But you really, really should hold off net-next patches until 
you fix all the pre-existing bugs :|


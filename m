Return-Path: <netdev+bounces-150285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F3E9E9CAF
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62455282A76
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 17:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A8514AD22;
	Mon,  9 Dec 2024 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Q8VMzWgb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20822143871;
	Mon,  9 Dec 2024 17:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733764289; cv=none; b=NA6aoFn8A0BUN79kh2DsXjccg4rdcVgOfxQzfDm3cRK4uDxWxaGhtxxrDwNQKT8OHpugf/y0ifDmIK0d04TmH7tkzHqcFfgjdkheg3y8/V1PbWXyn+V0qAOIBFv9HD6Aw/vYzch1QK0rdssq032f8BqAFsjx8zR6DJ6IftQni0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733764289; c=relaxed/simple;
	bh=ngMmvBElSZG0QFrk2B2dVDCtmQH1Qc2tCmNXX3Dvnss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuGxWHPV+aaQdQ+8FQ9gNZpqsk8hWLScFGRh9FrHYjx1csueKM+XJ6qiPO7Y2K1lAJxFJYoBkALrvjAIVi33kNlassxTQIqwKNcGz80z4Y/yisAa39YSXkxlU4BaydKXmaRnaC1Gkppl3uA/VUFOnMSfNVXUth3RE4UGpsibv/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Q8VMzWgb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=B/1VlGu9aZrC/pPeI68fRvjJG+KMxrkY7sSrAbkXbT8=; b=Q8VMzWgbMvHGCD4qrAQ3Qq7DIt
	mgvx7hG9QGfxtGtJBscvnUOFD1em46UmyECwC7O47ZQ2ksAEsbHSoQIRJ2B1JqsX2P0JOnulMPImL
	lMAlabWGvjTFieyK2F8gw0iV0qj/ItbAgYVnxErOjA2KGVkCkcKnzThOHd97IMYK8ePc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKhHz-00FhIO-LJ; Mon, 09 Dec 2024 18:11:19 +0100
Date: Mon, 9 Dec 2024 18:11:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tarun Alle <Tarun.Alle@microchip.com>
Cc: arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: phy: microchip_t1: Autonegotiaion
 support for LAN887x T1 phy
Message-ID: <1d230d3c-740b-4876-a0f7-e48361b6d238@lunn.ch>
References: <20241209161427.3580256-1-Tarun.Alle@microchip.com>
 <20241209161427.3580256-3-Tarun.Alle@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209161427.3580256-3-Tarun.Alle@microchip.com>

> -	/* First patch only supports 100Mbps and 1000Mbps force-mode.
> -	 * T1 Auto-Negotiation (Clause 98 of IEEE 802.3) will be added later.
> -	 */
> -	linkmode_clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, phydev->supported);
> -

What are the backwards compatibility issues here? I would at least
expect some comments in the commit message. As far as i understand, up
until this patch, it always required forced configuration. With this
patch, it suddenly will auto-neg by default? If the link partner is
not expecting auto-neg, that will fail.

> +/* LAN887X Errata: 100M master issue. Dual speed in Aneg is not supported. */

Please could you expand on this. We are now doing auto-neg by default,
and auto-neg is somewhat broken?

	Andrew


Return-Path: <netdev+bounces-132382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9597A991744
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 16:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12DE8B20D52
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 14:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A3B14C5B3;
	Sat,  5 Oct 2024 14:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6CEPA5Nw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4104C91;
	Sat,  5 Oct 2024 14:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728137902; cv=none; b=K4R1g0Bv4srchpL7RGqgwCV5vpG+bnBc3skg4dv7FlUxBCR7E7HQh2Hr7PZyIHOTjQD1BsKzEI6Tbz1P0/dqCgITtuF+gIL7M0BZAhXjVbbfLA70QcTKHvWA+YlNpaqvH4SizPjkBhgp5n+Tv9E5bUjV7WaxFXT15Tz/apYxTEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728137902; c=relaxed/simple;
	bh=z58kpIA08q0lrTS6s+7kuYpJFc0TBY9+yvA2ox/CNnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/3SMt/6jzdufyzm0pz6HvNr6/xtGzVIvfa/y53FkI4fzCEMspe1gy/vvWNNUkxgy7ED8mHsyfzosMmev8q95by52i8tZ33rMzgsA9KVjGI1xdsJ0kSo7m738XLKUYYZmNTubhxAL+5CeEMRav3XNBdR2qatC2e5hkqEYPOOZok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6CEPA5Nw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vcbOwEVJYOqCfpF0JItusw+gpp8QZNqOFErMOMAbH7k=; b=6CEPA5NwwzioM78mp1GeRtObnL
	G+7DA35ALE/dDgW3ty7jTEyuOBG9ERd22XKQDJ1AUIt3qiHcrVbJsArRIw/4sSnlw1/14C0ANLGfG
	JxY/NqijiL1jnkHwSmK+fA8InXAfibe+bHj3z/7KJZVNub2P+Rt5BxShehNsYOP4dEXM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sx5bY-0098SB-Sx; Sat, 05 Oct 2024 16:17:56 +0200
Date: Sat, 5 Oct 2024 16:17:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next] net: phy: always set polarity_modes if op
 is supported
Message-ID: <e288f85c-2e5e-457f-b0d7-665c6410ccb4@lunn.ch>
References: <473d62f268f2a317fd81d0f38f15d2f2f98e2451.1728056697.git.daniel@makrotopia.org>
 <5c821b2d-17eb-4078-942f-3c1317b025ff@lunn.ch>
 <ZwBn-GJq3BovSJd4@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwBn-GJq3BovSJd4@makrotopia.org>

> I'll add "active-high" as an additional property then, as I found out
> that both, Aquantia and Intel/MaxLinear are technically speaking
> active-low by default (ie. after reset) and what we need to set is a
> property setting the LED to be driven active-high (ie. driving VDD
> rather than GND) instead. I hope it's not too late to make this change
> also for the Aquantia driver.

Adding a new property should not affect backwards compatibility, so it
should be safe to merge at any time.

	Andrew


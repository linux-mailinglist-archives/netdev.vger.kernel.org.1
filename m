Return-Path: <netdev+bounces-245161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF14CC804A
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 14:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D84F0301D61D
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 13:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E8535A92E;
	Wed, 17 Dec 2025 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FJ6LimZd"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE7A3596F5;
	Wed, 17 Dec 2025 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979405; cv=none; b=Z6EIPho4sie98dTP46OEQCzSmovTHloxsAVYjyEp6CIwo13DybLWR6BWYxojHv49pJCxM0Wg9v2MyklUn6kOCvvyw3ryarJc9txSM9UJaWnzQX+3Vj1c+t30QDs/l6MiSYXX94Z2lj9/MbTkZOj0ynR5H+SRSLykBVNU4JGEB9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979405; c=relaxed/simple;
	bh=MTTb8HlNJVO4UB4+QRj3v9hrUpMADXFxOGApeUa6NXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2YQQkUOiViwUARWrM1X0G2xTJ7tY3Y4rGW0B/DGRamf/PASUeTBtE9rYZhlF0SCbU4rz3zzMyt4m/jHMXdemvUnWBRIljDP3gFKj7tUSMJkok9g+gGoHvO5ZMz18eiAGTFigK6PLJv3DMhKoX4zrvveN/gkr0U3DdiRH3BXiMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FJ6LimZd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2+WwBYYEeiXPhF+PDs3ijujEDaGJ6KDELIkS+mXjOB4=; b=FJ6LimZdyOBJ4Cs9CTvqf0pW87
	CglzRwzFM4UmrRrvpr+bXw6f21Bmerx0LxBhUeUVbHeQTwLJm/AC7OIEDY+YBlnSMVNlUck20Al/f
	eTULE/Q6sJK/GVygmxgbV84kemZVjsVQ0DSQhZsuJR/NTIQvQD2w0VEcukn8LBQ0WP9M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vVruT-00HDSE-Tf; Wed, 17 Dec 2025 14:49:45 +0100
Date: Wed, 17 Dec 2025 14:49:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	Frank.Sae@motor-comm.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, shenjian15@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	jonathan.cameron@huawei.com, salil.mehta@huawei.com,
	shiyongbang@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 6/6] net: phy: motorcomm: fix duplex setting
 error for phy leds
Message-ID: <0bb9d5a1-e01c-4d7d-b668-3bf81e98447b@lunn.ch>
References: <20251215125705.1567527-1-shaojijie@huawei.com>
 <20251215125705.1567527-7-shaojijie@huawei.com>
 <d8b3a059-d877-4db6-8afb-3023b8ee5fa3@lunn.ch>
 <143514a2-e538-47e2-920c-f223667cb900@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <143514a2-e538-47e2-920c-f223667cb900@huawei.com>

On Wed, Dec 17, 2025 at 09:05:20PM +0800, Jijie Shao wrote:
> 
> on 2025/12/16 15:21, Andrew Lunn wrote:
> > On Mon, Dec 15, 2025 at 08:57:05PM +0800, Jijie Shao wrote:
> > > fix duplex setting error for phy leds
> > > 
> > > Fixes: 355b82c54c12 ("net: phy: motorcomm: Add support for PHY LEDs on YT8521")
> > > Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> > Please don't mix new development and fixes in one patchset. Please
> > base this patch on net, and send it on its own.
> > 
> > https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
> > 
> > Fixes are accepted any time, it does not matter about the merge
> > window.
> > 
> > 	Andrew
> 
> Yes, this is RFC, just for code review.
> I sent it to net when requesting a merge.

This is however a real fix. The motorcomm driver is broken. Why wait
to fix it?

	Andrew


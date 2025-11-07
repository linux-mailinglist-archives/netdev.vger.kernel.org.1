Return-Path: <netdev+bounces-236858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B49C40D8A
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 17:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCA3F3A8286
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 16:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B622641CA;
	Fri,  7 Nov 2025 16:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="D0CsDTQs"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9D0264634
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 16:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532288; cv=none; b=SWfe1dSITcAZuKdUzjCNiWGtXPx/VBCU/TrkDipD+sWDNjVeaNaLXB4E/U9FnleSxhAj9INvzOjr69OUVznxwbe0Wn0mwrW6qsCLFxcDEUAJAxX0975gZ58yL7ojsXwu+ld5nooYS59ZHpQIVFg5LFS8fQiSWyF2Qc5LZAAvM1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532288; c=relaxed/simple;
	bh=j8eoj4rG+uxu2fGpd2VBmKB+i50/gIA14ZHysgIB8aE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlXHygfrsj3xEs8as0gmdBYDkOeNx9gpJeomesPjxn6bwRjWppBQzX4kADr49Tf1flAz/z2XnxCbMPY9vaz75shiZpAN4R41lAEVmU9JdEAfkkIF4AC6WqKl/PIYdrgUA66s0i+LVvywM4bSoYl5Wx/S7sywUfVLdsdc99l8R5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=D0CsDTQs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZPYhMO9Nonj3DvtjQNUTp9qcN6tHDVd5t6GBKRsP/v8=; b=D0CsDTQsEq+8+c/fKAUFkm4wYQ
	aVDTxdXw98FrGQtwydZ49fZDKITjhUM2EDzlUqaYGl70lqDfjWNpeUUONFwgHDhh1SbU+poeak7zK
	CbHQCG8Jed/pebMYY2+tp3NUbkm2DxDUogfhQ4WadBQSXQTI9J2u03S5cxsuUtzGCJl8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vHPA1-00DFUy-Nm; Fri, 07 Nov 2025 17:18:01 +0100
Date: Fri, 7 Nov 2025 17:18:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>, Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: [PATCH v2 net-next 6/6] net: phy: realtek: create
 rtl8211f_config_phy_eee() helper
Message-ID: <9cb3808d-341d-4db2-90c9-12bf412d4a48@lunn.ch>
References: <20251107110817.324389-1-vladimir.oltean@nxp.com>
 <20251107110817.324389-7-vladimir.oltean@nxp.com>
 <56b1deb7-2cc4-46fc-9890-bb7d984bed55@lunn.ch>
 <20251107143240.7azxhd3abehjktvu@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107143240.7azxhd3abehjktvu@skbuf>

> It's good you point this out. Somehow, among all transformations, I lost
> along the way the fact that the soft reset is necessary for disabling
> clkout on RTL8211F, not for PHY-mode EEE :-/
> https://elixir.bootlin.com/linux/v6.16.12/source/drivers/net/phy/realtek/realtek_main.c#L598
> 
> I checked the RTL8211F datasheet and it doesn't say that changes to the
> "PHY-mode EEE Enable" field would need a write to 0.15 to take effect.
> But it does say that about "CLKOUT Source".
> 
> Curiously, the RTL8211FVD datasheet doesn't suggest that modifying the
> CLKOUT source needs a soft reset when providing the steps to do so.
> 
> Anyway, this code transformation from patch 6/6 is not buggy per se
> (even if we change the CLKOUT on RTL8211F, we still get the
> genphy_soft_reset() that we need), but very misleading and confusing.
> 
> pw-bot: cr
> 
> > For the Marvell PHYs, lots of registers need a soft reset to put
> > changes into effect. I would not want to hide the soft reset inside a
> > helper, because of the danger more calls to helps are added
> > afterwards.
> 
> Ok, I get your point and I agree, but what to do?

If only the clk out that needs it, i would put it in the clock out
helper.

Is a soft reset expensive? Is a soft reset destructive? The marvell
one is both fast and does not seem to change any registers, it just
activates changes.

If you think some other registers might need it, i would probably just
do it unconditionally after all the configuration, assuming it is
cheap and non-destructive. Maybe add a comment that at least clk out
needs its, but other registers might need it as well?

      Andrew



Return-Path: <netdev+bounces-170375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C986A48600
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 18:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CAF6188DCC6
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18DA1C6FEA;
	Thu, 27 Feb 2025 16:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Y7eFTTcb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB6B1B85DF;
	Thu, 27 Feb 2025 16:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675407; cv=none; b=RmN/j4aD9squK9elFxKJdJ31ShBj2ix36UwmcqlkCqDGI03xLdA+6N57PaAUwPVy7hY7LWEHDklf3YHOHM124KZJEqr2c/3kvisPn5At/UVR1yDsYh84PgVdaT0qVJK0raDtMrXYpw0biMrsru4eoneH+0bn/HcMtNia6IO9yLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675407; c=relaxed/simple;
	bh=dwwXz15rnLwyQwuT+VNMV11IHrHQZ+V83M9c6sj8G+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUjMOXVXkW2h22aunzwWzJdc2IHZ2Ev37ACkVQ5ZRUiYNru3V2QpJlOJ7d3zeoRJ9iUKTq41Sk00a+kc+AlX+9hQ0o5kE4jkrK2TfzghCzKD/XoG/8CNoJWj5rEWf4wHaeMC9ZC5IaQz1KIO4RYIM0xr7ZP2sC7gpXhhBMtux54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Y7eFTTcb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hGUACzGWEEjLB5dmsGTv1IBmigcG0qIsLq4LcnANgeM=; b=Y7eFTTcb24BejeTcnuvUA5DmDZ
	GB1IhmLscE+YZojLX4joqevIn79RR4atjCPLuNjbBePYTKH+hyGiu93j15N2kaaE7bAA2N7hOAd5s
	t9+9+rHCCYdb/i386Gvdc7iXGLVNUvavbXCKL1tFeitPQtZiL7gjZqvTBUbnczEBP8UA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tnhBg-000exF-8u; Thu, 27 Feb 2025 17:56:40 +0100
Date: Thu, 27 Feb 2025 17:56:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Andrei Botila <andrei.botila@oss.nxp.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>
Subject: Re: [PATCH 1/3] net: phy: nxp-c45-tja11xx: add support for TJA1121
Message-ID: <4cd91b99-e88e-4f55-8fe7-8308cf6a35eb@lunn.ch>
References: <20250227160057.2385803-1-andrei.botila@oss.nxp.com>
 <20250227160057.2385803-2-andrei.botila@oss.nxp.com>
 <a9c98f2a-c5e9-43e3-b77a-0f20eb6cfa98@lunn.ch>
 <9de3e4c3-9f9e-41c0-9e2a-19e95e859c98@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9de3e4c3-9f9e-41c0-9e2a-19e95e859c98@oss.nxp.com>

> > Is there a way to tell them apart? Another register somewhere?
> 
> Unfortunately no, TJA1120 and TJA1121 share the same hardware the only
> difference being that TJA1121 has MACsec support while TJA1120 does not.
> It is the same for TJA1103 and TJA1104.

So the hardware can do MACsec, but it is disabled in firmware? Golden
screw driver could be used?

So you can tell them apart, otherwise you would offer MACsec on both.
It might be worth adding a .match_phy_device to the driver, so you can
have an entry per device. Just watch out for the semantics of
.match_phy_device, it gets called before the IDs are looked at.

	Andrew


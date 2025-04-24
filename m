Return-Path: <netdev+bounces-185532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D66A9AD0F
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 14:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDF0C7B2C57
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 12:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F31222F750;
	Thu, 24 Apr 2025 12:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iH/RIdmp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0900321FF4A;
	Thu, 24 Apr 2025 12:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745496996; cv=none; b=SWF1xQNurqBIN1tE5hwXc8dVbLUkJpV6woBohOiUBCqSWcb///HSs728pfk2hI2lTnoh3hib+X8YN/2J7w2doeG79xK5VrkRXnjNRiO4+cZxARFlxfVMEWC3LM/8+JtHkfB6AQU5JH9NGUKcqVXsIgAMgQg6tC7+IcB8f3tl3mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745496996; c=relaxed/simple;
	bh=EXCQGkJVb3ikUhe5Z7xJEbZwlIarJMazIfPkb5WCNJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2M+ns2KMJdwdLe2GkPqnZ417mQ16Lbs3LyYFozgNTeWyM/lKblhEt48XaaoHHkvQEKRoIkD48ZWW3t422HX2FPPD2UGmMrB8ZTvLIXP9AI9BhDNsOwDyq3ICSZrMa1uBhCIB+Pk7a4zauTSDxWOR2cMmJzrUses1iwzwfFpStA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iH/RIdmp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eToxWlS7Uu55X/OpbjIrz7rNLwhtOBmHvxKOjjoFdUg=; b=iH/RIdmpljQM3Gx8gJpTMuc59Y
	Mi9NE9Ux9q+RktIIpPcpvjjGCjVnCwSJPQjedapo+PS5uc7gZzTP+/XGBMjXwBKU5uiG7JsCNCTm6
	EmqaA7qw2nVPkhsCgKn7c8cwSL+pcuT5yP8IzIoO6xVc8OXsmYCzMKOetEbkIokhNkWE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u7vV2-00ASTy-RL; Thu, 24 Apr 2025 14:16:16 +0200
Date: Thu, 24 Apr 2025 14:16:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Yixun Lan <dlan@gentoo.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 4/5] arm64: dts: allwinner: a527: add EMAC0 to Radxa A5E
 board
Message-ID: <835b58a3-82a0-489e-a80f-dcbdb70f6f8d@lunn.ch>
References: <20250423-01-sun55i-emac0-v1-0-46ee4c855e0a@gentoo.org>
 <20250423-01-sun55i-emac0-v1-4-46ee4c855e0a@gentoo.org>
 <aa38baed-f528-4650-9e06-e7a76c25ec89@lunn.ch>
 <20250424014120.0d66bd85@minigeek.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424014120.0d66bd85@minigeek.lan>

On Thu, Apr 24, 2025 at 01:42:41AM +0100, Andre Przywara wrote:
> On Wed, 23 Apr 2025 18:58:37 +0200
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> Hi,
> 
> > > +&emac0 {
> > > +	phy-mode = "rgmii";  
> > 
> > Does the PCB have extra long clock lines in order to provide the
> > needed 2ns delay? I guess not, so this should be rgmii-id.
> 
> That's a good point, and it probably true.
> 
> > 
> > > +	phy-handle = <&ext_rgmii_phy>;
> > > +
> > > +	allwinner,tx-delay-ps = <300>;
> > > +	allwinner,rx-delay-ps = <400>;  
> > 
> > These are rather low delays, since the standard requires 2ns. Anyway,
> > once you change phy-mode, you probably don't need these.
> 
> Those go on top of the main 2ns delay

Which 2ns delay? "rgmii" means don't add 2ns delay, the PCB is doing
it. So if there is a 2ns delay, something is broken by not respecting
"rgmii".

> I just tried, it also works with some variations of those values, but
> setting tx-delay to 0 stops communication.

Just to be clear, you tried it with "rgmii-id" and the same <300> and
<400> values?

	Andrew


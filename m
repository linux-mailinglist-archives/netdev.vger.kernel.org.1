Return-Path: <netdev+bounces-184224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BDBA93F02
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 22:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5EA31B608D4
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 20:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE7423537B;
	Fri, 18 Apr 2025 20:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Wm49iNZ9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6AF1F869E;
	Fri, 18 Apr 2025 20:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745008874; cv=none; b=YkbdFlLpB4iQyvmPzBQAjf/YcPXCO3db7vA9fSJ685kmTZsnN+QVp2Q0AX7OYI1iBDusI+Rk5BoUU7u7jHnefmmSznTaunXSDIeBK0BqKoZO9ghm/jHMxWt1RxRcpAr6YhgeO1t9iih3tkR+YMuMQ2oqDLiYxDeASExXekOkZII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745008874; c=relaxed/simple;
	bh=C9Uj2szHgiSyhSFJPLB8kcClom8dVQYUbI2qxxDq6yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=It1rRmoDHtfaOZNP8eiZb1GrkXI0e7skshaw7HtJN6xM6gXG8OkR3i4QUU6FIOUuzzQdAzlI4Ehp9z1RCbnOl5Q/pgWUe6YEtHAq/itpX6oXuibWC/j5+iscMaf3piIvq/EF8VrosOg5tpt3HO8GXDKIyb6ApCO6AAaoeKIq2Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Wm49iNZ9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=khDOK1TjxyxAROtr0jQiZ7X4aZm0qTO+vpHmUfS/7KU=; b=Wm49iNZ9jPThjxDvW6abQGQlHl
	i6NvOCO2JcGJxCwhEfQkyIcsF95AM8MBK7Ze5tB0l/FqDXBgsIyuwnSgG3N1GkedBt1a22B/RuTzw
	DRsNSZGIDjkUn6FyQ2cuLiTWGbWijRIIen2SciJlCh3D6e/Pe6fVDY3wfjGewOEYRhms=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u5sWB-009wGv-6K; Fri, 18 Apr 2025 22:40:59 +0200
Date: Fri, 18 Apr 2025 22:40:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Whitcroft <apw@canonical.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>, Tero Kristo <kristo@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: ethernet-controller:
 update descriptions of RGMII modes
Message-ID: <4fbcce38-0a74-48d5-9802-a430098eccf2@lunn.ch>
References: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
 <218a27ae2b2ef2db53fdb3573b58229659db65f9.1744710099.git.matthias.schiffer@ew.tq-group.com>
 <6be3bdbe-e87e-4e83-9847-54e52984c645@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6be3bdbe-e87e-4e83-9847-54e52984c645@ti.com>

On Tue, Apr 15, 2025 at 04:06:31PM +0530, Siddharth Vadapalli wrote:
> On Tue, Apr 15, 2025 at 12:18:01PM +0200, Matthias Schiffer wrote:
> > As discussed [1], the comments for the different rgmii(-*id) modes do not
> > accurately describe what these values mean.
> > 
> > As the Device Tree is primarily supposed to describe the hardware and not
> > its configuration, the different modes need to distinguish board designs
> 
> If the Ethernet-Controller (MAC) is integrated in an SoC (as is the case
> with CPSW Ethernet Switch), and, given that "phy-mode" is a property
> added within the device-tree node of the MAC, I fail to understand how
> the device-tree can continue "describing" hardware for different board
> designs using the same SoC (unchanged MAC HW).

phy-mode describes the link between the MAC and the PHY. So it either
needs to be in the MAC node, or the PHY node when describing the
board. I don't know the history of why it ended up in the MAC node,
but it did.

> Since all of the above is documented in "ethernet-controller.yaml" and
> not "ethernet-phy.yaml", describing what the "MAC" should or shouldn't
> do seems accurate, and modifying it to describe what the "PHY" should or
> shouldn't do seems wrong.

What we are really saying here is, does the PCB have extra long clock
lines in order to add the delays? If yes, the MAC/PHY pair does
nothing. If no, the MAC/PHY pair needs to add the delay.

DT however says nothing about how the MAC/PHY pair should add the
delay. That would be configuration, and DT should try to not describe
configuration. Hence the binding description needs to be neutral to
MAC and PHY.

Linux has a preference, that the PHY does the delay. However, other
operating systems might have other preferences. And since the binding
should be generic across a range of operating systems, we don't
mention Linux's preference.

	Andrew


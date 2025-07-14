Return-Path: <netdev+bounces-206663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEB9B03F4E
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 15:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 435821770B0
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 13:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3362524C060;
	Mon, 14 Jul 2025 13:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sUyJsBIY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985414A1A;
	Mon, 14 Jul 2025 13:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752498583; cv=none; b=EXfKJrVP52k00R3N5PuL7sF9ff48Y2qrOsXQdzBCYY5lIGXxMPBvK/ML4w78cHgvpK5smbsstqWD9ddf6w80cwM1Aft6Jw7TOfT7HdvsT8uX+p9S2nA0g3UfmCJz+OYJmIoPSYqyKwoEC0Ixi9jIr/kH5sfIisWswSxIXJ1Z3ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752498583; c=relaxed/simple;
	bh=o1qYm/noaZ9CX74Y7R9xLDN0A7RylinyT4ae2zkhmQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJsZhO9As6dRXc+4woOAWl+cpe4TOmPMGJKQqBI7KDbfH3jx4JnjrBbQq07Zx8iNl1t11jUGs1LXyaIwAUOWnZ1c2TD9Qau1D5V/mHmAfaJlsuMHw2IG3EzVZVKGtoMJrQNozjplegiV55ThwEn4ptHl/IUAw4ciFijLtoKVQbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sUyJsBIY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cQqhnepfREGfXBXs6Gy2jlQYAmeLNJdpGYN4w0cdQSQ=; b=sUyJsBIYZZmfdt9NaOTTe/wl8q
	9WCbAVyudP9xk/saAaz0MTppPijs97FYttyaxfqpr7xVQ6OTJjCkEGFAhgBSaxAh4dwC9Jq7uggHk
	tfCx0DB5aSxpzzhMh0Y5uqbpHKzQkO4qB1JegaktAqSu0QQovxxJZFiUwhetDKg6fXoU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ubIvq-001SZ7-L8; Mon, 14 Jul 2025 15:09:22 +0200
Date: Mon, 14 Jul 2025 15:09:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Michael Walle <mwalle@kernel.org>
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
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>, Tero Kristo <kristo@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v2 2/3] net: ethernet: ti: am65-cpsw: fixup PHY
 mode for fixed RGMII TX delay
Message-ID: <fa3688c0-3b01-49fb-9c16-eeea66748876@lunn.ch>
References: <cover.1750756583.git.matthias.schiffer@ew.tq-group.com>
 <9b3fb1fbf719bef30702192155c6413cd5de5dcf.1750756583.git.matthias.schiffer@ew.tq-group.com>
 <DBBOW776RS0Z.1UZDHR9MGX26P@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBBOW776RS0Z.1UZDHR9MGX26P@kernel.org>

On Mon, Jul 14, 2025 at 12:01:22PM +0200, Michael Walle wrote:
> Hi,
> 
> On Tue Jun 24, 2025 at 12:53 PM CEST, Matthias Schiffer wrote:
> > All am65-cpsw controllers have a fixed TX delay, so the PHY interface
> > mode must be fixed up to account for this.
> >
> > Modes that claim to a delay on the PCB can't actually work. Warn people
> > to update their Device Trees if one of the unsupported modes is specified.
> >
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> For whatever reason, this patch is breaking network on our board
> (just transmission). We have rgmii-id in our devicetree which is now
> modified to be just rgmii-rxid. The board has a TI AM67A (J722S) with a
> Broadcom BCM54210E PHY. I'm not sure, if AM67A MAC doesn't add any
> delay or if it's too small. I'll need to ask around if there are any
> measurements but my colleague doing the measurements is on holiday
> at the moment.

I agree, we need to see if this is a AM65 vs AM67 issue. rgmii-id
would be correct if the MAC is not adding delays.

Do you have access to the datasheets for both? Can you do a side by
side comparison for the section which describes the fixed TX delay?

	Andrew



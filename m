Return-Path: <netdev+bounces-248633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FE3D0C737
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 23:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A15830076AF
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 22:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54BF341072;
	Fri,  9 Jan 2026 22:21:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389F4C2EA;
	Fri,  9 Jan 2026 22:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767997313; cv=none; b=EcxRLsWIFMaLMI4FQBoecPHAwGxjN0iWxo7+tQ7TIpnI+gwti4YgPJ0ATu5Ne1mhTtpMdsLRuXx2NpSb/x0mbYqv8HiXkpwiZPAunbgp8uF5C9P99+8r3k3zIB/K1tJddwkTYFNQHwBSJavJsq7IiKesCzsPKN/3yHHtew59xWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767997313; c=relaxed/simple;
	bh=OdU6CYBB1RxX8LM+xLtOHJYJqiSR573jb8+Ryj5sMuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKqNWAoJ8IHUcuLT5Oa3uETRKGqsEyQrVE2Yg++rVMf1W0aj3xNzmijPU2iQY6B0OfIrE4KrsInXjhkV1sJmdQtczW3thlyeQm82FCMwp5KYg+G0q70AlopYqU2k/4kMPcr6FcbjWdjYSBY1iCqqauLKhbbPvZPQtX9ofG/Zq10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1veKrW-000000002io-0hJy;
	Fri, 09 Jan 2026 22:21:42 +0000
Date: Fri, 9 Jan 2026 22:21:38 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Michael Klein <michael@fossekall.de>,
	Aleksander Jan Bajkowski <olek2@wp.pl>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/5] net: phy: realtek: simplify C22 reg access
 via MDIO_MMD_VEND2
Message-ID: <aWF_cmmcT03Q03Nv@makrotopia.org>
References: <cover.1767926665.git.daniel@makrotopia.org>
 <938aff8b65ea84eccdf1a2705684298ec33cc5b0.1767926665.git.daniel@makrotopia.org>
 <aWFz4TWNGEs7rGPF@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWFz4TWNGEs7rGPF@shell.armlinux.org.uk>

On Fri, Jan 09, 2026 at 09:32:18PM +0000, Russell King (Oracle) wrote:
> On Fri, Jan 09, 2026 at 03:03:22AM +0000, Daniel Golle wrote:
> > RealTek 2.5GE PHYs have all standard Clause-22 registers mapped also
> > inside MDIO_MMD_VEND2 at offset 0xa400. This is used mainly in case the
> > PHY is inside a copper SFP module which uses the RollBall MDIO-over-I2C
> > method which *only* supports Clause-45.
> 
> It isn't just Rollball. There are SoCs out there which have separate
> MDIO buses, one bus signals at 3.3V and can generate only clause 22
> frames. The other operates at 1.2V and can only generate clause 45
> frames.
> 
> While hardware may elect to generate and recognise either frame types
> at either voltage, this goes some way to explain why there are
> implementations that only support one or the other on a particular
> pair of MDC/MDIO wires.
> 
> Armada 8040 has this setup - there is one MDIO bus that only supports
> clause 22 frames, and there is a separate MDIO bus that only supports
> clause 45 frames.

Interesting. And a bit annoying. I wasn't aware of the electrical
difference (signal voltage).

Never the less, even with this change applied you now get a driver which
uses *only* Clause-45 access in case phydev->is_45 is true, and only
Clause-22 in case phydev->is_45 is false.

From what I understood this was the intended outcome of having two
dedicated drivers, and you can have the very same results now with a
single driver. If you would like me to broaden the commit message and
clarify this, please let me know.


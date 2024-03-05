Return-Path: <netdev+bounces-77575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD97872366
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 16:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200281F24073
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 15:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0F2127B7A;
	Tue,  5 Mar 2024 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hOX1hU/C"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3399127B67;
	Tue,  5 Mar 2024 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654371; cv=none; b=lQtvLcSt71L3ww8/E7uA4LE6dHiwI8YNpAGnbrB3UrVQp+vNc+QyfYTBUNfwyX6uqSSOb52qtkV0C4OXkj5eTPyTgzVtHhieNa3eP5hcZVLvrGzr41wUErYPcdlGz0kGcKVBBT1e85oJk9Ukgq6au/PRDHyt8yZe0DD8/jZu7BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654371; c=relaxed/simple;
	bh=iItpnO9HB22l6TPSIGEjXqZsSsW0E9L1Vp5Jr3gGztU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASVvr8xFD41C8ttjooBB2d4psE1U7WoePI8kXcl4baII0qugunOzYnY9vze65il0AJNn4dGqELh5ArzZ7iHuj2HhMPFmzKUC7ZMmp2DPszAEyt+/3mMau7oVLqSIxTiGc+cJEAjk54I6eHgMU80gdrRLuDhonqVwaPnvH7BEYfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hOX1hU/C; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5CbH98xMB39QeV6x5E8qPNDIpDvhpXOnij4KofH10cs=; b=hOX1hU/Cusfcnpy5jVYHTirOLq
	sImBKnD+SJWuspKBwUjwVTla7ARgyYgC2892X2zHj8T9FgVBaWsZRojto0geUWrY06Q5Hf0bnAsLz
	BounaFzet3EtjCVYCbJJOrzpiPbLZj3G+UdLc7hYOF2kUwcR5T3DNUsyyjQcWAlvBTLE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rhXCa-009RXt-F0; Tue, 05 Mar 2024 16:59:36 +0100
Date: Tue, 5 Mar 2024 16:59:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Eric Woudstra <ericwouds@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Lucien Jheng <lucien.jheng@airoha.com>,
	Zhi-Jun You <hujy652@protonmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 net-next 2/2] net: phy: air_en8811h: Add the Airoha
 EN8811H PHY driver
Message-ID: <641f9aec-2207-455c-a2d2-e981ea55a594@lunn.ch>
References: <20240302183835.136036-1-ericwouds@gmail.com>
 <20240302183835.136036-3-ericwouds@gmail.com>
 <e056b4ac-fffb-41d9-a357-898e35e6d451@lunn.ch>
 <aeb9f17c-ea94-4362-aeda-7d94c5845462@gmail.com>
 <Zebf5UvqWjVyunFU@shell.armlinux.org.uk>
 <0184291e-a3c7-4e54-8c75-5b8654d582b4@lunn.ch>
 <ZecrGTsBZ9VgsGZ+@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZecrGTsBZ9VgsGZ+@shell.armlinux.org.uk>

> > What i'm thinking is we add another op to phy_driver dedicated to
> > firmware download. We let probe run as is, so the PHY is registered
> > and available. But if the firmware op is set, we start a thread and
> > call the op in it. Once the op exits, we signal a completion event.
> > phy_attach_direct() would then wait on the completion.
> 
> That's really not good, because phy_attach_direct() can be called
> from .ndo_open, which will result in the rtnl lock being held while
> we wait - so this is not much better than having the firmware load
> in .config_init.

My guess is, most devices register their MDIO bus, causing the PHYs to
be probed, and then do nothing for a while until user space is up and
running, which then ifup the interfaces. So we can use that time to
start downloading the firmware. We probably end up spending less time
holding rtnl in .config_init. For NFS root, it won't help, although if
you are using NFS root, you are also likely to be TFTP booting the
kernel, so the bootloader has already downloaded the firmware to the
PHY.

	Andrew


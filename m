Return-Path: <netdev+bounces-180397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7662A8133E
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 19:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46FFE8A0BAC
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A42D22F38E;
	Tue,  8 Apr 2025 17:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WN85ll5G"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9C0191F79;
	Tue,  8 Apr 2025 17:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744132103; cv=none; b=Fk1g3qDG0eUPiE4VzcEt1BKqQWrWo3LCBT2qUSEl+z79/py1VZiE47FOs+6yRouMCbHPwVV70os3cg58Tiu/M18rKcpCTzfxIZ/14/DMETOQVGn8WrgYPmeGsPVV7+VfuOVU6ziUGZLmfSlKc1letu3c1gFI1kwWHQwnWwvdS8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744132103; c=relaxed/simple;
	bh=ISpJuPdPfR789eM2c+XnQY2Ua5fwbfPzALomy5gPpfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/yWBwtX9F0roosrXNV5U2J0VKF6+Ea9HOZ+MLcmZMBOxUN9huU+ehWvVYHBaLQCat9yNDV5+HEEPOHEgxF8VLLO5NTsQnT0yEPp2QYQ0j3zkMjmew1BMj2zKE3PVi7wytMP32dcNwfxrHwjppCYrUvVTcud1NG0q7l5//iGp1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WN85ll5G; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=m6Zahi0sarElgNiROhFmUN7IZ3Qj0JsjaKqp3OqQl2s=; b=WN85ll5GnP8jm4E5CPBNiYzgcw
	Nv//yxrxKFc0F5lxcSLQv23LrGyGOuzPv5ortcl1X5SXrJtaoEfCjwvmA5DWY81euYVe2P5nvI/Ph
	Frgbh6motOShBQOA+igX6ZZT+N3HCHRS6g4pOeTuLjHYsbBka1YP1pNeP3D27uZ+Hymo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u2CQb-008QXY-97; Tue, 08 Apr 2025 19:08:01 +0200
Date: Tue, 8 Apr 2025 19:08:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Simon Horman <horms@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.or
Subject: Re: [net-next PATCH 2/2] net: phy: mediatek: add Airoha PHY ID to
 SoC driver
Message-ID: <7e60d851-1b70-4084-a63f-c8ff7bf81425@lunn.ch>
References: <20250408155321.613868-1-ansuelsmth@gmail.com>
 <20250408155321.613868-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408155321.613868-2-ansuelsmth@gmail.com>

On Tue, Apr 08, 2025 at 05:53:14PM +0200, Christian Marangi wrote:
> Airoha AN7581 SoC ship with a Switch based on the MT753x Switch embedded
> in other SoC like the MT7581 and the MT7988. Similar to these they
> require configuring some pin to enable LED PHYs.
> 
> Add support for the PHY ID for the Airoha embedded Switch and define a
> simple probe function to toggle these pins. Also fill the LED functions
> and add dedicated function to define LED polarity.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


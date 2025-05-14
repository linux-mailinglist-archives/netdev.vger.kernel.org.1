Return-Path: <netdev+bounces-190395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF47AB6B1C
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 14:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B99C3B1A70
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 12:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142DB27702D;
	Wed, 14 May 2025 12:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FPZ4rhXT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A8D276056;
	Wed, 14 May 2025 12:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747224586; cv=none; b=EyVaTf1gZlGowdo9oz2oZUQgnbGcwB7FXkiLWjHtO0qD6zr+EdCUOwvGWi5nhYjX7LG5IkVkjSR6fAWWIQZCRFoYngrkzcZRPy1yQm856umrTCvYpi2DQpvNkWyzXdwy3atshPHU2p4+105tsdwJpc6fjVjJJwAL96IFHY5YZJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747224586; c=relaxed/simple;
	bh=K/9Izu9qiN2K04mZ6Vdme5/q9/qVGbNktQh7S1wszeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=df0tnF0bjd2sAS8LLqUpzEYcQ5nr6OgjCNFfKKIMi1RBOwiIJC4pWxnhasvQYYP1kjxvforJ9pX6d8RYj6KXrPai66Qjrgx1+0pMZgvQznfowbca2DskWOdcVzUMHn+Zco8xmNY53fuwLfskJhx1KwuE3s0BaK8Qm+jlwqOrtgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FPZ4rhXT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gR0lq2R8NskzCfbSMLb8IMLoPerOeBsRsJsnYVXF+4s=; b=FPZ4rhXTiKsUN3Trjl9BvKpKQu
	oAbXd3SqCcB9iceCXJxRpyGZDqADqKWzvqIO43OZ+MrDU1+FyAtVczJyqlcruLupGYu7l6eHgy75s
	cTbdb0R8ZGmxqmT51E2MsC+6saVq2qKm/yyfEtuIxxbxuxlNj3Vu2ve8CZKdvjGp9/Ug=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uFAvM-00CYMX-QN; Wed, 14 May 2025 14:09:24 +0200
Date: Wed, 14 May 2025 14:09:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	balika011 <balika011@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next v3 1/2] net: phy: mediatek: Sort config and file
 names in Kconfig and Makefile
Message-ID: <2147e0e3-44c0-4fd8-916d-53291dc86a6a@lunn.ch>
References: <20250514105738.1438421-1-SkyLake.Huang@mediatek.com>
 <20250514105738.1438421-2-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514105738.1438421-2-SkyLake.Huang@mediatek.com>

On Wed, May 14, 2025 at 06:57:37PM +0800, Sky Huang wrote:
> From: Sky Huang <skylake.huang@mediatek.com>
> 
> Sort config and file names in Kconfig and Makefile in
> drivers/net/phy/mediatek/ according to sequence in MAINTAINERS.

If you use "make menuconfig" you will notice PHYs are sorted by
tristate string. So having Gigabit before Soc is correct.

> --- a/drivers/net/phy/mediatek/Makefile
> +++ b/drivers/net/phy/mediatek/Makefile
> @@ -1,4 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_MEDIATEK_GE_SOC_PHY)	+= mtk-ge-soc.o
>  obj-$(CONFIG_MTK_NET_PHYLIB)		+= mtk-phy-lib.o
>  obj-$(CONFIG_MEDIATEK_GE_PHY)		+= mtk-ge.o
> -obj-$(CONFIG_MEDIATEK_GE_SOC_PHY)	+= mtk-ge-soc.o

These should be in alphabetic order based on CONFIG_. So
CONFIG_MTK_NET_PHYLIB is what should move.

    Andrew

---
pw-bot: cr


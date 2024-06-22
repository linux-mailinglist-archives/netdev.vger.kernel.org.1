Return-Path: <netdev+bounces-105871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54761913560
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 19:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04F651F229A8
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 17:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BCF219E4;
	Sat, 22 Jun 2024 17:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lyHmkqkx"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C506718651;
	Sat, 22 Jun 2024 17:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719077532; cv=none; b=ClEo+R9L0rnkL7EPNIk/GNCPUflrjKZTIr3aSp8JJEixqypzwOz2rpabDS9SKoI+nepHbIk7YquRAfvQ9zdJL/xgSfufmezRyUJzFMNEdrCt5Q9w3iTd+bcRHpH84HEA3WjpsJqJDqxwJYD/dIioc9c5jeQnogeX74sfj0ddDB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719077532; c=relaxed/simple;
	bh=0iV0yVaCXJj6EeCVbMHqnK8b7v5m8l3zJJeOMyE9cII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZV6EVdDHdL1/lH6RFBi+IDnmOhqfaYl/djCAkwwhai/9YmmfNazzrN5P3YM5HhU3nLgVSNLtowhnFM0ekwjqQXlEIfrjGAZvZAx6NF5L3L0DRBx4VMuedA4dO4JupzOVznbcROVLKBO/fIKN51RtbrMfRlHcXdOKdLRvoIaPaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lyHmkqkx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=my4hZnL32V+SMN5dS2dc7S3j2Y/FVoAYeGfakbx4Qj4=; b=lyHmkqkxMhH2homFvP09/othi2
	olglnMnZ9rhuby8GkjyUjIJxydNMCEXG4eOk193xahKZo5C2RjHzCTTHlhca2FNK/PWxR18fZ4F4z
	kAB+hYuEYPcbDwAoAtNxWdBwp5MGBhIKsNoL+7xYXyGc8hCiAPe1a4t9qAExl8FPviFI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sL4ao-000k2U-3t; Sat, 22 Jun 2024 19:32:02 +0200
Date: Sat, 22 Jun 2024 19:32:02 +0200
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
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next v8 07/13] net: phy: mediatek: add MT7530 &
 MT7531's PHY ID macros
Message-ID: <9515b596-c151-4e46-95f1-768e76de34cc@lunn.ch>
References: <20240621122045.30732-1-SkyLake.Huang@mediatek.com>
 <20240621122045.30732-8-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621122045.30732-8-SkyLake.Huang@mediatek.com>

On Fri, Jun 21, 2024 at 08:20:39PM +0800, Sky Huang wrote:
> From: "SkyLake.Huang" <skylake.huang@mediatek.com>
> 
> This patch adds MT7530 & MT7531's PHY ID macros in mtk-ge.c so that
> it follows the same rule of mtk-ge-soc.c.
> @@ -170,9 +173,10 @@ static struct phy_driver mtk_gephy_driver[] = {
>  		.resume		= genphy_resume,
>  		.read_page	= mtk_phy_read_page,
>  		.write_page	= mtk_phy_write_page,
> +		.led_hw_is_supported = mt753x_phy_led_hw_is_supported,

Was this intentional. It does not fit the commit message, so i wounder
if it should be somewhere else?

Otherwise:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


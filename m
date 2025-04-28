Return-Path: <netdev+bounces-186430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B21A9F178
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 14:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3F9D3B16C5
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 12:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57E52222A0;
	Mon, 28 Apr 2025 12:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TyTI+CiJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BED71F8AC5;
	Mon, 28 Apr 2025 12:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745844849; cv=none; b=VJb7E+beKp4IAgJcOWf+S2QSV+FomVRg+vkle1MQvgazILqc3O51uJRuAUN3WitpAYvqFWznMSfQPUnXFx50atA/1o1uekhrsYEbCqZSwg62VqfTFz8DdzP4AO0KZ8P2tD5TbOInKjK+lgZ4KpzgcKd9zDwx3ojEE2BVCJXFkCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745844849; c=relaxed/simple;
	bh=ljVmkwfyBpxbZuNNqkJ6Uc4gcwYncJlBYXT65/Ip3V8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqWrlXbhRhK7Br5VXgRJ2YuAbhQla2mLa0g4RyBOdYUyGTtt2uPRH1vfFoliE2S2J1mVzWzyxNl+7p29OsbrMeqZVRFXFeAUtVS3XqhfadHNgfJW74lhD20NR4gJ72Bt1UpNbN2qGozUNHCTrwOR6NAZuHyZIpeehUWWZk6gVDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TyTI+CiJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KuthMj4SVMiZzJYTH3vd30SFc9+oF/zdEInnc/IAW3I=; b=TyTI+CiJ2BuRPrHGUpV3WnqfK5
	pQHGHEiVzGirZafi2MBTbScvTMlVUkWI4B1Uq1BlJQGwXJUP0ZBrOMQ08AFtFSVdok8NwhLo7IrD9
	srcEU0Yf9668WCud4JinfuHuAEnFCMxouxXhdBk96mxRhIORVK61LG5lhfsDg+kwHsjA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u9Nzf-00Apzo-1Z; Mon, 28 Apr 2025 14:53:55 +0200
Date: Mon, 28 Apr 2025 14:53:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: daniel.braunwarth@kuka.com
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: realtek: Add support for WOL magic
 packet on RTL8211F
Message-ID: <39f9fa02-7fa9-4246-aaa5-2f14d6319f90@lunn.ch>
References: <20250428-realtek_wol-v1-1-15de3139d488@kuka.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428-realtek_wol-v1-1-15de3139d488@kuka.com>

> +static void rtl8211f_get_wol(struct phy_device *dev, struct ethtool_wolinfo *wol)
> +{
> +	struct rtl821x_priv *priv = dev->priv;
> +
> +	wol->supported = WAKE_MAGIC;
> +	wol->wolopts = priv->saved_wolopts;

Can the current configuration be read from the hardware, rather than
using a cached value. The BIOS could for example enable magic packet,
and Linux inherits it.

> +static int rtl8211f_set_wol(struct phy_device *dev, struct ethtool_wolinfo *wol)
> +{
> +	struct rtl821x_priv *priv = dev->priv;
> +	const u8 *mac_addr = dev->attached_dev->dev_addr;
> +	int oldpage;
> +
> +	oldpage = phy_save_page(dev);
> +	if (oldpage < 0)
> +		goto err;
> +
> +	if (wol->wolopts & WAKE_MAGIC) {
> +		/* Store the device address for the magic packet */
> +		rtl821x_write_page(dev, 0xd8c);

Does the datasheet have names for these magic values? Please add
#defines.

	Andrew


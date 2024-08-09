Return-Path: <netdev+bounces-117216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECE494D201
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 16:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3352B2815C5
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 14:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC94196D98;
	Fri,  9 Aug 2024 14:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="l8FsXVL/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDFD183CD5;
	Fri,  9 Aug 2024 14:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723213087; cv=none; b=C6Cj1AX0PkTEMO901DMmSJU1glk4iAunROvmdtVIcwps48FssU0oJSSjaV0eo4yfIF56SWpyL7ZbO+Hk03LHoI4u6Cbe9VlDYIdZD/P9ee+Ojaejrh8Qls5BSxWXK8bdnYG1xDo7OZ+qJ3IUvDmgAaCD3TXVBL2l5wHLVMwFFsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723213087; c=relaxed/simple;
	bh=Xe6VQcR13IR5xdJepGS5KXMJ0C8Fv6emTHCwiKDrpDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRd5biZqZ6MWTK4vVmjUWgb/LCk2sSZatWIRcvKv3FQjC4rrc5Y1A2K1m72Rpg+CIXP6sHMd6a7BrgGm6/dwloxD+CcrvyWj64lcwdXU0J39AoxwsKiUozSj7DCIp6szWYPohaTJxSs1G0oLcoxUnYvc4CTRjD7/BjvexiNDmLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=l8FsXVL/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vki4wtnHRXTTskSJFhd+KIf6rSnsqvEzjaOpn0X3xQc=; b=l8FsXVL/pau0I+mwggEpPFkvxo
	gNtlpPd49bNoRAhKXlO7llgDiSQZynrvymwVOZ8i/tZhNCFP4sA3yVR+Cbvmh6CS1zDGpPuZ1AS6b
	/XV88Owx0175FrEmgyKVNQzFgB2MZuPCrMpQCC6CLN9lmnIhDOhz9WNLG3iN/xMoUSbY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1scQRE-004NvL-7s; Fri, 09 Aug 2024 16:17:52 +0200
Date: Fri, 9 Aug 2024 16:17:52 +0200
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
Subject: Re: [PATCH net-next v10 11/13] net: phy: add driver for built-in
 2.5G ethernet PHY on MT7988
Message-ID: <ebeb75a3-a6b1-46b3-b1e8-7d8448eb23f6@lunn.ch>
References: <20240701105417.19941-1-SkyLake.Huang@mediatek.com>
 <20240701105417.19941-12-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701105417.19941-12-SkyLake.Huang@mediatek.com>

> +static int mt798x_2p5ge_phy_config_aneg(struct phy_device *phydev)
> +{
> +	bool changed = false;
> +	u32 adv;
> +	int ret;
> +
> +	/* In fact, if we disable autoneg, we can't link up correctly:
> +	 * 2.5G/1G: Need AN to exchange master/slave information.
> +	 * 100M/10M: Without AN, link starts at half duplex (According to
> +	 *           IEEE 802.3-2018), which this phy doesn't support.
> +	 */
> +	if (phydev->autoneg == AUTONEG_DISABLE)
> +		return -EOPNOTSUPP;

I assume you have seen Russells patches in this area. Please could you
test and review them. Depending on which gets merged, you might need
to come back and clean this up later.

   Andrew


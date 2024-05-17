Return-Path: <netdev+bounces-97045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8448C8EAF
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 01:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 347DD1F21CCA
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 23:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28091411F3;
	Fri, 17 May 2024 23:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NI8N36hk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074E21E532;
	Fri, 17 May 2024 23:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715989426; cv=none; b=QX4VsGcIq6cYfeSQulj6wQBjw2a79uMmLOb+lj1KIrsppLaoNc0Pj1yx+DKk95ZS/9TByNqR0rvDM71KQVfzrKHeZUl/w5nlsmTNJOvkHtv1QarZVD6rZFi4choSXZGOTeUgmfLi4H/RmHmEeaQiat3z0494W890aUN5+Ql2JgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715989426; c=relaxed/simple;
	bh=SUJNIfxCBNQFiBrC8tFj+egOdR1XQPQFhxzFYVcVbvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGOfKGFNd6QOVM1MD3TonDVARQWhlEiKVH/h92u07icCcVFKN4h7unZaJiElDM8Xtlaw0rXKZjzmvbI6qzyRa7PcoD0ZTisteMH61eVVFQmxkHVnCEMrjS5BDp9OusPU6EbhTn/6jByWfD2ckTxc9cHf58829KyJnMsqmdJFavw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NI8N36hk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2v1/YXR2GimaLG5uR1GGycdNdXwLlVivQdeAFA74MKY=; b=NI8N36hk3w1HBCPBgYWVnuTdlU
	MN8Jb6YqDUjkgQWyBkeFvHzmmqRZz4DDcjHWIv2z3Yw97fVCuPPTzQJj64sxUNfcdvAHFdrCeP0cB
	HLlQbW4Tt2zfmgBaj8IJZWx1b5FoQpTsvM3V/W44EGW1j6VIdnwjjrAkwlgxmNBuFcVs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s87EJ-00FbJa-LE; Sat, 18 May 2024 01:43:15 +0200
Date: Sat, 18 May 2024 01:43:15 +0200
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
Subject: Re: [PATCH net-next v2 4/5] net: phy: mediatek: Extend 1G TX/RX link
 pulse time
Message-ID: <d4a99edc-e514-4a18-9d85-0355ddf4686a@lunn.ch>
References: <20240517102908.12079-1-SkyLake.Huang@mediatek.com>
 <20240517102908.12079-5-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517102908.12079-5-SkyLake.Huang@mediatek.com>

> +int mtk_gphy_cl22_read_status(struct phy_device *phydev)
> +{
> +	int err, old_link = phydev->link;
> +	int mii_ctrl;
> +
> +	/* Update the link, but return if there was an error */
> +	err = genphy_update_link(phydev);
> +	if (err)
> +		return err;
> +
> +	/* why bother the PHY if nothing can have changed */
> +	if (phydev->autoneg == AUTONEG_ENABLE && old_link && phydev->link)
> +		return 0;
> +
> +	phydev->master_slave_get = MASTER_SLAVE_CFG_UNSUPPORTED;
> +	phydev->master_slave_state = MASTER_SLAVE_STATE_UNSUPPORTED;
> +	phydev->speed = SPEED_UNKNOWN;
> +	phydev->duplex = DUPLEX_UNKNOWN;
> +	phydev->pause = 0;
> +	phydev->asym_pause = 0;
> +
> +	if (phydev->is_gigabit_capable) {
> +		err = genphy_read_master_slave(phydev);
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	err = genphy_read_lpa(phydev);
> +	if (err < 0)
> +		return err;
> +
> +	if (phydev->autoneg == AUTONEG_ENABLE) {
> +		if (phydev->autoneg_complete) {
> +			phy_resolve_aneg_linkmode(phydev);
> +		} else {
> +			mii_ctrl = phy_read(phydev, MII_CTRL1000);
> +			if ((mii_ctrl & ADVERTISE_1000FULL) || (mii_ctrl & ADVERTISE_1000HALF))
> +				extend_an_new_lp_cnt_limit(phydev);

This all looks very similar to genphy_read_status(), except these
three.

Would it be possible to call genphy_read_status() to do most of the
work, and then do these couple of lines of code.

      Andrew


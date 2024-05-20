Return-Path: <netdev+bounces-97197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B5B8C9DF8
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 15:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E5D91C2147F
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 13:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5767154789;
	Mon, 20 May 2024 13:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XrQkqERh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F0C1CD18;
	Mon, 20 May 2024 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716211069; cv=none; b=Gs2eb9IKv416fCFugFRfJwFCcFWU9NQWCAefeD9m/8bjngTRvUHgJjK2V3AGyLfuBdGgglwZspBdtgoMd+lNXCIW3OPhk+a2X7pr3RB1vEC4eH2fUxcFbmOv5yGMuMXM3h9iMekTryQynJMl9wMRgk1eVEhoa7by2X8C65h5Buk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716211069; c=relaxed/simple;
	bh=2pc9eb/n0fggHWJGm7ZPYFjRKT4X2r90jaagBTnGttA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOaZa0VM5lbF6miFKV0ZfVT9wiCZXfnXHnqb+nBe8O36PRh3iyudSBWv/M/OzWSMH2/Nw/3CnTfJQ1AHODkMMrx2Ztpx+ttDpejdOXi3skcv4h/LUHs9ii9lUZ2Eiu33T2vIh/HdSZsNsQEkha6YL2AbaLyzbornD0Os3HwJ1EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XrQkqERh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kBepfuRSnR60+uXpcB5dLLA7csPWcskh8ZUNfZDMcXI=; b=XrQkqERh5PY8JuDZ54IBjmYc/S
	OzyanipZZToOSnM3CT9RqesnTEe7B0Jyqt1grcLwm8aDN+oJtl4WJbPB7bnKL9VS+SMFDkY+Vxnfv
	RKQ9FZI+7i1LHL6p064EIw20vAMW/04AgUsPWZkkHiEeFhbvQgVk3eiKbJNRgeqBxWok=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s92tR-00FhLz-AJ; Mon, 20 May 2024 15:17:33 +0200
Date: Mon, 20 May 2024 15:17:33 +0200
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
Subject: Re: [PATCH net-next v3 4/5] net: phy: mediatek: Extend 1G TX/RX link
 pulse time
Message-ID: <5389c04a-40ff-44a1-9592-05c6dc1a9636@lunn.ch>
References: <20240520113456.21675-1-SkyLake.Huang@mediatek.com>
 <20240520113456.21675-5-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520113456.21675-5-SkyLake.Huang@mediatek.com>

> +static void extend_an_new_lp_cnt_limit(struct phy_device *phydev)
> +{
> +	int mmd_read_ret;
> +	int ret;
> +	u32 reg_val;
> +
> +	ret = read_poll_timeout(mmd_read_ret = phy_read_mmd, reg_val,
> +				(mmd_read_ret < 0) || reg_val & MTK_PHY_FINAL_SPEED_1000,
> +				10000, 1000000, false, phydev,
> +				MDIO_MMD_VEND1, MTK_PHY_LINK_STATUS_MISC);
> +	if (mmd_read_ret < 0)
> +		ret = mmd_read_ret;
> +	/* If final_speed_1000 is raised, try to extend timeout period
> +	 * of auto downshift.
> +	 */
> + if (!ret) {

If you look at other Linux code, the general pattern is to look if a
function returned an error. If it does, either return immediately, or
jump to the end of the function where the cleanup is.

Since this is a void function:

> +	if (mmd_read_ret < 0)
> +		return;

And then you don't need the

> + if (!ret) {


> +		tr_modify(phydev, 0x0, 0xf, 0x3c, AN_NEW_LP_CNT_LIMIT_MASK,
> +			  FIELD_PREP(AN_NEW_LP_CNT_LIMIT_MASK, 0xf));
> +		mdelay(1500);
> +
> +		ret = read_poll_timeout(mmd_read_ret = tr_read, reg_val,
> +					(mmd_read_ret < 0) ||
> +					(reg_val & AN_STATE_MASK) !=
> +					(AN_STATE_TX_DISABLE << AN_STATE_SHIFT),
> +					10000, 1000000, false, phydev,
> +					0x0, 0xf, 0x2);
> +
> +		if (mmd_read_ret < 0)
> +			ret = mmd_read_ret;
> +
> +		if (!ret) {

This if can also be removed.

> +			mdelay(625);
> +			tr_modify(phydev, 0x0, 0xf, 0x3c, AN_NEW_LP_CNT_LIMIT_MASK,
> +				  FIELD_PREP(AN_NEW_LP_CNT_LIMIT_MASK, 0x8));
> +			mdelay(500);
> +			tr_modify(phydev, 0x0, 0xf, 0x3c, AN_NEW_LP_CNT_LIMIT_MASK,
> +				  FIELD_PREP(AN_NEW_LP_CNT_LIMIT_MASK, 0xf));
> +		}
> +	}

One question i have is, should this really be a void function? What
does it mean if read_poll_timeout() returns an error? Why is it safe
to ignore it? Why not return the error?

> +}
> +
> +int mtk_gphy_cl22_read_status(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = genphy_read_status(phydev);
> +	if (ret)
> +		return ret;
> +
> +	if (phydev->autoneg == AUTONEG_ENABLE && !phydev->autoneg_complete) {
> +		ret = phy_read(phydev, MII_CTRL1000);
> +		if ((ret & ADVERTISE_1000FULL) || (ret & ADVERTISE_1000HALF))
> +			extend_an_new_lp_cnt_limit(phydev);
> +	}
> +
> +	return 0;

If extend_an_new_lp_cnt_limit() fails, what does it mean? Do we
actually want mtk_gphy_cl22_read_status() to indicate something has
gone wrong? Or does extend_an_new_lp_cnt_limit() failing not matter?

	Andrew


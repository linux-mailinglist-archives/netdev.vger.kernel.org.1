Return-Path: <netdev+bounces-245655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1870ACD459A
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 21:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83FFE30057D3
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 20:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411863090EB;
	Sun, 21 Dec 2025 20:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XLykvq0P"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899A71FC0EF;
	Sun, 21 Dec 2025 20:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766348978; cv=none; b=HjZ03WsWw4xWrZgMqu3cFbvvsJFV5VE64cyZ/2slU7rAxyMYHXUWQIh29KLCWcU9X4Lj2tmay5i+mX3HOGe+DqOUZdW9eWhSVn9RTJreLHnoN2zk76nxvHWwMinvZKEjojED1phHKFC+ugS4C8S45qBqsbTAye/ofCfkc87ZzFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766348978; c=relaxed/simple;
	bh=wpjud/DML7ZdFV1/4BvPN/b+8Qm25K0rqeX5Yfk2V10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwIjQ3Uvp8qW5XdpuW5KRLzfCZ55uPwwBqUtrMWYatkDL4YdBAVhHcCClGs7gAvdCU8g7J5VTNh2qgQI2ln10dS7Xcb6WOKHH5XeVeKnRYoVUwIWskVsBcTovT5qSPelUmQt6aJmB2uts2DgFDWFzaU2WjrsndVln8YJtFRaMnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XLykvq0P; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iXlgYh0CQtosUN+iPFR2GAsQw4bjRf0NFv+vaUVqhIs=; b=XLykvq0Pvo/cpzO08bPp3u673u
	Qr8S4Nq7TSrI1P2fmSn/Eu/ft+hH60Pw/nU6kLCQkNZrgkepPGrxzY8/NJJr1G6rh5NtY3ioy1Xfk
	Sxzk1nCoRKuQaPUF/lVRSkG1m883g08VjBplWUKff3zz4zJYBPTi+8Qt+h8aDXEmMC3E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vXQ33-0006lm-WD; Sun, 21 Dec 2025 21:29:02 +0100
Date: Sun, 21 Dec 2025 21:29:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yao Zi <me@ziyao.cc>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Chen-Yu Tsai <wens@csie.org>, Jisheng Zhang <jszhang@kernel.org>,
	Furong Xu <0x1207@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>
Subject: Re: [RFC PATCH net-next v4 1/3] net: phy: motorcomm: Support YT8531S
 PHY in YT6801 Ethernet controller
Message-ID: <5365dc9f-310a-4532-9987-ae0e1849f46b@lunn.ch>
References: <20251216180331.61586-1-me@ziyao.cc>
 <20251216180331.61586-2-me@ziyao.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216180331.61586-2-me@ziyao.cc>

On Tue, Dec 16, 2025 at 06:03:29PM +0000, Yao Zi wrote:
> YT6801's internal PHY is confirmed as a GMII-capable variant of YT8531S
> by a previous series[1] and reading PHY ID. Add support for
> PHY_INTERFACE_MODE_GMII for YT8531S to allow the Ethernet driver to
> reuse the PHY code for its internal PHY.
> 
> Link: https://lore.kernel.org/all/a48d76ac-db08-46d5-9528-f046a7b541dc@motor-comm.com/ # [1]
> Co-developed-by: Frank Sae <Frank.Sae@motor-comm.com>
> Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>
> ---
>  drivers/net/phy/motorcomm.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
> index 89b5b19a9bd2..b751fbc6711a 100644
> --- a/drivers/net/phy/motorcomm.c
> +++ b/drivers/net/phy/motorcomm.c
> @@ -910,6 +910,10 @@ static int ytphy_rgmii_clk_delay_config(struct phy_device *phydev)
>  		val |= FIELD_PREP(YT8521_RC1R_RX_DELAY_MASK, rx_reg) |
>  		       FIELD_PREP(YT8521_RC1R_GE_TX_DELAY_MASK, tx_reg);
>  		break;
> +	case PHY_INTERFACE_MODE_GMII:
> +		if (phydev->drv->phy_id != PHY_ID_YT8531S)
> +			return -EOPNOTSUPP;
> +		break;

You have a break here. So the write to RGMII delay register will be
performed, even thought this is an GMII PHY. Does the register exists?
Would it be better to just return 0;

      Andrew


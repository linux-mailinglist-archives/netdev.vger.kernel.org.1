Return-Path: <netdev+bounces-46609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2354C7E55FB
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 13:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AED951F2183D
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 12:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D972171D2;
	Wed,  8 Nov 2023 12:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l6ldWBYn"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EB6171BB
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 12:12:56 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3A31BEE;
	Wed,  8 Nov 2023 04:12:55 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 157B7E0009;
	Wed,  8 Nov 2023 12:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1699445573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q9hjJhQDtQb/mOVqql7uBP6GEHGD2KS3+D+itPlv0iA=;
	b=l6ldWBYnuO/VeVFb4/lPVCXp3yDTZi+LCgJ7mJ/n+6Dfk/nviujapsZ7Lx2Klc6LVe+1wl
	dtrVJ1Jp6hLKi6UNNtT47129qFeBfKhDbLOGPY3xxd3Hd1Rpwh711nuPKPauz1K/jrJ4QO
	siH5KHC/4f1mOH/BXPwFu3KanQnZKNxRSCQt2kEozu37/KNbtSXaDgeIimMzq2hOWnP5tD
	EYDRg/h/AcI02czYht52Th7z9LnwtqigdHX3Oc+DmDtsi7GiieJtFyEkY5duIZ3CmcLnAu
	E1iB5aub1nSquUvmGjiPRTZu6ukpYMtoWns4mxY1mx5agrKPxTqQWgcfJWfSiw==
Date: Wed, 8 Nov 2023 13:12:50 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Luo Jie <quic_luoj@quicinc.com>
Cc: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] net: phy: at803x: add QCA8084 ethernet phy
 support
Message-ID: <20231108131250.66d1c236@fedora>
In-Reply-To: <20231108113445.24825-2-quic_luoj@quicinc.com>
References: <20231108113445.24825-1-quic_luoj@quicinc.com>
	<20231108113445.24825-2-quic_luoj@quicinc.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello,

On Wed, 8 Nov 2023 19:34:43 +0800
Luo Jie <quic_luoj@quicinc.com> wrote:

> Add qca8084 PHY support, which is four-port PHY with maximum
> link capability 2.5G, the features of each port is almost same
> as QCA8081 and slave seed config is not needed.
> 
> Three kind of interface modes supported by qca8084.
> PHY_INTERFACE_MODE_QUSGMII, PHY_INTERFACE_MODE_2500BASEX and
> PHY_INTERFACE_MODE_SGMII.
> 
> The PCS(serdes) and clock are also needed to be configured to
> bringup qca8084 PHY, which will be added in the pcs driver.
> 
> The additional CDT configurations used for qca8084.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  drivers/net/phy/at803x.c | 48 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)

[...]

> @@ -1824,6 +1828,21 @@ static int qca808x_read_status(struct phy_device *phydev)
>  		return ret;
>  
>  	if (phydev->link) {
> +		/* There are two PCSs available for QCA8084, which support the following
> +		 * interface modes.
> +		 *
> +		 * 1. PHY_INTERFACE_MODE_QUSGMII utilizes PCS1 for all available 4 ports,
> +		 * which is for all link speeds.
> +		 *
> +		 * 2. PHY_INTERFACE_MODE_2500BASEX utilizes PCS0 for the fourth port,
> +		 * which is only for the link speed 2500M same as QCA8081.
> +		 *
> +		 * 3. PHY_INTERFACE_MODE_SGMII utilizes PCS0 for the fourth port,
> +		 * which is for the link speed 10M, 100M and 1000M same as QCA8081.
> +		 */
> +		if (phydev->interface == PHY_INTERFACE_MODE_QUSGMII)
> +			return 0;
> +

What I understand from this is that this PHY can be used either as a
switch, in which case port 4 would be connected to the host interface
at up to 2.5G, or as a quad-phy, but since it uses QUSGMII the link
speed would be limited to 1G per-port, is that correct ?

However the get_features function seems to build the supported modes
set by reading some capabilities registers : 

static int qca808x_get_features(struct phy_device *phydev)
{
[...]
	ret = phy_read_mmd(phydev, MDIO_MMD_AN, QCA808X_PHY_MMD7_CHIP_TYPE);
	if (ret < 0)
		return ret;

	if (QCA808X_PHY_CHIP_TYPE_1G & ret)
		linkmode_clear_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->supported);
[...]
}

Wouldn't port 4 report 2.5G capabilities then ? Maybe you need to
mask-out the 2.5G bit if the interface is qusgmii.

Best regards,

Maxime


Return-Path: <netdev+bounces-211467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B58E1B18FB9
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 21:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EE72AA1582
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 19:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDE52580CF;
	Sat,  2 Aug 2025 18:59:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9943F2561C5
	for <netdev@vger.kernel.org>; Sat,  2 Aug 2025 18:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754161199; cv=none; b=r5yo1oPxAAfI/EOJ/UKwuzF1lEgPAH6OxCbHiTknMHeTdpSHnFTn/Jeu00DqvG7mNrYzIWMCxR8TCSefd9y7XLT88morXvVedz2HY1pVplFgKnDtLcm5XsEoVRVh6rMuHIDK3ucuoRp0j7afeRbQMnRRACyWHETppYrv7QXpHOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754161199; c=relaxed/simple;
	bh=zS0HkYliP/Jb4w/PyKaW2rKnqoeREt2JEBWd2hTP/hA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjmWyuV1uu12Ky7E2gpxVnMIKrMwM42gCl4MTnTggbaZMu3t3D0KhPPtKdGmj5ksAen2qRPBm8wzqy/8+Noo+ePfxU8rCD4V2pmqyG6YT8jzombDG6tflXLyD67ijLqQtd/Ha0S5/hCh2D+HQr80gJ6+nzRjfB9iQOhSLNdbqZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uiHS5-0003Rb-Br; Sat, 02 Aug 2025 20:59:29 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uiHS2-00BaKR-05;
	Sat, 02 Aug 2025 20:59:26 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uiHS1-0044Ok-2p;
	Sat, 02 Aug 2025 20:59:25 +0200
Date: Sat, 2 Aug 2025 20:59:25 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Tristram.Ha@microchip.com
Cc: Oleksij Rempel <linux@rempel-privat.de>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: microchip: Fix KSZ8863 reset problem
Message-ID: <aI5gDWqMBBtESscm@pengutronix.de>
References: <20250802002253.5210-1-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250802002253.5210-1-Tristram.Ha@microchip.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi,

On Fri, Aug 01, 2025 at 05:22:53PM -0700, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> ksz8873_valid_regs[] was added for register access for KSZ8863/KSZ8873
> switches, but the reset register is not in the list so
> ksz8_reset_switch() does not take any effect.
> 
> ksz_cfg() is updated to display an error so that there will be a future
> check for adding new register access code.
> 
> A side effect of not resetting the switch is the static MAC table is not
> cleared.  Further additions to the table will show write error as there
> are only 8 entries in the table.

Thank you for fixing it!

> Fixes: d0dec3333040 ("net: dsa: microchip: Add register access control for KSZ8873 chip")
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> ---
>  drivers/net/dsa/microchip/ksz8.c       | 7 ++++++-
>  drivers/net/dsa/microchip/ksz_common.c | 1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
> index 76e490070e9c..6d282a8e3684 100644
> --- a/drivers/net/dsa/microchip/ksz8.c
> +++ b/drivers/net/dsa/microchip/ksz8.c
> @@ -36,7 +36,12 @@
>  
>  static void ksz_cfg(struct ksz_device *dev, u32 addr, u8 bits, bool set)
>  {
> -	regmap_update_bits(ksz_regmap_8(dev), addr, bits, set ? bits : 0);
> +	int ret;
> +
> +	ret = regmap_update_bits(ksz_regmap_8(dev), addr, bits, set ? bits : 0);
> +	if (ret)
> +		dev_err(dev->dev, "can't update reg 0x%x: %pe\n", addr,
> +			ERR_PTR(ret));

Better using ksz_rmw8() instead. It is already providing error message.

In this file there is 4 direct accesses to regmap_update_bits() without
error handling. It would be great if you have chance to replace it with
ksz_rmw8() too.

>  }
>  
>  static void ksz_port_cfg(struct ksz_device *dev, int port, int offset, u8 bits,
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index 7292bfe2f7ca..4cb14288ff0f 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -1447,6 +1447,7 @@ static const struct regmap_range ksz8873_valid_regs[] = {
>  	regmap_reg_range(0x3f, 0x3f),
>  
>  	/* advanced control registers */
> +	regmap_reg_range(0x43, 0x43),

This register is no documented in the public documentation. Out of
curiosity, are there some where more information about this two
"reserved" register ranges: 0x3A-0x3E and 0x40-0x5F?

Best regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


Return-Path: <netdev+bounces-147201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A74C89D8357
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 11:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29552285555
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 10:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7C41917F9;
	Mon, 25 Nov 2024 10:27:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31707191F7E
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 10:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732530454; cv=none; b=oCfIi966y4dsEeXa4HjAwXMI6Z6wJv7kLOyajM8NssVP/54kam2xflgw0fFRyuHsbKsWehekq80eB5SkGZ7hWtspY6f151nJdDDstKbQ5cqIBVkdsMkk6iDQCDycwshfVhouWoMvhqR3Md1JJltsettHQTiDUHcBrAPK2yz8Wxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732530454; c=relaxed/simple;
	bh=IlATpwwyy7Ekk3P/+rNRCeiVAYye5eYylou2gWkmA5k=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nu2/8T0JggTSOPUtHtMqAA7URc7jHUdiwHwF0tVASFc6tNCtxg0dAqqJgqgx2EStH7rBR038CBolnzS71eHyyIzU0gsR3cDMkpp1pxc1uXzrxm0Cz/yRUuR7OJ5fmRrrwrubvxqvcqtdgSLfyjZXscRWWEEN+Ehexcru6PKn2sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tFWJK-0000au-JV; Mon, 25 Nov 2024 11:27:18 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tFWJH-0003zr-0b;
	Mon, 25 Nov 2024 11:27:15 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tFWJH-000CoY-2r;
	Mon, 25 Nov 2024 11:27:15 +0100
Message-ID: <32a2d3d7f95a4f865ce4b49b4f8246587be48128.camel@pengutronix.de>
Subject: Re: [PATCH net-next v3 3/7] net: ftgmac100: Add reset toggling for
 Aspeed SOCs
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Jacky Chou <jacky_chou@aspeedtech.com>, andrew+netdev@lunn.ch, 
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com,  robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, ratbert@faraday-tech.com,  netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 25 Nov 2024 11:27:15 +0100
In-Reply-To: <20241120075017.2590228-4-jacky_chou@aspeedtech.com>
References: <20241120075017.2590228-1-jacky_chou@aspeedtech.com>
	 <20241120075017.2590228-4-jacky_chou@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Mi, 2024-11-20 at 15:50 +0800, Jacky Chou wrote:
> Toggle the SCU reset before hardware initialization.
>=20
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  drivers/net/ethernet/faraday/ftgmac100.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ether=
net/faraday/ftgmac100.c
> index 17ec35e75a65..1840f7089676 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.c
> +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> @@ -9,6 +9,7 @@
>  #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
> =20
>  #include <linux/clk.h>
> +#include <linux/reset.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/etherdevice.h>
>  #include <linux/ethtool.h>
> @@ -98,6 +99,7 @@ struct ftgmac100 {
>  	struct work_struct reset_task;
>  	struct mii_bus *mii_bus;
>  	struct clk *clk;
> +	struct reset_control *rst;
> =20
>  	/* AST2500/AST2600 RMII ref clock gate */
>  	struct clk *rclk;
> @@ -1979,6 +1981,24 @@ static int ftgmac100_probe(struct platform_device =
*pdev)
>  				  priv->base + FTGMAC100_OFFSET_TM);
>  	}
> =20
> +	priv->rst =3D devm_reset_control_get_optional_exclusive(priv->dev, NULL=
);
> +	if (IS_ERR(priv->rst))
> +		goto err_register_netdev;
> +	if (!priv->rst)
> +		dev_info(&pdev->dev, "no reset control found\n");

Am I understanding correctly that the aspeed-g4 to g6 platforms don't
have the reset? If so, this message is unnecessary noise on those
platforms.

regards
Philipp


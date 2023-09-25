Return-Path: <netdev+bounces-36097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 416F37AD352
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 10:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 5FC471C20445
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 08:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E4F11CA5;
	Mon, 25 Sep 2023 08:29:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EC611C8E
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 08:29:25 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E94A9D;
	Mon, 25 Sep 2023 01:29:23 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 59D431C0011;
	Mon, 25 Sep 2023 08:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1695630562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BETUE3RcO2izRKuzFet0qGTNc4Tx8tBroVhfQaFja4M=;
	b=CoAUieulogXjKaWvt/53Nr27hPmJCYgbgpgtpvTWdxfeuSQObY+TxPZ6e8XNeMb3xMdFQ/
	kWasErliE/rkTA9bsfAzWShxLCoSf2vd0eOUygOBU/J+BFucsiVZ0Ys85Wl6ll/3bXKoEM
	nP/v7ZV88VPVeMLoluryuPMwXR7B/N5uDuq8ZkpiLIp0D2ym8Tx1jEmNj9Roy4m+xz+Ba5
	zgDa6xTFUIHRWiFmMHuVp5Nx5vNKCrnyHNjPuO+7OrdqyNpXkOjzH0f2ItUF4P0vyB+xQg
	EL+0860POWWsexkowpKD3TIJ4gd4afx6ZAjmB/0jgEN4wZa2xLRpDweDSVkh9A==
Date: Mon, 25 Sep 2023 10:29:19 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt
 <stefan@datenfreihafen.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Marcel Holtmann <marcel@holtmann.org>, Harry
 Morris <harrymorris12@gmail.com>, linux-wpan@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ieee802154: ca8210: Fix a potential UAF in ca8210_probe
Message-ID: <20230925102919.356b45ab@xps-13>
In-Reply-To: <20230925072423.24772-1-dinghao.liu@zju.edu.cn>
References: <20230925072423.24772-1-dinghao.liu@zju.edu.cn>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Dinghao,

dinghao.liu@zju.edu.cn wrote on Mon, 25 Sep 2023 15:24:22 +0800:

> If of_clk_add_provider() fails in ca8210_register_ext_clock(),
> it calls clk_unregister() to release priv->clk and returns an
> error. However, the caller ca8210_probe() then calls ca8210_remove(),
> where priv->clk is freed again in ca8210_unregister_ext_clock(). In
> this case, a use-after-free may happen in the second time we call
> clk_unregister().
>=20
> Fix this by nulling priv->clk after the first clk_unregister(). Also
> refine the pointer checking in ca8210_unregister_ext_clock().
>=20
> Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/net/ieee802154/ca8210.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8=
210.c
> index aebb19f1b3a4..1d545879c000 100644
> --- a/drivers/net/ieee802154/ca8210.c
> +++ b/drivers/net/ieee802154/ca8210.c
> @@ -2760,6 +2760,7 @@ static int ca8210_register_ext_clock(struct spi_dev=
ice *spi)
>  	ret =3D of_clk_add_provider(np, of_clk_src_simple_get, priv->clk);
>  	if (ret) {
>  		clk_unregister(priv->clk);
> +		priv->clk =3D NULL;

This function is a bit convoluted. You could just return the result of
of_clk_add_provider() (keep the printk's if you want, they don't seem
very useful) and let ca8210_unregister_ext_clock() do the cleanup.

>  		dev_crit(
>  			&spi->dev,
>  			"Failed to register external clock as clock provider\n"
> @@ -2780,7 +2781,7 @@ static void ca8210_unregister_ext_clock(struct spi_=
device *spi)
>  {
>  	struct ca8210_priv *priv =3D spi_get_drvdata(spi);
> =20
> -	if (!priv->clk)
> +	if (IS_ERR_OR_NULL(priv->clk))

Does not look useful as you are enforcing priv->clock to be valid or
NULL, it cannot be an error code.

Thanks,
Miqu=C3=A8l


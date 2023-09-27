Return-Path: <netdev+bounces-36561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3680B7B073E
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 16:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 540D51C208F4
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 14:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21B12AB36;
	Wed, 27 Sep 2023 14:46:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2F71846
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 14:46:44 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E9CF4
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 07:46:42 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qlVo2-000330-AL; Wed, 27 Sep 2023 16:46:26 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1qlVo0-009McB-Tv; Wed, 27 Sep 2023 16:46:24 +0200
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qlVo0-00BjIg-RC; Wed, 27 Sep 2023 16:46:24 +0200
Date: Wed, 27 Sep 2023 16:46:24 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Oleksij Rempel <linux@rempel-privat.de>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: microchip: Uninitialized variable in
 ksz9477_acl_move_entries()
Message-ID: <20230927144624.GN2714790@pengutronix.de>
References: <2f58ca9a-9ac5-460a-98a4-aa8304f2348a@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2f58ca9a-9ac5-460a-98a4-aa8304f2348a@moroto.mountain>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 03:53:37PM +0300, Dan Carpenter wrote:
> Smatch complains that if "src_idx" equals "dst_idx" then
> ksz9477_validate_and_get_src_count() doesn't initialized "src_count".
> Set it to zero for this situation.
>=20
> Fixes: 002841be134e ("net: dsa: microchip: Add partial ACL support for ks=
z9477 switches")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!

> ---
>  drivers/net/dsa/microchip/ksz9477_acl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/dsa/microchip/ksz9477_acl.c b/drivers/net/dsa/mi=
crochip/ksz9477_acl.c
> index 06d74c19eb94..e554cd4a024b 100644
> --- a/drivers/net/dsa/microchip/ksz9477_acl.c
> +++ b/drivers/net/dsa/microchip/ksz9477_acl.c
> @@ -554,7 +554,8 @@ static int ksz9477_acl_move_entries(struct ksz_device=
 *dev, int port,
>  	struct ksz9477_acl_entry buffer[KSZ9477_ACL_MAX_ENTRIES];
>  	struct ksz9477_acl_priv *acl =3D dev->ports[port].acl_priv;
>  	struct ksz9477_acl_entries *acles =3D &acl->acles;
> -	int src_count, ret, dst_count;
> +	int ret, dst_count;
> +	int src_count =3D 0;
> =20
>  	ret =3D ksz9477_validate_and_get_src_count(dev, port, src_idx, dst_idx,
>  						 &src_count, &dst_count);
> --=20
> 2.39.2
>=20
>=20
>=20

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


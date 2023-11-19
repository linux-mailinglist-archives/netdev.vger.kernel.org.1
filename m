Return-Path: <netdev+bounces-48999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B137F057A
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 11:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D615CB208B4
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 10:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4AC2579;
	Sun, 19 Nov 2023 10:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF391B6
	for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 02:46:37 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-267-ds4de99gNlKNnQcKnKAIGA-1; Sun, 19 Nov 2023 10:46:34 +0000
X-MC-Unique: ds4de99gNlKNnQcKnKAIGA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 19 Nov
 2023 10:46:58 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 19 Nov 2023 10:46:57 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Saeed Mahameed' <saeed@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: RE: [net V2 14/15] net/mlx5e: Check return value of snprintf writing
 to fw_version buffer
Thread-Topic: [net V2 14/15] net/mlx5e: Check return value of snprintf writing
 to fw_version buffer
Thread-Index: AQHaF0XylALLXXn7WEa5ff6y5dXoVbCBfI4w
Date: Sun, 19 Nov 2023 10:46:57 +0000
Message-ID: <81cae734ee1b4cde9b380a9a31006c1a@AcuMS.aculab.com>
References: <20231114215846.5902-1-saeed@kernel.org>
 <20231114215846.5902-15-saeed@kernel.org>
In-Reply-To: <20231114215846.5902-15-saeed@kernel.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Saeed Mahameed
> Sent: 14 November 2023 21:59
>=20
> Treat the operation as an error case when the return value is equivalent =
to
> the size of the name buffer. Failed to write null terminator to the name
> buffer, making the string malformed and should not be used. Provide a
> string with only the firmware version when forming the string with the
> board id fails.

Nak.

RTFM snprintf().

>=20
> Without check, will trigger -Wformat-truncation with W=3D1.
>=20
>     drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c: In function 'ml=
x5e_ethtool_get_drvinfo':
>     drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c:49:31: warning: =
'%.16s' directive output may
> be truncated writing up to 16 bytes into a region of size between 13 and =
22 [-Wformat-truncation=3D]
>       49 |                  "%d.%d.%04d (%.16s)",
>          |                               ^~~~~
>     drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c:48:9: note: 'snp=
rintf' output between 12 and
> 37 bytes into a destination of size 32
>       48 |         snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_versi=
on),
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
>       49 |                  "%d.%d.%04d (%.16s)",
>          |                  ~~~~~~~~~~~~~~~~~~~~~
>       50 |                  fw_rev_maj(mdev), fw_rev_min(mdev), fw_rev_su=
b(mdev),
>          |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
>       51 |                  mdev->board_id);
>          |                  ~~~~~~~~~~~~~~~
>=20
> Fixes: 84e11edb71de ("net/mlx5e: Show board id in ethtool driver informat=
ion")
> Link:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D6d4ab2e97dcfbcd748ae7176
> 1a9d8e5e41cc732c
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/en_ethtool.c    | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> index 215261a69255..792a0ea544cd 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> @@ -43,12 +43,17 @@ void mlx5e_ethtool_get_drvinfo(struct mlx5e_priv *pri=
v,
>  =09=09=09       struct ethtool_drvinfo *drvinfo)
>  {
>  =09struct mlx5_core_dev *mdev =3D priv->mdev;
> +=09int count;
>=20
>  =09strscpy(drvinfo->driver, KBUILD_MODNAME, sizeof(drvinfo->driver));
> -=09snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
> -=09=09 "%d.%d.%04d (%.16s)",
> -=09=09 fw_rev_maj(mdev), fw_rev_min(mdev), fw_rev_sub(mdev),
> -=09=09 mdev->board_id);
> +=09count =3D snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
> +=09=09=09 "%d.%d.%04d (%.16s)", fw_rev_maj(mdev),
> +=09=09=09 fw_rev_min(mdev), fw_rev_sub(mdev), mdev->board_id);
> +=09if (count =3D=3D sizeof(drvinfo->fw_version))
> +=09=09snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
> +=09=09=09 "%d.%d.%04d", fw_rev_maj(mdev),
> +=09=09=09 fw_rev_min(mdev), fw_rev_sub(mdev));
> +
>  =09strscpy(drvinfo->bus_info, dev_name(mdev->device),
>  =09=09sizeof(drvinfo->bus_info));
>  }
> --
> 2.41.0
>=20

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)



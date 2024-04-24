Return-Path: <netdev+bounces-91012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 297678B0F8A
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 18:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96C181F22DFD
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 16:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2C3161311;
	Wed, 24 Apr 2024 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeyyFl7i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2169D16130D;
	Wed, 24 Apr 2024 16:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713975505; cv=none; b=uJi9WUdD6e/IPOEyJDGUu3pGLfleDnSCoOONSZqdLe/w3tYZYWXe1AMv1Sl4VnEKvH0dLB9eYb2SxaUHq1Fpr+bsa8K2zYSOBmTQygRYyvhY3iwvRM88NKDtykUCKskdV4Scjm0jjR78/umNOrlAXVOaOyaHcCtPZWUmkv7WGcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713975505; c=relaxed/simple;
	bh=WOCA64wLURkzbX3ikbDOkLsxKLSUsfx9997T2RUaXbM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bPzUeDW8P0S3QoXv5pnjsMlIkGI992h93iSO2L6CTYQWeV4xo201Euq/yTCGMCpKjjNnDYMJBHrln8BSiLpRnhxv/T9l5/NVWwPsXaWSoM2f0pYXGcw/TW4wCd6a4z56vGoPAu+2kVGJyKYZTw+Eg/lZUGEVG8AHNWcAaQbSGto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeyyFl7i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9F2C113CD;
	Wed, 24 Apr 2024 16:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713975504;
	bh=WOCA64wLURkzbX3ikbDOkLsxKLSUsfx9997T2RUaXbM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eeyyFl7imnDTYm5iLmD+lfkzycscZRdTB3YQ5BjHvvnx/JTn2+ih4dK2Y0nBgNHNk
	 jXYoIAm0t0G7YJJXE5GeCZrcAuXmW5B4nQsZ8pgxDJwkPceZyEDKhsRL5E6XTsBzsF
	 xlZ3NlDVSDHJgARljvXjFbfWRv9NWfVwemQ35UbsF2bnnYRNEj4LL3D5cHRKI9TdVO
	 /SuR/vWxiX+oltGFkUv2KKKaSBJOPHn3auoY2dJzbWwUcaTowfYBac55W07hboInSe
	 7SVLiIEB/BTW3gh602Uy6/H2YDR4P2bc9MVmNCnq33mQZSp52fnHO9GgsCQLCnSyts
	 lW0NbiE0kKJ3A==
Date: Wed, 24 Apr 2024 09:18:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>, "Michael S .
 Tsirkin" <mst@redhat.com>, Brett Creeley <bcreeley@amd.com>, Ratheesh
 Kannoth <rkannoth@marvell.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Tal
 Gilboa <talgi@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Jiri Pirko <jiri@resnulli.us>, Paul
 Greenwalt <paul.greenwalt@intel.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Kory Maincent
 <kory.maincent@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
 "justinstitt@google.com" <justinstitt@google.com>
Subject: Re: [PATCH net-next v9 2/4] ethtool: provide customized dim profile
 management
Message-ID: <20240424091823.4e9b008b@kernel.org>
In-Reply-To: <640292b7-5fcd-44c2-bdd1-03702b7e60a1@linux.alibaba.com>
References: <20240417155546.25691-1-hengqi@linux.alibaba.com>
	<20240417155546.25691-3-hengqi@linux.alibaba.com>
	<20240418174843.492078d5@kernel.org>
	<96b59800-85e6-4a9e-ad9b-7ad3fa56fff4@linux.alibaba.com>
	<640292b7-5fcd-44c2-bdd1-03702b7e60a1@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Apr 2024 21:41:55 +0800 Heng Qi wrote:
> +struct dim_irq_moder {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* See DIM_PROFILE_* */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 profile_flags;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* See DIM_COALESCE_* for Rx and Tx=
 */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 coal_flags;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Rx DIM period count mode: CQE or=
 EQE */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 dim_rx_mode;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Tx DIM period count mode: CQE or=
 EQE */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 dim_tx_mode;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* DIM profile list for Rx */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dim_cq_moder *rx_profile;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* DIM profile list for Tx */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dim_cq_moder *tx_profile;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Rx DIM worker function scheduled=
 by net_dim() */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void (*rx_dim_work)(struct work_str=
uct *work);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Tx DIM worker function scheduled=
 by net_dim() */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void (*tx_dim_work)(struct work_str=
uct *work);
> +};
> +
>=20
> .....
>=20
>=20
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ndo_init_irq_moder=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D virtnet_init_irq_moder,

The init callback mostly fills in static data, can we not
declare the driver information statically and move the init
code into the core?

> ....
>=20
>=20
> +static int virtnet_init_irq_moder(struct net_device *dev)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct virtnet_info *vi =3D n=
etdev_priv(dev);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dim_irq_moder *moder;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int len;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!virtio_has_feature(vi->v=
dev, VIRTIO_NET_F_VQ_NOTF_COAL))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return 0;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev->irq_moder =3D kzalloc(si=
zeof(*dev->irq_moder), GFP_KERNEL);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!dev->irq_moder)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 goto err_moder;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 moder =3D dev->irq_moder;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 len =3D NET_DIM_PARAMS_NUM_PR=
OFILES * sizeof(*moder->rx_profile);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 moder->profile_flags |=3D DIM=
_PROFILE_RX;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 moder->coal_flags |=3D DIM_CO=
ALESCE_USEC | DIM_COALESCE_PKTS;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 moder->dim_rx_mode =3D DIM_CQ=
_PERIOD_MODE_START_FROM_EQE;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 moder->rx_dim_work =3D virtne=
t_rx_dim_work;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 moder->rx_profile =3D kmemdup=
(dim_rx_profile[moder->dim_rx_mode],
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 len, GFP_KERNEL);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!moder->rx_profile)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 goto err_profile;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> +
> +err_profile:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(moder);
> +err_moder:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
> +}
> +
>=20
> ......
>=20
> +void net_dim_setting(struct net_device *dev, struct dim *dim, bool is_tx)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dim_irq_moder *irq_moder =3D=
 dev->irq_moder;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!irq_moder)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (is_tx) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 INIT_WORK(&dim->work, irq_moder->tx_dim_work);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 dim->mode =3D irq_moder->dim_tx_mode;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INIT_WORK(&dim->work, irq_moder->rx=
_dim_work);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dim->mode =3D irq_moder->dim_rx_mod=
e;
> +}
>=20
> .....
>=20
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < vi->max_queue_pai=
rs; i++)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 net_dim_setting(vi->dev, &vi->rq[i].dim, false);
>=20
> .....
>=20
>  =C2=A0=C2=A0=C2=A0 ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES,=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* u32 */
>=20
>  =C2=A0=C2=A0=C2=A0 ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS,=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* u32 */
>=20
> + /* nest - _A_PROFILE_IRQ_MODERATION */
>=20
> +=C2=A0 ETHTOOL_A_COALESCE_RX_PROFILE,
>=20
> +=C2=A0=C2=A0 /* nest - _A_PROFILE_IRQ_MODERATION */
> +=C2=A0 ETHTOOL_A_COALESCE_TX_PROFILE,
>=20
> ......
>=20
>=20
> Almost clear implementation, but the only problem is when I want to
> reuse "ethtool -C" and append ETHTOOL_A_COALESCE_RX_PROFILE
> and ETHTOOL_A_COALESCE_TX_PROFILE, *ethnl_set_coalesce_validate()
> will report an error because there are no ETHTOOL_COALESCE_RX_PROFILE
> and ETHTOOL_COALESCE_TX_PROFILE, because they are replaced by
> DIM_PROFILE_RX and DIM_PROFILE_TX in the field profile_flags.*

I see.

> Should I reuse ETHTOOL_COALESCE_RX_PROFILE and
> ETHTOOL_A_COALESCE_TX_PROFILE in ethtool_ops->.supported_coalesce_params
> and remove the field profile_flags from struct dim_irq_moder?
> Or let ethnl_set_coalesce_validate not verify these two flags?
> Is there a better solution?

Maybe create the bits but automatically add them for the driver?

diff --git a/net/ethtool/coalesce.c b/net/ethtool/coalesce.c
index 83112c1a71ae..56777d36f7f1 100644
--- a/net/ethtool/coalesce.c
+++ b/net/ethtool/coalesce.c
@@ -243,6 +243,8 @@ ethnl_set_coalesce_validate(struct ethnl_req_info *req_=
info,
=20
 	/* make sure that only supported parameters are present */
 	supported_params =3D ops->supported_coalesce_params;
+	if (dev->moder->coal_flags ...)
+		supported_params |=3D ETHTOOL_COALESCE_...;
 	for (a =3D ETHTOOL_A_COALESCE_RX_USECS; a < __ETHTOOL_A_COALESCE_CNT; a++)
 		if (tb[a] && !(supported_params & attr_to_mask(a))) {
 			NL_SET_ERR_MSG_ATTR(info->extack, tb[a],


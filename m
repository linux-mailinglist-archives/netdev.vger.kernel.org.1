Return-Path: <netdev+bounces-120258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FA3958B6D
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 17:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2580B1F210EC
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 15:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE5518FDAB;
	Tue, 20 Aug 2024 15:34:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD3A1922F7
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 15:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724168056; cv=none; b=TqEBD6lcd7wveOgMbYTifx9mDhvNYzI7lnnXpMStSeAXK/li0qEvvWRlNa3RGQXshUHu7BiGAq0mfvmCf/rgBTWgLY56fOgE9bbT667OtYzRtoEw1Alikw2Ol0BR8nJiRA5Z9edEzmr5hyZOAWiwV6sBm7Ffd2X5z4zxDvvnvT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724168056; c=relaxed/simple;
	bh=Z6e5duGcUZO/LsiFxq3oIb0/JzZ0GTraJ9Z9+AAkisY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UAavzcPyLef7YldDkjd5ghnNjilQCsVgTLRBBmNh7/A5VYirW35Y/A0OKEA2XuW62XI8Ba2b2G0JLA678YBYlQzGTPg3oypRD+uSzaQriYS4G5eqjx8ZTH5WwLhJ30dSugC5K+akcvWtX2vjIIOA6549lpbIsOzkXdXcrmZHKSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-gPYJl3sWPJ-lWzXRdjPp8Q-1; Tue,
 20 Aug 2024 11:34:07 -0400
X-MC-Unique: gPYJl3sWPJ-lWzXRdjPp8Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B37521954225;
	Tue, 20 Aug 2024 15:34:05 +0000 (UTC)
Received: from hog (unknown [10.39.192.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 150273001FF1;
	Tue, 20 Aug 2024 15:34:00 +0000 (UTC)
Date: Tue, 20 Aug 2024 17:33:58 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hangbin Liu <liuhangbin@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCHv3 net-next 2/3] bonding: Add ESN support to IPSec HW
 offload
Message-ID: <ZsS3Zh8bT-qc46s7@hog>
References: <20240820004840.510412-1-liuhangbin@gmail.com>
 <20240820004840.510412-3-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240820004840.510412-3-liuhangbin@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hangbin,

(adding Steffen since we're getting a bit into details of IPsec)

2024-08-20, 08:48:39 +0800, Hangbin Liu wrote:
> Currently, users can see that bonding supports IPSec HW offload via ethto=
ol.
> However, this functionality does not work with NICs like Mellanox cards w=
hen
> ESN (Extended Sequence Numbers) is enabled, as ESN functions are not yet
> supported. This patch adds ESN support to the bonding IPSec device offloa=
d,
> ensuring proper functionality with NICs that support ESN.
>=20
> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/bonding/bond_main.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
> index 560e3416f6f5..24747fceef66 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -651,10 +651,35 @@ static bool bond_ipsec_offload_ok(struct sk_buff *s=
kb, struct xfrm_state *xs)
>  =09return err;
>  }
> =20
> +/**
> + * bond_advance_esn_state - ESN support for IPSec HW offload
> + * @xs: pointer to transformer state struct
> + **/
> +static void bond_advance_esn_state(struct xfrm_state *xs)
> +{
> +=09struct net_device *real_dev;
> +
> +=09rcu_read_lock();
> +=09real_dev =3D bond_ipsec_dev(xs);
> +=09if (!real_dev)
> +=09=09goto out;
> +
> +=09if (!real_dev->xfrmdev_ops ||
> +=09    !real_dev->xfrmdev_ops->xdo_dev_state_advance_esn) {
> +=09=09pr_warn("%s: %s doesn't support xdo_dev_state_advance_esn\n", __fu=
nc__, real_dev->name);

xdo_dev_state_advance_esn is called on the receive path for every
packet when ESN is enabled (xfrm_input -> xfrm_replay_advance ->
xfrm_replay_advance_esn -> xfrm_dev_state_advance_esn), this needs to
be ratelimited.


But this CB is required to make offload with ESN work. If it's not
implemented on a lower device, I expect things will break. I wonder
what the best behavior would be:

 - just warn (this patch) -- but things will break for users

 - don't allow mixing devices that support ESN with devices that don't
   in the same bond (really bad if the user doesn't care about ESN)

 - don't allow enslaving devices that don't support ESN if an xfrm
   state using ESN has been added to the bond, and don't allow
   creating ESN states if the bond has one non-ESN slave

 - disable re-offloading the state if we have to migrate it from an
   ESN-enabled to a non-ESN device (when changing the active slave)
   -- and fall back to the (slow) SW implementation

 - other options that I'm not thinking about?


Sorry I'm only noticing this at v3 :(

--=20
Sabrina



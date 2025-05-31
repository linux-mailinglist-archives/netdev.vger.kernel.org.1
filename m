Return-Path: <netdev+bounces-194479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4224CAC9A34
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 11:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B6644A5788
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 09:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AE9235BF3;
	Sat, 31 May 2025 09:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="BG2WZ1dD"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D581E519;
	Sat, 31 May 2025 09:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748683009; cv=none; b=K5nff6htzvSl3H2PilN71OxsDyxIAuDo8GjGZOcu0gn23nnC+vIRfp0+gM82C7j04NeI42uLDZ5L+LQQWHzDV+s/Vwn49zOJvBtnYHKj3MP61341GD4s7du2jbL1arYdrevkUFJmNchkOapntzraY3kJDXKsAdslros7IZHCtRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748683009; c=relaxed/simple;
	bh=Nf9MPw+KHk4DbwHqcnlemdN1bMsyhVPmR+H46ueSbgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T2BIKtXdv6Z+APXEsqR5jTcqrjDSCDUQzCL0FDCFyft9ZTKjlBoRuaoIqIJHpcexrzTo9EpErb9c45v7jMFF1Gwd50ebW7Hm7nOLASgTgFqAU+faPwWlFCLqTvrqm83geOD0KobB9QXdJMKiEkpGECG8XF0yaGEi6Iv6PqhXZC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=BG2WZ1dD; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1748683004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9e3ygM0jvmbE7HN2UFSQMTGTErfuZibV4CLp7vHuGEQ=;
	b=BG2WZ1dD60ya0pAVPh+hdPXtTSW+DJ4yKrJtAXxJv5VB6kZTanThoKpm6xzDr05NLAd50i
	3sEQhHzXjCdJf3EXt6eG7jggwjYcirULko5Bavrq5loJU0hN/bURHq3QqE2Xq2c25ZBD73
	muErhrW/N+D390ue3h/ns6qNrrb33ac=
From: Sven Eckelmann <sven@narfation.org>
To: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 Matthias Schiffer <mschiffer@universe-factory.net>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH batadv 2/5] batman-adv: only create hardif while a netdev is part
 of a mesh
Date: Sat, 31 May 2025 11:16:30 +0200
Message-ID: <7760123.MhkbZ0Pkbq@sven-desktop>
In-Reply-To:
 <e311c7d643fa1a7d13f2b518f6ee525eb6711f6c.1747687504.git.mschiffer@universe-factory.net>
References:
 <0b26554afea5203820faef1dfb498af7533a9b5d.1747687504.git.mschiffer@universe-factory.net>
 <e311c7d643fa1a7d13f2b518f6ee525eb6711f6c.1747687504.git.mschiffer@universe-factory.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3532761.VLH7GnMWUR";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart3532761.VLH7GnMWUR
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 31 May 2025 11:16:30 +0200
Message-ID: <7760123.MhkbZ0Pkbq@sven-desktop>
MIME-Version: 1.0

On Monday, 19 May 2025 22:46:29 CEST Matthias Schiffer wrote:
> @@ -734,9 +768,6 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
>         if (ret < 0)
>                 goto err_upper;
>  
> -       hard_iface->if_status = BATADV_IF_INACTIVE;
> -
> -       kref_get(&hard_iface->refcount);
>         hard_iface->batman_adv_ptype.type = ethertype;
>         hard_iface->batman_adv_ptype.func = batadv_batman_skb_recv

This is confusing. You remove the reference for the batman_adv_ptype but kept 
the `batadv_hardif_put(hard_iface);` after 
`dev_remove_pack(&hard_iface->batman_adv_ptype);`.

I think this should be added again and instead following code should receive a 
`batadv_hardif_put(hard_iface);` after the `list_del_rcu(&hard_iface->list);`:


> @@ -818,11 +849,16 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
>         struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
>         struct batadv_hard_iface *primary_if = NULL;
>  
> +       ASSERT_RTNL();
> +
>         batadv_hardif_deactivate_interface(hard_iface);
>  
>         if (hard_iface->if_status != BATADV_IF_INACTIVE)
>                 goto out;
>  
> +       list_del_rcu(&hard_iface->list);
> +       batadv_hardif_generation++;
> +
>         batadv_info(hard_iface->mesh_iface, "Removing interface: %s\n",
>                     hard_iface->net_dev->name);
>         dev_remove_pack(&hard_iface->batman_adv_ptype);


And yes, this means that this needs to be removed in PATCH 3 again - together 
with the `kref_get` from this chunk (from PATCH 3):

On Monday, 19 May 2025 22:46:31 CEST Matthias Schiffer wrote:
> @@ -738,8 +735,6 @@ int batadv_hardif_enable_interface(struct net_device *net_dev,
>         batadv_v_hardif_init(hard_iface);
>  
>         kref_get(&hard_iface->refcount);
> -       list_add_tail_rcu(&hard_iface->list, &batadv_hardif_list);
> -       batadv_hardif_generation++;
>  
>         hardif_mtu = READ_ONCE(hard_iface->net_dev->mtu);
>         required_mtu = READ_ONCE(mesh_iface->mtu) + max_header_len;



Just a question about this part (you don't really need to change it - I am 
just interested). Why did you move this MTU check to such a late position in 
the code?

> -       hardif_mtu = READ_ONCE(hard_iface->net_dev->mtu);
> -       required_mtu = READ_ONCE(mesh_iface->mtu) + max_header_len;
> +       ASSERT_RTNL();
>  
> -       if (hardif_mtu < ETH_MIN_MTU + max_header_len)
> +       if (!batadv_is_valid_iface(net_dev))
>                 return -EINVAL;
>  
[...]
> +       hard_iface = kzalloc(sizeof(*hard_iface), GFP_ATOMIC);
> +       if (!hard_iface)
> +               return -ENOMEM;
> +
> +       netdev_hold(net_dev, &hard_iface->dev_tracker, GFP_ATOMIC);
> +       hard_iface->net_dev = net_dev;
[...]
> +       hardif_mtu = READ_ONCE(hard_iface->net_dev->mtu);
> +       required_mtu = READ_ONCE(mesh_iface->mtu) + max_header_len;
> +
> +       if (hardif_mtu < ETH_MIN_MTU + max_header_len) {
> +               ret = -EINVAL;
> +               goto err_put;
> +       }

It made the error handling more complicated. And at the moment, I don't see 
the reason. For me, It would have been been more logical to just a a minimal 
invasive change like:

> -       hardif_mtu = READ_ONCE(hard_iface->net_dev->mtu);
> +       hardif_mtu = READ_ONCE(net_dev->mtu);



Thanks,
	Sven

--nextPart3532761.VLH7GnMWUR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaDrI7gAKCRBND3cr0xT1
y07YAQDVyR/OScCqmjK6581lF8hCs9w6rB6o2vV6IV6R7NCsTQD9H6y3oePiuHOj
BvPM8kV+xcZ3a+jPr3egHm+0AQ4K5wg=
=9jGN
-----END PGP SIGNATURE-----

--nextPart3532761.VLH7GnMWUR--





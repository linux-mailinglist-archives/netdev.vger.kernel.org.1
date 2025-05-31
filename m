Return-Path: <netdev+bounces-194486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D59AC9A53
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 11:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5199F9E323B
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 09:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E624239E76;
	Sat, 31 May 2025 09:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="nUO6SsTZ"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A932376EC;
	Sat, 31 May 2025 09:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748685143; cv=none; b=qf7hkVczKoVhrzEkhHyI6J2kPTZOgTErjBpd6A5dL2lKcg8yecvk9VdASXmOWmuuJfkcXd92DdGlE+WR0jKv7gyVuJMllO8eW6P8NkcQi95mDYWwZzMEomOsjH7zaZgL896e02JY/rSVfnzQnayBgEJ99pNuCW/QWV4OyxAW9/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748685143; c=relaxed/simple;
	bh=mcLu69E22oPtyjeUulYDLFJPoP+jaJ+5GOPJWv+7XyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZpSvPG4yRulkBH8b2lthdRIZY8XiLYo5KIIIVSJZArDZ/ntrKaf5A0BVmvK5BFUnDY67GBAtOUcy+5qgzm8k2gure4iRrxo9vkcO+7EDcXzbrteGuO7b8tw0kVW8RXiQ2PiWpi/8dg/ujRx8gLirwYYoks3nN8D2yPIJAmtxKnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=nUO6SsTZ; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1748685138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yvo1gKEFvcCi1DSavYyf9wE/OfH4XiSCUbk32K7rcBQ=;
	b=nUO6SsTZH54XbUvXnm3Ki3CChaZZZASBQx/bUv8hbtvqU5PiZUPFTbmxUu9k/yn5srJafl
	k5CXPZdG/k8vTSCpGQa3b+CFO6elNPORIR2r0USjAJcoCUaMCLd6Xwwy3wbZ393/KKVX0N
	ld/l6hZZXkLzBgccZIoVQ1O+Q9zUvsk=
From: Sven Eckelmann <sven@narfation.org>
To: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 Matthias Schiffer <mschiffer@universe-factory.net>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Matthias Schiffer <mschiffer@universe-factory.net>
Subject:
 Re: [PATCH batadv 2/5] batman-adv: only create hardif while a netdev is part
 of a mesh
Date: Sat, 31 May 2025 11:52:12 +0200
Message-ID: <6005840.1IzOArtZ34@sven-desktop>
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
Content-Type: multipart/signed; boundary="nextPart4437374.BddDVKsqQX";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart4437374.BddDVKsqQX
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 31 May 2025 11:52:12 +0200
Message-ID: <6005840.1IzOArtZ34@sven-desktop>
MIME-Version: 1.0

On Monday, 19 May 2025 22:46:29 CEST Matthias Schiffer wrote:
> -int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
> +int batadv_hardif_enable_interface(struct net_device *net_dev,
>                                    struct net_device *mesh_iface)
>  {
[....]
> +       hard_iface->wifi_flags =3D batadv_wifi_flags_evaluate(net_dev);

Moving this here should break the WIFI TT flag in scenarios like this:

                   =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=90            =20
       =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BCbr-lan=E2=94=9C=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90     =20
       =E2=94=82           =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=98      =E2=94=82     =20
       =E2=94=82                         =E2=94=82     =20
       =E2=94=82                         =E2=94=82     =20
     =E2=94=8C=E2=94=80=E2=96=BC=E2=94=80=E2=94=90                    =E2=
=94=8C=E2=94=80=E2=94=80=E2=96=BC=E2=94=80=E2=94=90   =20
     =E2=94=82ap0=E2=94=82                    =E2=94=82bat0=E2=94=82   =20
     =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=98                    =E2=
=94=94=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=98   =20
                                 =E2=94=82     =20
                                 =E2=94=82     =20
                              =E2=94=8C=E2=94=80=E2=94=80=E2=96=BC=E2=94=80=
=E2=94=80=E2=94=90  =20
                              =E2=94=82mesh0=E2=94=82  =20
                              =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=98  =20


ap0 is not the lower interface of any batadv mesh interface but TT ap=20
isolation is depending on the information stored for this hardif. See:



/**
 * batadv_is_wifi_hardif() - check if the given hardif is a wifi interface
 * @hard_iface: the device to check
 *
 * Return: true if the net device is a 802.11 wireless device, false otherw=
ise.
 */
bool batadv_is_wifi_hardif(struct batadv_hard_iface *hard_iface)
{
	if (!hard_iface)
		return false;

	return hard_iface->wifi_flags !=3D 0;
}

bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
			 unsigned short vid, int ifindex, u32 mark)
{
[...]
	if (ifindex !=3D BATADV_NULL_IFINDEX)
		in_dev =3D dev_get_by_index(net, ifindex);

	if (in_dev)
		in_hardif =3D batadv_hardif_get_by_netdev(in_dev);
[...]
	if (batadv_is_wifi_hardif(in_hardif))
		tt_local->common.flags |=3D BATADV_TT_CLIENT_WIFI;
[...]


static bool
_batadv_is_ap_isolated(struct batadv_tt_local_entry *tt_local_entry,
		       struct batadv_tt_global_entry *tt_global_entry)
{
	if (tt_local_entry->common.flags & BATADV_TT_CLIENT_WIFI &&
	    tt_global_entry->common.flags & BATADV_TT_CLIENT_WIFI)
		return true;

	/* check if the two clients are marked as isolated */
	if (tt_local_entry->common.flags & BATADV_TT_CLIENT_ISOLA &&
	    tt_global_entry->common.flags & BATADV_TT_CLIENT_ISOLA)
		return true;

	return false;
}


Kind regards,
	Sven
--nextPart4437374.BddDVKsqQX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaDrRTAAKCRBND3cr0xT1
yzUsAQCp/BGDaLgH0bq7xgYDPfCB+JWa1ATr3Z4n9blbzryMMgD/bOqU8Sjbwa9V
21JVjVIElBn4VBShwmvDlt2H82tdMQg=
=Ej70
-----END PGP SIGNATURE-----

--nextPart4437374.BddDVKsqQX--





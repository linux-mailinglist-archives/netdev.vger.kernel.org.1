Return-Path: <netdev+bounces-126468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4822B971412
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 11:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7458E1C22C0E
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 09:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB3E1B29D3;
	Mon,  9 Sep 2024 09:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="dfZvTQsV"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C672F1B2EE0
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 09:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725875034; cv=none; b=O3v25+Jv7c85OVsdGEJzi7im54RBPAyGjW623V0d4jIx9DT02+LaFhe+u85d1la2VPwOseny9lF/WPvQp561RM/wMDTweG6jNDO8SR60cM8dharWHU9940ykVHl3vP29PC+klOi7QYpebNtsM/6LQSm/DxEdgva9xZR3TqxxeKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725875034; c=relaxed/simple;
	bh=mdCA4N+GNVY0fJkzFyi/Gl+NoZ0YobtLCyWMNATLKLs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AwXoMCVdW+8o9NOVh2LpjgHj79LbHxL4VdQIX/3+neS42hka9TKk+ksYYB7QxG8pH+34ub+DaHMoy/Ii0oUwoAI1x0x3ArtjKQwr+R6bgFH+rZuI4/LCLUtZisgzrXc3Sfj6Fl/Q58XPlzIKZyyhNdg3DW9PdmPZWmv50/gBfpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=dfZvTQsV; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 52F6788C8E;
	Mon,  9 Sep 2024 11:43:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725875030;
	bh=y+ZOkuhV+ORWPzQUEat+C9lYpyiwHv49fIrrhPU8X80=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dfZvTQsVUu2HvBtcIFJNlKwOCYRyaU+N4YJmWUNwp/+khPwGu8FI9GRjU2bOtjbJQ
	 nqX0wD+Ou6hjLQyORlQZ/vyHJFX3pm1UbPnGHK5fOBYdGcHoOpDZcVk9RwajWye/Zm
	 S+xOvdsW8Y8msLYHqbwlvl2uvT4hd5gqRhteg7907CX0bNl8jPDwXC2IKjFqYvQnCW
	 GUAdl7TXVocxWIHsIbWDTzlEMigRkq1h2UobhUwXPYVjw5AYqP3ZdDC1uDZfb2IBL2
	 Jy8QSKxUrq7g5xS43RPbVyQYDQHi8GbGGifM93W8sniJGUG4SdpcBgzN0nr1m0RIE6
	 nvj+WJizKMaYA==
Date: Mon, 9 Sep 2024 11:43:49 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/2] net: hsr: Remove interlink_sequence_nr.
Message-ID: <20240909114349.229b42b0@wsk>
In-Reply-To: <20240906132816.657485-3-bigeasy@linutronix.de>
References: <20240906132816.657485-1-bigeasy@linutronix.de>
	<20240906132816.657485-3-bigeasy@linutronix.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PCx0GGlSJXMDUHOxp0gnyS5";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/PCx0GGlSJXMDUHOxp0gnyS5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Sebastian Andrzej,

> From: Eric Dumazet <edumazet@google.com>
>=20
> Remove interlink_sequence_nr which is unused.
>=20
> [ bigeasy: split out from Eric's patch ].
>=20
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  net/hsr/hsr_device.c | 1 -
>  net/hsr/hsr_main.h   | 1 -
>  2 files changed, 2 deletions(-)
>=20
> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> index a06e790042e2e..10393836992df 100644
> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c
> @@ -625,7 +625,6 @@ int hsr_dev_finalize(struct net_device *hsr_dev,
> struct net_device *slave[2], /* Overflow soon to find bugs easier: */
>  	hsr->sequence_nr =3D HSR_SEQNR_START;
>  	hsr->sup_sequence_nr =3D HSR_SUP_SEQNR_START;
> -	hsr->interlink_sequence_nr =3D HSR_SEQNR_START;
> =20
>  	timer_setup(&hsr->announce_timer, hsr_announce, 0);
>  	timer_setup(&hsr->prune_timer, hsr_prune_nodes, 0);
> diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
> index ab1f8d35d9dcf..fcfeb79bb0401 100644
> --- a/net/hsr/hsr_main.h
> +++ b/net/hsr/hsr_main.h
> @@ -203,7 +203,6 @@ struct hsr_priv {
>  	struct timer_list	prune_proxy_timer;
>  	int announce_count;
>  	u16 sequence_nr;
> -	u16 interlink_sequence_nr; /* Interlink port seq_nr */

I think that this was an attempt to exactly follow standard (point
5.2.2.2 HSR-SAN RedBox for attachment to a single-thread LAN) which
states that proxy node table shall keep for each interlink the sequence
number [*]. Instead in code the sequence number for a new frame which
comes from interlink port is assigned int:

hsr_get_node() -> file line 271=20

and then this starting sequence numer is used for this proxy node table
node.

Hence it shall be safe to remove it.

>  	u16 sup_sequence_nr;	/* For HSRv1 separate seq_nr for
> supervision */ enum hsr_version prot_version;	/* Indicate if
> HSRv0, HSRv1 or PRPv1 */ spinlock_t seqnr_lock;	/* locking for
> sequence_nr */




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/PCx0GGlSJXMDUHOxp0gnyS5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmbew1UACgkQAR8vZIA0
zr18tAf/U6nRw0SzUTDVzCSU/HrRG7E7Y6OJYxNgt7gv1nc8I1oGarOyWU+KnaMj
LwrmDMdlY0Dx6/UZO2WzvUpuqyN7HuMamEmIP5s1a9fl0Gv4GNKXjV42f8idXGV0
tpyPZal9fFcQ+UXPK7iQh1whqg2oaAszHCJSEmAZikdKICd8Ya9emjGVv56wGj5n
31hXGkoXIIydIgEVlI6nMl94/bnDgyyCZ+ZQwodZOwlnYEaD/gFA6Bq7C7FmyEBx
uJrZitnfnuaJHsMagWr4UPnGxQCfMadFvOEyPlOUW6MF8i+7nCTRmf5M5FxtK71h
c+hb+s8W49lMUjK1Sz9//qRQiJc25A==
=jkrD
-----END PGP SIGNATURE-----

--Sig_/PCx0GGlSJXMDUHOxp0gnyS5--


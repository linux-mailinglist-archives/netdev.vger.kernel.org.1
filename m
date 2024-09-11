Return-Path: <netdev+bounces-127246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5140974BE4
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 09:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D2381F25D62
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 07:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14E614375C;
	Wed, 11 Sep 2024 07:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="caxRTezo"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26BA53E15
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 07:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726041276; cv=none; b=j3WlbiXn5mx+xfkDfKC/JZYgBzQrHZ/cfoqQBcrpHF4xzVbEkFNGmTlxdhHnJLH1yM+H/W6JFrAeVnZHNyp9S2GcyQh3O6Bjq7MZPjPLaq5IdaTnoukyvp98EKPT5H4wTX9Myx95XfdDzIltsODBWzZY3p5wRs5lbJqfzKVwRrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726041276; c=relaxed/simple;
	bh=arkvYEokhZ0x786yVFqGZbrE3TXIKtNFYX/xMZFlddc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b2cPYUX5xwodHmnGYwkE9AAfPyVegYsZiVoi9UaiBUA0iJObmdQBO3GNcg90w9pjjSTJ76FzGwsNS+59de3ZINtoqNf96+qyT4ib/dPHumXmVuIWdZlnrFDZDruh/L4ckAo2qXHnd6c1EbIQ86SRLaG1MJUTzswL4yutgpfWCaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=caxRTezo; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 5BC6388CF6;
	Wed, 11 Sep 2024 09:54:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1726041273;
	bh=kY/HAlrD8pURfaUKeNvVFltkFOEV27ATrYEyt1kGtu8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=caxRTezoElABA8roZhAvT5nP9dotawCF5IEhyMRn1NXyxa6+5ocL/lV5S1fDxQ0Ft
	 C9cikB0xa9sZ7tYh2MVWTpBhVX2oRUYPp6i80gq6woL2JbAMv/WviXhab7rEztXdXl
	 m4qZU2j4Nf7BS1h0EwT7sgPGPAE1ed4Iti4XyZKzy/mD6lS5iNgPm2sahAcLqeAWBB
	 y/4TSGrb/mP0PVbwAHOujDJ1UByNWPhNmGvClbaPLyozZkHRr+9fVBxzk5kYUCtwjc
	 NQ15cslqI9Vtf04WQ2YbWqQ+IN3XmS2rdj3odCjtF2I3HYJt8iFvWX7HIM1+00Lyyh
	 25wOP4YCottUg==
Date: Wed, 11 Sep 2024 09:54:31 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>,
 syzbot+3d602af7549af539274e@syzkaller.appspotmail.com
Subject: Re: [PATCH net 1/2] net: hsr: Use the seqnr lock for frames
 received via interlink port.
Message-ID: <20240911095431.51b4074d@wsk>
In-Reply-To: <20240910162517.2b226a71@kernel.org>
References: <20240906132816.657485-1-bigeasy@linutronix.de>
	<20240906132816.657485-2-bigeasy@linutronix.de>
	<20240909114948.129735b9@wsk>
	<20240910162517.2b226a71@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IQy.iBSL=figIHzofeBZwLK";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/IQy.iBSL=figIHzofeBZwLK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

> On Mon, 9 Sep 2024 11:49:48 +0200 Lukasz Majewski wrote:
> > > +	if (port->type =3D=3D HSR_PT_INTERLINK) {
> > > +		spin_lock_bh(&hsr->seqnr_lock);   =20
> >=20
> > I'm just wondering if this could have impact on offloaded HSR
> > operation.
> >=20
> > I will try to run hsr_redbox.sh test on this patch (with QEMU) and
> > share results. =20
>=20
> Hi Lukasz, any luck with the testing?

I will reply by EOD


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/IQy.iBSL=figIHzofeBZwLK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmbhTLcACgkQAR8vZIA0
zr1u6QgAy0cI5cqKJyVJ80rdXSfwPGzK8lVvrDjEhuWzmR7dMmhCAwpoRBIKOEq7
WY+wQkiqeZMu9WNAL3S8qpEItWJ8ywnI6d0PzC0grv+CurWP8Wndmz19e0ZxdwYz
youSwIGjam+h+OlbTxDfzxVCBYjPlbqGuBCS5pN7XgrY/OFGjWGOCFjdutD0njVL
p4UY6wC3a/ZTVI2KfnmhMe+U0fM3vi5pSJpSJHhWHXWrJ5aCXPvky8tcOd0MZbiN
StWlngkSctcDxvim0n87rDEMLrTOzowinpkbNmnp8bg710X8fktecRX90HXFRIrY
7P5rhasPnGr/8eZQ/gzoCKx7ho2Vew==
=gRfh
-----END PGP SIGNATURE-----

--Sig_/IQy.iBSL=figIHzofeBZwLK--


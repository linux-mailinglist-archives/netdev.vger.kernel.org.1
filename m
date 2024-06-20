Return-Path: <netdev+bounces-105299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABAB910626
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 15:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0A871C20A9D
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFB31AE851;
	Thu, 20 Jun 2024 13:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="z3eJfICD"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939EC1AD3E4;
	Thu, 20 Jun 2024 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718890107; cv=none; b=RK2w+IpqSc3xZkL5N7predy+ichqeXai1YPC0ZafqHlWjrR0PtcKqnqARy14Rx5a9BN16CF2d5dvf99PEhKsfkuKt0mrrzfoHhV/1hRVznqbfjIk0eI5Ns2oQTBqb0o4araGUnS8sgX8iIRhVb3dkkRLSniFFon+RFyo02SESwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718890107; c=relaxed/simple;
	bh=HtPh7nrwIT5HDN7q+X4OHUF423G3xEmkp/tahV9ZY4A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DeP5urV1wmTmUCjduo1du+ltXq191tEc9rwbj5O4YgN3MkGzaCIemsXeU3HIjeuLNm0EWKj6y+xZ9GoPLlAYQMQ4VUvClM6/xrc1AwKpka/fODjfDriOzdWX00UtegHiGGeM30zFLuyqQUFUXfD+7YZ6QgDOV87909Vruyyj5Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=z3eJfICD; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 327628852D;
	Thu, 20 Jun 2024 15:28:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718890102;
	bh=gC3XTbwyiJFPVKF+L/fGQD25aTQ9MqZy+mjg4RtVXTw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=z3eJfICDEw4vrbKfTpn90v/mQ7WQ3dAOWi76amn8GqM/5piuhyc+9jqCPd+GCm9Sf
	 +7kZi0kM9vNjrXt2H65aSYfElfXE8yzOazGnRet5WlSoYUpq8EqHdRZ6FLzpVBaLCN
	 Li8nzOHg9qW+L6CUq4AilhjCgJz+1BpfGivrNKLDB41xF9G29YLdBkEC6OoXJEHZay
	 rQtshrNCM7zeVsz6jeQ4KmkU3nWx2aNSRKCi6LNmD98c0jP7DRWLcJRYSmdxPx2V/u
	 l1fso9xpdZW0eeAwvD61J/1ftYK5d/7g4ORzFPjdUfXM2TM+wWZA9YvuotvUcm4yw/
	 ikA7hrb/29/RA==
Date: Thu, 20 Jun 2024 15:28:19 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Tristram.Ha@microchip.com, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Simon Horman <horms@kernel.org>, Dan Carpenter
 <dan.carpenter@linaro.org>, "Ricardo B. Marliere" <ricardo@marliere.net>,
 Casper Andersson <casper.casan@gmail.com>, linux-kernel@vger.kernel.org,
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 net-next] net: dsa: Allow only up to two HSR HW
 offloaded ports for KSZ9477
Message-ID: <20240620152819.74a865ae@wsk>
In-Reply-To: <20240620120641.jr2m4zpnzzjqeycq@skbuf>
References: <20240619134248.1228443-1-lukma@denx.de>
	<20240619134248.1228443-1-lukma@denx.de>
	<20240619144243.cp6ceembrxs27tfc@skbuf>
	<20240619171057.766c657b@wsk>
	<20240619154814.dvjcry7ahvtznfxb@skbuf>
	<20240619155928.wmivi4lckjq54t3w@skbuf>
	<20240620095920.6035022d@wsk>
	<20240620090210.drop6jwh7e5qw556@skbuf>
	<20240620140044.07191e24@wsk>
	<20240620120641.jr2m4zpnzzjqeycq@skbuf>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Z3G+I4kidgh81Ius6flpYQQ";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/Z3G+I4kidgh81Ius6flpYQQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

> On Thu, Jun 20, 2024 at 02:00:44PM +0200, Lukasz Majewski wrote:
> > In general I do understand your concerns - however, as I've stated
> > this patch fixes oddity of the KSZ9477. I can test it with it. =20
>=20
> > To keep it short: I do see your point, but I believe that it is out
> > of the scope for this particular patch. =20
>=20
> So that's it? Can't test with anything other than KSZ9477 =3D> don't
> care about anything else,

For this particular code the QEMU tests were specially developed
(hsr_redbox.sh).
Moreover, I've tested it on a real HW (the SW emulation of HSR) -
EVB-KSZ9477.

Additionally, the code was tested with offloaded case. For all this
stuff reproduction steps were provided with commit messages.

I would not call this "don't care about anything else" case...

Going further - the response for those patches - in terms of comments
was not as big as expected.

> and will ignore review feedback,

As I stated before - I do understand your concerns. However, I do
believe that with this patch I do address issue for KSZ9477.

> even if
> the static analysis of the code plausibly points to a more widespread
> issue?

I don't have xrs700x to test. Shall I spend time on fixing some
perceived issue for IC which I don't have?

Maybe somebody (like manufacturer or _real_ user) with xrc700x shall
test the code and provide feedback?
I've used get_maintainer script to add all people involved.

=20
> As the author of commit 5055cccfc2d1 ("net: hsr: Provide RedBox
> support (HSR-SAN)"), who do you think should be responsible of taking
> care that it plays well with existing offloading drivers?

As I've written above - code which I've provided (including tests) is
IMHO enough.

However, if the community has other impression, then please provide
feedback. I will try to take proper actions.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/Z3G+I4kidgh81Ius6flpYQQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmZ0LnQACgkQAR8vZIA0
zr2b/Af/ePBl/NGBtg8HXWvdPkF4TkumQgaBUN2uZMRlGSdA7aPalJAwhZiu8L9d
EAw2s0EMBhCojdZ4WCD3fa9aU1LEa6vjRT2n2oVwCOCPXLnOwoVi+IzDcZN3NRJv
763pj6co4ZQpnd71u7kPJmlVTtDdAUbERZd+DMixJzed2ayD8Eray3bR2MTxr22I
ng7tzc+NwW/4BCWchK6N5h5wQPnGUdae6ZDBSDZcHAzMRNHFsDv+ZPb5y1Xzi+/r
Pvalnbu+s/iqukDfEiPL66eCEulL167pJVcio2mD5hGI1Aa+U828VRe+np4/7GXy
ItSoKYp/KrTUB/ASAMR3aMsDxrKCLQ==
=CUmJ
-----END PGP SIGNATURE-----

--Sig_/Z3G+I4kidgh81Ius6flpYQQ--


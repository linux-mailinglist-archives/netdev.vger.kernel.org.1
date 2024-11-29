Return-Path: <netdev+bounces-147859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0729DE6EC
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 14:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD7F8B2098A
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 13:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E9F158A1F;
	Fri, 29 Nov 2024 13:05:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB84158520
	for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 13:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732885522; cv=none; b=imW65ehs1v7CXi5bx85KJ/iNIbXGY6eHfYRPubXPbFbOkaA8nONmaZIQZoDB4MnCiI9J6XUAlJ0aTqAIegI0+OLkX8aLyyWrM09xK2Elbnv6p1LH7ZqZALtMbWXfDp13u9Kv3je8BbWC8Ovxh/Vy46ZoUbQuKOzC1+kJ1OZBtgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732885522; c=relaxed/simple;
	bh=/v7ZiPByGFrT+RmNT3fzBi6ce5dBbuZGWSvMKpileok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=teRG4ROaBCOeVJLvXAd3lpPa8ZoK4VUZlhG0qdxNCAplrKLdlgYDF1js2ZtpY/H/YYRQG8wlBsq0J+RzGDbXYzNRLlAvZX2pv60KNiKVt1RNNdxH21IVxzB4Q41pERQJjeBZ9zF9rJObnd6q1PPxWx2VFFQpc4bl47tiVAVjL28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tH0gK-00022U-FE; Fri, 29 Nov 2024 14:05:12 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tH0gJ-000nKX-0n;
	Fri, 29 Nov 2024 14:05:12 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AFCD338127A;
	Fri, 29 Nov 2024 13:05:11 +0000 (UTC)
Date: Fri, 29 Nov 2024 14:05:11 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Dmitry Antipov <dmantipov@yandex.ru>, 
	Robin van der Gracht <robin@protonic.nl>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, lvc-project@linuxtesting.org, 
	syzbot+d4e8dc385d9258220c31@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] can: fix skb reference counting in j1939_session_new()
Message-ID: <20241129-skinny-jackrabbit-of-relaxation-903ae4-mkl@pengutronix.de>
References: <20241105094823.2403806-1-dmantipov@yandex.ru>
 <Z0m53JjLCTEm7On8@pengutronix.de>
 <20241129-poetic-snake-of-recreation-32e05a-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3hgzgzczb4vfeuwc"
Content-Disposition: inline
In-Reply-To: <20241129-poetic-snake-of-recreation-32e05a-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--3hgzgzczb4vfeuwc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] can: fix skb reference counting in j1939_session_new()
MIME-Version: 1.0

On 29.11.2024 13:59:28, Marc Kleine-Budde wrote:
> On 29.11.2024 13:55:56, Oleksij Rempel wrote:
> > On Tue, Nov 05, 2024 at 12:48:23PM +0300, Dmitry Antipov wrote:
> > > Since 'j1939_session_skb_queue()' do an extra 'skb_get()' for each
> > > new skb, I assume that the same should be done for an initial one
> > > in 'j1939_session_new()' just to avoid refcount underflow.
> > >=20
> > > Reported-by: syzbot+d4e8dc385d9258220c31@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=3Dd4e8dc385d9258220c31
> > > Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> > > Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> >=20
> > Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
>=20
> Can you re-phrase the commit message. The "assume" is not appropriate :)

What about:

Since j1939_session_skb_queue() does an extra skb_get() for each new
skb, do the same for the initial one in j1939_session_new() to avoid
refcount underflow.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--3hgzgzczb4vfeuwc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdJvAQACgkQKDiiPnot
vG8wIQf/dd3tGCmrgyol1dddyp8l3DPDOEPRd56k7vEF6fa9JPxEn6yXP8njn4Zg
7+iq8mFHzuhxYtgHdS4vG7b+s1wvxPAwv1GHFVlYkXZ9KqHSll8tdiPpZZPglrtz
I64ItmDtKnej7DhtH+lTh21J4UXRI7lGwWG+7H+D4ta2oXw2bg+HKEcXAXGjiQkn
6rxUJTPpPsFJSaHK2D1ZEB1nzziqSRFqx0yrqEqCSS4cDKlc+wpzjF6/Gh/uthKL
BNwGbsqKZfoAB5PdN7iEqaluPGavmCPp1wPNWeGvWNC8sMkAGIk1ZnSFuQtpMI4s
sIyvwvuuqnmoD2SgwkaAFmRySUljIA==
=+3se
-----END PGP SIGNATURE-----

--3hgzgzczb4vfeuwc--


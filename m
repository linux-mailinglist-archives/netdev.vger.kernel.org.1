Return-Path: <netdev+bounces-256691-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIW0ENc4g2ngjwMAu9opvQ
	(envelope-from <netdev+bounces-256691-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 13:17:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9047BE5B26
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 13:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52BA23055632
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 12:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9415C3ED12E;
	Wed,  4 Feb 2026 12:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEV8rrua"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E87359FB8
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 12:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770207161; cv=none; b=XqLV7ogsDOPrZa06ccU8Ji+RX6gM8cY+vpdDm1K9ZMmiROUE/pcMaz94iWhdILhN58k5vJynalhVjAdmZAJnX0pCU33GwHyjdcVKjF+8lVr7c81pxaa3nYyCl0dfdO8h/lslzPVIBnluFbRdYz9gusvDhxesqWsXEUqsGWLTR78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770207161; c=relaxed/simple;
	bh=32al2y9NedVlQ+5NCmezUbchkwA6XNnFrhycK5R4aLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2sWc54fwB5Jazbqq+I9H9JZxxxksYeMpBYB7PiVWKyEM1gY2ieL6e3m3B8isxCb+SK84yRrZBy6OUDUlC21SC9UJSnKsIC9TnCnkXBzgh2tM07WZQ7q3Yen9YjJkDsBckrxrGY7nxoFgBn6Gz+5ITyMCAi+07S4lSsDvPBbkFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEV8rrua; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-89476eaaf16so67478336d6.1
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 04:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770207160; x=1770811960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OrfzD1lTlAdR3bBur5U4iZ/FZqIOUF/A1GH3WkYhUNk=;
        b=fEV8rrua2ckSLEV4GzX1Ltvb7XysoxN03vldL9BEC6VZLqvJK+FPEPmzrkCJxJqB1k
         Zl0RCI66/5yBNSotHcMKaXdznMPWPGLsb6pXMklQrAQQ5shTlth5MLE7KKXN1uHB5rSN
         vT9J3zaKRgPVd7h9fu6E9qj0vd3tTdBgoVM9sKEO1VKOc6yuJc3nCUTF4/XcYifsqreK
         Yk+0segYUE3c0FUyuqqzvxvJ1RTRsSH+3REqYyVzwKMSpnxjqC/ivUlMf+ii++kHwn1F
         NAc8+YNZ6/BKC8jvdeCvWpkuiKo5ZWwURKnxOOnyv2s1pN50N1BnZx6jG5qRYF0qwKmN
         tIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770207160; x=1770811960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OrfzD1lTlAdR3bBur5U4iZ/FZqIOUF/A1GH3WkYhUNk=;
        b=dLpPXBLkH7PtCQ4VZsqjoXUfTae8Gzdm+SqVpgaclUKrVJRPUdOH2j5tbqTlkk/0b7
         oWty9btloJk2yiRhtJRE4sAy4jW/xlypJQZt4C4O8ZIHJ28kDo1SqsihCmg8dU+Fwg+Z
         EYKagDrjN56L74/qpk7WpLMmDc4ngc/1sU4AOnmMnlyOpgB2vgbAoeZCr85TUYJdPIbp
         QY/O4vgZw9ogvKsZPu5uOyHYmwsu+cg77qZvyEE9BKoDEA2VZIXU3efTRglDb5hbvgPc
         i0e45RDUnmTYA6tTIK7/GVTX4iGTCWHlcS1+vnXNOne9+2LXFfrxwgHQTFIpq5dMlJlq
         H7lQ==
X-Gm-Message-State: AOJu0YwOMqe5C4q+nGI5AJk1GU+A7fZGb5v2Ezm4hmufZuAUfSoc/riB
	twen9f2XM0h6d+GWJfm/4Q6e1Mmqtv0O7oahL5w7auhkgW6vWGFpBwaX
X-Gm-Gg: AZuq6aIeig63y/JVSq+oCmrcjMSZ1zF2XfCVhUE7jehVxSzAo3LHCrPKEDWamqMsnST
	I4kih61j4BG2trqgt9A6mh/udkOROst+JSryNnR3G3uIJWxfxctHNNNJTJtOy4ej3/H/4E4Z4Np
	AJDo+Fi6SGI8CtKNiSLBUNySxU7LOat5OgEEvWTvxMGn4C//xiMibOkX9BbyEKU84X9pj8Cp5Y+
	Q4ImwXdcRefHudrAuqmlnZy69aFnCGhknYbrjxCj6Bq1mQrm0MbvghycPa6XaQMv1EItBcK6iyM
	oTxjbfRQTL+DeHXLPWXK6++h6KZck3+S41LEZC2qNtOrMRQD+c2BKVrXjPtSc9z8uBFlJHxd0D5
	J9ZRF6z1+5YMijrzorKP0E2baXvxk+Y+33+uHFSKxPEUWoXpbsd4Dfm32Ide6uBZk0gdvFJQHvL
	9U/Y8Jy2A0qw9PBoJxiw==
X-Received: by 2002:a05:6214:519c:b0:895:ad1:c2c8 with SMTP id 6a1803df08f44-895221ec7c7mr41807796d6.68.1770207160087;
        Wed, 04 Feb 2026 04:12:40 -0800 (PST)
Received: from pek-khao-d3 ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fa5576csm176201785a.2.2026.02.04.04.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 04:12:39 -0800 (PST)
Date: Wed, 4 Feb 2026 20:12:32 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Meghana Malladi <m-malladi@ti.com>
Cc: netdev@vger.kernel.org, MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Himanshu Mittal <h-mittal1@ti.com>, Simon Horman <horms@kernel.org>,
	Byungchul Park <byungchul@sk.com>,
	Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: [EXTERNAL] [PATCH net-next 0/2] net: ti: icssg: Remove dedicated
 workqueue for ndo_set_rx_mode callback
Message-ID: <aYM3sP6LQU5jOPLE@pek-khao-d3>
References: <20260204-icssg-prueth-workqueue-v1-0-9a892f4b293d@gmail.com>
 <583feb00-09a8-4008-ae50-b6f3e3f990ba@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yk0taMIwVVR7ANj2"
Content-Disposition: inline
In-Reply-To: <583feb00-09a8-4008-ae50-b6f3e3f990ba@ti.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-256691-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,proofpoint.com:url,linux.dev:email,intel.com:email,lunn.ch:email,ti.com:email,davemloft.net:email]
X-Rspamd-Queue-Id: 9047BE5B26
X-Rspamd-Action: no action


--yk0taMIwVVR7ANj2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 04, 2026 at 04:44:21PM +0530, Meghana Malladi wrote:
> Hi Kevin,
>=20
> On 2/4/26 08:11, Kevin Hao wrote:
> > While addressing an issue in the cpsw driver, I based my fix on the
> > implementation of the emac_ndo_set_rx_mode() function in icssg. During
> > review, Jakub pointed out that the dedicated workqueue for the
> > ndo_set_rx_mode callback might be unnecessary.=E2=80=8A
> > ZjQcmQRYFpfptBannerStart
> > This message was sent from outside of Texas Instruments.
> > Do not click links or open attachments unless you recognize the source
> > of this email and know the content is safe.
> > Report=C2=A0Suspicious
> > <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK!
> > uxdqXRfPtm1bKoXPFrvrtsCD2dIkXHVJwEzupcwg1k-qY0e_2PUuMdZgJf-
> > SUVShc4kuXcBnqQbeqGz1dHBW-_OSdROPAjSiNpSTmAhDg8nQbc8$>
> > ZjQcmQRYFpfptBannerEnd
> >=20
> > While addressing an issue in the cpsw driver, I based my fix on the
> > implementation of the emac_ndo_set_rx_mode() function in icssg. During =
review,
> > Jakub pointed out that the dedicated workqueue for the ndo_set_rx_mode
> > callback might be unnecessary. I subsequently used the system workqueue=
 for
> > this purpose in the cpsw driver, and it performed as expected. Therefor=
e,
> > I believe the same approach can be applied to the icssg driver. These t=
wo
> > patches aim to remove this dedicated workqueue for icssg drivers.
> >=20
>=20
> It would be more helpful, if you could provide link to the cpsw fix which
> you have mentioned above.

The fix for cpsw is available at:
  https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=
=3Dc0b5dc73a38f954e780f93a549b8fe225235c07a

Jakub's suggestion can be found here:
  https://lore.kernel.org/all/20260127190836.6a420768@kernel.org/

I will also include this information in the v2 cover letter.

Thanks,
Kevin

>=20
> > Please note: I do not have access to a board that supports the CSSG PRU
> > Ethernet controller, so this change has only been build-tested.
> >=20
> > ---
> > Cc: MD Danish Anwar <danishanwar@ti.com>
> > Cc: Roger Quadros <rogerq@kernel.org>
> > Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: Meghana Malladi <m-malladi@ti.com>
> > Cc: Jacob Keller <jacob.e.keller@intel.com>
> > Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> > Cc: Himanshu Mittal <h-mittal1@ti.com>
> > Cc: Simon Horman <horms@kernel.org>
> > Cc: Byungchul Park <byungchul@sk.com>
> > Cc: Markus Elfring <elfring@users.sourceforge.net>
> >=20
> > ---
> > Kevin Hao (2):
> >        net: ti: icssg-prueth-sr1: Remove unused workqueue
> >        net: ti: icssg-prueth: Use system default workqueue in ndo_set_r=
x_mode callback
> >=20
> >   drivers/net/ethernet/ti/icssg/icssg_common.c     |  1 -
> >   drivers/net/ethernet/ti/icssg/icssg_prueth.c     | 13 ++++---------
> >   drivers/net/ethernet/ti/icssg/icssg_prueth.h     |  1 -
> >   drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c |  9 +--------
> >   4 files changed, 5 insertions(+), 19 deletions(-)
> > ---
> > base-commit: 5c009020744fe129e4728e71c44a6c7816c9105e
> > change-id: 20260203-icssg-prueth-workqueue-f460eba72132
> >=20
> > Best regards,
> > --=20
> > Kevin Hao <haokexin@gmail.com>
> >=20
>=20
> Thanks,
> Meghana

--yk0taMIwVVR7ANj2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAmmDN7AACgkQk1jtMN6u
sXF23Af+OXAy1SHenCjrgpG2Yzng/T7TPESPJAXw8Rdf1rLhOAZct/1ZffmZjpN7
pHub3jFEHVlClOO7xU3rYmPpoxEYGe9RRJnk8Hl7zU54lreEMm5Gy6TxYF0RRxuX
wBn+reKKQVP4yHoz7gi4gzuglU5s8JRf7s38GQS3MG7up6VGPq4nnGHVgo37E0M3
G6TkH9kLkRQnUOFNUJ/ziEWRJGXGggCJMkfRJyM2hYwwWZRuhZb71MUpd+tKwMqI
MvZTgTvatKQF5U/eR7HA1A2+0Jc7Bu/Kogmi1/7igCnyEg9jI3gywoCzMqPOvjmH
3hvKY8E4pvnNFJt4smudVO7hlffxdw==
=ORT6
-----END PGP SIGNATURE-----

--yk0taMIwVVR7ANj2--


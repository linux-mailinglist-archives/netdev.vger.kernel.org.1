Return-Path: <netdev+bounces-291825-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2K2WOCPNFWoTcAcAu9opvQ
	(envelope-from <netdev+bounces-291825-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:41:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A71D45D9DFF
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A8DC300AC2D
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAA23CAE73;
	Tue, 26 May 2026 16:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="mk0Bwf5h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E205A3C584A
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 16:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813501; cv=none; b=d/rF23trDhBJT+0MQk8HNU5+k06XoEH3VFu1b9CrtQdidpKxVinaIzXZDkrk7sAnP43q2hS3cdFiU2LjyG053YKfsfM7QG0SP3+HH31OWIBzSa6GxAR4SOxWvJ6bkUGk4HK+YR4HTY5qJw0++cfYg6q25mE6/Lp1lWSn9K9f0lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813501; c=relaxed/simple;
	bh=4V0/hRzQM3QPZtd9ciEuGpakZz9BDAJEY1Xq/95IEYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TP/aL+E9JpF7xMq2OWVWnOWzYgVVSePWr9nbkfZMjvk0EbDHKlEWG+kTv0FvS6gfX2z4VVT7TkggaWqgywPLOEUVu38MD2Yr54iuGTZRJqPLMtplviiHqQ8xcOXrBKGdr2VyvhRtVHZJsl+e6UN1PFYZ5gpDidXRS0ZglkyxHb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=mk0Bwf5h; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4905529b933so24545965e9.0
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 09:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779813497; x=1780418297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+neT3f/iOdkns4E+8cxUHIEwouFFRC5e7pB2NZRvaQM=;
        b=mk0Bwf5hXpVXtR8qKrq4eVR8YRH8uAgW243P9LPUcvYHlW/W3CenauBquVI1o3J3Gz
         ykz9ET95iEHsRPV830hnFjr+E9v6rT8uhO0Iv8U2EVfdIiTHUUuKMxFybKQ5FuNj38bd
         fdstOAocTCEVIJp/li2MjrH1TtrNYnTy9LFZwGX72Coi2ym25O4/5jgSbT/7y8xXzHEk
         Fc/IBf27hQDsuVeDJJOKWgwtUeRO5mJq0jJAVfLR97P3J7upjpS4Qdi3HsJ8sYyNyP/o
         LOkZcOScYuknd4QAmTD+rRr6zgy3tK7XkOL9daYc9jJ12Qq/UI632ZbmKMp5vbeHF0ud
         rzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779813497; x=1780418297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+neT3f/iOdkns4E+8cxUHIEwouFFRC5e7pB2NZRvaQM=;
        b=Uq479mSi8A54MO/j5R4gsow/B9450n8GeA23iR9AVNTESUVgIVPpWwGJav0hJlRDjV
         dxZg9bgAM0RzjcdJKmoyjTYezUFPp6UgQSDmUvvfKIoMLR3eeg3Gnv26gA9BtQRb8vdd
         sCMHS2kCet4DuZp4I/D4eub8bJ6eTyZ/wR541x19t2107kUGFhC0aJFzu2y+kwDN6gXH
         o0fNRpKIzn21r30WVzImpKZRZGzXNT9gPBrNjE9YqGVTYzY94JOR68jw6fPaIxIav96j
         39DOjdrtOPDuWt6LM235ExZ3Kt0LLQuTXFmLMwJcPh5Fe0SeNzvCumWYLX9uWHCXRfw1
         +QbQ==
X-Forwarded-Encrypted: i=1; AFNElJ9UY21Y1ucSYSB7MKisQHAiQxbuvMMkEVfggpCyRPTgCsN+V59ly8x+LMuCQ7RY0oKDIv25DWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxF1iAhgYK3sWl0gK9Ie7DGOfS2/RNylgpN0IXz2TZINAzqx68
	270b5dt2TKIidTQA9zZ2L7+e+FMZl1ZZI4w57CfvCjJaUud5jPVenpRdXGKDC60Lgy4=
X-Gm-Gg: Acq92OEIhqshysf6uYfKIF3NL30k/ERmBqUIWKFEdGJyRUOlb97TGiSa7TG+VI1ZEvY
	wrFQEBSq2DC/5lHRpFi0VMl7x8ySCWCoqgZotdHRWDPEhe9m36oGFPir07ywJBDPBAtODoNS2q7
	zmYK0tdyN4bHV7K5GCMqei/5vj2yJtXEIv2BmdL9NvUplswwNLs50U/XAYKIgZI5thyjyrUyrOA
	UGBI0qUYA5pLTtIEbBiSG1Bw0NcJ3AKCcrPdUZC8PmzttGk2HBvmmBkKWzMljiEyC5SH61MYlcO
	M4YfO90i9GZMpOoi/ANcb//KSwmiyEoyUIkWxj8J2WP2f2vYy6hlw3cImdUF3Et5+hthU1rAFxV
	fF8lf+EA8mExKYKCFby8wgQVCDYm1+HK6kyKcpOxkGNEQf4RU4rgAduwLByMx2K+2kHnAIYx+g+
	zKpzq3c1mZsbGotp1ca2zxv7YVIHeSlY3AqRgZBUGtkJmBg1GWnY6w5hzrNLk0VOzT3LcyLJ2q1
	wrIJ7Bnu7bDYMI=
X-Received: by 2002:a05:600c:4ecc:b0:485:4388:3492 with SMTP id 5b1f17b1804b1-490424b25abmr314126765e9.11.1779813497306;
        Tue, 26 May 2026 09:38:17 -0700 (PDT)
Received: from localhost (p200300f65f47db04a716d2bdeddb4813.dip0.t-ipconnect.de. [2003:f6:5f47:db04:a716:d2bd:eddb:4813])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45eb6d493dfsm37901229f8f.23.2026.05.26.09.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 09:38:16 -0700 (PDT)
Date: Tue, 26 May 2026 18:38:15 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Max Staudt <max@enpas.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Helge Deller <deller@gmx.de>, linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, netdev@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, "Christian A. Ehrhardt" <lk@c--e.de>
Subject: Re: [PATCH v1 0/8] zorro: Improve handling of pointers in
 zorro_device_id::driver_data
Message-ID: <ahXMGtBv_pQXM7YS@monoceros>
References: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
 <CAMuHMdUVoNg-rSV_hDcvi6KCosmE=SMcxUj2Y8fkoJ=33zMSXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="26ssrqftvvoyehs2"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUVoNg-rSV_hDcvi6KCosmE=SMcxUj2Y8fkoJ=33zMSXw@mail.gmail.com>
X-Spamd-Result: default: False [-1.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	TAGGED_FROM(0.00)[bounces-291825-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,hansenpartnership.com,oracle.com,lunn.ch,davemloft.net,google.com,redhat.com,enpas.org,gmx.de,vger.kernel.org,lists.linux-m68k.org,lists.freedesktop.org,codasip.com,c--e.de];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,baylibre.com:email,baylibre.com:dkim]
X-Rspamd-Queue-Id: A71D45D9DFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--26ssrqftvvoyehs2
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 0/8] zorro: Improve handling of pointers in
 zorro_device_id::driver_data
MIME-Version: 1.0

On Tue, May 26, 2026 at 05:01:48PM +0200, Geert Uytterhoeven wrote:
> Hi Uwe,
>=20
> On Tue, 26 May 2026 at 16:17, Uwe Kleine-K=F6nig (The Capable Hub)
> <u.kleine-koenig@baylibre.com> wrote:
> > this series is about improving the handling of pointers in struct
> > zorro_device_id's driver_data.
> >
> > While it's ok on all current Linux platforms to store a pointer in an
> > unsigned long variable, it involves casting that loses type information.
> > This can be nicely seen in patch #7 where after profiting from patch #6
> > the compiler notices a missing const.
> >
> > Preparing for that change, all zorro_device_ids are converted to use
> > named initializers, which is also a nice cleanup that could stand for
> > itself, as it improves readability for humans. (That is necessary
> > because an anonymous union can be initialized by name, but not using a
> > list initializer.)
> >
> > My motivation for this series is the CHERI hardware extension. With that
> > pointers are bigger than longs and thus you cannot store pointers in
> > zorro_device_id::driver_data. So this series is also about getting
> > support for CHERI into the mainline, but I hope the clean up effects
> > mentioned above are justification enough to accept this series.
>=20
> Thanks for your series!
>=20
> > The dependencies in this series are as follows:
> >
> >  - Patch #5 depends on #1, #2
>=20
> s/5/6/?
>=20
> >  - Patches #7 and #8 depend on patch #6.
> >
> > So if the ata maintainers agreed to merge their patch #1 via scsi, and
> > Geert agrees to patch #5 and that it's also merged via scsi, patches #1,
>=20
> s/5/6/?

Yes, indeed. And I tried so hard to get all the numbers right :-\

Best regards
Uwe

--26ssrqftvvoyehs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoVzHQACgkQj4D7WH0S
/k4BXggAoAuTCgxPow5/rQYRxSTj+kNc4XmxhIlX39wkjq4KJoBOkfK1zOhQISV1
4HHCqWa9m9dov4bu6Kg8LwbKa2UChzh7HIDanvg0FuTjuR2DvZAqQ1h3KlZHQj4H
Dh1fxxwA9H2mAUN8tHgeBxUVZ6qajflOjKFHpsQbdgTyoj2LkR1szY77e5P4QdmS
0UJbs5rWuTPA+ErMqqdl4SkAygYx8SEw84ch7byHO4yx9rpUCp8zJk95dKJCgAir
L38wVLJUZNR7sQVkPKakWtv34niUdKWjqIXa8yB4GHOQFX65uFKEzrvodPCyE2J/
vgh7fbUvdt3OqTL+DpSduQS2l1F1qA==
=W3Nr
-----END PGP SIGNATURE-----

--26ssrqftvvoyehs2--


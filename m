Return-Path: <netdev+bounces-295798-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OWlLJyq7Imp5cwEAu9opvQ
	(envelope-from <netdev+bounces-295798-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 14:03:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5267647EBC
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 14:03:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=WPk4LjV2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295798-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295798-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB282302591D
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 11:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488CE413610;
	Fri,  5 Jun 2026 11:56:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711A04C9572
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 11:56:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780660585; cv=none; b=XBfasfeoh+xT9Pt9FxBBSmk7ld2/xXsayuHjYXnoW4htmgH6OU9FlnMRUZfRLSrs76OD8raxLDcBtT3UY6ogDDEfQiv81xLPBBFdDAyId/C3Rdd0znjust1QQphIAh7FOasWgS24V6GkIbhrUCp/UGqwSdbTRi3fQgT6fhnjh68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780660585; c=relaxed/simple;
	bh=RUeXkJiOC5YOIHyl10EHg1neCRlJCG9AqHP1nNGld8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r64lsm1dIkjSj6lp9mCtgUxtY22lESFC2g4Rv43hhkv91dtAsZBIyA8ASJDgZIWYePxqKRBsm5+Pga526QvocuXyJCXdsK4hFLqgjpumqCtcUIEMbupj0Bsjtyz2L5ktbgRTXsrW8812eY3IaWluI+q0VkVxn92LThFCeJmG1Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=WPk4LjV2; arc=none smtp.client-ip=209.85.128.43
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490be03d47bso15064855e9.0
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 04:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1780660581; x=1781265381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+kMxhX4dP4R/LjY4CwrRq2xMY3d+unBriPLMp8xLnLc=;
        b=WPk4LjV23jxnahAgWyU3SDAR/6VvX1WbfQplE0M5hwrKobgCUdMlIgh98Q6Gjw53cK
         Ucem92i0wYtq9gOBRtze4GqMsVHM4khWVXtfu9kglV7LPd3vA6k0aryBRZhoAVtyLnRr
         dl8CtJOvuqkIxSeBJ7OiWygIoohnk98UJoKsplWZalRynW1h4UUxBJmU/5xNbV+wry6K
         2wjZLNm5HNm4rifBcYbOxWZkroP8JW6sftHCQLKDD1Mz8YMvQGWe4Jzme4Rm7P3zx5f/
         fb3st2sU5OFPght7xhRb5lPriVWHU5YGYicn4arAskw2JjdPa1izKTBYi9u4TOxZYL8z
         FkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780660581; x=1781265381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+kMxhX4dP4R/LjY4CwrRq2xMY3d+unBriPLMp8xLnLc=;
        b=A1tV2ax1dABdrHVb3GElzA4FNxkGBHxA+RMBkw/Zuih8YGp5pNrWtuigVcaKJX6EKK
         7HKdBxixWnNR+v2hVgbDpxiGI3Wgor2TtgGlj2uF6JIQw2Z8cekLi2rYBVTCIWyklE8k
         h25AoNjgpMnkHNHp30aXaNmRQO6nbkXJ1Stdq0E1vKD2dCk0o5MUg/GhrNq11+ic4BBr
         wDYzx5IaxMaoHRJkmeCVhLst8XSlXohCqvzINTo1cEiBYlLUYT6n+N72kKVTV4BwaHUX
         +FvKhHnAHS9WwHSrQsjFfk3I65i/ePiGjyu2MS1MsCbt1JHnnMJIlDDqwUlM+jAvn7Ru
         2BZw==
X-Forwarded-Encrypted: i=1; AFNElJ/0g/kN0dJ47F13bR8P1RRIqmLLtvnpDYIIKJXsIJUa8lIGqu35lcbfDX4q963rBvLgd/98zcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJOoghF3y7J2DbLZ8Idhc1EPYFwR4/BQSvb12J3TaAPEX5cW8x
	KztpKv0b7OHKaHaguVVBZ1cBTVAHBzwR8eTGJ6RtdGduEm2OgEI+Ra1UZidKIHb4Vx0=
X-Gm-Gg: Acq92OGWzfp6vjoah1vE6FSF20axywDd6umKKkL23lxnwVGsJ7MDEt/336TIDkzkH80
	LsKZ0JLRLuBb2fnBUmS0hkV3rAu2aL7rTJhzWZXuY9+GW2zLQztdjjvLhuM/jjQIIo+H8AeHbCd
	dvA/FIScwNFg0De90sC7tOugoZxlbw+bV0KoBICKOuDoiKBdaKs9P/3gSzc8+am1FOZEJh66N98
	cQxf/EqFK9t4V0WQgvHCAGJpOtyEru8ZHPkRfIHI7TeRivcpmgfp+62lfJDqYjGio0pU8Pncidx
	JclJ4Lcxqm2KGFXEeTPwWoUHQwziDbt+WJy8NxcEZc0LtJvnNOkhBnSZcEeJlvbYEcjQVmQafdJ
	aMXMiML2gfNJmDDL69cVTTB7VGrVfuXoGRUOz1WFTAVN8tXtVNExW4zf8TO1aSqbEC2f0Yke5Vs
	H7ZQm/aKjJcmKe3lomYUxPXYGpR+i3UefW
X-Received: by 2002:a05:600c:8705:b0:488:ac01:72de with SMTP id 5b1f17b1804b1-490c25898efmr60737855e9.5.1780660580944;
        Fri, 05 Jun 2026 04:56:20 -0700 (PDT)
Received: from localhost ([212.133.41.47])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-490bc3fd502sm147344695e9.11.2026.06.05.04.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 04:56:20 -0700 (PDT)
Date: Fri, 5 Jun 2026 13:56:17 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, netdev@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, "Christian A. Ehrhardt" <lk@c--e.de>
Subject: Re: [PATCH v1 0/8] zorro: Improve handling of pointers in
 zorro_device_id::driver_data
Message-ID: <aiKyB-28VEg1kp7W@monoceros>
References: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
 <a3f9e96e-3bbb-4cfc-845c-58649405a1cf@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="22tuv3cnyx6wf3bq"
Content-Disposition: inline
In-Reply-To: <a3f9e96e-3bbb-4cfc-845c-58649405a1cf@gmx.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:deller@gmx.de,m:James.Bottomley@hansenpartnership.com,m:martin.petersen@oracle.com,m:linux-ide@vger.kernel.org,m:linux-m68k@lists.linux-m68k.org,m:linux-kernel@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-i2c@vger.kernel.org,m:linux-fbdev@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:christian.ehrhardt@codasip.com,m:lk@c--e.de,s:lists@lfdr.de];
	DMARC_NA(0.00)[baylibre.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,hansenpartnership.com,oracle.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295798-lists,netdev=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E5267647EBC


--22tuv3cnyx6wf3bq
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 0/8] zorro: Improve handling of pointers in
 zorro_device_id::driver_data
MIME-Version: 1.0

Hello Helge,

On Fri, Jun 05, 2026 at 12:44:04AM +0200, Helge Deller wrote:
> On 5/26/26 16:17, Uwe Kleine-K=C3=B6nig (The Capable Hub) wrote:

Your MUA seems to interpret my UTF-8 encoded name as latin1 and
converted it to UTF-8 making my =F6 appear as =C3=B6. I *think* the problem=
 is
on your side.

> > this series is about improving the handling of pointers in struct
> > zorro_device_id's driver_data.
> >=20
> > While it's ok on all current Linux platforms to store a pointer in an
> > unsigned long variable, it involves casting that loses type information.
> > This can be nicely seen in patch #7 where after profiting from patch #6
> > the compiler notices a missing const.
> >=20
> > Preparing for that change, all zorro_device_ids are converted to use
> > named initializers, which is also a nice cleanup that could stand for
> > itself, as it improves readability for humans. (That is necessary
> > because an anonymous union can be initialized by name, but not using a
> > list initializer.)
> >=20
> > My motivation for this series is the CHERI hardware extension. With that
> > pointers are bigger than longs and thus you cannot store pointers in
> > zorro_device_id::driver_data. So this series is also about getting
> > support for CHERI into the mainline, but I hope the clean up effects
> > mentioned above are justification enough to accept this series.
> >=20
> > The dependencies in this series are as follows:
> >=20
> >   - Patch #5 depends on #1, #2
> >   - Patches #7 and #8 depend on patch #6.
> >=20
> > So if the ata maintainers agreed to merge their patch #1 via scsi, and
> > Geert agrees to patch #5 and that it's also merged via scsi, patches #1,
> > #2, #6 and #7 can go in without further coordination.
> >=20
> > Patches #3, #4 and #5 are only about using the same initialization style
> > for all zorro_device_id and can go in without coordination.
> >=20
> > Best regards
> > Uwe
> >=20
> > Uwe Kleine-K=F6nig (The Capable Hub) (8):
> >    ata: pata_budda: Use named initializer for zorro_device_id
> >    scsi: Use named initializer for zorro_device_id
> >    net: Use named initializer for zorro_device_id arrays
> >    i2c: icy: Use named initializer for zorro_device_id arrays
> >    video: fm2fb: Use named initializer for zorro_device_id array
> >    zorro: Simplify storing pointers in device id struct
> >    scsi: zorro7xx: Make use of struct zorro_device_id::driver_data_ptr
> >    video: cirrusfb: Make use of struct zorro_device_id::driver_data_ptr
> >=20
> >   drivers/ata/pata_buddha.c             |  8 ++++----
> >   drivers/i2c/busses/i2c-icy.c          |  4 ++--
> >   drivers/net/ethernet/8390/hydra.c     |  4 ++--
> >   drivers/net/ethernet/8390/xsurf100.c  |  4 ++--
> >   drivers/net/ethernet/8390/zorro8390.c |  6 +++---
> >   drivers/net/ethernet/amd/a2065.c      |  8 ++++----
> >   drivers/net/ethernet/amd/ariadne.c    |  4 ++--
> >   drivers/scsi/a2091.c                  |  6 +++---
> >   drivers/scsi/gvp11.c                  | 17 ++++++++--------
> >   drivers/scsi/zorro7xx.c               | 16 +++++++--------
> >   drivers/scsi/zorro_esp.c              |  2 +-
> >   drivers/video/fbdev/cirrusfb.c        | 28 +++++++++++++--------------
> >   drivers/video/fbdev/fm2fb.c           |  6 +++---
> >   include/linux/mod_devicetable.h       |  6 +++++-
> >   14 files changed, 62 insertions(+), 57 deletions(-)
>=20
> you may add to the series:
> Acked-by: Helge Deller <deller@gmx.de>

Thanks!

> Since it touches various subtrees, I assume you will merge it though your=
 tree?

Well, my plan is that the scsi maintainers pick up patches #1, #2, #6
and #7 and I remind you once #6 (i.e. the dependency for #8) is in
Linus' tree. But with your ack the two fb patches can also go in via
scsi.

To James and Martin: I didn't hear from you about my merge suggestion up
to now. The other affected maintainers agreed so far that (assuming
you're using b4) and interpreting Helge's ack as agreement that you also
pick up the fb patches, you can go for

	b4 am -l -t -3 -P1,2,5-8 cover.1779803053.git.u.kleine-koenig@baylibre.com

If you like I can also pick up these patches (then with your ack please)
and send them to Linus for the next merge window. Just tell me about
your preference.

Best regards
Uwe

--22tuv3cnyx6wf3bq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoiuV8ACgkQj4D7WH0S
/k6cwgf+IBJ8XPNUSo4d38q7fIjSN9Kio+eF/i1F0XZFkTXu/snZAgAhVec4a9nQ
0tReoiNbPZL5k1kFhyjqoVSmH2A6Oe8hDK/rHeszhxosEzgOuGyGVmM1cDKfUkNQ
+nhcan81Bf43fZgyFWoOlxns+20U6kjBBAksZHGYgm6L41w0tjVYLHTN9Pv1jTWz
TK+k3WMkM0Sln7O6Rk2DBDBNJ8/lz82tGZkcfgmaM8P8WffD91LeUDcXvTBNYFJR
9P0mISJgM+Qt5WaJwzW0k/h0Vu3HPh3P3wPIGiYQGLV7jfcHFG2xvWIwxONopqV5
MD78q/W31G+Q1Z796Ms01uQxrzyWaQ==
=ZKbW
-----END PGP SIGNATURE-----

--22tuv3cnyx6wf3bq--


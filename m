Return-Path: <netdev+bounces-305768-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3e+6FWIuTmoNEwIAu9opvQ
	(envelope-from <netdev+bounces-305768-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 13:02:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A05A07249E8
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 13:02:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=TVCoBivw;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305768-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305768-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68D573003E99
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 11:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809E64314A3;
	Wed,  8 Jul 2026 11:02:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F60430CF0
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 11:02:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783508570; cv=none; b=EfuiKZf5NS0L+qPAeNZgB+TK64A1SFSMvTEtXguYqJNfRF6n971zWns4S+42iXwRUCRjhxA6/WFie43YuUet4jVnpyZEtIFDcpJ0KpiY9mGwVhv3e8GAIrC/D658Ot+ZekahEAjNp8mOePPpb5O58NpqSz5Y+zpb5ChEm9DDWDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783508570; c=relaxed/simple;
	bh=oPZaKv1OXlABgq9QPAtMKfhvRK+tiC3E15Kuw9g/LH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNs4XSuxjR0D4yKbCtOr22sn1kAA+8mVLv6iitGTBK+D+FFGMUz+iwQYzZXHjndV74kvY8rZ9DwizNkmAUztx1wvinDVvf6wLeCKMuEHC/3YeIzso9SF4Z1/AF0EWOsZ3JCMi/29hpzzRUkxh9qa5UPa8JoJxVUGg5JzDyd+6F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=TVCoBivw; arc=none smtp.client-ip=209.85.128.46
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493b27c7451so18913595e9.0
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 04:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783508557; x=1784113357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oPZaKv1OXlABgq9QPAtMKfhvRK+tiC3E15Kuw9g/LH0=;
        b=TVCoBivwZB2Iu+tXZ3PZJl6FTVvr7/zv/pmro4MivlSx8HxlzupIfthsZ8Jim8mcQN
         Ag2xQD1zlSNB9iI/B816fkbjAjAvNmspd4RfFBRANlt03eGinG4oeeNYVFkZSx6rkpLT
         qG5bHwkZyvigBoT6egeQcBw0Wgu6XK/y/nU7ui0lkmSg6lwhjZI/qfMt7mEfCxRptRbh
         iVXPhcg/iWozh82DGlFpg0+caPRIMs/IBAkwHkEiOlb22hdpVFYsy3a/LmdxDXTB3JP4
         aOua/pWfGBrSsBV7C2QTnR8PelDfMvOLDFzIDzu+CeAy0oVyQpsUWykyUPeRUEeF7kEl
         EKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783508557; x=1784113357;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oPZaKv1OXlABgq9QPAtMKfhvRK+tiC3E15Kuw9g/LH0=;
        b=edAybCyIGUxSm7MqBP3GaG50TtPG5uBf8vbEK9vZl+g7230kvF4Aso/DrCZ9lcE1qn
         o4o1MQ39EH4NyvrAByra/aNaJmyvmJDo5KJX0lN5HkJMRQQqWqcb3TKSOab93b1omwlS
         4acVDfRuee8eEz8BkEmMR8EXgaH7VTkk9m/wTK3EPjlcSHr5H2c/9Zif+V62O4xIX6Hz
         PbamwHG98Q/qEwjkWElc6xfEOAMpNs431BQheHFEShyR4WuAL6jNwA0xGD9Q92lfLXFy
         dA6pZ/0qOjrX3dd+H/5rTQW7fMioAbMoDBSBTM1Tc9k2ytexK1Kmy9gRZv7syz0yAB8B
         78Tw==
X-Forwarded-Encrypted: i=1; AHgh+RpJLAQUZWTiNSjm32XfOkhsoglA6Pxe9CQbIafhth0zDiOJCburfpEllb6LWsy/qnZaP/+oZPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiflVu/8ryDxuYJpE/JVJtfR9dOegA3IWTtiEOIr3z3qt2ag4x
	4B1gPVi8rMkzXPXBawB1Viv4Y6xTfBvEsgnJYTViN965RyUMuJ/J6pfBFFK0m+mVdSqWYjoyV4t
	3jdoy
X-Gm-Gg: AfdE7clibZc8oxYq3h0H80BCw12wdVeEBONZkAQdOfA94GjHPYJOngTRVWdWUFftCDm
	bbjF4+oB8pt8F5DpcXANVVrlt0kkYvoPuVaT0nDiKs0cML0x/VuadVdSsa57L+EV2LFpx74YqNJ
	Dj/nQS3m8TEMI8Myno+fERhHYKbCp/QdpuKCSvogv4Vms/Y9aCCm0WlvQG0vFTR+gGl/EIwN+v8
	aImWZOAcZAc9EVYNoqh+7joEDMqWyIDYtrni7z7IC7bb+0N1H4pkpUbwOmR/Gqz2MZ2hsf/P8xc
	/DrXuUGEOcGi4fwobvV4l9Zz2tp8bBri6KTecYF10y5Je81WiotipddbN6KiREKAx8WRfh9/Ldo
	fJiL2qTot5nexjCWDaf8L0/ySeMfuZhz8uhPP318PvBtZrqQ75CmuFNT6nBToFZnYIohdRupdmc
	hFOoLw+29IF1M1x8v+MrcN9iNaW6g+9pdDClfuyHFvJWcFS3t5XkSR0voKO25qZ0tk9t2gi7hBx
	QWA
X-Received: by 2002:a05:600c:1d04:b0:493:bc4a:a14d with SMTP id 5b1f17b1804b1-493e63a9f76mr20030585e9.19.1783508557034;
        Wed, 08 Jul 2026 04:02:37 -0700 (PDT)
Received: from localhost (p200300f65f47db04930dc5bd4534e1e5.dip0.t-ipconnect.de. [2003:f6:5f47:db04:930d:c5bd:4534:e1e5])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493e0f40d50sm151903545e9.5.2026.07.08.04.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 04:02:36 -0700 (PDT)
Date: Wed, 8 Jul 2026 13:02:34 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 net-next] net: phy: Drop #inclusion of
 <linux/mod_devicetable.h> from <linux/mdio.h>
Message-ID: <ak4tWWl2Mt3BkTXy@monoceros>
References: <ca270a534d0f230a939a3fb4a661808b35d6436d.1783329817.git.u.kleine-koenig@baylibre.com>
 <12ec5246-4124-4edb-a5f8-f10c73b1fcb7@lunn.ch>
 <akwToZyYvHZPtdjV@monoceros>
 <96a77bc9-9804-43fb-acf0-b93574cd60f3@lunn.ch>
 <akynGw4TQimFiQST@monoceros>
 <2f07f731-0b97-4a23-8ccd-f01638fc1c7e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ncfrdjtwdwvsqxls"
Content-Disposition: inline
In-Reply-To: <2f07f731-0b97-4a23-8ccd-f01638fc1c7e@lunn.ch>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-305768-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,baylibre.com:from_mime,baylibre.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A05A07249E8


--ncfrdjtwdwvsqxls
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 net-next] net: phy: Drop #inclusion of
 <linux/mod_devicetable.h> from <linux/mdio.h>
MIME-Version: 1.0

On Tue, Jul 07, 2026 at 02:10:56PM +0200, Andrew Lunn wrote:
> On Tue, Jul 07, 2026 at 09:15:35AM +0200, Uwe Kleine-K=F6nig (The Capable=
 Hub) wrote:
> > Hello Andrew,
> >=20
> > On Mon, Jul 06, 2026 at 11:28:33PM +0200, Andrew Lunn wrote:
> > > > That's exactly my thought, and there is commit ad428f5811bd
> > > > ("mod_devicetable.h: Split into per subsystem headers") that is par=
t of
> > > > v7.2-rc2 and that does exactly that (apart from the filename).
> > >=20
> > > Ah, O.K. net-next tends to great dragged along the -rcX versions. So
> > > you can probably submit the networking changes in a weeks time. Just
> > > make sure they apply to
> > >=20
> > > https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
> >=20
> > Note that while I created the patch under discussion on top of -rc2, the
> > justification is also valid on -rc1 and the patch doesn't use the new
> > headers, so it can be applied to the above repo already now.
>=20
> Yes, our patchwork instance and its CI agree:
>=20
> https://patchwork.kernel.org/project/netdevbpf/patch/ca270a534d0f230a939a=
3fb4a661808b35d6436d.1783329817.git.u.kleine-koenig@baylibre.com/

That's great.

> but i was actually meaning the patches which swaps to the broken out
> header with only struct mdio_device_id. I assume that patch is the one
> which really reduces the number of files which get recompiled on
> unrelated changes. That patch can be submitted to netdev probably next
> week.

Ah, indeed. After 995832b2cebe6969d1b42635db698803ee31294d and its
parent there are not many left affecting netdev. But ack, I will wait a
bit before tackling drivers/net/wireless/intel/iwlwifi/iwl-config.h
(which is the only remaining user of <linux/mod_devicetable.h> in
drivers/net).

Best regards
Uwe

--ncfrdjtwdwvsqxls
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpOLkcACgkQj4D7WH0S
/k6E0wgApW4YEibqxo7s6E2O2Qy4D5Tx3XurOUW4nbjnKTfepxZwf8B5r5Hn6fr/
QhUtm5a9JNOxWPsmJM79yjdBDGmGls18G+CTQxwOxRj1IfW+RAD0kGQBXYJpq4uN
dQq21Wq7sO6jOxuBlYuu9oZFDA6ZkqnU/0VnH6Jp1D/vCOsfAcxPttTO3D61MGiO
eQuh2zR7SPDiF+Lzm7IWi6NEZAKbXg/+jbkioFJU2vE09GkH9lJvVtS5SQwVX25p
HhoQCYm1wTyEPP8gTl9lf3hSQ/Epr7DFMtxmrTQ4GMgTplSOQln8zMJwK37v+bBi
F3CvCSUqlUJWY0AEQxg1ehLQbzbj0g==
=v4gp
-----END PGP SIGNATURE-----

--ncfrdjtwdwvsqxls--


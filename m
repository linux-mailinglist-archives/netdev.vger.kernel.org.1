Return-Path: <netdev+bounces-305311-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hen6HkipTGosnwEAu9opvQ
	(envelope-from <netdev+bounces-305311-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 09:22:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E241F7186B3
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 09:22:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=JstgJxSz;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305311-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305311-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6B583006527
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 07:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B8C39E191;
	Tue,  7 Jul 2026 07:15:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DB6420882
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 07:15:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783408544; cv=none; b=Jb8A5icS5Zg3Nao4G+goj8EX9+xXtXQX6HVZg+gq0HCLk/NI5TPbuqCojbRuBMMTeUoIeqEbfESGlOH8BtJhFQXC+vdWDizvdkr9JDQuyrae83n5NA7qowvZ/SVbiNgnHTuwKq/d3OVJQTzQDCb09pcmNLaso3smIWWKglkgRtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783408544; c=relaxed/simple;
	bh=VT0K4E1pQMV1NqJDoya6dN+nncwhVoOSZxEDR7q6Rk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfCH82RFwdDdw1NlcghOZeJMMsWALF21A8HNWZxXHqMrn2nRifElPbmk+afbbwIhn2cGNpE2YgjdPY98cSwxNz54Dxt043+mSfSa8CjEuUd+DAYIqsDrZvK3bfMnQqk25mp/O46TOJ3j+S8JhYUM10nBqP+leZHgGWkxPZPMOJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=JstgJxSz; arc=none smtp.client-ip=209.85.221.51
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-475cb71a4ebso3894879f8f.0
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 00:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783408537; x=1784013337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VT0K4E1pQMV1NqJDoya6dN+nncwhVoOSZxEDR7q6Rk4=;
        b=JstgJxSzBJ3sMh2XSgAItAwDDIpGYJc9JLFuXK0K5ubjVYl26Kp6MCg7q1Nhv6zW2q
         7tsA2ZKVd6l9btBJTdgNHK6ibH4F4TZK2MOvTVPGGqsXp7KXhmhN0f9wbE3fZShh4wVi
         zdf31kbeGsDWSZJfJEFghWSHkZsyYoTX4GDeNXH2b60VddxTbmCCkU84m2g2Bg4ZdkkD
         g2iXXUgwmBPERqzfeMCGb+PGxGV8JxGQNhwuVJJnXxs7GJGK5llGgHouPr8KlTtMytSl
         yPnt0t4cM5iwzMbgGp1loKWI+ZHttJ8d20wpV+RtBj3fkmvgko+ZGxuswo3QWKKhfC1x
         IBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783408537; x=1784013337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VT0K4E1pQMV1NqJDoya6dN+nncwhVoOSZxEDR7q6Rk4=;
        b=Ouqdwfi0rw9x+MMuJZrrGquEw/d+/GVzKEIb/+p+4l3AjAd2oxQlIHHUg13N2KH5lB
         JwGo4HZeTeyUMVc1ESsAn0Kj1boDrpZqjhMXX9LGVCH3wjYRNBuN+fSLxP6+XafTZRQX
         9WScJcc/Z2gU9qnHj7QqLTaqXQr1hwdmQrsCo33BlA0h2ouD94ymXmdHjPMP97gTHOLG
         ooXrLTYiaQUTq6ygQ1JhS4nmgI29GoPQv/nx4jDzzcDEBQg5HhUsrFgICEsEfBpCcoI+
         1wBv7iyQSRJORMx84mTun7EMqqx51e+JJq5DiXst4sxZ+H2G1DeU1XrH287GeQrp447N
         5XeQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq2C30UZC9m1EG8+DBPqASvi/9+VBDYObvwhWu8euk1iRfMIvKDZVIRuxRqQH7fMhaBO1HhZPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0kXTH3Jz1DXFicr0AWNIOaY9tomSS6u6YKChKKvhHTFfwFJ41
	fouLmRPS1+QQUeDdk5bB/L/t+WX4C9PBPlT8zg42RMCWroT+v6C/rBTF8gW7doggXA8=
X-Gm-Gg: AfdE7clySHDm5HaUWBMX4Az3/0Lcd5KGl5etMb2g/7BhFe2lSuaURguqdy8Sueqa5rF
	JwfJscOBhHhlD8Fl5Nd4w7XO/9NT++Ky1DsebMWplizTKXv0CloQ1lD17fw0n7SYBgyBbA0il9V
	RIfxIvoIbLouuXCtG0doB6+Am8GS91tCTNa8A+q56Cek/0DKBJg9GBtHpk7Pcf3bOugvDEMq/nO
	yoVOwoRweMsbqMHG/gsIPZmr5hd1wkEd4fFmxKz6CevQYuFb84d104Mv0/+ibgyRJ3yWg1gp8ja
	eiBtw8tykxfBh9itvciS6Pq0IVgOFVMKO2GAc+LiAvDhyhvXhU+mJxkVKf+bYq6aszcZSdCGzBX
	4bXQvlbN9iPQw53cMUXFOnw6EFCmObbdnAuxgOWOJnIofL/6GI5jSqjX6kcQWMBICAHewLJZCtn
	jsmKVa8d2bkY2BMa7iCQ86kB8JzWeFpLYupKDy4YZa3SXms1dJoDbWluuAtvp9jMgdjffEyp3Ih
	aDb
X-Received: by 2002:a05:600c:3f0b:b0:492:437a:a653 with SMTP id 5b1f17b1804b1-493e1ff0070mr12648885e9.26.1783408537121;
        Tue, 07 Jul 2026 00:15:37 -0700 (PDT)
Received: from localhost (p200300f65f47db0437b4d928ee3eb6f8.dip0.t-ipconnect.de. [2003:f6:5f47:db04:37b4:d928:ee3e:b6f8])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493e0ab4dd0sm34441895e9.2.2026.07.07.00.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 00:15:36 -0700 (PDT)
Date: Tue, 7 Jul 2026 09:15:35 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 net-next] net: phy: Drop #inclusion of
 <linux/mod_devicetable.h> from <linux/mdio.h>
Message-ID: <akynGw4TQimFiQST@monoceros>
References: <ca270a534d0f230a939a3fb4a661808b35d6436d.1783329817.git.u.kleine-koenig@baylibre.com>
 <12ec5246-4124-4edb-a5f8-f10c73b1fcb7@lunn.ch>
 <akwToZyYvHZPtdjV@monoceros>
 <96a77bc9-9804-43fb-acf0-b93574cd60f3@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xhhjyf7dhbn7moxo"
Content-Disposition: inline
In-Reply-To: <96a77bc9-9804-43fb-acf0-b93574cd60f3@lunn.ch>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
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
	TAGGED_FROM(0.00)[bounces-305311-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,baylibre.com:from_mime,baylibre.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E241F7186B3


--xhhjyf7dhbn7moxo
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 net-next] net: phy: Drop #inclusion of
 <linux/mod_devicetable.h> from <linux/mdio.h>
MIME-Version: 1.0

Hello Andrew,

On Mon, Jul 06, 2026 at 11:28:33PM +0200, Andrew Lunn wrote:
> > That's exactly my thought, and there is commit ad428f5811bd
> > ("mod_devicetable.h: Split into per subsystem headers") that is part of
> > v7.2-rc2 and that does exactly that (apart from the filename).
>=20
> Ah, O.K. net-next tends to great dragged along the -rcX versions. So
> you can probably submit the networking changes in a weeks time. Just
> make sure they apply to
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git

Note that while I created the patch under discussion on top of -rc2, the
justification is also valid on -rc1 and the patch doesn't use the new
headers, so it can be applied to the above repo already now.

Best regards
Uwe

--xhhjyf7dhbn7moxo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpMp5QACgkQj4D7WH0S
/k4BhwgAuoCMTyIcsqE5z9TK3DyfdiBIFlp7TEdo48W8ljxwHlPER0dSLAeyDi1p
AfJrBdw3ZDMHuJOT5iSrFOt1TP5eLeQwPMrG1ZJVU2ZzT61OBau0mLIDnF89HXv2
iYltxKySlVU+Anb6krKBnImfM+VniFmt+56UFoZARaCLpteW+W0JajmeOx4FvZSc
gxsATSLxK0ci6em3dde7bKrhXOYxSWg1ZB0IODFfXa2Cn6qp/dYC6olw5IiRDjAo
2WUaK/p/nHSPdKItpE1O3aAemUT/ZoyfDFaGNM0jyPNW2sL/Vczqz7++kZeeHV+t
2bQD2TPpqw1KeqLXS3casrl19rkPIA==
=YgnM
-----END PGP SIGNATURE-----

--xhhjyf7dhbn7moxo--


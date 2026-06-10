Return-Path: <netdev+bounces-297782-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LV0dDoucKWqYagMAu9opvQ
	(envelope-from <netdev+bounces-297782-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 19:19:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE0E66BED1
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 19:19:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b="F4Q4/GBX";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297782-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297782-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF997310D8F7
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6571434753B;
	Wed, 10 Jun 2026 17:13:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DA1265620
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 17:13:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781111617; cv=none; b=arV0IKHuRCC+188KIcVEMxJlEaeIZMdefZi/wlvCYh+kRqxiRm1a+8ZVkCn/4QIQz0N2TAOdo2sxG9Q8hjRvxgKIKVBqJRluSJvzuC6rFlNMs+wj42MKUH52PZKvqZG26lnm6c6hf5MhDS9po1MPBuX5JrPkFXD8q2opDFU+zbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781111617; c=relaxed/simple;
	bh=7/xcZhoKpwGcZKaMKoiJxd4/lEx1O8tqAlHKlPik40w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKNvNsxzjwj1gT5RlCyLJxY+MYbDdhDQthtOt4YyB81tChuNBwgqHeG+RVvJEcLwkyaRLJQmU6PYpsKvS4vfQi9x4J/PrZHaC0GvgpHb6iYDHDEd3j+kDUAWDIP6EDvyVkec6NCgTuyqsfjvaemAW/sBciw86ihIj14XnvhLBJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=F4Q4/GBX; arc=none smtp.client-ip=209.85.221.50
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45ef1629ff4so4918749f8f.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 10:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781111613; x=1781716413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7/xcZhoKpwGcZKaMKoiJxd4/lEx1O8tqAlHKlPik40w=;
        b=F4Q4/GBXkSLZUOhJWMZvEeXpAkAbds5EQYR05ssiChmJsRlqw/USx8QDhdFOZ4SKYX
         /H+hlmb+df93egcRYx7UxTIDLP/ANc7MGTEBc3qouLNMtycuzabFw4yIvPH8fKcnVsyj
         pSToAfYP1d72jydtZpzmucsRPuKmZzhtXu+IrTFviRirwaKji3NHmugEI8DWohrfBxYW
         Y8VVHGCHctqiidamPwKQYI7e3nnfNbiUhDKAxz5HsXpI0XMfGAtWO1jJTCy9H0wcTgW5
         b8kikL+QgKAHXMLOFXlM4783zVj8BVZbTaWnMLr2mw1+d+ShQqKKRfXnJ8ngXwMQRvSv
         Jxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781111613; x=1781716413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/xcZhoKpwGcZKaMKoiJxd4/lEx1O8tqAlHKlPik40w=;
        b=Y7vfi7Fk/TXJCESh/jH3EC5qYcwirYBnaiMVgAXLqKCSJ48mkMcFncNDKLUklKJ90x
         SLzRevaeKWhnAR9LiTwx16um6lPV43bAmU73YtWsEh8qj3g0TFRYKzMduufu8lGXIphl
         hTJyKuWchqZqQdA212C3szrLZ+WvBZXlU0g9WZmUfemwjlVwlWHXr7pkva66GAA6C75L
         6d+TYqqcpCt4YDcrErs96gWWbXC4Z9s8FDudwgW8BkvEJnWX+r9c7PEMEezYnXgQnqkt
         +JdOAczLL1XSMZTpbv5nzQW90yFVQ5NYNL8xhIQhB/3vh50gzpPP1cxRhVKytD+Hurye
         NyXg==
X-Gm-Message-State: AOJu0YwnvMiL/q2uRIiBDNLj9541KvYIGF911jqnwFKEuwrk35CDoTti
	UpZk1YUsQkwKLo6w/znwtkv1KA7OmladnL8pNeapnOePgUT2WZB6XAsCHjvA49vUIDg=
X-Gm-Gg: Acq92OH5uwED5D+i56XxeWPFti/0Sgnef4A239N0KS/mIEVZTdaMHbdG6iDUdUQ8sr+
	ntziY8P/pKrjMqFetf00HC7fYQSUUhoVLvCpEFExvb3QqIFCOov2qNTAehc816jlqoRFuGIVETI
	giBVQhUgGBzW5sYiVwYzS9mxuCtawUy67xCbzS6h6s+CtrRyXIbYMdjBmuk2CHVigYFpggEJM+q
	vI1QZEYpwG/3qY7alUcKttw1BZfCEcpA1hHRRVTwpDi3TnNH4FyrwO0zldOsDa5JAg2Ii/U6Mke
	XSNMjb9RinNfzVNy24Y7c1Ok18O2k8xM49rAzrDGr779y5gn0ntsAsJ3oF3ZeiGl8CDrze3AbJR
	5ofEI7xYlCm3olWJvwH8vHoPkhSGR2MrJY3RdAIqFVqKZu5HxXLMLRdiVSCcVYnx482ffJZx/q4
	N1PrRPUNp4WxyOEWLr+FCaRUycQWxo8B6JATNTc2VbUfQaHE366vcwdyudr/XvzhxSOnonL/eeC
	aDzJRbMZPKDLRhjpFyb+jpueQ==
X-Received: by 2002:a05:600c:8b6a:b0:490:688b:ece5 with SMTP id 5b1f17b1804b1-490c261b08fmr390154585e9.30.1781111613608;
        Wed, 10 Jun 2026 10:13:33 -0700 (PDT)
Received: from localhost (p200300f65f47db046aec8c3a4b621e71.dip0.t-ipconnect.de. [2003:f6:5f47:db04:6aec:8c3a:4b62:1e71])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4601f2e4b18sm57539850f8f.10.2026.06.10.10.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 10:13:32 -0700 (PDT)
Date: Wed, 10 Jun 2026 19:13:30 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: David Heidelberg <david+nfc@ixit.cz>
Cc: netdev@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
	Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ian Ray <ian.ray@gehealthcare.com>, Carl Lee <carl.lee@amd.com>, 
	Tomasz Unger <tomasz.unger@yahoo.pl>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] nfc: Use named initializers for struct
 i2c_device_id
Message-ID: <aima4QhlwCzWa2vF@monoceros>
References: <20260518133311.644160-2-u.kleine-koenig@baylibre.com>
 <c5b5025c-1925-41cc-89ee-3c52a1192f26@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4wajsa3zx244mfzu"
Content-Disposition: inline
In-Reply-To: <c5b5025c-1925-41cc-89ee-3c52a1192f26@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297782-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS(0.00)[m:david+nfc@ixit.cz,m:netdev@vger.kernel.org,m:krzk@kernel.org,m:horms@kernel.org,m:kuba@kernel.org,m:andriy.shevchenko@linux.intel.com,m:ian.ray@gehealthcare.com,m:carl.lee@amd.com,m:tomasz.unger@yahoo.pl,m:linux-kernel@vger.kernel.org,m:david@ixit.cz,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linux.intel.com,gehealthcare.com,amd.com,yahoo.pl];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,nfc];
	DBL_BLOCKED_OPENRESOLVER(0.00)[monoceros:mid,baylibre.com:dkim,baylibre.com:email,baylibre.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9EE0E66BED1


--4wajsa3zx244mfzu
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next] nfc: Use named initializers for struct
 i2c_device_id
MIME-Version: 1.0

Hello David,

On Mon, May 18, 2026 at 05:09:54PM +0200, Krzysztof Kozlowski wrote:
> On 18/05/2026 15:33, Uwe Kleine-K=F6nig (The Capable Hub) wrote:
> > While being less compact, using named initializers allows to more easily
> > see which members of the structs are assigned which value without having
> > to lookup the declaration of the struct. And it's also more robust
> > against changes to the struct definition.
> >=20
> > While touching all these arrays, unify usage of whitespace in the list
> > terminator.
> >=20
> > This patch doesn't modify the compiled arrays, only their representation
> > in source form benefits. The former was confirmed with x86 and arm64
> > builds.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@ba=
ylibre.com>
>=20
> You need to refresh your tree to next - you miss David.

@krzk: Thanks for that hint.

@david: Would it help you if I resent this patch or do you have it on
your radar already?

Best regards
UWe

--4wajsa3zx244mfzu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmopmzYACgkQj4D7WH0S
/k7Xzgf9Fxyi6laW4HqGp9U22Qti2JfXd4MYYOfISvcfOj/0RvVQ67QtRSlejhxY
OSZx4/tqeNeWLxFcT7kfmjZF/iEbcHD/rGthcf7GPKNjM8TcVVJxK/O8Av0XvZD4
f/lw285dzS9V06C5C1DK5SX5Jh4Y/Egb3x4R3pCXaWo+s60WvgLkr4M1aRLCm8NE
dism62gmIOWcyJxRdIuhXaZaXlsmDIkTsRm7A4ipH3fnYmgaSkaf0w8LyYcDu34A
zrORh4OM0gK2ehBNomvlyTDDKPEwHkuldkI2VX6arXZaIddlvKHkGk+uFyHrtu/O
lM3Pm/KGXYohoAT8U53UqFXxolA8Pw==
=VaSC
-----END PGP SIGNATURE-----

--4wajsa3zx244mfzu--


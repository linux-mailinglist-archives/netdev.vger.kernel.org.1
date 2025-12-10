Return-Path: <netdev+bounces-244267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9365ACB3634
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 16:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2FC89300DC8D
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 15:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17E01917F0;
	Wed, 10 Dec 2025 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mdcTGguI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456A425392C
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765382146; cv=none; b=GEEGrhOE25c5nNtVAlhSJGnxDSQ/G1+JCMCWTuQ18gBP3iFWFsltRV8RA+GJ0BvEX0q5QKdbxluKYFBfvzkcIlGf/gJZ3zVwoemZIjz4FdwpwRvQ6mmz6qOPN9CEMxElqiBnJfks5rT0nWzl8oR0hXUrBLecnwaMjhUYgI3yBoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765382146; c=relaxed/simple;
	bh=G8Q2u2sVOOsXSr7qFY2KLbIPxq/0nI2Nn65kA8r7YQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRLtzy5hQATCWFv6MLPTUycDZb+XoEMgOw6qq6WwNkJdYlJ0UIX4+CZzyY+twdaVujjEsSIa34lrVr9JBUkIQrJ48eTxFsH1VshoIH3u956xq4HXIRHe8VgLgGYJN1hV+yIk3M7QTQWOhvlt3cP51eRlA/ZnuuVFxJvBacKRXxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mdcTGguI; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-647a3bca834so1625a12.2
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 07:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765382142; x=1765986942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G8Q2u2sVOOsXSr7qFY2KLbIPxq/0nI2Nn65kA8r7YQ4=;
        b=mdcTGguIyFR1vKLpq8co0Cewkm0zXuDtAi+B4oz4OjEG0gCtmlsjrM/apzuWne8ghQ
         ChSG834BtKt2UJ7VGH8Xq7tThyyDB1Z8WUoY1p/cPGCxmfHE0UCGhFjDjk/aMu1zuAGV
         WLpc7JRLAjsPwfQtJz1QvXuXrCwLReFq5ZPWEf0XJbcCyvEiqNeYE98XEfeWUuZjspUq
         yspR4Pql6aaTdnp8OBaUCHAJzjLdlW2sW6B+5ouSZsz2ZICauCN8XxnzCHhCw/VtwXJg
         xsxicfTzlHYPqF3DmB0tSFcieGETjV6zkbOs7YJQ5lx2mHu7jiKdW780zjoM6kSWTjz2
         zVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765382142; x=1765986942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8Q2u2sVOOsXSr7qFY2KLbIPxq/0nI2Nn65kA8r7YQ4=;
        b=L90CjM+HzRFMOJgiaFbG6Iob3jdjAD1gBHyo9Yyv4Z/k3WGbGhOl9HetKGc/vBj5p4
         vUdvBfXHtHFTZrkxIM2jBV+Y0ySgDdW8X8Af3JoE+GwwbiZSNfWxA+xVUYKD86VgUzZY
         nhoLHy009bRFPcmu57MUhJBp5o0ao2p2mNg1Gg+NnC5laqgiM5EZynKDKjn5qvjkFQb/
         yezlT2aIIEMlgUHziE0XwoOfSrQwN2zibOyNJNS4esdwkofyI7ytMxrgcR/PGcwSQtp1
         bJczGG61t0Dqs9Tk4g6rBpMQl8E5l9sK76U+oGMgbonV/tmdodb8AjYYK9d9WKdkWZsM
         EFcQ==
X-Gm-Message-State: AOJu0Yy0i8GlszV3cKQ0uHFS+WCMXLKN3SzOh2s48YItDFwt1q1rzDjV
	hjdgna9I6CEoJoNi1QEpMFLh9Ipt38V/F7k0oYj8AF9iF+ifG/d7s6bHVzRJ6ThUa0c=
X-Gm-Gg: AY/fxX4ZoxWEUN+5ho1LTmH7BkAGY0k6SIkE7/J73963zjRnvqLvN5qzapSVCOMMXuE
	86u9a0oEpxcXOmYBkiVIw2sPRCsaVbXzkKBpMHnIRqCE83PmoBS1jn5NznZ9ro5qNxp7ZOjwiE4
	ET9zcMYRwIV3o1hawtdrkrfQuExHdvBWH/yt5PMathNvgBvsAw7ASB8J2fZhdlUcEClfhmo/1xh
	J6MSmLryW7iZ+LriiaRaPhyBw/dt/mre/Xi5eKJWK2rxU+vuGKDTsgT380LJuo2gt0P9gaRZFjV
	o7nH/lXtM6zCMasFrRvEr4HEZvj6PWoOHyqccyD5WozSCLfBb1W/OEZWbpAcXTAgWIzhlWcL/2K
	zyYPvSNUf2ZIUiLeR+RQvm4VftpxO2qBLeKmWIRSAS9pASEkKLNtiE54KxKOKbUZ5ay4Rb1WZk5
	GmBsGZR4SgKG1ak9YbdxGD7Mjxbe2iVkP16KnrsaXxF7Jn1/W537VhXR3QmzngaWsrBeW76XOJV
	Uw=
X-Google-Smtp-Source: AGHT+IFtdITBVw1NZitBnhjXDJRgjHCxhXPtM8OwdVYIEA/FLrKfi71V/nkBsKrYDqpjS32YGuufCQ==
X-Received: by 2002:a05:6402:51cc:b0:647:62e1:300e with SMTP id 4fb4d7f45d1cf-6496d5ec98dmr2866969a12.33.1765382142381;
        Wed, 10 Dec 2025 07:55:42 -0800 (PST)
Received: from localhost (p200300f65f00660850b8fa1cfb7adf67.dip0.t-ipconnect.de. [2003:f6:5f00:6608:50b8:fa1c:fb7a:df67])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-647b41219c1sm18676323a12.27.2025.12.10.07.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 07:55:41 -0800 (PST)
Date: Wed, 10 Dec 2025 16:55:40 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	Garri Djavadyan <g.djavadyan@gmail.com>, stable@vger.kernel.org, 1117959@bugs.debian.org
Subject: Re: [PATCH 1/2 net-next v2] ipv6: clear RA flags when adding a
 static route
Message-ID: <zmqrhsroqfgqgyn5bvybhfppruv2wsghokmpzkz64mpalwaajq@kv4pazae6uwi>
References: <20251115095939.6967-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="urotfrqmzkqody4u"
Content-Disposition: inline
In-Reply-To: <20251115095939.6967-1-fmancera@suse.de>


--urotfrqmzkqody4u
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2 net-next v2] ipv6: clear RA flags when adding a
 static route
MIME-Version: 1.0

Hello,

On Sat, Nov 15, 2025 at 10:59:38AM +0100, Fernando Fernandez Mancera wrote:
> When an IPv6 Router Advertisement (RA) is received for a prefix, the
> kernel creates the corresponding on-link route with flags RTF_ADDRCONF
> and RTF_PREFIX_RT configured and RTF_EXPIRES if lifetime is set.
>=20
> If later a user configures a static IPv6 address on the same prefix the
> kernel clears the RTF_EXPIRES flag but it doesn't clear the RTF_ADDRCONF
> and RTF_PREFIX_RT. When the next RA for that prefix is received, the
> kernel sees the route as RA-learned and wrongly configures back the
> lifetime. This is problematic because if the route expires, the static
> address won't have the corresponding on-link route.
>=20
> This fix clears the RTF_ADDRCONF and RTF_PREFIX_RT flags preventing that
> the lifetime is configured when the next RA arrives. If the static
> address is deleted, the route becomes RA-learned again.
>=20
> Fixes: 14ef37b6d00e ("ipv6: fix route lookup in addrconf_prefix_rcv()")
> Reported-by: Garri Djavadyan <g.djavadyan@gmail.com>
> Closes: https://lore.kernel.org/netdev/ba807d39aca5b4dcf395cc11dca61a130a=
52cfd3.camel@gmail.com/
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>

this commit is in the mainline now as
f72514b3c5698e4b900b25345e09f9ed33123de6 and is supposed to fix
https://bugs.debian.org/1117959.

I would have expected this to get backported to stable (here: 6.12.x),
but it's not in the list for 6.12.62-rc1[1].

Can we please have this patch backported?

[1] https://lore.kernel.org/all/20251210072948.125620687@linuxfoundation.or=
g/

Thanks
Uwe

--urotfrqmzkqody4u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmk5l/kACgkQj4D7WH0S
/k6erAf/T4zGWs/IRkIPbPpr00LTGWPYtn2Ll1dmur0IDmYi45DzRTETSfw3U9NK
NkrcoS2nZA1aK3h2HW6rHhVP0NQ++U3FfPT0o4zlZUdgEem8RVef+xvf+AyQbIxF
uhX8Wja0nVW3QLtj190wqcsvhTzcOTBISrK9EoUPJRdYEFv0yBiM12fmDuIPitv8
wfRGK6GXMW5+3s2c9TJoxDtvDZt+45xauImuou+t68PhoFi4bwhcKlifobjcPVII
O126RfhvdSqBX0lXiyaG+sH+eDdH1/JBSHIl0vCCqaO38MWPPtRFt9jib0tk281V
P/FJQ94VGR1g6KkDPFeR1ScMg9ZysQ==
=yAus
-----END PGP SIGNATURE-----

--urotfrqmzkqody4u--


Return-Path: <netdev+bounces-84926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE7D898B40
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 17:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79F7B1F220A9
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 15:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2459E12AAD4;
	Thu,  4 Apr 2024 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandelman.ca header.i=@sandelman.ca header.b="iW0W2n/b"
X-Original-To: netdev@vger.kernel.org
Received: from tuna.sandelman.ca (tuna.sandelman.ca [209.87.249.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E9276033
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.87.249.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712244963; cv=none; b=H/1rJ5q2dQo2z1xNZbP2rH7y6iK4+Z2zVDuD/IPipkFpA8QnLZClkkZbtdAWCA55cPsNu0+mY/+Z3g3hjz//WqNIkngXfMo+EPqtHRkyl2nad8zHfP1UEuX7avUp7Rd7WOP1g/UN7FTA/5TlgNPCgngJ2zStT2Nu4Sv5SLgk6bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712244963; c=relaxed/simple;
	bh=74U+YjD0YICgG2vFFCdRIYwAUqFVT3N7UmxpsF/aXJY=;
	h=From:To:cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=JTFD+98jWNJQis00LgYECZ7hWg9nlRf6BBYZzMrK0DLgZTKHZftean8UdwzBHSO+dR3lHUUyglJFR9oLhH0I7eQzT8CgTZipd/Nch/TaMjHELbh3SNsl7gfH4EkCnIwfTLE4ThWf5vpfyrQVXn5vy8n1JOzOkeeakfEwT3qGZL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandelman.ca; spf=pass smtp.mailfrom=sandelman.ca; dkim=pass (2048-bit key) header.d=sandelman.ca header.i=@sandelman.ca header.b=iW0W2n/b; arc=none smtp.client-ip=209.87.249.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandelman.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandelman.ca
Received: from localhost (localhost [127.0.0.1])
	by tuna.sandelman.ca (Postfix) with ESMTP id 380E13898B;
	Thu,  4 Apr 2024 11:35:59 -0400 (EDT)
Received: from tuna.sandelman.ca ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id HkxB8aoxGYTI; Thu,  4 Apr 2024 11:35:57 -0400 (EDT)
Received: from sandelman.ca (obiwan.sandelman.ca [IPv6:2607:f0b0:f:2::247])
	by tuna.sandelman.ca (Postfix) with ESMTP id 9910838988;
	Thu,  4 Apr 2024 11:35:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandelman.ca;
	s=mail; t=1712244957;
	bh=/qqiYean3Ym7petZQnfU4tw8ryUeqHorsKcmug8pGtg=;
	h=From:To:cc:Subject:In-Reply-To:References:Date:From;
	b=iW0W2n/bQYsRY+x/FaOx/AZ6vPOI4w5AATk/NwowjXrF31/2MHu5bNxVOnIXiVq7c
	 HdUrH/Ta1GcUO3cL3Lo7l0dvmcMdPTluAWM4Swl+UlM/8VpiueuqtQU5l9Mqb3L6s8
	 dqyAYBa8U60Yjxi1rLN8lXbPwTbgECy9q9zO7B61aXWPGSsS2wTaHNvAVnU/Hg1/g9
	 bz6W4AQc8LVoUDU27l8r/6TXk+OpNMTm16HIItu/Xxo814xebNA7n2Lk6RQdmWvZlt
	 msW9iV7lAEHYPAdwIBnllevGBPBJ1kq7oI12QiFqiJShcVrOs0aApiHBZk1SQ9UNtT
	 dcw17wvqZzVwQ==
Received: from obiwan.sandelman.ca (localhost [IPv6:::1])
	by sandelman.ca (Postfix) with ESMTP id 9427C111;
	Thu,  4 Apr 2024 11:35:57 -0400 (EDT)
From: Michael Richardson <mcr@sandelman.ca>
To: Antony Antony <antony@phenome.org>
cc: antony.antony@secunet.com, Herbert Xu <herbert@gondor.apana.org.au>,
    netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
    devel@linux-ipsec.org, Eric Dumazet <edumazet@google.com>,
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
    "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net 1/1] xfrm: fix source address in icmp error generation from IPsec gateway
In-Reply-To: <Zg7F4GwJIW6_ajdK@Antony2201.local>
References: <cover.1712226175.git.antony.antony@secunet.com> <20ea2ab0472ecf2d1625dadb7ca0df39cf4fe0f5.1712226175.git.antony.antony@secunet.com> <28050.1712230684@obiwan.sandelman.ca> <Zg6aIbUV-oj4wPMq@Antony2201.local> <7748.1712241557@obiwan.sandelman.ca> <Zg7F4GwJIW6_ajdK@Antony2201.local>
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; GNU Emacs 28.2
X-Face: $\n1pF)h^`}$H>Hk{L"x@)JS7<%Az}5RyS@k9X%29-lHB$Ti.V>2bi.~ehC0;<'$9xN5Ub#
 z!G,p`nR&p7Fz@^UXIn156S8.~^@MJ*mMsD7=QFeq%AL4m<nPbLgmtKK-5dC@#:k
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 04 Apr 2024 11:35:57 -0400
Message-ID: <23137.1712244957@obiwan.sandelman.ca>

--=-=-=
Content-Type: text/plain


Antony Antony <antony@phenome.org> wrote:
    > On Thu, Apr 04, 2024 at 10:39:17AM -0400, Michael Richardson wrote:
    >>
    >> Antony Antony <antony@phenome.org> wrote: > Indeed, 10.1.3.2 does not
    >> match the policy. However, notice the "flag > icmp" in the above
    >> line. That means the policy lookup will use the > inner payload for
    >> policy lookup as specified in RFC 4301, Section 6, > which will
    >> match. The inner payload 10.1.4.1 <=> 10.1.4.3 will match > the
    >> policy.
    >>
    >> How is "flag icmp" communicated via IKEv2?

    > As far as I'm aware, it isn't communicated via IKEv2. I believe it's
    > considered a local policy, and possibly specified in BCP.

    > However, how is communicating it over IKEv2 relevant to this kernel
    > patch? I don't see any connection! If there is one, please
    > elaborate. Without a clear link, the netdev maintainers might reject
    > this patch.

because, we are using a custom Linux kernel flag to get the ICMP back into
the tunnel, then the other end might not accept the packet if it doesn't have
a similiar configuration.

    >> Won't the other gateway just drop this packet?

    > That's would be a local choice, fate of an ICMP message:), akin to ICMP
    > errors elsewhere. Let's not dive into filtering choices and PMTU for
    > now:)

No, it's not. It's up to IKEv2 to configure those flags.
Your choice requires extra flags.  The previous behaviour was rather
ingenious because it guaranteed that the packet always fit into the tunnel.
(the bug was that it didn't do it for IPv6 as well)

    > Just thinking out loud, I haven't seen forwarding ICMP error messages
    > negotiated in other tunneling protocols like MPLS or pptp...., if I
    > recall correctly, QUIC does indeed have it specified.

So, what?  They aren't L3 tunnel protocols are they?
MPLS is L2.5, pptp is L2 and QUIC is L4.

--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        |    IoT architect   [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCgAvFiEEbsyLEzg/qUTA43uogItw+93Q3WUFAmYOyN0RHG1jckBzYW5k
ZWxtYW4uY2EACgkQgItw+93Q3WX4rQgAq6czqmES3SDtZn7AV9ufflA1tTp5kN+0
VOBTL6UK8lX3SPAqgvqTXrzICqYxdsDgxZwlS546h5QFAF6CcqNpEr811jEUYhJt
7rCAPu9KX2Lz5pqYjkmdJ/UrZN1nC9RYqEv/nSBVwfQSFXqXFbm5aBVoblPJkL21
Z988YRHIJYN68BiPX4hjWVcTolJ47TQkcj+Jw/oRpLWZ/hg/pFZtA9YVRgeb1/wl
FpE/m4fX98f8n5TKwdElSjK4mpwddCQkOTJeA2tTxC6nJJAJphlJlIS1jbscDG8B
TcSPk3sJVggscksyA9zJUacO0SpBlVpwyti1dvMKiTZVZ3/XK0ImFA==
=bhtr
-----END PGP SIGNATURE-----
--=-=-=--


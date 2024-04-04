Return-Path: <netdev+bounces-84912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4081D898A45
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 16:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AFBA1C20D65
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 14:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00387182D8;
	Thu,  4 Apr 2024 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandelman.ca header.i=@sandelman.ca header.b="Ygq3LE6k"
X-Original-To: netdev@vger.kernel.org
Received: from tuna.sandelman.ca (tuna.sandelman.ca [209.87.249.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096E3168DA
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.87.249.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712241561; cv=none; b=FOJ8V4MURjpoEoKRNkIqzEsjyua0RtYpndYKutMR2xpwT6Sp34Th47/qInkvLQ+drzKxvuGN0VEO+vji7S3JF/e8JS6z9Q5yQDH4UU44Qi74AGCu7JGNwBNUjuSNk7EdBnR2cpcxadCisG4Rf7gCTCZnvJdLGkSeMk+WKbHuDlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712241561; c=relaxed/simple;
	bh=CwAvl28fyBamPEJgziBJqUkD/hLUMxWcxwlvYOxjd50=;
	h=From:To:cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=QKKyRMur+uWVyMDhTjcyEOcS90gDV+CAP807sCzReevhFn4VBqw2hrVyOsxZWGoFDsqCj+F7hZ+VKKjdBLFs9oH2sWjjSHtK32kWzGs6y3k1yIWl7flqzao6ILmuNB3EZZ5HIN4HNCRJKok6SQw6f8Je0EG0uvtmNX5zfMBFOIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandelman.ca; spf=pass smtp.mailfrom=sandelman.ca; dkim=pass (2048-bit key) header.d=sandelman.ca header.i=@sandelman.ca header.b=Ygq3LE6k; arc=none smtp.client-ip=209.87.249.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandelman.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandelman.ca
Received: from localhost (localhost [127.0.0.1])
	by tuna.sandelman.ca (Postfix) with ESMTP id 9A3933898B;
	Thu,  4 Apr 2024 10:39:18 -0400 (EDT)
Received: from tuna.sandelman.ca ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id FZnH-1xvOAx5; Thu,  4 Apr 2024 10:39:17 -0400 (EDT)
Received: from sandelman.ca (obiwan.sandelman.ca [IPv6:2607:f0b0:f:2::247])
	by tuna.sandelman.ca (Postfix) with ESMTP id 6A52038988;
	Thu,  4 Apr 2024 10:39:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandelman.ca;
	s=mail; t=1712241557;
	bh=ATvB/suQA4L1/h4S0HWm4c5gVxT0nCOx/IAypVGYzTg=;
	h=From:To:cc:Subject:In-Reply-To:References:Date:From;
	b=Ygq3LE6khmMbUOWJe3NCTqI6rSUSxvuifJZ1mEedTl0rmPVRondAX8ed9qRsyb0sW
	 5L6/5BjZQR5J/x649/BD0ApIeDzsq11oCW9oZ7fTzKxgqcaph+Z9PXx+MEzNkDdmVt
	 rFPNySgZOqoxgN0+M+TLfjulspprGbRtMZeB7MiXU0HIBKPlOL2hSPPajUviWrAe8X
	 X9PWmpjgSn6PxGtfXi3CzEgUJnWmO5KxmWl/S0rHDzRilY/+NvKei7JOG1YzfqBzdc
	 C/OtRhXAIYdpJHyf3iPyn+e3PKRuqn+CowjbZfbFRiP1rnYSqjcesixw9rI+E/senx
	 nGVVHr1pCbebg==
Received: from obiwan.sandelman.ca (localhost [IPv6:::1])
	by sandelman.ca (Postfix) with ESMTP id 65B0F111;
	Thu,  4 Apr 2024 10:39:17 -0400 (EDT)
From: Michael Richardson <mcr@sandelman.ca>
To: Antony Antony <antony@phenome.org>
cc: antony.antony@secunet.com, Herbert Xu <herbert@gondor.apana.org.au>,
    netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
    devel@linux-ipsec.org, Eric Dumazet <edumazet@google.com>,
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
    "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net 1/1] xfrm: fix source address in icmp error generation from IPsec gateway
In-Reply-To: <Zg6aIbUV-oj4wPMq@Antony2201.local>
References: <cover.1712226175.git.antony.antony@secunet.com> <20ea2ab0472ecf2d1625dadb7ca0df39cf4fe0f5.1712226175.git.antony.antony@secunet.com> <28050.1712230684@obiwan.sandelman.ca> <Zg6aIbUV-oj4wPMq@Antony2201.local>
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
Date: Thu, 04 Apr 2024 10:39:17 -0400
Message-ID: <7748.1712241557@obiwan.sandelman.ca>

--=-=-=
Content-Type: text/plain


Antony Antony <antony@phenome.org> wrote:
    > Indeed, 10.1.3.2 does not match the policy. However, notice the "flag
    > icmp" in the above line. That means the policy lookup will use the
    > inner payload for policy lookup as specified in RFC 4301, Section 6,
    > which will match. The inner payload 10.1.4.1 <=> 10.1.4.3 will match
    > the policy.

How is "flag icmp" communicated via IKEv2?
Won't the other gateway just drop this packet?


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCgAvFiEEbsyLEzg/qUTA43uogItw+93Q3WUFAmYOu5URHG1jckBzYW5k
ZWxtYW4uY2EACgkQgItw+93Q3WWPqAf+JQ6+3Vh9wWz4XKY3BwEVQa6KT5NDvbq8
awmgZieRmXtSweYCj6A9rNlGeWIhZfJcE8kpeMHpv5426QMR2cxL1A0au9OiLGSt
LMH72U5F49dn7SyaB1Lc+GpBkM7WX6RbUBu8Kvc4Q8GtZ1fwviXx2tiwBd1AkgS9
29mVJXkI0P7fheTNM9ReogNwd84Ct+vKgSo9J7qLqy3bNKpKrg0shy4+X9GMJs93
zMGOIJXyypFxi5ug4+Orr3/rkpAfYuqonRhsJgN3HT1zOHa5QSr/9JWE27V+zKGd
X4p1btNNdTItYL+loG2Kiz/8jLGLpx00QUYFhxlTQ9laZUrdMtx3hw==
=djSy
-----END PGP SIGNATURE-----
--=-=-=--


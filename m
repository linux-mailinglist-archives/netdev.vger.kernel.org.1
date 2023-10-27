Return-Path: <netdev+bounces-44768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6007D9A2F
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 15:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2228C281947
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 13:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9375200BA;
	Fri, 27 Oct 2023 13:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandelman.ca header.i=@sandelman.ca header.b="bjcZFFnQ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A9E1F958
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 13:39:23 +0000 (UTC)
X-Greylist: delayed 523 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 Oct 2023 06:38:53 PDT
Received: from tuna.sandelman.ca (tuna.sandelman.ca [IPv6:2607:f0b0:f:3:216:3eff:fe7c:d1f3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18CF1A6
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 06:38:53 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by tuna.sandelman.ca (Postfix) with ESMTP id 92FA21800E;
	Fri, 27 Oct 2023 09:30:08 -0400 (EDT)
Received: from tuna.sandelman.ca ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id WDTG7ky62-fa; Fri, 27 Oct 2023 09:30:07 -0400 (EDT)
Received: from sandelman.ca (obiwan.sandelman.ca [IPv6:2607:f0b0:f:2::247])
	by tuna.sandelman.ca (Postfix) with ESMTP id 38CBB1800C;
	Fri, 27 Oct 2023 09:30:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandelman.ca;
	s=mail; t=1698413407;
	bh=ZgNuC7FhnLtOiT6VuflzYhbLeg77u65h8Qbd9w7E/nc=;
	h=From:To:cc:Subject:In-Reply-To:References:Date:From;
	b=bjcZFFnQxmfk6N4Pk6N0R4uGq5YsLS164YrcooZt/UhndJRNMh9tGlgeu5GCOFZKS
	 +71dieidDyq9/3a0kq4H3syjXZLwIJCcLSYHSCerNuxMe6xnJSLH2zpc+aQktmrNGs
	 CX1U7Cuw7GfH/+pBQ3AN+hlt1i2LlBc+RPcxCHj3ngDNFhJU5sLkS7dAc92aizBAUI
	 fYgdBLzijf/Aa4z0PFOCE9l7KE7OlQD7pAgRMMq0ue8vwoH6Zw5mWpP9VRIoV3Azu1
	 4grE6GJJKkaAYlBGFZoBshTgVZw8Q1OJ/4I5aEGP/c+6xM0+DRJDLhwZsl9oHX3C4J
	 NmEl7XwJdgFRg==
Received: from localhost (localhost [IPv6:::1])
	by sandelman.ca (Postfix) with ESMTP id 30C9D9F;
	Fri, 27 Oct 2023 09:30:07 -0400 (EDT)
From: Michael Richardson <mcr@sandelman.ca>
To: antony.antony@secunet.com
cc: Steffen Klassert <steffen.klassert@secunet.com>,
    Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
    devel@linux-ipsec.org, Jakub Kicinski <kuba@kernel.org>,
    "David S. Miller" <davem@davemloft.net>
Subject: Re: [devel-ipsec] [PATCH v2 ipsec-next 2/2] xfrm: fix source address in icmp error generation from IPsec gateway
In-Reply-To: <300c36a0644b63228cee8d0a74be0e1e81d0fe98.1698394516.git.antony.antony@secunet.com>
References: <e9b8e0f951662162cc761ee5473be7a3f54183a7.1639872656.git.antony.antony@secunet.com> <300c36a0644b63228cee8d0a74be0e1e81d0fe98.1698394516.git.antony.antony@secunet.com>
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; GNU Emacs 27.1
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
Date: Fri, 27 Oct 2023 09:30:07 -0400
Message-ID: <16810.1698413407@localhost>

--=-=-=
Content-Type: text/plain


Antony Antony via Devel <devel@linux-ipsec.org> wrote:
    > When enabling support for xfrm lookup using reverse ICMP payload,
    > We have identified an issue where the source address of the IPv4 e.g
    > "Destination Host Unreachable" message is incorrect. The IPv6 appear
    > to do the right thing.

One thing that operators of routers with a multitude of interfaces want to do
is send all ICMP messages from a specific IP address.  Often the public
address, that has the sane reverse DNS name.
AFAIK, this is not an option on Linux, but Cisco/Juniper/etc. devices usually
can do this.  I can't recall how today. (I was actually looking that up this week)

This can conflict however, with the need to get the result back into the
tunnel.  I don't have a good answer, except that we probably need a fair bit
of flexibility, with some good automatically discovered defaults.



--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCgAvFiEEbsyLEzg/qUTA43uogItw+93Q3WUFAmU7u18RHG1jckBzYW5k
ZWxtYW4uY2EACgkQgItw+93Q3WVp2Af+LDuoNcRvj3SmRftxzV1isPGP+/74ZYHd
DuLTVBb6SjVrSAGoVTdMksQ+kLyWGuX8wZHd5LTKfyyjbwoHL9HUtn21sTMspCwZ
YtXYRFw2zp2SHtg9DGhsKJZKWFvtNTzQh8Pq/VlFJ4nLEvNA3IijKM3polQtAl1k
CB615u3kc9uPxZQNvuQjoGNP3LvrP+aSSfsSVWO4BPYxc/KpoCEGPCntCmvocDl/
PjqNGVApQRZbkE+Y/k+UFrwdxI5IY1qy1KDE8aMPc6DVp4G94VVF6Ab/GqfE4d5E
9qYRuRFVCb7aPPzGELdB+q4bm31i1b0DOSTfY6MUoxLwP55MQcnaog==
=fNdj
-----END PGP SIGNATURE-----
--=-=-=--


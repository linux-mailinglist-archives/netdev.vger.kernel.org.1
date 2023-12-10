Return-Path: <netdev+bounces-55644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB14280BC9E
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 19:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65870B207FC
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 18:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909AC1A5A0;
	Sun, 10 Dec 2023 18:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandelman.ca header.i=@sandelman.ca header.b="EL3dE5GC"
X-Original-To: netdev@vger.kernel.org
X-Greylist: delayed 394 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 10 Dec 2023 10:54:14 PST
Received: from tuna.sandelman.ca (tuna.sandelman.ca [209.87.249.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E463D95
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 10:54:14 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by tuna.sandelman.ca (Postfix) with ESMTP id B229F1800F;
	Sun, 10 Dec 2023 13:47:37 -0500 (EST)
Received: from tuna.sandelman.ca ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id wQjBjc7C-lVr; Sun, 10 Dec 2023 13:47:35 -0500 (EST)
Received: from sandelman.ca (obiwan.sandelman.ca [IPv6:2607:f0b0:f:2::247])
	by tuna.sandelman.ca (Postfix) with ESMTP id A7D7A1800C;
	Sun, 10 Dec 2023 13:47:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandelman.ca;
	s=mail; t=1702234055;
	bh=QphxznjkhXHX+kh4bhaDhMyx0bJB04o0vglcWjvMXUM=;
	h=From:To:cc:Subject:In-Reply-To:References:Date:From;
	b=EL3dE5GCP3F81Sv1WbihMuEGMEkuET/HVoa4uEB/0/K9gGeYrauapYKqReNbj507Q
	 NSfURcamzZUgWAFIJKKUCcsQHbbg5q7d4VOdPZJpDys3XbjvwJvNVkqyyo82qCa2oZ
	 agwwAU+T1qpi/KZ+DoNh8wjt7E2IYPoUtZjc8bTm1XX6dVSXQzHnQE1D8VaAscUu/D
	 xOUy/k9W/QEc123IveAjHrumK7BsUR0d6AFd27MhIOYPIAP0roeZqW3p+Zbd0piJ4V
	 GfAhL06zq2ntVBhCNWRJY7/6+b9mIFnplm0hklSIsjuGaEt91lVMK48T02EZxgdm6j
	 0Fa7961w7dQmQ==
Received: from localhost (localhost [IPv6:::1])
	by sandelman.ca (Postfix) with ESMTP id 9FB372A6;
	Sun, 10 Dec 2023 13:47:35 -0500 (EST)
From: Michael Richardson <mcr@sandelman.ca>
To: Eyal Birger <eyal.birger@gmail.com>
cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
    kuba@kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com,
    herbert@gondor.apana.org.au, pablo@netfilter.org, paul@nohats.ca,
    nharold@google.com, devel@linux-ipsec.org, netdev@vger.kernel.org
Subject: Re: [devel-ipsec] [PATCH ipsec-next, v2] xfrm: support sending NAT keepalives in ESP in UDP states
In-Reply-To: <20231210180116.1737411-1-eyal.birger@gmail.com>
References: <20231210180116.1737411-1-eyal.birger@gmail.com>
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; GNU Emacs 28.2
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
Date: Sun, 10 Dec 2023 13:47:35 -0500
Message-ID: <15709.1702234055@localhost>

--=-=-=
Content-Type: text/plain


+		BUILD_BUG_ON(XFRMA_MAX != XFRMA_NAT_KEEPALIVE_INTERVAL);

This code was there before, and you are just updating it, but I gotta wonder
about it.  It feels very not-DRY.
It seems to be testing that XFRMA_MAX was updated correctly in the header
file, and I guess I'm dubious about where it is being done.

I said last year at the workshop that I'd start a tree on documentation for
XFRM stuff, and I've managed to actually start that, and I'll attempt to use
this new addition as template.

As a general comment, until this work is RCU'ed I'm wondering how it will
perform on systems with thousands of SAs. As you say: this is a place for
improvement.  If no keepalives are set, does the code need to walk the xfrm
states at all.  I wonder if that might mitigate the situation for bigger
systems that have not yet adapted.  I don't see a way to not include this
code.





--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCgAvFiEEbsyLEzg/qUTA43uogItw+93Q3WUFAmV2B8cRHG1jckBzYW5k
ZWxtYW4uY2EACgkQgItw+93Q3WVFaAgAhbQRe6GVdaXpKqSTwMZg9YARXlt+mGdp
wbNBxMihO944rRpBBTjF7WbUumKTYmsROvmauhRyzhYdtSlkTQ3nbfQWwf5k+5d0
QptnBr82kiSkNGyM5ezx8NOa8RE6u7KSAIoLjp3Z7/uMpbKmGlhmO3Nyu9JgIOej
1aZ0lamGVr7E0CUPuWLwNW3JNwPGtOq4q2W7LRg0bJggHvU5Od95k+HXq7jDXxYm
En3SrD0Jnivzt0OYhqmo/lkd69iEQHfIhn+iRrrtFxuM9Hoi/jnYyntGE4qwTTc2
5TCm2C6HD4qfbU0A+xP3xA3aN0aEbr8vRex1l73lry2OC7UsWoyBRQ==
=Bh0k
-----END PGP SIGNATURE-----
--=-=-=--


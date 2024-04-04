Return-Path: <netdev+bounces-84813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC4D89865A
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 13:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66796288C65
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 11:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3048E82876;
	Thu,  4 Apr 2024 11:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandelman.ca header.i=@sandelman.ca header.b="Ubq2600j"
X-Original-To: netdev@vger.kernel.org
Received: from tuna.sandelman.ca (tuna.sandelman.ca [209.87.249.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDCD745C3
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 11:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.87.249.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712231265; cv=none; b=mdP+ccWItcS2/YQM6AAvmAtG3XFadxvM6D8GxOrmYrrJsIpkkGXl8bEv7b0pvwKJ+uO62+dWVnuGx0VbOhg3YupcsjnT4kQQvHuon7nsi3HhxxnCQc2pozBBGbwCaOxLjmmIr7VFnxC8Wr1tDC3ko95IduYjeNXCawFPV1CHHNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712231265; c=relaxed/simple;
	bh=PABBUSzejn1hkSBNwXigPpIvtBs+/cxFIUvBforHgAE=;
	h=From:To:cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=Pp5DF7R+PrR/+0jh2/rdBMpGHWSIyFmLkmmD11scItH3Ih9l/oT9kCD9bQQqpe/+Ug4kMj811jgTt3hq3ea4rwAPEsLYyL0IcZRksfBBSuw6sfKN8iqM9h4yboC2TeCnMCv7753Pg4FcZS+EoemEE8jrPoE70SYmIQwvFXhgVXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandelman.ca; spf=pass smtp.mailfrom=sandelman.ca; dkim=pass (2048-bit key) header.d=sandelman.ca header.i=@sandelman.ca header.b=Ubq2600j; arc=none smtp.client-ip=209.87.249.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandelman.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandelman.ca
Received: from localhost (localhost [127.0.0.1])
	by tuna.sandelman.ca (Postfix) with ESMTP id EB08F3898B;
	Thu,  4 Apr 2024 07:38:04 -0400 (EDT)
Received: from tuna.sandelman.ca ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id KW9QgUZ4aBQL; Thu,  4 Apr 2024 07:38:04 -0400 (EDT)
Received: from sandelman.ca (obiwan.sandelman.ca [209.87.249.21])
	by tuna.sandelman.ca (Postfix) with ESMTP id 3FD8F38988;
	Thu,  4 Apr 2024 07:38:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandelman.ca;
	s=mail; t=1712230684;
	bh=CKkRPNC+uyK55LepfndT0wO9UV8rc9Z9TNsPXgoX73w=;
	h=From:To:cc:Subject:In-Reply-To:References:Date:From;
	b=Ubq2600jIt/CNXt9qeGin9X8NzDILKOuJUjaQ47dzAcA9nes1zVHmQIjD1bbqYaKP
	 FfwzhKEonai5g+W8udn2XkgJf2Fc8EKRVs3lpMKDknlMzAoM9ha7TYv5DU/iU308s8
	 bK8RLvfpau7owESaC4WrmpnuwKeDgndQ2H34MBGr/hC+wj2oj07lHRDh1oMGO9/XtP
	 2RjanXdYSTdS/tLppJbv5FGSrTzowmRvJK44NlRWSZbQaRZ/wclcVpXJaE/5HTMYIQ
	 7SUnkJXZOhykeJUNEW+XtcFCpjeMyuwO7Esy7rjtzZju1Gxk6kiqWF/yXi4LRwrfg1
	 UTUYcj9X8/5Mg==
Received: from obiwan.sandelman.ca (localhost [IPv6:::1])
	by sandelman.ca (Postfix) with ESMTP id 35BCA111;
	Thu,  4 Apr 2024 07:38:04 -0400 (EDT)
From: Michael Richardson <mcr@sandelman.ca>
To: antony.antony@secunet.com
cc: Jakub Kicinski <kuba@kernel.org>,
    Steffen Klassert <steffen.klassert@secunet.com>,
    "David S. Miller" <davem@davemloft.net>,
    David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
    "Paolo
 Abeni" <pabeni@redhat.com>, netdev@vger.kernel.org,
    devel@linux-ipsec.org, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [devel-ipsec] [PATCH net 1/1] xfrm: fix source address in icmp error generation from IPsec gateway
In-Reply-To: <20ea2ab0472ecf2d1625dadb7ca0df39cf4fe0f5.1712226175.git.antony.antony@secunet.com>
References: <cover.1712226175.git.antony.antony@secunet.com> <20ea2ab0472ecf2d1625dadb7ca0df39cf4fe0f5.1712226175.git.antony.antony@secunet.com>
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
Date: Thu, 04 Apr 2024 07:38:04 -0400
Message-ID: <28050.1712230684@obiwan.sandelman.ca>

--=-=-=
Content-Type: text/plain


Antony Antony via Devel <devel@linux-ipsec.org> wrote:
    > This commit would force to use source address from the gatway/host.
    > The ICMP error message source address correctly set from the host.

While that seems more correct, since that host is generating, it might not
fit into the IPsec tunnel, and therefore might go the right place or
anywhere.   Perhaps you could pick the internal IP of the gateway, but in
more complex policies, the gateway itself might not be part of the VPN.

    > Again before the fix ping -W 5 -c 1 10.1.4.3 From 10.1.4.3 icmp_seq=1
    > Destination Host Unreachable

    > After the fix From 10.1.3.2 icmp_seq=1 Destination Host Unreachable

ip -netns host2 xfrm policy add src 10.1.1.0/24 dst 10.1.4.0/24 dir out \
        flag icmp tmpl src 10.1.2.1 dst 10.1.3.2 proto esp reqid 1 mode tunnel

As far as I can see, 10.1.3.2 does not fit into this policy.
You appear to be selecting the outside ("WAN") interface of the gateway.
It would be less confusing if you had used 172.16.0.0/24 for the outside of
the gateways in your example.
How will the WAN interface manage to talk to the internal sender of the
packet except via the tunnel?

--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        |    IoT architect   [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCgAvFiEEbsyLEzg/qUTA43uogItw+93Q3WUFAmYOkRwRHG1jckBzYW5k
ZWxtYW4uY2EACgkQgItw+93Q3WX+gwf/eyG65KWi3xirCNfQZgaClrZ8yFO17DbK
tcNebszq3BwuIgTCMhrQzzMoOUFo+QjMYziu+0CEy/2L6OpxD2donUlCAIBhrzdW
K4AXwMXw/E1gOdlzQhD+9T02bLqJULAhH387dzb7mEDAi24xnSKW9qmo1kL95g6v
sH41LmPIAW6x1cE7irRAmGj7/jcysrv3uEEkvECUkmNwDr+6MnhvYIk2VSGRMeSm
4u6/UuXlSiMuGiwE7LoABWqErYwWidXdrJqL9rnP4LF03WWuQX1IarAIP0yzhw7m
07byVNAoKiagSTvl7soOq5fc4rlc/vDu8unLjCpqLJs8Ux/G7rtP/w==
=m3i1
-----END PGP SIGNATURE-----
--=-=-=--


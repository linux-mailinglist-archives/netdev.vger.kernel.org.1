Return-Path: <netdev+bounces-132756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F118993023
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0382289F20
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14FD1D88B9;
	Mon,  7 Oct 2024 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.fr header.i=benoit.monin@gmx.fr header.b="BF2prAz3"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981CE1D79A5;
	Mon,  7 Oct 2024 14:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728312885; cv=none; b=W6TCGf7tRSxRO5jhLM3+dofeU7sY1qJpnPsHZf/+au5I5/bKF0Lov/Z1UPgB/Rbfm2W280bAPV94JJ2zzc6GaBJ2xcXPengKaZOMXY5+2sqra7qagTO6QFVG9xcFROwElOd2tlGBBcI0ikm6R+fVeH8PBpnImL6xhqJPttAHNHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728312885; c=relaxed/simple;
	bh=Iqo8ngZeODghVeUiw2dCz+wYnflCSXSkcVxpoW7h7/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vi15NAY5q5AKcEsCpBu7zccUEp0h6DXSAp2JH7FBEIfXvPLUDznkVZqR3JRZIZlHT3wbOU9Uvnqwl4cKH5gYS/AcvritCnJuBiNuaT73zTMjwCDqopxjIpQz7iCX8KWyo5ahIww5haRRTmyqxKsr3EVive+ASvjJCB8DOqiouv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.fr; spf=pass smtp.mailfrom=gmx.fr; dkim=pass (2048-bit key) header.d=gmx.fr header.i=benoit.monin@gmx.fr header.b=BF2prAz3; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.fr;
	s=s31663417; t=1728312854; x=1728917654; i=benoit.monin@gmx.fr;
	bh=5CJ3PojilP9pzTP1lBI15/fEZnSMxZWJzIh/6VHIbiw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BF2prAz3Kc2ABilUFHCaa7kPUmPxI7YXJQ3i8P+ARVgB4s+iEZr4V8M9xIJmCt92
	 ORgEQb8LLe81w2z8h1EEK7yiL6hCsTebf/nsb7M81iv3Ayo4c59UfRSyp6ZPYiLzT
	 F7SQcGO7TgvoptyKdjf9VO+ytumffEunrw1a153Gzp+Yk6qnOyRhlyYJwcXiJ5h+a
	 CibTkiZA8SUhCh4/X5jY7C0Av+5rDmLGfviz269gfCsSuuGJ1byM4oN75F9H2tGAx
	 8bGo46Obq7lKgnRZgPANa/QzyaVz1RgJ0Py/aSD2xnd6jLDv82+Ycsc2eEgYiYSt0
	 Q8bL+SRxxs0e+QqgAw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from pianobar.pianonet ([176.145.30.241]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N6bjy-1u4JYW1QZa-012GRi; Mon, 07
 Oct 2024 16:54:14 +0200
From: =?UTF-8?B?QmVub8OudA==?= Monin <benoit.monin@gmx.fr>
To: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH net-next] net: skip offload for NETIF_F_IPV6_CSUM if ipv6 header
 contains extension
Date: Mon, 07 Oct 2024 16:54:12 +0200
Message-ID: <7056440.9J7NaK4W3v@benoit.monin>
In-Reply-To: <670326ed8220a_135479294d1@willemb.c.googlers.com.notmuch>
References:
 <0dc0c2af98e96b1df20bd36aeaed4eb4e27d507e.1728056028.git.benoit.monin@gmx.fr>
 <670326ed8220a_135479294d1@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Provags-ID: V03:K1:sxe0lufCzZrl31HztvVECRrNs0/1q9l2gDX+sqVQ3gnzuA4mRJl
 hYRkpxVJQ5s96ZCoX1GHHaDzUTeNFqqbm2/+hLKwkk2/mv3UnyHJZZE1QqJJyfa5AgtcfmT
 16LFFuOChxZW/pNs5bzU0F9tDKtdQDKNd9zxBnDH2SnnFqcI4SBVDcSpGPhBcVgnjWHMoRC
 NsazlLT3idjpQxTDLtaMw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mnytWOTI3LY=;Dwas4gEcZSCt+t8SqMatF64rYcJ
 jFc5zDFVixNDN472LFGcQlSFtEb0gtsU5olju1J5u4Hr5TRJGifoC5pszAQMrOyYHR/k79aHq
 ggUjns8gmGoTRuxLwMkKHc4c3WKgktnGxEty7JQ7KSmvzdSWu5kBlF05Zj4rQ7A7EUuCjeVCF
 pg61laObjFGKAkJltc0CSTybJTY5Q996gozvxeSkRtjMoalc8NlareZyiG8njZy7tJrZS7apm
 66zJRhCBgr8R/QOH27/Rc460fiPPP/vob11gPfWhotBkjXFa8wWrHeB/IQPxbswOUi0PMFKNz
 ij5GVPX3vul3vLB5iNvQo1tfTTK1TexSEuzhHjSa1oKECh9mrfcnsJecwSeaxuzVJAbKJk77d
 kbd1NUi5yHWUmCH370ZZU1wxr6u5BCt/0q2T7E2vL0d5PcRhsdQdz2Y1YVocgGOwdW4OqOm4S
 g1i9Adoa4EyWxS2HtTB20TKpzQ+QN83hw1f8C2g8pudocVn9Ew0RKPUNQ+m5dxKKBkDx1cQpT
 uuCEtjIkOa86Ap9djBKUcY64QKZi4sDsIpgEGGYSEBlDuAg9UppWrtgGRd9nESKnGTR7tOUfy
 K0kDRp5z14MnVoWwRou87dDENBCD9i1eOrPkpEy6hOl+DOPWMh/aWLxg8MOCxk77zoxQK4F1N
 H8TvjgNswPh5RmVKr8k+9uhH35vqSXFN9hL7BTYDFwq7jdOJvI8c7eVCB1tZIDKoFCyVLSnX6
 8bmlTPqh0A6cXb0SkIvcFPArRkeuAgm1DXVmrHhdeznurWGh2b3BlgDh6YjiMN+/mFtiFcDoF
 3pVkIW/cbnOluJnmBJWAOkeA==

07/10/2024 Willem de Bruijn wrote :
> Beno=C3=AEt Monin wrote:
> > Devices with NETIF_F_IP_CSUM capability can checksum TCP and UDP over
> > IPv4 with an IP header that may contains options; whereas devices with
> > NETIF_F_IPV6_CSUM capability can only checksum TCP and UDP over IPv6 if
> > the IP header does not contains extension.
>=20
> Are both these statements universally true across devices?
>=20
> I can believe for NETIF_F_IP_CSUM that this is the definition, and
> that devices that cannot handle options must fix it up indivually in
> ndo_features_check.
>=20
> And same for NETIF_F_IPV6_CSUM with extension headers.
>=20
> But it would be good to see where this is asserted in the code, or
> examples of drivers that have to perform such actions.
>=20
I was referring to the documentation in skbuff.h that describes=20
NETIF_F_IP_CSUM and NETIF_F_IPV6_CSUM.

=46or NETIF_F_IPV6_CSUM, at least fsl_dpa and r8169 expect=20
ipv6_hdr(skb)->nexthdr to be IPPROTO_{TCP,UDP} to compute the correct=20
checksum for IPv6.

I posted more details about the problem I am trying to fix with this=20
patch in the following thread:=20
https://lore.kernel.org/netdev/26548921.1r3eYUQgxm@benoit.monin/T/#u

> > Enforce that in skb_csum_hwoffload_help by checking the network header
> > length in the case where the IP header version is 6. We cannot simply
> > rely on the network header length since the IPv4 header can from 20 to
> > 60 bytes whereas the IPv6 header must be 40 bytes. So we check the
> > version field which is common to IPv4 and IPv6 headers.
> >=20
> > This fixes checksumming errors seen with ip6_tunnel and fou6
> > encapsulation, for example with GRE-in-UDP over IPv6:
> > * fou6 adds a UDP header with a partial checksum if the inner packet
> > does not contains a valid checksum.
>=20
> Where in the code is this conditional on the inner packet csum?
>=20
This is done by udp6_set_csum, which called by fou6_build_udp.

> > * ip6_tunnel adds an IPv6 header with a destination option extension
> > header if encap_limit is non-zero (the default value is 4).
>=20
>=20
> If this is a fix, we'll need to target net and best effort find a
> suitable fixes tag.
> =20
I guess the particular problem I have found is present since the merge=20
of fou6 in 4.7, but it might not be the only code path to create an=20
IPv6 packet with an extension header and a partial checksum.

> > Signed-off-by: Beno=C3=AEt Monin <benoit.monin@gmx.fr>
> > ---
> >  net/core/dev.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index ea5fbcd133ae..199831d86ec1 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -3639,6 +3639,9 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
> >  		return 0;
> >=20
> >  	if (features & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) {
> > +		if (ip_hdr(skb)->version =3D=3D 6 &&
> > +		    skb_network_header_len(skb) !=3D sizeof(struct ipv6hdr))
> > +			goto sw_checksum;
> >  		switch (skb->csum_offset) {
> >  		case offsetof(struct tcphdr, check):
> >  		case offsetof(struct udphdr, check):
> > @@ -3646,6 +3649,7 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
> >  		}
> >  	}
> >=20
> > +sw_checksum:
> >  	return skb_checksum_help(skb);
> >  }
> >  EXPORT_SYMBOL(skb_csum_hwoffload_help);
>=20

=2D-=20
Beno=C3=AEt




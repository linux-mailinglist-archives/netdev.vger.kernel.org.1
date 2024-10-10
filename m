Return-Path: <netdev+bounces-134323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65667998CB5
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 18:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8563F1C2417A
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 16:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AB51CCB26;
	Thu, 10 Oct 2024 16:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.fr header.i=benoit.monin@gmx.fr header.b="XgXiS4tF"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649781CDFBF;
	Thu, 10 Oct 2024 16:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728576194; cv=none; b=TFyyEkXWoVh7s7ZbKIleqVROX+vl2l2Q5PTNWbsd4D7GlDpXeVeMZUTRTSQBD4kfsL/BIPw6eXkKxY021E2TkpNiiiFtiw3xEvRxAqe5UMM9g16WHSgBwlaQn26hFveh0gCN8IYdESxjJxUzZG4yZVHiv2I54xZlFO40K7+OvMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728576194; c=relaxed/simple;
	bh=YEur4iq0uGEeB52FwdOWW2u8Qd1BoZFT2Y84D9WsaLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1NBLz0BLQvlX5NZyf8YAFQpWWvNBDX9s/ym317uJN5USijMRcy8rYb61vMZWaVGO92utGv+H/OrFmPIe0hG+GV+v/1DEZaeddnOy5dPkWCUiMDVyj8klqtSEvsEgl5GlRKXaI0tQnJfGN+1Vuqa+jhO4rqr+BWgFfAq1hRS+Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.fr; spf=pass smtp.mailfrom=gmx.fr; dkim=pass (2048-bit key) header.d=gmx.fr header.i=benoit.monin@gmx.fr header.b=XgXiS4tF; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.fr;
	s=s31663417; t=1728576161; x=1729180961; i=benoit.monin@gmx.fr;
	bh=RfZGwL1l9wHXLj6f7j79OWKeH3u63ih9lynY6pSJ1mI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XgXiS4tFCmmKUra0F59QKjz4j9kI3psiz+Bw5UhgoaBo1LEdMsrmnYRE4FY0zWYm
	 P3icszIiBPmdcR+ERUYI7eHc6+ytgRuBXUCmALW7iAtaJzS9kCQkuAsKK3rdlDjht
	 cKAQCbBJpyLWUzGOW2MX43NqwX2dvR4VL3ac1oQ7eP9bxJyLHgKIRxWfdPHQR9lYI
	 Jh9+6ybZwgA9mQea9YX2GmghSVDYOpW90xMrxkhYEBlVAk5PvRF+vJmo960fuZzfU
	 aXn222QRTwKhM6T9IQf359NkK2jNGllNXJip+WZqekiHfjjtZcz4r+zaFXEKpTyvb
	 x7mjBZiFi1BBFcZGgg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from pianobar.pianonet ([176.145.30.241]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M3UUy-1syNOM3SVe-003gfV; Thu, 10
 Oct 2024 18:02:40 +0200
From: =?UTF-8?B?QmVub8OudA==?= Monin <benoit.monin@gmx.fr>
To: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH net-next] net: skip offload for NETIF_F_IPV6_CSUM if ipv6 header
 contains extension
Date: Thu, 10 Oct 2024 18:02:39 +0200
Message-ID: <4411734.UPlyArG6xL@benoit.monin>
In-Reply-To: <6704483c31f9c_1635eb294a0@willemb.c.googlers.com.notmuch>
References:
 <0dc0c2af98e96b1df20bd36aeaed4eb4e27d507e.1728056028.git.benoit.monin@gmx.fr>
 <7056440.9J7NaK4W3v@benoit.monin>
 <6704483c31f9c_1635eb294a0@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Provags-ID: V03:K1:eTA5N3veNAgjqkcsOBlVDQzQb8QraoITNoPaoblTNMsSZf2vbfI
 2nVGfarOOJQek5cwmeAVHmIjYftXhu6eGFZTz/Awt601PbuIFoVrPqyks2921fwLaCYSUbH
 vNs0oPg4w3aGYwFXJ9Y/Gg529fKz5bn0Bp83wX/CoZfdLOgKOxNqA8IE6QfUZxxUsseAhxN
 H9YKvYzVXYWvGX+Tam4eA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sq9/lO4Evuo=;72Wnv/zcLu1ecjuENwogYll7KXX
 qMlxBejT1s26Xir1LXtn5LBZBKFA+VSECJhvJMF99Qg5i9Bgkdr50ZV4cJI5xrsN4pnMlKJV1
 RuPi4qnFyk37tk+I6mu9rh4W8i3GdEL0gU7nuHhrIYW64Dcu6v3ano5O3RNyBhJq9iYgIGlqY
 H54LLImiTTW+UpiWUBYHmmnchVrOl2JXEe7r75SQxDm6lcMchJ8azUJ9QDsRdmRYvZ1ZLJSz6
 NVfQIvnx0MnyEjOyiX9aSWKxrKPXb2Py860a7Td2bFgj5NvpjpAc+vZBApkjb4uOqKVQXXx4A
 mBdKC9W4EqJQxxqQPNno6Of1M9Sn6AQMFHOiZEOXgoS7poymzqfuwiFuvnJVzx3JwQiFxKOGS
 zHVFQ+hmVPbsZNxgH5n3GBUPxMUQOxpiSsnGd6ououS0KBWsEThsZ/gUDywHw8Co5MUc+zWyS
 8W0YQEpR0r68hgpuTqB4TRzZtdM+PE0uNVgNGHVzP+q0tNBrLBdykpuHEnevtTatKiEhJaalN
 FvnCuJ8HZT2w/EzNweNRQF/pZTcxMGbrpcwQOe8ncobKQ+WshoMvm83/xSXdvV/Yl8dyEjYWE
 mAkrspbHUfBPFJoML6UzwudIYAOpYmyOAikv0Vd6odexGUdp2qwMtfXJo2emlfuTx9rVYRseX
 0w97olJPBVOhpWVdCPaQNDFwFxpMLgIq3dIH183heAVtGFttXJbidHki/dMESxEERKU7Xg6mU
 W9c0Jrk6pvbSSwYhS5j2FNr4raZZNj02sQv5xCBB+kkfFP0FNPgAp+KX7jmrZNwCQYhOPdlKM
 Oh5KQnKKNN6jzgLDqFzjy7Mg==

07/10/2024 Willem de Bruijn wrote:
> Beno=C3=AEt Monin wrote:
> > 07/10/2024 Willem de Bruijn wrote :
> > > Beno=C3=AEt Monin wrote:
> > > > Devices with NETIF_F_IP_CSUM capability can checksum TCP and UDP ov=
er
> > > > IPv4 with an IP header that may contains options; whereas devices w=
ith
> > > > NETIF_F_IPV6_CSUM capability can only checksum TCP and UDP over IPv=
6 if
> > > > the IP header does not contains extension.
> > >=20
> > > Are both these statements universally true across devices?
> > >=20
> > > I can believe for NETIF_F_IP_CSUM that this is the definition, and
> > > that devices that cannot handle options must fix it up indivually in
> > > ndo_features_check.
> > >=20
> > > And same for NETIF_F_IPV6_CSUM with extension headers.
> > >=20
> > > But it would be good to see where this is asserted in the code, or
> > > examples of drivers that have to perform such actions.
> > >=20
> > I was referring to the documentation in skbuff.h that describes=20
> > NETIF_F_IP_CSUM and NETIF_F_IPV6_CSUM.
>=20
> Excellent. I had missed that when trying to find the source.
> Can you add that pointer to the commit message?
> =20
Agreed, I will add that to the commit message.

> > For NETIF_F_IPV6_CSUM, at least fsl_dpa and r8169 expect=20
> > ipv6_hdr(skb)->nexthdr to be IPPROTO_{TCP,UDP} to compute the correct=20
> > checksum for IPv6.
> >=20
> > I posted more details about the problem I am trying to fix with this=20
> > patch in the following thread:=20
> > https://lore.kernel.org/netdev/26548921.1r3eYUQgxm@benoit.monin/T/#u
>=20
> And I had missed this thread entirely too. It's very helpful.
>=20
> Please add a Link: tag that refers to it.
> =20
Ok.

> > > > Enforce that in skb_csum_hwoffload_help by checking the network hea=
der
> > > > length in the case where the IP header version is 6. We cannot simp=
ly
> > > > rely on the network header length since the IPv4 header can from 20=
 to
> > > > 60 bytes whereas the IPv6 header must be 40 bytes. So we check the
> > > > version field which is common to IPv4 and IPv6 headers.
> > > >=20
> > > > This fixes checksumming errors seen with ip6_tunnel and fou6
> > > > encapsulation, for example with GRE-in-UDP over IPv6:
> > > > * fou6 adds a UDP header with a partial checksum if the inner packet
> > > > does not contains a valid checksum.
> > >=20
> > > Where in the code is this conditional on the inner packet csum?
> > >=20
> > This is done by udp6_set_csum, which called by fou6_build_udp.
>=20
>         else if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
>                 uh->check =3D 0;
>                 uh->check =3D udp_v6_check(len, saddr, daddr, lco_csum(sk=
b));
>                 if (uh->check =3D=3D 0)
>                         uh->check =3D CSUM_MANGLED_0;
>         } else {
>                 skb->ip_summed =3D CHECKSUM_PARTIAL;
>                 skb->csum_start =3D skb_transport_header(skb) - skb->head;
>                 skb->csum_offset =3D offsetof(struct udphdr, check);
>                 uh->check =3D ~udp_v6_check(len, saddr, daddr, 0);
>         }
>=20
> It either leaves the inner header as CHECKSUM_PARTIAL, and fills in
> the outer header entirely, based on knowledge that the inner header
> will add up to zero (local checksum offload).
>=20
> Or it assumes that the inner header is already filled in (whether
> computed or CSUM_MANGLED_0) and then uses CHECKSUM_PARTIAL offloading
> for the outer packet.
>=20
> The issue you are seeing is because CHECKSUM_PARTIAL with
> NETIF_F_IPV6_CSUM does not work if extension headers are present. If
> so, it should even affect non-tunneled packets. I think this reference
> to a dependency on the state of an inner checksum adds confusion only.
> Unless I'm missing something.
>=20
I also forgot to mention that the problem only affects encapsulated packets=
=2E=20
UDP packets emitted from user-space to an IPv6 address go through=20
ip6_make_skb(), which calls __ip6_append_data() where a check is done on th=
e=20
header size before setting CHECKSUM_PARTIAL:

	/* CHECKSUM_PARTIAL only with no extension headers and when
	 * we are not going to fragment
	 */
	if (transhdrlen && sk->sk_protocol =3D=3D IPPROTO_UDP &&
	    headersize =3D=3D sizeof(struct ipv6hdr) &&
	    length <=3D mtu - headersize &&
	    (!(flags & MSG_MORE) || cork->gso_size) &&
	    rt->dst.dev->features & (NETIF_F_IPV6_CSUM | NETIF_F_HW_CSUM))
		csummode =3D CHECKSUM_PARTIAL;

This is done before calling ip6_local_out(). No such check is done by=20
ip6_tnl_xmit() before it calls ip6_local_out(), because there is no reason =
to=20
check for device offload feature at this point. It is assumed that it will =
be=20
verified by validate_xmit_skb().

I will add this explanation to the commit message.

> > > > * ip6_tunnel adds an IPv6 header with a destination option extension
> > > > header if encap_limit is non-zero (the default value is 4).
> > >=20
> > >=20
> > > If this is a fix, we'll need to target net and best effort find a
> > > suitable fixes tag.
> > > =20
> > I guess the particular problem I have found is present since the merge=
=20
> > of fou6 in 4.7, but it might not be the only code path to create an=20
> > IPv6 packet with an extension header and a partial checksum.
>=20
> True. The fix as is won't be backportable before commit 62fafcd63139
> ("net: support ip generic csum processing in skb_csum_hwoffload_help")
> in v5.12 anyway.
>=20
> Maybe use that as the Fixes tag, but add a comment in the tag that it
> did not introduce the bug, but the fix depends on that logic.
>=20
Ok, I will add a Fixes tag.

> > > > Signed-off-by: Beno=C3=AEt Monin <benoit.monin@gmx.fr>
> > > > ---
> > > >  net/core/dev.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >=20
> > > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > > index ea5fbcd133ae..199831d86ec1 100644
> > > > --- a/net/core/dev.c
> > > > +++ b/net/core/dev.c
> > > > @@ -3639,6 +3639,9 @@ int skb_csum_hwoffload_help(struct sk_buff *s=
kb,
> > > >  		return 0;
> > > >=20
> > > >  	if (features & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) {
> > > > +		if (ip_hdr(skb)->version =3D=3D 6 &&
> > > > +		    skb_network_header_len(skb) !=3D sizeof(struct ipv6hdr))
> > > > +			goto sw_checksum;
>=20
> This check depends on skb->transport_header and skb->network_header
> being set. This is likely true for all CHECKSUM_PARTIAL packets that
> originate in the local stack. As well as for the injected packets and
> forwarded packets, as far as I see, so Ack.
>=20
> Access to the network header at this point likely requires
> skb_header_pointer, however. As also used in qdisc_pkt_len_init called
> from the same __dev_queue_xmit_nit.
>=20
> Perhaps this test should be in can_checksum_protocol, which already
> checks that the packet is IPv6 when testing NETIF_F_IPV6_CSUM.
>=20
You're right, moving this to can_checksum_protocol() makes more sense. I wi=
ll=20
do that, retest and post a new version of the patch.

> > > >  		switch (skb->csum_offset) {
> > > >  		case offsetof(struct tcphdr, check):
> > > >  		case offsetof(struct udphdr, check):
> > > > @@ -3646,6 +3649,7 @@ int skb_csum_hwoffload_help(struct sk_buff *s=
kb,
> > > >  		}
> > > >  	}
> > > >=20
> > > > +sw_checksum:
> > > >  	return skb_checksum_help(skb);
> > > >  }
> > > >  EXPORT_SYMBOL(skb_csum_hwoffload_help);
> > >=20
> >=20
>=20
Thanks for your thorough review!

=2D-=20
Beno=C3=AEt




Return-Path: <netdev+bounces-244629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC83CBBB39
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 14:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 438133005EBD
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 13:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150F925782D;
	Sun, 14 Dec 2025 13:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="eSuPBOwq";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="AcjX1mIs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C4F256C83
	for <netdev@vger.kernel.org>; Sun, 14 Dec 2025 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765719633; cv=none; b=X1VdHePr6OH6BqfYz5+X4K70F5MhnoeqYUGcdPPs7PP2aiF0AKHLIjkunJCl3hnxJPAde4C36qdJHNLR+eK6zVF/3+inKrbZc8ArZlP86cePtM+lHQ0K4wWUrWkR2fqyWksawLCp2bHjd5nNFcxAm/I3zTuo4b7J7Uzpjqs6bJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765719633; c=relaxed/simple;
	bh=y4/gw3q+5vUV2AlNKkMEiUtOK7v4FxUdlWYCuttRNcY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=F0M6aPDN1wmBaNy9c/AJHEB2rqfE9Ex1hXBcTuK2QH27sU+ZPz4+CYobZvaHVWOz9HrXq2CbLHbnhB8TUjp6Zv7qZkZ0nFtJaJpma5knfkLBQXD4UREqesPGHUXJB4irZjW+DGbfEhoGSHILkdEqK/xrDPOzm9N5zfIDvGFLj+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=eSuPBOwq; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=AcjX1mIs; arc=none smtp.client-ip=160.80.4.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 5BEDdljw021250;
	Sun, 14 Dec 2025 14:39:52 +0100
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 24D781205C5;
	Sun, 14 Dec 2025 14:39:43 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1765719583; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UgOq6ObpVzjWvN6aLkDLv1M6UeEfOp9SBk+Qjqyf2u8=;
	b=eSuPBOwqsz2Hwh5A3xXMlmHgpD217jxbVqk7TFQ2Zka/hpJV30EoxsFT6QgOx3lx1Ss9IA
	bQ4T7QgwGchcsgBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1765719583; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UgOq6ObpVzjWvN6aLkDLv1M6UeEfOp9SBk+Qjqyf2u8=;
	b=AcjX1mIs1ktRx6mwspFmIWXh000JVAcFntNC1SjgyoxAiuH6bbO4sUVPlfOJyzMP3ptNUl
	tTjNUPktHhrTlMepBFCuGT4y2V3zoLAIE3tnmd2IQ4TpcGIEEyDq5eZjgWRjOagbDuYoa3
	H8k7UFFITfLPUcttc50GTFOaqMCjjapX1UAjn4TB1EtIjcWiYq3xxOy9Sf9tBVwLYjOmWn
	DN1xlzyyFHeIK2pvx33phDMwPU2E6NK7Ldleu9V1yecZSMeTPjUHfc6Kekb3a7luPeApWi
	2xXHBOoDPBBDXXf+hkyYaK09UEC1kdHh2AmVqHxtlNvjxlTt+/6jN/CWbxa/bQ==
Date: Sun, 14 Dec 2025 14:39:42 +0100
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: nicolas.dichtel@6wind.com
Cc: "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet
 <edumazet@google.com>,
        David Lebrun <david.lebrun@uclouvain.be>,
        Paolo
 Lungaroni <paolo.lungaroni@uniroma2.it>,
        David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
        stefano.salsano@uniroma2.it, Andrea Mayer
 <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net] seg6: fix route leak for encap routes
Message-Id: <20251214143942.ccc2ec1a46ce6a8fcc3ede55@uniroma2.it>
In-Reply-To: <051053d9-65f2-43bf-936b-c12848367acd@6wind.com>
References: <20251208102434.3379379-1-nicolas.dichtel@6wind.com>
	<20251210113745.145c55825034b2fe98522860@uniroma2.it>
	<051053d9-65f2-43bf-936b-c12848367acd@6wind.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Wed, 10 Dec 2025 18:00:39 +0100
Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:

> Le 10/12/2025 =E0 11:37, Andrea Mayer a =E9crit=A0:
> > On Mon,  8 Dec 2025 11:24:34 +0100
> > Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:
> >=20
> >> The goal is to take into account the device used to set up the route.
> >> Before this commit, it was mandatory but ignored. After encapsulation,=
 a
> >> second route lookup is performed using the encapsulated IPv6 address.
> >> This route lookup is now done in the vrf where the route device is set.
> >>
> >=20
> > Hi Nicolas,
> Hi Andrea,
>=20

Hi Nicolas,

> >=20
> > I've got your point. However, I'm still concerned about the implication=
s of
> > using the *dev* field in the root lookup. This field has been ignored f=
or this
> > purpose so far, so some existing configurations/scripts may need to be =
adapted
> > to work again. The adjustments made to the self-tests below show what m=
ight
> > happen.
> Yes, I was wondering how users use this *dev* arg. Maybe adding a new att=
ribute,
> something like SEG6_IPTUNNEL_USE_NH_DEV will avoid any regressions.
>=20

IMHO using a new attribute seems to be a safer approach.

Is this new attribute intended to be used (a) to enable/disable the use of =
*dev*
during the route lookup, or (b) to carry the interface identifier (oif)
explicitly for use in the lookup?
In the latter case (b), the route *dev* would no longer be consulted at all=
 for=20
this purpose.


> >=20
> >=20
> >> The l3vpn tests show the inconsistency; they are updated to reflect the
> >> fix. Before the commit, the route to 'fc00:21:100::6046' was put in the
> >> vrf-100 table while the encap route was pointing to veth0, which is not
> >> associated with a vrf.
> >>
> >> Before:
> >>> $ ip -n rt_2-Rh5GP7 -6 r list vrf vrf-100 | grep fc00:21:100::6046
> >>> cafe::1  encap seg6 mode encap segs 1 [ fc00:21:100::6046 ] dev veth0=
 metric 1024 pref medium
> >>> fc00:21:100::6046 via fd00::1 dev veth0 metric 1024 pref medium
> >>
> >> After:
> >>> $ ip -n rt_2-Rh5GP7 -6 r list vrf vrf-100 | grep fc00:21:100::6046
> >>> cafe::1  encap seg6 mode encap segs 1 [ fc00:21:100::6046 ] dev veth0=
 metric 1024 pref medium
> >>> $ ip -n rt_2-Rh5GP7 -6 r list | grep fc00:21:100::6046
> >>> fc00:21:100::6046 via fd00::1 dev veth0 metric 1024 pref medium
> >>
> >> Fixes: 6c8702c60b88 ("ipv6: sr: add support for SRH encapsulation and =
injection with lwtunnels")
> >> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> >> ---
> >>  net/ipv6/seg6_iptunnel.c                                | 6 ++++++
> >>  tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh | 2 +-
> >>  tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh  | 2 +-
> >>  tools/testing/selftests/net/srv6_end_dt6_l3vpn_test.sh  | 2 +-
> >>  4 files changed, 9 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
> >> index 3e1b9991131a..9535aea28357 100644
> >> --- a/net/ipv6/seg6_iptunnel.c
> >> +++ b/net/ipv6/seg6_iptunnel.c
> >> @@ -484,6 +484,12 @@ static int seg6_input_core(struct net *net, struc=
t sock *sk,
> >>  	 * now and use it later as a comparison.
> >>  	 */
> >>  	lwtst =3D orig_dst->lwtstate;
> >> +	if (orig_dst->dev) {
> >=20
> > When can 'orig_dst->dev' be NULL in this context?
> I was cautious to avoid any unpleasant surprises. A dst can have dst->dev=
 set to
> NULL.
>=20

I see your point regarding caution.

However, if 'orig_dst->dev' were NULL at this point, the kernel would crash
anyway because subsequent functions (e.g., __seg6_do_srh_encap()) rely on
'orig_dst->dev' (not NULL) to retrieve the net.


> >> +		rcu_read_lock();
> >> +		skb->dev =3D l3mdev_master_dev_rcu(orig_dst->dev) ?:
> >> +			dev_net(skb->dev)->loopback_dev;

One issue here is that the outgoing device (*dev*) is being treated as the
packet's *incoming* interface.

ip6_route_input() uses 'skb->dev->ifindex' to populate 'flowi6_iif'.
Consequently, if there is an 'ip rule' matching on 'iif' (ingress interface=
),
it will evaluate against the *dev* (the VRF or the loopback) instead of the
actual interface the packet was received on.
This can lead to incorrect policy routing lookups.


> >> +		rcu_read_unlock();
> >> +	}


> Thanks,
> Nicolas

Thanks,

Ciao,
Andrea


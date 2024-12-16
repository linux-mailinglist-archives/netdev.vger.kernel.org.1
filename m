Return-Path: <netdev+bounces-152357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E099F3971
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 20:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59B8F1623B6
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 19:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB624148314;
	Mon, 16 Dec 2024 19:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+BY8HlL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7992F5B
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 19:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734375696; cv=none; b=ZwRxQp925PBvgf50B52OeMxEK4bks4T3qAjC3HHaUQ6BjyKwnW7FvuOI0H+HDte2GiMza9UCJqVgBIhoRIIMx9S2zvIaBx7WRm+4J0ZliSXba5Jix2OLUAB9lUagDtqviIloa7g4jt25rviMr7w4CPYGmKgWDIJOxFPgOWcJYDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734375696; c=relaxed/simple;
	bh=PEkolkMlFZVncofKCfgLpu98Ga81pzruiRWE92xp8F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDDbW00Kr9C4zC6w/3mLExr1ptJ2cmEYdw7ZIxmlyVYUq78ZmWKxosM42ismemHLPQxDTRBQuUqTTc+mu3escEVrlEvjjnaH/EeuyQ7xJRNvrP+2PEz+ywfcZqiRtV45YZrxYARLwGFZZXaJfHkC/X+tWUk7YQBJxFPEfsqblF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+BY8HlL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71ADC4CED0;
	Mon, 16 Dec 2024 19:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734375696;
	bh=PEkolkMlFZVncofKCfgLpu98Ga81pzruiRWE92xp8F0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V+BY8HlL6r/SjbnRbU1kHgRGN0X6xQg4VBp56IEy3f+KQamDNdWlUFNN+lfp0X4lu
	 XVCcpJZtjgKpHlJ5F46g1dFH62TJc84qDwssji4+YUnES3m3FWwri8A+4X2BG5SUvi
	 6RdP2TlvMh4K7mN2cl6O5g2T/FZchxg3l8JySkJCY++SOmEh9SLzOqZbG5m+dSnbmS
	 TVTj9XosJ5P6BGqai/qoeyORd2uRRqhQsIKMW2u373dsTgdlKSOE0iZ0ua3uYr/T6r
	 O41sl1xlEARQ+/aVb/CEGox875C30oowSx74Z1PlDTG9CgOwIJ73Ft+CEUfc5ojTFk
	 rnEI4UEmxmeZg==
Date: Mon, 16 Dec 2024 20:01:33 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Oleksij Rempel <linux@rempel-privat.de>, netdev@vger.kernel.org,
	andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, nbd@nbd.name,
	sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	lorenzo.bianconi83@gmail.com
Subject: Re: [RFC net-next 0/5] Add ETS and TBF Qdisc offload for Airoha
 EN7581 SoC
Message-ID: <Z2B5DW70Wq1tOIhM@lore-desk>
References: <cover.1733930558.git.lorenzo@kernel.org>
 <20241211154109.dvkihluzdouhtamr@skbuf>
 <Z1qqrVWV84DBZuCn@lore-desk>
 <20241212150613.zhi3vbxuwsc3blui@skbuf>
 <Z1sXTPeekJ5See_u@lore-desk>
 <20241212184647.t5n7t2yynh6ro2mz@skbuf>
 <Z2AYXRy-LjohbxfL@lore-desk>
 <20241216154947.fms254oqcjj72jmx@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RXqgu89OLw6YBm9O"
Content-Disposition: inline
In-Reply-To: <20241216154947.fms254oqcjj72jmx@skbuf>


--RXqgu89OLw6YBm9O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, Dec 16, 2024 at 01:09:01PM +0100, Lorenzo Bianconi wrote:
> > I guess what I did not make clear here is that we are discussing about
> > 'routed' traffic (sorry for that). The traffic is received from the WAN
> > interface and routed to a DSA port (or the other way around).
> > In this scenario the 3-way handshake will be received by the CPU via the
> > WAN port (or the conduit port) while the subsequent packets will be hw
> > forwarded from WAN to LAN (or LAN to WAN). For EN7581 [0], the traffic
> > will be received by the system from GDM2 (WAN) and the PSE/PPE blocks
> > will forward it to the GDM1 port that is connected to the DSA cpu port.
> >=20
> > The proposed series is about adding the control path to apply a given Q=
disc
> > (ETS or TBF for EN7581) to the traffic that is following the described =
path
> > without creating it directly on the DSA switch port (for the reasons de=
scribed
> > before). E.g. the user would want to apply an ETS Qdisc just for traffic
> > egressing via lan0.
> >=20
> > This series is not strictly related to the airoha_eth flowtable offload
> > implementation but the latter is required to have a full pictures of the
> > possible use case (this is why I was saying it is better to post it fir=
st).
>=20
> It's good to know this does not depend on flowtable.
>=20
> When you add an offloaded Qdisc to the egress of a net device, you don't
> affect just the traffic L3 routed to that device, but all traffic (also
> includes the packets sent to it using L2 forwarding). As such, I simply
> don't believe that the way in which the UAPI is interpreted here (root
> egress qdisc matches only routed traffic) is proper.
>=20
> Ack?

Considering patch [0], we are still offloading the Qdisc on the provided
DSA switch port (e.g. LANx) via the port_setup_tc() callback available in
dsa_user_setup_qdisc(), but we are introducing even the ndo_setup_tc_condui=
t()
callback in order to use the hw Qdisc capabilities available on the mac chip
(e.g. EN7581) for the routed traffic from WAN to LANx. We will still apply
the Qdisc defined on LANx for L2 traffic from LANy to LANx. Agree?

>=20
> > > I'm trying to look at the big picture and abstract away the flowtable=
 a
> > > bit. I don't think the tc rule should be on the user port. Can the
> > > redirection of packets destined towards a particular switch port be
> > > accomplished with a tc u32 filter on the conduit interface instead?
> > > If the tc primitives for either the filter or the action don't exist,
> > > maybe those could be added instead? Like DSA keys in "flower" which g=
ain
> > > introspection into the encapsulated packet headers?
> >=20
> > The issue with the current DSA infrastructure is there is no way to use
> > the conduit port to offload a Qdisc policy to a given lan port since we
> > are missing in the APIs the information about what user port we are
> > interested in (this is why I added the new netdev callback).
>=20
> How does the introduction of ndo_setup_tc_conduit() help, since the probl=
em
> is elsewhere? You are not making "tc qdisc add lanN root ets" work correc=
tly.
> It is simply not comparable to the way in which it is offloaded by
> drivers/net/dsa/microchip/ksz_common.c, even though the user space
> syntax is the same. Unless you're suggesting that for ksz it is not
> offloaded correctly?

nope, I am not saying the current Qdisc DSA infrastructure is wrong, it just
does not allow to exploit all hw capabilities available on EN7581 when the
traffic is routed from the WAN port to a given DSA switch port. If we do:

$tc qdisc add dev lan0 root handle 1: ets strict 8 priomap ...

in the current upstream implementation we do:
  dsa_user_setup_tc():
     ...
       -> ds->ops->port_setup_tc(ds, dp->index, type, type_data)
          (it applies the Qdisc on lan0 configuring the hw switch)

adding the ndo_setup_tc_conduit() callback we have:

  dsa_user_setup_qdisc()
    ...
      -> conduit->netdev_ops->ndo_setup_tc_conduit(conduit, dp->index, type=
, type_data)
         (it applies the Qdisc on EN7581 mac chip for the routed traffic de=
stinated to lan0)

      -> ds->ops->port_setup_tc(ds, dp->index, type, type_data)
         (it applies the Qdisc on lan0 configuring the hw switch)

>=20
> Oleksij, am I missing something?
>=20
> > Please consider here we are discussing about Qdisc policies and not flo=
wer
> > rules to mangle the traffic.
>=20
> What's a Qdisc policy?

I mean a queue scheduler algorithm (e.g. TBF, ETS, HTB, ...)

>=20
> Also, flower is a classifier, not an action. It doesn't mangle packets
> by the very definition of what a classifier is.

yes, but goal of the series is the Queue scheduler offloading, not
classifier/action. Agree?

>=20
> > The hw needs to be configured in advance to apply the requested policy
> > (e.g TBF for traffic shaping).
>=20
> What are you missing exactly to make DSA packets go to a particular
> channel on the conduit?
>=20
> For Qdisc offloading you want to configure the NIC in advance, of course.
>=20
> Can't you do something like this to guide packets to the correct channels?
>=20
> tc qdisc add dev eth0 clsact
> tc qdisc add dev eth0 root handle 1: ets strict 8 priomap ...
> tc filter add dev eth0 egress ${u32 or flower filter to match on DSA tagg=
ed packets} \
> 	flowid 1:1

If we apply the Qdisc directly on the conduit port (eth0) we can just apply=
 the
queue scheduler on all the traffic egressing via the DSA switch while I wou=
ld
like to apply it on per DSA port basis (but using the mac chip hw capabilit=
ies),
got my point?

Regards,
Lorenzo

[0] https://patchwork.kernel.org/project/netdevbpf/patch/8e57ae3c4b064403ca=
843ffa45a5eb4e4198cf80.1733930558.git.lorenzo@kernel.org/

--RXqgu89OLw6YBm9O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ2B5DQAKCRA6cBh0uS2t
rJQqAQD5nHji0N2GtbJhwpUmDnHxg0zclMKG2PHnC+dhfhbMEAEA5ZWqZJwJGiRY
l82xcEC5GsTYI9m7ht+t+63yzfp4nQk=
=R5w1
-----END PGP SIGNATURE-----

--RXqgu89OLw6YBm9O--


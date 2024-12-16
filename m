Return-Path: <netdev+bounces-152181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0499F3019
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 13:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42986188316F
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 12:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14D920459A;
	Mon, 16 Dec 2024 12:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUAjRbRI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A99E38FA6
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 12:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734350944; cv=none; b=egEzuCcbB0FC09cQ1JQooqbCcQrriN/F3upGPgKfPwpW0TIRJ4l2WyJCkU8hIdcJxciAB0/VElBlV4mQrnav9yrzk1mWo+ctpOHSs10Sl1nyYP0DXO/BOmgYJuYQ94v+hA7Kji535gkLZ8GgnBs8HQwfwU/ORpWHML3yUK8db9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734350944; c=relaxed/simple;
	bh=NvT9qeS8rdRRygfFMeVcBLUhj9fFyA9StbpSggcgn4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbfRFcI2cl0+SayhcxCFG0oUzNTWPKxae4+6f9j+LCeqzLV/ZC9ymqZQoOqoK0UdAaUvk7xPC6vwi3jsXH5OBAtVcEzuf8tpC9mJIA8I7ha2eYdmfrp4fd7RP9iV5nLfe3p3SpGuY9SeZW9DA4wpHJvv/BDUbSBpiEJVByu2vzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUAjRbRI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C2BC4CED0;
	Mon, 16 Dec 2024 12:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734350944;
	bh=NvT9qeS8rdRRygfFMeVcBLUhj9fFyA9StbpSggcgn4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JUAjRbRIlS8wVKc6SP0LW23hTE7pDnYqceFYUEDBd38ebSAZ0gWl0ilTuvS6Afg8L
	 N2ZwOEnVWwIfDW102jUyhF2GN5v1zZfTm482lXcdfntq7sYG9WWQU9fBmQf5QxKT2X
	 k3qn4X7vo4LvRAW5pu7hV4WAlycm30pGWrmzaDciP/BSayeDDoHxbivHg7mPzxtN2y
	 UBC61rz04qmQ6KvFt4r9705WhXBXZR1h/aMY+L0IwfENTghF1Evx5az/oxiHc5A6PY
	 kl0L7XGLy6DtXbxzK7h7q+ml60BEbbt/ZT4HiINsM2mrn5xouzJfnjkhwhCAwYfV3w
	 YtP5CKknd2mvg==
Date: Mon, 16 Dec 2024 13:09:01 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, nbd@nbd.name, sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com, lorenzo.bianconi83@gmail.com
Subject: Re: [RFC net-next 0/5] Add ETS and TBF Qdisc offload for Airoha
 EN7581 SoC
Message-ID: <Z2AYXRy-LjohbxfL@lore-desk>
References: <cover.1733930558.git.lorenzo@kernel.org>
 <20241211154109.dvkihluzdouhtamr@skbuf>
 <Z1qqrVWV84DBZuCn@lore-desk>
 <20241212150613.zhi3vbxuwsc3blui@skbuf>
 <Z1sXTPeekJ5See_u@lore-desk>
 <20241212184647.t5n7t2yynh6ro2mz@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9z+PDC61Tt4YZqkq"
Content-Disposition: inline
In-Reply-To: <20241212184647.t5n7t2yynh6ro2mz@skbuf>


--9z+PDC61Tt4YZqkq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, Dec 12, 2024 at 06:03:08PM +0100, Lorenzo Bianconi wrote:
> > > Explain "the mac chip forwards (in hw) the WAN traffic to the DSA swi=
tch
> > > via the CPU port". How many packets does airoha_dev_select_queue() se=
e?
> > > All of them, or only the first of a flow? What operations does the
> > > offload consist of?
> >=20
> > I am referring to the netfilter flowtable offload where the kernel rece=
ives
> > just the 3-way handshake of a TCP connection and then the traffic is fu=
lly
> > offloaded (the hw receives a flower rule to route the traffic between
> > interfaces applying NAT mangling if requested).

Hi Vladimir,

Sorry for the late reply.

>=20
> And how do the follow-up packets know to go to the same conduit queue as
> the initial packets of the flow?
>=20
> As mentioned, my trouble with your current proposal is that I don't
> think it reacts adequately to the user space request. Given your command,
> packets forwarded from lan1 to lan0 should also go through lan0's ETS
> scheduler, but my understanding is that they won't, because they bypass
> the conduit. I don't encourage adding new net_device_ops infrastructure
> to implement unexpected behavior.

I guess what I did not make clear here is that we are discussing about
'routed' traffic (sorry for that). The traffic is received from the WAN
interface and routed to a DSA port (or the other way around).
In this scenario the 3-way handshake will be received by the CPU via the
WAN port (or the conduit port) while the subsequent packets will be hw
forwarded from WAN to LAN (or LAN to WAN). For EN7581 [0], the traffic
will be received by the system from GDM2 (WAN) and the PSE/PPE blocks
will forward it to the GDM1 port that is connected to the DSA cpu port.

The proposed series is about adding the control path to apply a given Qdisc
(ETS or TBF for EN7581) to the traffic that is following the described path
without creating it directly on the DSA switch port (for the reasons descri=
bed
before). E.g. the user would want to apply an ETS Qdisc just for traffic
egressing via lan0.

This series is not strictly related to the airoha_eth flowtable offload
implementation but the latter is required to have a full pictures of the
possible use case (this is why I was saying it is better to post it first).

>=20
> I'm trying to look at the big picture and abstract away the flowtable a
> bit. I don't think the tc rule should be on the user port. Can the
> redirection of packets destined towards a particular switch port be
> accomplished with a tc u32 filter on the conduit interface instead?
> If the tc primitives for either the filter or the action don't exist,
> maybe those could be added instead? Like DSA keys in "flower" which gain
> introspection into the encapsulated packet headers?

The issue with the current DSA infrastructure is there is no way to use
the conduit port to offload a Qdisc policy to a given lan port since we
are missing in the APIs the information about what user port we are
interested in (this is why I added the new netdev callback).
Please consider here we are discussing about Qdisc policies and not flower
rules to mangle the traffic. The hw needs to be configured in advance to ap=
ply
the requested policy (e.g TBF for traffic shaping).

>=20
> > Re-thinking about it, I guess it is better to post flowtable support
> > first and then continue the discussion about QoS offloading, what do
> > you think?
>=20
> I don't know about Andrew, but I'm really not familiar with the
> netfilter flowtable (and there's another series from Eric Woudstra
> waiting for me to know everything about it).
>=20
> Though, I don't think this can continue for long, we need to find a
> common starting place for discussions, since the development for chips
> with flowtable offload is starting to put pressure on DSA. What to read
> as a starting point for a basic understanding?

I do not think there is much documentation about it (except the source code=
).
I guess you can take a look to [1],[2].

Regards,
Lorenzo

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D23020f04932701d5c8363e60756f12b43b8ed752
[1] https://docs.kernel.org/networking/nf_flowtable.html
[2] https://thermalcircle.de/doku.php?id=3Dblog:linux:flowtables_1_a_netfil=
ter_nftables_fastpath

--9z+PDC61Tt4YZqkq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ2AYXQAKCRA6cBh0uS2t
rI2fAQC/7oYH2QeBJJIN/hte6cB0S7mGFi9AAfOMqOFticUhQwD+PE9flU17rfEv
muUdtkVXcXrNmSTBIthSi4oOfNN60AM=
=YmdI
-----END PGP SIGNATURE-----

--9z+PDC61Tt4YZqkq--


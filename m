Return-Path: <netdev+bounces-152537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8D99F483F
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 11:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 472FA1882E93
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 10:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC92C1DC747;
	Tue, 17 Dec 2024 10:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ht9zZ9AV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A3E1D1E74
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 10:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734429691; cv=none; b=JXBzG9EQ2N+W90t8gndJpmCwY/Na7MyBb9jNkBfNNrixX4KP/CHir/x5BexqcHO7pG4bFrz7rfaRmNR6gGqRNVk+ZfFJ1TWuEzqKnL8d5gNQYaZENXWf9TekAGbpGhw0mofGMAyLIEfG4rUvNSSVtetDq2zjRM141YIX3C9U/a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734429691; c=relaxed/simple;
	bh=znx75QO08E5c7zjmyuZyLOt4uuIsS0LJcaGOYD3tjDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGfh4SgcHEDbRm/lpajp2POkrfCVCEhpAmFaCdzyhM5uctpthyu4kPmLJxhO5qtzckD3teNh/bjys3JenzY8ko9xnbCimuluRmetpiH/LvQM71x1vwro4+P3UELqsFk9cdjKi3OfvL/pRAaFyiY7y45J4zK0ndUzMqHi6EIwGw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ht9zZ9AV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4535C4CED3;
	Tue, 17 Dec 2024 10:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734429691;
	bh=znx75QO08E5c7zjmyuZyLOt4uuIsS0LJcaGOYD3tjDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ht9zZ9AV3gmL4R0+XIsPxvTZS7CirHjgJtq/PG0/AH2i4dBYLVSrcOKbUvVgUlemh
	 sxCWbNVdOcHLoPWMwqT0UnOPCHhwV+YLhVDzgfsTIscZBl9Djq6kOOgaO5nteVqLV4
	 sJF3/dUOk8WUazOls9tO5F9h8t5eHOyD+lmmJgUyLPpCw9tTeVET6hFICZojQ5josg
	 iTRK6D0hJELTcR3IIgNcOpTZZ/R15hr/CWd7vAF7MEcsHan7ND4ZfQwCaG6O2Q3puf
	 8zVZpEXvBMJHn0e1VJhE87XAJa+1kUDSZxZR6ZtmRpnHbUPriSvx9FdXVIjXqzxKaa
	 ITjVxR6w/xukg==
Date: Tue, 17 Dec 2024 11:01:28 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
	Oleksij Rempel <linux@rempel-privat.de>, netdev@vger.kernel.org,
	andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, nbd@nbd.name,
	sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	lorenzo.bianconi83@gmail.com
Subject: Re: [RFC net-next 0/5] Add ETS and TBF Qdisc offload for Airoha
 EN7581 SoC
Message-ID: <Z2FL-IcDLHXV-WCU@lore-desk>
References: <Z1sXTPeekJ5See_u@lore-desk>
 <20241212184647.t5n7t2yynh6ro2mz@skbuf>
 <Z2AYXRy-LjohbxfL@lore-desk>
 <20241216154947.fms254oqcjj72jmx@skbuf>
 <Z2B5DW70Wq1tOIhM@lore-desk>
 <20241216194641.b7altsgtjjuloslx@skbuf>
 <Z2CpgqpIR5_MXTO7@lore-desk>
 <20241216231311.odozs4eki7bbagwp@skbuf>
 <Z2FAUuOh4jrA0uGu@lore-desk>
 <20241217093040.x4yangwss2xa5lbz@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/PdKOp1lvndNLBiR"
Content-Disposition: inline
In-Reply-To: <20241217093040.x4yangwss2xa5lbz@skbuf>


--/PdKOp1lvndNLBiR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, Dec 17, 2024 at 10:11:46AM +0100, Lorenzo Bianconi wrote:
> > > When you add an offloaded Qdisc to the egress of lan1, the expectation
> > > is that packets from lan2 obey it too (offloaded tc goes hand in hand
> > > with offloaded bridge). Whereas, by using GDM1/QDMA resources, you are
> > > breaking that expectation, because packets from lan2 bridged by MT7530
> > > don't go to GDM1 (the "x").
> >=20
> > ack, I got your point. I was assuming to cover this case (traffic from =
lan2 to
> > lan1) maintaining the port_setup_tc() callback in dsa_user_setup_qdisc(=
) (this
> > traffic is not managed by ndo_setup_tc_conduit() callback). If this app=
roach is
> > not ok, I guess we will need to revisit the approach.
>=20
> To offload QoS on the egress of a DSA user port:
>=20
> port_setup_tc() is:
> (a) necessary
> (b) sufficient
>=20
> ndo_setup_tc_conduit() is:
> (a) unnecessary

I agree it is unnecessary, but w/o it we must rely on limited QoS capabilit=
ies
of the hw dsa switch. The goal of the series is just exploit enhanced QoS
capabilities available on the EN7581 SoC.

> (b) insufficient
>=20
> > > But you call it a MAC chip because between the GDM1 and the MT7530 th=
ere's
> > > an in-chip Ethernet MAC (GMII netlist), with a fixed packet rate, rig=
ht?
> >=20
> > With "mac chip" I mean the set of PSE/PPE and QDMA blocks in the diagram
> > (what is managed by airoha_eth driver). There is no other chip in betwe=
en
> > of GDM1 and MT7530 switch (sorry for the confusion).
>=20
> The MT7530 is also on the same chip as the GDM1, correct?

I think so, but I am not sure.

>=20
> > > I'm asking again, are the channels completely independent of one anot=
her,
> > > or are they consuming shared bandwidth in a way that with your propos=
al
> > > is just not visible? If there is a GMII between the GDM1 and the MT75=
30,
> > > how come the bandwidth between the channels is not shared in any way?
> >=20
> > Channels are logically independent.
>=20
> "Logically independent" does not mean "does not share resources", which
> is what I asked.
>=20
> > GDM1 is connected to the MT7530 switch via a fixed speed link (10Gbps, =
similar
> > to what we have for other MediaTek chipset, like MT7988 [0]). The fixed=
 link speed
> > is higher than the sum of DSA port link speeds (on my development board=
s I have
> > 4 DSA ports @ 1Gbps);
>=20
> And this fixed connection is a pair of internal Ethernet MACs, correct?

yes

> I see on MT7988 we do have the "pause" property, which would suggest so,
> since flow control is a MAC level feature. I assume 10 Gbps in the
> device tree means it is an XGMII really limited at that speed, and that
> speed is not just for phylink compliance, right?

I think so

>=20
> What if we push your example to the extreme, and say that the DSA user
> ports also have 10 Gbps links? How independent are the QDMA channels in
> this case? What arbitration algorithm will be used for QoS among user
> ports, when the combined bandwidth exceeds the CPU port capacity?

AFIR there is even the possibility to configure inter-channel QoS on the ch=
ip,
like a Round Robin scheduler or Strict-Priority between channels.

Regards,
Lorenzo

--/PdKOp1lvndNLBiR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ2FL+AAKCRA6cBh0uS2t
rMPkAPwIVnjFVjRW1JNH0RbpQKJHWmmpBYc3thC+MA1sVKQwBwD9Go4iB+JYpsBt
F+RrVhO71gLeqAowtDRrGtritBNCWg8=
=e5hP
-----END PGP SIGNATURE-----

--/PdKOp1lvndNLBiR--


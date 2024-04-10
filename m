Return-Path: <netdev+bounces-86638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE1289FAD6
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 16:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F64285456
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 14:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2469B16F91F;
	Wed, 10 Apr 2024 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHVjYrAi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0099F16F8EE
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712761067; cv=none; b=eeAIBSOhu1dme8C9qC/+atPMprZDwM2w44j20r3FU5sPUIREJNmVByYlJ1/A3C0IaRUttMO+1u/1VAnPUt0JeddvizX5gq+cVPje7seEclqA3j1mhZAIpBSpps1GDnmu+659Jz9N6Ohb8xl6FoBXhTx/QfDeOPS393uGHVVlG7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712761067; c=relaxed/simple;
	bh=xepD0fp+VG51zxZqh2o3bDOQkyIM4tTn4rBxnhYH+L0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eP6fpPAYyLgG3frt9e/G7jdqeE0j5rTsOEoGrASCd10m5fK7TjAvUmdKuKtVvf1S+nVJiLjP6NfSDChpjXpUe3CLlUUInDXV3mAkpBAe2HxXOd2HjAsZeoPiU3H3ylyGf8JjNSnOAOOdaUKg/tLaJ3u8H+GEuBMfiqid2Mt9wqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHVjYrAi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A193C433C7;
	Wed, 10 Apr 2024 14:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712761066;
	bh=xepD0fp+VG51zxZqh2o3bDOQkyIM4tTn4rBxnhYH+L0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LHVjYrAiDjtGiGr5TO4l2/eb3OcJ2RJxQlIo2EYWssUimpWTj3K/2KEdZpSoojBLB
	 9WzYMtW5v5dEYpjSQUJnjZRxaiO7n3vuYHUXzJAOEtt3wFwp7HDEezM5mrD14RmQvP
	 1g7rT/fhv6ITCY9kwZ0mR8o4wrdOqYharrAdHFUse4izwETcoHLOTtCUoKUJ99j+yZ
	 iXuQdQ48wYqNVvkIoQrnRl/09xBrWojSy4WPDE5p4AT/02e9yKKT4tjrqZsFlj9c1j
	 VIOl7EEzTbi/rfNpKIRQFVbTwX4lH7hI7h+3A0QCPQWWB9r0AxgStV8QOt1UObkRZR
	 Kqyz5NOcV8njw==
Date: Wed, 10 Apr 2024 07:57:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, Jiri Pirko
 <jiri@resnulli.us>, Madhu Chittim  <madhu.chittim@intel.com>, Sridhar
 Samudrala <sridhar.samudrala@intel.com>
Subject: Re: [RFC] HW TX Rate Limiting Driver API
Message-ID: <20240410075745.4637c537@kernel.org>
In-Reply-To: <91451f2da3dcd70de3138975ad7d21f0548e19c9.camel@redhat.com>
References: <20240405102313.GA310894@kernel.org>
	<20240409153250.574369e4@kernel.org>
	<91451f2da3dcd70de3138975ad7d21f0548e19c9.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Apr 2024 10:33:50 +0200 Paolo Abeni wrote:
> On Tue, 2024-04-09 at 15:32 -0700, Jakub Kicinski wrote:
> > On Fri, 5 Apr 2024 11:23:13 +0100 Simon Horman wrote: =20
> > > /**
> > >  * enum shaper_lookup_mode - Lookup method used to access a shaper
> > >  * @SHAPER_LOOKUP_BY_PORT: The root shaper for the whole H/W, @id is =
unused
> > >  * @SHAPER_LOOKUP_BY_NETDEV: The main shaper for the given network de=
vice,
> > >  *                           @id is unused
> > >  * @SHAPER_LOOKUP_BY_VF: @id is a virtual function number.
> > >  * @SHAPER_LOOKUP_BY_QUEUE: @id is a queue identifier.
> > >  * @SHAPER_LOOKUP_BY_TREE_ID: @id is the unique shaper identifier ins=
ide the
> > >  *                            shaper hierarchy as in shaper_info.id
> > >  *
> > >  * SHAPER_LOOKUP_BY_PORT and SHAPER_LOOKUP_BY_VF, SHAPER_LOOKUP_BY_TR=
EE_ID are
> > >  * only available on PF devices, usually inside the host/hypervisor.
> > >  * SHAPER_LOOKUP_BY_NETDEV is available on both PFs and VFs devices, =
but
> > >  * only if the latter are privileged ones. =20
> >=20
> > The privileged part is an implementation limitation.=C2=A0
> > Limiting oneself
> > or subqueues should not require elevated privileges, in principle,
> > right? =20
>=20
> The reference to privileged functions is here to try to ensure proper
> isolation when required.
>=20
> E.g. Let's suppose the admin in the the host wants to restricts/limits
> the B/W for a given VF (the VF itself, not the representor! See below
> WRT shaper_lookup_mode) to some rate, he/she likely wants intends
> additionally preventing the guest from relaxing the setting configuring
> the such rate on the guest device.

1) representor is just a control path manifestation of the VF
   any offload on the representor is for the VF - this is how forwarding
   works, this is how "switchdev qdisc offload" works

2) its a hierarchy, we can delegate one layer to the VF and the layer
   under that to the eswitch manager. VF can set it limit to inf
   but the eswitch layer should still enforce its limit
   The driver implementation may constrain the number of layers,
   delegation or form of the hierarchy, sure, but as I said, that's an
   implementation limitation (which reminds me -- remember to add extack=20
   to the "write" ops)

> > > enum shaper_lookup_mode {
> > >     SHAPER_LOOKUP_BY_PORT,
> > >     SHAPER_LOOKUP_BY_NETDEV,
> > >     SHAPER_LOOKUP_BY_VF,
> > >     SHAPER_LOOKUP_BY_QUEUE,
> > >     SHAPER_LOOKUP_BY_TREE_ID, =20
> >=20
> > Two questions.
> >=20
> > 1) are these looking up real nodes or some special kind of node which
> > can't have settings assigned directly?=C2=A0
> > IOW if I want to rate limit=20
> > the port do I get + set the port object or create a node above it and
> > link it up? =20
>=20
> There is no concept of such special kind of nodes. Probably the above
> enum needs a better/clearer definition of each element.
> How to reach a specific configuration for the port shaper depends on
> the NIC defaults - whatever hierarchy it provides/creates at
> initialization time.=C2=A0
>=20
> The NIC/firmware can either provide a default shaper for the port level
> - in such case the user/admin just need to set it. Otherwise user/admin
> will have to create the shaper and link it.

What's a default limit for a port? Line rate?
I understand that the scheduler can't be "disabled" but that doesn't mean
we must expose "noop" schedulers as if user has created them.

Let me step back. The goal, AFAIU, was to create an internal API into
which we can render existing APIs. We can combine settings from mqprio
and sysfs etc. and create a desired abstract hierarchy to present to=20
the driver. That's doable.
Transforming arbitrary pre-existing driver hierarchy to achieve what
the uAPI wants.. would be an NP hard problem, no?

> I guess the first option should be more common/the expected one.
>=20
> This proposal allows both cases.
>=20
> > Or do those special nodes not exit implicitly (from the example it
> > seems like they do?) =20

s/exit/exist/
=20
> Could you please re-phrase the above?

Basically whether dump of the hierarchy is empty at the start.

> > 2) the objects themselves seem rather different. I'm guessing we need
> > port/netdev/vf because either some users don't want to use switchdev
> > (vf =3D repr netdev) or drivers don't implement it "correctly" (port !=
=3D
> > netdev?!)? =20
>=20
> Yes, the nodes inside the hierarchy can be linked to very different
> objects. The different lookup mode are there just to provide easy
> access to relevant objects.
>=20
> Likely a much better description is needed:  'port' here is really the
> cable plug level, 'netdev' refers to the Linux network device. There
> could be multiple netdev for the same port as 'netdev' could be either
> referring to a PF or a VFs. Finally VF is really the virtual function
> device, not the representor, so that the host can configure/limits the
> guest tx rate.=20
>=20
> The same shaper can be reached/looked-up with different ids.
>=20
> e.g. the device level shaper for a virtual function can be reached
> with:
>=20
> - SHAPER_LOOKUP_BY_TREE_ID + unique tree id (every node is reachable
> this way) from any host device in the same hierarcy
> - SHAPER_LOOKUP_BY_VF + virtual function id, from the host PF device
> - SHAPER_LOOKUP_BY_NETDEV, from the guest VF device
>=20
> > Also feels like some of these are root nodes, some are leaf nodes? =20
>=20
> There is a single root node (the port's parent), possibly many internal
> nodes (port, netdev, vf, possibly more intermediate levels depending on
> the actual configuration [e.g. the firmware or the admin could create
> 'device groups' or 'queue groups']) and likely many leave nodes (queue
> level).
>=20
> My personal take is than from an API point of view differentiating
> between leaves and internal nodes makes the API more complex with no
> practical advantage for the API users.

If you allow them to be configured.

What if we consider netdev/queue node as "exit points" of the tree,=20
to which a layer of actual scheduling nodes can be attached, rather=20
than doing scheduling by themselves?

> > > 	int (*get)(struct net_device *dev,
> > > 		   enum shaper_lookup_mode lookup_mode, u32 id,
> > >                    struct shaper_info *shaper, struct netlink_ext_ack=
 *extack); =20
> >=20
> > How about we store the hierarchy in the core?
> > Assume core has the source of truth, no need to get? =20
>=20
> One design choice was _not_ duplicating the hierarchy in the core: the
> full hierarchy is maintained only by the NIC/firmware.=C2=A0The NIC/firmw=
are
> can perform some changes "automatically" e.g. when adding or deleting
> VFs or queues it will likely create/delete the paired shaper. The
> synchronization looks cumbersome and error prone.

The core only needs to maintain the hierarchy of whats in its domain of
control.

> The hierarchy could be exposed to both host and guests, I guess only
> the host core could be the source of truth, right?

I guess you're saying that the VF configuration may be implemented by askin=
g=20
the PF driver to perform the actions? Perhaps we can let the driver allocate
and maintain its own hierarchy but yes, we don't have much gain from holding
that in the core.

This is the picture in my mind:

PF / eswitch domain

              Q0 ]-> [50G] | RR | >-[ PF netdev =3D pf repr ] - |
              Q1 ]-> [50G] |    |                             |
                                                              |
-----------------------------------------                     |
VF1 domain                               |                    |
                                         |                    |
     Q0 ]-> | RR | - [35G] >-[ VF netdev x vf repr ]-> [50G]- | RR | >- port
     Q1 ]-> |    |                       |                    |
                                         |                    |
-----------------------------------------                     |
                                                              |
-------------------------------------------                   |
VF2 domain                                 |                  |
                                           |                  |
     Q0 ]-> [100G] -> |0 SP | >-[ VF net.. x vf r ]-> [50G] - |
     Q1 ]-> [200G] -> |1    |              |                  |
-------------------------------------------

In this contrived example we have VF1 which limited itself to 35G.
VF2 limited each queue to 100G and 200G (ignored, eswitch limit is lower)
and set strict priority between queues.
PF limits each of its queues, and VFs to 50G, no rate limit on the port.

"x" means we cross domains, "=3D" purely splices one hierarchy with another.

The hierarchy for netdevs always starts with a queue and ends in a netdev.
The hierarchy for eswitch has just netdevs at each end (hierarchy is
shared by all netdevs with the same switchdev id).

If the eswitch implementation is not capable of having a proper repr for PFs
the PF queues feed directly into the port.

The final RR node may be implicit (if hierarchy has loose ends, the are
assumed to RR at the last possible point before egress).


Return-Path: <netdev+bounces-184280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D52BDA942FE
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 12:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA4F017DCB3
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 10:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8701C84D7;
	Sat, 19 Apr 2025 10:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhkEjXLh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E841172A;
	Sat, 19 Apr 2025 10:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745059943; cv=none; b=mfeexLK+4Xz5xIfvDnd05JJVMD2nM4izYFPA5wFkW6iQQ33g01rdFJpxfZuK63vks3C2fTuYXVx1ZnmK0n+VdBf72Thvq7m0503LiN9Pbif8Sgk7q6THAXdobRjPla6TSQaMUosJTuwt2WUAc2pl2J+26yJYlfVcF/e179vSlLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745059943; c=relaxed/simple;
	bh=JE6SyHfvTXBUJhE0U+Gn1/w/BjrhTEg6jteZii8ZPCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qIFODJJo2giGb8cjAySv16FKkEdhem5t5j08xUFCKSh+YD0TOTsGwHGOovhPOjmh6CwRVckeFN9GMfntK0/dY9zo0//5thLW1eTfK1u57iEyTacMTOmt30fO3HG0OsmRVeZUlldvt4Y+RrxuKYQEGzY0hy7iuN285urIqGsS9yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhkEjXLh; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e7299e3ab5cso1108085276.1;
        Sat, 19 Apr 2025 03:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745059940; x=1745664740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JE6SyHfvTXBUJhE0U+Gn1/w/BjrhTEg6jteZii8ZPCQ=;
        b=ZhkEjXLh+R39ffFZ6H2p4oVHIu5FWHmYUmo/lOMf3h4dnajhl7KzIZ9PCN4u9yG3CY
         KZ+/IYbUPANtKQWcyo0MQcED/sGbF+V9F3kOVbjhtljhFoSQrnFeMmBRkEzNAa2OrRXR
         8Up+FnjtSMEBAArQIqUBEmwDVby36vPZPlqvDfIWPYz3E695EBuPMxk2p76ehwPEb858
         nld71gHl19w0idGTtkqbDA6tDfCp3DxMAm2jAkN2goe83NdyQ2VotHRIofSb5mRtcefa
         Y2dKIjhMjELtHqRkIQw5umUQsu3rPVCXYlQidmWwbu7wLgY3B9oMt6NCKYx/oAuPyUXL
         wEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745059940; x=1745664740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JE6SyHfvTXBUJhE0U+Gn1/w/BjrhTEg6jteZii8ZPCQ=;
        b=GxkTXzKU8hAAACIVUvoa+z/Gosi7LKoE797uthmsYw0CB4IPfPCb9SCNJIkw5CkpND
         xBziMzWxhJW8HKpMQ7eqHnOUKw5prHB6N3Q9+rOyATPPr9KntTzb2QrcfAVj71t3gIYY
         BNCGjiUu+Yjckz8pNVppLClgfVwtmghycMVf7RwQzoYb7hPKz3fYA2b+1va0sMsyEsTt
         vxlbJiPlQ0s+9DvKIXcCUXPsYVyLOlyu/Q9cB5mOHuKm9hGTe2YO/WNRil0+nVW5rf9x
         9z2/79GWxGqPH9rAsonr9YRDNcwKZoAHbt+KOVWQ1Fo8Ie+1VQy2N9araq9ya4Ed6HVc
         a1lw==
X-Forwarded-Encrypted: i=1; AJvYcCVGR942Fjp7nb5op+4kkShQ1wJfXKTk+RJCjnZb22n2h2BGeIQSNufUsyDZSHqJuZgXNB2/o2sh@vger.kernel.org, AJvYcCXe6rhXm4feZXhk5ndhx1UQCZO6xPozIeZCMgqwSgETmzlv14WSrJRbFakHVXgcDSU6YEdJGFQwoDR13e8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwL0dENyisGA1XNOHvjG5K5tc693k8fJFHei5t6a9zN9fnZbqh
	JBvL3zmFIxmu5FTfsbAuhe7qPneBgfTsrHx64umtdA8Al36J6KtpBh01HHJB8UD8QbDjUHHbAOx
	NywTOPnCiIHeGfatj9Hntfvu1aTA=
X-Gm-Gg: ASbGncsNIhL5GNHs+VXNXnReB5pZZu0bwb1yeyok81MwjtnWCgCoF0neDEurrl9zGjH
	L1MF/qo0K/EuJFpkgLw+O0rOv00ZnKzf+RYkMFOjmuZOF4PaQJjnZczsI8cREEfOhBpadbgACUq
	XceaP+7tP9nHnjgQxi/R6G
X-Google-Smtp-Source: AGHT+IHUHFzNiDgMPDpxv9TuY5D3bcHfp9XMWgxUQjX/9sOG7AZK8386yiF1x26ijt9I39xxeR0XO34JWXcQl+4NojQ=
X-Received: by 2002:a05:6902:2849:b0:e6d:f0a6:4cc5 with SMTP id
 3f1490d57ef6-e7297d8fdf6mr7674807276.1.1745059940508; Sat, 19 Apr 2025
 03:52:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250412122428.108029-3-jonas.gorski@gmail.com>
 <20250414124930.j435ccohw3lna4ig@skbuf> <20250414125248.55kdsbjfllz4jjed@skbuf>
 <CAOiHx==VEbdn3ULHXf5FEBaNAxzyoHTqJEMYYtcQzjkj__RoLg@mail.gmail.com> <20250414150743.zku6yhs7x3sthn55@skbuf>
In-Reply-To: <20250414150743.zku6yhs7x3sthn55@skbuf>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Sat, 19 Apr 2025 12:52:09 +0200
X-Gm-Features: ATxdqUEO6GX3y2UGig927IaHJd35FOjD2beiBfXDJ-TXkZR5Sjv0TwynMOPrIyc
Message-ID: <CAOiHx==Wk8b43x8HLX4i-o696LioqeHoTpM+kzwn+NBE7dV8wg@mail.gmail.com>
Subject: Re: [PATCH RFC net 2/2] net: dsa: propagate brentry flag changes
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, bridge@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 5:07=E2=80=AFPM Vladimir Oltean <vladimir.oltean@nx=
p.com> wrote:
>
> On Mon, Apr 14, 2025 at 03:49:27PM +0200, Jonas Gorski wrote:
> > I was just in the progress of writing down some thoughts myself I had
> > while thinking about this.
> >
> > So to me passing on the original flags but then no updates of these
> > flags feels wrong. I would expect them to be either never passed on,
> > or always sync it (and let the driver choose to handle or ignore
> > them).
>
> Maybe, but right now it seems like the wrong problem to tackle, and it
> is probably so for every driver for which the VLAN information in the
> receive traffic depends on the bridge VLAN configuration, and is not
> statically configured by the driver.
>
> > Having the cpu port as egress untagged I can easily find one case
> > where this breaks stuff (at least with b53):
> >
> > With lan1, lan2 being dsa ports of the same switch:
> >
> > # bridge with lan1
> > $ ip link add swbridge type bridge vlan_filtering 1
> > $ ip link set lan1 master swbridge
> > $ bridge vlan add dev swbridge vid 10 self pvid untagged
> >
> > # lan2 stand alone
> > $ ip link add lan2.10 link lan2 type vlan id 10
> >
> > as then lan2.10 would never receive any packets, as the VLAN 10
> > packets received by the CPU ports never carry any vlan tags.
> >
> > The core issue here is that b53 switches do not provide any way of
> > knowing the original tagged state of received packets, as the dsa
> > header has no field for that (bcm56* switches do, but these are a
> > different beast).
>
> I see, and indeed, this is yet another angle. The flags of the host
> bridge VLAN do not match with the flags of the flags of the RX filtering
> VLAN, the latter having this comment: "This API only allows programming
> tagged, non-PVID VIDs". The update of flags would not be propagated to
> the driver, neither with your patch nor without it, because VID=3D10
> already exists on the CPU port, and this isn't a "changed" VLAN (because
> it is an artificial switchdev event emitted by DSA, unbeknownst to the
> bridge). So DSA would still decide to bump the refcount rather than
> notify the driver.
>
> You'd have to ask yourself how do you even expect DSA to react and sort
> this out, between the bridge direction wanting the VLAN untagged and the
> 8021q direction wanting it tagged.

Unless the switch chip supports passing frames as is to the cpu port
(and only there), the only winning move is likely to keep the cpu port
tagged in all cases, and untag in software as needed. I guess this is
what untag_vlan_aware_bridge_pvid is for.

As a side note, b53 datasheets state that all vlans are always tagged
on egress and ignore the untag map for the management port, but that
is clearly not the case for most devices lol.

I am still a bit confused by untag_bridge_pvid, or more specifically
dsa_software_untag_vlan_unaware_bridge(). I would have expected a non
vlan_filtering bridge to ignore any vlan configuration, including
PVID. Or rather the PVID is implicit by a port being bridged with vlan
uppers of a certain vid (e.g. port1.10 + port2 =3D> port2 has PVID 10),
but not explicitly via the bridge vlan configuration.

> > I guess the proper fix for b53 is probably to always have a vlan tag
> > on the cpu port (except for the special vlan 0 for untagged traffic on
> > ports with no PVID), and enable untag_vlan_aware_bridge_pvid.
>
> What's the story with the ports with no PVID, and VID 0?
> In Documentation/networking/switchdev.rst, it is said that VLAN
> filtering bridge ports should drop untagged and VID 0 tagged RX packets
> when there is no pvid.

Hm, that's not what the code does:

With a vlan_filtering bridge VID 0 always gets added to bridge ports
if they get set up:

The order is:

1. filtering is enabled on the port =3D> NETIF_F_HW_VLAN_CTAG_FILTER is set
2. on if up, vlan_device_event() sees that NETIF_F_HW_VLAN_CTAG_FILTER
is enabled and calls vlan_vid_add(dev, .., 0)
3. switchdev/dsa passes this on to the dsa driver via port_vlan_add()
4. all bridge ports being up are now members of vlan 0/have vlan 0 enabled.

Not sure if this is intended/expected behavior, but this enables
untagged rx at least with b53. And since b53 can't restrict forwarding
on a per-vlan base, likely enables forwarding between all bridge ports
for untagged traffic (until a PVID vlan is configured on the bridge,
then the untagged traffic is moved to a different port). This part is
likely not intended.

My first guess was that this is intentional to allow STP & co to work
regardless if there is a PVID/egress untagged VLAN configured. Though
this will likely also require preventing of forwarding unless this is
a configured bridge vlan. Currently trying to read 802.1Q-2022 to see
if I find anything clearly stating how this should (not) work ... .

> > To continue the stream of consciousness, it probably does not make
> > sense to pass on the untagged flag for the bridge/cpu port, because it
> > will affect all ports of the switch, regardless of them being member
> > of the bridge.
>
> Though it needs to be said, usually standalone ports are VLAN-unaware,
> thus, the VLAN ID on RX from their direction is a discardable quantity.
>
> b53 is one of the special drivers, for setting ds->vlan_filtering_is_glob=
al =3D true.
> That makes standalone ports become VLAN filtering even when not under a
> bridge, and is what ultimately causes DSA to program RX filtering VLANs
> to hardware in the first place. Normally, 8021q uppers aren't programmed
> to hardware - see the comments above dsa_user_manage_vlan_filtering().

That's unfortunately how the switch chip works, either you have
filtering on all ports, or on none. Can't toggle it on a per-port
base. The only exception is the CPU port, where you can at least allow
it to send to any VLAN/port.

> > Looking through drivers in net/drivers/dsa, I don't see
> > anyone checking if egress untag is applied to the cpu port, so I
> > wonder if not most, maybe even all (dsa) switch drivers have the same
> > issue and would actually need to keep the cpu port always tagged.
>
> What check do you expect to see exactly? Many drivers treat VLANs on the
> CPU port in special ways, sja1105, felix/ocelot, mv88e6xxx, mt7530, ksz8,=
 maybe others.
> Some of them are subtle and not easy to spot, because they are not from
> the .port_vlan_add() call path (like felix_update_tag_8021q_rx_rule()).

I was mostly looking if .port_vlan_add() has some special handling for
the cpu port as it gets called for vlans configured on the bridge
port, and I didn't see anyone ignoring the untagged flag if
programming the cpu port. Didn't look too deeply though.

> > And looking through the tag_* handlers, only ocelot looks like it may
> > have the information available whether a packet was originally tagged
> > or not, so would also need to have untag_vlan_aware_bridge_pvid enabled=
.
>
> ocelot can select between 2 different tagging protocols, "ocelot" (which
> leaves the VLAN header unmodified) and "ocelot-8021q" (which does not),
> and the latter indeed does set untag_vlan_aware_bridge_pvid. It's an
> option from which more than one driver could benefit, though, for sure.
>
> mv88e6xxx uses MV88E6XXX_G1_VTU_DATA_MEMBER_TAG_UNMODIFIED which
> provides essentially that information, neither "tag" nor "untag", but
> "keep".

Ah, I see, just checked the datasheet.

 b53 also has a "keep unmodified" mode, but that is global and applies
to all ports, so an untagged at ingress frame then can never become
egress tagged. Completely useless when also having a vlan filtering
bridge.

> > Makes the think the cpu port always tagged should be the default
> > behavior. It's easy to strip a vlan tag that shouldn't be there, but
> > hard to add one that's missing, especially since in contrast to PVID
> > you can have more than one vlan as egress untagged.
>
> I agree and I would like to see b53 converge towards that. But changing
> the default by unsetting this flag in DSA could be a breaking change, we
> should be careful, and definitely only consider that for net-next.
>
> b53 already sets a form (the deprecated form) of ds->untag_bridge_pvid,
> someone with hardware should compare its behavior to the issues
> documented in dsa_software_untag_vlan_unaware_bridge(), and, if
> necessary, transition it to ds->untag_vlan_aware_bridge_pvid or perhaps
> something else.

This is for the case when you have a b53 switch behind a b53 switch, e.g.

sw0.port1..4 user ports
sw0.cpu -> sw1.port1
sw1.port2..4 user ports
sw1.cpu -> eth0

and you have user ports on both switches. Due to the way the broadcom
tag works, if sw0 would be brcm tagged, then sw1 wouldn't see the vlan
tag anymore on rx (since there will now be the brcm tag), and all
traffic would go to the pvid of sw1.port1, thus any forwarding between
ports of sw0 and sw1 would have to be done in software.

In this case, sw0 needs to have its traffic always tagged. Also sw1
needs to keep all vlans on port1 egress tagged, not sure if we
actually take care of that ... (maybe the dsa code does that for us,
didn't check).

Although forwarding works between user ports of sw0 and sw1, from the
linux perspective we would never receive any traffic from sw0's ports,
since we only have sw1's tag, and that one will say sw1.port1.

So while you may be able to configure vlans and forwarding, probably
everything else won't work as expected. Like when you want to send out
a packet on a certain port.

Though I assume this isn't a special issue for b53, and rather a
common issue of chained switch chips, and b53 just acknowledges it /
tries to work around it. I know that marvell (E)DSA can handle this,
but I wouldn't be surprised if many others can't.

Looking at devices in OpenWrt that are affected by this, these device
have exactly one user port on sw1, and that one is mostly used as a
wan port, so as a stand-alone port, not a bridge port. One could argue
here that proper functioning of the "outer" switch's ports is more
important than being able to forward frames in hardware to the wan
port.

Unfortunately I do not have a device at hand, might need to figure out
if I can get my hands on one ... .

Best regards,
Jonas


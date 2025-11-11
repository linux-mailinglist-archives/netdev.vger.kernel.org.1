Return-Path: <netdev+bounces-237634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83354C4E1EC
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 14:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B0391881F5C
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 13:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7688D26E158;
	Tue, 11 Nov 2025 13:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCPAL+0K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CFA76025
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 13:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762867897; cv=none; b=VKD05AITDh+A00EdVi3ZMEzLSVHvteH1OxdCSuYzbSwMyyXjZTJHN2wIYaV1jYM1lwP+aJhlDijUQWYLAWz8QEoiICf8NcvAv/ZBG4RmCAvxiO2xmi9LvKxX826w2EKuXNFtRXssVMx7Sue/zrhR5EzHkjzuzAZDLPTd8ukAFvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762867897; c=relaxed/simple;
	bh=DMi6sCuXS3Pie01FqNU1xC+xLKXgOJZdV4/enTeinIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=StrGTxSmrsYtVZIaQ8KwEnTMXANa5B1mYg2e0qeOzWtqO3GxZKtdWxit5ahhw5jHSWLxVLPcnM9AZJDLEceO35OIrMmjxpv6fN/nYs/92R+RgJtKqVz9nXjTXs8iLk8qdfNiph4mizQRrwlZ3BOaNLsdRfq4o1SLsjiqbhARVH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCPAL+0K; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-787eb2d86bfso23898517b3.2
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 05:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762867894; x=1763472694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyIN+7ErQ3P8PMyjPjpHzOQvi0mWhG2I97HzcBXrsS0=;
        b=RCPAL+0K12huSMKHR75RzG09vvh+iD3ZxpuKAG2Xw46vTYapLkctkAJKfZxB7NeBtx
         VX7fLqYoNS2famkSQi0q4UteIm2SiLqaZ+2RvYMLOgSlc9ABNYUAt+XiKCw7YFX9cePt
         Yy0mRKyXQWYOQ8S3YITYVJl9RXyO8Up2Dx5X71dyVIO9tSu3hG6/ENOD7nUKfCX/9bkC
         POJzDax/6XJjMUZo0wtBih6i7S5QYcl/LJWXp9U2QlBj329a9lyNP2tlWIFZ2ZG1yNlV
         cWR8ii8mi9tI3lhyl8PyfCW096oqL5o5VUNsXVDmlhC7+aPhKXbkd+0xUCNYWq+ntJHb
         PVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762867894; x=1763472694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CyIN+7ErQ3P8PMyjPjpHzOQvi0mWhG2I97HzcBXrsS0=;
        b=WKLWEHsxmdyvVazODfzAnMKoGS54M03DgjgeaSXQ8PE1MBFFgJdgk/MyiHS4gRy0PI
         RNPQ5syAocbQ29Oe4dRAf4obdrdnmmXEkgx1Odv/NuN3GSvRiuBZioyGQu30LbClmFdu
         lsX1RZMRv/dSwxch0ismZCIrWk54iqkBuEaSoXBNIr74irNbkaX+U4GhI7KVoze9yUaF
         DB0ZsdO8jlhrH8Ztk3ouZlHGuSzhinsXGZUf1v7t2Eykil4uyaOEFUj1S4YuXAaNfKT6
         8Aihy8ct1TtnpwskY6jL0gvCyVl4YuG8lgTveNxvBWUr/merhwvUZjhYK0vzXzm+MC0I
         FRow==
X-Forwarded-Encrypted: i=1; AJvYcCVx5bltFztepGaaNBe4aH9NcXxiw+6EGV0HSQb9+cLn9hbGxhQHZh9COyqzLXqRHwssfloWl4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWbcjWtV/QHJUjBruHZAx+xXq/GiclPJGduwz+DiZ01JRVyKFQ
	oEW3xK1X6WWItfrCww4vjBgvwHS+Hj4BC56uEDdn7zozZKxUzr3WZNjkglriY0lqEGHDviWRI3k
	KtEJmrfdjcnbg4CraqxhCs16DmjLiGro=
X-Gm-Gg: ASbGncvXsV/6+GyujcEJivGYQW/HNCM7fV6vwtHRZD7nIv0g+s0SgXsnTyCGo8GG/aR
	x6MMyp+/w/07nKEKEmHxJoNI8nr1LgqoXND5pm+A+RKHNTOvS8hsHeQHp9B/H9lWaKLKkqMSQq+
	0UFqaSUlUYeiNFByxW2YdK4LCO4OAx3LqHrLXpFUilvhoTb5cv6gPzcdW8lJeh9IzyxmXoc1fu0
	aRKDo9SM9l9dsACgR3gj2p0G9FQPtnPPlWzUCC95WHz502wwTQRx2CbNxE=
X-Google-Smtp-Source: AGHT+IGwkYrVAfEPvPzmef5jJqS38L9lJaVwkQydaYvZjea3LT5SMI81HU8S/HyP1/tg1jhbH8fXF3m3QwxFxO5RPkA=
X-Received: by 2002:a05:690c:670a:b0:787:de81:35c2 with SMTP id
 00721157ae682-787de8137a6mr97165477b3.42.1762867894275; Tue, 11 Nov 2025
 05:31:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110214443.342103-1-jonas.gorski@gmail.com>
 <20251110230124.7pzmkhrkxvtgzh5k@skbuf> <CAOiHx==ymTyVbs7UmNH28UgxcfnMQBtt6qA=ZnKvEF3QLe_z8w@mail.gmail.com>
 <20251111102951.lkexwdk5btdqdt46@skbuf>
In-Reply-To: <20251111102951.lkexwdk5btdqdt46@skbuf>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Tue, 11 Nov 2025 14:31:23 +0100
X-Gm-Features: AWmQ_bmr5IDtv6w6cEpkS5D8nNOKqP2MIR1pY5E2JtuklDEL_-BgBruAkQ4BDR0
Message-ID: <CAOiHx==CEztXuq5o+-OEpK4nkGA+EVFuX7uU6WKnrkeXU6x6BA@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 0/3] net: dsa: deny unsupported 8021q uppers
 on bridge ports
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 11:29=E2=80=AFAM Vladimir Oltean <olteanv@gmail.com=
> wrote:
>
> On Tue, Nov 11, 2025 at 10:53:00AM +0100, Jonas Gorski wrote:
> > Hi Vladimir,
> >
> > On Tue, Nov 11, 2025 at 12:01=E2=80=AFAM Vladimir Oltean <olteanv@gmail=
.com> wrote:
> > >
> > > Hi Jonas,
> > >
> > > On Mon, Nov 10, 2025 at 10:44:40PM +0100, Jonas Gorski wrote:
> > > > Documentation/networking/switchdev.rst is quite strict on how VLAN
> > > > uppers on bridged ports should work:
> > > >
> > > > - with VLAN filtering turned off, the bridge will process all ingre=
ss traffic
> > > >   for the port, except for the traffic tagged with a VLAN ID destin=
ed for a
> > > >   VLAN upper. (...)
> > > >
> > > > - with VLAN filtering turned on, these VLAN devices can be created =
as long as
> > > >   the bridge does not have an existing VLAN entry with the same VID=
 on any
> > > >   bridge port. (...)
> > > >
> > > > Presumably with VLAN filtering on, the bridge should also not proce=
ss
> > > > (i.e. forward) traffic destined for a VLAN upper.
> > > >
> > > > But currently, there is no way to tell dsa drivers that a VLAN on a
> > > > bridged port is for a VLAN upper and should not be processed by the
> > > > bridge.
> > >
> > > You say this as if it mattered. We can add a distinguishing mechanism
> > > (for example we can pass a struct dsa_db to .port_vlan_add(), set to
> > > DSA_DB_PORT for VLAN RX filtering and DSA_DB_BRIDGE for bridge VLANs)=
,
> > > but the premise was that drivers don't need to care, because HW won't=
 do
> > > anything useful with that information.
> >
> > It matters in the case of VLAN uppers on bridged ports. It does not
> > matter for VLAN uppers on standalone ports.
>
> Ok, and what would a driver do with the info that a port_vlan_add() call
> came from 8021q and not from the bridge?

Prevent forwarding of that VID on that port and instead send/redirect
it to the CPU port, if it can do it. Or reject the configuration (e.g.
with not supported).

And if DSA sees the rejection it can decide to switch the port to
standalone mode, so it works.

> > > > Both adding a VLAN to a bridge port and adding a VLAN upper to a br=
idged
> > > > port will call dsa_switch_ops::port_vlan_add(), with no way for the
> > > > driver to know which is which. But even so, most devices likely wou=
ld
> > > > not support configuring forwarding per VLAN.
> > >
> > > Yes, this is why the status quo is that DSA tries to ensure that VLAN
> > > uppers do not cause ports to forward packets between each other.
> > > You are not really changing the status quo in any way, just fixing so=
me
> > > bugs where that didn't happen effectively. Perhaps you could make tha=
t a
> > > bit more clear.
> >
> > Right, I'm trying to prevent situations where the forwarding will
> > happen despite not being supposed to happen.
> >
> > > > So in order to prevent the configuration of configurations with
> > > > unintended forwarding between ports:
> > > >
> > > > * deny configuring more than one VLAN upper on bridged ports per VL=
AN on
> > > >   VLAN filtering bridges
> > > > * deny configuring any VLAN uppers on bridged ports on VLAN non
> > > >   filtering bridges
> > > > * And consequently, disallow disabling filtering as long as there a=
re
> > > >   any VLAN uppers configured on bridged ports
> > >
> > > First bullet makes some sense, bullets 2 and 3 not so much.
> > >
> > > The first bullet makes just "some" sense because I don't understand w=
hy
> > > limit to just bridged ports. We should extend to all NETIF_F_HW_VLAN_=
CTAG_FILTER
> > > ports as per the dsa_user_manage_vlan_filtering() definitions.
> >
> > Standalone ports are isolated from each other, so the configured VLAN
> > uppers do not matter for forwarding. They will (should) never forward
> > traffic to other ports, regardless of any VLAN (filtering)
> > configuration on the bridge, so there is no issue here (pending
> > correct programming of the switch). Usually isolation trumps any VLAN
> > memberships.
>
> So we would hope, that standalone ports are completely isolated from
> each other, but unless drivers implement ds->fdb_isolation, that isn't a
> given fact. Forwarding might be prevented, but FDB lookups might still
> take place, so when you have this setup:
>
> swp1.100     br0
>  |         /     \
> swp1     swp2    swp3  (bridge vlan add dev swp3 vid 100 master)
>
> and you ping station 00:01:02:03:04:05 from swp1.100, you'd expect it
> goes out the wire on swp1. But if swp3 had previously learned 00:01:02:03=
:04:05,
> I wouldn't be surprised if the switch tried to forward it in that
> direction instead (failing of course, but dropping the packet in that
> process). We would be saved if the tagger's xmit() would force the
> packet to bypass FDB lookup, but that isn't a given either...
>
> As I'm saying, swp1 can have NETIF_F_HW_VLAN_CTAG_FILTER set due to any
> of the quirks described in dsa_user_manage_vlan_filtering().
>
> It might be a moot point because I haven't verified what are the drivers
> which fulfill all conditions for this to be a practical problem. It might
> as well be the empty set. For example, sja1105 fulfills them all, but
> sja1105_prechangeupper() rejects all 8021q uppers so it is not affected.

There doesn't need to be a VLAN upper, it's enough if the native VLAN
of standalone ports overlaps with the VLANs used in the bridge.

AFAICT that is at least an issue for those that use 8021q taggers. And
there is the opposite direction, where a similar issue can occur:

If swp1 receives a packet with 00:01:02:03:04:05 the switch may try to
forward it to swp3 (and drop it) instead of delivering it to the host.

But at least for b53 these are not an issue. The xmit header overrides
any fdb lookups, and non-bridged ports are configured to trap all
traffic to the cpu port, skipping fdb lookups. And since they do not
learn, they have no fdb entries configured, so the bridged ports
should never attempt to forward to them.

> > This is purely about unintended/forbidden forwarding between bridged po=
rts.
> >
> > > Bullets 2 and 3 don't make sense because it isn't explained how VLAN
> > > non-filtering bridge ports could gain the NETIF_F_HW_VLAN_CTAG_FILTER
> > > feature required for them to see RX filtering VLANs programmed to
> > > hardware in the first place.
> >
> > Let me try with an example:
> >
> > let's say we have swp1 - swp4, standalone.
> >
> > allowed forward destinations for all are the cpu port, no filtering.
> >
> > now we create a bridge between swp2 and swp3.
> >
> > now swp2 may also forward to swp3, and swp3 to swp2.
> >
> > swp1 and swp4 may still only forward to cpu (and this doesn't change
> > here. We can ignore them).
> >
> > Bullet point 1:
> >
> > If vlan_filtering is enabled, swp2 and swp3 will only forward configure=
d VLANs.
> >
> > swp2 and swp3 will have NETIF_F_HW_VLAN_CTAG_FILTER (as VLAN filtering
> > is enabled on these ports).
> >
> > If we enable VID 10 on both ports, the driver will be called with
> > port_vlan_add(.. vid =3D 10), and they forward VLAN 10 between each
> > other.
> > If we instead create uppers for VID 10 for both ports, the driver will
> > be called with port_vlan_add(... vid =3D 10) (as
> > NETIF_F_HW_VLAN_CTAG_FILTER is is set), and they forward VLAN 10
> > between each other (oops).
>
> I didn't contest that, and the bridged port example is clear. I just
> said I don't think you're seeing the picture broadly enough on this
> bullet point. I may be wrong though - just want to clarify what I'm
> saying.
>
> > Bullet point 2:
> >
> > If vlan_filtering is disabled, swp2 and swp3 forward any VID between ea=
ch other.
> >
> > swp2 and swp3 won't have NETIF_F_HW_VLAN_CTAG_FILTER (as vlan
> > filtering is disabled on these ports).
> >
> > If we now create an upper for VID 10 on swp2, then VLAN 10 should not
> > be forwarded to swp3 anymore (as VLAN 10 is now "consumed" by the host
> > on this port).
> >
> > But since there is no port_vlan_add() call due to filtering disabled
> > (NETIF_F_HW_VLAN_CTAG_FILTER not set), the dsa driver does not know
> > that the forwarding should be inhibited between these ports, and VLAN
> > 10 is still forwarded from swp2 to swp3 (oops).
>
> Is this the behaviour with veth bridge ports (that VID 10 packets are
> trapped as opposed to bridged)? I need a software-based reference to
> clearly understand the gap vs DSA's hardware offload.  I don't think
> there's any test for that, but it is good to have one.

It's at least written that way in switchdev.rst (I admit I haven't
verified that this is true):

"When there is a VLAN device (e.g: sw0p1.100) configured on top of a switch=
dev
network device which is a bridge port member, the behavior of the software
network stack must be preserved, or the configuration must be refused if th=
at
is not possible.

- with VLAN filtering turned off, the bridge will process all ingress traff=
ic
  for the port, except for the traffic tagged with a VLAN ID destined for a
  VLAN upper. The VLAN upper interface (which consumes the VLAN tag) can ev=
en
  be added to a second bridge, which includes other switch ports or softwar=
e
  interfaces. Some approaches to ensure that the forwarding domain for traf=
fic
  belonging to the VLAN upper interfaces are managed properly:

    * If forwarding destinations can be managed per VLAN, the hardware coul=
d be
      configured to map all traffic, except the packets tagged with a VID
      belonging to a VLAN upper interface, to an internal VID corresponding=
 to
      untagged packets. This internal VID spans all ports of the VLAN-unawa=
re
      bridge. The VID corresponding to the VLAN upper interface spans the
      physical port of that VLAN interface, as well as the other ports that
      might be bridged with it. ..."

This very clearly says to me: if there is a VLAN upper on a bridged
port, then any packets tagged with this VLAN must not be forwarded to
other ports, unless the upper is part of a different bridge.

The text for filtering bridges isn't super clear though:

"- with VLAN filtering turned on, these VLAN devices can be created as long=
 as
  the bridge does not have an existing VLAN entry with the same VID on any
  bridge port. These VLAN devices cannot be enslaved into the bridge since =
they
  duplicate functionality/use case with the bridge's VLAN data path process=
ing."

But I understand this as "same behavior, but no bridging them."

So I don't think that DSA in its current form can support/describe
VLAN uppers on bridged ports (of a non filtering bridge).

And bridging VLAN uppers with physical ports becomes even more fun: I
verified that having e.g. eth1.100 and eth2 in a non-ffiltering
bridge, if if a VLAN tagged packet ingresses on eth2, it will egress
as double tagged on eth1.

Maybe we should just ban non-filtering bridges, would make things so
much easier (j/k).

> > Bullet point 3:
> > And since having uppers on a bridged ports on a non-filtering bridge
> > does not inhibit forwarding at all, we cannot allow disabling
> > filtering as long as VLAN uppers on bridged ports exist.
> >
> > Does this now make it clearer what situations I am talking about?
> >
> > The easy way is to disallow these configurations, which is what I try
> > to attempt (explicitly allowed by switchdev.rst).
> >
> > One other more expensive options are making bridge ports with VLAN
> > uppers (or more than one upper for a VLAN) standalone and disable
> > forwarding, and only do forwarding in software.
> >
> > Or add the above mentioned DSA_DB_PORT for vlan uppers on (bridged)
> > ports, regardless of filtering being enabled, and then let the dsa
> > driver handle forwarding per VLAN.
>
> But you still won't get ndo_vlan_rx_add_vid() calls from the 8021q layer
> if you're under a VLAN-unaware bridge, so it doesn't help case #2.
> You'd have to remove the ndo_vlan_rx_add_vid() handling and manually
> track CHANGEUPPER events from 8021q interfaces.

Right, that would be prerequisite for that, which is probably quite a
bit of work. That's why I'm for now trying to reject this as it is
broken, instead trying to make this work (if it even can be made to
work).

Best regards,
Jonas


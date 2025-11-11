Return-Path: <netdev+bounces-237525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC88C4CC73
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E8AAF34F57B
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 09:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D65A2FD7D6;
	Tue, 11 Nov 2025 09:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HulecNlH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B501D2FBDE3
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854794; cv=none; b=HLn4L55aay13DG3lC8OCfdHNO9HFQBXkaRRFAqcfgom2RNXCJuCtdPjLwwUU16n9Tx/M5f9JR39zClrVrldB2AeCRhiGMPuYsvw2GrsZ22HBSkXJ0z3SUutH6bzg4O5s8Zk2gcWWi6pzh9h/GZ5ES1C+7pLUmXi+UDJ4gkKjfL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854794; c=relaxed/simple;
	bh=KC/FtaD7GZlypAuVRR7zqPHHKnWewGdbZEtDc8ssmpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yh7hciA/Jam9BM6V+5EqXV9Rlu1kMhQkuLkE0Bo5v6Vpdh0M3S+NwCki5gI+y5qo1tbuYPfFVjj509BmqWTDxLlvSzI3oAXn3sXDKEbqxn3IQgTGuIj7OratekiJ33BAXOGXm8mohATrAZbp8bYoAkAQFkXQJsDLY35fVoLUKR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HulecNlH; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-640e065991dso3061611d50.3
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 01:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762854792; x=1763459592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PyXx/XqXF1D8laPygGvxhQVfuy/TOB8qpygNndyh+h8=;
        b=HulecNlHkU34xlyKnD2xbr4UzcDv2WbQJw83MDAqjWRZKHvNDKlCVhvYTfeglKfCXH
         kqsiMmA6Ih+J8phn+SlJMVDGjrkNsykbeltx3RYmBQhKALX7otrNEJQ3jGWpiyMVVKXK
         APH2hXr15LBr2pq+c0lCPPo1yxUcSGV6jJT6PgEU9YXGGE6LxqxbsEqVeV6dj0ujEkjC
         VEdoIixB4pqKUJWfzEKC/yJi9J+clh9rry+79sSPEM+RqyQhq0xkkdHJLxM4nzBFHTd2
         fiMPPhKR/XMZkLYABmQywg9LoLYSyhohJy3+KQ5CO9vAqnBix5A3KhGckPob9BDt9ZYk
         bS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762854792; x=1763459592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PyXx/XqXF1D8laPygGvxhQVfuy/TOB8qpygNndyh+h8=;
        b=GKm39wZGyXUxuuUqRH1RxOPM+NE9la6vCoh6xKdIpJsBiSf2x+NTWc1FJUHVUT2JWk
         wqA1demJfv1BAWwcx48XUv4MFPAJFY+FROM9Xa/tbiQrAoQUN9xOi6IHHyANoinEchR8
         Pox2gORNBdHuqIG8WS1J9/K5SxBxz9BU96yjo1uB98N6YwZtrxIM7rOEQjO7jIIgAvib
         et44ibEt5eacZa0E3rwsm2xsyxGP1lXOyD+6bcFA2DjL47XDp+IcA/d98pLASzbYEJlI
         xqeEXXowZWxcImV54cNLVT4QF2XlP6VRMM+MIk7y7Nwcj3auRrY5gKPs8ajhMjD0AHE2
         esTA==
X-Forwarded-Encrypted: i=1; AJvYcCV/ZEyne3iki7yWPELd+zBdSZb6oSv/B5uWhACqVLiZThdy6eh0UCDpmpXdMTRkxodVnKEyrAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVOegwVfCcd5FZXjKXaNXF2uDtQkq8EY4UKUCXdtJl+/Zy1VGe
	ftmdly/V5pqM9HUukarlv0cBDuTqul7S1Ns/e/CPrpb39iLmzcpKM8rdkPhzJ7phHyrPtyEI59w
	f13LE1tNkbicF9RlRJSyOB9p5Q02AY80=
X-Gm-Gg: ASbGncsJD/GtefLpgwHewz9tF/OpCv7gnlj4xDXqv2lpT0RfApUBAwiCrNfdXObMm5e
	csvHFT2c3O++V4PoxiZV/uJIRuKOD5X3uGmkhAb6sBxDs327HZgNYB1vgdkNMtIzWcBMKwxxTef
	zvTStUylEb0ac9hczr/lka/8V5w+1dAVJFKGOsDOKmsOB1XsRh/ubX39Lhyyqco50b+Yh3R8qcD
	apw6YNNvI4pYyzjiZP7gpfWuMTkfGeALHPbI8n+paBDnqvIq7S5jwkOKQw=
X-Google-Smtp-Source: AGHT+IF9cL8R75S5fEHKMWwHyOCM8yxLp2zyYPXr/dVSYHl4uTdJ+SmI0MDP5Zccup4b3rFR5/FSamFpoN56cAOne0Q=
X-Received: by 2002:a05:690e:4319:b0:63f:c10e:6422 with SMTP id
 956f58d0204a3-640d4521e01mr8042406d50.8.1762854791585; Tue, 11 Nov 2025
 01:53:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110214443.342103-1-jonas.gorski@gmail.com> <20251110230124.7pzmkhrkxvtgzh5k@skbuf>
In-Reply-To: <20251110230124.7pzmkhrkxvtgzh5k@skbuf>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Tue, 11 Nov 2025 10:53:00 +0100
X-Gm-Features: AWmQ_bmVu_tf7Qwi2USmUQ1KPdAesVol6XAFAeMYSR2SRaeAWkqula63Sj7g6Dk
Message-ID: <CAOiHx==ymTyVbs7UmNH28UgxcfnMQBtt6qA=ZnKvEF3QLe_z8w@mail.gmail.com>
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

Hi Vladimir,

On Tue, Nov 11, 2025 at 12:01=E2=80=AFAM Vladimir Oltean <olteanv@gmail.com=
> wrote:
>
> Hi Jonas,
>
> On Mon, Nov 10, 2025 at 10:44:40PM +0100, Jonas Gorski wrote:
> > Documentation/networking/switchdev.rst is quite strict on how VLAN
> > uppers on bridged ports should work:
> >
> > - with VLAN filtering turned off, the bridge will process all ingress t=
raffic
> >   for the port, except for the traffic tagged with a VLAN ID destined f=
or a
> >   VLAN upper. (...)
> >
> > - with VLAN filtering turned on, these VLAN devices can be created as l=
ong as
> >   the bridge does not have an existing VLAN entry with the same VID on =
any
> >   bridge port. (...)
> >
> > Presumably with VLAN filtering on, the bridge should also not process
> > (i.e. forward) traffic destined for a VLAN upper.
> >
> > But currently, there is no way to tell dsa drivers that a VLAN on a
> > bridged port is for a VLAN upper and should not be processed by the
> > bridge.
>
> You say this as if it mattered. We can add a distinguishing mechanism
> (for example we can pass a struct dsa_db to .port_vlan_add(), set to
> DSA_DB_PORT for VLAN RX filtering and DSA_DB_BRIDGE for bridge VLANs),
> but the premise was that drivers don't need to care, because HW won't do
> anything useful with that information.

It matters in the case of VLAN uppers on bridged ports. It does not
matter for VLAN uppers on standalone ports.

> > Both adding a VLAN to a bridge port and adding a VLAN upper to a bridge=
d
> > port will call dsa_switch_ops::port_vlan_add(), with no way for the
> > driver to know which is which. But even so, most devices likely would
> > not support configuring forwarding per VLAN.
>
> Yes, this is why the status quo is that DSA tries to ensure that VLAN
> uppers do not cause ports to forward packets between each other.
> You are not really changing the status quo in any way, just fixing some
> bugs where that didn't happen effectively. Perhaps you could make that a
> bit more clear.

Right, I'm trying to prevent situations where the forwarding will
happen despite not being supposed to happen.

> > So in order to prevent the configuration of configurations with
> > unintended forwarding between ports:
> >
> > * deny configuring more than one VLAN upper on bridged ports per VLAN o=
n
> >   VLAN filtering bridges
> > * deny configuring any VLAN uppers on bridged ports on VLAN non
> >   filtering bridges
> > * And consequently, disallow disabling filtering as long as there are
> >   any VLAN uppers configured on bridged ports
>
> First bullet makes some sense, bullets 2 and 3 not so much.
>
> The first bullet makes just "some" sense because I don't understand why
> limit to just bridged ports. We should extend to all NETIF_F_HW_VLAN_CTAG=
_FILTER
> ports as per the dsa_user_manage_vlan_filtering() definitions.

Standalone ports are isolated from each other, so the configured VLAN
uppers do not matter for forwarding. They will (should) never forward
traffic to other ports, regardless of any VLAN (filtering)
configuration on the bridge, so there is no issue here (pending
correct programming of the switch). Usually isolation trumps any VLAN
memberships.

This is purely about unintended/forbidden forwarding between bridged ports.

> Bullets 2 and 3 don't make sense because it isn't explained how VLAN
> non-filtering bridge ports could gain the NETIF_F_HW_VLAN_CTAG_FILTER
> feature required for them to see RX filtering VLANs programmed to
> hardware in the first place.

Let me try with an example:

let's say we have swp1 - swp4, standalone.

allowed forward destinations for all are the cpu port, no filtering.

now we create a bridge between swp2 and swp3.

now swp2 may also forward to swp3, and swp3 to swp2.

swp1 and swp4 may still only forward to cpu (and this doesn't change
here. We can ignore them).

Bullet point 1:

If vlan_filtering is enabled, swp2 and swp3 will only forward configured VL=
ANs.

swp2 and swp3 will have NETIF_F_HW_VLAN_CTAG_FILTER (as VLAN filtering
is enabled on these ports).

If we enable VID 10 on both ports, the driver will be called with
port_vlan_add(.. vid =3D 10), and they forward VLAN 10 between each
other.
If we instead create uppers for VID 10 for both ports, the driver will
be called with port_vlan_add(... vid =3D 10) (as
NETIF_F_HW_VLAN_CTAG_FILTER is is set), and they forward VLAN 10
between each other (oops).

Bullet point 2:

If vlan_filtering is disabled, swp2 and swp3 forward any VID between each o=
ther.

swp2 and swp3 won't have NETIF_F_HW_VLAN_CTAG_FILTER (as vlan
filtering is disabled on these ports).

If we now create an upper for VID 10 on swp2, then VLAN 10 should not
be forwarded to swp3 anymore (as VLAN 10 is now "consumed" by the host
on this port).

But since there is no port_vlan_add() call due to filtering disabled
(NETIF_F_HW_VLAN_CTAG_FILTER not set), the dsa driver does not know
that the forwarding should be inhibited between these ports, and VLAN
10 is still forwarded from swp2 to swp3 (oops).

Bullet point 3:
And since having uppers on a bridged ports on a non-filtering bridge
does not inhibit forwarding at all, we cannot allow disabling
filtering as long as VLAN uppers on bridged ports exist.

Does this now make it clearer what situations I am talking about?

The easy way is to disallow these configurations, which is what I try
to attempt (explicitly allowed by switchdev.rst).

One other more expensive options are making bridge ports with VLAN
uppers (or more than one upper for a VLAN) standalone and disable
forwarding, and only do forwarding in software.

Or add the above mentioned DSA_DB_PORT for vlan uppers on (bridged)
ports, regardless of filtering being enabled, and then let the dsa
driver handle forwarding per VLAN. This may or may not be possible,
depending on the hardware. One workaround I can think of is to enable
a VLAN membership violation trap and then remove the port from the
VLAN. But this also has the potential to pull a lot of traffic to the
cpu. And requires drivers to be adapted to handle it. And would
require filtering, which may get complicated for the non-filtering
bridge case.

> > An alternative solution suggested by switchdev.rst would be to treat
> > these ports as standalone, and do the filtering/forwarding in software.
> >
> > But likely DSA supported switches are used on low power devices, where
> > the performance impact from this would be large.
> >
> > While going through the code, I also found one corner case where it was
> > possible to add bridge VLANs shared with VLAN uppers, while adding
> > VLAN uppers shared with bridge VLANs was properly denied. This is the
> > first patch as this seems to be like the least controversial.
> >
> > Sent as a RFC for now due to the potential impact, though a preliminary
> > test didn't should any failures with bridge_vlan_{un,}aware.sh and
> > local_termination.sh selftests on BCM63268.
> >
> > A potential selftest for bridge_vlan_{un,}aware.sh I could think of
> >
> > - bridge p3, p4
> > - add VLAN uppers on p1 - p4 with a unique VLAN
> >   if refused, treat as allowed failure
> > - check if p4 sees traffic from p1
> >
> > If p1 and p4 are isolated (so implicitly p2 and p3), its fine, and if
> > the configuration is rejected is also fine, but forwarding is not.
>
> Sounds like something which would be fit for
> tools/testing/selftests/net/forwarding/no_forwarding.sh.

Oh, wasn't aware of this one, yeah, that seems appropriate. Thanks!
Will try to come up with a test.

Best Regards,
Jonas


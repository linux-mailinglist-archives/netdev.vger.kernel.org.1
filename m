Return-Path: <netdev+bounces-185895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 783D1A9C020
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 09:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B641B16E4FE
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 07:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19562230D1E;
	Fri, 25 Apr 2025 07:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlGzrxa0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CE722F778;
	Fri, 25 Apr 2025 07:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745567548; cv=none; b=Mw6tGOw5Bn+dlYtjVYXnbGjZJ15qd2OrRsJdPryd0Bk67AjurAdykxpNuMhcSmXdp9imJ5o3xDsO4f7utas4gKHePCfMuYnI0iqEyQPgejHBRmWYgdnNJuJC16P/b2HAZRWhbLynF57N1tRjdzzsG0g9G0cmk9dl1xjtGPqSddI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745567548; c=relaxed/simple;
	bh=RpcqN6cyutJ07es0L7ZhSTLTN/piKrCMnO4y3jBK+Xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EEfWuVsY3f1uY0VHKIyOEtrDEun99KgN5dtdbQCGhUHAuE3ajpFwYPZgOOal87JuE9fU5KntBt7mVfGNl3twpv5TpxGL5bLewwZP5HOwNABUMjiKgZfYQ7RLLXdy/MKsHi9GCE359LzL1IdZ1iWhHAGOSUzOCFVEXaI1FNkLoxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlGzrxa0; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ff07872097so20519287b3.3;
        Fri, 25 Apr 2025 00:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745567545; x=1746172345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDubi+d9NvmGvDUOgMVTF/g//Z3Xwpt+6cFsorV2Ef0=;
        b=YlGzrxa0WugQLM7hFgbAr8bIkApp/H4rvByKOvOWrS7augs1swy+6wjLFhE2jJR4Y+
         ixDw8XUyZ2myGBBQMQzP1g14OSHT/RZwlGgKJKfroOwyp/HNVtV6pN16YR27DAnIwnGO
         B9E3w9/e5S9XN+qclSbQ3fh3NHr5HkvHuhRCa7Dj+74i28Z2zJAfCeSt8Zp0S3/IcMpx
         s64n1hO8LhziVRs4AffIyshN5Nr03R/J6BAWObloYRTiGAan9d4An9W86rJxd4LDRsNl
         xGHFx+fyn9Pq14h24RJ704lFHChlSDE3Mdyia5nACPpNTzVEbhqCTWwLfuzCZkwVi7pB
         29AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745567545; x=1746172345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WDubi+d9NvmGvDUOgMVTF/g//Z3Xwpt+6cFsorV2Ef0=;
        b=s3M+MzcY9QzVj19mXYsVnpyZ4BKKQvb/91CDiHXq78NG27FmZj1tydQOJSxSlQ+nq2
         ndvYztj/ShGpdOzzgqY7b19oF3K7qQfnxN35J34FOXTyCEkBpJOqICRtrUUONp4XBfnj
         GYPmFsQKiVLPo1Yg6qR7WbWzXbUViFraeYk+4pKkIqsaTNRyBg63Sflc3qimzvxnu41S
         FDnGQG4qxS57yguABq9vLX3/L/XuUon7fiPIS/3NapI085Qcv5OcVp2lwtOsfoX3dUNs
         ilhJp/mJ7FPGwIXLtYjVbgkkZOSuSmUGeC4LHhwLy1791ft/NoWj8YsPt7GlEIzoKbWg
         CisA==
X-Forwarded-Encrypted: i=1; AJvYcCUXyrTdVwZpdu8H1in/+WTj6+tLw5HSKu1KZPdA0JMT4PqlEZ3Nfho8DaH4bjSOHq6BCNzKF6MSH6dAipE=@vger.kernel.org, AJvYcCUt7wjdhIOyv1+lYHYVRjW92PkORwoMfVDVd6Wyo5i3jCnKzAjzoK3CtIVYaUBjco6R3Fe1cEXB@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx44tTWw/TkPeS75xUmdS1vHvha3uwJn50BG/AlCsRrEhJjGgU
	FoJKJ/00FA+Yw6JYGXFzKd0UCEytKyjVktA9kTRD9bali6VkopaSVSVQS9uFJqlqfhuvR1LfD/u
	F7NH+xF32ZLoMAZzHDJcnBaWsDnI=
X-Gm-Gg: ASbGncsMkDxHRdHtj21dieXXGjoZD6xmrCP9js5YL94DUOS5UjKPLpAAD9i1pLN+qqa
	U5p7dZEr/b1XWgDAmDl/pf1LCfhthfpvVyydLfR06cCk9gR4ElvOOcePs+wpyipaRpDR1hQ0sPV
	JJvhuqokvPI7eCSdIYCQI=
X-Google-Smtp-Source: AGHT+IFhasof6ajBdVvw3/ejge8/p839ycOF33yzhTq1K+SFpwRDYljMr7qB2jYxSgWh4BnpcV5BEhHsZklfTONZxz8=
X-Received: by 2002:a05:690c:89:b0:6fd:2b7d:9a4e with SMTP id
 00721157ae682-7085413938fmr15829407b3.18.1745567544954; Fri, 25 Apr 2025
 00:52:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422184913.20155-1-jonas.gorski@gmail.com>
 <20250424102509.65u5zmxhbjsd5vun@skbuf> <04ac4aec-e6cd-4432-a31d-73088e762565@gmail.com>
 <CAOiHx==5p2O6wVa42YtR-d=Sufbb2Ljy64mFSHavX2bguVXPWg@mail.gmail.com> <20250424225738.7xr36vll3vg4irzf@skbuf>
In-Reply-To: <20250424225738.7xr36vll3vg4irzf@skbuf>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Fri, 25 Apr 2025 09:52:13 +0200
X-Gm-Features: ATxdqUGS-JXFIBwrz2B3SG5La3AkLqaTLQ2ludX7QQ-KS-mHo9ut1LhTHeUlYY0
Message-ID: <CAOiHx=m0nkxczOHQycCjsXcRvs-eP+wGgrUDDuB5UpSnMBSLkw@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: fix VLAN 0 filter imbalance when toggling filtering
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 12:57=E2=80=AFAM Vladimir Oltean <olteanv@gmail.com=
> wrote:
>
> On Thu, Apr 24, 2025 at 03:58:50PM +0200, Jonas Gorski wrote:
> > On Thu, Apr 24, 2025 at 2:34=E2=80=AFPM Florian Fainelli <f.fainelli@gm=
ail.com> wrote:
> > > On 4/24/2025 12:25 PM, Vladimir Oltean wrote:
> > > > On Tue, Apr 22, 2025 at 08:49:13PM +0200, Jonas Gorski wrote:
> > > >> When a net device has NETIF_F_HW_VLAN_CTAG_FILTER set, the 8021q c=
ode
> > > >> will add VLAN 0 when enabling the device, and remove it on disabli=
ng it
> > > >> again.
> > > >>
> > > >> But since we are changing NETIF_F_HW_VLAN_CTAG_FILTER during runti=
me in
> > > >> dsa_user_manage_vlan_filtering(), user ports that are already enab=
led
> > > >> may end up with no VLAN 0 configured, or VLAN 0 left configured.
> > > >>
> > > >> E.g.the following sequence would leave sw1p1 without VLAN 0 config=
ured:
> > > >>
> > > >> $ ip link add br0 type bridge vlan_filtering 1
> > > >> $ ip link set br0 up
> > > >> $ ip link set sw1p1 up (filtering is 0, so no HW filter added)
> > > >> $ ip link set sw1p1 master br0 (filtering gets set to 1, but alrea=
dy up)
> > > >>
> > > >> while the following sequence would work:
> > > >>
> > > >> $ ip link add br0 type bridge vlan_filtering 1
> > > >> $ ip link set br0 up
> > > >> $ ip link set sw1p1 master br0 (filtering gets set to 1)
> > > >> $ ip link set sw1p1 up (filtering is 1, HW filter is added)
> > > >>
> > > >> Likewise, the following sequence would leave sw1p2 with a VLAN 0 f=
ilter
> > > >> enabled on a vlan_filtering_is_global dsa switch:
> > > >>
> > > >> $ ip link add br0 type bridge vlan_filtering 1
> > > >> $ ip link set br0 up
> > > >> $ ip link set sw1p1 master br0 (filtering set to 1 for all devices=
)
> > > >> $ ip link set sw1p2 up (filtering is 1, so VLAN 0 filter is added)
> > > >> $ ip link set sw1p1 nomaster (filtering is reset to 0 again)
> > > >> $ ip link set sw1p2 down (VLAN 0 filter is left configured)
> > > >>
> > > >> This even causes untagged traffic to break on b53 after undoing th=
e
> > > >> bridge (though this is partially caused by b53's own doing).
> > > >>
> > > >> Fix this by emulating 8021q's vlan_device_event() behavior when ch=
anging
> > > >> the NETIF_F_HW_VLAN_CTAG_FILTER flag, including the printk, so tha=
t the
> > > >> absence of it doesn't become a red herring.
> > > >>
> > > >> While vlan_vid_add() has a return value, vlan_device_event() does =
not
> > > >> check its return value, so let us do the same.
> > > >>
> > > >> Fixes: 06cfb2df7eb0 ("net: dsa: don't advertise 'rx-vlan-filter' w=
hen not needed")
> > > >> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> > > >> ---
> > > >
> > > > Why does the b53 driver depend on VID 0? CONFIG_VLAN_8021Q can be
> > > > disabled or be an unloaded module, how does it work in that case?
> > >
> > > This is explained in this commit:
> > >
> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/commit/?id=3D64a81b24487f0d2fba0f033029eec2abc7d82cee
> > >
> > > however the case of starting up with CONFIG_VLAN_8021Q and then loadi=
ng
> > > the 8021q module was not thought about, arguably I am not sure what s=
ort
> > > of notification or event we can hook onto in order to react properly =
to
> > > that module being loaded. Do you know?
> >
> > config BRIDGE_VLAN_FILTERING
> >         bool "VLAN filtering"
> >         depends on BRIDGE
> >         depends on VLAN_8021Q
> >
> > without 8021Q there is no vlan filtering bridge, so filtering can
> > never be 1, so NETIF_F_HW_VLAN_CTAG_FILTER is never set, so HW filters
> > for VLAN 0 are never installed or removed, therefore the issue can
> > never happen.
>
> nitpick: except for ds->needs_standalone_vlan_filtering (which b53 does n=
ot set though).
>
> >
> > The issue is only if a vlan filtering bridge was there, and now isn't
> > anymore, and a previously VLAN 0 HW filter is left intact. This causes
> > an incomplete vlan entry left programmed in the vlan table of the chip
> > with just this port as a member, which breaks forwarding for that
> > VLAN, which is incidentally also the VLAN used for untagged traffic in
> > the non filtering case.
>
> Ok, so let's say b53_default_pvid() is 0, and b53_setup() ->
> b53_apply_config() -> b53_configure_vlan() calls b53_set_vlan_entry() on
> it to set it up, independently of the 8021q layer. So far so good.
>
> But then, the 8021q layer can modify VID 0 on the device from the way in
> which it was set up by the driver for VLAN-unaware operation, namely it
> can remove it, and this breaks VLAN-unaware reception.
>
> One needs to wonder why would the b53 driver even permit changes coming
> from .port_vlan_add() and .port_vlan_del() to a VID it has reserved for
> special use. There's nothing to gain from reacting to these operations,
> only to lose.
>
> I'm trying to think whether switchdev drivers in general have anything
> to benefit from commit ad1afb003939 ("vlan_dev: VLAN 0 should be treated
> as "no vlan tag" (802.1p packet)"). I'm tempted to say "thanks for the
> well-intended hint about VID 0, but a switchdev's data path is so
> complicated that we'd rather manage VID 0 ourselves". Not only do many
> drivers reserve VID 0 and thus need to be independent of the 8021q layer
> even for VLAN-unaware operation, but also think of this: the bridge may
> have vlan_filtering 1 and vlan_default_pvid 0. What will happen if the
> 8021q layer decides to add VID 0 to the RX filtering table? My logic and
> testing with the software data path says that VID 0 traffic should not
> be forwarded. My intuition is that it will make b53 accept this kind of
> traffic.
>
> Here's a self test I posted exactly for this scenario, if you don't
> mind, please let me know what happens, and we'll see where to go from
> there. On ocelot, which has commit 9323ac367005 ("net: mscc: ocelot:
> ignore VID 0 added by 8021q module"), it passes (but fails elsewhere,
> sadly - I've sent a patch also for that).
> https://lore.kernel.org/netdev/20250424223734.3096202-2-vladimir.oltean@n=
xp.com/T/#u
>
> That being said, I don't think we are quite prepared to adopt my
> solution (of ignoring VID 0) DSA-wide (especially not as a bug fix),
> because it is driver-dependent whether VID 0 is in a conflict with a
> VLAN ID reserved for private use or not. Even though adding VID 0 to the
> RX filtering table possibly allows its forwarding even when it shouldn't
> (and that isn't desirable), there might be some positive benefits as
> well - like permitting VID 0 reception when it _should_ be received.
>
> It's a pretty tricky situation, I guess we should first establish what
> are the tests that need to pass, then assess on a per-driver basis where
> we are. We don't have nearly as much coverage as we would need.

I gave it a test with a vlan_filtering bridge with no PVID / egress
untagged vlan defined on a pure software bridge, and STP continued to
work fine. So in a sense, VLAN 0 is needed, as we still need to allow
untagged traffic to be received regardless of a PVID egress untagged
VLAN being defined.

But we shouldn't forward it (except to the cpu port) unless it is part
of a PVID egress untagged VLAN. This is the tricky part. If (dsa)
switch drivers ensure that untagged traffic always reaches the cpu
port, then we can ignore VLAN 0.

So I think this boils down to that dsa needs a way to pass on to
drivers whether a VLAN should be forwarded to other members or not
when adding it to a port.

Currently, from a dsa driver perspective, the following two scenarios
would be indistinguishable:

$ ip link add br0 type bridge vlan_filtering 1
$ ip link set sw1p1 master br0
$ ip link set sw1p2 master br0
$ bridge vlan add dev sw1p1 vid 10
$ bridge vlan add dev sw2p1 vid 10

and

$ ip link add br0 type bridge vlan_filtering 1
$ ip link set sw1p1 master br0
$ ip link set sw1p2 master br0
$ ip link add sw1p1.10 link sw1p1 type vlan id 10
$ ip link add sw1p2.10 link sw1p2 type vlan id 10

But in the second case, swp1p1 and sw1p2 should be isolated.

This is because vlan filters and bridge vlans result in the same
port_vlan_add() call, with no way of the driver to tell from where the
call comes from.

And yes, this is something that is probably hard to configure for many
smaller embedded switch chips. E.g. b53 supported switches do not have
forward/flood/etc masks per VLAN, so some cheating/workaround is
needed here. switchdev.rst says to fall back to software forwarding if
there is no other way. I have some ideas, but I will first need to
verify that they work ... .

Regards,
Jonas


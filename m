Return-Path: <netdev+bounces-186254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8FDA9DBEA
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 17:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7210D5A80BF
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 15:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A67125D1E0;
	Sat, 26 Apr 2025 15:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ec4gz2Ia"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7B925C824;
	Sat, 26 Apr 2025 15:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745682290; cv=none; b=Zmdv8Q9HYaaQttln08fxq2aeIwQBvXSTtAKNbvoQ3lZe3O1hOQAcrn7CVbAYRfz5o92Cpwu7Tc2ZieUlYs85dPeJDbTTTX8WYfH/FaqWYrpNcc63wOnXTPHBUEGiO3lQcNzISCfLJbxW5VoQnt0MWb76H6rhpIZPZ2pt6RkoRYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745682290; c=relaxed/simple;
	bh=xlZ8h9J35ik7B66HmzAggOJdBA3VvKTZTpHUKEo2XF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXGYAmFQYkKwgYCaCuiiNFAYja5gMApRxV3ZTBk1B9rTdUenx3H/YvBGhpyFRTHQdIT9yyPPXKeJklvT68jLuFC8lh6w0EvZLNVfKaM7J3v0Hy+QXQ2HujYGmIYvHwJLMgpUGCHRzG1Cg6cARQqGEVydMDmXJh1NWRS9d1kRRCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ec4gz2Ia; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6fece18b3c8so28253707b3.3;
        Sat, 26 Apr 2025 08:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745682284; x=1746287084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARtNC8JVpT+jeLqAI00HLzUJP64d2b+ljBjn6oIHgyA=;
        b=Ec4gz2Ia48SI3lzs903SOyGRrvagMScKWQzVV9HaqFRCntXegMpBErv9o3dFXhXjJV
         aQBFT3m2JBLvR9376FDKs8Oo/VyakxWEG83Rk30rEKfy8Qx9NBOPPyxDWNdc2kHz6Bbs
         3PJwH3bM6HlDpytOYeme4/47n3yubfl+EO56R+//qRUcVtwmEkUmiSuhausLTeT8B/ye
         82mrpSmejBAPmw6MHonDtMrlSPbBAVRDlbRcEfg9SZvn85ZP73tggCkMVYranlOb8m/T
         wTmVuq6OraiQbI9aXyCvPyqNn2fC9Wu1f00Kn2PBh4PYQ0UII7FT0GPhMGQSFLO2fFa6
         ErFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745682284; x=1746287084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ARtNC8JVpT+jeLqAI00HLzUJP64d2b+ljBjn6oIHgyA=;
        b=Wcj5WTpyxvphddQNM1zs6UhFf4z+Hd7tF+EVsd8UeXg+OzuMYvO3p2oi0MuepeNyV0
         9fUEuC8n085K91JFxemI6qNbkIDvEzDwVMkJsI0bGoqDGeI+Nowa/SaKjjTlYC1+Kg4t
         jiUaFs0J0unAfTFwxL1sgXhjH4/XVsAWjxX8QDbF4CvN5859XxQMkbKhZuXdm5+DFKFJ
         5+ZXEG11ETYVLhcDRjd0Tz8WjT5E1WCc3rSICLSE3Vmloqk8e4lOstcHuuMYn9WlpBFk
         jDRec7dOmoU+KxKNK8u8EFB8R/XezBwh59GQq4NWfnbgsqtxoLDDvHMT3AV+XGCTociV
         dhXg==
X-Forwarded-Encrypted: i=1; AJvYcCXQWvV63cxzXPxCejErv12q6iemwbyf7HeY9oJMe2+9TnTpa7PHNJAUlmeOK64uxR8U44SCJpJAwTzoY7g=@vger.kernel.org, AJvYcCXYLUFctVHJKUAqfeNAGPrHNPdnXbsC9s9tH/9qcvBYWe64XFOgqc6Vdbp/RK7E3dxKJcZdD91s@vger.kernel.org
X-Gm-Message-State: AOJu0YzvSRCL4LsUeQi1xa6T22HPsombQl310IO1R0W0IQIxuEbfhj9M
	5vF0ewJpxVY8/BY/cUfMXEMfNiUVNCA2qlxikEiALDL4goiFW3knAyfx9ohU+HBLdRFRooLU5VR
	g9VU8/GsTsqjHuZG2r8UnWe9AsuY1nDI+
X-Gm-Gg: ASbGncsgSYw2i3cDB529xSO7ZjgMY/hRtFSbiL+t8gsQ784RpNSir6IPfRs2jFQ3Px/
	IKy/Ii7veDR/iR8AArf6TZadZe6pNTvHdx3nSoTazOqPa61gp+L+XfjF07OWeLuG+Qq0U6yl7CQ
	6LnDMLIWLekiB+MV2IwpE=
X-Google-Smtp-Source: AGHT+IFWt5dBX82EtXcodI6rxsLIR9kiwj0th4wIpc3HvAJzZfS2svwa8Pwzo1us3u5cW0L+VnuywSrjm70hg6NcNo4=
X-Received: by 2002:a05:690c:660a:b0:707:d16d:31f8 with SMTP id
 00721157ae682-708540fa1cemr87645127b3.14.1745682284305; Sat, 26 Apr 2025
 08:44:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422184913.20155-1-jonas.gorski@gmail.com>
 <20250424102509.65u5zmxhbjsd5vun@skbuf> <04ac4aec-e6cd-4432-a31d-73088e762565@gmail.com>
 <CAOiHx==5p2O6wVa42YtR-d=Sufbb2Ljy64mFSHavX2bguVXPWg@mail.gmail.com>
 <20250424225738.7xr36vll3vg4irzf@skbuf> <CAOiHx=m0nkxczOHQycCjsXcRvs-eP+wGgrUDDuB5UpSnMBSLkw@mail.gmail.com>
 <20250425114225.w24quv7gnp5vlcyd@skbuf>
In-Reply-To: <20250425114225.w24quv7gnp5vlcyd@skbuf>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Sat, 26 Apr 2025 17:44:33 +0200
X-Gm-Features: ATxdqUHp5YW_jCusTnSdaSXaSKD3oYtOu3jPkrp5BrL0nZ1XXz5r6LrfUiyIgdY
Message-ID: <CAOiHx==qdf+NVk5wG2J48gVBovp-UQuO1iS+6cCFbKyGyR0uqw@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: fix VLAN 0 filter imbalance when toggling filtering
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 1:42=E2=80=AFPM Vladimir Oltean <vladimir.oltean@nx=
p.com> wrote:
>
> On Fri, Apr 25, 2025 at 09:52:13AM +0200, Jonas Gorski wrote:
> > I gave it a test with a vlan_filtering bridge with no PVID / egress
> > untagged vlan defined on a pure software bridge, and STP continued to
> > work fine.
>
> STP is not part of the bridge data path, it is control path. The PVID
> rules don't apply to it.
> In software terms, br_handle_frame() returns RX_HANDLER_PASS for it, it
> doesn't go through br_handle_vlan().
>
> > So in a sense, VLAN 0 is needed, as we still need to allow
> > untagged traffic to be received regardless of a PVID egress untagged
> > VLAN being defined.
>
> When we are talking about the hardware data path of a switchdev port,
> that is debatable as well, since many switchdevs have built-in packet
> traps which again bypass the VLAN table (a function specific to the
> switching layer, like learning, STP state etc). I would argue that the
> presence of VID 0 in the RX filtering table is irrelevant for STP as far
> as switchdevs are concerned.

For b53, it is not, at least in the current state. LLC packets (and
other reserved multicast) are only redirected to CPU if there is a
PVID VLAN defined. But this isn't unfixable, I just noticed we
explicitly enable that reserved multicast follows VLAN configuration.

> > But we shouldn't forward it (except to the cpu port) unless it is part
> > of a PVID egress untagged VLAN. This is the tricky part. If (dsa)
> > switch drivers ensure that untagged traffic always reaches the cpu
> > port, then we can ignore VLAN 0.
> >
> > So I think this boils down to that dsa needs a way to pass on to
> > drivers whether a VLAN should be forwarded to other members or not
> > when adding it to a port.
>
> That can be done (add a struct dsa_db argument to port_vlan_add(),
> signifying whether it is a port VLAN or a bridge VLAN), but I haven't
> come across switches which can make the distinction. It would require
> mapping the same VID, coming from different ports, to different hardware
> FIDs.

At least for b53, the workaround I see that could work is (for the
filtering case):

1. enable trap of vlan membership violations to cpu (this also
disables learning for those packets)
2. when the first port installs a vlan filter, have a vlan entry with
just the cpu port
3. when the last port removes the filter, remove the cpu port again

The theoretical result should be:

1. if the vlan does not exist on the bridge, and no standalone port
has a vlan upper with it, it will be dropped
2. if the vlan does exist on the bridge, it will be forwarded between
ports that are members of it
3. if there is a vlan upper, that ports traffic will be redirected to
the cpu port

Since all packets will be redirected to the cpu port, and learning is
disabled for these packets, there is no need for a separate FID for
that port/vlan, and it would ensure that vlan uppers are separated
between each other.

This would even work for VLANs that are already configured on the
bridge (though switchdev.rst says that isn't allowed).

The down side would be that any VLAN membership violation for
configured VLANs would be redirected to the cpu port, though it's
probably still less than e.g. switching ports to standalone and do
forwarding in software (which would be an alternative for allowing
multiple VLAN uppers with a vlan aware bridge).

> > Currently, from a dsa driver perspective, the following two scenarios
> > would be indistinguishable:
> >
> > $ ip link add br0 type bridge vlan_filtering 1
> > $ ip link set sw1p1 master br0
> > $ ip link set sw1p2 master br0
> > $ bridge vlan add dev sw1p1 vid 10
> > $ bridge vlan add dev sw2p1 vid 10
> >
> > and
> >
> > $ ip link add br0 type bridge vlan_filtering 1
> > $ ip link set sw1p1 master br0
> > $ ip link set sw1p2 master br0
> > $ ip link add sw1p1.10 link sw1p1 type vlan id 10
> > $ ip link add sw1p2.10 link sw1p2 type vlan id 10
> >
> > But in the second case, swp1p1 and sw1p2 should be isolated.
> >
> > This is because vlan filters and bridge vlans result in the same
> > port_vlan_add() call, with no way of the driver to tell from where the
> > call comes from.
> >
> > And yes, this is something that is probably hard to configure for many
> > smaller embedded switch chips. E.g. b53 supported switches do not have
> > forward/flood/etc masks per VLAN, so some cheating/workaround is
> > needed here. switchdev.rst says to fall back to software forwarding if
> > there is no other way. I have some ideas, but I will first need to
> > verify that they work ... .
>
> We have insufficient coverage in dsa_user_prechangeupper_sanity_check()
> and dsa_port_can_apply_vlan_filtering(), but we should add another
> restriction for this: 8021q uppers with the same VID should not be
> installed to ports spanning the same VLAN-aware bridge. And there should
> be a new test for it in tools/testing/selftests/net/forwarding/no_forward=
ing.sh.
>
> The restriction can be selectively lifted if there ever appear drivers
> which can make the distinction you are talking about, but I don't think
> that any of them can, at the moment.

AFAICT, we probably then also need to deny any vlan uppers on ports
bridged via vlan unaware bridges for now, as we currently don't
actually configure them at all.

switchdev.rst says "Frames ingressing the device with a VID that is
not programmed into the bridge/switch's VLAN table must be forwarded
and may be processed using a VLAN device (see below)" (I thought with
a vlan unaware bridge we do not program the VLAN table? anway ...)

"- with VLAN filtering turned off, the bridge will process all ingress traf=
fic
  for the port, except for the traffic tagged with a VLAN ID destined for a
  VLAN upper."

This is currently not happening when creating a vlan upper, at least I
don't see any port_vlan_add() (?) calls for that. And even then, it
would be indistinguishable from the port_vlan_add() calls that happen
if you add a vlan to the bridge's vlan table, which you can, and DSA
passes on, but should not be acted upon by the switch until vlan
filtering is turned on.

Also in general vlan unaware bridges feel like they have a lot of
complicated and probably unsupportable setups.

Like for example:

br0 { sw1p1, sw1p2, sw1p3, sw1p4 }
br1 { sw1p1.10, sw1p4.10 }

would AFAIU mean:

- forward all traffic except vlan 10 tagged between all 4 ports
- vlan 10 tagged traffic from sw1p1 can only go to sw1p4
- vlan 10 tagged traffic from sw1p4 can only go to sw1p1
- vlan 10 tagged traffic from sw1p2 and sw1p3 can go to all other ports

I'm not confident that I could program that correctly on a Broadcom
XGS switch, and these support a *lot* of VLAN shenanigans.

This probably leaves:

"    * Treat bridge ports with VLAN upper interfaces as standalone, and let
      forwarding be handled in the software data path."

as the only viable option here (I have to admit I don't really
understand what the first option is suggesting to do).

Best regards,
Jonas


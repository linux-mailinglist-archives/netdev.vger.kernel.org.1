Return-Path: <netdev+bounces-185764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A32A9BAFA
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 00:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1E391B8489D
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 22:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FD8224B13;
	Thu, 24 Apr 2025 22:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AX0Kg4UR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83B514900B;
	Thu, 24 Apr 2025 22:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745535466; cv=none; b=scQiIVHijDWODOC5a8+k2n+pa52DDMnd3ZCoqwtDCzeha45Rvw8UXay1h2qwnabphMYj0LZ9rDgYDYjLPt3x2AJNT8kJYjzgng4XqsSQUstnIoxm+DqRNeC2oD5xcjSexf++ozi5aWZkpgmkuIf9MoQ5wMbNLJOfwvEe6bWUtK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745535466; c=relaxed/simple;
	bh=I9GLLHXNevi/4S5O0gi610ywDg9g4cLrTCrLugcDduI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cA6xrb+s2E4qs3nRCoy7zxj5GVhRYynGpvB9NWXLvYtAJWg5Exy5NRVMstQeS6Y+sz3hxC92bAVOZs9pn6/TnVvx/EPsIr4ZYVmpZlS9nLFpT/S0Vmhft9iV1hPqX8teQCXLGu8+S3us3Qc+jyokSJ51/FL5tIh4K8oKtXNtJw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AX0Kg4UR; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf7c2c351so1530325e9.0;
        Thu, 24 Apr 2025 15:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745535462; x=1746140262; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tt3wakvDIHzIQYo4afILWwjn2SUWyuaONXXdhw9MFGc=;
        b=AX0Kg4URbUOB5mKq+Sv4q4D8wE8in03Q3W/3YcQ45DVjlmFT6z4l2uvcbluw4poWkk
         gwXGVPUTtr0+9j5AYlQxwHSss1lcUFSO0lBjpzpV0F7l7AgWoFwhvBUnuTYD/dxDMMYS
         +Tj4CfCYoSLhZ4oY5Pnc5ruFSctvEMUnNXhP83TDjKbGS4Ntf5SeDuWgs9nX0BgZUR+m
         IPFdWuCXcDsw5khSG6lDrEC9ENDaEh7f25BPoDPww7CTkjQphRrxVWEUb4Dzvc2fSCqW
         WFko2jWmaqT6Mmv1MN3hObGXke3I++wf/16VLdbRpLY60ZlHNZ64jNGnUQKnlqJVDcr/
         CwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745535462; x=1746140262;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tt3wakvDIHzIQYo4afILWwjn2SUWyuaONXXdhw9MFGc=;
        b=qWErYJIZ1CY5+xtw7dbiYeuaOJ7b29A2ijTx+7MzXkJQXhjHGNlX1hzYlnV0Uaa1sm
         mkXIe8zKvB8huZZV2mq/lYsv0OrfboNb+bxA6CXQw29nbdpcKacAA57tYXmVyeheWGti
         WPrK5rbiW4FKAvbRPUK6YnUAjiv42CXP/AhmMvOlwpcqNGVt4WfXKU+i/9eBkQchZ4/f
         4Er4PK0cuHMDpKSeK/fdSptAZDfaOPUak0oz/bLRU4QgZPLOEvisAEtCo8grpomtuy74
         k39b6LojZ1PhowAXFqg7szLUtVbwruWyTrqeY07mXFLttVzxRxdOFBbeXjHhhNB09GKw
         VdFw==
X-Forwarded-Encrypted: i=1; AJvYcCVU1YquO2a3e3yxZe79qV/r0aA2T/E9Fe85TzsdKHOaMeg612vc6iXwD/KAwVkgNoX32fEnub1R@vger.kernel.org, AJvYcCW1nmeeSwxPIRY2rOwUEjRDJs9TTcLvsrhfhbP9MYYQYRn3HChMjRpzc4ja9si0zdMXUKEdRAuRPc65cJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT4ffdunYaI912e2jDPdS3fTPJQmlAQn4hcxdXrk/SsVJ6RC+K
	oQBuYJsldFLTpFqYfGYPUoot+dezBjcbwRSLuH2LuWTJJhF9ezwV
X-Gm-Gg: ASbGnct3CReBZNhRV1Lr69HVxMY8dSiZkxudV4BT6TFG8AyNe9xVnFFZNwq3cq2OZoc
	Z+nHHUNoTussbH4IBIm03kJW7kFPl1S9C10sQ7pMKW6hieSXXA+wEcCxG3s4TENoBjzCIUr3nke
	Z720+fRFVMwiVEpq6NbsJppaM8D3TolepqPg9IQ4rplQpX2PhlaAEKH73fIL2t8rBnriuczjgxt
	193NKIFzXNK2HSk/dBOVHJBDPbIt4Mh2DTwRYS4t8917e8jyN2GObrRqtxF8gGSR7EvM8eYZ/9K
	LndKAYiidHoHoaep4Oy7dHcKwpul
X-Google-Smtp-Source: AGHT+IGGTdiMBQwmNpdRAXt++I8DcOe06hDEC6vJgeQcv6JXKGjqLOk5vlJ4oHfQrRVHt+/NiHS00w==
X-Received: by 2002:a05:600c:4e01:b0:439:9a1f:d73d with SMTP id 5b1f17b1804b1-440a66bdd1emr9635e9.8.1745535461520;
        Thu, 24 Apr 2025 15:57:41 -0700 (PDT)
Received: from skbuf ([188.25.50.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e46c23sm528105f8f.75.2025.04.24.15.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 15:57:40 -0700 (PDT)
Date: Fri, 25 Apr 2025 01:57:38 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: fix VLAN 0 filter imbalance when toggling
 filtering
Message-ID: <20250424225738.7xr36vll3vg4irzf@skbuf>
References: <20250422184913.20155-1-jonas.gorski@gmail.com>
 <20250424102509.65u5zmxhbjsd5vun@skbuf>
 <04ac4aec-e6cd-4432-a31d-73088e762565@gmail.com>
 <CAOiHx==5p2O6wVa42YtR-d=Sufbb2Ljy64mFSHavX2bguVXPWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOiHx==5p2O6wVa42YtR-d=Sufbb2Ljy64mFSHavX2bguVXPWg@mail.gmail.com>

On Thu, Apr 24, 2025 at 03:58:50PM +0200, Jonas Gorski wrote:
> On Thu, Apr 24, 2025 at 2:34 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> > On 4/24/2025 12:25 PM, Vladimir Oltean wrote:
> > > On Tue, Apr 22, 2025 at 08:49:13PM +0200, Jonas Gorski wrote:
> > >> When a net device has NETIF_F_HW_VLAN_CTAG_FILTER set, the 8021q code
> > >> will add VLAN 0 when enabling the device, and remove it on disabling it
> > >> again.
> > >>
> > >> But since we are changing NETIF_F_HW_VLAN_CTAG_FILTER during runtime in
> > >> dsa_user_manage_vlan_filtering(), user ports that are already enabled
> > >> may end up with no VLAN 0 configured, or VLAN 0 left configured.
> > >>
> > >> E.g.the following sequence would leave sw1p1 without VLAN 0 configured:
> > >>
> > >> $ ip link add br0 type bridge vlan_filtering 1
> > >> $ ip link set br0 up
> > >> $ ip link set sw1p1 up (filtering is 0, so no HW filter added)
> > >> $ ip link set sw1p1 master br0 (filtering gets set to 1, but already up)
> > >>
> > >> while the following sequence would work:
> > >>
> > >> $ ip link add br0 type bridge vlan_filtering 1
> > >> $ ip link set br0 up
> > >> $ ip link set sw1p1 master br0 (filtering gets set to 1)
> > >> $ ip link set sw1p1 up (filtering is 1, HW filter is added)
> > >>
> > >> Likewise, the following sequence would leave sw1p2 with a VLAN 0 filter
> > >> enabled on a vlan_filtering_is_global dsa switch:
> > >>
> > >> $ ip link add br0 type bridge vlan_filtering 1
> > >> $ ip link set br0 up
> > >> $ ip link set sw1p1 master br0 (filtering set to 1 for all devices)
> > >> $ ip link set sw1p2 up (filtering is 1, so VLAN 0 filter is added)
> > >> $ ip link set sw1p1 nomaster (filtering is reset to 0 again)
> > >> $ ip link set sw1p2 down (VLAN 0 filter is left configured)
> > >>
> > >> This even causes untagged traffic to break on b53 after undoing the
> > >> bridge (though this is partially caused by b53's own doing).
> > >>
> > >> Fix this by emulating 8021q's vlan_device_event() behavior when changing
> > >> the NETIF_F_HW_VLAN_CTAG_FILTER flag, including the printk, so that the
> > >> absence of it doesn't become a red herring.
> > >>
> > >> While vlan_vid_add() has a return value, vlan_device_event() does not
> > >> check its return value, so let us do the same.
> > >>
> > >> Fixes: 06cfb2df7eb0 ("net: dsa: don't advertise 'rx-vlan-filter' when not needed")
> > >> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> > >> ---
> > >
> > > Why does the b53 driver depend on VID 0? CONFIG_VLAN_8021Q can be
> > > disabled or be an unloaded module, how does it work in that case?
> >
> > This is explained in this commit:
> >
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=64a81b24487f0d2fba0f033029eec2abc7d82cee
> >
> > however the case of starting up with CONFIG_VLAN_8021Q and then loading
> > the 8021q module was not thought about, arguably I am not sure what sort
> > of notification or event we can hook onto in order to react properly to
> > that module being loaded. Do you know?
> 
> config BRIDGE_VLAN_FILTERING
>         bool "VLAN filtering"
>         depends on BRIDGE
>         depends on VLAN_8021Q
> 
> without 8021Q there is no vlan filtering bridge, so filtering can
> never be 1, so NETIF_F_HW_VLAN_CTAG_FILTER is never set, so HW filters
> for VLAN 0 are never installed or removed, therefore the issue can
> never happen.

nitpick: except for ds->needs_standalone_vlan_filtering (which b53 does not set though).

> 
> The issue is only if a vlan filtering bridge was there, and now isn't
> anymore, and a previously VLAN 0 HW filter is left intact. This causes
> an incomplete vlan entry left programmed in the vlan table of the chip
> with just this port as a member, which breaks forwarding for that
> VLAN, which is incidentally also the VLAN used for untagged traffic in
> the non filtering case.

Ok, so let's say b53_default_pvid() is 0, and b53_setup() ->
b53_apply_config() -> b53_configure_vlan() calls b53_set_vlan_entry() on
it to set it up, independently of the 8021q layer. So far so good.

But then, the 8021q layer can modify VID 0 on the device from the way in
which it was set up by the driver for VLAN-unaware operation, namely it
can remove it, and this breaks VLAN-unaware reception.

One needs to wonder why would the b53 driver even permit changes coming
from .port_vlan_add() and .port_vlan_del() to a VID it has reserved for
special use. There's nothing to gain from reacting to these operations,
only to lose.

I'm trying to think whether switchdev drivers in general have anything
to benefit from commit ad1afb003939 ("vlan_dev: VLAN 0 should be treated
as "no vlan tag" (802.1p packet)"). I'm tempted to say "thanks for the
well-intended hint about VID 0, but a switchdev's data path is so
complicated that we'd rather manage VID 0 ourselves". Not only do many
drivers reserve VID 0 and thus need to be independent of the 8021q layer
even for VLAN-unaware operation, but also think of this: the bridge may
have vlan_filtering 1 and vlan_default_pvid 0. What will happen if the
8021q layer decides to add VID 0 to the RX filtering table? My logic and
testing with the software data path says that VID 0 traffic should not
be forwarded. My intuition is that it will make b53 accept this kind of
traffic.

Here's a self test I posted exactly for this scenario, if you don't
mind, please let me know what happens, and we'll see where to go from
there. On ocelot, which has commit 9323ac367005 ("net: mscc: ocelot:
ignore VID 0 added by 8021q module"), it passes (but fails elsewhere,
sadly - I've sent a patch also for that).
https://lore.kernel.org/netdev/20250424223734.3096202-2-vladimir.oltean@nxp.com/T/#u

That being said, I don't think we are quite prepared to adopt my
solution (of ignoring VID 0) DSA-wide (especially not as a bug fix),
because it is driver-dependent whether VID 0 is in a conflict with a
VLAN ID reserved for private use or not. Even though adding VID 0 to the
RX filtering table possibly allows its forwarding even when it shouldn't
(and that isn't desirable), there might be some positive benefits as
well - like permitting VID 0 reception when it _should_ be received.

It's a pretty tricky situation, I guess we should first establish what
are the tests that need to pass, then assess on a per-driver basis where
we are. We don't have nearly as much coverage as we would need.


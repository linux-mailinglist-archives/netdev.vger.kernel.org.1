Return-Path: <netdev+bounces-181900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5C2A86D59
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 15:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292BC1B60FB6
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 13:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F0B19D090;
	Sat, 12 Apr 2025 13:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1JNT2kz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EC8142E83;
	Sat, 12 Apr 2025 13:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744465817; cv=none; b=po1CPv/jInVOYqF8vPHNuGUuEzAfEQR2SSk1BZa+K/72nDNGabE0ddH4vtMZltm0CPFUvlGtn0MPZqs1LASQVmteeOIJBWiFnX7GijpgT++rfVwuwGz1/gJqwM+ZJSG87ABa4FIe6ZaKe0T7ni7rbdFpqqJfceMoN5GUQ+23v0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744465817; c=relaxed/simple;
	bh=9HVAaKeQsXM5ZKip4Wyw4Xr3Rq1kzLUbh5jUuY5fHjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IHMjg/u+Y5s6xX3gTsR2+4apdl3L9/WB1Hthax7MKLryzsNOVcKRrNgn4coQ8cDjRVYoO/tVEsSQkRLpxkMxMyhV7qgT2g+sfq1w2NRbL8pB7P8Sb4VU1vjrhWGr9V+w4B1HZti+p0s+CpW/yQvKEqrPwAzD4WSdTYAM0YCy7zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1JNT2kz; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e6405e4ab4dso3667157276.0;
        Sat, 12 Apr 2025 06:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744465815; x=1745070615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HVAaKeQsXM5ZKip4Wyw4Xr3Rq1kzLUbh5jUuY5fHjg=;
        b=j1JNT2kzfjWBsCl78Eke8f+ozwl/bJq1L8us/SuCy+P/TgWGC7gJ3U38Pefyp6dw46
         ns9Ze5wth7a1Yh7fBFikGexWzwU2BBpxPZn37OcUdFNOoSgdLtZIGYcxd0sGGXw1aB0z
         +YEEXJUSsPlK6GFBCR+alynRU8BdANwEFGVhJTg7aIeZvCt0HhrVOjAx6rQAvRGcoONJ
         l2Yz1uKMxHwp6l3RStJF410Ae5iezTQSjfY5PDvilaFJA5WdmD0r1bNuMZOnPMssL9bB
         VeDBIHaNQCKD+HKO4tA+VuwxGmwjsijy/sbGa0iHUv90meoOq1CbNaX6HsZ9hYJI6Fnp
         aHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744465815; x=1745070615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9HVAaKeQsXM5ZKip4Wyw4Xr3Rq1kzLUbh5jUuY5fHjg=;
        b=urBjkaCqLd5XX9kIJo4cBup3YoWlh1BMCCQMr83PaBzgRFRwWRl9iP5CIZBBYgW9Nq
         d9W+qYgBwN+e1HJnpFpn2fBqBSk/e7mppTGc/Tyy2BjkZ7CU11lPnVYX9siDyJ+CMIHf
         whGn6PkbdpohkCCgPQuv6oDHyc/Fv2dfPNe3s7oCnSa4hqi7rug1dTGFGs7BeX1nBG3t
         KOqkKCeMOvB4pSVjf7xuFvZz/VzyWqtemxqMX2HaV1EMcV3zB+JCAcnL0zqqWhNSua5x
         eVxN4S8MD0xDJ5fUslt58ulaoPuky9CkWts0MblW75vxgDdRKth8tIfQmcF4ZdMHoI40
         js3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWPvUoK520DQKrs6Wx84LOv12wvjlypmBkldM0gRdVExzLzg4qXFR9khkZDt0P1Judij4O25vTJ5DMZqg=@vger.kernel.org, AJvYcCXD0Poxe7lOofGcViZTbSCaND71zJ1bujlHtlZQncwCNYvX+JHTOX1zDUCwPeoxiLGH3fVOcDQf@vger.kernel.org
X-Gm-Message-State: AOJu0YzY598D+dL63xrt0lgpMNyuUu/bsU1nfXDXX+/apF+uDN4RuZWy
	8DVVEY+pay2PVkCR3EECxIrccwxqQiP/dqbzaklcaSPPJizL2oDG/i6Hp2gGiJRrXItdaHOLv6p
	2ciodFCO+IxUGp5ZjOyxxXgQGUdA=
X-Gm-Gg: ASbGncvPK4YS0TOBoeLUPDtumZHnlfvvlxicCMPDZZ8iarY7RhjjZdG45M4xnXvnLa3
	KnI9QlZBOo97TRqr+zatf/s5Ux1Ix4rkD3TeyX7glEiE5DiSsb0yZEnz34VUJ/sV4+WPSzE4vR+
	KFdmxv61tLOhXmvLDKE3PkzBKTwzo5YjO40Dyz+BjmgudQMpLhiHbtDrg=
X-Google-Smtp-Source: AGHT+IGlVaCnBfQC6aLBOtn8bfByNyXTwCZBMS+MjyA3ylshqjYzEuowrHjxS7RvT4Ak34ee74hLRjR5mgNoo12z6Dk=
X-Received: by 2002:a05:6902:2610:b0:e64:cd91:9c6b with SMTP id
 3f1490d57ef6-e704df2291amr9533794276.2.1744465814617; Sat, 12 Apr 2025
 06:50:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250412122428.108029-1-jonas.gorski@gmail.com> <20250412133422.xtkd3pxoc7nwprrb@skbuf>
In-Reply-To: <20250412133422.xtkd3pxoc7nwprrb@skbuf>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Sat, 12 Apr 2025 15:50:00 +0200
X-Gm-Features: ATxdqUFoNO90KQDhVHiGWcqBH9cRmiqh3zj4d_mFx7nVU1ZdayZ8Gf2QBeKdaOk
Message-ID: <CAOiHx=mYJm_mrwrDCuQ4ZEviPKLgWDqNcaSXPzaXHeGYWBJCaA@mail.gmail.com>
Subject: Re: [PATCH RFC net 0/2] net: dsa: fix handling brentry vlans with flags
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <vladimir.oltean@nxp.com>, bridge@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 12, 2025 at 3:34=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
>
> On Sat, Apr 12, 2025 at 02:24:26PM +0200, Jonas Gorski wrote:
> > While trying to figure out the hardware behavior of a DSA supported
> > switch chip and printing various internal vlan state changes, I noticed
> > that some flows never triggered adding the cpu port to vlans, preventin=
g
> > it from receiving any of the VLANs traffic.
> >
> > E.g. the following sequence would cause the cpu port not being member o=
f
> > the vlan, despite the bridge vlan output looking correct:
> >
> > $ ip link add swbridge type bridge vlan_filtering 1 vlan_default_pvid 1
> > $ ip link set lan1 master swbridge
>
> At this step, dsa_port_bridge_join() -> switchdev_bridge_port_offload()
> -> ... -> br_switchdev_port_offload() -> nbp_switchdev_sync_objs() ->
> br_switchdev_vlan_replay() -> br_switchdev_vlan_replay_group(br_vlan_grou=
p(br))
> -> br_switchdev_vlan_replay_one() should have notified DSA, with changed=
=3Dfalse.
> It should be processed by dsa_user_host_vlan_add() -> dsa_port_host_vlan_=
add().
>
> You make it sound like that doesn't happen.

Yes, because I messed up writing down what I did. That should have
been vlan_default_pvid 0 so there are no VLANs configured by default.
>
> I notice you didn't mention which "DSA supported chip" you are using.
> By any chance, does its driver set ds->configure_vlan_while_not_filtering=
 =3D false?
> That would be my prime suspect, making dsa_port_skip_vlan_configuration()=
 ignore
> the code path above, because the bridge port is not yet VLAN filtering.
> It becomes VLAN filtering only a bit later in dsa_port_bridge_join(),
> with the dsa_port_switchdev_sync_attrs() -> dsa_port_vlan_filtering(br_vl=
an_enabled(br))
> call.
>
> If that is the case, the only thing that is slightly confusing to me is
> why you haven't seen the "skipping configuration of VLAN" extack message.
> But anyway, if the theory above is true, you should instead be looking
> at adding proper VLAN support to said driver, and drop this set instead,
> because VLAN replay isn't working properly.

It's b53, and on first glance it does not set it. But as I just
noticed, I messed up the example.

So adding the lan1 vid is supposed to be the very first vlan that is config=
ured.

>
> > $ bridge vlan add dev lan1 vid 1 pvid untagged
> > $ bridge vlan add dev swbridge vid 1 pvid untagged self
> >
> > Adding more printk debugging, I traced it br_vlan_add_existing() settin=
g
> > changed to true (since the vlan "gained" the pvid untagged flags), and
> > then the dsa code ignoring the vlan notification, since it is a vlan fo=
r
> > the cpu port that is updated.
>
> Yes, this part and everything that follows should be correct.

Sorry for the mistake. I did it correctly while testing though!

Best regards,
Jonas


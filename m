Return-Path: <netdev+bounces-181946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE73A87139
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 11:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47CE71891C72
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 09:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F18199EBB;
	Sun, 13 Apr 2025 09:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQbTWk8W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A567178372;
	Sun, 13 Apr 2025 09:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744536326; cv=none; b=JF8KKVvbVDpLbtZqa+e4W84AY9geGyezM9Q2dyH62lbrycQRxLy7iRskXQjjWKqJJSxTbL8af3UJbgjq06uc/paY3ftSmbymJLnpyAPOC2advx+Eff2Hkw1CIn4EAX0BOam9G5L+DASXnUHbYOukAo3tS7wWV62swgTGuTfxXFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744536326; c=relaxed/simple;
	bh=XW0UTv9CvXun7cSv8wxoN8fYT/wluyfThYmnYWG9Fzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=If0VAW7lyx/O/uW+IValKswzsKeIlnY1Gow0JfeDoI4+nW4zJcZoX47L5mKEXRUcpU2ULL05S51kDuyXtRRD/LpR5EgWYJiMy6i/XBSIPzyhN3Hb2WFTdWfqFuiIzX7VS5PN4+idk2IjGEJrVV4fQktGO5AVcZtX8KRJS5PhAew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQbTWk8W; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e455bf1f4d3so2514001276.2;
        Sun, 13 Apr 2025 02:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744536324; x=1745141124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XW0UTv9CvXun7cSv8wxoN8fYT/wluyfThYmnYWG9Fzw=;
        b=QQbTWk8W1RJJ1RYIo6C8jydjO3JCU6EgvOYjHN/fF2Xd1hNSfxq58GYAe3KslBAlhC
         gNvnI4O+atyFMXxs6RCBs/CzOKBlQv4fd226Y7mf4uElHzvsJF3tCRNgUcpT8VG4C6mt
         achU/Ol53ABl0AJEqZRa3KuiyHks1kDlE9nyuWUR0AwyFuWXE1ojbk00BNKd9dJblzDI
         3sM3cIgoDu8ka6mkOpW4EfLiUuUyChU1HNKj7XbbR4SOpRgbZJUTkRozmRk+clzIZ0k0
         rDbEYx90YYaa/mWRmoyLm2gbl02bRRhAoq/Q01BTLGxRBsYRu9gYXfzUPlMA5PgKNRCc
         HBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744536324; x=1745141124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XW0UTv9CvXun7cSv8wxoN8fYT/wluyfThYmnYWG9Fzw=;
        b=RVRqkWXOCJnIdZ7wy9XY/YsJ/Zhb7KZfLfCp6oRVqMX9AciJf5pv0Wv78ktVLTACjU
         ufGOCfB4T4Apb0oMSDI5HWllV5rDImbiWI8ge5schEUiy2Mni03S7+enqwRM2nzunoV/
         ZkcKf0pQcMPHmdZR3AWtj+/uwLA6alTIw3mgJwblLgm+dQFZeP6nh0UUucwkC82Aouxi
         kTL83vhX55u40tWNtamgR5R4RZXz+7ZpEZmad4sw+bLq8CUsMX2OL2OcgczxvKTZgjkz
         cuhPA2fMPdaPM2d9CHMj32412xWosvaQjeRn8jVKs/WClCHNIAnXC1CzKW2yWC2YoRws
         rWWg==
X-Forwarded-Encrypted: i=1; AJvYcCWy6ptPtGqegS9fwqTPWpC47CegPJoak47aeXDQq8Ro2Lq2IGLhmoTMDnwDoPP6zGYRbpEVWzj9@vger.kernel.org, AJvYcCX3nBLIBXMaWLQ4+oIraNhqBlRg6cFbTLw6ErQBVQpwC10cZze3blwSaOmr0vEOxVL6jV8a22YBWSYIaPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcsPGBADMoV2QMPvqlil028F8OuvZcHuXqaL3CJmj1OsQBZuod
	8avY5yAWjkB9QFL+eI5RPlVmpO1LoYAAK6hvr19t8sRou7cw5raYU/f/M6CN21VA+WKYeye/fJq
	WXCkvejmvnalH9lhwQuTCQXO+FDw=
X-Gm-Gg: ASbGncupdpAApaylRGYykYvgOfi9b1h5/fXPJyYC1P5X9xbh4UC9vsptbSlnrhHG+Rk
	Hc7MINJzuhHKGoLb2R+jhSRECd0839sV2QHeCcZyKc88oDU+hMX+rdB+Io/G7WJR2ufzllnrhmH
	xql8g3eo4fRgNcYZQ8QI4w
X-Google-Smtp-Source: AGHT+IEUPr9fpjvjQQp/TLLIU5fDq/TyhcM1PNpw1aLvcN/dix4gtOImMC2y/7/MMDqAAoqeFqHr4d14FnKJbb84sRw=
X-Received: by 2002:a05:6902:218b:b0:e6d:f8d3:5ee6 with SMTP id
 3f1490d57ef6-e704dfad75bmr13813435276.41.1744536323820; Sun, 13 Apr 2025
 02:25:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250412122428.108029-1-jonas.gorski@gmail.com>
 <20250412133422.xtkd3pxoc7nwprrb@skbuf> <CAOiHx=mYJm_mrwrDCuQ4ZEviPKLgWDqNcaSXPzaXHeGYWBJCaA@mail.gmail.com>
In-Reply-To: <CAOiHx=mYJm_mrwrDCuQ4ZEviPKLgWDqNcaSXPzaXHeGYWBJCaA@mail.gmail.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Sun, 13 Apr 2025 11:25:12 +0200
X-Gm-Features: ATxdqUGr1sHPIJAJqS4j0fS7KvaiCs3iVse3NbRGaHjOGUrakBsCO4TJU4Jf4Wc
Message-ID: <CAOiHx=mchprjNi8qQKsYzf18rE0NZxt-SjBRs9xnJEppcXUe7Q@mail.gmail.com>
Subject: Re: [PATCH RFC net 0/2] net: dsa: fix handling brentry vlans with flags
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <vladimir.oltean@nxp.com>, bridge@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 12, 2025 at 3:50=E2=80=AFPM Jonas Gorski <jonas.gorski@gmail.co=
m> wrote:
>
> On Sat, Apr 12, 2025 at 3:34=E2=80=AFPM Vladimir Oltean <olteanv@gmail.co=
m> wrote:
> >
> > On Sat, Apr 12, 2025 at 02:24:26PM +0200, Jonas Gorski wrote:
> > > While trying to figure out the hardware behavior of a DSA supported
> > > switch chip and printing various internal vlan state changes, I notic=
ed
> > > that some flows never triggered adding the cpu port to vlans, prevent=
ing
> > > it from receiving any of the VLANs traffic.
> > >
> > > E.g. the following sequence would cause the cpu port not being member=
 of
> > > the vlan, despite the bridge vlan output looking correct:
> > >
> > > $ ip link add swbridge type bridge vlan_filtering 1 vlan_default_pvid=
 1
> > > $ ip link set lan1 master swbridge
> >
> > At this step, dsa_port_bridge_join() -> switchdev_bridge_port_offload()
> > -> ... -> br_switchdev_port_offload() -> nbp_switchdev_sync_objs() ->
> > br_switchdev_vlan_replay() -> br_switchdev_vlan_replay_group(br_vlan_gr=
oup(br))
> > -> br_switchdev_vlan_replay_one() should have notified DSA, with change=
d=3Dfalse.
> > It should be processed by dsa_user_host_vlan_add() -> dsa_port_host_vla=
n_add().
> >
> > You make it sound like that doesn't happen.
>
> Yes, because I messed up writing down what I did. That should have
> been vlan_default_pvid 0 so there are no VLANs configured by default.
> >
> > I notice you didn't mention which "DSA supported chip" you are using.
> > By any chance, does its driver set ds->configure_vlan_while_not_filteri=
ng =3D false?
> > That would be my prime suspect, making dsa_port_skip_vlan_configuration=
() ignore
> > the code path above, because the bridge port is not yet VLAN filtering.
> > It becomes VLAN filtering only a bit later in dsa_port_bridge_join(),
> > with the dsa_port_switchdev_sync_attrs() -> dsa_port_vlan_filtering(br_=
vlan_enabled(br))
> > call.
> >
> > If that is the case, the only thing that is slightly confusing to me is
> > why you haven't seen the "skipping configuration of VLAN" extack messag=
e.
> > But anyway, if the theory above is true, you should instead be looking
> > at adding proper VLAN support to said driver, and drop this set instead=
,
> > because VLAN replay isn't working properly.
>
> It's b53, and on first glance it does not set it. But as I just
> noticed, I messed up the example.

So I had the chance to properly check and b53 does not unset it, so it
should be true.

> So adding the lan1 vid is supposed to be the very first vlan that is conf=
igured.
>
> >
> > > $ bridge vlan add dev lan1 vid 1 pvid untagged
> > > $ bridge vlan add dev swbridge vid 1 pvid untagged self
> > >
> > > Adding more printk debugging, I traced it br_vlan_add_existing() sett=
ing
> > > changed to true (since the vlan "gained" the pvid untagged flags), an=
d
> > > then the dsa code ignoring the vlan notification, since it is a vlan =
for
> > > the cpu port that is updated.
> >
> > Yes, this part and everything that follows should be correct.

So as an addendum that I probably should have included in the cover
letter and commit message:

Starting with no vlans configured on the bridge:

$ bridge vlan add dev lan1 vid 1 pvid untagged
$ bridge vlan add dev swbridge vid 1 pvid untagged self

does not work, but

$ bridge vlan add dev lan1 vid 1 pvid untagged
$ bridge vlan add dev swbridge vid 1 self

does properly trigger a configuration of the vlan on the cpu port.

And the difference is that in the former, would_change =3D>
vlan->changed is true (due to "pvid untagged"), and in the latter it
is not.

Best regards,
Jonas


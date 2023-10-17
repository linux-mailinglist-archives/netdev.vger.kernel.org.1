Return-Path: <netdev+bounces-41641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 065387CB817
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 03:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A229B20EA2
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 01:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A9F20EA;
	Tue, 17 Oct 2023 01:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xmr9PIp1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782E917E3
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 01:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A50C433C8;
	Tue, 17 Oct 2023 01:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697507115;
	bh=mAqRaQtVmSEdfKD/csl5OOYvPddFe5dMk2GavYV5T84=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xmr9PIp1Y2MjcrcmjM/hOYtNQlCpD8n2NW9c4h76/yoVo/Fh+8V0/man23geTi3g/
	 Fx1gEnOPiqHBDylFAZg/37oycqWs7Lhx5khv4k5Nv1oXk2VBghlc9PzABAadtWO6qw
	 ZMAL6sOXh7dKr6UaTfukwPzG3xUQ/IzIHBWHNTzQXvSY0gBsahEe6Zgqf0POwBnbZx
	 h8QDehXJoRSWL+1ki0nd3ToQoFAYMrPLxKeI62+eSNMYFRQf5QB/5oy/TO19m+4ieT
	 4bWDqGquZpnPvRaM1ZArD53Bz3S/GKTV0HMtS+jxub8/tX5gqZmlpao5cNG594K0QY
	 pL4TtZY4J5d3g==
Date: Mon, 16 Oct 2023 18:45:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel =?UTF-8?B?R3LDtmJlcg==?= <dxld@darkboxed.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, Richard Weinberger
 <richard@nod.at>, Serge Hallyn <serge.hallyn@canonical.com>, "Eric W.
 Biederman" <ebiederm@xmission.com>
Subject: Re: [BUG] rtnl_newlink: Rogue MOVE event delivered on netns change
Message-ID: <20231016184514.5dda6518@kernel.org>
In-Reply-To: <20231017012024.pp2riikutr54ini4@House.clients.dxld.at>
References: <20231010121003.x3yi6fihecewjy4e@House.clients.dxld.at>
	<20231013153605.487f5a74@kernel.org>
	<20231013154302.44cc197d@kernel.org>
	<2023101408-matador-stagnant-7cab@gregkh>
	<20231016073251.0f47d42b@kernel.org>
	<2023101632-circle-delegate-39dd@gregkh>
	<20231017012024.pp2riikutr54ini4@House.clients.dxld.at>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Oct 2023 03:20:24 +0200 Daniel Gr=C3=B6ber wrote:
> > 1. we have tb[IFLA_IFNAME] set, so do_setlink() will populate ifname
> >=20
> > 2. Because of #1, __dev_change_net_namespace() gets called with=20
> >    new name provide (pat =3D eth123)
> >=20
> > 3. It will do netdev_name_in_use(), which returns true. =20
>=20
> At this point we're still looking at the old netns, right?

New one, already. We got it from the caller and the caller
from rtnl_link_get_net_capable().

> > 7. Now we finally call:
> >=20
> >    err =3D device_rename(&dev->dev, dev->name);
> >=20
> > Which tells device core that the name has changed, and gives you=20
> > the (second) MOVE event. This time with the correct name. =20
>=20
> I don't like loose ends. Any idea why we only see the one MOVE now?

No, annoyingly I haven't. But I do have a host on 5.19.

[ ~]# uname -r
5.19.13-200.fc36.x86_64
[ ~]# ip netns add test
[ ~]# udevadm monitor -k &
[ ~]# ip li add name eth0 type dummy
KERNEL[67.377539] add      /module/dummy (module)
KERNEL[67.381720] add      /devices/virtual/net/eth0 (net)
KERNEL[67.381822] add      /devices/virtual/net/eth0/queues/rx-0 (queues)
KERNEL[67.381854] add      /devices/virtual/net/eth0/queues/tx-0 (queues)
[ ~]# ip -netns test li add name eth0 type dummy
[ ~]# ip -netns test link set dev eth0 netns 1 name eth1
KERNEL[99.681956] add      /devices/virtual/net/eth0 (net)
KERNEL[99.681975] move     /devices/virtual/net/eth1 (net)

I don't see it on older kernels either :S


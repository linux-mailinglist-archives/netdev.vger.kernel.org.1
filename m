Return-Path: <netdev+bounces-94941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD498C10AD
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 15:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 559C1B21DD7
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FC8158A21;
	Thu,  9 May 2024 13:53:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFF6156F5D
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 13:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715262782; cv=none; b=u5opXgl1DJJVcZssRy4heXX2qBCyK5TneHqUkuKVfKauFzwWr/M2ebZGlTrUklErovDpggvjIablpQlZrJStr1VHgn5tlg/rOzNf+Svk3ElU/1RsgxdLru8MMqO/XKLWe0FrdKiIfbiFbmLWI6X+qttWqRc5DM0db1Jo1ukISjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715262782; c=relaxed/simple;
	bh=MO18mheK6pTiUPcyvA5Zd6372ftLaYSV6m93A50flic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KIAaGvZq7/foAh61V+q+403C3mWtA03XKqYw4/lT+zraVTjIkaC2USL8ZkpLJTnPuIZywYOk5+HP1kYns3DnbfCf5q6Aj1K7IvtZyUMBx+/FIo0I9qhE67z0R71HCjkLJ6ISo7kWGobOfhvotrmorCxcGyfn/P/Hl20thYb3768=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-wjPbyup3PNumOijAIZoh4g-1; Thu,
 09 May 2024 09:52:55 -0400
X-MC-Unique: wjPbyup3PNumOijAIZoh4g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 31B173C0CD24;
	Thu,  9 May 2024 13:52:54 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F9331256E68;
	Thu,  9 May 2024 13:52:52 +0000 (UTC)
Date: Thu, 9 May 2024 15:52:51 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 04/24] ovpn: add basic interface
 creation/destruction/management routines
Message-ID: <ZjzVM1GXb5tkoqlB@hog>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-5-antonio@openvpn.net>
 <ZjuRqyZB0kMINqme@hog>
 <b6a6c29b-ad78-4d6f-be1a-93615f27c956@openvpn.net>
 <ZjygvCgXFfrA4GRN@hog>
 <1d31ca80-055e-4601-91b6-b0dc38b721c7@openvpn.net>
 <Zjy-jPqyKo-6clve@hog>
 <b537eb9d-ddab-4b39-bcea-2b8781507a8c@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b537eb9d-ddab-4b39-bcea-2b8781507a8c@openvpn.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-05-09, 15:25:21 +0200, Antonio Quartulli wrote:
> By the way, thank you very much for taking the time to have this
> constructive discussion. I really appreciate it!

Cheers :)


> On 09/05/2024 14:16, Sabrina Dubroca wrote:
> > 2024-05-09, 12:35:32 +0200, Antonio Quartulli wrote:
> > > On 09/05/2024 12:09, Sabrina Dubroca wrote:
> > > Hence I decided to fully trigger the unregistration.
> >=20
> > That's the bit that doesn't make sense to me: the device is going
> > away, so you trigger a manual unregister. Cleaning up some additional
> > resources (peers etc), that makes sense. But calling
> > unregister_netdevice (when you're most likely getting called from
> > unregister_netdevice already, because I don't see other spots setting
> > dev->reg_state =3D NETREG_UNREGISTERING) is what I don't get. And I
> > wonder why you're not hitting the BUG_ON in
> > unregister_netdevice_many_notify:
> >=20
> >      BUG_ON(dev->reg_state !=3D NETREG_REGISTERED);
>=20
> I think because we have our ovpn->registered check.
>
> It ensures that we don't call ovpn_iface_destruct more than once.

Ah, probably, yes.

> But now, that I implemented the rtnl_link_ops I can confirm I am hitting =
the
> BUG_ON. And now it makes sense.
>=20
> I presume that now I can I simply remove the call to unregister_netdevice=
()
> from ovpn_iface_destruct() and move it to ovpn_nl_del_iface_doit().

Sounds good.


> > > > Because you create your devices via genl (which I'm not a fan
> > > > of, even if it's a bit nicer for userspace having a single netlink =
api
> > > > to deal with),
> > >=20
> > > Originally I had implemented the rtnl_link_ops, but the (meaningful)
> > > objection was that a user is never supposed to create an ovpn iface b=
y
> > > himself, but there should always be an openvpn process running in use=
rspace.
> > > Hence the restriction to genl only.
> >=20
> > Sorry, but how does genl prevent a user from creating the ovpn
> > interface manually? Whatever API you define, anyone who manages to
> > come up with the right netlink message will be able to create an
> > interface. You can't stop people from using your API without your
> > official client.
>=20
> I don't want to prevent people from creating ovpn ifaces the way they lik=
e.
> I just don't see how the rtnl_link API can be useful, other than allowing
> users to execute 'ip link add/del..'.
>
> And by design that is not a usecase we want to support, because once the
> iface is created, nothing will happen if there is no userspace software
> driving it (no matter if it is openvpn or anything else).
>=20
> When explaining this decision, I like to make a comparison to virtual
> 802.11/wifi ifaces.
> They also lack rtnl_link (AFAIR) as they also require some userspace
> software to handle them in order to be useful.
>=20
> All this said, having everything in one place looks cleaner too :)

From an API point of view, maybe. But for the kernel implementation,
using rtnl_link_ops->newlink is easier.

> > > > default_device_exit_batch/default_device_exit_net think
> > > > ovpn devices are real NICs and move them back to init_net instead o=
f
> > > > destroying them.
> > > >=20
> > > > Maybe we can extend the condition in default_device_exit_net with a
> > > > new flag so that ovpn devices get destroyed by the core, even witho=
ut
> > > > rtnl_link_ops?
> > >=20
> > > Thanks for pointing out the function responsible for this decision.
> > > How would you extend the check though?
> > >=20
> > > Alternatively, what if ovpn simply registers an empty rtnl_link_ops w=
ith
> > > netns_fund set to false? That should make the condition happy, while =
keeping
> > > ovpn genl-only
> >=20
> > Yes. I was thinking about adding a flag to the device, because I
> > wasn't sure an almost empty rtnl_link_ops could be handled safely, but
> > it seems ok. ovs does it, see commit 5b9e7e160795 ("openvswitch:
> > introduce rtnl ops stub"). And, as that commit message says, "ip -d
> > link show" would also show that the device is of type openvpn (or
> > ovpn, whatever you put in ops->kind), which would be nice.
>=20
> I just coded something along those lines.

Great, thanks.

> It seems pretty clean and we don't need to touch core (+ the bonus of hav=
ing
> the name in "ip -d link")....and the iface does get destroyed upon netns
> exit! :-)
>=20
> I am grasping much better how all these APIs work together now.

Nice :)

--=20
Sabrina



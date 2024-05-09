Return-Path: <netdev+bounces-94900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 274478C0F75
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 14:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93B2B1F23099
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 12:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0814814B088;
	Thu,  9 May 2024 12:16:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2F214C581
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 12:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715256983; cv=none; b=QbEpeISlIu4muSyC/EDfZGkEd0snhD/HsoQWEhUEKmcL61jJoJqinEMAExeLTvpkuxb3ZCKWRcI0GaF95sCmsUk0DMzwtVDhjBRXrFpy8Jg7c74m5Wdsalf2x3goZl7F3/EnsAyt2i54ctXB3QPlXECTbQMJLJX1NTTRGun5hWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715256983; c=relaxed/simple;
	bh=TELd1+AKW+yVtxGnUXgXrG78NhaO9WZBfHMXPmLS6WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ewJrXCNjr7E0xIXoK5iaFu17K4cpdyi/flUDJaXEaHn4vrBhG5phCMqEsv0HVbIg3Vj/s1UdvA/ObofDbW4p9Y7N987qPffYIw8kdQRCBAchZ45EsNJ8posBbOhRt9DXMLzjZilbXWUuLa1rrJ2LiXDqZ88hOZV0F8/fQx28qTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-0mYVRwCpMAWSCnG1oSeilw-1; Thu,
 09 May 2024 08:16:16 -0400
X-MC-Unique: 0mYVRwCpMAWSCnG1oSeilw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 980CA3820EA4;
	Thu,  9 May 2024 12:16:15 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C9BB40C6EB7;
	Thu,  9 May 2024 12:16:13 +0000 (UTC)
Date: Thu, 9 May 2024 14:16:12 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 04/24] ovpn: add basic interface
 creation/destruction/management routines
Message-ID: <Zjy-jPqyKo-6clve@hog>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-5-antonio@openvpn.net>
 <ZjuRqyZB0kMINqme@hog>
 <b6a6c29b-ad78-4d6f-be1a-93615f27c956@openvpn.net>
 <ZjygvCgXFfrA4GRN@hog>
 <1d31ca80-055e-4601-91b6-b0dc38b721c7@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1d31ca80-055e-4601-91b6-b0dc38b721c7@openvpn.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-05-09, 12:35:32 +0200, Antonio Quartulli wrote:
> On 09/05/2024 12:09, Sabrina Dubroca wrote:
> > 2024-05-09, 10:25:44 +0200, Antonio Quartulli wrote:
> > > On 08/05/2024 16:52, Sabrina Dubroca wrote:
> > > > 2024-05-06, 03:16:17 +0200, Antonio Quartulli wrote:
> > > > >    static int ovpn_netdev_notifier_call(struct notifier_block *nb=
,
> > > > >    =09=09=09=09     unsigned long state, void *ptr)
> > > > >    {
> > > > >    =09struct net_device *dev =3D netdev_notifier_info_to_dev(ptr)=
;
> > > > > +=09struct ovpn_struct *ovpn;
> > > > >    =09if (!ovpn_dev_is_valid(dev))
> > > > >    =09=09return NOTIFY_DONE;
> > > > > +=09ovpn =3D netdev_priv(dev);
> > > > > +
> > > > >    =09switch (state) {
> > > > >    =09case NETDEV_REGISTER:
> > > > > -=09=09/* add device to internal list for later destruction upon
> > > > > -=09=09 * unregistration
> > > > > -=09=09 */
> > > > > +=09=09ovpn->registered =3D true;
> > > > >    =09=09break;
> > > > >    =09case NETDEV_UNREGISTER:
> > > > > +=09=09/* twiddle thumbs on netns device moves */
> > > > > +=09=09if (dev->reg_state !=3D NETREG_UNREGISTERING)
> > > > > +=09=09=09break;
> > > > > +
> > > > >    =09=09/* can be delivered multiple times, so check registered =
flag,
> > > > >    =09=09 * then destroy the interface
> > > > >    =09=09 */
> > > > > +=09=09if (!ovpn->registered)
> > > > > +=09=09=09return NOTIFY_DONE;
> > > > > +
> > > > > +=09=09ovpn_iface_destruct(ovpn);
> > > >=20
> > > > Maybe I'm misunderstanding this code. Why do you want to manually
> > > > destroy a device that is already going away?
> > >=20
> > > We need to perform some internal cleanup (i.e. release all peers).
> > > I don't see how this can happen automatically, no?
> >=20
> > That's what ->priv_destructor does,
>=20
> Not really.
>=20
> Every peer object increases the netdev refcounter to the netdev, therefor=
e
> we must first delete all peers in order to have netdevice->refcnt reach 0
> (and then invoke priv_destructor).

Oh, I see. I'm still trying to wrap my head around all the objects and
components of your driver.

> So the idea is: upon UNREGISTER event we drop all resources and eventuall=
y
> (via RCU) all references to the netdev are also released, which in turn
> triggers the destructor.
>=20
> makes sense?

That part, yes, thanks for explaining. Do you really need the peers to
hold a reference on the netdevice? With my limited understanding, it
seems the peers are sub-objects of the netdevice.

> > and it will be called ultimately
> > by the unregister_netdevice call you have in ovpn_iface_destruct (in
> > netdev_run_todo). Anyway, this UNREGISTER event is probably generated
> > by unregister_netdevice_many_notify (basically a previous
> > unregister_netdevice() call), so I don't know why you want to call
> > unregister_netdevice again on the same device.
>=20
> I believe I have seen this notification being triggered upon netns exit, =
but
> in that case the netdevice was not being removed from core.

Sure, but you have a comment about that and you're filtering that
event, so I'm ignoring this case.

> Hence I decided to fully trigger the unregistration.

That's the bit that doesn't make sense to me: the device is going
away, so you trigger a manual unregister. Cleaning up some additional
resources (peers etc), that makes sense. But calling
unregister_netdevice (when you're most likely getting called from
unregister_netdevice already, because I don't see other spots setting
dev->reg_state =3D NETREG_UNREGISTERING) is what I don't get. And I
wonder why you're not hitting the BUG_ON in
unregister_netdevice_many_notify:

    BUG_ON(dev->reg_state !=3D NETREG_REGISTERED);


> > > > > @@ -62,6 +210,24 @@ static struct notifier_block ovpn_netdev_noti=
fier =3D {
> > > > >    =09.notifier_call =3D ovpn_netdev_notifier_call,
> > > > >    };
> > > > > +static void ovpn_netns_pre_exit(struct net *net)

BTW, in case you end up keeping this function, it should have
__net_exit annotation (see for example ipv4_frags_exit_net).

> > > > > +{
> > > > > +=09struct ovpn_struct *ovpn;
> > > > > +
> > > > > +=09rtnl_lock();
> > > > > +=09list_for_each_entry(ovpn, &dev_list, dev_list) {
> > > > > +=09=09if (dev_net(ovpn->dev) !=3D net)
> > > > > +=09=09=09continue;
> > > > > +
> > > > > +=09=09ovpn_iface_destruct(ovpn);
> > > >=20
> > > > Is this needed? On netns destruction all devices within the ns will=
 be
> > > > destroyed by the networking core.
> > >=20
> > > Before implementing ovpn_netns_pre_exit() this way, upon namespace de=
letion
> > > the ovpn interface was being moved to the global namespace.
> >=20
> > Crap it's only the devices with ->rtnl_link_ops that get killed by the
> > core.
>=20
> exactly! this goes hand to hand with my comment above: event delivered bu=
t
> interface not destroyed.

There's no event sent to ovpn_netdev_notifier_call in that case (well,
only the fake "unregister" out of the current netns that you're
ignoring). Otherwise, you wouldn't need ovpn_netns_pre_exit.

> > Because you create your devices via genl (which I'm not a fan
> > of, even if it's a bit nicer for userspace having a single netlink api
> > to deal with),
>=20
> Originally I had implemented the rtnl_link_ops, but the (meaningful)
> objection was that a user is never supposed to create an ovpn iface by
> himself, but there should always be an openvpn process running in userspa=
ce.
> Hence the restriction to genl only.

Sorry, but how does genl prevent a user from creating the ovpn
interface manually? Whatever API you define, anyone who manages to
come up with the right netlink message will be able to create an
interface. You can't stop people from using your API without your
official client.

> > default_device_exit_batch/default_device_exit_net think
> > ovpn devices are real NICs and move them back to init_net instead of
> > destroying them.
> >=20
> > Maybe we can extend the condition in default_device_exit_net with a
> > new flag so that ovpn devices get destroyed by the core, even without
> > rtnl_link_ops?
>=20
> Thanks for pointing out the function responsible for this decision.
> How would you extend the check though?
>
> Alternatively, what if ovpn simply registers an empty rtnl_link_ops with
> netns_fund set to false? That should make the condition happy, while keep=
ing
> ovpn genl-only

Yes. I was thinking about adding a flag to the device, because I
wasn't sure an almost empty rtnl_link_ops could be handled safely, but
it seems ok. ovs does it, see commit 5b9e7e160795 ("openvswitch:
introduce rtnl ops stub"). And, as that commit message says, "ip -d
link show" would also show that the device is of type openvpn (or
ovpn, whatever you put in ops->kind), which would be nice.

--=20
Sabrina



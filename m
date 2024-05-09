Return-Path: <netdev+bounces-94858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7323F8C0DFA
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 12:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84E911C2110B
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 10:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E836514AD14;
	Thu,  9 May 2024 10:09:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8EF14A4FF
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 10:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715249357; cv=none; b=uG+tSGOEcZiJ/w4VLOrooon7ZMh4Oy9PIFKD7IaXUMr9CBtS0lYR9CXw9miBbLNBfRRj5QNS8mdhxSwu6uaJZvBFOYeBjwTEECh70C/BaibOBM7+22KTqtJl5z2VP18nZnw16HbPYE4YJYc42OJhHGeYi2Czr1Z2REpoVjGx4S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715249357; c=relaxed/simple;
	bh=Szz2WxrTEgN97//PYlaMdCl+ZNNQuRaW2dNxA8/Zgv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=O/5gwcOHSnuyAHSaRy3TDPYsJ/ZbGeDiRfd5dUbbvayWewbaUUTX1M+FXpsh0cni22MMOGxHok/UFQZeYi/Ok2BTaUS7Emrkwofrb7o0ivETZ+VZWnRJkF3yw6hK5KP8kDop/5VWJJh0Y3MS9KhgQZUYcyt+CbDLIbe/ae1NJ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-sELZQplUOXCA3OaNWreScw-1; Thu, 09 May 2024 06:09:02 -0400
X-MC-Unique: sELZQplUOXCA3OaNWreScw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68C38185A783;
	Thu,  9 May 2024 10:09:02 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 34A6F5ADC42;
	Thu,  9 May 2024 10:09:01 +0000 (UTC)
Date: Thu, 9 May 2024 12:09:00 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 04/24] ovpn: add basic interface
 creation/destruction/management routines
Message-ID: <ZjygvCgXFfrA4GRN@hog>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-5-antonio@openvpn.net>
 <ZjuRqyZB0kMINqme@hog>
 <b6a6c29b-ad78-4d6f-be1a-93615f27c956@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b6a6c29b-ad78-4d6f-be1a-93615f27c956@openvpn.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-05-09, 10:25:44 +0200, Antonio Quartulli wrote:
> On 08/05/2024 16:52, Sabrina Dubroca wrote:
> > 2024-05-06, 03:16:17 +0200, Antonio Quartulli wrote:
> > > diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
> > > index 33c0b004ce16..584cd7286aff 100644
> > > --- a/drivers/net/ovpn/main.c
> > > +++ b/drivers/net/ovpn/main.c
> > [...]
> > > +static void ovpn_struct_free(struct net_device *net)
> > > +{
> > > +=09struct ovpn_struct *ovpn =3D netdev_priv(net);
> > > +
> > > +=09rtnl_lock();
> >=20
> >   ->priv_destructor can run from register_netdevice (already under
> > RTNL), this doesn't look right.
> >=20
> > > +=09list_del(&ovpn->dev_list);
> >=20
> > And if this gets called from register_netdevice, the list_add from
> > ovpn_iface_create hasn't run yet, so this will probably do strange
> > things?
>=20
> Argh, again I haven't considered a failure in register_netdevice and you =
are
> indeed right.
>=20
> Maybe it is better to call list_del() in the netdev notifier, upon
> NETDEV_UNREGISTER event?

I'd like to avoid splitting the clean up code over so maybe different
functions and called through different means. Keep it simple.

AFAICT the only reason you need this list is to delete your devices on
netns exit, so if we can get rid of that the list can go away.


> > > +static int ovpn_net_open(struct net_device *dev)
> > > +{
> > > +=09struct in_device *dev_v4 =3D __in_dev_get_rtnl(dev);
> > > +
> > > +=09if (dev_v4) {
> > > +=09=09/* disable redirects as Linux gets confused by ovpn handling
> > > +=09=09 * same-LAN routing
> > > +=09=09 */
> > > +=09=09IN_DEV_CONF_SET(dev_v4, SEND_REDIRECTS, false);
> > > +=09=09IPV4_DEVCONF_ALL(dev_net(dev), SEND_REDIRECTS) =3D false;
> >=20
> > Jakub, are you ok with that? This feels a bit weird to have in the
> > middle of a driver.
>=20
> Let me share what the problem is (copied from the email I sent to Andrew
> Lunn as he was also curious about this):
>=20
> The reason for requiring this setting lies in the OpenVPN server acting a=
s
> relay point (star topology) for hosts in the same subnet.
>=20
> Example: given the a.b.c.0/24 IP network, you have .2 that in order to ta=
lk
> to .3 must have its traffic relayed by .1 (the server).
>=20
> When the kernel (at .1) sees this traffic it will send the ICMP redirects=
,
> because it believes that .2 should directly talk to .3 without passing
> through .1.

So only the server would need to stop sending them, not the client?
(or the client would need to ignore them)
But the kernel has no way of knowing if an ovpn device is on a client
or a server?

> Of course it makes sense in a normal network with a classic broadcast
> domain, but this is not the case in a VPN implemented as a star topology.
>=20
> Does it make sense?

It looks like the problem is that ovpn links are point-to-point
(instead of a broadcast LAN kind of link where redirects would make
sense), and the kernel doesn't handle it that way.

> The only way I see to fix this globally is to have an extra flag in the
> netdevice signaling this peculiarity and thus disabling ICMP redirects
> automatically.
>=20
> Note: wireguard has those lines too, as it probably needs to address the
> same scenario.

I've noticed a lot of similarities in some bits I've looked at, and I
hate that this is turning into another pile of duplicate code like
vxlan/geneve, bond/team, etc :(


> > [...]
> > > +void ovpn_iface_destruct(struct ovpn_struct *ovpn)
> > > +{
> > > +=09ASSERT_RTNL();
> > > +
> > > +=09netif_carrier_off(ovpn->dev);
> > > +
> > > +=09ovpn->registered =3D false;
> > > +
> > > +=09unregister_netdevice(ovpn->dev);
> > > +=09synchronize_net();
> >=20
> > If this gets called from the loop in ovpn_netns_pre_exit, one
> > synchronize_net per ovpn device would seem quite expensive.
>=20
> As per your other comment, maybe I should just remove the synchronize_net=
()
> entirely since it'll be the core to take care of inflight packets?

There's a synchronize_net in unregister_netdevice_many_notify, so I'd
say you can get rid of it here.


> > >   static int ovpn_netdev_notifier_call(struct notifier_block *nb,
> > >   =09=09=09=09     unsigned long state, void *ptr)
> > >   {
> > >   =09struct net_device *dev =3D netdev_notifier_info_to_dev(ptr);
> > > +=09struct ovpn_struct *ovpn;
> > >   =09if (!ovpn_dev_is_valid(dev))
> > >   =09=09return NOTIFY_DONE;
> > > +=09ovpn =3D netdev_priv(dev);
> > > +
> > >   =09switch (state) {
> > >   =09case NETDEV_REGISTER:
> > > -=09=09/* add device to internal list for later destruction upon
> > > -=09=09 * unregistration
> > > -=09=09 */
> > > +=09=09ovpn->registered =3D true;
> > >   =09=09break;
> > >   =09case NETDEV_UNREGISTER:
> > > +=09=09/* twiddle thumbs on netns device moves */
> > > +=09=09if (dev->reg_state !=3D NETREG_UNREGISTERING)
> > > +=09=09=09break;
> > > +
> > >   =09=09/* can be delivered multiple times, so check registered flag,
> > >   =09=09 * then destroy the interface
> > >   =09=09 */
> > > +=09=09if (!ovpn->registered)
> > > +=09=09=09return NOTIFY_DONE;
> > > +
> > > +=09=09ovpn_iface_destruct(ovpn);
> >=20
> > Maybe I'm misunderstanding this code. Why do you want to manually
> > destroy a device that is already going away?
>=20
> We need to perform some internal cleanup (i.e. release all peers).
> I don't see how this can happen automatically, no?

That's what ->priv_destructor does, and it will be called ultimately
by the unregister_netdevice call you have in ovpn_iface_destruct (in
netdev_run_todo). Anyway, this UNREGISTER event is probably generated
by unregister_netdevice_many_notify (basically a previous
unregister_netdevice() call), so I don't know why you want to call
unregister_netdevice again on the same device.


> > > @@ -62,6 +210,24 @@ static struct notifier_block ovpn_netdev_notifier=
 =3D {
> > >   =09.notifier_call =3D ovpn_netdev_notifier_call,
> > >   };
> > > +static void ovpn_netns_pre_exit(struct net *net)
> > > +{
> > > +=09struct ovpn_struct *ovpn;
> > > +
> > > +=09rtnl_lock();
> > > +=09list_for_each_entry(ovpn, &dev_list, dev_list) {
> > > +=09=09if (dev_net(ovpn->dev) !=3D net)
> > > +=09=09=09continue;
> > > +
> > > +=09=09ovpn_iface_destruct(ovpn);
> >=20
> > Is this needed? On netns destruction all devices within the ns will be
> > destroyed by the networking core.
>=20
> Before implementing ovpn_netns_pre_exit() this way, upon namespace deleti=
on
> the ovpn interface was being moved to the global namespace.

Crap it's only the devices with ->rtnl_link_ops that get killed by the
core. Because you create your devices via genl (which I'm not a fan
of, even if it's a bit nicer for userspace having a single netlink api
to deal with), default_device_exit_batch/default_device_exit_net think
ovpn devices are real NICs and move them back to init_net instead of
destroying them.

Maybe we can extend the condition in default_device_exit_net with a
new flag so that ovpn devices get destroyed by the core, even without
rtnl_link_ops?

--=20
Sabrina



Return-Path: <netdev+bounces-111894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E27AB933FCE
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 17:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDDF21C20C94
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 15:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675BF181B9F;
	Wed, 17 Jul 2024 15:37:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530F3181310
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 15:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721230645; cv=none; b=dF3wR4XZp+enhf92mDa6elpmptRNL7O1t/RqxJXchQzUii/wC8w7RJkAKgx3GvDaJyiSBlGmPO0p8qYoljNevJQ2aStt4TQGQs0VF9na09ggjL3vLtuFLdkAaKIeFA8w5BqkyH2Iz5FfpdnCPeVhEZclFoNxf36rh9t3byRd2vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721230645; c=relaxed/simple;
	bh=BJQgO9W2lrGVl3TaUJKWuwdslA/OLCv4lbbZqaoPfjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=cBtT4JFuFOWlu7dQULYtIK9vBth9kTL5ahKummVNQTV2wx2If/GwsbwMkKmmPmvIwTNTMIU8effkb+fzw8BFYPNhBPkT7oJXzxe95O4WUcpxpWsHYnJwHID6dGhoPxPD2d8wnzlEzOTj+QEhR87QCVKkqOG+sxEZWb9pagcW5bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-bUIsXBbiPrat0ucZgUzFjg-1; Wed,
 17 Jul 2024 11:37:11 -0400
X-MC-Unique: bUIsXBbiPrat0ucZgUzFjg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DFB1A18B63D1;
	Wed, 17 Jul 2024 15:37:06 +0000 (UTC)
Received: from hog (unknown [10.39.192.3])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6BDBA1955F3B;
	Wed, 17 Jul 2024 15:37:03 +0000 (UTC)
Date: Wed, 17 Jul 2024 17:37:00 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com
Cc: netdev@vger.kernel.org, ryazanov.s.a@gmail.com, andrew@lunn.ch
Subject: Re: [PATCH net-next v5 20/25] ovpn: implement peer add/dump/delete
 via netlink
Message-ID: <ZpflHPMK5tDlfXQw@hog>
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-21-antonio@openvpn.net>
 <ZpZ4cF7hLTIxBiej@hog>
 <3a6ce780-4532-4823-a326-d10e09688894@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3a6ce780-4532-4823-a326-d10e09688894@openvpn.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-07-17, 16:04:25 +0200, Antonio Quartulli wrote:
> On 16/07/2024 15:41, Sabrina Dubroca wrote:
> > 2024-06-27, 15:08:38 +0200, Antonio Quartulli wrote:
> > > +=09if (attrs[OVPN_A_PEER_SOCKET]) {
> > > +=09=09/* lookup the fd in the kernel table and extract the socket
> > > +=09=09 * object
> > > +=09=09 */
> > > +=09=09sockfd =3D nla_get_u32(attrs[OVPN_A_PEER_SOCKET]);
> > > +=09=09/* sockfd_lookup() increases sock's refcounter */
> > > +=09=09sock =3D sockfd_lookup(sockfd, &ret);
> > > +=09=09if (!sock) {
> > > +=09=09=09NL_SET_ERR_MSG_FMT_MOD(info->extack,
> > > +=09=09=09=09=09       "cannot lookup peer socket (fd=3D%u): %d",
> > > +=09=09=09=09=09       sockfd, ret);
> > > +=09=09=09ret =3D -ENOTSOCK;
> > > +=09=09=09goto peer_release;
> > > +=09=09}
> > > +
> > > +=09=09if (peer->sock)
> > > +=09=09=09ovpn_socket_put(peer->sock);
> > > +
> > > +=09=09peer->sock =3D ovpn_socket_new(sock, peer);
> > > +=09=09if (IS_ERR(peer->sock)) {
> > > +=09=09=09NL_SET_ERR_MSG_FMT_MOD(info->extack,
> > > +=09=09=09=09=09       "cannot encapsulate socket: %ld",
> > > +=09=09=09=09=09       PTR_ERR(peer->sock));
> > > +=09=09=09sockfd_put(sock);
> > > +=09=09=09peer->sock =3D NULL;
> >=20
> > Is there any value for the client in keeping the old peer->sock
> > assigned if we fail here?
> >=20
> > ie something like:
> >=20
> >      tmp =3D ovpn_socket_new(sock, peer);
> >      if (IS_ERR(tmp)) {
> >          ...
> >          goto peer_release;
> >      }
> >      if (peer->sock)
> >          ovpn_socket_put(peer->sock);
> >      peer->sock =3D tmp;
> >=20
> >=20
> > But if it's just going to get rid of the old socket and the whole
> > association/peer on failure, probably not.
>=20
> Right. if attaching the new socket fails, we are entering some broken sta=
tus
> which is not worth keeping around.

Ok, then the current code is fine, thanks.


> > > +=09/* Only when using UDP as transport protocol the remote endpoint
> > > +=09 * can be configured so that ovpn knows where to send packets
> > > +=09 * to.
> > > +=09 *
> > > +=09 * In case of TCP, the socket is connected to the peer and ovpn
> > > +=09 * will just send bytes over it, without the need to specify a
> > > +=09 * destination.
> >=20
> > (that should also work with UDP "connected" sockets)
>=20
> True, but those are not used in openvpn. In case of UDP, userspace just
> creates one socket and uses it for all peers.
> I will add a note about 'connected UDP socket' in the comment, to clear t=
his
> out.

If you want. I was being pedantic, I don't think it's really necessary
to mention this.


> > > +=09=09=09=09goto peer_release;
> > > +=09=09=09}
> > > +=09=09}
> > > +
> > > +=09=09/* set peer sockaddr */
> > > +=09=09ret =3D ovpn_peer_reset_sockaddr(peer, ss, local_ip);
> > > +=09=09if (ret < 0) {
> > > +=09=09=09NL_SET_ERR_MSG_FMT_MOD(info->extack,
> > > +=09=09=09=09=09       "cannot set peer sockaddr: %d",
> > > +=09=09=09=09=09       ret);
> > > +=09=09=09goto peer_release;
> > > +=09=09}
> > > +=09}
> >=20
> > I would reject OVPN_A_PEER_SOCKADDR_REMOTE for a non-UDP socket.
>=20
> judging from the comments below, it seems you prefer to reject unneeded
> attributes. OTOH I took the opposite approach (just ignore those).

Yes.

> However, I was actually looking for some preference/indication regarding
> this point and I now I got one :-)

I don't think there's an established rule, and a lot of the old code
is very tolerant. That's my preference (in part because I think
refusing bogus combinations allows to enable them in the future with a
new behavior), but maybe the maintainers have a different opinion?
OTOH ignoring those attributes can let a modern client run on an old
kernel (possibly without some features, depending on what the
attribute is).

(leaving a few other examples of stricter validation for context:)

> I will be strict and return -EINVAL when unneded attributes are present.
>=20
> >=20
> >=20
> > > +=09/* VPN IPs cannot be updated, because they are hashed */
> >=20
> > Then I think there should be something like
> >=20
> >      if (!new_peer && (attrs[OVPN_A_PEER_VPN_IPV4] || attrs[OVPN_A_PEER=
_VPN_IPV6])) {
> >          NL_SET_ERR_MSG_FMT_MOD(... "can't update ip");
> >          ret =3D -EINVAL;
> >          goto peer_release;
> >      }
> >=20
> > (just after getting the peer, before any changes have actually been
> > made)
>=20
> ACK
>=20
> >=20
> > And if they are only used in MP mode, I would maybe also reject
> > requests where mode=3D=3DP2P and OVPN_A_PEER_VPN_IPV* is provided.
>=20
> yup, like I commented above.
>=20
> >=20
> >=20
> > > +=09if (new_peer && attrs[OVPN_A_PEER_VPN_IPV4])
> > > +=09=09peer->vpn_addrs.ipv4.s_addr =3D
> > > +=09=09=09nla_get_in_addr(attrs[OVPN_A_PEER_VPN_IPV4]);
> > > +
> > > +=09/* VPN IPs cannot be updated, because they are hashed */
> > > +=09if (new_peer && attrs[OVPN_A_PEER_VPN_IPV6])
> > > +=09=09peer->vpn_addrs.ipv6 =3D
> > > +=09=09=09nla_get_in6_addr(attrs[OVPN_A_PEER_VPN_IPV6]);
> > > +
> > > +=09/* when setting the keepalive, both parameters have to be configu=
red */
> >=20
> > Then I would also reject a config where only one is set (also before an=
y
> > changes have been made).
>=20
> ok


[...]
> > > +=09if (attrs[OVPN_A_PEER_KEEPALIVE_INTERVAL] &&
> > > +=09    attrs[OVPN_A_PEER_KEEPALIVE_TIMEOUT]) {
> > > +=09=09keepalive_set =3D true;
> > > +=09=09interv =3D nla_get_u32(attrs[OVPN_A_PEER_KEEPALIVE_INTERVAL]);
> > > +=09=09timeout =3D nla_get_u32(attrs[OVPN_A_PEER_KEEPALIVE_TIMEOUT]);
> > > +=09}
> > > +
> > > +=09if (keepalive_set)
> > > +=09=09ovpn_peer_keepalive_set(peer, interv, timeout);
> >=20
> > Why not skip the bool and just do this in the previous block?
>=20
> I am pretty sure there was a reason...but it may have faded away after th=
e
> 95-th rebase hehe. Thanks for spotting this!

:)

>=20
> >=20
> > > +=09netdev_dbg(ovpn->dev,
> > > +=09=09   "%s: %s peer with endpoint=3D%pIScp/%s id=3D%u VPN-IPv4=3D%=
pI4 VPN-IPv6=3D%pI6c\n",
> > > +=09=09   __func__, (new_peer ? "adding" : "modifying"), ss,
> > > +=09=09   peer->sock->sock->sk->sk_prot_creator->name, peer->id,
> > > +=09=09   &peer->vpn_addrs.ipv4.s_addr, &peer->vpn_addrs.ipv6);
> > > +
> > > +=09if (new_peer) {
> > > +=09=09ret =3D ovpn_peer_add(ovpn, peer);
> > > +=09=09if (ret < 0) {
> > > +=09=09=09NL_SET_ERR_MSG_FMT_MOD(info->extack,
> > > +=09=09=09=09=09       "cannot add new peer (id=3D%u) to hashtable: %=
d\n",
> > > +=09=09=09=09=09       peer->id, ret);
> > > +=09=09=09goto peer_release;
> > > +=09=09}
> > > +=09} else {
> > > +=09=09ovpn_peer_put(peer);
> > > +=09}
> > > +
> > > +=09return 0;
> > > +
> > > +peer_release:
> > > +=09if (new_peer) {
> > > +=09=09/* release right away because peer is not really used in any
> > > +=09=09 * context
> > > +=09=09 */
> > > +=09=09ovpn_peer_release(peer);
> > > +=09=09kfree(peer);
> >=20
> > I don't think that's correct, the new peer was created with
> > ovpn_peer_new, so it took a reference on the netdevice
> > (netdev_hold(ovpn->dev, ...)), which isn't released by
> > ovpn_peer_release. Why not just go through ovpn_peer_put?
>=20
> Because then we would send the notification to userspace, but it is not
> correct to do so, because the new() is just about to return an error.

Oh, right.

> I presume I should just move netdev_put(peer->ovpn->dev, NULL); to
> ovpn_peer_release(). That will take care of this case too.

Ok.


--=20
Sabrina



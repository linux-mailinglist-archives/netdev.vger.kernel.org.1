Return-Path: <netdev+bounces-112062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE683934C40
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 13:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AB50B21215
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 11:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D8812AAC6;
	Thu, 18 Jul 2024 11:12:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FEA4D8A1
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 11:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721301147; cv=none; b=i3M7gf/jGGDxQv/mXVUd5gbULtMG6uLlmiCCO/XLB0YhSWhbRgj9N2Fs+fhI6qOirS058rHOYuRE2wQe6JhDai61Zrof2M5l/qLgyxbLYS/f4uzVK8rjRpwD/QV3HjiTf8txwU4cWZ6uKIR3dU2vWOgeoUAXY99WsOddwTzUAbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721301147; c=relaxed/simple;
	bh=8yRQhLv/8roERMbHAxm6Kq1jmhwX14n/70pbMrRoI/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=iVmepBbjlTZUaePNGxJj+1qlnffvjCN5VSv8mYldLoCK1D6r7n0nZgeHtuTs/BB42k3tmfEuFgmLFfdB3huCWJCjeCWVg+JCEuB/vYXMeOxolTv2aO+eByrR2JGxIjpfPYt0vJTkpxqx7FJCv6KmrJTk5LdBR/KEEWEQcd2+I44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-om821kRLPO6KestQSPOvtA-1; Thu,
 18 Jul 2024 07:12:20 -0400
X-MC-Unique: om821kRLPO6KestQSPOvtA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 68A6E1955D54;
	Thu, 18 Jul 2024 11:12:19 +0000 (UTC)
Received: from hog (unknown [10.39.192.3])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 800693000188;
	Thu, 18 Jul 2024 11:12:16 +0000 (UTC)
Date: Thu, 18 Jul 2024 13:12:14 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, ryazanov.s.a@gmail.com,
	pabeni@redhat.com, edumazet@google.com, andrew@lunn.ch
Subject: Re: [PATCH net-next v5 19/25] ovpn: add support for peer floating
Message-ID: <Zpj4jqhGMGPG-6Kq@hog>
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-20-antonio@openvpn.net>
 <Zpf8I5HdJFgehunO@hog>
 <5d49ef6c-ad35-4199-b5af-0caae5a04e85@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5d49ef6c-ad35-4199-b5af-0caae5a04e85@openvpn.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-07-18, 11:37:38 +0200, Antonio Quartulli wrote:
> On 17/07/2024 19:15, Sabrina Dubroca wrote:
> > 2024-06-27, 15:08:37 +0200, Antonio Quartulli wrote:
> > > +void ovpn_peer_float(struct ovpn_peer *peer, struct sk_buff *skb)
> > > +{
> > > +=09struct sockaddr_storage ss;
> > > +=09const u8 *local_ip =3D NULL;
> > > +=09struct sockaddr_in6 *sa6;
> > > +=09struct sockaddr_in *sa;
> > > +=09struct ovpn_bind *bind;
> > > +=09sa_family_t family;
> > > +=09size_t salen;
> > > +
> > > +=09rcu_read_lock();
> > > +=09bind =3D rcu_dereference(peer->bind);
> > > +=09if (unlikely(!bind))
> > > +=09=09goto unlock;
> >=20
> > Why are you aborting here? ovpn_bind_skb_src_match considers
> > bind=3D=3DNULL to be "no match" (reasonable), then we would create a ne=
w
> > bind for the current address.
>=20
> (NOTE: float and the following explanation assume connection via UDP)
>=20
> peer->bind is assigned right after peer creation in ovpn_nl_set_peer_doit=
().
>=20
> ovpn_peer_float() is called while the peer is exchanging traffic.
>=20
> If we got to this point and bind is NULL, then the peer was being release=
d,
> because there is no way we are going to NULLify bind during the peer life
> cycle, except upon ovpn_peer_release().
>=20
> Does it make sense?

Alright, thanks, I missed that.


> > > +=09if (likely(ovpn_bind_skb_src_match(bind, skb)))
> >=20
> > This could be running in parallel on two CPUs, because ->encap_rcv
> > isn't protected against that. So the bind could be getting updated in
> > parallel. I would move spin_lock_bh above this check to make sure it
> > doesn't happen.
>=20
> hm, I should actually use peer->lock for this, which is currently only us=
ed
> in ovpn_bind_reset() to avoid multiple concurrent assignments...but you'r=
e
> right we should include the call to skb_src_check() as well.

Ok, sounds good.

> > ovpn_peer_update_local_endpoint would also need something like that, I
> > think.
>=20
> at least the test-and-set part should be protected, if we can truly invok=
e
> ovpn_peer_update_local_endpoint() multiple times concurrently.

Yes.

> How do I test running encap_rcv in parallel?
> This is actually an interesting case that I thought to not be possible (n=
o
> specific reason for this..).

It should happen when the packets come from different source IPs and
the NIC has multiple queues, then they can be spread over different
CPUs. But it's probably not going to be easy to land multiple packets
in ovpn_peer_float at the same time to trigger this issue.


> > > +=09netdev_dbg(peer->ovpn->dev, "%s: peer %d floated to %pIScp", __fu=
nc__,
> > > +=09=09   peer->id, &ss);
> > > +=09ovpn_peer_reset_sockaddr(peer, (struct sockaddr_storage *)&ss,
> > > +=09=09=09=09 local_ip);
> > > +
> > > +=09spin_lock_bh(&peer->ovpn->peers->lock);
> > > +=09/* remove old hashing */
> > > +=09hlist_del_init_rcu(&peer->hash_entry_transp_addr);
> > > +=09/* re-add with new transport address */
> > > +=09hlist_add_head_rcu(&peer->hash_entry_transp_addr,
> > > +=09=09=09   ovpn_get_hash_head(peer->ovpn->peers->by_transp_addr,
> > > +=09=09=09=09=09      &ss, salen));
> >=20
> > That could send a concurrent reader onto the wrong hash bucket, if
> > it's going through peer's old bucket, finds peer before the update,
> > then continues reading after peer is moved to the new bucket.
>=20
> I haven't fully grasped this scenario.
> I am imagining we are running ovpn_peer_get_by_transp_addr() in parallel:
> reader gets the old bucket and finds peer, because ovpn_peer_transp_match=
()
> will still return true (update wasn't performed yet), and will return it.

The other reader isn't necessarily looking for peer, but maybe another
item that landed in the same bucket (though your hashtables are so
large, it would be a bit unlucky).

> At this point, what do you mean with "continues reading after peer is mov=
ed
> to the new bucket"?

Continues iterating, in hlist_for_each_entry_rcu inside
ovpn_peer_get_by_transp_addr.

ovpn_peer_float                          ovpn_peer_get_by_transp_addr

                                         start lookup
                                         head =3D ovpn_get_hash_head(...)
                                         hlist_for_each_entry_rcu
                                         ...
                                         find peer on head

peer moved from head to head2

                                         continue hlist_for_each_entry_rcu =
with peer->next
                                         but peer->next is now on head2
                                         keep walking ->next on head2 inste=
ad of head

--=20
Sabrina



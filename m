Return-Path: <netdev+bounces-95943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D85FF8C3E35
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 11:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B683281F24
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 09:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777F31474B1;
	Mon, 13 May 2024 09:36:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F0453398
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 09:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715593015; cv=none; b=W4/TdJjMLZh8FrNKsiVbc+PvpaaFMCXFTL1yu6S20pTUCgFq3DGn7XQ8ho8FGjMDNlB646D+Gi8hjcNmfA3A+jAVtB1jLoIdQymKKwu4Mv6/xx0lKwBDjmleHd5QG2W5ERsMo/00S/JRKRxr6i9qdfVIq4RX9bNqvq3zT7C66rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715593015; c=relaxed/simple;
	bh=NJhgzsWZRJVsYO5SWnYBu3WkIWy49govnXd7Z7CErnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=BhSeH+CgNAvpG17irpTbthBg30Ue8fX886LxeZ6VQDzdNXoXtv1c+BQ3qPoNphiYcenXSoyk643M7lt8rR7VTqTAXhFW6T7gsF8kC01cyFJ1mFwZSqk2sVBnx5R4JvoYGb7aCOnusIB1uj8rHheJV57XtwRUrlGjVvWrCnKETnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-8T-8oHxDO2S5VrVeXl3WDw-1; Mon, 13 May 2024 05:36:48 -0400
X-MC-Unique: 8T-8oHxDO2S5VrVeXl3WDw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B4D0185A78E;
	Mon, 13 May 2024 09:36:48 +0000 (UTC)
Received: from hog (unknown [10.39.192.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0141A2BA;
	Mon, 13 May 2024 09:36:46 +0000 (UTC)
Date: Mon, 13 May 2024 11:36:45 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 09/24] ovpn: implement basic TX path (UDP)
Message-ID: <ZkHfLWPJAznta1A4@hog>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-10-antonio@openvpn.net>
 <ZkE2JmBCj-yJ3xYK@hog>
 <2d707980-72d1-49d1-a9e8-f794fcc590cb@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2d707980-72d1-49d1-a9e8-f794fcc590cb@openvpn.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-05-13, 09:37:06 +0200, Antonio Quartulli wrote:
> On 12/05/2024 23:35, Sabrina Dubroca wrote:
> > 2024-05-06, 03:16:22 +0200, Antonio Quartulli wrote:
> > > +/* send skb to connected peer, if any */
> > > +static void ovpn_queue_skb(struct ovpn_struct *ovpn, struct sk_buff =
*skb,
> > > +=09=09=09   struct ovpn_peer *peer)
> > > +{
> > > +=09int ret;
> > > +
> > > +=09if (likely(!peer))
> > > +=09=09/* retrieve peer serving the destination IP of this packet */
> > > +=09=09peer =3D ovpn_peer_get_by_dst(ovpn, skb);
> > > +=09if (unlikely(!peer)) {
> > > +=09=09net_dbg_ratelimited("%s: no peer to send data to\n",
> > > +=09=09=09=09    ovpn->dev->name);
> > > +=09=09goto drop;
> > > +=09}
> > > +
> > > +=09ret =3D ptr_ring_produce_bh(&peer->tx_ring, skb);
> > > +=09if (unlikely(ret < 0)) {
> > > +=09=09net_err_ratelimited("%s: cannot queue packet to TX ring\n",
> > > +=09=09=09=09    peer->ovpn->dev->name);
> > > +=09=09goto drop;
> > > +=09}
> > > +
> > > +=09if (!queue_work(ovpn->crypto_wq, &peer->encrypt_work))
> > > +=09=09ovpn_peer_put(peer);
> >=20
> > I wanted to come back to this after going through the crypto patch,
> > because this felt like a strange construct when I first looked at this
> > patch.
> >=20
> > Why are you using a workqueue here? Based on the kdoc for crypto_wq
> > ("used to schedule crypto work that may sleep during TX/RX"), it's to
> > deal with async crypto.
> >=20
> > If so, why not use the more standard way of dealing with async crypto
> > in contexts that cannot sleep, ie letting the crypto core call the
> > "done" callback asynchronously? You need to do all the proper refcount
> > handling, but IMO it's cleaner and simpler than this workqueue and
> > ptr_ring. You can see an example of that in macsec (macsec_encrypt_*
> > in drivers/net/macsec.c).
>=20
> Aha! You don't know how happy I was when I found the doc describing how t=
o
> convert the async code into sync-looking :-) With the detail that I had t=
o
> move to a different context, as the code may want to sleep (hence the
> introduction of the workqueue).
>=20
> It looks like I am little fan of WQs, while you are telling me to avoid t=
hem
> if possible.

I'm mainly trying to simplify the code (get rid of some ptr_rings, get
rid of some ping-pong between functions and changes of context,
etc). And here, I'm also trying to make it look more like other
similar pieces of code, because I'm already familiar with a few kernel
implementations of protocols doing crypto (macsec, ipsec, tls).

> I presume that using WQs comes with a non-negligible cost, therefore if w=
e
> can just get things done without having to use them, then I should just
> don't.

If you're using AESNI for your GCM implementation, the crypto API will
also be using a workqueue (see crypto/cryptd.c), but only when the
crypto can't be done immediately (ie, when the FPU is already busing).

In the case of crypto accelerators, there might be benefits from
queueing multiple requests and then letting them live their life,
instead of waiting for each request separately. I don't have access to
that HW so I cannot test this.

> I think I could go back to no-workqueue encrypt/decrypt.
> Do you think this may have any impact on any future multi-core optimizati=
on?
> Back then I also thought that going through workers may make improvements=
 in
> this area easier. But I could just be wrong.

Without thinking about it too deeply, the workqueue looks more like a
bottleneck that a no-workqueue approach just wouldn't have. You would
probably need per-CPU WQs (probably separated for encrypt and
decrypt). cryptd_enqueue_request (crypto/cryptd.c) has an example of
that.

--=20
Sabrina



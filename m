Return-Path: <netdev+bounces-110168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE60292B2A0
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 10:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4B84281A6B
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 08:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA16314831C;
	Tue,  9 Jul 2024 08:53:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B6A13DB9B
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 08:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720515184; cv=none; b=aN9EakQ2Flh9foyVGQKtdwn5OS+QCN2Q5rzQ9Emn3wBfMPu8t6ZUFWth18ZcYUsj+etFOnffrYHwq7AYznv7lbXVD12/mgCJHayRUOb7jyKZP5OsBW7TLps0kEKSbMthNs/XenIowwQ6GQPL5dr8BgSOdGNdtvElKnybGbdy08g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720515184; c=relaxed/simple;
	bh=vOb7JPqhD/PWCmwpMbQyb5PNLGoibxnBBV7vMkT7wk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=aWVkL49avXPdF5m8AaYUQs6A+QUdPJ3CC4wzc7ElZuiO8cUZjlR0TvnfGBDYeWuksS5daSWxPcMKoVctUv97xDQikU8dkgxkmmWzeAfrvANzWPn7IpI5IdwtOSr/JZsHL8ApvZFrq77eywfS5gd7bCFaCPhUtXym2bfTFXcvphw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-j2syhXpXNxS6De8SC9Vv0w-1; Tue,
 09 Jul 2024 04:51:39 -0400
X-MC-Unique: j2syhXpXNxS6De8SC9Vv0w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C1471955F45;
	Tue,  9 Jul 2024 08:51:38 +0000 (UTC)
Received: from hog (unknown [10.39.192.70])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5DD7C3000185;
	Tue,  9 Jul 2024 08:51:34 +0000 (UTC)
Date: Tue, 9 Jul 2024 10:51:33 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, ryazanov.s.a@gmail.com,
	pabeni@redhat.com, edumazet@google.com, andrew@lunn.ch
Subject: Re: [PATCH net-next v5 12/25] ovpn: implement packet processing
Message-ID: <Zoz6FdiZ64bQhU0c@hog>
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-13-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240627130843.21042-13-antonio@openvpn.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-06-27, 15:08:30 +0200, Antonio Quartulli wrote:
> +/* removes the primary key from the crypto context */
> +void ovpn_crypto_kill_primary(struct ovpn_crypto_state *cs)
> +{
> +=09struct ovpn_crypto_key_slot *ks;
> +
> +=09mutex_lock(&cs->mutex);
> +=09ks =3D rcu_replace_pointer(cs->primary, NULL,
> +=09=09=09=09 lockdep_is_held(&cs->mutex));

Should there be a check that we're killing the key that has expired
and not some other key?  I'm wondering if this could happen:

ovpn_encrypt_one
    ovpn_aead_encrypt
        ovpn_pktid_xmit_next
            seq_num reaches threshold
            returns -ERANGE
        returns -ERANGE

                                            ovpn_crypto_key_slots_swap
                                                replaces cs->primary with c=
s->secondary

    ovpn_encrypt_post
        ret =3D -ERANGE
        ovpn_crypto_kill_primary
            kills the freshly installed primary key

> +=09ovpn_crypto_key_slot_put(ks);
> +=09mutex_unlock(&cs->mutex);
> +}
> +

[...]
> +static void ovpn_aead_encrypt_done(void *data, int ret)
> +{
> +=09struct sk_buff *skb =3D data;
> +
> +=09aead_request_free(ovpn_skb_cb(skb)->req);
> +=09ovpn_encrypt_post(skb, ret);
> +}
> +
> +int ovpn_aead_encrypt(struct ovpn_crypto_key_slot *ks, struct sk_buff *s=
kb,
> +=09=09      u32 peer_id)
> +{
> +=09const unsigned int tag_size =3D crypto_aead_authsize(ks->encrypt);
> +=09const unsigned int head_size =3D ovpn_aead_encap_overhead(ks);
> +=09struct scatterlist sg[MAX_SKB_FRAGS + 2];
> +=09DECLARE_CRYPTO_WAIT(wait);

unused? (also in _decrypt)

[...]
> +
> +=09req =3D aead_request_alloc(ks->encrypt, GFP_ATOMIC);
> +=09if (unlikely(!req))
> +=09=09return -ENOMEM;
> +
> +=09/* setup async crypto operation */
> +=09aead_request_set_tfm(req, ks->encrypt);
> +=09aead_request_set_callback(req, 0, ovpn_aead_encrypt_done, NULL);

NULL? That should be skb, ovpn_aead_encrypt_done needs it (same for
decrypt).

I suspect you haven't triggered the async path in testing. For that,
you can use crconf:

git clone https://git.code.sf.net/p/crconf/code
cd code && make
./src/crconf add driver 'pcrypt(generic-gcm-aesni)' type 3  priority 10000

Then all packets encrypted with gcm(aes) should go through the async
code.

> +=09aead_request_set_crypt(req, sg, sg, skb->len - head_size, iv);
> +=09aead_request_set_ad(req, OVPN_OP_SIZE_V2 + NONCE_WIRE_SIZE);
> +
> +=09ovpn_skb_cb(skb)->req =3D req;
> +=09ovpn_skb_cb(skb)->ks =3D ks;
> +
> +=09/* encrypt it */
> +=09return crypto_aead_encrypt(req);
> +}

[...]
> @@ -77,14 +133,45 @@ static void ovpn_decrypt_post(struct sk_buff *skb, i=
nt ret)
>  /* pick next packet from RX queue, decrypt and forward it to the device =
*/
>  void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb)
>  {
> +=09struct ovpn_crypto_key_slot *ks;
> +=09u8 key_id;
> +
> +=09/* get the key slot matching the key ID in the received packet */
> +=09key_id =3D ovpn_key_id_from_skb(skb);
> +=09ks =3D ovpn_crypto_key_id_to_slot(&peer->crypto, key_id);

This takes a reference on the keyslot (ovpn_crypto_key_slot_hold), but
I don't see it getting released in ovpn_decrypt_post. In
ovpn_encrypt_post you're adding a ovpn_crypto_key_slot_put (to match
ovpn_crypto_key_slot_primary), but nothing equivalent in
ovpn_decrypt_post?

> +=09if (unlikely(!ks)) {
> +=09=09net_info_ratelimited("%s: no available key for peer %u, key-id: %u=
\n",
> +=09=09=09=09     peer->ovpn->dev->name, peer->id, key_id);
> +=09=09dev_core_stats_rx_dropped_inc(peer->ovpn->dev);
> +=09=09kfree_skb(skb);
> +=09=09return;
> +=09}
> +
>  =09ovpn_skb_cb(skb)->peer =3D peer;
> -=09ovpn_decrypt_post(skb, 0);
> +=09ovpn_decrypt_post(skb, ovpn_aead_decrypt(ks, skb));
>  }

--=20
Sabrina



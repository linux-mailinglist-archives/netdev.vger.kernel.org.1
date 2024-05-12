Return-Path: <netdev+bounces-95760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AF78C35C2
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 10:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8390D1C2080C
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 08:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80F114F98;
	Sun, 12 May 2024 08:46:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7684F1C01
	for <netdev@vger.kernel.org>; Sun, 12 May 2024 08:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715503598; cv=none; b=AA+7SEpKDMVsfcACGCB2YJLRrthWRHp/iUWZFyPQxQE146GfslLhs6DWwChg4y36ahN7bNCSi6CyUUlkLfBVXEMahQUaATqqvhh0x1wPKx2UCf5tIDkuh6bCtaf80zuV9lOBYic44WQjyh8CfH+jL/wsFldFeZkwyjHPneq/RZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715503598; c=relaxed/simple;
	bh=qdPrnl5sjqCRX5Sf/ryDSn376wrIr/wE4JOt5kUyL/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=eOxNEHQULFuoov9KU7T2svLw8ayUh3CFKNxzkhvY3R9RU/Uc/GocLLYg9T+ZNDjXpU4W5S4pAaeBiyj30/QEDpx2VNlDZPSRwiHLycDybWgElIJONcNpKPAQ6MxpDgyO64LmF0uuntH8mRS+r+IS5YRVAb5H81Qou8frgDvyRNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-W_jrCTjrOqKTjosJqSxTrw-1; Sun, 12 May 2024 04:46:22 -0400
X-MC-Unique: W_jrCTjrOqKTjosJqSxTrw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A410080021D;
	Sun, 12 May 2024 08:46:21 +0000 (UTC)
Received: from hog (unknown [10.39.192.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C8CFE40C6EB7;
	Sun, 12 May 2024 08:46:19 +0000 (UTC)
Date: Sun, 12 May 2024 10:46:18 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 11/24] ovpn: implement packet processing
Message-ID: <ZkCB2sFnpIluo3wm@hog>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-12-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240506011637.27272-12-antonio@openvpn.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-05-06, 03:16:24 +0200, Antonio Quartulli wrote:
> diff --git a/drivers/net/ovpn/bind.c b/drivers/net/ovpn/bind.c
> index c1f842c06e32..7240d1036fb7 100644
> --- a/drivers/net/ovpn/bind.c
> +++ b/drivers/net/ovpn/bind.c
> @@ -13,6 +13,7 @@
>  #include "ovpnstruct.h"
>  #include "io.h"
>  #include "bind.h"
> +#include "packet.h"
>  #include "peer.h"

You have a few hunks like that in this patch, adding an include to a
file that is otherwise not being modified. That's odd.

> diff --git a/drivers/net/ovpn/crypto.c b/drivers/net/ovpn/crypto.c
> new file mode 100644
> index 000000000000..98ef1ceb75e0
> --- /dev/null
> +++ b/drivers/net/ovpn/crypto.c
> @@ -0,0 +1,162 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*  OpenVPN data channel offload
> + *
> + *  Copyright (C) 2020-2024 OpenVPN, Inc.
> + *
> + *  Author:=09James Yonan <james@openvpn.net>
> + *=09=09Antonio Quartulli <antonio@openvpn.net>
> + */
> +
> +#include <linux/types.h>
> +#include <linux/net.h>
> +#include <linux/netdevice.h>
> +//#include <linux/skbuff.h>

That's also odd :)


[...]
> +/* Reset the ovpn_crypto_state object in a way that is atomic
> + * to RCU readers.
> + */
> +int ovpn_crypto_state_reset(struct ovpn_crypto_state *cs,
> +=09=09=09    const struct ovpn_peer_key_reset *pkr)
> +=09__must_hold(cs->mutex)
> +{
> +=09struct ovpn_crypto_key_slot *old =3D NULL;
> +=09struct ovpn_crypto_key_slot *new;
> +
> +=09lockdep_assert_held(&cs->mutex);
> +
> +=09new =3D ovpn_aead_crypto_key_slot_new(&pkr->key);

This doesn't need the lock to be held, you could move the lock to a
smaller section (only around the pointer swap).

> +=09if (IS_ERR(new))
> +=09=09return PTR_ERR(new);
> +
> +=09switch (pkr->slot) {
> +=09case OVPN_KEY_SLOT_PRIMARY:
> +=09=09old =3D rcu_replace_pointer(cs->primary, new,
> +=09=09=09=09=09  lockdep_is_held(&cs->mutex));
> +=09=09break;
> +=09case OVPN_KEY_SLOT_SECONDARY:
> +=09=09old =3D rcu_replace_pointer(cs->secondary, new,
> +=09=09=09=09=09  lockdep_is_held(&cs->mutex));
> +=09=09break;
> +=09default:
> +=09=09goto free_key;

And validating pkr->slot before alloc could avoid a pointless
alloc/free (and simplify the code: once _new() has succeeded, no
failure can occur anymore).

> +=09}
> +
> +=09if (old)
> +=09=09ovpn_crypto_key_slot_put(old);
> +
> +=09return 0;
> +free_key:
> +=09ovpn_crypto_key_slot_put(new);
> +=09return -EINVAL;
> +}
> +
> +void ovpn_crypto_key_slot_delete(struct ovpn_crypto_state *cs,
> +=09=09=09=09 enum ovpn_key_slot slot)
> +{
> +=09struct ovpn_crypto_key_slot *ks =3D NULL;
> +
> +=09mutex_lock(&cs->mutex);
> +=09switch (slot) {
> +=09case OVPN_KEY_SLOT_PRIMARY:
> +=09=09ks =3D rcu_replace_pointer(cs->primary, NULL,
> +=09=09=09=09=09 lockdep_is_held(&cs->mutex));
> +=09=09break;
> +=09case OVPN_KEY_SLOT_SECONDARY:
> +=09=09ks =3D rcu_replace_pointer(cs->secondary, NULL,
> +=09=09=09=09=09 lockdep_is_held(&cs->mutex));
> +=09=09break;
> +=09default:
> +=09=09pr_warn("Invalid slot to release: %u\n", slot);
> +=09=09break;
> +=09}
> +=09mutex_unlock(&cs->mutex);
> +
> +=09if (!ks) {
> +=09=09pr_debug("Key slot already released: %u\n", slot);

This will also be printed in case of an invalid argument, which would
be mildly confusing.

> +=09=09return;
> +=09}
> +=09pr_debug("deleting key slot %u, key_id=3D%u\n", slot, ks->key_id);
> +
> +=09ovpn_crypto_key_slot_put(ks);
> +}


> +static struct ovpn_crypto_key_slot *
> +ovpn_aead_crypto_key_slot_init(enum ovpn_cipher_alg alg,
> +=09=09=09       const unsigned char *encrypt_key,
> +=09=09=09       unsigned int encrypt_keylen,
> +=09=09=09       const unsigned char *decrypt_key,
> +=09=09=09       unsigned int decrypt_keylen,
> +=09=09=09       const unsigned char *encrypt_nonce_tail,
> +=09=09=09       unsigned int encrypt_nonce_tail_len,
> +=09=09=09       const unsigned char *decrypt_nonce_tail,
> +=09=09=09       unsigned int decrypt_nonce_tail_len,
> +=09=09=09       u16 key_id)
> +{
[...]
> +
> +=09if (sizeof(struct ovpn_nonce_tail) !=3D encrypt_nonce_tail_len ||
> +=09    sizeof(struct ovpn_nonce_tail) !=3D decrypt_nonce_tail_len) {
> +=09=09ret =3D -EINVAL;
> +=09=09goto destroy_ks;
> +=09}

Those checks could be done earlier, before bothering with any
allocations.

> +
> +=09memcpy(ks->nonce_tail_xmit.u8, encrypt_nonce_tail,
> +=09       sizeof(struct ovpn_nonce_tail));
> +=09memcpy(ks->nonce_tail_recv.u8, decrypt_nonce_tail,
> +=09       sizeof(struct ovpn_nonce_tail));
> +
> +=09/* init packet ID generation/validation */
> +=09ovpn_pktid_xmit_init(&ks->pid_xmit);
> +=09ovpn_pktid_recv_init(&ks->pid_recv);
> +
> +=09return ks;
> +
> +destroy_ks:
> +=09ovpn_aead_crypto_key_slot_destroy(ks);
> +=09return ERR_PTR(ret);
> +}
> +
> +struct ovpn_crypto_key_slot *
> +ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc)
> +{
> +=09return ovpn_aead_crypto_key_slot_init(kc->cipher_alg,
> +=09=09=09=09=09      kc->encrypt.cipher_key,
> +=09=09=09=09=09      kc->encrypt.cipher_key_size,
> +=09=09=09=09=09      kc->decrypt.cipher_key,
> +=09=09=09=09=09      kc->decrypt.cipher_key_size,
> +=09=09=09=09=09      kc->encrypt.nonce_tail,
> +=09=09=09=09=09      kc->encrypt.nonce_tail_size,
> +=09=09=09=09=09      kc->decrypt.nonce_tail,
> +=09=09=09=09=09      kc->decrypt.nonce_tail_size,
> +=09=09=09=09=09      kc->key_id);
> +}

Why the wrapper? You could just call ovpn_aead_crypto_key_slot_init
directly.

> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
> index 9935a863bffe..66a4c551c191 100644
> --- a/drivers/net/ovpn/io.c
> +++ b/drivers/net/ovpn/io.c
> @@ -110,6 +114,27 @@ int ovpn_napi_poll(struct napi_struct *napi, int bud=
get)
>  =09return work_done;
>  }
> =20
> +/* Return IP protocol version from skb header.
> + * Return 0 if protocol is not IPv4/IPv6 or cannot be read.
> + */
> +static __be16 ovpn_ip_check_protocol(struct sk_buff *skb)

nit: if you put this function higher up in the patch that introduced
it, you wouldn't have to move it now

> +{
> +=09__be16 proto =3D 0;
> +
> +=09/* skb could be non-linear, make sure IP header is in non-fragmented
> +=09 * part
> +=09 */
> +=09if (!pskb_network_may_pull(skb, sizeof(struct iphdr)))
> +=09=09return 0;
> +
> +=09if (ip_hdr(skb)->version =3D=3D 4)
> +=09=09proto =3D htons(ETH_P_IP);
> +=09else if (ip_hdr(skb)->version =3D=3D 6)
> +=09=09proto =3D htons(ETH_P_IPV6);
> +
> +=09return proto;
> +}
> +
>  /* Entry point for processing an incoming packet (in skb form)
>   *
>   * Enqueue the packet and schedule RX consumer.
> @@ -132,7 +157,81 @@ int ovpn_recv(struct ovpn_struct *ovpn, struct ovpn_=
peer *peer,
> =20
>  static int ovpn_decrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
>  {
> -=09return true;

I missed that in the RX patch, true isn't an int :)
Were you intending this function to be bool like ovpn_encrypt_one?
Since you're not actually using the returned value in the caller, it
would be reasonable, but you'd have to convert all the <0 error values
to bool.

> +=09struct ovpn_peer *allowed_peer =3D NULL;
> +=09struct ovpn_crypto_key_slot *ks;
> +=09__be16 proto;
> +=09int ret =3D -1;
> +=09u8 key_id;
> +
> +=09/* get the key slot matching the key Id in the received packet */
> +=09key_id =3D ovpn_key_id_from_skb(skb);
> +=09ks =3D ovpn_crypto_key_id_to_slot(&peer->crypto, key_id);
> +=09if (unlikely(!ks)) {
> +=09=09net_info_ratelimited("%s: no available key for peer %u, key-id: %u=
\n",
> +=09=09=09=09     peer->ovpn->dev->name, peer->id, key_id);
> +=09=09goto drop;
> +=09}
> +
> +=09/* decrypt */
> +=09ret =3D ovpn_aead_decrypt(ks, skb);
> +
> +=09ovpn_crypto_key_slot_put(ks);
> +
> +=09if (unlikely(ret < 0)) {
> +=09=09net_err_ratelimited("%s: error during decryption for peer %u, key-=
id %u: %d\n",
> +=09=09=09=09    peer->ovpn->dev->name, peer->id, key_id,
> +=09=09=09=09    ret);
> +=09=09goto drop;
> +=09}
> +
> +=09/* check if this is a valid datapacket that has to be delivered to th=
e
> +=09 * tun interface

s/tun/ovpn/ ?

> +=09 */
> +=09skb_reset_network_header(skb);
> +=09proto =3D ovpn_ip_check_protocol(skb);
> +=09if (unlikely(!proto)) {
> +=09=09/* check if null packet */
> +=09=09if (unlikely(!pskb_may_pull(skb, 1))) {
> +=09=09=09netdev_dbg(peer->ovpn->dev,
> +=09=09=09=09   "NULL packet received from peer %u\n",
> +=09=09=09=09   peer->id);
> +=09=09=09ret =3D -EINVAL;
> +=09=09=09goto drop;
> +=09=09}
> +
> +=09=09netdev_dbg(peer->ovpn->dev,
> +=09=09=09   "unsupported protocol received from peer %u\n",
> +=09=09=09   peer->id);
> +
> +=09=09ret =3D -EPROTONOSUPPORT;
> +=09=09goto drop;
> +=09}
> +=09skb->protocol =3D proto;
> +
> +=09/* perform Reverse Path Filtering (RPF) */
> +=09allowed_peer =3D ovpn_peer_get_by_src(peer->ovpn, skb);
> +=09if (unlikely(allowed_peer !=3D peer)) {
> +=09=09if (skb_protocol_to_family(skb) =3D=3D AF_INET6)
> +=09=09=09net_warn_ratelimited("%s: RPF dropped packet from peer %u, src:=
 %pI6c\n",
> +=09=09=09=09=09     peer->ovpn->dev->name, peer->id,
> +=09=09=09=09=09     &ipv6_hdr(skb)->saddr);
> +=09=09else
> +=09=09=09net_warn_ratelimited("%s: RPF dropped packet from peer %u, src:=
 %pI4\n",
> +=09=09=09=09=09     peer->ovpn->dev->name, peer->id,
> +=09=09=09=09=09     &ip_hdr(skb)->saddr);
> +=09=09ret =3D -EPERM;
> +=09=09goto drop;
> +=09}

Have you considered holding rcu_read_lock around this whole RPF check?
It would avoid taking a reference on the peer just to release it 3
lines later. And the same could likely be done for some of the other
ovpn_peer_get_* lookups too.


> +=09ret =3D ptr_ring_produce_bh(&peer->netif_rx_ring, skb);
> +drop:
> +=09if (likely(allowed_peer))
> +=09=09ovpn_peer_put(allowed_peer);
> +
> +=09if (unlikely(ret < 0))
> +=09=09kfree_skb(skb);
> +
> +=09return ret;

Mixing the drop/success returns looks kind of strange. This would be a
bit simpler:

ovpn_peer_put(allowed_peer);
return ptr_ring_produce_bh(&peer->netif_rx_ring, skb);

drop:
if (allowed_peer)
    ovpn_peer_put(allowed_peer);
kfree_skb(skb);
return ret;


> diff --git a/drivers/net/ovpn/packet.h b/drivers/net/ovpn/packet.h
> index 7ed146f5932a..e14c9bf464f7 100644
> --- a/drivers/net/ovpn/packet.h
> +++ b/drivers/net/ovpn/packet.h
> @@ -10,7 +10,7 @@
>  #ifndef _NET_OVPN_PACKET_H_
>  #define _NET_OVPN_PACKET_H_
> =20
> -/* When the OpenVPN protocol is ran in AEAD mode, use
> +/* When the OpenVPN protocol is run in AEAD mode, use

nit: that typo came in earlier

--=20
Sabrina



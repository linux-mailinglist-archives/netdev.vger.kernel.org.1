Return-Path: <netdev+bounces-124228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E417968A2F
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 16:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB1BF28153D
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 14:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128B01A263C;
	Mon,  2 Sep 2024 14:42:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD43C1A263B
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 14:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725288146; cv=none; b=ImMG75CBAvujHFi+u/rivnTqL9E6s4sz7EVPHs2iFW04g9FSI/vGRinDhCYW8KbeXYTWAu4mxTepzKw3AhKzZnGhgnD02CzIM0+OemDaBDr4kPMQWruJWVj/aefRoWDUxsyK8I1V7eYrH+HWKZKJaBFtNnQ0kHctrqhPyuAQ9aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725288146; c=relaxed/simple;
	bh=CBjJXaJHkPaOmiVub7IJIw1tk+jdsKr/fN9mo4PchH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gv5I1SDygRcTJYn+3Eu2SHtgrTd8eqTcl5/q7+5OdHP+veruxOTA2pZDa85BCdVapMD9uSCpcvC2nCclLONTgjJov6BVc8fyaVoNrPQCZYU7FQEjbInZ1UwdPBI1HWyJl7mmHsDDF8KmR1mmcFbU5IJHBG1DglA6ifVm6prCtOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-DpiiGd5FO3y45qkjqLUakg-1; Mon,
 02 Sep 2024 10:42:18 -0400
X-MC-Unique: DpiiGd5FO3y45qkjqLUakg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D736719560BF;
	Mon,  2 Sep 2024 14:42:16 +0000 (UTC)
Received: from hog (unknown [10.39.192.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B697C1956048;
	Mon,  2 Sep 2024 14:42:13 +0000 (UTC)
Date: Mon, 2 Sep 2024 16:42:11 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	ryazanov.s.a@gmail.com, edumazet@google.com, andrew@lunn.ch
Subject: Re: [PATCH net-next v6 12/25] ovpn: implement packet processing
Message-ID: <ZtXOw-NcL9lvwWa8@hog>
References: <20240827120805.13681-1-antonio@openvpn.net>
 <20240827120805.13681-13-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240827120805.13681-13-antonio@openvpn.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-08-27, 14:07:52 +0200, Antonio Quartulli wrote:
> +/* this swap is not atomic, but there will be a very short time frame wh=
ere the

Since we're under a mutex, I think we might get put to sleep for a
not-so-short time frame.

> + * old_secondary key won't be available. This should not be a big deal a=
s most

I could be misreading the code, but isn't it old_primary that's
unavailable during the swap? rcu_replace_pointer overwrites
cs->primary, so before the final assign, both slots contain
old_secondary?

> + * likely both peers are already using the new primary at this point.
> + */
> +void ovpn_crypto_key_slots_swap(struct ovpn_crypto_state *cs)
> +{
> +=09const struct ovpn_crypto_key_slot *old_primary, *old_secondary;
> +
> +=09mutex_lock(&cs->mutex);
> +
> +=09old_secondary =3D rcu_dereference_protected(cs->secondary,
> +=09=09=09=09=09=09  lockdep_is_held(&cs->mutex));
> +=09old_primary =3D rcu_replace_pointer(cs->primary, old_secondary,
> +=09=09=09=09=09  lockdep_is_held(&cs->mutex));
> +=09rcu_assign_pointer(cs->secondary, old_primary);
> +
> +=09pr_debug("key swapped: %u <-> %u\n",
> +=09=09 old_primary ? old_primary->key_id : 0,
> +=09=09 old_secondary ? old_secondary->key_id : 0);
> +
> +=09mutex_unlock(&cs->mutex);
> +}

[...]
> +int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slo=
t *ks,
> +=09=09      struct sk_buff *skb)
> +{
> +=09const unsigned int tag_size =3D crypto_aead_authsize(ks->encrypt);
> +=09const unsigned int head_size =3D ovpn_aead_encap_overhead(ks);
> +=09DECLARE_CRYPTO_WAIT(wait);

nit: unused

> +=09struct aead_request *req;
> +=09struct sk_buff *trailer;
> +=09struct scatterlist *sg;
> +=09u8 iv[NONCE_SIZE];
> +=09int nfrags, ret;
> +=09u32 pktid, op;
> +
> +=09/* Sample AEAD header format:
> +=09 * 48000001 00000005 7e7046bd 444a7e28 cc6387b1 64a4d6c1 380275a...
> +=09 * [ OP32 ] [seq # ] [             auth tag            ] [ payload ..=
. ]
> +=09 *          [4-byte
> +=09 *          IV head]
> +=09 */
> +
> +=09/* check that there's enough headroom in the skb for packet
> +=09 * encapsulation, after adding network header and encryption overhead
> +=09 */
> +=09if (unlikely(skb_cow_head(skb, OVPN_HEAD_ROOM + head_size)))
> +=09=09return -ENOBUFS;
> +
> +=09/* get number of skb frags and ensure that packet data is writable */
> +=09nfrags =3D skb_cow_data(skb, 0, &trailer);
> +=09if (unlikely(nfrags < 0))
> +=09=09return nfrags;
> +
> +=09if (unlikely(nfrags + 2 > (MAX_SKB_FRAGS + 2)))
> +=09=09return -ENOSPC;
> +
> +=09ovpn_skb_cb(skb)->ctx =3D kmalloc(sizeof(*ovpn_skb_cb(skb)->ctx),
> +=09=09=09=09=09GFP_ATOMIC);
> +=09if (unlikely(!ovpn_skb_cb(skb)->ctx))
> +=09=09return -ENOMEM;

I think you should clear skb->cb (or at least ->ctx) at the start of
ovpn_aead_encrypt. I don't think it will be cleaned up by the previous
user, and if we fail before this alloc, we will possibly have bogus
values in ->ctx when we get to kfree(ovpn_skb_cb(skb)->ctx) at the end
of ovpn_encrypt_post.

(Similar comments around cb/ctx freeing and initialization apply to
ovpn_aead_decrypt and ovpn_decrypt_post)

> +=09sg =3D ovpn_skb_cb(skb)->ctx->sg;
> +
> +=09/* sg table:
> +=09 * 0: op, wire nonce (AD, len=3DOVPN_OP_SIZE_V2+NONCE_WIRE_SIZE),
> +=09 * 1, 2, 3, ..., n: payload,
> +=09 * n+1: auth_tag (len=3Dtag_size)
> +=09 */
> +=09sg_init_table(sg, nfrags + 2);
> +
> +=09/* build scatterlist to encrypt packet payload */
> +=09ret =3D skb_to_sgvec_nomark(skb, sg + 1, 0, skb->len);
> +=09if (unlikely(nfrags !=3D ret)) {
> +=09=09kfree(sg);

This is the only location in this function (and ovpn_encrypt_post)
that frees sg. Is that correct? sg points to an array contained within
->ctx, I don't think you want to free that directly.

> +=09=09return -EINVAL;
> +=09}
> +
> +=09/* append auth_tag onto scatterlist */
> +=09__skb_push(skb, tag_size);
> +=09sg_set_buf(sg + nfrags + 1, skb->data, tag_size);
> +
> +=09/* obtain packet ID, which is used both as a first
> +=09 * 4 bytes of nonce and last 4 bytes of associated data.
> +=09 */
> +=09ret =3D ovpn_pktid_xmit_next(&ks->pid_xmit, &pktid);
> +=09if (unlikely(ret < 0)) {
> +=09=09kfree(ovpn_skb_cb(skb)->ctx);

Isn't that going to cause a double-free when we get to the end of
ovpn_encrypt_post? Or even UAF when we try to get ks/peer at the
start?

> +=09=09return ret;
> +=09}
> +
> +=09/* concat 4 bytes packet id and 8 bytes nonce tail into 12 bytes
> +=09 * nonce
> +=09 */
> +=09ovpn_pktid_aead_write(pktid, &ks->nonce_tail_xmit, iv);
> +
> +=09/* make space for packet id and push it to the front */
> +=09__skb_push(skb, NONCE_WIRE_SIZE);
> +=09memcpy(skb->data, iv, NONCE_WIRE_SIZE);
> +
> +=09/* add packet op as head of additional data */
> +=09op =3D ovpn_opcode_compose(OVPN_DATA_V2, ks->key_id, peer->id);
> +=09__skb_push(skb, OVPN_OP_SIZE_V2);
> +=09BUILD_BUG_ON(sizeof(op) !=3D OVPN_OP_SIZE_V2);
> +=09*((__force __be32 *)skb->data) =3D htonl(op);
> +
> +=09/* AEAD Additional data */
> +=09sg_set_buf(sg, skb->data, OVPN_OP_SIZE_V2 + NONCE_WIRE_SIZE);
> +
> +=09req =3D aead_request_alloc(ks->encrypt, GFP_ATOMIC);
> +=09if (unlikely(!req)) {
> +=09=09kfree(ovpn_skb_cb(skb)->ctx);

Same here.

> +=09=09return -ENOMEM;
> +=09}
> +
> +=09/* setup async crypto operation */
> +=09aead_request_set_tfm(req, ks->encrypt);
> +=09aead_request_set_callback(req, 0, ovpn_aead_encrypt_done, skb);
> +=09aead_request_set_crypt(req, sg, sg, skb->len - head_size, iv);
> +=09aead_request_set_ad(req, OVPN_OP_SIZE_V2 + NONCE_WIRE_SIZE);
> +
> +=09ovpn_skb_cb(skb)->ctx->peer =3D peer;
> +=09ovpn_skb_cb(skb)->ctx->req =3D req;
> +=09ovpn_skb_cb(skb)->ctx->ks =3D ks;
> +
> +=09/* encrypt it */
> +=09return crypto_aead_encrypt(req);
> +}
> +
> +static void ovpn_aead_decrypt_done(void *data, int ret)
> +{
> +=09struct sk_buff *skb =3D data;
> +
> +=09aead_request_free(ovpn_skb_cb(skb)->ctx->req);

This function only gets called in the async case. Where's the
corresponding aead_request_free in the sync case? (same for encrypt)
This should be moved into ovpn_decrypt_post, I think.

> +=09ovpn_decrypt_post(skb, ret);
> +}
> +
> +int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slo=
t *ks,
> +=09=09      struct sk_buff *skb)
> +{
> +=09const unsigned int tag_size =3D crypto_aead_authsize(ks->decrypt);
> +=09int ret, payload_len, nfrags;
> +=09unsigned int payload_offset;
> +=09DECLARE_CRYPTO_WAIT(wait);

nit: unused


[...]
> -static void ovpn_encrypt_post(struct sk_buff *skb, int ret)
> +void ovpn_encrypt_post(struct sk_buff *skb, int ret)
>  {
> -=09struct ovpn_peer *peer =3D ovpn_skb_cb(skb)->peer;
> +=09struct ovpn_crypto_key_slot *ks =3D ovpn_skb_cb(skb)->ctx->ks;
> +=09struct ovpn_peer *peer =3D ovpn_skb_cb(skb)->ctx->peer;

ovpn_skb_cb(skb)->ctx may not have been set by ovpn_aead_encrypt.

> +
> +=09/* encryption is happening asynchronously. This function will be
> +=09 * called later by the crypto callback with a proper return value
> +=09 */
> +=09if (unlikely(ret =3D=3D -EINPROGRESS))
> +=09=09return;
> =20
>  =09if (unlikely(ret < 0))
>  =09=09goto err;
> =20
>  =09skb_mark_not_on_list(skb);
> =20
> +=09kfree(ovpn_skb_cb(skb)->ctx);
> +
>  =09switch (peer->sock->sock->sk->sk_protocol) {
>  =09case IPPROTO_UDP:
>  =09=09ovpn_udp_send_skb(peer->ovpn, peer, skb);
>  =09=09break;
>  =09default:
>  =09=09/* no transport configured yet */
>  =09=09goto err;

ovpn_skb_cb(skb)->ctx has just been freed before this switch, and here
we jump to err and free it again.

>  =09}
>  =09/* skb passed down the stack - don't free it */
>  =09skb =3D NULL;
>  err:
>  =09if (unlikely(skb)) {
>  =09=09dev_core_stats_tx_dropped_inc(peer->ovpn->dev);
> -=09=09kfree_skb(skb);
> +=09=09kfree(ovpn_skb_cb(skb)->ctx);
>  =09}
> +=09kfree_skb(skb);
> +=09ovpn_crypto_key_slot_put(ks);
>  =09ovpn_peer_put(peer);
>  }

--=20
Sabrina



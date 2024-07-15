Return-Path: <netdev+bounces-111524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E469931716
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 16:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C30541F21FA3
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 14:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C9C18A925;
	Mon, 15 Jul 2024 14:45:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC4118C16B
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 14:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721054709; cv=none; b=p2l55BPLNm022kNuPa07eyiuZ+KU7LAqIshZC81ias08kGkHzH86V+HzDY0fCQEL98XX5e/l77jSvQg+UmiSPRlg0ND661+Ow+H+GqhFSDgaDX98vi/Ii8Xw/vcUfjw321oz35M0gbOtcjpz1go35N5JqhI/q9Dw+9HLie7WKzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721054709; c=relaxed/simple;
	bh=264EpI1sjuhbxs5ojy/B5LUSH2I/tKr4cnkJ7W+Nl8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tYzsF5acgAE1s3bDEeoZnQtg42t2vmY1icRRbkke+pU6Qs/EdSAsKSINBfnev5myL4vj7owADbLXqPHfgOWqRBdaSSQhwL6IyLSGgLO3G91HiZBKeAcnHZU12E5ZDOBJEwYpRJndNOUWVXVgAeh8BiXBo0QKNtu7+Kkrrz+QYTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-5NWl95axOlOKlP1qYvCFLg-1; Mon,
 15 Jul 2024 10:45:03 -0400
X-MC-Unique: 5NWl95axOlOKlP1qYvCFLg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87ECF1944A89;
	Mon, 15 Jul 2024 14:45:01 +0000 (UTC)
Received: from hog (unknown [10.39.192.3])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5FF351955F3B;
	Mon, 15 Jul 2024 14:44:57 +0000 (UTC)
Date: Mon, 15 Jul 2024 16:44:55 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, ryazanov.s.a@gmail.com,
	pabeni@redhat.com, edumazet@google.com, andrew@lunn.ch
Subject: Re: [PATCH net-next v5 17/25] ovpn: implement keepalive mechanism
Message-ID: <ZpU15_ZNAV5ysnCC@hog>
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-18-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240627130843.21042-18-antonio@openvpn.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-06-27, 15:08:35 +0200, Antonio Quartulli wrote:
> +static const unsigned char ovpn_keepalive_message[] =3D {
> +=090x2a, 0x18, 0x7b, 0xf3, 0x64, 0x1e, 0xb4, 0xcb,
> +=090x07, 0xed, 0x2d, 0x0a, 0x98, 0x1f, 0xc7, 0x48
> +};
> +
> +/**
> + * ovpn_is_keepalive - check if skb contains a keepalive message
> + * @skb: packet to check
> + *
> + * Assumes that the first byte of skb->data is defined.
> + *
> + * Return: true if skb contains a keepalive or false otherwise
> + */
> +static bool ovpn_is_keepalive(struct sk_buff *skb)
> +{
> +=09if (*skb->data !=3D OVPN_KEEPALIVE_FIRST_BYTE)

You could use ovpn_keepalive_message[0], and then you wouldn't need
this extra constant.

> +=09=09return false;
> +
> +=09if (!pskb_may_pull(skb, sizeof(ovpn_keepalive_message)))
> +=09=09return false;
> +
> +=09return !memcmp(skb->data, ovpn_keepalive_message,
> +=09=09       sizeof(ovpn_keepalive_message));

Is a packet that contains some extra bytes after the exact keepalive
considered a valid keepalive, or does it need to be the correct
length?

> +}
> +
>  /* Called after decrypt to write the IP packet to the device.
>   * This method is expected to manage/free the skb.
>   */
> @@ -91,6 +116,9 @@ void ovpn_decrypt_post(struct sk_buff *skb, int ret)
>  =09=09goto drop;
>  =09}
> =20
> +=09/* note event of authenticated packet received for keepalive */
> +=09ovpn_peer_keepalive_recv_reset(peer);
> +
>  =09/* point to encapsulated IP packet */
>  =09__skb_pull(skb, ovpn_skb_cb(skb)->payload_offset);
> =20
> @@ -107,6 +135,12 @@ void ovpn_decrypt_post(struct sk_buff *skb, int ret)
>  =09=09=09goto drop;
>  =09=09}
> =20
> +=09=09if (ovpn_is_keepalive(skb)) {
> +=09=09=09netdev_dbg(peer->ovpn->dev,
> +=09=09=09=09   "ping received from peer %u\n", peer->id);

That should probably be _ratelimited, but it seems we don't have
_ratelimited variants for the netdev_* helpers.



> +/**
> + * ovpn_xmit_special - encrypt and transmit an out-of-band message to pe=
er
> + * @peer: peer to send the message to
> + * @data: message content
> + * @len: message length
> + *
> + * Assumes that caller holds a reference to peer
> + */
> +static void ovpn_xmit_special(struct ovpn_peer *peer, const void *data,
> +=09=09=09      const unsigned int len)
> +{
> +=09struct ovpn_struct *ovpn;
> +=09struct sk_buff *skb;
> +
> +=09ovpn =3D peer->ovpn;
> +=09if (unlikely(!ovpn))
> +=09=09return;
> +
> +=09skb =3D alloc_skb(256 + len, GFP_ATOMIC);

Where is that 256 coming from?

> +=09if (unlikely(!skb))
> +=09=09return;

Failure to send a keepalive should probably have a counter, to help
users troubleshoot why their connection dropped.
(can be done later unless someone insists)


> +=09skb_reserve(skb, 128);

And that 128?

> +=09skb->priority =3D TC_PRIO_BESTEFFORT;
> +=09memcpy(__skb_put(skb, len), data, len);

nit: that's __skb_put_data

> +=09/* increase reference counter when passing peer to sending queue */
> +=09if (!ovpn_peer_hold(peer)) {
> +=09=09netdev_dbg(ovpn->dev, "%s: cannot hold peer reference for sending =
special packet\n",
> +=09=09=09   __func__);
> +=09=09kfree_skb(skb);
> +=09=09return;
> +=09}
> +
> +=09ovpn_send(ovpn, skb, peer);
> +}
> +
> +/**
> + * ovpn_keepalive_xmit - send keepalive message to peer
> + * @peer: the peer to send the message to
> + */
> +void ovpn_keepalive_xmit(struct ovpn_peer *peer)
> +{
> +=09ovpn_xmit_special(peer, ovpn_keepalive_message,
> +=09=09=09  sizeof(ovpn_keepalive_message));
> +}

I don't see other users of ovpn_xmit_special in this series, if you
don't have more planned in the future you could drop the extra function.


> +/**
> + * ovpn_peer_expire - timer task for incoming keepialive timeout

typo: s/keepialive/keepalive/



> +/**
> + * ovpn_peer_keepalive_set - configure keepalive values for peer
> + * @peer: the peer to configure
> + * @interval: outgoing keepalive interval
> + * @timeout: incoming keepalive timeout
> + */
> +void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 t=
imeout)
> +{
> +=09u32 delta;
> +
> +=09netdev_dbg(peer->ovpn->dev,
> +=09=09   "%s: scheduling keepalive for peer %u: interval=3D%u timeout=3D=
%u\n",
> +=09=09   __func__, peer->id, interval, timeout);
> +
> +=09peer->keepalive_interval =3D interval;
> +=09if (interval > 0) {
> +=09=09delta =3D msecs_to_jiffies(interval * MSEC_PER_SEC);
> +=09=09mod_timer(&peer->keepalive_xmit, jiffies + delta);

Maybe something to consider in the future: this could be resetting a
timer that was just about to go off to a somewhat distant time in the
future. Not sure the peer will be happy about that (and not consider
it a timeout).

> +=09} else {
> +=09=09timer_delete(&peer->keepalive_xmit);
> +=09}
> +
> +=09peer->keepalive_timeout =3D timeout;
> +=09if (timeout) {

pedantic nit: inconsistent style with the "interval > 0" test just
above

> +=09=09delta =3D msecs_to_jiffies(timeout * MSEC_PER_SEC);
> +=09=09mod_timer(&peer->keepalive_recv, jiffies + delta);
> +=09} else {
> +=09=09timer_delete(&peer->keepalive_recv);
> +=09}
> +}
> +

[...]
> +/**
> + * ovpn_peer_keepalive_recv_reset - reset keepalive timeout
> + * @peer: peer for which the timeout should be reset
> + *
> + * To be invoked upon reception of an authenticated packet from peer in =
order
> + * to report valid activity and thus reset the keepalive timeout
> + */
> +static inline void ovpn_peer_keepalive_recv_reset(struct ovpn_peer *peer=
)
> +{
> +=09u32 delta =3D msecs_to_jiffies(peer->keepalive_timeout * MSEC_PER_SEC=
);
> +
> +=09if (unlikely(!delta))
> +=09=09return;
> +
> +=09mod_timer(&peer->keepalive_recv, jiffies + delta);

This (and ovpn_peer_keepalive_xmit_reset) is going to be called for
each packet. I wonder how well the timer subsystem deals with one
timer getting updated possibly thousands of time per second.

--=20
Sabrina



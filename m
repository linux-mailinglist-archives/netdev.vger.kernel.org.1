Return-Path: <netdev+bounces-123773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E5496678E
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 19:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFEB4B22A9B
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 17:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DC914C585;
	Fri, 30 Aug 2024 17:04:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453D54B5AE
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725037445; cv=none; b=EX2zxRfxdm945BE87ia5i8MciaUxsxtkC5eo2HEokr4V0DIdqDYIjnH4LsyMoUKvBqfwpSHVRAnmG21C7ygrvD8LfrEe7IgAkfJ+T4ZWRxhgyF8BvZq5Fjv206zkgLe6P7MT4Bs/rLoztnX9i4J7oD7A0pxK2JGnGjq84ONImvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725037445; c=relaxed/simple;
	bh=luLYQzlqzlXu8/ZG8Er+GrQzlMm5axkbz4pt2Rq3Z5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IefWC+ddGOYhfzswgWIFGiM7CvLd6xf2vYiSM448mwCHOFQewybyw1sPd5QLbdldesW1jXRjYluYi1ubgEUmtrKlZnmYEiXk0x4BSpSH+KVtLgvSEO8l2fH0frErhtx3KDC3Ab+CA/lHo5p5YJfy+u5Av0jkRFrF/ZUajXr1jE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-MZJ7aEnPPQeG19osHSfCuQ-1; Fri,
 30 Aug 2024 13:02:28 -0400
X-MC-Unique: MZJ7aEnPPQeG19osHSfCuQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29AD919560B4;
	Fri, 30 Aug 2024 17:02:27 +0000 (UTC)
Received: from hog (unknown [10.39.192.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A8FE1955F45;
	Fri, 30 Aug 2024 17:02:23 +0000 (UTC)
Date: Fri, 30 Aug 2024 19:02:21 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	ryazanov.s.a@gmail.com, edumazet@google.com, andrew@lunn.ch
Subject: Re: [PATCH net-next v6 10/25] ovpn: implement basic TX path (UDP)
Message-ID: <ZtH7HWxCn0Qyk3wU@hog>
References: <20240827120805.13681-1-antonio@openvpn.net>
 <20240827120805.13681-11-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240827120805.13681-11-antonio@openvpn.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Antonio,

Thanks for the updated patchset. I'm going through it again.

2024-08-27, 14:07:50 +0200, Antonio Quartulli wrote:
> +/* send skb to connected peer, if any */
> +static void ovpn_send(struct ovpn_struct *ovpn, struct sk_buff *skb,
> +=09=09      struct ovpn_peer *peer)
> +{
> +=09struct sk_buff *curr, *next;
> +
> +=09if (likely(!peer))
> +=09=09/* retrieve peer serving the destination IP of this packet */
> +=09=09peer =3D ovpn_peer_get_by_dst(ovpn, skb);
> +=09if (unlikely(!peer)) {
> +=09=09net_dbg_ratelimited("%s: no peer to send data to\n",
> +=09=09=09=09    ovpn->dev->name);
> +=09=09dev_core_stats_tx_dropped_inc(ovpn->dev);
> +=09=09goto drop;
> +=09}
> +
> +=09/* this might be a GSO-segmented skb list: process each skb
> +=09 * independently
> +=09 */
> +=09skb_list_walk_safe(skb, curr, next)
> +=09=09if (unlikely(!ovpn_encrypt_one(peer, curr))) {
> +=09=09=09dev_core_stats_tx_dropped_inc(ovpn->dev);
> +=09=09=09kfree_skb(curr);

Is this a bit inconsistent with ovpn_net_xmit's behavior? There we
drop the full list if we fail one skb_share_check, and here we only
drop the single packet that failed and handle the rest? Or am I
misreading this?

> +=09=09}
> +
> +=09/* skb passed over, no need to free */
> +=09skb =3D NULL;
> +drop:
> +=09if (likely(peer))
> +=09=09ovpn_peer_put(peer);
> +=09kfree_skb_list(skb);
> +}
> =20
>  /* Send user data to the network
>   */
>  netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
>  {
> +=09struct ovpn_struct *ovpn =3D netdev_priv(dev);
> +=09struct sk_buff *segments, *tmp, *curr, *next;
> +=09struct sk_buff_head skb_list;
> +=09__be16 proto;
> +=09int ret;
> +
> +=09/* reset netfilter state */
> +=09nf_reset_ct(skb);
> +
> +=09/* verify IP header size in network packet */
> +=09proto =3D ovpn_ip_check_protocol(skb);
> +=09if (unlikely(!proto || skb->protocol !=3D proto)) {
> +=09=09net_err_ratelimited("%s: dropping malformed payload packet\n",
> +=09=09=09=09    dev->name);
> +=09=09dev_core_stats_tx_dropped_inc(ovpn->dev);
> +=09=09goto drop;
> +=09}
> +
> +=09if (skb_is_gso(skb)) {
> +=09=09segments =3D skb_gso_segment(skb, 0);
> +=09=09if (IS_ERR(segments)) {
> +=09=09=09ret =3D PTR_ERR(segments);
> +=09=09=09net_err_ratelimited("%s: cannot segment packet: %d\n",
> +=09=09=09=09=09    dev->name, ret);
> +=09=09=09dev_core_stats_tx_dropped_inc(ovpn->dev);
> +=09=09=09goto drop;
> +=09=09}
> +
> +=09=09consume_skb(skb);
> +=09=09skb =3D segments;
> +=09}
> +
> +=09/* from this moment on, "skb" might be a list */
> +
> +=09__skb_queue_head_init(&skb_list);
> +=09skb_list_walk_safe(skb, curr, next) {
> +=09=09skb_mark_not_on_list(curr);
> +
> +=09=09tmp =3D skb_share_check(curr, GFP_ATOMIC);
> +=09=09if (unlikely(!tmp)) {
> +=09=09=09kfree_skb_list(next);

Those don't get counted as dropped, but the ones we've already handled
(and put on skb_list) will be counted as dev_core_stats_tx_dropped_inc?
(it probably doesn't matter that much, since if we'd dropped before/at
skb_gso_segment we'd only count one drop)

> +=09=09=09net_err_ratelimited("%s: skb_share_check failed\n",
> +=09=09=09=09=09    dev->name);
> +=09=09=09goto drop_list;
> +=09=09}
> +
> +=09=09__skb_queue_tail(&skb_list, tmp);
> +=09}
> +=09skb_list.prev->next =3D NULL;
> +
> +=09ovpn_send(ovpn, skb_list.next, NULL);
> +
> +=09return NETDEV_TX_OK;
> +
> +drop_list:
> +=09skb_queue_walk_safe(&skb_list, curr, next) {
> +=09=09dev_core_stats_tx_dropped_inc(ovpn->dev);
> +=09=09kfree_skb(curr);
> +=09}
> +drop:
>  =09skb_tx_error(skb);
> -=09kfree_skb(skb);
> +=09kfree_skb_list(skb);
>  =09return NET_XMIT_DROP;
>  }


[...]
> +void ovpn_udp_send_skb(struct ovpn_struct *ovpn, struct ovpn_peer *peer,
> +=09=09       struct sk_buff *skb)
> +{
> +=09struct ovpn_bind *bind;
> +=09struct socket *sock;
> +=09int ret =3D -1;
> +
> +=09skb->dev =3D ovpn->dev;
> +=09/* no checksum performed at this layer */
> +=09skb->ip_summed =3D CHECKSUM_NONE;
> +
> +=09/* get socket info */
> +=09sock =3D peer->sock->sock;
> +=09if (unlikely(!sock)) {
> +=09=09net_warn_ratelimited("%s: no sock for remote peer\n", __func__);
> +=09=09goto out;
> +=09}
> +
> +=09rcu_read_lock();
> +=09/* get binding */
> +=09bind =3D rcu_dereference(peer->bind);
> +=09if (unlikely(!bind)) {
> +=09=09net_warn_ratelimited("%s: no bind for remote peer\n", __func__);
> +=09=09goto out_unlock;
> +=09}
> +
> +=09/* crypto layer -> transport (UDP) */
> +=09ret =3D ovpn_udp_output(ovpn, bind, &peer->dst_cache, sock->sk, skb);
> +
> +out_unlock:
> +=09rcu_read_unlock();
> +out:
> +=09if (unlikely(ret < 0)) {
> +=09=09dev_core_stats_tx_dropped_inc(ovpn->dev);
> +=09=09kfree_skb(skb);
> +=09=09return;
> +=09}
> +
> +=09dev_sw_netstats_tx_add(ovpn->dev, 1, skb->len);

I don't think it's safe to access skb->len after calling
udp_tunnel(6)_xmit_skb.

For example, vxlan_xmit_one (drivers/net/vxlan/vxlan_core.c) has a
similar counter and saves skb->len into pkt_len.

--=20
Sabrina



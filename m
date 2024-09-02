Return-Path: <netdev+bounces-124175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36700968621
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 13:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C08981F22306
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 11:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E274184547;
	Mon,  2 Sep 2024 11:24:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CE713B58D
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 11:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725276257; cv=none; b=LIcat9kkCjJjmwWCwvyzZTuNCrc3GaxgMAWvH3ajcGVv4bdPoSBfm+K8BJLpjpmllwDGrWRe4oOAj2Ugzqpnp6x8vWd67Ryy8q8eG3uYCmFAuUjYgQKRefP0m/6NZS7AiSPkncJ/1XOxYF5OXnWXJeCl6Xws1N/5IrJV/+hv0pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725276257; c=relaxed/simple;
	bh=cYFPch9hEZ+za67+BYrPY5OI6mz2QH0wkp6SGD4m/aY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=vBiFfoXVeyLydYP4yrLoLBIe1pDY/tiC7VWEajogVi0PWUouFb65uSUWsFgV5I3BA0jAyARMero7jPYa7f2b8UVh83EfRTCCYhc10+WoBCLBO5UlIrP93VwRw7zWYMb5g80r63vgGa1+tfqhSQ6rO0UBLcvrWSV/h53Na/zG6C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-3kxoh4EYNKmgNEs_m-C5oA-1; Mon,
 02 Sep 2024 07:22:57 -0400
X-MC-Unique: 3kxoh4EYNKmgNEs_m-C5oA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A5C219560B4;
	Mon,  2 Sep 2024 11:22:56 +0000 (UTC)
Received: from hog (unknown [10.39.192.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B3A101956048;
	Mon,  2 Sep 2024 11:22:52 +0000 (UTC)
Date: Mon, 2 Sep 2024 13:22:50 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	ryazanov.s.a@gmail.com, edumazet@google.com, andrew@lunn.ch
Subject: Re: [PATCH net-next v6 11/25] ovpn: implement basic RX path (UDP)
Message-ID: <ZtWgCv2bH0fCarwq@hog>
References: <20240827120805.13681-1-antonio@openvpn.net>
 <20240827120805.13681-12-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240827120805.13681-12-antonio@openvpn.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-08-27, 14:07:51 +0200, Antonio Quartulli wrote:
> +static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *sk=
b)
> +{
> +=09/* we can't guarantee the packet wasn't corrupted before entering the
> +=09 * VPN, therefore we give other layers a chance to check that
> +=09 */
> +=09skb->ip_summed =3D CHECKSUM_NONE;
> +
> +=09/* skb hash for transport packet no longer valid after decapsulation =
*/
> +=09skb_clear_hash(skb);
> +
> +=09/* post-decrypt scrub -- prepare to inject encapsulated packet onto t=
he
> +=09 * interface, based on __skb_tunnel_rx() in dst.h
> +=09 */
> +=09skb->dev =3D peer->ovpn->dev;
> +=09skb_set_queue_mapping(skb, 0);
> +=09skb_scrub_packet(skb, true);
> +
> +=09skb_reset_network_header(skb);
> +=09skb_reset_transport_header(skb);
> +=09skb_probe_transport_header(skb);
> +=09skb_reset_inner_headers(skb);
> +
> +=09memset(skb->cb, 0, sizeof(skb->cb));
> +
> +=09/* cause packet to be "received" by the interface */
> +=09if (likely(gro_cells_receive(&peer->ovpn->gro_cells,
> +=09=09=09=09     skb) =3D=3D NET_RX_SUCCESS))
> +=09=09/* update RX stats with the size of decrypted packet */
> +=09=09dev_sw_netstats_rx_add(peer->ovpn->dev, skb->len);

I don't think accessing skb->len after passing the skb to
gro_cells_receive is safe, see
c7cc9200e9b4 ("macsec: avoid use-after-free in macsec_handle_frame()")


[...]
>  static void ovpn_struct_free(struct net_device *net)
>  {
> +=09struct ovpn_struct *ovpn =3D netdev_priv(net);
> +
> +=09gro_cells_destroy(&ovpn->gro_cells);
> +=09rcu_barrier();

What's the purpose of this rcu_barrier? I expect it in module_exit,
not when removing one netdevice.


> diff --git a/drivers/net/ovpn/skb.h b/drivers/net/ovpn/skb.h
> index 7966a10d915f..e070fe6f448c 100644
> --- a/drivers/net/ovpn/skb.h
> +++ b/drivers/net/ovpn/skb.h
> @@ -18,10 +18,7 @@
>  #include <linux/types.h>
> =20
>  struct ovpn_cb {
> -=09struct aead_request *req;
>  =09struct ovpn_peer *peer;
> -=09struct ovpn_crypto_key_slot *ks;
> -=09unsigned int payload_offset;

Squashed into the wrong patch?


[...]
> +struct ovpn_struct *ovpn_from_udp_sock(struct sock *sk)
> +{
> +=09struct ovpn_socket *ovpn_sock;
> +
> +=09if (unlikely(READ_ONCE(udp_sk(sk)->encap_type) !=3D UDP_ENCAP_OVPNINU=
DP))
> +=09=09return NULL;
> +
> +=09ovpn_sock =3D rcu_dereference_sk_user_data(sk);

[1]

> +=09if (unlikely(!ovpn_sock))
> +=09=09return NULL;
> +
> +=09/* make sure that sk matches our stored transport socket */
> +=09if (unlikely(!ovpn_sock->sock || sk !=3D ovpn_sock->sock->sk))
> +=09=09return NULL;
> +
> +=09return ovpn_sock->ovpn;
> +}


> +static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
> +{
> +=09struct ovpn_peer *peer =3D NULL;
> +=09struct ovpn_struct *ovpn;
> +=09u32 peer_id;
> +=09u8 opcode;
> +
> +=09ovpn =3D ovpn_from_udp_sock(sk);
> +=09if (unlikely(!ovpn)) {
> +=09=09net_err_ratelimited("%s: cannot obtain ovpn object from UDP socket=
\n",
> +=09=09=09=09    __func__);
> +=09=09goto drop;
> +=09}
[...]
> +=09/* pop off outer UDP header */
> +=09__skb_pull(skb, sizeof(struct udphdr));
> +=09ovpn_recv(peer, skb);
> +=09return 0;
> +
> +drop:
> +=09if (peer)
> +=09=09ovpn_peer_put(peer);
> +=09dev_core_stats_rx_dropped_inc(ovpn->dev);

If we get here from the first goto, ovpn is NULL. You could add a
drop_noovpn label right here to just do the free+return.

> +=09kfree_skb(skb);
> +=09return 0;
> +}
> +
>  /**
>   * ovpn_udp4_output - send IPv4 packet over udp socket
>   * @ovpn: the openvpn instance
> @@ -257,8 +342,13 @@ void ovpn_udp_send_skb(struct ovpn_struct *ovpn, str=
uct ovpn_peer *peer,
>   */
>  int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct *ovpn=
)
>  {
> +=09struct udp_tunnel_sock_cfg cfg =3D {
> +=09=09.sk_user_data =3D ovpn,
> +=09=09.encap_type =3D UDP_ENCAP_OVPNINUDP,
> +=09=09.encap_rcv =3D ovpn_udp_encap_recv,
> +=09};
>  =09struct ovpn_socket *old_data;
> -=09int ret =3D 0;
> +=09int ret;
> =20
>  =09/* sanity check */
>  =09if (sock->sk->sk_protocol !=3D IPPROTO_UDP) {
> @@ -272,6 +362,7 @@ int ovpn_udp_socket_attach(struct socket *sock, struc=
t ovpn_struct *ovpn)
>  =09if (!old_data) {
>  =09=09/* socket is currently unused - we can take it */
>  =09=09rcu_read_unlock();
> +=09=09setup_udp_tunnel_sock(sock_net(sock->sk), sock, &cfg);

This will set sk_user_data to the ovpn_struct, but ovpn_from_udp_sock
expects the ovpn_socket [1], which is stored into sk_user_data a
little bit later by ovpn_socket_new. If a packet reaches
ovpn_udp_encap_recv -> ovpn_from_udp_sock before ovpn_socket_new
overwrites sk_user_data, bad things probably happen.

--=20
Sabrina



Return-Path: <netdev+bounces-96071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6556C8C437D
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 16:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88F731C22CCE
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 14:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353DB211C;
	Mon, 13 May 2024 14:50:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0629E1C01
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715611839; cv=none; b=VQdgwDMz26HHDHPXpJ7HBm8kRmVQjR3JAgc03KH74oAJK1b2qsqomD8d2zuzwM9Eoxjl60NQ/Fbk0EbLgCrdDnzNNZm+4TfIr8jwWQM2gU03VsllreSu83hDL+ukbhmKNshRiBflluv8GZkQIE4UBr/uNNcu0mdgCOnAci2bxJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715611839; c=relaxed/simple;
	bh=xBfOlsRIwt/X7ch7iqeoiX902W5mUGHFTGU640ieyRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GjPovZAel5hlOU2C5Uvie63a9jfPr3sH298DvI028lePMCVAChyWjO8VrlZ/2kmqPP0TRTfTPq8nAbcp5kb58Wgbxh/K+qWL6oE14Y/7bT9T+OZrgUWzK6RsXAIcc2dhmuyJPQt/6jc8lhmXuoNFn9844O9+rt/RQzOZymvGaz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-UtRGLBlBPTutfEa8jgCEGw-1; Mon, 13 May 2024 10:50:29 -0400
X-MC-Unique: UtRGLBlBPTutfEa8jgCEGw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 705D0801211;
	Mon, 13 May 2024 14:50:28 +0000 (UTC)
Received: from hog (unknown [10.39.192.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BAD90200A08E;
	Mon, 13 May 2024 14:50:26 +0000 (UTC)
Date: Mon, 13 May 2024 16:50:25 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 13/24] ovpn: implement TCP transport
Message-ID: <ZkIosadLULByXFKc@hog>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-14-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240506011637.27272-14-antonio@openvpn.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-05-06, 03:16:26 +0200, Antonio Quartulli wrote:
> @@ -307,6 +308,7 @@ static bool ovpn_encrypt_one(struct ovpn_peer *peer, =
struct sk_buff *skb)
>  /* Process packets in TX queue in a transport-specific way.
>   *
>   * UDP transport - encrypt and send across the tunnel.
> + * TCP transport - encrypt and put into TCP TX queue.
>   */
>  void ovpn_encrypt_work(struct work_struct *work)
>  {
> @@ -340,6 +342,9 @@ void ovpn_encrypt_work(struct work_struct *work)
>  =09=09=09=09=09ovpn_udp_send_skb(peer->ovpn, peer,
>  =09=09=09=09=09=09=09  curr);
>  =09=09=09=09=09break;
> +=09=09=09=09case IPPROTO_TCP:
> +=09=09=09=09=09ovpn_tcp_send_skb(peer, curr);
> +=09=09=09=09=09break;
>  =09=09=09=09default:
>  =09=09=09=09=09/* no transport configured yet */
>  =09=09=09=09=09consume_skb(skb);
> diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
> index 9ae9844dd281..a04d6e55a473 100644
> --- a/drivers/net/ovpn/main.c
> +++ b/drivers/net/ovpn/main.c
> @@ -23,6 +23,7 @@
>  #include "io.h"
>  #include "packet.h"
>  #include "peer.h"
> +#include "tcp.h"
> =20
>  /* Driver info */
>  #define DRV_DESCRIPTION=09"OpenVPN data channel offload (ovpn)"
> @@ -247,8 +248,14 @@ static struct pernet_operations ovpn_pernet_ops =3D =
{
> =20
>  static int __init ovpn_init(void)
>  {
> -=09int err =3D register_netdevice_notifier(&ovpn_netdev_notifier);
> +=09int err =3D ovpn_tcp_init();
> =20
> +=09if (err) {

ovpn_tcp_init cannot fail (and if it could, you'd need to clean up
when register_netdevice_notifier fails). I'd make ovpn_tcp_init void
and kill this check.

> +=09=09pr_err("ovpn: cannot initialize TCP component: %d\n", err);
> +=09=09return err;
> +=09}
> +
> +=09err =3D register_netdevice_notifier(&ovpn_netdev_notifier);
>  =09if (err) {
>  =09=09pr_err("ovpn: can't register netdevice notifier: %d\n", err);
>  =09=09return err;
> diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
> index b5ff59a4b40f..ac4907705d98 100644
> --- a/drivers/net/ovpn/peer.h
> +++ b/drivers/net/ovpn/peer.h
> @@ -33,6 +33,16 @@
>   * @netif_rx_ring: queue of packets to be sent to the netdevice via NAPI
>   * @napi: NAPI object
>   * @sock: the socket being used to talk to this peer
> + * @tcp.tx_ring: queue for packets to be forwarded to userspace (TCP onl=
y)
> + * @tcp.tx_work: work for processing outgoing socket data (TCP only)
> + * @tcp.rx_work: wok for processing incoming socket data (TCP only)

Never actually used.
If you keep it: s/wok/work/

> + * @tcp.raw_len: next packet length as read from the stream (TCP only)
> + * @tcp.skb: next packet being filled with data from the stream (TCP onl=
y)
> + * @tcp.offset: position of the next byte to write in the skb (TCP only)
> + * @tcp.data_len: next packet length converted to host order (TCP only)

It would be nice to add information about whether they're used for TX or RX=
.

> + * @tcp.sk_cb.sk_data_ready: pointer to original cb
> + * @tcp.sk_cb.sk_write_space: pointer to original cb
> + * @tcp.sk_cb.prot: pointer to original prot object
>   * @crypto: the crypto configuration (ciphers, keys, etc..)
>   * @dst_cache: cache for dst_entry used to send to peer
>   * @bind: remote peer binding
> @@ -59,6 +69,25 @@ struct ovpn_peer {
>  =09struct ptr_ring netif_rx_ring;
>  =09struct napi_struct napi;
>  =09struct ovpn_socket *sock;
> +=09/* state of the TCP reading. Needed to keep track of how much of a
> +=09 * single packet has already been read from the stream and how much i=
s
> +=09 * missing
> +=09 */
> +=09struct {
> +=09=09struct ptr_ring tx_ring;
> +=09=09struct work_struct tx_work;
> +=09=09struct work_struct rx_work;
> +
> +=09=09u8 raw_len[sizeof(u16)];

Why not u16 or __be16 for this one?

> +=09=09struct sk_buff *skb;
> +=09=09u16 offset;
> +=09=09u16 data_len;
> +=09=09struct {
> +=09=09=09void (*sk_data_ready)(struct sock *sk);
> +=09=09=09void (*sk_write_space)(struct sock *sk);
> +=09=09=09struct proto *prot;
> +=09=09} sk_cb;
> +=09} tcp;
>  =09struct ovpn_crypto_state crypto;
>  =09struct dst_cache dst_cache;
>  =09struct ovpn_bind __rcu *bind;
> diff --git a/drivers/net/ovpn/skb.h b/drivers/net/ovpn/skb.h
> new file mode 100644
> index 000000000000..ba92811e12ff
> --- /dev/null
> +++ b/drivers/net/ovpn/skb.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*  OpenVPN data channel offload
> + *
> + *  Copyright (C) 2020-2024 OpenVPN, Inc.
> + *
> + *  Author:=09Antonio Quartulli <antonio@openvpn.net>
> + *=09=09James Yonan <james@openvpn.net>
> + */
> +
> +#ifndef _NET_OVPN_SKB_H_
> +#define _NET_OVPN_SKB_H_
> +
> +#include <linux/in.h>
> +#include <linux/in6.h>
> +#include <linux/ip.h>
> +#include <linux/skbuff.h>
> +#include <linux/socket.h>
> +#include <linux/types.h>
> +
> +#define OVPN_SKB_CB(skb) ((struct ovpn_skb_cb *)&((skb)->cb))
> +
> +struct ovpn_skb_cb {
> +=09union {
> +=09=09struct in_addr ipv4;
> +=09=09struct in6_addr ipv6;
> +=09} local;
> +=09sa_family_t sa_fam;
> +};
> +
> +/* Return IP protocol version from skb header.
> + * Return 0 if protocol is not IPv4/IPv6 or cannot be read.
> + */
> +static inline __be16 ovpn_ip_check_protocol(struct sk_buff *skb)

A dupe of this function exists in drivers/net/ovpn/io.c. I guess you
can just introduce skb.h from the start (with only
ovpn_ip_check_protocol at first).

> +{
> +=09__be16 proto =3D 0;
> +
> +=09/* skb could be non-linear,
> +=09 * make sure IP header is in non-fragmented part
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
> +#endif /* _NET_OVPN_SKB_H_ */
> diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
> index e099a61b03fa..004db5b13663 100644
> --- a/drivers/net/ovpn/socket.c
> +++ b/drivers/net/ovpn/socket.c
> @@ -16,6 +16,7 @@
>  #include "packet.h"
>  #include "peer.h"
>  #include "socket.h"
> +#include "tcp.h"
>  #include "udp.h"
> =20
>  /* Finalize release of socket, called after RCU grace period */
> @@ -26,6 +27,8 @@ static void ovpn_socket_detach(struct socket *sock)
> =20
>  =09if (sock->sk->sk_protocol =3D=3D IPPROTO_UDP)
>  =09=09ovpn_udp_socket_detach(sock);
> +=09else if (sock->sk->sk_protocol =3D=3D IPPROTO_TCP)
> +=09=09ovpn_tcp_socket_detach(sock);
> =20
>  =09sockfd_put(sock);
>  }
> @@ -69,6 +72,8 @@ static int ovpn_socket_attach(struct socket *sock, stru=
ct ovpn_peer *peer)
> =20
>  =09if (sock->sk->sk_protocol =3D=3D IPPROTO_UDP)
>  =09=09ret =3D ovpn_udp_socket_attach(sock, peer->ovpn);
> +=09else if (sock->sk->sk_protocol =3D=3D IPPROTO_TCP)
> +=09=09ret =3D ovpn_tcp_socket_attach(sock, peer);
> =20
>  =09return ret;
>  }
> @@ -124,6 +129,21 @@ struct ovpn_socket *ovpn_socket_new(struct socket *s=
ock, struct ovpn_peer *peer)
>  =09ovpn_sock->sock =3D sock;

The line above this is:

    ovpn_sock->ovpn =3D peer->ovpn;

It's technically fine since you then overwrite this with peer in case
we're on TCP, but ovpn_sock->ovpn only exists on UDP since you moved
it into a union in this patch.

>  =09kref_init(&ovpn_sock->refcount);
> =20
> +=09/* TCP sockets are per-peer, therefore they are linked to their uniqu=
e
> +=09 * peer
> +=09 */
> +=09if (sock->sk->sk_protocol =3D=3D IPPROTO_TCP) {
> +=09=09ovpn_sock->peer =3D peer;
> +=09=09ret =3D ptr_ring_init(&ovpn_sock->recv_ring, OVPN_QUEUE_LEN,
> +=09=09=09=09    GFP_KERNEL);
> +=09=09if (ret < 0) {
> +=09=09=09netdev_err(peer->ovpn->dev, "%s: cannot allocate TCP recv ring\=
n",
> +=09=09=09=09   __func__);

Should you also call ovpn_socket_detach here? (as well when the
kzalloc for ovpn_sock fails a bit earlier)

> +=09=09=09kfree(ovpn_sock);
> +=09=09=09return ERR_PTR(ret);
> +=09=09}
> +=09}
> +
>  =09rcu_assign_sk_user_data(sock->sk, ovpn_sock);
> =20
>  =09return ovpn_sock;
> diff --git a/drivers/net/ovpn/socket.h b/drivers/net/ovpn/socket.h
> index 0d23de5a9344..88c6271ba5c7 100644
> --- a/drivers/net/ovpn/socket.h
> +++ b/drivers/net/ovpn/socket.h
> @@ -21,12 +21,25 @@ struct ovpn_peer;
>  /**
>   * struct ovpn_socket - a kernel socket referenced in the ovpn code
>   * @ovpn: ovpn instance owning this socket (UDP only)
> + * @peer: unique peer transmitting over this socket (TCP only)
> + * @recv_ring: queue where non-data packets directed to userspace are st=
ored
>   * @sock: the low level sock object
>   * @refcount: amount of contexts currently referencing this object
>   * @rcu: member used to schedule RCU destructor callback
>   */
>  struct ovpn_socket {
> -=09struct ovpn_struct *ovpn;
> +=09union {
> +=09=09/* the VPN session object owning this socket (UDP only) */

nit: Probably not needed

> +=09=09struct ovpn_struct *ovpn;
> +
> +=09=09/* TCP only */
> +=09=09struct {
> +=09=09=09/** @peer: unique peer transmitting over this socket */

Is kdoc upset about peer but not recv_ring?

> +=09=09=09struct ovpn_peer *peer;
> +=09=09=09struct ptr_ring recv_ring;
> +=09=09};
> +=09};
> +
>  =09struct socket *sock;
>  =09struct kref refcount;
>  =09struct rcu_head rcu;
> diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
> new file mode 100644
> index 000000000000..84ad7cd4fc4f
> --- /dev/null
> +++ b/drivers/net/ovpn/tcp.c
> @@ -0,0 +1,511 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*  OpenVPN data channel offload
> + *
> + *  Copyright (C) 2019-2024 OpenVPN, Inc.
> + *
> + *  Author:=09Antonio Quartulli <antonio@openvpn.net>
> + */
> +
> +#include <linux/ptr_ring.h>
> +#include <linux/skbuff.h>
> +#include <net/tcp.h>
> +#include <net/route.h>
> +
> +#include "ovpnstruct.h"
> +#include "main.h"
> +#include "io.h"
> +#include "packet.h"
> +#include "peer.h"
> +#include "proto.h"
> +#include "skb.h"
> +#include "socket.h"
> +#include "tcp.h"
> +
> +static struct proto ovpn_tcp_prot;
> +
> +static int ovpn_tcp_read_sock(read_descriptor_t *desc, struct sk_buff *i=
n_skb,
> +=09=09=09      unsigned int in_offset, size_t in_len)
> +{
> +=09struct sock *sk =3D desc->arg.data;
> +=09struct ovpn_socket *sock;
> +=09struct ovpn_skb_cb *cb;
> +=09struct ovpn_peer *peer;
> +=09size_t chunk, copied =3D 0;
> +=09void *data;
> +=09u16 len;
> +=09int st;
> +
> +=09rcu_read_lock();
> +=09sock =3D rcu_dereference_sk_user_data(sk);
> +=09rcu_read_unlock();

You can't just release rcu_read_lock and keep using sock (here and in
the rest of this file). Either you keep rcu_read_lock, or you can take
a reference on the ovpn_socket.


Anyway, this looks like you're reinventing strparser. Overall this is
very similar to net/xfrm/espintcp.c, but the receive side of espintcp
uses strp and is much shorter (recv_ring looks equivalent to
ike_queue, both sending a few messages to userspace -- look for
strp_init, espintcp_rcv, espintcp_parse in that file).

> +/* Set TCP encapsulation callbacks */
> +int ovpn_tcp_socket_attach(struct socket *sock, struct ovpn_peer *peer)
> +{
> +=09void *old_data;
> +=09int ret;
> +
> +=09INIT_WORK(&peer->tcp.tx_work, ovpn_tcp_tx_work);
> +
> +=09ret =3D ptr_ring_init(&peer->tcp.tx_ring, OVPN_QUEUE_LEN, GFP_KERNEL)=
;
> +=09if (ret < 0) {
> +=09=09netdev_err(peer->ovpn->dev, "cannot allocate TCP TX ring\n");
> +=09=09return ret;
> +=09}
> +
> +=09peer->tcp.skb =3D NULL;
> +=09peer->tcp.offset =3D 0;
> +=09peer->tcp.data_len =3D 0;
> +
> +=09write_lock_bh(&sock->sk->sk_callback_lock);
> +
> +=09/* make sure no pre-existing encapsulation handler exists */
> +=09rcu_read_lock();
> +=09old_data =3D rcu_dereference_sk_user_data(sock->sk);
> +=09rcu_read_unlock();
> +=09if (old_data) {
> +=09=09netdev_err(peer->ovpn->dev,
> +=09=09=09   "provided socket already taken by other user\n");
> +=09=09ret =3D -EBUSY;
> +=09=09goto err;

The UDP code differentiates "socket already owned by this interface"
from "already taken by other user". That doesn't apply to TCP?



> +int __init ovpn_tcp_init(void)
> +{
> +=09/* We need to substitute the recvmsg and the sock_is_readable
> +=09 * callbacks in the sk_prot member of the sock object for TCP
> +=09 * sockets.
> +=09 *
> +=09 * However sock->sk_prot is a pointer to a static variable and
> +=09 * therefore we can't directly modify it, otherwise every socket
> +=09 * pointing to it will be affected.
> +=09 *
> +=09 * For this reason we create our own static copy and modify what
> +=09 * we need. Then we make sk_prot point to this copy
> +=09 * (in ovpn_tcp_socket_attach())
> +=09 */
> +=09ovpn_tcp_prot =3D tcp_prot;

Don't you need a separate variant for IPv6, like TLS does?

> +=09ovpn_tcp_prot.recvmsg =3D ovpn_tcp_recvmsg;

You don't need to replace ->sendmsg as well? The userspace client is
not expected to send messages?

--=20
Sabrina



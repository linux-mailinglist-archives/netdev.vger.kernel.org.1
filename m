Return-Path: <netdev+bounces-95477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029088C25FC
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 15:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 269231C21655
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 13:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6363E12C498;
	Fri, 10 May 2024 13:45:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB0612C48A
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 13:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715348742; cv=none; b=Ogq6IYQs7dT+YQiKFF3x9zapJN3OawUAAUJ2pDJ9tCQNus91qHYe5/dwgOfWAYJCoKKWawi/rtjVOrxCFhniIeLJHlC3jcmIfoi8o+3HuMeb9hpuRtZKpnI+Vd6g6DWlZDx96CT/TkbBixrxdO45N+BbuQnhG4USTJ3GEzs8IoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715348742; c=relaxed/simple;
	bh=SjstU1bbZjcSmPd3Beao+Q/duPYs6oHQDLoAtFYHdSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UCA2nvTwacBFpLtTL+KE7syL2Qb9iaIF58Vu+rmMibpSFC5FXIR47FGAcYgsZNTi9kRpfZwULs+qi6eggI1VYefrpxFNOqghHjqlovS59dTTxg6Uz7bynsROIXONccwPM1q1dbdDDoTccTAOQRScvsx48HykFBisze2nbAA9LMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-Pw1rXLB9NkOuJiPkWqUqFg-1; Fri, 10 May 2024 09:45:28 -0400
X-MC-Unique: Pw1rXLB9NkOuJiPkWqUqFg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55464800994;
	Fri, 10 May 2024 13:45:28 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BD5D417ED5;
	Fri, 10 May 2024 13:45:27 +0000 (UTC)
Date: Fri, 10 May 2024 15:45:26 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 10/24] ovpn: implement basic RX path (UDP)
Message-ID: <Zj4k9g1hV1eHQ4Ox@hog>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-11-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240506011637.27272-11-antonio@openvpn.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-05-06, 03:16:23 +0200, Antonio Quartulli wrote:
> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
> index 36cfb95edbf4..9935a863bffe 100644
> --- a/drivers/net/ovpn/io.c
> +++ b/drivers/net/ovpn/io.c
> +/* Called after decrypt to write the IP packet to the device.
> + * This method is expected to manage/free the skb.
> + */
> +static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *sk=
b)
> +{
> +=09/* packet integrity was verified on the VPN layer - no need to perfor=
m
> +=09 * any additional check along the stack

But it could have been corrupted before it got into the VPN?

> +=09 */
> +=09skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> +=09skb->csum_level =3D ~0;
> +

[...]
> +int ovpn_napi_poll(struct napi_struct *napi, int budget)
> +{
> +=09struct ovpn_peer *peer =3D container_of(napi, struct ovpn_peer, napi)=
;
> +=09struct sk_buff *skb;
> +=09int work_done =3D 0;
> +
> +=09if (unlikely(budget <=3D 0))
> +=09=09return 0;
> +=09/* this function should schedule at most 'budget' number of
> +=09 * packets for delivery to the interface.
> +=09 * If in the queue we have more packets than what allowed by the
> +=09 * budget, the next polling will take care of those
> +=09 */
> +=09while ((work_done < budget) &&
> +=09       (skb =3D ptr_ring_consume_bh(&peer->netif_rx_ring))) {
> +=09=09ovpn_netdev_write(peer, skb);
> +=09=09work_done++;
> +=09}
> +
> +=09if (work_done < budget)
> +=09=09napi_complete_done(napi, work_done);
> +
> +=09return work_done;
> +}

Why not use gro_cells? It would avoid all that napi polling and
netif_rx_ring code (and it's per-cpu, going back to our other
discussion around napi).


> diff --git a/drivers/net/ovpn/proto.h b/drivers/net/ovpn/proto.h
> new file mode 100644
> index 000000000000..0a51104ed931
> --- /dev/null
> +++ b/drivers/net/ovpn/proto.h
[...]
> +/**
> + * ovpn_key_id_from_skb - extract key ID from the skb head
> + * @skb: the packet to extract the key ID code from
> + *
> + * Note: this function assumes that the skb head was pulled enough
> + * to access the first byte.
> + *
> + * Return: the key ID
> + */
> +static inline u8 ovpn_key_id_from_skb(const struct sk_buff *skb)

> +static inline u32 ovpn_opcode_compose(u8 opcode, u8 key_id, u32 peer_id)

(tiny nit: those aren't used yet in this patch. probably not worth
moving them into the right patch.)


> diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
> index f434da76dc0a..07182703e598 100644
> --- a/drivers/net/ovpn/udp.c
> +++ b/drivers/net/ovpn/udp.c
> @@ -20,9 +20,117 @@
>  #include "bind.h"
>  #include "io.h"
>  #include "peer.h"
> +#include "proto.h"
>  #include "socket.h"
>  #include "udp.h"
> =20
> +/**
> + * ovpn_udp_encap_recv - Start processing a received UDP packet.
> + * @sk: socket over which the packet was received
> + * @skb: the received packet
> + *
> + * If the first byte of the payload is DATA_V2, the packet is further pr=
ocessed,
> + * otherwise it is forwarded to the UDP stack for delivery to user space=
.
> + *
> + * Return:
> + *  0 if skb was consumed or dropped
> + * >0 if skb should be passed up to userspace as UDP (packet not consume=
d)
> + * <0 if skb should be resubmitted as proto -N (packet not consumed)
> + */
> +static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
> +{
> +=09struct ovpn_peer *peer =3D NULL;
> +=09struct ovpn_struct *ovpn;
> +=09u32 peer_id;
> +=09u8 opcode;
> +=09int ret;
> +
> +=09ovpn =3D ovpn_from_udp_sock(sk);
> +=09if (unlikely(!ovpn)) {
> +=09=09net_err_ratelimited("%s: cannot obtain ovpn object from UDP socket=
\n",
> +=09=09=09=09    __func__);
> +=09=09goto drop;
> +=09}
> +
> +=09/* Make sure the first 4 bytes of the skb data buffer after the UDP
> +=09 * header are accessible.
> +=09 * They are required to fetch the OP code, the key ID and the peer ID=
.
> +=09 */
> +=09if (unlikely(!pskb_may_pull(skb, sizeof(struct udphdr) + 4))) {

Is this OVPN_OP_SIZE_V2?

> +=09=09net_dbg_ratelimited("%s: packet too small\n", __func__);
> +=09=09goto drop;
> +=09}
> +
> +=09opcode =3D ovpn_opcode_from_skb(skb, sizeof(struct udphdr));
> +=09if (unlikely(opcode !=3D OVPN_DATA_V2)) {
> +=09=09/* DATA_V1 is not supported */
> +=09=09if (opcode =3D=3D OVPN_DATA_V1)
> +=09=09=09goto drop;
> +
> +=09=09/* unknown or control packet: let it bubble up to userspace */
> +=09=09return 1;
> +=09}
> +
> +=09peer_id =3D ovpn_peer_id_from_skb(skb, sizeof(struct udphdr));
> +=09/* some OpenVPN server implementations send data packets with the
> +=09 * peer-id set to undef. In this case we skip the peer lookup by peer=
-id
> +=09 * and we try with the transport address
> +=09 */
> +=09if (peer_id !=3D OVPN_PEER_ID_UNDEF) {
> +=09=09peer =3D ovpn_peer_get_by_id(ovpn, peer_id);
> +=09=09if (!peer) {
> +=09=09=09net_err_ratelimited("%s: received data from unknown peer (id: %=
d)\n",
> +=09=09=09=09=09    __func__, peer_id);
> +=09=09=09goto drop;
> +=09=09}
> +=09}
> +
> +=09if (!peer) {
> +=09=09/* data packet with undef peer-id */
> +=09=09peer =3D ovpn_peer_get_by_transp_addr(ovpn, skb);
> +=09=09if (unlikely(!peer)) {
> +=09=09=09netdev_dbg(ovpn->dev,
> +=09=09=09=09   "%s: received data with undef peer-id from unknown source=
\n",
> +=09=09=09=09   __func__);

_ratelimited?

> +=09=09=09goto drop;
> +=09=09}
> +=09}
> +
> +=09/* At this point we know the packet is from a configured peer.
> +=09 * DATA_V2 packets are handled in kernel space, the rest goes to user
> +=09 * space.
> +=09 *
> +=09 * Return 1 to instruct the stack to let the packet bubble up to
> +=09 * userspace
> +=09 */
> +=09if (unlikely(opcode !=3D OVPN_DATA_V2)) {

You already handled those earlier, before getting the peer.


[...]
> @@ -255,10 +368,20 @@ int ovpn_udp_socket_attach(struct socket *sock, str=
uct ovpn_struct *ovpn)
>  =09=09=09return -EALREADY;
>  =09=09}
> =20
> -=09=09netdev_err(ovpn->dev, "%s: provided socket already taken by other =
user\n",
> +=09=09netdev_err(ovpn->dev,
> +=09=09=09   "%s: provided socket already taken by other user\n",

I guess you meant to break that line in the patch that introduced it,
rather than here? :)


> +void ovpn_udp_socket_detach(struct socket *sock)
> +{
> +=09struct udp_tunnel_sock_cfg cfg =3D { };
> +
> +=09setup_udp_tunnel_sock(sock_net(sock->sk), sock, &cfg);

I can't find anything in the kernel currently using
setup_udp_tunnel_sock the way you're using it here.

Does this provide any benefit compared to just letting the kernel
disable encap when the socket goes away? Are you planning to detach
and then re-attach the same socket?

--=20
Sabrina



Return-Path: <netdev+bounces-149209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D90A9E4C59
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 03:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5C6618818E3
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 02:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C5C187848;
	Thu,  5 Dec 2024 02:38:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767A279DC
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 02:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733366290; cv=none; b=YTi53GdaNtUFxb/UB9w016/LedyEwdjArqpl7FJsdhsQxkduyv++MxqNs0oFhtPOCDqtA422BJs5Y0e7hBM5HNAqzocG82mT8LJLXSzZWVMecdVt0jeQxv4ooS8sud28y+PnVJR+7soDyGVleciqd+Jw5t//2rYi0ZuZPdPS2NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733366290; c=relaxed/simple;
	bh=Yda4GCF2HtyP7GVJr68aMzyiJwY3DrKYdEBYFINCl1g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=plbYtqq6u/tGcHxWXLyEZaBrH5iaUXVTr6/OD4D5rlMt1OJ2sXRkBC5MJ9RmEvFW24jLpM8d35j8SvIrTe2NSVij/Ze5Sn9NBTtNxgBERqJkgBMC1YmOce9wZClXtVKV/ZBX2oAqKpKGKESIbjhec7U23dgbK/z3/CaSO2kh0II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-241-iuV-d_jLMKazjlviFCdpbA-1; Thu, 05 Dec 2024 02:38:02 +0000
X-MC-Unique: iuV-d_jLMKazjlviFCdpbA-1
X-Mimecast-MFC-AGG-ID: iuV-d_jLMKazjlviFCdpbA
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 5 Dec
 2024 02:37:22 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 5 Dec 2024 02:37:22 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'David Howells' <dhowells@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Marc Dionne <marc.dionne@auristor.com>, Yunsheng Lin
	<linyunsheng@huawei.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "linux-afs@lists.infradead.org"
	<linux-afs@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 02/37] rxrpc: Use umin() and umax() rather than
 min_t()/max_t() where possible
Thread-Topic: [PATCH net-next 02/37] rxrpc: Use umin() and umax() rather than
 min_t()/max_t() where possible
Thread-Index: AQHbRMbh0C4h7ofUKUqfMucF4fVa+LLW8I5g
Date: Thu, 5 Dec 2024 02:37:22 +0000
Message-ID: <35033e7d707b4c68ae125820230d3cd3@AcuMS.aculab.com>
References: <20241202143057.378147-1-dhowells@redhat.com>
 <20241202143057.378147-3-dhowells@redhat.com>
In-Reply-To: <20241202143057.378147-3-dhowells@redhat.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6y1yGbhSFpdh6m2BAY7BGUtyPg4jARNsJ0HhfbUqB9s_1733366281
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: David Howells <dhowells@redhat.com>
> Sent: 02 December 2024 14:30
>=20
> Use umin() and umax() rather than min_t()/max_t() where the type specifie=
d
> is an unsigned type.

You are also changing some max() to umax().
Presumably they have always passed the type check so max() is fine.
And max(foo, 1) would have required that 'foo' be 'signed int' and could
potentially be negative when max(-1, 1) will be 1 but umax(-1, 1) is
undefined.

I actually suspect a lot of the min_t/max_t could be plain min/max now.
It looks like someone couldn't be bothered to generate unsigned constants.
Now min(unsigned_val, 1) is accepted as well as min(unsigned_val, 1u).

=09David


>=20
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Eric Dumazet <edumazet@google.com>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: linux-afs@lists.infradead.org
> cc: netdev@vger.kernel.org
> ---
>  net/rxrpc/call_event.c  |  5 ++---
>  net/rxrpc/call_object.c |  4 ++--
>  net/rxrpc/conn_client.c |  2 +-
>  net/rxrpc/input.c       | 13 +++++--------
>  net/rxrpc/insecure.c    |  2 +-
>  net/rxrpc/io_thread.c   |  2 +-
>  net/rxrpc/output.c      |  2 +-
>  net/rxrpc/rtt.c         |  6 +++---
>  net/rxrpc/rxkad.c       |  6 +++---
>  net/rxrpc/rxperf.c      |  2 +-
>  net/rxrpc/sendmsg.c     |  2 +-
>  11 files changed, 21 insertions(+), 25 deletions(-)
>=20
> diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
> index 7bbb68504766..c4754cc9b8d4 100644
> --- a/net/rxrpc/call_event.c
> +++ b/net/rxrpc/call_event.c
> @@ -233,8 +233,7 @@ static void rxrpc_close_tx_phase(struct rxrpc_call *c=
all)
>=20
>  static bool rxrpc_tx_window_has_space(struct rxrpc_call *call)
>  {
> -=09unsigned int winsize =3D min_t(unsigned int, call->tx_winsize,
> -=09=09=09=09     call->cong_cwnd + call->cong_extra);
> +=09unsigned int winsize =3D umin(call->tx_winsize, call->cong_cwnd + cal=
l->cong_extra);
>  =09rxrpc_seq_t window =3D call->acks_hard_ack, wtop =3D window + winsize=
;
>  =09rxrpc_seq_t tx_top =3D call->tx_top;
>  =09int space;
> @@ -467,7 +466,7 @@ bool rxrpc_input_call_event(struct rxrpc_call *call, =
struct sk_buff *skb)
>  =09=09} else {
>  =09=09=09unsigned long nowj =3D jiffies, delayj, nextj;
>=20
> -=09=09=09delayj =3D max(nsecs_to_jiffies(delay), 1);
> +=09=09=09delayj =3D umax(nsecs_to_jiffies(delay), 1);
>  =09=09=09nextj =3D nowj + delayj;
>  =09=09=09if (time_before(nextj, call->timer.expires) ||
>  =09=09=09    !timer_pending(&call->timer)) {
> diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
> index f9e983a12c14..0df647d1d3a2 100644
> --- a/net/rxrpc/call_object.c
> +++ b/net/rxrpc/call_object.c
> @@ -220,9 +220,9 @@ static struct rxrpc_call *rxrpc_alloc_client_call(str=
uct rxrpc_sock *rx,
>  =09=09__set_bit(RXRPC_CALL_EXCLUSIVE, &call->flags);
>=20
>  =09if (p->timeouts.normal)
> -=09=09call->next_rx_timo =3D min(p->timeouts.normal, 1);
> +=09=09call->next_rx_timo =3D umin(p->timeouts.normal, 1);
>  =09if (p->timeouts.idle)
> -=09=09call->next_req_timo =3D min(p->timeouts.idle, 1);
> +=09=09call->next_req_timo =3D umin(p->timeouts.idle, 1);
>  =09if (p->timeouts.hard)
>  =09=09call->hard_timo =3D p->timeouts.hard;
>=20
> diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
> index bb11e8289d6d..86fb18bcd188 100644
> --- a/net/rxrpc/conn_client.c
> +++ b/net/rxrpc/conn_client.c
> @@ -231,7 +231,7 @@ static bool rxrpc_may_reuse_conn(struct rxrpc_connect=
ion *conn)
>  =09distance =3D id - id_cursor;
>  =09if (distance < 0)
>  =09=09distance =3D -distance;
> -=09limit =3D max_t(unsigned long, atomic_read(&rxnet->nr_conns) * 4, 102=
4);
> +=09limit =3D umax(atomic_read(&rxnet->nr_conns) * 4, 1024);
>  =09if (distance > limit)
>  =09=09goto mark_dont_reuse;
>=20
> diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
> index 16d49a861dbb..49e35be7dc13 100644
> --- a/net/rxrpc/input.c
> +++ b/net/rxrpc/input.c
> @@ -44,8 +44,7 @@ static void rxrpc_congestion_management(struct rxrpc_ca=
ll *call,
>=20
>  =09if (test_and_clear_bit(RXRPC_CALL_RETRANS_TIMEOUT, &call->flags)) {
>  =09=09summary->retrans_timeo =3D true;
> -=09=09call->cong_ssthresh =3D max_t(unsigned int,
> -=09=09=09=09=09    summary->flight_size / 2, 2);
> +=09=09call->cong_ssthresh =3D umax(summary->flight_size / 2, 2);
>  =09=09cwnd =3D 1;
>  =09=09if (cwnd >=3D call->cong_ssthresh &&
>  =09=09    call->cong_mode =3D=3D RXRPC_CALL_SLOW_START) {
> @@ -113,8 +112,7 @@ static void rxrpc_congestion_management(struct rxrpc_=
call *call,
>=20
>  =09=09change =3D rxrpc_cong_begin_retransmission;
>  =09=09call->cong_mode =3D RXRPC_CALL_FAST_RETRANSMIT;
> -=09=09call->cong_ssthresh =3D max_t(unsigned int,
> -=09=09=09=09=09    summary->flight_size / 2, 2);
> +=09=09call->cong_ssthresh =3D umax(summary->flight_size / 2, 2);
>  =09=09cwnd =3D call->cong_ssthresh + 3;
>  =09=09call->cong_extra =3D 0;
>  =09=09call->cong_dup_acks =3D 0;
> @@ -206,9 +204,8 @@ void rxrpc_congestion_degrade(struct rxrpc_call *call=
)
>  =09rxrpc_inc_stat(call->rxnet, stat_tx_data_cwnd_reset);
>  =09call->tx_last_sent =3D now;
>  =09call->cong_mode =3D RXRPC_CALL_SLOW_START;
> -=09call->cong_ssthresh =3D max_t(unsigned int, call->cong_ssthresh,
> -=09=09=09=09    call->cong_cwnd * 3 / 4);
> -=09call->cong_cwnd =3D max_t(unsigned int, call->cong_cwnd / 2, RXRPC_MI=
N_CWND);
> +=09call->cong_ssthresh =3D umax(call->cong_ssthresh, call->cong_cwnd * 3=
 / 4);
> +=09call->cong_cwnd =3D umax(call->cong_cwnd / 2, RXRPC_MIN_CWND);
>  }
>=20
>  /*
> @@ -709,7 +706,7 @@ static void rxrpc_input_ack_trailer(struct rxrpc_call=
 *call, struct sk_buff *skb
>  =09=09call->tx_winsize =3D rwind;
>  =09}
>=20
> -=09mtu =3D min(ntohl(trailer->maxMTU), ntohl(trailer->ifMTU));
> +=09mtu =3D umin(ntohl(trailer->maxMTU), ntohl(trailer->ifMTU));
>=20
>  =09peer =3D call->peer;
>  =09if (mtu < peer->maxdata) {
> diff --git a/net/rxrpc/insecure.c b/net/rxrpc/insecure.c
> index 6716c021a532..751eb621021d 100644
> --- a/net/rxrpc/insecure.c
> +++ b/net/rxrpc/insecure.c
> @@ -19,7 +19,7 @@ static int none_init_connection_security(struct rxrpc_c=
onnection *conn,
>   */
>  static struct rxrpc_txbuf *none_alloc_txbuf(struct rxrpc_call *call, siz=
e_t remain, gfp_t gfp)
>  {
> -=09return rxrpc_alloc_data_txbuf(call, min_t(size_t, remain, RXRPC_JUMBO=
_DATALEN), 1, gfp);
> +=09return rxrpc_alloc_data_txbuf(call, umin(remain, RXRPC_JUMBO_DATALEN)=
, 1, gfp);
>  }
>=20
>  static int none_secure_packet(struct rxrpc_call *call, struct rxrpc_txbu=
f *txb)
> diff --git a/net/rxrpc/io_thread.c b/net/rxrpc/io_thread.c
> index 07c74c77d802..7af5adf53b25 100644
> --- a/net/rxrpc/io_thread.c
> +++ b/net/rxrpc/io_thread.c
> @@ -558,7 +558,7 @@ int rxrpc_io_thread(void *data)
>  =09=09=09}
>=20
>  =09=09=09timeout =3D nsecs_to_jiffies(delay_ns);
> -=09=09=09timeout =3D max(timeout, 1UL);
> +=09=09=09timeout =3D umax(timeout, 1);
>  =09=09=09schedule_timeout(timeout);
>  =09=09=09__set_current_state(TASK_RUNNING);
>  =09=09=09continue;
> diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
> index 5ea9601efd05..85112ea31a39 100644
> --- a/net/rxrpc/output.c
> +++ b/net/rxrpc/output.c
> @@ -118,7 +118,7 @@ static void rxrpc_fill_out_ack(struct rxrpc_call *cal=
l,
>  =09=09txb->kvec[1].iov_len =3D ack->nAcks;
>=20
>  =09=09wrap =3D RXRPC_SACK_SIZE - sack;
> -=09=09to =3D min_t(unsigned int, ack->nAcks, RXRPC_SACK_SIZE);
> +=09=09to =3D umin(ack->nAcks, RXRPC_SACK_SIZE);
>=20
>  =09=09if (sack + ack->nAcks <=3D RXRPC_SACK_SIZE) {
>  =09=09=09memcpy(sackp, call->ackr_sack_table + sack, ack->nAcks);
> diff --git a/net/rxrpc/rtt.c b/net/rxrpc/rtt.c
> index cdab7b7d08a0..6dc51486b5a6 100644
> --- a/net/rxrpc/rtt.c
> +++ b/net/rxrpc/rtt.c
> @@ -27,7 +27,7 @@ static u32 __rxrpc_set_rto(const struct rxrpc_peer *pee=
r)
>=20
>  static u32 rxrpc_bound_rto(u32 rto)
>  {
> -=09return min(rto, RXRPC_RTO_MAX);
> +=09return umin(rto, RXRPC_RTO_MAX);
>  }
>=20
>  /*
> @@ -91,11 +91,11 @@ static void rxrpc_rtt_estimator(struct rxrpc_peer *pe=
er, long sample_rtt_us)
>  =09=09/* no previous measure. */
>  =09=09srtt =3D m << 3;=09=09/* take the measured time to be rtt */
>  =09=09peer->mdev_us =3D m << 1;=09/* make sure rto =3D 3*rtt */
> -=09=09peer->rttvar_us =3D max(peer->mdev_us, rxrpc_rto_min_us(peer));
> +=09=09peer->rttvar_us =3D umax(peer->mdev_us, rxrpc_rto_min_us(peer));
>  =09=09peer->mdev_max_us =3D peer->rttvar_us;
>  =09}
>=20
> -=09peer->srtt_us =3D max(1U, srtt);
> +=09peer->srtt_us =3D umax(srtt, 1);
>  }
>=20
>  /*
> diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
> index 48a1475e6b06..e3194d73dd84 100644
> --- a/net/rxrpc/rxkad.c
> +++ b/net/rxrpc/rxkad.c
> @@ -150,11 +150,11 @@ static struct rxrpc_txbuf *rxkad_alloc_txbuf(struct=
 rxrpc_call *call, size_t rem
>  =09struct rxrpc_txbuf *txb;
>  =09size_t shdr, space;
>=20
> -=09remain =3D min(remain, 65535 - sizeof(struct rxrpc_wire_header));
> +=09remain =3D umin(remain, 65535 - sizeof(struct rxrpc_wire_header));
>=20
>  =09switch (call->conn->security_level) {
>  =09default:
> -=09=09space =3D min_t(size_t, remain, RXRPC_JUMBO_DATALEN);
> +=09=09space =3D umin(remain, RXRPC_JUMBO_DATALEN);
>  =09=09return rxrpc_alloc_data_txbuf(call, space, 1, gfp);
>  =09case RXRPC_SECURITY_AUTH:
>  =09=09shdr =3D sizeof(struct rxkad_level1_hdr);
> @@ -164,7 +164,7 @@ static struct rxrpc_txbuf *rxkad_alloc_txbuf(struct r=
xrpc_call *call, size_t rem
>  =09=09break;
>  =09}
>=20
> -=09space =3D min_t(size_t, round_down(RXRPC_JUMBO_DATALEN, RXKAD_ALIGN),=
 remain + shdr);
> +=09space =3D umin(round_down(RXRPC_JUMBO_DATALEN, RXKAD_ALIGN), remain +=
 shdr);
>  =09space =3D round_up(space, RXKAD_ALIGN);
>=20
>  =09txb =3D rxrpc_alloc_data_txbuf(call, space, RXKAD_ALIGN, gfp);
> diff --git a/net/rxrpc/rxperf.c b/net/rxrpc/rxperf.c
> index 085e7892d310..7ef93407be83 100644
> --- a/net/rxrpc/rxperf.c
> +++ b/net/rxrpc/rxperf.c
> @@ -503,7 +503,7 @@ static int rxperf_process_call(struct rxperf_call *ca=
ll)
>  =09=09=09=09   reply_len + sizeof(rxperf_magic_cookie));
>=20
>  =09while (reply_len > 0) {
> -=09=09len =3D min_t(size_t, reply_len, PAGE_SIZE);
> +=09=09len =3D umin(reply_len, PAGE_SIZE);
>  =09=09bvec_set_page(&bv, ZERO_PAGE(0), len, 0);
>  =09=09iov_iter_bvec(&msg.msg_iter, WRITE, &bv, 1, len);
>  =09=09msg.msg_flags =3D MSG_MORE;
> diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
> index 6abb8eec1b2b..b04afb5df241 100644
> --- a/net/rxrpc/sendmsg.c
> +++ b/net/rxrpc/sendmsg.c
> @@ -360,7 +360,7 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
>=20
>  =09=09/* append next segment of data to the current buffer */
>  =09=09if (msg_data_left(msg) > 0) {
> -=09=09=09size_t copy =3D min_t(size_t, txb->space, msg_data_left(msg));
> +=09=09=09size_t copy =3D umin(txb->space, msg_data_left(msg));
>=20
>  =09=09=09_debug("add %zu", copy);
>  =09=09=09if (!copy_from_iter_full(txb->kvec[0].iov_base + txb->offset,
>=20

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)



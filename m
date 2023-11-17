Return-Path: <netdev+bounces-48697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 378AC7EF46E
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 15:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF753B207E7
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 14:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8301E36AEE;
	Fri, 17 Nov 2023 14:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DQtMu1q4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646771EA7F
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 14:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883CCC433C7
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 14:28:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DQtMu1q4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1700231310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h+5EC+wGvau4MkSgMzGo/kYP2JA/syf3nTRDtT9fBuA=;
	b=DQtMu1q4cfPloSoXs7Pxvp+PR6D7eLBIhb6EpgxwCQ1mG3DZ6cS/Souaaz6JYtZahdGEjP
	3IpMF6ggg/wllpg9M+LKPzc/3sZyL3BFW6tpXO3xjVUUt2i9RNMi4l4GTTH0KIENWHqW6P
	ea2CfJ18mtpP1bTNY/IRE4fvJ2JC0GA=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e50ba18c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <netdev@vger.kernel.org>;
	Fri, 17 Nov 2023 14:28:30 +0000 (UTC)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5ac376d311aso22159557b3.1
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 06:28:30 -0800 (PST)
X-Gm-Message-State: AOJu0YxAR6xA2YhBiQ11LwAYDUQTi1hJn9xUDwQfkidUMKmO+vpsxEmF
	3eXtCTDRfhQwFbDbmSz2hEUoTC9qEDvROqSSQ3k=
X-Google-Smtp-Source: AGHT+IHbhRda+2hqKwmLijgXdKdZ7yvL10vaMilnSrG94GnMm1ZwxDcY93WCZxln/QUVQXbsYoHfH4cQFSPRbKlWrJs=
X-Received: by 2002:a81:4113:0:b0:5a8:277f:b378 with SMTP id
 o19-20020a814113000000b005a8277fb378mr15795154ywa.1.1700231309279; Fri, 17
 Nov 2023 06:28:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231117141733.3344158-1-edumazet@google.com>
In-Reply-To: <20231117141733.3344158-1-edumazet@google.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Fri, 17 Nov 2023 15:28:16 +0100
X-Gmail-Original-Message-ID: <CAHmME9qvTUj4RUBo7AJXKhVSxvKbKxbKsnU0_rDfGSeXLNvb+Q@mail.gmail.com>
Message-ID: <CAHmME9qvTUj4RUBo7AJXKhVSxvKbKxbKsnU0_rDfGSeXLNvb+Q@mail.gmail.com>
Subject: Re: [PATCH v2 net] wireguard: use DEV_STATS_INC()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot <syzkaller@googlegroups.com>, Hangbin Liu <liuhangbin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Fri, Nov 17, 2023 at 3:17=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> wg_xmit() can be called concurrently, KCSAN reported [1]
> some device stats updates can be lost.
>
> Use DEV_STATS_INC() for this unlikely case.
>
> [1]
> BUG: KCSAN: data-race in wg_xmit / wg_xmit
>
> read-write to 0xffff888104239160 of 8 bytes by task 1375 on cpu 0:
> wg_xmit+0x60f/0x680 drivers/net/wireguard/device.c:231
> __netdev_start_xmit include/linux/netdevice.h:4918 [inline]
> netdev_start_xmit include/linux/netdevice.h:4932 [inline]
> xmit_one net/core/dev.c:3543 [inline]
> dev_hard_start_xmit+0x11b/0x3f0 net/core/dev.c:3559
> ...
>
> read-write to 0xffff888104239160 of 8 bytes by task 1378 on cpu 1:
> wg_xmit+0x60f/0x680 drivers/net/wireguard/device.c:231
> __netdev_start_xmit include/linux/netdevice.h:4918 [inline]
> netdev_start_xmit include/linux/netdevice.h:4932 [inline]
> xmit_one net/core/dev.c:3543 [inline]
> dev_hard_start_xmit+0x11b/0x3f0 net/core/dev.c:3559
> ...
>
> v2: also change wg_packet_consume_data_done() (Hangbin Liu)
>     and wg_packet_purge_staged_packets()
>
> Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/wireguard/device.c  |  4 ++--
>  drivers/net/wireguard/receive.c | 12 ++++++------
>  drivers/net/wireguard/send.c    |  3 ++-
>  3 files changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/devic=
e.c
> index 258dcc1039216f311a223fd348295d4b5e03a3ed..deb9636b0ecf8f47e832a0b07=
e9e049ba19bdf16 100644
> --- a/drivers/net/wireguard/device.c
> +++ b/drivers/net/wireguard/device.c
> @@ -210,7 +210,7 @@ static netdev_tx_t wg_xmit(struct sk_buff *skb, struc=
t net_device *dev)
>          */
>         while (skb_queue_len(&peer->staged_packet_queue) > MAX_STAGED_PAC=
KETS) {
>                 dev_kfree_skb(__skb_dequeue(&peer->staged_packet_queue));
> -               ++dev->stats.tx_dropped;
> +               DEV_STATS_INC(dev, tx_dropped);
>         }
>         skb_queue_splice_tail(&packets, &peer->staged_packet_queue);
>         spin_unlock_bh(&peer->staged_packet_queue.lock);
> @@ -228,7 +228,7 @@ static netdev_tx_t wg_xmit(struct sk_buff *skb, struc=
t net_device *dev)
>         else if (skb->protocol =3D=3D htons(ETH_P_IPV6))
>                 icmpv6_ndo_send(skb, ICMPV6_DEST_UNREACH, ICMPV6_ADDR_UNR=
EACH, 0);
>  err:
> -       ++dev->stats.tx_errors;
> +       DEV_STATS_INC(dev, tx_errors);
>         kfree_skb(skb);
>         return ret;
>  }
> diff --git a/drivers/net/wireguard/receive.c b/drivers/net/wireguard/rece=
ive.c
> index 0b3f0c843550957ee1fe3bed7185a7d990246c2b..a176653c88616b1bc871fe52f=
cea778b5e189f69 100644
> --- a/drivers/net/wireguard/receive.c
> +++ b/drivers/net/wireguard/receive.c
> @@ -416,20 +416,20 @@ static void wg_packet_consume_data_done(struct wg_p=
eer *peer,
>         net_dbg_skb_ratelimited("%s: Packet has unallowed src IP (%pISc) =
from peer %llu (%pISpfsc)\n",
>                                 dev->name, skb, peer->internal_id,
>                                 &peer->endpoint.addr);
> -       ++dev->stats.rx_errors;
> -       ++dev->stats.rx_frame_errors;
> +       DEV_STATS_INC(dev, rx_errors);
> +       DEV_STATS_INC(dev, rx_frame_errors);
>         goto packet_processed;
>  dishonest_packet_type:
>         net_dbg_ratelimited("%s: Packet is neither ipv4 nor ipv6 from pee=
r %llu (%pISpfsc)\n",
>                             dev->name, peer->internal_id, &peer->endpoint=
.addr);
> -       ++dev->stats.rx_errors;
> -       ++dev->stats.rx_frame_errors;
> +       DEV_STATS_INC(dev, rx_errors);
> +       DEV_STATS_INC(dev, rx_frame_errors);
>         goto packet_processed;
>  dishonest_packet_size:
>         net_dbg_ratelimited("%s: Packet has incorrect size from peer %llu=
 (%pISpfsc)\n",
>                             dev->name, peer->internal_id, &peer->endpoint=
.addr);
> -       ++dev->stats.rx_errors;
> -       ++dev->stats.rx_length_errors;
> +       DEV_STATS_INC(dev, rx_errors);
> +       DEV_STATS_INC(dev, rx_length_errors);
>         goto packet_processed;
>  packet_processed:
>         dev_kfree_skb(skb);
> diff --git a/drivers/net/wireguard/send.c b/drivers/net/wireguard/send.c
> index 95c853b59e1dae1df8b4e5cbf4e3541e35806b82..0d48e0f4a1ba3e1f11825136a=
65de0867b204496 100644
> --- a/drivers/net/wireguard/send.c
> +++ b/drivers/net/wireguard/send.c
> @@ -333,7 +333,8 @@ static void wg_packet_create_data(struct wg_peer *pee=
r, struct sk_buff *first)
>  void wg_packet_purge_staged_packets(struct wg_peer *peer)
>  {
>         spin_lock_bh(&peer->staged_packet_queue.lock);
> -       peer->device->dev->stats.tx_dropped +=3D peer->staged_packet_queu=
e.qlen;
> +       DEV_STATS_ADD(peer->device->dev, tx_dropped,
> +                     peer->staged_packet_queue.qlen);
>         __skb_queue_purge(&peer->staged_packet_queue);
>         spin_unlock_bh(&peer->staged_packet_queue.lock);
>  }

This is probably fine if you want to do it and feel strongly about it,
and you can take this directly into net/net-next with my:

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

However, I recall evaluating the races here long ago and deliberately
deciding not to do anything about it. Sure KCSAN will complain, but
these stats being pixel perfect isn't really _that_ important and it
really doesn't seem worth it to have the performance hit of several
atomics on every packet. There's also peer->{r,t}x_bytes that should
probably be adjusted if you're going to change these. But again - is
it really worth it to do that? It just seems like such an unnecessary
performance hit.

So I think I'd prefer to _not_ fix this. But if you feel really
strongly about it, I'll be okay deferring to your judgement.

Jason


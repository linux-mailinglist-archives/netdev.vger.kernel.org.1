Return-Path: <netdev+bounces-63093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6648582B2E6
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 17:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41BE1F25AAD
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 16:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B294F5FB;
	Thu, 11 Jan 2024 16:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K56N9zw2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375C1495D5
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55818b7053eso12830a12.0
        for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 08:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704990388; x=1705595188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K30QLyCbHCL75IsyofqnBHA8mjC9PVkRkBbAX6BkpK0=;
        b=K56N9zw2RDj3lCyryyCKgmAdYOxn1ZqayPiOdpCfBB8N6EYYd6lejGumKg/Wv10lvh
         8HfA4zd0EI3xqkYxC27QyW8NUsl6o4Jckk7TR3WrBN5Te8IVOGAF0g/KKXSJX17aVDpO
         5Audfjxq2nC+Bqz6WNPxLY6oWC0iHyiROwz1vh54dpVJt+V9k6CWDD4oNjhWwk605hnQ
         eU+jEznaumA8qzAXHLrY94V5Hs3+fSIkxaG8XWJnbMljKPNH1NriUPl6hWh5YqVDa3UE
         BhsI5uPUNUwLjTeiFpAn70owliUFnPMoiHYSBud0/Ks10N1aGUnVZpgHXorJ6A8Ch8uQ
         c79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704990388; x=1705595188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K30QLyCbHCL75IsyofqnBHA8mjC9PVkRkBbAX6BkpK0=;
        b=jcaNDB+G/9XabLqrTedREQ8LZNfHL6rHoLOQYAPXe+OM5AoS878yiWAXwkgFKLoNnh
         gpIiVKlL18uN7227960bAbi2NNqpCqb4Hqwog7pAyFfw609OKG3boGqE8DS8PqqCwY8K
         qQrVnuabwmfJ3fce4qOT9USkTSxQBtNWXD0VZE9nD+yDRDZLwpP4gM1LpyEaneLnd51c
         tg0J4LUoGfEGNFQ9misL63X8xZvcdV863C1mngxyGGXfJyGmfsyBk49RkkkYw1Wr2wKO
         maq5idQqhgRm++pqAZSs5yRjXim1dE3skVTx8DtSkXR7sNOymjm4B8ZJF0oEKco1pRdz
         tu+g==
X-Gm-Message-State: AOJu0Yxxc9aBumvaVbec8NbMVmnM7F5rTO12NBL4ucUfRZjOrT7uevyQ
	E9dNesC2tS6rSUYWoIQ/MkKXKn6BudTVR5FbuxmgTpXwBdTq
X-Google-Smtp-Source: AGHT+IGG/epSnevZ3tibTtsyj6ljbUTjIpunG+bc1R+QOl/x0GDHrqpNq3C6hvaHo8gUIsrVp/EukS3BSyyLaI9hNG4=
X-Received: by 2002:aa7:c411:0:b0:558:b501:1d2a with SMTP id
 j17-20020aa7c411000000b00558b5011d2amr49800edq.6.1704990388229; Thu, 11 Jan
 2024 08:26:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111154138.7605-1-n.zhandarovich@fintech.ru>
In-Reply-To: <20240111154138.7605-1-n.zhandarovich@fintech.ru>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Jan 2024 17:26:17 +0100
Message-ID: <CANn89iJaxTFGNFqmCJSQfr9nwHUPK6DBnK1oZ1sJ2Gm6eqebag@mail.gmail.com>
Subject: Re: [PATCH net] wireguard: receive: annotate data-race around receiving_counter.counter
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, wireguard@lists.zx2c4.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot <syzkaller@googlegroups.com>, 
	syzbot+d1de830e4ecdaac83d89@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 4:41=E2=80=AFPM Nikita Zhandarovich
<n.zhandarovich@fintech.ru> wrote:
>
> Syzkaller with KCSAN identified a data-race issue [1] when accessing
> keypair->receiving_counter.counter.
>
> This patch uses READ_ONCE() and WRITE_ONCE() annotations to fix the
> problem.
>
> [1]
> BUG: KCSAN: data-race in wg_packet_decrypt_worker / wg_packet_rx_poll
>
> write to 0xffff888107765888 of 8 bytes by interrupt on cpu 0:
>  counter_validate drivers/net/wireguard/receive.c:321 [inline]
>  wg_packet_rx_poll+0x3ac/0xf00 drivers/net/wireguard/receive.c:461
>  __napi_poll+0x60/0x3b0 net/core/dev.c:6536
>  napi_poll net/core/dev.c:6605 [inline]
>  net_rx_action+0x32b/0x750 net/core/dev.c:6738
>  __do_softirq+0xc4/0x279 kernel/softirq.c:553
>  do_softirq+0x5e/0x90 kernel/softirq.c:454
>  __local_bh_enable_ip+0x64/0x70 kernel/softirq.c:381
>  __raw_spin_unlock_bh include/linux/spinlock_api_smp.h:167 [inline]
>  _raw_spin_unlock_bh+0x36/0x40 kernel/locking/spinlock.c:210
>  spin_unlock_bh include/linux/spinlock.h:396 [inline]
>  ptr_ring_consume_bh include/linux/ptr_ring.h:367 [inline]
>  wg_packet_decrypt_worker+0x6c5/0x700 drivers/net/wireguard/receive.c:499
>  process_one_work kernel/workqueue.c:2633 [inline]
>  ...
>
> read to 0xffff888107765888 of 8 bytes by task 3196 on cpu 1:
>  decrypt_packet drivers/net/wireguard/receive.c:252 [inline]
>  wg_packet_decrypt_worker+0x220/0x700 drivers/net/wireguard/receive.c:501
>  process_one_work kernel/workqueue.c:2633 [inline]
>  process_scheduled_works+0x5b8/0xa30 kernel/workqueue.c:2706
>  worker_thread+0x525/0x730 kernel/workqueue.c:2787
>  ...
>
> Fixes: a9e90d9931f3 ("wireguard: noise: separate receive counter from sen=
d counter")
> Reported-by: syzbot+d1de830e4ecdaac83d89@syzkaller.appspotmail.com
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> ---
>  drivers/net/wireguard/receive.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireguard/receive.c b/drivers/net/wireguard/rece=
ive.c
> index a176653c8861..d91383afb6e2 100644
> --- a/drivers/net/wireguard/receive.c
> +++ b/drivers/net/wireguard/receive.c
> @@ -251,7 +251,7 @@ static bool decrypt_packet(struct sk_buff *skb, struc=
t noise_keypair *keypair)
>
>         if (unlikely(!READ_ONCE(keypair->receiving.is_valid) ||
>                   wg_birthdate_has_expired(keypair->receiving.birthdate, =
REJECT_AFTER_TIME) ||
> -                 keypair->receiving_counter.counter >=3D REJECT_AFTER_ME=
SSAGES)) {
> +                 READ_ONCE(keypair->receiving_counter.counter) >=3D REJE=
CT_AFTER_MESSAGES)) {
>                 WRITE_ONCE(keypair->receiving.is_valid, false);
>                 return false;
>         }
> @@ -318,7 +318,7 @@ static bool counter_validate(struct noise_replay_coun=
ter *counter, u64 their_cou
>                 for (i =3D 1; i <=3D top; ++i)
>                         counter->backtrack[(i + index_current) &
>                                 ((COUNTER_BITS_TOTAL / BITS_PER_LONG) - 1=
)] =3D 0;
> -               counter->counter =3D their_counter;
> +               WRITE_ONCE(counter->counter, their_counter);
>         }
>
>         index &=3D (COUNTER_BITS_TOTAL / BITS_PER_LONG) - 1;

It seems you forgot to add this as well ?

diff --git a/drivers/net/wireguard/receive.c b/drivers/net/wireguard/receiv=
e.c
index a176653c88616b1bc871fe52fcea778b5e189f69..a1493c94cea042165f8523a4dac=
573800a6d03c4
100644
--- a/drivers/net/wireguard/receive.c
+++ b/drivers/net/wireguard/receive.c
@@ -463,7 +463,7 @@ int wg_packet_rx_poll(struct napi_struct *napi, int bud=
get)
                        net_dbg_ratelimited("%s: Packet has invalid
nonce %llu (max %llu)\n",
                                            peer->device->dev->name,
                                            PACKET_CB(skb)->nonce,
-                                           keypair->receiving_counter.coun=
ter);
+
READ_ONCE(keypair->receiving_counter.counter));
                        goto next;
                }

Thanks.


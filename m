Return-Path: <netdev+bounces-220613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA952B4760A
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 20:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2221C5A0A51
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 18:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FEF1D86FF;
	Sat,  6 Sep 2025 18:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfBRtidd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C0B161302;
	Sat,  6 Sep 2025 18:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757182559; cv=none; b=ap6jsbN79wfNRyCE2eqQhA0+PR1lXOFcKY6Lj7ena9rkh/iwyTj41NGd+iU2N3KLgAAO/AH4IBZc9ay3krn8mhkHYFBeH77/JTAL5l4XG6MyyZm9GzAT3viU5RQsqxl++eyA0hIjEnEtThSR/oUm+zo0ZAZZJUzOC5te6JhY+pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757182559; c=relaxed/simple;
	bh=pKDzSmvIL4lTSgcD8iCFGONY0vje+Wa8Erwm+y186X0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=REOpuw+UdXyg0D6rJNJrU8f6BR7kH4c+6n67IkocWaOruTxT4eYcL++4rWQnZ7ZtC872eaaqIczY9+K4W2w3ZjXYDFyqkyLo0Tlf/cY3qZhvMeGG5ofUzMTSW4XIww/LHFnm6Xqx26juxDctZlOkunRRFWz+Ud9RgUCuPUPYSaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfBRtidd; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3fc5f086877so5294395ab.0;
        Sat, 06 Sep 2025 11:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757182557; x=1757787357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FHryJ0rhZkGy+sVtJCQBeUtGMf5DFgMMGvlR5feEKM=;
        b=GfBRtiddH9KLZCGC7DEzIwCgGeV+m8bYim0ekSNkKRmreFyicylCFoKM1hDzSc2/uY
         PyQ98hp+kJIAoOLMq2RVmDb8PD+JE6ac2sTmW48S4OAwUW5ax9TEsnULvcJybbKBY9fZ
         rlo4xWSVU7UUqkJzeq5fyJ5GoJVV9shdBteZAXlYocMZRecNrWHk9vgZK4C9Ee+iVM5Z
         k1PfDfTekEyLfSCymw6RX0hQzHG1vo3xlDonP8y67lwVgP3a/0lT6ikfJcRLiKWl6xDc
         9Of0wUjit63t1eW3UXX8JlCn1zDveOddT0rTcAIf0/JBk52XPbtR2SIU7uf5jMpOCJt8
         7SuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757182557; x=1757787357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FHryJ0rhZkGy+sVtJCQBeUtGMf5DFgMMGvlR5feEKM=;
        b=loXbyameUPeknQzQfk+endcM2BiDaJ099FlcY2D9LpP5iuoOzk+XAHkhco2fDqRQvy
         j9ZW+Crs/dg3muiSg0fHK1rxg6iNzKCa+vWh7HDPr3UKEaqNtnAlhnXTF+iYG4dd4wZV
         JrExMfFUNr0O9oPEw6aZXEhdrPm8+KPgj4itgmBhLexPpUglHVwG6mEnCfB7o7S3CjcY
         iuw4vpKZfvZQRUtPCnzLyGa+MD7ymybg/dP8p+9xs1pS8W5H663YUS4zeljsKorRv8bH
         z4UA8pRVzb8Z4JAr8kCNCtX/BpJjPKJxpEWjU7a7zcwoIijYRQOJQA9lcWPUX7AiLKLN
         J7/w==
X-Forwarded-Encrypted: i=1; AJvYcCVnGNVPlLoq/koMbQ8ctdSJZiYvHDkXVsoHx63XQSNyu4MTqQDqtfLjMtpNZ24N6xCd1i6F3doY8H+uGaM=@vger.kernel.org, AJvYcCXZKTqZAitGQ5QKL0qKsKKcXQIvosyY0FrsKwlRxCGrNYlP8KJTqQ6313N6cHerAqIgEq+xQ5oj@vger.kernel.org
X-Gm-Message-State: AOJu0YxKldj8VT4tDGFn1KhA4jBIEvI8gkC5mzcfFADvxpIRihsQK4E3
	IkRMm82SRlaIiPVB+6x69KL+FT1RLG4kZ1Oz4k5uxoycYq3IHJFAa2pGQam394EZP+wMO8KKRhf
	UPLNLODR4lrYXRN4dW2Zxa/GUrUxZIw4=
X-Gm-Gg: ASbGncv/uutMgW+Bei2cTkBDdV9hXX93TK4pDHFG1miXsqyibi7dxoRGRraGXUo2mIV
	T0XmLlHNkjRS8kOpYL2p1KNdg0V0U974/VbvGzzvtMSgKEOLyo6paorxVLSqVDRt+99BDh+eOcv
	2vGnnKHzoEd6wVkqYMaHNxa+d/BttUC+aK9nLbuJ5lPQe7BhoZ3JnUacu1+s79b+8qYQL9yqrxB
	Az+UyP41CuRDM80Gm8l
X-Google-Smtp-Source: AGHT+IFli/L2H8SCbAMQ8WaD1sODAZpWj5uRDs+iOM+Z/3fKp6bYqoRoCLr0lD65Z8Th5Etbd6oFCRE9OJXRBA0iokw=
X-Received: by 2002:a05:6e02:1feb:b0:3e6:65d5:2278 with SMTP id
 e9e14a558f8ab-3fd7e252a7cmr35852525ab.5.1757182556476; Sat, 06 Sep 2025
 11:15:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250906173001.3656356-1-jackzxcui1989@163.com> <20250906173001.3656356-3-jackzxcui1989@163.com>
In-Reply-To: <20250906173001.3656356-3-jackzxcui1989@163.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 7 Sep 2025 02:15:20 +0800
X-Gm-Features: Ac12FXyQqMrZN9H10D6304dYG5mZrknjFm38A5xFFIQ3UWWCYDIUtSlv1BtjX80
Message-ID: <CAL+tcoA8pvTNSNKfxdGLm+chnMkUNkPCdJKMNacWxE3mAV4A6Q@mail.gmail.com>
Subject: Re: [PATCH net-next v11 2/2] net: af_packet: Use hrtimer to do the
 retire operation
To: Xin Zhao <jackzxcui1989@163.com>
Cc: willemdebruijn.kernel@gmail.com, edumazet@google.com, ferenc@fejes.dev, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 7, 2025 at 1:30=E2=80=AFAM Xin Zhao <jackzxcui1989@163.com> wro=
te:
>
> In a system with high real-time requirements, the timeout mechanism of
> ordinary timers with jiffies granularity is insufficient to meet the
> demands for real-time performance. Meanwhile, the optimization of CPU
> usage with af_packet is quite significant. Use hrtimer instead of timer
> to help compensate for the shortcomings in real-time performance.
> In HZ=3D100 or HZ=3D250 system, the update of TP_STATUS_USER is not real-=
time
> enough, with fluctuations reaching over 8ms (on a system with HZ=3D250).
> This is unacceptable in some high real-time systems that require timely
> processing of network packets. By replacing it with hrtimer, if a timeout
> of 2ms is set, the update of TP_STATUS_USER can be stabilized to within
> 3 ms.

You might miss stating the reason why you move one structure member
delete_blk_timer.

>
> Reviewed-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> Link: https://lore.kernel.org/all/20250831100822.1238795-1-jackzxcui1989@=
163.com/
> Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
> ---
> Changes in v11:
> - structure tpacket_kbdq_core needs a new organization
>   as suggested by Jason Xing.
> - Change the comments of prb_retire_rx_blk_timer_expired and prb_open_blo=
ck
>   as suggested by Jason Xing.
>
> Changes in v9:
> - Remove the function prb_setup_retire_blk_timer and move hrtimer setup a=
nd start
>   logic into function init_prb_bdqc
>   as suggested by Willem de Bruijn.
> - Remove 'refresh_timer:' label which is not needed while I change goto l=
ogic to
>   if-else implementation.
>
> Changes in v8:
> - Delete delete_blk_timer field, as suggested by Willem de Bruijn,
>   hrtimer_cancel will check and wait until the timer callback return and =
ensure
>   enter enter callback again.
> - Simplify the logic related to setting timeout, as suggestd by Willem de=
 Bruijn.
>   Currently timer callback just restarts itself unconditionally, so delet=
e the
>   'out:' label, do not forward hrtimer in prb_open_block, call hrtimer_fo=
rward_now
>   directly and always return HRTIMER_RESTART.
>   The only special case is when prb_open_block is called from tpacket_rcv=
. That
>   would set the timeout further into the future than the already queued t=
imer.
>   An earlier timeout is not problematic. No need to add complexity to avo=
id that.
>
> Changes in v7:
> - Only update the hrtimer expire time within the hrtimer callback.
>   When the callback return, without sk_buff_head lock protection, __run_h=
rtimer will
>   enqueue the timer if return HRTIMER_RESTART. Setting the hrtimer expire=
s while
>   enqueuing a timer may cause chaos in the hrtimer red-black tree.
>
> Changes in v2:
> - Drop the tov_in_msecs field of tpacket_kbdq_core added by the patch
>   as suggested by Willem de Bruijn.
>
> Changes in v1:
> - Do not add another config for the current changes
>   as suggested by Eric Dumazet.
> - Mention the beneficial cases 'HZ=3D100 or HZ=3D250' and performance det=
ails
>   in the changelog
>   as suggested by Eric Dumazet and Ferenc Fejes.
> - Delete the 'pkc->tov_in_msecs =3D=3D 0' bounds check which is not neces=
sary
>   as suggested by Willem de Bruijn.
>
> ---
>  net/packet/af_packet.c | 108 ++++++++++++-----------------------------
>  net/packet/diag.c      |   2 +-
>  net/packet/internal.h  |  10 ++--
>  3 files changed, 38 insertions(+), 82 deletions(-)
>
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index d4eb4a4fe..d55528776 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -203,8 +203,7 @@ static void prb_retire_current_block(struct tpacket_k=
bdq_core *,
>  static int prb_queue_frozen(struct tpacket_kbdq_core *);
>  static void prb_open_block(struct tpacket_kbdq_core *,
>                 struct tpacket_block_desc *);
> -static void prb_retire_rx_blk_timer_expired(struct timer_list *);
> -static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *)=
;
> +static enum hrtimer_restart prb_retire_rx_blk_timer_expired(struct hrtim=
er *);
>  static void prb_fill_rxhash(struct tpacket_kbdq_core *, struct tpacket3_=
hdr *);
>  static void prb_clear_rxhash(struct tpacket_kbdq_core *,
>                 struct tpacket3_hdr *);
> @@ -579,33 +578,13 @@ static __be16 vlan_get_protocol_dgram(const struct =
sk_buff *skb)
>         return proto;
>  }
>
> -static void prb_del_retire_blk_timer(struct tpacket_kbdq_core *pkc)
> -{
> -       timer_delete_sync(&pkc->retire_blk_timer);
> -}
> -
>  static void prb_shutdown_retire_blk_timer(struct packet_sock *po,
>                 struct sk_buff_head *rb_queue)
>  {
>         struct tpacket_kbdq_core *pkc;
>
>         pkc =3D GET_PBDQC_FROM_RB(&po->rx_ring);
> -
> -       spin_lock_bh(&rb_queue->lock);
> -       pkc->delete_blk_timer =3D 1;
> -       spin_unlock_bh(&rb_queue->lock);
> -
> -       prb_del_retire_blk_timer(pkc);
> -}
> -
> -static void prb_setup_retire_blk_timer(struct packet_sock *po)
> -{
> -       struct tpacket_kbdq_core *pkc;
> -
> -       pkc =3D GET_PBDQC_FROM_RB(&po->rx_ring);
> -       timer_setup(&pkc->retire_blk_timer, prb_retire_rx_blk_timer_expir=
ed,
> -                   0);
> -       pkc->retire_blk_timer.expires =3D jiffies;
> +       hrtimer_cancel(&pkc->retire_blk_timer);
>  }
>
>  static int prb_calc_retire_blk_tmo(struct packet_sock *po,
> @@ -671,53 +650,40 @@ static void init_prb_bdqc(struct packet_sock *po,
>         p1->version =3D po->tp_version;
>         po->stats.stats3.tp_freeze_q_cnt =3D 0;
>         if (req_u->req3.tp_retire_blk_tov)
> -               p1->retire_blk_tov =3D req_u->req3.tp_retire_blk_tov;
> +               p1->interval_ktime =3D ms_to_ktime(req_u->req3.tp_retire_=
blk_tov);
>         else
> -               p1->retire_blk_tov =3D prb_calc_retire_blk_tmo(po,
> -                                               req_u->req3.tp_block_size=
);
> -       p1->tov_in_jiffies =3D msecs_to_jiffies(p1->retire_blk_tov);
> +               p1->interval_ktime =3D ms_to_ktime(prb_calc_retire_blk_tm=
o(po,
> +                                                req_u->req3.tp_block_siz=
e));
>         p1->blk_sizeof_priv =3D req_u->req3.tp_sizeof_priv;
>         rwlock_init(&p1->blk_fill_in_prog_lock);
>
>         p1->max_frame_len =3D p1->kblk_size - BLK_PLUS_PRIV(p1->blk_sizeo=
f_priv);
>         prb_init_ft_ops(p1, req_u);
> -       prb_setup_retire_blk_timer(po);
> +       hrtimer_setup(&p1->retire_blk_timer, prb_retire_rx_blk_timer_expi=
red,
> +                     CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
> +       hrtimer_start(&p1->retire_blk_timer, p1->interval_ktime,
> +                     HRTIMER_MODE_REL_SOFT);
>         prb_open_block(p1, pbd);
>  }
>
> -/*  Do NOT update the last_blk_num first.
> - *  Assumes sk_buff_head lock is held.
> - */
> -static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *p=
kc)
> -{
> -       mod_timer(&pkc->retire_blk_timer,
> -                       jiffies + pkc->tov_in_jiffies);
> -}
> -
>  /*
> - * Timer logic:
> - * 1) We refresh the timer only when we open a block.
> - *    By doing this we don't waste cycles refreshing the timer
> - *       on packet-by-packet basis.
> - *
>   * With a 1MB block-size, on a 1Gbps line, it will take
>   * i) ~8 ms to fill a block + ii) memcpy etc.
>   * In this cut we are not accounting for the memcpy time.
>   *
> - * So, if the user sets the 'tmo' to 10ms then the timer
> - * will never fire while the block is still getting filled
> - * (which is what we want). However, the user could choose
> - * to close a block early and that's fine.
> - *
> - * But when the timer does fire, we check whether or not to refresh it.
>   * Since the tmo granularity is in msecs, it is not too expensive
>   * to refresh the timer, lets say every '8' msecs.
>   * Either the user can set the 'tmo' or we can derive it based on
>   * a) line-speed and b) block-size.
>   * prb_calc_retire_blk_tmo() calculates the tmo.
>   *
> + * The retire hrtimer expiration is unconditional and periodic.

The code itself is self-explanatory.

If I were you, I would move part of the comments like this into the
commit message to explicitly demonstrate the historical changes. But
it's only me.

> + * See comment in prb_open_block.
> + *
> + * If there are numerous packet sockets on the system, please set an
> + * appropriate timeout to avoid frequent enqueueing of hrtimers.
>   */
> -static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
> +static enum hrtimer_restart prb_retire_rx_blk_timer_expired(struct hrtim=
er *t)
>  {
>         struct packet_sock *po =3D
>                 timer_container_of(po, t, rx_ring.prb_bdqc.retire_blk_tim=
er);
> @@ -730,9 +696,6 @@ static void prb_retire_rx_blk_timer_expired(struct ti=
mer_list *t)
>         frozen =3D prb_queue_frozen(pkc);
>         pbd =3D GET_CURR_PBLOCK_DESC_FROM_CORE(pkc);
>
> -       if (unlikely(pkc->delete_blk_timer))
> -               goto out;
> -
>         /* We only need to plug the race when the block is partially fill=
ed.
>          * tpacket_rcv:
>          *              lock(); increment BLOCK_NUM_PKTS; unlock()
> @@ -749,26 +712,16 @@ static void prb_retire_rx_blk_timer_expired(struct =
timer_list *t)
>         }
>
>         if (!frozen) {
> -               if (!BLOCK_NUM_PKTS(pbd)) {
> -                       /* An empty block. Just refresh the timer. */
> -                       goto refresh_timer;
> +               if (BLOCK_NUM_PKTS(pbd)) {
> +                       /* Not an empty block. Need retire the block. */
> +                       prb_retire_current_block(pkc, po, TP_STATUS_BLK_T=
MO);
> +                       prb_dispatch_next_block(pkc, po);
>                 }
> -               prb_retire_current_block(pkc, po, TP_STATUS_BLK_TMO);
> -               if (!prb_dispatch_next_block(pkc, po))
> -                       goto refresh_timer;
> -               else
> -                       goto out;
>         } else {
>                 /* Case 1. Queue was frozen because user-space was
>                  * lagging behind.
>                  */
> -               if (prb_curr_blk_in_use(pbd)) {
> -                       /*
> -                        * Ok, user-space is still behind.
> -                        * So just refresh the timer.
> -                        */
> -                       goto refresh_timer;
> -               } else {
> +               if (!prb_curr_blk_in_use(pbd)) {
>                         /* Case 2. queue was frozen,user-space caught up,
>                          * now the link went idle && the timer fired.
>                          * We don't have a block to close.So we open this
> @@ -777,15 +730,12 @@ static void prb_retire_rx_blk_timer_expired(struct =
timer_list *t)
>                          * Thawing/timer-refresh is a side effect.
>                          */
>                         prb_open_block(pkc, pbd);
> -                       goto out;
>                 }
>         }
>
> -refresh_timer:
> -       _prb_refresh_rx_retire_blk_timer(pkc);
> -
> -out:
> +       hrtimer_forward_now(&pkc->retire_blk_timer, pkc->interval_ktime);
>         spin_unlock(&po->sk.sk_receive_queue.lock);
> +       return HRTIMER_RESTART;
>  }
>
>  static void prb_flush_block(struct tpacket_kbdq_core *pkc1,
> @@ -879,11 +829,18 @@ static void prb_thaw_queue(struct tpacket_kbdq_core=
 *pkc)
>  }
>
>  /*
> - * Side effect of opening a block:
> + * prb_open_block is called by tpacket_rcv or timer callback.
>   *
> - * 1) prb_queue is thawed.
> - * 2) retire_blk_timer is refreshed.
> + * Reasons why NOT update hrtimer in prb_open_block:
> + * 1) It will increase complexity to distinguish the two caller scenario=
.
> + * 2) hrtimer_cancel and hrtimer_start need to be called if you want to =
update
> + * TMO of an already enqueued hrtimer, leading to complex shutdown logic=
.
>   *
> + * One side effect of NOT update hrtimer when called by tpacket_rcv is t=
hat
> + * a newly opened block triggered by tpacket_rcv may be retired earlier =
than
> + * expected. On the other hand, if timeout is updated in prb_open_block,=
 the
> + * frequent reception of network packets that leads to prb_open_block be=
ing
> + * called may cause hrtimer to be removed and enqueued repeatedly.

Same here. The idea and reasoning behind this function/timer would be
better to move into the commit message as well.

Let Willem make the final call :)

Thanks,
Jason

>   */
>  static void prb_open_block(struct tpacket_kbdq_core *pkc1,
>         struct tpacket_block_desc *pbd1)
> @@ -917,7 +874,6 @@ static void prb_open_block(struct tpacket_kbdq_core *=
pkc1,
>         pkc1->pkblk_end =3D pkc1->pkblk_start + pkc1->kblk_size;
>
>         prb_thaw_queue(pkc1);
> -       _prb_refresh_rx_retire_blk_timer(pkc1);
>
>         smp_wmb();
>  }
> diff --git a/net/packet/diag.c b/net/packet/diag.c
> index 6ce1dcc28..c8f43e0c1 100644
> --- a/net/packet/diag.c
> +++ b/net/packet/diag.c
> @@ -83,7 +83,7 @@ static int pdiag_put_ring(struct packet_ring_buffer *ri=
ng, int ver, int nl_type,
>         pdr.pdr_frame_nr =3D ring->frame_max + 1;
>
>         if (ver > TPACKET_V2) {
> -               pdr.pdr_retire_tmo =3D ring->prb_bdqc.retire_blk_tov;
> +               pdr.pdr_retire_tmo =3D ktime_to_ms(ring->prb_bdqc.interva=
l_ktime);
>                 pdr.pdr_sizeof_priv =3D ring->prb_bdqc.blk_sizeof_priv;
>                 pdr.pdr_features =3D ring->prb_bdqc.feature_req_word;
>         } else {
> diff --git a/net/packet/internal.h b/net/packet/internal.h
> index d367b9f93..b76e645cd 100644
> --- a/net/packet/internal.h
> +++ b/net/packet/internal.h
> @@ -20,10 +20,11 @@ struct tpacket_kbdq_core {
>         unsigned int    feature_req_word;
>         unsigned int    hdrlen;
>         unsigned char   reset_pending_on_curr_blk;
> -       unsigned char   delete_blk_timer;
>         unsigned short  kactive_blk_num;
>         unsigned short  blk_sizeof_priv;
>
> +       unsigned short  version;
> +
>         char            *pkblk_start;
>         char            *pkblk_end;
>         int             kblk_size;
> @@ -32,6 +33,7 @@ struct tpacket_kbdq_core {
>         uint64_t        knxt_seq_num;
>         char            *prev;
>         char            *nxt_offset;
> +
>         struct sk_buff  *skb;
>
>         rwlock_t        blk_fill_in_prog_lock;
> @@ -39,12 +41,10 @@ struct tpacket_kbdq_core {
>         /* Default is set to 8ms */
>  #define DEFAULT_PRB_RETIRE_TOV (8)
>
> -       unsigned short  retire_blk_tov;
> -       unsigned short  version;
> -       unsigned long   tov_in_jiffies;
> +       ktime_t         interval_ktime;
>
>         /* timer to retire an outstanding block */
> -       struct timer_list retire_blk_timer;
> +       struct hrtimer  retire_blk_timer;
>  };
>
>  struct pgv {
> --
> 2.34.1
>


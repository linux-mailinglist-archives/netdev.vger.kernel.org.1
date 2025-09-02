Return-Path: <netdev+bounces-219228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22024B4095F
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 17:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E0FF1B22AAA
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 15:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2CE32ED50;
	Tue,  2 Sep 2025 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAKpTfrK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD08832ED56;
	Tue,  2 Sep 2025 15:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756827845; cv=none; b=EvyQtZO+qqKGEdo1bz0k/50Qi17d2jgP8uUGGqSXPNlX4FROe1t5sceY35HhpLXPwfrh7KyAI4sKd/iORkZSn/eKP2yM6jafPApIiM7Fm+fZlCCJbq7JdRmtHMG5EivkCypmTR+pSX3gSlhuD1m6ep06WB/j/mKt8XRIvY1pego=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756827845; c=relaxed/simple;
	bh=XOTI0+936W4tD73h1aCDakrzYu2ttsm/3s2J1bYpgOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gWSDUseJ00Qb1shy3kQJW6L/ywMBdnKBKA+O1NVGKNitFTuP77XqGsz8bI926dAom1X0pr7PL5m0lEQZsCONnsOetqS+hmu5lsxXzDONdGz6C2MzuhL5kSBxXrALUFq+brB+kAOYTUQO9YDsopslXPzWW0LdWiuwK9zGYGQMKeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAKpTfrK; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3ea8b3a64c7so24202325ab.0;
        Tue, 02 Sep 2025 08:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756827842; x=1757432642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8agd8UEMtfGe6Ku/7+zpVWyZrLtCJJAshlY8SeQGlE=;
        b=RAKpTfrK7A44Zdg73/pDfUmiRccfYf86P3QYZqvchrb1yXnWcC/USL2eUffTSM2Dwy
         Wi+ZZzonhJ50jGkdIEBes/lRN5h+lZZLDapeOWJ99lNpCs8BluDd3M9Jd+3fbRD7FrMW
         DgAudAScsic/hqSK/vU1tvOrBrcv+v8+rvHtRaF5MhwGC+bZ4RqVBkXzCkLnmUt5lb1k
         6RjoNxMunVUbFzj0xIB+w+B1+dnW9h7NBRMuZ33toKmr0HH1/3CSiga2R208VKxAuqLp
         Yeaec+6xZwdlPEyqKIKgkR2aXSLC2frACZDVUXalQji2IiNcZZtLA+JFASxVHUJrT7lo
         RWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756827842; x=1757432642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o8agd8UEMtfGe6Ku/7+zpVWyZrLtCJJAshlY8SeQGlE=;
        b=oFhuYP+QOQfEwk5m83sFmj1/rjA0VbbnqZaDAKWbt+sRp2V4JhJzI5nTEtNx2w2NC+
         6Fv6x+XlgXXigzWLo7U/mg08xqCTC+QBcFBqqoCKJnKEtJBIT85nwe5mmNzd02fWPvEb
         iUsw5tMfZPwTCFfCsRxWuRMmkeTX3zUaWJLEapzWMwujvYPBHv7QurONAFIMr+fqz/Mc
         OoxJZ0oYvfadRLBpHCZBsNqY19hpBPqMfEsVnp1yLCl36xih/XA+m629gBHb4owdyjZt
         H46jAQHoVSKWY+F1d/UmVm5p1RyqWDUJen/ZDV+NpPbGLRDrhMdgfLHclATBjF+6VdDa
         072Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmnMUAS46nhBOzbRPtv47g9De1BWm8QGN2efgho4izPOaeJAMqZ6GqJpr++lE8xDOaDJgtiXOt@vger.kernel.org, AJvYcCWRQhEw90EWfR2DXqb2HSRlL3aIKkPY9TzUalACTL1DQahhOXCy2NbZG/otpKdgza3V0hf+9DF21sS+EF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEMdmlkeWtMonqAeDM8hvHoyMiORu+Fn1ar/nIG0YxDkOv3IKR
	6sSZNWuj3X+4LKS2zCqNHQS/jeTTtH1jxvK7y0//IZYl0xiHDmlJTraXxPN0w1/MZKaSxnPNxkL
	BbWfGemSFpkmgsZfQSLeUBtRJyk+sBvE=
X-Gm-Gg: ASbGncuBn4UH1U6/he0tVuCgutITXcZE/Xrah5vVZXw9T92e+ed5VBmpb2J3nyQ0UOB
	YerXT6dtpWL/Q/9O1xm41yTVhL3bEbgjxW5oHew9zXqZd/mtsspMUQjXUGCqDnF+S3u7D/cdZJs
	59veYT6niMvvLt4b1agZeVtbbxFpiOvkUukdpGZ+PKitHn2m9bilpk1/RIDY7o9eq+kjXEmrXZP
	jgcAxM=
X-Google-Smtp-Source: AGHT+IHBxHssTDIF9QMZPl8bqv5eGDHDg9+HE4kamJXglQytPWyPF4D1CmVh2ipXT9tivX6lm88xwWrVnpT3QEuCuK0=
X-Received: by 2002:a05:6e02:3781:b0:3f3:4562:ca92 with SMTP id
 e9e14a558f8ab-3f400674c40mr246803965ab.10.1756827841558; Tue, 02 Sep 2025
 08:44:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250831100822.1238795-1-jackzxcui1989@163.com> <20250831100822.1238795-3-jackzxcui1989@163.com>
In-Reply-To: <20250831100822.1238795-3-jackzxcui1989@163.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 2 Sep 2025 23:43:24 +0800
X-Gm-Features: Ac12FXyhicQqPaJIB9m4YUFtWzj0ZzzLPIa-R58sQ0bUbCPTETUIy5pUFyJ9ZvY
Message-ID: <CAL+tcoCAVxt3RuYEsaqcvprCfMWfA0A34O9S3xSexzmmnbwSJQ@mail.gmail.com>
Subject: Re: [PATCH net-next v10 2/2] net: af_packet: Use hrtimer to do the
 retire operation
To: Xin Zhao <jackzxcui1989@163.com>
Cc: willemdebruijn.kernel@gmail.com, edumazet@google.com, ferenc@fejes.dev, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 31, 2025 at 6:09=E2=80=AFPM Xin Zhao <jackzxcui1989@163.com> wr=
ote:
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
>
> Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
> ---
> Changes in v8:
> - Simplify the logic related to setting timeout.
>
> Changes in v7:
> - Only update the hrtimer expire time within the hrtimer callback.
>
> Changes in v1:
> - Do not add another config for the current changes.
>
> ---
>  net/packet/af_packet.c | 79 +++++++++---------------------------------
>  net/packet/diag.c      |  2 +-
>  net/packet/internal.h  |  6 ++--
>  3 files changed, 20 insertions(+), 67 deletions(-)
>
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index d4eb4a4fe..3e3bb4216 100644
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
> @@ -671,29 +650,22 @@ static void init_prb_bdqc(struct packet_sock *po,
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
> +                                               req_u->req3.tp_block_size=
));
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

You expect to see it start at the setsockopt phase? Even if it's far
from the real use of recv at the moment.

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
>   * Timer logic:
>   * 1) We refresh the timer only when we open a block.
> @@ -717,7 +689,7 @@ static void _prb_refresh_rx_retire_blk_timer(struct t=
packet_kbdq_core *pkc)
>   * prb_calc_retire_blk_tmo() calculates the tmo.
>   *
>   */
> -static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
> +static enum hrtimer_restart prb_retire_rx_blk_timer_expired(struct hrtim=
er *t)
>  {
>         struct packet_sock *po =3D
>                 timer_container_of(po, t, rx_ring.prb_bdqc.retire_blk_tim=
er);
> @@ -730,9 +702,6 @@ static void prb_retire_rx_blk_timer_expired(struct ti=
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
> @@ -749,26 +718,16 @@ static void prb_retire_rx_blk_timer_expired(struct =
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
> @@ -777,15 +736,12 @@ static void prb_retire_rx_blk_timer_expired(struct =
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
> @@ -917,7 +873,6 @@ static void prb_open_block(struct tpacket_kbdq_core *=
pkc1,
>         pkc1->pkblk_end =3D pkc1->pkblk_start + pkc1->kblk_size;
>
>         prb_thaw_queue(pkc1);
> -       _prb_refresh_rx_retire_blk_timer(pkc1);

Could you say more on why you remove this here and only reset/update
the expiry time in the timer handler? Probably I missed something
appearing in the previous long discussion.

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
> index d367b9f93..f8cfd9213 100644
> --- a/net/packet/internal.h
> +++ b/net/packet/internal.h
> @@ -20,7 +20,6 @@ struct tpacket_kbdq_core {
>         unsigned int    feature_req_word;
>         unsigned int    hdrlen;
>         unsigned char   reset_pending_on_curr_blk;
> -       unsigned char   delete_blk_timer;
>         unsigned short  kactive_blk_num;
>         unsigned short  blk_sizeof_priv;
>
> @@ -39,12 +38,11 @@ struct tpacket_kbdq_core {
>         /* Default is set to 8ms */
>  #define DEFAULT_PRB_RETIRE_TOV (8)
>
> -       unsigned short  retire_blk_tov;
> +       ktime_t         interval_ktime;
>         unsigned short  version;
> -       unsigned long   tov_in_jiffies;
>
>         /* timer to retire an outstanding block */
> -       struct timer_list retire_blk_timer;
> +       struct hrtimer  retire_blk_timer;
>  };

The whole structure needs a new organization?

Before:
        /* size: 152, cachelines: 3, members: 22 */
        /* sum members: 144, holes: 2, sum holes: 8 */
        /* paddings: 1, sum paddings: 4 */
        /* last cacheline: 24 bytes */
After:
        /* size: 176, cachelines: 3, members: 19 */
        /* sum members: 163, holes: 4, sum holes: 13 */
        /* paddings: 1, sum paddings: 4 */
        /* forced alignments: 1, forced holes: 1, sum forced holes: 6 */
        /* last cacheline: 48 bytes */

Thanks,
Jason

>
>  struct pgv {
> --
> 2.34.1
>
>


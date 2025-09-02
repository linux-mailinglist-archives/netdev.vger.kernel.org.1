Return-Path: <netdev+bounces-219246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF17B40AE4
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 18:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10AA97B4D41
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 16:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1432BEFE1;
	Tue,  2 Sep 2025 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZvn64uf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35482877FC;
	Tue,  2 Sep 2025 16:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756831400; cv=none; b=JCABddLK99QvVL3KHowh3TbXWDrQENNrT2AtbKCU4i2jbmoYh8YA1NVcZk2BX3LAyDbF9Ar/nurzs/WKbz2Ry/2Vgugc41GMYbAc9gNKLiLBogRIFRhwzp+5Zwo8fdYgLpaqUh1DNM0FsiBat7LHXz/qhZ3ab/92nNsBJFFymUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756831400; c=relaxed/simple;
	bh=pNQF920LCP5sfkJuLl2/bHlmNH0CpwtW8TRO7FNfORw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VybPKP21lGM32zLxUtJF9RH6AMrcZElsXaSi8pVDE6OAvEYApMBcf8O5tc21QSkENQ/giBG25KEC/Ntxxp7QQ9h9O+dEYblftGk0jSnZw1g/WtxCDSIgF+RTTz8X7/Wz8ATZ5sICrll7eHnJ5Pw1agEERVGW6nnnqh9pPjJ2mUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZvn64uf; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-887490f0654so44032639f.0;
        Tue, 02 Sep 2025 09:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756831397; x=1757436197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0l/lpFpsMhxQP1BvXo5dY414yVX8MMT3B+6FaO0U0c=;
        b=KZvn64ufMxRdF+PP/PT8zNokm0yEojvgEVQdu+7RSzjSdZa5zU7qMiU2HTkcG/KBoZ
         9ws03m4+rEt9H2+EU8ARhnh0ztGLORDRUiXbFKFcboQtg/NuO7bH5Kiye0YwFpY7VSqj
         GygOZKWzOoSe5Bfe4tlBHvIajldEaeTnlSQejkXgnIVS6+jIIgCiBoBqcknEy/PIY/z0
         JVfd4EHvwSUTdXNk7tFKC3FznjbOU1QJwF8mCD31VwXcmAjYBG/CvCNEKXXxpeEhfiOo
         iICuTVBhDG9jWZe5VlUSLCvUZJJVQVYKCPdHmnwVcBxe07qNFTVvQOBkkWf9/VkVp8KA
         qTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756831397; x=1757436197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0l/lpFpsMhxQP1BvXo5dY414yVX8MMT3B+6FaO0U0c=;
        b=IIZ7OsA3bvUzns6e1pkHYzkXZiVD50y4VBAUNk2o4Wo1i9oB9BY17L8gjbDT8jhIPx
         7/EElGrY1HeuGDKZP2EYgl/Ws7YzwQrk52LCoT+OFAqFkqFKSPQYe5as5pjdiFH+9IQy
         sctZfJekYEy9xwwAxDavI2j2ickPtxFgWFdHDkE79GkP7e/Ye342cUVmhhXBD2Sg/H08
         8zegJJEl+UER0wg5V/D3GKrUeuPTfXZNfRNfRADmE0mLLK2VjbLcolEBQC+XdiIYjzGw
         lg6eOTTcOoYhy535xq768HqIzC7RTr+b0tTdYBPrF/EX8I1gvLAL+O/3KAHpNgJgFvRA
         4dAw==
X-Forwarded-Encrypted: i=1; AJvYcCUmoxkhHwi1kt8NlB4nO8uB1pkGc9P/rs7RJBe5c4Wc5DPJqhfEAADmO0fOWtfxcYz0Uo3TGM97ixsQM5Y=@vger.kernel.org, AJvYcCVCM/qaO/jpcuBAMPLQiDwh54UiIsH89Eru2q9nrbiwQmyeqH0eb3RdzZs7ONSGS5RqQiDUBt1B@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6ZcIpcR3OHP0ue8TplvNS5d3fUNzBGRCUkDA/aTf14uKMRy+k
	CKKP3PXjMmP+tyUQgBXlNlnfiaXE56C/CGV7H5R43dQ8rIsxCMjU6wzxA6BoCAHPh8VISCSIHl6
	NCu3Ozf0g35vZohCWw65IfmicSmENNlg=
X-Gm-Gg: ASbGncsm8zyXDZ/PbDlX9Lz0qM2KSXi7F4/Ksy5kKrLvk098FWgI4v7Z1LRB974CePh
	icbU2bmbJ0mr24k/fOGopsjYpUi4fBYKIurbVDAXPBjgdiDr+5oA9Os6S/euuWROtG6I2we3xCI
	rdqzrYzfRZttpQi4+si3IitokTLItMOXQi+cT5icW/t2L+EQQmoEDRcmgbw3z7IntbJkNL4LoIt
	zNjqaQ=
X-Google-Smtp-Source: AGHT+IFKIPZnrHdY3XIMV3a1mVk429grb81ouaqdswR4E+iGmnFWdewNuJwcO3WbaFkhhSqzpTgjttmTtvSMo8O4RwE=
X-Received: by 2002:a05:6e02:2147:b0:3f0:71da:c07 with SMTP id
 e9e14a558f8ab-3f4021c7ae1mr198398625ab.22.1756831397249; Tue, 02 Sep 2025
 09:43:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250831100822.1238795-1-jackzxcui1989@163.com>
 <20250831100822.1238795-3-jackzxcui1989@163.com> <CAL+tcoCAVxt3RuYEsaqcvprCfMWfA0A34O9S3xSexzmmnbwSJQ@mail.gmail.com>
In-Reply-To: <CAL+tcoCAVxt3RuYEsaqcvprCfMWfA0A34O9S3xSexzmmnbwSJQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 3 Sep 2025 00:42:41 +0800
X-Gm-Features: Ac12FXyKVQ1dS1tKR_JR2tMZEMNL2kKMnljwh3Ao9GDPNUbF8i28ao2WUF22sfs
Message-ID: <CAL+tcoCp12t_5PRWWkiMi++1MgYX4WXW4dUDXYzHF_tJACw3dg@mail.gmail.com>
Subject: Re: [PATCH net-next v10 2/2] net: af_packet: Use hrtimer to do the
 retire operation
To: Xin Zhao <jackzxcui1989@163.com>
Cc: willemdebruijn.kernel@gmail.com, edumazet@google.com, ferenc@fejes.dev, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 11:43=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Sun, Aug 31, 2025 at 6:09=E2=80=AFPM Xin Zhao <jackzxcui1989@163.com> =
wrote:
> >
> > In a system with high real-time requirements, the timeout mechanism of
> > ordinary timers with jiffies granularity is insufficient to meet the
> > demands for real-time performance. Meanwhile, the optimization of CPU
> > usage with af_packet is quite significant. Use hrtimer instead of timer
> > to help compensate for the shortcomings in real-time performance.
> > In HZ=3D100 or HZ=3D250 system, the update of TP_STATUS_USER is not rea=
l-time
> > enough, with fluctuations reaching over 8ms (on a system with HZ=3D250)=
.
> > This is unacceptable in some high real-time systems that require timely
> > processing of network packets. By replacing it with hrtimer, if a timeo=
ut
> > of 2ms is set, the update of TP_STATUS_USER can be stabilized to within
> > 3 ms.
> >
> > Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
> > ---
> > Changes in v8:
> > - Simplify the logic related to setting timeout.
> >
> > Changes in v7:
> > - Only update the hrtimer expire time within the hrtimer callback.
> >
> > Changes in v1:
> > - Do not add another config for the current changes.
> >
> > ---
> >  net/packet/af_packet.c | 79 +++++++++---------------------------------
> >  net/packet/diag.c      |  2 +-
> >  net/packet/internal.h  |  6 ++--
> >  3 files changed, 20 insertions(+), 67 deletions(-)
> >
> > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > index d4eb4a4fe..3e3bb4216 100644
> > --- a/net/packet/af_packet.c
> > +++ b/net/packet/af_packet.c
> > @@ -203,8 +203,7 @@ static void prb_retire_current_block(struct tpacket=
_kbdq_core *,
> >  static int prb_queue_frozen(struct tpacket_kbdq_core *);
> >  static void prb_open_block(struct tpacket_kbdq_core *,
> >                 struct tpacket_block_desc *);
> > -static void prb_retire_rx_blk_timer_expired(struct timer_list *);
> > -static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core =
*);
> > +static enum hrtimer_restart prb_retire_rx_blk_timer_expired(struct hrt=
imer *);
> >  static void prb_fill_rxhash(struct tpacket_kbdq_core *, struct tpacket=
3_hdr *);
> >  static void prb_clear_rxhash(struct tpacket_kbdq_core *,
> >                 struct tpacket3_hdr *);
> > @@ -579,33 +578,13 @@ static __be16 vlan_get_protocol_dgram(const struc=
t sk_buff *skb)
> >         return proto;
> >  }
> >
> > -static void prb_del_retire_blk_timer(struct tpacket_kbdq_core *pkc)
> > -{
> > -       timer_delete_sync(&pkc->retire_blk_timer);
> > -}
> > -
> >  static void prb_shutdown_retire_blk_timer(struct packet_sock *po,
> >                 struct sk_buff_head *rb_queue)
> >  {
> >         struct tpacket_kbdq_core *pkc;
> >
> >         pkc =3D GET_PBDQC_FROM_RB(&po->rx_ring);
> > -
> > -       spin_lock_bh(&rb_queue->lock);
> > -       pkc->delete_blk_timer =3D 1;

One more review from my side is that as to the removal of
delete_blk_timer, I'm afraid it deserves a clarification in the commit
message.

> > -       spin_unlock_bh(&rb_queue->lock);
> > -
> > -       prb_del_retire_blk_timer(pkc);
> > -}
> > -
> > -static void prb_setup_retire_blk_timer(struct packet_sock *po)
> > -{
> > -       struct tpacket_kbdq_core *pkc;
> > -
> > -       pkc =3D GET_PBDQC_FROM_RB(&po->rx_ring);
> > -       timer_setup(&pkc->retire_blk_timer, prb_retire_rx_blk_timer_exp=
ired,
> > -                   0);
> > -       pkc->retire_blk_timer.expires =3D jiffies;
> > +       hrtimer_cancel(&pkc->retire_blk_timer);
> >  }
> >
> >  static int prb_calc_retire_blk_tmo(struct packet_sock *po,
> > @@ -671,29 +650,22 @@ static void init_prb_bdqc(struct packet_sock *po,
> >         p1->version =3D po->tp_version;
> >         po->stats.stats3.tp_freeze_q_cnt =3D 0;
> >         if (req_u->req3.tp_retire_blk_tov)
> > -               p1->retire_blk_tov =3D req_u->req3.tp_retire_blk_tov;
> > +               p1->interval_ktime =3D ms_to_ktime(req_u->req3.tp_retir=
e_blk_tov);
> >         else
> > -               p1->retire_blk_tov =3D prb_calc_retire_blk_tmo(po,
> > -                                               req_u->req3.tp_block_si=
ze);
> > -       p1->tov_in_jiffies =3D msecs_to_jiffies(p1->retire_blk_tov);
> > +               p1->interval_ktime =3D ms_to_ktime(prb_calc_retire_blk_=
tmo(po,
> > +                                               req_u->req3.tp_block_si=
ze));
> >         p1->blk_sizeof_priv =3D req_u->req3.tp_sizeof_priv;
> >         rwlock_init(&p1->blk_fill_in_prog_lock);
> >
> >         p1->max_frame_len =3D p1->kblk_size - BLK_PLUS_PRIV(p1->blk_siz=
eof_priv);
> >         prb_init_ft_ops(p1, req_u);
> > -       prb_setup_retire_blk_timer(po);
> > +       hrtimer_setup(&p1->retire_blk_timer, prb_retire_rx_blk_timer_ex=
pired,
> > +                     CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
> > +       hrtimer_start(&p1->retire_blk_timer, p1->interval_ktime,
> > +                     HRTIMER_MODE_REL_SOFT);
>
> You expect to see it start at the setsockopt phase? Even if it's far
> from the real use of recv at the moment.
>
> >         prb_open_block(p1, pbd);
> >  }
> >
> > -/*  Do NOT update the last_blk_num first.
> > - *  Assumes sk_buff_head lock is held.
> > - */
> > -static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core =
*pkc)
> > -{
> > -       mod_timer(&pkc->retire_blk_timer,
> > -                       jiffies + pkc->tov_in_jiffies);
> > -}
> > -
> >  /*
> >   * Timer logic:
> >   * 1) We refresh the timer only when we open a block.
> > @@ -717,7 +689,7 @@ static void _prb_refresh_rx_retire_blk_timer(struct=
 tpacket_kbdq_core *pkc)
> >   * prb_calc_retire_blk_tmo() calculates the tmo.
> >   *
> >   */
> > -static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
> > +static enum hrtimer_restart prb_retire_rx_blk_timer_expired(struct hrt=
imer *t)
> >  {
> >         struct packet_sock *po =3D
> >                 timer_container_of(po, t, rx_ring.prb_bdqc.retire_blk_t=
imer);
> > @@ -730,9 +702,6 @@ static void prb_retire_rx_blk_timer_expired(struct =
timer_list *t)
> >         frozen =3D prb_queue_frozen(pkc);
> >         pbd =3D GET_CURR_PBLOCK_DESC_FROM_CORE(pkc);
> >
> > -       if (unlikely(pkc->delete_blk_timer))
> > -               goto out;
> > -
> >         /* We only need to plug the race when the block is partially fi=
lled.
> >          * tpacket_rcv:
> >          *              lock(); increment BLOCK_NUM_PKTS; unlock()
> > @@ -749,26 +718,16 @@ static void prb_retire_rx_blk_timer_expired(struc=
t timer_list *t)
> >         }
> >
> >         if (!frozen) {
> > -               if (!BLOCK_NUM_PKTS(pbd)) {
> > -                       /* An empty block. Just refresh the timer. */
> > -                       goto refresh_timer;
> > +               if (BLOCK_NUM_PKTS(pbd)) {
> > +                       /* Not an empty block. Need retire the block. *=
/
> > +                       prb_retire_current_block(pkc, po, TP_STATUS_BLK=
_TMO);
> > +                       prb_dispatch_next_block(pkc, po);
> >                 }
> > -               prb_retire_current_block(pkc, po, TP_STATUS_BLK_TMO);
> > -               if (!prb_dispatch_next_block(pkc, po))
> > -                       goto refresh_timer;
> > -               else
> > -                       goto out;
> >         } else {
> >                 /* Case 1. Queue was frozen because user-space was
> >                  * lagging behind.
> >                  */
> > -               if (prb_curr_blk_in_use(pbd)) {
> > -                       /*
> > -                        * Ok, user-space is still behind.
> > -                        * So just refresh the timer.
> > -                        */
> > -                       goto refresh_timer;
> > -               } else {
> > +               if (!prb_curr_blk_in_use(pbd)) {
> >                         /* Case 2. queue was frozen,user-space caught u=
p,
> >                          * now the link went idle && the timer fired.
> >                          * We don't have a block to close.So we open th=
is
> > @@ -777,15 +736,12 @@ static void prb_retire_rx_blk_timer_expired(struc=
t timer_list *t)
> >                          * Thawing/timer-refresh is a side effect.
> >                          */
> >                         prb_open_block(pkc, pbd);
> > -                       goto out;
> >                 }
> >         }
> >
> > -refresh_timer:
> > -       _prb_refresh_rx_retire_blk_timer(pkc);
> > -
> > -out:
> > +       hrtimer_forward_now(&pkc->retire_blk_timer, pkc->interval_ktime=
);
> >         spin_unlock(&po->sk.sk_receive_queue.lock);
> > +       return HRTIMER_RESTART;
> >  }
> >
> >  static void prb_flush_block(struct tpacket_kbdq_core *pkc1,
> > @@ -917,7 +873,6 @@ static void prb_open_block(struct tpacket_kbdq_core=
 *pkc1,
> >         pkc1->pkblk_end =3D pkc1->pkblk_start + pkc1->kblk_size;
> >
> >         prb_thaw_queue(pkc1);
> > -       _prb_refresh_rx_retire_blk_timer(pkc1);
>
> Could you say more on why you remove this here and only reset/update
> the expiry time in the timer handler? Probably I missed something
> appearing in the previous long discussion.

I gradually understand your thought behind this modification. You're
trying to move the timer operation out of prb_open_block() and then
spread the timer operation into each caller.

You probably miss the following call trace:
packet_current_rx_frame() -> __packet_lookup_frame_in_block() ->
prb_open_block() -> _prb_refresh_rx_retire_blk_timer()
?

May I ask why bother introducing so many changes like this instead of
leaving it as-is?

Thanks,
Jason

>
> >
> >         smp_wmb();
> >  }
> > diff --git a/net/packet/diag.c b/net/packet/diag.c
> > index 6ce1dcc28..c8f43e0c1 100644
> > --- a/net/packet/diag.c
> > +++ b/net/packet/diag.c
> > @@ -83,7 +83,7 @@ static int pdiag_put_ring(struct packet_ring_buffer *=
ring, int ver, int nl_type,
> >         pdr.pdr_frame_nr =3D ring->frame_max + 1;
> >
> >         if (ver > TPACKET_V2) {
> > -               pdr.pdr_retire_tmo =3D ring->prb_bdqc.retire_blk_tov;
> > +               pdr.pdr_retire_tmo =3D ktime_to_ms(ring->prb_bdqc.inter=
val_ktime);
> >                 pdr.pdr_sizeof_priv =3D ring->prb_bdqc.blk_sizeof_priv;
> >                 pdr.pdr_features =3D ring->prb_bdqc.feature_req_word;
> >         } else {
> > diff --git a/net/packet/internal.h b/net/packet/internal.h
> > index d367b9f93..f8cfd9213 100644
> > --- a/net/packet/internal.h
> > +++ b/net/packet/internal.h
> > @@ -20,7 +20,6 @@ struct tpacket_kbdq_core {
> >         unsigned int    feature_req_word;
> >         unsigned int    hdrlen;
> >         unsigned char   reset_pending_on_curr_blk;
> > -       unsigned char   delete_blk_timer;
> >         unsigned short  kactive_blk_num;
> >         unsigned short  blk_sizeof_priv;
> >
> > @@ -39,12 +38,11 @@ struct tpacket_kbdq_core {
> >         /* Default is set to 8ms */
> >  #define DEFAULT_PRB_RETIRE_TOV (8)
> >
> > -       unsigned short  retire_blk_tov;
> > +       ktime_t         interval_ktime;
> >         unsigned short  version;
> > -       unsigned long   tov_in_jiffies;
> >
> >         /* timer to retire an outstanding block */
> > -       struct timer_list retire_blk_timer;
> > +       struct hrtimer  retire_blk_timer;
> >  };
>
> The whole structure needs a new organization?
>
> Before:
>         /* size: 152, cachelines: 3, members: 22 */
>         /* sum members: 144, holes: 2, sum holes: 8 */
>         /* paddings: 1, sum paddings: 4 */
>         /* last cacheline: 24 bytes */
> After:
>         /* size: 176, cachelines: 3, members: 19 */
>         /* sum members: 163, holes: 4, sum holes: 13 */
>         /* paddings: 1, sum paddings: 4 */
>         /* forced alignments: 1, forced holes: 1, sum forced holes: 6 */
>         /* last cacheline: 48 bytes */
>
> Thanks,
> Jason
>
> >
> >  struct pgv {
> > --
> > 2.34.1
> >
> >


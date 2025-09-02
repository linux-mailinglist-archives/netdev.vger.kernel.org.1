Return-Path: <netdev+bounces-219188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 811D8B4063C
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 16:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81C0B172B48
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 14:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDCB2DF3CF;
	Tue,  2 Sep 2025 14:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTP5ycis"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5B12DF6EA;
	Tue,  2 Sep 2025 14:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756821934; cv=none; b=kJKiLGShfT0ao7Kn0CXi1LDMUpajoxH7FtTFWTy6p7RDtBUHSnsnuy0UBAbudn/aJsc+hKfEjV8F0HshIWVCLVpwm05tRl7zBI7bNyzsj7TQsVg7ddsMBFL92rR1lnxU4/0MqZMcG5Z0zLYwxSV63ERuvYK7pW225C12IA208uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756821934; c=relaxed/simple;
	bh=WqL8QEjjL7r4XmNavrTNC+GBSLmdfzhOFFZTbcF8008=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V1TI3FiWwj85tDBpG2aSf4H1H/U4Ux/vS/6pi8fAllLiMnUGakkIE4jbaWe3sELngn693eYfhQzn4ZUN0wUl+nwD+q/iCLBpGii1ZArpmWyi6zRwxQUqfif7Cs52OyKrw335UQpjqye7UWayy4xtqbSGh5HWYeUQUjXexD5ezXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTP5ycis; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3ea8b3a64c7so23647345ab.0;
        Tue, 02 Sep 2025 07:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756821932; x=1757426732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IuUbMHTW3Lrm+ILnoYOreD7nrQXIKzGAX3ZRUUd3/Fk=;
        b=aTP5ycisnFrknjwUzaBt5xp6nqijRBPsGvqNJs21FW/ISB/tURmU0C1/u8Ep4aXdtL
         jpWQsdGA94JfL3SS/DFCfVkD9lH7OYMDShD2VPxMz1Tn4VYRCucv+49WxFzTJoo0g9gj
         gJJ+vkiC6Bj/Wj/75tosjWDkJ82+u75jmi/rpM2SnsBo091+JqIaZ5zjqtrDGbJ1qYmz
         r2xhvMTuh1MGaX6Zyn7t2oofuK1paNstPoI1HjBNpIN+VR/doWXY+6SLMHIPENqz+94J
         DbszFhlNp3aY5UQpXoVVNUxrxK/ZobkTAF2CyOikjVC+uhR/0ooTVtM6MfkS4QCk7Lco
         TTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756821932; x=1757426732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IuUbMHTW3Lrm+ILnoYOreD7nrQXIKzGAX3ZRUUd3/Fk=;
        b=Rl2nIXEQ6azH/TnATSqr131PJIlq5ASx0+zNINQu7rjiDq1AAcerzzCpT2Fl1ICD34
         cDvE5dNyiaMzT9lvX1Hi7UgTki+2psR/26FamfjlQVUqYjHg7DodHliimRm21IT1SsRk
         4P2r2WhhWPymNZbI+ikuMTvLcEhW5RdaJlPuWtaLFtR/2iiQIYfL9CLBmGxRG1KiHNbA
         /wB30WvmQ2TJAPf0NY2JtBm9goDuO5JPunesBft5wgWniV8d/ddPzmP/4NalO904T0rR
         9zKGDnH02GjrvxeCw2FGXi+o/hfniuY4xoeoCnqJggnsjnZq7b9CiBeKmDZ1kq2zIoqo
         UUDg==
X-Forwarded-Encrypted: i=1; AJvYcCUsTUUkyJEIBW42e/07UD8GdQ2qPxySv/WBVqQfaq+bKqXWTX2w6RnwE1St9jVWHwryt/AiMlkn@vger.kernel.org, AJvYcCXm6lv3z6Kelt3nusrM2uwbyY+hAz7Nw1dj4KPhoioUobUu832a5+35MTdwQskb2NMJ9w2TKJJ5H6tl7qE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlOZ05DpZ/RWDm0LZ9sthxrFDG3WXQiMGVFc95HhAV+1tGvQ4u
	fdk1C5uosBcEdjQ9QYuD6GIpE/udy3cF6sirVg7AE+9A845MgXn7P5x65KFlT6JNlXkDs5yX3gb
	Lg7Hn+tVddE38JqNbEgav5m55trnza8eVioj9os0=
X-Gm-Gg: ASbGncvdTlB+DmIkBdNtlvYBoVnRdKatNB9daXEWEnatFo3UaOuTRy/9yNDBpdrwb/f
	QVkMoeg70hmu3rYFBtSmoOe3ujmThBV8KFBFvWHSxb6K9pTINl40mvCdlnScI8efJ06jocDlfKF
	EsHzAwEdLHv8lffqYEtMeDKrHSXday1Ilvv4vl9wEtG8aIxfy4I0nkrxA4P5PH0WNTlW4q50O5d
	nBdyQ0=
X-Google-Smtp-Source: AGHT+IH/faVvJRDetkmio72Ojj/stYKECnbth7d+fvSheZOVTsIDjzFD6JWCYHcExo0xbigEaUjvq3iZ5W8i4VdL6Yw=
X-Received: by 2002:a05:6e02:3c03:b0:3f0:4a62:cfd0 with SMTP id
 e9e14a558f8ab-3f4000974ddmr230827905ab.4.1756821931907; Tue, 02 Sep 2025
 07:05:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250831100822.1238795-1-jackzxcui1989@163.com> <20250831100822.1238795-2-jackzxcui1989@163.com>
In-Reply-To: <20250831100822.1238795-2-jackzxcui1989@163.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 2 Sep 2025 22:04:54 +0800
X-Gm-Features: Ac12FXwkd-qgnRRh_CeBqvzvNjDDlu_ORz8tZ4OL8Xi-Iu31XsjOwosLQVhnZD4
Message-ID: <CAL+tcoBsfxyfGUyKfuiQsqwc8useNefZWxSVJOyivEci9jM6Zw@mail.gmail.com>
Subject: Re: [PATCH net-next v10 1/2] net: af_packet: remove
 last_kactive_blk_num field
To: Xin Zhao <jackzxcui1989@163.com>
Cc: willemdebruijn.kernel@gmail.com, edumazet@google.com, ferenc@fejes.dev, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 31, 2025 at 6:10=E2=80=AFPM Xin Zhao <jackzxcui1989@163.com> wr=
ote:
>
> kactive_blk_num (K) is incremented on block close. last_kactive_blk_num (=
L)
> is set to match K on block open and each timer. So the only time that the=
y
> differ is if a block is closed in tpacket_rcv and no new block could be
> opened.
> So the origin check L=3D=3DK in timer callback only skip the case 'no new=
 block
> to open'. If we remove L=3D=3DK check, it will make prb_curr_blk_in_use c=
heck
> earlier, which will not cause any side effect.

I believe the above commit message needs to be revised:
1) the above sentence (starting from 'if we remove L....') means
nothing because your modification doesn't change the behaviour when
the queue is not frozen.
2) lack of proofs/reasons on why exposing the prb_open_block() logic doesn'=
t
cause side effects. It's the key proof that shows to future readers to
make sure this patch will not bring trouble.

>
> Signed-off-by: Xin Zhao <jackzxcui1989@163.com>

It was suggested by Willem, so please add:
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>

So far, it looks good to me as well:
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

And I will finish reviewing the other patch by tomorrow :)

Thanks,
Jason



> ---
>  net/packet/af_packet.c | 60 ++++++++++++++++++++----------------------
>  net/packet/internal.h  |  6 -----
>  2 files changed, 28 insertions(+), 38 deletions(-)
>
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index a7017d7f0..d4eb4a4fe 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -669,7 +669,6 @@ static void init_prb_bdqc(struct packet_sock *po,
>         p1->knum_blocks =3D req_u->req3.tp_block_nr;
>         p1->hdrlen =3D po->tp_hdrlen;
>         p1->version =3D po->tp_version;
> -       p1->last_kactive_blk_num =3D 0;
>         po->stats.stats3.tp_freeze_q_cnt =3D 0;
>         if (req_u->req3.tp_retire_blk_tov)
>                 p1->retire_blk_tov =3D req_u->req3.tp_retire_blk_tov;
> @@ -693,7 +692,6 @@ static void _prb_refresh_rx_retire_blk_timer(struct t=
packet_kbdq_core *pkc)
>  {
>         mod_timer(&pkc->retire_blk_timer,
>                         jiffies + pkc->tov_in_jiffies);
> -       pkc->last_kactive_blk_num =3D pkc->kactive_blk_num;
>  }
>
>  /*
> @@ -750,38 +748,36 @@ static void prb_retire_rx_blk_timer_expired(struct =
timer_list *t)
>                 write_unlock(&pkc->blk_fill_in_prog_lock);
>         }
>
> -       if (pkc->last_kactive_blk_num =3D=3D pkc->kactive_blk_num) {
> -               if (!frozen) {
> -                       if (!BLOCK_NUM_PKTS(pbd)) {
> -                               /* An empty block. Just refresh the timer=
. */
> -                               goto refresh_timer;
> -                       }
> -                       prb_retire_current_block(pkc, po, TP_STATUS_BLK_T=
MO);
> -                       if (!prb_dispatch_next_block(pkc, po))
> -                               goto refresh_timer;
> -                       else
> -                               goto out;
> +       if (!frozen) {
> +               if (!BLOCK_NUM_PKTS(pbd)) {
> +                       /* An empty block. Just refresh the timer. */
> +                       goto refresh_timer;
> +               }
> +               prb_retire_current_block(pkc, po, TP_STATUS_BLK_TMO);
> +               if (!prb_dispatch_next_block(pkc, po))
> +                       goto refresh_timer;
> +               else
> +                       goto out;
> +       } else {
> +               /* Case 1. Queue was frozen because user-space was
> +                * lagging behind.
> +                */
> +               if (prb_curr_blk_in_use(pbd)) {
> +                       /*
> +                        * Ok, user-space is still behind.
> +                        * So just refresh the timer.
> +                        */
> +                       goto refresh_timer;
>                 } else {
> -                       /* Case 1. Queue was frozen because user-space wa=
s
> -                        *         lagging behind.
> +                       /* Case 2. queue was frozen,user-space caught up,
> +                        * now the link went idle && the timer fired.
> +                        * We don't have a block to close.So we open this
> +                        * block and restart the timer.
> +                        * opening a block thaws the queue,restarts timer
> +                        * Thawing/timer-refresh is a side effect.
>                          */
> -                       if (prb_curr_blk_in_use(pbd)) {
> -                               /*
> -                                * Ok, user-space is still behind.
> -                                * So just refresh the timer.
> -                                */
> -                               goto refresh_timer;
> -                       } else {
> -                              /* Case 2. queue was frozen,user-space cau=
ght up,
> -                               * now the link went idle && the timer fir=
ed.
> -                               * We don't have a block to close.So we op=
en this
> -                               * block and restart the timer.
> -                               * opening a block thaws the queue,restart=
s timer
> -                               * Thawing/timer-refresh is a side effect.
> -                               */
> -                               prb_open_block(pkc, pbd);
> -                               goto out;
> -                       }
> +                       prb_open_block(pkc, pbd);
> +                       goto out;
>                 }
>         }
>
> diff --git a/net/packet/internal.h b/net/packet/internal.h
> index 1e743d031..d367b9f93 100644
> --- a/net/packet/internal.h
> +++ b/net/packet/internal.h
> @@ -24,12 +24,6 @@ struct tpacket_kbdq_core {
>         unsigned short  kactive_blk_num;
>         unsigned short  blk_sizeof_priv;
>
> -       /* last_kactive_blk_num:
> -        * trick to see if user-space has caught up
> -        * in order to avoid refreshing timer when every single pkt arriv=
es.
> -        */
> -       unsigned short  last_kactive_blk_num;
> -
>         char            *pkblk_start;
>         char            *pkblk_end;
>         int             kblk_size;
> --
> 2.34.1
>
>


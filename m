Return-Path: <netdev+bounces-220185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E21DB44AB1
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 02:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B48763B9292
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 00:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276D61FC3;
	Fri,  5 Sep 2025 00:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgz0TO5h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637A610E3;
	Fri,  5 Sep 2025 00:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757031023; cv=none; b=JwAUFBzhR/qZrnbow7H4ltEekuel5MAiQJOYPPlpN0Bbv1ZDte3g55odk604SIohohIpZ/Q7VICcLkypXy6O9ZkaZfkm5/TXBjAz3uu8DQ+4ygRmm0I6K6Nxs5btgZhyjTFPmB9iAAQWpOL67cSdNpp3HjodOC47S53zEwkHHq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757031023; c=relaxed/simple;
	bh=Wqt0zoEmu9173NVgTwhdZ2M7MsZCPaLd/KKYZq92uO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E7cGEgE7wxkpOJJpMmmrFdm5kxzyzlu8sIQE9b3BvQ3d025aG4+7akASywK0Ks9BoKvPGZEN6wRlza8gLnuVEjtf0RcpXnkTzOVz4uQ6TgG1qXQYVKW1KACLV6/uFjijKKLYNf4A1k4CaoqnH/GF4PmZ3gAH8GGoikCvELA8Y8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgz0TO5h; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3f0651cb971so10246435ab.3;
        Thu, 04 Sep 2025 17:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757031020; x=1757635820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/TjQo4jPuViIaMKeRLpkPebSAj9mMxtTxcu+Ya09Fs=;
        b=bgz0TO5h/3g4emSFJ0d1zpvrxBx5Z3WVutvoR5eg01VpKolzUzg4D/TsA1lJXMYvWn
         oJG755jbjXj4iH+uwTCUCdg9ZYku9wzTQu3nepca3afdMvkMnLxMP7Wxp+QznDM29Th/
         J427gO2mjGiKmSNQNCBXBSR3s65cpcz/MV6RrtRHKDPFl5EviMTivLBiEaTwRZMHodVI
         3npJcb1rVm/LJtqHx+yIqaoAYRKcTuJJd2ZpSmrlYJxf0fcxTgZaA6w3S0HGjY8MbxU2
         NVV9MTE0/WhYAEBgBjpaa3Z6+E5xmusnAdc8lck75xKayRdYmt53/tDLH7FYJAh7Alg2
         jzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757031020; x=1757635820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O/TjQo4jPuViIaMKeRLpkPebSAj9mMxtTxcu+Ya09Fs=;
        b=jHz1VmlLKLOjC6BmCYG0CfARTcJtu/By5p1C8jaCeO/FmaUIAbOWGlgjbzMpD5QSbW
         /epSXKutI9mkwAuhIil7xJ+/Q2I+jDPzC0U5fJhdM1qOoOgNbcG+3MZ5ou8XxedBGQHi
         56R7klGKniMoRnzrH7D4DeXTY2WenJGYh3ue58aLxil2ErfVj9pzRs+3XG33BvBQXZFU
         3A0EfBrYFnsze2cCnkCYWHO2VjS8XGR5gvfTBGFhXWXGlIXcTzK0QWJSDnOP9zRo8pdI
         5sCNlWc37GxzjlAav5aqIwqdTIt1dET5m6rAdUhrgl1vDkudD+8NvoTKi9VDieWP7CGi
         vTZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU43Hu23FbJBKFIHkwl7cJk45zFDUQciY/WhOwa6QtElzMTn11BcTXbRFE8xmJOk/MbojF60NxuDX2amJQ=@vger.kernel.org, AJvYcCU7om92DXdu4tSsyrDBs4Nzb2C2E09oFHSiiTikOCihFeq2XkXwdWgs56bIcdMWQjfuy63JO02q@vger.kernel.org
X-Gm-Message-State: AOJu0YzlZqX/lZ37m4tY4XQVOnlxLMD0f7tHBnA96myjHHFCGaPQPm2j
	wTlsyYbOwq2TCTgP1tZnIiLA0XYxzce2o/Fdok7WBSIwDRLFN12OJtgx4rjOF55jXy+vMHcVyOB
	QlxzhIKuaaAC4qPpfGIYnC3tUhS48Yn0=
X-Gm-Gg: ASbGncvBBCOiaBnPG7uVaVZdIYpks/rG5BFkSDxDbkIdhy1sR61HIaVeL/ngl/lTVxb
	M/I/GnqU7DZrB4PCeM65TJq9Gz8Nz1o6xIYhEauijuM2cVMbltZuk/uoRsmXdWt1Ac87BP7PkP2
	Bgr3MC+PLEHOP9szpEgBU52kOkLc+RKEw8t87K0mjlz8wW5ib5n2NhiEIkEDh5RsyT+4CvXN7xC
	7y2O6ksTJapc5q42XIVHA==
X-Google-Smtp-Source: AGHT+IGljxce7x4jBgkKnW0xO1cr+poR4gowOY+QS/LFAGZa+oChfry7jhVX4j4dfrilczpUv3hMuwTcUyeJJw3ZKn0=
X-Received: by 2002:a05:6e02:3a06:b0:3f0:b1ba:f72e with SMTP id
 e9e14a558f8ab-3f4021c42d0mr369846055ab.25.1757031020238; Thu, 04 Sep 2025
 17:10:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904145920.1431219-1-jackzxcui1989@163.com>
In-Reply-To: <20250904145920.1431219-1-jackzxcui1989@163.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 5 Sep 2025 08:09:43 +0800
X-Gm-Features: Ac12FXx5HaEwRNNl1C4OlwRjbLRkrmMCplt0TWXlIzpz9u1BH4C52pIlpbXG6-g
Message-ID: <CAL+tcoB8d3jvD50oa3p5eZT+qLAXFXtuEQ9TvRr3jHzkxeXtSg@mail.gmail.com>
Subject: Re: [PATCH net-next v10 2/2] net: af_packet: Use hrtimer to do the
 retire operation
To: Xin Zhao <jackzxcui1989@163.com>
Cc: willemdebruijn.kernel@gmail.com, edumazet@google.com, ferenc@fejes.dev, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 11:00=E2=80=AFPM Xin Zhao <jackzxcui1989@163.com> wr=
ote:
>
> On Thu, Sep 4, 2025 at 10:50=E2=80=AF+0800 Jason Xing <kerneljasonxing@gm=
ail.com> wrote:
>
> > > In the description of [PATCH net-next v10 0/2] net: af_packet: optimi=
ze retire operation:
> > >
> > > Changes in v7:
> > >   When the callback return, without sk_buff_head lock protection, __r=
un_hrtimer will
> > >   enqueue the timer if return HRTIMER_RESTART. Setting the hrtimer ex=
pires while
> > >   enqueuing a timer may cause chaos in the hrtimer red-black tree.
> > >
> > > Neither hrtimer_set_expires nor hrtimer_forward_now is allowed when t=
he hrtimer has
> > > already been enqueued. Therefore, the only place where the hrtimer ti=
meout can be set is
> > > within the callback, at which point the hrtimer is in a non-enqueued =
state and can have
> > > its timeout set.
> >
> > Can we use hrtimer_is_queued() instead? Please see tcp_pacing_check()
> > as an example. But considering your following explanation, I think
> > it's okay now.
>
> Okay=EF=BC=8C let's keep the current logic as it is.

In case I didn't clearly state it, you don't need to change the
overall logic but only add back one missing point as I replied in the
last email? That is lookup path needing to refresh/update the timer.

>
>
>
> > > /* kbdq - kernel block descriptor queue */
> > > struct tpacket_kbdq_core {
> > >         struct pgv      *pkbdq;
> > >         unsigned int    feature_req_word;
> > >         unsigned int    hdrlen;
> > >         unsigned short  kactive_blk_num;
> > >         unsigned short  blk_sizeof_priv;
> > >         unsigned char   reset_pending_on_curr_blk;
> > >
> > >         char            *pkblk_start;
> > >         char            *pkblk_end;
> > >         int             kblk_size;
> > >         unsigned int    max_frame_len;
> > >         unsigned int    knum_blocks;
> > >         char            *prev;
> > >         char            *nxt_offset;
> > >
> > >         unsigned short  version;
> > >
> > >         uint64_t        knxt_seq_num;
> > >         struct sk_buff  *skb;
> > >
> > >         rwlock_t        blk_fill_in_prog_lock;
> > >
> > >         /* timer to retire an outstanding block */
> > >         struct hrtimer  retire_blk_timer;
> > >
> > >         /* Default is set to 8ms */
> > > #define DEFAULT_PRB_RETIRE_TOV  (8)
> > >
> > >         ktime_t         interval_ktime;
> > > };
> >
> > Could you share the result after running 'pahole --hex -C
> > tpacket_kbdq_core vmlinux'?
>
> I change the struct tpacket_kbdq_core as following:
>
> /* kbdq - kernel block descriptor queue */
> struct tpacket_kbdq_core {
>         struct pgv      *pkbdq;
>         unsigned int    feature_req_word;
>         unsigned int    hdrlen;
>         unsigned char   reset_pending_on_curr_blk;
>         unsigned short  kactive_blk_num;
>         unsigned short  blk_sizeof_priv;
>
>         unsigned short  version;
>
>         char            *pkblk_start;
>         char            *pkblk_end;
>         int             kblk_size;
>         unsigned int    max_frame_len;
>         unsigned int    knum_blocks;
>         char            *prev;
>         char            *nxt_offset;
>
>         uint64_t        knxt_seq_num;
>         struct sk_buff  *skb;
>
>         rwlock_t        blk_fill_in_prog_lock;
>
>         /* timer to retire an outstanding block */
>         struct hrtimer  retire_blk_timer;
>
>         /* Default is set to 8ms */
> #define DEFAULT_PRB_RETIRE_TOV  (8)
>
>         ktime_t         interval_ktime;
> };
>
>
> pahole --hex -C tpacket_kbdq_core vmlinux
>
> running results:
>
> struct tpacket_kbdq_core {
>         struct pgv *               pkbdq;                /*     0   0x8 *=
/
>         unsigned int               feature_req_word;     /*   0x8   0x4 *=
/
>         unsigned int               hdrlen;               /*   0xc   0x4 *=
/
>         unsigned char              reset_pending_on_curr_blk; /*  0x10   =
0x1 */
>
>         /* XXX 1 byte hole, try to pack */
>
>         short unsigned int         kactive_blk_num;      /*  0x12   0x2 *=
/
>         short unsigned int         blk_sizeof_priv;      /*  0x14   0x2 *=
/
>         short unsigned int         version;              /*  0x16   0x2 *=
/
>         char *                     pkblk_start;          /*  0x18   0x8 *=
/
>         char *                     pkblk_end;            /*  0x20   0x8 *=
/
>         int                        kblk_size;            /*  0x28   0x4 *=
/
>         unsigned int               max_frame_len;        /*  0x2c   0x4 *=
/
>         unsigned int               knum_blocks;          /*  0x30   0x4 *=
/
>
>         /* XXX 4 bytes hole, try to pack */
>
>         char *                     prev;                 /*  0x38   0x8 *=
/
>         /* --- cacheline 1 boundary (64 bytes) --- */
>         char *                     nxt_offset;           /*  0x40   0x8 *=
/
>         uint64_t                   knxt_seq_num;         /*  0x48   0x8 *=
/
>         struct sk_buff *           skb;                  /*  0x50   0x8 *=
/
>         rwlock_t                   blk_fill_in_prog_lock; /*  0x58  0x30 =
*/
>         /* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
>         struct hrtimer             retire_blk_timer __attribute__((__alig=
ned__(8))); /*  0x88  0x40 */
>
>         /* XXX last struct has 4 bytes of padding */
>
>         /* --- cacheline 3 boundary (192 bytes) was 8 bytes ago --- */
>         ktime_t                    interval_ktime;       /*  0xc8   0x8 *=
/
>
>         /* size: 208, cachelines: 4, members: 19 */
>         /* sum members: 203, holes: 2, sum holes: 5 */
>         /* paddings: 1, sum paddings: 4 */
>         /* forced alignments: 1 */
>         /* last cacheline: 16 bytes */
> } __attribute__((__aligned__(8)));

How about this one? The 'size' would be shrinked to168 and the 'sum
holes' remains 5.
# pahole --hex -C tpacket_kbdq_core vmlinux
struct tpacket_kbdq_core {
        struct pgv *               pkbdq;                /*     0   0x8 */
        unsigned int               feature_req_word;     /*   0x8   0x4 */
        unsigned int               hdrlen;               /*   0xc   0x4 */
        short unsigned int         kactive_blk_num;      /*  0x10   0x2 */
        short unsigned int         blk_sizeof_priv;      /*  0x12   0x2 */
        short unsigned int         version;              /*  0x14   0x2 */
        unsigned char              reset_pending_on_curr_blk; /*  0x16   0x=
1 */

        /* XXX 1 byte hole, try to pack */

        char *                     pkblk_start;          /*  0x18   0x8 */
        char *                     pkblk_end;            /*  0x20   0x8 */
        int                        kblk_size;            /*  0x28   0x4 */
        unsigned int               max_frame_len;        /*  0x2c   0x4 */
        unsigned int               knum_blocks;          /*  0x30   0x4 */

        /* XXX 4 bytes hole, try to pack */

        uint64_t                   knxt_seq_num;         /*  0x38   0x8 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        char *                     prev;                 /*  0x40   0x8 */
        char *                     nxt_offset;           /*  0x48   0x8 */
        struct sk_buff *           skb;                  /*  0x50   0x8 */
        rwlock_t                   blk_fill_in_prog_lock; /*  0x58   0x8 */
        ktime_t                    interval_ktime;       /*  0x60   0x8 */
        struct hrtimer             retire_blk_timer
__attribute__((__aligned__(8))); /*  0x68  0x40 */

        /* XXX last struct has 4 bytes of padding */

        /* size: 168, cachelines: 3, members: 19 */
        /* sum members: 163, holes: 2, sum holes: 5 */
        /* paddings: 1, sum paddings: 4 */
        /* forced alignments: 1 */
        /* last cacheline: 40 bytes */
} __attribute__((__aligned__(8)));

I didn't want a more aggressive adjustment around the remaining holes.
At least, the current statistics show a better result than before :)

Thanks,
Jason

>
> Thanks
> Xin Zhao
>


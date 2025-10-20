Return-Path: <netdev+bounces-230776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 08974BEF37D
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 06:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A10714E524A
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 04:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84761286891;
	Mon, 20 Oct 2025 04:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXZ1xttV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14E8354AEA
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 04:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760933089; cv=none; b=bcRRPrlXx38vdjMU8Dmf74yWOmw3Qczo0ojKIAR0pV46CmsFfcHpFKkKQLztonVxa9Y8+4tDMacc9EYnnLFZUQNybGADPwgZNiQ/h7kdIC/HJIxA8rYAChL7SioqTKAKBQCl9SWS5+tAjzcfJziJ+KKaINl2L1gVSmnce4owq/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760933089; c=relaxed/simple;
	bh=BrBSwvP4U1oadRL+lkNQZU8qTv/t08T3CSd325/A6yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WUmIDRYR4yyDbWyeDbQiwXSJyEJi4qGQUFvSNlI2sZIn5ffyRL1EQQJI9NhLdnaDGngR4CgeICUm2kuv/XHdJkHksjYZvgJYxCUnsdN6MLIjs/5JUrFaTfiZkVTqyTLlHUvh5IPaKhTTLG0J3aSlMjw1HDYU0ebtFpbk7HuwBJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXZ1xttV; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-93e2c9821fcso352390739f.3
        for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 21:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760933087; x=1761537887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTk8LQSKM8ZGCaHMHDpO18C5oLMVQQjrf2wrzeY1hAA=;
        b=CXZ1xttVCr6kpp1e0y7Erx+TC7lr3ZIT28HFBh8GNXdPIB5EVnQcX6a8Yi531KEMSx
         nTH7uGWfo61LhbiEGlRJ1bnyMXc9A8RN72jL3qYkmcEb3hvtDg6mOmc5KcNx4ksuXni5
         si2clbj5Ie1UKMenWZmLFm+MVf/D+mAeAOKKPB+AtRatRrEiSGm6r4/rUN9Cnu4J2QQW
         ZBFVP7sYKeIzROSkEA+bCG37EvO/WVEKoLzMTC+fXWNy2Hm97iR1FVTqt2XdrvMVOLV+
         EBLhzNFKgstylwBuxVe81t5ZjY+D5lNcFvT1M28PBV4mUSiGfP1pabMAdTI0g3MmCxvu
         KfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760933087; x=1761537887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bTk8LQSKM8ZGCaHMHDpO18C5oLMVQQjrf2wrzeY1hAA=;
        b=uCEtK0IlSybbqYWh0E6JcN4EqBiBZ9DBQTcKKMsHO1nDSRucX1WFtsyRkVkSmwxFei
         0GYb82ush/G5juYMRmiFiYh4cYnbrPuWDknFifvEBWffj7WlTehT6+m3kyn7ZOwN8zme
         DqC01Wrgfn6+z7YSoBxSyuop62fq7DBcHES1NcdKzQdmOz3VoiS1rQIBHC/Bu0zKMBlr
         JLqbLaIyuuaYm2Fpyf7+I0LqDYFL5Upg57KvBPCXQJA2LYUXzBrNrpSwnkZRRtFQGHWx
         NXFvNC67Kvb0KRXkV6djjU4FSTPyLulxAuy/nvI83Es1nSNTIrboItCiN+/THgk4ClHP
         C/Mg==
X-Forwarded-Encrypted: i=1; AJvYcCU7IiWf1E4iBRbcoEQA8M/vcmhVEjJqUN3jitsoXMLLvLsr1BYs8++IneIcWG0MVe4yNC/mF3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YztEftuhoE9oFQNSwFwk+UGM8/ooQDpz9hfbPzbTAOfMiz5aXM0
	vuAGNW+bduqfv4uWbpzKZJcRA7YGYsCGcQZmHhA+/udpG490fOWVVCkOuE4+g2oHeGrZ8rzCxfS
	yxJGA4QKKvBKXNDuNby0JDL+tixZU5P2KNr1pzUs=
X-Gm-Gg: ASbGncuTu7e82s6HdwKwt+qvrBrjNKp2iNIFBtYP479bvyZRHPc560VYttMmbwmPw9w
	t41o89UZCeo8org36JJXF4F0bVvumKTezBpL6qnvhYoVbeBpWaSi9HSkN+8RDptbh0v65grd0Px
	IwrzPGAqCdFgjD/EXve1jJpvLSlktIiQ5zCgUD2b5MZL6TBkU512WntpMAF5Dk66EmnPYVyuM/v
	Pls7w8+r0MnXxYA6k5r84AzvUBmOciXW5mBuQI9VyRaNZALt+zQ2pZSL6vx
X-Google-Smtp-Source: AGHT+IFE+jMAi7h84qz7XsmrOA79Sd5fnA4EM2eXCUcvh21k25H/Gc4+Y4wEo+5nw8VEoR1gFzucPWsrRT+RdmGjjkk=
X-Received: by 2002:a05:6e02:440b:20b0:430:c78c:75d6 with SMTP id
 e9e14a558f8ab-430c78c7663mr136337455ab.2.1760933086863; Sun, 19 Oct 2025
 21:04:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251019170016.138561-1-peng.yu@alibaba-inc.com>
 <CANn89iLsDDQuuQF2i73_-HaHMUwd80Q_ePcoQRy_8GxY2N4eMQ@mail.gmail.com>
 <befd947e-8725-4637-8fac-6a364b0b4df0.peng.yu@alibaba-inc.com> <CANn89iJN4V8SeythtQVrSjhztWmCySdAxR8h35i4Ea2ceq9k8w@mail.gmail.com>
In-Reply-To: <CANn89iJN4V8SeythtQVrSjhztWmCySdAxR8h35i4Ea2ceq9k8w@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 20 Oct 2025 12:04:10 +0800
X-Gm-Features: AS18NWALYw2lHzYBSWjmSmUBTSCtc_mSfoRsooIveVePQXl350PkrjeJ8WzCf2o
Message-ID: <CAL+tcoD8akZPp87CFnc2d98eZGvXheNeUEJBZcJEaqHZst4DFQ@mail.gmail.com>
Subject: Re: [PATCH] net: set is_cwnd_limited when the small queue check fails
To: Eric Dumazet <edumazet@google.com>
Cc: "YU, Peng" <peng.yu@alibaba-inc.com>, Peng Yu <yupeng0921@gmail.com>, 
	ncardwell <ncardwell@google.com>, kuniyu <kuniyu@google.com>, 
	netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 12:00=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Sun, Oct 19, 2025 at 4:00=E2=80=AFPM YU, Peng <peng.yu@alibaba-inc.com=
> wrote:
> >
> > I think we know the root cause in the driver. We are using the
> > virtio_net driver. We found that the issue happens after this driver
> > commit:
> >
> > b92f1e6751a6 virtio-net: transmit napi
> >
> > According to our test, the issue will happen if we apply below change:
> >
> >
> >  static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
> >  {
> >         struct virtio_net_hdr_mrg_rxbuf *hdr;
> > @@ -1130,6 +1174,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb=
, struct net_device *dev)
> >         int err;
> >         struct netdev_queue *txq =3D netdev_get_tx_queue(dev, qnum);
> >         bool kick =3D !skb->xmit_more;
> > +       bool use_napi =3D sq->napi.weight;
> >
> >         /* Free up any pending old buffers before queueing new ones. */
> >         free_old_xmit_skbs(sq);
> > @@ -1152,8 +1197,10 @@ static netdev_tx_t start_xmit(struct sk_buff *sk=
b, struct net_device *dev)
> >         }
> >
> >         /* Don't wait up for transmitted skbs to be freed. */
> > -       skb_orphan(skb);
> > -       nf_reset(skb);
> > +       if (!use_napi) {
> > +               skb_orphan(skb);
> > +               nf_reset(skb);
> > +       }
> >
> >
> > Before this change, the driver will invoke skb_orphan immediately when
> > it receives a skb, then the tcp layer will decrease the wmem_alloc.
> > Thus the small queue check won't fail. After applying this change, the
> > virtio_net driver will tell tcp layer to decrease the wmem_alloc when
> > the skp is really sent out.
> > If we set use_napi to false, the virtio_net driver will invoke
> > skb_orphan immediately as before, then the issue won't happen.
> > But invoking skb_orphan in start_xmit looks like a workaround to me,
> > I'm not sure if we should rollback this change.  The small queue check
> > and cwnd window would come into a kind of "dead lock" situation to me,
> > so I suppose we should fix that "dead lock".  If you believe we
> > shouldn't change TCP layer for this issue, may I know the correct
> > direction to resolve this issue? Should we modify the virtio_net
> > driver, let it always invoke skb_orphan as before?
> > As a workaround, we set the virtio_net module parameter napi_tx to
> > false, then the use_napi would be false too. Thus the issue won't
> > happen. But we indeed want to enable napi_tx, so may I know what's
> > your suggestion about this issue?
> >
>
> I think you should start a conversation with virtio_net experts,
> instead of making TCP
> bufferbloated again.
>
> TX completions dynamics are important, and we are not going to
> penalize all drivers
> just because of one.
>
> You are claiming deadlocks, but the mechanisms in place are proven to
> work damn well.

Oh, we're almost at the same time to reply to the thread :)

Right, I'm totally with you.

Thanks,
Jason

>
> >
> > ------------------------------------------------------------------
> > From:Eric Dumazet <edumazet@google.com>
> > Send Time:2025 Oct. 20 (Mon.) 01:43
> > To:Peng Yu<yupeng0921@gmail.com>
> > CC:ncardwell<ncardwell@google.com>; kuniyu<kuniyu@google.com>; netdev<n=
etdev@vger.kernel.org>; "linux-kernel"<linux-kernel@vger.kernel.org>; Peng =
YU<peng.yu@alibaba-inc.com>
> > Subject:Re: [PATCH] net: set is_cwnd_limited when the small queue check=
 fails
> >
> >
> > On Sun, Oct 19, 2025 at 10:00 AM Peng Yu <yupeng0921@gmail.com> wrote:
> > >
> > > The limit of the small queue check is calculated from the pacing rate=
,
> > > the pacing rate is calculated from the cwnd. If the cwnd is small,
> > > the small queue check may fail.
> > > When the samll queue check fails, the tcp layer will send less
> > > packages, then the tcp_is_cwnd_limited would alreays return false,
> > > then the cwnd would have no chance to get updated.
> > > The cwnd has no chance to get updated, it keeps small, then the pacin=
g
> > > rate keeps small, and the limit of the small queue check keeps small,
> > > then the small queue check would always fail.
> > > It is a kind of dead lock, when a tcp flow comes into this situation,
> > > it's throughput would be very small, obviously less then the correct
> > > throughput it should have.
> > > We set is_cwnd_limited to true when the small queue check fails, then
> > > the cwnd would have a chance to get updated, then we can break this
> > > deadlock.
> > >
> > > Below ss output shows this issue:
> > >
> > > skmem:(r0,rb131072,
> > > t7712, <------------------------------ wmem_alloc =3D 7712
> > > tb243712,f2128,w219056,o0,bl0,d0)
> > > ts sack cubic wscale:7,10 rto:224 rtt:23.364/0.019 ato:40 mss:1448
> > > pmtu:8500 rcvmss:536 advmss:8448
> > > cwnd:28 <------------------------------ cwnd=3D28
> > > bytes_sent:2166208 bytes_acked:2148832 bytes_received:37
> > > segs_out:1497 segs_in:751 data_segs_out:1496 data_segs_in:1
> > > send 13882554bps lastsnd:7 lastrcv:2992 lastack:7
> > > pacing_rate 27764216bps <--------------------- pacing_rate=3D27764216=
bps
> > > delivery_rate 5786688bps delivered:1485 busy:2991ms unacked:12
> > > rcv_space:57088 rcv_ssthresh:57088 notsent:188240
> > > minrtt:23.319 snd_wnd:57088
> > >
> > > limit=3D(27764216 / 8) / 1024 =3D 3389 < 7712
> > > So the samll queue check fails. When it happens, the throughput is
> > > obviously less than the normal situation.
> > >
> > > By setting the tcp_is_cwnd_limited to true when the small queue check
> > > failed, we can avoid this issue, the cwnd could increase to a reasona=
lbe
> > > size, in my test environment, it is about 4000. Then the small queue
> > > check won't fail.
> >
> >
> > >
> > > Signed-off-by: Peng Yu <peng.yu@alibaba-inc.com>
> > > ---
> > >  net/ipv4/tcp_output.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > > index b94efb3050d2..8c70acf3a060 100644
> > > --- a/net/ipv4/tcp_output.c
> > > +++ b/net/ipv4/tcp_output.c
> > > @@ -2985,8 +2985,10 @@ static bool tcp_write_xmit(struct sock *sk, un=
signed int mss_now, int nonagle,
> > >                     unlikely(tso_fragment(sk, skb, limit, mss_now, gf=
p)))
> > >                         break;
> > >
> > > -               if (tcp_small_queue_check(sk, skb, 0))
> > > +               if (tcp_small_queue_check(sk, skb, 0)) {
> > > +                       is_cwnd_limited =3D true;
> > >                         break;
> > > +               }
> > >
> > >                 /* Argh, we hit an empty skb(), presumably a thread
> > >                  * is sleeping in sendmsg()/sk_stream_wait_memory().
> > > --
> > > 2.47.3
> >
> > Sorry this makes no sense to me.  CWND_LIMITED should not be hijacked.
> >
> > Something else is preventing your flows to get to nominal speed,
> > because we have not seen anything like that.
> >
> > It is probably a driver issue or a receive side issue : Instead of
> > trying to work around the issue, please root cause it.
>


Return-Path: <netdev+bounces-219784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 959A6B42F67
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 04:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA54E1BC742B
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 02:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0E61FE44B;
	Thu,  4 Sep 2025 02:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vg4DUxxV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745AB1F3B9E;
	Thu,  4 Sep 2025 02:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756951833; cv=none; b=jRxMlJCOJ93JjLtNTH0+Mc67EpXEzhU20O2sRJmLvms751DFcrBzr+8qvGZbYkJMryyQAbJJI8yfQVzSTFRtIAomZbe96VdZTMxP6xpFW1GlFhajhLNJtx1fElTp6sxLmNqZtgqvvGgEmfluEKgt+P3QgydpaWuWFl5wYdQg+5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756951833; c=relaxed/simple;
	bh=JDG+bpmRr3JVfrS9E3EWnkvwEUQaKf/y21zhSG6Epo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ajbRz17nLOvLB0V9AYVLlYIlyuuYpJNxt30wzFXQ5fuB56oBZ115tCkg4ExMXHhYO+SIoSKXBMz+MnlrWioq6V8fQN+Ev2pSKvvjooZEFPvSzrePrLUm+f/VgsoC/SjyRMyGPn/+zlQW0NV39UnV2JiSxuSinbaC2yvzLD6RnP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vg4DUxxV; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3f664c47ad3so6212845ab.2;
        Wed, 03 Sep 2025 19:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756951830; x=1757556630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HR6fRaQQWI3CNJtJXkMDroRDdqsm/sqYrmpKftXM96M=;
        b=Vg4DUxxVy7rPn/gsvbf6g3CDPA4eSB3damxaxQVgHIpISwI/iLugG22RI94Al5EKwq
         D2OnFCkSiuWokSaTK9wceO3TekQFldY05oCOgnpTjrtZw6yhXHpiCbTX3GbOGl63drpy
         ae51rhEyZUlBboHEqnjMzxn5Cq4TI7SHMY/uJ22F7gdip8y1W0RGNbCluMKeAZst4eoI
         0IVktQFhRhSz8xKm5H170Zih2Y9qZte9DcC7T6Lg/uHYQVusRcxc6KXczRDwvItu9yeH
         VWOnDt6MtwbnP1phJcFY2krLwI2PA2DhtGTKZ9OtjBxXVuyYvzqC3Lo5XswK8OzKtkGK
         H2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756951830; x=1757556630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HR6fRaQQWI3CNJtJXkMDroRDdqsm/sqYrmpKftXM96M=;
        b=lfQJKI0UQWFqx7c7/CuF4o9frfbQVjznjXoGVEMK01C5sEeS1nGnqAYnrEoTPX7uHS
         vD2KQEOAJPTHSh7VJvGU4kUhsxyc74mfGFVPvBX8u+sNJoOFVIz3DQTo2V1QG+k2yrvl
         ieTsTibs45W2Ibby0YoffO+EC+n6ga5XXbW3blX9hU5vW0+rEQRzIdNhqi/NkCtNrf5l
         D+FJ58BNdCqrYJQSEaOSZ/QAxCt2ORzAKDg6Q7sdB0zewexcKCu98aXSJGf6+l3wH1Zs
         7AzAIoaoatPKCHZ0PiBVVxsvlVP7sUE9DZpxFCujKiuwduoqTC3cgvM9pLBsEc+eficA
         n80Q==
X-Forwarded-Encrypted: i=1; AJvYcCVyfNR47VzgWvHdLoxEa7glctFxoDRxogBDwSK39aldSZavcuqtqfz6T//SY6muti6Ku2ufo1J1HS+TV9w=@vger.kernel.org, AJvYcCWVlgN+dQRv+395CoLeSphji+4qxD2HMseMhe8I10I64ZtoYWV83GQIWxLFbY68JoDUN/fbRr5t@vger.kernel.org
X-Gm-Message-State: AOJu0YyznInJYapbK/jPX+L9NlRyDPU32T1pa/AsgUEnuoYlg0ezJe3G
	ZIlAtRBUn1ts/tlSvEydVDCK+dLKkHkeAXgCsvbBK/XSrtg+U3i44p2SBdZEKMXC16uAV2vEkp7
	MyIHx6os67KLktziEpRJsscu+3pQwt3c=
X-Gm-Gg: ASbGncuPXf/HMdLn/d4Fjitr4abzGotuh+CQaiEetP0rvgcEaVf+Y8nTfMd1cRTDU1H
	0hAZUw0x68wPXnCU9D37wxLBGAG1y+Sm7u+zI6MfMn4qmVB4bmta3WJE3uDcEyTS7BdiqCVLhJ7
	TE810KU7VL8P47OydnoR9nefx7uZ+hbXOgIuumTWZztdkpHKxw8j1Rkt+k5bq9VK7NRcFofpAFl
	pQiR3tmWJYuvfzS
X-Google-Smtp-Source: AGHT+IE8H8f7mZY3whrhnkEI4XuLpQovz9595ku4AWVcdCF/TNdZ7BptxQ8yq5pdJHSb6KBTS3MDp1nGvc/O0VREfhk=
X-Received: by 2002:a05:6e02:b48:b0:3f6:63a9:d5f8 with SMTP id
 e9e14a558f8ab-3f663a9d895mr48891925ab.30.1756951830294; Wed, 03 Sep 2025
 19:10:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903145600.512627-1-jackzxcui1989@163.com>
In-Reply-To: <20250903145600.512627-1-jackzxcui1989@163.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 4 Sep 2025 10:09:54 +0800
X-Gm-Features: Ac12FXx4LKWkv55p6NOQvc5BuqqfO904lb3vgqvOX8KZo0mxJHZKeNajeLa4wY8
Message-ID: <CAL+tcoAgsWdNuwBep=Kch+YRkFnAmHS+OTA0Ffxqy=p6bH9hag@mail.gmail.com>
Subject: Re: [PATCH net-next v10 1/2] net: af_packet: remove
 last_kactive_blk_num field
To: Xin Zhao <jackzxcui1989@163.com>
Cc: willemdebruijn.kernel@gmail.com, edumazet@google.com, ferenc@fejes.dev, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 10:58=E2=80=AFPM Xin Zhao <jackzxcui1989@163.com> wr=
ote:
>
> On Tue, Sep 2, 2025 at 22:04=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
>
> > > kactive_blk_num (K) is incremented on block close. last_kactive_blk_n=
um (L)
> > > is set to match K on block open and each timer. So the only time that=
 they
> > > differ is if a block is closed in tpacket_rcv and no new block could =
be
> > > opened.
> > > So the origin check L=3D=3DK in timer callback only skip the case 'no=
 new block
> > > to open'. If we remove L=3D=3DK check, it will make prb_curr_blk_in_u=
se check
> > > earlier, which will not cause any side effect.
> >
> > I believe the above commit message needs to be revised:
> > 1) the above sentence (starting from 'if we remove L....') means
> > nothing because your modification doesn't change the behaviour when
> > the queue is not frozen.
> > 2) lack of proofs/reasons on why exposing the prb_open_block() logic do=
esn't
> > cause side effects. It's the key proof that shows to future readers to
> > make sure this patch will not bring trouble.
>
> This diff file may not clearly demonstrate the changes made to the
> prb_retire_rx_blk_timer_expired function. We have simply removed the chec=
k for
> pkc->last_kactive_blk_num =3D=3D pkc->kactive_blk_num; the other logic re=
mains unchanged.
> Therefore, we should only need to explain why removing the check for
> pkc->last_kactive_blk_num =3D=3D pkc->kactive_blk_num will not cause any =
negative impacts.
>
> I will clarify in the commit that our change to prb_retire_rx_blk_timer_e=
xpired only
> involves removing the check for pkc->last_kactive_blk_num =3D=3D pkc->kac=
tive_blk_num,
> to ensure that everyone understands this point, as it may not be clearly =
visible from
> the diff file.
>
> The commit may be changed as follow:
>
> kactive_blk_num (K) is only incremented on block close.
> In timer callback prb_retire_rx_blk_timer_expired, except delete_blk_time=
r
> is true, last_kactive_blk_num (L) is set to match kactive_blk_num (K) in
> all cases. L is also set to match K in prb_open_block.
> The only case K not equal to L is when scheduled by tpacket_rcv
> and K is just incremented on block close but no new block could be opened=
,
> so that it does not call prb_open_block in prb_dispatch_next_block.
> This patch modifies the prb_retire_rx_blk_timer_expired function by simpl=
y
> removing the check for L =3D=3D K. Why can we remove the check for L =3D=
=3D K in
> timer callback?
> In prb_freeze_queue, reset_pending_on_curr_blk (R) is set to 1. If R =3D=
=3D 1,
> prb_queue_frozen return 1. In prb_retire_rx_blk_timer_expired,
> frozen =3D prb_queue_frozen(pkc); so frozen is 1 when R =3D=3D 1.
>
> Consider the following case:
> (before applying this patch)
> cpu0                                  cpu1
> tpacket_rcv
>   ...
>     prb_dispatch_next_block
>       prb_freeze_queue (R =3D 1)
>                                       prb_retire_rx_blk_timer_expired
>                                         L !=3D K
>                                           _prb_refresh_rx_retire_blk_time=
r
>                                             refresh timer
>                                             set L =3D K

I do not think the above can happen because:
1) tpacket_rcv() owns the sk_receive_queue.lock and then calls
packet_current_rx_frame()->__packet_lookup_frame_in_block()->prb_dispatch_n=
ext_block()
2) the timer prb_retire_rx_blk_timer_expired() also needs to acquire
the same lock first.

> (after applying this patch)
> cpu0                                  cpu1
> tpacket_rcv
>   ...
>     prb_dispatch_next_block
>       prb_freeze_queue (R =3D 1)
>                                       prb_retire_rx_blk_timer_expired
>                                         !forzen is 0
>                                           check prb_curr_blk_in_use
>                                             if true
>                                               same as (before apply)
>                                             if false
>                                               prb_open_block
> Before applying this patch, prb_retire_rx_blk_timer_expired will do nothi=
ng
> but refresh timer and set L =3D K in the case above. After applying this
> patch, it will check prb_curr_blk_in_use and call prb_open_block if
> user-space caught up.

The major difference after this patch is that even if L !=3D K we would
call prb_open_block(). So I think the key point is that this patch
provides another checkpoint to thaw the might-be-frozen block in any
case. It doesn't have any effect because
__packet_lookup_frame_in_block() has the same logic and does it again
without this patch when detecting the ring is frozen. The patch only
advances checking the status of the ring.

Thanks,
Jason

>
>
> Please check if the above description is appropriate. I will change the
> description as above in PATCH v11.
>
>
> >
> > >
> > > Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
> >
> > It was suggested by Willem, so please add:
> > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
>
> Okay, I will add it in the PATCH v11.
>
> >
> > So far, it looks good to me as well:
> > Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> >
> > And I will finish reviewing the other patch by tomorrow :)
>
>
> Thanks
> Xin Zhao
>


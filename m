Return-Path: <netdev+bounces-88659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A9F8A81A1
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 13:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB0B02865D2
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 11:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C1713F431;
	Wed, 17 Apr 2024 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfUQ0E0T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6110313D264
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 11:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713351834; cv=none; b=X3G3v3MuybF2UA6k9GoL6Y3Y29Yqt1HCscb3mH/nquH2327bUaodPdB9QaPX8i7e2MBO93bE97mZkjKI5BbPesR7oBxMzpw592dOXAyU/KFomsAVZWXSDF8ETL20omTVNZSjA8oHCXvc4CMzDiKxALJg4EzLTaZWHKGNPdwM0NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713351834; c=relaxed/simple;
	bh=bXXTHuGrpZgdNgQTl9T8IhAo7qo36IbOSrgIlxr46es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TQ/1dKBkTDo7MSg6Kk2liYrCMvWynXNqD3HlVnepYvcPhHV1feehvxtn9UWRf7QC/ll5arqQgPZ94BQbrcUlmNQQ+s8DFJ0X5Q8uBMyN8EzenjaNkfmAyA/+Qx40Vv63P5eWJrBwrQvyCC2w3IvrqwCJ0GMBcqgnvG+2sIz//40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfUQ0E0T; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a524ecaf215so508552566b.2
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 04:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713351827; x=1713956627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzTkaIGi1pksa/hCpFvkSDh0ZDb+oyr6XD9u+Ojgrek=;
        b=HfUQ0E0TjP83C7PfVqYfWFBsFRccCz6gHlmlcmkHQvjbaW7kwMLwNPhx0EpwiKuv6x
         4fMQCo27sKu7aGwuzRbvcFc6KXyDcTjAMnqg+ZBwzMe3D4crZ3jC8gbLe7Qp5cZG6Sne
         qnkFSMhlZ61+czFUrj+qnUtKxHycHRk8FhFeVFZxqpQwEcms/RhU90xroyxEArQ0yYy0
         NhEC2PeuB3xh8lK6Gu6WeGQN3gblH/2YGESGmv7qFV4V80D03Xr9Pyn4N4/fz7ppmc6y
         AtfnPfyyBo2v7pn8YhRaRNFlxf11j05i8w682lPFFhCE67z8QU4JTQMLjblWaEFds8Ga
         WIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713351827; x=1713956627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzTkaIGi1pksa/hCpFvkSDh0ZDb+oyr6XD9u+Ojgrek=;
        b=Pd0iy7VaU8rFczplSODJWFPOBqzm0gDtE/mbG+e6McPwLj8fnKXk3vrJzUx6NbD7HS
         AkF7uzL2LHIs/pY6xFuxF0k1c/7oD5yzHuMFX78yxVcot6Tzm+HVjaHP5AuriqHlXv8B
         z12j/1YzCAY3ehvN4NRzX8kwwQ9o5ZZihIuVCXgiVwhQE1evj5tP179OdQty7ss0Ll1e
         lm7sUEZkQ193Yc65X/EG5iDl51uuBiA1YRvk36HgbVjsf2jWIXiYJoX/m0QiqDEjuNTx
         b4cfVe103kbGZKbgML+m5vo/DxLO7sQtEJnOAjfJW8qO+R7oIzrTO7/fUrrwS79wU57t
         ukkg==
X-Forwarded-Encrypted: i=1; AJvYcCUlFoPBpY3lXQeqj0wKaStI9Sjn4uFA1V2k6iSah7j2QZhlAr50TwGOJFpmqmi5FODK46SVLsCh4wc92xRexB9lpO0BYof1
X-Gm-Message-State: AOJu0YzjYDaIrvKmaYUzCjFqEgf0H5brrlTnX0n67nbMWkPwv1uvqFIr
	x0cwku0L3xP7+ork51lTIOf6tVxroQ++NNmV50z/NS1niyYvsFNqhccFOxBOwk48Rfv8PMhMKYQ
	/hjJUkT19xwEwtjkCryW9fm7d9P8=
X-Google-Smtp-Source: AGHT+IFRczJ+jiPx1rcinRL3YXV2Kw/bBZRsommJWpVvZmLOox2uewrXnAlJBYNrjTmjvd2QhO7kOCBUBLH6Ud6cpbE=
X-Received: by 2002:a17:907:7f88:b0:a51:8145:6877 with SMTP id
 qk8-20020a1709077f8800b00a5181456877mr13366710ejc.37.1713351827357; Wed, 17
 Apr 2024 04:03:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417062721.45652-1-kerneljasonxing@gmail.com>
 <20240417062721.45652-3-kerneljasonxing@gmail.com> <CANn89iLKxuBcriFNjtAS8DuhyLq2MPzGdvZxzijzhYdKM+Cw6w@mail.gmail.com>
In-Reply-To: <CANn89iLKxuBcriFNjtAS8DuhyLq2MPzGdvZxzijzhYdKM+Cw6w@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 17 Apr 2024 19:03:10 +0800
Message-ID: <CAL+tcoBZ0MCntKO2POZ9g6kZ7euMXZY94FWN85siH1tZ6w5Lrg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/3] net: rps: protect filter locklessly
To: Eric Dumazet <edumazet@google.com>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, horms@kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 6:04=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Apr 17, 2024 at 8:27=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > As we can see, rflow->filter can be written/read concurrently, so
> > lockless access is needed.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> > I'm not very sure if the READ_ONCE in set_rps_cpu() is useful. I
> > scaned/checked the codes and found no lock can prevent multiple
> > threads from calling set_rps_cpu() and handling the same flow
> > simultaneously. The same question still exists in patch [3/3].
> > ---
> >  net/core/dev.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 2003b9a61e40..40a535158e45 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -4524,8 +4524,8 @@ set_rps_cpu(struct net_device *dev, struct sk_buf=
f *skb,
> >                         goto out;
> >                 old_rflow =3D rflow;
> >                 rflow =3D &flow_table->flows[flow_id];
> > -               rflow->filter =3D rc;
> > -               if (old_rflow->filter =3D=3D rflow->filter)
> > +               WRITE_ONCE(rflow->filter, rc);
> > +               if (old_rflow->filter =3D=3D READ_ONCE(rflow->filter))
>
> You missed the obvious opportunity to use
>
>                if (old_rflow->filter =3D=3D  rc)
>
> Here your code is going to force the compiler to read the memory right
> after a prior write, adding a stall on some arches.

Thanks. I see. I will remove READ_ONCE() and then reuse 'rc'.

I would like to ask one relational question: could multiple threads
access the same rflow in set_rps_cpu() concurrently? Because I was
thinking a lot about whether I should use the READ_ONCE() here to
prevent another thread accessing/modifying this value concurrently.
The answer is probably yes?

Thanks,
Jason

>
> >                         old_rflow->filter =3D RPS_NO_FILTER;
> >         out:
> >  #endif
> > @@ -4666,7 +4666,7 @@ bool rps_may_expire_flow(struct net_device *dev, =
u16 rxq_index,
> >         if (flow_table && flow_id <=3D flow_table->mask) {
> >                 rflow =3D &flow_table->flows[flow_id];
> >                 cpu =3D READ_ONCE(rflow->cpu);
> > -               if (rflow->filter =3D=3D filter_id && cpu < nr_cpu_ids =
&&
> > +               if (READ_ONCE(rflow->filter) =3D=3D filter_id && cpu < =
nr_cpu_ids &&
> >                     ((int)(READ_ONCE(per_cpu(softnet_data, cpu).input_q=
ueue_head) -
> >                            READ_ONCE(rflow->last_qtail)) <
> >                      (int)(10 * flow_table->mask)))
> > --
> > 2.37.3
> >


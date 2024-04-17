Return-Path: <netdev+bounces-88675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FACC8A82F1
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 14:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7B81B210C8
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 12:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A043B13CF94;
	Wed, 17 Apr 2024 12:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQa4UJyj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153045B1E0
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 12:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713356089; cv=none; b=Pq2KyIkvCt9XF1n6P1KHmaRABEwPUFAF/fu1FFojG+vQn4MSjkPqoXAH0V1eZUS9NNXR2PrWpfq5I284iFVHowRmrz/0qgP5IbwmilnynnffRi9yml6oIpOlzwI+p5rYwxnEBTA+95clEcizJafQrOniCIeB6AkPWYnxb+5udz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713356089; c=relaxed/simple;
	bh=G9WeQquYO04PtHyVkrKJTOa6pnak3i4WAGbisF1vopI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rxoMBQMcCGiRnJdvZPzoLhXvYLvxD11bW7knlbpFM2pp7tSlR4uW5W6mJe7BfmXvIaVQ8ziELDYEY+ORZ+rdgwWbReidep25550kbK6eeJYTB49VHQKNhK6W5o96yvTQwvkNg3eMdKcLIRRpO48sHegwX4J9pb/EBg/r/kq7FjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQa4UJyj; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a555faf94fcso53397366b.0
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 05:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713356086; x=1713960886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJFaodPx+9f07hJzg7MK4LOTdj5DKtQeKmrTiaGX7g8=;
        b=iQa4UJyjs1uMY13jxLwazXnpA8gKOAqvmKQvItHz9LmsMfwiTkQZKYaK9Q3/G1E9pZ
         G7zZbqpJ2qFqBVWJQ6DEExmIuFmlDPf3UwYAKPXZLNv1hAKxk74KZzAEjG4/KYJkz5Pf
         sAyhFYD6t5HMjorBap69pCgABW3pdF5Oz12faDvyCeeIJ5/Ga3sX58YU8aRsjJbNgwTT
         Lz8VFwXLWELN8WsKPuNBFM+NSvWBoixF+MIgVF9jXR8Yiiq2BxYXehf7g7yWm0ELMjfE
         gVlerFWDeNmgNfo3XLWUWwi0z57Ynk/PtNQ93Y0VwFyIVzVv5HyEiUN7rAJLIf6eCUHp
         QPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713356086; x=1713960886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJFaodPx+9f07hJzg7MK4LOTdj5DKtQeKmrTiaGX7g8=;
        b=vhMh0iz65/IeAxcq5eQ8ZctlGAKKr+JtUd9y0EqIR3Y4S+P7/4gypDa4gCfdxHsU8D
         gVKEDc2+KcWddZzNL3YjM5YRql8JflLpy++PRacKAoh/NV7fwvDw1djeYe9zQqXdjcW1
         t2U3n7Z1R1kPK2/U19XLuUOFiJJHz1fD+tel/JXsN5hgZHW442iziDQMtNG0DtzSFWSt
         jI0NEgPfEk13/ZHpR2xHpQsdprYIvSoSvaXCKDsYU/pN3OY7e1fXyRukACQRn7k9X6xD
         pkRaPs2+YUUSo7Sf2xUUrOMSLotXoj9N9rben63Eus/3s4toa5OheqSYRORjem1mfPo3
         00jA==
X-Forwarded-Encrypted: i=1; AJvYcCU5R3YlQNrLvdtSiA4MtjcrHPIZqywdvmQgpFPXKiBMcQHHkfD+oia1HONeaVRaLi7/OQXGkjKp2DQLeRp+Od1NNrymYSoX
X-Gm-Message-State: AOJu0Yy/boymaBfcyZTPTJ4MEhx1uLberiIruy9V72+rPVAh8w6jCAGf
	2XpVv77gC2IGyaslbvCIzxUERMzLyXruaWn84tpxVHBfgXNMlquVkwsNLYSU7M9HKX7jI1p1HFR
	yDi4DidTdERMR0BLRn5cw+wGGq6g=
X-Google-Smtp-Source: AGHT+IEkKlDCHD3biYYQMGwC/t49kZMrjzFD30aMc1onJnNqvlyXr73jYUyNSqNVtaqhbREME5ZFvG/q+ZHkYplY5aY=
X-Received: by 2002:a17:907:b9c3:b0:a51:9197:a2cf with SMTP id
 xa3-20020a170907b9c300b00a519197a2cfmr8530686ejc.44.1713356086090; Wed, 17
 Apr 2024 05:14:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417062721.45652-1-kerneljasonxing@gmail.com>
 <20240417062721.45652-3-kerneljasonxing@gmail.com> <CANn89iLKxuBcriFNjtAS8DuhyLq2MPzGdvZxzijzhYdKM+Cw6w@mail.gmail.com>
 <CAL+tcoBZ0MCntKO2POZ9g6kZ7euMXZY94FWN85siH1tZ6w5Lrg@mail.gmail.com>
 <CANn89iJovrpBc8vFadJZdA89=H5Qt8uvj2Cu3jr=HHP2pELw2Q@mail.gmail.com> <CANn89iJm3Pokx2hJy4af-frhV2+cadRYBSydG2Pc5w3C7d8RrA@mail.gmail.com>
In-Reply-To: <CANn89iJm3Pokx2hJy4af-frhV2+cadRYBSydG2Pc5w3C7d8RrA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 17 Apr 2024 20:14:09 +0800
Message-ID: <CAL+tcoCW2-T3tkNdV6phLTwEj6Hejp5FR13ZB6jDScUCpTV0yQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/3] net: rps: protect filter locklessly
To: Eric Dumazet <edumazet@google.com>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, horms@kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 7:58=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Apr 17, 2024 at 1:52=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > @@ -4668,7 +4668,7 @@ bool rps_may_expire_flow(struct net_device *dev,
> > u16 rxq_index,
> >                 cpu =3D READ_ONCE(rflow->cpu);
> >                 if (rflow->filter =3D=3D filter_id && cpu < nr_cpu_ids =
&&
> >                     ((int)(READ_ONCE(per_cpu(softnet_data,
> > cpu).input_queue_head) -
> > -                          READ_ONCE(rflow->last_qtail)) <
> > +                          rflow->last_qtail) <
> >                      (int)(10 * flow_table->mask)))
> >                         expire =3D false;
> >         }
>
> Oh well, rps_may_expire_flow() might be called from other contexts, so
> only the  READ_ONCE()
> from get_rps_cpu() is not really necessary.

Thanks for telling me the access logic about qtail in the previous email.

Yes, I'm writing exactly what you're saying now :) I can keep
protecting rflow->cpu and rflow->filter locklessly.

I can remove the unneeded annotations around qtail as you suggested
with those two patches if I can, or you can submit it first. It's up
to you :)

Thanks,
Jason


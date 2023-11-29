Return-Path: <netdev+bounces-52243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B7E7FDF5C
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 19:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6C93282A90
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 18:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644683454C;
	Wed, 29 Nov 2023 18:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t4VVgDLH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF18112
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 10:34:23 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54b0c368d98so1130a12.1
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 10:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701282862; x=1701887662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oj8iW5fqpjz7flGK5b84ePxv8TYliajWJz8n3Jo6wQE=;
        b=t4VVgDLHJX3o2FaVZSBkf7xupe2fmCu0VY8eIM+aUhfpD2ddGdzmzfZTgU0TO624lD
         wORTvHvy+iIVWgEXWruaeAen+aYjaXrUf7BSilg8SwN+KxRxuOVSOzYZ70PGYk05/k2h
         +NVDJHz2FCs4yXw5NfuWa6mPeafM4hYnbDbEiG4MrcpY6+BPkETiJpb6V5M7XdC6B0SH
         6A1QlPcY/VqBtLOZqdcf+RHsB0D/qu+U8DL+hS2sD5ezXTbTCGuBJ9JPq/VJVmHLgRoP
         NUy2o5+K8OTlQOKazZ0Y1v5kmJG0ljTHaCC9uVaogrvOjssfrpd9VuDm5eFbdCadrOCr
         VLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701282862; x=1701887662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oj8iW5fqpjz7flGK5b84ePxv8TYliajWJz8n3Jo6wQE=;
        b=o26wxcChc7DgxyZIj5dtykE8AWT8Y3Ji5IQoRrKBFUaSk26wz6YRqDeVPBupRPmsN7
         h3aqkJJde0vsUZAfjJjq3gz1Am1tgYu9M1e/3KS7M6T6UqkTvKaIn1v746ayhlGFc1DN
         ACKYZo/mpjUrC1M53h/FHhN1ZjJgT/Hwry010D1a1klpmZUYbYH4Y49tsrRL9pVvUrMB
         bfZ/efBfGOV17MhT1pQlcIm9yNlCP3OQ+RqcsmOvkgmeOIrcn76NeqrnICK9dhBEIn6v
         SGWGOpC3mCPyt5qZr9sRQrbFDIcPCdc5YOUuU/i3239+H/RSN6t5ZEIf76w+jHnHHnH7
         Vttw==
X-Gm-Message-State: AOJu0YzIjZ0MW6ld8nMcmvdjFuciGw4cihSn7m8GhBt4oXxgXlTXWRQ/
	/XuNTpFMpv5RPpqBzs88437ixnG0pSUjyDR3A5cH0w==
X-Google-Smtp-Source: AGHT+IHSLO+GwHkj/jUTJJ+SRaKZj5oTZ03/vZXAd8Lc0HWiJiTjUaNSqCAcJ/pAes+m68MmBNH4rZrfTQVe99mPcLg=
X-Received: by 2002:a05:6402:1cae:b0:54b:81ba:93b2 with SMTP id
 cz14-20020a0564021cae00b0054b81ba93b2mr386edb.2.1701282861955; Wed, 29 Nov
 2023 10:34:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129165721.337302-1-dima@arista.com> <20231129165721.337302-7-dima@arista.com>
 <CANn89iJcfn0yEM7Pe4RGY3P0LmOsppXO7c=eVqpwVNdOY2v3zA@mail.gmail.com> <df55eb1d-b63a-4652-8103-d2bd7b5d7eda@arista.com>
In-Reply-To: <df55eb1d-b63a-4652-8103-d2bd7b5d7eda@arista.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 29 Nov 2023 19:34:07 +0100
Message-ID: <CANn89iLZx-SiV0BqHkEt9vS4LZzDxW2omvfOvNX6XWSRPFs7sw@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] net/tcp: Store SNEs + SEQs on ao_info
To: Dmitry Safonov <dima@arista.com>
Cc: David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
	Dmitry Safonov <0x7f454c46@gmail.com>, Francesco Ruggeri <fruggeri05@gmail.com>, 
	Salam Noureddine <noureddine@arista.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 7:14=E2=80=AFPM Dmitry Safonov <dima@arista.com> wr=
ote:
>
> On 11/29/23 18:09, Eric Dumazet wrote:
> > On Wed, Nov 29, 2023 at 5:57=E2=80=AFPM Dmitry Safonov <dima@arista.com=
> wrote:
> >>
> >> RFC 5925 (6.2):
> >>> TCP-AO emulates a 64-bit sequence number space by inferring when to
> >>> increment the high-order 32-bit portion (the SNE) based on
> >>> transitions in the low-order portion (the TCP sequence number).
> >>
> >> snd_sne and rcv_sne are the upper 4 bytes of extended SEQ number.
> >> Unfortunately, reading two 4-bytes pointers can't be performed
> >> atomically (without synchronization).
> >>
> >> In order to avoid locks on TCP fastpath, let's just double-account for
> >> SEQ changes: snd_una/rcv_nxt will be lower 4 bytes of snd_sne/rcv_sne.
> >>
> >
> > This will not work on 32bit kernels ?
>
> Yeah, unsure if there's someone who wants to run BGP on 32bit box, so at
> this moment it's already limited:
>
> config TCP_AO
>         bool "TCP: Authentication Option (RFC5925)"
>         select CRYPTO
>         select TCP_SIGPOOL
>         depends on 64BIT && IPV6 !=3D m # seq-number extension needs WRIT=
E_ONCE(u64)
>

Oh well, this seems quite strange to have such a limitation.

> Probably, if there will be a person who is interested in this, it can
> get a spinlock for !CONFIG_64BIT.


>
> > Unless ao->snd_sne and ao->rcv_sneare only read/written under the
> > socket lock (and in this case no READ_ONCE()/WRITE_ONCE() should be
> > necessary)
>

You have not commented on where these are read without the socket lock held=
 ?

tcp_ao_get_repair() can lock the socket.

In TW state, I guess these values can not be changed ?

I think you can remove all these READ_ONCE()/WRITE_ONCE() which are not nee=
ded,
or please add a comment if they really are.

Then, you might be able to remove the 64BIT dependency ...


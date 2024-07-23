Return-Path: <netdev+bounces-112636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322CB93A463
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 18:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C0491C22C01
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 16:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD6F157A7C;
	Tue, 23 Jul 2024 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z+RgCbV1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3B31586C4
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 16:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721752118; cv=none; b=olWgr6YVw1zBA1Vb66RBWssXFaG1sCssPW5nNF/gtUAwJwT3Ug0ToTekc1GIvp5AihJgpqAiOaY+81ODQKyK/A8XGhr/GGaihbWxZKe99ap/HjsDUtYwmDkyXmUP0cTXFY94RwPFT2NGpBPz5YvEXDcLEpI8D4wKpeO9GTOqQU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721752118; c=relaxed/simple;
	bh=He47tfLB1rF0i2GRYw3kXwpAc+FksFIqOfeyxI2EVlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bfmZ/jVmhnsKcDyRfYLb0vugA7FKbElXpFusC0hswJEv8RrEy+rAw+7D/D9vcQN1KN/5da5EmlQcfuZaOW7ocDTfkcczdQE9dyT9YKvwfvKrTK/woBa2wRIHx1T1LgwAafICD5tFVYY0ZeKtnieUffM5y5JUnt1n4LpzZdRYO5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z+RgCbV1; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so18058a12.1
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 09:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721752115; x=1722356915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMIRP3kimguXBqf/5rQrdgsl/tCRIZsEZMFXHQamnCA=;
        b=Z+RgCbV1t5vNTGWoix0hjkXijyy3Sj4GT+T0tlsjQmEBGlNMUizqSpukzle2iy7GAn
         mHazN04NJM+XMjQIlqjKdPC/OCfv/qMH+t/pHhWBWDO/IgvctYt+OhA9wkCn628STBMX
         fv0T/CaDjILSBvi+KkYOgkaKqfqhiMoU9XtPdQTCm9W2Uq5u09W1/iOx1MZk95srCo2Y
         iCVnPrSUiFrnmEUUZxQtAebV4b+IXsQpKDXK6akoVTyZiiM6FFfgP2FcUbrChIUBvMKp
         zsGPmCIAjqOEaFwdr9KoWd6SngddgT1yRyBUuB/LZT+460NtYyvdnfqr1aV0e1pBwL63
         kwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721752115; x=1722356915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMIRP3kimguXBqf/5rQrdgsl/tCRIZsEZMFXHQamnCA=;
        b=J8RizMEfSqgqnFeEmlzGnoYiEhT2CHSUt7IkAm6G6y2DXTlEFF6oR2Nt73ggdn9MJz
         HXs7Ne8CnibhwFN3WpU6faXFNbmvqybkIIuKECvq2sgCbo8mSQ6nznBSXIABHIaPAL/D
         oltyKWsEWidfB7ioeVVgx3YU6PpXvuljujG10wmr7n8LMUasMblTWSwzWdJKN33MI4gv
         oSxqzhebgvAD8xVA9ha7IvjZLSOhI6BTxj+mvdap6bxHz6X+LvD28Mkv6F0k9Oynsy78
         VDBfFAAQgmL2LDK2NbCsGlQ1Ow6GbtxH1e79+Mz+e7uonbdA2/RY68yo7yOmIoo9jg+B
         zN4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHxQnfjaSJ7w9dotG4CEJYsWjS/qbUFx/7AZvKdc4PwVtco/vR9GeIXVngi8lHKE8rq5Rnb1UUm8Tx4xznFZ5CDNNuLyJ5
X-Gm-Message-State: AOJu0YwFm32h77GRBg41MV6WKQzxEdPh8m0Q9KiLeDPGUFpgMFGWueNZ
	aUE4SRx/FhnZXHdiUPvTk9JsocjLUgjKt4ErtDx41g+Dle1T9pZ7xyU1FAvgc2ykZYBz6d106b9
	oJiY/4il4C3dRl4kDKSdRWOgGHTr3zUTkYmG0RkmA2IgrtIdhEg==
X-Google-Smtp-Source: AGHT+IFmT7JsF0R6mLhx9LNISmcf9qtC92Z49jeTKEvaoa6HDFd6ep/JvUMgBlZzurxGS0LGP5YpQPGW0ekC5+pwWmA=
X-Received: by 2002:a05:6402:35ca:b0:57d:32ff:73ef with SMTP id
 4fb4d7f45d1cf-5a456952e27mr623320a12.6.1721752114758; Tue, 23 Jul 2024
 09:28:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723135742.35102-1-kerneljasonxing@gmail.com>
 <CANn89i+dYsvrVwWCRX=B1ZyL3nZUjnNtaQ5rfizDOV5XhHV2dQ@mail.gmail.com>
 <CAL+tcoDZ2VDCd00ydv-RzMudq=d+jVukiDLgs7RpsJwvGqBp1Q@mail.gmail.com>
 <CAL+tcoCC2g1iHA__vr8bbUX-kba2bBi2NbQNZnxOAMTJOQQAWg@mail.gmail.com>
 <CANn89i+3c3fg1SYEpx02yCKHfBoZvYJt=wTqgZ77nCWzN0q-Wg@mail.gmail.com> <CAL+tcoB3iwsTTt8Bpc62Zc-CoyOGRrAdAjo26XqUvFnBoqXpTw@mail.gmail.com>
In-Reply-To: <CAL+tcoB3iwsTTt8Bpc62Zc-CoyOGRrAdAjo26XqUvFnBoqXpTw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 23 Jul 2024 18:28:20 +0200
Message-ID: <CANn89iLDQFbxrcYOvMq+eXkxuArgfnS+uG33dJZmhOGg+xWucQ@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] net: add an entry for CONFIG_NET_RX_BUSY_POLL
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 6:01=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Tue, Jul 23, 2024 at 11:26=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Tue, Jul 23, 2024 at 5:13=E2=80=AFPM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > On Tue, Jul 23, 2024 at 11:09=E2=80=AFPM Jason Xing <kerneljasonxing@=
gmail.com> wrote:
> > > >
> > > > On Tue, Jul 23, 2024 at 10:57=E2=80=AFPM Eric Dumazet <edumazet@goo=
gle.com> wrote:
> > > > >
> > > > > On Tue, Jul 23, 2024 at 3:57=E2=80=AFPM Jason Xing <kerneljasonxi=
ng@gmail.com> wrote:
> > > > > >
> > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > >
> > > > > > When I was doing performance test on unix_poll(), I found out t=
hat
> > > > > > accessing sk->sk_ll_usec when calling sock_poll()->sk_can_busy_=
loop()
> > > > > > occupies too much time, which causes around 16% degradation. So=
 I
> > > > > > decided to turn off this config, which cannot be done apparentl=
y
> > > > > > before this patch.
> > > > >
> > > > > Too many CONFIG_ options, distros will enable it anyway.
> > > > >
> > > > > In my builds, offset of sk_ll_usec is 0xe8.
> > > > >
> > > > > Are you using some debug options or an old tree ?
> > >
> > > I forgot to say: I'm running the latest kernel which I pulled around
> > > two hours ago. Whatever kind of configs with/without debug options I
> > > use, I can still reproduce it.
> >
> > Ok, please post :
> >
> > pahole --hex -C sock vmlinux
>
> 1) Enable the config:
> $ pahole --hex -C sock vmlinux
> struct sock {
>         struct sock_common         __sk_common;          /*     0  0x88 *=
/
>         /* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
>         __u8
> __cacheline_group_begin__sock_write_rx[0]; /*  0x88     0 */
>         atomic_t                   sk_drops;             /*  0x88   0x4 *=
/
>         __s32                      sk_peek_off;          /*  0x8c   0x4 *=
/
>         struct sk_buff_head        sk_error_queue;       /*  0x90  0x18 *=
/
>         struct sk_buff_head        sk_receive_queue;     /*  0xa8  0x18 *=
/
>         /* --- cacheline 3 boundary (192 bytes) --- */
>         struct {
>                 atomic_t           rmem_alloc;           /*  0xc0   0x4 *=
/
>                 int                len;                  /*  0xc4   0x4 *=
/
>                 struct sk_buff *   head;                 /*  0xc8   0x8 *=
/
>                 struct sk_buff *   tail;                 /*  0xd0   0x8 *=
/
>         } sk_backlog;                                    /*  0xc0  0x18 *=
/
>         __u8
> __cacheline_group_end__sock_write_rx[0]; /*  0xd8     0 */
>         __u8
> __cacheline_group_begin__sock_read_rx[0]; /*  0xd8     0 */
>         struct dst_entry *         sk_rx_dst;            /*  0xd8   0x8 *=
/
>         int                        sk_rx_dst_ifindex;    /*  0xe0   0x4 *=
/
>         u32                        sk_rx_dst_cookie;     /*  0xe4   0x4 *=
/
>         unsigned int               sk_ll_usec;           /*  0xe8   0x4 *=
/

See here ? offset of sk_ll_usec is 0xe8, not 0x104 as you posted.

Do not blindly trust perf here.

Please run a benchmark with 1,000,000 af_unix messages being sent and recei=
ved.

I am guessing your patch makes no difference at all (certainly not 16
% as claimed in your changelog)


Return-Path: <netdev+bounces-101391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E35128FE5A4
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 13:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E81AC1C24A77
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 11:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB05D195810;
	Thu,  6 Jun 2024 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gmj1UvpS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B32A195813
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 11:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717674196; cv=none; b=PRnHCtKkpPe7I9tdMBlUrr0je/JjVbfwEZVullkelZazSW4gbA0dLlVDXx04NJq0akhcbGp6ft21BbUNMGwghB3XO0POE5MqzADKGLCi0velsTXFD4LbvVry+x9KRgKERiTwWP9b4q23O80QbXnlvkGIj++Yu27m5xj6b5vXu74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717674196; c=relaxed/simple;
	bh=gyGWhdDdhkpxC5ydmzTGJ4Uy7cIhCO6HWBUO1hu1Gx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bCy4S0DKq04KdNge+XvE4teKz8Pkdgu+k8yPdyGfmq76Kx8dGhzHfBfEdzd6pJI6akP35ct4DLrZ58a7ymjPGhPJEAJYBl2FQRo8QkCzCi3tii82hRti+pIl7MRfuhnQGcxsZbGreS42EqjVDX5sF37J+6TUxhoqo0NQsE5RemQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gmj1UvpS; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57a677d3d79so3695297a12.1
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 04:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717674193; x=1718278993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2Q46ANk4vy7Lg/Mh4YiLhQJijIXJFSdh3CKjAQRR20=;
        b=Gmj1UvpS1SnWxSHxs9/fF3VQ9mYcTRsU8iscM8JD5FpajecoSPPui+Ph0bAW6NQpu5
         8acEaZsJVpuPGlS605fjo4dWzeXhqash7U1EF4oss4cUEp7+ngWkftx31js/WcArM2Zb
         WLhooJm4G/ZljTSmBbYZxuuAz55Vc2UlR6dzD6u3er9t4Ra3WIvhMal1+AdqWvO0l9XE
         bJkSGdaI3ODApsCHuaVZt/vpdyQUoZlvtjl8K6okp2G1A3Fg+TP6c6TYu0wEFWuqMKGU
         +DFGGQmpB/Wr7Tlja/E4zkSEp8xTDvnVOocvPFoHhgkYBu42dnWXzk9BQYWb7zajoa89
         3Nrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717674193; x=1718278993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2Q46ANk4vy7Lg/Mh4YiLhQJijIXJFSdh3CKjAQRR20=;
        b=gZpiiVTPWtKNKk1BnxHa6En8BK0qUjmqrkoUf0GafxmCf5FFNcutwgEsEaFLuP0CGO
         cG0D8+7KWEi8hBH/fPJMn1mmQhMmMT0Lv2E4HhJKpKp7XqlKOLnJUYpYW+nBJ1XLJkL6
         V8eo8cxlSKWlW7VxlbeeCr89rjVV1pi+cNapFeZuQtRfvXJ69QUsP/5JcYxzaL0RusbG
         986ywAR8rJZ6knTniwK3011X1nyEZi55kelQBAZnXzChFK9DukGAu70F8qngnsW8Ex8i
         InYpAEjMvFLAX5JJ3yHDH8fV+nLu0wReqFNOX4D6xUY2KH+IM7rwM0/NKdyQOppXIF92
         3Qmg==
X-Forwarded-Encrypted: i=1; AJvYcCVzSLn/PRBm4JseiyeNXZMlc6/2+rEyqxj5mBM2yOXNgdwjN8rolQ/1t1ksAQoz3oGATt+LeNKejvUjn2d4of2peLkj7h6g
X-Gm-Message-State: AOJu0YzpdGS7+Qhk/ElsIzx7KpViTXVIRzi2r2PYRmH2zL9XDoK0O9tm
	5yYbSTfVlfPNBFxj4t5uuV4xH5vtnnufIdCSPPzs78scBh44j1wKRSNiwA158MD8LNe7FzMuE3o
	gBhFG3IInqkPYHpoGQeK+sHIR5FU=
X-Google-Smtp-Source: AGHT+IEjpq6eRD8fx4Gp8qzRa6Yuf06uiF+1vGdlQwg0yqVny1ur9OnYXCEHM41VT6pNH1VT+f931qr/m74h1WsRsIo=
X-Received: by 2002:a50:d549:0:b0:578:6019:265a with SMTP id
 4fb4d7f45d1cf-57aa53f0a99mr1843938a12.8.1717674193199; Thu, 06 Jun 2024
 04:43:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509114615.317450-1-jiri@resnulli.us> <1715325076.4219763-2-hengqi@linux.alibaba.com>
 <ZktGj4nDU4X0Lxtx@nanopsycho.orion> <ZmBMa7Am3LIYQw1x@nanopsycho.orion>
 <1717587768.1588957-5-hengqi@linux.alibaba.com> <CACGkMEsiosWxNCS=Jpb-H14b=-26UzPjw+sD3H21FwVh2ZTF5g@mail.gmail.com>
 <CAL+tcoB8y6ctDO4Ph8WM-19qAoNMcYTVWLKRqsJYYrmW9q41=w@mail.gmail.com> <CACGkMEvh6nKfFMp5fb6tbijrs88vgSofCNkwN1UzKHnf6RqURg@mail.gmail.com>
In-Reply-To: <CACGkMEvh6nKfFMp5fb6tbijrs88vgSofCNkwN1UzKHnf6RqURg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 6 Jun 2024 19:42:35 +0800
Message-ID: <CAL+tcoA3JpS3S6Hzwpc5F0dzm92AnfYfqj-4uLmTsgQ5hj1fTA@mail.gmail.com>
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
To: Jason Wang <jasowang@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, Jiri Pirko <jiri@resnulli.us>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mst@redhat.com, 
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 12:25=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Jun 6, 2024 at 10:59=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > Hello Jason,
> >
> > On Thu, Jun 6, 2024 at 8:21=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> > >
> > > On Wed, Jun 5, 2024 at 7:51=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.=
com> wrote:
> > > >
> > > > On Wed, 5 Jun 2024 13:30:51 +0200, Jiri Pirko <jiri@resnulli.us> wr=
ote:
> > > > > Mon, May 20, 2024 at 02:48:15PM CEST, jiri@resnulli.us wrote:
> > > > > >Fri, May 10, 2024 at 09:11:16AM CEST, hengqi@linux.alibaba.com w=
rote:
> > > > > >>On Thu,  9 May 2024 13:46:15 +0200, Jiri Pirko <jiri@resnulli.u=
s> wrote:
> > > > > >>> From: Jiri Pirko <jiri@nvidia.com>
> > > > > >>>
> > > > > >>> Add support for Byte Queue Limits (BQL).
> > > > > >>
> > > > > >>Historically both Jason and Michael have attempted to support B=
QL
> > > > > >>for virtio-net, for example:
> > > > > >>
> > > > > >>https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e=
1bc3@redhat.com/
> > > > > >>
> > > > > >>These discussions focus primarily on:
> > > > > >>
> > > > > >>1. BQL is based on napi tx. Therefore, the transfer of statisti=
cal information
> > > > > >>needs to rely on the judgment of use_napi. When the napi mode i=
s switched to
> > > > > >>orphan, some statistical information will be lost, resulting in=
 temporary
> > > > > >>inaccuracy in BQL.
> > > > > >>
> > > > > >>2. If tx dim is supported, orphan mode may be removed and tx ir=
q will be more
> > > > > >>reasonable. This provides good support for BQL.
> > > > > >
> > > > > >But when the device does not support dim, the orphan mode is sti=
ll
> > > > > >needed, isn't it?
> > > > >
> > > > > Heng, is my assuption correct here? Thanks!
> > > > >
> > > >
> > > > Maybe, according to our cloud data, napi_tx=3Don works better than =
orphan mode in
> > > > most scenarios. Although orphan mode performs better in specific be=
nckmark,
> > >
> > > For example pktgen (I meant even if the orphan mode can break pktgen,
> > > it can finish when there's a new packet that needs to be sent after
> > > pktgen is completed).
> > >
> > > > perf of napi_tx can be enhanced through tx dim. Then, there is no r=
eason not to
> > > > support dim for devices that want the best performance.
> > >
> > > Ideally, if we can drop orphan mode, everything would be simplified.
> >
> > Please please don't do this. Orphan mode still has its merits. In some
> > cases which can hardly be reproduced in production, we still choose to
> > turn off the napi_tx mode because the delay of freeing a skb could
> > cause lower performance in the tx path,
>
> Well, it's probably just a side effect and it depends on how to define
> performance here.

Yes.

>
> > which is, I know, surely
> > designed on purpose.
>
> I don't think so and no modern NIC uses that. It breaks a lot of things.

To avoid confusion, I meant napi_tx mode can delay/slow down the speed
in the tx path and no modern nic uses skb_orphan().

I think I will have some time to test BQL in virtio_net.

Thanks,
Jason


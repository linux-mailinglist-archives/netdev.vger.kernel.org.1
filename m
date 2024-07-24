Return-Path: <netdev+bounces-112702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7698F93AA35
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 02:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C56628426A
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 00:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B777D4A1A;
	Wed, 24 Jul 2024 00:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDk/urPY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E374B4A19
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 00:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721781538; cv=none; b=ayaoMxsig2jwoGIAX9/kdHYjaTY4aBCR+SF95bm3qJB7ORENVSXcFcLFyC/qvJtUppy93XwrN9zSXmuaY1PbULRH4vttl/X2u+v7W0+tYiDQsP7lVlmDEsTxfHIbFZ0VDjLDEBAGKyV34CCz73OxTe3fdK1Z4BaekWdMBvXhA0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721781538; c=relaxed/simple;
	bh=sLLmFZMSDm3KuS6d7zOeQffsGrFjKxnGtkkRm1sut5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZVKZ1VxRkLxC7jSpgtbEVxIUkDGPizF/HEIdNN9msKfEhP2e3qUV93Ek9tTGJhehE5uVk51oqQeP8BbMa4mdKgVnqe0MLbgzXj3z6o3t8a56RK7Yt+1f6wD32TjI2f3w6rYPzsf64c2IzkXQOxRJOihao3mTbPIpwifypoK4vPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDk/urPY; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a1fcb611baso5279914a12.1
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 17:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721781535; x=1722386335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHjXK/3vVosQh/xPJNchdWXJr8GeOLPLb5rFiITpsVw=;
        b=TDk/urPYwEQo7S+jWF+L9dD7u8ij6JVMo/R07a0fwSVQxTAYdO8NkUGFlw1VeI2BMV
         4v/4UjdF4yGW/CobL10tLf6MX/cCU16KBvreuVZSAXV2xLCIsFaLTfZN47km4TvumKHP
         toZkEbAkvgPaBxD91K9FzFuhVTEMCqadPhZEKxlwLvZloyjDgUc2uq8VtnIpsG6CP+Ku
         /iezZWegXnMkpQM68cEMD1QMg51FnttLTpHqGWkjpbeJbybgABZbXOzGstdO9SanepcS
         nv/iB7/56KiNENFS0XZO0rmmpsmCd3F451calmmz3lNCvxGSLweWZw7lmw0h0nLunCvV
         fUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721781535; x=1722386335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tHjXK/3vVosQh/xPJNchdWXJr8GeOLPLb5rFiITpsVw=;
        b=IASmdDGi32m7lge1Skx1Clwv5ouJGO6aAXqT46vhdZSMbpbaQ7TsbFKua9jaje7Qr2
         nUOidGuTQ1IN6U8v1u7y5+fYRRVudUDnAUpAJeuRi8lAA1Uuob84SvzuUZ5FSLLT5ewd
         58yy+SbLjssoIGLIKbx0iALNX3Y9AVgYAok6bvXbnlntQZ2/8eQZBQrvs9/klYjKOOV9
         StyCEOJr/12m2LG2rxgWVe+f7UJ88J8JC6UlEdIt20XIbfd7Yo+oWU1wExlY+X4VuSeG
         gQq64hwrV3KnhV1aFnPwXhUTtIEvB3+akAsCMkxwiqWgLRONa1lBGm1bWI9D3sRVk3aj
         bAow==
X-Forwarded-Encrypted: i=1; AJvYcCVAm4rg/UCRuqplyt9Kzf/TJl+jGz2y1EZOIvcD4vB2pnP4f39RCmMQyGknsrvz6R8XAdiZQDD9D/+Zi+ryBOJZjla7SgIW
X-Gm-Message-State: AOJu0YySm+18ufD4p9KesQjFQwtdJ9HXm6GMpSLX6Vpk9eU3rpcX4eeE
	4CdATkmSpQqLXpiryYjWTh2OGHHa6szKuqLGJYpgFPnFHpUeGVddIWZV9VV/B8U/n6R3kLQimp0
	Jzj4xzd5Z6F+DhhGW+Wfm8f9fBWd8fz9Q
X-Google-Smtp-Source: AGHT+IEI/7J8D3OIooE2+WKRP0jMzLiKoabz7GtToaVWXhZhVe4wD0/icNGUljwdL+5keJkdPqffGIbfFpdug0q+ZsQ=
X-Received: by 2002:a05:6402:2691:b0:5a1:6198:10bc with SMTP id
 4fb4d7f45d1cf-5a47bb91de2mr7412886a12.28.1721781535097; Tue, 23 Jul 2024
 17:38:55 -0700 (PDT)
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
 <CANn89i+3c3fg1SYEpx02yCKHfBoZvYJt=wTqgZ77nCWzN0q-Wg@mail.gmail.com>
 <CAL+tcoB3iwsTTt8Bpc62Zc-CoyOGRrAdAjo26XqUvFnBoqXpTw@mail.gmail.com> <CANn89iLDQFbxrcYOvMq+eXkxuArgfnS+uG33dJZmhOGg+xWucQ@mail.gmail.com>
In-Reply-To: <CANn89iLDQFbxrcYOvMq+eXkxuArgfnS+uG33dJZmhOGg+xWucQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 24 Jul 2024 08:38:16 +0800
Message-ID: <CAL+tcoBGRz1ukKe=z2qjPUgjSZ=a-WdXLpTcLj5BxTVNAhnUZg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] net: add an entry for CONFIG_NET_RX_BUSY_POLL
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 12:28=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Tue, Jul 23, 2024 at 6:01=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > On Tue, Jul 23, 2024 at 11:26=E2=80=AFPM Eric Dumazet <edumazet@google.=
com> wrote:
> > >
> > > On Tue, Jul 23, 2024 at 5:13=E2=80=AFPM Jason Xing <kerneljasonxing@g=
mail.com> wrote:
> > > >
> > > > On Tue, Jul 23, 2024 at 11:09=E2=80=AFPM Jason Xing <kerneljasonxin=
g@gmail.com> wrote:
> > > > >
> > > > > On Tue, Jul 23, 2024 at 10:57=E2=80=AFPM Eric Dumazet <edumazet@g=
oogle.com> wrote:
> > > > > >
> > > > > > On Tue, Jul 23, 2024 at 3:57=E2=80=AFPM Jason Xing <kerneljason=
xing@gmail.com> wrote:
> > > > > > >
> > > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > > >
> > > > > > > When I was doing performance test on unix_poll(), I found out=
 that
> > > > > > > accessing sk->sk_ll_usec when calling sock_poll()->sk_can_bus=
y_loop()
> > > > > > > occupies too much time, which causes around 16% degradation. =
So I
> > > > > > > decided to turn off this config, which cannot be done apparen=
tly
> > > > > > > before this patch.
> > > > > >
> > > > > > Too many CONFIG_ options, distros will enable it anyway.
> > > > > >
> > > > > > In my builds, offset of sk_ll_usec is 0xe8.
> > > > > >
> > > > > > Are you using some debug options or an old tree ?
> > > >
> > > > I forgot to say: I'm running the latest kernel which I pulled aroun=
d
> > > > two hours ago. Whatever kind of configs with/without debug options =
I
> > > > use, I can still reproduce it.
> > >
> > > Ok, please post :
> > >
> > > pahole --hex -C sock vmlinux
> >
> > 1) Enable the config:
> > $ pahole --hex -C sock vmlinux
> > struct sock {
> >         struct sock_common         __sk_common;          /*     0  0x88=
 */
> >         /* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
> >         __u8
> > __cacheline_group_begin__sock_write_rx[0]; /*  0x88     0 */
> >         atomic_t                   sk_drops;             /*  0x88   0x4=
 */
> >         __s32                      sk_peek_off;          /*  0x8c   0x4=
 */
> >         struct sk_buff_head        sk_error_queue;       /*  0x90  0x18=
 */
> >         struct sk_buff_head        sk_receive_queue;     /*  0xa8  0x18=
 */
> >         /* --- cacheline 3 boundary (192 bytes) --- */
> >         struct {
> >                 atomic_t           rmem_alloc;           /*  0xc0   0x4=
 */
> >                 int                len;                  /*  0xc4   0x4=
 */
> >                 struct sk_buff *   head;                 /*  0xc8   0x8=
 */
> >                 struct sk_buff *   tail;                 /*  0xd0   0x8=
 */
> >         } sk_backlog;                                    /*  0xc0  0x18=
 */
> >         __u8
> > __cacheline_group_end__sock_write_rx[0]; /*  0xd8     0 */
> >         __u8
> > __cacheline_group_begin__sock_read_rx[0]; /*  0xd8     0 */
> >         struct dst_entry *         sk_rx_dst;            /*  0xd8   0x8=
 */
> >         int                        sk_rx_dst_ifindex;    /*  0xe0   0x4=
 */
> >         u32                        sk_rx_dst_cookie;     /*  0xe4   0x4=
 */
> >         unsigned int               sk_ll_usec;           /*  0xe8   0x4=
 */
>
> See here ? offset of sk_ll_usec is 0xe8, not 0x104 as you posted.

Oh, so sorry. My fault. I remembered only that perf record was
executed in an old tree before you optimise the layout of struct sock.
Then I found out if I disable the config applying to the latest tree
running in my virtual machine, the result is better. So let me find a
physical server to run the latest kernel and will get back more
accurate information of 'perf record' here.

>
> Do not blindly trust perf here.
>
> Please run a benchmark with 1,000,000 af_unix messages being sent and rec=
eived.
>
> I am guessing your patch makes no difference at all (certainly not 16
> % as claimed in your changelog)

The fact is the performance would improve when I disable the config if
I only test unix_poll related paths. The time spent can decrease from
2.45 to 2.05 which is 16%. As I said, it can be easily reproduced.

Thanks,
Jason


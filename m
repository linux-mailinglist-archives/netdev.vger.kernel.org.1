Return-Path: <netdev+bounces-112703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D0193AA40
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 02:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 720C81C221FF
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 00:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C2A28FD;
	Wed, 24 Jul 2024 00:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDfFrL2U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8331A211C
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 00:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721782542; cv=none; b=YYsO5CLWVtmFMgXxMFc4XrEF8XiZm2qI6tRRcI+bzodj0UP9w7FOJTFjlxlpJxgMYWKXxk3ZnWkAkRxdPxlLVddBMmNTmxdvKyKZ5pCZVhYI5Vd5PkmQrIf1SwHJZUlP3l3eX+MDq91hg5LYTwy3f2h7akV7a4IAkTPAZ4CZP1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721782542; c=relaxed/simple;
	bh=/aSY1AOLCv3XKGce7d5dVZJv1yvfDLX5lLcuj3UB33k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rpPiv5IQVu38o9rJc2ORZvur6rmGOJWgB3zRbkNmrO2bpM2NRjmNfyLeyPkoyrLEkhIFvhRxlzwnPidJlldHQm9YQofPoac7BhsDHT3UBXEFm1jcxM3EX7PyKluxVeUcoQvnilf5OW7ZKf/EVRFWh+3zj8XOIjbZOjdj4Hd9DAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDfFrL2U; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eefeab807dso71885721fa.3
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 17:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721782539; x=1722387339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofmN0TDUy1sVOUV1/NC9E5wnwjuLogelV/lWW0ov1rM=;
        b=KDfFrL2UkrcacfJ6+tAeYqp1mLOeDXtDFAygSGJ6q7DE8Abpz7JG4ut8GVdp6NhJGT
         IZl253teJFIfIsIzPAwLAojIpvJsYl5mnMdLFPBHCg8PKO8/JiXvmj+coRWmllGi+u6G
         0sWK/77kfHg8d3voamFyrNBZaJeCxHAkImJdO6UBiqynTNraI1lAZtdfnWxPUGqfR689
         uqzQt+XFGA8hgwYuIO0x75BM1ZZQS1ehj4qhHQe56ByXdyvB4qBhE8iLuyh20Sbo43JR
         hu4Cd4DtMrdvXzHyXaKMcpU0aFCv40w/n7IwWMo6GbiW0R2ULrGlNlKCeov6nGoEY7V5
         qDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721782539; x=1722387339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ofmN0TDUy1sVOUV1/NC9E5wnwjuLogelV/lWW0ov1rM=;
        b=FB2uB9v6SmxoAWocrrw/hVTCAvsMcRQ8yDkuaveFewWu7vY/7uPL4RsiMSwXMg+xYv
         8P1Q0q6jv7lnbVzlCwiUV0Ika+XqGinH+NZH/Z3d8Ho2Kk/4SThSWFw2OerBUj9ioi2Y
         WM3DCymTKJZlzRzVuGNyX0QPr5KUtVZR6etNltUpGFiMqHWossxhldPmvxpTi4BXNZ8K
         N4zVRV8h9R8q45v6LUd71SOLG9IQ+fH++vnQdfS/5iSRV++JVvXIxaRMwE24l74bEjhF
         trU5CXkeSeWzUQVym+qeKMvInRrcEs3YaaDMRjdrulqVwxesyd9VcgqPgV2ykL2vc2fd
         f2JA==
X-Forwarded-Encrypted: i=1; AJvYcCUAw+81Rcr3hV1PwvV7+xxAnK1GFaMFdgvNZrjafUcWIBq36sN7OQz2fqYhPWueCer55nfcPhkbZncdkaCUuZGSHfyKyGnx
X-Gm-Message-State: AOJu0YyweA1vZPzpFi9n9G0yGSoLpmoj/5V+Fl3FtPg09mfhMVoDWBEh
	wLMDc4G/KwH0yngXD6vuB9ylOwyxMg1km+uEJrMgxESq8SEbKQ1i0YoG5RsUuS8D84FqT/7nWLR
	U2Xii/mhGu9ubSQGMeOeG91JAXIJRjfSzkXI=
X-Google-Smtp-Source: AGHT+IEgId9wngY3UjV9zRY7k+RvEfGYDtGiW0pTcgX4rS+gf0IBg8LdwSDy9ZEMkbXLUjkYVq0Vzc7MX25KF7b7/wM=
X-Received: by 2002:a2e:3302:0:b0:2ef:2eb9:5e5b with SMTP id
 38308e7fff4ca-2f0324d8bccmr2862801fa.6.1721782538251; Tue, 23 Jul 2024
 17:55:38 -0700 (PDT)
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
 <CAL+tcoB3iwsTTt8Bpc62Zc-CoyOGRrAdAjo26XqUvFnBoqXpTw@mail.gmail.com>
 <CANn89iLDQFbxrcYOvMq+eXkxuArgfnS+uG33dJZmhOGg+xWucQ@mail.gmail.com> <CAL+tcoBGRz1ukKe=z2qjPUgjSZ=a-WdXLpTcLj5BxTVNAhnUZg@mail.gmail.com>
In-Reply-To: <CAL+tcoBGRz1ukKe=z2qjPUgjSZ=a-WdXLpTcLj5BxTVNAhnUZg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 24 Jul 2024 08:55:01 +0800
Message-ID: <CAL+tcoBoD9v5a+LoftwEGCXM4y7kMr5kGbYRGQK0S0RWt3k16Q@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] net: add an entry for CONFIG_NET_RX_BUSY_POLL
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 8:38=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Wed, Jul 24, 2024 at 12:28=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Tue, Jul 23, 2024 at 6:01=E2=80=AFPM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > On Tue, Jul 23, 2024 at 11:26=E2=80=AFPM Eric Dumazet <edumazet@googl=
e.com> wrote:
> > > >
> > > > On Tue, Jul 23, 2024 at 5:13=E2=80=AFPM Jason Xing <kerneljasonxing=
@gmail.com> wrote:
> > > > >
> > > > > On Tue, Jul 23, 2024 at 11:09=E2=80=AFPM Jason Xing <kerneljasonx=
ing@gmail.com> wrote:
> > > > > >
> > > > > > On Tue, Jul 23, 2024 at 10:57=E2=80=AFPM Eric Dumazet <edumazet=
@google.com> wrote:
> > > > > > >
> > > > > > > On Tue, Jul 23, 2024 at 3:57=E2=80=AFPM Jason Xing <kerneljas=
onxing@gmail.com> wrote:
> > > > > > > >
> > > > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > > > >
> > > > > > > > When I was doing performance test on unix_poll(), I found o=
ut that
> > > > > > > > accessing sk->sk_ll_usec when calling sock_poll()->sk_can_b=
usy_loop()
> > > > > > > > occupies too much time, which causes around 16% degradation=
. So I
> > > > > > > > decided to turn off this config, which cannot be done appar=
ently
> > > > > > > > before this patch.
> > > > > > >
> > > > > > > Too many CONFIG_ options, distros will enable it anyway.
> > > > > > >
> > > > > > > In my builds, offset of sk_ll_usec is 0xe8.
> > > > > > >
> > > > > > > Are you using some debug options or an old tree ?
> > > > >
> > > > > I forgot to say: I'm running the latest kernel which I pulled aro=
und
> > > > > two hours ago. Whatever kind of configs with/without debug option=
s I
> > > > > use, I can still reproduce it.
> > > >
> > > > Ok, please post :
> > > >
> > > > pahole --hex -C sock vmlinux
> > >
> > > 1) Enable the config:
> > > $ pahole --hex -C sock vmlinux
> > > struct sock {
> > >         struct sock_common         __sk_common;          /*     0  0x=
88 */
> > >         /* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- *=
/
> > >         __u8
> > > __cacheline_group_begin__sock_write_rx[0]; /*  0x88     0 */
> > >         atomic_t                   sk_drops;             /*  0x88   0=
x4 */
> > >         __s32                      sk_peek_off;          /*  0x8c   0=
x4 */
> > >         struct sk_buff_head        sk_error_queue;       /*  0x90  0x=
18 */
> > >         struct sk_buff_head        sk_receive_queue;     /*  0xa8  0x=
18 */
> > >         /* --- cacheline 3 boundary (192 bytes) --- */
> > >         struct {
> > >                 atomic_t           rmem_alloc;           /*  0xc0   0=
x4 */
> > >                 int                len;                  /*  0xc4   0=
x4 */
> > >                 struct sk_buff *   head;                 /*  0xc8   0=
x8 */
> > >                 struct sk_buff *   tail;                 /*  0xd0   0=
x8 */
> > >         } sk_backlog;                                    /*  0xc0  0x=
18 */
> > >         __u8
> > > __cacheline_group_end__sock_write_rx[0]; /*  0xd8     0 */
> > >         __u8
> > > __cacheline_group_begin__sock_read_rx[0]; /*  0xd8     0 */
> > >         struct dst_entry *         sk_rx_dst;            /*  0xd8   0=
x8 */
> > >         int                        sk_rx_dst_ifindex;    /*  0xe0   0=
x4 */
> > >         u32                        sk_rx_dst_cookie;     /*  0xe4   0=
x4 */
> > >         unsigned int               sk_ll_usec;           /*  0xe8   0=
x4 */
> >
> > See here ? offset of sk_ll_usec is 0xe8, not 0x104 as you posted.
>
> Oh, so sorry. My fault. I remembered only that perf record was
> executed in an old tree before you optimise the layout of struct sock.
> Then I found out if I disable the config applying to the latest tree
> running in my virtual machine, the result is better. So let me find a
> physical server to run the latest kernel and will get back more
> accurate information of 'perf record' here.
>
> >
> > Do not blindly trust perf here.
> >
> > Please run a benchmark with 1,000,000 af_unix messages being sent and r=
eceived.
> >
> > I am guessing your patch makes no difference at all (certainly not 16
> > % as claimed in your changelog)
>
> The fact is the performance would improve when I disable the config if
> I only test unix_poll related paths. The time spent can decrease from
> 2.45 to 2.05 which is 16%. As I said, it can be easily reproduced.

To prove that accessing the sk_ll_usec field could cause performance
issue, I only remove those lines as below with CONFIG_NET_RX_BUSY_POLL
enabled:
diff --git a/net/socket.c b/net/socket.c
index fcbdd5bc47ac..74a730330a01 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1392,20 +1392,11 @@ static __poll_t sock_poll(struct file *file,
poll_table *wait)
 {
        struct socket *sock =3D file->private_data;
        const struct proto_ops *ops =3D READ_ONCE(sock->ops);
-       __poll_t events =3D poll_requested_events(wait), flag =3D 0;
+       __poll_t flag =3D 0;

        if (!ops->poll)
                return 0;

-       if (sk_can_busy_loop(sock->sk)) {
-               /* poll once if requested by the syscall */
-               if (events & POLL_BUSY_LOOP)
-                       sk_busy_loop(sock->sk, 1);
-
-               /* if this socket can poll_ll, tell the system call */
-               flag =3D POLL_BUSY_LOOP;
-       }
-
        return ops->poll(file, sock, wait) | flag;
 }

The result of time could decrease to ~2.1.

>
> Thanks,
> Jason


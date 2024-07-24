Return-Path: <netdev+bounces-112723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7060393AD2D
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 09:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66D591C20E55
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 07:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E64061FDA;
	Wed, 24 Jul 2024 07:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fta2LNRs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4DE210FB
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 07:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721806440; cv=none; b=M1yUJClvdsUoAboUgH+iHefOPImSKCl4WaEhKv5C5lf5uf5x55xB/AIwOQsED93ZWvk0LXwcof3M47p5NtnpPmb9ChPGLLRDLwC24AMD3tt+uHMmdlG+VSJZU2ysuqWZkJt/dV5pZKn/ssYli16SA+HxLAPsTJANVVDAtrsnVA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721806440; c=relaxed/simple;
	bh=f/D8VGMKr44ggMnXzUEbB6qHyfQmQ+JPc49ikJUi1ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rhFdbVOrUuPLjDRl/krSgf/y6dz7X2/WR2gVpwHDfcENF6jtBzdeerkfPcYDOXoMChWgwAGECD5SlKBYmaxUSTE0oLVTlKMUPbd0SrGhvrVLSiMA7GAf1pXYamk4Mc/4iWGdaGphtS2XND8A8KnMzKM7zTxgbf86JPsCkdGb16Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fta2LNRs; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-58f9874aeb4so5330803a12.0
        for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 00:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721806437; x=1722411237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLcXJWqM51YlOGxKQmV1hIrMWVZKdDIjA1ycwgxFHqo=;
        b=fta2LNRs40hoL6tp/+0z8oBeuMpdbmHShIEVlIUpUYbTVlf5vFjgMlkz524eISyNNS
         /j4JBNfA3vE1I5rhs33R5BA8JMlgDtGxtgp7kuYjzCFCsIDdqRFQrZnhbzo7gvZ5Qatf
         pz4lxH0MB0NpraNRfqiEgFRMU0ug5UMH8JTrvKVDt79QlnIxBgoqwTHzjA8j+MSLmbz4
         WCQ0O+RPYIcQp+3wBVsnoJUeeRVWwfODIuDdLrUI8veZ+rN4UqnkUUqp9vz8HFfOqKfd
         xnCsog9iAroGTZ2b4FjMTUcQKH24Nvvnfz9fcy+oS3BH7aKKF93ANZe4BcP1MnXGti9q
         I6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721806437; x=1722411237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLcXJWqM51YlOGxKQmV1hIrMWVZKdDIjA1ycwgxFHqo=;
        b=Hm+Z34JVTu39oi40Sj91T4pGeOoAPg2AQwed3PPaFBbxs98UmhkA/pg8f43rDkRtOV
         ummdAMzicNK7bE6DwduQ5Of8qgpmsNUTa1gQdFOPh4nYLI8ZhC3Zp9QKbu71OC3wmvMi
         yr0vOQfjwgfgWxBDbbEO62BOhDxWD872SMmu6KtXqrH7/5L0g8u+SIaqjaHUqJ6Yb1Ir
         Azu9nrxss7HkOESCA7aPEDx26HzvfkDH8AM9YrC0fKI2gZi1rksVJ1S4nul2qKXRr2yk
         tItAiZazYSxZkJGW7lr6vjtOr9KFH4+6JUzeV0pQIMq5+TOLdmEQir2nv9bT4cBM0jYE
         Q1fg==
X-Forwarded-Encrypted: i=1; AJvYcCWnFPYnRzKleqs+ABqqH++RGbYYCu4jn8FYYsAwu8tCciWV5T8uwsUg43hUDTrLb9jv1qEUCzuRzAI06wUk6XblZnKcSrFf
X-Gm-Message-State: AOJu0YwWj2gA62LNVX6EMOd+lkU4B/DMCgVbmyc9t3SviF9Q3y0e/vti
	X4oT/FIzRbD21rIESbWbocN6/3BhM5v1vkJwB5HliMQbKmqaY+G3TbiZZeOslIX8Y/WyoxfBWER
	vjl5ewO1kuoO6+JDunk/0FS4wKuQ=
X-Google-Smtp-Source: AGHT+IGQGG+89I9kJ+DtqpHwojwtMBdw+GWXiOmjSLyVOvXroimITJfkkpYyCMedSSvLoJMTovTWUEU+0vsQhWPaMMw=
X-Received: by 2002:a50:8749:0:b0:5a1:c40a:3a81 with SMTP id
 4fb4d7f45d1cf-5a4f0c7724bmr6371685a12.35.1721806436586; Wed, 24 Jul 2024
 00:33:56 -0700 (PDT)
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
Date: Wed, 24 Jul 2024 15:33:18 +0800
Message-ID: <CAL+tcoBXBmSevsfNpERwewgvVmCmabJuhXhi_Hi7ADZ=OLG5Kw@mail.gmail.com>
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

Now I'm back. The same output of perf when running the latest kernel
on the virtual server goes like this:
       =E2=94=82
       =E2=94=82    static inline bool sk_can_busy_loop(const struct sock *=
sk)
       =E2=94=82    {
       =E2=94=82    return READ_ONCE(sk->sk_ll_usec) && !signal_pending(cur=
rent);
       =E2=94=82      mov     0xe8(%rdx),%ebp
 55.71 =E2=94=82      test    %ebp,%ebp
       =E2=94=82    =E2=86=93 jne     62
       =E2=94=82    sock_poll():
command I used: perf record -g -e cycles:k -F 999 -o tk5_select10.data
-- ./bin-x86_64/select -E -C 200 -L -S -W -M -N "select_10" -n 100 -B
500

If it's running on the physical server, the perf output is like this:
       =E2=94=82     =E2=86=93 je     e1
       =E2=94=82       mov    0x18(%r13),%rdx
  0.03 =E2=94=82       mov    %rsi,%rbx
  0.00 =E2=94=82       mov    %rdi,%r12
       =E2=94=82       mov    0xe8(%rdx),%r14d
 26.48 =E2=94=82       test   %r14d,%r14d

What a interesting thing I found is that running on the physical
server the delta output is better than on the virtual server:
    original kernel, remove access of sk_ll_usec
physical: 2.26, 2.08 (delta is 8.4%)
virtual: 2.45, 2.05 (delta is ~16%)

I'm still confused about reading this sk_ll_usec can cause such a
performance degradation situation.

Eric, may I ask if you have more ideas/suggestions about this one?

Thanks,
Jason

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
>
> Thanks,
> Jason


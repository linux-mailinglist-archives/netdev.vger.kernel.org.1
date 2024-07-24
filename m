Return-Path: <netdev+bounces-112735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F173D93AE3F
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 11:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FBF41F244B3
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 09:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364ED13AD33;
	Wed, 24 Jul 2024 09:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDGqsKQ5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541FE1C6B4
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 09:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721811758; cv=none; b=VXYMoDS9VEC2NjNrPNmPYogKSx52p/EbHagjT9q8DLFGNJ1ydxNkc5sTDIP138QgKm2Js3JmchlZ+8e0StwsxXHKR25naxlhjJczqDkRyWYodFs88y+FYAHbxFSR3Moi66ZjvQrKbeNBOVPFAw7iEyj/feesfUgr8MnuiCa43v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721811758; c=relaxed/simple;
	bh=/k9i9DssdMmRoiVQfJTUfJBOb8sFaszlS9W8y5Ow1zY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gOKYnLmMBmeCAzH90y8TJDTXjz7xAUpcYBffxNsuIlYhJGzVWPpnGwTW1lv+gXRlTQ7Ymk468LLdsR2DHz6RZDDNW79YLacvnDWvJn7LmP9hGDZtAQJmg1IoZLODfBYIGjjVNTaWpnGF704YHXcTKMjUacpVe0u6xI63MqZQiuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDGqsKQ5; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52f01afa11cso5136079e87.0
        for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 02:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721811754; x=1722416554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pU5Uz8+wHkFvgZD2kBn5blv5MD9b/vbr6Ll9UxxBlHM=;
        b=kDGqsKQ5QNIwHuA30LZKTOnupRtcmV66rMNklJ7fXay6RmZ2FecQVWD+9WXfeMHUPu
         jRx4TkXOUO6PVWIjJpPnbhCSwhLpU/F49myh/Wh0NyCBCpjpkQnccJ7dgNrz09YgPxqm
         uQ3xuKQJNo4O1kr6I8GL8Qk4VHvh8Qi6MiN96p2myLeBGpKxVUKjLvD+d4yMwVeWNzXO
         HUPBzcLRdzbVrXkw8sCxsle2osHPmMLYT3nnngD+yXBbRenDA4O6dkLwO1YqjIHlZaBw
         FzNrJmhJ+xsBwm9sG5gCX8ujm+RFhXl8SOoVXRRgo3Fm3mZ7tAwfO7uQtcJXSqWrMwdl
         rn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721811754; x=1722416554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pU5Uz8+wHkFvgZD2kBn5blv5MD9b/vbr6Ll9UxxBlHM=;
        b=GJrKu5o5+8dgiiDBhHcnbAAabTrYLnidS4O9Gd/QKmpSr1Ih/d31yG6/ecKvqWWYr7
         29tdqO0UWosmM6yPUw7v3xsMrEm38+MXUOmrMVLe+DbwadtJf7hiQkpMbOT+PF5sDVAp
         Dhk22iTohvLPTipz8n5LAkd5R8qfb9E8Nv9cLOjQijdTLMzDzcjOHSXK2DsQ6DS4UhL1
         C/53H5ybpIeYBSvwqrLRMPtmn8Thh5J5bgi8QjTuTRldD/K8ZKxHdJ52Umw+7/b/nFpV
         sav2MDCfTGEGFbJpfMouRpnPYjDqoV/Xs4Q7QM1M7OK1WJtOuaTJX2TlBfyceJqSkuVA
         htJw==
X-Forwarded-Encrypted: i=1; AJvYcCX7RPVs6IDeZbkuNKmJGQVVGlKX0X0vF5I2CE53PT6h6zC5nekpZBbZo53u629kghldlOH00w3fDAS5t1oV3kAFUnRezYCI
X-Gm-Message-State: AOJu0Yyi5yJJroqqncHKrOuYkBW1hWpq1G2SeUft9vrrL1UKds3GGt92
	R85Ez5PqKsPLCMBAbCgKOdCUkm1S3amFr2Gg4mGpCyBRF12CXO4UVz8pNma3C1MNj4iUt5mJkdE
	uwVEIowRLEf1vXJ6KJGeNoTFWQuHmLE/J
X-Google-Smtp-Source: AGHT+IGYGvPjexKIMJN8v6zR8GV5mDiHGSYSwTPCntSv1jBzbofbRTE105JYw0P7Qo0xe1F7Wm83DhekahMV+rn4cXg=
X-Received: by 2002:a05:6512:4011:b0:52e:a68a:6076 with SMTP id
 2adb3069b0e04-52fcf13a17fmr968904e87.49.1721811753866; Wed, 24 Jul 2024
 02:02:33 -0700 (PDT)
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
 <CANn89iLDQFbxrcYOvMq+eXkxuArgfnS+uG33dJZmhOGg+xWucQ@mail.gmail.com>
 <CAL+tcoBGRz1ukKe=z2qjPUgjSZ=a-WdXLpTcLj5BxTVNAhnUZg@mail.gmail.com>
 <CAL+tcoBXBmSevsfNpERwewgvVmCmabJuhXhi_Hi7ADZ=OLG5Kw@mail.gmail.com> <CANn89iLPYPPHCSLiXmwP9G+Gfa8J=w3aD-HtPVzhjDeQvO_Z9g@mail.gmail.com>
In-Reply-To: <CANn89iLPYPPHCSLiXmwP9G+Gfa8J=w3aD-HtPVzhjDeQvO_Z9g@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 24 Jul 2024 17:01:56 +0800
Message-ID: <CAL+tcoB=c2wbUQV67-qSAZ1R34DOrQasqsudBi9dz_TOt1MutQ@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] net: add an entry for CONFIG_NET_RX_BUSY_POLL
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 4:54=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Jul 24, 2024 at 9:33=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > On Wed, Jul 24, 2024 at 8:38=E2=80=AFAM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > On Wed, Jul 24, 2024 at 12:28=E2=80=AFAM Eric Dumazet <edumazet@googl=
e.com> wrote:
> > > >
> > > > On Tue, Jul 23, 2024 at 6:01=E2=80=AFPM Jason Xing <kerneljasonxing=
@gmail.com> wrote:
> > > > >
> > > > > On Tue, Jul 23, 2024 at 11:26=E2=80=AFPM Eric Dumazet <edumazet@g=
oogle.com> wrote:
> > > > > >
> > > > > > On Tue, Jul 23, 2024 at 5:13=E2=80=AFPM Jason Xing <kerneljason=
xing@gmail.com> wrote:
> > > > > > >
> > > > > > > On Tue, Jul 23, 2024 at 11:09=E2=80=AFPM Jason Xing <kernelja=
sonxing@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, Jul 23, 2024 at 10:57=E2=80=AFPM Eric Dumazet <edum=
azet@google.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Jul 23, 2024 at 3:57=E2=80=AFPM Jason Xing <kerne=
ljasonxing@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > > > > > >
> > > > > > > > > > When I was doing performance test on unix_poll(), I fou=
nd out that
> > > > > > > > > > accessing sk->sk_ll_usec when calling sock_poll()->sk_c=
an_busy_loop()
> > > > > > > > > > occupies too much time, which causes around 16% degrada=
tion. So I
> > > > > > > > > > decided to turn off this config, which cannot be done a=
pparently
> > > > > > > > > > before this patch.
> > > > > > > > >
> > > > > > > > > Too many CONFIG_ options, distros will enable it anyway.
> > > > > > > > >
> > > > > > > > > In my builds, offset of sk_ll_usec is 0xe8.
> > > > > > > > >
> > > > > > > > > Are you using some debug options or an old tree ?
> > > > > > >
> > > > > > > I forgot to say: I'm running the latest kernel which I pulled=
 around
> > > > > > > two hours ago. Whatever kind of configs with/without debug op=
tions I
> > > > > > > use, I can still reproduce it.
> > > > > >
> > > > > > Ok, please post :
> > > > > >
> > > > > > pahole --hex -C sock vmlinux
> > > > >
> > > > > 1) Enable the config:
> > > > > $ pahole --hex -C sock vmlinux
> > > > > struct sock {
> > > > >         struct sock_common         __sk_common;          /*     0=
  0x88 */
> > > > >         /* --- cacheline 2 boundary (128 bytes) was 8 bytes ago -=
-- */
> > > > >         __u8
> > > > > __cacheline_group_begin__sock_write_rx[0]; /*  0x88     0 */
> > > > >         atomic_t                   sk_drops;             /*  0x88=
   0x4 */
> > > > >         __s32                      sk_peek_off;          /*  0x8c=
   0x4 */
> > > > >         struct sk_buff_head        sk_error_queue;       /*  0x90=
  0x18 */
> > > > >         struct sk_buff_head        sk_receive_queue;     /*  0xa8=
  0x18 */
> > > > >         /* --- cacheline 3 boundary (192 bytes) --- */
> > > > >         struct {
> > > > >                 atomic_t           rmem_alloc;           /*  0xc0=
   0x4 */
> > > > >                 int                len;                  /*  0xc4=
   0x4 */
> > > > >                 struct sk_buff *   head;                 /*  0xc8=
   0x8 */
> > > > >                 struct sk_buff *   tail;                 /*  0xd0=
   0x8 */
> > > > >         } sk_backlog;                                    /*  0xc0=
  0x18 */
> > > > >         __u8
> > > > > __cacheline_group_end__sock_write_rx[0]; /*  0xd8     0 */
> > > > >         __u8
> > > > > __cacheline_group_begin__sock_read_rx[0]; /*  0xd8     0 */
> > > > >         struct dst_entry *         sk_rx_dst;            /*  0xd8=
   0x8 */
> > > > >         int                        sk_rx_dst_ifindex;    /*  0xe0=
   0x4 */
> > > > >         u32                        sk_rx_dst_cookie;     /*  0xe4=
   0x4 */
> > > > >         unsigned int               sk_ll_usec;           /*  0xe8=
   0x4 */
> > > >
> > > > See here ? offset of sk_ll_usec is 0xe8, not 0x104 as you posted.
> > >
> > > Oh, so sorry. My fault. I remembered only that perf record was
> > > executed in an old tree before you optimise the layout of struct sock=
.
> > > Then I found out if I disable the config applying to the latest tree
> > > running in my virtual machine, the result is better. So let me find a
> > > physical server to run the latest kernel and will get back more
> > > accurate information of 'perf record' here.
> >
> > Now I'm back. The same output of perf when running the latest kernel
> > on the virtual server goes like this:
> >        =E2=94=82
> >        =E2=94=82    static inline bool sk_can_busy_loop(const struct so=
ck *sk)
> >        =E2=94=82    {
> >        =E2=94=82    return READ_ONCE(sk->sk_ll_usec) && !signal_pending=
(current);
> >        =E2=94=82      mov     0xe8(%rdx),%ebp
> >  55.71 =E2=94=82      test    %ebp,%ebp
> >        =E2=94=82    =E2=86=93 jne     62
> >        =E2=94=82    sock_poll():
> > command I used: perf record -g -e cycles:k -F 999 -o tk5_select10.data
> > -- ./bin-x86_64/select -E -C 200 -L -S -W -M -N "select_10" -n 100 -B
> > 500
> >
> > If it's running on the physical server, the perf output is like this:
> >        =E2=94=82     =E2=86=93 je     e1
> >        =E2=94=82       mov    0x18(%r13),%rdx
> >   0.03 =E2=94=82       mov    %rsi,%rbx
> >   0.00 =E2=94=82       mov    %rdi,%r12
> >        =E2=94=82       mov    0xe8(%rdx),%r14d
> >  26.48 =E2=94=82       test   %r14d,%r14d
> >
> > What a interesting thing I found is that running on the physical
> > server the delta output is better than on the virtual server:
> >     original kernel, remove access of sk_ll_usec
> > physical: 2.26, 2.08 (delta is 8.4%)
> > virtual: 2.45, 2.05 (delta is ~16%)
> >
> > I'm still confused about reading this sk_ll_usec can cause such a
> > performance degradation situation.
> >
> > Eric, may I ask if you have more ideas/suggestions about this one?
> >
>
> We do not micro-optimize based on 'perf' reports, because of artifacts.

Sure, I know this. The reason why I use perf to observe is that I
found performance degradation between 5.x and the latest kernel. Then
I started to look into the sock_poll() and unix_poll(). It turns out
that some accesses of members can consume more time than expected.

>
> Please run a full workload, sending/receiving 1,000,000 messages and repo=
rt
> the time difference, not on a precise function but the whole workload.

Okay.

>
> Again, I am guessing there will be no difference, because the cache
> line is needed anyway.

To conclude from the theory of the layout, I agree that I cannot see
any better method to improve.

>
> Please make sure to run the latest kernels, this will avoid you
> discovering issues that have been already fixed.

Sure, I did it based on the latest kernel as my previous emails said.
Without accessing sk_ll_usec, the performance is better.

Anyway, thanks so much for your help!

Thanks,
Jason


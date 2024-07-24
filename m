Return-Path: <netdev+bounces-112733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1052B93AE20
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 10:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33DB61C21DBF
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 08:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E6A14B977;
	Wed, 24 Jul 2024 08:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BMHcRHoq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEAE1CAA1
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 08:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721811266; cv=none; b=BV1GSLWyXLpZPkPVDz67FXYcwpUoBfkzEyjzNSFQM30gxkNGsLsnODbGxYTUu4PZDkwDlVv1uQt0VBVC3z6w4cCJ9eGrVSOLGxAOiE0aNMiftu5jcHS8YehDgp+Tl2AH8MZt+C9N2bW+HQTOYQpjxa5rEwTQpHtmL1mjhyo+vQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721811266; c=relaxed/simple;
	bh=zFL49NRlwd8kX/UMqyAoZLf3OKHAw6fYJ4jADA/VWGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKDYNXP5TYFZQ6G/C+2ybgc/lZ03Ixr+dtShQ5D3Bn4Jdh9mCY4Uj9usDQVmc4h+biDuunxwMxo1qfXZlfe1ae/+N2YLvutFS4vjraq2hYIVm6/TxHq5UAMnQpnpIhPetNk+oBUY/fWyFGibG9KBeWkOMwhruVd1hb0vVekScf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BMHcRHoq; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so10531a12.1
        for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 01:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721811263; x=1722416063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHusJ15Ue7yCENcgW24ixCBHzifrLqREEYbPQeAjwtw=;
        b=BMHcRHoqlKHGNB+CryJ10cvBDdqB+/FzzIK6vzVQ4Mnr0jFHroJiUOEPzEOAbYfved
         I+lXmxNXAEzhrEo7yFG8Az5Zm8k2GZ2P5mxYIGS3T79+0LhHDpy4Ch1xGs+KvfmFDvkG
         a2t3+OGdHOTNSdp3q4oS8oWGF/lqBsBPPDXxCvYGKwczciKW1P9zKo7MHZjqybYeJZ6N
         vDcwUxXEL4jS6gOqe/YYI59nPRCAYWAUdbHTADhGOGUb1MrhOjHL1woNCQ+1is1P4TTd
         OX7jeYvNbJY/1hA+OAg1QwE+CllSnK324uZxRmB7nsWr5gE/eNpPFjUycmMBovQY60Bs
         i6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721811263; x=1722416063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHusJ15Ue7yCENcgW24ixCBHzifrLqREEYbPQeAjwtw=;
        b=EjWMfeLME6Z/mSh5KZ0Qf5+uzr6PEzJu9VVTHBbFsdP0fAGUKH09p9irb/0NlbDB3v
         3jAlKst7LQkf8swLirBIdvkkTf75tVHTty1QhS5DsAWBWUUKOnJ9P+x5BUgePzH0G8Wz
         zsMIFaxFR7e769n+CIioA6GcWy2fcrDwm+QGB2oVhtGBSlyHDtuIJ2wvORbtahbvOofh
         bKwDnZgz+qJgDm+Nx0vZJfc5MJ5AzFIwHDz/BrXc7/Bn9kvpwDzje8bsm9axezHEkzcY
         ndtlTcFC3SI2j/rUqTfaNFAw10M87Xq/0d7rfECJeyhbuxWyNBCpP3Z+EHCkwCMlspzq
         YPYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEqAPuPIxAKLjgl6fk4mEXJj1hzCOV5QtIFzIHPYGlIAx1tC1OHzRaWkVnpv4mAahOtTIwH1pOJROWlN44aRrtrJIWktjR
X-Gm-Message-State: AOJu0Yy/1r0OaLdCW1TggKBsmbI9G03hiI5LbeLF+Yr4L2iZJasOu8PP
	L4D9wPW1XQwHNSfnhkjWzzrPEPg256xMPlhEXZ0hOwNa2+ZgdEDYgNebsfgnCigjRXnH1w/Riee
	FqlI/EAJW7DIKVpXciRtKzoMZ5bF6dzcj8xXh
X-Google-Smtp-Source: AGHT+IGbJ1Fe5yXu6vvTbtWouIHsQKKtH17O34a+OsCZykVa4oGkBdCfB5yOITedB1d+mqkI6TQmPGIPhF83GFMVVOM=
X-Received: by 2002:a05:6402:26ce:b0:59f:9f59:9b07 with SMTP id
 4fb4d7f45d1cf-5aacb8e1b52mr230540a12.4.1721811262537; Wed, 24 Jul 2024
 01:54:22 -0700 (PDT)
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
 <CAL+tcoBGRz1ukKe=z2qjPUgjSZ=a-WdXLpTcLj5BxTVNAhnUZg@mail.gmail.com> <CAL+tcoBXBmSevsfNpERwewgvVmCmabJuhXhi_Hi7ADZ=OLG5Kw@mail.gmail.com>
In-Reply-To: <CAL+tcoBXBmSevsfNpERwewgvVmCmabJuhXhi_Hi7ADZ=OLG5Kw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 24 Jul 2024 10:54:08 +0200
Message-ID: <CANn89iLPYPPHCSLiXmwP9G+Gfa8J=w3aD-HtPVzhjDeQvO_Z9g@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] net: add an entry for CONFIG_NET_RX_BUSY_POLL
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 9:33=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Wed, Jul 24, 2024 at 8:38=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > On Wed, Jul 24, 2024 at 12:28=E2=80=AFAM Eric Dumazet <edumazet@google.=
com> wrote:
> > >
> > > On Tue, Jul 23, 2024 at 6:01=E2=80=AFPM Jason Xing <kerneljasonxing@g=
mail.com> wrote:
> > > >
> > > > On Tue, Jul 23, 2024 at 11:26=E2=80=AFPM Eric Dumazet <edumazet@goo=
gle.com> wrote:
> > > > >
> > > > > On Tue, Jul 23, 2024 at 5:13=E2=80=AFPM Jason Xing <kerneljasonxi=
ng@gmail.com> wrote:
> > > > > >
> > > > > > On Tue, Jul 23, 2024 at 11:09=E2=80=AFPM Jason Xing <kerneljaso=
nxing@gmail.com> wrote:
> > > > > > >
> > > > > > > On Tue, Jul 23, 2024 at 10:57=E2=80=AFPM Eric Dumazet <edumaz=
et@google.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, Jul 23, 2024 at 3:57=E2=80=AFPM Jason Xing <kernelj=
asonxing@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > > > > >
> > > > > > > > > When I was doing performance test on unix_poll(), I found=
 out that
> > > > > > > > > accessing sk->sk_ll_usec when calling sock_poll()->sk_can=
_busy_loop()
> > > > > > > > > occupies too much time, which causes around 16% degradati=
on. So I
> > > > > > > > > decided to turn off this config, which cannot be done app=
arently
> > > > > > > > > before this patch.
> > > > > > > >
> > > > > > > > Too many CONFIG_ options, distros will enable it anyway.
> > > > > > > >
> > > > > > > > In my builds, offset of sk_ll_usec is 0xe8.
> > > > > > > >
> > > > > > > > Are you using some debug options or an old tree ?
> > > > > >
> > > > > > I forgot to say: I'm running the latest kernel which I pulled a=
round
> > > > > > two hours ago. Whatever kind of configs with/without debug opti=
ons I
> > > > > > use, I can still reproduce it.
> > > > >
> > > > > Ok, please post :
> > > > >
> > > > > pahole --hex -C sock vmlinux
> > > >
> > > > 1) Enable the config:
> > > > $ pahole --hex -C sock vmlinux
> > > > struct sock {
> > > >         struct sock_common         __sk_common;          /*     0  =
0x88 */
> > > >         /* --- cacheline 2 boundary (128 bytes) was 8 bytes ago ---=
 */
> > > >         __u8
> > > > __cacheline_group_begin__sock_write_rx[0]; /*  0x88     0 */
> > > >         atomic_t                   sk_drops;             /*  0x88  =
 0x4 */
> > > >         __s32                      sk_peek_off;          /*  0x8c  =
 0x4 */
> > > >         struct sk_buff_head        sk_error_queue;       /*  0x90  =
0x18 */
> > > >         struct sk_buff_head        sk_receive_queue;     /*  0xa8  =
0x18 */
> > > >         /* --- cacheline 3 boundary (192 bytes) --- */
> > > >         struct {
> > > >                 atomic_t           rmem_alloc;           /*  0xc0  =
 0x4 */
> > > >                 int                len;                  /*  0xc4  =
 0x4 */
> > > >                 struct sk_buff *   head;                 /*  0xc8  =
 0x8 */
> > > >                 struct sk_buff *   tail;                 /*  0xd0  =
 0x8 */
> > > >         } sk_backlog;                                    /*  0xc0  =
0x18 */
> > > >         __u8
> > > > __cacheline_group_end__sock_write_rx[0]; /*  0xd8     0 */
> > > >         __u8
> > > > __cacheline_group_begin__sock_read_rx[0]; /*  0xd8     0 */
> > > >         struct dst_entry *         sk_rx_dst;            /*  0xd8  =
 0x8 */
> > > >         int                        sk_rx_dst_ifindex;    /*  0xe0  =
 0x4 */
> > > >         u32                        sk_rx_dst_cookie;     /*  0xe4  =
 0x4 */
> > > >         unsigned int               sk_ll_usec;           /*  0xe8  =
 0x4 */
> > >
> > > See here ? offset of sk_ll_usec is 0xe8, not 0x104 as you posted.
> >
> > Oh, so sorry. My fault. I remembered only that perf record was
> > executed in an old tree before you optimise the layout of struct sock.
> > Then I found out if I disable the config applying to the latest tree
> > running in my virtual machine, the result is better. So let me find a
> > physical server to run the latest kernel and will get back more
> > accurate information of 'perf record' here.
>
> Now I'm back. The same output of perf when running the latest kernel
> on the virtual server goes like this:
>        =E2=94=82
>        =E2=94=82    static inline bool sk_can_busy_loop(const struct sock=
 *sk)
>        =E2=94=82    {
>        =E2=94=82    return READ_ONCE(sk->sk_ll_usec) && !signal_pending(c=
urrent);
>        =E2=94=82      mov     0xe8(%rdx),%ebp
>  55.71 =E2=94=82      test    %ebp,%ebp
>        =E2=94=82    =E2=86=93 jne     62
>        =E2=94=82    sock_poll():
> command I used: perf record -g -e cycles:k -F 999 -o tk5_select10.data
> -- ./bin-x86_64/select -E -C 200 -L -S -W -M -N "select_10" -n 100 -B
> 500
>
> If it's running on the physical server, the perf output is like this:
>        =E2=94=82     =E2=86=93 je     e1
>        =E2=94=82       mov    0x18(%r13),%rdx
>   0.03 =E2=94=82       mov    %rsi,%rbx
>   0.00 =E2=94=82       mov    %rdi,%r12
>        =E2=94=82       mov    0xe8(%rdx),%r14d
>  26.48 =E2=94=82       test   %r14d,%r14d
>
> What a interesting thing I found is that running on the physical
> server the delta output is better than on the virtual server:
>     original kernel, remove access of sk_ll_usec
> physical: 2.26, 2.08 (delta is 8.4%)
> virtual: 2.45, 2.05 (delta is ~16%)
>
> I'm still confused about reading this sk_ll_usec can cause such a
> performance degradation situation.
>
> Eric, may I ask if you have more ideas/suggestions about this one?
>

We do not micro-optimize based on 'perf' reports, because of artifacts.

Please run a full workload, sending/receiving 1,000,000 messages and report
the time difference, not on a precise function but the whole workload.

Again, I am guessing there will be no difference, because the cache
line is needed anyway.

Please make sure to run the latest kernels, this will avoid you
discovering issues that have been already fixed.


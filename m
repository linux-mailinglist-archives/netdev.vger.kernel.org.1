Return-Path: <netdev+bounces-168331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD13AA3E928
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 01:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2DF919C1A24
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 00:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACE35CB8;
	Fri, 21 Feb 2025 00:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7B/ch/S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D96718EAB;
	Fri, 21 Feb 2025 00:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740097613; cv=none; b=L6mGf+ZHBQCt6PUy1Ef9OKidtOvS5zWOcWD+3nSriulCkKOhwmrzi8LJUNwIImDqhiSQYA7Z/sOLHj69SCNgZBrNXotEoCz8pIRnakH+QzoLYszY8uNwKOexUfKgyPTAjfhqtmDq1ccdcgLBUAlUKLrh5VuQplFVQYY5BHJyiD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740097613; c=relaxed/simple;
	bh=I2pO7Wft5pvESP3onPEFemXdrwWNRpRIxMt7iA1vHvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a9nEXLOkcTMCGv6A8lCtuCeHMXzL1N+0pd9ZHVFjyEirgHPR3K8/+BuqJyGcuk5WpG/E85ma27QaqFb1+y6wUO6Ihv18/IXmZtq0MddNsyG/SGbhhe5VmuUErHY1k3k9zPYgRJM1bRps67XhrWeAOqG4rpNYITBwco5uDpxXEqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7B/ch/S; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-855a8275758so43311139f.3;
        Thu, 20 Feb 2025 16:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740097610; x=1740702410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgF/YRDp6wf7Cg+RtAfP4L1t13pt2UAJwFrfEBCFLto=;
        b=b7B/ch/Sq9WhYIFDvEaGHqKhIGdmx4RM7UKTyKHneW7FgId6Ygl0R6CioKPUX1F8ox
         6I73KwDxwoupgAh81ADvlMeg5JzHXJnBcuetiM8IZspyD/zxL+uxNwAA0uszkByvaybz
         WWRnUCeJL5D9Z/O9mbXh4W/9ffiqd/j7L6xr3cLC0cN0zFpJ36X2QwAhAARdNCD2p4/x
         X6eLrdD/EH7fk88aFSj7ygG7/YoG2f/Vpf5EEffKlpgG3Z6wcICVBqLpfJba9X4MyjL4
         YtpQQWu6IFNvAHb5e+4LhQs8+g+iE0Y1xJOincjFP4upgeJ0+QqxB6PeVyWMGR+Yr9b4
         e+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740097610; x=1740702410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgF/YRDp6wf7Cg+RtAfP4L1t13pt2UAJwFrfEBCFLto=;
        b=BK2ciZrGPI2VTePhmcXmI4QnwlPwQbTZdz0GiKmdeDiqJy4e5r5+Ipr4jRMR2+4Csp
         V5t/cjWyxZJ1E+g9/KFm2qu9c4swLg/Gi8nuXZRXvoP3mKLUkXCBHS10aUM8b5wc9Cq2
         qJ9SbHhlh3zxHKAMJcCnjEBRACwz6DZFP58ZmzL74gQoJPh30DTQMM7EcI0OwKg/78x9
         yffGSBNRTgxol20HDfE0AIYNloQ1JqzE6hgb6cV0qY4UWew1LjyQ1qfR4G9MKVEXPQiV
         coD+Ue5wIwNvdyXWVKguS1XcZSSgvUR1othyQZbEZRzssbtJ2tT3vSiEPb1lkq2DXGFb
         beCg==
X-Forwarded-Encrypted: i=1; AJvYcCV90mhBEkUabfGLl4RKW2k4bcjVXMIZYb0oOcUZCSkyvzeO0fM1httuMqjhSuuC2RHY4Yb6rXQf@vger.kernel.org, AJvYcCWaiWt2yYQAaToEkRBwzlQXCps3SxXMuib6pjCAa5TuEdECl92t486LadbKnwTzNtTCoogTzvRHE6VcIYoZ09c=@vger.kernel.org
X-Gm-Message-State: AOJu0YywVfBhyM2BcAkRlc2htztCVZ5CLekVBRcA6j/CXUpDeprqCmwI
	7ZSRkbJMLCtCYQb2TjF45PvLEhESunD/YJFHFWFA2TNEHiKrWQsy852/8vnJj7UFKzoEK8fHVMx
	MUywzkOElWcCjtSrpdUVUO8PTnAU=
X-Gm-Gg: ASbGnctqeSJYghIARzfmpt7Hw7Kx3UdyuHoVIdjx9ey4r3oJuWvosEpRgfs+p5P4emI
	eff+kMe61d0CV+CN27CUHl89JRG/GFvODxQIhJ8DfBRzPRqG9QlQ5P5qtk9qnbB+dWtYiQQM=
X-Google-Smtp-Source: AGHT+IH4D1q3UFeVWtaN2R6x1spI8QRIwqW+I9MgD7CKBpIuB8NO/1V3y1mvWUH7JAiPyJtGpem8T39U0fONBZaJmQM=
X-Received: by 2002:a05:6e02:1908:b0:3d0:21aa:a752 with SMTP id
 e9e14a558f8ab-3d2cae47e92mr13314065ab.2.1740097610446; Thu, 20 Feb 2025
 16:26:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739988644.git.pav@iki.fi> <b278a4f39101282e2d920fed482b914d23ffaac3.1739988644.git.pav@iki.fi>
 <CAL+tcoBxtxCT1R8pPFF2NvDv=1PKris1Gzg-acfKHN9qHr7RFA@mail.gmail.com>
 <67b694f08332c_20efb029434@willemb.c.googlers.com.notmuch>
 <CAL+tcoDJAYDce6Ud49q1+srq-wJ=04JxMm1w-Yzcdd1FGE3U7g@mail.gmail.com>
 <67b74c47c14c7_261ab62943@willemb.c.googlers.com.notmuch> <67b7b88c60ea0_292289294bb@willemb.c.googlers.com.notmuch>
In-Reply-To: <67b7b88c60ea0_292289294bb@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 21 Feb 2025 08:26:14 +0800
X-Gm-Features: AWEUYZl9k5Vlk7K9nAMc68CLLK_QjgUWZKUtHyfHS_2iX1EuTuSLqxiNyytUcxc
Message-ID: <CAL+tcoAD4t3f2vMquxwSNVzpRfyHWvG9NYfkjTWZZfd7oHCSGw@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] net-timestamp: COMPLETION timestamp on packet tx completion
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Pauli Virtanen <pav@iki.fi>, linux-bluetooth@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, gerhard@engleder-embedded.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 7:19=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Willem de Bruijn wrote:
> > Jason Xing wrote:
> > > On Thu, Feb 20, 2025 at 10:35=E2=80=AFAM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Jason Xing wrote:
> > > > > On Thu, Feb 20, 2025 at 2:15=E2=80=AFAM Pauli Virtanen <pav@iki.f=
i> wrote:
> > > > > >
> > > > > > Add SOF_TIMESTAMPING_TX_COMPLETION, for requesting a software t=
imestamp
> > > > > > when hardware reports a packet completed.
> > > > > >
> > > > > > Completion tstamp is useful for Bluetooth, as hardware timestam=
ps do not
> > > > > > exist in the HCI specification except for ISO packets, and the =
hardware
> > > > > > has a queue where packets may wait.  In this case the software =
SND
> > > > > > timestamp only reflects the kernel-side part of the total laten=
cy
> > > > > > (usually small) and queue length (usually 0 unless HW buffers
> > > > > > congested), whereas the completion report time is more informat=
ive of
> > > > > > the true latency.
> > > > > >
> > > > > > It may also be useful in other cases where HW TX timestamps can=
not be
> > > > > > obtained and user wants to estimate an upper bound to when the =
TX
> > > > > > probably happened.
> > > > > >
> > > > > > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > > > > > ---
> > > > > >
> > > > > > Notes:
> > > > > >     v4: changed SOF_TIMESTAMPING_TX_COMPLETION to only emit COM=
PLETION
> > > > > >         together with SND, to save a bit in skb_shared_info.tx_=
flags
> > > > > >
> > > > > >         As it then cannot be set per-skb, reject setting it via=
 CMSG.
> > > > > >
> > > > > >  Documentation/networking/timestamping.rst | 9 +++++++++
> > > > > >  include/uapi/linux/errqueue.h             | 1 +
> > > > > >  include/uapi/linux/net_tstamp.h           | 6 ++++--
> > > > > >  net/core/sock.c                           | 2 ++
> > > > > >  net/ethtool/common.c                      | 1 +
> > > > > >  5 files changed, 17 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/Documentation/networking/timestamping.rst b/Docume=
ntation/networking/timestamping.rst
> > > > > > index 61ef9da10e28..5034dfe326c0 100644
> > > > > > --- a/Documentation/networking/timestamping.rst
> > > > > > +++ b/Documentation/networking/timestamping.rst
> > > > > > @@ -140,6 +140,15 @@ SOF_TIMESTAMPING_TX_ACK:
> > > > > >    cumulative acknowledgment. The mechanism ignores SACK and FA=
CK.
> > > > > >    This flag can be enabled via both socket options and control=
 messages.
> > > > > >
> > > > > > +SOF_TIMESTAMPING_TX_COMPLETION:
> > > > > > +  Request tx timestamps on packet tx completion, for the packe=
ts that
> > > > > > +  also have SOF_TIMESTAMPING_TX_SOFTWARE enabled.  The complet=
ion
> > > > >
> > > > > Is it mandatory for other drivers that will try to use
> > > > > SOF_TIMESTAMPING_TX_COMPLETION in the future? I can see you coupl=
ed
> > > > > both of them in hci_conn_tx_queue in patch [2/5]. If so, it would=
 be
> > > > > better if you add the limitation in sock_set_timestamping() so th=
at
> > > > > the same rule can be applied to other drivers.
> > > > >
> > > > > But may I ask why you tried to couple them so tight in the versio=
n?
> > > > > Could you say more about this? It's optional, right? IIUC, you
> > > > > expected the driver to have both timestamps and then calculate th=
e
> > > > > delta easily?
> > > >
> > > > This is a workaround around the limited number of bits available in
> > > > skb_shared_info.tx_flags.
> > >
> > > Oh, I'm surprised I missed the point even though I revisited the
> > > previous discussion.
> > >
> > > Pauli, please add the limitation when users setsockopt in
> > > sock_set_timestamping() :)
> > >
> > > >
> > > > Pauli could claim last available bit 7.. but then you would need to
> > > > find another bit for SKBTX_BPF ;)
> > >
> > > Right :D
> > >
> > > >
> > > > FWIW I think we could probably free up 1 or 2 bits if we look close=
ly,
> > > > e.g., of SKBTX_HW_TSTAMP_USE_CYCLES or SKBTX_WIFI_STATUS.
> > >
> > > Good. Will you submit a patch series to do that, or...?
> >
> > Reclaiming space is really up to whoever needs it.
> >
> > I'll take a quick look, just to see if there is an obvious path and
> > we can postpone this whole conversation to next time we need a bit.
>
> SKBTX_HW_TSTAMP_USE_CYCLES is only true if SOF_TIMESTAMPING_BIND_PHC.
> It cannot be set per cmsg (is not in SOF_TIMESTAMPING_TX_RECORD_MASK),
> so no need to record it per skb.

Those flags look like sub-features to me, not like the completion one.
Occupying one bit in the skb is luxury for them.

>
> It only has two drivers using it, which can easily be updated:
>
>         -                if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_=
USE_CYCLES)
>         +                if (skb->sk &&
>         +                    READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING=
_BIND_PHC)
>                                         tx_flags |=3D IGC_TX_FLAGS_TSTAMP=
_TIMER_1;
>
> They later call skb_tstamp_tx, which does nothing if !skb->sk.
> Only cost is a higher cost of accessing the sk cacheline.
>
> SKBTX_WIFI_STATUS essentially follows the same argument. It can only
> be set in the sockopt. It has a handful more callsites that would need
> to be updated. sock_flag(sk, SOCK_WIFI_STATUS) will be tested without
> the socket lock held. But this is already the case in the UDP lockless
> fast path through ip_make_skb.
>
> SKBTX_HW_TSTAMP_NETDEV is only used on Rx. Could shadow another bit
> that is used only on Tx.
>
> SKBTX_IN_PROGRESS is only used by the driver to suppress the software
> tx timestamp from skb_tx_timestamp if a later hardware timestamp will
> be generated. Predates SOF_TIMESTAMPING_OPT_TX_SWHW.

Thanks for the detailed analysis. I just checked them out and agreed.

> In short plenty of bits we can reclaim if we try.
>
> SKBTX_BPF was just merged, so we will have to reclaim one.

It's worth knowing that we probably will work on top of the bpf-next
net branch if so.

Do you want to reclaim every possible bit in one go? One series can
complete the work. // If there is anything, feel free to ask me to
implement/co-work :)

> The first one seems most straightforward.

If there are more flags than the tx_flags can have in the future, I
think we can turn to the second method you mentioned.

Could we harvest one or more to have a better uniformed design before
working on this completion feature, I'm wondering?

Thanks,
Jason


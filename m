Return-Path: <netdev+bounces-156447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFFFA06716
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 22:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57093A546B
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 21:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DA6202F95;
	Wed,  8 Jan 2025 21:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mG/G+W7i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C42315E8B
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 21:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736371144; cv=none; b=nFN8pFG24GAhZXoAvpOERyXCkXkd+JJNBfS/oZp9sIOleCUHknSIxnIZ+NrtO9b5N+x3FnoLxEAu6L98MZQHf/HHVMaTTcTwPtOSv0h4mnT4byRWGeV27p9AxQ30SLCT2XSER97kVW+0MqIgssjmgGwYEfE9UK+114MhiIC4HcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736371144; c=relaxed/simple;
	bh=6txERFyG27pIRB8eYPjUGfSMl1sJYFwtcANR4pWufME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=KHzafk4gbfNWhmmvSFQ+tqM2vBIfXDyXuhb4ots8VaZikIXmEgkILeoxbX5MbCamyUDJN/G9zqJvupowtEWTzrPvJaO54pe2ceGZwWkYoVTJD03PIJ/hej0rXkxgCJPwSOjKOiSl7QOvUsD8Oyfu6O9ZWNcS4Ab2UD4/T5P4Hus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mG/G+W7i; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4361d5730caso2785e9.1
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 13:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736371140; x=1736975940; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCouPXYig7wKrrmzUfCVeHthJbZomhwVZSHtJbqUwfI=;
        b=mG/G+W7iAbhwusu1u1sZCRlZXJqay8bWLpICrjfnzlxTKRQcROW73tbnViYqJDCwgZ
         sD63tpTDufKshSs7qOOp+EZNULbHM+1dZXZP8GbfGVGd/JBtuF/aGu6QmzBTdZuN29au
         wzT/GcNj8sUBunqD5DcMq14gFzJENiMstvroYP0KpMc0bVRbYyGvoMCZ4MyJkOdrWbLO
         rViHaPjSxyI1SdhMpy9OLyH23aOsQb4tu6VsVr77/Zg6f0zAL/aKXbrOlwKwFJ6KxNxM
         ywLQs+MsQFjsON8vtRJZh8R59LjQ44XrK54vv5xzgq/ajkZ2HeUhNRoOxe+81+4F2ywu
         2uog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736371140; x=1736975940;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCouPXYig7wKrrmzUfCVeHthJbZomhwVZSHtJbqUwfI=;
        b=pl+7FZJ9/uYm61j6tAwRlf77gTjuAa7MdA6C61/dyStIn+r5G7sUb1bRiCkEf7ZLJ2
         3RSn+IkgCWzSk1TNx2QqqGROklhI1HuRELu6tmkKI8K5ZSNwrqvWigqbGzVu8Pe71jDD
         NIQ0Ea2ctWHzAmP2yJVAVVlXB/vn74AnQwb7cF8Q9jdp2k6Vgde8/ppYpPhwd9fTOxNR
         c19PEffHSNlCD2KnMW/94g9EsRARJHs1m5GUdTTltd/zl3o4RXPvouzy2+6xUO+3n7A+
         UGicFnKQPV+sSl16klLFh3x4gNuOk+jezH6RNptxbBx6I+o4o6//DOSlP1qjHdTx3fAv
         HQDA==
X-Forwarded-Encrypted: i=1; AJvYcCUt1z8ADZ5SyMwTxINAnN9t9wj9Z+KiHaghkm/D8iHS8OUJ7Opf0c9F+ORenQYFNnWLozTEbqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiJDznPpMcN6+NC0Xocerw9N3NUkyhDOIdQWqIpFkQWntbFlmt
	R+G7OmLCy4qmEoM+0Cuj+kpOvLXhUNj0aaPMlREoaj3Wvku9DPbSAJOCoEPGCaPdTg99FF+TPNs
	18M/NEDIYRO62Ox2NTER2sZLUETZUvjSz3Hlo
X-Gm-Gg: ASbGncveVyohz/up9rb3aFZCplAytiirYDNBwEVWbtemSse12y4wBlGZVG3SmfYltj5
	Ukf9fyXUGdMx8N1vrVkv4jM7yKlao+pdTT9eBSXpkhwtvrBNAB81EtI44chm9sTyK4kerDN0=
X-Google-Smtp-Source: AGHT+IH74JJq6nrbdRNlgWMyTPbUxunvzK2Q2li+ETfKPXGEV0fwzf0NIL2ckrHtCKHci60rwfERpCiOWKVLiii36WI=
X-Received: by 2002:a05:600c:3b87:b0:434:c967:e4b5 with SMTP id
 5b1f17b1804b1-436e8e44e6bmr221085e9.1.1736371140238; Wed, 08 Jan 2025
 13:19:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102191227.2084046-1-skhawaja@google.com> <20250102164714.0d849aaf@kernel.org>
 <Z37RFvD03cctrtTO@LQ3V64L9R2>
In-Reply-To: <Z37RFvD03cctrtTO@LQ3V64L9R2>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Wed, 8 Jan 2025 13:18:48 -0800
X-Gm-Features: AbW1kvbvawKDhaq-HjsuOC_5uZR5z9m3MCFSY3g_rCzXjdiIaVw7ZEt3KDOr8WY
Message-ID: <CAAywjhTAvT+LPT8_saw41vV6SE+EWd-2gzCH1iP_0HOvdi=yEg@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] Add support to do threaded napi busy poll
To: Joe Damato <jdamato@fastly.com>, Jakub Kicinski <kuba@kernel.org>, 
	Samiullah Khawaja <skhawaja@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	mkarsten@uwaterloo.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 11:25=E2=80=AFAM Joe Damato <jdamato@fastly.com> wro=
te:
>
> On Thu, Jan 02, 2025 at 04:47:14PM -0800, Jakub Kicinski wrote:
> > On Thu,  2 Jan 2025 19:12:24 +0000 Samiullah Khawaja wrote:
> > > Extend the already existing support of threaded napi poll to do conti=
nuous
> > > busypolling.
> > >
> > > This is used for doing continuous polling of napi to fetch descriptor=
s from
> > > backing RX/TX queues for low latency applications. Allow enabling of =
threaded
> > > busypoll using netlink so this can be enabled on a set of dedicated n=
apis for
> > > low latency applications.
> >
> > This is lacking clear justification and experimental results
> > vs doing the same thing from user space.
Thanks for the response.

The major benefit is that this is a one common way to enable busy
polling of descriptors on a particular napi. It is basically
independent of the userspace API and allows for enabling busy polling
on a subset, out of the complete list, of napi instances in a device
that can be shared among multiple processes/applications that have low
latency requirements. This allows for a dedicated subset of napi
instances that are configured for busy polling on a machine and
workload/jobs can target these napi instances.

Once enabled, the relevant kthread can be queried using netlink
`get-napi` op. The thread priority, scheduler and any thread core
affinity can also be set. Any userspace application using a variety of
interfaces (AF_XDP, io_uring, xsk, epoll etc) can run on top of it
without any further complexity. For userspace driven napi busy
polling, one has to either use sysctls to setup busypolling that are
done at device level or use different interfaces depending on the use
cases,
- epoll params (or a sysctl that is system wide) for epoll based interface
- socket option (or sysctl that is system wide) for sk_recvmsg
- io_uring (I believe SQPOLL can be configured with it)

Our application for this feature uses a userspace implementation of
TCP (https://github.com/Xilinx-CNS/onload) that interfaces with AF_XDP
to send/receive packets. We use neper (running with AF_XDP + userspace
TCP library) to measure latency improvements with and without napi
threaded busy poll. Our target application sends packets with a well
defined frequency with a couple of 100 bytes of RPC style
request/response.

Test Environment:
Google C3 VMs running netdev-net/main kernel with idpf driver

Without napi threaded busy poll (p50 at around 44us)
num_transactions=3D47918
latency_min=3D0.000018838
latency_max=3D0.333912365
latency_mean=3D0.000189570
latency_stddev=3D0.005859874
latency_p50=3D0.000043510
latency_p90=3D0.000053750
latency_p99=3D0.000058230
latency_p99.9=3D0.000184310

With napi threaded busy poll (p50 around 14us)
latency_min=3D0.000012271
latency_max=3D0.209365389
latency_mean=3D0.000021611
latency_stddev=3D0.001166541
latency_p50=3D0.000013590
latency_p90=3D0.000019990
latency_p99=3D0.000023670
latency_p99.9=3D0.000027830

> Apologies for chiming in late here as I was out of the office, but I
> agree with Jakub and Stanislav:
Thanks for chiming in.
>
> - This lacks clear justification and data to compare packet delivery
>   mechanisms. IMHO, at a minimum a real world application should be
>   benchmarked and various packet delivery mechanisms (including this
>   one) should be compared side-by-side. You don't need to do exactly
>   what Martin and I did [1], but I'd offer that as a possible
>   suggestion for how you might proceed if you need some suggestions.
Some of the packet delivery mechanisms like epoll can only be compared
with this using the application that uses it. This napi threaded
approach provides support for enabling busy polling of a napi
regardless of the userspace API the application uses. For example our
target application uses AF_XDP directly and interfaces with rings
directly.
>
> - This should include a test of some sort; perhaps expanding the test
>   I added (as Stanislav suggested) would be a good start?
Thanks for the suggestion. I am currently expanding the test you added
with this (as Stanislav suggested). I will be sending an update with
it.
>
> - IMHO, this change should also include updated kernel documentation
>   to clearly explain how, when, and why a user might use this and
>   what tradeoffs a user can expect. The commit message is, IMHO, far
>   too vague.
>
>   Including example code snippets or ynl invocations etc in the
>   kernel documentation would be very helpful.
Thanks for the suggestion. I will add those in the next update.
>
> > I'd also appreciate if Google could share the experience and results
> > of using basic threaded NAPI _in production_.
We are not using basic threaded NAPI _in production_, but we are going
to use this threaded napi busy poll in production for one of the use
cases. We are currently improving neper to accurately do the network
traffic simulation and handle the frequency of request/response
properly.
>
> +1; this data would be very insightful.
>
> [1]: https://lore.kernel.org/netdev/20241109050245.191288-1-jdamato@fastl=
y.com/


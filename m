Return-Path: <netdev+bounces-229146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3896BD8964
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6D80541B5D
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE492EBB83;
	Tue, 14 Oct 2025 09:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TPBBf6/S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2350E2E2F1A
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 09:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435358; cv=none; b=MaWTFZjj8FvsSP/+LbTcC2y9V6//P6NXRY9fEX3lhgmAKNXJcY2FqA4+xnNYqPPQltLSDSBmpQp7IoB4gBkQA6UqM+enNaNRkRm2iSiTy5GGFV4ioTkeJ0vJtXOzsgd93MAQCtLbohUL/v99T0p+SkFennPBNuzhEV2Gllpo0YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435358; c=relaxed/simple;
	bh=gGb9eDVa6GvVYjR9gyWIr55BgaGdEpmDwy6Ql2lMG9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3mHJbvOOLpiLutS1Wjd+4WyURaI4iII7O9Oz6QuAf8TniSuQv65rxdC3v4Iz1ke5/vKVB/hjR4PXAhbuNhnj2DxyC+90jCe4NkSXO/WrVf4HKvU632pwJIJt5VCuS+ytu9pNb8+wWLNv6dL1g4Ba57D1nIezsXrftUaLUxxf44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TPBBf6/S; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-816ac9f9507so788202085a.1
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 02:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760435355; x=1761040155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rejcU5EZuKfOaVf3kGuy7qqlEcfNKn49oLZoxZhzh8=;
        b=TPBBf6/S0rF6DBgg/Wz6eF6o71OngV/9WOKH+K/UYrQblEDvVMR7IaIGypoGhrh8uD
         ss+yUof6CvLRyK+JXyOUkeW+5rSmaePXuJ8enm63d41z60mvtYwbVjzJSkE3Grcr39qx
         eeEHy7y9LnJ5H7j/KfhQVb2u7iFArdxPUWwPM/E1tQ/NoNXg365BMOxnXEGM/Z8gAemY
         MZa1Ycgcm06UjxLaiqzTbKtkc97SNKuf+PCnGLZMvxIFV8ZcbqKmWFEx4vo4A6nbFVS4
         EhA0ya4zDQ20x6dQD0GtlAioNSQn2okTe8ORycShgj6bcNWq0Bl9z4TMSJC4mKsTAokm
         neqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760435355; x=1761040155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rejcU5EZuKfOaVf3kGuy7qqlEcfNKn49oLZoxZhzh8=;
        b=FuMVEdlvJPF6MsvhjlzVkwgv0Hwxz4p6PDT+7hDq6yzZyqoS04wMz6CaMQojpKLMW8
         odINCuY9rfkEHb1x83XgI90YUhShNncSue85El+WoN50a6EVpXWADacQk3gglbnV4aYa
         Cj6Mn34bAy9JzfbtQg9RjObd+EwexKEQMxVeh/acn1+juhlLqnpoaan2ojgNkILi/xV7
         W5ydqS/jDQoW4v08Z2O85RDktV4FGwYUwUp+zMy5rAXxjjtjnPMrIGh0YwvIPOo19BuA
         3sEX8lv2hESbV2TE3giO4o224Qo4ZLwf1N1UCQP98iDpNM2rnV3j2+YtIDKwnou+QW8G
         yf9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXr+jV/ITThBgwkUfaLKxWMtBIrSS42DjKCj7G2nTtwbN9eYm0NdwO47Iwak2TV5aWQGFZMQ7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv+7hmOceeDQ4ZoIcmDU8j4p8zjpfLX3UWDVjSIA6b7sDzhHMy
	TvGbYdpoP+hm3xeOxeRCzlNhZODG6aSJc8hWl+uHDwKwmvafuS4aYSRPG5BD5oYR2w4jXo8SuaI
	rEQzOn8zYnszNgR56j5sPFJ9W5p1a31GWOzqIv17s
X-Gm-Gg: ASbGncv8/CO5RJanSj2OtZ3T1l/vdhloJYJlClouKMFXCd/pdSho9fncZtA8upr5deW
	oUdJh6Q2NM7HRm7q/+OL6tOJkahlHAhECXymo1vz7jD1kqaC0pXfWMTkxYO06Bz7XJhe3P6y6MC
	/N8yEr81jcDKQYgf+/HWiEak9tkP4yBHRw4ANqLf/2XHTneAbLI3kGCwmwSijNmSNpioRAzhEOZ
	yIdfrUTP1aUkHfxHz9IYhMdxxIRVBIZPnJQYl+Vse8=
X-Google-Smtp-Source: AGHT+IHl4KYhns6HjXctJUP8o5ymMntOlhxSsAztTQ/ElyRGupOcA1nshFbafOIGxpIMTBr9aCbejFNLuYJavjSBG/8=
X-Received: by 2002:a05:622a:1651:b0:4b7:a1b6:cf29 with SMTP id
 d75a77b69052e-4e6de928b64mr379844891cf.41.1760435354432; Tue, 14 Oct 2025
 02:49:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013101636.69220-1-21cnbao@gmail.com> <aO11jqD6jgNs5h8K@casper.infradead.org>
 <CAGsJ_4x9=Be2Prbjia8-p97zAsoqjsPHkZOfXwz74Z_T=RjKAA@mail.gmail.com>
 <CANn89iJpNqZJwA0qKMNB41gKDrWBCaS+CashB9=v1omhJncGBw@mail.gmail.com> <CAGsJ_4xGSrfori6RvC9qYEgRhVe3bJKYfgUM6fZ0bX3cjfe74Q@mail.gmail.com>
In-Reply-To: <CAGsJ_4xGSrfori6RvC9qYEgRhVe3bJKYfgUM6fZ0bX3cjfe74Q@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Oct 2025 02:49:03 -0700
X-Gm-Features: AS18NWCJcjmV12JbFBOiX1xuqww7glxnYRIPGxjvTUEA69A11zlzBQw_qx0TUQI
Message-ID: <CANn89iKSW-kk-h-B0f1oijwYiCWYOAO0jDrf+Z+fbOfAMJMUbA@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: net: disable kswapd for high-order network buffer allocation
To: Barry Song <21cnbao@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Jonathan Corbet <corbet@lwn.net>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Huacai Zhou <zhouhuacai@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 1:58=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Tue, Oct 14, 2025 at 1:04=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Mon, Oct 13, 2025 at 9:09=E2=80=AFPM Barry Song <21cnbao@gmail.com> =
wrote:
> > >
> > > On Tue, Oct 14, 2025 at 5:56=E2=80=AFAM Matthew Wilcox <willy@infrade=
ad.org> wrote:
> > > >
> > > > On Mon, Oct 13, 2025 at 06:16:36PM +0800, Barry Song wrote:
> > > > > On phones, we have observed significant phone heating when runnin=
g apps
> > > > > with high network bandwidth. This is caused by the network stack =
frequently
> > > > > waking kswapd for order-3 allocations. As a result, memory reclam=
ation becomes
> > > > > constantly active, even though plenty of memory is still availabl=
e for network
> > > > > allocations which can fall back to order-0.
> > > >
> > > > I think we need to understand what's going on here a whole lot more=
 than
> > > > this!
> > > >
> > > > So, we try to do an order-3 allocation.  kswapd runs and ... succee=
ds in
> > > > creating order-3 pages?  Or fails to?
> > > >
> > >
> > > Our team observed that most of the time we successfully obtain order-=
3
> > > memory, but the cost is excessive memory reclamation, since we end up
> > > over-reclaiming order-0 pages that could have remained in memory.
> > >
> > > > If it fails, that's something we need to sort out.
> > > >
> > > > If it succeeds, now we have several order-3 pages, great.  But wher=
e do
> > > > they all go that we need to run kswapd again?
> > >
> > > The network app keeps running and continues to issue new order-3 allo=
cation
> > > requests, so those few order-3 pages won=E2=80=99t be enough to satis=
fy the
> > > continuous demand.
> >
> > These pages are freed as order-3 pages, and should replenish the buddy
> > as if nothing happened.
>
> Ideally, that would be the case if the workload were simple. However, the
> system may have many other processes and kernel drivers running
> simultaneously, also consuming memory from the buddy allocator and possib=
ly
> taking the replenished pages. As a result, we can still observe multiple
> kswapd wakeups and instances of over-reclamation caused by the network
> stack=E2=80=99s high-order allocations.
>
> >
> > I think you are missing something to control how much memory  can be
> > pushed on each TCP socket ?
> >
> > What is tcp_wmem on your phones ? What about tcp_mem ?
> >
> > Have you looked at /proc/sys/net/ipv4/tcp_notsent_lowat
>
> # cat /proc/sys/net/ipv4/tcp_wmem
> 524288  1048576 6710886

Ouch. That is insane tcp_wmem[0] .

Please stick to 4096, or risk OOM of various sorts.

>
> # cat /proc/sys/net/ipv4/tcp_notsent_lowat
> 4294967295
>
> Any thoughts on these settings?

Please look at
https://www.kernel.org/doc/Documentation/networking/ip-sysctl.txt

tcp_notsent_lowat - UNSIGNED INTEGER
A TCP socket can control the amount of unsent bytes in its write queue,
thanks to TCP_NOTSENT_LOWAT socket option. poll()/select()/epoll()
reports POLLOUT events if the amount of unsent bytes is below a per
socket value, and if the write queue is not full. sendmsg() will
also not add new buffers if the limit is hit.

This global variable controls the amount of unsent data for
sockets not using TCP_NOTSENT_LOWAT. For these sockets, a change
to the global variable has immediate effect.


Setting this sysctl to 2MB can effectively reduce the amount of memory
in TCP write queues by 66 %,
or allow you to increase tcp_wmem[2] so that only flows needing big
BDP can get it.


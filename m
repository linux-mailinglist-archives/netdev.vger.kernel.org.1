Return-Path: <netdev+bounces-207557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 420B0B07C7D
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 20:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C2D3B550C
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 18:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC6028D8FE;
	Wed, 16 Jul 2025 18:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MdR61cdu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2852283FCF
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 18:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752689279; cv=none; b=PWoPwpi0JX3YFzO81sN7YX98v1HtVzI7bvSgASmPem2i1edNCUAOLrkuIkHGrlRpx2eDzZO+IdZsQNLTRFrEES7k0pTNKCPypFjD3TWUN5KtA0gf8PX+fzpsb66eKxYeHH86/GqYSwsVB7JopTUppgRZPIOb/LUIdzTvcXRL3nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752689279; c=relaxed/simple;
	bh=r+/J00r88pbp9r2+6CgOPBBi4aOmlFIDaultrznfTe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q7ZILe2/0/IEFvkKyt1DmSzReL6W8QGc8CJhG1CKHMyecXjPcgQwCBiKjWj9kIcdqVLWOS/BqiR5eWAYye2xa/l0ZLcMt0khMhpTgveKZwy+iGVO+OB1Jts5b6buEsREE/sGbhyWBrLv5r1WCL1C/8Q0jir67uBiNF5ecfa3iKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MdR61cdu; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-235ea292956so1021835ad.1
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 11:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752689277; x=1753294077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HtBqIB8vQTR5u8cmm+T4QFZrBMFS3cf5PT3R4konQOk=;
        b=MdR61cdupNQ2p6Rgltx+G5PZN1t7sYRPs019RP6ANNqU+4LsAOxOUOcg1ttV55B38o
         a5UcQmPNo7hHWaRDwpkT+omrd/yXDWvW9253HOvlPqcIOWMwMFe9Z7OZDonBXArrECQr
         DuWvTxQqm6S7vO7s/NhLiG1rL9qe2jWkO4Oh2nkwxU/zEACzhLjYdLbWw/N5tsNOAesj
         HUJb/RjF9zGtT5+YcB+FlAJ0xrzoyV+8y50TUf0mI5j6qeCh8iRjBM99p07LKUIfEjuj
         tMxeUA2CfV4r2cieffBcL5xGT0mm51EmBx9xb+9T23EK71bID2XYPIba2gR2aRHBflYQ
         6J3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752689277; x=1753294077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HtBqIB8vQTR5u8cmm+T4QFZrBMFS3cf5PT3R4konQOk=;
        b=pZ5+GnscFVu4r8pJwc4HXU9PyOwiXU0HdVk5neHjqVrSxwqP4neIj4Wi5QxYrjq25v
         z+8JwLFQjutRnPVgOHVI3KA9ygYunfM2fiVxDUNQO3VNQS0GFWNxIHkNPsdI8KTf78QG
         ayaXk0W8V9JMXeYdAOL6TPbBHltIVX8riIn02ra75RouQHPBksaS12SvAmt0CEsyUyX3
         3UZOHkCh9yn6xgwKM8M58fSFqMmDMsFnurZ/vcsCW9XpESj+Cfh0uvl2+GpqskUCT9kX
         erdvffDlyXw3f1z6L60sQ39BIvY0VHciCd1GGfJHv3jhVX2qd55/gJiKgkoxin3fFWvT
         gEzw==
X-Forwarded-Encrypted: i=1; AJvYcCV79rCstgP1M1lkISfDhLwbn4ZbcfCgtzff7fjoXomYohFKQAoh9Uvxrkg2ugnckVT1tLsKlrA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym3YQg3SdFt9NfYr+91lI4iZuY6vUxeTYXMDuwtUaPfOQHGFpZ
	T3yjiKetfXT4Qc40sPzmVt8454FrfKe6LSanj2hnnEKQJjxasWxuePLB0GO3mS2sUqz2vnfPKsj
	j+rGU4mCxPBjVauWyYAW1DGs9FRLAW9rCUIYDaWV/
X-Gm-Gg: ASbGncvkG5yhwrlQfUHrMW7hxno5hoPN5Vx3gLC7ookGPvrdiH3nngXfV2xhwI4y+70
	1+70oDJVK1wvEdqb5GTGDHvS+LRvmu11mjAqBI5z8sSN7KRA1mqOI6nxR/Ifnx/5pHq5VAExjfR
	8Sku603JkuY67BCIUvFz/SFrrk5KuSUjfvLICQ5tTsx0xP9LCuFAvwPpXPCdF1CLcKX9hWtlIdq
	noPko348grkbB1dEbuDqrAzldA4fvRhR0qUd2k8gGOvepxj
X-Google-Smtp-Source: AGHT+IFGQs/MhfAF/+F7gLLhpBzOXJuauznlby7F1yG4NA9+LP2teg9k4yIgRkRG4Jy0JEX6O8hUmbjUe7rQ0t4POyo=
X-Received: by 2002:a17:902:d490:b0:234:d7b2:2ab9 with SMTP id
 d9443c01a7336-23e256adcc4mr58822625ad.12.1752689276880; Wed, 16 Jul 2025
 11:07:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714143613.42184-1-daniel.sedlak@cdn77.com>
 <20250714143613.42184-2-daniel.sedlak@cdn77.com> <vlybtuctmjmsfkh4x455q4iokcme4zbowvolvti2ftmcysechr@ydj4uss6vkm2>
In-Reply-To: <vlybtuctmjmsfkh4x455q4iokcme4zbowvolvti2ftmcysechr@ydj4uss6vkm2>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 16 Jul 2025 11:07:44 -0700
X-Gm-Features: Ac12FXzTb1KzWeKzpPlneXdiabppVB68MvIey5AKLhH3yNR2XP56uLG6-DIvxu4
Message-ID: <CAAVpQUBNoRgciFXVtqS2rxjCeD44JHOuDNcuN0J__guY33pfjw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 1/2] tcp: account for memory pressure signaled
 by cgroup
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Daniel Sedlak <daniel.sedlak@cdn77.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, netdev@vger.kernel.org, 
	Matyas Hurtik <matyas.hurtik@cdn77.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 9:50=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Mon, Jul 14, 2025 at 04:36:12PM +0200, Daniel Sedlak wrote:
> > This patch is a result of our long-standing debug sessions, where it al=
l
> > started as "networking is slow", and TCP network throughput suddenly
> > dropped from tens of Gbps to few Mbps, and we could not see anything in
> > the kernel log or netstat counters.
> >
> > Currently, we have two memory pressure counters for TCP sockets [1],
> > which we manipulate only when the memory pressure is signalled through
> > the proto struct [2]. However, the memory pressure can also be signaled
> > through the cgroup memory subsystem, which we do not reflect in the
> > netstat counters. In the end, when the cgroup memory subsystem signals
> > that it is under pressure, we silently reduce the advertised TCP window
> > with tcp_adjust_rcv_ssthresh() to 4*advmss, which causes a significant
> > throughput reduction.
> >
> > So this patch adds a new counter to account for memory pressure
> > signaled by the memory cgroup, so it is much easier to spot.
> >
> > Link: https://elixir.bootlin.com/linux/v6.15.4/source/include/uapi/linu=
x/snmp.h#L231-L232 [1]
> > Link: https://elixir.bootlin.com/linux/v6.15.4/source/include/net/sock.=
h#L1300-L1301 [2]
> > Co-developed-by: Matyas Hurtik <matyas.hurtik@cdn77.com>
> > Signed-off-by: Matyas Hurtik <matyas.hurtik@cdn77.com>
> > Signed-off-by: Daniel Sedlak <daniel.sedlak@cdn77.com>
> > ---
> >  Documentation/networking/net_cachelines/snmp.rst |  1 +
> >  include/net/tcp.h                                | 14 ++++++++------
> >  include/uapi/linux/snmp.h                        |  1 +
> >  net/ipv4/proc.c                                  |  1 +
> >  4 files changed, 11 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/networking/net_cachelines/snmp.rst b/Documen=
tation/networking/net_cachelines/snmp.rst
> > index bd44b3eebbef..ed17ff84e39c 100644
> > --- a/Documentation/networking/net_cachelines/snmp.rst
> > +++ b/Documentation/networking/net_cachelines/snmp.rst
> > @@ -76,6 +76,7 @@ unsigned_long  LINUX_MIB_TCPABORTONLINGER
> >  unsigned_long  LINUX_MIB_TCPABORTFAILED
> >  unsigned_long  LINUX_MIB_TCPMEMORYPRESSURES
> >  unsigned_long  LINUX_MIB_TCPMEMORYPRESSURESCHRONO
> > +unsigned_long  LINUX_MIB_TCPCGROUPSOCKETPRESSURE
> >  unsigned_long  LINUX_MIB_TCPSACKDISCARD
> >  unsigned_long  LINUX_MIB_TCPDSACKIGNOREDOLD
> >  unsigned_long  LINUX_MIB_TCPDSACKIGNOREDNOUNDO
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index 761c4a0ad386..aae3efe24282 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -267,6 +267,11 @@ extern long sysctl_tcp_mem[3];
> >  #define TCP_RACK_STATIC_REO_WND  0x2 /* Use static RACK reo wnd */
> >  #define TCP_RACK_NO_DUPTHRESH    0x4 /* Do not use DUPACK threshold in=
 RACK */
> >
> > +#define TCP_INC_STATS(net, field)    SNMP_INC_STATS((net)->mib.tcp_sta=
tistics, field)
> > +#define __TCP_INC_STATS(net, field)  __SNMP_INC_STATS((net)->mib.tcp_s=
tatistics, field)
> > +#define TCP_DEC_STATS(net, field)    SNMP_DEC_STATS((net)->mib.tcp_sta=
tistics, field)
> > +#define TCP_ADD_STATS(net, field, val)       SNMP_ADD_STATS((net)->mib=
.tcp_statistics, field, val)
> > +
> >  extern atomic_long_t tcp_memory_allocated;
> >  DECLARE_PER_CPU(int, tcp_memory_per_cpu_fw_alloc);
> >
> > @@ -277,8 +282,10 @@ extern unsigned long tcp_memory_pressure;
> >  static inline bool tcp_under_memory_pressure(const struct sock *sk)
> >  {
> >       if (mem_cgroup_sockets_enabled && sk->sk_memcg &&
> > -         mem_cgroup_under_socket_pressure(sk->sk_memcg))
> > +         mem_cgroup_under_socket_pressure(sk->sk_memcg)) {
> > +             TCP_INC_STATS(sock_net(sk), LINUX_MIB_TCPCGROUPSOCKETPRES=
SURE);
> >               return true;
>
> Incrementing it here will give a very different semantic to this stat
> compared to LINUX_MIB_TCPMEMORYPRESSURES. Here the increments mean the
> number of times the kernel check if a given socket is under memcg
> pressure for a net namespace. Is that what we want?

I'm trying to decouple sk_memcg from the global tcp_memory_allocated
as you and Wei planned before, and the two accounting already have the
different semantics from day1 and will keep that, so a new stat having a
different semantics would be fine.

But I think per-memcg stat like memory.stat.XXX would be a good fit
rather than pre-netns because one netns could be shared by multiple
cgroups and multiple sockets in the same cgroup could be spread across
multiple netns.


Return-Path: <netdev+bounces-128160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F31697850B
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 571291C2214A
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 15:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44B7433C8;
	Fri, 13 Sep 2024 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bh4isZHG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5714086A
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726242000; cv=none; b=jsxgPFNTu4oxD7m2gkb5Swkxh2cJYWRZ8/CdFPAs8iQMGWG23ve41tFK41JH4UY442I/eHAu+HCcnIPHu5RL2jFUH8EVuxqIcAN/FGxcHTWzdOgR4G2sE4tsMvR0wS54J6jNzkjXjQnE1T1X0T6T4qXpatj00+lOB4n8uSPf3lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726242000; c=relaxed/simple;
	bh=vJzTQroHUo6fH3tz9KeS90mgTSfC0eOVWdyUtSQdEwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bQtHD0aTFwlnjyyrz0MiinVUTqkWIV5HLpV0NHA2ucSSqcWr6rF7Excv0gJ4N1ZBReEdWKCxr68wW9jJkR/jvnHQgSEDLFGWYqXEjprfoh685sSSmAIu3iFSihp2fuyF7M0GvVXbgYEAUc+ZR4YnexMpAQ1CoY63TkmaQSzuEFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bh4isZHG; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a90349aa7e5so236199066b.0
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 08:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726241997; x=1726846797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJzTQroHUo6fH3tz9KeS90mgTSfC0eOVWdyUtSQdEwY=;
        b=Bh4isZHGd58FvnlgjW4O0IMtYBbOOVEX1WXgC5ZkGPxtjwzH++S3O4zzGgDUK4R2m1
         0Q1x3fU5Enp/Z7lOUUKpT5gjwCytY04Wrm7l0Ag6JyNA+RKOVuyLN62ufFoV3UrjvMU+
         mXlPP/KYZtkM1TKg+1RQpwMluYoIjnVBfPcwZgMR90J6tnXOvb69DqLGTRvpLy2C/+e6
         p3XBunDdtnJBD2K2XAL++EWcNLIHLO/xpXwGY+EQnpETLE/5/Kf/khjJA7+C0n33knMm
         LloQv27FKicVToojeskaLp2txtzrepMB13RBn8poyXO/u+uaoKKAurU+d9lWk/XS9ucQ
         AyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726241997; x=1726846797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJzTQroHUo6fH3tz9KeS90mgTSfC0eOVWdyUtSQdEwY=;
        b=A64sIcvcrJjc6HH0ptycBfS8wCowxSArvqLSXVfAeKLbzR+YGNhi5kkSb0AtFgnP3H
         QzCnysBE2as67t1oTkdaD1JkmEYj8x29pmK2FS7k4KTIsDpIyYqH/evFAO5IF5DPobyN
         JiV/yc+SkVaTfaI1UwsUhpWRmCDDdXgnjHBFBLn81NkKIjPSNWhFKkGV2JbL1BrIxTsu
         30feRYWQl+jG2KkxQd3mwvwc8LcKjFN0M88D8dRgDIyyoB/SgcA7vnu3XOBm1k6Os6Mf
         0m3sTvlDSc/1aZCfXQC7PV5L8DjUv8ZhSsNiWmCNVOoRePqgvGK1ZGWfTFUeSyOXWVYg
         t//A==
X-Forwarded-Encrypted: i=1; AJvYcCXZqj3s1ZsbJyW/wKZWHBkHInE65IxKdrpUFtUADi9tqknf+uM+rsau42Yx6cZkW5cudcvIX7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYVoRsLCcUu9i6qNN3vBl1D0gQ8vO/lMuHEfe9Rjj4URKRtMqx
	XuCzBetHqx5ORak/ptH5pw83GdrX/YFEE/X+bbzS2R70dfVU+YXx386aOCeJvMyf8AsNcbZ6NxQ
	JAUkE3xvPWrbvuVkSSKuv5N5k0M0jYsY0VyNh
X-Google-Smtp-Source: AGHT+IFNeCJJHp+jP8jPlCbcwArfRcQWZK97ZRZkvZ97GsIeaKLJcgIl7VM1fSNXGaUxvRlprTtclIj8cglIhRH3aW0=
X-Received: by 2002:a17:907:868e:b0:a7d:a00a:aa02 with SMTP id
 a640c23a62f3a-a90293f9003mr568351966b.1.1726241996235; Fri, 13 Sep 2024
 08:39:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913100941.8565-1-lulie@linux.alibaba.com>
 <CANn89iJuUFaM5whtsqA37vh6vUKUQJhgjV9Uqv6_ARpVGFjB2w@mail.gmail.com>
 <20240913142155.GA14069@linux.alibaba.com> <CANn89iL9EYX1EYLcrsXxz6dZX6eYyAi+u4uCZuYjg=y3tbgh6A@mail.gmail.com>
 <20240913150649.GB14069@linux.alibaba.com>
In-Reply-To: <20240913150649.GB14069@linux.alibaba.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 13 Sep 2024 17:39:45 +0200
Message-ID: <CANn89iJdy1RK4UHxAtjT5MA0oyaPPw3wPoeYMEhBFPemQD4YwA@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] net/udp: Add 4-tuple hash for connected socket
To: dust.li@linux.alibaba.com
Cc: Philo Lu <lulie@linux.alibaba.com>, netdev@vger.kernel.org, 
	willemdebruijn.kernel@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, antony.antony@secunet.com, 
	steffen.klassert@secunet.com, linux-kernel@vger.kernel.org, 
	jakub@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 5:07=E2=80=AFPM Dust Li <dust.li@linux.alibaba.com>=
 wrote:
>
> On 2024-09-13 16:39:33, Eric Dumazet wrote:
> >On Fri, Sep 13, 2024 at 4:22=E2=80=AFPM Dust Li <dust.li@linux.alibaba.c=
om> wrote:
> >>
> >> On 2024-09-13 13:49:03, Eric Dumazet wrote:
> >> >On Fri, Sep 13, 2024 at 12:09=E2=80=AFPM Philo Lu <lulie@linux.alibab=
a.com> wrote:
> >> >>
> >> >> This RFC patch introduces 4-tuple hash for connected udp sockets, t=
o
> >> >> make udp lookup faster. It is a tentative proposal and any comment =
is
> >> >> welcome.
> >> >>
> >> >> Currently, the udp_table has two hash table, the port hash and port=
addr
> >> >> hash. But for UDP server, all sockets have the same local port and =
addr,
> >> >> so they are all on the same hash slot within a reuseport group. And=
 the
> >> >> target sock is selected by scoring.
> >> >>
> >> >> In some applications, the UDP server uses connect() for each incomi=
ng
> >> >> client, and then the socket (fd) is used exclusively by the client.=
 In
> >> >> such scenarios, current scoring method can be ineffcient with a lar=
ge
> >> >> number of connections, resulting in high softirq overhead.
> >> >>
> >> >> To solve the problem, a 4-tuple hash list is added to udp_table, an=
d is
> >> >> updated when calling connect(). Then __udp4_lib_lookup() firstly
> >> >> searches the 4-tuple hash list, and return directly if success. A n=
ew
> >> >> sockopt UDP_HASH4 is added to enable it. So the usage is:
> >> >> 1. socket()
> >> >> 2. bind()
> >> >> 3. setsockopt(UDP_HASH4)
> >> >> 4. connect()
> >> >>
> >> >> AFAICT the patch (if useful) can be further improved by:
> >> >> (a) Support disable with sockopt UDP_HASH4. Now it cannot be disabl=
ed
> >> >> once turned on until the socket closed.
> >> >> (b) Better interact with hash2/reuseport. Now hash4 hardly affects =
other
> >> >> mechanisms, but maintaining sockets in both hash4 and hash2 lists s=
eems
> >> >> unnecessary.
> >> >> (c) Support early demux and ipv6.
> >> >>
> >> >> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> >> >
> >> >Adding a 4-tuple hash for UDP has been discussed in the past.
> >>
> >> Thanks for the information! we don't know the history.
> >>
> >> >
> >> >Main issue is that this is adding one cache line miss per incoming pa=
cket.
> >>
> >> What about adding something like refcnt in 'struct udp_hslot' ?
> >> if someone enabled uhash4 on the port, we increase the refcnt.
> >> Then we can check if that port have uhash4 enabled. If it's zero,
> >> we can just bypass the uhash4 lookup process and goto the current
> >> udp4_lib_lookup2().
> >>
> >
> >Reading anything (thus a refcnt) in 'struct udp_hslot' will need the
> >same cache line miss.
>
> hslot2->head in 'struct udp_hslot' will be read right away in
> udp4_lib_lookup2() in any case, it's just a few instructions
> later(about 20). So I think cache miss should not be a problem
> in this case.

I guess this could work.


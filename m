Return-Path: <netdev+bounces-224961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A248FB8C097
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 08:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F8C11B25D4B
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 06:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19B822D793;
	Sat, 20 Sep 2025 06:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gI3sXn1U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F301F12E0
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 06:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758349354; cv=none; b=Fypz8c9z6hy/FftUT1FbsGPHzhc0TfdFuHQtUwb9oYb9gv/ockRXRU/MOzXumc17EuoUB7HyOi4Rc1w5TCYnEuMfpQAuI8vQJKco3jDFLne1cgm2PQwCAI6MxPHRLEYIYx5wvR84xoz8/KGiQknc/c8v7V00KXJIyAa5HghAlwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758349354; c=relaxed/simple;
	bh=u9vUptCA920XzB8LmVbCg1oIK6NcdxFqRP0VE/SRHJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Myu5Z6tQHVYBCEK+XEngbBb60QMwxBYZ8N9Nd9Pg4f+ESY9AmSiiTSA7fUX4qf8TOZchl76+SMNBegmIrX8BLLK6bNN2/xKBSSTQPzgTL1jBx3N0QSv6UGK2WGOMpvh6oemdSSfUspXYJ8niQuJhGFSwKhQ973ZQCjLYOj+9sdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gI3sXn1U; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b523fb676efso2490683a12.3
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 23:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758349352; x=1758954152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0tfXtf883LOfe4mtu4xg/ZUb5Bvdy+IH76QlVfWfkk=;
        b=gI3sXn1Uc5a9MaGODq3NoDTIc112biuav7H/nyNyr68IQEhcvVR53qU69Sr69LfUrr
         TmMZgSi/ZdfLNQo+paFL6ztyWIY+W4NVyLs5MsYb7Fz4i2V7A7V3Ca2EUy1pWLhDmEeM
         nRXtpcaZwhUJiIQuRuA3LGCdXjyhN8O89n+x0Q/2Q1+cBk4cCbXzGwraMkBF9u9GK1Un
         2IL+zGqoQmS/kYeAdEqCtMS90x96PlnZfVQ4HQEeeXeFoloAROHZ0d9YWZN738qOTNeB
         UZx+squqmX9WMf2TnvxvP2kgOEweoCNRqNNTyirgiBgTyC0XSHgQR8gJG0Qg43+JKQrs
         GE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758349352; x=1758954152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0tfXtf883LOfe4mtu4xg/ZUb5Bvdy+IH76QlVfWfkk=;
        b=Qq8jpFzPtsvxVLHLPYnhQpMUkkpUUZLqQ7G7isU2Pjfb68y6ApsUhTHTWr/0cJjoAT
         BacXi3Jhu5hmi1Zv+samOckP0Hhl2Vh+y7fP4CkMb6YrKY9rU1FgV08Crst6+flWmH+X
         cZw3p+N+bq4QXru23cMQBH8cT08qrM6G91kq5o2LBzPcA3QuEy3Bpz4Sz1WXfGm3vXor
         QyUSPys2W96dK6wTcJAn4v4XmfIblQeDzkzuNkby2b9e6aitzb2+DFuftuiJh8k2sIfe
         oTTCydrJ/pL4pHo0o+blmb41uqBgQ70OCuUmbZMCIjmgcOnJkQD2vInG2ZDpEyhlzpK7
         aNbA==
X-Forwarded-Encrypted: i=1; AJvYcCXh3VPmlOWBuleff0Skgh8YvYMP1+ZMOOGunQ8oJ/4NCSd8S3QdX2ZKKrCJGmx4QGwqQUe4bWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3VeLYxZDcsEliSRqHMSB9vzcB3Upt9scZjnNEfu8VpSojv+dJ
	lSg0HyxSvM2ruvmlD2xELRUCzO/U1KVEc4LLSlrSVT7lRp3zR8h8EZ2/OUvphNGdtI9CaZZkISr
	dDa75xsH12GTJq2nVvJAaEtf1F6XGySd0vnQxDKDt
X-Gm-Gg: ASbGnctTutRhZ9W1+6RbYJueSGjFy2lM4hShEVPrAwBqiLx+TzUMIVXg0aTxkzSAV3p
	qnSd7Q8i6+OeUaLf4MJFZ/6HJtCTVm15G0HZZvM/c2ECaasAbPHzdsT1qdniSZt+L2Cg0R1toDF
	HqkldwXfP8DNj5hClgog6nxeRuk4MRJyy+tGARa2JaLnGYG4B0IfdWJOOFWZqEUPQ1VKcwV1s1P
	w0BlGxAFkfq6P4jsaseWRcf0/plJbLlZtcwBWWEn3sXTTlwMlk=
X-Google-Smtp-Source: AGHT+IECYF57IFMVtc2Gyr1qz0Iv03ucKz7Asth6sU5+mQ9a35uJTQ1FQWLmRbWkjTVImTkWIYJj798dTdea9D1RyGI=
X-Received: by 2002:a17:902:f541:b0:251:2d4d:bdfa with SMTP id
 d9443c01a7336-269ba42ae48mr73330985ad.20.1758349352278; Fri, 19 Sep 2025
 23:22:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920000751.2091731-1-kuniyu@google.com> <20250920000751.2091731-4-kuniyu@google.com>
 <bn7f2mwrkbdfhyodf74nfx6qnbpfmqm2gzkgvnuulcq3ha6sib@2oxhp2xgfwha>
In-Reply-To: <bn7f2mwrkbdfhyodf74nfx6qnbpfmqm2gzkgvnuulcq3ha6sib@2oxhp2xgfwha>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 19 Sep 2025 23:22:21 -0700
X-Gm-Features: AS18NWApiOyHHObXXhI5-pIviJSgp703DDMEEGaNEQKirhZcXJFPXWE4ZcuSSrE
Message-ID: <CAAVpQUAkhJ8L_z7Y3T9HkZ-rcgsZE2Sbk0QEh4EUCf_mcAV19Q@mail.gmail.com>
Subject: Re: [PATCH v10 bpf-next/net 3/6] net-memcg: Introduce
 net.core.memcg_exclusive sysctl.
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 10:36=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Sat, Sep 20, 2025 at 12:07:17AM +0000, Kuniyuki Iwashima wrote:
> > If net.core.memcg_exclusive is 1 when sk->sk_memcg is allocated,
> > the socket is flagged with SK_MEMCG_EXCLUSIVE internally and skips
> > the global per-protocol memory accounting.
> >
> > OTOH, for accept()ed child sockets, this flag is inherited from
> > the listening socket in sk_clone_lock() and set in __inet_accept().
> > This is to preserve the decision by BPF which will be supported later.
> >
> > Given sk->sk_memcg can be accessed in the fast path, it would
> > be preferable to place the flag field in the same cache line as
> > sk->sk_memcg.
> >
> > However, struct sock does not have such a 1-byte hole.
> >
> > Let's store the flag in the lowest bit of sk->sk_memcg and check
> > it in mem_cgroup_sk_exclusive().
> >
> > Tested with a script that creates local socket pairs and send()s a
> > bunch of data without recv()ing.
> >
> > Setup:
> >
> >   # mkdir /sys/fs/cgroup/test
> >   # echo $$ >> /sys/fs/cgroup/test/cgroup.procs
> >   # sysctl -q net.ipv4.tcp_mem=3D"1000 1000 1000"
> >
> > Without net.core.memcg_exclusive, charged to memcg & tcp_mem:
> >
> >   # prlimit -n=3D524288:524288 bash -c "python3 pressure.py" &
> >   # cat /sys/fs/cgroup/test/memory.stat | grep sock
> >   sock 22642688 <-------------------------------------- charged to memc=
g
> >   # cat /proc/net/sockstat| grep TCP
> >   TCP: inuse 2006 orphan 0 tw 0 alloc 2008 mem 5376 <-- charged to tcp_=
mem
> >   # ss -tn | head -n 5
> >   State Recv-Q Send-Q Local Address:Port  Peer Address:Port
> >   ESTAB 2000   0          127.0.0.1:34479    127.0.0.1:53188
> >   ESTAB 2000   0          127.0.0.1:34479    127.0.0.1:49972
> >   ESTAB 2000   0          127.0.0.1:34479    127.0.0.1:53868
> >   ESTAB 2000   0          127.0.0.1:34479    127.0.0.1:53554
> >   # nstat | grep Pressure || echo no pressure
> >   TcpExtTCPMemoryPressures        1                  0.0
> >
> > With net.core.memcg_exclusive=3D1, only charged to memcg:
> >
> >   # sysctl -q net.core.memcg_exclusive=3D1
> >   # prlimit -n=3D524288:524288 bash -c "python3 pressure.py" &
> >   # cat /sys/fs/cgroup/test/memory.stat | grep sock
> >   sock 2757468160 <------------------------------------ charged to memc=
g
> >   # cat /proc/net/sockstat | grep TCP
> >   TCP: inuse 2006 orphan 0 tw 0 alloc 2008 mem 0 <- NOT charged to tcp_=
mem
> >   # ss -tn | head -n 5
> >   State Recv-Q Send-Q  Local Address:Port  Peer Address:Port
> >   ESTAB 111000 0           127.0.0.1:36019    127.0.0.1:49026
> >   ESTAB 110000 0           127.0.0.1:36019    127.0.0.1:45630
> >   ESTAB 110000 0           127.0.0.1:36019    127.0.0.1:44870
> >   ESTAB 111000 0           127.0.0.1:36019    127.0.0.1:45274
> >   # nstat | grep Pressure || echo no pressure
> >   no pressure
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> > v8: Fix build failure when CONFIG_NET=3Dn
> > ---
> >  Documentation/admin-guide/sysctl/net.rst |  9 ++++++
> >  include/net/netns/core.h                 |  3 ++
> >  include/net/sock.h                       | 39 ++++++++++++++++++++++--
> >  mm/memcontrol.c                          | 12 +++++++-
> >  net/core/sock.c                          |  1 +
> >  net/core/sysctl_net_core.c               | 11 +++++++
> >  net/ipv4/af_inet.c                       |  4 +++
> >  7 files changed, 76 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/a=
dmin-guide/sysctl/net.rst
> > index 2ef50828aff1..7272194dcf45 100644
> > --- a/Documentation/admin-guide/sysctl/net.rst
> > +++ b/Documentation/admin-guide/sysctl/net.rst
> > @@ -212,6 +212,15 @@ mem_pcpu_rsv
> >
> >  Per-cpu reserved forward alloc cache size in page units. Default 1MB p=
er CPU.
> >
> > +memcg_exclusive
> > +---------------
> > +
> > +Skip charging socket buffers to the per-protocol global memory account=
ing
> > +(controlled by net.ipv4.tcp_mem, etc) if they are already charged to t=
he
> > +cgroup memory controller ("sock" in memory.stat file).
> > +
> > +Default: 0
> > +
> >  rmem_default
> >  ------------
> >
> > diff --git a/include/net/netns/core.h b/include/net/netns/core.h
> > index 9b36f0ff0c20..ec511088e67d 100644
> > --- a/include/net/netns/core.h
> > +++ b/include/net/netns/core.h
> > @@ -16,6 +16,9 @@ struct netns_core {
> >       int     sysctl_optmem_max;
> >       u8      sysctl_txrehash;
> >       u8      sysctl_tstamp_allow_data;
> > +#ifdef CONFIG_MEMCG
> > +     u8      sysctl_memcg_exclusive;
> > +#endif
>
> Hmm will this be a system level or namespace level sysctl? Seems like ns
> level, any reason to go with netns level?

This is netns-level, I don't have a specific reason other than
granularity and have no preference.  Anyway, either
system-level or netns-level require admin privilege.


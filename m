Return-Path: <netdev+bounces-211972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F35B1CC6E
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 21:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F0FC18C3DE4
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 19:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3317E1F8755;
	Wed,  6 Aug 2025 19:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FUOSf0g+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B77846C
	for <netdev@vger.kernel.org>; Wed,  6 Aug 2025 19:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754508039; cv=none; b=orDTb3Dh9/+OYofr7qnTQvrOaz8gDSN0Ueivu6UbzoXboq0oOgqbf8PSyHGLGuWA7A+fSLmOqYsvn+PgjGYyaueo2W6xi0rhoNtYELrtO9vqxIuwVW/AA52irGIcKwCoZVEGrzggeOHWCcOcspAFzkl6AmxUGmeBBvze6PhuPJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754508039; c=relaxed/simple;
	bh=Avm7iRpw7t/J0OMzU30V+QDHcFm/VvYrQda7gk+c1uY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WT85G7FA90a9HcWUxDFOmPxjdIDoQSVpiO9aUFjqSOuFWI7b5gidMCdTxdh5jVc10y2ITA01BSWpEMgvRGJMmPD1XOu9FNldUc5AmexabGoRvapEDI0IPxhCfCiv2b7O+YfDc8zlOiVjKfMIpewl9JrapE8bjumbNSoPKeem2AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FUOSf0g+; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b4233f86067so179798a12.0
        for <netdev@vger.kernel.org>; Wed, 06 Aug 2025 12:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754508037; x=1755112837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlwSPPk3zh2CiPmdVqXCK+PGcDLcMMqnjeuzNG7VVSA=;
        b=FUOSf0g+IUbJYQgU1tNE+rHpUnwqMEKdWX9n5h6CSgx9qCyuW2C8x+/+AmhKDv7a5x
         T3OTztJYdkh6iigC3MpxJ/IGMTslfnqItIVqNbGpxMOtBNtG0+0iWH/67iVKRKm2fdlu
         0Ndk1hCukARRt4OIc/zcyCMyCzDnUZ0zFZTxzLD3z9ZrljGrrmAG1ITwHyjZPv5CnkiG
         E/P1AdcJ/lEuqgS/H69tktlj9M4D8WPjw8iDiDUxlLMmxXPbJJm+GO5m8hRCOShmFwKO
         tXsbbEJhbZhK61n45XRR+ifALCtaiHae+/nsPihxsH26J2tJyhN10hWpWZu/YjwJJrxQ
         ehxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754508037; x=1755112837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlwSPPk3zh2CiPmdVqXCK+PGcDLcMMqnjeuzNG7VVSA=;
        b=d4jX0j23MZbyvMqvdt1AvvlCV8HbxTswJ+pHmXpZAa0336zaYjjx7l/AiJUB3K6jU3
         A+oyg2dY40e1PalhbTrzK3gwQlxSZQv+6YcVPsZOgYgaBiTbMbipW0eKizMafX+LK/ZG
         O8DHNsMD0FSrOM3hrKVwQ5E4mKRYqe1LAjyGSSXhZN51Ba4v9hmtTyCuLTu9yUZnGzYX
         nIqlJTynS7hGvwZeuM6iLWzLSvQTONtkTB3GWJR4lR/6h7Myr90TksZtTLQjGp4xRVdL
         b1kDSom6MWaySMHkyMLm3cwAuzR0CWsTxd1vTQl4fYcsW9Ewpfd/PQIVC32q5QKez/AT
         fWig==
X-Forwarded-Encrypted: i=1; AJvYcCUKtdzh586lBfQgGaSdPn/3VCu+onqkjU8CKkPOD9rANR+PYpH8uoxPg/6wa2+7lWOHcbxiCec=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLSARO8FklQc2K2bobKPxWv1WnB5yYPnkbWv7EvFMzLL59ElNU
	xVczZ2ddn2po7GpNnwuTRz+SoL6mPMDqa1NkRZBpwiyV3b913C2gKkVFTW+O1Unenfcls5BS3Jp
	C1jmAcRNJq3sZNE2ubCuHSABHSnpObcMPyQFn4lN2
X-Gm-Gg: ASbGncvlhhrncja9pNTb2Isli0OTs8b7BsxVEVi0KLRwLNkm7ISRadsz5K6zGLx13tt
	eefULruElP78aEX3h3fElt7UgdIsG50qYrfK0/85mlre1vaz7a59WEfDwMI5ZtUWLlMGCsuL/y0
	UIqrYleXHKGFJ1vgXe0zFTyfJiBE64DicKMZnqixH+k+9qyDGZ7CWH9nsVZUxrKKxn8qjM0wqhp
	5XkWC14WggjG/usv9+8N6CiUBPI4vZWYdfrdg==
X-Google-Smtp-Source: AGHT+IFxu1qOt0d8Ya0ox+N19/1UV6+3t1Ff6v4R83F4G2adOyfF/EwYs87dnaZxJVxmA9LvZiQKWITP/CjagDvnBGQ=
X-Received: by 2002:a17:902:e751:b0:240:417d:8166 with SMTP id
 d9443c01a7336-242b06e7164mr9555095ad.19.1754508036289; Wed, 06 Aug 2025
 12:20:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805064429.77876-1-daniel.sedlak@cdn77.com> <fcnlbvljynxu5qlzmnjeagll7nf5mje7rwkimbqok6doso37gl@lwepk3ztjga7>
In-Reply-To: <fcnlbvljynxu5qlzmnjeagll7nf5mje7rwkimbqok6doso37gl@lwepk3ztjga7>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 6 Aug 2025 12:20:25 -0700
X-Gm-Features: Ac12FXzJnBZFvHp4SW91p6FAcWqq_WSkdxhE_YNRj03saLxF9wSquf_4XkIv_5U
Message-ID: <CAAVpQUBrNTFw34Kkh=b2bpa8aKd4XSnZUa6a18zkMjVrBqNHWw@mail.gmail.com>
Subject: Re: [PATCH v4] memcg: expose socket memory pressure in a cgroup
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Daniel Sedlak <daniel.sedlak@cdn77.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, netdev@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Matyas Hurtik <matyas.hurtik@cdn77.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 4:02=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.dev=
> wrote:
>
> On Tue, Aug 05, 2025 at 08:44:29AM +0200, Daniel Sedlak wrote:
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
> > Keep in mind that when the cgroup memory subsystem signals the socket
> > memory pressure, it affects all sockets used in that cgroup.
> >
> > This patch exposes a new file for each cgroup in sysfs which signals
> > the cgroup socket memory pressure. The file is accessible in
> > the following path.
> >
> >   /sys/fs/cgroup/**/<cgroup name>/memory.net.socket_pressure
>
> let's keep the name concise. Maybe memory.net.pressure?
>
> >
> > The output value is a cumulative sum of microseconds spent
> > under pressure for that particular cgroup.
> >
> > Link: https://elixir.bootlin.com/linux/v6.15.4/source/include/uapi/linu=
x/snmp.h#L231-L232 [1]
> > Link: https://elixir.bootlin.com/linux/v6.15.4/source/include/net/sock.=
h#L1300-L1301 [2]
> > Co-developed-by: Matyas Hurtik <matyas.hurtik@cdn77.com>
> > Signed-off-by: Matyas Hurtik <matyas.hurtik@cdn77.com>
> > Signed-off-by: Daniel Sedlak <daniel.sedlak@cdn77.com>
> > ---
> > Changes:
> > v3 -> v4:
> > - Add documentation
> > - Expose pressure as cummulative counter in microseconds
> > - Link to v3: https://lore.kernel.org/netdev/20250722071146.48616-1-dan=
iel.sedlak@cdn77.com/
> >
> > v2 -> v3:
> > - Expose the socket memory pressure on the cgroups instead of netstat
> > - Split patch
> > - Link to v2: https://lore.kernel.org/netdev/20250714143613.42184-1-dan=
iel.sedlak@cdn77.com/
> >
> > v1 -> v2:
> > - Add tracepoint
> > - Link to v1: https://lore.kernel.org/netdev/20250707105205.222558-1-da=
niel.sedlak@cdn77.com/
> >
> >  Documentation/admin-guide/cgroup-v2.rst |  7 +++++++
> >  include/linux/memcontrol.h              |  2 ++
> >  mm/memcontrol.c                         | 15 +++++++++++++++
> >  mm/vmpressure.c                         |  9 ++++++++-
> >  4 files changed, 32 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/ad=
min-guide/cgroup-v2.rst
> > index 0cc35a14afbe..c810b449fb3d 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -1884,6 +1884,13 @@ The following nested keys are defined.
> >       Shows pressure stall information for memory. See
> >       :ref:`Documentation/accounting/psi.rst <psi>` for details.
> >
> > +  memory.net.socket_pressure
> > +     A read-only single value file showing how many microseconds
> > +     all sockets within that cgroup spent under pressure.
> > +
> > +     Note that when the sockets are under pressure, the networking
> > +     throughput can be significantly degraded.
> > +
> >
> >  Usage Guidelines
> >  ~~~~~~~~~~~~~~~~
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 87b6688f124a..6a1cb9a99b88 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -252,6 +252,8 @@ struct mem_cgroup {
> >        * where socket memory is accounted/charged separately.
> >        */
> >       unsigned long           socket_pressure;
> > +     /* exported statistic for memory.net.socket_pressure */
> > +     unsigned long           socket_pressure_duration;
>
> I think atomic_long_t would be better.
>
> >
> >       int kmemcg_id;
> >       /*
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 902da8a9c643..8e299d94c073 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -3758,6 +3758,7 @@ static struct mem_cgroup *mem_cgroup_alloc(struct=
 mem_cgroup *parent)
> >       INIT_LIST_HEAD(&memcg->swap_peaks);
> >       spin_lock_init(&memcg->peaks_lock);
> >       memcg->socket_pressure =3D jiffies;
> > +     memcg->socket_pressure_duration =3D 0;
> >       memcg1_memcg_init(memcg);
> >       memcg->kmemcg_id =3D -1;
> >       INIT_LIST_HEAD(&memcg->objcg_list);
> > @@ -4647,6 +4648,15 @@ static ssize_t memory_reclaim(struct kernfs_open=
_file *of, char *buf,
> >       return nbytes;
> >  }
> >
> > +static int memory_socket_pressure_show(struct seq_file *m, void *v)
> > +{
> > +     struct mem_cgroup *memcg =3D mem_cgroup_from_seq(m);
> > +
> > +     seq_printf(m, "%lu\n", READ_ONCE(memcg->socket_pressure_duration)=
);
> > +
> > +     return 0;
> > +}
> > +
> >  static struct cftype memory_files[] =3D {
> >       {
> >               .name =3D "current",
> > @@ -4718,6 +4728,11 @@ static struct cftype memory_files[] =3D {
> >               .flags =3D CFTYPE_NS_DELEGATABLE,
> >               .write =3D memory_reclaim,
> >       },
> > +     {
> > +             .name =3D "net.socket_pressure",
> > +             .flags =3D CFTYPE_NOT_ON_ROOT,
> > +             .seq_show =3D memory_socket_pressure_show,
> > +     },
> >       { }     /* terminate */
> >  };
> >
> > diff --git a/mm/vmpressure.c b/mm/vmpressure.c
> > index bd5183dfd879..1e767cd8aa08 100644
> > --- a/mm/vmpressure.c
> > +++ b/mm/vmpressure.c
> > @@ -308,6 +308,8 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg=
, bool tree,
> >               level =3D vmpressure_calc_level(scanned, reclaimed);
> >
> >               if (level > VMPRESSURE_LOW) {
> > +                     unsigned long socket_pressure;
> > +                     unsigned long jiffies_diff;
> >                       /*
> >                        * Let the socket buffer allocator know that
> >                        * we are having trouble reclaiming LRU pages.
> > @@ -316,7 +318,12 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memc=
g, bool tree,
> >                        * asserted for a second in which subsequent
> >                        * pressure events can occur.
> >                        */
> > -                     WRITE_ONCE(memcg->socket_pressure, jiffies + HZ);
> > +                     socket_pressure =3D jiffies + HZ;
> > +
> > +                     jiffies_diff =3D min(socket_pressure - READ_ONCE(=
memcg->socket_pressure), HZ);
> > +                     memcg->socket_pressure_duration +=3D jiffies_to_u=
secs(jiffies_diff);
>
> KCSAN will complain about this. I think we can use atomic_long_add() and
> don't need the one with strict ordering.

Assuming from atomic_ that vmpressure() could be called concurrently
for the same memcg, should we protect socket_pressure and duration
within the same lock instead of mixing WRITE/READ_ONCE() and
atomic?  Otherwise jiffies_diff could be incorrect (the error is smaller
than HZ though).


>
> > +
> > +                     WRITE_ONCE(memcg->socket_pressure, socket_pressur=
e);
> >               }
> >       }
> >  }
> >
> > base-commit: e96ee511c906c59b7c4e6efd9d9b33917730e000
> > --
> > 2.39.5
> >


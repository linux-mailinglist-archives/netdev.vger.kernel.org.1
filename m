Return-Path: <netdev+bounces-93774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7878BD2C9
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 18:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28EA61C21871
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 16:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1163156657;
	Mon,  6 May 2024 16:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Y3k0j3IG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583F9156646
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 16:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715012934; cv=none; b=QZnI4zdhpNOGM7mAgQNFUZutTmXnzUY8rOji64ju1Ak9WBWMJyqDsE7unDgbDVwAKD+PIdR+8SphbqsJ9X//TJw/fKA3rVMhYAoQi12IK4T5wzEvzIRJjX7u9vkNZ10MT7E1vEngY5Ynns3jjUtN9NeM31XdYoprYW7PU36vUnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715012934; c=relaxed/simple;
	bh=yBy+qbkhiVAGOfJz494tYdqv5oV8MVNOabfY1NO2uRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YizDJGnzAnPd9agVh62AA+MYsHYqBQdpTbRIaniHRyHeJX2X9qK/znV1+4mLyEqNsCigJQJNOAEFr+73v3huge1FDCCZAOBx3iZbpfnaJYlRicR07XqhqtNTeb0P7q1FkVIMKVKSjC5V/GjC13p7KOB44EgS/mUv60NJF6hJH/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Y3k0j3IG; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-61bb219737dso23790797b3.2
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 09:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1715012932; x=1715617732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCCkT3u7JpEp6mJ5QsHOybd1FYzd1g8E4PkeVAusjAE=;
        b=Y3k0j3IG2OMbjastaYHXwkSTG5lGUUZnk4+LN5E7tCNvv1w2iP0rcdS8AIXV8XbN0d
         5nlfIrexO5bzL7EjjkgHQXbNJfdwTD//ribKD0EjrMVUFfWh3W8q87V612CZ3BxF6A/4
         ScacCcw2bRdVNKeVoa9PTaml7WlxXrHZxJRed55zPqnwrublz41Q46OMzZtRymAyruT5
         ZtjgljkH5HHYevpVwDgMJD43qpOO783DeW+WuNmJMQNbhN0ql/7QbNwG18t7dkiVccUZ
         cM64C6M++2e0nfSdbwIiMcbx8EuJnPesFfldbVuvT93nA7qM1nwKb0KwsXBnJujkoy43
         8dUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715012932; x=1715617732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCCkT3u7JpEp6mJ5QsHOybd1FYzd1g8E4PkeVAusjAE=;
        b=DgMb6EvdV4aZ6vlIjflvwILkkMnqq+dvSQdq7bZgTsDRmsYyVbzuEeSKz49K1zzgvv
         LeJDkHrxMvIdigCS/jP7FMkEHxiME4YrmTbfc813O9/smTdwP3x1xiiRrcatfU5rfaM0
         xNKRYAQH4Bqbggcz3IcYj+CPHMtsAF6TE9Ac/ztSuQUbbdlyJ5e2I/lOkAS57tORyj2f
         /gTCSdOArxjnN+r//eSk853BdHR25ejZrxokev2K+x7oasDmHjBoMA259fAWrztMM63X
         30yW/d3H4L+/vK6bagopzwbYsd0pSpjTJIMCOJdurM6W02yZlwKR58Qj1ShQ+80/13ts
         ZFZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4RKVGWdrGxrG8Py3E4qyGjVnxcN93wFKz/LoV7QE0tJtd1E489Ov1Tx52qYD7K1cpZPZySmI1fqv1XgqlO+oFyEDrI5Y6
X-Gm-Message-State: AOJu0Yyr9uDGnb5JE0MDdccn5HxsaNkj8bPIczxbMlef0aFxz/0GqpmG
	MTWO1SPORks9CDb7SjDT0CMHMN8+4z4PhoVmFcJlWfz333xpBvQ4JNvC2+nrkx/QYCeJmmZU3RQ
	tvebfZsK1M/YQ/rNobjAK0maFNO5CZTxWpSXAzA==
X-Google-Smtp-Source: AGHT+IFvfA2ywVbCWpHObc2hhQu6/bp+dPE34bgiOyDlARIZkevuDZ413NE2Lsv3j8JUxB1ePQsIlKXeHYj5RqeHUtk=
X-Received: by 2002:a81:af12:0:b0:61a:d372:8767 with SMTP id
 n18-20020a81af12000000b0061ad3728767mr9829158ywh.51.1715012932189; Mon, 06
 May 2024 09:28:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171457225108.4159924.12821205549807669839.stgit@firesoul>
 <30d64e25-561a-41c6-ab95-f0820248e9b6@redhat.com> <4a680b80-b296-4466-895a-13239b982c85@kernel.org>
 <203fdb35-f4cf-4754-9709-3c024eecade9@redhat.com> <b74c4e6b-82cc-4b26-b817-0b36fbfcc2bd@kernel.org>
 <b161e21f-9d66-4aac-8cc1-83ed75f14025@redhat.com> <42a6d218-206b-4f87-a8fa-ef42d107fb23@kernel.org>
 <4gdfgo3njmej7a42x6x6x4b6tm267xmrfwedis4mq7f4mypfc7@4egtwzrfqkhp>
 <55854a94-681e-4142-9160-98b22fa64d61@kernel.org> <mnakwztmiskni3k6ia5mynqfllb3dw5kicuv4wp4e4ituaezwt@2pzkuuqg6r3e>
In-Reply-To: <mnakwztmiskni3k6ia5mynqfllb3dw5kicuv4wp4e4ituaezwt@2pzkuuqg6r3e>
From: Ivan Babrou <ivan@cloudflare.com>
Date: Mon, 6 May 2024 09:28:41 -0700
Message-ID: <CABWYdi2pTg5Yc23XAV_ZLJepF42b8L3R5syhocDVJS-Po=ZYOA@mail.gmail.com>
Subject: Re: [PATCH v1] cgroup/rstat: add cgroup_rstat_cpu_lock helpers and tracepoints
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Waiman Long <longman@redhat.com>, tj@kernel.org, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, cgroups@vger.kernel.org, 
	yosryahmed@google.com, netdev@vger.kernel.org, linux-mm@kvack.org, 
	kernel-team@cloudflare.com, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Daniel Dao <dqminh@cloudflare.com>, jr@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 9:22=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.dev=
> wrote:
>
> On Mon, May 06, 2024 at 02:03:47PM +0200, Jesper Dangaard Brouer wrote:
> >
> >
> > On 03/05/2024 21.18, Shakeel Butt wrote:
> [...]
> > >
> > > Hmm 128 usec is actually unexpectedly high.
> >
> > > How does the cgroup hierarchy on your system looks like?
> > I didn't design this, so hopefully my co-workers can help me out here? =
(To
> > @Daniel or @Jon)
> >
> > My low level view is that, there are 17 top-level directories in
> > /sys/fs/cgroup/.
> > There are 649 cgroups (counting occurrence of memory.stat).
> > There are two directories that contain the major part.
> >  - /sys/fs/cgroup/system.slice =3D 379
> >  - /sys/fs/cgroup/production.slice =3D 233
> >  - (production.slice have directory two levels)
> >  - remaining 37
> >
> > We are open to changing this if you have any advice?
> > (@Daniel and @Jon are actually working on restructuring this)
> >
> > > How many cgroups have actual workloads running?
> > Do you have a command line trick to determine this?
> >
>
> The rstat infra maintains a per-cpu cgroup update tree to only flush
> stats of cgroups which have seen updates. So, even if you have large
> number of cgroups but the workload is active in small number of cgroups,
> the update tree should be much smaller. That is the reason I asked these
> questions. I don't have any advise yet. At the I am trying to understand
> the usage and then hopefully work on optimizing those.
>
> >
> > > Can the network softirqs run on any cpus or smaller
> > > set of cpus? I am assuming these softirqs are processing packets from
> > > any or all cgroups and thus have larger cgroup update tree.
> >
> > Softirq and specifically NET_RX is running half of the cores (e.g. 64).
> > (I'm looking at restructuring this allocation)
> >
> > > I wonder if
> > > you comment out MEMCG_SOCK stat update and still see the same holding
> > > time.
> > >
> >
> > It doesn't look like MEMCG_SOCK is used.
> >
> > I deduct you are asking:
> >  - What is the update count for different types of mod_memcg_state() ca=
lls?
> >
> > // Dumped via BTF info
> > enum memcg_stat_item {
> >         MEMCG_SWAP =3D 43,
> >         MEMCG_SOCK =3D 44,
> >         MEMCG_PERCPU_B =3D 45,
> >         MEMCG_VMALLOC =3D 46,
> >         MEMCG_KMEM =3D 47,
> >         MEMCG_ZSWAP_B =3D 48,
> >         MEMCG_ZSWAPPED =3D 49,
> >         MEMCG_NR_STAT =3D 50,
> > };
> >
> > sudo bpftrace -e 'kfunc:vmlinux:__mod_memcg_state{@[args->idx]=3Dcount(=
)}
> > END{printf("\nEND time elapsed: %d sec\n", elapsed / 1000000000);}'
> > Attaching 2 probes...
> > ^C
> > END time elapsed: 99 sec
> >
> > @[45]: 17996
> > @[46]: 18603
> > @[43]: 61858
> > @[47]: 21398919
> >
> > It seems clear that MEMCG_KMEM =3D 47 is the main "user".
> >  - 21398919/99 =3D 216150 calls per sec
> >
> > Could someone explain to me what this MEMCG_KMEM is used for?
> >
>
> MEMCG_KMEM is the kernel memory charged to a cgroup. It also contains
> the untyped kernel memory which is not included in kernel_stack,
> pagetables, percpu, vmalloc, slab e.t.c.
>
> The reason I asked about MEMCG_SOCK was that it might be causing larger
> update trees (more cgroups) on CPUs processing the NET_RX.

We pass cgroup.memory=3Dnosocket in the kernel cmdline:

* https://lore.kernel.org/lkml/CABWYdi0G7cyNFbndM-ELTDAR3x4Ngm0AehEp5aP0tfN=
kXUE+Uw@mail.gmail.com/

> Anyways did the mutex change helped your production workload regarding
> latencies?


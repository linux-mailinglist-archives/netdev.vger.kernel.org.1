Return-Path: <netdev+bounces-185604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD891A9B199
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 17:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E96AB3AD4E4
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 15:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FF9156236;
	Thu, 24 Apr 2025 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2By85Dh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5B2140E30;
	Thu, 24 Apr 2025 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745506871; cv=none; b=QHdaCXiyGlCkh5Zkk1jOppFGW1oa14oMV4QFnGAdjZ0oNpEyMq94xFy5hvLVg42FzA9KYLFYNwBcMTJyZsZTDuI2X3qtqGO3nQ4z+UONF5J4j2+NvVukIvMpUnM5TGI2tQRf2H2qCP1s8YpQe4ur85vw0vBaQY5iTklwIksms74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745506871; c=relaxed/simple;
	bh=WZrbqKmAg0FD/XTF9P5yyPYVGajEsFNFsxowH+/If6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=STjk7ECxEfPJ3zQ24hFdh6jtVqXO2rHh2NR5cI6adXvSD5Ej+wU/fyzDdHUwo64yALhpPtTLk93iY/BMs1fRIioN7xwNQkkqZ/VxsgivwuaLE5A0WTJHaxj2UpGHoKmAvyo1PhR4XLv4rNI2K/dzVUKVS/qeUY8bPZEFjS6+vow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2By85Dh; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5f6222c6c4cso1843439a12.1;
        Thu, 24 Apr 2025 08:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745506867; x=1746111667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=It4ml5Ru4yl9+22otEEIPtTHR6OFPl3zqIaTbe137T8=;
        b=K2By85DhQ+LjQq3vTqP705LFUN9+OUHiJGdTxwR4OljX6OXdsXqMYh8PS9FNimcnlG
         97jIuKZVB5hIRZa3x1inNxVJ+wl3UeZoAHhfvFO16Iu3Nzlu+wzKnUhgYnQsj8ylzsEx
         vUem9zsOUsT1MbsoHtp1FGGaFxHyzRAV4DW3r1BjksIPnRn9Okoo6Xje/N3+X0YoglrV
         cqt2sl3T1oc2e2Hlqkoch0PTC2H1C98enJXT9WC+dtB64gB75iy6i1l2serRBVGl+JML
         l/DD8SNJkKdLNyD1iOKyWqX/ZM3YTntIrueXbolCKpSGiUK+7NAKDDSlXm3b0K7Lj4/d
         +qvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745506867; x=1746111667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=It4ml5Ru4yl9+22otEEIPtTHR6OFPl3zqIaTbe137T8=;
        b=EsvYDLcl7z8+OjFcujUZgR4rh8kb6rGhbn7XAfh+i9RnBHudbb81OmusSEjOkhihFh
         OHJzvapdX0hlzFbvue+bP0HUzAXmFULpK/b1+HRCrkh41787qm9NL+DlxrCa9mrpzpyq
         YHLFo+dZdrPaarL356qU24obu6//9Ca0IO/Qp/3XgckyhzzCrO4SgZ8eX6zY2pwIvp97
         JLA00LFisd7oGfbBAb7bdMcJLK0JA4uOqMmb12s60z0D7nlq2kEqzof1nTvptJxmjaFQ
         XRMdEbVQ+wbi/WPMQfJzeZXW7zn4k2HWLet2oOHRvH7BuF40SfwI2AnFCj26TLKkqZLm
         vi4g==
X-Forwarded-Encrypted: i=1; AJvYcCWrqwZFwRAVmiR5uScXRECtTgA6VZrCCoY+xiwdQ89XAEdN4WH1VL9gvVHRtYyjnNm2xhQb4QLZ@vger.kernel.org, AJvYcCXTBtjsj9CYOUimiKu+oRLprPhuDLzdoP/QF/HGGOlKOALJ7iqQ1NqmA3pMFm07SNrTqDlbaSTzalR26k8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsd1bRsVvDls6Wi5ggzF2sDTBtR3uS/vnsLXwlUGMcpc0tSxSA
	y8zTmMXCnpFj0mIKrMlYbx2dFPSeMRkBJ9Oz9ssSg5BvH7N5MyifIzw27wXiCTUiR5a9BvzfbaH
	WefGebWzacOUnY6y8uWyXMGwkzro=
X-Gm-Gg: ASbGncu3V//vv+MVat0Z5ev4WOOyjrun3URkY4WF412O3UXisAR1pCNfnHlUHw3B8dp
	rkJyGb7s3pYRpJXnPsGuhPkygmT8ihmhv3UY+Xz6nDD8omOqEO2XTcbqV5L/ZRsAVAq3q30jTDV
	IZj88on24cCQxhRQzSpBuatb78U1VhTfI=
X-Google-Smtp-Source: AGHT+IFOZdGs4ZPLLFxxxmPcGD72nqmhCo7aJSTf0O+vREAfssfxzx/8+wnND9t7Do6b9RCL1AcbNeTyQ5cQGze8LvA=
X-Received: by 2002:a05:6402:40c5:b0:5f1:6a55:3941 with SMTP id
 4fb4d7f45d1cf-5f6de2b5e36mr3010326a12.14.1745506866412; Thu, 24 Apr 2025
 08:01:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424080755.272925-1-harry.yoo@oracle.com> <CAGudoHGkNn032RVuJdwYqpzfQgAB8pv=hEzdR1APsFOOSQnq1Q@mail.gmail.com>
 <aAoLKVwC5JCe7fbv@harry>
In-Reply-To: <aAoLKVwC5JCe7fbv@harry>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 24 Apr 2025 17:00:53 +0200
X-Gm-Features: ATxdqUFzA1rL1TZWpr6MKEHlQUoRakmY4xujufZPSd0_mGNjt5Zn2ri1WsM848o
Message-ID: <CAGudoHFaQHn4X+C9GLDt5sTVD=2=PgWX-KvtBKSdqNJSD_p1sA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Reviving the slab destructor to tackle the percpu
 allocator scalability problem
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Vlad Buslov <vladbu@nvidia.com>, 
	Yevgeny Kliteynik <kliteyn@nvidia.com>, Jan Kara <jack@suse.cz>, Byungchul Park <byungchul@sk.com>, 
	linux-mm@kvack.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 11:58=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> w=
rote:
>
> On Thu, Apr 24, 2025 at 11:29:13AM +0200, Mateusz Guzik wrote:
> > On Thu, Apr 24, 2025 at 10:08=E2=80=AFAM Harry Yoo <harry.yoo@oracle.co=
m> wrote:
> > >
> > > Overview
> > > =3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > The slab destructor feature existed in early days of slab allocator(s=
).
> > > It was removed by the commit c59def9f222d ("Slab allocators: Drop sup=
port
> > > for destructors") in 2007 due to lack of serious use cases at that ti=
me.
> > >
> > > Eighteen years later, Mateusz Guzik proposed [1] re-introducing a sla=
b
> > > constructor/destructor pair to mitigate the global serialization poin=
t
> > > (pcpu_alloc_mutex) that occurs when each slab object allocates and fr=
ees
> > > percpu memory during its lifetime.
> > >
> > > Consider mm_struct: it allocates two percpu regions (mm_cid and rss_s=
tat),
> > > so each allocate=E2=80=93free cycle requires two expensive acquire/re=
lease on
> > > that mutex.
> > >
> > > We can mitigate this contention by retaining the percpu regions after
> > > the object is freed and releasing them only when the backing slab pag=
es
> > > are freed.
> > >
> > > How to do this with slab constructors and destructors: the constructo=
r
> > > allocates percpu memory, and the destructor frees it when the slab pa=
ges
> > > are reclaimed; this slightly alters the constructor=E2=80=99s semanti=
cs,
> > > as it can now fail.
> > >
> > > This series is functional (although not compatible with MM debug
> > > features yet), but still far from perfect. I=E2=80=99m actively refin=
ing it and
> > > would appreciate early feedback before I improve it further. :)
> > >
> >
> > Thanks for looking into this.
>
> You're welcome. Thanks for the proposal.
>
> > The dtor thing poses a potential problem where a dtor acquiring
> > arbitrary locks can result in a deadlock during memory reclaim.
>
> AFAICT, MM does not reclaim slab memory unless we register shrinker
> interface to reclaim it. Or am I missing something?
>
> Hmm let's say it does anyway, then is this what you worry about?
>
> someone requests percpu memory
> -> percpu allocator takes a lock (e.g., pcpu_alloc_mutex)
> -> allocates pages from buddy
> -> buddy reclaims slab memory
> -> slab destructor calls pcpu_alloc_mutex (deadlock!)
>
> > So for this to be viable one needs to ensure that in the worst case
> > this only ever takes leaf-locks (i.e., locks which are last in any
> > dependency chain -- no locks are being taken if you hold one).
>
> Oh, then you can't allocate memory while holding pcpu_lock or
> pcpu_alloc_mutex?
>

It should be perfectly fine to allocate memory with pcpu_alloc_mutex
as it is not an inherent part of reclaim.

The part used by dtor would be the spinlock already present in the
percpu allocator.

The idea would be the mutex-protected area preps everything as needed,
but synchronisation with freeing the pcpu areas would only need the
leaf spinlock.

So issues there provided some care is employed.

> > This
> > needs to demonstrate the percpu thing qualifies or needs to refactor
> > it to that extent.
> >
> > > This series is based on slab/for-next [2].
> > >
> > > Performance Improvement
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > I measured the benefit of this series for two different users:
> > > exec() and tc filter insertion/removal.
> > >
> > > exec() throughput
> > > -----------------
> > >
> > > The performance of exec() is important when short-lived processes are
> > > frequently created. For example: shell-heavy workloads and running ma=
ny
> > > test cases [3].
> > >
> > > I measured exec() throughput with a microbenchmark:
> > >   - 33% of exec() throughput gain on 2-socket machine with 192 CPUs,
> > >   - 4.56% gain on a desktop with 24 hardware threads, and
> > >   - Even 4% gain on a single-threaded exec() throughput.
> > >
> > > Further investigation showed that this was due to the overhead of
> > > acquiring/releasing pcpu_alloc_mutex and its contention.
> > >
> > > See patch 7 for more detail on the experiment.
> > >
> > > Traffic Filter Insertion and Removal
> > > ------------------------------------
> > >
> > > Each tc filter allocates three percpu memory regions per tc_action ob=
ject,
> > > so frequently inserting and removing filters contend heavily on the s=
ame
> > > mutex.
> > >
> > > In the Linux-kernel tools/testing tc-filter benchmark (see patch 4 fo=
r
> > > more detail), I observed a 26% reduction in system time and observed
> > > much less contention on pcpu_alloc_mutex with this series.
> > >
> > > I saw in old mailing list threads Mellanox (now NVIDIA) engineers car=
ed
> > > about tc filter insertion rate; these changes may still benefit
> > > workloads they run today.
> > >
> > > Feedback Needed from Percpu Allocator Folks
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > As percpu allocator is directly affected by this series, this work
> > > will need support from the percpu allocator maintainers, and we need =
to
> > > address their concerns.
> > >
> > > They will probably say "This is a percpu memory allocator scalability
> > > issue and we need to make it scalable"? I don't know.
> > >
> > > What do you say?
> > >
> > > Some hanging thoughts:
> > > - Tackling the problem on the slab side is much simpler, because the =
slab
> > >   allocator already caches objects per CPU. Re-creating similar logic
> > >   inside the percpu allocator would be redundant.
> > >
> > >   Also, since this is opt-in per slab cache, other percpu allocator
> > >   users remain unaffected.
> > >
> > > - If fragmentation is a concern, we could probably allocate larger pe=
rcpu
> > >   chunks and partition them for slab objects.
> > >
> > > - If memory overhead becomes an issue, we could introduce a shrinker
> > >   to free empty slabs (and thus releasing underlying percpu memory ch=
unks).
> > >
> > > Patch Sequence
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > Patch #1 refactors freelist_shuffle() to allow the slab constructor t=
o
> > > fail in the next patch.
> > >
> > > Patch #2 allows the slab constructor fail.
> > >
> > > Patch #3 implements the slab destructor feature.
> > >
> > > Patch #4 converts net/sched/act_api to use the slab ctor/dtor pair.
> > >
> > > Patch #5, #6 implements APIs to charge and uncharge percpu memory and
> > > percpu counter.
> > >
> > > Patch #7 converts mm_struct to use the slab ctor/dtor pair.
> > >
> > > Known issues with MM debug features
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > The slab destructor feature is not yet compatible with KASAN, KMEMLEA=
K,
> > > and DEBUG_OBJECTS.
> > >
> > > KASAN reports an error when a percpu counter is inserted into the
> > > percpu_counters linked list because the counter has not been allocate=
d
> > > yet.
> > >
> > > DEBUG_OBJECTS and KMEMLEAK complain when the slab object is freed, wh=
ile
> > > the associated percpu memory is still resident in memory.
> > >
> > > I don't expect fixing these issues to be too difficult, but I need to
> > > think a little bit to fix it.
> > >
> > > [1] https://urldefense.com/v3/__https://lore.kernel.org/linux-mm/CAGu=
doHFc*Km-3usiy4Wdm1JkM*YjCgD9A8dDKQ06pZP070f1ig@mail.gmail.com__;Kys!!ACWV5=
N9M2RV99hQ!K8JHFp0DM1nkYDDnSbJNnwLOl-6PSEXnUlekFs6paI9bGha34XCp9q9wKF6E8S1I=
4ZHZKpnI6wgKqLM$
> > >
> > > [2] https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/=
kernel/git/vbabka/slab.git/log/?h=3Dslab*for-next__;Lw!!ACWV5N9M2RV99hQ!K8J=
HFp0DM1nkYDDnSbJNnwLOl-6PSEXnUlekFs6paI9bGha34XCp9q9wKF6E8S1I4ZHZKpnIGu8Tha=
A$
> > >
> > > [3] https://urldefense.com/v3/__https://lore.kernel.org/linux-mm/2023=
0608111408.s2minsenlcjow7q3@quack3__;!!ACWV5N9M2RV99hQ!K8JHFp0DM1nkYDDnSbJN=
nwLOl-6PSEXnUlekFs6paI9bGha34XCp9q9wKF6E8S1I4ZHZKpnIN_ctSTM$
> > >
> > > [4] https://urldefense.com/v3/__https://lore.kernel.org/netdev/vbfmun=
ui7dm.fsf@mellanox.com__;!!ACWV5N9M2RV99hQ!K8JHFp0DM1nkYDDnSbJNnwLOl-6PSEXn=
UlekFs6paI9bGha34XCp9q9wKF6E8S1I4ZHZKpnIDPKy5XU$
> > >
> > > Harry Yoo (7):
> > >   mm/slab: refactor freelist shuffle
> > >   treewide, slab: allow slab constructor to return an error
> > >   mm/slab: revive the destructor feature in slab allocator
> > >   net/sched/act_api: use slab ctor/dtor to reduce contention on pcpu
> > >     alloc
> > >   mm/percpu: allow (un)charging objects without alloc/free
> > >   lib/percpu_counter: allow (un)charging percpu counters without
> > >     alloc/free
> > >   kernel/fork: improve exec() throughput with slab ctor/dtor pair
> > >
> > >  arch/powerpc/include/asm/svm.h            |   2 +-
> > >  arch/powerpc/kvm/book3s_64_mmu_radix.c    |   3 +-
> > >  arch/powerpc/mm/init-common.c             |   3 +-
> > >  arch/powerpc/platforms/cell/spufs/inode.c |   3 +-
> > >  arch/powerpc/platforms/pseries/setup.c    |   2 +-
> > >  arch/powerpc/platforms/pseries/svm.c      |   4 +-
> > >  arch/sh/mm/pgtable.c                      |   3 +-
> > >  arch/sparc/mm/tsb.c                       |   8 +-
> > >  block/bdev.c                              |   3 +-
> > >  drivers/dax/super.c                       |   3 +-
> > >  drivers/gpu/drm/i915/i915_request.c       |   3 +-
> > >  drivers/misc/lkdtm/heap.c                 |  12 +--
> > >  drivers/usb/mon/mon_text.c                |   5 +-
> > >  fs/9p/v9fs.c                              |   3 +-
> > >  fs/adfs/super.c                           |   3 +-
> > >  fs/affs/super.c                           |   3 +-
> > >  fs/afs/super.c                            |   5 +-
> > >  fs/befs/linuxvfs.c                        |   3 +-
> > >  fs/bfs/inode.c                            |   3 +-
> > >  fs/btrfs/inode.c                          |   3 +-
> > >  fs/ceph/super.c                           |   3 +-
> > >  fs/coda/inode.c                           |   3 +-
> > >  fs/debugfs/inode.c                        |   3 +-
> > >  fs/dlm/lowcomms.c                         |   3 +-
> > >  fs/ecryptfs/main.c                        |   5 +-
> > >  fs/efs/super.c                            |   3 +-
> > >  fs/erofs/super.c                          |   3 +-
> > >  fs/exfat/cache.c                          |   3 +-
> > >  fs/exfat/super.c                          |   3 +-
> > >  fs/ext2/super.c                           |   3 +-
> > >  fs/ext4/super.c                           |   3 +-
> > >  fs/fat/cache.c                            |   3 +-
> > >  fs/fat/inode.c                            |   3 +-
> > >  fs/fuse/inode.c                           |   3 +-
> > >  fs/gfs2/main.c                            |   9 +-
> > >  fs/hfs/super.c                            |   3 +-
> > >  fs/hfsplus/super.c                        |   3 +-
> > >  fs/hpfs/super.c                           |   3 +-
> > >  fs/hugetlbfs/inode.c                      |   3 +-
> > >  fs/inode.c                                |   3 +-
> > >  fs/isofs/inode.c                          |   3 +-
> > >  fs/jffs2/super.c                          |   3 +-
> > >  fs/jfs/super.c                            |   3 +-
> > >  fs/minix/inode.c                          |   3 +-
> > >  fs/nfs/inode.c                            |   3 +-
> > >  fs/nfs/nfs42xattr.c                       |   3 +-
> > >  fs/nilfs2/super.c                         |   6 +-
> > >  fs/ntfs3/super.c                          |   3 +-
> > >  fs/ocfs2/dlmfs/dlmfs.c                    |   3 +-
> > >  fs/ocfs2/super.c                          |   3 +-
> > >  fs/openpromfs/inode.c                     |   3 +-
> > >  fs/orangefs/super.c                       |   3 +-
> > >  fs/overlayfs/super.c                      |   3 +-
> > >  fs/pidfs.c                                |   3 +-
> > >  fs/proc/inode.c                           |   3 +-
> > >  fs/qnx4/inode.c                           |   3 +-
> > >  fs/qnx6/inode.c                           |   3 +-
> > >  fs/romfs/super.c                          |   3 +-
> > >  fs/smb/client/cifsfs.c                    |   3 +-
> > >  fs/squashfs/super.c                       |   3 +-
> > >  fs/tracefs/inode.c                        |   3 +-
> > >  fs/ubifs/super.c                          |   3 +-
> > >  fs/udf/super.c                            |   3 +-
> > >  fs/ufs/super.c                            |   3 +-
> > >  fs/userfaultfd.c                          |   3 +-
> > >  fs/vboxsf/super.c                         |   3 +-
> > >  fs/xfs/xfs_super.c                        |   3 +-
> > >  include/linux/mm_types.h                  |  40 ++++++---
> > >  include/linux/percpu.h                    |  10 +++
> > >  include/linux/percpu_counter.h            |   2 +
> > >  include/linux/slab.h                      |  21 +++--
> > >  ipc/mqueue.c                              |   3 +-
> > >  kernel/fork.c                             |  65 +++++++++-----
> > >  kernel/rcu/refscale.c                     |   3 +-
> > >  lib/percpu_counter.c                      |  25 ++++++
> > >  lib/radix-tree.c                          |   3 +-
> > >  lib/test_meminit.c                        |   3 +-
> > >  mm/kfence/kfence_test.c                   |   5 +-
> > >  mm/percpu.c                               |  79 ++++++++++------
> > >  mm/rmap.c                                 |   3 +-
> > >  mm/shmem.c                                |   3 +-
> > >  mm/slab.h                                 |  11 +--
> > >  mm/slab_common.c                          |  43 +++++----
> > >  mm/slub.c                                 | 105 ++++++++++++++++----=
--
> > >  net/sched/act_api.c                       |  82 +++++++++++------
> > >  net/socket.c                              |   3 +-
> > >  net/sunrpc/rpc_pipe.c                     |   3 +-
> > >  security/integrity/ima/ima_iint.c         |   3 +-
> > >  88 files changed, 518 insertions(+), 226 deletions(-)
> > >
> > > --
> > > 2.43.0
> > >
> >
> >
> > --
> > Mateusz Guzik <mjguzik gmail.com>
>
> --
> Cheers,
> Harry / Hyeonggon



--=20
Mateusz Guzik <mjguzik gmail.com>


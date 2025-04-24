Return-Path: <netdev+bounces-185462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E632A9A7B5
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 11:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A8F16F160
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 09:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCE121D584;
	Thu, 24 Apr 2025 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbfYjSVu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B62D528;
	Thu, 24 Apr 2025 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745486970; cv=none; b=RgXwChhLfGrNbDvA1X1l5uF5MF4xCsQiRNsGZl9WPkxanvWRievRg4KQIjohBc1GvnIfK5COq50TxynX74qCROB8bS4Mp7F/q5ic8oXurn6n01MW8CGCtanOS9nDFREVTx1JFSSqZigggU0J/tTxc2HBZ74PCLbKZ37yFL32Mwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745486970; c=relaxed/simple;
	bh=WMXk+6fZL5HWDT0q7FStgDfnCjJ8LsObKoKcmW9RdqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nkS8YfNIbVKvpx/pLlcqEDxaKtwKEKZrtSo7uXL0xF8pC26fBD9xwEwPket7aybBmjEVv69dJsSbOwSSrIl8fwu6Oy26e2pXWycMn0lPJ/3N3mt2Hc8TkaDTLgc24MdvOaI3QtmjnMZYE8rnk0xx5xp6ccOwNPUxa87wNMSc/+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbfYjSVu; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac2963dc379so123570566b.2;
        Thu, 24 Apr 2025 02:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745486967; x=1746091767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emqJp3Dr3uZ/0FPx2fo09TOUZ7mzAJd83ebP+rzKJaY=;
        b=SbfYjSVuX/eX1+BfyfWuM/0vRELRo2B246fkPHMTFyEUGGGXflqyawjdZYlDd28ymj
         Rv/RyQW202vn5TtQh1ZDCH80yoBkIwJskmwcrXzDwATeqA6GyAMh48t4g4TQzAddMQM0
         4qj55i5P0zCgKUlXwA0NGDbMD7iuuV3feNWFFIrVEMoEsmL69sXGV7FsKGYm3odazC9t
         Kg44OU7/tod+s7WApIPnLGYlHrqtsyAmjRyX4HWDuewzTryf+2uUMbY736v4iIZ5F6k3
         OzY1S2sXGD2lRIcU56SimlSwuAtFq4ClSvJJC/8TBvBMLDnzn/s8dkZ5eKUP7naTsp84
         jZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745486967; x=1746091767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=emqJp3Dr3uZ/0FPx2fo09TOUZ7mzAJd83ebP+rzKJaY=;
        b=XPC6ienmixZEm1J8WeRZyEeGrFGSqeJOzAC+Usm7kh2Yhht5uPurcv+HoECpUc8FI3
         PVXOh+82EtReSu/j9QzN8AnFDWmMICYBVwT+EJqNTvM1jpTPTqVZE9gGL42mIYXTRHiq
         HAiEuub3fwg6+zM10Zdakg799WRwy1eNkGAnvFIqGjQKPE9neKgZwLN+NdJ02IDKXbAI
         q1Gz/mZ6fIYyxx2Wv+MN2Q3f3W+336wucwela+8FIjP+xVOqZFGiutBRFMq8GRmc+3Va
         SzTFuBF7FddLjUvtZnXRVpwuPGEmhKMpi7NYo3DGSezr1M5DDH0Uemzv+Y42Ka0/JIFc
         iPtg==
X-Forwarded-Encrypted: i=1; AJvYcCWdh7KzkXtBswc/mnNnh1aU5k7Wv1FakIr+EF1tnb3RQItrK4cN3vznFLBBiYIMKLpwt6QQCbDPSEHI19Y=@vger.kernel.org, AJvYcCWs8YesEEXGhzYmXogyzhd9ITaeRgp4gtrubz9HznQMgEXOi7hEAX6QRtYenJ/7/G98kTo8a4uI@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0zRmertO6whpaDkmKpzW6e8dXQq/qWcEB3cZTJ6txM6LrWeOR
	HSD07KILWiiFtpoZjWMMZM12nfttLlEfooaMET4uMiTIoR6VqiVrPhToJvsLjXzbqKRcbCxyy4S
	HtgJWXA913LB0Q5lpCnagjHg+wlc=
X-Gm-Gg: ASbGncvL1eKnCr0E2KMMy4zWKsDL+N1+9YWI3uEV5HysH8uBjuV2VjQP3avzys1lmi2
	fjyzrcP1Y4QayUUMilFKO0aTOGY3fHmYnpXdDyPTzS0zbFg+JCrbgBHrV6SkgX7VUE758yKasnu
	zaP+L1aKdYjMzRLCPLWTbIeQ==
X-Google-Smtp-Source: AGHT+IGTmo4D66ZzGkHf+lx5EU/fmhf5RaiBs35BZ1O8MoD5zN9qYJBzHB6QN2m1D4wXScfTxlhD5XXd1ubwsXWmDac=
X-Received: by 2002:a17:907:8691:b0:acb:b900:2bc5 with SMTP id
 a640c23a62f3a-ace572b4619mr208700866b.32.1745486966648; Thu, 24 Apr 2025
 02:29:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424080755.272925-1-harry.yoo@oracle.com>
In-Reply-To: <20250424080755.272925-1-harry.yoo@oracle.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 24 Apr 2025 11:29:13 +0200
X-Gm-Features: ATxdqUFpT2K9i5NWIy4iBrdWe1JtpjyVecpNXJAMCqjsnXGDj1PZMLKaE2iQQq8
Message-ID: <CAGudoHGkNn032RVuJdwYqpzfQgAB8pv=hEzdR1APsFOOSQnq1Q@mail.gmail.com>
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

On Thu, Apr 24, 2025 at 10:08=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> w=
rote:
>
> Overview
> =3D=3D=3D=3D=3D=3D=3D=3D
>
> The slab destructor feature existed in early days of slab allocator(s).
> It was removed by the commit c59def9f222d ("Slab allocators: Drop support
> for destructors") in 2007 due to lack of serious use cases at that time.
>
> Eighteen years later, Mateusz Guzik proposed [1] re-introducing a slab
> constructor/destructor pair to mitigate the global serialization point
> (pcpu_alloc_mutex) that occurs when each slab object allocates and frees
> percpu memory during its lifetime.
>
> Consider mm_struct: it allocates two percpu regions (mm_cid and rss_stat)=
,
> so each allocate=E2=80=93free cycle requires two expensive acquire/releas=
e on
> that mutex.
>
> We can mitigate this contention by retaining the percpu regions after
> the object is freed and releasing them only when the backing slab pages
> are freed.
>
> How to do this with slab constructors and destructors: the constructor
> allocates percpu memory, and the destructor frees it when the slab pages
> are reclaimed; this slightly alters the constructor=E2=80=99s semantics,
> as it can now fail.
>
> This series is functional (although not compatible with MM debug
> features yet), but still far from perfect. I=E2=80=99m actively refining =
it and
> would appreciate early feedback before I improve it further. :)
>

Thanks for looking into this.

The dtor thing poses a potential problem where a dtor acquiring
arbitrary locks can result in a deadlock during memory reclaim.

So for this to be viable one needs to ensure that in the worst case
this only ever takes leaf-locks (i.e., locks which are last in any
dependency chain -- no locks are being taken if you hold one). This
needs to demonstrate the percpu thing qualifies or needs to refactor
it to that extent.


> This series is based on slab/for-next [2].
>
> Performance Improvement
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> I measured the benefit of this series for two different users:
> exec() and tc filter insertion/removal.
>
> exec() throughput
> -----------------
>
> The performance of exec() is important when short-lived processes are
> frequently created. For example: shell-heavy workloads and running many
> test cases [3].
>
> I measured exec() throughput with a microbenchmark:
>   - 33% of exec() throughput gain on 2-socket machine with 192 CPUs,
>   - 4.56% gain on a desktop with 24 hardware threads, and
>   - Even 4% gain on a single-threaded exec() throughput.
>
> Further investigation showed that this was due to the overhead of
> acquiring/releasing pcpu_alloc_mutex and its contention.
>
> See patch 7 for more detail on the experiment.
>
> Traffic Filter Insertion and Removal
> ------------------------------------
>
> Each tc filter allocates three percpu memory regions per tc_action object=
,
> so frequently inserting and removing filters contend heavily on the same
> mutex.
>
> In the Linux-kernel tools/testing tc-filter benchmark (see patch 4 for
> more detail), I observed a 26% reduction in system time and observed
> much less contention on pcpu_alloc_mutex with this series.
>
> I saw in old mailing list threads Mellanox (now NVIDIA) engineers cared
> about tc filter insertion rate; these changes may still benefit
> workloads they run today.
>
> Feedback Needed from Percpu Allocator Folks
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> As percpu allocator is directly affected by this series, this work
> will need support from the percpu allocator maintainers, and we need to
> address their concerns.
>
> They will probably say "This is a percpu memory allocator scalability
> issue and we need to make it scalable"? I don't know.
>
> What do you say?
>
> Some hanging thoughts:
> - Tackling the problem on the slab side is much simpler, because the slab
>   allocator already caches objects per CPU. Re-creating similar logic
>   inside the percpu allocator would be redundant.
>
>   Also, since this is opt-in per slab cache, other percpu allocator
>   users remain unaffected.
>
> - If fragmentation is a concern, we could probably allocate larger percpu
>   chunks and partition them for slab objects.
>
> - If memory overhead becomes an issue, we could introduce a shrinker
>   to free empty slabs (and thus releasing underlying percpu memory chunks=
).
>
> Patch Sequence
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Patch #1 refactors freelist_shuffle() to allow the slab constructor to
> fail in the next patch.
>
> Patch #2 allows the slab constructor fail.
>
> Patch #3 implements the slab destructor feature.
>
> Patch #4 converts net/sched/act_api to use the slab ctor/dtor pair.
>
> Patch #5, #6 implements APIs to charge and uncharge percpu memory and
> percpu counter.
>
> Patch #7 converts mm_struct to use the slab ctor/dtor pair.
>
> Known issues with MM debug features
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The slab destructor feature is not yet compatible with KASAN, KMEMLEAK,
> and DEBUG_OBJECTS.
>
> KASAN reports an error when a percpu counter is inserted into the
> percpu_counters linked list because the counter has not been allocated
> yet.
>
> DEBUG_OBJECTS and KMEMLEAK complain when the slab object is freed, while
> the associated percpu memory is still resident in memory.
>
> I don't expect fixing these issues to be too difficult, but I need to
> think a little bit to fix it.
>
> [1] https://lore.kernel.org/linux-mm/CAGudoHFc+Km-3usiy4Wdm1JkM+YjCgD9A8d=
DKQ06pZP070f1ig@mail.gmail.com
>
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/log/?=
h=3Dslab/for-next
>
> [3] https://lore.kernel.org/linux-mm/20230608111408.s2minsenlcjow7q3@quac=
k3
>
> [4] https://lore.kernel.org/netdev/vbfmunui7dm.fsf@mellanox.com
>
> Harry Yoo (7):
>   mm/slab: refactor freelist shuffle
>   treewide, slab: allow slab constructor to return an error
>   mm/slab: revive the destructor feature in slab allocator
>   net/sched/act_api: use slab ctor/dtor to reduce contention on pcpu
>     alloc
>   mm/percpu: allow (un)charging objects without alloc/free
>   lib/percpu_counter: allow (un)charging percpu counters without
>     alloc/free
>   kernel/fork: improve exec() throughput with slab ctor/dtor pair
>
>  arch/powerpc/include/asm/svm.h            |   2 +-
>  arch/powerpc/kvm/book3s_64_mmu_radix.c    |   3 +-
>  arch/powerpc/mm/init-common.c             |   3 +-
>  arch/powerpc/platforms/cell/spufs/inode.c |   3 +-
>  arch/powerpc/platforms/pseries/setup.c    |   2 +-
>  arch/powerpc/platforms/pseries/svm.c      |   4 +-
>  arch/sh/mm/pgtable.c                      |   3 +-
>  arch/sparc/mm/tsb.c                       |   8 +-
>  block/bdev.c                              |   3 +-
>  drivers/dax/super.c                       |   3 +-
>  drivers/gpu/drm/i915/i915_request.c       |   3 +-
>  drivers/misc/lkdtm/heap.c                 |  12 +--
>  drivers/usb/mon/mon_text.c                |   5 +-
>  fs/9p/v9fs.c                              |   3 +-
>  fs/adfs/super.c                           |   3 +-
>  fs/affs/super.c                           |   3 +-
>  fs/afs/super.c                            |   5 +-
>  fs/befs/linuxvfs.c                        |   3 +-
>  fs/bfs/inode.c                            |   3 +-
>  fs/btrfs/inode.c                          |   3 +-
>  fs/ceph/super.c                           |   3 +-
>  fs/coda/inode.c                           |   3 +-
>  fs/debugfs/inode.c                        |   3 +-
>  fs/dlm/lowcomms.c                         |   3 +-
>  fs/ecryptfs/main.c                        |   5 +-
>  fs/efs/super.c                            |   3 +-
>  fs/erofs/super.c                          |   3 +-
>  fs/exfat/cache.c                          |   3 +-
>  fs/exfat/super.c                          |   3 +-
>  fs/ext2/super.c                           |   3 +-
>  fs/ext4/super.c                           |   3 +-
>  fs/fat/cache.c                            |   3 +-
>  fs/fat/inode.c                            |   3 +-
>  fs/fuse/inode.c                           |   3 +-
>  fs/gfs2/main.c                            |   9 +-
>  fs/hfs/super.c                            |   3 +-
>  fs/hfsplus/super.c                        |   3 +-
>  fs/hpfs/super.c                           |   3 +-
>  fs/hugetlbfs/inode.c                      |   3 +-
>  fs/inode.c                                |   3 +-
>  fs/isofs/inode.c                          |   3 +-
>  fs/jffs2/super.c                          |   3 +-
>  fs/jfs/super.c                            |   3 +-
>  fs/minix/inode.c                          |   3 +-
>  fs/nfs/inode.c                            |   3 +-
>  fs/nfs/nfs42xattr.c                       |   3 +-
>  fs/nilfs2/super.c                         |   6 +-
>  fs/ntfs3/super.c                          |   3 +-
>  fs/ocfs2/dlmfs/dlmfs.c                    |   3 +-
>  fs/ocfs2/super.c                          |   3 +-
>  fs/openpromfs/inode.c                     |   3 +-
>  fs/orangefs/super.c                       |   3 +-
>  fs/overlayfs/super.c                      |   3 +-
>  fs/pidfs.c                                |   3 +-
>  fs/proc/inode.c                           |   3 +-
>  fs/qnx4/inode.c                           |   3 +-
>  fs/qnx6/inode.c                           |   3 +-
>  fs/romfs/super.c                          |   3 +-
>  fs/smb/client/cifsfs.c                    |   3 +-
>  fs/squashfs/super.c                       |   3 +-
>  fs/tracefs/inode.c                        |   3 +-
>  fs/ubifs/super.c                          |   3 +-
>  fs/udf/super.c                            |   3 +-
>  fs/ufs/super.c                            |   3 +-
>  fs/userfaultfd.c                          |   3 +-
>  fs/vboxsf/super.c                         |   3 +-
>  fs/xfs/xfs_super.c                        |   3 +-
>  include/linux/mm_types.h                  |  40 ++++++---
>  include/linux/percpu.h                    |  10 +++
>  include/linux/percpu_counter.h            |   2 +
>  include/linux/slab.h                      |  21 +++--
>  ipc/mqueue.c                              |   3 +-
>  kernel/fork.c                             |  65 +++++++++-----
>  kernel/rcu/refscale.c                     |   3 +-
>  lib/percpu_counter.c                      |  25 ++++++
>  lib/radix-tree.c                          |   3 +-
>  lib/test_meminit.c                        |   3 +-
>  mm/kfence/kfence_test.c                   |   5 +-
>  mm/percpu.c                               |  79 ++++++++++------
>  mm/rmap.c                                 |   3 +-
>  mm/shmem.c                                |   3 +-
>  mm/slab.h                                 |  11 +--
>  mm/slab_common.c                          |  43 +++++----
>  mm/slub.c                                 | 105 ++++++++++++++++------
>  net/sched/act_api.c                       |  82 +++++++++++------
>  net/socket.c                              |   3 +-
>  net/sunrpc/rpc_pipe.c                     |   3 +-
>  security/integrity/ima/ima_iint.c         |   3 +-
>  88 files changed, 518 insertions(+), 226 deletions(-)
>
> --
> 2.43.0
>


--=20
Mateusz Guzik <mjguzik gmail.com>


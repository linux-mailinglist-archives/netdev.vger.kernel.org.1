Return-Path: <netdev+bounces-108252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC6491E84E
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 21:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 642721F22891
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 19:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4757D16F836;
	Mon,  1 Jul 2024 19:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtX/vA4r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E35316F0F0;
	Mon,  1 Jul 2024 19:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719861185; cv=none; b=M9VYUU817PvWd0oi14GMry72HoMWtrlKFDBcKkEQylDQzenkP77Ewr9tJ6aKu/rjTv9LDxyM16em4XYA6rNqcanivsNO2wOJ5Jefz/kAAAQtG+yDD/zbyggILLZJhw8qeehpmhi+GqbIM+TQrlXjZKYDXNx27C36DE2g6x/nQ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719861185; c=relaxed/simple;
	bh=iah6vxPmNoMKkFqv8vV3vfr0RI89jVaKOeDiBHmwcP8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vnp2L8lzz9+MJDPqkbF0Xydqs/RRhJ+Io0Yn0/1Jw/SH84kgpbuaa/k4IV2EPIWx9C90f8l1nIOnviy5XdinoEFQgUMnDouxoYxr7Nii2h8uVRsZ04pJYDHBj7Paq6ZuicAfPNSVBXj+jE3D3W8onZ9hG+p0MPMVYBAmMjndSp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtX/vA4r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C40C32781;
	Mon,  1 Jul 2024 19:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719861184;
	bh=iah6vxPmNoMKkFqv8vV3vfr0RI89jVaKOeDiBHmwcP8=;
	h=From:To:Cc:Subject:Date:From;
	b=RtX/vA4rdiTVl0whr0d++JbtH0iGY0ga1ZXtjuRFI68ourBdJ2PBBACqoLay2JB77
	 6zyAwNINSJWxpjSA453uQsygrFZ01hZpig0uNGG+Lrb+OThCDO8MFrq9Dpj2NEjRG8
	 mglHEdoE9oFLqKvMusSHIci5vl11qap/E5VZMHTe5dJ7qwTd7IiTy//AgudMTI+5V6
	 UJ+6/vmDrrFno6hygTZclInRC2fGeNZXzJaXvmxIA2QpkgyQ7cmOMkSq4tYOxAL2pJ
	 5RztPVPD1lCNb2lWdBF6ajMbEAOh1/EEB724qqoU1WV5TM5eG1g1P1EKMcSXCdwNb/
	 +dYbHLIYUp2QA==
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <kees@kernel.org>,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	jvoisin <julien.voisin@dustri.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jann Horn <jannh@google.com>,
	Matteo Rizzo <matteorizzo@google.com>,
	Thomas Graf <tgraf@suug.ch>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v6 0/6] slab: Introduce dedicated bucket allocator
Date: Mon,  1 Jul 2024 12:12:57 -0700
Message-Id: <20240701190152.it.631-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6373; i=kees@kernel.org; h=from:subject:message-id; bh=iah6vxPmNoMKkFqv8vV3vfr0RI89jVaKOeDiBHmwcP8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmgv++wYpdg1QAVso3x/Qnvyba7ZEqjOAyoKi+1 Tp6lxsqfrSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZoL/vgAKCRCJcvTf3G3A Jl+sEACxg9KQeodWaMSNrbxqxPZiq+SxRmaH66iRDr5+5jG4KmBa1Smye7sCWO3QJCtVmChSp8t 2+Xr3e5iN3EScMAixVYZsFYdLPZ1mmGs2Y1PAIXzM2v3ggK6q62jAWZeIssFGczrm/GqN1qdZtF qKz5x9SVPJgKu7GbWb9Olzp50Kgd4l2ZA7SKKN+Cl8ZvNYBdoYzXALl/naT8Jacow+FnlS18fZt mI6Fq0huDm+I90tgmYWXijvx3Gm2ID1jcrPmP7Fv93HhTKCV6TeAhwbFgPlfMrErODdGZZ61GJC 6Iou3EmCIaDzzAhFMXIhSDfIRYSnfaHjOLnvoT4WZKSG6uz9jZEt9gqeH/xnE30sTXCcFc5y5QV TBgAmd+eskUwBLB460g8h9CyIm4RJxQk36sJdXy1q3OgT9Vp5pZyWFQ9mbvKaU4475j6CZ/1ekZ E7NbaBCtDip9gQWQal+z9a1XzBhxC/fJN/1hapXWVQRsZ1YiQUd0+NWT2G10qPeQ5C+sdw/K0aH AbW43GNJWalOitgzCgjqMC2j4+33bGXKZZSHxDAAv0RaXO65izNqEw/CggNE+oU/cCsx4LKo97P qTTIfrgTt6ZEnUj8yIYORkh6vIuo76QGcKaDO7NmlM1rCAjpPyd7QsnrOsaMU+bQOwEJJ9CtKji ENP5WdKsZHiLY
 FA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

 v6:
  - update commit logs:
    - update description of Kconfig default and API details
    - call out usage of SLAB_NO_MERGE
    - improve description of cross-cache attacks
    - fix typos
  - add kern-doc parsing of DECL_BUCKET_PARAMS macro
  - add kern-doc to kmem_buckets_create()
  - have CONFIG_SLAB_BUCKETS default to CONFIG_SLAB_FREELIST_HARDENED
  - add CONFIG_SLAB_BUCKETS to hardening.config
  - drop alignment argument from kmem_buckets_create()
 v5: https://lore.kernel.org/lkml/20240619192131.do.115-kees@kernel.org
 v4: https://lore.kernel.org/lkml/20240531191304.it.853-kees@kernel.org/
 v3: https://lore.kernel.org/lkml/20240424213019.make.366-kees@kernel.org/
 v2: https://lore.kernel.org/lkml/20240305100933.it.923-kees@kernel.org/
 v1: https://lore.kernel.org/lkml/20240304184252.work.496-kees@kernel.org/

For the cover letter, I'm repeating the commit log for patch 4 here,
which has the more complete rationale:

    Dedicated caches are available for fixed size allocations via
    kmem_cache_alloc(), but for dynamically sized allocations there is only
    the global kmalloc API's set of buckets available. This means it isn't
    possible to separate specific sets of dynamically sized allocations into
    a separate collection of caches.

    This leads to a use-after-free exploitation weakness in the Linux
    kernel since many heap memory spraying/grooming attacks depend on using
    userspace-controllable dynamically sized allocations to collide with
    fixed size allocations that end up in same cache.

    While CONFIG_RANDOM_KMALLOC_CACHES provides a probabilistic defense
    against these kinds of "type confusion" attacks, including for fixed
    same-size heap objects, we can create a complementary deterministic
    defense for dynamically sized allocations that are directly user
    controlled. Addressing these cases is limited in scope, so isolating these
    kinds of interfaces will not become an unbounded game of whack-a-mole. For
    example, many pass through memdup_user(), making isolation there very
    effective.

    In order to isolate user-controllable dynamically-sized
    allocations from the common system kmalloc allocations, introduce
    kmem_buckets_create(), which behaves like kmem_cache_create(). Introduce
    kmem_buckets_alloc(), which behaves like kmem_cache_alloc(). Introduce
    kmem_buckets_alloc_track_caller() for where caller tracking is
    needed. Introduce kmem_buckets_valloc() for cases where vmalloc fallback
    is needed. Note that these caches are specifically flagged with
    SLAB_NO_MERGE, since merging would defeat the entire purpose of the
    mitigation.

    This can also be used in the future to extend allocation profiling's use
    of code tagging to implement per-caller allocation cache isolation[1]
    even for dynamic allocations.

    Memory allocation pinning[2] is still needed to plug the Use-After-Free
    cross-allocator weakness (where attackers can arrange to free an
    entire slab page and have it reallocated to a different cache),
    but that is an existing and separate issue which is complementary
    to this improvement. Development continues for that feature via the
    SLAB_VIRTUAL[3] series (which could also provide guard pages -- another
    complementary improvement).

    Link: https://lore.kernel.org/lkml/202402211449.401382D2AF@keescook [1]
    Link: https://googleprojectzero.blogspot.com/2021/10/how-simple-linux-kernel-memory.html [2]
    Link: https://lore.kernel.org/lkml/20230915105933.495735-1-matteorizzo@google.com/ [3]

After the core implementation are 2 patches that cover the most heavily
abused "repeat offenders" used in exploits. Repeating those details here:

    The msg subsystem is a common target for exploiting[1][2][3][4][5][6]
    use-after-free type confusion flaws in the kernel for both read and
    write primitives. Avoid having a user-controlled size cache share the
    global kmalloc allocator by using a separate set of kmalloc buckets.

    Link: https://blog.hacktivesecurity.com/index.php/2022/06/13/linux-kernel-exploit-development-1day-case-study/ [1]
    Link: https://hardenedvault.net/blog/2022-11-13-msg_msg-recon-mitigation-ved/ [2]
    Link: https://www.willsroot.io/2021/08/corctf-2021-fire-of-salvation-writeup.html [3]
    Link: https://a13xp0p0v.github.io/2021/02/09/CVE-2021-26708.html [4]
    Link: https://google.github.io/security-research/pocs/linux/cve-2021-22555/writeup.html [5]
    Link: https://zplin.me/papers/ELOISE.pdf [6]
    Link: https://syst3mfailure.io/wall-of-perdition/ [7]

    Both memdup_user() and vmemdup_user() handle allocations that are
    regularly used for exploiting use-after-free type confusion flaws in
    the kernel (e.g. prctl() PR_SET_VMA_ANON_NAME[1] and setxattr[2][3][4]
    respectively).

    Since both are designed for contents coming from userspace, it allows
    for userspace-controlled allocation sizes. Use a dedicated set of kmalloc
    buckets so these allocations do not share caches with the global kmalloc
    buckets.

    Link: https://starlabs.sg/blog/2023/07-prctl-anon_vma_name-an-amusing-heap-spray/ [1]
    Link: https://duasynt.com/blog/linux-kernel-heap-spray [2]
    Link: https://etenal.me/archives/1336 [3]
    Link: https://github.com/a13xp0p0v/kernel-hack-drill/blob/master/drill_exploit_uaf.c [4]

Thanks!

-Kees

Kees Cook (6):
  mm/slab: Introduce kmem_buckets typedef
  mm/slab: Plumb kmem_buckets into __do_kmalloc_node()
  mm/slab: Introduce kvmalloc_buckets_node() that can take kmem_buckets
    argument
  mm/slab: Introduce kmem_buckets_create() and family
  ipc, msg: Use dedicated slab buckets for alloc_msg()
  mm/util: Use dedicated slab buckets for memdup_user()

 include/linux/slab.h            |  48 ++++++++++++---
 ipc/msgutil.c                   |  13 +++-
 kernel/configs/hardening.config |   1 +
 mm/Kconfig                      |  17 ++++++
 mm/slab.h                       |   6 +-
 mm/slab_common.c                | 101 +++++++++++++++++++++++++++++++-
 mm/slub.c                       |  20 +++----
 mm/util.c                       |  23 ++++++--
 scripts/kernel-doc              |   1 +
 9 files changed, 200 insertions(+), 30 deletions(-)

-- 
2.34.1



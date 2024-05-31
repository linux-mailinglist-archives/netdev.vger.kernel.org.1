Return-Path: <netdev+bounces-99820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 073EA8D6985
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 21:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B04E1F29CBC
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 19:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EBF17D35A;
	Fri, 31 May 2024 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrCqjAbN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACADC178369;
	Fri, 31 May 2024 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717182899; cv=none; b=HSV5fAExQEfI5aq98TJhd8jfc8C+ABD8I7TYScCsDa4p7C2kkskIVUPJaY73BYD68vkLcWXrOLgIZWf0YVkNZoJp4rvsrjNJL6BFlysFwQz8mmwha98s6yVAdpWuHsz7cwutI+p0yh+WmYz2NtJnk5j2ZhbG/ZF9VnPNISlrjsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717182899; c=relaxed/simple;
	bh=tBx0KaEXOIynYzOOaB1bqfZ9QktW0dbm7km7OlYN+Rs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aXtH2VZpuQalEpnuQrqo9ksqV3KlxsUFjXgd84nkQm7Jhbvh2WkSBWiUoiRKg0+XcKsIbN1hXhBgsLF9lAl2bqb/c+93q00nqCIDNy9oWV1DrRyQ8lVUGsmJmsTgJi8Z021Uv2Ix6XKBDbM/go7Fc8ixIkx+YBWAqB7n8znaIYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrCqjAbN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B23DC4AF09;
	Fri, 31 May 2024 19:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717182899;
	bh=tBx0KaEXOIynYzOOaB1bqfZ9QktW0dbm7km7OlYN+Rs=;
	h=From:To:Cc:Subject:Date:From;
	b=OrCqjAbNKm0AWv71bIwhSQBBUUXBwgB56ZUzHevoL1a8V28yF5NTlx5e6IyOh7JRY
	 6rv2Ek5BX7HXnYmFeOrJjAxTxTijFXeh+JcHunaBXhehvX1x3+fhkPs2lN3n4JpR2A
	 I+J/B5MBYoX0PxxiHEsZ1WFi6BH2ynVV1JRrEEkeVQhPfrR/zF/+0LWF1p7d5FqgaX
	 zbQY2wbPRsw+uYnVhK2M1J5zt9lAO17YuZJMBfIvfWN+E1oZt8bcGk6y9pv2PSmu5W
	 fsvrX3xjMAJqmoIq4r8mUw2r4QiHb7Uk7Oy7TRhR44n/F2rl5Px4jSLKCfPgMxSvsp
	 D3uzLvjLRdOMw==
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
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v4 0/6] slab: Introduce dedicated bucket allocator
Date: Fri, 31 May 2024 12:14:52 -0700
Message-Id: <20240531191304.it.853-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5639; i=kees@kernel.org; h=from:subject:message-id; bh=tBx0KaEXOIynYzOOaB1bqfZ9QktW0dbm7km7OlYN+Rs=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmWiGxbiOlG/iNE86Nprep9z5p0TnTMedaC8B0s cmSg2FPrxqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZlohsQAKCRCJcvTf3G3A JsZMEACa4xV/oNU/T5sSEh9oE3qw9UvbiJIzdKvwqn1kbdL6wnYCkPggvCGd40ONLDpGvLOv0Cy EO6BEDZldyF3eKBahgBQuDfFYylseB1or4He/ZzrwkV7Qz6Ckm8NVZheUl3W9lwhapXBiYw155E TmzDU+ak3q+6WQiOzQ91Mrh8xmmYLeI43rKVHuVsr1l75Xv4NUHj37If6DjMjj+AjMOwTZLhT+z rABdFOBLww6qOt8Z+Qma5/owfoG6VADg6xBb5TulXNPUrp+L0KF5wXtonSJbwrTZwTRQdJh0AtC jCB+7v+aY5kZVu5nGiFaHfZQIqgliudOAn//iorKWY5TbdtDia4z+vNESAat8nMcvY2G9GlOcQz r0f2mqShBJQ+scm/HLNV2cvT43yGXznkSEjXyN/TGyArApYQ+JgOZrwLGq0qMMsN0jw2Bh45pbY xMA1P30Dz6u2jzSqW5DYRk/DS6C/e8GPirnIlaU7dgJ4DC4MG/CU6TBUVBS1puFKCFYlKE34lxn ldCim2hnPfq0yr7PMaDU8YMH81e7I73kB+VVc/5hLnJEBwDCLnAQcxyEtPvGEKmWAJgyOz5wz6o COZw+BlIcufsq4RZwrx30Wf87clFc/pfLaKcuUaxzSV+Mv8Z5UTRvbF9PPUdTSjDzNFU85Twk+7 q9Oq1YbxQT7ND
 Qw==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

 v4:
  - Rebase to v6.10-rc1
  - Add CONFIG_SLAB_BUCKETS to turn off the feature
 v3: https://lore.kernel.org/lkml/20240424213019.make.366-kees@kernel.org/
 v2: https://lore.kernel.org/lkml/20240305100933.it.923-kees@kernel.org/
 v1: https://lore.kernel.org/lkml/20240304184252.work.496-kees@kernel.org/

For the cover letter, I'm repeating commit log for patch 4 here, which has
additional clarifications and rationale since v2:

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
    controlled. Addressing these cases is limited in scope, so isolation these
    kinds of interfaces will not become an unbounded game of whack-a-mole. For
    example, pass through memdup_user(), making isolation there very
    effective.
    
    In order to isolate user-controllable sized allocations from system
    allocations, introduce kmem_buckets_create(), which behaves like
    kmem_cache_create(). Introduce kmem_buckets_alloc(), which behaves like
    kmem_cache_alloc(). Introduce kmem_buckets_alloc_track_caller() for
    where caller tracking is needed. Introduce kmem_buckets_valloc() for
    cases where vmalloc callback is needed.
    
    Allows for confining allocations to a dedicated set of sized caches
    (which have the same layout as the kmalloc caches).
    
    This can also be used in the future to extend codetag allocation
    annotations to implement per-caller allocation cache isolation[1] even
    for dynamic allocations.
    
    Memory allocation pinning[2] is still needed to plug the Use-After-Free
    cross-allocator weakness, but that is an existing and separate issue
    which is complementary to this improvement. Development continues for
    that feature via the SLAB_VIRTUAL[3] series (which could also provide
    guard pages -- another complementary improvement).
    
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

 include/linux/slab.h | 70 ++++++++++++++++++++++++++++-------
 ipc/msgutil.c        | 13 ++++++-
 lib/rhashtable.c     |  2 +-
 mm/Kconfig           | 15 ++++++++
 mm/slab.h            |  6 ++-
 mm/slab_common.c     | 87 ++++++++++++++++++++++++++++++++++++++++++--
 mm/slub.c            | 34 ++++++++++++-----
 mm/util.c            | 29 +++++++++++----
 8 files changed, 217 insertions(+), 39 deletions(-)

-- 
2.34.1



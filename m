Return-Path: <netdev+bounces-105010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C041C90F700
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 21:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46DCA1F22AC2
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 19:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B576158D82;
	Wed, 19 Jun 2024 19:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILO1WzP4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119016F2FA;
	Wed, 19 Jun 2024 19:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718825638; cv=none; b=OV7gI63qa+uOqAygtKwUZGlw/vRESEW2JXhC9kivFBFw5dLW+8vClVhJ5uHxi2HkVw9Tum2tYMWduNRJNAVTjKFD0L2hyoOVL5AaH5fpRNVJqtpvInJS0OlziOq55fGubtUtiv35tfBo1RGaV+3aPjwhzOkavOmJdnmhf5ydOGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718825638; c=relaxed/simple;
	bh=rCuC147fYmDtvDKRsay/TPMA580R1cV0CqcWtYXITNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z9qrtVS/PN6malXyMg5BVgck35w7p0K7UqHoOoUmmuzgb3cWATAlz5X3tMBMcps6N7VBze3WcUyQxmnz6fjBSWLmsNUhB1UxlBZ8k3Vg4jCMhXY4dZeK0uhWWVArBR0m5o0ouX8OQkNAvJVEfk2lujwCLSib6L6uvA21Xjq9rVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILO1WzP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06EDC4AF07;
	Wed, 19 Jun 2024 19:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718825637;
	bh=rCuC147fYmDtvDKRsay/TPMA580R1cV0CqcWtYXITNQ=;
	h=From:To:Cc:Subject:Date:From;
	b=ILO1WzP4rJTLoTLKi4PkpSpRq9c5N/PhEDFECsHrTkFl1QACtTgY+rJW9KMm4BWfx
	 /E4qKMwezvvz+vg0/xBy8DkaLMirjNY6DuvEAfzF2+sBMQLTLA5cMSZ/W/CfJJEAbS
	 WuiHIBRkicBOUlJ3X1Lvb3A9rWr5/XErJC7b+sD4RTGU/0uI+YAWz6sH7lE4zuAR+n
	 WGk6zFz30g/B+bCG1RkJTnzwa7GFQVzMGWyDq8WkdWb0BjIUgCz/WqATwqEber5h5O
	 w7ddILFyb2XPdJZeq+xblfZYvcVGdxlwsFY0CyaVcF1UEcfwLVrsaZ3o5egseJAO7k
	 sfzRLblD7QKRA==
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
Subject: [PATCH v5 0/6] slab: Introduce dedicated bucket allocator
Date: Wed, 19 Jun 2024 12:33:48 -0700
Message-Id: <20240619192131.do.115-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6065; i=kees@kernel.org; h=from:subject:message-id; bh=rCuC147fYmDtvDKRsay/TPMA580R1cV0CqcWtYXITNQ=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmczKhRgUdrjMlqp+DXoOV1DQo8UHBJkd/m+b/9 E8XxeZuB7SJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZnMyoQAKCRCJcvTf3G3A JoY1D/4ylvVu7defFNoTvkPBIvUnSotH37+jE2Ii4yHqdGyXcw6IxVKniJ6wiQJ5Hcj5qavdAEe lewv2kVY5lA69EKPpEsuZ53pH6M0ywnmh0Qb6ojBTpj/aPKB3WyY2fYhOKicNcxWw/k1tpvhj/V aII8Z5yaqizEuEkjjghQn5yERDk9UZEUGWwcNbentM4KmRkuB9e5qJTlSb5/JJP2UrlG4VwOyzX vr+L/sMNfqC9C/PbJwAuhu17HpcPzH4lt8BrhYYYSU+rM35ObCB+GLbsvVhy//bYGMjyZPqNtuh aeQ7o6d53Bjs/mB3T2AgGaDY1Ht3zj+5w+2ABdEELpsHIL8bTt3Vqak9zs/Lcr+iMfhG+5XSZMb 4ZXDYrTuRuidL3wNp88Rg2XGfSs/9tIfsYhPpbJ8nHVHxVelXIkTTYr0vE1aQFkSMLzn9IyDIiL NSFpEnzewhfDGAytMEN8A7LvexYaHs6pvr1uk++G4d9BVL+pl2ThEKmajJHacX6X7xS7iVqhkrR regafqOdddTgSthM4B4oYCBH00MJAsZzPxBzYdIb4IROOPQmGLNhfxIYqEfSLu+ZDhDJ9okiMbZ yxa3uQCfjfYg2IL9lA71NQwl8SuVKd+f4s6s4ww+hEBCDZDngM5cDR7AtXEdyYz4ELy4tcdeDUb +mYf33wGGRTVv
 Fg==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

 v5:
  - Use vbabka's macros for optional arguments (thank you! I added a
    Co-developed-by and S-o-b)
  - Do not make Kconfig "default y", but recommend that it be enabled (vbabka)
  - Do not check for NULL before kmem_cache_destroy() on error path (horms)
  - Adjust size/bucket argument ordering on slab_alloc()
  - Make sure kmem_buckets cache itself is SLAB_NO_MERGE
  - Do not include "_noprof" in kern-doc (it is redundant)
  - Fix kern-doc argument ordering
 v4: https://lore.kernel.org/lkml/20240531191304.it.853-kees@kernel.org/
 v3: https://lore.kernel.org/lkml/20240424213019.make.366-kees@kernel.org/
 v2: https://lore.kernel.org/lkml/20240305100933.it.923-kees@kernel.org/
 v1: https://lore.kernel.org/lkml/20240304184252.work.496-kees@kernel.org/

For the cover letter, I'm repeating the commit log for patch 4 here,
which has additional clarifications and rationale since v2:

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

 include/linux/slab.h | 49 +++++++++++++++++++++-----
 ipc/msgutil.c        | 13 ++++++-
 mm/Kconfig           | 16 +++++++++
 mm/slab.h            |  6 ++--
 mm/slab_common.c     | 83 ++++++++++++++++++++++++++++++++++++++++++--
 mm/slub.c            | 20 +++++------
 mm/util.c            | 23 ++++++++----
 7 files changed, 180 insertions(+), 30 deletions(-)

-- 
2.34.1



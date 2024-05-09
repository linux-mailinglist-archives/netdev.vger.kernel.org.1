Return-Path: <netdev+bounces-95070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF938C1609
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 22:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CA741C21A01
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 20:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F2D12C55D;
	Thu,  9 May 2024 20:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wg/hIfvO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B5112C489
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 20:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284880; cv=none; b=Dpc0aC+JjBrzLizcoQR+e97gOMdrIGa3czpv3iT/j4YWjc77oVhj8I9/TyWVWLou+9eTThDISIRXM7+DGnv24Qpp37yYqCoo7w4xvN2vyy7uavT2L2VMhL2fWdt0dM3LU0kfuxGsscn9TfXu4jCGQ96aXEAZk3wuGbWh4WJ9tZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284880; c=relaxed/simple;
	bh=I/StWvCKS3Dv4OeTH5aI03p7PaglUOESCGcwVHlL8fM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nsQeLgHKX0zOBUpFl0/RKz+qr5kyX9o4M+T7bWs8SL3MBeQ7SJRzhloApQuay0SjxT9VuBBaGWl+mUtQ2S591ag0d/IwF2KfNnSljOotzf9su77iejWSBZ9qTBvWm2aEY7Qs/rdFK/CW0OO/yJKrGZsEs0e2ciCyEl47aSPKo54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wg/hIfvO; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc0bcf9256so1998461276.3
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 13:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284878; x=1715889678; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rvw1r0YiZ9FWMZEUFCynhvM36Z8DTNYRZhlWsu0lkBc=;
        b=Wg/hIfvO9aJb3kjfgcDdw/uFDpldCChWbHLUVctTZD9h/mmyxj8KgWAi5JpGpBZDDY
         i1ck6brxG1nMTAPRl/njLJLq5kDff08webY88wEkqsfaPt3j58JJ+yVlWWODuximd2it
         n2WBKLnyaCcNd3IrmUe01jT2g5nkRwY8iRbppKt0gwnmoWpqkDvn/d7vOeRW9CwuxS4d
         PDxrl6yasyaxKshx1WIxtOIJayDZiKZU/d2SILtziVJ/Id4cJH4gvsbJGmNuixTJXIgv
         rJr1jcm8lh2Fgxfo/tVz8OxClbX08lmluE0n5uV/kmVJr2ReRxQyeNUVDyFo2SL3Uf3u
         VM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284878; x=1715889678;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rvw1r0YiZ9FWMZEUFCynhvM36Z8DTNYRZhlWsu0lkBc=;
        b=cOyd/F3UwD1d5YaNu4PXjZyA1rx0DVf43heFh8d4FwZNBB2weTVTVgA52zB6tzkoA8
         kTPfn72DslwYmwo4SIgLyAQhHVrh70sZypMtVFkfn++STO9QpP+Smvlmy7Ig32OPW7WG
         8Jq0tVyI3Xk1MxPSQshPIuJ4BC/bevwSqlzrFLhNfuUDDZUeRN8k8XuDr9/jjg3+zbZc
         lO6WWzXWk0zg/FYTdVaXa7LliniRHno5JQJAM5P5TDvwHMQ7U6SEvKlLlECzOltHVt9P
         jJB2qWYFIdUEx1+i7m84EU0rWPYajaV87ntz+oeY/WeBrLxL9RoLi9WWnJYc9xS1PFZ4
         nc2g==
X-Forwarded-Encrypted: i=1; AJvYcCVbvJSkAIxAm982iC3jOZbfNJH7+oY/vMDV0sYC1UgvTAKdkciKYGQU7dXikTv3NVYqrHenONg5Nfth2JExgVyFG1Qu/82U
X-Gm-Message-State: AOJu0YxfZJup+QYNcUIT+s6NCYrkegGGkjx6TrRttSkA6b912LrUB0V2
	bsOUqBqQ4ASdCGJ7vp+IplTQzG+8wwOrk8E2je0tzXlCo19cE+UpQXNTxOG4vrH4JsBX/GG24oI
	V3A==
X-Google-Smtp-Source: AGHT+IHpOYcnCKAgNxLWCv5PxWZfMXvL8C7Gz/+Il/03alKml+KTIw816t0RgfA9erd/ilyxF8Kqzz2DP5U=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a25:8d03:0:b0:de5:1ea2:fc75 with SMTP id
 3f1490d57ef6-dee4f2deb83mr57084276.7.1715284877769; Thu, 09 May 2024 13:01:17
 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:02 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-11-edliaw@google.com>
Subject: [PATCH v3 10/68] selftests/cgroup: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/cgroup/cgroup_util.c        | 3 ---
 tools/testing/selftests/cgroup/test_core.c          | 2 --
 tools/testing/selftests/cgroup/test_cpu.c           | 2 --
 tools/testing/selftests/cgroup/test_hugetlb_memcg.c | 2 --
 tools/testing/selftests/cgroup/test_kmem.c          | 2 --
 tools/testing/selftests/cgroup/test_memcontrol.c    | 2 --
 tools/testing/selftests/cgroup/test_zswap.c         | 2 --
 7 files changed, 15 deletions(-)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index 432db923bced..ce16a50ecff8 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -1,7 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-
-#define _GNU_SOURCE
-
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/limits.h>
diff --git a/tools/testing/selftests/cgroup/test_core.c b/tools/testing/selftests/cgroup/test_core.c
index a5672a91d273..de8baad46022 100644
--- a/tools/testing/selftests/cgroup/test_core.c
+++ b/tools/testing/selftests/cgroup/test_core.c
@@ -1,6 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-
-#define _GNU_SOURCE
 #include <linux/limits.h>
 #include <linux/sched.h>
 #include <sys/types.h>
diff --git a/tools/testing/selftests/cgroup/test_cpu.c b/tools/testing/selftests/cgroup/test_cpu.c
index dad2ed82f3ef..5a4a314f6af7 100644
--- a/tools/testing/selftests/cgroup/test_cpu.c
+++ b/tools/testing/selftests/cgroup/test_cpu.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <linux/limits.h>
 #include <sys/sysinfo.h>
 #include <sys/wait.h>
diff --git a/tools/testing/selftests/cgroup/test_hugetlb_memcg.c b/tools/testing/selftests/cgroup/test_hugetlb_memcg.c
index 856f9508ea56..80d05d50a42d 100644
--- a/tools/testing/selftests/cgroup/test_hugetlb_memcg.c
+++ b/tools/testing/selftests/cgroup/test_hugetlb_memcg.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-
 #include <linux/limits.h>
 #include <sys/mman.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
index 96693d8772be..2e453ac50c0d 100644
--- a/tools/testing/selftests/cgroup/test_kmem.c
+++ b/tools/testing/selftests/cgroup/test_kmem.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-
 #include <linux/limits.h>
 #include <fcntl.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 41ae8047b889..c871630d62a3 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -1,6 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#define _GNU_SOURCE
-
 #include <linux/limits.h>
 #include <linux/oom.h>
 #include <fcntl.h>
diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
index d13954256335..87512e91845e 100644
--- a/tools/testing/selftests/cgroup/test_zswap.c
+++ b/tools/testing/selftests/cgroup/test_zswap.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-
 #include <linux/limits.h>
 #include <unistd.h>
 #include <stdio.h>
-- 
2.45.0.118.g7fe29c98d7-goog



Return-Path: <netdev+bounces-187489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FE5AA76F0
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 18:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0017E4A0BCE
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 16:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BAC25D203;
	Fri,  2 May 2025 16:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="Z52PY3Jc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B9F25B678
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 16:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746202538; cv=none; b=CsIx0BLhKBjTgSiG5pATT6Flt0rg5cb/OpX/L1LOeT/z+4V+Z/esa8ZWuNi5uXYPZkhI1w14Otid/HQTAiq7w176k2odJac38e/0Qn8KBXBEWcoiBsRcNAgozKu6s1m1iuLP7a13YQsA7ki048sQ3awoPo2jUSq6slBl/5c6ZBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746202538; c=relaxed/simple;
	bh=ISn+5YJuklJRAulujIuiAQlBaYWaYuUMgcWAirYTpPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qEafZu5AXvohsoZ2lxDjobZRRVbrqrMKdKA2EUuEjhFpAMwgIqZHEb8nycW7onTmnBdzvAf29pPpc80V/ls6nGIX0dylMAZa0dBNTM2sYcW+5a0qeeysF23JojTF9MbSJ6uf9WdK8Ahbi3wqae1PYnrtX9wB5iBCfSN512Tgm8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=Z52PY3Jc; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b07698318ebso286777a12.2
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 09:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1746202536; x=1746807336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lqoi0NjsecEwMZZUoaSKn9mI4uNWEknBUyd3i0Xi0Mw=;
        b=Z52PY3JcqCsQwVydjNN1LuaEJzVhOgtPCUgWrFUjd8ppDegqGI6fj0/2RHj75T/eKO
         E04gFXBcqj3E2W4wtZbEm+Uz/QMnRCU2RKeqC/d9WOuxV0+qUz7k6BC66ji2x7tuoIGg
         5ZTF1hxFOV/kxGxiu8vCcAs6KmqMdSLVWr98Y3UiZ8+GVGGHvT4g/Rq4WFszDc4A10mC
         x77u7pTvFGvSdCpdTeyP2WoSMvf78RYIOdJi5XlifG+QQ7caBF4GCRNbF9Ml31HjN3pg
         Uq8dqgbv8Fn2QdUSm/0m5tOK+nnxRrH2bcnXc8YOlZKd1bHOQYGpHcVAadkxysPy6dg+
         qoUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746202536; x=1746807336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lqoi0NjsecEwMZZUoaSKn9mI4uNWEknBUyd3i0Xi0Mw=;
        b=XZeqEaxqLWaYc6IdnixLcyy9YGomfiAinzfz97+eXhba8Sq3Lk58gZMoM4StVq6KvQ
         6FK3StSbMzEk6Fnh5PrKcpixTc3PGozc0+tJf8kfe7HIPi7hebwZNZWruwykOOGSkM2s
         O0CRogyxNUE/ncTg0Q1Lw0J8G7m9jRWgaO+8i7/biddHxkSDqitJ153b8J7oN15I3M4k
         gPjuCySTqotriO59kXaBJd5hJUAv9JD9VZPDQ5GIs5Ef6AlNXzH+Ib64RBFlZengSmOY
         SU88jIKH/wl+RzEO1FdFamIm+g0MKRU6z/zywFLGr0xacsvG+2CR5/xmWkgvTPs/gHYy
         FuWw==
X-Gm-Message-State: AOJu0YxUa52m3zOXh/aYOdLMpkAedNn04ODZVI6fBQgi7Pl1+OJPQ56K
	ZjvZtDrQrzIYaX67fg7K3FREtCti81dYHunDd4iB0Vco8ZWneDGb1BO0+WtJ1+EbeqLdb3uNQkT
	FCRE=
X-Gm-Gg: ASbGncskwxXCDTXTnAYhByvlt7aE6GqTLLhzUJI5RLNPctvStDitKVlfljh7VldhSDr
	W4gjYX4TnhaykZ22wIuc8F8G5q10Nxhm3aR1T1mEsbP6XkHtBEJIY9rWI6igEqZAjKUtnH7ZyK9
	9tYhmU6ujr8m4BGCKP6v5oi6svWRnN40esst7BXTPCarGOj1sUxEGYdYhY0iN+JIBrFAwqK7++W
	sSgdZM2os3MYF+C6//KWg4zuETIDDg1nhrWXIZWByhd80AuMHO9H1112Dzjfz6ZAPn7Fyp72+6C
	Nvj2hBD5ITfXR/lv5mcstrzV/P7Om8Tn2xZ2pYQe
X-Google-Smtp-Source: AGHT+IG+aO3gDH5/zkYiEQAduZ/Zrcf7NjIUMyPQTafmywGJG5KW96mrd15uN1c2sEigPpKVASbyTw==
X-Received: by 2002:a17:903:2d0:b0:22d:e53d:efb7 with SMTP id d9443c01a7336-22e1031e35bmr18602215ad.4.1746202535776;
        Fri, 02 May 2025 09:15:35 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:7676:294c:90a5:2828])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e151e95c3sm9572135ad.68.2025.05.02.09.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 09:15:35 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v7 bpf-next 0/7] bpf: udp: Exactly-once socket iteration
Date: Fri,  2 May 2025 09:15:19 -0700
Message-ID: <20250502161528.264630-1-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both UDP and TCP socket iterators use iter->offset to track progress
through a bucket, which is a measure of the number of matching sockets
from the current bucket that have been seen or processed by the
iterator. On subsequent iterations, if the current bucket has
unprocessed items, we skip at least iter->offset matching items in the
bucket before adding any remaining items to the next batch. However,
iter->offset isn't always an accurate measure of "things already seen"
when the underlying bucket changes between reads which can lead to
repeated or skipped sockets. Instead, this series remembers the cookies
of the sockets we haven't seen yet in the current bucket and resumes
from the first cookie in that list that we can find on the next
iteration. This series focuses on UDP socket iterators, but a later
series will apply a similar approach to TCP socket iterators.

To be more specific, this series replaces struct sock **batch inside
struct bpf_udp_iter_state with union bpf_udp_iter_batch_item *batch,
where union bpf_udp_iter_batch_item can contain either a pointer to a
socket or a socket cookie. During reads, batch contains pointers to all
sockets in the current batch while between reads batch contains all the
cookies of the sockets in the current bucket that have yet to be
processed. On subsequent reads, when iteration resumes,
bpf_iter_udp_batch finds the first saved cookie that matches a socket in
the bucket's socket list and picks up from there to construct the next
batch. On average, assuming it's rare that the next socket disappears
before the next read occurs, we should only need to scan as much as we
did with the offset-based approach to find the starting point. In the
case that the next socket is no longer there, we keep scanning through
the saved cookies list until we find a match. The worst case is when
none of the sockets from last time exist anymore, but again, this should
be rare.

CHANGES
=======
v6 -> v7:
* Move initialization of iter->state.bucket to -1 from patch five ("bpf:
  udp: Avoid socket skips and repeats during iteration") to patch three
  ("bpf: udp: Get rid of st_bucket_done") to avoid skipping the first
  bucket in the patch three and four (Martin).
* Rename sock to sk in bpf_iter_batch_item (Martin).
* Use ASSERT_OK_PTR in do_resume_test to check if counts is NULL
  (Martin).
* goto done in do_resume_test when calloc or sock_iter_batch__open fails
  to make sure things are cleaned up properly, and initialize pointers
  to NULL explicitly to silence warnings from llvm 20 in CI.

v5 -> v6:
* Rework the logic in patch two ("bpf: udp: Make sure iter->batch
  always contains a full bucket snapshot") again to simplify it:
  * Only try realloc with GFP_USER one time instead of two (Alexei).
  * v5 introduced a second call to bpf_iter_udp_realloc_batch inside the
    loop to handle the GFP_ATOMIC case. In v6, move the GFP_USER case
    inside the loop as well, so it's all in once place. This, I feel,
    makes it a bit easier to understand the control flow. Consequently,
    it also simplifies the logic outside the loop.
* Use GFP_NOWAIT instead of GFP_ATOMIC to avoid depleting memory
  reserves, since iterators are not critical operation (Alexei). Alexei
  suggested using __GFP_NOWARN as well with GFP_NOWAIT, but this is
  already set inside bpf_iter_udp_realloc_batch, so no change was needed
  there.
* Introduce patch three ("bpf: udp: Get rid of st_bucket_done") to
  simplify things further, since with patch two, st_bucket_done == true
  is equivalent to iter->cur_sk == iter->end_sk.
* In patch five ("bpf: udp: Avoid socket skips and repeats during
  iteration"), initialize iter->state.bucket to -1 so that on the first
  call to bpf_iter_udp_batch, the resume_bucket condition is not hit.
  This avoids adding a special case to the condition around
  bpf_iter_udp_resume for bucket zero.

v4 -> v5:
* Rework the logic from patch two ("bpf: udp: Make sure iter->batch
  always contains a full bucket snapshot") to move the handling of the
  GFP_ATOMIC case inside the main loop and get rid of the extra lock
  variable. This makes the logic clearer and makes it clearer that the
  bucket lock is always released (Martin).
* Introduce udp_portaddr_for_each_entry_from in patch two instead of
  patch four ("bpf: udp: Avoid socket skips and repeats during
  iteration"), since patch two now needs to be able to resume list
  iteration from an arbitrary point in the GFP_ATOMIC case.
* Similarly, introduce the memcpy inside bpf_iter_udp_realloc_batch in
  patch two instead of patch four, since in the GFP_ATOMIC case the new
  batch needs to remember the sockets from the old batch.
* Use sock_gen_cookie instead of __sock_gen_cookie inside
  bpf_iter_udp_put_batch, since it can be called from a preemptible
  context (Martin).

v3 -> v4:
* Explicitly assign sk = NULL on !iter->end_sk exit condition
  (Kuniyuki).
* Reword the commit message of patch two ("bpf: udp: Make sure
  iter->batch always contains a full bucket snapshot") to make the
  reasoning for GFP_ATOMIC more clear.

v2 -> v3:
* Guarantee that iter->batch is always a full snapshot of a bucket to
  prevent socket repeat scenarios [3]. This supercedes the patch from v2
  that simply propagated ENOMEM up from bpf_iter_udp_batch and covers
  the scenario where the batch size is still too small after a realloc.
* Fix up self tests (Martin)
  * ASSERT_EQ(nread, sizeof(out), "nread") instead of
    ASSERT_GE(nread, 1, "nread) in read_n.
  * Use ASSERT_OK and ASSERT_OK_FD in several places.
  * Add missing free(counts) to do_resume_test.
  * Move int local_port declaration to the top of do_resume_test.
  * Remove unnecessary guards before close and free.

v1 -> v2:
* Drop WARN_ON_ONCE from bpf_iter_udp_realloc_batch (Kuniyuki).
* Fixed memcpy size parameter in bpf_iter_udp_realloc_batch; before it
  was missing sizeof(elem) * (Kuniyuki).
* Move "bpf: udp: Propagate ENOMEM up from bpf_iter_udp_batch" to patch
  two in the series (Kuniyuki).

rfc [1] -> v1:
* Use hlist_entry_safe directly to retrieve the first socket in the
  current bucket's linked list instead of immediately breaking from
  udp_portaddr_for_each_entry (Martin).
* Cancel iteration if bpf_iter_udp_realloc_batch() can't grab enough
  memory to contain a full snapshot of the current bucket to prevent
  unwanted skips or repeats [2].

[1]: https://lore.kernel.org/bpf/20250404220221.1665428-1-jordan@jrife.io/
[2]: https://lore.kernel.org/bpf/CABi4-ogUtMrH8-NVB6W8Xg_F_KDLq=yy-yu-tKr2udXE2Mu1Lg@mail.gmail.com/
[3]: https://lore.kernel.org/bpf/d323d417-3e8b-48af-ae94-bc28469ac0c1@linux.dev/

Jordan Rife (7):
  bpf: udp: Make mem flags configurable through
    bpf_iter_udp_realloc_batch
  bpf: udp: Make sure iter->batch always contains a full bucket snapshot
  bpf: udp: Get rid of st_bucket_done
  bpf: udp: Use bpf_udp_iter_batch_item for bpf_udp_iter_state batch
    items
  bpf: udp: Avoid socket skips and repeats during iteration
  selftests/bpf: Return socket cookies from sock_iter_batch progs
  selftests/bpf: Add tests for bucket resume logic in UDP socket
    iterators

 include/linux/udp.h                           |   3 +
 net/ipv4/udp.c                                | 173 ++++---
 .../bpf/prog_tests/sock_iter_batch.c          | 447 +++++++++++++++++-
 .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
 .../selftests/bpf/progs/sock_iter_batch.c     |  24 +-
 5 files changed, 575 insertions(+), 73 deletions(-)

-- 
2.43.0



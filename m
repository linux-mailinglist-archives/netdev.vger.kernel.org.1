Return-Path: <netdev+bounces-204623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D781AFB7ED
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 17:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794C516E362
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 15:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC202135B8;
	Mon,  7 Jul 2025 15:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="OaCq2/T4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB1620E718
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903471; cv=none; b=TlO/x92EtXnbPjYuRBbEvYBD64kLbn9sgn2NU1jvYd86Jiu/XDCNuhMtqQzr9nSiJ373v7hx4yYjr2qarSJLf2fdgVXHLIHBgVKPTRRehXe6Vk39Uno2yHbGmCfBMdbAeA6HVc6cbVyDxkSbkAuJikt0nMizQ/Yi0A7XIDe0VJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903471; c=relaxed/simple;
	bh=VVVX0l/wLhMBdJXjwvBvhwp4QVtRT3glhvwXyYbEs9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pU2KdBnDPRP4LEb7EtyzBfJmQLMHIrU4t7MC08KIbVsjOqxD6/wf4KVU7pQYGIKFero+7bcQbSTzRwuPyv6OxPj0yCuKTo2IT2C1V77qwoCp41U6CNjRUIt1MYlAD7/+eZZPO+Yv2JYP89ZOgb/xzbhxR5oNcjcIApLfUqyv07Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=OaCq2/T4; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-234eaea2e4eso4628795ad.0
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 08:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1751903468; x=1752508268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bX8nuaSudf4HTlD7nl8OQzT6HPtIGxyDdNBJy0yDRpI=;
        b=OaCq2/T4TYLCfZSMAwJxCWZ0PJ1nzYS/CmM1ydNlwT0bRodtZ1NTg76HgE8R/T979q
         zABxx2KrQ7DbUm7W9jqqNeA3VqnoW+OW77gchJht6hG4pQ3n1kyIw4wnAtqgfryPCfbS
         lVSfX/ELR5hu3Z5N6PPCAW4VlBpT4IoKKcFJEDq29/wAFLQFdqqc+4kJgh5OVmmprgHS
         ZwPCja59Cm1p76Tg532prM3jAxGU3+RplTjHFfhuVa4udWkEvegUL2Og1C/UijMN5Cmi
         EChV5305UjcEFhrm+ky6vRDOSG6Yym430pj7ob66qb8LgD/gVPjs/1qzxH56BkoO496O
         6ybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751903468; x=1752508268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bX8nuaSudf4HTlD7nl8OQzT6HPtIGxyDdNBJy0yDRpI=;
        b=LIyAFUNnKUiStwLXInP6wYwUXJOh+UyYEK9nGVP+DpSehwQ6O7zitJaAo9fTAUniR3
         99U2zrvjs3nozzm2TjI3pMbrIQg0HyinJ2dB/KK0s+rLL2wJR1wIslKo2tas+FRLcDoh
         /wn7CIcx1Pd8u5B9XxCQM4I6G7imWQ11wP0RmM+7e4L9DCFaD8bTgQDCj6G6dky8rlkT
         9T3EyFEX2fllzTF0bhXy6wsiaYlZaf487afqZK9p1CKQ2OHW0AXYrPQsi2Ndg3MUOy3H
         uE+uFLT7Z/CICZDAChW0dLguzJdoyDWkHJULyQ5y6Ewq/RBhLDYyYWW5NsRY7UB2nyhG
         Hi2Q==
X-Gm-Message-State: AOJu0YxiVO2UtGQ4TUVLsGlZA6JvwH/US7xyCvzYCTpJLUoR0F4QnI1l
	6vhBquBZNqINKbrUjuSJXRbekj8DfEK5Fe8/Gn+9GioIw7f5UO2kVN25fOfO9dHAUTXzyGKYHOX
	vfe7U
X-Gm-Gg: ASbGncuD/AIbRXS8/yl1Y1Uh0yPHa41s5WqLlKn2F0XQ+fyxKje6ZhwsbeRSgu2+Zv9
	UpBpafSBgwKkCWEzf9qw7S4YJrOcnA1OTCiWP21nF/DHp7UhiPUPdwQZeb2t2hsjCahMC810wLQ
	TJeIxXFteXGSzdYf6D1hOnDXWU2E6+afWFul7lkpsEOGFNvwkhtQHH+6o0lCzHHvuzDkIU0hEeY
	mKD+mzaz9QUK4y1rXwoygsOgFMQbWx8SWw6kh38S50xlADDuzwnyb5ZOZeAl4WNPtf9C4DnBKgF
	2d7uUR1Csj9pASoTELWbo2LQN3iVFAmNQFyTZUvueyIBcwsjKrp5gJcO1F6EOg==
X-Google-Smtp-Source: AGHT+IHnSiIxsn/3ZSz6Us8rp0zLkpStznUVMmfHJN6y4AGWM02wY7zbQHjfn6DT4U45/DMg1XRP9Q==
X-Received: by 2002:a17:903:2347:b0:234:e170:88f3 with SMTP id d9443c01a7336-23c87282944mr80494485ad.8.1751903467847;
        Mon, 07 Jul 2025 08:51:07 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:e505:eb21:1277:21f5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455eb3bsm95772065ad.115.2025.07.07.08.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 08:51:07 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Stanislav Fomichev <stfomichev@gmail.com>
Subject: [PATCH v4 bpf-next 00/12] bpf: tcp: Exactly-once socket iteration
Date: Mon,  7 Jul 2025 08:50:48 -0700
Message-ID: <20250707155102.672692-1-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TCP socket iterators use iter->offset to track progress through a
bucket, which is a measure of the number of matching sockets from the
current bucket that have been seen or processed by the iterator. On
subsequent iterations, if the current bucket has unprocessed items, we
skip at least iter->offset matching items in the bucket before adding
any remaining items to the next batch. However, iter->offset isn't
always an accurate measure of "things already seen" when the underlying
bucket changes between reads, which can lead to repeated or skipped
sockets. Instead, this series remembers the cookies of the sockets we
haven't seen yet in the current bucket and resumes from the first cookie
in that list that we can find on the next iteration.

This is a continuation of the work started in [1]. This series largely
replicates the patterns applied to UDP socket iterators, applying them
instead to TCP socket iterators.

CHANGES
=======
v3 -> v4:
* Drop braces around sk_nulls_for_each_from in patch five ("bpf: tcp:
  Avoid socket skips and repeats during iteration") (Stanislav).
* Add a break after the TCP_SEQ_STATE_ESTABLISHED case in patch five
  (Stanislav).
* Add an `if (sock_type == SOCK_STREAM)` check before assigning
  TCP_LISTEN to skel->rodata->ss in patch eight ("selftests/bpf: Allow
  for iteration over multiple states") to more clearly express the
  intent that the option is only consumed for SOCK_STREAM tests
  (Stanislav).
* Move the `i = 0` assignment into the for loop in patch ten
  ("selftests/bpf: Create established sockets in socket iterator
  tests") (Stanislav).

v2 -> v3:
* Unroll the loop inside bpf_iter_tcp_batch to make the logic easier to
  follow in patch two ("bpf: tcp: Make sure iter->batch always contains
  a full bucket snapshot"). This gets rid of the `resizes` variable from
  v2 and eliminates the extra conditional that checks how many batch
  resize attempts have occurred so far (Stanislav).
    Note: This changes the behavior slightly. Before, in the case that
    the second call to tcp_seek_last_pos (and later bpf_iter_tcp_resume)
    advances to a new bucket, which may happen if the current bucket is
    emptied after releasing its lock, the `resizes` "budget" would be
    reset, the net effect being that we would try a batch resize with
    GFP_USER at most once per bucket. Now, we try to resize the batch
    with GFP_USER at most once per call, so it makes it slightly more
    likely that we hit the GFP_NOWAIT scenario. However, this edge case
    should be rare in practice anyway, and the new behavior is more or
    less consistent with the original retry logic, so avoid the loop and
    prefer code clarity.
* Move the call to bpf_iter_tcp_put_batch out of
  bpf_iter_tcp_realloc_batch and call it directly before invoking
  bpf_iter_tcp_realloc_batch with GFP_USER inside bpf_iter_tcp_batch.
  /Don't/ call it before invoking bpf_iter_tcp_realloc_batch the second
  time while we hold the lock with GFP_NOWAIT. This avoids a conditional
  inside bpf_iter_tcp_realloc_batch from v2 that only calls
  bpf_iter_tcp_put_batch if flags != GFP_NOWAIT and is a bit more
  explicit (Stanislav).
* Adjust patch five ("bpf: tcp: Avoid socket skips and repeats during
  iteration") to fit with the new logic in patch two.

v1 -> v2:
* In patch five ("bpf: tcp: Avoid socket skips and repeats during
  iteration"), remove unnecessary bucket bounds checks in
  bpf_iter_tcp_resume. In either case, if st->bucket is outside the
  current table's range then bpf_iter_tcp_resume_* calls *_get_first
  which immediately returns NULL anyway and the logic will fall through.
  (Martin)
* Add a check at the top of bpf_iter_tcp_resume_listening and
  bpf_iter_tcp_resume_established to see if we're done with the current
  bucket and advance it immediately instead of wasting time finding the
  first matching socket in that bucket with
  (listening|established)_get_first. In v1, we originally discussed
  adding logic to advance the bucket in bpf_iter_tcp_seq_next and
  bpf_iter_tcp_seq_stop, but after trying this the logic seemed harder
  to track. Overall, keeping everything inside bpf_iter_tcp_resume_*
  seemed a bit clearer. (Martin)
* Instead of using a timeout in the last patch ("selftests/bpf: Add
  tests for bucket resume logic in established sockets") to wait for
  sockets to leave the ehash table after calling close(), use
  bpf_sock_destroy to deterministically destroy and remove them. This
  introduces one more patch ("selftests/bpf: Create iter_tcp_destroy
  test program") to create the iterator program that destroys a selected
  socket. Drive this through a destroy() function in the last patch
  which, just like close(), accepts a socket file descriptor. (Martin)
* Introduce one more patch ("selftests/bpf: Allow for iteration over
  multiple states") to fix a latent bug in iter_tcp_soreuse where the
  sk->sk_state != TCP_LISTEN check was ignored. Add the "ss" variable to
  allow test code to configure which socket states to allow.

[1]: https://lore.kernel.org/bpf/20250502161528.264630-1-jordan@jrife.io/

Jordan Rife (12):
  bpf: tcp: Make mem flags configurable through
    bpf_iter_tcp_realloc_batch
  bpf: tcp: Make sure iter->batch always contains a full bucket snapshot
  bpf: tcp: Get rid of st_bucket_done
  bpf: tcp: Use bpf_tcp_iter_batch_item for bpf_tcp_iter_state batch
    items
  bpf: tcp: Avoid socket skips and repeats during iteration
  selftests/bpf: Add tests for bucket resume logic in listening sockets
  selftests/bpf: Allow for iteration over multiple ports
  selftests/bpf: Allow for iteration over multiple states
  selftests/bpf: Make ehash buckets configurable in socket iterator
    tests
  selftests/bpf: Create established sockets in socket iterator tests
  selftests/bpf: Create iter_tcp_destroy test program
  selftests/bpf: Add tests for bucket resume logic in established
    sockets

 net/ipv4/tcp_ipv4.c                           | 269 ++++++++---
 .../bpf/prog_tests/sock_iter_batch.c          | 451 +++++++++++++++++-
 .../selftests/bpf/progs/sock_iter_batch.c     |  37 +-
 3 files changed, 673 insertions(+), 84 deletions(-)

-- 
2.43.0



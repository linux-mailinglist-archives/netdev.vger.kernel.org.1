Return-Path: <netdev+bounces-183542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50871A90FAA
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 01:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 614DA446A7B
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 23:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335D42459CC;
	Wed, 16 Apr 2025 23:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="hEQPI6d3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C85223371C
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 23:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744846598; cv=none; b=Nw5TB/c+BJzM3uKdprlFlnGNU+H4nTMyPgEG/feRETV0EYLG2PdWh7tXfBFlFyWVqKUjzvo83IZe3g6CunIQWLmC20zj71dV7yp+waUfJsAw/gVSqoqlS84rjePOCFHOuKlpP+5A0zROyTmnccJAnR+i4lqVeHxfUY4B9vzED5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744846598; c=relaxed/simple;
	bh=goHA5Hw2gXw6Y2RSKrNb7wu/YBcdpijTX0bsVEk0kN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FsGH7lKu38Ejq94fanOr7uwUhsW9f7VZBO8E21gHod59t3if+uiB/S84dDQQ8YgVZBDmCI5LxaIPU+qAxRsx53mfWj+fzQ5P4XG/OOet35AsgOMRrY35e2Rqp8u33sinrN+g65ITarPndgETydfOFaCIwCaraY22cwlTZj9bqC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=hEQPI6d3; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-736c1c8e9e9so20927b3a.3
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 16:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1744846595; x=1745451395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8N3A0q/+TwAtfTTu90d94V275Qbq8ozT4Nb2NOn0atQ=;
        b=hEQPI6d3oVT4rFoiNkbuOKUg2QlXPLZmvmTHtlm+t19WX2PfBppDvfCB9HYdLhgMwN
         BdkNZQHleezBPVSxrmulzN8Uhs3zdiXZQJi+8nvWIxgZZb2wb53DEbSq11hyrebPvvw9
         hnGBNFBce41lEYDuaSBGJxAAiNkodZsZ+qrduiegDD5e8/ajzr3ZkpiFhcnlkG1E+oLR
         MU8FXIfoOWqtDIoOvm2aAs9OwVdXl9TjQgXHK41PNC4sHB5JJFRfIomXXuI/x1feunFp
         ysSvw7cJSk9AGBQXF94n8JJckVQGHthH2OGI5D/nDGPOafEkheW79w/I6JP6q+6yyKg0
         vsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744846595; x=1745451395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8N3A0q/+TwAtfTTu90d94V275Qbq8ozT4Nb2NOn0atQ=;
        b=Yj9479/hXNVrCj4yp3bDJ+2Yd5VNHghgVEOOyBZKgIaMAIXqxKVnsNwwdAZ2+pdLYv
         oAKv570vnswGuOZ+bqVbGIfE8njP8+cC7z69sx70JyP/bjMlqPbbm/cGbmrxbF7c2jGO
         d5/bw6F7J3U0iEzkt+5dv1BKZs/UWpkarWqkcg3ciEQ3xigVFEPQxS5gl8/ymsNwcL40
         VCKK5HEkfaX36r6ca2H8ZwW+EnY7zLV81EsD0EsfXj55zGH8ugOUePYGcCOWFYG7VQMu
         3Ti+2xe5tFxnludjbd86d/t+T3UjKL/hIu7gcgESjhbxz5pSRbsoRYPY9192rO1i5WwS
         YJ/w==
X-Gm-Message-State: AOJu0YxmGRbJ/6+0wss/jDyPb8jMAnJzH/ADgGRwNZsYsATHUawVvl5Y
	puaQbWgczuwOSNh+90RJdouDcOQ22idNClZzUvMWo4ZcILwLfQl+BogMRuiti7bp6G0i32JYOCQ
	dCMo=
X-Gm-Gg: ASbGncvmbBnRJc60Ek6bXPRm4BvpkKTNFAMww1wh3vF333zvUff7Lrgdk3mJo/Q+6pi
	MTO21Enz2G+Jz2aHkYS4Y/RcUK6mDSbX4XG9Ycw+VersE/Ifs9xm3c9QCs3sy2nDK/sLA33+gHI
	Un7WLQbJpLm1oXqQ8Ud2itZVIPSTs9y404c2XqS0YMimqVRDPNN3cnOZP80C0KmvLHwROQMyyoa
	keF+bqaw7ZTJfnfHJZ5SEEikIyLpCnvRHCORm8d57aEvYpXcICy8G6cXXXB/SpwQrRzwIrFz+Xv
	hJCK0uEABbFMLu6HryQKRQ9fQfLQxA==
X-Google-Smtp-Source: AGHT+IFFGZ0EFt6Kk0d5M4/MDQt+C5jk/mCuPE8+QTNqltLuNSCyt314nZjD5TiKjENJf5or7wIndA==
X-Received: by 2002:a17:90b:1b0d:b0:2fe:b972:a2c3 with SMTP id 98e67ed59e1d1-3086d25732bmr942284a91.0.1744846595198;
        Wed, 16 Apr 2025 16:36:35 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:b7fc:bdc8:4289:858f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308611d6166sm2269251a91.7.2025.04.16.16.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 16:36:34 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH v3 bpf-next 0/6] bpf: udp: Exactly-once socket iteration
Date: Wed, 16 Apr 2025 16:36:15 -0700
Message-ID: <20250416233622.1212256-1-jordan@jrife.io>
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
iteration.

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

Jordan Rife (6):
  bpf: udp: Make mem flags configurable through
    bpf_iter_udp_realloc_batch
  bpf: udp: Make sure iter->batch always contains a full bucket snapshot
  bpf: udp: Use bpf_udp_iter_batch_item for bpf_udp_iter_state batch
    items
  bpf: udp: Avoid socket skips and repeats during iteration
  selftests/bpf: Return socket cookies from sock_iter_batch progs
  selftests/bpf: Add tests for bucket resume logic in UDP socket
    iterators

 include/linux/udp.h                           |   3 +
 net/ipv4/udp.c                                | 155 ++++--
 .../bpf/prog_tests/sock_iter_batch.c          | 447 +++++++++++++++++-
 .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
 .../selftests/bpf/progs/sock_iter_batch.c     |  24 +-
 5 files changed, 574 insertions(+), 56 deletions(-)

-- 
2.43.0



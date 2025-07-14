Return-Path: <netdev+bounces-206806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3499BB04725
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 20:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297951A6118C
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D49026C3B8;
	Mon, 14 Jul 2025 18:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="NU0ssmkK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F5126C396
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 18:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752516571; cv=none; b=kYYnezbNoB4aj/4+FjNvtZbW+OdSUnciJ18VTuISCZbV9JLdapFrE+NaSzGDaEhz11VLzw6XhuguLu/b1F7egBjuSeoQfIUSrjYMw0rY3GzkYBN8Mo3sIuolBtqRF7PeDMLLJUVRikSbrrD/6j4dUTI6ioXVXsf2LRbb63B8e9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752516571; c=relaxed/simple;
	bh=bxxFogUP1oFJd3d2e7LXv1WV66TV2hKEyk3AFHWrq/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J4Br66gwtgpV5NPBmojdDJUMf9UeqXfBsrMUbfzYkVG70qNzETkZuqHNc5yFnHBCVv5ZyFPtpYO+n4yCRurHe1Bdy0Zag+K63m60Z1hrzv/OP0yq3fkCOM9CTinDcuOBWnXV7RTkw5nX5nWdhFs4opqkLUBUS5/tBCz4tcoYwmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=NU0ssmkK; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-234eaea2e4eso5746465ad.0
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 11:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1752516567; x=1753121367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UCIeepe8RfVctcxWkoxn2Xqz4Sfp2ySYQyPBvgJjOjs=;
        b=NU0ssmkKYBbFwRT/7kFXozy/eZUK9eUpLOkxPIpUpu/7JM905uhLuDL0SlR8L+ZJcd
         lHOnAK6UG45gYFGJgdeQr8aoIyQDZ8+44wv6W9Slr9Fq/SzdKfkn1lczZ9cLv8DpIbyK
         IlMMPC5iyDSuTD5v9ORR3P6lmq4C5JxP9Ny8Lrnvw6eUC0qJpccsaO2v7S/yvjvNIh3P
         Hvee9UR6RbqFKBN3+kd3Nxnbd7/rah3Zr0Y3Rnaybfzlke4nDuqjOI18/IJOyNpIv9rG
         VWl3FsxyhBGT5z0XnFspLpeXhFK0YO7OodxMJrY3SXgrQm864Ko5Wgmn/KsLz4a58G5g
         I01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752516567; x=1753121367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UCIeepe8RfVctcxWkoxn2Xqz4Sfp2ySYQyPBvgJjOjs=;
        b=J6RV4b+y3xcq5GfB/h0U/a1Ovf5t6qDDS9D5L8eS9Rs1iwS3H0m/UG30ncHHYpapEM
         zl0gqoAPnxSyv+Y5DJs08xqZAs0oqLP+J2VpHXxw30/9oL+Zlu/f6RaDEPwpwVxIZ0cX
         ENXiJG2FYocgSp77vLVyMLji+KD5bMIJzckqb8pZx3j3DiFfl4DuwfssYygzu4KMFH8E
         37DpWmN/t9RH4cEAZEeLDaNwhTtSM3rAIv/r94XjjFHo2JcZacPTysPwn4Q/A5mdtjSa
         nlQCm+6dhfatawvVR3CxTkw8zmRWjidiXzfzSNqytoIT9syNccubmq20UXe76s9wOl6T
         45Iw==
X-Gm-Message-State: AOJu0Yx0Kar1Mg6LrrCY7yfsf47kTaPJkMTlTIorQi3p8Iufyi1eQsXq
	CM5KBpdyIdxaYW7J2zPeU0ggmjZ0IjeGQmLz8FfK19QypCjOIwSepH+8piL49jL3B8B077SZjzO
	e4e91
X-Gm-Gg: ASbGncvKxMGUx5IiP6VS1kfDScfW1r90NlWJx/IS0S78qW7yAJCA2WiNNafQZ44xeXO
	eWGhAnAWjALI6UStpbZ4FZusR+eUaHNMeau6vzdgr/RbtGOnOAQMT6JlrbcjPU3H5GXrVtrRw7F
	6vXbtt1TO0LPmdABI8YtGRVMRSe/QBhzru9/IvTnSau+ehvR2MHSnzTiTX2ZF2v2Qc/6MUeXprX
	aMXR49otkW4h/EWc449PmLwdltrtwqEw/mjWVfHPffqxnUBR9zZhktHrVYU3H4DwcQz4okiWc+1
	0F6qOCqvLr93xfGRKv6VIGiAV3yDKc9/ppWEFMbJ8BOk2lIE3hEBA6Vj7672BCpWPqvD4KV79CW
	K5Tk0EEH9cg==
X-Google-Smtp-Source: AGHT+IFzfrE5MqiPgJJWw1On6i9rxwd3VZ8RAZkUcfW6mxZA8sYTKwvf5KmfJzvI9R/s/mBJUFtFww==
X-Received: by 2002:a17:902:c40a:b0:23c:8f17:5e2f with SMTP id d9443c01a7336-23dede497e0mr85368255ad.4.1752516567327;
        Mon, 14 Jul 2025 11:09:27 -0700 (PDT)
Received: from t14.. ([2a00:79e1:abc:133:84d3:3b84:b221:e691])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42aeadcsm98126405ad.78.2025.07.14.11.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 11:09:27 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 00/12] bpf: tcp: Exactly-once socket iteration
Date: Mon, 14 Jul 2025 11:09:04 -0700
Message-ID: <20250714180919.127192-1-jordan@jrife.io>
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
v5 -> v6:
* In patch ten ("selftests/bpf: Create established sockets in socket
  iterator tests"), use poll() to choose a socket that has a connection
  ready to be accept()ed. Before, connect_to_server would set the
  O_NONBLOCK flag on all listening sockets so that accept_from_one could
  loop through them all and find the one that connect_to_addr_str
  connected to. However, this is subtly buggy and could potentially lead
  to test flakes, since the 3 way handshake isn't necessarily done when
  connect returns, so it's possible none of the accept() calls succeed.
  Use poll() instead to guarantee that the socket we accept() from is
  ready and eliminate the need for the O_NONBLOCK flag (Martin).

v4 -> v5:
* Move WARN_ON_ONCE before the `done` label in patch two ("bpf: tcp:
  Make sure iter->batch always contains a full bucket snapshot"")
  (Martin).
* Remove unnecessary kfunc declaration in patch eleven ("selftests/bpf:
  Create iter_tcp_destroy test program") (Martin).
* Make sure to close the socket fd at the end of `destroy` in patch
  twelve ("selftests/bpf: Add tests for bucket resume logic in
  established sockets") (Martin).

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

 net/ipv4/tcp_ipv4.c                           | 269 +++++++---
 .../bpf/prog_tests/sock_iter_batch.c          | 461 +++++++++++++++++-
 .../selftests/bpf/progs/sock_iter_batch.c     |  36 +-
 3 files changed, 682 insertions(+), 84 deletions(-)

-- 
2.43.0



Return-Path: <netdev+bounces-199134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB4AADF28F
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 18:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC91C4A2F44
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 16:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1FB2F0C65;
	Wed, 18 Jun 2025 16:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="Gz77tB45"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264D32E9ED5
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 16:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263952; cv=none; b=RgtNd8MgTYL/uzUy2YPZ0n9A19uDlKcqcUJ9HmpFAlE3w+TD33GGIE9JVad5+Dev881XdRpSq7HblPqceEG9taKyibTq7G6B1UW97SUtvZ3mVHoq1VVtwPXg2E4v4L0gPDDlZTfr6amcamZqd4yyoGeOBhYMF3278we7IkONa60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263952; c=relaxed/simple;
	bh=Xt7U1x3SkNTaDSR5L1DVqg/uyQUndXVGHRE3Zd14eVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SCTLn/QAjWhQkoRa7wLHwQApfMKCdnDDWsrAVd8MW078p3prt9EIcRLB8QgjLRrAAnMHbPthlitj/bC3dT29CYjR6hdKKHgPYwuCRAUvRQf8FKGMxFom7q08x3FgsmOOjNeQbMc7IohxNDk3VkFW/AT7/48YeouUcdRiQ8mVWWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=Gz77tB45; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-313336f8438so1404896a91.0
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 09:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1750263949; x=1750868749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=81pEAwXmixuxAF0u6MPMjW9qRqViI6uiK6RzRIZYnIg=;
        b=Gz77tB45qW8OyP/4AtWTEBommtgPvGbimohXVdYUrOqdOKcuE75Fpciyy0ED653+7K
         8ez+roM5+v71PtjCpk57TemK64zMcDgkwGOKflM2qL+e8POUEkhvW5y0Omj1vv4zJlHn
         3mGTo1L4f6vewU8UNr7JUMMbVFzrFcEVHtJX943uj4zUVJcADEhA3sdZTxzXtQtm8cIW
         IXDg2Y/qOjVXlzHKSO34xAo3eodwEU1F1vO2VFfzAGKmBq0hRaTBM3t+XMZr9hplolj8
         D0DvRki5JukMSyJgEm879QgTZ9SKRtN6toHNQ+s4aCHHYW4pm9TJ6a16a3JtWJ8t1o83
         LnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750263949; x=1750868749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=81pEAwXmixuxAF0u6MPMjW9qRqViI6uiK6RzRIZYnIg=;
        b=d8BG09me7wV79V9YCIM/FZfGf1Nw6qu3VYIzJqxONxUnsyPI6L4bondXmkQohUU+Wv
         Sq2fdZKK5IcRnbm5Vgl4Az3mTjO9Fjhx2GwJoWM6F4BU8Fz0qtZVFaJed/kfbR/Nr+ws
         ef1OWSU0dei7I/g9RLlvS0lgQAW6PU1O9hKoSvWw3BIVmJn7USnS+zVhxmER7UAz8lp5
         82puCCwVjQaiElEY6GQn+2O5lZUG1ybL5v5en+ZADmppClc5UwCRKJPIxeo0gfjfGbKy
         jbTu01RGQg80h4gxy8TrvtiXuQiIApifIJI9frPeHrA/UGD7s5hGiFybtI2+GG/dYNsc
         dUzQ==
X-Gm-Message-State: AOJu0Yy5LqDxwCNYssCFsZEKz0qX7wwDtVXhYCZe+C4xHlHW7CMNJ0SE
	k4i/UGYDIyjAd0WVH6fnVnv2TZiRjRqnEH6EN23VH7aDVEOGMgw6FLE+nViHHabnYP5UhSjafnq
	U/sbfcoQ=
X-Gm-Gg: ASbGncvcOk09r0RjYcU7OEqltOCdlYLK0ojQSmVHNiZaXNUs15LEs0pZR6opG5k0fTm
	PJHMyQTJs/w3XqN5rkb03ReoEe+7L5tmgG7pUbqSOSPcrIgsUd3yMb0oA70rM4J68GBNUPQOw9N
	lOXzTVSPGjYr4SZtG2ME6R2zkEHdUhRMwHxD26fZ45XzsZI4gPwDD+0g6PYN50hYKj8RuVzhuYO
	FxJxNcxnv19Yajj83d20/BSybmW6ccR8zDf0nhynThtvnpaLYMAIL/q9jCbt//jkbPUHeGiB9Li
	dVzO5nikOmgn/27tNbBSWAf8/uD/GP+2pZ+Q42bd6H9bjrz6Bg0=
X-Google-Smtp-Source: AGHT+IELPUoe/0lbZ51Ep3CRUjBzFoOI7DQHZMtTAMEPeIerj8Ci4FOU7fjbN+PdNVV9TUydT51TQQ==
X-Received: by 2002:a17:90a:e7c3:b0:311:b0ec:135e with SMTP id 98e67ed59e1d1-313f1befc7dmr10086256a91.2.1750263949142;
        Wed, 18 Jun 2025 09:25:49 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:d683:8e90:dec5:4c47])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a2768c6sm137475a91.44.2025.06.18.09.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 09:25:48 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [RESEND PATCH v2 bpf-next 00/12] bpf: tcp: Exactly-once socket iteration
Date: Wed, 18 Jun 2025 09:25:31 -0700
Message-ID: <20250618162545.15633-1-jordan@jrife.io>
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
bucket changes between reads which can lead to repeated or skipped
sockets. Instead, this series remembers the cookies of the sockets we
haven't seen yet in the current bucket and resumes from the first cookie
in that list that we can find on the next iteration.

This is a continuation of the work started in [1]. This series largely
replicates the patterns applied to UDP socket iterators, applying them
instead to TCP socket iterators.

CHANGES
=======
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

 net/ipv4/tcp_ipv4.c                           | 263 +++++++---
 .../bpf/prog_tests/sock_iter_batch.c          | 450 +++++++++++++++++-
 .../selftests/bpf/progs/sock_iter_batch.c     |  37 +-
 3 files changed, 668 insertions(+), 82 deletions(-)

-- 
2.43.0



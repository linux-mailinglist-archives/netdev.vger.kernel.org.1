Return-Path: <netdev+bounces-202605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 833D9AEE576
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 19:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40FB87AA9BC
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 17:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B945B291C30;
	Mon, 30 Jun 2025 17:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="2wTH/+7g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DF2221DB5
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751303850; cv=none; b=n2BIVCrwLUQdMRJ/PYw+y4eVZ+mP85Gwc3KnbNl624HkFaLSB999PvHZkL5v0r2Ex1UJfR7aymDmyPZCBURefIwtSQKH52vsBpopGPYmqv2/ri1U3SeYZ5mMEQ1rlpJTDCpoxQEDFIB1iR39z2xO4NW+p6A7R58M+OwPMOjCL2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751303850; c=relaxed/simple;
	bh=0V9/Wy9V1PBoeqDc+eYGtxxOQzc3Yi1C1BMEgN04Dcg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R48I4MxFV4YoyF64vcwQff5U7b4HxS9hDb9/s5PJkfmxpbFROuSlM+HhXF/JbiNHl+jFbBeZwL/PEHyxNjQIgb7YLJpZCBCTL7FZjfmOXDO7UMLGzNYVHrE5ySfPcxzSVRtarkW6jjIrak4uYzTGoFRk/KzOHlgePx2bZObYaCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=2wTH/+7g; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7493d4e0d01so356288b3a.1
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 10:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1751303848; x=1751908648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hU+OEqHDQSCVzx+Nj7vxPurpCRjZ8fafcjXyz7/7EGQ=;
        b=2wTH/+7gkw4WPe7qHF7jlCzQTXGVqfhbIr9mnu1k9WsblqroLTu8ofKmUTvpgAPRaR
         GR9ARgVwcjqIgEJkkqzbcLV1Msrdf26yp24oBnYMjtYItYtIk5DUxEShxYNdB6Y9Hd5c
         ohZcIdM8VgRzK7vmrcaK7igvOyISfjsQre36/idcJJgdgy8hqRUJwrX/1cZW67ewhAyb
         AFx5rn4snxAOuxFvYNxok6SV131yj99EzlPmCzGCH/B+CzhNO0b7f1taS34zV9FizPKC
         wbVW6iQAEV7jGUYi63m40xR5eSG3+HLhaInPPjdffPBg+A7+QGzIybHW1HIbHVcBwkUP
         XzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751303848; x=1751908648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hU+OEqHDQSCVzx+Nj7vxPurpCRjZ8fafcjXyz7/7EGQ=;
        b=js31cnVCDyTRgAFqxkO/2WuQmHMzAr3ViOEduYPEgNG293FUJk+7Bb3I4sYC7P0rME
         q3DT/Kxw0t4a2Vt/X5giaFnHYm4BjdhmhV0PzqhpIjNdMHmr71/Yf4LTvpGRnL2OGsWL
         FX/V2a6Z5kX0ZiypM8BhVn6rvEQi+1MRIPyPllbXU9MhFJ+e0pRxi5YMn0M/OSbI1In0
         Gc4QYtb+x8RCV7cjoWN6LJVILyxk9ZKbnusqOPEH/sXBKRtkDhLoVEkptq0Xl6S4EmU8
         +Ac6LSHKFL8+dIR3Rwi4mfWFLDsaMgbEGvbMN15ofI7G3adr+/S2rkV5/l8NwIgaVQ0P
         xlYA==
X-Gm-Message-State: AOJu0YwejkZ4LpWcSAVeApTk+JcUzLnxwI1StXQDFnJXn/RwO6M1wKO1
	ODaydqEO4GUVLsfa4K8j0O5BrSnujG6Osjih8ZYPl2G9SUvL1rbxQw7WMdLaaxdvAPmh0JQqGKu
	FfYNYle8=
X-Gm-Gg: ASbGncuJc0ZvyrJkifq4OPDLk/ECaLGfoYCeB7gt8ZCCx/Mpr2sMSShN0J9NbqMqqyG
	CFHkc8fs42kqYUipEf/qogCueQQ+EsIuvdWL1vwDONoeD0gClLPtTerdjvDXKpicjc3TmZagGt8
	apFqezNN4jZfR/J3xFFgJFboHecvf8oSuStKcn0khDy7u7QyhF4QSSEuCuqK4x6AjDLbzB3MNoR
	isnHx8Y1H8razS6NThnYSoYR3TbKbXM+mhS3FcgdlVVg3QxbCXF26TsWtphA/BLunLpdhyncve3
	HZewsBn6PCqd2m72rGbqTGG7GyaI3ugpR+lHCzOyJC3WZ2AkCw==
X-Google-Smtp-Source: AGHT+IFscHlz0QS5fCs941fk5qk51h+qNURvUtDSfTGEOFPa2p+ltX23z4PHJVE4uVl7546QFtwyrw==
X-Received: by 2002:a05:6a00:2455:b0:740:275:d533 with SMTP id d2e1a72fcca58-74b0a66f70fmr3705851b3a.6.1751303847616;
        Mon, 30 Jun 2025 10:17:27 -0700 (PDT)
Received: from t14.. ([2a00:79e1:abc:133:9ab8:319d:a54b:9f64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af540a846sm9229232b3a.31.2025.06.30.10.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 10:17:27 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 00/12] bpf: tcp: Exactly-once socket iteration
Date: Mon, 30 Jun 2025 10:16:53 -0700
Message-ID: <20250630171709.113813-1-jordan@jrife.io>
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
 .../bpf/prog_tests/sock_iter_batch.c          | 450 +++++++++++++++++-
 .../selftests/bpf/progs/sock_iter_batch.c     |  37 +-
 3 files changed, 672 insertions(+), 84 deletions(-)

-- 
2.43.0



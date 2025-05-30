Return-Path: <netdev+bounces-194431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 052A6AC970A
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 23:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A67991C06C87
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 21:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5D4218ACA;
	Fri, 30 May 2025 21:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="iYnByFLp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46368211A27
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 21:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748640677; cv=none; b=KYNuGatsQQO4gtuPzkJpgtpGYjIRdJw9X9nfpDxQqHZLf0O4z0IDhw1BVrTKHEc7FbXxBCaQfu7vU6iIfG29FaAHIhTFg8bkB8g6gstG8EB5QgQ8Ok+HG1wWKQEaMPfA+DVBRjSUeB1ytk5SlDS5iFPj1szppVO4BUwyTWXe/3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748640677; c=relaxed/simple;
	bh=Xt7U1x3SkNTaDSR5L1DVqg/uyQUndXVGHRE3Zd14eVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sy/CvJSI2ezVjEdLRhG1+y5rRSilvf3Z68XBp/GD7YtFf7SeSTSDX8y2GtGBz8eLxvoeaWkqESOrFwPpMWPEn3cmvMIHC/+6OrvddNmMIoq8FX2KV5IaP+L0uMtimlKkV50ZBGBH5ot530dKTd5r+uHNzNZS8SXxoSnGJZbN4TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=iYnByFLp; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b2c43cbce41so333815a12.2
        for <netdev@vger.kernel.org>; Fri, 30 May 2025 14:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1748640674; x=1749245474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=81pEAwXmixuxAF0u6MPMjW9qRqViI6uiK6RzRIZYnIg=;
        b=iYnByFLpQ2unbJPdd+hbFJY48Jsm9x5z7mAgEAvr9e/BN+D5vAE41rPIQv1a3lyeK7
         KtDenp5sBOnH7P2n0nN7WjKZbDsGnwDCIRoAUdrQj+I9iO6G6HPgz567wa/IEb1p4+SW
         ENZe0m31OrNtVZ2zAa0VZtMMzpxp4cIHEZsCgO8wIPhIejyOPRCiIqJ4LvPdfFVn5IK5
         CK7CycN/FCowU75GCoatFJAT3/kqOg1RTMFBcKrPmSfXzplS1EXq8NGcdOcDtpgj1WP9
         gb818z1L1/7fH29ftWUv8wfui/uN0euMCahFf/slemETdAFegf/2G0t/AWNamJQ2sv6h
         jgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748640674; x=1749245474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=81pEAwXmixuxAF0u6MPMjW9qRqViI6uiK6RzRIZYnIg=;
        b=T6bQFhPbiwF6NhVNXd4Kz5+UN6JSySj6kME/DBynhhHIzSaKYkQ7ElhtxCUzGUSlQF
         WrxQ0t8UbgYNyaWX69CHRI7/Z1zv2oPaUISoWQojboHzFTfypEQiVJljvFujB7OmHQRS
         A5lT4mgjCreVj1ng8Y0a2WRrVhEC7vdgO7VdAyH1EKkrROBPYIZRMCX7a666LIruw4oI
         gUs+Se0BoHo8gyPJYpROHzTxPwgKVEeKo5AX5B9FTmnOvIarLXncJ2Z62Cs48bll7679
         IQhrLyoSReegNMkj7AaLf6BDUTJCRmU9TtY8c3BKlZmYftGgWeRw+011WkL+KraPDDN/
         JiJQ==
X-Gm-Message-State: AOJu0Yx48360j2ruaLpRJkWLIi5lF/yLmG/WnhIkTZkPfV21UBFJ6XNF
	+EJCJyzA4biN9Pzx6GN7O638jYgDvZnUDPcjeDBY73UB3vWr+HxD4gJzd12DEI33D1ZoZ72PUTy
	92tJ7938=
X-Gm-Gg: ASbGncthLZuvbQBqlNmGsmTaWf1+/BIulP0ca4Q4BYC6BmuBuc80wD2GtswttXMU+9K
	CrrbwJDwKNo84an9tq1YAm/jzwEVoWV6JDBoHTcYm3K/lcg1t+cCTE1khNFqx1hgu0OMWLYUdId
	ONFj+HSt42hVwAlVjeDEhlQ5jWRLmuOzFtX1Y2MuWyqYrFRNl8sjWDgcidO38UJ/tuTHuN0KpRy
	6fPXalAvy2YRlbItyiKVDgBPq8nIYzMrDjiC/kyOIlg6n+k+NxwlguJ07AeOwYCpGHEtdXb8R1Y
	l19lZHaefJkc/fO0klZ9FyDvSqt31U3AO/N8KEFS
X-Google-Smtp-Source: AGHT+IGInKghMC3FVP3+MvP9tl2QdYAbj0QI/SPMlxBeXh7/RCRQhPksSTBDIon4fv0NeHdAXgzyGw==
X-Received: by 2002:a05:6a20:12c4:b0:1ee:e1a4:2b4a with SMTP id adf61e73a8af0-21adea18fddmr2143955637.2.1748640674106;
        Fri, 30 May 2025 14:31:14 -0700 (PDT)
Received: from t14.. ([2607:fb91:20c7:44b2:2a24:2057:271e:f269])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afed4399sm3496763b3a.77.2025.05.30.14.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 14:31:13 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v2 bpf-next 00/12] bpf: tcp: Exactly-once socket iteration
Date: Fri, 30 May 2025 14:30:42 -0700
Message-ID: <20250530213059.3156216-1-jordan@jrife.io>
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



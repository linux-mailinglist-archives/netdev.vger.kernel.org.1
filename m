Return-Path: <netdev+bounces-191912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8C8ABDDC8
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 992217A6176
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 14:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929371FF7B3;
	Tue, 20 May 2025 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="i3CSniWs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB6A1FBE8A
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 14:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752679; cv=none; b=IH4869ZchNAecCKKbG98HQxVSHESMF/tz2l+Mo/Nht+tfTmqVqbsZkWjvq5dYvpd1fkEBzxq3z8dwplvEbzNHogZdYSv0R68Pnh+6OVDUyIEd3RuHRQllUTLVh77ah1Isb7jvckP8N4AUKEl4hz2Oafb9A6yFQIolAnUdtEKd7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752679; c=relaxed/simple;
	bh=QEiO8wsCK+qSOz+gK2YWUcQImrIEqec71zcGhBthLRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C2K9IRqI3KPhcCboiQNYzOzSzbigubym3zn9jEPEHV65Ap8UVd1f6yT4UMdxpHuSt+LPXFdQgibjf5P1+vDTKaUKQ2cygKCT2WkJDOnoCzBvOKOA7F7JonzMR9CL1oySMuB94TNMk+pATVOpATh6bWyMKOt6CsXO4EHXWrj/pgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=i3CSniWs; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-742a6f94f4aso625355b3a.3
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 07:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1747752676; x=1748357476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CiR/JZnsukZe0SXagOMVdueqyVBVimMB2RijeoqPgRQ=;
        b=i3CSniWsUzalNyWr4CehHOjxoIi82ecSyxSFdN1U5cRz4Wetgi0N3lMw20B4wiyoLR
         YoaMhMDqpSbKu4U0xCR7uYlS5FtijhSmDYlk3EEcT9E/HK+MvFmHNeqTUrHEDsGRZL41
         rXinberXw8MD1aqyZiTp6wpVGhvkFZyiH4BUYF1jLNookXkXfOzuLEt8MEI2qaJtGmzS
         O54eE9rCG2rNhBqBgt5GHLeQoNPBRKLiDbyEh2uilyRsoObSa1lLXrKbfjETHy6CW4/+
         Bx+UbFhUZE2D7SBOZvla5zygK8goYDfffIChII+we3EvIGLFalVzobr7OaD5LGI3waPj
         L1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747752676; x=1748357476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CiR/JZnsukZe0SXagOMVdueqyVBVimMB2RijeoqPgRQ=;
        b=c63bHRWDgl1N5z1ZGOPinvCxdNiSg6SxseoY+fBx8SwF1ptbOiAWeyq1GPLeiPLkwS
         /n/ACd3SfuMuMtAnBDvqMqES3mAosPNJgZ4NEcq/v/F2AdgnWTDg4RZUGcM4Z/E7r5Ce
         toN+Kau58goR+50zu+KLYyebN0ivOr7Mt5o1/f7KMHt0yF2qEBapO6HasP+/g6m2p2JH
         hMBpnl0v+vrnVlXgV0gIMVc8j7sDydhK2RdYKv2hdvTau+JAq00UfI5NBWznoMVAmgQ7
         q72wfVoSKtqsI/es+c3+27vKOd8KWSKg1bGfKA3RyhbycTjeqP1TsgtVtcPCY+NQrhuQ
         TJVA==
X-Gm-Message-State: AOJu0YyjD2B7ow9InMFTWlDiRlIOE895nrbVsqa4ubUp1ocCtb9Fc5V6
	51yG0U4ArXQFxH5/g6Hnu72OcKeTO6N9s3IcF/rzdNfUETrYInXvBcpgNVAbUmog9Uu062Rxo8P
	AUKTrhks=
X-Gm-Gg: ASbGnct2vS+hw8k+nOCnBaP1pqMP55bIl+FDIcH69iQXNhy0OoSoyAN8V2H9AOEhYFf
	MIeO0TwbNtAs8+sVPaMX50AaEddp7VAn+hGemtuAhxQd5UNLdcuMqsm0rgCpGwcDkn2H8RAdBgk
	64iaE406o8rfZ5tDhi1u1hgcjMWhH2DVxwHrjcvEmC0tga3YeMRwMzKdU/FKhEWJ5nQuba+racg
	pLzI0ewac+0jAb4qQloxqLq0i64jDHNziQH2U+XWupwgxf/aQlHBLOAHlxlMPYlAp32jsJBJ8Ch
	U5ZU41OS5xgB/pVJoqeEvvvHH3ZtNUhzZ7TbQoCs4GG6/6lOW2w=
X-Google-Smtp-Source: AGHT+IFcA3Js4nz8WesvZtoQqiLsibsJmuFCNOv5K54B+dMZNmGnPSoxGYC5H05u03BOLMlqvphNYw==
X-Received: by 2002:a05:6a00:2790:b0:736:89bd:ffb9 with SMTP id d2e1a72fcca58-742a961344dmr7102688b3a.0.1747752675898;
        Tue, 20 May 2025 07:51:15 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:276d:b09e:9f33:af8d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829bb3sm8242993b3a.100.2025.05.20.07.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 07:51:15 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v1 bpf-next 00/10] bpf: tcp: Exactly-once socket iteration
Date: Tue, 20 May 2025 07:50:47 -0700
Message-ID: <20250520145059.1773738-1-jordan@jrife.io>
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

Note: This series depends on [1] to apply cleanly, which is currently
      available only in bpf-next/net. As such, CI may not pass if it
      tries to test on top of bpf-next/master, but manual CI executions
      on my branch that included commits from [1] were green.

[1]: https://lore.kernel.org/bpf/20250502161528.264630-1-jordan@jrife.io/

Jordan Rife (10):
  bpf: tcp: Make mem flags configurable through
    bpf_iter_tcp_realloc_batch
  bpf: tcp: Make sure iter->batch always contains a full bucket snapshot
  bpf: tcp: Get rid of st_bucket_done
  bpf: tcp: Use bpf_tcp_iter_batch_item for bpf_tcp_iter_state batch
    items
  bpf: tcp: Avoid socket skips and repeats during iteration
  selftests/bpf: Add tests for bucket resume logic in listening sockets
  selftests/bpf: Allow for iteration over multiple ports
  selftests/bpf: Make ehash buckets configurable in socket iterator
    tests
  selftests/bpf: Create established sockets in socket iterator tests
  selftests/bpf: Add tests for bucket resume logic in established
    sockets

 net/ipv4/tcp_ipv4.c                           | 262 ++++++++---
 .../bpf/prog_tests/sock_iter_batch.c          | 442 +++++++++++++++++-
 .../selftests/bpf/progs/sock_iter_batch.c     |   4 +
 3 files changed, 631 insertions(+), 77 deletions(-)

-- 
2.43.0



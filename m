Return-Path: <netdev+bounces-185322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E43A99C40
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 01:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC8FF3ABC6A
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 23:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A0E242D84;
	Wed, 23 Apr 2025 23:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="XdIhiWcS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED80D1FECBD
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 23:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745452290; cv=none; b=I6O5oU1lybK6irtHOPpTFtOazmpysAPvpf4IBD976oLsU0mSpY/o0Taru41iPPEoeR/6oOo3B4GNLaW9DBdnelFJpbSIXxZtos5QLPJRZbnjVowvszmm8vg1VtKdoAMNlpSQ/lPJr3YQoagQVDxcWg4zFRjkI3i9aENDscOl2Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745452290; c=relaxed/simple;
	bh=ESq12MoDj0n1gSGYk55mPV1EuKJQEQLEGWNKf5vXWgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZKO4pRS8DYb+TpWs+PdXUSk7qhwCoSBPb1QdUAF18oGr4ESrxae2Vvb63qlJVKMVP1dcPDgZQCfjVUnGS40lQBzmv3rY23OFPNnGbgPaMfvLzKXPJNYnJhn4Cg1WYijzCbBF3EMaDjWYDonKaMA01emR0HNDfTRzyQT8uAuzITk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=XdIhiWcS; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2240ff0bd6eso808245ad.0
        for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 16:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1745452287; x=1746057087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/AsBOsdnsiqKNxklBct/cUcMShwyJwNdUbI1HKP1v+E=;
        b=XdIhiWcSysoP19MFh/boBLdN4616pN/VPHBss9FoMdOtibCyvWyecXc6esACWWo5im
         eT9STEQ67BoQhk9ZNMgEuaq187NsI7y/AqksJCApA6W85IclH1t/8Mf6I4ckevwRIXz5
         tK/M0+AakRwwd3UITowe/hzcR/ZEWu3i0jK1PVYojjdZ2uSlfOcjegfoizXZvhM0YYhC
         lLTNXHto3hzrZ4Ja93S//xJC9e0tuS1v6hNrDOV46YMu0hLXgd0C1I2wSVL2nOUsFWbY
         AQVPTT6mrLdgftyNZiEryvTExQ+WLl5tax4ZpK7530fGua16vkv3WJddvxaf6xyHwO9t
         VzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745452287; x=1746057087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/AsBOsdnsiqKNxklBct/cUcMShwyJwNdUbI1HKP1v+E=;
        b=V6AOH1qBQygmKzzcGOb3nyRq4eX56oRFFVcfDw3lIembgnUQ7rg9I5PflvfFZYufFg
         XKJkZwVp60J+T3uTSeECcRC98rb/GkFgDiq46PnyhPWYPoNtV2aG9bR0PM950sQYK6ve
         VHuhbMRyWI4hLb8F2UEVBmGbNnrqEDcj85PPQ9xf1WopZ9Fc9G09aEW/uReeS21i6N3i
         6oD9zz77j/+fu6V5Zi+93lI/s9qOtanCXCgSvvM24Xwj61XkunfHUybA6Nogfr4LorXA
         q+raGXn11f4D9+OxwD7pFIGKdHA9ntwta57tlGTD5e2D4kI79CncUO12ctxxpDwUqtIY
         8UuQ==
X-Gm-Message-State: AOJu0YyuOoNa3Y8nkvxlooeKvIKlA6wdHKFu1CdjBVMvcUk8LmQuvZD1
	4uEWq9dK7dxbJW+QAI7qEFTrY3ypMVztpnkd6OMWnRIFRSyBqJBs4Ku3UXTalmFnYEHZbOMnhlC
	dTYg=
X-Gm-Gg: ASbGnctTt6G454rb3b5cnGrQLPOUnnI37s8MScW06WUWloq3gOfHib4v19nUzJI+MZd
	eg389IYkizYry03HPURTiP2JCvQwJsLwaFaf54KNmcGip0kki+VgTKOKe3xqYxHRAxKfmKokDcx
	Z8mibYJw9NLFm4w68fJpZqob0RAY3c2otnNtg4XsyHvFVSVIv9PZr+RTNA16eTT7uTKUUZsBgV4
	JvVWH4fWJqFT02VAcH42NuhfGYOSDJSBTcoyBshPyu3TXVKa9PUWpBrqL3+N/neZKSAoTUjK6he
	urPVsQxplMIf2g61eoX6ZgSw4Bry1xNwmIvv2HMD
X-Google-Smtp-Source: AGHT+IH5/OcV01UlRW0unD94pA2OsRTYIKucGtgHihQP93ogW51ZdQffJ0OAzzVGwPD2y3Ffye7BTQ==
X-Received: by 2002:a17:903:1d2:b0:224:1785:8044 with SMTP id d9443c01a7336-22db3be6885mr2418035ad.4.1745452286757;
        Wed, 23 Apr 2025 16:51:26 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:f4b1:8a64:c239:dca3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d76cfasm499175ad.47.2025.04.23.16.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 16:51:26 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH v5 bpf-next 0/6] bpf: udp: Exactly-once socket iteration
Date: Wed, 23 Apr 2025 16:51:08 -0700
Message-ID: <20250423235115.1885611-1-jordan@jrife.io>
X-Mailer: git-send-email 2.48.1
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
 net/ipv4/udp.c                                | 151 ++++--
 .../bpf/prog_tests/sock_iter_batch.c          | 447 +++++++++++++++++-
 .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
 .../selftests/bpf/progs/sock_iter_batch.c     |  24 +-
 5 files changed, 569 insertions(+), 57 deletions(-)

-- 
2.48.1



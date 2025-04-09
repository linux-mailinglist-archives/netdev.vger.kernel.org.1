Return-Path: <netdev+bounces-180908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE900A82E86
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 20:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 647547AC9E0
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 18:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D862777EF;
	Wed,  9 Apr 2025 18:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="wBW8r3ko"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F68726FD88
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 18:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744222967; cv=none; b=V2z9g1toCT/so+PWoEvobtsslfDvT33Liu61t7RNsp6Y6aem18rj73Gt1X+lpfCRY2yr0Vfnc55QEpBH6J4qqk4kNqu78BZ0srtWdtJohMne/9G1M6TZ29swZHw2XmY59yf4NWHJLRRBba/oXg06do8ndBtQRhLljkfOXdonpH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744222967; c=relaxed/simple;
	bh=asV59gizBv28GYBxQFhVdeBj72VUNG4eA59XM+R9eGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qkt48mnvSmZB2bTF0CaCLEpsqdPAIADV+4P062VXTITbV+e9FFu/WzqTBrLu/cFx0Pwigrcsm+OPmxNjNT9vIBj1ZiB1Rq3pgjSGYtQ5N+lqcQQ5K1XMcsgeIe0NQp1TOFPJ4X2c+4hdke3d5LkqgQjXda8NA5jRVXosMiZAwKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=wBW8r3ko; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7390294782bso1217473b3a.0
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 11:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1744222963; x=1744827763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=llAd+HuXJY4PF9PO8i7LUmSbuK/5+LgxQcJzR0u8KiU=;
        b=wBW8r3koDjklPDPQBPacdyqRnFUviHjc6cKtvWbT9Z29fv7wH1iWnIAbmqOLlil4F+
         n629TUB9rraWG6ECgKWBpMSiFQaODevv7umuxzdN7/lXxpOvJ5HaSIaFjY3D2G1uHYZl
         KAtEPVNL702A8sTIKbYvWnEacZuRuf8TYy26kpedrmwp3/I32O3CBBayMh0HJWcZIRqN
         O4XH6kyMXGNv/sKk2M3HFH9lSfIczJ2oiBx3uROxoSsbCVUY4yi6ghAi26J4pGURBUMR
         5hghDqimwrdbDa/wHZXiZ3L0Mt6vF7sfdaBgpCWM/OuM67ruBpb0vYpg18IHmtNRyW4I
         oLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744222963; x=1744827763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=llAd+HuXJY4PF9PO8i7LUmSbuK/5+LgxQcJzR0u8KiU=;
        b=RyYCtSBFP6P/eiNrRIctbSnmjuxI4j4x19OwQ8uwA/8RTiutbxsWuouY31p54J0D6J
         15+VpKXn8mP7VkdlLsOxd1r2KKCxKsHFHYQgNTRVNjFBD2RKYJyUy0i6efn6Nu8KKALq
         VewqjVYb0ICX7iQKGvXnC2dnuJmo7lW4fLEE3gDERpz3uJYITERZ8SfWc57NnEpEZHtv
         pKbPAEH8xrLmSdrGBCLPGHCsMJj+bKDrpPMYRYmqKhHZndV9dyZKO/3ckoEexXQCJWXD
         hTzMhWT+lvh7/NEHwX3eD2lwVjYHCw+rpCOPJmodLOFQOQz6DSasJBCYIMz+Ua0PatGx
         FEvg==
X-Gm-Message-State: AOJu0Yyc6Dh2BGP1wJviMJRtSOM/F7buqUc9rDlKYsDt1uHPvrnj/UZb
	BDOsPBf0dkdFwFrNZXR2QfBMVYqAL16qU+DWdViRyJMpJFZqf1/aNqtLacx9rggYsvVR1TlAtlJ
	A9pY=
X-Gm-Gg: ASbGncvrHIrV0ew+fvSUnRWKJT4YmGBRN+XILDbmfM+6JN7oFyrvhd62whPSF74kpSh
	NRpM4zmH3cX13wjkgu9Df4t6cTPB4obGChBrVdVBUruVztqWUwsBiZKNd2NLfvUZ9zu72pcP4Bh
	3Rp4cvoiBKRYB99Pd4GlbPtWZOkX5WYMUvh95WgNmWI1TnccUpH1JQeI3cJ60+ckMHEdWDAY/tl
	fEMJ5Ry6vOuRd96C+PwReg1MCIijTcPLD33vr6ECt8GXo/00MJb00aR3sFZ8PSqWDqfWApkMe1Q
	uI5iBBHNAEeUaC+N4bhGlfkSKonhvg==
X-Google-Smtp-Source: AGHT+IGY4bFfOWbz1dmRXNq0KDY1qv1phdze5+/tT5DlyUhOCoI9gZGA/5f4fb86PmoqVSYT5LEDZQ==
X-Received: by 2002:a05:6a00:1309:b0:736:355b:5df6 with SMTP id d2e1a72fcca58-73bafd6d4aemr1415641b3a.6.1744222962340;
        Wed, 09 Apr 2025 11:22:42 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:2f6b:1a9a:d8b7:a414])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1d2ae5fsm1673021b3a.20.2025.04.09.11.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:22:42 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH v1 bpf-next 0/5] Exactly-once UDP socket iteration
Date: Wed,  9 Apr 2025 11:22:29 -0700
Message-ID: <20250409182237.441532-1-jordan@jrife.io>
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
rfc [1] -> v1:
* Use hlist_entry_safe directly to retrieve the first socket in the
  current bucket's linked list instead of immediately breaking from
  udp_portaddr_for_each_entry (Martin).
* Cancel iteration if bpf_iter_udp_realloc_batch() can't grab enough
  memory to contain a full snapshot of the current bucket to prevent
  unwanted skips or repeats [2].

[1]: https://lore.kernel.org/bpf/20250404220221.1665428-1-jordan@jrife.io/
[2]: https://lore.kernel.org/bpf/CABi4-ogUtMrH8-NVB6W8Xg_F_KDLq=yy-yu-tKr2udXE2Mu1Lg@mail.gmail.com/

Jordan Rife (5):
  bpf: udp: Use bpf_udp_iter_batch_item for bpf_udp_iter_state batch
    items
  bpf: udp: Avoid socket skips and repeats during iteration
  bpf: udp: Propagate ENOMEM up from bpf_iter_udp_batch
  selftests/bpf: Return socket cookies from sock_iter_batch progs
  selftests/bpf: Add tests for bucket resume logic in UDP socket
    iterators

 include/linux/udp.h                           |   3 +
 net/ipv4/udp.c                                | 101 +++-
 .../bpf/prog_tests/sock_iter_batch.c          | 451 +++++++++++++++++-
 .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
 .../selftests/bpf/progs/sock_iter_batch.c     |  24 +-
 5 files changed, 538 insertions(+), 42 deletions(-)

-- 
2.43.0



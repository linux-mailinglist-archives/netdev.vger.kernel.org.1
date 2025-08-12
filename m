Return-Path: <netdev+bounces-213057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9F2B23116
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 19:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E76D6568145
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 17:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F182FE58D;
	Tue, 12 Aug 2025 17:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TT4mjuDz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1AE2FE586
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 17:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021537; cv=none; b=KS+7T2vj5kIY5gZFgQXECHbHRgJGJl06NlB2ORHiYBMYzilpGiPy4tNNXclr4xEv6/TwHXvje8vp16H+1m/hWKQfe9K4FyVvBCQ7OgLf7z4jdpGpwLPs9eV+Iqi/eRglFcSmsjvfCjocXyoBVfyoZl1KOSnxoXxiodItjUnxjGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021537; c=relaxed/simple;
	bh=BBdOvE2AriIw5xw28ETj+/eLrI0VWJQRxeJ5yHjfv94=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PLGqRkI0WokObASV1J9E660eIRyv861qcZ7Z71+DuHdk3IQnudPIH65a0FM3/jdPrMxYcRFhSxY2lVXI3mrK4znPUpWcsgDrqv9P6aSC8NMgPTF26Jj6lCDxNdbZc+g/7VeCrLif2Yq8E4Al1FBkz+eDufx71EM7zVXQWh454mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TT4mjuDz; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76bb73b63d2so5951950b3a.1
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 10:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755021535; x=1755626335; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r2V1v9VHmhBBpIoyn/8bp16McXh5rwC69+hYhu5VhtU=;
        b=TT4mjuDzPb328wHdbUmGt/otZ3q/49m4dvhCiW5jeInpweNhEq3ajVoltTc1dei0w5
         hZfP1NJNMpkK2+GJK49OGsbjwgiQxi8wjhBnIO5+SazZ59xYDk1TfkYHeDQSJh89GcB6
         aJjqrbL0bzx5VEiZJvbxdDbc/zsrL2TOAntmDimR90+tDHR9JcS0/o6JoYB+I/22JgQu
         +PFlztWPf6KkUAVPRexyM1LjUV0xHH7GigkE7eefyAgpt+Bucyq1r0RrCUWHTwlaYv9z
         42FK5rhDgIgQu9nc0baYmvmc+1nPa3BmlniQt/wMMkEl/ryc+SCYrlpa0eNYZZcWkARn
         hd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755021535; x=1755626335;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r2V1v9VHmhBBpIoyn/8bp16McXh5rwC69+hYhu5VhtU=;
        b=WsA5w3LlrS5h5jlYfjhpSwsT/yrWpTzKDeVTEPDF3yybCtCq8/1IzFbKTdobqApCN1
         InSoQc4pHT1oyEaD5zoJFahhbBqVNX05ZxEWOurp7/Cl84h9JaTDEOeAiahq0Rrtj9AR
         yL4Q1eCjDK3s+1ts96I1Uo6zXjIq49CUWgP7ezL4ZHj4dJQCZDAb/zcr2CdY/7nKt3o3
         0X8MPmtJR3lx4vyDPEgKM6clNq/eLOY/0CY1H0Q8PHJmKlfvPBNyv8IpUhGvb1SnnTGt
         yrHQbFO9O4A+c6pLGSGYOWZHc944JWoRxIotoQAhS2TR8Bi+slYDhvAbsHy9ecyuoW3Z
         0yrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD/t8y0ewZxXD2N4sBdBS/m+IkAIKE8Lo874qT98R/JSX5gTZkeQHxuxDNY//BnDw4gQBNcLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXsU0DcD/yHx/EDcwYCMXWaECgfZQmRU+qQovz456HjG43MGQa
	9kRGv4tNEiJerCa/4hJ6DGtsvyOkb7jqPvz1h4lq8lxetTZQPbBPX3plAlMW+e18Cp7wq/KowmG
	wbwwlMA==
X-Google-Smtp-Source: AGHT+IHpI2A58X7fiHu4X8DLCY/YyPjXlJ8KtqdQYuS0Jk77Gj/N6hjXCZ5aN91Gfz65dY+Oy92efigaL18=
X-Received: from pfbde4.prod.google.com ([2002:a05:6a00:4684:b0:740:5196:b63a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:939d:b0:240:1119:d70c
 with SMTP id adf61e73a8af0-240a8bb39dcmr219488637.44.1755021534987; Tue, 12
 Aug 2025 10:58:54 -0700 (PDT)
Date: Tue, 12 Aug 2025 17:58:18 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250812175848.512446-1-kuniyu@google.com>
Subject: [PATCH v3 net-next 00/12] net-memcg: Decouple controlled memcg from sk->sk_prot->memory_allocated.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	"=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, Tejun Heo <tj@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Mina Almasry <almasrymina@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Some protocols (e.g., TCP, UDP) have their own memory accounting for
socket buffers and charge memory to global per-protocol counters such
as /proc/net/ipv4/tcp_mem.

When running under a non-root cgroup, this memory is also charged to
the memcg as sock in memory.stat.

Sockets of such protocols are still subject to the global limits,
thus affected by a noisy neighbour outside cgroup.

This makes it difficult to accurately estimate and configure appropriate
global limits.

If all workloads were guaranteed to be controlled under memcg, the issue
can be worked around by setting tcp_mem[0~2] to UINT_MAX.

However, this assumption does not always hold, and processes that belong
to the root cgroup or opt out of memcg can consume memory up to the global
limit, which is problematic.

This series decouples memcg from the global memory accounting if its
memory.max is not "max".  This simplifies the memcg configuration while
keeping the global limits within a reasonable range, which is only 10% of
the physical memory by default.

Overview of the series:

  patch 1 is a bug fix for MPTCP
  patch 2 ~ 9 move sk->sk_memcg accesses to a single place
  patch 10 moves sk_memcg under CONFIG_MEMCG
  patch 11 stores a flag in the lowest bit of sk->sk_memcg
  patch 12 decouples memcg from sk_prot->memory_allocated based on the flag


Changes:
  v3:
    * Patch 12
      * Fix build failrue for kTLS (include <net/proto_memory.h>)

  v2: https://lore.kernel.org/netdev/20250811173116.2829786-1-kuniyu@google.com/
    * Remove per-memcg knob
    * Patch 11
      * Set flag on sk_memcg based on memory.max
    * Patch 12
      * Add sk_should_enter_memory_pressure() and cover
        tcp_enter_memory_pressure() calls
      * Update examples in changelog

  v1: https://lore.kernel.org/netdev/20250721203624.3807041-1-kuniyu@google.com/


Kuniyuki Iwashima (12):
  mptcp: Fix up subflow's memcg when CONFIG_SOCK_CGROUP_DATA=n.
  mptcp: Use tcp_under_memory_pressure() in mptcp_epollin_ready().
  tcp: Simplify error path in inet_csk_accept().
  net: Call trace_sock_exceed_buf_limit() for memcg failure with
    SK_MEM_RECV.
  net: Clean up __sk_mem_raise_allocated().
  net-memcg: Introduce mem_cgroup_from_sk().
  net-memcg: Introduce mem_cgroup_sk_enabled().
  net-memcg: Pass struct sock to mem_cgroup_sk_(un)?charge().
  net-memcg: Pass struct sock to mem_cgroup_sk_under_memory_pressure().
  net: Define sk_memcg under CONFIG_MEMCG.
  net-memcg: Store MEMCG_SOCK_ISOLATED in sk->sk_memcg.
  net-memcg: Decouple controlled memcg from global protocol memory
    accounting.

 include/linux/memcontrol.h      | 45 +++++++++-------
 include/net/proto_memory.h      | 15 ++++--
 include/net/sock.h              | 67 +++++++++++++++++++++++
 include/net/tcp.h               | 10 ++--
 mm/memcontrol.c                 | 48 +++++++++++++----
 net/core/sock.c                 | 94 +++++++++++++++++++++------------
 net/ipv4/inet_connection_sock.c | 35 +++++++-----
 net/ipv4/tcp.c                  |  3 +-
 net/ipv4/tcp_output.c           | 13 +++--
 net/mptcp/protocol.c            |  4 +-
 net/mptcp/protocol.h            |  4 +-
 net/mptcp/subflow.c             | 11 ++--
 net/tls/tls_device.c            |  4 +-
 13 files changed, 254 insertions(+), 99 deletions(-)

-- 
2.51.0.rc0.205.g4a044479a3-goog



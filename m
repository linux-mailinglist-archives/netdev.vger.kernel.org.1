Return-Path: <netdev+bounces-220992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA436B49CFD
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 00:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A31AD1BC03E2
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 22:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921FE2EB879;
	Mon,  8 Sep 2025 22:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OppRjWbh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF332E0B5C
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 22:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757371077; cv=none; b=qH8wQhO8X9AZa4BgZz6QaHJsaToV4Ay21P2q0rsVd31ug6YcHSVJrReGF96CSOIn+235Wlo4rwOzMMo3SGHJ+vNcnO6jGmNXcdwEhEViz4aH6TYKH2jj7+QbfJ/r3FUm34lTbY5kNHqCn1g8VCHxeWn5NDqn9gx3FfBNrZiwF/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757371077; c=relaxed/simple;
	bh=K/+6HaezEKTNCz6DDiybQvx3x6N3ML8txPdoxMorAek=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kxXjIfvdf7j5zdwR1sR6U7rJNLDgEpJNxgbtU4+VXVsxavU/+EZbSHADEzsvJNi2xS75cK8MQQw5RgeY5qvxpTvU42fv5oP+pdtXAAJ4lb5do+bs6RCEUyt8Nia9NBncCY5VDEd0kQvdbgMBwMwwDUO9cDojw3k0EVythVxNB4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OppRjWbh; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3234811cab3so5577477a91.3
        for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 15:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757371075; x=1757975875; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oHB8VmjoeKDrD30KjQ7/qnRVGLhietJGaZsMWEtgdC4=;
        b=OppRjWbhpGouVpkY6BNuFPNZanA9BWDEJPhHVoLY4UBrCxD0cCUYPhwGUa07AsHvdP
         7AwjIgfxgWvMbY90ZEZtu/VeG29piK/2uY++1mmARw9pxPvrnFrbewXt4k1MarmVYRoN
         CvPlbWg8NdUiziILreeWFXi2rWUysagQNvdFjwMaCSE9l3PbRBj9TApYB6iYirh3PZVr
         OiCTNxBzOA5VZrLFkNw7qNdQ1t5wONpPa151Cp5ZeOe2mfl4H8VxnKgTcxYTSmtULDYX
         Dp0fH7kIl5WBPOj1O9+1ZfTHJZgSZWJiLKkH8ND3nc2ktefdrOXskKw4f15cXWwrQrcU
         x93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757371075; x=1757975875;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oHB8VmjoeKDrD30KjQ7/qnRVGLhietJGaZsMWEtgdC4=;
        b=DVfkjzcd2fX62p83D1gAM/+pkTi+ZRlkm7YnQ504avqQ5o5dwJ19BSZZcA9rSYtHbg
         CrI4SxNdDTbSkSTmoVFPq8xYk88Tme93Fo75pkUMyikFp9Cl/pc8Wb+S+esh03qN1Gaw
         2HZosUR7ZxjZ96Q7xzH38nGklsrZEA7niq/Jd/7aL52tTRoWNvkJHbRbifVFxQi7umVn
         iSX1yNxMqZkdQA0MPPKkZjp+DnyRXvVGllH/J6D477cfsTM0jNH96XjgyfkUPrG8bGFO
         kYQcJtFJGo+BN3GZHrK1ANNe4T3jKVGCUkMtBKxeJX4veKDyvYaxiZYUtYf8lWGcCHeQ
         h4Vw==
X-Forwarded-Encrypted: i=1; AJvYcCV77u5RfWKnXVebiqGISJ5Hr46N9qPvQuJnk6qFngUbso7e0FRoxx0X1ccyYBDxYR1+/Z5G5qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAcE55hJsuwCqC8jT21KYvgpSMrLFBJoARDPGz4MuYApZpmp+Q
	3dp9vGJceNNLKGNZa3jYgeHG4/zJCHGs9uJV24AAAB9e3GvOemEeoW1iOhwIbBcorzsrZmAgJaY
	RbUIzEQ==
X-Google-Smtp-Source: AGHT+IH4X8yBYzXqkgZhB9Z5Tv9zh1FGyGOFIpK56IY9kyCpIIZ9HtmeysYahQjYkIzCj52o7SB1uHXB6+8=
X-Received: from pjbse15.prod.google.com ([2002:a17:90b:518f:b0:32b:95bb:dbc])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d04:b0:32b:623d:ee9e
 with SMTP id 98e67ed59e1d1-32d43eff92bmr12149451a91.14.1757371075173; Mon, 08
 Sep 2025 15:37:55 -0700 (PDT)
Date: Mon,  8 Sep 2025 22:34:34 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250908223750.3375376-1-kuniyu@google.com>
Subject: [PATCH v6 bpf-next/net 0/5] bpf: Allow decoupling memcg from sk->sk_prot->memory_allocated.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Some protocols (e.g., TCP, UDP) have their own memory accounting for
socket buffers and charge memory to global per-protocol counters such
as /proc/net/ipv4/tcp_mem.

When running under a non-root cgroup, this memory is also charged to
the memcg as sock in memory.stat.

We do not need to pay costs for two orthogonal memory accounting
mechanisms.

This series allows decoupling memcg from the global memory accounting
(memcg + tcp_mem -> memcg) if socket is configured as such by BPF prog.


Overview of the series:

  patch 1 & 2 are prep
  patch 3 intorduces SK_BPF_MEMCG_SOCK_ISOLATED for bpf_setsockopt()
  patch 4 decouples memcg from sk_prot->memory_allocated based on the flag
  patch 5 is selftest


Changes:
  v6:
    * Patch 4
      * Update commit message
    * Patch 5
      * Trace sk_prot->memory_allocated + sk_prot->memory_per_cpu_fw_alloc

  v5: https://lore.kernel.org/netdev/20250903190238.2511885-1-kuniyu@google.com/
    * Patch 2
      * Rename new variants to bpf_sock_create_{get,set}sockopt()
    * Patch 3
      * Limit getsockopt() to BPF_CGROUP_INET_SOCK_CREATE
    * Patch 5
      * Use kern_sync_rcu()
      * Double NR_SEND to 128

  v4: https://lore.kernel.org/netdev/20250829010026.347440-1-kuniyu@google.com/
    * Patch 2
      * Use __bpf_setsockopt() instead of _bpf_setsockopt()
      * Add getsockopt() for a cgroup with multiple bpf progs running
    * Patch 3
      * Only allow inet_create() to set flags
      * Inherit flags from listener to child in sk_clone_lock()
      * Support clearing flags
    * Patch 5
      * Only use inet_create() hook
      * Test bpf_getsockopt()
      * Add serial_ prefix
      * Reduce sleep() and the amount of sent data

  v3: https://lore.kernel.org/netdev/20250826183940.3310118-1-kuniyu@google.com/
    * Drop patches for accept() hook
    * Patch 1
      * Merge if blocks
    * Patch2
      * Drop bpf_func_proto for accept()
    * Patch 3
      * Allow flagging without sk->sk_memcg
      * Inherit SK_BPF_MEMCG_SOCK_ISOLATED in __inet_accept()

  v2: https://lore.kernel.org/bpf/20250825204158.2414402-1-kuniyu@google.com/
    * Patch 2
      * Define BPF_CGROUP_RUN_PROG_INET_SOCK_ACCEPT() when CONFIG_CGROUP_BPF=n
    * Patch 5
      * Make 2 new bpf_func_proto static
    * Patch 6
      * s/mem_cgroup_sk_set_flag/mem_cgroup_sk_set_flags/ when CONFIG_MEMCG=n
      * Use finer CONFIG_CGROUP_BPF instead of CONFIG_BPF_SYSCALL for ifdef

  v1: https://lore.kernel.org/netdev/20250822221846.744252-1-kuniyu@google.com/


Kuniyuki Iwashima (5):
  tcp: Save lock_sock() for memcg in inet_csk_accept().
  bpf: Support bpf_setsockopt() for BPF_CGROUP_INET_SOCK_CREATE.
  bpf: Introduce SK_BPF_MEMCG_FLAGS and SK_BPF_MEMCG_SOCK_ISOLATED.
  net-memcg: Allow decoupling memcg from global protocol memory
    accounting.
  selftest: bpf: Add test for SK_BPF_MEMCG_SOCK_ISOLATED.

 include/net/proto_memory.h                    |  15 +-
 include/net/sock.h                            |  50 ++++
 include/net/tcp.h                             |  10 +-
 include/uapi/linux/bpf.h                      |   6 +
 net/core/filter.c                             |  82 ++++++
 net/core/sock.c                               |  65 +++--
 net/ipv4/af_inet.c                            |  37 +++
 net/ipv4/inet_connection_sock.c               |  26 +-
 net/ipv4/tcp.c                                |   3 +-
 net/ipv4/tcp_output.c                         |  10 +-
 net/mptcp/protocol.c                          |   3 +-
 net/tls/tls_device.c                          |   4 +-
 tools/include/uapi/linux/bpf.h                |   6 +
 .../selftests/bpf/prog_tests/sk_memcg.c       | 236 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/sk_memcg.c  | 146 +++++++++++
 15 files changed, 643 insertions(+), 56 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sk_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/sk_memcg.c

-- 
2.51.0.384.g4c02a37b29-goog



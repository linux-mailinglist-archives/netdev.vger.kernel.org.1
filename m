Return-Path: <netdev+bounces-218058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C30B3B020
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 03:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BFFD5667AD
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 01:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB101ADC83;
	Fri, 29 Aug 2025 01:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e+vXsf9s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47886288A2
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 01:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756429232; cv=none; b=LB4BNF7Y9W+I2izCI69eLiqEMkUdK8on4K00jWWtCIiAla3Z289o7efFHqettHbAiyjYh6wXq/oSB0Vsf9iV88QCmRdxxluFs/G4U+sU08AwB8QT9zaxQAzA1BU8TcCPgzsXKZ6Pd0N+XYhFylcLIkkbS5qDXpUbtjKQNfymqVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756429232; c=relaxed/simple;
	bh=yD1Esuj0Lh3yK7mpW5WWJeUIj1YS7IGhyxzodFvtwfM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UvhyFGgpOQhRorpRTAd8oze4B4yzyduWickFc0pn3f3+4hb3XUD28eBJpCaK9WqRndQncv9bD8mn9Lo4mkAGYp/DsFsgPEz4EN9plPy0RPLbjZZJx7YAfqgW5SSQGgTPbhBQmPBvFFi9PYbY0Z4YD+KHgaXEt3TpVGwoHP3dq/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e+vXsf9s; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7722ef6c864so48427b3a.1
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 18:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756429231; x=1757034031; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mABjjaqiP2UTHmxp2gWA08VShFYcnmT1DBYRkgpaZ+w=;
        b=e+vXsf9sbUn8lzd8j/RdScK+kBfEALGEgSY2JLeyxPim6PRc61L5t/C50958cIUeiX
         uDsjRWtqtUbN3P59OCpM9r71dhXQBjvAwgWuJ7ngaYAMWHlDvFHnfTEiWifIMbimIP9+
         drMLcb+AXYxcT4bB0usVjwMEsqOvhuyxokbzFd6H0UT2rFhS7712klqCTUPG8DoZfPbo
         NasbMCBel5xIKuiRZ1wFR+TUYgbHDl0lETrE0CQOHfhF8MEVsZG7iF5OLNn0eDxHcGvj
         qkKuVcwivyI6TLot96iuPmYO3mi/rO87cUUXwxNBeGP7kNX7nF/GUq3Q9YRt748g1Eeh
         CNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756429231; x=1757034031;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mABjjaqiP2UTHmxp2gWA08VShFYcnmT1DBYRkgpaZ+w=;
        b=kdLURQcI06sKtUB9aM0nmzqXg5BsbiPoSYGunxw6BvRRjkR6mjwC5w6W27ohw9C/m/
         0arUaGBa+0GseN9irPRBa2s31N/of0kgbnk3sEmL64wuC0tTC4akodWxSVvrAKqdKu4q
         zEPLrl1nuqOVqzRRW0hCW/epZI6WPo1qjD5e55uj+jWJUI/wPzCORmKBK8wE/zNDbvUk
         07W6eDeF0DkNvNUc10l2upu0bwIgrxNgm20QQoBGFM19uqoZG1e4kZDFW6gWHkwqkodY
         viFSjyFIj8zUCSFuw2rwnzJrqdVkj5LmzOEh75sI8zyGMZHk9xFmVTLuQQid8REpAc4C
         1wFw==
X-Forwarded-Encrypted: i=1; AJvYcCUvnhVMF4teeUCGE4On1+W9kyX44imTTaJ/25Pqiz7qkBG/TicHE5/48P2z/lBcv5Oxyb2Z3T4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/4tg96v0niXfG72MvQDhrRGSoBgmJ/6eAkv6klIVzxsCjRLCE
	WSlLJCiVS0TP6kw9DwKJRZrk0jzVVPdSOrfJxl2DjVvdQ3pSuECVXpNtPYGboG8P67atI9sCA8A
	eKeUuRw==
X-Google-Smtp-Source: AGHT+IEP4ctVkBTx+X5nJfCWiW1nJL0JfwQHajXAMXfp6ptS7jbQ9mYY0PQVtPK6Gw+1JD9w6fkBGh6pXVg=
X-Received: from pfbha19.prod.google.com ([2002:a05:6a00:8513:b0:771:fd7c:50e7])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1ca0:b0:771:f763:4654
 with SMTP id d2e1a72fcca58-771f7634976mr16665603b3a.18.1756429230374; Thu, 28
 Aug 2025 18:00:30 -0700 (PDT)
Date: Fri, 29 Aug 2025 01:00:03 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829010026.347440-1-kuniyu@google.com>
Subject: [PATCH v4 bpf-next/net 0/5] bpf: Allow decoupling memcg from sk->sk_prot->memory_allocated.
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

Sockets of such protocols are still subject to the global limits,
thus affected by a noisy neighbour outside cgroup.

This makes it difficult to accurately estimate and configure appropriate
global limits.

This series allows decoupling memcg from the global memory accounting
if socket is configured as such by BPF prog.

This simplifies the memcg configuration while keeping the global limits
within a reasonable range, which is only 10% of the physical memory by
default.

Overview of the series:

  patch 1 & 2 are prep
  patch 3 intorduces SK_BPF_MEMCG_SOCK_ISOLATED for bpf_setsockopt()
  patch 4 decouples memcg from sk_prot->memory_allocated based on the flag
  patch 5 is selftest


Changes:
  v4:
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
 net/core/filter.c                             |  91 +++++++-
 net/core/sock.c                               |  65 ++++--
 net/ipv4/af_inet.c                            |  37 +++
 net/ipv4/inet_connection_sock.c               |  26 +--
 net/ipv4/tcp.c                                |   3 +-
 net/ipv4/tcp_output.c                         |  10 +-
 net/mptcp/protocol.c                          |   3 +-
 net/tls/tls_device.c                          |   4 +-
 tools/include/uapi/linux/bpf.h                |   6 +
 .../selftests/bpf/prog_tests/sk_memcg.c       | 218 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/sk_memcg.c  |  38 +++
 15 files changed, 525 insertions(+), 57 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sk_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/sk_memcg.c

-- 
2.51.0.318.gd7df087d1a-goog



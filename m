Return-Path: <netdev+bounces-216154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F26B324EE
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 00:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5559A1BA79D0
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 22:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4AC26F285;
	Fri, 22 Aug 2025 22:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I9GibFaq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E8323505F
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 22:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755901131; cv=none; b=pNR3w8dnnn5Ii3DouumzjBPJ1raHjH/uAYQUl5ekdWPMztfBzshgGqqFij9WfdWAJy8sNj7ASuWsXuhoDzabel5DXI3srzlhprVcprCbC4lY0DprkBbjpVnKzIvDcUdDXEHSQ6KG7t/k0stMHAPUFMY3ysFzofpViYHS7LXUN30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755901131; c=relaxed/simple;
	bh=c6mGLJgnTfpuQVOeGknUJj9bW3ATLSK7ZiU6ojmW638=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=c6oEcCCtoT0jfk1By8aj3PHFBVbgvWMxo2SQwIrYJH0tkpoabzTZpoYP55GNVAr8ZfNMQkUFE8LwY5SpTQNs3xFdKL2TpEkCRAmXagXZK+btM22ZJtEGXYWgzcj8xrqxBtow7K9ipZScQxkXj0p/ewPp/xWtV4xmwqBG388MRpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I9GibFaq; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2465bc6da05so8196695ad.0
        for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 15:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755901130; x=1756505930; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hIkFgcvZcrojvPgSQkeYBl88OThm773qw4A5aWmF2/E=;
        b=I9GibFaqUi/SA+k5orIueBlgXvtftKRfO+CHUteFnOxeFuDRpiemVV7r+cPQmWuyIG
         wSlCAbsAjFR8LSlE9KlPt37hhcfdm+tUAuKXwApqascarwcWaShFs2VbGdN+VrYwoGI8
         Tg3WDUDVxro7CMG3O0cOxrOkPi/Ei1Yw/p7Ux1CTf/ybFjaIOlHtianSKe39UyICq0Tn
         K2eYwYaWx5jghetDv4v7BkwWdyYxCHXJ1jXWcERWbVj14dtHFfGdP2cuzqpSM/IzjzUR
         SPGz8wjO46lwpB/KvWBINpz+awc0e+ozM8QbCXoVnmJCm53IoTkx8gafLJPV5zuc7U7Y
         wS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755901130; x=1756505930;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hIkFgcvZcrojvPgSQkeYBl88OThm773qw4A5aWmF2/E=;
        b=j607ymQiuhalkedGyR7JBWNVT88RYPCXYp/DjypoDomdJdtFBYMJUGWCJGHKJru1qc
         6L9wYnVPit66rw9rC4+Ius3lNU3AK0al4Ymjq9ZQfHxD3tFdkk3wqlu00dPkbTEp5HOQ
         Zr8zJBvRENmgjSjrL8Qt/YM5l0WGwWmKYJ/xjhZv8SF3XJDeAzdxWfUQBxRaBs1WUkgI
         GZlSPxjKqj8KzaN+KUzgGnnH8fYJcT7o++Zw3mVLHvqGbJzlOvJDZqqETu3CJql6iP1H
         55bEGq+LoBlBQMsWwstKrsXlV+oPl+i1KOsHn0DhKEaXVSzY3ODDFSMro0BlawgCekYg
         dSUA==
X-Forwarded-Encrypted: i=1; AJvYcCVOCBFo49Bp5EUt+oTRm4u4ZwE/Xh2Wsgqx+Hj6Ik6gyCGom1et5KvtWsaq9mYjHkWSSiSz6TA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoKG0gKiW4sl/1FJjo/jI/AewqJ49JgOSeVw4jpt+t7QEgiw1g
	12R3Khl16iIAX1sqYN37/xhCl19I69JJjwCsW7E2ZLjFj3u0l3jlDLOnXjO09pr/TSKrcA5IsFv
	yGH0A+g==
X-Google-Smtp-Source: AGHT+IFLHNvGZFfSmyvczIBxR9kNhc5Bj1TRhTXcI3X2GP4drWc5WEHm4SlD8eb3yfX7ynv+xuI7cnSQ1E8=
X-Received: from plaq19.prod.google.com ([2002:a17:903:2053:b0:23f:fd13:e74d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cec2:b0:246:61e:b564
 with SMTP id d9443c01a7336-2462f1d82c4mr56035705ad.61.1755901129678; Fri, 22
 Aug 2025 15:18:49 -0700 (PDT)
Date: Fri, 22 Aug 2025 22:17:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822221846.744252-1-kuniyu@google.com>
Subject: [PATCH v1 bpf-next/net 0/8] bpf: Allow decoupling memcg from sk->sk_prot->memory_allocated.
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

  patch 1 is a prep
  patch 2 ~ 4 add a new bpf hook for accept()
  patch 5 & 6 intorduce SK_BPF_MEMCG_SOCK_ISOLATED for bpf_setsockopt()
  patch 7 decouples memcg from sk_prot->memory_allocated based on the flag
  patch 8 is selftest


Kuniyuki Iwashima (8):
  tcp: Save lock_sock() for memcg in inet_csk_accept().
  bpf: Add a bpf hook in __inet_accept().
  libbpf: Support BPF_CGROUP_INET_SOCK_ACCEPT.
  bpftool: Support BPF_CGROUP_INET_SOCK_ACCEPT.
  bpf: Support bpf_setsockopt() for
    BPF_CGROUP_INET_SOCK_(CREATE|ACCEPT).
  bpf: Introduce SK_BPF_MEMCG_FLAGS and SK_BPF_MEMCG_SOCK_ISOLATED.
  net-memcg: Allow decoupling memcg from global protocol memory
    accounting.
  selftest: bpf: Add test for SK_BPF_MEMCG_SOCK_ISOLATED.

 include/linux/bpf-cgroup-defs.h               |   1 +
 include/linux/bpf-cgroup.h                    |   4 +
 include/net/proto_memory.h                    |  15 +-
 include/net/sock.h                            |  48 ++++
 include/net/tcp.h                             |  10 +-
 include/uapi/linux/bpf.h                      |   7 +
 kernel/bpf/cgroup.c                           |   2 +
 kernel/bpf/syscall.c                          |   3 +
 net/core/filter.c                             |  75 +++++-
 net/core/sock.c                               |  64 ++++--
 net/ipv4/af_inet.c                            |  34 +++
 net/ipv4/inet_connection_sock.c               |  26 +--
 net/ipv4/tcp.c                                |   3 +-
 net/ipv4/tcp_output.c                         |  10 +-
 net/mptcp/protocol.c                          |   3 +-
 net/tls/tls_device.c                          |   4 +-
 tools/bpf/bpftool/cgroup.c                    |   6 +-
 tools/include/uapi/linux/bpf.h                |   7 +
 tools/lib/bpf/libbpf.c                        |   2 +
 .../selftests/bpf/prog_tests/sk_memcg.c       | 214 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/sk_memcg.c  |  29 +++
 21 files changed, 508 insertions(+), 59 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sk_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/sk_memcg.c

-- 
2.51.0.rc2.233.g662b1ed5c5-goog



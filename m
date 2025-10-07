Return-Path: <netdev+bounces-228042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E76D4BBFD59
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 02:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A26EF4E2456
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 00:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6615F17BA6;
	Tue,  7 Oct 2025 00:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dJ2VcesT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D911413AC1
	for <netdev@vger.kernel.org>; Tue,  7 Oct 2025 00:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759795886; cv=none; b=SPFj5AWBasRonNLx92el4awnKs6ibQmEHLg/Hsoin5zhmm8wQ+7m335UjRQpFpfXDj2xsYMzUKtg1nWhY3WvHNN6DRRYjgq44po7tyghQYPtfTbgTDuUz92SNdh4803jaFncSkRmTbfPTsuYyiKYBcHJCzKWtP3oLg9U2mmTBNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759795886; c=relaxed/simple;
	bh=OjB9U/glNklQYiP94Pw7OMVIVeV+esVdx+igohJW9Kk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZBHbDMIoPkBHlYQ5pDJbwPufQhURkLqeWz6bKPztVPI5A9gSYcutTuJbSNXv+oAxr3qT7e+Z9u8GlSIs8gXtLtHluXyxmqqSLtN4GzNUOzaetBx1lxJWu5jBi4GTk+Sna+S18PJqEvixYXYZFsyweagsBF1QZDLyAw8Qz1mZ3fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dJ2VcesT; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32ee62ed6beso9072171a91.2
        for <netdev@vger.kernel.org>; Mon, 06 Oct 2025 17:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759795884; x=1760400684; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jJBHN3rUg1YIOkUWt9hwotdn59mxOIV3QI8iAsT03sY=;
        b=dJ2VcesTWdLbE76MXM9GNb5M9cuABP6bz4srlw9IWWgY5Gnn/mT3FokDQhgD7EOdBm
         qNNgj64MtwaG7t4wPCI8JK/+XCVr0ESA+Az6YSRcz9H/jY/3unwnUvRMvn/NrWAfDJqX
         WP+GjwTZcK2t3cBykIq2ecQ8hu/Fe6gcvCCDz6S05qYqkXzBzaHHQIq0lzNmm0gbudHz
         jAIprurH2bV87OTqBsRSki6pKFe35CojWZPpKFmno7bYFje8kSEvpmpudxLjgbw6vxaf
         l2q2rmN+ZRXjmpdd9904KoAUXJpq42ROA5CU/mctvmGvAjyOiN8K5t+HRiJfByOgQ1w8
         YFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759795884; x=1760400684;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jJBHN3rUg1YIOkUWt9hwotdn59mxOIV3QI8iAsT03sY=;
        b=RTzzh0HUnJL4r3wxCxQVaOpvaBUvbZkmSGH8zkG4tP/JLh6ZunAOTwQUyih6fJ0t6o
         SDCeNgYDoPBK1I0w4TLOARXD6RXFsMbTMsdI508vh3ZqEMIFpnxtPTIePEw1NTQJQqAb
         7F6N/7aj2z8i32wNIg872ZhqiCpdjnQrsIVVV5+SDpR0DZXiZ9GWFkaHgTI6imBz4hwl
         hlKm/A7EdV4O1TKcpJgMITGS4Uu2QlFE5LemHybCjWNNPHLHi18EF3XblHMbw9vxGaZs
         sz0HWDN3Np76NOK+ixZ5nL86us5qDe9mzBAOP1/9XL4dyb8NqCKG4Cm/cttrSr6l19Qc
         AThQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/iQ7bXIWgc93m/agOhHLgdI3sSaOmF2k4ULDF+SwtdkZSl+JxmZkcpgxVB/EEeSc6JzvGsNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZcUUkwBx2rV8JjuHqU+6RNaN0HPlMDZkgVkvbfLvvFbgjAOkU
	d8AZDGV/7a9GM4I+r7uN8WPcX9SUWjnvGTqS20EL5E5AtPVOd3AB7XQ8Lm1X8l/LoTNzaHfTObP
	jbHR9UQ==
X-Google-Smtp-Source: AGHT+IFkcaYku7xK7pNlim0fBSQFL2WTduLoSh4WUJl6xK6pXTW9E81i1TZcGo0o0pCX4QtcmQ71Qm5AXHY=
X-Received: from pjxx8.prod.google.com ([2002:a17:90b:58c8:b0:31f:2a78:943])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c8b:b0:339:a243:e96d
 with SMTP id 98e67ed59e1d1-339c27d1164mr16953343a91.36.1759795884175; Mon, 06
 Oct 2025 17:11:24 -0700 (PDT)
Date: Tue,  7 Oct 2025 00:07:25 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Message-ID: <20251007001120.2661442-1-kuniyu@google.com>
Subject: [PATCH bpf-next/net 0/6] bpf: Allow opt-out from sk->sk_prot->memory_allocated.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series allows opting out of the global per-protocol memory
accounting if socket is configured as such by sysctl or BPF prog.

This series is v11 of the series below [0], but I start as a new series
because the changes now fall in net and bpf subsystems only.

I discussed with Roman Gushchin offlist, and he suggested not mixing
two independent subsystems and it would be cleaner not to depend on
memcg.

So, sk->sk_memcg and memcg code are no longer touched, and instead we
use another hole near sk->sk_prot to store a flag for the net feature.

Overview of the series:

  patch 1 is misc cleanup
  patch 2 allows opt-out from sk->sk_prot->memory_allocated
  patch 3 introduces net.core.bypass_prot_mem
  patch 4 & 5 supports flagging sk->sk_bypass_prot_mem via bpf_setsockopt()
  patch 6 is selftest


[0]: https://lore.kernel.org/bpf/20250920000751.2091731-1-kuniyu@google.com/


Note: de7342228b73 is needed to build selftest on bpf-next/net.


Kuniyuki Iwashima (6):
  tcp: Save lock_sock() for memcg in inet_csk_accept().
  net: Allow opt-out from global protocol memory accounting.
  net: Introduce net.core.bypass_prot_mem sysctl.
  bpf: Support bpf_setsockopt() for BPF_CGROUP_INET_SOCK_CREATE.
  bpf: Introduce SK_BPF_BYPASS_PROT_MEM.
  selftest: bpf: Add test for sk->sk_bypass_prot_mem.

 Documentation/admin-guide/sysctl/net.rst      |   8 +
 include/net/netns/core.h                      |   1 +
 include/net/proto_memory.h                    |   3 +
 include/net/sock.h                            |   3 +
 include/net/tcp.h                             |   3 +
 include/uapi/linux/bpf.h                      |   2 +
 net/core/filter.c                             |  79 +++++
 net/core/sock.c                               |  37 ++-
 net/core/sysctl_net_core.c                    |   9 +
 net/ipv4/af_inet.c                            |  22 ++
 net/ipv4/inet_connection_sock.c               |  25 --
 net/ipv4/tcp.c                                |   3 +-
 net/ipv4/tcp_output.c                         |   7 +-
 net/mptcp/protocol.c                          |   7 +-
 net/tls/tls_device.c                          |   3 +-
 tools/include/uapi/linux/bpf.h                |   1 +
 .../bpf/prog_tests/sk_bypass_prot_mem.c       | 282 ++++++++++++++++++
 .../selftests/bpf/progs/sk_bypass_prot_mem.c  | 104 +++++++
 18 files changed, 561 insertions(+), 38 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sk_bypass_prot_mem.c
 create mode 100644 tools/testing/selftests/bpf/progs/sk_bypass_prot_mem.c

-- 
2.51.0.710.ga91ca5db03-goog



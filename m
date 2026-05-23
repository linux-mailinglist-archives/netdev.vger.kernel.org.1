Return-Path: <netdev+bounces-291055-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGeKGpJlEWr7lQYAu9opvQ
	(envelope-from <netdev+bounces-291055-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 10:30:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B94F55BDDCE
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 10:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E03D3015458
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 08:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF71356759;
	Sat, 23 May 2026 08:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LB/zDbY4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0862355F4E
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 08:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779525006; cv=none; b=aG2yNIMwTbtMl4DPqqBMOzS+19MISvCR504gRnmEpzPo9T9v6baWRr7nVHzkjX8a6rgJJtYApG9eeP4bLAgcNH7QSjTY51A2P+IZ1hFxdMKLt9PZLJa/EfXSuUlFLpNyam6rczDl6UtujPOeBpDEPXs+I1eDINpX28FUcVtTy9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779525006; c=relaxed/simple;
	bh=jsFMmyu18Qw2PbBRpNSwM1AQpuGcBNVvoTLRGGh4ddQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bseoYPF6qepvdcCE44npvU/ya83KU8RMzW2/cZsQYLOFdvBGG0WT1XW557PIDDCfiFSJTJ6wrkNJgHnpEqXFLt/wjLz7qSkAmiO3NFrZroBOaXFwzOjRr98V7IDSfTD+N7RvKZnOKeNjrEqRZrNdE4yKxrLRPg6BIe1ZWN5KhMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LB/zDbY4; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c82c84be9c3so3752299a12.0
        for <netdev@vger.kernel.org>; Sat, 23 May 2026 01:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779525004; x=1780129804; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g9pAuZgrOffCgXqEmGyFxxgYomzoecwVeHEGegwQ8hk=;
        b=LB/zDbY4A7IPBJfRY6m7XXkAKw/CPIZNQM5tF759jX//rE3UWnbTRwuszkmWmsiUSZ
         nHE18T4ULfYhj+dIIEhx4RWTKO/mZ9KDZA9etJsRc/NXQJmss75lsQI1Yz/O3hXsvZhJ
         ccA0PIg5cJVqZ95HjE1yy/vNd6qr1zhteVIDoEEcRd8Tfdfj6xGJAUixzZfzzokDWLL4
         r3rIiquH7jHOCDMa+t/hScYs+I9MQnypBP9SRKNOnl6EjZ7c/DtRZ/rOjQhBPtPJX5/L
         /AZjOtYzYs7+0ahh81wLD5M4nyCxnq06yfzK+/btxdzZe5EAIemYj1BVDpcdWsiNBxId
         14EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779525004; x=1780129804;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g9pAuZgrOffCgXqEmGyFxxgYomzoecwVeHEGegwQ8hk=;
        b=dk/A7TGva/KOaaxXB+s+8yz3TVIN1vRKLuxy1zNyPyLEtcaL+o3HNpzAQhvO79kGo6
         k/BUSKE7xA3icSOzdZFnkj9bQHHkcPJh9w+Uhf+bezmyAWOs2/ZmkONKKse5euvs6LdD
         5/lHmHyumhtrzGmvL1guu+oUvi4DeXwqj2V2UHqsmVHnxHZOR9XYQawwntioHAblUf0f
         SxN3zpcSdldGZRt0p6LNYK/lim04aPgIF7bOE/yUmarjdyUtEf6ni/JWssHOSMy3gYj9
         ceYAznXYQP0gJFIBjbirnbRnwrjl6QoejwamhB7ETRYl8luYFDmRQo3ZAIyITPFXEUBQ
         D2PA==
X-Forwarded-Encrypted: i=1; AFNElJ9pA0KLQSnJ0aKu8McHzI78EorV3gbz4g44B9MNh1LgevfvU3M7lAZe5wnx3+Q3sVrZ680Ml4w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj+BGNtjgtIcGMQICrRGiZJxBAVIu8aydBOwbTuFCwJgKRN8YX
	jpFSaUMB0H6rGa30KSvjkxGb2Vt7DzWV+Sm+q+YKsqWCPHvsPSlyix6iv8mY4HvnBc4shzPldve
	aKn2jfA==
X-Received: from plhu9.prod.google.com ([2002:a17:903:1249:b0:2bc:7c67:1874])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cecc:b0:2b9:86ca:5bf2
 with SMTP id d9443c01a7336-2beb06732c3mr76968915ad.30.1779525004000; Sat, 23
 May 2026 01:30:04 -0700 (PDT)
Date: Sat, 23 May 2026 08:29:29 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260523083001.2911931-1-kuniyu@google.com>
Subject: [PATCH v3 bpf-next 00/11] bpf: Add SOCK_OPS hooks for TCP AutoLOWAT.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291055-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.926];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B94F55BDDCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series introduces BPF_SOCK_OPS_RCVQ_CB, a new type of opt-in
hooks for BPF SOCK_OPS prog.

The hooks can be enabled on per-socket basis by bpf_setsockopt():

  int flag = BPF_SOCK_OPS_RCVQ_CB_FLAG;

  bpf_setsockopt(sk, SOL_TCP, TCP_BPF_SOCK_OPS_CB_FLAGS,
                 &flags, sizeof(flags));

or via the SOCK_OPS specific helper:

  bpf_sock_ops_cb_flags_set(skops, BPF_SOCK_OPS_RCVQ_CB_FLAG);

Once activated, the BPF prog will be invoked with bpf_sock_ops.op
set to BPF_SOCK_OPS_RCVQ_CB upon the following events:

  1. TCP stack enqueues skb to sk->sk_receive_queue
  2. TCP recvmsg() completes

This allows the BPF prog to dynamically adjust sk->sk_rcvlowat,
suppressing unnecessary EPOLLIN wakeups until sufficient data
is available in the receive queue.

This functionality, which we call "TCP AutoLOWAT", was originally
developed in 2020 by Tenzin Ukyab with the help of Soheil Hassas
Yeganeh, Arjun Roy, and Eric Dumazet.  It has served Google RPC
workloads for more than 5 years.

Combined with TCP RX zerocopy, this typically allows us to read an
entire RPC frame with just a single wakeup and a single system call.

While the original implementation was specialised for our
internal RPC format, this series introduces a more flexible
version by leveraging BPF.

The BPF SOCK_OPS prog in the last selftest patch closely mirrors
the core logic of the original implementation to provide a real-world
example.

Overview:

  Patch  1      : misc cleanup for testing
  Patch  2      : Add BPF_SOCK_OPS_RCVQ_CB with no actual hooks
  Patch  3 -  5 : Add bpf helpers
  Patch  6 -  8 : Add safe guard for BPF_SOCK_OPS_RCVQ_CB
  Patch  9 - 10 : Add BPF_SOCK_OPS_RCVQ_CB hooks
  Patch 11      : selftest


Changes:
  v3:
    Patch  6: Check sk->sk_prot and update tp->bpf_sock_ops_cb_flags
               under sk->sk_callback_lock, and only when not flagged yet.

  v2: https://lore.kernel.org/bpf/20260522074601.1658705-1-kuniyu@google.com/
    Add Patch 6 - 8
    Patch  2: s/BPF_SOCK_OPS_RCVLOWAT_CB/BPF_SOCK_OPS_RCVQ_CB/g
    Patch  3: Explain why using ____ version instead of __ version
    Patch 10: Add explanation of tcp_bpf_rcvlowat() placement.
    Patch 11: Make copy_len u64 and swap validation order for it
               to pass no_alu32 test case

  v1: https://lore.kernel.org/bpf/20260508073355.3916746-1-kuniyu@google.com/


Kuniyuki Iwashima (11):
  selftest: bpf: Use BPF_SOCK_OPS_ALL_CB_FLAGS + 1 for bad_cb_test_rv.
  bpf: tcp: Introduce BPF_SOCK_OPS_RCVQ_CB.
  bpf: tcp: Support bpf_skb_load_bytes() for BPF_SOCK_OPS_RCVQ_CB.
  tcp: Split out __tcp_set_rcvlowat().
  bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.
  bpf: tcp: Make BPF_SOCK_OPS_RCVQ_CB and SOCKMAP mutually exclusive.
  bpf: mptcp: Don't support BPF_SOCK_OPS_RCVQ_CB.
  bpf: tcp: Reject BPF_SOCK_OPS_RCVQ_CB if receive queue is not empty.
  bpf: tcp: Factorise bpf_skops_established().
  bpf: tcp: Add SOCK_OPS rcvlowat hook.
  selftest: bpf: Add test for BPF_SOCK_OPS_RCVQ_CB.

 include/net/tcp.h                             |  14 +
 include/uapi/linux/bpf.h                      |  18 +-
 net/core/filter.c                             |  95 ++++-
 net/ipv4/tcp.c                                |  14 +-
 net/ipv4/tcp_bpf.c                            |  12 +
 net/ipv4/tcp_fastopen.c                       |   2 +
 net/ipv4/tcp_input.c                          |  25 +-
 tools/include/uapi/linux/bpf.h                |  18 +-
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   4 +
 .../selftests/bpf/prog_tests/tcp_autolowat.c  | 350 ++++++++++++++++++
 .../selftests/bpf/prog_tests/tcpbpf_user.c    |   3 +-
 .../selftests/bpf/progs/bpf_tracing_net.h     |   2 +
 .../selftests/bpf/progs/tcp_autolowat.c       | 326 ++++++++++++++++
 .../selftests/bpf/progs/test_tcpbpf_kern.c    |   3 +-
 14 files changed, 870 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c
 create mode 100644 tools/testing/selftests/bpf/progs/tcp_autolowat.c

-- 
2.54.0.746.g67dd491aae-goog



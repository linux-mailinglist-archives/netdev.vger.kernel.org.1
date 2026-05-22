Return-Path: <netdev+bounces-290701-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEuiIF8KEGpqSwYAu9opvQ
	(envelope-from <netdev+bounces-290701-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:48:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 004FF5B0307
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42F503016912
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 07:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41B23612ED;
	Fri, 22 May 2026 07:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aPlNA/Nx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E32C33F58E
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 07:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779435967; cv=none; b=XtNr8m44li904r7U2yC880WmHLeTezEvgnEHhKUIR6VuQTDxwTwvul5UaBQE+yrf/9KrytUk1UA2GmcFzF5L1iRObyMX5UQ2XJcAvsM4tb7D+rAorfmBY4fzrobdYMVq+p/hDh0BKlleecXBCOlxyi/MFspOEhwYwHxUSxUAuxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779435967; c=relaxed/simple;
	bh=YtuyIdQZY+eul6VUiynURNGynwN0UeTB6J/R8fpgDyM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=P4z0G5EbAg6RNb9R6mI0zgKJHaFdGrem+I8mH+SM7D44rCWuWzoyBCohyUBvdLdpVN/7sTHEaChdYMGuq355C/Gdechhp1TGRuDqxrqcv1JrVh9VtxN2RG0T+BAhNiQS8oHDsSAVTVFLyRSle+YX6Ph9AwkSDs+OxEOYDEDaRg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aPlNA/Nx; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2baf7378ad0so74203245ad.0
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 00:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779435965; x=1780040765; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L4N3hOfAzGfaW5hWnhwkjve/GusrE1zFUOtYHsUbX90=;
        b=aPlNA/NxZL9SyhsXSRP47saw3l7/ESbzyt1JlsYI6hCVzISdIHdY8a2S/BXnwh9hs+
         sieTUDDCjGQiFcrB7VdsM9wu6xHM97kRRIuLR/QahUwC6Eti9j0c59RsQk4IHWr9oVfA
         lLN8GPW4nZ3sf/pDFivDBkGN6i8o7W5e4ZvAByZ/spwmHdQbHE0dWsYMM3N00SyvXJQS
         kLfKUK4BaMaLvfHpXi/DTUPqxI6w9yTVcqZzMBCxNCtuFB5Nq/uDnaHbeuCzC50g0qbJ
         nP/pARjDmkblzBIHRKevSTWP1mEa8cge25Xvg2iDeSTFQYzvjgRxd5d0ZeEk+3cu7Alh
         QdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779435965; x=1780040765;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L4N3hOfAzGfaW5hWnhwkjve/GusrE1zFUOtYHsUbX90=;
        b=aJiSwuQSYuaf8OCswgFpapNMv+Fz2iYSfqU6kcDVY1qUjugzQ5y/HAubfj5cjLzs2P
         RwAH1v4kH7jUNs7BRK/9sXS0UjRmpvOwa5iGQuIlxIVy9yzWrn8yY7c3dhC6EAN49+be
         mMznLtd8yKEZRNliC4zKBRdQdPhzgxZXpE6ZDN5okgNk8FL0/WATIy7a+upCdiraQInj
         nrSym1unL1PmfUiLdncfu8nygAjQYZRDFXDd5gkX7S1fZH7TlgRMh/yGA21sKnyfFrXa
         sRFo+L3mwBEsTOxHPFh3GLTKIaX34QQNxrEOhxnxo6zlcJakH2VsKdP9pqfMM2e5muJl
         /JAw==
X-Forwarded-Encrypted: i=1; AFNElJ9X3NvJk1LytYjuje7HljCQx/YtWz8PLHkuL1LBNVXcXaicVrXYlB2yN0ioUt13m9ljOEwtNAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvB/5kGIRq9Mp7o9W/oTzQnUefCLoRyMWsEiW4bWA5oA2ykiCz
	tffzpmYQUryTJaJOUDF8XOwYJPAHp7yR9Ul/ZaSlWRVbrwcJCQg+6GxzFWDB397DBgf/QMiryiV
	tpThu1w==
X-Received: from plek17.prod.google.com ([2002:a17:903:4511:b0:2bd:9574:2958])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c94f:b0:2b0:608d:d8a8
 with SMTP id d9443c01a7336-2beb0366400mr25021195ad.1.1779435965129; Fri, 22
 May 2026 00:46:05 -0700 (PDT)
Date: Fri, 22 May 2026 07:44:51 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522074601.1658705-1-kuniyu@google.com>
Subject: [PATCH v2 bpf-next 00/11] bpf: Add SOCK_OPS hooks for TCP AutoLOWAT.
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290701-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.960];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 004FF5B0307
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
  v2:
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

 include/net/tcp.h                             |  13 +
 include/uapi/linux/bpf.h                      |  18 +-
 net/core/filter.c                             |  89 ++++-
 net/ipv4/tcp.c                                |  14 +-
 net/ipv4/tcp_bpf.c                            |   2 +
 net/ipv4/tcp_fastopen.c                       |   2 +
 net/ipv4/tcp_input.c                          |  25 +-
 tools/include/uapi/linux/bpf.h                |  18 +-
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   4 +
 .../selftests/bpf/prog_tests/tcp_autolowat.c  | 350 ++++++++++++++++++
 .../selftests/bpf/prog_tests/tcpbpf_user.c    |   3 +-
 .../selftests/bpf/progs/bpf_tracing_net.h     |   2 +
 .../selftests/bpf/progs/tcp_autolowat.c       | 326 ++++++++++++++++
 .../selftests/bpf/progs/test_tcpbpf_kern.c    |   3 +-
 14 files changed, 855 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c
 create mode 100644 tools/testing/selftests/bpf/progs/tcp_autolowat.c

-- 
2.54.0.746.g67dd491aae-goog



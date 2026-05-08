Return-Path: <netdev+bounces-285685-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEpOL8qS/WnWfgAAu9opvQ
	(envelope-from <netdev+bounces-285685-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 09:37:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 407554F318E
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 09:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 783FF300695D
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 07:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35362329C6B;
	Fri,  8 May 2026 07:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="id6RhLto"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF23231F9BE
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 07:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778225657; cv=none; b=SN5tWsJ4ZhNJ79onForUkAsZI2bc3I1r/bbYePq4IocjqoUYG4WqOJ2lpiKjdzcTZcx5mN+y0GKaIvc+YquexwdQz39M6mGdLtPmBWY6MVhZLmgxHhVDXg7NiS9X+nwXkgd8iZROtmM1k4MzLqZutLJEhX9MWgL6pzWyEP6Bl/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778225657; c=relaxed/simple;
	bh=9rbpH9sTtoxDH1P1A5GC1ty6OQLE5yq76Pq1luSCRBI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qi10QcbkRxbZOGepFjsM8Q+JGtjyWOnZn6yFEPr+GGHf6y5n4vIkn55L98SAkKBTmezbUwMD/2QIDbmkdlNHOFBAgLjowUk+h9w0Y0vjfAkAvsjeOkZaNlD0hPDqbmjMIrmOviuk4RjO+E2TiNA98VoK1jkDxak/qWPLw/GD09E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=id6RhLto; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f6e6a3a76so1719356b3a.0
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 00:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778225655; x=1778830455; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/7Pn1xhB3shHE/iVX8WNrP72hOJ5ZDHm6Pa6CaRu/P0=;
        b=id6RhLtoEAYT5svEeBM4dmxnNme44cs7+/tC2mcRp3Z7x5h15DklA3tgWO/0UwUJXq
         +zU/NwfZh/ZkDfep6lrmrsnODZM5WZYTW7E9o/jymObT0lKyIQiRZFmbmgox8WfzfD8s
         sZL6oGV/ixilkMN7pSzjBKvhTXUbCy6kTwlAsb62nHyrLYprJPV4SVbE4cprPS40C1N+
         2O14qriJxpzaOseA2qogvmFfFNGN0CdsauqEy1rnggjxAgB0jIQG5X79J76V4rat6OH8
         FY401UFWqTSLnfGf6vrzF7WpzHud6woyiZrgAYcnIKyDXBJkYaPx/dVIu/OTSM0txAsC
         RjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778225655; x=1778830455;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/7Pn1xhB3shHE/iVX8WNrP72hOJ5ZDHm6Pa6CaRu/P0=;
        b=CeJNAIJDSA0bDQhuARoXML/b4dA356pnZ5PKzENydNiKIb/GK5u0ziy3J65dDxGHhH
         1rO22JU0HiMtOsILHO42HpEZcmr9BVfzPIFsAw9aUTB+eCMqL9DJtSgwncbp715tBrjK
         7r+UMf8YEXxzd3b7qRMkQGLdJXu0UsGnQhD+mBqoZdoKmluo2Hlttknbjh1ac4d9xauV
         dWXOcT4ikYL6iXJcdTaV1FoKtoh2LG/LqgWV8H5f/aaUpGoOiS1IGF3BMY3bnohvPjbk
         eTgY1SEOylvWVDK0LBEyJeDHBE2JwZ9PXWZi4z0IxaISipeLv3LQT5bmP0ls7vnWVtUS
         2IVw==
X-Forwarded-Encrypted: i=1; AFNElJ9fidiDDIneIi+NSJ4US85C3v0u5WFq5dfl7B3PoVmKnql34mN81RQrJsNhzJboYwvh2y1Fcgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYzxacI8lq9PQXJiIlpVTpmxNCURdYutpdkgICc50uT6SEgzsa
	rJjOD5flIsAVcMYwbyVBW/DWwRcYWkipccJ0YAhhYmE2U+v35K3Eurp9W63H4L1pl65Hr7IWLBu
	vY0W2Cw==
X-Received: from pfbmx6.prod.google.com ([2002:a05:6a00:6ec6:b0:82f:dd9:c650])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:94f6:b0:82f:a6bf:bee7
 with SMTP id d2e1a72fcca58-83a5ea435b1mr11249860b3a.49.1778225654929; Fri, 08
 May 2026 00:34:14 -0700 (PDT)
Date: Fri,  8 May 2026 07:33:21 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260508073355.3916746-1-kuniyu@google.com>
Subject: [PATCH v1 bpf-next 0/8] bpf: Add SOCK_OPS hooks for TCP AutoLOWAT.
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
X-Rspamd-Queue-Id: 407554F318E
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-285685-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This series introduces BPF_SOCK_OPS_RCVLOWAT_CB, a new type
of opt-in hooks for BPF SOCK_OPS prog.

The hooks can be enabled on per-socket basis by bpf_setsockopt():

  int flag = BPF_SOCK_OPS_RCVLOWAT_CB_FLAG;

  bpf_setsockopt(sk, SOL_TCP, TCP_BPF_SOCK_OPS_CB_FLAGS,
                 &flags, sizeof(flags));

or via the SOCK_OPS specific helper:

  bpf_sock_ops_cb_flags_set(skops, BPF_SOCK_OPS_RCVLOWAT_CB_FLAG);

Once activated, the BPF prog will be invoked with bpf_sock_ops.op
set to BPF_SOCK_OPS_RCVLOWAT_CB upon the following events:

  1. TCP stack enqueues skb to sk->sk_receive_queue
  2. TCP recvmsg() completes

This allows the BPF prog to dynamically adjust sk->sk_rcvlowat,
suppressing unnecessary EPOLLIN wakeups until sufficient data
is available in the receive queue.

This functionality, which we call "TCP AutoLOWAT", was originally
developed in 2020 by Tenzin Ukyab with the help of Soheil Hassas
Yeganeh, Arjun Roy, and Eric Dumazet.  It has served Google RPC
workloads for more than 5 years.

Combined with TCP RX zerocopy, this typically allows us to read
an entire RPC frame with just a single wakeup and a single system
call.

While the original implementation was specialised for our
internal RPC format, this series introduces a more flexible
version by leveraging BPF.

The BPF SOCK_OPS prog in the last selftest patch closely mirrors
the core logic of the original implementation to provide a real-world
example.

Overview:

  Patch 1     : misc cleanup for testing
  Patch 2     : Add BPF_SOCK_OPS_RCVLOWAT_CB with no actual hooks
  Patch 3 - 5 : Add bpf helpers
  Patch 6 - 7 : Add BPF_SOCK_OPS_RCVLOWAT_CB hooks
  Patch 8     : selftest


Kuniyuki Iwashima (8):
  selftest: bpf: Use BPF_SOCK_OPS_ALL_CB_FLAGS + 1 for bad_cb_test_rv.
  bpf: tcp: Introduce BPF_SOCK_OPS_RCVLOWAT_CB.
  bpf: tcp: Support bpf_skb_load_bytes() for BPF_SOCK_OPS_RCVLOWAT_CB.
  tcp: Split out __tcp_set_rcvlowat().
  bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.
  bpf: tcp: Factorise bpf_skops_established().
  bpf: tcp: Add SOCK_OPS rcvlowat hook.
  selftest: bpf: Add test for BPF_SOCK_OPS_RCVLOWAT_CB.

 include/net/tcp.h                             |  15 +
 include/uapi/linux/bpf.h                      |  18 +-
 net/core/filter.c                             |  51 +++
 net/ipv4/tcp.c                                |  14 +-
 net/ipv4/tcp_fastopen.c                       |   2 +
 net/ipv4/tcp_input.c                          |  25 +-
 tools/include/uapi/linux/bpf.h                |  18 +-
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   4 +
 .../selftests/bpf/prog_tests/tcp_autolowat.c  | 350 ++++++++++++++++++
 .../selftests/bpf/prog_tests/tcpbpf_user.c    |   3 +-
 .../selftests/bpf/progs/bpf_tracing_net.h     |   2 +
 .../selftests/bpf/progs/tcp_autolowat.c       | 316 ++++++++++++++++
 .../selftests/bpf/progs/test_tcpbpf_kern.c    |   3 +-
 13 files changed, 810 insertions(+), 11 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c
 create mode 100644 tools/testing/selftests/bpf/progs/tcp_autolowat.c

-- 
2.54.0.563.g4f69b47b94-goog



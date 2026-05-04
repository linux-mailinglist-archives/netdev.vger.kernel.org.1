Return-Path: <netdev+bounces-284040-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGhZLGcK+Wnt4gIAu9opvQ
	(envelope-from <netdev+bounces-284040-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 23:06:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B354C3DF0
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 23:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57434301ABA4
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 21:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB2233E346;
	Mon,  4 May 2026 21:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pjhu7vqB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D604D31E83C
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 21:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777928774; cv=none; b=PgRKl47zqklny/joulA82Fy9ay7V39GBFWsux84LGB0frEExJbjAGGgTNP5Ab/xICH7ZQZZgy5uEgKNeHPV+VwdraSZfqMZ7jCaoekgtoAN0jDqETDXMBS7WEam8o+NXkXXZBWyNrXKgodA0lDaH/y1Z5DC8/VVctSUrpoO4x8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777928774; c=relaxed/simple;
	bh=vcU8idIUwMCKkvk/pPp3VWO6bf+ST48nqlXCkHAS8SA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XGMiGQOn1tye8RMfrBWzq/tzG2oXtu8v3OhlgUX51AOJ5ihcQXKD5F3sPO7yufg4IVo2Z06Ns/ZsvAaHe6I0cfr15n0qk78Y+72V0PiY+6rUcwJntoN/rgs8BAe63vUXnZQT/lW0NDvYKU7874ye2bvScd+rd8pd/ou0sYiyt2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pjhu7vqB; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3653638874cso1930249a91.2
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 14:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777928772; x=1778533572; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=saJcCx34yPqZu6s4wgP31guVMnuHq9ARYffBdNUR00o=;
        b=pjhu7vqBxOWBax8ppKxiWCSbI68nzAacuP+qPyS++bas8o/KZ3ddbA/wxk2r3i/2Tu
         JMocmIUWMKTBptGwyH5i93qb97WNHNpK3mAkegJcsSe9n1KzWNK+99rRG9+5ZVjwrI0T
         YGRqxzEXBg31H4GpVBcUKmZJeQDpVpdHE9O+9/YFr4kyZPBFvGxuAm13hXlEUtcayEf9
         V6sBou8E6RvmhDyDmSAKuRK0zDIHm/QNKYHmnA13QKkhluHelKta4FrbzRCPVxUMDYlQ
         W6JmxhAE5B/n9fAdVqFN2Bahu5PG2EJw/cDUDDZvZvNERU6xFu8D2EORKkbPgEMDaMGb
         xNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777928772; x=1778533572;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=saJcCx34yPqZu6s4wgP31guVMnuHq9ARYffBdNUR00o=;
        b=LEYK0qiJq0LzXKKBXiX5QgPHishvOqv9krO/I7k13TickCOWgIqS9ZDXil8nM8V0Lk
         3duMx1mUMSYUbUlSUhTFy4kchobxJJN9a8TCe7a/i3dP0I01XwvsLin0j6AkEt/GuKZx
         Oghruj9Tp8vMj58IURjhsPu/d+e5l5BMjTbWXuah0OLwRot3kbfmRkn7acKYzgt3xYdf
         p7jt5KaqP3J7ooWhsy0D4WaCXzTcxNsFnsyD4RgKa5hzVX4JXyoB0mRAuGC0+aEPnce3
         skwDYsHpqb//V+93LzUyf8q8Tx7JsJF2NjnjOBu4dc4tz/uVwHd+XKRQD7ue5K1M/Nfm
         oUmQ==
X-Forwarded-Encrypted: i=1; AFNElJ8HDA32BjvZ/4kHqhnEB9swpNToYNqIAUoJ+ES46ixkFm7T7AwBIFm2dncFH7OEF26bEHXzwoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnXDd01PHPdZscjcklwJmAVmkJtFEm3yJTUF8J0z1v2b/zyivn
	KbUNjakxbigD8ElDqbIwbvTJUQEvxAvX/LntqCq2szkT0Wj+WQywhNyFcInMfV0xXK9DKrjvXvz
	YAzW2Hg==
X-Received: from pjva3.prod.google.com ([2002:a17:90a:d803:b0:364:ff68:5a3c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:35cf:b0:35e:58d3:329f
 with SMTP id 98e67ed59e1d1-3650ce8654cmr11209655a91.13.1777928772105; Mon, 04
 May 2026 14:06:12 -0700 (PDT)
Date: Mon,  4 May 2026 21:04:47 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504210610.180150-1-kuniyu@google.com>
Subject: [PATCH v2 bpf 0/6] bpf: tcp: Fix type confusion in bpf helper functions.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 18B354C3DF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	FREEMAIL_TO(0.00)[linux.dev,iogearbox.net,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284040-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,fomichev.me,kernel.org,linux.dev,google.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

bpf_tcp_sock() only check if sk->sk_protocol is IPPROTO_TCP,
but RAW socket can bypass it:

  socket(AF_INET, SOCK_RAW, IPPROTO_TCP)

The same issues exist in other bpf functions:

  * bpf_mptcp_sock_from_subflow()
  * bpf_skc_to_tcp_sock()
  * bpf_skc_to_tcp6_sock()
  * sol_tcp_sockopt()

Patch 1 fixes bpf_tcp_sock() and Patch 2 adds a test for it.
Patch 3 ~ 6 fix the rest of the functions above.


Changes:
  v2:
    * Inverse if (err) to if (!err) in the selftest
    * Add patch 3 ~ 6

  v1: https://lore.kernel.org/bpf/20260430184405.1227386-1-kuniyu@google.com/
      https://lore.kernel.org/mptcp/20260430-mptcp-bpf-mptcp-sock-type-v1-1-d2ed5cda7da9@kernel.org/


Kuniyuki Iwashima (5):
  bpf: tcp: Fix type confusion in bpf_tcp_sock().
  selftest: bpf: Add test for bpf_tcp_sock() and RAW socket.
  bpf: tcp: Fix type confusion in bpf_skc_to_tcp_sock().
  bpf: tcp: Fix type confusion in bpf_skc_to_tcp6_sock().
  bpf: tcp: Fix type confusion in sol_tcp_sockopt().

Matthieu Baerts (NGI0) (1):
  mptcp: bpf: fix type confusion in bpf_mptcp_sock_from_subflow()

 net/core/filter.c                              |  8 ++++----
 net/mptcp/bpf.c                                |  2 +-
 .../selftests/bpf/prog_tests/sockopt_sk.c      | 18 +++++++++++++++++-
 tools/testing/selftests/bpf/progs/sockopt_sk.c | 16 ++++++++++++++++
 4 files changed, 38 insertions(+), 6 deletions(-)

-- 
2.54.0.545.g6539524ca2-goog



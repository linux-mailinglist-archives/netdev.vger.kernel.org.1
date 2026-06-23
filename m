Return-Path: <netdev+bounces-301435-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hv8aBXDHOmrZGggAu9opvQ
	(envelope-from <netdev+bounces-301435-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:50:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA2B6B9405
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:50:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dPnPftCa;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301435-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301435-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBCD0305E1B6
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 17:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72FE38F633;
	Tue, 23 Jun 2026 17:50:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4376A38D3F9
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 17:50:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237011; cv=none; b=M3AyjgCJmOnQKOoArCcLC/nrBTDgvlUyZA8hPdVHLc/Aw3SxN8bgrtPN6V0XBMzFYaBTLmcCFq2chORvnbEwN8oFJcaKVn72mCZ2dSdxXxdm20xiHgfPFy86QHNQssSyY1jHKrvH5MuQN8Fd7S9nSgu2+heZMXlqzd1g2CFSGYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237011; c=relaxed/simple;
	bh=J4Mmg50ei5MqCilxr8JVSS/g8YXU0rdSBLfRIFuLPHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QBpao2+2UVpAdX1+p0vfGK7+UVSgQTvRGd9POVynv6aSWL8VB6SBK32w/rmWvHG9Gnp1UJRzmuq+2k7ztn9fsl3TuoRNB7i4gIiki06/0XXzr7zcUmiouT0IrkWOcoCWn9uI5PItpKzsKQzz7ueK3K6uJIS0/4I4CXT+5z81q0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPnPftCa; arc=none smtp.client-ip=209.85.161.47
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6a11ee16bafso138302eaf.0
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 10:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782237008; x=1782841808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5T1ktDtWc3MIt0N1DGCs0NMaU/i1dfQECQKpgA5t4J0=;
        b=dPnPftCaVwoCNrSuOpSm50wf6msfZN1PLHmqDbVUfcCgNSUkg9iXBRb8WX052kOw+v
         yVhefuAKLQ9mJB9i3oba0ANuIViVKIsPgzZMKNl8cy1b86jagfORDbWhDqD8jx5PqTs2
         4ct3AmpFxgXEBe04dXB7uEQU/wTwTsrLp2+v+rD7lfjiyyU1aXbreRP3G0fMH0NjcPQc
         AzUse3DDXSdm2V5iPMlzPHGquPomRJZtDKjrOLhgO/HKD5q0BPSHwnGKtQLGUiXbKniQ
         sqdZ6qL/1vnkqeXdZf/rbLfNoKjfKGOiG+Ojy0Z0VARYSepYlpxXNqCrriAK+MXh1bCN
         xqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782237008; x=1782841808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5T1ktDtWc3MIt0N1DGCs0NMaU/i1dfQECQKpgA5t4J0=;
        b=DRN0hgDCRovNTQUsTrONQ278sQ781R40HOORL7+MxTscm1ahrdklNHQFALR2BsmcKn
         ae9ksoBSwO7+oqDL7AfMUqem/GcbeM62QhTt8K2iXI3/rPyq2sBPLHvxr4NM+aqc7bXf
         523D8ra/gJfCYjCD9K8hDXmhXwPzD7FmHERSpV3cnS2K8qmLnqDbn+S1g4y0KTcLv530
         +SC3+MDKjKLJFXo6jAQyj0rGX/hbw8IZrzNz6e7LykjgxmPEdUukMWFWKKZW1nsD74/m
         EURmtQgkctb+wEi/rwPsJTMcPk4Pjsn43nnBL+yJHfheHLAYGOOroJrKswJAmDPDdBu1
         xmBg==
X-Gm-Message-State: AOJu0Yy0HWPAW3i/YEcEDjS9oIfyqLvBGrs6JUXrFFaDiBn3uCoU87ol
	m/3eR5BDJJ/am+LQPxoFyY0w5pVfpen5WYYJSAi+WH2kclqHQC5dIjZ/
X-Gm-Gg: AfdE7ckRmCnBBKNZe40lrHZeKTgGawX7UfYNXSTuwfXa+tt0QI0UhvvX5WIGZSJYNzj
	n4S8AjoYdJYTbUtpwD+6jzsOtX0/JlB5HKfWRKVGHtMLvPIAvJOnKb9qOV6lKuApnSYS4cbGYLs
	xcQWJzcUqmIXkXvs7WVLgcq9Sv23ZfTiCNyKBIUxzDgk4vuoO+9uA8215Acr5nXY8fv6FdNWAeZ
	MeHhUJb2telL4vfIPq7wfk+RHVOLN124yg+1+KDcDpusD0a4+V7azDwbmRLOXunSrHcVcDGvejE
	RO9jSsqYaQ/2ZdexEswMwfuTlvviXJY7puMVyPfcei4qqIVOWeH9Odw+JYc74+sglqoDoVeckSG
	RJsDutpsIyOJO+M09HevC9MQDyx6YJ8Ry4/7v6RxrH46yYdgktxl4t0MESypkqGdsIP6kcG92ql
	lV8jA=
X-Received: by 2002:a05:6820:190f:b0:6a0:c3ed:be45 with SMTP id 006d021491bc7-6a0d8d5d523mr14664965eaf.54.1782237007813;
        Tue, 23 Jun 2026 10:50:07 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a0ea102694sm7193449eaf.13.2026.06.23.10.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:50:07 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	kuniyu@google.com,
	kerneljasonxing@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 00/15] bpf: A common way to attach struct_ops to a cgroup
Date: Tue, 23 Jun 2026 10:49:48 -0700
Message-ID: <20260623175006.3136053-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	TAGGED_FROM(0.00)[bounces-301435-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:shakeel.butt@linux.dev,m:roman.gushchin@linux.dev,m:kuniyu@google.com,m:kerneljasonxing@gmail.com,m:ameryhung@gmail.com,m:kernel-team@meta.com,m:alexeistarovoitov@gmail.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9CA2B6B9405

Hi,

I am continuing Martin's work to support attaching struct_ops to cgroup.

At LSF/MM/BPF 2025, Martin presented [1] the need for a new interface
to extend tcp_sock operations instead of adding more BPF_SOCK_OPS_*CB
enum values. The need for predictable ordering when attaching struct_ops
to a cgroup was also briefly discussed.

At LSF/MM/BPF 2026, additional use cases were raised, in particular
OOM and memcg use cases that also need to attach struct_ops to a
cgroup.

BPF already has a common bpf_link-based API for attaching different
BPF program types to a cgroup. It provides common attach, detach,
update, ordering, and query semantics across those program types.

This series extends the same model to struct_ops. Conceptually,
struct_ops is a group of BPF programs, so using similar
attachment/detachment/update/query APIs and ordering semantics for
cgroup attachment keeps the interface consistent with existing cgroup
BPF links.

This series uses a new struct bpf_tcp_ops as the first user. The
struct_ops mirrors the TCP-related sockops hooks except
BPF_SOCK_OPS_NEEDS_ECN and BPF_SOCK_OPS_BASE_RTT, which are
intentionally left out.

The selftests cover attach, query, update, ordering, before/after
placement, retval chaining, the header option hooks, and inheritance
across a multi-level cgroup hierarchy.

The map_free_pre_rcu addition in patch 2 is not very ideal; it will
need some thought too.

[1] page 13: https://drive.google.com/file/d/1wjKZth6T0llLJ_ONPAL_6Q_jbxbAjByp/view?usp=sharing


Changelog

RFC v1 -> v2
  - Fix UAF of cfi_stubs
  - Fix retval: use bpf_tramp_run_ctx instead of bpf_cg_run_ctx and
    expose bpf_get_retval() to bpf_tcp_ops
  - Add selftests
    - struct_ops cgroup attachment
      - Test bpf_get_retval()
      - Test before/after order
      - Test cgroup hierarchy and inheritance
    - Test TCP header option hooks and helpers
  - Move bpf_tcp_ops out of legacy BPF_SOCK_OPS_TEST_FLAG guard
  - Complete bpf_tcp_ops (make it comparable to legacy sockops tcp)

---

Amery Hung (4):
  bpf: Allow all struct_ops to use bpf_dynptr_from_skb()
  bpf: tcp: Support selected sock_ops callbacks as struct_ops
  bpf: tcp: Support parse/len/write header option hooks in bpf_tcp_ops
  selftests/bpf: Add test for bpf_tcp_ops header option hooks

Martin KaFai Lau (11):
  bpf: Remove __rcu tagging in st_link->map
  bpf: Make struct_ops tasks_rcu grace period optional
  bpf: Add bpf_struct_ops accessor helpers
  bpf: Remove unnecessary prog_list_prog() check
  bpf: Replace prog_list_prog() check with direct pl->prog and pl->link
    check
  bpf: Add prog_list_init_item(), prog_list_replace_item(), and
    prog_list_id()
  bpf: Move LSM trampoline unlink into bpf_cgroup_link_auto_detach()
  bpf: Add a few bpf_cgroup_array_* helper functions
  bpf: Add infrastructure to support attaching struct_ops to cgroups
  libbpf: Support attaching struct_ops to a cgroup
  selftests/bpf: Test attaching struct_ops to a cgroup

 include/linux/bpf-cgroup-defs.h               |   1 +
 include/linux/bpf-cgroup.h                    |  28 +
 include/linux/bpf.h                           |  56 +-
 include/linux/filter.h                        |   5 +
 include/net/tcp.h                             | 153 ++++-
 include/uapi/linux/bpf.h                      |  39 +-
 kernel/bpf/bpf_struct_ops.c                   | 152 +++--
 kernel/bpf/btf.c                              |  23 +-
 kernel/bpf/cgroup.c                           | 472 ++++++++++++++-
 kernel/bpf/core.c                             |   5 +
 kernel/bpf/syscall.c                          |   4 +
 net/core/filter.c                             |  33 +-
 net/ipv4/Makefile                             |   1 +
 net/ipv4/af_inet.c                            |   1 +
 net/ipv4/bpf_tcp_ca.c                         |  16 +
 net/ipv4/bpf_tcp_ops.c                        | 310 ++++++++++
 net/ipv4/tcp.c                                |   1 +
 net/ipv4/tcp_input.c                          |  17 +
 net/ipv4/tcp_output.c                         |  48 ++
 net/ipv4/tcp_timer.c                          |   1 +
 net/sched/bpf_qdisc.c                         |   2 -
 tools/include/uapi/linux/bpf.h                |  39 +-
 tools/lib/bpf/bpf.c                           |   2 +
 tools/lib/bpf/bpf.h                           |   3 +-
 tools/lib/bpf/libbpf.c                        |  59 ++
 tools/lib/bpf/libbpf.h                        |   3 +
 tools/lib/bpf/libbpf.map                      |   5 +
 tools/lib/bpf/libbpf_version.h                |   2 +-
 .../selftests/bpf/prog_tests/bpf_tcp_ops.c    | 554 ++++++++++++++++++
 .../bpf/prog_tests/bpf_tcp_ops_hdr.c          |  97 +++
 .../testing/selftests/bpf/progs/bpf_tcp_ops.c | 141 +++++
 .../selftests/bpf/progs/bpf_tcp_ops_hdr.c     |  83 +++
 32 files changed, 2234 insertions(+), 122 deletions(-)
 create mode 100644 net/ipv4/bpf_tcp_ops.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_hdr.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_tcp_ops.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c

-- 
2.53.0-Meta



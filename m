Return-Path: <netdev+bounces-305158-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zntjC6fmS2qwcQEAu9opvQ
	(envelope-from <netdev+bounces-305158-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 19:32:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E95713E58
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 19:32:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=C3yJ6Xan;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305158-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-305158-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C6AB302E994
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 17:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37BA3A641F;
	Mon,  6 Jul 2026 17:19:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D6F38C42E
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 17:19:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358364; cv=none; b=IrJSJoeXm4xwoTIpS3Bd9FoDa04wV8mFRWH5E1wNdKsRvNlnSMthrNDPDc5NoQrVvlOkozhU9BhOz69slvx1SrgxZaYrcWA2b0Jq7nLYevftbD35BQ5eacR/cBzjzqq83nY9IicGiudVcwn0F2AKutqNUeOCz/+UcTrdtEj4gNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358364; c=relaxed/simple;
	bh=ehUPaU/1dF2KpG5kToZV7U5XhlQnUkBKHuGMy/qSzhs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FGquObv3MqAuBOSUQSn4VcSuoBnwVYS/rjN2OXPSylbBxBok+02XOXkYTGl0l5I+nvZhIU4zNt5eNFCoRSlFfkpMPCKbXfOneBq9LruZTDyMVIQf7UXK/w0/ITQi7F8sTPq9DOALdWeCSGqBaYwG5LvtSeOkITHQtnP5Nb1Otws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3yJ6Xan; arc=none smtp.client-ip=209.85.210.41
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e9f5637634so1555683a34.3
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 10:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783358362; x=1783963162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CcnEKxuZvnrlq/X8pfnKmD+Iim0hx24bDmSujajdu2Y=;
        b=C3yJ6Xanaw0+kWmedBpRUt76aNgktRzzTp8Df+YloZ3DIltOIyRAV1ucL9hjoK/V5T
         zVJ8n5mqkPPp0O5tRbnxpP6lxm6E9STbO2CIADU7Iqnx/eO+PaK+0Q3+wmDyKy0hr2nV
         fCAorBCKqpK5ZOxVKHxreVoDHRqPyaVqK5F8NLCCCghNhFpMkIsFWTYd2cnFOwtcHRur
         v0k681+ldBt41nucDVaON0IBhkSVxUZag2SQQNF9H3mzCeeJpjz6AYyIO8nYkG0wNbsA
         cgM27kAZDV5FoWkGsL1yoJmX5z4EFd9tOLnX/dJ92CStg6UT0iOCdGE520uWRQ252wrf
         BzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783358362; x=1783963162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CcnEKxuZvnrlq/X8pfnKmD+Iim0hx24bDmSujajdu2Y=;
        b=UjIlkeXLCCdiPUlw6n4uVgAVZzAeWd5YsbPGvcZuon2PoYEvVcO5VbBTT1EwXt0sXX
         ZfMFsZKOYshf169lXYFcNq9IuuTCVkp2RyGPw5jgjqmT/VopSwyYz8BdzhIMvLQRfbT4
         i0+x+eVTVwZrq9ci5o8XQEWhFlc9wdscsXuk0yNekJ/B7aOyw2S3lB3FiNQdQt/OWph2
         5PB0833avhbYXeo8d7uRt4/xoCVtl9Gwzk8bYMXjRr9Vm9z/vCYVewbWIfnH9aTz4KkW
         adQCQpedOBRZQpHSame+drW0LVwKgbQDVQM2Nix8t1c8tEO8/RFwyc3+pd9twirybSlN
         0DLg==
X-Gm-Message-State: AOJu0YwmyHdBxHiWT5ptCnF8urtJ14tJaLCz0rGATGqCer50Hhuo7FtQ
	akdhJGF/3pKJGfPFdD232muZmDHs8LET3NIDaEZA5r/0dk5vghEsZoKF
X-Gm-Gg: AfdE7clzJmtn7Yg289FY1HLbbrpCFkoGrr21pMcrLMdm0dlvK89T2oUXgBvNRCkCsYD
	D70yaVFjJXy7lAi2lF8CH9P6F2ihq1xo1U19/1XDIbik4Cyt7gKEy/dEbJeHCc23hRELBbW2itn
	A4sVAY3G6UWIUXDSBuou+eUZzOhVPy+faxFSYEgMYwNxOB1D9Svr0wEr6r9DDQ9NuN8eu4lZWLU
	1VyIBa3L/Hvh6jagy6CxjQkw4E2jRnhsOYaT6eKDxplAGRnHRrKCw2MJkMlWYx1aqdR7wz+ea0J
	T1VDWk7IGeMo263nV79O+wcPvmsF9DcAoPHoUebUERosaa3Wn3AdCSpjGOVnMOPEi4Nu/ZQhb9i
	gMBbDmr9RgzWo9r6zY4Uo9WzDLcOlfG8E9+kqoin6FZ6HoIrVr7eRxOtZ4lN3eUs582Op2msBFF
	3keK5HiucscKLv9A==
X-Received: by 2002:a05:6830:608d:b0:7e6:cee5:1bbf with SMTP id 46e09a7af769-7ebb2262664mr900845a34.12.1783358361740;
        Mon, 06 Jul 2026 10:19:21 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:45::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb54521db4sm11966334a34.25.2026.07.06.10.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:19:20 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 00/15] bpf: A common way to attach struct_ops to a cgroup
Date: Mon,  6 Jul 2026 10:19:02 -0700
Message-ID: <20260706171918.317102-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	TAGGED_FROM(0.00)[bounces-305158-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 27E95713E58

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

v2 -> v3
  - Patch 3: Remove redundant bpf_struct_ops_kdata_map_id (Sashiko)
  - Patch 11: Reject sleepable programs (Sashiko)
  - Patch 12: Silence warning when casting ctx to arg pointer
  - Patch 13: Fix incorrect libbpf API addition (Andrii)
  - Patch 14: Fix selftest cgroup cleanup (Sashiko)
  - Patch 15: Use network_helpers.c

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
 kernel/bpf/bpf_struct_ops.c                   | 142 +++--
 kernel/bpf/btf.c                              |  23 +-
 kernel/bpf/cgroup.c                           | 472 ++++++++++++++-
 kernel/bpf/core.c                             |   5 +
 kernel/bpf/syscall.c                          |   4 +
 net/core/filter.c                             |  33 +-
 net/ipv4/Makefile                             |   1 +
 net/ipv4/af_inet.c                            |   1 +
 net/ipv4/bpf_tcp_ca.c                         |  16 +
 net/ipv4/bpf_tcp_ops.c                        | 324 ++++++++++
 net/ipv4/tcp.c                                |   1 +
 net/ipv4/tcp_input.c                          |  17 +
 net/ipv4/tcp_output.c                         |  48 ++
 net/ipv4/tcp_timer.c                          |   1 +
 net/sched/bpf_qdisc.c                         |   2 -
 tools/include/uapi/linux/bpf.h                |  39 +-
 tools/lib/bpf/bpf.c                           |   2 +
 tools/lib/bpf/bpf.h                           |   3 +-
 tools/lib/bpf/libbpf.c                        |  64 ++
 tools/lib/bpf/libbpf.h                        |   3 +
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/bpf_tcp_ops.c    | 560 ++++++++++++++++++
 .../bpf/prog_tests/bpf_tcp_ops_hdr.c          |  77 +++
 .../testing/selftests/bpf/progs/bpf_tcp_ops.c | 141 +++++
 .../selftests/bpf/progs/bpf_tcp_ops_hdr.c     |  83 +++
 31 files changed, 2224 insertions(+), 121 deletions(-)
 create mode 100644 net/ipv4/bpf_tcp_ops.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_hdr.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_tcp_ops.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c

-- 
2.52.0



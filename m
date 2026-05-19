Return-Path: <netdev+bounces-289625-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJ10FTDeDGrdpAUAu9opvQ
	(envelope-from <netdev+bounces-289625-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 00:03:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B592B5856AC
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 00:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A440230BA477
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 21:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FEF3EC2DE;
	Tue, 19 May 2026 21:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qQmCmzi/"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A781C3ECBC5
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 21:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779227958; cv=none; b=BNDTmjuWq+9sMQVBmom/Rqg3WsBOwJXPXcioOoYmJ/qO6H6vDFyvOfHy0ce4quS76NE+pILzoyNKcdKZGj/fr2uZ5hFOYHULYgxbUiGOnpuq0JLpkt4/qLgZiF7hU3NhWPwJ44a4L8xJWprHrYDS0J6Q0W5cB/cyyFZBsbyCPtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779227958; c=relaxed/simple;
	bh=ePJzZbQ4VQlwEKCEvmUw9zR8asDru25ONnt1vk4BJsI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=poN2P4q5XtiNA0+fNWFlE3uB0Xqiik41269MoGf8qPPCTaLefEYklzDJrcCnbvaOhrDJN88Vi9KOF+bvQhlCg16dwA3xpqST8ilPs+9TSpjPlKn1C+msyBzBfsGM04dXG7UexMbZ6h0c+u2/kDRyX4ApLZGckqnCXAsBic6uEIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qQmCmzi/; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779227944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pPo1ND6dAsTx+Kx+qEzwTW+ndp3BIW/sCB0tHDioNNA=;
	b=qQmCmzi/tF95Cq5ZsUo5xNpYwIeIzJfAoGTT5wn7U1GrFDHhfz9N0qVtSroFrt837WkB5X
	b5woDRRtypHaVefiRjuYasaMFMsGggbe8o9PG5Ajh4Cy0Me+adCziiZQzcbMUTM2rYJlBZ
	mD5+Wtdlq5XrpApWliO7Ug/7+PqzBnk=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	'Shakeel Butt ' <shakeel.butt@linux.dev>,
	'Roman Gushchin ' <roman.gushchin@linux.dev>,
	'Amery Hung ' <ameryhung@gmail.com>,
	netdev@vger.kernel.org
Subject: [RFC PATCH bpf-next 00/12] bpf: A common way to attach struct_ops to a cgroup
Date: Tue, 19 May 2026 14:58:07 -0700
Message-ID: <20260519215841.2984970-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289625-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B592B5856AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Martin KaFai Lau <martin.lau@kernel.org>

At LSF/MM/BPF 2025, I presented [1] the need for a new interface
to extend tcp_sock operations instead of adding more
BPF_SOCK_OPS_*CB enum values. The need for predictable ordering when
attaching struct_ops to a cgroup was also briefly discussed.

At LSF/MM/BPF 2026, additional use cases were raised, in particular
OOM and memcg use cases, that also need to attach struct_ops to a
cgroup.

BPF already has a common bpf_link-based API for attaching different
BPF program types to a cgroup. It provides common attach, detach,
update, ordering, and query semantics across those program types.

This series extends the same model to struct_ops. Conceptually,
struct_ops is a group of BPF programs, so using similar
attachment/detachment/update/query APIs and ordering semantics for
cgroup attachment keeps the interface consistent with existing cgroup
BPF links.

This series uses a new struct bpf_tcp_ops as the first user. Not all
BPF_SOCK_OPS_*CB callbacks are implemented yet.

The selftests cover the basic attach, query, and ordering behavior.
More coverage is still needed for multi-level cgroup inheritance,
BPF_F_BEFORE/AFTER, and bpf_link__update_map().

The map_free_pre_rcu addition in patch 2 is not very ideal, this
will need some thoughts also.

[1] page 13: https://drive.google.com/file/d/1wjKZth6T0llLJ_ONPAL_6Q_jbxbAjByp/view?usp=sharing

Martin KaFai Lau (12):
  bpf: Remove __rcu tagging in st_link->map
  bpf: Make struct_ops tasks_rcu grace period optional
  bpf: Add bpf_struct_ops accessor helpers
  bpf: Remove unnecessary prog_list_prog() check
  bpf: Replace prog_list_prog() check with direct pl->prog and pl->link check
  bpf: Add prog_list_init_item(), prog_list_replace_item(), and prog_list_id()
  bpf: Move LSM trampoline unlink into bpf_cgroup_link_auto_detach()
  bpf: Add a few bpf_cgroup_array_* helper functions
  bpf: Add infrastructure to support attaching struct_ops to cgroups
  bpf: tcp: Support selected sock_ops callbacks as struct_ops
  libbpf: Support attaching struct_ops to a cgroup
  selftests/bpf: Test attaching struct_ops to a cgroup

 include/linux/bpf-cgroup-defs.h               |   1 +
 include/linux/bpf-cgroup.h                    |  28 ++
 include/linux/bpf.h                           |  55 ++-
 include/net/tcp.h                             |  74 ++-
 include/uapi/linux/bpf.h                      |   4 +-
 kernel/bpf/bpf_struct_ops.c                   | 152 ++++--
 kernel/bpf/btf.c                              |  23 +-
 kernel/bpf/cgroup.c                           | 452 ++++++++++++++++--
 kernel/bpf/core.c                             |   5 +
 kernel/bpf/syscall.c                          |   4 +
 net/ipv4/Makefile                             |   1 +
 net/ipv4/af_inet.c                            |   1 +
 net/ipv4/bpf_tcp_ca.c                         |  16 +
 net/ipv4/bpf_tcp_ops.c                        | 134 ++++++
 net/ipv4/tcp.c                                |   4 +-
 net/ipv4/tcp_output.c                         |   5 +-
 tools/include/uapi/linux/bpf.h                |   4 +-
 tools/lib/bpf/bpf.c                           |   2 +
 tools/lib/bpf/bpf.h                           |   3 +-
 tools/lib/bpf/libbpf.c                        |  59 +++
 tools/lib/bpf/libbpf.h                        |   3 +
 tools/lib/bpf/libbpf.map                      |   5 +
 tools/lib/bpf/libbpf_version.h                |   2 +-
 .../selftests/bpf/prog_tests/bpf_tcp_ops.c    | 207 ++++++++
 .../testing/selftests/bpf/progs/bpf_tcp_ops.c |  97 ++++
 25 files changed, 1253 insertions(+), 88 deletions(-)
 create mode 100644 net/ipv4/bpf_tcp_ops.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_tcp_ops.c

-- 
2.53.0-Meta



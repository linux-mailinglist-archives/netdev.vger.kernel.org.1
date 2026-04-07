Return-Path: <netdev+bounces-275838-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SG0dHqZr1GletwcAu9opvQ
	(envelope-from <netdev+bounces-275838-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 04:27:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC823A905C
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 04:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 228E4301039A
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 02:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E95F2727F3;
	Tue,  7 Apr 2026 02:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pRlteTRF"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E87D238178
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 02:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775528867; cv=none; b=sw8XcJHlyd8MNk262GqLSIPrighCdAd5Ps+SH7j5eVPKOcicAAhbBf0TIduimuEsMnT2syZeT93nLQKI3XKwUiYFN3fFmU0IxahRzoOLMVxvLmptaTDMDhjPxsu3mExhLe9YVPvG7qRJ0QYpoNhuJmAExnkJbuBQTzwt3tKDqsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775528867; c=relaxed/simple;
	bh=xr116ENgh6GConTk+CrKHjqqli2+OmQT78h7tAHpoFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a9kMyyg+v9gvGbh9BYuRjH8jsuISd3ZWWlQ34k4oKzjwmRKh8Xj/ZGkYPQ9HJUXmQUN2cue+uLbSLkcmQZ0W99+aLOWDzfkBFhPnbsqp57bM080BtSmEQaUxuL+RMmktVJnTeKdl3M0Hv8XVQjBs9vzwN3S2Cg3cvF8VsVMebgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pRlteTRF; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775528862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/BTSRSfR0uEztwllvIBtGt3uj4LQXe+9g40tIFFHvFA=;
	b=pRlteTRFCngwuqCfB/JPjTWBX+W/RnoxhfZoknK1Mz5RfmhefF+5ylpwY6KKZSsIYGwvV2
	ZPFBxVFOoExV/l0+Kisefx27Vx26fjtBxsSp4Gjie32VCqGcq2m1+3DCPMXTggiMfKqBlA
	E9WnvR1wIxK+1jb/NZvvrzMI4xL0XoU=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: werner@verivus.ai,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Sun Jian <sun.jian.kdev@gmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v3 0/2] bpf: Fix SOCK_OPS_GET_SK same-register OOB read in sock_ops and add selftest
Date: Tue,  7 Apr 2026 10:26:26 +0800
Message-ID: <20260407022720.162151-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275838-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[verivus.ai,linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: BFC823A905C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a BPF sock_ops program accesses ctx fields with dst_reg == src_reg,
the SOCK_OPS_GET_SK() and SOCK_OPS_GET_FIELD() macros fail to zero the
destination register in the !fullsock / !locked_tcp_sock path, leading to
OOB read (GET_SK) and kernel pointer leak (GET_FIELD).

Patch 1: Fix both macros by adding BPF_MOV64_IMM(si->dst_reg, 0) in the
!fullsock landing pad.
Patch 2: Add selftests covering same-register and different-register cases
for both GET_SK and GET_FIELD.

[1] https://lore.kernel.org/bpf/6fe1243e-149b-4d3b-99c7-fcc9e2f75787@std.uestc.edu.cn/T/#u

Changes since v2:
https://lore.kernel.org/bpf/20260406031330.187630-1-jiayuan.chen@linux.dev/
- Addressed selftest review from Martin KaFai Lau: removed unused skel
  parameter, renamed to test_ns_ for automatic netns, ASSERT_GE -> ASSERT_OK_FD
- Add reviewed-by tags.

Changes since v1:
https://lore.kernel.org/bpf/20260404141010.247536-1-jiayuan.chen@linux.dev/
- Fixed the same bug in SOCK_OPS_GET_FIELD() (pointed out by AI review)
- Added SOCK_OPS_GET_FIELD same-register and GET_SK different-register
  subtests

Jiayuan Chen (2):
  bpf: Fix same-register dst/src OOB read and pointer leak in sock_ops
  selftests/bpf: Add tests for sock_ops ctx access with same src/dst
    register

 net/core/filter.c                             |   6 +-
 .../bpf/prog_tests/sock_ops_get_sk.c          |  76 ++++++++++++
 .../selftests/bpf/progs/sock_ops_get_sk.c     | 117 ++++++++++++++++++
 3 files changed, 197 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_ops_get_sk.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_ops_get_sk.c

-- 
2.43.0



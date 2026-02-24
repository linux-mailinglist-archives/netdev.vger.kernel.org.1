Return-Path: <netdev+bounces-260571-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOU+BUPInWk8SAQAu9opvQ
	(envelope-from <netdev+bounces-260571-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:48:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CBD18947F
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB2773063A1E
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 15:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC773A4F3E;
	Tue, 24 Feb 2026 15:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YZPphYPs"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7305039B4AD
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 15:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771947711; cv=none; b=D4VrRzdPWgmUMLbHOgDlDNPpEsZH05MrRxqiLbNsUIkGc1sx/rdWK3/b2K8q9BkyBQn11cVnpN2j1bOqeW8gjgEo8PsQVResuzYG5iMPG6lYgej6pZ0RBw2m7U75NG/i/NoytNC175ctH3OdbTUPIE+f7mPR2S1phlZND4Jaj/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771947711; c=relaxed/simple;
	bh=Qky58vhSg7ngpuiMAI0wXwi0OB8jKBtIVpl989hW15k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JnpOzSiarmdROdbo1kzzXjQWokI508FR4XsntfDupA/2fPqQlzESdjKNDw6WQZHblrnrsbvgWzp055PVBPfciqvfXhs4aCk1nwEpZgYUgrNH1br9FLKdgBkwTVYV98CzZVQXAbKlmho8eDCaB6Y8ayuJ+SuMkZn8abXHQxd8Fck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YZPphYPs; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771947697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vsRHNcJt7Fs8ijA/eSOjtaTvGBC9pS0O7xztTp+2ST4=;
	b=YZPphYPsH39NChvKkNn89BC4zucxFJ/ynOhlt1DDuCL5ye5eRYswqwiXFxTOEVIdPKXsQR
	jSQmoLyGkQTyCDHzO1ncUoqcfjn51p088GVhtLnuZr5QWVxldt33zd9iay+02fdd1qfh4r
	snGXhJzPJWJQlfxv/ckYZ855x7WvZUU=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Feng Yang <yangfeng@kylinos.cn>,
	Leon Hwang <leon.hwang@linux.dev>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 0/8] bpf: Enhance __bpf_prog_map_compatible()
Date: Tue, 24 Feb 2026 23:40:16 +0800
Message-ID: <20260224154024.12504-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,kylinos.cn,huawei.com,vger.kernel.org,fb.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-260571-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.969];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 68CBD18947F
X-Rspamd-Action: no action

Following discussion in the "bpf: tail calls in sleepable programs" [1],
this series extends __bpf_prog_map_compatible() with additional per-program
compatibility checks.

The series validates these attributes:

* kprobe_write_ctx: for uprobe programs that can update pt_regs.
* call_get_func_ip: for tracing programs using bpf_get_func_ip().
* call_session_cookie: for fsession programs using bpf_session_cookie().
* call_session_is_return: for fsession programs using bpf_session_is_return().

For each attribute, prog_array compatibility is one-way:
programs without the requirement are rejected when tail-calling into
programs that require it.

This keeps tail-call runtime assumptions consistent. For example,
call_get_func_ip programs rely on func_ip metadata prepared on trampoline
stack; tail-calling from a !call_get_func_ip program into such a callee can
produce invalid func_ip values. The same class of issue applies to
call_session_cookie and call_session_is_return.

Links:
[1] https://lore.kernel.org/bpf/20260130081208.1130204-1-jolsa@kernel.org/

Leon Hwang (8):
  bpf: Add fsession to verbose log in check_get_func_ip()
  bpf: Disallow !kprobe_write_ctx progs tail-calling kprobe_write_ctx
    progs
  bpf: Disallow !call_get_func_ip progs tail-calling call_get_func_ip
    progs
  bpf: Disallow !call_session_cookie progs tail-calling
    call_session_cookie progs
  bpf: Disallow !call_session_is_return progs tail-calling
    call_session_is_return progs
  selftests/bpf: Add a test to verify kprobe_write_ctx compatibility
    enforcement
  selftests/bpf: Add a test to verify call_get_func_ip compatibility
    enforcement
  selftests/bpf: Add a test to verify session-kfunc compatibility
    enforcement

 include/linux/bpf.h                           | 11 +++--
 kernel/bpf/core.c                             | 15 ++++++
 kernel/bpf/verifier.c                         |  4 +-
 .../selftests/bpf/prog_tests/attach_probe.c   | 44 +++++++++++++++++
 .../selftests/bpf/prog_tests/fsession_test.c  | 47 +++++++++++++++++++
 .../bpf/prog_tests/get_func_ip_test.c         | 46 ++++++++++++++++++
 .../selftests/bpf/progs/fsession_test.c       |  6 +++
 .../selftests/bpf/progs/get_func_ip_test.c    |  6 +++
 .../selftests/bpf/progs/kprobe_write_ctx.c    |  6 +++
 9 files changed, 181 insertions(+), 4 deletions(-)

-- 
2.52.0



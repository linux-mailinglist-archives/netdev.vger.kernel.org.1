Return-Path: <netdev+bounces-263264-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIpMDfP6pmltbwAAu9opvQ
	(envelope-from <netdev+bounces-263264-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 16:14:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6191F2446
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 16:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B33E300CC80
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 15:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922F047F2E6;
	Tue,  3 Mar 2026 15:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vV1d/3cB"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C2447F2DB
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 15:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550449; cv=none; b=ua/r/u+o28dsY1x6oHsZvm/AbxI1rWvfIR7MOFIOylbAftyCkSLQMMTUyqVqaQIW/v12MiDyUlkg6pJPOvRxIN3G9JqeqyV+fEgjyRldGA/1jBrDeJ4H/zjNya0ZeF1XLMXK1FlnfJYGXmZNua+zZegZkno7m39/GxqUltmpMw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550449; c=relaxed/simple;
	bh=og5BGeFrQ30Aqrda3hTixvdjugHX91yV1mpgepgzpaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T7wMh5/5ZVQ6TNIPKL6ADd9pMFtw8jbrnE6bqZ0FffRkMi/7Xu0734/L4cnTZjgYipS/8yvhwzyy9V73unVIyiNpnLrH3S5j2XfbMKQGsixcptBI2DjU/EiaBBbKweFDvN263+9HpdX/hqr/vWXyv6njvPS5EohCAYoFcqDVCsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vV1d/3cB; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772550445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5h/Luh3nfXV7UEzDnO3fH1YL4eWophs4aupwotkiXUk=;
	b=vV1d/3cBhWQeLop0t2aqFtKHQDZvJMgnpK6nyWiidpr8ShtOIvHjUPKO2gByc0l9t4e3Vq
	8O/UmIQV5QBRdEmUI65WlpIvVO2ix3kCbtErQyeDcQMCd1ns9cgHI/9sU9HgwYruSjeNRg
	D26XK7PbN+1mgo0LgUTvszXQ1XMRkUQ=
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
Subject: [PATCH bpf-next v3 0/6] bpf: Enhance __bpf_prog_map_compatible()
Date: Tue,  3 Mar 2026 23:06:33 +0800
Message-ID: <20260303150639.85007-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 9E6191F2446
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,kylinos.cn,huawei.com,vger.kernel.org,fb.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-263264-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Following discussion in the "bpf: tail calls in sleepable programs" [1],
this series extends __bpf_prog_map_compatible() with additional per-program
compatibility checks.

The series validates these attributes:

* kprobe_write_ctx: for uprobe programs that can update pt_regs.
* call_get_func_ip: for tracing programs using bpf_get_func_ip().
* call_session_cookie: for fsession programs using bpf_session_cookie().

kprobe_write_ctx progs can be abused to modify pt_regs of kprobe progs via
tail calls. As in the test in patch #6, a kprobe prog can "regs->di = 0;"
when it runs as a tail callee. Thus, bpf_prog_test_run_opts() gets -EFAULT
instead of success.

call_get_func_ip progs could get a bogus func IP when they run as tail
callees, because the tail caller does not prepare the func IP on the
trampoline stack. As in the test in patch #6, it gets the RBX value on
stack instead of the true func IP.

call_session_cookie progs can modify the first arg value on the trampoline
stack. As in the test in patch #6, bpf_prog_test_run_opts() also gets -EFAULT
because the first arg is modified by "*cookie = 0;".

Links:
[1] https://lore.kernel.org/bpf/20260130081208.1130204-1-jolsa@kernel.org/

Changes:
v2 -> v3:
* Address comment from bot+bpf-ci:
  * Guard call_get_func_ip and call_session_cookie with "has_trampoline" for
    BPF_MAP_OWNER_MATCH_FOR_INIT.
* v2: https://lore.kernel.org/bpf/20260302150342.55709-1-leon.hwang@linux.dev/

v1 -> v2:
* Factor out bpf_map_owner_init() and bpf_map_owner_matches() helpers.
* Drop the "call_session_is_return" case, because the "is_return" value is
  always prepared for fsession progs.
* Address comments from Alexei:
  * Use bitfields like 'u32 jited:1;'.
  * Reimplement selftests.
* v1: https://lore.kernel.org/bpf/20260224154024.12504-1-leon.hwang@linux.dev/

Leon Hwang (6):
  bpf: Add fsession to verbose log in check_get_func_ip()
  bpf: Factor out bpf_map_owner_[init,matches]() helpers
  bpf: Disallow !kprobe_write_ctx progs tail-calling kprobe_write_ctx
    progs
  bpf: Disallow !call_get_func_ip progs tail-calling call_get_func_ip
    progs
  bpf: Disallow !call_session_cookie progs tail-calling
    call_session_cookie progs
  selftests/bpf: Add tests to verify prog_array map compatibility

 include/linux/bpf.h                           |   9 +-
 kernel/bpf/core.c                             | 141 +++++---
 kernel/bpf/verifier.c                         |   2 +-
 .../selftests/bpf/prog_tests/tailcalls.c      | 319 ++++++++++++++++++
 .../bpf/progs/tailcall_map_compatible.c       | 103 ++++++
 5 files changed, 524 insertions(+), 50 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_map_compatible.c

-- 
2.52.0



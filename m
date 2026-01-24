Return-Path: <netdev+bounces-253006-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1wrDJRs9dGnp3gAAu9opvQ
	(envelope-from <netdev+bounces-253006-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 04:31:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0813C7C4EC
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 04:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 793F03014525
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 03:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7B414EC73;
	Sat, 24 Jan 2026 03:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ljv1H+zC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CD13EBF23
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 03:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769225494; cv=none; b=lpMqC3RISYbz37Wu3EEJsLQdRr5zAzwi5JWHveb9CGksIwTiPyg2/PQbIsd2MvgjpNFlf/DaRFl5LaY2Mv1sAxtYv73J9WbW10jKj8za2iB4UOqrTfZMD8292daFTuZVHb/5cu2BUVpjXxqqZv+OYUD86CfGsX/5Lwn6eVXjCYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769225494; c=relaxed/simple;
	bh=xDDi6T9+Y8sKN1LGDeHJ/zhVSk36u6YRBVwntf6K0tc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c844N3aFtxkAn8SF5gWTVht4xCHQnvWeplxixHgQQsLCjy26W7efo+Jknm1GN7gD7crGl5dVusDmHWBOdOfgV5azcKioDo+anhEDI1ZSmT8wHqAYtc3V61yRauJ8Iur6L6aWol1OJ7dn/LnUvSOyVoMcvJEPKUqa9duYQXNbcXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ljv1H+zC; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a09a3bd9c5so22144475ad.3
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 19:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769225493; x=1769830293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=URC4J2NRmsTKC5gLmGNxjKJW9mo7tDwtl+mLWM/PYGY=;
        b=Ljv1H+zCBKGVaBaVYWFS/18tXui+q/exhstn8o2GNVrTYHzzw6exsoEe+2YklYki/2
         XyqmT/LXBWJ4PfzS6zmHrtFeH/V7T92Uv37YfZ2VF4dWAJLBuh0fuXito3Z8QBPGIHES
         rdIOaCjJWdDHI/0wlHUQd5fBzQPUtME0xh0znelefAY7O5Z9iRzNpe4E4txkMMNVhNB/
         ph/inXTqqB0V8OROowL2BHPmxorOX/XGWCTYhCpd3h6ED9wg4IrQ7yhQUpGN+9FjfUaW
         25sD3Xd8/ZRJNSMcXoN0uyuvpvSAQfkgSctvpPbE8rsU//9q9RAjZQMPkh+IZgvSExPG
         O7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769225493; x=1769830293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URC4J2NRmsTKC5gLmGNxjKJW9mo7tDwtl+mLWM/PYGY=;
        b=ZZX6swiazSCZh8wo84sYDj1pULGZhKAzbAPvcwN6MQ5uMKPz47j6eU7mmAx16LXVCR
         jNBQWIkjOaZ7fHCofBPmZhOeJYD74/Agx7Aen7JFaINwOVeXXZ4k25WQusQeo5SqILBR
         6ZI93ug0Vxhyj5p5sB4zV8FdZydNVIhipwFZ72K7cRgrOoA4bVLWqN9rrFkeii3AR6zx
         QkDYTkHtGrrJyrZNTRSWt8/QAW9fPGHywvLr0JXzfASf3joo00xecxv5/4ocfcPSzKT6
         PjfeNyAZDIeiIEHOJ4gteKMMFQgaX5oICabdo4d37py9XBpVDSMm8kS+STCHpuTr2l7p
         LuZA==
X-Forwarded-Encrypted: i=1; AJvYcCWdy4NWLRzdauvmU5kbIB98odKDXWpLCyP0cPbIg/uhkbaSRivV89WO+LzRAz80jMRtSs445d0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcqFJH8enABabZTuvKnaTcrlDGYUfND83+fmNXZn+OlC2axuOm
	ncctr02hJ92CoEFWO6/24cZvHw4GeBq6bMWcGFnPmbBbTRy5JJ+taF6Q
X-Gm-Gg: AZuq6aIN976th2gfWfSn1xdiU3yTwERzSqsSTkHY+/nWfERMcFJPr1GFM3t9V7LTyeQ
	GYDH63um7WAUURcdN2RHIZFUHv3G3KcIublp3J7FfR16Pdda8VpNoGC34Z37X0uL4MH76j2iLZd
	z+Fr+b214TGRi7lT0py0KflZUvq8W8YDTjFlAgKesd02A+kWDaNS7qtFZCpxZN23ONoDwli/shb
	vlXCTN8qb6Px1qAPl7Bf6+icfXRb4dETYNLKOWJc68XrTz0cfsT7yAJcFAoXEfP50mWsT/NyULA
	mYXUe8Pf07/B23f8FWBCwWg2g/o+S7xnFQy0Q1cjF2lsmckSVJCMqke3DN/Cqi/t/Yhuzc4KrDF
	rOh0J3PCWaQKxekCBxMiYD/FvUW2WyxX+/IguN4mZ3PjJKgCU2t+X3IWHLMlErkdZxl2cc562t/
	oLgDepeghE
X-Received: by 2002:a17:903:1247:b0:295:425a:350e with SMTP id d9443c01a7336-2a7fe43fbc5mr39267765ad.8.1769225492482;
        Fri, 23 Jan 2026 19:31:32 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802dcddb0sm32539805ad.38.2026.01.23.19.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 19:31:32 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v12 00/13] bpf: fsession support
Date: Sat, 24 Jan 2026 11:31:06 +0800
Message-ID: <20260124033119.28682-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253006-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,davemloft.net,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_NEQ_ENVFROM(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,chinatelecom.cn:mid]
X-Rspamd-Queue-Id: 0813C7C4EC
X-Rspamd-Action: no action

overall
-------
Sometimes, we need to hook both the entry and exit of a function with
TRACING. Therefore, we need define a FENTRY and a FEXIT for the target
function, which is not convenient.

Therefore, we add a tracing session support for TRACING. Generally
speaking, it's similar to kprobe session, which can hook both the entry
and exit of a function with a single BPF program.

We allow the usage of bpf_get_func_ret() to get the return value in the
fentry of the tracing session, as it will always get "0", which is safe
enough and is OK.

Session cookie is also supported with the kfunc bpf_session_cookie().
In order to limit the stack usage, we limit the maximum number of cookies
to 4.

kfunc design
------------
In order to keep consistency with existing kfunc, we don't introduce new
kfunc for fsession. Instead, we reuse the existing kfunc
bpf_session_cookie() and bpf_session_is_return().

The prototype of bpf_session_cookie() and bpf_session_is_return() don't
satisfy our needs, so we change their prototype by adding the argument
"void *ctx" to them.

We inline bpf_session_cookie() and bpf_session_is_return() for fsession
in the verifier directly. Therefore, we don't need to introduce new
functions for them.

architecture
------------
The fsession stuff is arch related, so the -EOPNOTSUPP will be returned if
it is not supported yet by the arch. In this series, we only support
x86_64. And later, other arch will be implemented.

Changes v11 -> v12:
* update the variable "delta" in the 2nd patch
* improve the fsession testcase by adding the 11th patch, which will test
  bpf_get_func_* for fsession
* v11: https://lore.kernel.org/bpf/20260123073532.238985-1-dongml2@chinatelecom.cn/

Changes v10 -> v11:
* rebase and fix the conflicts in the 2nd patch
* use "volatile" in the 11th patch
* rename BPF_TRAMP_SHIFT_* to BPF_TRAMP_*_SHIFT
* v10: https://lore.kernel.org/bpf/20260115112246.221082-1-dongml2@chinatelecom.cn/

Changes v9 -> v10:
* 1st patch: some small adjustment, such as use switch in
  bpf_prog_has_trampoline()
* 2nd patch: some adjustment to the commit log and comment
* 3rd patch:
  - drop the declaration of bpf_session_is_return() and
    bpf_session_cookie()
  - use vmlinux.h instead of bpf_kfuncs.h in uprobe_multi_session.c,
    kprobe_multi_session_cookie.c and uprobe_multi_session_cookie.c
* 4th patch:
  - some adjustment to the comment and commit log
  - rename the prefix from BPF_TRAMP_M_ to BPF_TRAMP_SHIFT_
  - remove the definition of BPF_TRAMP_M_NR_ARGS
  - check the program type in bpf_session_filter()
* 5th patch: some adjustment to the commit log
* 6th patch:
  - add the "reg" to the function arguments of emit_store_stack_imm64()
  - use the positive offset in emit_store_stack_imm64()
* 7th patch:
  - use "|" for func_meta instead of "+"
  - pass the "func_meta_off" to invoke_bpf() explicitly, instead of
    computing it with "stack_size + 8"
  - pass the "cookie_off" to invoke_bpf() instead of computing the current
    cookie index with "func_meta"
* 8th patch:
  - split the modification to bpftool to a separate patch
* v9: https://lore.kernel.org/bpf/20260110141115.537055-1-dongml2@chinatelecom.cn/

Changes v8 -> v9:
* remove the definition of bpf_fsession_cookie and bpf_fsession_is_return
  in the 4th and 5th patch
* rename emit_st_r0_imm64() to emit_store_stack_imm64() in the 6th patch
* v8: https://lore.kernel.org/bpf/20260108022450.88086-1-dongml2@chinatelecom.cn/

Changes v7 -> v8:
* use the last byte of nr_args for bpf_get_func_arg_cnt() in the 2nd patch
* v7: https://lore.kernel.org/bpf/20260107064352.291069-1-dongml2@chinatelecom.cn/

Changes v6 -> v7:
* change the prototype of bpf_session_cookie() and bpf_session_is_return(),
  and reuse them instead of introduce new kfunc for fsession.
* v6: https://lore.kernel.org/bpf/20260104122814.183732-1-dongml2@chinatelecom.cn/

Changes v5 -> v6:
* No changes in this version, just a rebase to deal with conflicts.
* v5: https://lore.kernel.org/bpf/20251224130735.201422-1-dongml2@chinatelecom.cn/

Changes v4 -> v5:
* use fsession terminology consistently in all patches
* 1st patch:
  - use more explicit way in __bpf_trampoline_link_prog()
* 4th patch:
  - remove "cookie_cnt" in struct bpf_trampoline
* 6th patch:
  - rename nr_regs to func_md
  - define cookie_off in a new line
* 7th patch:
  - remove the handling of BPF_TRACE_SESSION in legacy fallback path for
    BPF_RAW_TRACEPOINT_OPEN
* v4: https://lore.kernel.org/bpf/20251217095445.218428-1-dongml2@chinatelecom.cn/

Changes v3 -> v4:
* instead of adding a new hlist to progs_hlist in trampoline, add the bpf
  program to both the fentry hlist and the fexit hlist.
* introduce the 2nd patch to reuse the nr_args field in the stack to
  store all the information we need(except the session cookies).
* limit the maximum number of cookies to 4.
* remove the logic to skip fexit if the fentry return non-zero.
* v3: https://lore.kernel.org/bpf/20251026030143.23807-1-dongml2@chinatelecom.cn/

Changes v2 -> v3:
* squeeze some patches:
  - the 2 patches for the kfunc bpf_tracing_is_exit() and
    bpf_fsession_cookie() are merged into the second patch.
  - the testcases for fsession are also squeezed.
* fix the CI error by move the testcase for bpf_get_func_ip to
  fsession_test.c
* v2: https://lore.kernel.org/bpf/20251022080159.553805-1-dongml2@chinatelecom.cn/

Changes v1 -> v2:
* session cookie support.
  In this version, session cookie is implemented, and the kfunc
  bpf_fsession_cookie() is added.
* restructure the layout of the stack.
  In this version, the session stuff that stored in the stack is changed,
  and we locate them after the return value to not break
  bpf_get_func_ip().
* testcase enhancement.
  Some nits in the testcase that suggested by Jiri is fixed. Meanwhile,
  the testcase for get_func_ip and session cookie is added too.
* v1: https://lore.kernel.org/bpf/20251018142124.783206-1-dongml2@chinatelecom.cn/

Menglong Dong (13):
  bpf: add fsession support
  bpf: use the least significant byte for the nr_args in trampoline
  bpf: change prototype of bpf_session_{cookie,is_return}
  bpf: support fsession for bpf_session_is_return
  bpf: support fsession for bpf_session_cookie
  bpf,x86: introduce emit_store_stack_imm64() for trampoline
  bpf,x86: add fsession support for x86_64
  libbpf: add fsession support
  bpftool: add fsession support
  selftests/bpf: add testcases for fsession
  selftests/bpf: test bpf_get_func_* for fsession
  selftests/bpf: add testcases for fsession cookie
  selftests/bpf: test fsession mixed with fentry and fexit

 arch/x86/net/bpf_jit_comp.c                   |  76 +++++---
 include/linux/bpf.h                           |  36 ++++
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/btf.c                              |   2 +
 kernel/bpf/syscall.c                          |  18 +-
 kernel/bpf/trampoline.c                       |  53 +++++-
 kernel/bpf/verifier.c                         |  90 +++++++--
 kernel/trace/bpf_trace.c                      |  49 +++--
 net/bpf/test_run.c                            |   1 +
 net/core/bpf_sk_storage.c                     |   1 +
 tools/bpf/bpftool/common.c                    |   1 +
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/lib/bpf/bpf.c                           |   1 +
 tools/lib/bpf/libbpf.c                        |   3 +
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   3 -
 .../selftests/bpf/prog_tests/fsession_test.c  | 119 ++++++++++++
 .../bpf/prog_tests/get_func_args_test.c       |   1 +
 .../bpf/prog_tests/get_func_ip_test.c         |   2 +
 .../bpf/prog_tests/tracing_failure.c          |   2 +-
 .../selftests/bpf/progs/fsession_test.c       | 179 ++++++++++++++++++
 .../selftests/bpf/progs/get_func_args_test.c  |  31 ++-
 .../selftests/bpf/progs/get_func_ip_test.c    |  14 ++
 .../bpf/progs/kprobe_multi_session_cookie.c   |  15 +-
 .../bpf/progs/uprobe_multi_session.c          |   7 +-
 .../bpf/progs/uprobe_multi_session_cookie.c   |  15 +-
 .../progs/uprobe_multi_session_recursive.c    |  11 +-
 26 files changed, 631 insertions(+), 101 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fsession_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/fsession_test.c

-- 
2.52.0



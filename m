Return-Path: <netdev+bounces-253034-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WC4POKxkdGnb5AAAu9opvQ
	(envelope-from <netdev+bounces-253034-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 07:20:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A697CA51
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 07:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A83A73002B56
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 06:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6858B26C3BD;
	Sat, 24 Jan 2026 06:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vg697gus"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D7D242D78
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 06:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769235624; cv=none; b=UmK1Ovk7N09xO/HpvV0252359ZTw7I8F41205nC5tmT14CuUIuwnR+AJMlR7P7nE33qyvdFPpfa8ExxhnN3NamMJDcfagb3BIDan29EvakSNpNmGHu3mCM8BS9Qhh8a99Gb4vrsuWQ1JVmXdzvkwg9Ok2j5ey8pPGH+gH4UQQ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769235624; c=relaxed/simple;
	bh=WredZZn/a+zZ9uJ5/JU57vXB+kJrUUoaGO0qhU/I4Us=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aFmLb1k4jBFso8KSlrKyJN2bFU/+nfcCjgE6JxTbJXsHLQ/hyT1jOe3Q4QL9zyBoQbUAqarya6wgHZKuHkeXr4UMSR1oLHHlCGldK5/iQafDIBI9xPT9/Bbd4PIH24DnCET/Q9JANy2dj8xM0zYBcA0v2K5xvWX72MnaXWBUnWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vg697gus; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-c227206e6dcso2021202a12.2
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 22:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769235622; x=1769840422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ATb5J1yx6A/uoa7XzI7Z9WUUxvehsMm2uIkfTBxvrU=;
        b=Vg697gusiR4rLFHZFutGuvnfKV1qFjeOHWqVa9invh89K/e/LUFniDja2jbnftxlEy
         SSTLVCKqKS3j08GWsJi4OhxqEARb73cTqo0Q/aXRlAG4K7MWIuRiSo2sw6O4Vm0ek3FP
         8obCt8qxm7AXtu+P5+HxMYj3Kxm3O9yt7vkyYXRgePziywcK3VBgdtZ8sq8Xt+KpL63v
         2ADy2g3/lT+MPIGWTSEnUgNDE8Q48q9dsM0SqGYtZ3IG1zHN11NgFAANWL/xrnVjSCK9
         o60r3qvgqFAlPWtsgJxSAjiOHcQz9AAgd92hm2XdEOf6iu/g0tFicxFe1tykyWxGULdy
         xAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769235622; x=1769840422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ATb5J1yx6A/uoa7XzI7Z9WUUxvehsMm2uIkfTBxvrU=;
        b=XU/7WGNu/XyXThzmYBcHXF/gRWBaMw2UveNIlwWU0K+Fssd/H+ERJNMc3T5nd0O+xx
         eyJrcZA4774uQnnofJOhIyh9oDJJ5LQDpWi/0oXFEdvQUyLgI9JU7vggNb2A92VP1a3G
         4TFXsv5oE+iUL3r6CVNmnTR8qKydJsZZYVijkbVLzo2FVQW4Fm0L+jWg5MIdSWu1zEOj
         O7PsjFniGDAhiDxRo2FXJe25NPqhSzatS6NEI/Foqq8W7WI/10HShx698d0S7vGSeAJp
         xwhD9b7fzC1lc+AGAlp9eXgRM25nI3UQx8PHJlTT77nRIci/eqeSCHO0ynpB2Dhcej5S
         rHUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6G6wGepVxqnqKBiMYTU7Ah7SWuTgw7xyg20eeTYKgA88haFZtjCiDDjO/q3oSsw+9WlTrlA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKUFQEfG9UJ2i5KquQt3RxUPegxRpaSNKmOhJTLHvFLPlB6i1H
	qqQwIQbFkjY+nUL09t3eNppilYH/jOfSyghQU40COs8zScT4ZthU1nJg
X-Gm-Gg: AZuq6aLQEBNqcozdu4yVCfMDM7STcnOZXAfgmVo/+fhoB8WT/m0G9ituxSJU12gR2GZ
	F+y1bY9VhUpVWea/+U7ybYpd4Js792u18K1KhCRquwhzfo0F0OD+1uii41vRiCpeFHTjMkyizTK
	TqRaNSrJP5yWvFLdwLFR3DaDLBSB5Lt9SMW889SiqVD0NSVSEGqfWAlgboQcLFbnffQfqXxgS0o
	qLCo9l14DQDgKFo22YlTZ88r89mqknfRUaNQ1Q1QBh8dPG+57qhz2qxYSRClOnGkZflLj6VZc50
	ZZ36BaoulnKpAvrXJo9tm5vU6zLN/77iqj56Ru8KQ9+WkocoRxDd8F+JEa1uJ4+GzWuz1T7L6/3
	SOcraLum7+RFn1KKtgGWnGEU2ogutUvXihhwu6b5tQNNfQVM+dEzkUWIbQP2o0WHjWw4ceVUlW8
	HWn4McHdrr
X-Received: by 2002:a17:90a:d40e:b0:34a:48ff:694 with SMTP id 98e67ed59e1d1-35368f292a2mr4012900a91.31.1769235622107;
        Fri, 23 Jan 2026 22:20:22 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353354a6b5asm6496537a91.9.2026.01.23.22.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 22:20:21 -0800 (PST)
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
Subject: [PATCH bpf-next v13 00/13] bpf: fsession support
Date: Sat, 24 Jan 2026 14:19:55 +0800
Message-ID: <20260124062008.8657-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUSPICIOUS_URL_IN_SUSPICIOUS_MESSAGE(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	URIBL_RED(0.50)[chinatelecom.cn:mid];
	MAILLIST(-0.15)[generic];
	HAS_ANON_DOMAIN(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,davemloft.net,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253034-lists,netdev=lfdr.de];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20230601];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	NEURAL_HAM(-0.00)[-0.931];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:104.64.211.4:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinatelecom.cn:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 10A697CA51
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

Changes v12 -> v13:
* fix the selftests fail on !x86_64 in the 11th patch
* v12: https://lore.kernel.org/bpf/20260124033119.28682-1-dongml2@chinatelecom.cn/

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
 .../selftests/bpf/prog_tests/fsession_test.c  | 124 ++++++++++++
 .../bpf/prog_tests/get_func_args_test.c       |   1 +
 .../bpf/prog_tests/get_func_ip_test.c         |   2 +
 .../bpf/prog_tests/tracing_failure.c          |   2 +-
 .../selftests/bpf/progs/fsession_test.c       | 179 ++++++++++++++++++
 .../selftests/bpf/progs/get_func_args_test.c  |  40 +++-
 .../selftests/bpf/progs/get_func_ip_test.c    |  23 +++
 .../bpf/progs/kprobe_multi_session_cookie.c   |  15 +-
 .../bpf/progs/uprobe_multi_session.c          |   7 +-
 .../bpf/progs/uprobe_multi_session_cookie.c   |  15 +-
 .../progs/uprobe_multi_session_recursive.c    |  11 +-
 26 files changed, 654 insertions(+), 101 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fsession_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/fsession_test.c

-- 
2.52.0



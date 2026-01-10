Return-Path: <netdev+bounces-248689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC83D0D6EA
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 15:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C43D300D170
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 14:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD183446B9;
	Sat, 10 Jan 2026 14:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQifLt9l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B467346794
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768054293; cv=none; b=ZucwItkAo5ONZaQaVQ6mRYx5UwDk6C4da0IlqPesSZaqi+JnzWl2jNKyoW/6GIMUfqDJ8zZGsNKn0ciQ8Ezc8JoSpDQHtgZoAOAWEM07PrJ8W8veEiDeK80KA69JD3pmUGh3o0RIB1jC7+04MfSfJU7cfOjsdMvY77CDuaPUR5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768054293; c=relaxed/simple;
	bh=HT3PZ6NWua8J19nOiijYCURqlz4st9dfdYPQbCS85ck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sUUjkh8U7JauyFyG3dq+toNoj//vkFN+MMLwkTReBoycA5w8afMTzJcYSbVC72X+/C7YTV5ZP2SaHMdgaMuAHJ3L1wrlwxl93NSODu8y6eA5zF+lhNoHeL7vdoWLJyOeqBXZ0ZcSVUS4YLjI/RySdz33LvYwnIkEybteBs4YHDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQifLt9l; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7ade456b6abso3277551b3a.3
        for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 06:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768054291; x=1768659091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=muLJ/bklG5ZA3Zs+JGbPBSIUe/zEHzZcoLpn4TOjRds=;
        b=eQifLt9lfF0k0TSq2gprUW/uuO7AT7Oqflm4ydHqBfBxSL+o5vwglVB5j9JzVhkS9a
         VRyeH7tXfkqsZLggNt1CoAiHD3YuSm0KrLglTUhZK5pQBuNRwwp/Dhiv5/aCl6JOBTJV
         Uv5Vstn1DJNpHRUdXBZy0zJJbb2aiIEjan2puPNZXi82DG5qL1mM9UNu+QLvCfSYuZPP
         zUp+Ifmt9Q0xGWARmxK+PeKOh0IWuqZQujahRqCUQG51NNZ1Qf4I0QyQlrpi5De8uwQ/
         LPOqiElnvuWMohQrk3gZWO1tDJfCvnB1CrAz1595T0gyBj0wgPoQ/fTVQrLdFVv9jIt6
         PCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768054291; x=1768659091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=muLJ/bklG5ZA3Zs+JGbPBSIUe/zEHzZcoLpn4TOjRds=;
        b=eaLnEf2Q2i79hxGcZOQSSG0F3HG1glPbI7t/TZZJwQ4y1xSl/yVHIjufxHFZ2KlQ5S
         O5K6QTNZYjTNO1X4mOGTAEHAWuzB5q+zYkdbmwuriGLSFP6uKU9RpNU9yQccFGNkJDRb
         xa7tQFKsqvNftGfgrLExbhIbc0wRiXldrtOMLQuQA+tJCLKBFjm3U1eoqVzgNNhusv6Y
         rGWS2zcwhG0874jZXyw21F+eHFFRohIktxjMRdYhdVTwjUrUcXQxp9Jbi5B1SW4mRFRm
         lwNzWOWH7NJzk4wxkRUwDTBNanASQcxlfnY0IIkiJKYBkIJTWOVDvBICM43UJ1z+DWqu
         l5Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWLYaK0ts19hdHBgnFmHF0lEQmK+qnR+hq/5uduyJsEURUaroOuJM171UBnf8BDwDNIdI5DBH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHtyJfNNmRKceLjk0FDtfr1BxZr2uGEl9We+wJ73qJitCHZJap
	NjP7RCmw4BW5EoYC9B6Di8xZM43rSzWL3w/UcwachYpeSsanqjJOa8MF
X-Gm-Gg: AY/fxX48Z5EgzJBHyZ/G30XTN1fCGEh5p/8I9gRtpL8RtuLpU9BEJZ7kSrr0myEcVgp
	pLroT4ZEVSRqw9xyGM81IIQ267rRmSQp7bHwjbnaKoeku5033zp/h6TFtBtk5irq52jAdKgHKkr
	oOx3d4BAuQKfOQT/utetkK/QNBHY9JXOkCeG7BAGkTIHe0Pe3ssoohhhxNN7Wm1PX8LHD+CFoNE
	IysgQwfD24tlMLr3l6RNs0KpLE0FWh+7gQ585iFNM6rIDfXS+Y+5wKxOxZ3lZSW6VhFoJ4pQoLe
	gE0rPB8NVH1lm9nyDNuagLUqKV4foDVscZa8mvVj6ZJABXJcUnXlbV9KBseT7c0axyV1hnVGFtY
	wgzyGb7YZqib7m0phIAtU/+DlWzg5ONbXfjfaMRZ6li8HDExa7npFvbOVBquZJXGXrvLy31bxzG
	9tf9oQQpU=
X-Google-Smtp-Source: AGHT+IE6x72OioB/0md71pHOAtWtLp2uMCfSTz2hSI9e2zLffQJ9PsiXDeMkdG5GDeWinXSwWalQkw==
X-Received: by 2002:a05:6a00:1c83:b0:81f:39ad:6c94 with SMTP id d2e1a72fcca58-81f39ad779amr1994651b3a.9.1768054291410;
        Sat, 10 Jan 2026 06:11:31 -0800 (PST)
Received: from 7950hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f42658f03sm1481079b3a.20.2026.01.10.06.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 06:11:31 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
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
Subject: [PATCH bpf-next v9 00/11] bpf: fsession support
Date: Sat, 10 Jan 2026 22:11:04 +0800
Message-ID: <20260110141115.537055-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, all.

In this version, I removed the definition of bpf_fsession_cookie and
bpf_fsession_is_return, as Alexei suggested.

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

Changes since v8:
* remove the definition of bpf_fsession_cookie and bpf_fsession_is_return
  in the 4th and 5th patch
* rename emit_st_r0_imm64() to emit_store_stack_imm64() in the 6th patch

Changes since v7:
* use the last byte of nr_args for bpf_get_func_arg_cnt() in the 2nd patch

Changes since v6:
* change the prototype of bpf_session_cookie() and bpf_session_is_return(),
  and reuse them instead of introduce new kfunc for fsession.

Changes since v5:
* No changes in this version, just a rebase to deal with conflicts.

Changes since v4:
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

Changes since v3:
* instead of adding a new hlist to progs_hlist in trampoline, add the bpf
  program to both the fentry hlist and the fexit hlist.
* introduce the 2nd patch to reuse the nr_args field in the stack to
  store all the information we need(except the session cookies).
* limit the maximum number of cookies to 4.
* remove the logic to skip fexit if the fentry return non-zero.

Changes since v2:
* squeeze some patches:
  - the 2 patches for the kfunc bpf_tracing_is_exit() and
    bpf_fsession_cookie() are merged into the second patch.
  - the testcases for fsession are also squeezed.

* fix the CI error by move the testcase for bpf_get_func_ip to
  fsession_test.c

Changes since v1:
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

Menglong Dong (11):
  bpf: add fsession support
  bpf: use last 8-bits for the nr_args in trampoline
  bpf: change prototype of bpf_session_{cookie,is_return}
  bpf: support fsession for bpf_session_is_return
  bpf: support fsession for bpf_session_cookie
  bpf,x86: introduce emit_store_stack_imm64() for trampoline
  bpf,x86: add fsession support for x86_64
  libbpf: add fsession support
  selftests/bpf: add testcases for fsession
  selftests/bpf: add testcases for fsession cookie
  selftests/bpf: test fsession mixed with fentry and fexit

 arch/x86/net/bpf_jit_comp.c                   |  48 ++++-
 include/linux/bpf.h                           |  37 ++++
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/btf.c                              |   2 +
 kernel/bpf/syscall.c                          |  18 +-
 kernel/bpf/trampoline.c                       |  53 ++++-
 kernel/bpf/verifier.c                         |  82 ++++++--
 kernel/trace/bpf_trace.c                      |  38 ++--
 net/bpf/test_run.c                            |   1 +
 net/core/bpf_sk_storage.c                     |   1 +
 tools/bpf/bpftool/common.c                    |   1 +
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/lib/bpf/bpf.c                           |   1 +
 tools/lib/bpf/libbpf.c                        |   3 +
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   4 +-
 .../selftests/bpf/prog_tests/fsession_test.c  | 115 ++++++++++
 .../bpf/prog_tests/tracing_failure.c          |   2 +-
 .../selftests/bpf/progs/fsession_test.c       | 198 ++++++++++++++++++
 .../bpf/progs/kprobe_multi_session_cookie.c   |  12 +-
 .../bpf/progs/uprobe_multi_session.c          |   4 +-
 .../bpf/progs/uprobe_multi_session_cookie.c   |  12 +-
 .../progs/uprobe_multi_session_recursive.c    |   8 +-
 22 files changed, 570 insertions(+), 72 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fsession_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/fsession_test.c

-- 
2.52.0



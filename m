Return-Path: <netdev+bounces-246742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2A9CF0EA8
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 13:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1ADCE3009F91
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 12:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C17C2C21C0;
	Sun,  4 Jan 2026 12:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AI+a281B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414202C15A0
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 12:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767529717; cv=none; b=szvOo+B50LMVRdLuS3617wWqdG+bF/n1ld1761OEG4xNr8BLEn5mqKFtTRMA4b861votS+TCVm+f1BsIk32UnZM9X5U11s0uKSlBW4l2a3Y9UEAyCgRNLrbcx/vfnmzEk4DfrEHGgaXd8Wpxs3I3R4WP8CG0Ucoi+KvSUGyOp7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767529717; c=relaxed/simple;
	bh=37NoOwmbEFbtysE2DlDpNUYsBOiTWnWUsCk/VqY80jM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TkiPLAOKqHpUAn95/keGXU/SOXBx6mAuok8ZE8qATMfTdYL+LQ4lYn5oez8caY00S7SmN+gjltmfLVNaLA0m5GqyYZmyUweGxs+0yauf1A2H1CcP8tRWxrDUgOJ+vkXoAtPJQpJEqWUQuuPs6OxqqxFfX+RNOJnklXI2kXv60Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AI+a281B; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-790647da8cbso18350267b3.1
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 04:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767529714; x=1768134514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2G7eadH5MMBxz7yZ0+iAQgcawTRkgGwCWOA1VR9NfFs=;
        b=AI+a281BWbTzdwHK/chIp2I6YIAdOzSlvMlJLXaq2YPGSPDRO9oviqzUpTgtXVqBHk
         AC5R4Oq5Kikj+ZpjGoHHoLd5J4GYHJIlk2LMW4DlWSU4e0FS0Q8eCbJISm4aahYEKGSW
         cCWi7krOxRGpQimMtpVv+dEwGOzFSclM1p3UpWDU9QBAe5uOZW7oFz8NCfp6fLe54VCa
         YTzZdI2kXBJC3Q/WEM4wQrf9OcEKIGWJl7VbyGJ9lyOgGmMLsg0+JEX4nGA2e2cwHD4k
         E5aIffzJjxnZ2fqOm+gYNHllYHyMq9frk0g1+jO+4TiWt61bHy5H3g+OPvEHwZ7gkCrh
         2KvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767529714; x=1768134514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2G7eadH5MMBxz7yZ0+iAQgcawTRkgGwCWOA1VR9NfFs=;
        b=pf1hGxMRUXEgacuq7Z7bBw2FFuURiiExUzdyZS2L+6lds/0uWDNZqaBw0QnpvwVmyn
         K+yL2oU8F0VC+zbNVeByjgAyT57rOgXnyyQ9jjnIq+qu1UqvSuJPUOfYweNq1/nLzMnv
         CKAH4/xqeZqQiyh5TOv5wweenwJvhr0gMiBOlkJ0qveoqUISNECok1LVa2lMYI5xScEW
         owjGlrxQJ2Toh72DcFcYFK5y7mjd3NvvefbT3RERSiEuUUoaPylNzSLQOeKidHghJh15
         gP0mLuj9Mv2IaNEwGkOBhVYXizfQgvlAVxnJozEkBbv/VikqePLWVgEd+G+FATKLUzdX
         r3Iw==
X-Forwarded-Encrypted: i=1; AJvYcCWH1GGVCjjr/PYMkYyjjRrlXbmK8WWXBtdezOToW3HIgy+z6hvrsWyQf+pWAHTAxgubN5731xE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS/BmBc1HlIQJAQkEnW51BRMtanobh9YdQQcHHZGSR2xKSU6/P
	VjVJHKXOd7ldpUp0V0dvInjtY6RnjS9bWL+aoouEHLQU+wESWJwgTk3c
X-Gm-Gg: AY/fxX40X+zJl56ftfddQ/oKlvJ1gN88ujpOOUSBxvRuVUVBJn90agxdrzSr/prRa7a
	Q/OCyB2Ava0nI+CUI01tqD23hToEA/c1W/JokuYlEVo/iNVbC3r1jmbClGJu3tHYBAN/5PJCjEv
	cSq0OTaQsw7thnyJ18vWwboMRUCCvNXOiFdagl+pjkTmjNzDlApsB53jYVMoIPykM7nwaSHeaEW
	VhX18URjCmDMV4dB4A3cPSsA9GY0OKpU6iYbU7Zmmv2kyKAy5B4seA66oMQ+t9J+2FMXVC4zst4
	9FHo0Zc7WeaxjbiBzkjlSgnbgH/tl/EBvT+3Uh78mlJOSYroPmtF01PZkKATncUx9Hn29MH2Fyx
	is9apfPHoeF720CyUhB7UrL0OEB/kioAUeqbwTGCd8nF+eXet6UKOjRhyuqwoDiF9nEvT5B7Bw9
	DY6HwDnFdexFqj5CL5zg==
X-Google-Smtp-Source: AGHT+IHS9a4jImQKSg/PReudg9XbT91OW2y1MNoQqzFfjATamNzIW8aA0ESgRzh5mH2OJJYRUevbPg==
X-Received: by 2002:a05:690e:144c:b0:646:82e4:8539 with SMTP id 956f58d0204a3-64682e486camr33149822d50.43.1767529714160;
        Sun, 04 Jan 2026 04:28:34 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb4378372sm175449427b3.12.2026.01.04.04.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 04:28:33 -0800 (PST)
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
Subject: [PATCH bpf-next v6 00/10] bpf: fsession support
Date: Sun,  4 Jan 2026 20:28:04 +0800
Message-ID: <20260104122814.183732-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, all.

No changes in this version, just a rebase to deal with conflicts.

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

Session cookie is also supported with the kfunc bpf_fsession_cookie().
In order to limit the stack usage, we limit the maximum number of cookies
to 4.

kfunc design
------------
The kfunc bpf_fsession_is_return() and bpf_fsession_cookie() are
introduced, and they are both inlined in the verifier.

In current solution, we can't reuse the existing bpf_session_cookie() and
bpf_session_is_return(), as their prototype is different from
bpf_fsession_is_return() and bpf_fsession_cookie(). In
bpf_fsession_cookie(), we need the function argument "void *ctx" to get
the cookie. However, the prototype of bpf_session_cookie() is "void".

Maybe it's possible to reuse the existing bpf_session_cookie() and
bpf_session_is_return(). First, we move the nr_regs from stack to struct
bpf_tramp_run_ctx, as Andrii suggested before. Then, we define the session
cookies as flexible array in bpf_tramp_run_ctx like this:
    struct bpf_tramp_run_ctx {
        struct bpf_run_ctx run_ctx;
        u64 bpf_cookie;
        struct bpf_run_ctx *saved_run_ctx;
        u64 func_meta; /* nr_args, cookie_index, etc */
        u64 fsession_cookies[];
    };

The problem of this approach is that we can't inlined the bpf helper
anymore, such as get_func_arg, get_func_ret, get_func_arg_cnt, etc, as
we can't use the "current" in BPF assembly.

So maybe it's better to use the new kfunc for now? And I'm analyzing that
if it is possible to inline "current" in verifier. Maybe we can convert to
the solution above if it success.

architecture
------------
The fsession stuff is arch related, so the -EOPNOTSUPP will be returned if
it is not supported yet by the arch. In this series, we only support
x86_64. And later, other arch will be implemented.

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

Menglong Dong (10):
  bpf: add fsession support
  bpf: use last 8-bits for the nr_args in trampoline
  bpf: add the kfunc bpf_fsession_is_return
  bpf: add the kfunc bpf_fsession_cookie
  bpf,x86: introduce emit_st_r0_imm64() for trampoline
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
 kernel/bpf/verifier.c                         |  76 +++++--
 kernel/trace/bpf_trace.c                      |  56 ++++-
 net/bpf/test_run.c                            |   1 +
 net/core/bpf_sk_storage.c                     |   1 +
 tools/bpf/bpftool/common.c                    |   1 +
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/lib/bpf/bpf.c                           |   1 +
 tools/lib/bpf/libbpf.c                        |   3 +
 .../selftests/bpf/prog_tests/fsession_test.c  | 115 ++++++++++
 .../bpf/prog_tests/tracing_failure.c          |   2 +-
 .../selftests/bpf/progs/fsession_test.c       | 198 ++++++++++++++++++
 17 files changed, 572 insertions(+), 42 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fsession_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/fsession_test.c

-- 
2.52.0



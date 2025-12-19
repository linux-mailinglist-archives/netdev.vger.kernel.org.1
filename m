Return-Path: <netdev+bounces-245453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F02CCE181
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 01:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0CC83042195
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 00:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104D3207DE2;
	Fri, 19 Dec 2025 00:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bT6UF6ON"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670601C860A
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 00:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766105739; cv=none; b=CikX8kRNBob747jtd4PDMnhmXYkZU54yCWRVt9OYgK97GF35WVXYpBkdVmdmac3mIc7ZzLaAbUW/gRbHncM5Zc/xpRn+xNxTDA0Lcx/UY5D2eGo07xgHoc6NQb0pQIIAkXM4iK59BGBYtVZfCCkle7iNJ5hbOR3mCDnsBef0lbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766105739; c=relaxed/simple;
	bh=JP1E3U0Gzf5VQ6cl7Il6a+42qITte063Iy96oSwNP+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hIbj6wfleF47KZShV1L9o1e/2E0468QM5aVkuaCJPyp7eFA+heFBIjsUgXIYYHM2CAoclt1vP7RIez0GRypymeCvOzpBjOq5/35O+PfnMjBju6p5XBIzEw3ebBhqfBreiaLO7TZRPyiHOTU2zSRMNX3iTe0zA3h49nVD6w1Yu8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bT6UF6ON; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7b8eff36e3bso1981957b3a.2
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 16:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766105737; x=1766710537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Dsp2WwBfETjCKui8ZIJDbgjocXF3AXwxdQY+2AXB/c=;
        b=bT6UF6ONm0o3za8p+9PBTDetpp0Zf8L/Zc+RyDdcRku8jVgRnngn1mXVakM1moYSmf
         qT+hy4JgoW/oewhLNIeiq1ACmIJ+vQ1Zw42CVXGlxK8LlFkRTR3ZBnpTxcdD6MJfF7Vd
         4xMHPat9eN5qW3Xt1elkxfG0H0xRz+IBViyVs8lN9vXhUvmKjoXNbicTQsdMep2ODnjX
         uLm2UAzMkBiK/LPEODpyO3WkSG7bN7vqPZQmtDP+w4KDovnbNqmhHZ9OoriDSwED/1yv
         Y6WvmuS2tAIHkhZOOqroXmklVMQRuWD56vf7s9qUwz+n9WZT4oUkro8kFzdkZMqdiKt+
         iAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766105737; x=1766710537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Dsp2WwBfETjCKui8ZIJDbgjocXF3AXwxdQY+2AXB/c=;
        b=nGV6szjtLBe8htBXAhdqoP8RIXQvZ0YHOprn9htkSuYcVESoXDoxNZZMxEkLVSqT36
         LsXqAxTlMuNkHubgIH0hbB80dI4Z2LBPW0BwEPZfUa2lqk5lg+bVJOeydIcsIiqzL90M
         K0kqx2RS+Ixo29VcB8d3TD0U4EM4Zli9galJgCbwQWR07CFCrHDCvH0ExMZ8JbpBalwf
         srcuc8KN+sL56sf5Cj5iNTmsHsJNd18EiR44wdX8ke1jzREeKGlhGhHIYqti2vOwFZ7Z
         U8PjHnz3qkoMEQEzJeQAfTXl7Kh+rCeJpSERnaxJDsYl3to5wubwoW4vDTOyGCJ8VLDA
         uNPw==
X-Forwarded-Encrypted: i=1; AJvYcCWx1IbxsZQRNVKYfML2OCLzyt6fWwH57F6tej9+CYS5bHt00ZirY+IfRmWbMkKGX9cgw5fgGXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmubbCBsaDPXjA23dxTTPVusc68cadGHTOW3/RpyQ0pP36yr4W
	qrjXykfNyApkzUvd2CgySUMZCRSpkT7nbsFyNdU0vvJLQ6IJq49YS+4vG5uMfrJPGOUQJAZfBvg
	LOpElk6BZ/Mmii6vsU9XPNtz6jslLcZM=
X-Gm-Gg: AY/fxX7Hz7OlQWUOvmFBICMAzu6gwHhwLY0r9ARkr0UIWsSNveA+c2VuQ7CJMQFjKep
	cDsY0HSfPSSWXXuLuZbVyqnwm1icMrUejkTxvQUGjOT1QkMdJJFHgxZlhyVngPqqF93DorgMgxm
	pVfFIaLt5BEMfHbBJPYaW9amL2qB/iW9/lDiNj/ksd0WL1tm+Gsd1y9SwNos248Yu2uyFkWlBn7
	UvlFELVUOzI+8xdH7qeQtxJgDBSAXLCkJocOadlovpNYOzKASbhFM1UCXK2LBiA+fYoqJCLPZ9g
	Vl/80CWh2IU=
X-Google-Smtp-Source: AGHT+IG93jGTSDKVm8+Mm96QmwIh3k7UWIMS9J62DKLnhYbke2RgPKZ6ftaX1+BtSaHaWu0fSfmjzKvfs509tzQ7J0Y=
X-Received: by 2002:a05:6a20:4323:b0:35f:2293:877f with SMTP id
 adf61e73a8af0-376a8ebe36amr1329187637.33.1766105736577; Thu, 18 Dec 2025
 16:55:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217095445.218428-1-dongml2@chinatelecom.cn>
In-Reply-To: <20251217095445.218428-1-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Dec 2025 16:55:23 -0800
X-Gm-Features: AQt7F2pItVsQNLZFecdCNJrvgORyyY0sKKslQT65UU6kVXiOC7iVPrEPsPnhYMg
Message-ID: <CAEf4Bzb8oooWbxctuVhNPsziRBd1Fv9Y11-5TiEML8ckjrCt+g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/9] bpf: tracing session supporting
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 1:54=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> Hi, all.
>
> In this version, I combined Alexei and Andrii's advice, which makes the
> architecture specific code much simpler.
>
> Sometimes, we need to hook both the entry and exit of a function with
> TRACING. Therefore, we need define a FENTRY and a FEXIT for the target
> function, which is not convenient.
>
> Therefore, we add a tracing session support for TRACING. Generally
> speaking, it's similar to kprobe session, which can hook both the entry
> and exit of a function with a single BPF program. Session cookie is also
> supported with the kfunc bpf_fsession_cookie(). In order to limit the
> stack usage, we limit the maximum number of cookies to 4.
>
> The kfunc bpf_fsession_is_return() and bpf_fsession_cookie() are both
> inlined in the verifier.

We have generic bpf_session_is_return() and bpf_session_cookie() (that
currently works for ksession), can't you just implement them for the
newly added program type instead of adding type-specific kfuncs?

>
> We allow the usage of bpf_get_func_ret() to get the return value in the
> fentry of the tracing session, as it will always get "0", which is safe
> enough and is OK. Maybe we can prohibit the usage of bpf_get_func_ret()
> in the fentry in verifier, which can make the architecture specific code
> simpler.
>
> The fsession stuff is arch related, so the -EOPNOTSUPP will be returned i=
f
> it is not supported yet by the arch. In this series, we only support
> x86_64. And later, other arch will be implemented.
>
> Changes since v3:
> * instead of adding a new hlist to progs_hlist in trampoline, add the bpf
>   program to both the fentry hlist and the fexit hlist.
> * introduce the 2nd patch to reuse the nr_args field in the stack to
>   store all the information we need(except the session cookies).
> * limit the maximum number of cookies to 4.
> * remove the logic to skip fexit if the fentry return non-zero.
>
> Changes since v2:
> * squeeze some patches:
>   - the 2 patches for the kfunc bpf_tracing_is_exit() and
>     bpf_fsession_cookie() are merged into the second patch.
>   - the testcases for fsession are also squeezed.
>
> * fix the CI error by move the testcase for bpf_get_func_ip to
>   fsession_test.c
>
> Changes since v1:
> * session cookie support.
>   In this version, session cookie is implemented, and the kfunc
>   bpf_fsession_cookie() is added.
>
> * restructure the layout of the stack.
>   In this version, the session stuff that stored in the stack is changed,
>   and we locate them after the return value to not break
>   bpf_get_func_ip().
>
> * testcase enhancement.
>   Some nits in the testcase that suggested by Jiri is fixed. Meanwhile,
>   the testcase for get_func_ip and session cookie is added too.
>
> Menglong Dong (9):
>   bpf: add tracing session support
>   bpf: use last 8-bits for the nr_args in trampoline
>   bpf: add the kfunc bpf_fsession_is_return
>   bpf: add the kfunc bpf_fsession_cookie
>   bpf,x86: introduce emit_st_r0_imm64() for trampoline
>   bpf,x86: add tracing session supporting for x86_64
>   libbpf: add support for tracing session
>   selftests/bpf: add testcases for tracing session
>   selftests/bpf: test fsession mixed with fentry and fexit
>
>  arch/x86/net/bpf_jit_comp.c                   |  47 +++-
>  include/linux/bpf.h                           |  39 +++
>  include/uapi/linux/bpf.h                      |   1 +
>  kernel/bpf/btf.c                              |   2 +
>  kernel/bpf/syscall.c                          |  18 +-
>  kernel/bpf/trampoline.c                       |  50 +++-
>  kernel/bpf/verifier.c                         |  75 ++++--
>  kernel/trace/bpf_trace.c                      |  56 ++++-
>  net/bpf/test_run.c                            |   1 +
>  net/core/bpf_sk_storage.c                     |   1 +
>  tools/bpf/bpftool/common.c                    |   1 +
>  tools/include/uapi/linux/bpf.h                |   1 +
>  tools/lib/bpf/bpf.c                           |   2 +
>  tools/lib/bpf/libbpf.c                        |   3 +
>  .../selftests/bpf/prog_tests/fsession_test.c  |  90 +++++++
>  .../bpf/prog_tests/tracing_failure.c          |   2 +-
>  .../selftests/bpf/progs/fsession_test.c       | 226 ++++++++++++++++++
>  17 files changed, 571 insertions(+), 44 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/fsession_test.=
c
>  create mode 100644 tools/testing/selftests/bpf/progs/fsession_test.c
>
> --
> 2.52.0
>


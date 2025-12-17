Return-Path: <netdev+bounces-245101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C05FACC6E53
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 10:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C69230124F7
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 09:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099AD346FA9;
	Wed, 17 Dec 2025 09:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTFwtxt0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EEC3164D6
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 09:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765965297; cv=none; b=OYncPwFYOTUX+7OtVCstCQrn0fYHlfRlN3ouw9brmmCMetPidPay3qnlPuqw4tjrm4M8H9duRwgj8+P1fBa3Il9jWeRKX86yeMjS2yGutvKCouJkIojc+cMwD5iJflgOTNoqeC/NjzyE/Ir37o8mNRJT/Tw6GJS64GnuCJm6a8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765965297; c=relaxed/simple;
	bh=NGvdOLAiuDMwpsDwMXQ5sEGNewqHQ/BO9EMpstuuiD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=drWFe20AuU1KdaQ554oiMBVyIHZ3/ApA3yALjQaoDjhksrV9a9Lg0u8QSd83knUfMxZAekLadVPbXoRFQYoxwufyUf2vkdqafyxopJ7AuyHyWeqf5AULnuEW06tIZOQzA5fWJg3G5TTsu51w1dbsY2ibSpg6WpZuz8wsp2SUJ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTFwtxt0; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a09757004cso48091755ad.3
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 01:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765965296; x=1766570096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ia3wyOyYeEqo0nguI+DPqpD5+4HXprm2bO56e8BK4e4=;
        b=UTFwtxt0BAr1Zl0aRz1KDZ2SM9Ev2RckF1ZSmAjY/WXwggWqpeBXvjt4B8wqtMxyT1
         C4YX6w/+/Y+1ehh9yfBe9nmXzGJr4HFUm6rEpDs8M08pzDB1uD8/Mat3Dp+staSOrWOI
         wvpUY1kRQ6C6oFOCC+K2G5i/wb1APEtsH90o7B+S8z5jLdnN7ytzjQnGGSoRQywtuCyE
         PrKron2bYu+HI3vMDiU22beRKH0gGHrCGBhdwBwQOmTfhTuvFDaAm7n2R3VUMx4+a0hj
         SdLMYBVmuqj2dDSwnyz+sDopDaGaAI7KoTbmdnB3sNuG7XINyVrHmRESQCm8D6bvf1gq
         jgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765965296; x=1766570096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ia3wyOyYeEqo0nguI+DPqpD5+4HXprm2bO56e8BK4e4=;
        b=ayIEfzW5+LIp5uYM1Cx7uL7HpIeZ9Q+eqhpf2XpjptSBOkIO4CtlD/VYKjrepMdqDL
         wWymXoEZeWWYqXB35yeTwNxxaKZDsiSVTxP4vwrXcxfzlRPXXOaXVNecwao/Evsu7iNW
         lPnmwKUQlXjY+Nu/4riV6Io+IdGezZ+5Q7Lo/cQFee0+2nmH+EjvSHIKe3k7/slC3Rlv
         FbYQZbZzkiNJY/4eKZcB/yVTaqwF6aosEIHoPe0OcvCekVrPFbQqLW8jMpYO9USGs3RD
         muZP0tBoigt2s4HMEGW3KcqDs/+WQal91DnARKvcBAQzeUPnGKcxHsoQke1cCJUPDlGE
         o/mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmzQP7ATpPwpgZVYenncgyxpn4/PPbjn2H3dovKXlTz/cyrXDY6lqT1M5SdWXy56TPkFs9KYM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7rwExmwHrUr8Ef2R2O8LO+PG85gUv5RgBwTf85JOuH6TeNMzg
	NhVti2E4FAnDyn0ioprHI0/fOGp0VhfKvA1kek1r5H+P1ewYiLhgZ0xu
X-Gm-Gg: AY/fxX7riDPaPtfyBbkHsD64Sl2p+Naf+xR5Joy0Pys69J/p+w11u3GdOkj7xFltW7r
	Q9vAj7j6MQRWJaqd+2n+C+gimVRTdwkzg1D3s46U/haCqhsfQCZNcAaxxGkoBdHutx+Yf1JYIDc
	5DBEIPWDZ0C1XJFR0LD3L6iHr5ulLGP/AJ0YIh5YgdFbzdS37nESZgp9dZTIS5f7TjTnks8oln5
	JNFk0Xo7FeDMveDgQF11RYZK4Sz2Ynx3I0B1K57wBncSZYQi0j9OHVBNf38on9ufuqPGMvzyUxW
	/W7PCbzfIJZnsSmEzvJs4ObJ0v5C8y44nsLKaV83TjF6yB+wp4EMou7OIm8uOfUqVQgT/a56L4J
	Fw1aY0pKaHwhJmeN8ycFJo/KZSMxME+1ZQ3oWTAhp6beCzYssndxFSXU0lCOldfylRBjfh0RizR
	sHyIrXU4k=
X-Google-Smtp-Source: AGHT+IH8vphoIeSzTwCCge5KbWOLEeT5ViqMbLxOMT5VhgZKsu6oxMiG1bT/dCXlAp5hgtrSwsOWIw==
X-Received: by 2002:a17:903:3508:b0:2a0:f46a:e3f1 with SMTP id d9443c01a7336-2a0f46ae498mr89462805ad.3.1765965295677;
        Wed, 17 Dec 2025 01:54:55 -0800 (PST)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a07fa0b1aasm140715945ad.3.2025.12.17.01.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 01:54:55 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
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
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 0/9] bpf: tracing session supporting
Date: Wed, 17 Dec 2025 17:54:36 +0800
Message-ID: <20251217095445.218428-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, all.

In this version, I combined Alexei and Andrii's advice, which makes the
architecture specific code much simpler.

Sometimes, we need to hook both the entry and exit of a function with
TRACING. Therefore, we need define a FENTRY and a FEXIT for the target
function, which is not convenient.

Therefore, we add a tracing session support for TRACING. Generally
speaking, it's similar to kprobe session, which can hook both the entry
and exit of a function with a single BPF program. Session cookie is also
supported with the kfunc bpf_fsession_cookie(). In order to limit the
stack usage, we limit the maximum number of cookies to 4.

The kfunc bpf_fsession_is_return() and bpf_fsession_cookie() are both
inlined in the verifier.

We allow the usage of bpf_get_func_ret() to get the return value in the
fentry of the tracing session, as it will always get "0", which is safe
enough and is OK. Maybe we can prohibit the usage of bpf_get_func_ret()
in the fentry in verifier, which can make the architecture specific code
simpler.

The fsession stuff is arch related, so the -EOPNOTSUPP will be returned if
it is not supported yet by the arch. In this series, we only support
x86_64. And later, other arch will be implemented.

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

Menglong Dong (9):
  bpf: add tracing session support
  bpf: use last 8-bits for the nr_args in trampoline
  bpf: add the kfunc bpf_fsession_is_return
  bpf: add the kfunc bpf_fsession_cookie
  bpf,x86: introduce emit_st_r0_imm64() for trampoline
  bpf,x86: add tracing session supporting for x86_64
  libbpf: add support for tracing session
  selftests/bpf: add testcases for tracing session
  selftests/bpf: test fsession mixed with fentry and fexit

 arch/x86/net/bpf_jit_comp.c                   |  47 +++-
 include/linux/bpf.h                           |  39 +++
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/btf.c                              |   2 +
 kernel/bpf/syscall.c                          |  18 +-
 kernel/bpf/trampoline.c                       |  50 +++-
 kernel/bpf/verifier.c                         |  75 ++++--
 kernel/trace/bpf_trace.c                      |  56 ++++-
 net/bpf/test_run.c                            |   1 +
 net/core/bpf_sk_storage.c                     |   1 +
 tools/bpf/bpftool/common.c                    |   1 +
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/lib/bpf/bpf.c                           |   2 +
 tools/lib/bpf/libbpf.c                        |   3 +
 .../selftests/bpf/prog_tests/fsession_test.c  |  90 +++++++
 .../bpf/prog_tests/tracing_failure.c          |   2 +-
 .../selftests/bpf/progs/fsession_test.c       | 226 ++++++++++++++++++
 17 files changed, 571 insertions(+), 44 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fsession_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/fsession_test.c

-- 
2.52.0


